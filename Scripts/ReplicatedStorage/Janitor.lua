--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Janitor
  Path:     game.ReplicatedStorage.Library.Imported.TopbarPlus.Packages.Janitor
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:06 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local Heartbeat = RunService.Heartbeat;

local function getPromiseReference() -- Line: 25
    -- upvalues: RunService (copy)
    if RunService:IsRunning() then
        return require(game:GetService("ReplicatedStorage").Framework).modules.Promise;
    end;
end;

local u1 = newproxy(true);

getmetatable(u1).__tostring = function() -- Line: 33
    return "IndicesReference";
end;

local u2 = newproxy(true);

getmetatable(u2).__tostring = function() -- Line: 38
    return "LinkToInstanceIndex";
end;

local u3 = {
    IGNORE_MEMORY_DEBUG = true,
    ClassName = "Janitor",
    __index = {
        CurrentlyCleaning = true,
        [u1] = nil
    }
};
local u4 = {
    ["function"] = true,
    Promise = "cancel",
    RBXScriptConnection = "Disconnect"
};

function u3.new() -- Line: 64
    -- upvalues: u1 (copy), u3 (copy)
    return setmetatable({
        CurrentlyCleaning = false,
        [u1] = nil
    }, u3);
end;

function u3.Is(p5) -- Line: 76
    -- upvalues: u3 (copy)
    local v6;

    if type(p5) == "table" then
        v6 = getmetatable(p5) == u3;
    else
        v6 = false;
    end;

    return v6;
end;

u3.is = u3.Is;

function u3.__index.Add(p7, p8, p9, p10) -- Line: 89
    -- upvalues: u1 (copy), u4 (copy)
    if p10 then
        p7:Remove(p10);
        local v11 = p7[u1];

        if not v11 then
            v11 = {};
            p7[u1] = v11;
        end;

        v11[p10] = p8;
    end;

    local v12 = typeof(p8);
    local v13 = p9 or (u4[v12 == "table" and string.match(tostring(p8), "Promise") and "Promise" or v12] or "Destroy");

    if type(p8) ~= "function" and not p8[v13] then
        warn(string.format("Object %s doesn\'t have method %s, are you sure you want to add it? Traceback: %s", tostring(p8), tostring(v13), debug.traceback(nil, 2)));
    end;

    p7[p8] = { v13, (debug.traceback("")) };

    return p8;
end;

u3.__index.Give = u3.__index.Add;

function u3.__index.AddPromise(p14, u15) -- Line: 126
    -- upvalues: RunService (copy)
    local v16;

    if RunService:IsRunning() then
        v16 = require(game:GetService("ReplicatedStorage").Framework).modules.Promise;
    else
        v16 = nil;
    end;

    if not v16 then
        return u15;
    end;

    if not v16.is(u15) then
        error(string.format("Invalid argument #1 to \'Janitor:AddPromise\' (Promise expected, got %s (%s))", typeof(u15), (tostring(u15))));
    end;

    if u15:getStatus() ~= v16.Status.Started then
        return u15;
    end;

    local v17 = newproxy(false);
    local v21 = p14:Add(v16.new(function(p18, p19, p20) -- Line: 134
        -- upvalues: u15 (copy)
        if p20(function() -- Line: 135
            -- upvalues: u15 (ref)
            u15:cancel();
        end) then
            return;
        end;

        p18(u15);
    end), "cancel", v17);
    v21:finallyCall(p14.Remove, p14, v17);

    return v21;
end;

u3.__index.GivePromise = u3.__index.AddPromise;

function u3.__index.AddObject(p22, p23) -- Line: 156
    -- upvalues: RunService (copy)
    local v24 = newproxy(false);
    local v25;

    if RunService:IsRunning() then
        v25 = require(game:GetService("ReplicatedStorage").Framework).modules.Promise;
    else
        v25 = nil;
    end;

    if not (v25 and v25.is(p23)) then
        return p22:Add(p23, false, v24), v24;
    end;

    if p23:getStatus() ~= v25.Status.Started then
        return p23;
    end;

    local v26 = p22:Add(v25.resolve(p23), "cancel", v24);
    v26:finallyCall(p22.Remove, p22, v24);

    return v26, v24;
end;

u3.__index.GiveObject = u3.__index.AddObject;

function u3.__index.Remove(p27, p28) -- Line: 179
    -- upvalues: u1 (copy)
    local v29 = p27[u1];
    local v30 = v29 and v29[p28];

    if v30 then
        local v31 = p27[v30];

        if v31 then
            v31 = v31[1];
        end;

        if v31 then
            if v31 == true then
                v30();
            else
                local v32 = v30[v31];

                if v32 then
                    v32(v30);
                end;
            end;

            p27[v30] = nil;
        end;

        v29[p28] = nil;
    end;

    return p27;
end;

function u3.__index.Get(p33, p34) -- Line: 213
    -- upvalues: u1 (copy)
    local v35 = p33[u1];

    if v35 then
        return v35[p34];
    end;
end;

function u3.__index.Cleanup(p36) -- Line: 224
    -- upvalues: u1 (copy)
    if not p36.CurrentlyCleaning then
        p36.CurrentlyCleaning = nil;

        for i, v in next, p36 do
            if i ~= u1 then
                local v37 = type(i);

                if v37 == "string" or v37 == "number" then
                    p36[i] = nil;
                else
                    local v38 = v[1];
                    local u39 = v[2];

                    local function warnUser(p40) -- Line: 241
                        -- upvalues: u39 (copy)
                        local v41 = debug.traceback("", 3);
                        warn("-------- Janitor Error --------" .. "\n" .. tostring(p40) .. "\n" .. v41 .. "" .. u39);
                    end;

                    if v38 == true then
                        local success, result = pcall(i);

                        if not success then
                            local v42 = debug.traceback("", 3);
                            warn("-------- Janitor Error --------" .. "\n" .. tostring(result) .. "\n" .. v42 .. "" .. u39);
                        end;
                    else
                        local v43 = i[v38];

                        if v43 then
                            local success, result = pcall(v43, i);
                            local v44;

                            if typeof(i) == "Instance" then
                                v44 = v43 == "Destroy";
                            else
                                v44 = false;
                            end;

                            if not (success or v44) then
                                local v45 = debug.traceback("", 3);
                                warn("-------- Janitor Error --------" .. "\n" .. tostring(result) .. "\n" .. v45 .. "" .. u39);
                            end;
                        end;
                    end;

                    p36[i] = nil;
                end;
            end;
        end;

        local v46 = p36[u1];

        if v46 then
            for i in next, v46 do
                v46[i] = nil;
            end;

            p36[u1] = {};
        end;

        p36.CurrentlyCleaning = false;
    end;
end;

u3.__index.Clean = u3.__index.Cleanup;

function u3.__index.Destroy(p47) -- Line: 284
    p47:Cleanup();
end;

u3.__call = u3.__index.Cleanup;
local u48 = {
    Connected = true
};
u48.__index = u48;

function u48.Disconnect(p49) -- Line: 298
    if p49.Connected then
        p49.Connected = false;
        p49.Connection:Disconnect();
    end;
end;

function u48.__tostring(p50) -- Line: 305
    return "Disconnect<" .. tostring(p50.Connected) .. ">";
end;

function u3.__index.LinkToInstance(u51, p52, p53) -- Line: 315
    -- upvalues: u2 (copy), u48 (copy), Heartbeat (copy)
    local u54 = nil;
    local v55 = p53 and newproxy(false) or u2;
    local u56 = p52.Parent == nil;
    local u57 = setmetatable({}, u48);
    u54 = p52.AncestryChanged:Connect(function(p58, p59) -- Line: 321, Name: ChangedFunction
        -- upvalues: u57 (copy), u56 (ref), Heartbeat (ref), u54 (ref), u51 (copy)
        u56 = u57.Connected and p59 == nil;

        if u56 then
            coroutine.wrap(function() -- Line: 327
                -- upvalues: Heartbeat (ref), u57 (ref), u54 (ref), u51 (ref), u56 (ref)
                Heartbeat:Wait();

                if not u57.Connected then
                    return;
                end;

                if not u54.Connected then
                    u51:Cleanup();

                    return;
                end;

                while u56 and (u54.Connected and u57.Connected) do
                    Heartbeat:Wait();
                end;

                if u57.Connected and u56 then
                    u51:Cleanup();
                end;
            end)();
        end;
    end);
    u57.Connection = u54;

    if u56 then
        local Parent = p52.Parent;

        if u57.Connected then
            if Parent == nil then
                u56 = true;
            else
                u56 = false;
            end;

            if u56 then
                coroutine.wrap(function() -- Line: 327
                    -- upvalues: Heartbeat (ref), u57 (copy), u54 (ref), u51 (copy), u56 (ref)
                    Heartbeat:Wait();

                    if not u57.Connected then
                        return;
                    end;

                    if not u54.Connected then
                        u51:Cleanup();

                        return;
                    end;

                    while u56 and (u54.Connected and u57.Connected) do
                        Heartbeat:Wait();
                    end;

                    if u57.Connected and u56 then
                        u51:Cleanup();
                    end;
                end)();
            end;
        end;
    end;

    return u51:Add(u57, "Disconnect", v55);
end;

function u3.__index.LinkToInstances(p60, ...) -- Line: 363
    -- upvalues: u3 (copy)
    local v61 = u3.new();

    for _, v in ipairs({ ... }) do
        v61:Add(p60:LinkToInstance(v, true), "Disconnect");
    end;

    return v61;
end;

for i, v in next, u3.__index do
    local v62 = string.lower(i);
    local v63 = string.sub(v62, 1, 1) .. string.sub(i, 2);
    u3.__index[v63] = v;
end;

return u3;