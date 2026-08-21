--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Turtle
  Path:     game.ReplicatedStorage.Library.Configs.Pets.Definitions.Turtle
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:31 2026
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
    maxTouches = 10,
    Animations = Assets.GetAnimations("Turtle"),
    Behaviors = { Behavior.EveryRandomInterval(NumberRange.new(30, 60), v1) }
};