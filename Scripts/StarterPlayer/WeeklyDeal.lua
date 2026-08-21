--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     WeeklyDeal
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Tabs.WeeklyDeal
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:39 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Replication = require(ReplicatedStorage.Replication);
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
local u2 = Library.get("Network");
local u3 = Library.get("Numbers");
local u4 = Library.get("Products");
local u5 = Library.get("Signal");
local u6 = Library.get("WeeklyDeal");
local LocalPlayer = Players.LocalPlayer;
local v7 = {};
local u8 = {};
local u9 = false;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;

local function hasPrompted() -- Line: 35
    -- upvalues: Replication (copy)
    local Deal2 = (Replication.Data.weekly_deals or {}).Deal2;

    if Deal2 then
        Deal2 = Deal2.prompted == true;
    end;

    return Deal2;
end;

local function hasPurchased() -- Line: 42
    -- upvalues: Replication (copy)
    local Deal2 = (Replication.Data.weekly_deals or {}).Deal2;

    if Deal2 then
        Deal2 = Deal2.purchased == true;
    end;

    return Deal2;
end;

local function markPrompted() -- Line: 49
    -- upvalues: Replication (copy), u5 (copy), u2 (copy)
    local Deal2 = (Replication.Data.weekly_deals or {}).Deal2;

    if Deal2 then
        Deal2 = Deal2.prompted == true;
    end;

    if Deal2 then
        return;
    end;

    Replication.Data.weekly_deals = Replication.Data.weekly_deals or {};
    Replication.Data.weekly_deals.Deal2 = Replication.Data.weekly_deals.Deal2 or {};
    Replication.Data.weekly_deals.Deal2.prompted = true;
    u5.Fire("WeeklyDealPrompted", "Deal2");
    u2:FireServer("WeeklyDealPrompted", "Deal2");
end;

local function getCurrentDeal() -- Line: 60
    -- upvalues: u4 (copy)
    return u4.products.weeklyDeal.Deal2;
end;

local function waitForTutorialToEnd() -- Line: 64
    -- upvalues: ReplicatedStorage (copy), Replication (copy), LocalPlayer (copy)
    repeat
        task.wait(0.1);
    until ReplicatedStorage:GetAttribute("DataLoaded");

    if not Replication.Data.tutorial then
        repeat
            task.wait(0.1);
        until Replication.Data.tutorial;
    end;

    if LocalPlayer:GetAttribute("InTutorial") then
        repeat
            task.wait(0.1);
        until not LocalPlayer:GetAttribute("InTutorial");
    end;
end;

local function getEndTime() -- Line: 75
    -- upvalues: u6 (copy)
    local Deal2 = u6.Deal2;

    return Deal2 and Deal2.endTime or os.time();
end;

local function formatDuration(p14) -- Line: 81
    local v15 = math.floor(p14);
    local v16 = math.max(0, v15);

    return `{math.floor(v16 / 86400)}d {math.floor(v16 % 86400 / 3600)}h {math.floor(v16 % 3600 / 60)}m`;
end;

local function updatePrice() -- Line: 91
    -- upvalues: u4 (copy), u1 (copy), u12 (ref), u10 (ref), u3 (copy)
    local Deal2 = u4.products.weeklyDeal.Deal2;

    if not Deal2 then
        return;
    end;

    local v17 = u1(u12, "Purchase");

    if v17 then
        v17 = u1(v17, "Frame");
    end;

    if v17 then
        v17 = u1(v17, "Price");
    end;

    if v17 then
        v17 = u1(v17, "PriceLabel");
    end;

    if not v17 then
        return;
    end;

    local price = Deal2.price;

    if not price then
        repeat
            task.wait(0.1);
            price = Deal2.price;
        until price ~= nil or not u10;
    end;

    if price == "ERR" then
        v17.Text = "NFS";

        return;
    end;

    v17.Text = u3.Comma(price);
end;

local function open() -- Line: 116
    -- upvalues: Replication (copy), u5 (copy), u9 (ref), markPrompted (copy), updatePrice (copy), u1 (copy), u12 (ref), u10 (ref), u8 (ref), u4 (copy), u13 (ref), u6 (copy)
    local Deal2 = (Replication.Data.weekly_deals or {}).Deal2;

    if Deal2 then
        Deal2 = Deal2.purchased == true;
    end;

    if Deal2 then
        u5.Fire("CloseTab", "WeeklyDeal");

        return;
    end;

    u9 = true;
    u5.Fire("WeeklyDealFrameVisible", true);
    markPrompted();
    task.spawn(updatePrice);
    local v18 = u1(u12, "Close");
    local v19 = u1(u12, "Purchase");
    local v20 = u1(u12, "Gift");
    local Close = u10:FindFirstChild("Close");
    local v21 = Close and Close:IsA("ObjectValue") and Close.Value == v18;
    u8[u12] = {};
    local v22 = v18 and not v21 and u1(v18, "Button");

    if v22 then
        u8[u12].close = v22.MouseButton1Click:Connect(function() -- Line: 138
            -- upvalues: u5 (ref)
            _G.Play("Tap");
            u5.Fire("CloseTab", "WeeklyDeal");
        end);
    end;

    if v19 then
        local v23 = u1(v19, "Button");
        local u24 = false;

        if v23 then
            v23.ZIndex = 9999;
            u8[u12].purchase = v23.MouseButton1Click:Connect(function() -- Line: 150
                -- upvalues: u24 (ref), Replication (ref), u5 (ref), u4 (ref)
                if u24 then
                    return;
                end;

                u24 = true;
                local Deal22 = (Replication.Data.weekly_deals or {}).Deal2;

                if Deal22 then
                    Deal22 = Deal22.purchased == true;
                end;

                if Deal22 then
                    u5.Fire("CloseTab", "WeeklyDeal");
                    u24 = false;

                    return;
                end;

                local Deal23 = u4.products.weeklyDeal.Deal2;

                if Deal23 and Deal23.id then
                    u4.prompt(Deal23.id, "product");
                end;

                task.wait(0.2);
                u24 = false;
            end);
        end;
    end;

    local v25 = v20 and u1(v20, "Button");

    if v25 then
        u8[u12].gift = v25.MouseButton1Click:Connect(function() -- Line: 174
            -- upvalues: u4 (ref), u5 (ref)
            local Deal22 = u4.products.weeklyDeal.Deal2;

            if Deal22 and Deal22.id then
                u5.Fire("WantsToGift", {
                    name = "Weekly Deal",
                    type = "product",
                    id = Deal22.id
                }, function() -- Line: 177
                    -- upvalues: u5 (ref)
                    u5.Fire("OpenTab", "WeeklyDeal");
                end);
            end;
        end);
    end;

    if u13 then
        u8[u13] = {};
        u8[u13].poll = task.spawn(function() -- Line: 187
            -- upvalues: u10 (ref), u13 (ref), u6 (ref)
            while u10 and u10.Enabled do
                local Deal22 = u6.Deal2;
                local v26 = (Deal22 and Deal22.endTime or os.time()) - os.time();
                local v27 = math.floor(v26);
                local v28 = math.max(0, v27);
                u13.Text = `Expires in: {`{math.floor(v28 / 86400)}d {math.floor(v28 % 86400 / 3600)}h {math.floor(v28 % 3600 / 60)}m`}`;
                task.wait(1);
            end;
        end);
    end;
end;

local function close() -- Line: 196
    -- upvalues: u5 (copy), u8 (ref)
    u5.Fire("WeeklyDealFrameVisible", false);

    for _, v in next, u8 do
        for _, v2 in next, v do
            if typeof(v2) == "thread" then
                task.cancel(v2);
            elseif typeof(v2) == "RBXScriptConnection" then
                v2:Disconnect();
            end;
        end;
    end;

    u8 = {};
end;

function v7.Start(p29, u30) -- Line: 212
    -- upvalues: u10 (ref), u11 (ref), u1 (copy), u12 (ref), u13 (ref), updatePrice (copy), waitForTutorialToEnd (copy), u9 (ref), Replication (copy), u5 (copy), close (copy), open (copy)
    u10 = u30;
    u11 = u1(u10, "Menu");
    u12 = u1(u11, "Buttons");
    u13 = u1(u11, "Timer");
    task.spawn(updatePrice);
    task.spawn(function() -- Line: 220
        -- upvalues: waitForTutorialToEnd (ref), u9 (ref), Replication (ref), u10 (ref), u5 (ref)
        waitForTutorialToEnd();
        task.wait(60);

        if not u9 then
            local Deal2 = (Replication.Data.weekly_deals or {}).Deal2;

            if Deal2 then
                Deal2 = Deal2.prompted == true;
            end;

            if not Deal2 then
                local Deal22 = (Replication.Data.weekly_deals or {}).Deal2;

                if Deal22 then
                    Deal22 = Deal22.purchased == true;
                end;

                if not (Deal22 or (u10.Enabled or _G.PromptingProduct)) then
                    u5.Fire("OpenTab", "WeeklyDeal");
                end;
            end;
        end;
    end);
    Replication:Connect("weekly_deals", function() -- Line: 230
        -- upvalues: Replication (ref), u10 (ref), u5 (ref)
        local Deal2 = (Replication.Data.weekly_deals or {}).Deal2;

        if Deal2 then
            Deal2 = Deal2.purchased == true;
        end;

        if Deal2 and u10.Enabled then
            u5.Fire("CloseTab", "WeeklyDeal");
        end;
    end);
    u30:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 236
        -- upvalues: u30 (copy), close (ref), open (ref)
        if u30.Enabled then
            open();

            return;
        end;

        close();
    end);
end;

return v7;