--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Products
  Path:     game.ReplicatedStorage.Library.Products
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:30 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local MarketplaceService = game:GetService("MarketplaceService");
local Replication = require(game.ReplicatedStorage.Replication);
local u1 = nil;
local u2 = nil;
local u3 = false;
local u4 = require(game.ReplicatedStorage.Library).get("Network");
local u5 = {};
local LocalPlayer = Players.LocalPlayer;
local u6 = {
    gamepasses = {
        VIP = {
            id = 1931410966
        },
        ["Auto Roll"] = {
            id = 1933352578
        },
        ["Auto Sell"] = {
            id = 1932676882
        },
        ["Lucky Rolls"] = {
            id = 1931848932
        }
    },
    products = {
        skipFreeGnome = {
            id = 3613091839
        },
        restock = {
            id = 3610697692
        },
        itemShop = {
            ["Basic Sprinkler"] = {
                id = 3610745693,
                type = "Sprinkler"
            },
            ["Golden Sprinkler"] = {
                id = 3610745772,
                type = "Sprinkler"
            },
            Fertilizer = {
                id = 3610745789,
                type = "Fertilizer"
            },
            ["Good Fertilizer"] = {
                id = 3610745826,
                type = "Fertilizer"
            },
            ["Mutation Mister"] = {
                id = 3610745839,
                type = "Sprinkler"
            },
            ["Gnome Coffee"] = {
                id = 3610745852,
                type = "GnomeItem"
            },
            ["Basic Watering Can"] = {
                id = 3630881430,
                type = "WateringCan"
            },
            ["Gold Watering Can"] = {
                id = 3631005561,
                type = "WateringCan"
            }
        },
        serverLuck = {
            ["1"] = {
                before = "1x",
                text = "2x",
                id = 3612391771
            },
            ["2"] = {
                before = "2x",
                text = "4x",
                id = 3612391869
            },
            ["3"] = {
                before = "4x",
                text = "8x",
                id = 3612392016
            },
            ["4"] = {
                before = "8x",
                text = "MAX",
                id = 3612392064
            }
        },
        boosts = {
            ["2xMoney"] = {
                id = 3612421897,
                name = "2x Money"
            },
            ["2xLuck"] = {
                id = 3612421926,
                name = "2x Luck"
            },
            ["4xLuck"] = {
                id = 3612421995,
                name = "4x Luck"
            },
            ["2xGrowthSpeed"] = {
                id = 3612422016,
                name = "2x Growth Speed"
            }
        },
        gnomes = {
            ["Carrot Gnome"] = {
                id = 3610237012
            },
            ["Corn Gnome"] = {
                id = 3610237112
            },
            ["Strawberry Gnome"] = {
                id = 3610237219
            },
            ["Pumpkin Gnome"] = {
                id = 3610237260
            },
            ["Watermelon Gnome"] = {
                id = 3610237298
            },
            ["Pineapple Gnome"] = {
                id = 3610237331
            },
            ["Cherry Blossom Gnome"] = {
                id = 3610237382
            },
            ["Banana Gnome"] = {
                id = 3610237438
            },
            ["Coconut Gnome"] = {
                id = 3610237470
            },
            ["Mango Gnome"] = {
                id = 3610237502
            },
            ["Dragonfruit Gnome"] = {
                id = 3610237535
            },
            ["Pomegranate Gnome"] = {
                id = 3610237639
            },
            ["Starfruit Gnome"] = {
                id = 3610237690
            },
            ["Jackfruit Gnome"] = {
                id = 3610237898
            },
            ["Blood Orange Gnome"] = {
                id = 3610237928
            },
            ["Giant Avocado Gnome"] = {
                id = 3610237949
            },
            ["King Apple Gnome"] = {
                id = 3610237971
            },
            ["Giant Peach Gnome"] = {
                id = 3610238000
            },
            ["Ruby Pear Gnome"] = {
                id = 3610238036
            },
            ["Crystal Apple Gnome"] = {
                id = 3610238066
            },
            ["Frost Gnome"] = {
                id = 3610987407
            },
            ["Celestial Starfruit Gnome"] = {
                id = 3611969837
            },
            ["Ghost Gnome"] = {
                id = 3644303283
            },
            ["Comet Gnome"] = {
                id = 3644301078
            },
            ["Moon Gnome"] = {
                id = 3610238087
            },
            ["Rainbow Mango Gnome"] = {
                id = 3611969916
            },
            ["Shadow Gnome"] = {
                id = 3644310888
            },
            ["Eclipse Gnome"] = {
                id = 3644308399
            },
            ["Sun Gnome"] = {
                id = 3610260716
            },
            ["Celestial Peach Gnome"] = {
                id = 3610987657
            },
            ["Nebula Gnome"] = {
                id = 3644315591
            },
            ["Lightning Gnome"] = {
                id = 3626149150
            },
            ["Galaxy Gnome"] = {
                id = 3610987693
            }
        },
        plotProducts = {
            growAll = {
                id = 3611956959
            },
            skip24h = {
                id = 3611957231
            },
            skip30m = {
                id = 3652724057
            }
        },
        gifting = {
            VIP = {
                id = 3612425884
            },
            ["Auto Rolls"] = {
                id = 3612425934
            },
            ["Auto Sell"] = {
                id = 3612425965
            },
            ["Lucky Rolls"] = {
                id = 3612426065
            }
        },
        rebirth = { 3624464734 },
        weeklyDeal = {
            Deal1 = {
                id = 3701712507
            },
            Deal2 = {
                id = 3708226630
            }
        }
    },
    bypass = {
        [157086476] = true,
        [63311152] = true
    }
};

function u6.check(u7, p8) -- Line: 138
    -- upvalues: LocalPlayer (copy), u6 (copy), RunService (copy), u3 (ref), u1 (ref), u2 (ref), Replication (copy), MarketplaceService (copy)
    local u9 = p8 or LocalPlayer;
    local success, result = pcall(function() -- Line: 140
        -- upvalues: u6 (ref), u7 (copy), RunService (ref), u3 (ref), u1 (ref), u2 (ref), u9 (ref), Replication (ref), MarketplaceService (ref)
        local v10 = u6.gamepasses[u7];

        if v10 then
            local id = v10.id;
            local v11;

            if RunService:IsServer() then
                if not u3 then
                    u3 = true;
                    u1 = require(game.ServerStorage.ServerLibrary);
                    u2 = u1.get("Data");
                end;

                v11 = u2.get(u9);

                if not v11 then
                    repeat
                        RunService.Heartbeat:Wait();
                        v11 = u2.get(u9);
                    until v11 ~= nil;
                end;
            else
                v11 = Replication.Data;
            end;

            local v12 = v11.gifting or {};
            local v13 = u6.bypass[u9 and u9.UserId] or v12[u7];

            if not v13 then
                v13 = MarketplaceService:UserOwnsGamePassAsync(u9 and u9.UserId, id);
            end;

            return v13;
        end;
    end);

    if success then
        return result;
    end;
end;

function u6.getInfo(u14, u15) -- Line: 170
    -- upvalues: MarketplaceService (copy)
    local success, result = pcall(function() -- Line: 171
        -- upvalues: MarketplaceService (ref), u14 (copy), u15 (copy)
        local v16 = u15 == "product" and Enum.InfoType.Product;

        if not v16 then
            if u15 == "gamepass" then
                v16 = Enum.InfoType.GamePass;
            else
                v16 = false;
            end;
        end;

        local v17 = MarketplaceService:GetProductInfo(u14, v16);

        if v17 then
            return v17;
        end;
    end);

    if success then
        return result;
    end;

    warn(u14, u15, "|", result);
end;

function u6.getGamepassFromId(u18) -- Line: 183
    -- upvalues: u6 (copy)
    local success, result = pcall(function() -- Line: 184
        -- upvalues: u6 (ref), u18 (copy)
        for i, v in next, u6.gamepasses do
            if v.id == u18 then
                return i;
            end;
        end;
    end);

    if success then
        return result;
    end;

    warn("[Get Gamepass From Id]: " .. result);
end;

function u6.prompt(p19, p20) -- Line: 201
    -- upvalues: u5 (copy), u6 (copy), MarketplaceService (copy), LocalPlayer (copy), RunService (copy), u4 (copy)
    if not (p19 and p20) then
        return;
    end;

    if u5.gamepass then
        u5.gamepass:Disconnect();
        u5.gamepass = nil;
    end;

    if u5.product then
        u5.product:Disconnect();
        u5.product = nil;
    end;

    if p20 == "gamepass" then
        if not u6.gamepasses[p19] then
            error("There is no gamepass named", p19);

            return;
        end;

        MarketplaceService:PromptGamePassPurchase(LocalPlayer, u6.gamepasses[p19].id);

        if RunService:IsClient() then
            _G.Loading.Prompt(true, true);
            u5.gamepass = MarketplaceService.PromptGamePassPurchaseFinished:Connect(function() -- Line: 219
                -- upvalues: u5 (ref), u4 (ref)
                _G.Loading.Prompt(false);
                u5.gamepass:Disconnect();
                u5.gamepass = nil;
                u4:FireServer("LogPromptPurchase", {
                    Close = true
                });
            end);
        end;
    elseif p20 == "product" then
        MarketplaceService:PromptProductPurchase(LocalPlayer, p19);

        if RunService:IsClient() then
            _G.Loading.Prompt(true, true);
            u5.product = MarketplaceService.PromptProductPurchaseFinished:Connect(function() -- Line: 238
                -- upvalues: u5 (ref), u4 (ref)
                _G.Loading.Prompt(false);
                u5.product:Disconnect();
                u5.product = nil;
                u4:FireServer("LogPromptPurchase", {
                    Close = true
                });
            end);
        end;
    end;
end;

function u6.setItemPrices(u21) -- Line: 251
    -- upvalues: u6 (copy)
    task.spawn(function() -- Line: 252
        -- upvalues: u6 (ref), u21 (copy)
        local _, _ = pcall(function() -- Line: 253
            -- upvalues: u6 (ref), u21 (ref)
            local products = u6.products;
            local itemShop = products.itemShop;

            if not itemShop then
                return;
            end;

            task.spawn(function() -- Line: 259
                -- upvalues: itemShop (copy), u21 (ref), products (copy)
                for i, v in next, itemShop do
                    local v22 = u21.getInfo(v.id, "product");

                    if not v22 then
                        return;
                    end;

                    products.itemShop[i].price = v22.IsForSale and v22.PriceInRobux or "ERR";
                end;
            end);
            local plotProducts = products.plotProducts;

            if not plotProducts then
                return;
            end;

            task.spawn(function() -- Line: 273
                -- upvalues: plotProducts (copy), u21 (ref), products (copy)
                for i, v in next, plotProducts do
                    local id = v.id;

                    if id then
                        local v23 = u21.getInfo(id, "product");

                        if not v23 then
                            return;
                        end;

                        products.plotProducts[i].price = v23.IsForSale and v23.PriceInRobux or "ERR";
                    end;
                end;
            end);
            local boosts = products.boosts;

            if not boosts then
                return;
            end;

            task.spawn(function() -- Line: 288
                -- upvalues: boosts (copy), u21 (ref), products (copy)
                for i, v in next, boosts do
                    local id = v.id;

                    if id then
                        local v24 = u21.getInfo(id, "product");

                        if not v24 then
                            return;
                        end;

                        products.boosts[i].price = v24.IsForSale and v24.PriceInRobux or "ERR";
                    end;
                end;
            end);
            local serverLuck = products.serverLuck;

            if not serverLuck then
                return;
            end;

            task.spawn(function() -- Line: 303
                -- upvalues: serverLuck (copy), u21 (ref), products (copy)
                for i, v in next, serverLuck do
                    local id = v.id;

                    if id then
                        local v25 = u21.getInfo(id, "product");

                        if not v25 then
                            return;
                        end;

                        products.serverLuck[i].price = v25.IsForSale and v25.PriceInRobux or "ERR";
                    end;
                end;
            end);
            local weeklyDeal = products.weeklyDeal;

            if weeklyDeal then
                task.spawn(function() -- Line: 317
                    -- upvalues: weeklyDeal (copy), u21 (ref), products (copy)
                    for i, v in next, weeklyDeal do
                        local id = v.id;

                        if id then
                            local v26 = u21.getInfo(id, "product");

                            if not v26 then
                                return;
                            end;

                            products.weeklyDeal[i].price = v26.IsForSale and v26.PriceInRobux or "ERR";
                        end;
                    end;
                end);
            end;

            local gamepasses = u6.gamepasses;

            if not gamepasses then
                return;
            end;

            task.spawn(function() -- Line: 333
                -- upvalues: gamepasses (copy), u21 (ref)
                for i, v in next, gamepasses do
                    local id = v.id;

                    if id then
                        local v27 = u21.getInfo(id, "gamepass");

                        if v27 then
                            gamepasses[i].price = v27.IsForSale and v27.PriceInRobux or "ERR";
                        end;
                    end;
                end;
            end);
        end);
    end);
end;

function u6.Initialize(u28) -- Line: 348
    -- upvalues: u4 (copy)
    u28:setItemPrices();
    u4:BindEvents({
        PromptProduct = function(p29) -- Line: 352
            -- upvalues: u28 (copy)
            u28.prompt(p29, "gamepass");
        end
    });
end;

return u6;