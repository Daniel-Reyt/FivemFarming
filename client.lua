ESX = exports['es_extended']:getSharedObject()
local table = {
    -- Legal
    -- Pizza
    { x = 26.281321,   y = -1301.367065, z = 29.195557, textInteract = "selling 1 Pizza", type = "sell", selling = { item = "pizza", qty = 1, money = 50 } },
    { x = 792.276917,  y = -735.613159,  z = 27.476929, textInteract = "Farm 1 Pasta",    type = "farm", item = "pasta" },
    { x = 2309.327393, y = 4885.595703,  z = 41.799316, textInteract = "Farm 1 Fromage",  type = "farm", item = "cheese" },
    { x = 1928.162598, y = 5099.907715,  z = 41.630737, textInteract = "Farm 1 Tomate",   type = "farm", item = "tomato" },
    {
        x = -297.230774,
        y = -1330.707642,
        z = 31.285034,
        textInteract = "Preparing 1 pizza",
        type = "craft",
        crafting = { items = { { qty = 1, item = "cheese" }, { qty = 1, item = "tomato" }, { qty = 1, item = "pasta" } }, result = "pizza" },
    },

    -- Ilegal
    -- WEED
    { x = -1174.259399, y = -1573.648315, z = 4.359009,  textInteract = "selling 1 joint",      type = "sell", selling = { item = "joint", qty = 1, money = 150 } },
    { x = 2220.712158,  y = 5582.505371,  z = 53.813232, textInteract = "Farm 1 weed head",     type = "farm", item = "chanvre_head" },
    { x = 101.050552,   y = -1115.670228, z = 29.296753, textInteract = "Farm 1 rolling paper", type = "farm", item = "rolling_paper" },
    {
        x = -82.958237,
        y = -1639.463745,
        z = 30.897461,
        textInteract = "Preparing 1 joint",
        type = "craft",
        crafting = { items = { { qty = 1, item = "chanvre_head" }, { qty = 1, item = "rolling_paper" } }, result = "joint" },
    },
    -- Coca
    { x = -3105.982422, y = 284.676910,   z = 8.958984,  textInteract = "selling 1 Cocaine traitée", type = "sell", selling = { item = "cocaine", qty = 1, money = 150 } },
    { x = 2911.147217,  y = 4492.694336,  z = 48.101074, textInteract = "Farm 1 coca leaf",          type = "farm", item = "coca_leaf" },
    { x = 913.397827,   y = -2174.663818, z = 30.493042, textInteract = "Farm 1 solvant",            type = "farm", item = "solvant" },
    {
        x = 1775.472534,
        y = -1617.507690,
        z = 112.366333,
        textInteract = "Preparing 1 Cocaine traitée",
        type = "craft",
        crafting = { items = { { qty = 1, item = "coca_leaf" }, { qty = 1, item = "solvant" } }, result = "cocaine" },
    },
    -- Shit
    { x = -290.571411, y = 2544.778076, z = 75.414673, textInteract = "selling 1 shit", type = "sell", selling = { item = "shit", qty = 1, money = 75 } },
    {
        x = 562.536255,
        y = -1752.290161,
        z = 29.313599,
        textInteract = "Preparing 1 shit",
        type = "craft",
        crafting = { items = { { qty = 1, item = "chanvre_head" } }, result = "shit" },
    },
}

local blips = {
    --farm
    { title = "Plantation de Weed",            type = "illegal", colour = 5, id = 616, x = 2220.712158,  y = 5582.505371,  z = 53.813232 },
    { title = "Papier a rouler",               type = "illegal", colour = 5, id = 616, x = 101.050552,   y = -1115.670228, z = 29.296753 },

    { title = "Plantation de Coca",            type = "illegal", colour = 5, id = 616, x = 2911.147217,  y = 4492.694336,  z = 48.101074 },
    { title = "Solvant",                       type = "illegal", colour = 5, id = 616, x = 913.397827,   y = -2174.663818, z = 30.493042 },

    { title = "Tomates",                       type = "farm",    colour = 5, id = 616, x = 1928.162598,  y = 5099.907715,  z = 41.630737 },
    { title = "Fromages",                      type = "farm",    colour = 5, id = 616, x = 2309.327393,  y = 4885.595703,  z = 41.799316 },
    { title = "Pâte a pizza",                  type = "farm",    colour = 5, id = 616, x = 792.276917,   y = -735.613159,  z = 27.476929 },

    --craft
    { title = "Production de Joint",           type = "illegal", colour = 5, id = 566, x = -82.958237,   y = -1639.463745, z = 30.897461 },
    { title = "Production de Cocaine traitée", type = "illegal", colour = 5, id = 566, x = 1775.472534,  y = -1617.507690, z = 112.366333 },
    { title = "Production de Shit",            type = "illegal", colour = 5, id = 566, x = 562.536255,   y = -1752.290161, z = 29.313599 },
    { title = "Production de Pizza",           type = "farm",    colour = 5, id = 566, x = -297.230774,  y = -1330.707642, z = 31.285034 },

    --sell
    { title = "Vente de Joint",                type = "illegal", colour = 5, id = 619, x = -1174.259399, y = -1573.648315, z = 4.359009 },
    { title = "Vente de Cocaine traitée",      type = "illegal", colour = 5, id = 619, x = -3105.982422, y = 284.676910,   z = 8.958984 },
    { title = "Vente de Shit",                 type = "illegal", colour = 5, id = 619, x = -290.571411,  y = 2544.778076,  z = 75.414673 },
    { title = "Vente de Pizza",                type = "sell",    colour = 5, id = 619, x = 26.281321,    y = -1301.367065, z = 29.195557 },

}


Citizen.CreateThread(function()
    local blipsAlreadyDrawn = false
    if not blipsAlreadyDrawn then
        for y, info in pairs(blips) do
            info.blip = AddBlipForCoord(info.x, info.y, info.z);
            SetBlipSprite(info.blip, info.id);
            SetBlipDisplay(info.blip, 4);
            SetBlipScale(info.blip, 1);
            SetBlipColour(info.blip, info.colour);
            SetBlipAsShortRange(info.blip, true);
            BeginTextCommandSetBlipName("STRING");
            AddTextComponentString(info.title);
            EndTextCommandSetBlipName(info.blip);
        end
        blipsAlreadyDrawn = true
    end
    while true do
        Citizen.Wait(0)
        for k in pairs(table) do
            -- Draw Marker Here --
            if table[k].type == "sell" then
                DrawMarker(1, table[k].x, table[k].y, table[k].z - 1, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 255,
                    0,
                    200,
                    0,
                    0, 0, 0)
            elseif table[k].type == "farm" then
                DrawMarker(1, table[k].x, table[k].y, table[k].z - 1, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 116,
                    127,
                    196,
                    200,
                    0,
                    0, 0, 0)
            elseif table[k].type == "craft" then
                DrawMarker(1, table[k].x, table[k].y, table[k].z - 1, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 252,
                    186,
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
