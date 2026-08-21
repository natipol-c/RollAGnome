--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Bee
  Path:     game.ReplicatedStorage.Library.Configs.Pets.Definitions.Bee
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
    maxTouches = 20,
    Animations = Assets.GetAnimations("Bee"),
    Behaviors = { Behavior.EveryRandomInterval(NumberRange.new(15, 30), {
            Kind = "MultiplyRandomFruitValue",
            Multiplier = 1.0025,
            Ripe = true
        }) }
};