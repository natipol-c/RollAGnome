--[[
  Type:     LocalScript
  Method:   cached
  Name:     Handler
  Path:     game.Players.Palukalima37806.PlayerGui.Display.Boosts.Frame.ServerLuck.Handler
  Service:  PlayerGui
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:31 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local u1 = require(ReplicatedStorage.Library).get("Numbers");
local _ = Players.LocalPlayer;

local function timerChanged() -- Line: 23
    -- upvalues: ReplicatedStorage (copy), u1 (copy)
    local v2 = ReplicatedStorage:GetAttribute("LuckTime");

    if not v2 then
        return;
    end;

    script.Parent.Timer.Text = u1.FormatTimePriority(v2);
end;

local function luckChanged() -- Line: 29
    -- upvalues: ReplicatedStorage (copy)
    local v3 = ReplicatedStorage:GetAttribute("LuckLevel") - 1;

    if not v3 then
        return;
    end;

    script.Parent.Visible = v3 > 0;
    script.Parent.Label.Text = `{2 ^ v3}X`;
end;

local v4 = ReplicatedStorage:GetAttribute("LuckLevel") - 1;

if v4 then
    script.Parent.Visible = v4 > 0;
    script.Parent.Label.Text = `{2 ^ v4}X`;
end;

ReplicatedStorage:GetAttributeChangedSignal("LuckLevel"):Connect(luckChanged);
local v5 = ReplicatedStorage:GetAttribute("LuckTime");

if v5 then
    script.Parent.Timer.Text = u1.FormatTimePriority(v5);
end;

ReplicatedStorage:GetAttributeChangedSignal("LuckTime"):Connect(timerChanged);