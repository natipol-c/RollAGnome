--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Promise
  Path:     game.ReplicatedStorage.Library.Imported.Promise
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:00 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    __mode = "k"
};

local function isCallable(p2) -- Line: 10
    if type(p2) == "function" then
        return true;
    end;

    local v3 = type(p2) == "table" and getmetatable(p2);

    if v3 then
        local v4 = rawget(v3, "__call");

        if type(v4) == "function" then
            return true;
        end;
    end;

    return false;
end;

local function makeEnum(u5, p6) -- Line: 28
    local v7 = {};

    for _, v in ipairs(p6) do
        v7[v] = v;
    end;

    return setmetatable(v7, {
        __index = function(p8, p9) -- Line: 36, Name: __index
            -- upvalues: u5 (copy)
            error(string.format("%s is not in %s!", p9, u5), 2);
        end,

        __newindex = function() -- Line: 39, Name: __newindex
            -- upvalues: u5 (copy)
            error(string.format("Creating new members in %s is not allowed!", u5), 2);
        end
    });
end;

local u10 = {
    Kind = makeEnum("Promise.Error.Kind", { "ExecutionError", "AlreadyCancelled", "NotResolvedInTime", "TimedOut" })
};
u10.__index = u10;

function u10.new(p11, p12) -- Line: 64
    -- upvalues: u10 (ref)
    local v13 = p11 or {};
    local v14 = {
        error = tostring(v13.error) or "[This error has no error text.]",
        trace = v13.trace,
        context = v13.context,
        kind = v13.kind,
        parent = p12,
        createdTick = os.clock(),
        createdTrace = debug.traceback()
    };

    return setmetatable(v14, u10);
end;

function u10.is(p15) -- Line: 77
    if type(p15) == "table" then
        local v16 = getmetatable(p15);

        if type(v16) == "table" then
            local v17;

            if rawget(p15, "error") == nil then
                v17 = false;
            else
                local v18 = rawget(v16, "extend");
                v17 = type(v18) == "function";
            end;

            return v17;
        end;
    end;

    return false;
end;

function u10.isKind(p19, p20) -- Line: 89
    -- upvalues: u10 (ref)
    assert(p20 ~= nil, "Argument #2 to Promise.Error.isKind must not be nil");
    local v21 = u10.is(p19) and p19.kind == p20;

    return v21;
end;

function u10.extend(p22, p23) -- Line: 95
    -- upvalues: u10 (ref)
    local v24 = p23 or {};
    v24.kind = v24.kind or p22.kind;

    return u10.new(v24, p22);
end;

function u10.getErrorChain(p25) -- Line: 103
    local v26 = { p25 };

    while v26[#v26].parent do
        table.insert(v26, v26[#v26].parent);
    end;

    return v26;
end;

function u10.__tostring(p27) -- Line: 113
    local v28 = { string.format("-- Promise.Error(%s) --", p27.kind or "?") };

    for _, v in ipairs(p27:getErrorChain()) do
        table.insert(v28, table.concat({ v.trace or v.error, v.context }, "\n"));
    end;

    return table.concat(v28, "\n");
end;

local function pack(...) -- Line: 137
    return select("#", ...), { ... };
end;

local function packResult(p29, ...) -- Line: 144
    return p29, select("#", ...), { ... };
end;

local function makeErrorHandler(u30) -- Line: 148
    -- upvalues: u10 (ref)
    assert(u30 ~= nil, "traceback is nil");

    return function(p31) -- Line: 151
        -- upvalues: u10 (ref), u30 (copy)
        if type(p31) == "table" then
            return p31;
        end;

        return u10.new({
            error = p31,
            kind = u10.Kind.ExecutionError,
            trace = debug.traceback(tostring(p31), 2),
            context = "Promise created at:\n\n" .. u30
        });
    end;
end;

local function runExecutor(u32, p33, ...) -- Line: 171
    -- upvalues: packResult (copy), u10 (ref)
    local v34 = xpcall;
    assert(u32 ~= nil, "traceback is nil");

    return packResult(v34(p33, function(p35) -- Line: 151
        -- upvalues: u10 (ref), u32 (copy)
        if type(p35) == "table" then
            return p35;
        end;

        return u10.new({
            error = p35,
            kind = u10.Kind.ExecutionError,
            trace = debug.traceback(tostring(p35), 2),
            context = "Promise created at:\n\n" .. u32
        });
    end, ...));
end;

local function createAdvancer(u36, u37, u38, u39) -- Line: 179
    -- upvalues: runExecutor (copy)
    return function(...) -- Line: 180
        -- upvalues: runExecutor (ref), u36 (copy), u37 (copy), u38 (copy), u39 (copy)
        local v40, v41, v42 = runExecutor(u36, u37, ...);

        if v40 then
            u38(unpack(v42, 1, v41));

            return;
        end;

        u39(v42[1]);
    end;
end;

local function isEmpty(p43) -- Line: 191
    return next(p43) == nil;
end;

local u44 = {
    Error = u10,
    Status = makeEnum("Promise.Status", { "Started", "Resolved", "Rejected", "Cancelled" }),
    _getTime = os.clock,
    _timeEvent = game:GetService("RunService").Heartbeat,
    _unhandledRejectionCallbacks = {},
    prototype = {}
};
u44.__index = u44.prototype;

function u44._new(p45, u46, p47) -- Line: 230
    -- upvalues: u44 (copy), u1 (copy), runExecutor (copy)
    if p47 ~= nil and not u44.is(p47) then
        error("Argument #2 to Promise.new must be a promise or nil", 2);
    end;

    local u48 = {
        _thread = nil,
        _values = nil,
        _valuesLength = -1,
        _unhandledRejection = true,
        _cancellationHook = nil,
        _source = p45,
        _status = u44.Status.Started,
        _queuedResolve = {},
        _queuedReject = {},
        _queuedFinally = {},
        _parent = p47,
        _consumers = setmetatable({}, u1)
    };

    if p47 and p47._status == u44.Status.Started then
        p47._consumers[u48] = true;
    end;

    setmetatable(u48, u44);

    local function resolve(...) -- Line: 278
        -- upvalues: u48 (copy)
        u48:_resolve(...);
    end;

    local function reject(...) -- Line: 282
        -- upvalues: u48 (copy)
        u48:_reject(...);
    end;

    local function onCancel(p49) -- Line: 286
        -- upvalues: u48 (copy), u44 (ref)
        if p49 then
            if u48._status == u44.Status.Cancelled then
                p49();
            else
                u48._cancellationHook = p49;
            end;
        end;

        return u48._status == u44.Status.Cancelled;
    end;

    u48._thread = coroutine.create(function() -- Line: 298
        -- upvalues: runExecutor (ref), u48 (copy), u46 (copy), resolve (copy), reject (copy), onCancel (copy)
        local v50, _, v51 = runExecutor(u48._source, u46, resolve, reject, onCancel);

        if not v50 then
            reject(v51[1]);
        end;
    end);
    task.spawn(u48._thread);

    return u48;
end;

function u44.new(p52) -- Line: 349
    -- upvalues: u44 (copy)
    return u44._new(debug.traceback(nil, 2), p52);
end;

function u44.__tostring(p53) -- Line: 353
    return string.format("Promise(%s)", p53._status);
end;

function u44.defer(u54) -- Line: 375
    -- upvalues: u44 (copy), runExecutor (copy)
    local u55 = debug.traceback(nil, 2);

    return u44._new(u55, function(u56, u57, u58) -- Line: 378
        -- upvalues: runExecutor (ref), u55 (copy), u54 (copy)
        task.defer(function() -- Line: 379
            -- upvalues: runExecutor (ref), u55 (ref), u54 (ref), u56 (copy), u57 (copy), u58 (copy)
            local v59, _, v60 = runExecutor(u55, u54, u56, u57, u58);

            if not v59 then
                u57(v60[1]);
            end;
        end);
    end);
end;

u44.async = u44.defer;

function u44.resolve(...) -- Line: 416
    -- upvalues: pack (copy), u44 (copy)
    local u61, u62 = pack(...);

    return u44._new(debug.traceback(nil, 2), function(p63) -- Line: 418
        -- upvalues: u62 (copy), u61 (copy)
        p63(unpack(u62, 1, u61));
    end);
end;

function u44.reject(...) -- Line: 433
    -- upvalues: pack (copy), u44 (copy)
    local u64, u65 = pack(...);

    return u44._new(debug.traceback(nil, 2), function(p66, p67) -- Line: 435
        -- upvalues: u65 (copy), u64 (copy)
        p67(unpack(u65, 1, u64));
    end);
end;

function u44._try(p68, u69, ...) -- Line: 444
    -- upvalues: pack (copy), u44 (copy)
    local u70, u71 = pack(...);

    return u44._new(p68, function(p72) -- Line: 447
        -- upvalues: u69 (copy), u71 (copy), u70 (copy)
        p72(u69(unpack(u71, 1, u70)));
    end);
end;

function u44.try(p73, ...) -- Line: 475
    -- upvalues: u44 (copy)
    return u44._try(debug.traceback(nil, 2), p73, ...);
end;

function u44._all(p74, u75, u76) -- Line: 484
    -- upvalues: u44 (copy)
    if type(u75) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.all"), 3);
    end;

    for i, v in pairs(u75) do
        if not u44.is(v) then
            error(string.format("Non-promise value passed into %s at index %s", "Promise.all", (tostring(i))), 3);
        end;
    end;

    if #u75 == 0 or u76 == 0 then
        return u44.resolve({});
    end;

    return u44._new(p74, function(u77, u78, p79) -- Line: 502
        -- upvalues: u76 (copy), u75 (copy)
        local u80 = {};
        local u81 = {};
        local u82 = 0;
        local u83 = 0;
        local u84 = false;

        local function resolveOne(p85, ...) -- Line: 520
            -- upvalues: u84 (ref), u82 (ref), u76 (ref), u80 (copy), u75 (ref), u77 (copy), u81 (copy)
            if u84 then
                return;
            end;

            u82 = u82 + 1;

            if u76 == nil then
                u80[p85] = ...;
            else
                u80[u82] = ...;
            end;

            if u82 >= (u76 or #u75) then
                u84 = true;
                u77(u80);

                for _, v in ipairs(u81) do
                    v:cancel();
                end;
            end;
        end;

        p79(function() -- Line: 513, Name: cancel
            -- upvalues: u81 (copy)
            for _, v in ipairs(u81) do
                v:cancel();
            end;
        end);

        for i, v in ipairs(u75) do
            u81[i] = v:andThen(function(...) -- Line: 545
                -- upvalues: resolveOne (copy), i (copy)
                resolveOne(i, ...);
            end, function(...) -- Line: 547
                -- upvalues: u83 (ref), u76 (ref), u75 (ref), u81 (copy), u84 (ref), u78 (copy)
                u83 = u83 + 1;

                if u76 == nil or #u75 - u83 < u76 then
                    for _, v2 in ipairs(u81) do
                        v2:cancel();
                    end;

                    u84 = true;
                    u78(...);
                end;
            end);
        end;

        if u84 then
            for _, v in ipairs(u81) do
                v:cancel();
            end;
        end;
    end);
end;

function u44.all(p86) -- Line: 589
    -- upvalues: u44 (copy)
    return u44._all(debug.traceback(nil, 2), p86);
end;

function u44.fold(p87, u88, p89) -- Line: 618
    -- upvalues: u44 (copy)
    local v90 = type(p87) == "table";
    assert(v90, "Bad argument #1 to Promise.fold: must be a table");
    local v91;

    if type(u88) == "function" then
        v91 = true;
    elseif type(u88) == "table" then
        local v92 = getmetatable(u88);

        if v92 then
            local v93 = rawget(v92, "__call");
            v91 = type(v93) == "function";
        else
            v91 = false;
        end;
    else
        v91 = false;
    end;

    assert(v91, "Bad argument #2 to Promise.fold: must be a function");
    local u94 = u44.resolve(p89);

    return u44.each(p87, function(u95, u96) -- Line: 623
        -- upvalues: u94 (ref), u88 (copy)
        u94 = u94:andThen(function(p97) -- Line: 624
            -- upvalues: u88 (ref), u95 (copy), u96 (copy)
            return u88(p97, u95, u96);
        end);
    end):andThen(function() -- Line: 627
        -- upvalues: u94 (ref)
        return u94;
    end);
end;

function u44.some(p98, p99) -- Line: 651
    -- upvalues: u44 (copy)
    local v100 = type(p99) == "number";
    assert(v100, "Bad argument #2 to Promise.some: must be a number");

    return u44._all(debug.traceback(nil, 2), p98, p99);
end;

function u44.any(p101) -- Line: 675
    -- upvalues: u44 (copy)
    return u44._all(debug.traceback(nil, 2), p101, 1):andThen(function(p102) -- Line: 676
        return p102[1];
    end);
end;

function u44.allSettled(u103) -- Line: 697
    -- upvalues: u44 (copy)
    if type(u103) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.allSettled"), 2);
    end;

    for i, v in pairs(u103) do
        if not u44.is(v) then
            error(string.format("Non-promise value passed into %s at index %s", "Promise.allSettled", (tostring(i))), 2);
        end;
    end;

    if #u103 == 0 then
        return u44.resolve({});
    end;

    return u44._new(debug.traceback(nil, 2), function(u104, p105, p106) -- Line: 715
        -- upvalues: u103 (copy)
        local u107 = {};
        local u108 = {};
        local u109 = 0;

        local function u111(p110, ...) -- Line: 725
            -- upvalues: u109 (ref), u107 (copy), u103 (ref), u104 (copy)
            u109 = u109 + 1;
            u107[p110] = ...;

            if u109 >= #u103 then
                u104(u107);
            end;
        end;

        p106(function() -- Line: 735
            -- upvalues: u108 (copy)
            for _, v in ipairs(u108) do
                v:cancel();
            end;
        end);

        for i, v in ipairs(u103) do
            u108[i] = v:finally(function(...) -- Line: 744
                -- upvalues: u111 (copy), i (copy)
                u111(i, ...);
            end);
        end;
    end);
end;

function u44.race(u112) -- Line: 775
    -- upvalues: u44 (copy)
    local v113 = type(u112) == "table";
    assert(v113, string.format("Please pass a list of promises to %s", "Promise.race"));

    for i, v in pairs(u112) do
        local v114 = u44.is(v);
        local format = string.format;
        local v115 = tostring(i);
        assert(v114, format("Non-promise value passed into %s at index %s", "Promise.race", v115));
    end;

    return u44._new(debug.traceback(nil, 2), function(u116, u117, p118) -- Line: 782
        -- upvalues: u112 (copy)
        local u119 = {};
        local u120 = false;

        local function cancel() -- Line: 786
            -- upvalues: u119 (copy)
            for _, v in ipairs(u119) do
                v:cancel();
            end;
        end;

        local function finalize(u121) -- Line: 792
            -- upvalues: u119 (copy), u120 (ref)
            return function(...) -- Line: 793
                -- upvalues: u119 (ref), u120 (ref), u121 (copy)
                for _, v in ipairs(u119) do
                    v:cancel();
                end;

                u120 = true;

                return u121(...);
            end;
        end;

        if p118(function(...) -- Line: 793
            -- upvalues: u119 (copy), u120 (ref), u117 (copy)
            for _, v in ipairs(u119) do
                v:cancel();
            end;

            u120 = true;

            return u117(...);
        end) then
            return;
        end;

        for i, v in ipairs(u112) do
            u119[i] = v:andThen(function(...) -- Line: 793
                -- upvalues: u119 (copy), u120 (ref), u116 (copy)
                for _, v2 in ipairs(u119) do
                    v2:cancel();
                end;

                u120 = true;

                return u116(...);
            end, function(...) -- Line: 793
                -- upvalues: u119 (copy), u120 (ref), u117 (copy)
                for _, v2 in ipairs(u119) do
                    v2:cancel();
                end;

                u120 = true;

                return u117(...);
            end);
        end;

        if u120 then
            for _, v in ipairs(u119) do
                v:cancel();
            end;
        end;
    end);
end;

function u44.each(u122, u123) -- Line: 870
    -- upvalues: u44 (copy), u10 (ref)
    local v124 = type(u122) == "table";
    assert(v124, string.format("Please pass a list of promises to %s", "Promise.each"));
    local v125;

    if type(u123) == "function" then
        v125 = true;
    elseif type(u123) == "table" then
        local v126 = getmetatable(u123);

        if v126 then
            local v127 = rawget(v126, "__call");
            v125 = type(v127) == "function";
        else
            v125 = false;
        end;
    else
        v125 = false;
    end;

    assert(v125, string.format("Please pass a handler function to %s!", "Promise.each"));

    return u44._new(debug.traceback(nil, 2), function(p128, p129, p130) -- Line: 874
        -- upvalues: u122 (copy), u44 (ref), u10 (ref), u123 (copy)
        local v131 = {};
        local u132 = {};
        local u133 = false;

        local function _() -- Line: 880
            -- upvalues: u132 (copy)
            for _, v in ipairs(u132) do
                v:cancel();
            end;
        end;

        p130(function() -- Line: 886
            -- upvalues: u133 (ref), u132 (copy)
            u133 = true;

            for _, v in ipairs(u132) do
                v:cancel();
            end;
        end);
        local v134 = {};

        for i, v in ipairs(u122) do
            if u44.is(v) then
                if v:getStatus() == u44.Status.Cancelled then
                    for _, v2 in ipairs(u132) do
                        v2:cancel();
                    end;

                    return p129(u10.new({
                        error = "Promise is cancelled",
                        kind = u10.Kind.AlreadyCancelled,
                        context = string.format("The Promise that was part of the array at index %d passed into Promise.each was already cancelled when Promise.each began.\n\nThat Promise was created at:\n\n%s", i, v._source)
                    }));
                end;

                if v:getStatus() == u44.Status.Rejected then
                    for _, v2 in ipairs(u132) do
                        v2:cancel();
                    end;

                    return p129(select(2, v:await()));
                end;

                local v135 = v:andThen(function(...) -- Line: 919
                    return ...;
                end);
                table.insert(u132, v135);
                v134[i] = v135;
            else
                v134[i] = v;
            end;
        end;

        for i, v in ipairs(v134) do
            if u44.is(v) then
                local v136, v = v:await();

                if not v136 then
                    for _, v2 in ipairs(u132) do
                        v2:cancel();
                    end;

                    return p129(v);
                end;
            end;

            if u133 then
                return;
            end;

            local v137 = u44.resolve(u123(v, i));
            table.insert(u132, v137);
            local v138, v139 = v137:await();

            if not v138 then
                for _, v2 in ipairs(u132) do
                    v2:cancel();
                end;

                return p129(v139);
            end;

            v131[i] = v139;
        end;

        p128(v131);
    end);
end;

function u44.is(p140) -- Line: 969
    -- upvalues: u44 (copy)
    if type(p140) ~= "table" then
        return false;
    end;

    local v141 = getmetatable(p140);

    if v141 == u44 then
        return true;
    end;

    if v141 ~= nil then
        if type(v141) == "table" then
            local v142 = rawget(v141, "__index");

            if type(v142) == "table" then
                local v143 = rawget(v141, "__index");
                local v144 = rawget(v143, "andThen");
                local v145;

                if type(v144) == "function" then
                    v145 = true;
                else
                    local v146 = type(v144) == "table" and getmetatable(v144);

                    if v146 then
                        local v147 = rawget(v146, "__call");
                        v145 = type(v147) == "function";
                    else
                        v145 = false;
                    end;
                end;

                if v145 then
                    return true;
                end;
            end;
        end;

        return false;
    end;

    local andThen = p140.andThen;

    if type(andThen) == "function" then
        return true;
    end;

    local v148 = type(andThen) == "table" and getmetatable(andThen);

    if v148 then
        local v149 = rawget(v148, "__call");

        if type(v149) == "function" then
            return true;
        end;
    end;

    return false;
end;

function u44.promisify(u150) -- Line: 1018
    -- upvalues: u44 (copy)
    return function(...) -- Line: 1019
        -- upvalues: u44 (ref), u150 (copy)
        return u44._try(debug.traceback(nil, 2), u150, ...);
    end;
end;

function u44.delay(u151) -- Line: 1042
    -- upvalues: u44 (copy)
    local v152 = type(u151) == "number";
    assert(v152, "Bad argument #1 to Promise.delay, must be a number.");
    local u153 = u44._getTime();

    return u44._new(debug.traceback(nil, 2), function(u154) -- Line: 1045
        -- upvalues: u151 (copy), u44 (ref), u153 (copy)
        task.delay(u151, function() -- Line: 1046
            -- upvalues: u154 (copy), u44 (ref), u153 (ref)
            u154(u44._getTime() - u153);
        end);
    end);
end;

function u44.prototype.timeout(p155, u156, u157) -- Line: 1090
    -- upvalues: u44 (copy), u10 (ref)
    local u158 = debug.traceback(nil, 2);

    return u44.race({ u44.delay(u156):andThen(function() -- Line: 1094
            -- upvalues: u44 (ref), u157 (copy), u10 (ref), u156 (copy), u158 (copy)
            return u44.reject(u157 == nil and u10.new({
                error = "Timed out",
                kind = u10.Kind.TimedOut,
                context = string.format("Timeout of %d seconds exceeded.\n:timeout() called at:\n\n%s", u156, u158)
            }) or u157);
        end), p155 });
end;

function u44.prototype.getStatus(p159) -- Line: 1114
    return p159._status;
end;

function u44.prototype._andThen(u160, u161, u162, u163) -- Line: 1123
    -- upvalues: u44 (copy), runExecutor (copy)
    u160._unhandledRejection = false;

    if u160._status ~= u44.Status.Cancelled then
        return u44._new(u161, function(u164, u165, p166) -- Line: 1135
            -- upvalues: u162 (copy), u161 (copy), runExecutor (ref), u163 (copy), u160 (copy), u44 (ref)
            local u167;

            if u162 then
                local u168 = u161;
                local u169 = u162;

                u167 = function(...) -- Line: 180
                    -- upvalues: runExecutor (ref), u168 (copy), u169 (copy), u164 (copy), u165 (copy)
                    local v170, v171, v172 = runExecutor(u168, u169, ...);

                    if v170 then
                        u164(unpack(v172, 1, v171));

                        return;
                    end;

                    u165(v172[1]);
                end;
            else
                u167 = u164;
            end;

            if u163 then
                local u173 = u161;
                local u174 = u163;

                u165 = function(...) -- Line: 180
                    -- upvalues: runExecutor (ref), u173 (copy), u174 (copy), u164 (copy), u165 (copy)
                    local v175, v176, v177 = runExecutor(u173, u174, ...);

                    if v175 then
                        u164(unpack(v177, 1, v176));

                        return;
                    end;

                    u165(v177[1]);
                end;
            end;

            if u160._status == u44.Status.Started then
                table.insert(u160._queuedResolve, u167);
                table.insert(u160._queuedReject, u165);
                p166(function() -- Line: 1154
                    -- upvalues: u160 (ref), u44 (ref), u167 (ref), u165 (ref)
                    if u160._status == u44.Status.Started then
                        table.remove(u160._queuedResolve, table.find(u160._queuedResolve, u167));
                        table.remove(u160._queuedReject, table.find(u160._queuedReject, u165));
                    end;
                end);
            elseif u160._status == u44.Status.Resolved then
                u167(unpack(u160._values, 1, u160._valuesLength));
            elseif u160._status == u44.Status.Rejected then
                u165(unpack(u160._values, 1, u160._valuesLength));
            end;
        end, u160);
    end;

    local v178 = u44.new(function() -- Line: 1128
    end);
    v178:cancel();

    return v178;
end;

function u44.prototype.andThen(p179, p180, p181) -- Line: 1193
    local v182;

    if p180 == nil or type(p180) == "function" then
        v182 = true;
    elseif type(p180) == "table" then
        local v183 = getmetatable(p180);

        if v183 then
            local v184 = rawget(v183, "__call");
            v182 = type(v184) == "function";
        else
            v182 = false;
        end;
    else
        v182 = false;
    end;

    assert(v182, string.format("Please pass a handler function to %s!", "Promise:andThen"));
    local v185;

    if p181 == nil or type(p181) == "function" then
        v185 = true;
    elseif type(p181) == "table" then
        local v186 = getmetatable(p181);

        if v186 then
            local v187 = rawget(v186, "__call");
            v185 = type(v187) == "function";
        else
            v185 = false;
        end;
    else
        v185 = false;
    end;

    assert(v185, string.format("Please pass a handler function to %s!", "Promise:andThen"));

    return p179:_andThen(debug.traceback(nil, 2), p180, p181);
end;

function u44.prototype.catch(p188, p189) -- Line: 1220
    local v190;

    if p189 == nil or type(p189) == "function" then
        v190 = true;
    elseif type(p189) == "table" then
        local v191 = getmetatable(p189);

        if v191 then
            local v192 = rawget(v191, "__call");
            v190 = type(v192) == "function";
        else
            v190 = false;
        end;
    else
        v190 = false;
    end;

    assert(v190, string.format("Please pass a handler function to %s!", "Promise:catch"));

    return p188:_andThen(debug.traceback(nil, 2), nil, p189);
end;

function u44.prototype.tap(p193, u194) -- Line: 1241
    -- upvalues: u44 (copy), pack (copy)
    local v195;

    if type(u194) == "function" then
        v195 = true;
    elseif type(u194) == "table" then
        local v196 = getmetatable(u194);

        if v196 then
            local v197 = rawget(v196, "__call");
            v195 = type(v197) == "function";
        else
            v195 = false;
        end;
    else
        v195 = false;
    end;

    assert(v195, string.format("Please pass a handler function to %s!", "Promise:tap"));

    return p193:_andThen(debug.traceback(nil, 2), function(...) -- Line: 1243
        -- upvalues: u194 (copy), u44 (ref), pack (ref)
        local v198 = u194(...);

        if not u44.is(v198) then
            return ...;
        end;

        local u199, u200 = pack(...);

        return v198:andThen(function() -- Line: 1248
            -- upvalues: u200 (copy), u199 (copy)
            return unpack(u200, 1, u199);
        end);
    end);
end;

function u44.prototype.andThenCall(p201, u202, ...) -- Line: 1276
    -- upvalues: pack (copy)
    local v203;

    if type(u202) == "function" then
        v203 = true;
    elseif type(u202) == "table" then
        local v204 = getmetatable(u202);

        if v204 then
            local v205 = rawget(v204, "__call");
            v203 = type(v205) == "function";
        else
            v203 = false;
        end;
    else
        v203 = false;
    end;

    assert(v203, string.format("Please pass a handler function to %s!", "Promise:andThenCall"));
    local u206, u207 = pack(...);

    return p201:_andThen(debug.traceback(nil, 2), function() -- Line: 1279
        -- upvalues: u202 (copy), u207 (copy), u206 (copy)
        return u202(unpack(u207, 1, u206));
    end);
end;

function u44.prototype.andThenReturn(p208, ...) -- Line: 1306
    -- upvalues: pack (copy)
    local u209, u210 = pack(...);

    return p208:_andThen(debug.traceback(nil, 2), function() -- Line: 1308
        -- upvalues: u210 (copy), u209 (copy)
        return unpack(u210, 1, u209);
    end);
end;

function u44.prototype.cancel(p211) -- Line: 1324
    -- upvalues: u44 (copy)
    if p211._status ~= u44.Status.Started then
        return;
    end;

    p211._status = u44.Status.Cancelled;

    if p211._cancellationHook then
        p211._cancellationHook();
    end;

    coroutine.close(p211._thread);

    if p211._parent then
        p211._parent:_consumerCancelled(p211);
    end;

    for i in pairs(p211._consumers) do
        i:cancel();
    end;

    p211:_finalize();
end;

function u44.prototype._consumerCancelled(p212, p213) -- Line: 1352
    -- upvalues: u44 (copy)
    if p212._status ~= u44.Status.Started then
        return;
    end;

    p212._consumers[p213] = nil;

    if next(p212._consumers) == nil then
        p212:cancel();
    end;
end;

function u44.prototype._finally(u214, u215, u216) -- Line: 1368
    -- upvalues: u44 (copy), runExecutor (copy)
    u214._unhandledRejection = false;

    return u44._new(u215, function(u217, u218, p219) -- Line: 1371
        -- upvalues: u214 (copy), u216 (copy), runExecutor (ref), u215 (copy), u44 (ref)
        local u220 = nil;
        p219(function() -- Line: 1374
            -- upvalues: u214 (ref), u220 (ref)
            u214:_consumerCancelled(u214);

            if u220 then
                u220:cancel();
            end;
        end);
        local v225 = u216 and function(...) -- Line: 1387
            -- upvalues: runExecutor (ref), u215 (ref), u216 (ref), u218 (copy), u44 (ref), u220 (ref), u217 (copy), u214 (ref)
            local v221, _, v222 = runExecutor(u215, u216, ...);
            local v223 = v222[1];

            if not v221 then
                return u218(v223);
            end;

            if not u44.is(v223) then
                u217(u214);

                return;
            end;

            u220 = v223;
            v223:finally(function(p224) -- Line: 1398
                -- upvalues: u44 (ref), u217 (ref), u214 (ref)
                if p224 ~= u44.Status.Rejected then
                    u217(u214);
                end;
            end):catch(function(...) -- Line: 1403
                -- upvalues: u218 (ref)
                u218(...);
            end);
        end or u217;

        if u214._status == u44.Status.Started then
            table.insert(u214._queuedFinally, v225);
        else
            v225(u214._status);
        end;
    end);
end;

function u44.prototype.finally(p226, p227) -- Line: 1473
    local v228;

    if p227 == nil or type(p227) == "function" then
        v228 = true;
    elseif type(p227) == "table" then
        local v229 = getmetatable(p227);

        if v229 then
            local v230 = rawget(v229, "__call");
            v228 = type(v230) == "function";
        else
            v228 = false;
        end;
    else
        v228 = false;
    end;

    assert(v228, string.format("Please pass a handler function to %s!", "Promise:finally"));

    return p226:_finally(debug.traceback(nil, 2), p227);
end;

function u44.prototype.finallyCall(p231, u232, ...) -- Line: 1487
    -- upvalues: pack (copy)
    local v233;

    if type(u232) == "function" then
        v233 = true;
    elseif type(u232) == "table" then
        local v234 = getmetatable(u232);

        if v234 then
            local v235 = rawget(v234, "__call");
            v233 = type(v235) == "function";
        else
            v233 = false;
        end;
    else
        v233 = false;
    end;

    assert(v233, string.format("Please pass a handler function to %s!", "Promise:finallyCall"));
    local u236, u237 = pack(...);

    return p231:_finally(debug.traceback(nil, 2), function() -- Line: 1490
        -- upvalues: u232 (copy), u237 (copy), u236 (copy)
        return u232(unpack(u237, 1, u236));
    end);
end;

function u44.prototype.finallyReturn(p238, ...) -- Line: 1513
    -- upvalues: pack (copy)
    local u239, u240 = pack(...);

    return p238:_finally(debug.traceback(nil, 2), function() -- Line: 1515
        -- upvalues: u240 (copy), u239 (copy)
        return unpack(u240, 1, u239);
    end);
end;

function u44.prototype.awaitStatus(p241) -- Line: 1527
    -- upvalues: u44 (copy)
    p241._unhandledRejection = false;

    if p241._status == u44.Status.Started then
        local u242 = coroutine.running();
        p241:finally(function() -- Line: 1534
            -- upvalues: u242 (copy)
            task.spawn(u242);
        end):catch(function() -- Line: 1540
        end);
        coroutine.yield();
    end;

    if p241._status == u44.Status.Resolved then
        return p241._status, unpack(p241._values, 1, p241._valuesLength);
    end;

    if p241._status == u44.Status.Rejected then
        return p241._status, unpack(p241._values, 1, p241._valuesLength);
    end;

    return p241._status;
end;

local function awaitHelper(p243, ...) -- Line: 1555
    -- upvalues: u44 (copy)
    return p243 == u44.Status.Resolved, ...;
end;

function u44.prototype.await(p244) -- Line: 1580
    -- upvalues: awaitHelper (copy)
    return awaitHelper(p244:awaitStatus());
end;

local function expectHelper(p245, ...) -- Line: 1584
    -- upvalues: u44 (copy)
    if p245 ~= u44.Status.Resolved then
        error(... == nil and "Expected Promise rejected with no value." or ..., 3);
    end;

    return ...;
end;

function u44.prototype.expect(p246) -- Line: 1617
    -- upvalues: expectHelper (copy)
    return expectHelper(p246:awaitStatus());
end;

u44.prototype.awaitValue = u44.prototype.expect;

function u44.prototype._unwrap(p247) -- Line: 1631
    -- upvalues: u44 (copy)
    if p247._status == u44.Status.Started then
        error("Promise has not resolved or rejected.", 2);
    end;

    return p247._status == u44.Status.Resolved, unpack(p247._values, 1, p247._valuesLength);
end;

function u44.prototype._resolve(u248, ...) -- Line: 1641
    -- upvalues: u44 (copy), u10 (ref), pack (copy)
    if u248._status ~= u44.Status.Started then
        if u44.is((...)) then
            (...):_consumerCancelled(u248);
        end;

        return;
    end;

    if u44.is((...)) then
        if select("#", ...) > 1 then
            local v249 = string.format("When returning a Promise from andThen, extra arguments are discarded! See:\n\n%s", u248._source);
            warn(v249);
        end;

        local u250 = ...;
        local v252 = u250:andThen(function(...) -- Line: 1662
            -- upvalues: u248 (copy)
            u248:_resolve(...);
        end, function(...) -- Line: 1664
            -- upvalues: u250 (copy), u10 (ref), u248 (copy)
            local v251 = u250._values[1];

            if u250._error then
                v251 = u10.new({
                    context = "[No stack trace available as this Promise originated from an older version of the Promise library (< v2)]",
                    error = u250._error,
                    kind = u10.Kind.ExecutionError
                });
            end;

            if u10.isKind(v251, u10.Kind.ExecutionError) then
                return u248:_reject(v251:extend({
                    error = "This Promise was chained to a Promise that errored.",
                    trace = "",
                    context = string.format("The Promise at:\n\n%s\n...Rejected because it was chained to the following Promise, which encountered an error:\n", u248._source)
                }));
            end;

            u248:_reject(...);
        end);

        if v252._status == u44.Status.Cancelled then
            u248:cancel();

            return;
        end;

        if v252._status == u44.Status.Started then
            u248._parent = v252;
            v252._consumers[u248] = true;
        end;

        return;
    end;

    u248._status = u44.Status.Resolved;
    local v253, v254 = pack(...);
    u248._valuesLength = v253;
    u248._values = v254;

    for _, v in ipairs(u248._queuedResolve) do
        coroutine.wrap(v)(...);
    end;

    u248:_finalize();
end;

function u44.prototype._reject(u255, ...) -- Line: 1712
    -- upvalues: u44 (copy), pack (copy)
    if u255._status ~= u44.Status.Started then
        return;
    end;

    u255._status = u44.Status.Rejected;
    local v256, v257 = pack(...);
    u255._valuesLength = v256;
    u255._values = v257;

    if next(u255._queuedReject) == nil then
        local u258 = tostring((...));
        coroutine.wrap(function() -- Line: 1734
            -- upvalues: u44 (ref), u255 (copy), u258 (copy)
            u44._timeEvent:Wait();

            if not u255._unhandledRejection then
                return;
            end;

            local v259 = string.format("Unhandled Promise rejection:\n\n%s\n\n%s", u258, u255._source);

            for _, v in ipairs(u44._unhandledRejectionCallbacks) do
                task.spawn(v, u255, unpack(u255._values, 1, u255._valuesLength));
            end;

            if u44.TEST then
                return;
            end;

            warn(v259);
        end)();
    else
        for _, v in ipairs(u255._queuedReject) do
            coroutine.wrap(v)(...);
        end;
    end;

    u255:_finalize();
end;

function u44.prototype._finalize(p260) -- Line: 1766
    -- upvalues: u44 (copy)
    for _, v in ipairs(p260._queuedFinally) do
        coroutine.wrap(v)(p260._status);
    end;

    p260._queuedFinally = nil;
    p260._queuedReject = nil;
    p260._queuedResolve = nil;

    if not u44.TEST then
        p260._parent = nil;
        p260._consumers = nil;
    end;

    task.defer(coroutine.close, p260._thread);
end;

function u44.prototype.now(p261, p262) -- Line: 1803
    -- upvalues: u44 (copy), u10 (ref)
    local v263 = debug.traceback(nil, 2);

    if p261._status == u44.Status.Resolved then
        return p261:_andThen(v263, function(...) -- Line: 1806
            return ...;
        end);
    end;

    local reject = u44.reject;

    if p262 == nil then
        p262 = u10.new({
            error = "This Promise was not resolved in time for :now()",
            kind = u10.Kind.NotResolvedInTime,
            context = ":now() was called at:\n\n" .. v263
        }) or p262;
    end;

    return reject(p262);
end;

function u44.retry(u264, u265, ...) -- Line: 1848
    -- upvalues: u44 (copy)
    local v266;

    if type(u264) == "function" then
        v266 = true;
    elseif type(u264) == "table" then
        local v267 = getmetatable(u264);

        if v267 then
            local v268 = rawget(v267, "__call");
            v266 = type(v268) == "function";
        else
            v266 = false;
        end;
    else
        v266 = false;
    end;

    assert(v266, "Parameter #1 to Promise.retry must be a function");
    local v269 = type(u265) == "number";
    assert(v269, "Parameter #2 to Promise.retry must be a number");
    local u270 = { ... };
    local u271 = select("#", ...);

    return u44.resolve(u264(...)):catch(function(...) -- Line: 1854
        -- upvalues: u265 (copy), u44 (ref), u264 (copy), u270 (copy), u271 (copy)
        if u265 > 0 then
            return u44.retry(u264, u265 - 1, unpack(u270, 1, u271));
        end;

        return u44.reject(...);
    end);
end;

function u44.retryWithDelay(u272, u273, u274, ...) -- Line: 1876
    -- upvalues: u44 (copy)
    local v275;

    if type(u272) == "function" then
        v275 = true;
    elseif type(u272) == "table" then
        local v276 = getmetatable(u272);

        if v276 then
            local v277 = rawget(v276, "__call");
            v275 = type(v277) == "function";
        else
            v275 = false;
        end;
    else
        v275 = false;
    end;

    assert(v275, "Parameter #1 to Promise.retry must be a function");
    local v278 = type(u273) == "number";
    assert(v278, "Parameter #2 (times) to Promise.retry must be a number");
    local v279 = type(u274) == "number";
    assert(v279, "Parameter #3 (seconds) to Promise.retry must be a number");
    local u280 = { ... };
    local u281 = select("#", ...);

    return u44.resolve(u272(...)):catch(function(...) -- Line: 1883
        -- upvalues: u273 (copy), u44 (ref), u274 (copy), u272 (copy), u280 (copy), u281 (copy)
        if u273 <= 0 then
            return u44.reject(...);
        end;

        u44.delay(u274):await();

        return u44.retryWithDelay(u272, u273 - 1, u274, unpack(u280, 1, u281));
    end);
end;

function u44.fromEvent(u282, p283) -- Line: 1918
    -- upvalues: u44 (copy)
    local u284 = p283 or function() -- Line: 1919
        return true;
    end;

    return u44._new(debug.traceback(nil, 2), function(u285, p286, p287) -- Line: 1923
        -- upvalues: u282 (copy), u284 (ref)
        local u288 = nil;
        local u289 = false;

        local function disconnect() -- Line: 1927
            -- upvalues: u288 (ref)
            u288:Disconnect();
            u288 = nil;
        end;

        u288 = u282:Connect(function(...) -- Line: 1936
            -- upvalues: u284 (ref), u285 (copy), u288 (ref), u289 (ref)
            local v290 = u284(...);

            if v290 ~= true then
                if type(v290) ~= "boolean" then
                    error("Promise.fromEvent predicate should always return a boolean");
                end;

                return;
            end;

            u285(...);

            if not u288 then
                u289 = true;

                return;
            end;

            u288:Disconnect();
            u288 = nil;
        end);

        if u289 and u288 then
            return disconnect();
        end;

        p287(disconnect);
    end);
end;

function u44.onUnhandledRejection(u291) -- Line: 1970
    -- upvalues: u44 (copy)
    table.insert(u44._unhandledRejectionCallbacks, u291);

    return function() -- Line: 1973
        -- upvalues: u44 (ref), u291 (copy)
        local v292 = table.find(u44._unhandledRejectionCallbacks, u291);

        if v292 then
            table.remove(u44._unhandledRejectionCallbacks, v292);
        end;
    end;
end;

return u44;