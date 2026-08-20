--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Ant
  Path:     game.ReplicatedStorage.Library.Configs.Pets.Definitions.Ant
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
    Animations = Assets.GetAnimations("Ant"),
    Behaviors = { Behavior.EveryRandomInterval(NumberRange.new(180, 300), {
            Kind = "CollectRipeFruit",
            Maximum = 1,
            ValueMultiplier = 1.1
        }) }
};