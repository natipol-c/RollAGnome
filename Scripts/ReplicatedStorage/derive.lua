--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     derive
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.centau_vide@0.3.1.vide.derive
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:02 2026
]]

-- Decompiled with Potassium's decompiler.

if not game then
    script = require("test/relative-string");
end;

local graph = require(script.Parent.graph);
local create_node = graph.create_node;
local push_child_to_scope = graph.push_child_to_scope;
local assert_stable_scope = graph.assert_stable_scope;
local evaluate_node = graph.evaluate_node;

return function(p1) -- Line: 9, Name: derive
    -- upvalues: create_node (copy), assert_stable_scope (copy), evaluate_node (copy), push_child_to_scope (copy)
    local u2 = create_node(assert_stable_scope(), p1, false);
    evaluate_node(u2);

    return function() -- Line: 14
        -- upvalues: push_child_to_scope (ref), u2 (copy)
        push_child_to_scope(u2);

        return u2.cache;
    end;
end;