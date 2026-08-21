--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     bootstrap
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.alicesaidhi+conch.0.2.5-rc.2.conch.src.bootstrap
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:33 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local u1 = require("./arguments");
local u2 = require("./console");
local u3 = require("./state");
require("./types");
local u4 = RunService:IsClient();

local function output(p5) -- Line: 37
    -- upvalues: u2 (copy)
    u2.console.output(p5);
end;

local function concat(...) -- Line: 39
    local v6 = { ... };

    for i, v in v6 do
        v6[i] = tostring(v);
    end;

    return table.concat(v6, " ");
end;

local function print(...) -- Line: 47
    -- upvalues: concat (copy), u2 (copy)
    local v7 = {
        kind = "normal",
        text = concat(...)
    };
    u2.console.output(v7);
end;

local function error(...) -- Line: 52
    -- upvalues: concat (copy), error (copy)
    error(concat(...), 0);
end;

local function warn(...) -- Line: 57
    -- upvalues: concat (copy), u2 (copy)
    local v8 = {
        kind = "warn",
        text = concat(...)
    };
    u2.console.output(v8);
end;

local function info(...) -- Line: 62
    -- upvalues: concat (copy), u2 (copy)
    local v9 = {
        kind = "info",
        text = concat(...)
    };
    u2.console.output(v9);
end;

if u4 then
    u2.register_command("license", {
        description = "Outputs the license to the console.",
        permissions = {},

        arguments = function() -- Line: 71, Name: arguments
        end,

        callback = function() -- Line: 72, Name: callback
            -- upvalues: u2 (copy)
            for _, v in string.split(
                "MIT License\n\nCopyright (c) 2025 alicesays_hallo\n\nPermission is hereby granted, free of charge, to any person obtaining a copy\nof this software and associated documentation files (the \"Software\"), to deal\nin the Software without restriction, including without limitation the rights\nto use, copy, modify, merge, publish, distribute, sublicense, and/or sell\ncopies of the Software, and to permit persons to whom the Software is\nfurnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all\ncopies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\nIMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\nFITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\nAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\nLIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\nOUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE\nSOFTWARE.",
                "\n"
            ) do
                u2.console.output({
                    kind = "normal",
                    text = v
                });
            end;
        end
    });
end;

return function() -- Line: 80
    -- upvalues: print (copy), RunService (copy), u3 (copy), u4 (copy), u2 (copy), u1 (copy), error (copy), warn (copy), info (copy)
    local function internal() -- Line: 81
        -- upvalues: print (ref), RunService (ref), u3 (ref)
        print((`CONCH INTERNAL INFORMATION - {RunService:IsClient() and "CLIENT" or (RunService:IsServer() and "SERVER" or "?")}`));
        print("");
        print("REGISTERED ROLES:");

        for i, v in u3.roles do
            print((`[{i}]: {table.concat(v, ", ")}`));
        end;

        print("");
        print("REGISTERED COMMANDS");
    end;

    local function set(p10, p11, p12) -- Line: 97
        p10[p11] = p12;
    end;

    if u4 then
        u2.register_command("print", {
            description = "Converts the given arguments into a string and sends it to the output",
            permissions = {},

            arguments = function() -- Line: 104, Name: arguments
                -- upvalues: u1 (ref)
                return u1.variadic(u1.any("any", "Arguments to output"));
            end,

            callback = print
        });
        u2.register_command("sleep", {
            description = "Waits for a given amount of time before continuing execution",

            arguments = function() -- Line: 112, Name: arguments
                -- upvalues: u1 (ref)
                return u1.number("time", "The amount of time to sleep for");
            end,

            callback = task.wait
        });
        u2.register_command("pairs", {
            description = "Iterates over a table",

            arguments = function() -- Line: 120, Name: arguments
                -- upvalues: u1 (ref)
                return u1.table("t", "Table to iterate over");
            end,

            callback = function(u13) -- Line: 123, Name: callback
                local u14 = pairs(u13);
                local u15 = nil;

                return function() -- Line: 127
                    -- upvalues: u14 (copy), u13 (copy), u15 (ref)
                    local v16, v17 = u14(u13, u15);
                    u15 = v16;

                    return v16, v17;
                end;
            end
        });
        u2.register_command("ipairs", {
            description = "Iterates over an array",

            arguments = function() -- Line: 137, Name: arguments
                -- upvalues: u1 (ref)
                return u1.table("t", "Table to iterate over");
            end,

            callback = function(u18) -- Line: 140, Name: callback
                local u19 = ipairs(u18);
                local u20 = 0;

                return function() -- Line: 144
                    -- upvalues: u19 (copy), u18 (copy), u20 (ref)
                    local v21, v22 = u19(u18, u20);
                    u20 = v21;

                    return v21, v22;
                end;
            end
        });
        u2.register_quick("error", error);
        u2.register_quick("warn", warn);
        u2.register_quick("info", info);
        u2.register_command("set", {
            description = "Attempts to set the given key and value onto the given object",
            permissions = {},

            arguments = function() -- Line: 158, Name: arguments
                -- upvalues: u1 (ref)
                return u1.any("object", "the object to set"), u1.any("key", "key of the object"), u1.any("value", "the value to set it to");
            end,

            callback = set
        });
    end;
end;