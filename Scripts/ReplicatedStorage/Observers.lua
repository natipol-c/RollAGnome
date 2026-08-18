--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Observers
  Path:     game.ReplicatedStorage.Library.Imported.Observers
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:04 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    observeTag = require(script.observeTag),
    observeTagNoAncestry = require(script.observeTagNoAncestry),
    observeAttribute = require(script.observeAttribute),
    observeProperty = require(script.observeProperty),
    observePlayer = require(script.observePlayer),
    observeCharacter = require(script.observeCharacter),
    observeCharacters = require(script.observeCharacters),
    observeChildren = require(script.observeChildren),
    observeDescendants = require(script.observeDescendants)
};