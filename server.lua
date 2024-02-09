local QBCore = exports['qb-core']:GetCoreObject()
result={

}
RegisterServerEvent("houss:deleteped")
AddEventHandler("houss:deleteped", function()
    TriggerClientEvent("houss:deleteped",-1)
end)
RegisterServerEvent("houss:clearsql")
AddEventHandler("houss:clearsql", function()
    MySQL.Async.execute([[
        DELETE FROM deal WHERE started=@x
    ]], {
        ['@x'] = "True",
    })
end)
RegisterServerEvent("houss:insertsql")
AddEventHandler("houss:insertsql", function(place)
    local players = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            players = players + 1
        end
	end
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local randItem = math.random(1,11)
    if (players > Config.minimumplayers)then
        MySQL.Async.execute([[
            INSERT deal
            (`place`, `started`, `gun`)
            VALUES
            (@place, @started, @gun)
        ]], {
            ['@place'] = place,
            ['@started'] = "True",
            ['@gun'] = Config.ItemTable[math.random(1,11)],
        })
    else
        MySQL.Async.execute([[
            INSERT deal
            (`place`, `started`, `gun`)
            VALUES
            (@place, @started, @gun)
        ]], {
            ['@place'] = place,
            ['@started'] = "True",
            ['@gun'] = Config.ItemTable[math.random(5,11)],
        })
    end
    
end)

QBCore.Functions.CreateCallback("houssem:callstate",function(source,cb)
    local results = MySQL.Sync.fetchAll([[
        SELECT place, started, gun
        FROM deal
    ]])
    for _, s in pairs(results) do
        table.insert(result, {
            place = s.place,
            started = s.started,
            gun = s.gun,
        })
    end
    cb(result[1])
end)
	
RegisterServerEvent("houssDeal:server:loot")
AddEventHandler("houssDeal:server:loot", function(gun)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(gun, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[gun], 'add')
end)

RegisterServerEvent("houss-RemoveMoney")
AddEventHandler("houss-RemoveMoney",function(amount)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    xPlayer.Functions.RemoveMoney('cash', amount)
end)

QBCore.Functions.CreateCallback("houss-getcash", function(source, cb)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    cb(xPlayer.PlayerData.money.cash)
end)