--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     client
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch.0.2.5-rc.2.conch.src.client
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:25 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local u1 = require("./console");
local u2 = require("./net");
local u3 = require("./state");
require("./types");
local u4 = require("./user");
local LocalPlayer = Players.LocalPlayer;
local u5 = 0;

return {
    create_local_user = function(p6) -- Line: 14, Name: create_local_user
        -- upvalues: u4 (copy), LocalPlayer (copy), u3 (copy)
        u3.local_user = u4.create_user({
            name = p6.name,
            player = LocalPlayer
        });
    end,

    update_user_roles = function(p7) -- Line: 23, Name: update_user_roles
        -- upvalues: u3 (copy)
        local v8 = u3.users[p7.id];
        assert(v8, "local user does not exist");
        v8.roles = p7.roles;
    end,

    update_role_permissions = function(p9) -- Line: 31, Name: update_role_permissions
        -- upvalues: u3 (copy)
        u3.roles[p9.name] = p9.permissions;
    end,

    register_command = function(u10) -- Line: 36, Name: register_command
        -- upvalues: u1 (copy), u5 (ref), u3 (copy), u2 (copy)
        u1.register_command(u10.name, {
            description = u10.description,
            permissions = u10.permissions,

            arguments = function() -- Line: 41
                -- upvalues: u10 (copy)
                return unpack(u10.arguments);
            end,

            callback = function(...) -- Line: 43, Name: callback
                -- upvalues: u5 (ref), u3 (ref), u2 (ref), u10 (copy)
                local v11 = coroutine.running();
                u5 = u5 + 1;
                u3.continuations[u5] = v11;
                u2.client.invoke_command(u5, u10.name, { ... });
                local v12 = coroutine.yield();

                if v12.status == "ok" then
                    return unpack(v12.results);
                end;

                error("something went wrong on the server");
            end
        });
    end,

    receive_server_results = function(p13) -- Line: 64, Name: receive_server_results
        -- upvalues: u3 (copy)
        local v14 = u3.continuations[p13.invoke_id];

        if not v14 then
            return;
        end;

        u3.continuations[p13.invoke_id] = nil;
        task.spawn(v14, p13);
    end,

    log = function(p15) -- Line: 72, Name: log
        -- upvalues: u1 (copy)
        u1.console.output(p15);
    end
};