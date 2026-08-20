--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Mutant Bee
  Path:     game.ReplicatedStorage.Library.Configs.Pets.Definitions.Mutant Bee
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

return {
    Animations = Assets.GetAnimations("Mutant Bee"),
    Behaviors = { Behavior.EveryRandomInterval(NumberRange.new(300, 600), {
            Kind = "MutateRandomFruit",
            ValueMultiplier = 2,
            MutationPool = { "Golden", "Diamond", "Shiny", "Fire", "Night", "Toxic", "Charged", "Frozen", "Cursed" }
        }) }
};