--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     root
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.centau_vide@0.3.1.vide.root
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

local throw = require(script.Parent.throw);
local graph = require(script.Parent.graph);
local create_node = graph.create_node;
local push_scope = graph.push_scope;
local pop_scope = graph.pop_scope;
local destroy = graph.destroy;
local u1 = {};

return function(p2) -- Line: 13, Name: root
    -- upvalues: create_node (copy), u1 (copy), throw (copy), destroy (copy), push_scope (copy), pop_scope (copy)
    local u3 = create_node(false, false, false);
    u1[u3] = true;

    local function v4() -- Line: 18
        -- upvalues: u1 (ref), u3 (copy), throw (ref), destroy (ref)
        if not u1[u3] then
            throw("root already destroyed");
        end;

        u1[u3] = nil;
        destroy(u3);
    end;

    push_scope(u3);
    local v6 = { xpcall(p2, function(p5) -- Line: 26, Name: efn
            return debug.traceback(p5, 3);
        end, v4) };
    pop_scope();

    if not v6[1] then
        if not u1[u3] then
            throw("root already destroyed");
        end;

        u1[u3] = nil;
        destroy(u3);
        throw((`error while running root():\n\n{v6[2]}`));
    end;

    return v4, unpack(v6, 2);
end;