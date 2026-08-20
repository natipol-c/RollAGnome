--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ItemShop
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Tabs.ItemShop
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:08 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Replication);
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
local u2 = Library.get("Network");
local u3 = Library.get("Numbers");
local u4 = Library.get("Products");
local u5 = Library.get("Signal");
local u6 = Library.get("SimpleTween");
local u7 = Library.get("Rarities");
local u8 = Library.get("Fertilizer");
local u9 = Library.get("GnomeItems");
local u10 = Library.get("ItemShop");
local u11 = Library.get("Sprinklers");
local u12 = Library.get("WateringCans");
local _ = ReplicatedStorage.Assets;
local _ = Players.LocalPlayer;
local v13 = {};
local u14 = {};
local u15 = {};
local Template = script.Template;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = nil;
local u21 = nil;
local u22 = nil;
local u23 = false;
local u24 = nil;
local u25 = nil;

local function fireStockUpdate() -- Line: 50
    -- upvalues: u15 (copy), u14 (ref)
    for _, v in u15 do
        task.spawn(v, u14);
    end;
end;

local function fetchStock() -- Line: 56
    -- upvalues: u2 (copy), u14 (ref), u15 (copy)
    local success, result = pcall(function() -- Line: 57
        -- upvalues: u2 (ref)
        return u2:InvokeServer("GetStock");
    end);

    if not (success and result) then
        return {};
    end;

    u14 = result;

    for _, v in u15 do
        task.spawn(v, u14);
    end;

    return u14;
end;

local function purchase(u26) -- Line: 71
    -- upvalues: u2 (copy), fetchStock (copy)
    if not u26 then
        return false, "Something went wrong, try again! (1)";
    end;

    local v27, v28, v29 = pcall(function() -- Line: 74
        -- upvalues: u2 (ref), u26 (copy)
        return u2:InvokeServer("Purchase", u26);
    end);
    task.defer(fetchStock);

    if v27 then
        return v28, v29;
    end;

    return false, "Something went wrong, try again! (2)";
end;

local function secondsUntilRestock() -- Line: 88
    -- upvalues: u2 (copy)
    local success, result = pcall(function() -- Line: 89
        -- upvalues: u2 (ref)
        return u2:InvokeServer("GetSecondsLeft");
    end);

    return not success and 0 or result;
end;

local function onStockUpdate(p30) -- Line: 100
    -- upvalues: u15 (copy)
    table.insert(u15, p30);
end;

local function getItemStock(p31, p32) -- Line: 104
    -- upvalues: u14 (ref)
    return p32 and p32.AlwaysAvailable and 1 or (u14[p31] or 0);
end;

local function updateBuyOptions() -- Line: 114
    -- upvalues: u24 (ref), u10 (copy), u1 (copy), u22 (ref), u14 (ref)
    if not u24 then
        return;
    end;

    local v33 = u10.Items[u24];

    if not v33 then
        return;
    end;

    local v34 = u1(u1(u1(u22, "Buttons"), "Buy"), "Frame");
    local v35 = v33 and v33.AlwaysAvailable and 1 or (u14[u24] or 0);
    local v36;

    if v34 then
        v36 = v34:FindFirstChild("Overlay");
    else
        v36 = v34;
    end;

    if v34 then
        v34 = v34:FindFirstChild("UIGradient");
    end;

    if v36 then
        v36.Visible = v35 == 0;
    end;

    if v34 then
        v34.Color = v35 == 0 and ColorSequence.new(Color3.fromRGB(136, 136, 136), Color3.fromRGB(88, 88, 88)) or ColorSequence.new(Color3.fromRGB(14, 209, 0), Color3.fromRGB(10, 145, 0));
    end;
end;

local function tweenToTop(u37) -- Line: 137
    -- upvalues: u19 (ref), RunService (copy), u25 (ref), u6 (copy)
    if not (u37 and u19) then
        return;
    end;

    task.defer(function() -- Line: 140
        -- upvalues: RunService (ref), u37 (copy), u19 (ref), u25 (ref), u6 (ref)
        RunService.Heartbeat:Wait();

        if not (u37.Parent and u19.Parent) then
            return;
        end;

        local v38 = u37.AbsolutePosition.Y - u19.AbsolutePosition.Y + u19.CanvasPosition.Y;
        local v39 = math.max(0, u19.AbsoluteCanvasSize.Y - u19.AbsoluteWindowSize.Y);
        local v40 = math.clamp(v38, 0, v39);

        if u25 then
            u25:Cancel();
            u25 = nil;
        end;

        u25 = u6:Tween(u19, 0.25, "Quad", "Out", {
            CanvasPosition = Vector2.new(u19.CanvasPosition.X, v40)
        });
    end);
end;

local function displayPrices(p41, p42) -- Line: 160
    -- upvalues: u24 (ref), u22 (ref), u1 (copy), u3 (copy), updateBuyOptions (copy), u4 (copy), u19 (ref), RunService (copy), u25 (ref), u6 (copy)
    if u24 == p41 then
        u24 = nil;
        u22.Visible = false;

        return;
    end;

    u24 = p41;
    local v43 = u1(u22, "Buttons");
    u1(u1(v43, "Buy"), "Frame").Label.Text = "$" .. u3.getAmount(p42.price);
    updateBuyOptions();
    local v44 = u4.products.itemShop[p41];

    if not v44.price then
        repeat
            task.wait(0.1);
        until v44.price;
    end;

    u1(u1(v43, "Robux"), "Frame").PriceLabel.Text = u3.Comma(v44.price);
    local u45 = u1(u19, p41);
    u22.LayoutOrder = u45.LayoutOrder + 1;
    u22.Visible = true;
    u22.Parent = u19;

    if u45 then
        if not u19 then
            return;
        end;

        task.defer(function() -- Line: 140
            -- upvalues: RunService (ref), u45 (copy), u19 (ref), u25 (ref), u6 (ref)
            RunService.Heartbeat:Wait();

            if not (u45.Parent and u19.Parent) then
                return;
            end;

            local v46 = u45.AbsolutePosition.Y - u19.AbsolutePosition.Y + u19.CanvasPosition.Y;
            local v47 = math.max(0, u19.AbsoluteCanvasSize.Y - u19.AbsoluteWindowSize.Y);
            local v48 = math.clamp(v46, 0, v47);

            if u25 then
                u25:Cancel();
                u25 = nil;
            end;

            u25 = u6:Tween(u19, 0.25, "Quad", "Out", {
                CanvasPosition = Vector2.new(u19.CanvasPosition.X, v48)
            });
        end);
    end;
end;

local function open() -- Line: 199
    -- upvalues: u23 (ref), u19 (ref)
    if not u23 then
        u23 = true;
        u19.ScrollBarThickness = workspace.CurrentCamera.ViewportSize.X * (u19.ScrollBarThickness / 2200);
    end;
end;

local function close() -- Line: 214
    -- upvalues: u5 (copy)
    u5.Fire("ClosedItemShop");
end;

function v13.Start(p49, p50) -- Line: 218
    -- upvalues: u16 (ref), u17 (ref), u1 (copy), u18 (ref), u19 (ref), u20 (ref), u21 (ref), u22 (ref), u10 (copy), u11 (copy), u8 (copy), u9 (copy), u12 (copy), Template (copy), u3 (copy), u7 (copy), u24 (ref), updateBuyOptions (copy), u15 (copy), displayPrices (copy), u14 (ref), u2 (copy), fetchStock (copy), u4 (copy), ReplicatedStorage (copy), u5 (copy), u23 (ref)
    u16 = p50;
    u17 = u1(u16, "Menu");
    u18 = u1(u17, "Frame");
    u19 = u1(u18, "List");
    u20 = u1(u17, "Title");
    u21 = u1(u20, "Restock");
    u22 = u1(u19, "BuyOptions");
    local u51 = false;

    for i, v in next, u10.Items do
        local v52 = v.type == "Sprinkler" and u11[i] or (v.type == "Fertilizer" and u8[i] or v.type == "GnomeItem" and u9[i]);

        if not v52 then
            if v.type == "WateringCan" then
                v52 = u12[i];
            else
                v52 = false;
            end;
        end;

        if not v.ignore then
            local v53 = Template:Clone();
            v53.Name = i;
            local Frame = v53.Frame;
            Frame.Title.Text = v.name or i;
            Frame.Clipped.Icon.Image = v52.icon or "";
            Frame.Desc.Text = v.desc or "";
            Frame.Price.Text = u3.getAmount(v.price) .. "$";
            u7:SetLabel(v.rarity, Frame.Rarity);
            v53.LayoutOrder = v.order * 2;
            v53.Parent = u19;
            table.insert(u15, function(p54) -- Line: 251
                -- upvalues: i (copy), v (copy), Frame (copy), u24 (ref), updateBuyOptions (ref)
                local v55 = p54[i] or 0;

                if v.AlwaysAvailable then
                    Frame.Stock.Text = "∞ in stock";
                    v55 = 1;
                else
                    Frame.Stock.Text = `{v55} in stock`;
                end;

                if v55 == 0 then
                    Frame.Stock.Text = "Out of stock";
                end;

                Frame.Stock.TextColor3 = v55 > 0 and Color3.fromRGB(225, 225, 225) or Color3.fromRGB(255, 0, 0);

                if u24 == i then
                    updateBuyOptions();
                end;
            end);
            u1(v53, "Button").MouseButton1Click:Connect(function() -- Line: 274
                -- upvalues: u51 (ref), displayPrices (ref), i (copy), v (copy)
                if u51 then
                    return;
                end;

                u51 = true;
                displayPrices(i, v);
                task.wait(0.2);
                u51 = false;
            end);
        end;
    end;

    local v56 = u1(u22, "Buttons");
    local v57 = u1(v56, "Buy");
    local v58 = u1(v56, "Robux");
    local v59 = u1(v57, "Button");
    local u60 = false;
    v59.MouseButton1Click:Connect(function() -- Line: 295
        -- upvalues: u60 (ref), u24 (ref), u10 (ref), u14 (ref), u2 (ref), fetchStock (ref)
        if u60 then
            return;
        end;

        u60 = true;

        if not u24 then
            u60 = false;

            return;
        end;

        local v61 = u10.Items[u24];

        if (v61 and v61.AlwaysAvailable and 1 or (u14[u24] or 0)) <= 0 then
            u60 = false;

            return;
        end;

        local u62 = u24;
        local v63;

        if u62 then
            local v64, v65;
            v64, v63, v65 = pcall(function() -- Line: 74
                -- upvalues: u2 (ref), u62 (copy)
                return u2:InvokeServer("Purchase", u62);
            end);
            task.defer(fetchStock);

            if not v64 then
                v63 = false;
            end;
        else
            v63 = false;
        end;

        if v63 then
            _G.Play("Purchase");
        end;

        task.wait(0.2);
        u60 = false;
    end);
    local v66 = u1(v58, "Button");
    local u67 = false;
    v66.MouseButton1Click:Connect(function() -- Line: 322
        -- upvalues: u67 (ref), u24 (ref), u4 (ref)
        if u67 then
            return;
        end;

        u67 = true;

        if not u24 then
            u67 = false;

            return;
        end;

        u4.prompt(u4.products.itemShop[u24].id, "product");
        task.wait(0.2);
        u67 = false;
    end);
    fetchStock();
    u2:BindEvents({
        StockUpdated = function(p68) -- Line: 339, Name: StockUpdated
            -- upvalues: u14 (ref), u15 (ref)
            for i, v in p68 do
                u14[i] = v;
            end;

            for _, v in u15 do
                task.spawn(v, u14);
            end;
        end
    });
    u1(u21, "Button").MouseButton1Click:Connect(function() -- Line: 351
        -- upvalues: u4 (ref)
        u4.prompt(u4.products.restock.id, "product");
    end);
    ReplicatedStorage:GetAttributeChangedSignal("RestockSecondsLeft"):Connect(function() -- Line: 356
        -- upvalues: ReplicatedStorage (ref), u17 (ref), u3 (ref)
        local v69 = ReplicatedStorage:GetAttribute("RestockSecondsLeft");

        if v69 <= 0 then
            u17.Restock.Text = "Restocking...";

            return;
        end;

        u17.Restock.Text = "Restocks in: " .. u3.formatSemicolonTime(v69);
    end);
    u16:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 366
        -- upvalues: u16 (ref), u5 (ref), u23 (ref), u19 (ref)
        if u16.Enabled then
            if not u23 then
                u23 = true;
                u19.ScrollBarThickness = workspace.CurrentCamera.ViewportSize.X * (u19.ScrollBarThickness / 2200);
            end;

            return;
        end;

        u5.Fire("ClosedItemShop");
    end);
end;

return v13;