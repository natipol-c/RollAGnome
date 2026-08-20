--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     lib
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch.0.2.5-rc.2.conch.src.lib
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:01 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local v1 = require("./arguments");
local v2 = require("../roblox_packages/ast");
local v3 = require("./bootstrap");
local u4 = require("./client");
local u5 = require("./console");
local v6 = require("./context");
local u7 = require("./net");
local u8 = require("./state");
require("./types");
local u9 = require("./user");
local u10 = RunService:IsServer();
local u11 = RunService:IsClient();
local create_user = u9.create_user;
local disconnect_user = u9.disconnect_user;
local has_permissions = u9.has_permissions;
local create_command_context = v6.create_command_context;

local function FOREACH(p12, p13) -- Line: 27
    for i, v in p12 do
        p13(v, i);
    end;
end;

local function initiate_user_replication(p14) -- Line: 39
    -- upvalues: u5 (copy), has_permissions (copy), u7 (copy)
    for _, v in u5.console.commands do
        if has_permissions(p14, unpack(v.permissions)) then
            u7.server.fire_register_command(p14.player, {
                name = v.name,
                permissions = v.permissions
            });
        end;
    end;
end;

local function get_user(p15) -- Line: 52
    -- upvalues: u9 (copy), u8 (copy), create_user (copy), initiate_user_replication (copy)
    if typeof(p15) == "string" then
        local v16 = u9.obtain_user_key(false, p15);

        return u8.users[v16] or create_user({
            player = false,
            name = v16
        });
    end;

    local v17 = u9.obtain_user_key(p15, p15.DisplayName);
    local v18 = u8.users[v17];

    if v18 then
        return v18;
    end;

    local v19 = create_user({
        name = p15.DisplayName,
        player = p15
    });
    initiate_user_replication(v19);

    return v19;
end;

local function disconnect_user_for_player(p20) -- Line: 74
    -- upvalues: u9 (copy), u8 (copy), disconnect_user (copy)
    local v21 = u9.obtain_user_key(p20, p20.DisplayName);
    local v22 = u8.users[v21];

    if not v22 then
        return;
    end;

    disconnect_user(v22);
end;

local function invoke_server_command(u23, u24) -- Line: 83
    -- upvalues: get_user (copy), u5 (copy), u7 (copy), has_permissions (copy), create_command_context (copy)
    local u25 = get_user(u23);
    local v26 = u5.console.commands[u24.name];

    local function fail() -- Line: 90
        -- upvalues: u7 (ref), u23 (copy), u24 (copy)
        u7.server.fire_failed_invoke_reply(u23, u24.invoke_id);
    end;

    if not (v26 and u25) then
        return fail();
    end;

    if not has_permissions(u25, unpack(v26.permissions)) then
        return fail();
    end;

    local u27 = create_command_context(u25, u24.invoke_id);

    return (function(p28, ...) -- Line: 101, Name: handle
        -- upvalues: u5 (ref), u25 (copy), u24 (copy), u27 (copy), fail (copy), u7 (ref), u23 (copy)
        u5.after_command_run:fire({
            ok = p28,
            who = u25,
            command = u24.name,
            arguments = u24.args,
            result = { ... }
        });
        u27();

        if p28 then
            return u7.server.fire_successful_invoke_reply(u23, u24.invoke_id, { ... });
        end;

        warn(...);

        return fail();
    end)(pcall(v26.callback, unpack(u24.args)));
end;

local function resend_new_commands(p29) -- Line: 125
    -- upvalues: u5 (copy)
    if not p29.dirty then
        return;
    end;

    for _, v in u5.console.commands do
        u5.replicate_to_player(p29.player, v);
    end;

    p29.dirty = false;
end;

return {
    args = v1,
    parse = v2,

    execute = function(p30) -- Line: 176, Name: execute
        -- upvalues: u8 (copy), u11 (copy), u7 (copy), create_command_context (copy), u5 (copy)
        local local_user = u8.local_user;
        assert(u11, "cannot run commands outside of the client");
        assert(local_user, "unable to run commands without a local user");

        if u11 then
            u7.client.fire_log_command(p30);
        end;

        local v31 = create_command_context(local_user, false);
        local success, result = pcall(u5.execute, p30);

        if not success then
            u5.console.output({
                kind = "error",
                text = result
            });
        end;

        v31();
    end,

    register_quick = u5.register_quick,
    register = u5.register_command,

    on_execution = function(u32) -- Line: 192, Name: on_execution
        -- upvalues: u7 (copy)
        local u35 = u7.server.on_log_command(function(p33, p34) -- Line: 193
            -- upvalues: u32 (copy)
            if typeof(p34) ~= "string" then
                p33:Kick();
            end;

            u32(p33, p34);
        end);

        return function() -- Line: 198
            -- upvalues: u35 (copy)
            u35:Disconnect();
        end;
    end,

    on_command_run = function(p36) -- Line: 200, Name: on_command_run
        -- upvalues: u5 (copy)
        local u37 = u5.after_command_run:connect(p36);

        return function() -- Line: 203
            -- upvalues: u37 (copy)
            u37:disconnect();
        end;
    end,

    initiate_default_lifecycle = function() -- Line: 135, Name: initiate_default_lifecycle
        -- upvalues: u11 (copy), u7 (copy), u4 (copy), u10 (copy), Players (copy), get_user (copy), disconnect_user_for_player (copy), u5 (copy), invoke_server_command (copy), RunService (copy), u8 (copy)
        if not u11 then
            if u10 then
                u7.server.init();
                Players.PlayerAdded:Connect(get_user);
                Players.PlayerRemoving:Connect(disconnect_user_for_player);
                local v38 = get_user;

                for i, v in Players:GetPlayers() do
                    v38(v, i);
                end;

                local function _(p39) -- Line: 157
                    -- upvalues: get_user (ref), u5 (ref)
                    local v40 = get_user(p39);

                    if not v40.dirty then
                        return;
                    end;

                    for _, v in u5.console.commands do
                        u5.replicate_to_player(v40.player, v);
                    end;

                    v40.dirty = false;
                end;

                for _, v in Players:GetPlayers() do
                    local v41 = get_user(v);

                    if v41.dirty then
                        for _, v4 in u5.console.commands do
                            u5.replicate_to_player(v41.player, v4);
                        end;

                        v41.dirty = false;
                    end;
                end;

                u7.server.on_command_invoke(invoke_server_command);
                RunService.Heartbeat:Connect(function() -- Line: 163
                    -- upvalues: u8 (ref), u5 (ref)
                    for _, v in u8.users do
                        if v.dirty then
                            for _, v4 in u5.console.commands do
                                u5.replicate_to_player(v.player, v4);
                            end;

                            v.dirty = false;
                        end;
                    end;
                end);
            end;

            return;
        end;

        u7.client.init();
        u7.client.on_command_registered(u4.register_command);
        u7.client.on_invoke_reply(u4.receive_server_results);
        u7.client.on_log_received(u4.log);
        u7.client.on_user_info_received(u4.create_local_user);
        u7.client.on_role_info_received(u4.update_role_permissions);
        u7.client.on_user_roles_update(u4.update_user_roles);
    end,

    has_permissions = u9.has_permissions,

    set_role_permissions = function(p42, ...) -- Line: 33, Name: set_role
        -- upvalues: u8 (copy), u10 (copy), u7 (copy)
        u8.roles[p42] = { ... };

        if u10 then
            u7.server.fire_update_role_perms(p42, { ... });
        end;
    end,

    give_roles = u9.give_roles,
    remove_roles = u9.remove_roles,
    get_user = get_user,
    set_var = u5.write_global,
    get_command_context = v6.get_command_context,
    register_type = u5.register_type,

    log = function(p43, p44) -- Line: 220, Name: log
        -- upvalues: u10 (copy), u8 (copy), u7 (copy), u5 (copy)
        if not u10 then
            u5.console.output({
                kind = p43,
                text = p44
            });

            return;
        end;

        local v45 = u8.command_context[coroutine.running()];

        if not v45 then
            return;
        end;

        local player = v45.executor.player;

        if not player then
            return;
        end;

        u7.server.fire_log(player, {
            kind = p43,
            text = p44
        });
    end,

    register_default_commands = v3,
    console = u5.console,
    analyze = u5.analyze,
    _ = {
        create_user = u9.create_user,
        disconnect_user = u9.disconnect_user,

        create_local_user = function() -- Line: 241, Name: create_local_user
            -- upvalues: u9 (copy), u8 (copy), create_user (copy)
            local v46 = u9.obtain_user_key(false, "local");
            local v47 = u8.users[v46] or create_user({
                player = false,
                name = v46
            });
            u8.local_user = v47;

            return v47;
        end
    }
};