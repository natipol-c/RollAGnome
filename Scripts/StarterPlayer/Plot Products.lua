--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Plot Products
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Plot Products
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:40 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("CollectionService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
local u2 = Library.get("Products");
local u3 = u1(Players.LocalPlayer, "Plot");
local ProximityPrompt = script.ProximityPrompt;
local v4 = {};

local function gotPlot(p5) -- Line: 30
    -- upvalues: u1 (copy), u2 (copy), ProximityPrompt (copy)
    local v6 = u1(p5, "Products");
    local plotProducts = u2.products.plotProducts;
    local v7 = u1(u1(v6, "InstaGrow"), "Board");
    local v8 = u1(u1(u1(v7, "SurfaceGui"), "Price"), "PriceLabel");
    local price = plotProducts.growAll.price;

    if not price then
        repeat
            task.wait(0.1);
            price = plotProducts.growAll.price;
        until price ~= nil;
    end;

    v8.Text = price;
    local v9 = ProximityPrompt:Clone();
    v9.Parent = v7;
    v9.Triggered:Connect(function() -- Line: 53
        -- upvalues: u2 (ref), plotProducts (ref)
        u2.prompt(plotProducts.growAll.id, "product");
    end);
    local v10 = u1(u1(v6, "Skip24h"), "Board");
    local v11 = u1(u1(u1(v10, "SurfaceGui"), "Price"), "PriceLabel");
    local price2 = plotProducts.skip24h.price;

    if not price2 then
        repeat
            task.wait(0.1);
            price2 = plotProducts.skip24h.price;
        until price2 ~= nil;
    end;

    v11.Text = price2;
    local v12 = ProximityPrompt:Clone();
    v12.Parent = v10;
    v12.Triggered:Connect(function() -- Line: 75
        -- upvalues: u2 (ref), plotProducts (ref)
        u2.prompt(plotProducts.skip24h.id, "product");
    end);
    local v13 = u1(u1(v6, "Skip30m"), "Board");
    local v14 = u1(u1(u1(v13, "SurfaceGui"), "Price"), "PriceLabel");
    local price3 = plotProducts.skip30m.price;

    if not price3 then
        repeat
            task.wait(0.1);
            price3 = plotProducts.skip30m.price;
        until price3 ~= nil;
    end;

    v14.Text = price3;
    local v15 = ProximityPrompt:Clone();
    v15.Parent = v13;
    v15.Triggered:Connect(function() -- Line: 97
        -- upvalues: u2 (ref), plotProducts (ref)
        u2.prompt(plotProducts.skip30m.id, "product");
    end);
end;

function v4.Initialize(p16) -- Line: 103
    -- upvalues: u3 (copy), gotPlot (copy)
    if u3.Value then
        gotPlot(u3.Value);

        return;
    end;

    u3.Changed:Once(function() -- Line: 107
        -- upvalues: gotPlot (ref), u3 (ref)
        gotPlot(u3.Value);
    end);
end;

return v4;