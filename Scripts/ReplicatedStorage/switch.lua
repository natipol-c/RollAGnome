--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     switch
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.centau_vide@0.3.1.vide.switch
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:35 2026
]]

-- Decompiled with Potassium's decompiler.

if not game then
    script = require("test/relative-string");
end;

local throw = require(script.Parent.throw);
local graph = require(script.Parent.graph);
local create_node = graph.create_node;
local evaluate_node = graph.evaluate_node;
local push_child_to_scope = graph.push_child_to_scope;
local destroy = graph.destroy;
local assert_stable_scope = graph.assert_stable_scope;
local push_scope = graph.push_scope;
local pop_scope = graph.pop_scope;

return function(u1) -- Line: 17, Name: switch
    -- upvalues: assert_stable_scope (copy), destroy (copy), throw (copy), create_node (copy), push_scope (copy), pop_scope (copy), evaluate_node (copy), push_child_to_scope (copy)
    local u2 = assert_stable_scope();

    return function(u3) -- Line: 20
        -- upvalues: u1 (copy), destroy (ref), throw (ref), create_node (ref), u2 (copy), push_scope (ref), pop_scope (ref), evaluate_node (ref), push_child_to_scope (ref)
        local u4 = nil;
        local u5 = nil;
        local u9 = create_node(u2, function(p6) -- Line: 24, Name: update
            -- upvalues: u3 (copy), u1 (ref), u5 (ref), u4 (ref), destroy (ref), throw (ref), create_node (ref), u2 (ref), push_scope (ref), pop_scope (ref)
            local v7 = u3[u1()];

            if v7 == u5 then
                return p6;
            end;

            u5 = v7;

            if u4 then
                destroy(u4);
                u4 = nil;
            end;

            if v7 == nil then
                return nil;
            end;

            if type(v7) ~= "function" then
                throw("map must map a value to a function");
            end;

            local v8 = create_node(u2, false, false);
            u4 = v8;
            push_scope(v8);
            local success, result = pcall(v7);
            pop_scope();

            if not success then
                error(result, 0);
            end;

            return result;
        end, nil);
        evaluate_node(u9);

        return function() -- Line: 58
            -- upvalues: push_child_to_scope (ref), u9 (copy)
            push_child_to_scope(u9);

            return u9.cache;
        end;
    end;
end;