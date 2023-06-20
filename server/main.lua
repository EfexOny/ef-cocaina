RegisterNetEvent("ef-cocaina:server:harvest")
AddEventHandler("ef-cocaina:server:harvest",function() 
    local ply = QBCore.Functions.GetPlayer(source)

    ply.Functions.AddItem("momeala", 1)


end)