--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     context
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.centau_vide@0.3.1.vide.context
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
local get_scope = graph.get_scope;
local push_scope = graph.push_scope;
local pop_scope = graph.pop_scope;
local set_context = graph.set_context;
local u1 = newproxy();
local u2 = 0;

return function(...) -- Line: 17, Name: context
    -- upvalues: u2 (ref), get_scope (copy), u1 (copy), throw (copy), create_node (copy), set_context (copy), push_scope (copy), pop_scope (copy)
    u2 = u2 + 1;
    local u3 = u2;
    local u4 = select("#", ...) > 0;
    local u5 = ...;

    return function(...) -- Line: 24
        -- upvalues: get_scope (ref), u3 (copy), u1 (ref), u4 (copy), u5 (copy), throw (ref), create_node (ref), set_context (ref), push_scope (ref), pop_scope (ref)
        local v6 = get_scope();

        if select("#", ...) == 0 then
            while v6 do
                local context = v6.context;

                if context then
                    local v7 = context[u3];

                    if v7 ~= nil then
                        if v7 == u1 then
                            return nil;
                        end;

                        return v7;
                    end;

                    v6 = v6.owner;
                else
                    v6 = v6.owner;
                end;
            end;

            if u4 ~= nil then
                return u5;
            end;

            throw("attempt to get context when no context is set and no default context is set");

            return nil;
        end;

        if not v6 then
            return throw("attempt to set context outside of a vide scope");
        end;

        local v8, v9 = ...;
        local v10 = create_node(v6, false, false);

        if v8 == nil then
            v8 = u1;
        end;

        set_context(v10, u3, v8);
        push_scope(v10);
        local v12, v13 = xpcall(v9, function(p11) -- Line: 61, Name: efn
            return debug.traceback(p11, 3);
        end);
        pop_scope();

        if not v12 then
            throw((`error while running context:\n\n{v13}`));
        end;

        return v13;
    end;
end;