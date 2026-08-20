--[[
  Type:     LocalScript
  Method:   decompile
  Name:     LocalScript
  Path:     game.StarterGui.Display.LocalScript
  Service:  StarterGui
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:07 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
require(ReplicatedStorage.Library).get("Signal").new("ToggleDisplay"):Connect(function(p1) -- Line: 24
    script.Parent.Enabled = p1;
end);