--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Raccoon
  Path:     game.ReplicatedStorage.Library.Configs.Pets.Definitions.Raccoon
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
    Kind = "Rummage",
    ItemChance = 0.65,
    CoinBalancePercent = NumberRange.new(0.00015, 0.00025)
};

return {
    Animations = Assets.GetAnimations("Raccoon"),
    Behaviors = { Behavior.EveryRandomInterval(NumberRange.new(240, 420), v1) }
};