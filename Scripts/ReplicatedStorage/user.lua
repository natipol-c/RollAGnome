--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     user
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch.0.2.5-rc.2.conch.src.user
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:33 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local u1 = require("./constants");
local u2 = require("./net");
local u3 = require("./state");
require("./types");
local u4 = RunService:IsServer();

return {
    obtain_user_key = function(p5, p6) -- Line: 11, Name: obtain_user_key
        if p5 then
            return `player-{p5.UserId}`;
        end;

        return `server-{p6}`;
    end,

    create_user = function(p7) -- Line: 15, Name: create_user
        -- upvalues: u4 (copy), u2 (copy), u3 (copy)
        local v8 = {
            disconnected = false,
            dirty = false
        };
        local player = p7.player;
        local name = p7.name;
        local v9;

        if player then
            v9 = `player-{player.UserId}`;
        else
            v9 = `server-{name}`;
        end;

        v8.id = v9;
        v8.name = p7.name;
        v8.player = p7.player;
        v8.roles = {};

        if u4 and v8.player then
            u2.server.fire_create_user(v8.player, v8.id, v8.name);
        end;

        u3.users[v8.id] = v8;

        return v8;
    end,

    disconnect_user = function(p10) -- Line: 57, Name: disconnect_user
        -- upvalues: u3 (copy)
        if p10.disconnected == true then
            return;
        end;

        p10.disconnected = true;
        u3.users[p10.id] = nil;
    end,

    has_permissions = function(p11, ...) -- Line: 38, Name: has_permissions
        -- upvalues: u1 (copy), u3 (copy)
        local v12 = { ... };

        for _, v in p11.roles do
            if u1.ADMIN_ROLE == v then
                return true;
            end;

            if u3.roles[v] then
                for _, v2 in u3.roles[v] do
                    local v13 = table.find(v12, v2);

                    if v13 then
                        table.remove(v12, v13);

                        if #v12 == 0 then
                            return true;
                        end;
                    end;
                end;
            end;
        end;

        return false;
    end,

    give_roles = function(p14, ...) -- Line: 65, Name: give_roles
        -- upvalues: u4 (copy), u2 (copy)
        if p14.disconnected then
            return;
        end;

        local v15 = {};

        for i = 1, select("#", ...) do
            local v16 = select(i, ...);

            if not table.find(v15, v16) then
                table.insert(v15, v16);
            end;
        end;

        for _, v in p14.roles do
            if not table.find(v15, v) then
                table.insert(v15, v);
            end;
        end;

        p14.roles = v15;

        if u4 and p14.player then
            p14.dirty = true;
            u2.server.fire_update_user_roles(p14.player, {
                id = p14.id,
                roles = v15
            });
        end;
    end,

    remove_roles = function(p17, ...) -- Line: 92, Name: remove_roles
        -- upvalues: RunService (copy), u2 (copy)
        if p17.disconnected then
            return;
        end;

        local v18 = table.clone(p17.roles);
        local v19 = { ... };

        for i = #v18, 1, -1 do
            if table.find(v19, v18[i]) then
                v18[i] = v18[#v18];
                v18[#v18] = nil;
            end;
        end;

        p17.roles = v18;

        if RunService:IsServer() and p17.player then
            p17.dirty = true;
            u2.server.fire_update_user_roles(p17.player, {
                id = p17.id,
                roles = v18
            });
        end;
    end
};