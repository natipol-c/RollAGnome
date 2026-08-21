--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Frog
  Path:     game.ReplicatedStorage.Library.Configs.Pets.Definitions.Frog
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

return {
    maxTouches = 3,
    Animations = Assets.GetAnimations("Frog"),
    Behaviors = { Behavior.EveryRandomInterval(NumberRange.new(180, 300), {
            Kind = "ReduceRandomGrowingPlantTime",
            Percent = 0.09
        }) }
};