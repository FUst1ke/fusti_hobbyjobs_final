function IsSpawnPointClear(coords, maxDistance)
    local vehicle, coords = lib.getNearbyVehicles(coords, maxDistance, true)
    return #vehicle == 0
end

function createOptionList(data)
    local options = {}
    for k,v in pairs(data) do
        table.insert(options, {
            label = v.label..' -  $'..v.sellPrice,
            value = v.value,
            sellPrice = v.sellPrice
        })
    end
    return options
end

function createVehicleShop(data, actionsData)
    local options = {}
    for k,v in pairs(data.list) do
        table.insert(options, {
            title = v.label,
            description = Config.Notifies['price']..': '..v.sellPrice..'$',
            image = 'https://raw.githubusercontent.com/FUst1ke/gta5carimages/main/images/'..v.value..'.png',
            icon = 'car',
            onSelect = function()
                local zonePos = actionsData.sphereData or actionsData.boxData
                if IsSpawnPointClear(data.spawnCoord.position, data.spawnCoord.radius) then
                    TriggerServerEvent('fusti_jobcreator:spawnVehicle', v.value, data)
                    SetNewWaypoint(zonePos.coord.x, zonePos.coord.y)
                else
                    local notify = Config.Notifies['spawnpoint_not_clear']
                    lib.notify({title = notify.title, description = notify.description, type = notify.type, icon = notify.icon})
                end
            end
        })
    end
    return options
end