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
            description = 'Ár: '..v.sellPrice..'$',
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

-- function printTable(t, f)

--     local function printTableHelper(obj, cnt)
 
--        local cnt = cnt or 0
 
--        if type(obj) == "table" then
 
--           print("\n", string.rep("\t", cnt), "{\n")
--           cnt = cnt + 1
 
--           for k,v in pairs(obj) do
 
--              if type(k) == "string" then
--                 print(string.rep("\t",cnt), '["'..k..'"]', ' = ')
--              end
 
--              if type(k) == "number" then
--                 print(string.rep("\t",cnt), "["..k.."]", " = ")
--              end
 
--              printTableHelper(v, cnt)
--              print(",\n")
--           end
 
--           cnt = cnt-1
--           print(string.rep("\t", cnt), "}")
 
--        elseif type(obj) == "string" then
--           print(string.format("%q", obj))
 
--        else
--           print(tostring(obj))
--        end 
--     end
 
--     if f == nil then
--        printTableHelper(t)
--     else
--        io.output(f)
--        io.write("return")
--        printTableHelper(t)
--        io.output(io.stdout)
--     end
--  end