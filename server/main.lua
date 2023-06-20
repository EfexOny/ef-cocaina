RegisterNetEvent("ef-cocaina:server:harvest")
AddEventHandler("ef-cocaina:server:harvest",function() 
    local ply = QBCore.Functions.GetPlayer(source)

    ply.Functions.AddItem("planta coca", 1)


end)