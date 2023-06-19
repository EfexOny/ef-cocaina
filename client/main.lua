Citizen.CreateThread(function()
    -- PlayerData management
    local PlayerData = QBCore.Functions.GetPlayerData()

    RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
    AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
        PlayerData = QBCore.Functions.GetPlayerData()
    end)

    RegisterNetEvent("QBCore:Client:OnPlayerUnload")
    AddEventHandler("QBCore:Client:OnPlayerUnload", function()
        PlayerData = nil
    end)

    RegisterNetEvent("QBCore:Client:OnJobUpdate")
    AddEventHandler("QBCore:Client:OnJobUpdate", function(job)
        if PlayerData then
            PlayerData.job = job
        else
            PlayerData = QBCore.Functions.GetPlayerData()
        end
    end)

    

    RegisterNetEvent("QBCore:Client:SetDuty")
    RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
        if PlayerData.job then
            PlayerData.job.onduty = duty
        else
            PlayerData = QBCore.Functions.GetPlayerData()
        end
    end)
end)

AddEventHandler('onResourceStop', function(r)
    if r == GetCurrentResourceName()
    then
        reset()
        end
end)

function StergePlanta()
    ped = GetPlayerPed(-1)
    pos = GetEntityCoords(ped)
    print(pos)
    obiect = QBCore.Functions.GetClosestObject(pos)
    print(obiect)
    DeleteObject(obiect)
end


local hashmic = "prop_weed_02"
local hashmare = "prop_weed_01"

RegisterCommand('delpl',function()
    StergePlanta()
end)

RegisterCommand('statuspl',function()
    for k, v in pairs(plante or {}) do 
        print("Planta: " .. k .. plante[k].status)
    end
end)

function reset()
    for k, v in pairs(plante or {}) do
        plante[k].status = "nuexista"
    end
end

function harvest()
        ped = GetPlayerPed(-1)
        local ped = PlayerPedId()
        QBCore.Functions.Progressbar("harvest_cocaina", ('harvestam'), 3000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
        flags = 16,
        }, {
		animDict = "amb@world_human_gardener_plant@male@base",
        anim = "base",
        }, {}, {}, function() -- Done
        StopAnimTask(ped, "amb@world_human_gardener_plant@male@base", "base", 1.0)
        ClearPedTasksImmediately(ped)
    end)
end

RegisterNetEvent("ef-cocaina:harvest")
AddEventHandler("ef-cocaina:harvest", function()
    harvest()
end)

function spawn()
    for k, v in pairs(plante or {}) do
        if  plante[k].status == "nuexista" then
            RequestModel(hashmic)
            while not HasModelLoaded(hashmic) do
            Wait(1)
            end

            local planta = CreateObject(hashmic, plante[k].coords, true , true ,false)
            PlaceObjectOnGroundProperly(planta)
            FreezeEntityPosition(planta,true)
            plante[k].status = "Mic" 
            -- Wait(60000)
        else
            if plante[k].status == "Mic" then
                RequestModel(hashmare)
                while not HasModelLoaded(hashmare) do
                Wait(1)
                end
        
                obiect = QBCore.Functions.GetClosestObject(plante[k].coords)
                DeleteObject(obiect)
                local mare = CreateObject(hashmare, plante[k].coords, true , true ,false)
                exports['qb-target']:AddTargetEntity(mare , { 
                    options = { 
                    { 
                        num = 1, 
                        type = "client", 
                        event = "ef-cocaina:harvest", 
                        icon = 'fab fa-untappd',
                        label = 'Harvest', -- This is the label of this option which you would be able to click on to trigger everything, this has to be a string
                        targeticon = 'fab fa-untappd', -- This is the icon of the target itself, the icon changes to this when it turns blue on this specific option, this is OPTIONAL
                    }
                    },
                    distance = 2.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
                })
                PlaceObjectOnGroundProperly(mare)
                FreezeEntityPosition(mare,true)
                plante[k].status = "Mare" 
            else
                if plante[k].status == "Mare" then 
                    print("colecteaza frate")
                    Wait(10000)
                    print("colecteaza fratev2")
                end
            end
        end
    end
    print("stam oleaca")
    Wait(15000)
end

Citizen.CreateThread(function()
    while true do
        spawn()
        Wait(15000)
    end    
end)

plante = {
	-- Randu 1
    [1] = {
        coords = vector3(5353.1499023438,-5207.1840820312,31.022661209106),
        status = "nuexista",
        harvested = false
    },

	[2] = {
        coords = vector3(5357.6030273438,-5202.3159179688,30.842809677124),
        status = "nuexista",
        harvested = false
    },
	[3] = {
        coords = vector3(5361.8061523438,-5197.8178710938,30.610080718994),
        status = "nuexista",
        harvested = false
    },
	[4] = {
        coords = vector3(5366.2875976562,-5193.0336914062,30.484830856323),
        status = "nuexista",
        harvested = false
    },
	[5] = {
        coords = vector3(5371.8334960938,-5186.986328125,30.645357131958),
        status = "nuexista",
        harvested = false
    },
	[6] = {
        coords = vector3(5377.0048828125,-5181.60546875,30.621124267578),
        status = "nuexista",
        harvested = false
    },
	[7] = {
        coords = vector3(5381.59375,-5176.4799804688,30.686229705811),
        status = "nuexista",
        harvested = false
    },
	[8] = {
        coords = vector3(5386.2778320312,-5171.5844726562,30.922868728638),
        status = "nuexista",
        harvested = false
    },
	[9] = {
        coords = vector3(5384.1850585938,-5169.7607421875,30.657764434814),
        status = "nuexista",
        harvested = false
    },
	[10] = {
        coords = vector3(5379.7280273438,-5175.1083984375,30.442293167114),
        status = "nuexista",
        harvested = false
    },
	[11] = {
        coords = vector3(5374.0815429688,-5181.185546875,30.601625442505),
        status = "nuexista",
        harvested = false
    },
}