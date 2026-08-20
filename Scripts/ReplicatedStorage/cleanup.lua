--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     cleanup
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.centau_vide@0.3.1.vide.cleanup
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

local u1 = game and typeof or require("test/mock").typeof;
local throw = require(script.Parent.throw);
local graph = require(script.Parent.graph);
local get_scope = graph.get_scope;
local push_cleanup = graph.push_cleanup;

local function helper(u2) -- Line: 9
    -- upvalues: u1 (copy), throw (copy)
    return u1(u2) == "RBXScriptConnection" and function() -- Line: 11
        -- upvalues: u2 (copy)
        u2:Disconnect();
    end or (u1(u2) == "Instance" and function() -- Line: 12
        -- upvalues: u2 (copy)
        u2:Destroy();
    end or (u2.destroy and function() -- Line: 13
        -- upvalues: u2 (copy)
        u2:destroy();
    end or (u2.disconnect and function() -- Line: 14
        -- upvalues: u2 (copy)
        u2:disconnect();
    end or (u2.Destroy and function() -- Line: 15
        -- upvalues: u2 (copy)
        u2:Destroy();
    end or (u2.Disconnect and function() -- Line: 16
        -- upvalues: u2 (copy)
        u2:Disconnect();
    end or throw("cannot cleanup given object"))))));
end;

return function(p3) -- Line: 20, Name: cleanup
    -- upvalues: get_scope (copy), throw (copy), push_cleanup (copy), helper (copy)
    local v4 = get_scope();

    if not v4 then
        throw("cannot cleanup outside a stable or reactive scope");
    end;

    assert(v4);

    if type(p3) == "function" then
        push_cleanup(v4, p3);

        return;
    end;

    push_cleanup(v4, (helper(p3)));
end;