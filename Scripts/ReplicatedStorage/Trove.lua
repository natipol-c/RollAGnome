--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Trove
  Path:     game.ReplicatedStorage.Library.Imported.Trove
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:00 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local u1 = newproxy();
local u2 = newproxy();
local u3 = table.freeze({ "Destroy", "Disconnect", "destroy", "disconnect" });

local function GetObjectCleanupFunction(p4, p5) -- Line: 125
    -- upvalues: u1 (copy), u2 (copy), u3 (copy)
    local v6 = typeof(p4);

    if v6 == "function" then
        return u1;
    end;

    if v6 == "thread" then
        return u2;
    end;

    if p5 then
        return p5;
    end;

    if v6 == "Instance" then
        return "Destroy";
    end;

    if v6 == "RBXScriptConnection" then
        return "Disconnect";
    end;

    if v6 == "table" then
        for _, v in u3 do
            if typeof(p4[v]) == "function" then
                return v;
            end;
        end;
    end;

    error(`failed to get cleanup function for object {v6}: {p4}`, 3);
end;

local function AssertPromiseLike(p7) -- Line: 153
    if typeof(p7) ~= "table" or (typeof(p7.getStatus) ~= "function" or (typeof(p7.finally) ~= "function" or typeof(p7.cancel) ~= "function")) then
        error("did not receive a promise as an argument", 3);
    end;
end;

local u8 = {};
u8.__index = u8;

function u8.new() -- Line: 180
    -- upvalues: u8 (copy)
    local v9 = setmetatable({}, u8);
    v9._objects = {};
    v9._cleaning = false;

    return v9;
end;

function u8.Add(p10, p11, p12) -- Line: 239
    -- upvalues: GetObjectCleanupFunction (copy)
    if p10._cleaning then
        error("cannot call trove:Add() while cleaning", 2);
    end;

    local v13 = { p11, (GetObjectCleanupFunction(p11, p12)) };
    table.insert(p10._objects, v13);

    return p11;
end;

function u8.Clone(p14, p15) -- Line: 261
    if p14._cleaning then
        error("cannot call trove:Clone() while cleaning", 2);
    end;

    return p14:Add(p15:Clone());
end;

function u8.Construct(p16, p17, ...) -- Line: 304
    if p16._cleaning then
        error("Cannot call trove:Construct() while cleaning", 2);
    end;

    local v18 = nil;
    local v19 = type(p17);

    if v19 == "table" then
        v18 = p17.new(...);
    elseif v19 == "function" then
        v18 = p17(...);
    end;

    return p16:Add(v18);
end;

function u8.Connect(p20, p21, p22) -- Line: 337
    if p20._cleaning then
        error("Cannot call trove:Connect() while cleaning", 2);
    end;

    return p20:Add(p21:Connect(p22));
end;

function u8.BindToRenderStep(p23, u24, p25, p26) -- Line: 360
    -- upvalues: RunService (copy)
    if p23._cleaning then
        error("cannot call trove:BindToRenderStep() while cleaning", 2);
    end;

    RunService:BindToRenderStep(u24, p25, p26);
    p23:Add(function() -- Line: 367
        -- upvalues: RunService (ref), u24 (copy)
        RunService:UnbindFromRenderStep(u24);
    end);
end;

function u8.AddPromise(u27, u28) -- Line: 397
    if u27._cleaning then
        error("cannot call trove:AddPromise() while cleaning", 2);
    end;

    if typeof(u28) ~= "table" or (typeof(u28.getStatus) ~= "function" or (typeof(u28.finally) ~= "function" or typeof(u28.cancel) ~= "function")) then
        error("did not receive a promise as an argument", 3);
    end;

    if u28:getStatus() == "Started" then
        u28:finally(function() -- Line: 404
            -- upvalues: u27 (copy), u28 (copy)
            if u27._cleaning then
                return;
            end;

            u27:_findAndRemoveFromObjects(u28, false);
        end);
        u27:Add(u28, "cancel");
    end;

    return u28;
end;

function u8.Remove(p29, p30) -- Line: 429
    if p29._cleaning then
        error("cannot call trove:Remove() while cleaning", 2);
    end;

    return p29:_findAndRemoveFromObjects(p30, true);
end;

function u8.Extend(p31) -- Line: 458
    -- upvalues: u8 (copy)
    if p31._cleaning then
        error("cannot call trove:Extend() while cleaning", 2);
    end;

    return p31:Construct(u8);
end;

function u8.Clean(p32) -- Line: 478
    if p32._cleaning then
        return;
    end;

    p32._cleaning = true;

    for _, v in p32._objects do
        p32:_cleanupObject(v[1], v[2]);
    end;

    table.clear(p32._objects);
    p32._cleaning = false;
end;

function u8.WrapClean(u33) -- Line: 520
    return function() -- Line: 521
        -- upvalues: u33 (copy)
        u33:Clean();
    end;
end;

function u8._findAndRemoveFromObjects(p34, p35, p36) -- Line: 526
    local _objects = p34._objects;

    for i, v in _objects do
        if v[1] == p35 then
            local v37 = #_objects;
            _objects[i] = _objects[v37];
            _objects[v37] = nil;

            if p36 then
                p34:_cleanupObject(v[1], v[2]);
            end;

            return true;
        end;
    end;

    return false;
end;

function u8._cleanupObject(p38, p39, p40) -- Line: 546
    -- upvalues: u1 (copy), u2 (copy)
    if p40 == u1 then
        task.spawn(p39);

        return;
    end;

    if p40 == u2 then
        pcall(task.cancel, p39);

        return;
    end;

    p39[p40](p39);
end;

function u8.AttachToInstance(u41, p42) -- Line: 586
    if u41._cleaning then
        error("cannot call trove:AttachToInstance() while cleaning", 2);
    elseif not p42:IsDescendantOf(game) then
        error("instance is not a descendant of the game hierarchy", 2);
    end;

    return u41:Connect(p42.Destroying, function() -- Line: 593
        -- upvalues: u41 (copy)
        u41:Destroy();
    end);
end;

function u8.Destroy(p43) -- Line: 607
    p43:Clean();
end;

return {
    new = u8.new
};