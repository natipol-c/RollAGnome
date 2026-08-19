--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Bunny
  Path:     game.ReplicatedStorage.Library.Configs.Pets.Definitions.Bunny
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
local v1 = {
    Kind = "GrantMoneyBalancePercent",
    Percent = NumberRange.new(0.02, 0.05)
};

return {
    Animations = Assets.GetAnimations("Bunny"),
    Behaviors = { Behavior.EveryRandomInterval(NumberRange.new(90, 120), v1) }
};