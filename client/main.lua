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
        cleanup()
        end
end)

AddEventHandler('onResourceStart', function(r)
    if r == GetCurrentResourceName()
    then
        locuri_procesat()
        end
end)

-- FUNCTII

function locuri_procesat()

    exports['qb-target']:AddBoxZone("coca_procesare1",vector3(4980.76, -5132.42, -4.47), 2, 2, {
        name = "coca_procesare",
        heading=0,
        debugPoly = true,
        minZ = -8.07,
        maxZ = -4.07,
    }, {
        options = {
            {
                type = "client",
                event = "ef-cocaina:procesatcoca",
                icon = 'fas fa-low-vision',
                label = 'Proceseaza',
            },
        },
        distance = 3
    })

    exports['qb-target']:AddBoxZone("coca_procesare2",vector3(4983.27, -5132.0, -4.47), 2, 2, {
        name = "coca_procesare",
        heading=0,
        debugPoly = true,
        minZ = -7.87,
        maxZ = -3.87,
    }, {
        options = {
            {
                type = "client",
                event = "ef-cocaina:procesatcoca",
                icon = 'fas fa-low-vision',
                label = 'Proceseaza',
            },
        },
        distance = 3
    })
end

function cleanup()
    exports['qb-target']:RemoveZone("coca_procesare1")
    exports['qb-target']:RemoveZone("coca_procesare2")
end

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


function harvestplant()
    ped = GetPlayerPed(-1)
    pos = GetEntityCoords(ped)
    obiect = QBCore.Functions.GetClosestObject(pos)
    print("id obiect: " .. obiect)
    cautat = GetEntityCoords(obiect)
    print("coord obiect aproape: " .. cautat)
    for k, v in pairs(plante or {}) do 
        print(k .. plante[k].coords)
        if plante[k].coords.x   == cautat.x and plante[k].coords.y == cautat.y then
            plante[k].status = "nuexista" 
            DeleteObject(obiect)
        end
    end
end


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
    Wait(3000)
    harvestplant()
    QBCore.Functions.Notify("Ai colectat cu succes.")
    TriggerServerEvent("ef-cocaina:server:harvest")
    
end

function impachetat_planta()
    ped = GetPlayerPed(-1)
    coord = QBCore.Functions.GetCoords(ped)

    item = QBCore.Functions.HasItem("planta coca")
    if item then
        QBCore.Functions.Progressbar("harvest_cocaina", ('Impachetam'), 8000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
            flags = 16,
            }, {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 16,
            }, {}, {}, function() -- Done
            DeleteObject(prop)
            StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
            end)
    end
end

function procesat_planta()
        ped = GetPlayerPed(-1)
        coord = QBCore.Functions.GetCoords(ped)

        local animDict = "anim@amb@business@coc@coc_unpack_cut_left@"
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
        RequestModel("bkr_prop_coke_bakingsoda_o")
        RequestModel("prop_cs_credit_card")
        while not HasModelLoaded("prop_cs_credit_card") and not HasModelLoaded("bkr_prop_coke_bakingsoda_o") do Citizen.Wait(10) end
        SetEntityHeading(ped)
        Citizen.Wait(10)
        vector3(4976.94, -5132.98, -4.43)

        vector3(4980.71, -5132.64, -4.47)
        local card = CreateObject(GetHashKey("prop_cs_credit_card"), coord.x, coord.y, coord.z, true, false, false)
        local card2 = CreateObject(GetHashKey("prop_cs_credit_card"), coord.x, coord.y, coord.z, true, false, false)
        local soda = CreateObject(GetHashKey("bkr_prop_coke_bakingsoda_o"), coord.x, coord.y, coord.z, true, false, false)
        local gathScene = NetworkCreateSynchronisedScene(coord.x + 2  , coord.y + 0.5 , coord.z - 0.6 , 0.0, 0.0, 180.0 , 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, gathScene, animDict, "coke_cut_v5_coccutter", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(card, gathScene, animDict, "coke_cut_v5_creditcard", 4.0, -8.0, 1)
        NetworkAddEntityToSynchronisedScene(card2, gathScene, animDict, "coke_cut_v5_creditcard^1", 4.0, -8.0, 1)
        NetworkAddEntityToSynchronisedScene(soda, gathScene, animDict, "coke_cut_v5_bakingsoda", 4.0, -8.0, 1)
        NetworkStartSynchronisedScene(gathScene)
        Citizen.Wait(20000)
        NetworkStopSynchronisedScene(gathScene)
        DeleteEntity(card)
        DeleteEntity(card2)
        DeleteEntity(soda)
        Wait(3000)
        StopAnimTask(ped, dict, anim, 1.0)
        ClearPedTasksImmediately(ped)
        Wait(3000)
end

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
            Wait(60000)
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
                    }
                    },
                    distance = 1.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
                })
                PlaceObjectOnGroundProperly(mare)
                FreezeEntityPosition(mare,true)
                plante[k].status = "Mare" 
                Wait(60000)
            end
        end
    end
    print("stam oleaca")
    Wait(15000)
end

Citizen.CreateThread(function()
    while true do
        spawn()
        Wait(60000)
    end    
end)

-- EVENTS

RegisterNetEvent("ef-cocaina:procesatcoca")
AddEventHandler("ef-cocaina:procesatcoca",function()
    procesat_planta()
end)

RegisterNetEvent("ef-cocaina:harvest")
AddEventHandler("ef-cocaina:harvest", function()
    harvest()
end)

-- COMENZI (MAINLY DEBUG)


RegisterCommand('delpl',function()
    StergePlanta()
end)

RegisterCommand('statuspl',function()
    for k, v in pairs(plante or {}) do 
        print("Planta: " .. k .. plante[k].status)
    end
end)


-- plante
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
    [12] = {
        coords = vector3(5368.4096679688,-5187.58203125,30.498647689819),
        status = "nuexista",
        harvested = false
    },
	-- Randu 2
	[13] = {
        coords = vector3(5362.412109375,-5194.08984375,30.464206695557),
        status = "nuexista",
        harvested = false
    },
	[14] = {
        coords = vector3(5356.8193359375,-5200.5888671875,30.649749755859),
        status = "nuexista",
        harvested = false
    },
	[15] = {
        coords = vector3(5352.0791015625,-5205.7192382812,30.882474899292),
        status = "nuexista",
        harvested = false
    },
	[16] = {
        coords = vector3(5348.806640625,-5205.1284179688,30.839424133301),
        status = "nuexista",
        harvested = false
    },
	[17] = {
        coords = vector3(5354.3364257812,-5198.9985351562,30.439100265503),
        status = "nuexista",
        harvested = false
    },
	[18] = {
        coords = vector3(5360.318359375,-5192.6923828125,30.272401809692),
        status = "nuexista",
        harvested = false
    },
	[19] = {
        coords = vector3(5365.6704101562,-5186.951171875,30.444932937622),
        status = "nuexista",
        harvested = false
    },
	[20] = {
        coords = vector3(5371.3862304688,-5180.2294921875,30.403091430664),
        status = "nuexista",
        harvested = false
    },
	[21] = {
        coords = vector3(5375.7358398438,-5175.33203125,30.27484703064),
        status = "nuexista",
        harvested = false
    },
	[22] = {
        coords = vector3(5380.33984375,-5170.3950195312,30.156726837158),
        status = "nuexista",
        harvested = false
    },
	[23] = {
        coords = vector3(5380.4204101562,-5166.2421875,29.834789276123),
        status = "nuexista",
        harvested = false
    },
    [24] = {
        coords = vector3(5374.4243164062,-5173.5146484375,29.858720779419),
        status = "nuexista",
        harvested = false
    },
	-- Randu 3
	[25] = {
        coords = vector3(5368.73828125,-5179.9067382812,30.297300338745),
        status = "nuexista",
        harvested = false
    },
	[26] = {
        coords = vector3(5363.2041015625,-5186.1254882812,30.324813842773),
        status = "nuexista",
        harvested = false
    },
	[27] = {
        coords = vector3(5356.9545898438,-5192.7333984375,30.006698608398),
        status = "nuexista",
        harvested = false
    },
	[28] = {
        coords = vector3(5350.4375,-5199.9819335938,30.541149139404),
        status = "nuexista",
        harvested = false
    },
	[29] = {
        coords = vector3(5346.595703125,-5204.3642578125,30.933380126953),
        status = "nuexista",
        harvested = false
    },
	[30]= {
        coords = vector3(5344.619140625,-5202.376953125,31.06259727478),
        status = "nuexista",
        harvested = false
    },
	[31] = {
        coords = vector3(5338.88671875,-5186.4438476562,31.06702041626),
        status = "nuexista",
        harvested = false
    },
	[32] = {
        coords = vector3(5346.28515625,-5178.4140625,29.558498382568),
        status = "nuexista",
        harvested = false
    },
	[33] = {
        coords = vector3(5354.3950195312,-5169.3999023438,29.441623687744),
        status = "nuexista",
        harvested = false
    },
	[34] = {
        coords = vector3(5362.5161132812,-5159.6728515625,28.603685379028),
        status = "nuexista",
        harvested = false
    },
	[35] = {
        coords = vector3(5367.4296875,-5154.7661132812,27.595928192139),
        status = "nuexista",
        harvested = false
    },
	[36] = {
        coords = vector3(5363.525390625,-5155.3012695312,27.798597335815),
        status = "nuexista",
        harvested = false
    },
	-- Randu 4
	[37] = {
        coords = vector3(5355.9365234375,-5163.6655273438,29.243072509766),
        status = "nuexista",
        harvested = false
    },
	[38] = {
        coords = vector3(5347.3544921875,-5173.8095703125,29.476766586304),
        status = "nuexista",
        harvested = false
    },
	[39] = {
        coords = vector3(5340.001953125,-5181.712890625,30.39563369751),
        status = "nuexista",
        harvested = false
    },
	[40] = {
        coords = vector3(5333.4677734375,-5188.77734375,31.422966003418),
        status = "nuexista",
        harvested = false
    },
	[41] = {
        coords = vector3(5330.9272460938,-5187.5795898438,31.341171264648),
        status = "nuexista",
        harvested = false
    },
	[42] = {
        coords = vector3(5338.6650390625,-5179.4311523438,30.158977508545),
        status = "nuexista",
        harvested = false
    },
	[43] = {
        coords = vector3(5345.4375,-5171.9135742188,29.319629669189),
        status = "nuexista",
        harvested = false
    },
	[44] = {
        coords = vector3(5352.1787109375,-5164.2885742188,29.198560714722),
        status = "nuexista",
        harvested = false
    },
	[45] = {
        coords = vector3(5360.4150390625,-5154.91796875,27.846981048584),
        status = "nuexista",
        harvested = false
    },
	[46] = {
        coords = vector3(5361.1225585938,-5150.7109375,26.662830352783),
        status = "nuexista",
        harvested = false
    },
	[47] = {
        coords = vector3(5356.2587890625,-5156.0151367188,28.249326705933),
        status = "nuexista",
        harvested = false
    },
    [48] = {
        coords = vector3(5349.974609375,-5163.0649414062,29.078287124634),
        status = "nuexista",
        harvested = false
    },
	-- Randu 5
	[49] = {
        coords = vector3(5341.4580078125,-5172.5361328125,29.24427986145),
        status = "nuexista",
        harvested = false
    },
	[50] = {
        coords = vector3(5334.984375,-5179.5986328125,30.482891082764),
        status = "nuexista",
        harvested = false
    },
	[51] = {
        coords = vector3(5329.6333007812,-5185.2353515625,31.272613525391),
        status = "nuexista",
        harvested = false
    },
	[52] = {
        coords = vector3(5326.3715820312,-5185.1137695312,31.243457794189),
        status = "nuexista",
        harvested = false
    },
	[53] = {
        coords = vector3(5333.17578125,-5177.7280273438,30.178388595581),
        status = "nuexista",
        harvested = false
    },
	[54] = {
        coords = vector3(5339.6064453125,-5170.6635742188,29.066942214966),
        status = "nuexista",
        harvested = false
    },
	[55] = {
        coords = vector3(5345.9184570312,-5163.66796875,29.034238815308),
        status = "nuexista",
        harvested = false
    },
	[56] = {
        coords = vector3(5351.4125976562,-5157.8120117188,28.651838302612),
        status = "nuexista",
        harvested = false
    },
	[57] = {
        coords = vector3(5358.02734375,-5150.771484375,26.626203536987),
        status = "nuexista",
        harvested = false
    },
	[58] = {
        coords = vector3(5356.6577148438,-5148.2075195312,25.973281860352),
        status = "nuexista",
        harvested = false
    },
	[59] = {
        coords = vector3(5350.8090820312,-5154.986328125,28.261835098267),
        status = "nuexista",
        harvested = false
    },
	[60] = {
        coords = vector3(5343.9252929688,-5162.3754882812,28.940317153931),
        status = "nuexista",
        harvested = false
    },
	-- Randu 6
	[61] = {
        coords = vector3(5336.1586914062,-5170.654296875,28.956825256348),
        status = "nuexista",
        harvested = false
    },
	[62] = {
        coords = vector3(5329.42578125,-5178.0004882812,30.252325057983),
        status = "nuexista",
        harvested = false
    },
	[63] = {
        coords = vector3(5325.6552734375,-5182.2241210938,31.076169967651),
        status = "nuexista",
        harvested = false
    },
	[64] = {
        coords = vector3(5322.6909179688,-5181.7548828125,30.847862243652),
        status = "nuexista",
        harvested = false
    },
	[65] = {
        coords = vector3(5329.6479492188,-5174.3349609375,29.501358032227),
        status = "nuexista",
        harvested = false
    },
	[66] = {
        coords = vector3(5336.783203125,-5166.6767578125,28.614068984985),
        status = "nuexista",
        harvested = false
    },
	[67] = {
        coords = vector3(5343.76953125,-5159.0166015625,28.65411567688),
        status = "nuexista",
        harvested = false
    },
	[68] = {
        coords = vector3(5350.728515625,-5151.3779296875,27.369337081909),
        status = "nuexista",
        harvested = false
    },
	[69] = {
        coords = vector3(5355.671875,-5146.3525390625,25.298877716064),
        status = "nuexista",
        harvested = false
    },
	[70] = {
        coords = vector3(5352.8237304688,-5145.4204101562,25.134922027588),
        status = "nuexista",
        harvested = false
    },
	[71] = {
        coords = vector3(5346.8349609375,-5151.8930664062,27.665561676025),
        status = "nuexista",
        harvested = false
    },
    [72] = {
        coords = vector3(5341.2866210938,-5158.1274414062,28.236019134521),
        status = "nuexista",
        harvested = false
    },
	-- Randu 7
	[73] = {
        coords = vector3(5333.1254882812,-5166.79296875,28.26319694519),
        status = "nuexista",
        harvested = false
    },
	[74] = {
        coords = vector3(5326.9150390625,-5173.767578125,29.366992950439),
        status = "nuexista",
        harvested = false
    },
	[75] = {
        coords = vector3(5321.1040039062,-5180.0478515625,30.531980514526),
        status = "nuexista",
        harvested = false
    },
	[76] = {
        coords = vector3(5319.8525390625,-5177.5190429688,30.01392364502),
        status = "nuexista",
        harvested = false
    },
	[77] = {
        coords = vector3(5325.6313476562,-5171.0561523438,28.704580307007),
        status = "nuexista",
        harvested = false
    },
	[78] = {
        coords = vector3(5333.2680664062,-5162.5756835938,27.700658798218),
        status = "nuexista",
        harvested = false
    },
	[79] = {
        coords = vector3(5342.3325195312,-5153.0732421875,27.61424446106),
        status = "nuexista",
        harvested = false
    },
	[80] = {
        coords = vector3(5348.7138671875,-5146.1875,25.476541519165),
        status = "nuexista",
        harvested = false
    },
	[81] = {
        coords = vector3(5348.2905273438,-5143.3359375,24.22346496582),
        status = "nuexista",
        harvested = false
    },
	[82] = {
        coords = vector3(5341.880859375,-5150.2729492188,26.810611724854),
        status = "nuexista",
        harvested = false
    },
	[83] = {
        coords = vector3(5332.830078125,-5159.3051757812,27.150192260742),
        status = "nuexista",
        harvested = false
    },
	[84] = {
        coords = vector3(5326.5537109375,-5166.1748046875,27.667587280273),
        status = "nuexista",
        harvested = false
    },
	-- Randu 8
	[85] = {
        coords = vector3(5320.7866210938,-5173.1728515625,29.16114616394),
        status = "nuexista",
        harvested = false
    },
	[86] = {
        coords = vector3(5317.38671875,-5176.8852539062,29.695423126221),
        status = "nuexista",
        harvested = false
    },
	[87] = {
        coords = vector3(5316.5068359375,-5173.818359375,29.213306427002),
        status = "nuexista",
        harvested = false
    },
	[88] = {
        coords = vector3(5322.59375,-5166.921875,27.886167526245),
        status = "nuexista",
        harvested = false
    },
	[89] = {
        coords = vector3(5329.3696289062,-5160.171875,26.652835845947),
        status = "nuexista",
        harvested = false
    },
	[90] = {
        coords = vector3(5337.1840820312,-5151.7055664062,26.589965820312),
        status = "nuexista",
        harvested = false
    },
	[91] = {
        coords = vector3(5344.705078125,-5143.6298828125,24.086847305298),
        status = "nuexista",
        harvested = false
    },
	[92] = {
        coords = vector3(5343.8110351562,-5141.1171875,22.972972869873),
        status = "nuexista",
        harvested = false
    },
	[93] = {
        coords = vector3(5338.0200195312,-5147.5444335938,25.469871520996),
        status = "nuexista",
        harvested = false
    },
	[94] = {
        coords = vector3(5319.953125,-5166.2290039062,28.04914855957),
        status = "nuexista",
        harvested = false
    },
	[95] = {
        coords = vector3(5348.4404296875,-5198.0952148438,30.58130645752),
        status = "nuexista",
        harvested = false
    },
    [96] = {
        coords = vector3(5354.0888671875,-5192.0971679688,29.85941696167),
        status = "nuexista",
        harvested = false
    },
	-- Randu 9
	[97] = {
        coords = vector3(5360.6010742188,-5185.4077148438,30.121267318726),
        status = "nuexista",
        harvested = false
    },
	[98] = {
        coords = vector3(5366.4384765625,-5178.7109375,30.075132369995),
        status = "nuexista",
        harvested = false
    },
	[99] = {
        coords = vector3(5372.72265625,-5170.9799804688,29.425203323364),
        status = "nuexista",
        harvested = false
    },
	[100] = {
        coords = vector3(5378.6948242188,-5164.3002929688,29.393146514893),
        status = "nuexista",
        harvested = false
    },
	[101] = {
        coords = vector3(5377.8110351562,-5162.2163085938,29.126710891724),
        status = "nuexista",
        harvested = false
    },
	[102] = {
        coords = vector3(5372.365234375,-5168.1655273438,29.033491134644),
        status = "nuexista",
        harvested = false
    },
	[103] = {
        coords = vector3(5366.5249023438,-5174.9443359375,29.708478927612),
        status = "nuexista",
        harvested = false
    },
	[104] = {
        coords = vector3(5357.3452148438,-5184.9897460938,29.874990463257),
        status = "nuexista",
        harvested = false
    },
	[105] = {
        coords = vector3(5351.0678710938,-5191.529296875,29.9797706604),
        status = "nuexista",
        harvested = false
    },
	[106] = {
        coords = vector3(5343.6455078125,-5200.2543945312,31.298469543457),
        status = "nuexista",
        harvested = false
    },
	[107] = {
        coords = vector3(5341.0444335938,-5199.3168945312,31.57186126709),
        status = "nuexista",
        harvested = false
    },
	[108] = {
        coords = vector3(5345.955078125,-5193.6450195312,30.781656265259),
        status = "nuexista",
        harvested = false
    },
	-- Randu 10
	[109] = {
        coords = vector3(5352.2104492188,-5186.7329101562,29.658950805664),
        status = "nuexista",
        harvested = false
    },
	[110] = {
        coords = vector3(5358.1157226562,-5180.5141601562,29.800746917725),
        status = "nuexista",
        harvested = false
    },
	[111] = {
        coords = vector3(5364.140625,-5173.34375,29.474229812622),
        status = "nuexista",
        harvested = false
    },
	[112] = {
        coords = vector3(5373.3295898438,-5163.2998046875,28.736211776733),
        status = "nuexista",
        harvested = false
    },
	[113] = {
        coords = vector3(5372.0517578125,-5160.9301757812,28.482711791992),
        status = "nuexista",
        harvested = false
    },
	[114] = {
        coords = vector3(5365.3833007812,-5168.2348632812,28.859239578247),
        status = "nuexista",
        harvested = false
    },
	[115] = {
        coords = vector3(5358.525390625,-5176.5341796875,29.625673294067),
        status = "nuexista",
        harvested = false
    },
	[116] = {
        coords = vector3(5349.67578125,-5185.9697265625,29.770803451538),
        status = "nuexista",
        harvested = false
    },
	[117] = {
        coords = vector3(5343.8974609375,-5192.109375,31.100774765015),
        status = "nuexista",
        harvested = false
    },
	[118] = {
        coords = vector3(5339.2739257812,-5197.2397460938,31.731866836548),
        status = "nuexista",
        harvested = false
    },
	[119] = {
        coords = vector3(5338.01953125,-5194.2578125,31.690786361694),
        status = "nuexista",
        harvested = false
    },
    [120] = {
        coords = vector3(5346.033203125,-5186.12890625,30.181039810181),
        status = "nuexista",
        harvested = false
    },
	-- Randu 11
	[121] = {
        coords = vector3(5353.6743164062,-5178.0913085938,29.585887908936),
        status = "nuexista",
        harvested = false
    },
	[122] = {
        coords = vector3(5359.9482421875,-5170.345703125,29.238807678223),
        status = "nuexista",
        harvested = false
    },
	[123] = {
        coords = vector3(5370.0107421875,-5159.2055664062,28.247304916382),
        status = "nuexista",
        harvested = false
    },
	[124] = {
        coords = vector3(5368.1313476562,-5157.4072265625,28.008478164673),
        status = "nuexista",
        harvested = false
    },
	[125] = {
        coords = vector3(5361.125,-5165.0830078125,29.107269287109),
        status = "nuexista",
        harvested = false
    },
	[126] = {
        coords = vector3(5352.91015625,-5175.4189453125,29.605726242065),
        status = "nuexista",
        harvested = false
    },
	[127] = {
        coords = vector3(5344.9584960938,-5184.1694335938,30.148221969604),
        status = "nuexista",
        harvested = false
    },
	[128] = {
        coords = vector3(5336.7465820312,-5192.4409179688,31.611400604248),
        status = "nuexista",
        harvested = false
    },
	[129] = {
        coords = vector3(5334.7026367188,-5191.052734375,31.557947158813),
        status = "nuexista",
        harvested = false
    },
	[130] = {
        coords = vector3(5332.5883789062,-5286.9194335938,35.572994232178),
        status = "nuexista",
        harvested = false
    },
	[131] = {
        coords = vector3(5325.912109375,-5293.6796875,35.660400390625),
        status = "nuexista",
        harvested = false
    },
	[132] = {
        coords = vector3(5318.1953125,-5300.5249023438,35.478523254395),
        status = "nuexista",
        harvested = false
    },
	-- Randu 12
	[133] = {
        coords = vector3(5311.9833984375,-5306.4150390625,35.54967880249),
        status = "nuexista",
        harvested = false
    },
	[134] = {
        coords = vector3(5304.0078125,-5314.2006835938,35.371067047119),
        status = "nuexista",
        harvested = false
    },
	[135] = {
        coords = vector3(5301.857421875,-5312.4233398438,35.219440460205),
        status = "nuexista",
        harvested = false
    },
	[136] = {
        coords = vector3(5307.8666992188,-5306.3662109375,35.080951690674),
        status = "nuexista",
        harvested = false
    },
	[137] = {
        coords = vector3(5315.5830078125,-5299.2158203125,35.081405639648),
        status = "nuexista",
        harvested = false
    },
	[138] = {
        coords = vector3(5321.2509765625,-5294.1655273438,35.25687789917),
        status = "nuexista",
        harvested = false
    },
	[139] = {
        coords = vector3(5328.2568359375,-5287.4116210938,35.384910583496),
        status = "nuexista",
        harvested = false
    },
	[140] = {
        coords = vector3(5328.6381835938,-5283.865234375,34.964473724365),
        status = "nuexista",
        harvested = false
    },
	[141] = {
        coords = vector3(5320.0317382812,-5292.0419921875,34.955493927002),
        status = "nuexista",
        harvested = false
    },
	[142] = {
        coords = vector3(5312.658203125,-5298.740234375,34.942539215088),
        status = "nuexista",
        harvested = false
    },
	[143] = {
        coords = vector3(5306.0034179688,-5305.1674804688,34.778587341309),
        status = "nuexista",
        harvested = false
    },
    [144] = {
        coords = vector3(5301.6494140625,-5309.5219726562,34.984645843506),
        status = "nuexista",
        harvested = false
    },
    [145] = {
        coords = vector3(5299.474609375,-5307.8432617188,34.766319274902),
        status = "nuexista",
        harvested = false
    },
    [146] = {
        coords = vector3(5305.5795898438,-5302.1557617188,34.644985198975),
        status = "nuexista",
        harvested = false
    },
    [147] = {
        coords = vector3(5312.9204101562,-5295.1416015625,34.647045135498),
        status = "nuexista",
        harvested = false
    },
    [148] = {
        coords = vector3(5320.1108398438,-5288.5283203125,34.600521087646),
        status = "nuexista",
        harvested = false
    },
    [149] = {
        coords = vector3(5326.8168945312,-5281.7700195312,34.619247436523),
        status = "nuexista",
        harvested = false
    },
    [150] = {
        coords = vector3(5326.0068359375,-5279.18359375,34.465488433838),
        status = "nuexista",
        harvested = false
    },
    [151] = {
        coords = vector3(5319.7939453125,-5285.1284179688,34.393672943115),
        status = "nuexista",
        harvested = false
    },
    [152] = {
        coords = vector3(5312.3959960938,-5292.171875,34.366931915283),
        status = "nuexista",
        harvested = false
    },
    [153] = {
        coords = vector3(5304.9663085938,-5299.021484375,34.504001617432),
        status = "nuexista",
        harvested = false
    },
    [154] = {
        coords = vector3(5296.7431640625,-5306.87109375,34.48030090332),
        status = "nuexista",
        harvested = false
    },
    [155] = {
        coords = vector3(5294.9233398438,-5305.5288085938,34.102512359619),
        status = "nuexista",
        harvested = false
    },
    [156] = {
        coords = vector3(5301.7534179688,-5298.72265625,34.183498382568),
        status = "nuexista",
        harvested = false
    },
    [157] = {
        coords = vector3(5309.3349609375,-5291.423828125,34.106266021729),
        status = "nuexista",
        harvested = false
    },
    [158] = {
        coords = vector3(5316.8154296875,-5284.5004882812,34.187007904053),
        status = "nuexista",
        harvested = false
    },
    [159] = {
        coords = vector3(5324.3037109375,-5277.078125,34.228744506836),
        status = "nuexista",
        harvested = false
    },
    [160] = {
        coords = vector3(5322.7631835938,-5275.4174804688,34.015201568604),
        status = "nuexista",
        harvested = false
    },
    [161] = {
        coords = vector3(5316.5893554688,-5281.1791992188,34.009006500244),
        status = "nuexista",
        harvested = false
    },
    [162] = {
        coords = vector3(5309.34765625,-5288.2172851562,33.844974517822),
        status = "nuexista",
        harvested = false
    },
    [163] = {
        coords = vector3(5302.3095703125,-5294.966796875,33.994598388672),
        status = "nuexista",
        harvested = false
    },
    [164] = {
        coords = vector3(5294.4702148438,-5302.138671875,33.876121520996),
        status = "nuexista",
        harvested = false
    },
    [165] = {
        coords = vector3(5292.7124023438,-5300.5048828125,33.582649230957),
        status = "nuexista",
        harvested = false
    },
    [166] = {
        coords = vector3(5299.1118164062,-5294.2661132812,33.693664550781),
        status = "nuexista",
        harvested = false
    },
    [167] = {
        coords = vector3(5307.6000976562,-5286.212890625,33.563045501709),
        status = "nuexista",
        harvested = false
    },
    [168] = {
        coords = vector3(5313.4887695312,-5280.7807617188,33.752288818359),
        status = "nuexista",
        harvested = false
    },
    [169] = {
        coords = vector3(5319.9970703125,-5274.2700195312,33.763687133789),
        status = "nuexista",
        harvested = false
    },
    [170] = {
        coords = vector3(5319.0415039062,-5271.7045898438,33.573406219482),
        status = "nuexista",
        harvested = false
    },
    [171] = {
        coords = vector3(5312.3852539062,-5278.5004882812,33.515735626221),
        status = "nuexista",
        harvested = false
    },
    [172] = {
        coords = vector3(5305.5546875,-5284.9536132812,33.331630706787),
        status = "nuexista",
        harvested = false
    },
    [173] = {
        coords = vector3(5299.1806640625,-5290.6137695312,33.291316986084),
        status = "nuexista",
        harvested = false
    },
    [174] = {
        coords = vector3(5292.17578125,-5297.60546875,33.306503295898),
        status = "nuexista",
        harvested = false
    },
    [175] = {
        coords = vector3(5290.611328125,-5295.4399414062,32.991241455078),
        status = "nuexista",
        harvested = false
    },
    [176] = {
        coords = vector3(5296.9663085938,-5289.3857421875,33.087379455566),
        status = "nuexista",
        harvested = false
    },
    [177] = {
        coords = vector3(5303.8989257812,-5282.8549804688,32.937721252441),
        status = "nuexista",
        harvested = false
    },
    [178] = {
        coords = vector3(5311.0395507812,-5276.3471679688,33.150856018066),
        status = "nuexista",
        harvested = false
    },
    [179] = {
        coords = vector3(5317.3305664062,-5270.2534179688,33.364944458008),
        status = "nuexista",
        harvested = false
    },
    [180] = {
        coords = vector3(5316.3374023438,-5267.8012695312,33.061168670654),
        status = "nuexista",
        harvested = false
    },
    [181] = {
        coords = vector3(5309.5454101562,-5274.3120117188,32.804370880127),
        status = "nuexista",
        harvested = false
    },
    [182] = {
        coords = vector3(5303.0083007812,-5280.609375,32.592407226562),
        status = "nuexista",
        harvested = false
    },
    [183] = {
        coords = vector3(5297.3857421875,-5285.9965820312,32.622074127197),
        status = "nuexista",
        harvested = false
    },
    [184] = {
        coords = vector3(5291.2641601562,-5291.8583984375,32.852676391602),
        status = "nuexista",
        harvested = false
    },
    [185] = {
        coords = vector3(5300.1953125,-5279.9487304688,32.318431854248),
        status = "nuexista",
        harvested = false
    },
    [186] = {
        coords = vector3(5308.7412109375,-5271.759765625,32.691932678223),
        status = "nuexista",
        harvested = false
    },
    [187] = {
        coords = vector3(5315.3002929688,-5265.564453125,32.905403137207),
        status = "nuexista",
        harvested = false
    },
}
