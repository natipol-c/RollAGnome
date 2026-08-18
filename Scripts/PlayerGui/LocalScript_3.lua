--[[
  Type:     LocalScript
  Method:   cached
  Name:     LocalScript
  Path:     game.Players.Palukalima37806.PlayerGui.Display.LocalScript
  Service:  PlayerGui
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:10 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
require(ReplicatedStorage.Library).get("Signal").new("ToggleDisplay"):Connect(function(p1) -- Line: 24
    script.Parent.Enabled = p1;
end);