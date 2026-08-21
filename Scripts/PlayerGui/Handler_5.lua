--[[
  Type:     LocalScript
  Method:   cached
  Name:     Handler
  Path:     game.Players.Palukalima37806.PlayerGui.Display.Boosts.Frame.2x Luck.Handler
  Service:  PlayerGui
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:43 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local u1 = require(ReplicatedStorage.Library).get("Numbers");
local LocalPlayer = Players.LocalPlayer;

local function changed() -- Line: 24
    -- upvalues: LocalPlayer (copy), u1 (copy)
    local v2 = LocalPlayer:GetAttribute("2xLuck_Boost");

    if not v2 then
        script.Parent.Visible = false;

        return;
    end;

    script.Parent.Visible = v2 > 0;
    script.Parent.Label.Text = u1.FormatTimePriority(v2);
end;

local v3 = LocalPlayer:GetAttribute("2xLuck_Boost");

if v3 then
    script.Parent.Visible = v3 > 0;
    script.Parent.Label.Text = u1.FormatTimePriority(v3);
else
    script.Parent.Visible = false;
end;

LocalPlayer:GetAttributeChangedSignal("2xLuck_Boost"):Connect(changed);