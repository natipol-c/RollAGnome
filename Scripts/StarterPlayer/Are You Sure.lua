--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Are You Sure
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Tabs.Are You Sure
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:08 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
require(ReplicatedStorage.Replication);
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
Library.get("Network");
local u2 = Library.get("Numbers");
local u3 = Library.get("Signal");
Library.get("SimpleTween");
local _ = Players.LocalPlayer;
local v4 = {};
local u5 = {};
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;

local function open() -- Line: 36
end;

local function close() -- Line: 42
    -- upvalues: u5 (ref)
    for _, v in next, u5 do
        v:Disconnect();
    end;

    u5 = {};
end;

function v4.Start(p15, p16) -- Line: 50
    -- upvalues: u6 (ref), u7 (ref), u1 (copy), u8 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref), u5 (ref)
    u6 = p16;
    u7 = u1(u6, "Menu");
    u8 = u1(u7, "Frame");
    u9 = u1(u8, "Desc");
    u10 = u1(u8, "Background");
    u11 = u1(u8, "Price");
    u12 = u1(u11, "Label");
    u13 = u1(u8, "Buttons");
    u6:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 60
        -- upvalues: u6 (ref), u5 (ref)
        if u6.Enabled then
            return;
        end;

        for _, v in next, u5 do
            v:Disconnect();
        end;

        u5 = {};
    end);
end;

function _G.AreYouSure(p17) -- Line: 69
    -- upvalues: u9 (ref), u11 (ref), u10 (ref), u12 (ref), u2 (copy), u13 (ref), u3 (copy), u14 (ref), u5 (ref)
    if not p17 then
        return;
    end;

    _G.Play("Noti");
    local Callback = p17.Callback;
    local Price = p17.Price;
    local Flip = p17.Flip;
    u9.Text = p17.Message or "ERROR";

    if Price then
        u11.Visible = true;
        u10.Visible = true;
        u9.Position = UDim2.fromScale(0.5, 0.25);
        u9.Size = UDim2.fromScale(0.95, 0.308);
        u12.Text = u2.Comma(Price) .. "$";
    else
        u11.Visible = false;
        u10.Visible = false;
        u9.Position = UDim2.fromScale(0.5, 0.38);
        u9.Size = UDim2.fromScale(0.95, 0.38);
    end;

    u13.Yes.Size = Flip and UDim2.fromScale(1, 1) or UDim2.fromScale(1.5, 1);
    u13.Yes.LayoutOrder = Flip and 2 or 1;
    u13.No.Size = Flip and UDim2.fromScale(1.5, 1) or UDim2.fromScale(1, 1);
    u13.No.LayoutOrder = Flip and 1 or 2;
    u3.Fire("OpenTab", "Are You Sure");
    u14 = Callback;
    local v18 = next;
    local v19, v20 = u13:GetChildren();

    for _, v in v18, v19, v20 do
        if v:FindFirstChild("Button") then
            local Button = v:FindFirstChild("Button");
            local u21 = false;

            if u5[v] then
                u5[v]:Disconnect();
                u5[v] = nil;
            end;

            u5[v] = Button.MouseButton1Click:Connect(function() -- Line: 118
                -- upvalues: u21 (ref), Callback (copy), v (copy), u3 (ref)
                if not u21 then
                    u21 = true;
                    Callback(v.Name == "Yes");
                    u3.Fire("CloseTab", "Are You Sure");
                    task.wait(0.5);
                    u21 = false;
                end;
            end);
        end;
    end;
end;

return v4;