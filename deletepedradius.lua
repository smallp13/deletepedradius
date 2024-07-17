local locations = {
    { center = vector3(-1335.2922, -1301.8439, 4.8385), radius = 50.0 },
    { center = vector3(-1314.6464, -1373.2150, 4.5300), radius = 50.0 },
    -- Add more locations as needed
}

-- Function to check distance between two Vector3 positions
function distance(pos1, pos2)
    return #(pos1 - pos2)
end

-- Main loop to continuously despawn AI peds for each location
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- Adjust the delay as needed, 1000ms = 1 second

        for _, location in ipairs(locations) do
            local center = location.center
            local radius = location.radius

            -- Get all AI peds in the world
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
    end
end)
