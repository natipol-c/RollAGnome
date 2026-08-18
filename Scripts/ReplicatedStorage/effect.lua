--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     effect
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.centau_vide@0.3.1.vide.effect
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:05 2026
]]

-- Decompiled with Potassium's decompiler.

if not game then
    script = require("test/relative-string");
end;

local graph = require(script.Parent.graph);
local create_node = graph.create_node;
local assert_stable_scope = graph.assert_stable_scope;
local evaluate_node = graph.evaluate_node;

return function(p1, p2) -- Line: 8, Name: effect
    -- upvalues: create_node (copy), assert_stable_scope (copy), evaluate_node (copy)
    evaluate_node((create_node(assert_stable_scope(), p1, p2)));
end;