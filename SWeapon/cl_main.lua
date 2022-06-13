 Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(5000)
    end
end)

local mainMenu = RageUI.CreateMenu("", "Magasin d'arme", "1350", "50")
local open = false

mainMenu.Closed = function() open = false end 

function WeaponMarket()
    if not open then open = true RageUI.Visible(mainMenu, true)
        Citizen.CreateThread(function()
            while open do 
                RageUI.IsVisible(mainMenu, function()
                    for k,v in pairs(Config.WeaponMarket.List) do
                        RageUI.Button(v.label, nil, {RightLabel = "~g~"..v.price.."$"}, true, {
                            onSelected = function()
                                name = v.name
                                price = v.price
                                item = v.item
                                TriggerServerEvent('achatarme', name, price, item)
                            end
                        })
                    end
                end)
            Wait(0)
            end
        end)
    end
end


Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k,v in pairs(Config.WeaponMarket.Ped.Pos) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.x, v.y, v.z)
            if dist <= 1.5 then
                wait = 1
                ESX.ShowHelpNotification("Appuyer sur ~INPUT_CONTEXT~ pour ouvrir le ~p~Magasin d'arme")
                if IsControlJustPressed(1,51) then WeaponMarket() end
            end 
        end
    Citizen.Wait(wait)
    end
end)

Citizen.CreateThread(function()
    for k,v in pairs(Config.WeaponMarket.Ped.Pos) do
        local hash = GetHashKey(Config.WeaponMarket.Ped.Type)
        while not HasModelLoaded(hash) do RequestModel(hash) Wait(20) end
        local ped = CreatePed("PED_TYPE_CIVFEMALE", Config.WeaponMarket.Ped.Type, v.x, v.y, v.z, v.h, false, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
    end
end)