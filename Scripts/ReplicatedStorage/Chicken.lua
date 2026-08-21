--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Chicken
  Path:     game.ReplicatedStorage.Library.Configs.Pets.Definitions.Chicken
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
    Kind = "GiveEggReward",
    GnomeChance = 0.25,
    CoinBalancePercent = NumberRange.new(0.001, 0.0022)
};

return {
    maxTouches = 5,
    Animations = Assets.GetAnimations("Chicken"),
    Behaviors = { Behavior.EveryRandomInterval(NumberRange.new(120, 180), v1) }
};