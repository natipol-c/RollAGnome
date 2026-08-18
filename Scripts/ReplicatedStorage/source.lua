--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     source
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.centau_vide@0.3.1.vide.source
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
local create_source_node = graph.create_source_node;
local push_child_to_scope = graph.push_child_to_scope;
local update_descendants = graph.update_descendants;

return function(p1) -- Line: 11, Name: source
    -- upvalues: create_source_node (copy), push_child_to_scope (copy), update_descendants (copy)
    local u2 = create_source_node(p1);

    return function(...) -- Line: 14
        -- upvalues: push_child_to_scope (ref), u2 (copy), update_descendants (ref)
        if select("#", ...) == 0 then
            push_child_to_scope(u2);

            return u2.cache;
        end;

        local v3 = ...;

        if u2.cache == v3 and (type(v3) ~= "table" or table.isfrozen(v3)) then
            return v3;
        end;

        u2.cache = v3;
        update_descendants(u2);

        return v3;
    end;
end;