--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Signal
  Path:     game.ReplicatedStorage.Library.Imported.Signal
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:42:59 2026
]]

-- Decompiled with Potassium's decompiler.

local function assert(p1, p2) -- Line: 67
    if p1 then
        return;
    end;

    error(p2, 3);
end;

local u3 = {};
local u4 = {};
u4.__index = u4;
local u5 = {};
u5.__index = u5;

function u4.new(p6) -- Line: 89
    -- upvalues: u4 (copy), u3 (ref)
    local v7 = {
        _active = true,
        _head = nil,
        _name = typeof(p6) == "string" and p6 and p6 or ""
    };
    local v8 = setmetatable(v7, u4);
    u3[v8._name] = v8;

    return v8;
end;

function u4.Fire(p9, ...) -- Line: 104
    -- upvalues: u4 (copy)
    local v10 = u4:GetSignal(p9);

    if v10 then
        return v10:Call(...);
    end;

    for _ = 1, 7 do
        v10 = u4:GetSignal(p9);

        if v10 then
            break;
        end;

        task.wait(1);
    end;

    if v10 then
        return v10:Call(...);
    end;

    warn("SIGNAL:", p9, "is not a valid Signal");
end;

function u4.GetSignal(p11, p12) -- Line: 125
    -- upvalues: u3 (ref)
    return u3[p12];
end;

function u4.IsActive(p13) -- Line: 129
    return p13._active == true;
end;

local function Connect(p14, p15, p16) -- Line: 133
    -- upvalues: u5 (copy)
    if p14._active == false then
        return setmetatable({
            Connected = false
        }, u5);
    end;

    local _head = p14._head;
    local v17 = setmetatable({
        Connected = true,
        _prev = nil,
        _func = p15,
        _signal = p14,
        _next = _head,
        _is_wait = p16
    }, u5);

    if _head ~= nil then
        _head._prev = v17;
    end;

    p14._head = v17;

    return v17;
end;

function u4.Connect(p18, p19) -- Line: 166
    -- upvalues: Connect (copy)
    local v20 = typeof(p19) == "function";
    local v21 = ":Connect must be called with a function -" .. p18._name;

    if not v20 then
        error(v21, 3);
    end;

    return Connect(p18, p19);
end;

function u4.ConnectParallel(p22, u23) -- Line: 175
    -- upvalues: Connect (copy)
    local v24 = typeof(u23) == "function";
    local v25 = ":ConnectParallel must be called with a function -" .. p22._name;

    if not v24 then
        error(v25, 3);
    end;

    return Connect(p22, function(...) -- Line: 181
        -- upvalues: u23 (copy)
        task.desynchronize();
        u23(...);
    end);
end;

function u5.Disconnect(p26) -- Line: 187
    -- upvalues: u3 (ref)
    if p26.Connected == false then
        return;
    end;

    p26.Connected = false;
    local _signal = p26._signal;
    local _next = p26._next;
    local _prev = p26._prev;
    u3[p26._name] = nil;

    if _next ~= nil then
        _next._prev = _prev;
    end;

    if _prev == nil then
        _signal._head = _next;
    else
        _prev._next = _next;
    end;

    p26._func = nil;
    p26._signal = nil;
    p26._next = nil;
    p26._prev = nil;
end;

function u4.Wait(p27) -- Line: 220
    -- upvalues: Connect (copy)
    Connect(p27, coroutine.running(), true);

    return coroutine.yield();
end;

function u4.Call(p28, ...) -- Line: 230
    if p28._active == false then
        warn("Tried to :Fire destroyed signal -" .. p28._name);

        return;
    end;

    local _head = p28._head;

    while _head ~= nil do
        task.defer(_head._func, ...);
        local v29;

        if _head._is_wait then
            v29 = _head._next;
            _head:Disconnect();
        else
            v29 = _head._next;
        end;

        _head = v29;
    end;
end;

function u4.DisconnectAll(p30) -- Line: 256
    -- upvalues: u3 (ref)
    u3 = {};
    local _head = p30._head;

    while _head ~= nil do
        local _next = _head._next;
        _head:Disconnect();
        _head = _next;
    end;
end;

function u4.Destroy(p31) -- Line: 268
    if p31._active == false then
        return;
    end;

    p31._active = false;
    p31:DisconnectAll();
end;

function u4.GetName(p32) -- Line: 277
    return p32._name;
end;

function u4.SetName(p33, p34) -- Line: 281
    if typeof(p34) ~= "string" then
        error("Name must be a string!", 3);
    end;

    p33._name = p34;
end;

function u4.__tostring(p35) -- Line: 290
    return "Signal " .. p35._name;
end;

function u4.__call(p36, p37, p38) -- Line: 298
    -- upvalues: u5 (copy), Connect (copy)
    local v39 = typeof(p38) == "function";
    local v40 = ":Connect must be called with a function -" .. p36._name;

    if not v39 then
        error(v40, 3);
    end;

    if p36._active == false then
        return setmetatable({
            Connected = false
        }, u5);
    end;

    return Connect(p36, p38);
end;

return u4;