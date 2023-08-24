local ox = exports.ox_inventory

------------ reward give/sell ------------

RegisterServerEvent('fusti_jobcreator:giveReward')
AddEventHandler('fusti_jobcreator:giveReward', function(data)
    for k,v in pairs(data) do
        local randomNumber = math.random(1, 10)
        if v.chance > randomNumber then
            ox:AddItem(source, v.value, v.count)
        end
    end
end)

RegisterServerEvent('fusti_jobcreator:sellReward')
AddEventHandler('fusti_jobcreator:sellReward', function(input, data)
    for _,i in pairs(input) do
        for k,v in pairs(data) do
            if i == v.value then
                local itemCount = ox:GetItem(source, v.value, {}, false)
                if itemCount.count > 0 then
                    ox:AddItem(source, 'money', v.sellPrice * itemCount.count)
                    ox:RemoveItem(source, v.value, itemCount.count)
                    local notify = Config.Notifies['success_sold']
                    TriggerClientEvent('ox_lib:notify', source, {title = notify.title, description = string.format(notify.description, itemCount.count, itemCount.label, v.sellPrice * itemCount.count), type = notify.type, icon = notify.icon})
                    DeleteEntity(vehicle)
                else
                    local notify = Config.Notifies['no_item']
                    TriggerClientEvent('ox_lib:notify', source, {title = notify.title, description = string.format(notify.description, itemCount.label), type = notify.type, icon = notify.icon})
                end
            end
        end
    end
end)

lib.callback.register('fusti_jobcreator:itemCheck', function(source, item)
    local itemCount = ox:GetItem(source, item, {}, false)
    if item == 'none' or itemCount.count > 0 then
        return true
    else
        local notify = Config.Notifies['no_requiedItem']
        TriggerClientEvent('ox_lib:notify', source, {title = notify.title, description = string.format(notify.description, itemCount.label), type = notify.type, icon = notify.icon})
        return false
    end
end)

------------  spawn/delete ------------

RegisterServerEvent('fusti_jobcreator:spawnVehicle')
AddEventHandler('fusti_jobcreator:spawnVehicle', function(model, data)
    local src = source
    local money = ox:Search(src, 'count', 'money')
    for k,v in pairs(data.list) do
        if model == v.value then
            if money >= v.sellPrice then
                ox:RemoveItem(src, 'money', v.sellPrice)
                local notify = Config.Notifies['success_spawn']
                TriggerClientEvent('ox_lib:notify', src, {title = notify.title, description = notify.description, type = notify.type, icon = notify.icon})
                vehicle = CreateVehicleServerSetter(model, 'automobile', data.spawnCoord.position, data.spawnCoord.heading)
                SetVehicleNumberPlateText(vehicle, data.plate)
                Wait(500)
                TaskWarpPedIntoVehicle(src, vehicle, -1)
            else
                local notify = Config.Notifies['no_money']
                TriggerClientEvent('ox_lib:notify', src, {title = notify.title, description = notify.description, type = notify.type, icon = notify.icon})
            end
        end
    end
end)