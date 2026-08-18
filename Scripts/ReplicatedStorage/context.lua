--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     context
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch.0.2.5-rc.2.conch.src.context
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:05 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = require("./state");
require("./types");

return {
    create_command_context = function(p2, p3) -- Line: 4, Name: create_command_context
        -- upvalues: u1 (copy)
        local v4 = not u1.command_context[coroutine.running()];
        assert(v4, "there is already a command context for this thread");
        u1.command_context[coroutine.running()] = {
            executor = p2,
            invocation_id = p3
        };

        return function() -- Line: 17
            -- upvalues: u1 (ref)
            u1.command_context[coroutine.running()] = nil;
        end;
    end,

    get_command_context = function() -- Line: 20, Name: get_command_context
        -- upvalues: u1 (copy)
        return u1.command_context[coroutine.running()];
    end
};