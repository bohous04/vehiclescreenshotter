local allVeh = {}
Citizen.CreateThread(function()
    allVeh = json.decode(LoadResourceFile(GetCurrentResourceName(), 'doneVeh.json'))
    local count = 0
    if allVeh == nil then
        allVeh = {}
    end
end)

lib.callback.register('getVehiclesScreenshots', function(src)
    return allVeh
end)

RegisterNetEvent("vehicleDone", function(veh)
    allVeh[veh] = true
end)

RegisterCommand("saveVehicles", function()
    SaveResourceFile(GetCurrentResourceName(), 'doneVeh.json', json.encode(allVeh))
end)