ESX = exports['es_extended']:getSharedObject()
RegisterCommand("logpos", function(source)
    local source = source
    local ped = GetPlayerPed(source);
    local playerCoords = GetEntityCoords(ped)

    print(playerCoords)
end, true)
RegisterServerEvent("sell")
AddEventHandler("sell", function(selling)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.canCarryItem('money', selling.money) then
        local pizza = xPlayer.hasItem(selling.item)
        if pizza.count > 0 then
            xPlayer.removeInventoryItem(selling.item, selling.qty)
            xPlayer.addInventoryItem('money', selling.money)
        else
            xPlayer.showNotification("vous n'avez plus de " .. selling.item)
        end
    else
        xPlayer.showNotification("vous ne pouvez plus porter d'item")
    end
end)

RegisterServerEvent("addItemForCraft")
AddEventHandler("addItemForCraft", function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.canCarryItem(item, 1) then
        xPlayer.addInventoryItem(item, 1)
    else
        xPlayer.showNotification("vous ne pouvez plus porter d'item")
    end
end)

RegisterServerEvent("craft")
AddEventHandler("craft", function(crafting)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.canCarryItem(crafting.result, 1) then
        local canCraft = false;
        for k in pairs(crafting.items) do
            local item = xPlayer.hasItem(crafting.items[k].item)
            if item.count >= crafting.items[k].qty then
                canCraft = true
            else
                xPlayer.showNotification("Vous n'avez pas tout les items")
            end
        end
        if canCraft then
            for y in pairs(crafting.items) do
                xPlayer.removeInventoryItem(crafting.items[y].item, crafting.items[y].qty)
            end
            xPlayer.addInventoryItem(crafting.result, 1)
        end
    else
        xPlayer.showNotification("vous ne pouvez plus porter d'item")
    end
end)
