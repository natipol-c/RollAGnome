--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Products
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Products
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:08 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Replication = require(ReplicatedStorage.Replication);
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
local u2 = Library.get("Numbers");
local u3 = Library.get("Products");
local u4 = Library.get("Signal");
local v5 = {};
local u6 = nil;
local u7 = nil;
local u8 = false;

local function hasPrompted() -- Line: 29
    -- upvalues: Replication (copy)
    local Deal2 = (Replication.Data.weekly_deals or {}).Deal2;

    if Deal2 then
        Deal2 = Deal2.prompted == true;
    end;

    return Deal2;
end;

local function hasPurchased() -- Line: 36
    -- upvalues: Replication (copy)
    local Deal2 = (Replication.Data.weekly_deals or {}).Deal2;

    if Deal2 then
        Deal2 = Deal2.purchased == true;
    end;

    return Deal2;
end;

local function updateVisibility() -- Line: 43
    -- upvalues: u7 (ref), Replication (copy), u8 (ref)
    if u7 then
        local Deal2 = (Replication.Data.weekly_deals or {}).Deal2;

        if Deal2 then
            Deal2 = Deal2.prompted == true;
        end;

        if Deal2 then
            local Deal22 = (Replication.Data.weekly_deals or {}).Deal2;

            if Deal22 then
                Deal22 = Deal22.purchased == true;
            end;

            Deal2 = not Deal22 and not u8;
        end;

        u7.Visible = Deal2;
    end;
end;

local function updatePrice(p9) -- Line: 49
    -- upvalues: u3 (copy), u2 (copy)
    local Deal2 = u3.products.weeklyDeal.Deal2;

    if not Deal2 then
        return;
    end;

    local price = Deal2.price;

    if not price then
        repeat
            task.wait(0.1);
            price = Deal2.price;
        until price ~= nil;
    end;

    if price == "ERR" then
        p9.Text = "NFS";

        return;
    end;

    p9.Text = u2.Comma(price);
end;

function v5.Start(p10, p11) -- Line: 68
    -- upvalues: u6 (ref), u1 (copy), u7 (ref), Replication (copy), u8 (ref), updatePrice (copy), u4 (copy), updateVisibility (copy)
    u6 = u1(p11, "Right");
    u6 = u1(u6, "Products");
    u7 = u1(u6, "WeeklyDeal");

    if not Replication.Data.tutorial then
        repeat
            task.wait(0.1);
        until Replication.Data.tutorial;
    end;

    local v12 = u1(u7, "Button");
    local v13 = u1(u1(u1(u7, "Frame"), "Price"), "PriceLabel");
    local u14 = false;

    if u7 then
        local Deal2 = (Replication.Data.weekly_deals or {}).Deal2;

        if Deal2 then
            Deal2 = Deal2.prompted == true;
        end;

        if Deal2 then
            local Deal22 = (Replication.Data.weekly_deals or {}).Deal2;

            if Deal22 then
                Deal22 = Deal22.purchased == true;
            end;

            Deal2 = not Deal22 and not u8;
        end;

        u7.Visible = Deal2;
    end;

    task.spawn(updatePrice, v13);
    v12.MouseButton1Click:Connect(function() -- Line: 87
        -- upvalues: Replication (ref), u7 (ref), u8 (ref), u14 (ref), u4 (ref)
        local Deal2 = (Replication.Data.weekly_deals or {}).Deal2;

        if Deal2 then
            Deal2 = Deal2.purchased == true;
        end;

        if Deal2 then
            if u7 then
                local Deal22 = (Replication.Data.weekly_deals or {}).Deal2;

                if Deal22 then
                    Deal22 = Deal22.prompted == true;
                end;

                if Deal22 then
                    local Deal23 = (Replication.Data.weekly_deals or {}).Deal2;

                    if Deal23 then
                        Deal23 = Deal23.purchased == true;
                    end;

                    Deal22 = not Deal23 and not u8;
                end;

                u7.Visible = Deal22;
            end;

            return;
        end;

        if u14 then
            return;
        end;

        u14 = true;
        _G.Play("Tap");
        u4.Fire("OpenTab", "WeeklyDeal");
        task.wait(0.2);
        u14 = false;
    end);
    Replication:Connect("weekly_deals", updateVisibility);
    u4.new("WeeklyDealPrompted"):Connect(updateVisibility);
    u4.new("WeeklyDealFrameVisible"):Connect(function(p15) -- Line: 106
        -- upvalues: u8 (ref), u7 (ref), Replication (ref)
        u8 = p15 == true;

        if u7 then
            local Deal2 = (Replication.Data.weekly_deals or {}).Deal2;

            if Deal2 then
                Deal2 = Deal2.prompted == true;
            end;

            if Deal2 then
                local Deal22 = (Replication.Data.weekly_deals or {}).Deal2;

                if Deal22 then
                    Deal22 = Deal22.purchased == true;
                end;

                Deal2 = not Deal22 and not u8;
            end;

            u7.Visible = Deal2;
        end;
    end);
end;

return v5;