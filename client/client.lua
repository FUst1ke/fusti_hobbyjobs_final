local taskCount = 0
local objectList = {}
local pedList = {}
local isDoingTask = false

------------ setup peds/objects ------------

local function setPedComponents(entity)
    FreezeEntityPosition(entity, true)
    SetEntityInvincible(entity, true)
    TaskSetBlockingOfNonTemporaryEvents(entity, true)
end

local function setObjectComponents(object)
    FreezeEntityPosition(object, true)
    PlaceObjectOnGroundProperly(object)
    -- SetModelAsNoLongerNeeded(object)
    SetEntityAsMissionEntity(object, true, true)
end

local function enterStartPoint(self)
    lib.showTextUI(Config.Notifies['context'])
end

local function exitStartPoint(self)
    lib.hideTextUI()
end

local function nearbyStartPoint(self)
    if self.currentDistance < 2 and IsControlJustReleased(0, 38) then
        if taskCount == 0 then
            local options = createOptionList(self.actionsData.items)
            local dialog = Config.Notifies['itemSellMenu']
            local sell = lib.inputDialog(dialog.header, {{type = 'multi-select', label = dialog.label, description = dialog.description, options = options}})
            if sell == nil then return end
            if sell[1] == null then
                local notify = Config.Notifies['no_select']
                lib.notify({title = notify.title, description = notify.description, type = notify.type, icon = notify.icon})
                return 
            end
            TriggerServerEvent('fusti_jobcreator:sellReward', sell[1], options)
            taskCount = #self.actionsData.coords
        else
            local vehicle = self.vehicleData
            local actionsData = self.actionsData
            local options = createVehicleShop(vehicle, actionsData)
            lib.registerContext({id = 'vehicleshop', title = 'Jármű választó', options = options})
            lib.showContext('vehicleshop')
        end
    end
end

------------ blip/radius setup ------------

local function setupBlip(blipName, coords, data)
    SetBlipSprite(blipName, data.sprite)
    SetBlipDisplay(blipName, data.display)
    SetBlipScale(blipName, data.scale)
    SetBlipColour(blipName, data.colour)
    SetBlipAsShortRange(blipName, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(data.text)
    EndTextCommandSetBlipName(blipName)
end

local function setupRadius(radius, coords, data, rotation)
    -- SetBlipDisplay(radius, 10)
    SetBlipColour(radius, data.colour)
    SetBlipAlpha(radius, data.alpha)
    if not rotation then return end
    SetBlipRotation(radius, rotation)
end

------------ TaskPoint checks ------------

local function enterTaskPoint(self)
    lib.showTextUI(self.actionsData.action.context)
end

local function exitTaskPoint(self)
    lib.hideTextUI()
end

local function nearbyTaskPoint(self)
    if self.currentDistance < 2.5 and IsControlJustReleased(0, 38) then
        if not isDoingTask then
            TaskData = self.actionsData.action
            if taskCount <= 0 then local notify = Config.Notifies['no_more_task'] lib.notify({title = notify.title, description = notify.description, type = notify.type, icon = notify.icon}) return end
            lib.callback('fusti_jobcreator:itemCheck', false, function(item)
                if item then
                    isDoingTask, success = true, nil
                    
                    if not TaskData.skillCheckData then
                        success = true
                    else
                        success = lib.skillCheck(TaskData.skillCheckData.difficulty, TaskData.skillCheckData.inputs)
                    end

                    if not success then
                        local notify = Config.Notifies['skillCheck_failed']
                        lib.notify({title = notify.title, description = notify.description, type = notify.type, icon = notify.icon})
                        isDoingTask = false
                        return
                    else
                        if lib.progressBar({
                                duration = TaskData.progbar.time, label = TaskData.progbar.label, useWhileDead = false, canCancel = false,
                                disable = {car = true, move = true, combat = true, mouse = true},
                                anim = {dict = TaskData.anim.dict, clip = TaskData.anim.name},
                                prop = {model = TaskData.progbar.attach.prop, pos = TaskData.progbar.attach.pos, rot = TaskData.progbar.attach.rot, bone = TaskData.progbar.attach.bone}
                            }) 
                        then
                            taskCount = taskCount - 1
                            if taskCount == 0 then
                                SetNewWaypoint(self.mainPlaceData.ped.coord.x, self.mainPlaceData.ped.coord.y)
                                TriggerServerEvent('fusti_jobcreator:giveReward', self.actionsData.items)
                                self:remove()
                                lib.hideTextUI()
                                local dialog = Config.Notifies['everything_is_done']
                                local alert = lib.alertDialog({header = dialog.header, content = dialog.content, centered = dialog.centered, cancel = dialog.cancel})
                                RemoveBlip(TaskBlipTable[self.blip])
                                TaskBlipTable[self.blip] = nil
                                Wait(1000)
                                isDoingTask = false
                                return
                            end
                            local notify = Config.Notifies['task_to_go']
                            lib.notify({title = notify.title, description = string.format(notify.description, taskCount), type = notify.type, icon = notify.icon})
                            TriggerServerEvent('fusti_jobcreator:giveReward', self.actionsData.items)
                            self:remove()
                            lib.hideTextUI()
                            RemoveBlip(TaskBlipTable[self.blip])
                            TaskBlipTable[self.blip] = nil
                            Wait(1000)
                            isDoingTask = false
                        end
                    end
                end
            end, TaskData.requiredItem)
        end
    end
end

------------ Sphere/Box checks ------------

local function enterZone(self)
    TaskBlipTable = {}
    local actionsData = self.actionsData
    local mainPlaceData = self.mainPlaceData
    taskCount = self.taskCount
    for n, i in pairs(self.actionsData.coords) do
        local taskPoint = lib.points.new({coords = i.position, distance = Config.InteractDistance, onEnter = enterTaskPoint, onExit = exitTaskPoint, nearby = nearbyTaskPoint, actionsData = actionsData, mainPlaceData = mainPlaceData, taskCount = taskCount, blip = n})
        local object = CreateObject(actionsData.action.prop, i.position, false, true)
        table.insert(objectList, {object = object})
        setObjectComponents(object)
        if not actionsData.action.TaskBlipData then return end
        taskBlip = AddBlipForCoord(i.position)
        setupBlip(taskBlip, i.position, actionsData.action.TaskBlipData)
        TaskBlipTable[n] = taskBlip
    end
end

local function exitZone()
    for k,v in pairs(objectList) do
        DeleteEntity(v.object)
        objectList[k] = nil
    end
    for t, y in pairs(TaskBlipTable) do
        RemoveBlip(y)
    end
    collectgarbage()
end

------------ Script start ------------

AddEventHandler('onClientResourceStart', function (resourceName)
    if(GetCurrentResourceName() ~= resourceName) then return end
    for k,v in pairs(Config.Zones) do
        local pedData = v.mainPlace.ped
        lib.requestModel(pedData.model)
        local blipData = v.actions.blip
        local mainPlaceData = v.mainPlace
        local vehicleData = v.vehicles
        local actionsData = v.actions
        local zonePos = actionsData.sphereData or actionsData.boxData
        local point = lib.points.new({coords = pedData.coord, distance = Config.InteractDistance, onEnter = enterStartPoint, onExit = exitStartPoint, nearby = nearbyStartPoint, mainPlaceData = mainPlaceData, vehicleData = vehicleData, actionsData = actionsData})
        local pedBlip = AddBlipForCoord(pedData.coord)
        local sphereData = v.actions.sphereData
        local blip = AddBlipForCoord(zonePos.coord)
        local ped = CreatePed(0, pedData.model, pedData.coord, pedData.heading, true, true)
        taskCount = #actionsData.coords
        if actionsData.type == 'box' then
            local radius = AddBlipForArea(zonePos.coord, zonePos.size[1], zonePos.size[2])
            local box = lib.zones.box({coords = zonePos.coord, size = zonePos.size, rotation = zonePos.rotation, debug = Config.Debug, inside = insideBox, onEnter = enterZone, onExit = exitZone, actionsData = actionsData, mainPlaceData = mainPlaceData, taskCount = taskCount})
            setupRadius(radius, zonePos.coord, blipData.radius, zonePos.rotation)
        else
            local radius = AddBlipForRadius(zonePos.coord, zonePos.radius)
            local sphere = lib.zones.sphere({coords = zonePos.coord, radius = sphereData.radius, debug = Config.Debug, inside = insideSphere, onEnter = enterZone, onExit = exitZone, actionsData = actionsData, mainPlaceData = mainPlaceData, taskCount = taskCount})
            setupRadius(radius, zonePos.coord, blipData.radius, zonePos.rotation)
        end
        setupBlip(blip, zonePos.coord, blipData)
        setupBlip(pedBlip, pedData.coord, mainPlaceData.blip)
        setPedComponents(ped)
        table.insert(pedList, {ped = ped})
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    for k,v in pairs(objectList) do
        DeleteEntity(v.object)
        objectList[k] = nil
    end
    for k,v in pairs(pedList) do
        DeleteEntity(v.ped)
        pedList[k] = nil
    end
end)