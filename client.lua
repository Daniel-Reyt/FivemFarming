ESX = exports['es_extended']:getSharedObject()
local table = {
    -- Pizza
    { x = 27.520882, y = -1355.419800, z = 29.330444, textInteract = "selling 1 Pizza", type = "sell", selling = { item = "pizza", qty = 1, money = 50 } },
    { x = 24.520882, y = -1355.419800, z = 29.330444, textInteract = "Farm 1 Pasta",    type = "farm", item = "pasta" },
    { x = 21.520882, y = -1355.419800, z = 29.330444, textInteract = "Farm 1 Fromage",  type = "farm", item = "cheese" },
    { x = 18.520882, y = -1355.419800, z = 29.330444, textInteract = "Farm 1 Tomate",   type = "farm", item = "tomato" },
    {
        x = 15.520882,
        y = -1355.419800,
        z = 29.330444,
        textInteract = "Preparing 1 pizza",
        type = "craft",
        crafting = { items = { { qty = 1, item = "cheese" }, { qty = 1, item = "tomato" }, { qty = 1, item = "pasta" } }, result = "pizza" },
    },
    -- WEED
    { x = 27.520882, y = -1358.419800, z = 29.330444, textInteract = "selling 1 joint",      type = "sell", selling = { item = "joint", qty = 1, money = 150 } },
    { x = 24.520882, y = -1358.419800, z = 29.330444, textInteract = "Farm 1 weed head",     type = "farm", item = "chanvre_head" },
    { x = 21.520882, y = -1358.419800, z = 29.330444, textInteract = "Farm 1 rolling paper", type = "farm", item = "rolling_paper" },
    {
        x = 18.520882,
        y = -1358.419800,
        z = 29.330444,
        textInteract = "Preparing 1 joint",
        type = "craft",
        crafting = { items = { { qty = 1, item = "chanvre_head" }, { qty = 1, item = "rolling_paper" } }, result = "joint" },
    },
    -- Coca
    { x = 27.520882, y = -1361.419800, z = 29.330444, textInteract = "selling 1 Cocaine traitée", type = "sell", selling = { item = "cocaine", qty = 1, money = 150 } },
    { x = 24.520882, y = -1361.419800, z = 29.330444, textInteract = "Farm 1 coca leaf",          type = "farm", item = "coca_leaf" },
    { x = 21.520882, y = -1361.419800, z = 29.330444, textInteract = "Farm 1 solvant",            type = "farm", item = "solvant" },
    {
        x = 18.520882,
        y = -1361.419800,
        z = 29.330444,
        textInteract = "Preparing 1 Cocaine traitée",
        type = "craft",
        crafting = { items = { { qty = 1, item = "coca_leaf" }, { qty = 1, item = "solvant" } }, result = "cocaine" },
    }
}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(table) do
            -- Draw Marker Here --
            if table[k].type == "sell" then
                DrawMarker(1, table[k].x, table[k].y, table[k].z - 1, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 255, 0,
                    200,
                    0,
                    0, 0, 0)
            elseif table[k].type == "farm" then
                DrawMarker(1, table[k].x, table[k].y, table[k].z - 1, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 116, 127,
                    196,
                    200,
                    0,
                    0, 0, 0)
            elseif table[k].type == "craft" then
                DrawMarker(1, table[k].x, table[k].y, table[k].z - 1, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 252, 186,
                    3,
                    200,
                    0,
                    0, 0, 0)
            end
        end
    end
end)

Citizen.CreateThread(function()
    local canFarm = true;
    while true do
        Citizen.Wait(0)

        for k in pairs(table) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist      = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, table[k].x, table[k].y, table[k].z)

            if dist <= 2.2 then
                if table[k].type == "sell" then
                    if IsControlJustPressed(1, 51) and canFarm then -- "E"
                        canFarm = false
                        exports['progressBars']:startUI(1000, table[k].textInteract)
                        Citizen.SetTimeout(1000, function()
                            canFarm = true
                            TriggerServerEvent('sell', (table[k].selling))
                        end)
                    end
                elseif table[k].type == "farm" then
                    if IsControlJustPressed(1, 51) and canFarm then -- "E"
                        canFarm = false
                        exports['progressBars']:startUI(500, table[k].textInteract)
                        Citizen.SetTimeout(1000, function()
                            canFarm = true
                            TriggerServerEvent('addItemForCraft', (table[k].item))
                        end)
                    end
                elseif table[k].type == "craft" then
                    if IsControlJustPressed(1, 51) and canFarm then -- "E"
                        canFarm = false
                        exports['progressBars']:startUI(500, table[k].textInteract)
                        Citizen.SetTimeout(1000, function()
                            canFarm = true
                            TriggerServerEvent('craft', (table[k].crafting))
                        end)
                    end
                end
            end
        end
    end
end)
