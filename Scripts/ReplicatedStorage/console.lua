--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     console
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch.0.2.5-rc.2.conch.src.console
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:01 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local u1 = require("../roblox_packages/ast");
local u2 = require("../roblox_packages/compiler");
local v3 = require("../roblox_packages/vm");
require("../roblox_packages/types");
local u4 = require("../roblox_packages/intel");
local u5 = require("./net");
local v6 = require("./signal");
local u7 = require("./state");
require("./types");
local u8 = require("./user");
local u9 = RunService:IsServer();
local u10 = {
    locals = {},
    upvalues = {},
    instructions = {}
};
local u11 = v3();
local u12 = {};
local u13 = v6();
local u14 = {
    vm = u11,
    commands = u12,
    output = print
};
local u15 = {};

local function replicate_to_player(p16, p17) -- Line: 59
    -- upvalues: u8 (copy), u7 (copy), u5 (copy)
    local v18 = u8.obtain_user_key(p16);
    local v19 = u7.users[v18];

    if not v19 then
        return;
    end;

    if not u8.has_permissions(v19, unpack(p17.permissions)) then
        return;
    end;

    u5.server.fire_register_command(p16, {
        name = p17.name,
        description = p17.description,
        permissions = p17.permissions,
        arguments = p17.arguments
    });
end;

local u20 = false;

local function register_command(u21, u22) -- Line: 122
    -- upvalues: u15 (copy), u12 (copy), u11 (copy), u7 (copy), u13 (copy), u9 (copy), Players (copy), replicate_to_player (copy)
    local u23 = { u22.arguments() } or { {
            kind = "varargs",
            type = "any",
            name = "...",
            description = "unspecified"
        } };
    local u24 = {};
    local v25 = {};

    for i, v in u23 do
        local v26 = u15[v.type] or (warn((`no argument of type "{v.type}" is registered`)) or u15.any);
        local v27 = table.clone(v26.analysis);
        u24[i] = v26.convert;
        v25[i] = {
            kind = v.kind == "varargs" and "variadic" or "argument",
            optional = v.optional,
            name = v.name or v27.name,
            description = v.description,
            type = v27.type,
            suggestion_generator = v27.suggestion_generator
        };
    end;

    local v28 = {
        dirty_replicate = true,
        name = u21,
        description = u22.description,
        permissions = u22.permissions,
        arguments = u23,
        type_info = {
            kind = "command",
            name = u21,
            description = u22.description,
            arguments = v25
        },
        callback = u22.callback
    };
    u12[u21] = v28;

    u11.commands[u21] = function(...) -- Line: 183
        -- upvalues: u23 (copy), u24 (copy), u22 (copy), u7 (ref), u13 (ref), u21 (copy)
        local u29 = { ... };

        local function move(p30, ...) -- Line: 186
            -- upvalues: u29 (copy)
            for i = 0, select("#", ...) - 1 do
                u29[i + p30] = select(i + 1, ...);
            end;
        end;

        local v31 = nil;
        local v32 = nil;

        for i, v in u23 do
            if v.variadic then
                v31 = u24[i];
                v32 = i;
                break;
            end;

            if v.optional and select(i, ...) == nil then
                u29[i] = nil;
            else
                u29[i] = u24[i]((select(i, ...)));
            end;
        end;

        if v31 and v32 then
            for i = v32 + 1, select("#", ...) do
                u29[i] = v31((select(i, ...)));
            end;
        end;

        local v33 = { pcall(u22.callback, unpack(u29, 1, select("#", ...))) };
        local v34 = table.remove(v33, 1);
        local v35 = u7.command_context[coroutine.running()];
        local v36 = {
            ok = v34
        };

        if v35 then
            v35 = v35.executor;
        end;

        v36.who = v35;
        v36.command = u21;
        v36.arguments = u29;
        v36.result = v33;
        u13:fire(v36);

        if not v34 then
            error(v33[2]);
        end;

        return unpack(v33);
    end;

    if u9 then
        for _, v in Players:GetPlayers() do
            replicate_to_player(v, v28);
        end;
    end;

    return v28;
end;

return {
    console = u14,

    register_quick = function(p37, p38, ...) -- Line: 240, Name: register
        -- upvalues: register_command (copy)
        register_command(p37, {
            name = p37,
            callback = p38,

            arguments = function() -- Line: 244
            end,

            permissions = { ... }
        });
    end,

    register_command = register_command,
    replicate_to_player = replicate_to_player,

    execute = function(p39) -- Line: 86, Name: execute
        -- upvalues: u1 (copy), u20 (ref), u14 (copy), u2 (copy), u10 (copy), u11 (copy)
        local v40 = u1(p39, false);
        assert(v40.status ~= "pending", "unfinished block");
        assert(not u20, "already executing!");
        u14.output({
            kind = "info",
            text = `> {v40.src}`
        });

        if v40.status == "error" then
            return u14.output({
                kind = "error",
                text = v40.why
            });
        end;

        u20 = true;
        local v41 = u2(v40.value, u10);
        u10.instructions = {};
        (function(p42, p43, ...) -- Line: 101, Name: on_complete
            -- upvalues: u14 (ref)
            if p42 then
                for i = 1, select("#", ...) do
                    local output = u14.output;
                    local v44 = {
                        kind = "normal"
                    };
                    local v45 = select(i, ...);
                    v44.text = tostring(v45);
                    output(v44);
                end;

                return;
            end;

            u14.output({
                kind = "error",
                text = tostring(p43)
            });
        end)(pcall(u11.run, v41));
        u20 = false;
    end,

    analyze = function(p46, p47) -- Line: 249, Name: analyze
        -- upvalues: u12 (copy), u11 (copy), u10 (copy), u4 (copy)
        local v48 = {};
        local v49 = 1;
        local v50 = {};

        for _, v in u12 do
            v48[v49] = v.type_info;
            v49 = v49 + 1;
        end;

        for i, v in u11.globals do
            v50[i] = v;
        end;

        for i, v in u10.locals do
            v50[v] = u11.locals[i];
        end;

        return u4.generate_analysis_info({
            code = p46,
            where = p47,
            variables = v50,
            commands = v48
        });
    end,

    write_global = function(p51, p52) -- Line: 51, Name: write_global
        -- upvalues: u7 (copy), u11 (copy)
        assert(u7.local_user, "cannot set global on server");
        local v53 = string.match(p51, "^[A-z%-@_]*$");
        local v54 = `{p51} is not a valid name`;
        assert(v53, v54);
        u11.globals[p51] = p52;
    end,

    after_command_run = u13,

    register_type = function(u55, p56) -- Line: 30, Name: register_type
        -- upvalues: u15 (copy)
        u15[u55] = p56;

        return function(p57, p58) -- Line: 40
            -- upvalues: u55 (copy)
            return {
                optional = false,
                kind = "arg",
                name = p57,
                description = p58,
                type = u55
            };
        end;
    end,

    get_type = function(p59) -- Line: 57, Name: get_type
        -- upvalues: u15 (copy)
        return u15[p59];
    end,

    ast = u1
};