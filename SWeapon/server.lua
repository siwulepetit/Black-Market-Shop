 ESX = nil

 TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
 
 RegisterNetEvent('achatarme')
 AddEventHandler('achatarme', function(name, price, item)
     local xPlayer = ESX.GetPlayerFromId(source)
     local xMoney = xPlayer.getAccount('black_money').money
     if xMoney >= price then
         xPlayer.removeAccountMoney('black_money', price)
         if item then
             xPlayer.addInventoryItem(name, 1)
         else
             xPlayer.addWeapon(name, 200)
         end
         TriggerClientEvent('esx:showNotification', source, "Vous avez payé ~r~"..price.."$")
     else
         TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent sale")
     end
 end)
 