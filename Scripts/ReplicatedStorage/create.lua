--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     create
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.centau_vide@0.3.1.vide.create
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

local u1 = game and typeof or require("test/mock").typeof;
local u2 = game and Instance or require("test/mock").Instance;
local throw = require(script.Parent.throw);
local defaults = require(script.Parent.defaults);
local apply = require(script.Parent.apply);
local u3 = {};
setmetatable(u3, {
    __index = function(p4, p5) -- Line: 12, Name: __index
        -- upvalues: u2 (copy), throw (copy), defaults (copy), apply (copy)
        local success, result = pcall(u2.new, p5);

        if not success then
            throw((`invalid class name, could not create instance of class {p5}`));
        end;

        local v6 = defaults[p5];

        if v6 then
            for i, v in next, v6 do
                result[i] = v;
            end;
        end;

        local function ctor(p7) -- Line: 23
            -- upvalues: apply (ref), result (copy)
            return apply(result:Clone(), p7);
        end;

        p4[p5] = ctor;

        return ctor;
    end
});

local function create_instance(p8) -- Line: 32
    -- upvalues: u3 (copy)
    return u3[p8];
end;

local function clone_instance(u9) -- Line: 36
    -- upvalues: throw (copy), apply (copy)
    return function(p10) -- Line: 37
        -- upvalues: u9 (copy), throw (ref), apply (ref)
        local v11 = u9:Clone();

        if not v11 then
            throw("attempt to clone a non-archivable instance");
        end;

        return apply(v11, p10);
    end;
end;

return function(u12) -- Line: 44, Name: create
    -- upvalues: u3 (copy), u1 (copy), throw (copy), apply (copy)
    if type(u12) == "string" then
        return u3[u12];
    end;

    if u1(u12) == "Instance" then
        return function(p13) -- Line: 37
            -- upvalues: u12 (copy), throw (ref), apply (ref)
            local v14 = u12:Clone();

            if not v14 then
                throw("attempt to clone a non-archivable instance");
            end;

            return apply(v14, p13);
        end;
    end;

    throw("bad argument #1, expected string or instance, got " .. u1(u12));

    return nil;
end;