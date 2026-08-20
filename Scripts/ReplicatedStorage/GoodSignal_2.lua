--[[
  Type:     ModuleScript
  Method:   cached
  Name:     GoodSignal
  Path:     game.ReplicatedStorage.SatchelLoader.Satchel.Packages._Index.1foreverhd_topbarplus@3.3.1.topbarplus.Packages.GoodSignal
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:05 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = nil;

local function acquireRunnerThreadAndCallEventHandler(p2, ...) -- Line: 34
    -- upvalues: u1 (ref)
    local v3 = u1;
    u1 = nil;
    p2(...);
    u1 = v3;
end;

local function runEventHandlerInFreeThread() -- Line: 45
    -- upvalues: acquireRunnerThreadAndCallEventHandler (copy)
    while true do
        acquireRunnerThreadAndCallEventHandler(coroutine.yield());
    end;
end;

local u4 = {};
u4.__index = u4;

function u4.new(p5, p6) -- Line: 60
    -- upvalues: u4 (copy)
    return setmetatable({
        _connected = true,
        _next = false,
        _signal = p5,
        _fn = p6
    }, u4);
end;

function u4.Disconnect(p7) -- Line: 69
    p7._connected = false;

    if p7._signal._handlerListHead == p7 then
        p7._signal._handlerListHead = p7._next;

        return;
    end;

    local _handlerListHead = p7._signal._handlerListHead;

    while _handlerListHead and _handlerListHead._next ~= p7 do
        _handlerListHead = _handlerListHead._next;
    end;

    if _handlerListHead then
        _handlerListHead._next = p7._next;
    end;
end;

u4.Destroy = u4.Disconnect;
setmetatable(u4, {
    __index = function(p8, p9) -- Line: 92, Name: __index
        error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p9))), 2);
    end,

    __newindex = function(p10, p11, p12) -- Line: 95, Name: __newindex
        error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p11))), 2);
    end
});
local u13 = {};
u13.__index = u13;

function u13.new() -- Line: 104
    -- upvalues: u13 (copy)
    return setmetatable({
        _handlerListHead = false
    }, u13);
end;

function u13.Connect(p14, p15) -- Line: 110
    -- upvalues: u4 (copy)
    local v16 = u4.new(p14, p15);

    if not p14._handlerListHead then
        p14._handlerListHead = v16;

        return v16;
    end;

    v16._next = p14._handlerListHead;
    p14._handlerListHead = v16;

    return v16;
end;

function u13.DisconnectAll(p17) -- Line: 123
    p17._handlerListHead = false;
end;

u13.Destroy = u13.DisconnectAll;

function u13.Fire(p18, ...) -- Line: 132
    -- upvalues: u1 (ref), runEventHandlerInFreeThread (copy)
    local _handlerListHead = p18._handlerListHead;

    while _handlerListHead do
        if _handlerListHead._connected then
            if not u1 then
                u1 = coroutine.create(runEventHandlerInFreeThread);
                coroutine.resume(u1);
            end;

            task.spawn(u1, _handlerListHead._fn, ...);
        end;

        _handlerListHead = _handlerListHead._next;
    end;
end;

function u13.Wait(p19) -- Line: 149
    local u20 = coroutine.running();
    local u21 = nil;
    u21 = p19:Connect(function(...) -- Line: 152
        -- upvalues: u21 (ref), u20 (copy)
        u21:Disconnect();
        task.spawn(u20, ...);
    end);

    return coroutine.yield();
end;

function u13.Once(p22, u23) -- Line: 161
    local u24 = nil;
    u24 = p22:Connect(function(...) -- Line: 163
        -- upvalues: u24 (ref), u23 (copy)
        if u24._connected then
            u24:Disconnect();
        end;

        u23(...);
    end);

    return u24;
end;

setmetatable(u13, {
    __index = function(p25, p26) -- Line: 174, Name: __index
        error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(p26))), 2);
    end,

    __newindex = function(p27, p28, p29) -- Line: 177, Name: __newindex
        error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(p28))), 2);
    end
});

return u13;