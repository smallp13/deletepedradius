local center = vector3(-1335.2922, -1301.8439, 4.8385) -- vector location
local radius = 20.0 -- Radius to despawn ai

-- Function to check distance between two Vector3 positions
function distance(pos1, pos2)
    return #(pos1 - pos2)
end

-- Main loop to continuously despawn AI peds
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- Adjust the delay as needed, 1000ms = 1 second

        -- Get all AI peds in the world
        local allPeds = {}
        local handle, ped = FindFirstPed()
        local success

        repeat
            local pos = GetEntityCoords(ped, false)
            if distance(pos, center) <= radius then
                DeleteEntity(ped)
            end
            success, ped = FindNextPed(handle)
        until not success

        EndFindPed(handle)
    end
end)