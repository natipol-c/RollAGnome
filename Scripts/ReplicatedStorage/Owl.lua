--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Owl
  Path:     game.ReplicatedStorage.Library.Configs.Pets.Definitions.Owl
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:24 2026
]]

-- Decompiled with Potassium's decompiler.

local Assets = require(script.Parent.Parent.Assets);
local Behavior = require(script.Parent.Parent.Behavior);
require(script.Parent.Parent.Types);

return {
    Animations = Assets.GetAnimations("Owl"),
    Behaviors = { Behavior.EveryRandomInterval(NumberRange.new(60, 90), {
            Kind = "ReduceGnomePlantTime",
            Percent = 0.75
        }) }
};