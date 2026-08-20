--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Turtle
  Path:     game.ReplicatedStorage.Library.Configs.Pets.Definitions.Turtle
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:04 2026
]]

-- Decompiled with Potassium's decompiler.

local Assets = require(script.Parent.Parent.Assets);
local Behavior = require(script.Parent.Parent.Behavior);
require(script.Parent.Parent.Types);
local v1 = {
    Kind = "GrantRandomGnomeXPPercent",
    Percent = NumberRange.new(0.01, 0.02)
};

return {
    Animations = Assets.GetAnimations("Turtle"),
    Behaviors = { Behavior.EveryRandomInterval(NumberRange.new(240, 360), v1) }
};