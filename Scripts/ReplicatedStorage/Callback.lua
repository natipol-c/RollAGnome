--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Callback
  Path:     game.ReplicatedStorage.Library.Imported.Network.Callback
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:32 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    __index = {}
};
local u2 = {};

local function SignalCallback(p3, p4) -- Line: 8
    -- upvalues: u2 (copy)
    while true do
        p4(coroutine.yield());
        u2[p3] = nil;
    end;
end;

local u5 = {};

local function AsyncCallback(p6, p7) -- Line: 19
    -- upvalues: u5 (copy)
    local v8 = table.pack(true, p7(coroutine.yield()));
    local v9 = u5[p6];

    if v9 and not v9.result then
        v9.result = v8;

        if v9.waiting then
            task.spawn(v9.waiting);
        end;
    end;
end;

task.spawn(function() -- Line: 32
    -- upvalues: u5 (copy)
    while true do
        task.wait();

        for i, v in pairs(u5) do
            if not v.result and coroutine.status(i) == "dead" then
                v.result = { false };

                if v.waiting then
                    task.defer(v.waiting);
                end;
            end;
        end;
    end;
end);

local function SignalCreator(p10) -- Line: 50
    local v11 = coroutine.yield();

    while true do
        local v12 = coroutine.create(v11);
        coroutine.resume(v12, v12, p10);
        v11 = coroutine.yield(v12);
    end;
end;

function u1.__index.Execute(p13, ...) -- Line: 62
    -- upvalues: SignalCallback (copy), u2 (copy)
    local thread = p13.thread;

    if thread then
        p13.thread = nil;
    else
        local v14;
        v14, thread = coroutine.resume(p13.creator, SignalCallback);
    end;

    u2[thread] = true;
    task.spawn(thread, ...);

    if u2[thread] then
        u2[thread] = nil;

        return;
    end;

    p13.thread = thread;
end;

function u1.__index.ExecuteAsync(p15, ...) -- Line: 82
    -- upvalues: AsyncCallback (copy), u5 (copy)
    local _, v16 = coroutine.resume(p15.creator, AsyncCallback);
    local v17 = {
        result = nil,
        waiting = nil
    };
    u5[v16] = v17;
    task.spawn(v16, ...);

    if not v17.result then
        v17.waiting = coroutine.running();
        coroutine.yield();
    end;

    u5[v16] = nil;

    return v17.result;
end;

function u1.new(p18) -- Line: 102
    -- upvalues: SignalCreator (copy), u1 (copy)
    local v19 = coroutine.create(SignalCreator);
    coroutine.resume(v19, p18);

    return setmetatable({
        thread = nil,
        fn = p18,
        creator = v19
    }, u1);
end;

return u1;