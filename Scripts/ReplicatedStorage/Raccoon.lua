--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Raccoon
  Path:     game.ReplicatedStorage.Library.Configs.Pets.Definitions.Raccoon
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
    Kind = "Rummage",
    ItemChance = 0.65,
    CoinBalancePercent = NumberRange.new(0.02, 0.05)
};

return {
    Animations = Assets.GetAnimations("Raccoon"),
    Behaviors = { Behavior.EveryRandomInterval(NumberRange.new(180, 300), v1) }
};