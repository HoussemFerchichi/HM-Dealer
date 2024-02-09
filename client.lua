local QBCore = exports['qb-core']:GetCoreObject()
local display = false
local function CalculateTimeToDisplay()
    local hour = GetClockHours()
    local minute = GetClockMinutes()
    local obj = {}
	if minute <= 9 then
		minute = "0" .. minute
    end
    obj.hour = hour
    obj.minute = minute
    return obj
end
local gun=""
local ss = 0
local lanced = false
Citizen.CreateThread(function()
    while (true)do
        if (CalculateTimeToDisplay().hour == Config.starttime) and (not lanced)then
            ss = math.random(1,5)
            print(ss)
            TriggerServerEvent("houss:clearsql")
            TriggerServerEvent("houss:insertsql",ss)
            TriggerEvent("yoo")
            lanced = true
        end
        if (CalculateTimeToDisplay().hour == Config.starttime + 1) and (lanced)then
            lanced = false
        end
        Wait(1000)
    end
end)

AddEventHandler('yoo', function()
    TriggerEvent("qb-phone:client:GetCalled",math.random(1,1000000),math.random(1,1000000),true)
    Wait(5000)
    local incall = false
    local can = true
    local can2=true
    local played = false
    CreateThread(function()
        while can do
            QBCore.Functions.TriggerCallback('qb-phone:houssem:callstate', function(test)
                incall = test -- callback returns either the player is in call or not
                if (incall == true)then
                    can2=false
                end
                if (incall == false) and(can2==false)then --what to do when a phone call ends
                    can = false
                end
            end)
            Wait(5000)
            if (incall) and (played == false)then
                QBCore.Functions.TriggerCallback('houssem:callstate', function(result)
                    if (result.place == 1)then
                        TriggerEvent("InteractSound_CL:PlayOnOne","chopshop",1.0)
                    elseif(result.place == 2)then
                        TriggerEvent("InteractSound_CL:PlayOnOne","Matar",1.0)
                    elseif(result.place == 3)then
                        TriggerEvent("InteractSound_CL:PlayOnOne","port",1.0)
                    elseif(result.place == 4)then
                        TriggerEvent("InteractSound_CL:PlayOnOne","casino",1.0)
                    elseif(result.place == 5)then
                        TriggerEvent("InteractSound_CL:PlayOnOne","manege",1.0)
                    end
                end)
                played = true
                Wait(10000)
                Start()
                Wait(1000*60*Config.Waitminutes)
                TriggerEvent("houss:deleteped")
                lanced = false
            end
        end
    end)
end)
Citizen.CreateThread(function()
    modelHash = GetHashKey(Config.PedModelToSpawn)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(1)
    end
  end)

RegisterNetEvent('houss:deleteped')
 AddEventHandler('houss:deleteped', function()
    if (created_ped ~= nil)then
        ClearPedTasks(created_ped)
        DeletePed(created_ped)
        incall = false
        can = true
        can2=true
        played = false
        display = false
    end
end)
RegisterNetEvent('houss:start')
 AddEventHandler('houss:start', function()
    SetDisplay(not display)
end)
RegisterNetEvent('houss:start2')
 AddEventHandler('houss:start2', function()
    TriggerServerEvent("houss:deleteped",created_ped)
end)




function Start()
    TriggerEvent('qb-phone:client:CancelCall')
    local created = false
    Citizen.CreateThread(function()
        while not created do
            Wait(10)
            ped = GetPlayerPed(-1)
            pos = GetEntityCoords(ped, true)
            QBCore.Functions.TriggerCallback('houssem:callstate', function(result)
                results = result
                created_ped = CreatePed(0, modelHash , Config.PlaceToChoose[results.place].x,Config.PlaceToChoose[results.place].y,Config.PlaceToChoose[results.place].z - 1, 0, false)
                FreezeEntityPosition(created_ped, true)
                SetEntityInvincible(created_ped, true)
                SetBlockingOfNonTemporaryEvents(created_ped, true)
                TaskStartScenarioInPlace(created_ped, "WORLD_HUMAN_COP_IDLES", 0, true)
                gun = results.gun
                created = true
                exports["qb-target"]:AddCircleZone("capitulate", Config.PlaceToChoose[results.place], 1.0, {
                    name = "Echri men 3and zebi",
                    useZ = true,
                    }, {
                        options = {
                            {
                                event = "houss:start",
                                icon = "fas fa-bomb",
                                label = "Hez zabourom sle7",
                            },
                        },
                        job = {"all"},
                        distance = 2.1
                    })
                end)
                break
            Wait(Config.waittime*1000)
            if (created_ped ~= nil)then
                TriggerEvent("houss:start2")
            end
            
        end
    end)
end


------- UI ------
RegisterNUICallback("exit", function()
    SetDisplay(false)
end)
--xPlayer.Functions.RemoveMoney('cash', amount)
RegisterNUICallback("main", function(data)
    if (data.text == "a")then
        QBCore.Functions.TriggerCallback("houss-getcash", function(money)
            if (gun == "weapon_snspistol")then
                local x = Config.HeavyweaponMoney
                if (money > x)then
                    TriggerServerEvent("houss-RemoveMoney",x)
                    TriggerServerEvent("houssDeal:server:loot",gun)
                    TriggerServerEvent("houss:deleteped")
                else
                    QBCore.Functions.Notify("Not Enough Money","error")
                end
            elseif(gun == "weapon_pistol_mk2")then
                local x = Config.HeavyweaponMoney
                if (money > x)then
                    TriggerServerEvent("houss-RemoveMoney",x)
                    TriggerServerEvent("houssDeal:server:loot",gun)
                    TriggerServerEvent("houss:deleteped")
                else
                    QBCore.Functions.Notify("Not Enough Money","error")
                end
            elseif(gun == "weapon_bat")then
                local x = Config.LightweaponMoney
                if (money > x)then
                    TriggerServerEvent("houss-RemoveMoney",x)
                    TriggerServerEvent("houssDeal:server:loot",gun)
                    TriggerServerEvent("houss:deleteped")
                else
                    QBCore.Functions.Notify("Not Enough Money","error")
                end
            elseif(gun == "weapon_switchblade")then
                local x = Config.LightweaponMoney
                if (money > x)then
                    TriggerServerEvent("houss-RemoveMoney",x)
                    TriggerServerEvent("houssDeal:server:loot",gun)
                    TriggerServerEvent("houss:deleteped")
                else
                    QBCore.Functions.Notify("Not Enough Money","error")
                end
            elseif(gun == "weapon_knife")then
                local x = Config.LightweaponMoney
                if (money > x)then
                    TriggerServerEvent("houss-RemoveMoney",x)
                    TriggerServerEvent("houssDeal:server:loot",gun)
                    TriggerServerEvent("houss:deleteped")
                else
                    QBCore.Functions.Notify("Not Enough Money","error")
                end
            elseif(gun == "weapon_bottle")then
                local x = Config.LightweaponMoney
                if (money > x)then
                    TriggerServerEvent("houss-RemoveMoney",x)
                    TriggerServerEvent("houssDeal:server:loot",gun)
                    TriggerServerEvent("houss:deleteped")
                else
                    QBCore.Functions.Notify("Not Enough Money","error")
                end
            elseif(gun == "weapon_crowbar")then
                local x = Config.LightweaponMoney
                if (money > x)then
                    TriggerServerEvent("houss-RemoveMoney",x)
                    TriggerServerEvent("houssDeal:server:loot",gun)
                    TriggerServerEvent("houss:deleteped")
                else
                    QBCore.Functions.Notify("Not Enough Money","error")
                end
            elseif(gun == "weapon_knuckle")then
                local x = Config.LightweaponMoney
                if (money > x)then
                    TriggerServerEvent("houss-RemoveMoney",x)
                    TriggerServerEvent("houssDeal:server:loot",gun)
                    TriggerServerEvent("houss:deleteped")
                else
                    QBCore.Functions.Notify("Not Enough Money","error")
                end
            elseif(gun == "weapon_machete")then
                local x = Config.LightweaponMoney
                if (money > x)then
                    TriggerServerEvent("houss-RemoveMoney",x)
                    TriggerServerEvent("houssDeal:server:loot",gun)
                    TriggerServerEvent("houss:deleteped")
                else
                    QBCore.Functions.Notify("Not Enough Money","error")
                end
            end
        end)
    end
    SetDisplay(false)
end)

RegisterNUICallback("error", function(data)
    print(data.error)
    SetDisplay(false)
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
        gun = ".//images/".. gun..".png",
    })
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display)
        DisableControlAction(0, 2, display)
        DisableControlAction(0, 142, display)
        DisableControlAction(0, 18, display)
        DisableControlAction(0, 322, display)
        DisableControlAction(0, 106, display)
    end
end)