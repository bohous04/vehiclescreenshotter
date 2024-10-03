-- ______                     ______  __          
-- /      \                   /      \|  \         
-- |  ▓▓▓▓▓▓\ ______  _______ |  ▓▓▓▓▓▓\\▓▓ ______  
-- | ▓▓   \▓▓/      \|       \| ▓▓_  \▓▓  \/      \ 
-- | ▓▓     |  ▓▓▓▓▓▓\ ▓▓▓▓▓▓▓\ ▓▓ \   | ▓▓  ▓▓▓▓▓▓\
-- | ▓▓   __| ▓▓  | ▓▓ ▓▓  | ▓▓ ▓▓▓▓   | ▓▓ ▓▓  | ▓▓
-- | ▓▓__/  \ ▓▓__/ ▓▓ ▓▓  | ▓▓ ▓▓     | ▓▓ ▓▓__| ▓▓
-- \▓▓    ▓▓\▓▓    ▓▓ ▓▓  | ▓▓ ▓▓     | ▓▓\▓▓    ▓▓
--  \▓▓▓▓▓▓  \▓▓▓▓▓▓ \▓▓   \▓▓\▓▓      \▓▓_\▓▓▓▓▓▓▓
--                                       |  \__| ▓▓
--                                        \▓▓    ▓▓
--                                         \▓▓▓▓▓▓ 
------------------------------------------------------------------------------
local screenshotingType = "cars" -- "boats", "planes", "helicopters", "military", "cars"
local coords = vec4(-485.6501, -201.0580, 36.9186, 206.6049)
if screenshotingType == "cars" then
    coords = vec4(-485.6501, -201.0580, 36.9186, 206.6049) -- Cars
elseif screenshotingType == "boats" then
    coords = vec4(588.8462, 3817.6975, 33.8612, 315.2895) -- Boats
elseif screenshotingType == "planes" then
    coords = vec4(-1622.4210, -2706.4146, 13.9431, 329.7495) -- Planes
elseif screenshotingType == "helicopters" then
    coords = vec4(-724.6682, -1444.0328, 5.0005, 323.0380) -- Helicopters
elseif screenshotingType == "military" then
    coords = vec4(-2031.0728, 3143.5222, 32.8103, 215.3580) -- Military
end

RegisterCommand("screenvehicle", function(source, args, rawCommand) -- /screenvehicle <name> (this will take a screenshot of the vehicle with the given name)
    ScreenshotVehicle(args[1])
end, false)

RegisterCommand("screenCurrVeh", function(source, args, rawCommand) -- /screenvehicle (you must be sitting in the vehicle, use this for cars, that require you to add extras in tuning system)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local name = GetEntityArchetypeName(vehicle)
    ScreenshotVehicle(name, vehicle)
end, false)

RegisterCommand("screenallvehicles", function(source, args, rawCommand) -- /screenallvehicles (this will take screenshots of all vehicles in the game)
    print("Start")
    lib.callback('getVehiclesScreenshots', 10000, function(veh)
        print(veh)
        if not veh then veh = {} end
        for _, vehicle in pairs(GetAllVehicleModels()) do
            print(vehicle)
            Wait(10)
            local class = GetVehicleClassFromName(vehicle)
            if not veh[vehicle] and class ~= 10 and class ~= 11 and class ~= 14 and class ~= 15 and class ~= 16 and class ~= 17 and class ~= 19 and class ~= 21 then
                ScreenshotVehicle(vehicle)
            end
        end
        print("DONE")
    end)
end)

-- 0: Compacts  
-- 1: Sedans  
-- 2: SUVs  
-- 3: Coupes  
-- 4: Muscle  
-- 5: Sports Classics  
-- 6: Sports  
-- 7: Super  
-- 8: Motorcycles  
-- 9: Off-road  
-- 10: Industrial  
-- 11: Utility  
-- 12: Vans  
-- 13: Cycles  
-- 14: Boats  
-- 15: Helicopters  
-- 16: Planes  
-- 17: Service  
-- 18: Emergency  
-- 19: Military  
-- 20: Commercial  
-- 21: Trains  
-- 22: Open Wheel

-- _______                    __   __                         __ __   __          
-- |       \                  |  \ |  \                       |  \  \ |  \         
-- | ▓▓▓▓▓▓▓\ ______  _______ | ▓▓_| ▓▓_         ______   ____| ▓▓\▓▓_| ▓▓_        
-- | ▓▓  | ▓▓/      \|       \ \▓|   ▓▓ \       /      \ /      ▓▓  \   ▓▓ \       
-- | ▓▓  | ▓▓  ▓▓▓▓▓▓\ ▓▓▓▓▓▓▓\   \▓▓▓▓▓▓      |  ▓▓▓▓▓▓\  ▓▓▓▓▓▓▓ ▓▓\▓▓▓▓▓▓       
-- | ▓▓  | ▓▓ ▓▓  | ▓▓ ▓▓  | ▓▓    | ▓▓ __     | ▓▓    ▓▓ ▓▓  | ▓▓ ▓▓ | ▓▓ __      
-- | ▓▓__/ ▓▓ ▓▓__/ ▓▓ ▓▓  | ▓▓    | ▓▓|  \    | ▓▓▓▓▓▓▓▓ ▓▓__| ▓▓ ▓▓ | ▓▓|  \     
-- | ▓▓    ▓▓\▓▓    ▓▓ ▓▓  | ▓▓     \▓▓  ▓▓     \▓▓     \\▓▓    ▓▓ ▓▓  \▓▓  ▓▓     
--  \▓▓▓▓▓▓▓  \▓▓▓▓▓▓ \▓▓   \▓▓      \▓▓▓▓       \▓▓▓▓▓▓▓ \▓▓▓▓▓▓▓\▓▓   \▓▓▓▓      
------------------------------------------------------------------------------
local serverUrl = "http://localhost:3000/"
local distanceMultiplier = 0.5
---@param name string | nil
---@return table
local function Screenshot(name)
    local Promise = promise.new()
    local _url = serverUrl .. "upload" .. (name and "/" .. name)
    exports['screenshot-basic']:requestScreenshotUpload(_url, 'image', function(data)
        Promise:resolve(json.decode(data))
    end)
    local data = Citizen.Await(Promise)
    return data
end

---@param coords vector3
---@return number
local function CreateCamera(coords)
    local _camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(_camera, coords.x + 1, coords.y + 1, coords.z + 1)
    SetCamFov(_camera, 14.0) -- 20.0 Je OK
    RenderScriptCams(true, false, 0, true, false)
    return _camera
end

---@param v vector3
---@return vector3
local function vec3abs(v)
    return vector3(
        math.abs(v.x),
        math.abs(v.y),
        math.abs(v.z)
    )
end

---@param min vector3
---@param max vector3
local function GetDistance(min, max)
    local _min = vec3abs(min)
    local _max = vec3abs(max)

    local distance = (_min.x + _max.x + _min.y + _max.y + _min.z + _max.z + 1.0) * distanceMultiplier
    return distance
end

---@param entity number
---@param name string
local function ScreenshotEntity(entity, name)
    local model = GetEntityModel(entity)
    local min, max = GetModelDimensions(model)
    distanceMultiplier = 0.5
    local distance = GetDistance(min, max)
    while distance == nil do Wait(100) end
    if distance > 6.0 then
        print(distance)
        if distance > 6.0 then
            if distance > 30.0 then
                distanceMultiplier = 1.5
            else
                distanceMultiplier = 1.2
            end
        else
            distanceMultiplier = 0.9
        end
        local distance = GetDistance(min, max)
        local camera = CreateCamera(GetEntityCoords(PlayerPedId()))
        local camCoords = vec3(coords.x + distance + 7.0, coords.y - 7.0, coords.z + (distance / 4))
        SetCamCoord(camera, camCoords.x, camCoords.y, camCoords.z)
        PointCamAtCoord(camera, coords.x, coords.y, coords.z)

        Wait(500)
        local data = Screenshot(name)
        RenderScriptCams(false, false, 0, true, false)
        TriggerServerEvent("vehicleDone", name)

        return data
    else
        local camera = CreateCamera(GetEntityCoords(PlayerPedId()))
        local camCoords = vec3(coords.x + distance + 7.0, coords.y - 7.0, coords.z + (distance / 4))
        SetCamCoord(camera, camCoords.x, camCoords.y, camCoords.z)
        PointCamAtCoord(camera, coords.x, coords.y, coords.z)

        Wait(500)
        local data = Screenshot(name)
        RenderScriptCams(false, false, 0, true, false)
        TriggerServerEvent("vehicleDone", name)

        return data
    end
end

function ScreenshotVehicle(name, veh)
    local model = joaat(name)
    lib.requestModel(model)
    local vehicle
    SetEntityVisible(PlayerPedId(), false, 0)
    if not veh then 
        vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, coords.w, false, true)
    else
        SetEntityCoords(veh, coords.x, coords.y, coords.z)
        SetEntityHeading(veh, coords.w)
    end
    if veh then vehicle = veh end
    FreezeEntityPosition(vehicle, true)

    local data = ScreenshotEntity(vehicle, name)
    if not veh then
        DeleteEntity(vehicle)
    else
        FreezeEntityPosition(vehicle, false)
    end
    SetEntityVisible(PlayerPedId(), true, 0)

    return data
end

Citizen.CreateThread(function()
    while true do
		Wait(0)
        DisplayRadar(false)
        SetAmbientVehicleRangeMultiplierThisFrame(0.0)
        SetParkedVehicleDensityMultiplierThisFrame(0.0)
        SetRandomVehicleDensityMultiplierThisFrame(0.0)
        SetAmbientPedRangeMultiplierThisFrame(0.0)
        SetPedDensityMultiplierThisFrame(0.0)
        SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
        SetVehicleDensityMultiplierThisFrame(0.0)
        ClearAreaOfVehicles(coords, 150.0, false, false, false, false, false)
    end
end)