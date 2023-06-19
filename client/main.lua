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


function spawn()

    
    
    for k, v in pairs(Config.plante or {}) do
        RequestModel(hashmic)
        while not HasModelLoaded(hashmic) do
        Wait(1)
        end

        print(Config.plante[k].coords)
        local planta = CreateObject(hashmic,Config.plante[k].coords, true , true ,false)
        PlaceObjectOnGroundProperly(planta)
        FreezeEntityPosition(planta,true)
        -- Wait(60000)
    end

    print("stam oleaca")
    Wait(15000)
    --planta mare
    for k, v in pairs(Config.plante or {}) do

        RequestModel(hashmare)
        while not HasModelLoaded(hashmare) do
        Wait(1)
        end

        obiect = QBCore.Functions.GetClosestObject(Config.plante[i].coords)
        DeleteObject(obiect)
        Config.plante[k].gata = true
        local mare = CreateObject(hashmare,Config.plante[k].coords, true , true ,false)
        exports['qb-target']:AddTargetEntity(mare , { 
            options = { 
              { 
                num = 1, 
                type = "client", 
                event = "Test:Event", 
                icon = 'fas fa-example',
                label = 'Test', -- This is the label of this option which you would be able to click on to trigger everything, this has to be a string
                targeticon = 'fab fa-untappd', -- This is the icon of the target itself, the icon changes to this when it turns blue on this specific option, this is OPTIONAL
              }
            },
            distance = 2.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
          })
        PlaceObjectOnGroundProperly(mare)
        FreezeEntityPosition(mare,true)
        -- Wait(60000) 
    end
end

Citizen.CreateThread(function()
    while true do
        -- Wait(30000)

        spawn()
        break
    end    
end)