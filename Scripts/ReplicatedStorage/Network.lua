--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Network
  Path:     game.ReplicatedStorage.Library.Imported.Network
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:24 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local u1 = {
    Logging = nil
};
local u2 = RunService:IsServer();
local u3 = RunService:IsStudio();
local Callback = require(script.Callback);

function SafeInvokeBinding(p4, ...)
    local v5 = p4.Callback:ExecuteAsync(...);

    if v5[1] == false or v5[2] == false then
        return false;
    end;

    return true, unpack(v5, 3);
end;

function SafeInvokeWithTimeout(p6, p7, ...)
    local u8 = nil;
    local u9 = nil;

    if p6 then
        task.delay(p6, function() -- Line: 106
            -- upvalues: u8 (ref), u9 (ref)
            if not u8 then
                u8 = table.pack(false);

                if u9 then
                    task.spawn(u9);
                end;
            end;
        end);
    end;

    task.spawn(function(...) -- Line: 117
        -- upvalues: u8 (ref), u9 (ref)
        local v10 = table.pack(pcall(...));

        if not u8 then
            u8 = v10;

            if u9 then
                task.spawn(u9);
            end;
        end;
    end, ...);

    if not u8 then
        u9 = coroutine.running();
        coroutine.yield();
    end;

    return u8;
end;

local u11 = {};

function ExecutePendingEvents()
    -- upvalues: u11 (copy)
    local v12 = 1;
    local v13 = {};

    while v12 <= #u11 do
        local v14 = u11[v12 + 1];

        if u11[v12].IsBound then
            table.insert(v13, v14);
            table.remove(u11, v12 + 1);
            table.remove(u11, v12);
        else
            v12 = v12 + 2;
        end;
    end;

    for _, v in ipairs(v13) do
        task.spawn(v);
    end;
end;

if u2 then
    function OnServerEvent(p15, ...)
        -- upvalues: u11 (copy)
        if not p15.IsBound then
            table.insert(u11, p15);
            table.insert(u11, coroutine.running());
            coroutine.yield();
        end;

        for _, v in pairs(p15.Bindings) do
            v.Callback:Execute(...);
        end;
    end;

    function OnServerInvoke(p16, ...)
        -- upvalues: u11 (copy)
        if not p16.IsBound then
            table.insert(u11, p16);
            table.insert(u11, coroutine.running());
            coroutine.yield();
        end;

        return SafeInvokeBinding(p16.Binding, ...);
    end;
else
    function OnClientEvent(p17, ...)
        -- upvalues: u11 (copy)
        if not p17.IsBound then
            table.insert(u11, p17);
            table.insert(u11, coroutine.running());
            coroutine.yield();
        end;

        for _, v in pairs(p17.Bindings) do
            v.Callback:Execute(...);
        end;
    end;

    function OnClientInvoke(p18, ...)
        -- upvalues: u11 (copy)
        if not p18.IsBound then
            table.insert(u11, p18);
            table.insert(u11, coroutine.running());
            coroutine.yield();
        end;

        return SafeInvokeBinding(p18.Binding, ...);
    end;
end;

local u19, u20;

if u2 then
    local Folder = Instance.new("Folder", ReplicatedStorage);
    Folder.Name = "Communication";
    u19 = Instance.new("Folder", Folder);
    u19.Name = "Functions";
    u20 = Instance.new("Folder", Folder);
    u20.Name = "Events";
else
    local Communication = ReplicatedStorage:WaitForChild("Communication", 10);
    u19 = Communication:WaitForChild("Functions");
    u20 = Communication:WaitForChild("Events");
end;

local u21 = {
    Event = {},
    Function = {}
};

function GetHandler(u22, u23)
    -- upvalues: u21 (copy), u2 (copy), u20 (ref), u19 (ref)
    local v24 = u21[u22];

    if not v24 then
        error("Invalid handlerType \'" .. tostring(u22) .. "\'");
    end;

    local u25 = v24[u23];

    if not u25 then
        u25 = {
            Name = u23,
            Type = u22
        };
        v24[u23] = u25;

        if u22 == "Event" then
            u25.Bindings = {};
        end;

        task.spawn(function() -- Line: 290
            -- upvalues: u2 (ref), u22 (copy), u23 (copy), u20 (ref), u25 (ref), u19 (ref)
            if u2 then
                if u22 == "Event" then
                    local RemoteEvent = Instance.new("RemoteEvent");
                    RemoteEvent.Name = u23;
                    RemoteEvent.Parent = u20;
                    u25.Remote = RemoteEvent;
                    local UnreliableRemoteEvent = Instance.new("UnreliableRemoteEvent");
                    UnreliableRemoteEvent.Name = "Unreliable";
                    UnreliableRemoteEvent.Parent = RemoteEvent;
                    u25.Unreliable = UnreliableRemoteEvent;
                    RemoteEvent.OnServerEvent:Connect(function(...) -- Line: 303
                        -- upvalues: u25 (ref)
                        OnServerEvent(u25, ...);
                    end);
                    UnreliableRemoteEvent.OnServerEvent:Connect(function(...) -- Line: 307
                        -- upvalues: u25 (ref)
                        OnServerEvent(u25, ...);
                    end);
                else
                    local RemoteFunction = Instance.new("RemoteFunction");
                    RemoteFunction.Name = u23;
                    RemoteFunction.Parent = u19;
                    u25.Remote = RemoteFunction;

                    function RemoteFunction.OnServerInvoke(...) -- Line: 316
                        -- upvalues: u25 (ref)
                        return OnServerInvoke(u25, ...);
                    end;
                end;
            else
                local function waitForChild(p26, u27) -- Line: 324
                    local u28 = p26:FindFirstChild(u27);

                    if not u28 then
                        local u29 = coroutine.running();
                        local v31 = p26.ChildAdded:Connect(function(p30) -- Line: 332
                            -- upvalues: u29 (ref), u27 (copy), u28 (ref)
                            if u29 and p30.Name == u27 then
                                u28 = p30;
                                task.spawn(u29);
                            end;
                        end);
                        coroutine.yield();
                        u29 = nil;
                        v31:Disconnect();
                    end;

                    return u28;
                end;

                waitForChild(u22 == "Event" and u20 or u19, u23);

                if u22 == "Event" then
                    local v32 = waitForChild(u20, u23);
                    local v33 = waitForChild(v32, "Unreliable");
                    u25.Remote = v32;
                    u25.Unreliable = v33;

                    if not u2 then
                        v32.Name = "";
                    end;

                    v32.OnClientEvent:Connect(function(...) -- Line: 362
                        -- upvalues: u25 (ref)
                        OnClientEvent(u25, ...);
                    end);
                    v33.OnClientEvent:Connect(function(...) -- Line: 366
                        -- upvalues: u25 (ref)
                        OnClientEvent(u25, ...);
                    end);
                else
                    local v34 = waitForChild(u19, u23);
                    u25.Remote = v34;

                    if not u2 then
                        v34.Name = "";
                    end;

                    function v34.OnClientInvoke(...) -- Line: 377
                        -- upvalues: u25 (ref)
                        return OnClientInvoke(u25, ...);
                    end;
                end;
            end;

            if u25.WaitingForRemote then
                local WaitingForRemote = u25.WaitingForRemote;
                u25.WaitingForRemote = nil;

                for _, v in ipairs(WaitingForRemote) do
                    task.spawn(v);
                end;
            end;
        end);
    end;

    return u25;
end;

local u35 = setmetatable({}, {
    __mode = "v"
});
local u36 = 0;
local u37 = {};

function InitFilter(p38)
    -- upvalues: u35 (copy), u36 (ref)
    if u35[p38] then
        return u35[p38];
    end;

    local v39 = nil;

    if typeof(p38) == "function" then
        v39 = { p38 };
    elseif typeof(p38) == "table" and typeof(p38[1]) == "function" then
        v39 = {};

        for i, v in pairs(p38) do
            v39[i] = v;
        end;
    end;

    if v39 then
        v39.Priority = v39.Priority or 0;
        v39.RegisterIndex = u36;
        u36 = u36 + 1;
        u35[p38] = v39;
    end;

    return v39;
end;

function ApplyFilters(u40, u41)
    -- upvalues: u2 (copy), u1 (copy)
    return function(...) -- Line: 430
        -- upvalues: u41 (copy), u40 (copy), u2 (ref), u1 (ref)
        local u42 = table.pack(true, ...);

        for i, v in ipairs(u41.Filters) do
            u42 = table.pack(v(unpack(u42, 2, u42.n)));

            if u42[1] ~= true then
                if u42[1] ~= nil and u42[1] ~= false then
                    task.spawn(function() -- Line: 438
                        -- upvalues: i (copy), u40 (ref), u42 (ref)
                        error(string.format("Network: Filter #%d to \'%s\' returned invalid first value of type %s. False or nil expected to cancel event", i, u40.Name, (typeof(u42[1]))), -1);
                    end);
                end;

                return false;
            end;
        end;

        if u2 and u1.Logging then
            u1.Logging[#u1.Logging + 1] = { true, u40.Remote, ... };
        end;

        return true, u41[1](unpack(u42, 2, u42.n));
    end;
end;

function InitBinding(p43, p44, p45)
    -- upvalues: u37 (copy), Callback (copy)
    local v46 = nil;

    if typeof(p44) == "function" then
        v46 = { p44 };
    elseif typeof(p44) == "table" and typeof(p44[1]) == "function" then
        v46 = {};

        for i, v in pairs(p44) do
            v46[i] = v;
        end;
    end;

    if not v46 then
        return nil;
    end;

    local v47 = {};

    for i, v in pairs(v46) do
        if i ~= 1 then
            local v48 = u37[i];

            if not v48 then
                error("Filter \'" .. tostring(i) .. "\' doesn\'t exist");
            end;

            table.insert(v47, v48[1](p43, v, v46));
        end;
    end;

    table.sort(v47, function(p49, p50) -- Line: 491
        if p49.Priority == p50.Priority then
            return p49.RegisterIndex < p50.RegisterIndex;
        end;

        return p49.Priority < p50.Priority;
    end);

    if p45 then
        local v51 = typeof(p45) ~= "table" and { p45 } or p45;

        for i, v in ipairs(type(v51) == "table" and v51 and v51 or { v51 }) do
            if typeof(v) ~= "function" then
                error("Invalid custom filter #" .. i .. " (function expected, got " .. typeof(v) .. ")");
            end;

            table.insert(v47, v);
        end;
    end;

    v46.Filters = v47;
    v46.Callback = Callback.new(ApplyFilters(p43, v46));

    return v46;
end;

function BindToHandler(p52, p53, p54, p55)
    local v56 = InitBinding(p52, p53, p54);

    if not v56 then
        error("Invalid binding to \'" .. p52.Name .. "\'");
    end;

    if p52.Type == "Event" then
        table.insert(p52.Bindings, v56);
    else
        if p52.Binding then
            error("Duplicate function handler to \'" .. p52.Name .. "\'");
        end;

        p52.Binding = v56;
    end;

    if not p52.IsBound then
        p52.IsBound = true;

        if p55 then
            ExecutePendingEvents();
        end;
    end;
end;

if u2 then
    function FireClient(p57, p58, p59, ...)
        -- upvalues: u1 (copy)
        if u1.Logging then
            u1.Logging[#u1.Logging + 1] = {
                false,
                p58,
                p59,
                ...
            };
        end;

        p58:FireClient(p59, ...);
    end;

    function InvokeClientWithTimeout(p60, p61, p62, ...)
        -- upvalues: u1 (copy)
        if u1.Logging then
            u1.Logging[#u1.Logging + 1] = {
                false,
                p61.Remote,
                p62,
                ...
            };
        end;

        local v63 = SafeInvokeWithTimeout(p60, p61, p61.Remote.InvokeClient, p61.Remote, p62, ...);

        if v63[1] == false or v63[2] == false then
            return false;
        end;

        return true, unpack(v63, 3, v63.n);
    end;

    function u1.FireClient(p64, p65, p66, ...) -- Line: 572
        local v67 = GetHandler("Event", p66);
        FireClient(v67, v67.Remote, p65, ...);
    end;

    function u1.FireAllClients(p68, p69, ...) -- Line: 577
        local v70 = GetHandler("Event", p69);

        for _, v in p68:GetPlayers() do
            FireClient(v70, v70.Remote, v, ...);
        end;
    end;

    function u1.FireOtherClients(p71, p72, p73, ...) -- Line: 585
        local v74 = GetHandler("Event", p73);

        for _, v in p71:GetPlayers() do
            if v ~= p72 then
                FireClient(v74, v74.Remote, v, ...);
            end;
        end;
    end;

    function u1.FireClientUnreliable(p75, p76, p77, ...) -- Line: 595
        local v78 = GetHandler("Event", p77);
        FireClient(v78, v78.Unreliable, p76, ...);
    end;

    function u1.FireAllClientsUnreliable(p79, p80, ...) -- Line: 600
        local v81 = GetHandler("Event", p80);

        for _, v in p79:GetPlayers() do
            FireClient(v81, v81.Unreliable, v, ...);
        end;
    end;

    function u1.FireOtherClientsUnreliable(p82, p83, p84, ...) -- Line: 608
        local v85 = GetHandler("Event", p84);

        for _, v in p82:GetPlayers() do
            if v ~= p83 then
                FireClient(v85, v85.Unreliable, v, ...);
            end;
        end;
    end;

    function u1.FireOtherClientsWithinDistance(p86, p87, p88, p89, ...) -- Line: 618
        local v90 = p86:GetPlayerPosition(p87);

        if not v90 then
            return;
        end;

        local v91 = GetHandler("Event", p89);

        for _, v in ipairs(p86:GetPlayers()) do
            if v ~= p87 then
                local v92 = p86:GetPlayerPosition(v);

                if v92 and (v90 - v92).Magnitude <= p88 then
                    FireClient(v91, v91.Remote, v, ...);
                end;
            end;
        end;
    end;

    function u1.FireAllClientsWithinDistance(p93, p94, p95, p96, ...) -- Line: 637
        local v97 = GetHandler("Event", p96);

        for _, v in ipairs(p93:GetPlayers()) do
            local v98 = p93:GetPlayerPosition(v);

            if v98 and (p94 - v98).Magnitude <= p95 then
                FireClient(v97, v97.Remote, v, ...);
            end;
        end;
    end;

    function u1.InvokeClientWithTimeout(p99, p100, p101, p102, ...) -- Line: 653
        local v103 = GetHandler("Function", p102);

        return InvokeClientWithTimeout(p100, v103, p101, ...);
    end;

    function u1.InvokeClient(p104, p105, p106, ...) -- Line: 659
        local v107 = GetHandler("Function", p106);

        return InvokeClientWithTimeout(nil, v107, p105, ...);
    end;

    local Players = game:GetService("Players");

    function u1.GetPlayers(p108) -- Line: 668
        -- upvalues: Players (copy)
        return Players:GetPlayers();
    end;

    function u1.GetPlayerPosition(p109, p110) -- Line: 672
        local v111 = p110 and p110.Character and p110.Character.PrimaryPart;

        return v111 and v111.Position or nil;
    end;
end;

if not u2 then
    function FireServer(p112, p113, ...)
        p113:FireServer(...);
    end;

    function InvokeServerWithTimeout(p114, p115, ...)
        if not p115.Remote then
            if not p115.WaitingForRemote then
                p115.WaitingForRemote = {};
            end;

            table.insert(p115.WaitingForRemote, coroutine.running());
            coroutine.yield();
        end;

        local v116 = SafeInvokeWithTimeout(p114, p115, p115.Remote.InvokeServer, p115.Remote, ...);

        if v116[1] == false or v116[2] == false then
            error("InvokeServer Error");
        end;

        return unpack(v116, 3, v116.n);
    end;

    function u1.FireServer(p117, p118, ...) -- Line: 704
        local u119 = GetHandler("Event", p118);

        if u119.Remote then
            FireServer(u119, u119.Remote, ...);

            return;
        end;

        task.spawn(function(...) -- Line: 710
            -- upvalues: u119 (copy)
            if not u119.WaitingForRemote then
                u119.WaitingForRemote = {};
            end;

            table.insert(u119.WaitingForRemote, coroutine.running());
            coroutine.yield();
            FireServer(u119, u119.Remote, ...);
        end, ...);
    end;

    function u1.FireServerUnreliable(p120, p121, ...) -- Line: 720
        local u122 = GetHandler("Event", p121);

        if u122.Remote then
            FireServer(u122, u122.Unreliable, ...);

            return;
        end;

        task.spawn(function(...) -- Line: 726
            -- upvalues: u122 (copy)
            if not u122.WaitingForRemote then
                u122.WaitingForRemote = {};
            end;

            table.insert(u122.WaitingForRemote, coroutine.running());
            coroutine.yield();
            FireServer(u122, u122.Unreliable, ...);
        end, ...);
    end;

    function u1.InvokeServerWithTimeout(p123, p124, p125, ...) -- Line: 736
        local v126 = GetHandler("Function", p125);

        return InvokeServerWithTimeout(p124, v126, ...);
    end;

    function u1.InvokeServer(p127, p128, ...) -- Line: 741
        local v129 = GetHandler("Function", p128);

        return InvokeServerWithTimeout(nil, v129, ...);
    end;

    u20.ChildAdded:Connect(function(p130) -- Line: 748
        GetHandler("Event", p130.Name);
    end);

    for _, child in pairs(u20:GetChildren()) do
        task.spawn(GetHandler, "Event", child.Name);
    end;

    u19.ChildAdded:Connect(function(p131) -- Line: 751
        GetHandler("Function", p131.Name);
    end);

    for _, child in ipairs(u19:GetChildren()) do
        task.spawn(GetHandler, "Function", child.Name);
    end;
end;

function u1.BindEvents(p132, p133, p134) -- Line: 758
    local v135;

    if p134 then
        v135 = p133;
        p133 = p134;
    else
        v135 = nil;
    end;

    for i, v in pairs(p133) do
        BindToHandler(GetHandler("Event", i), v, v135, false);
    end;

    ExecutePendingEvents();
end;

function u1.BindFunctions(p136, p137, p138) -- Line: 770
    local v139;

    if p138 then
        v139 = p137;
        p137 = p138;
    else
        v139 = nil;
    end;

    for i, v in pairs(p137) do
        BindToHandler(GetHandler("Function", i), v, v139, false);
    end;

    ExecutePendingEvents();
end;

function u1.RegisterFilters(p140, p141) -- Line: 782
    -- upvalues: u37 (copy)
    for i, v in pairs(p141) do
        if u37[i] then
            error("Duplicate filter \'" .. i .. "\'");
        end;

        local v142 = InitFilter(v);

        if not v142 then
            error("Invalid filter \'" .. i .. "\'");
        end;

        u37[i] = v142;
    end;
end;

u1:RegisterFilters({
    MatchParams = {
        Priority = -100,

        function(u143, p144) -- Line: 817
            -- upvalues: u2 (copy), u3 (copy)
            local u145 = { unpack(p144) };

            if u2 then
                table.insert(u145, 1, "Instance");
            end;

            for i, v in pairs(u145) do
                if type(v) == "string" then
                    local v = string.split(v:gsub("%?", "|nil"), "|") or v;
                end;

                local v146 = "";
                local v147 = {};

                for _, v2 in pairs(v) do
                    local v148 = v2:gsub("^%s+", ""):gsub("%s+$", "");
                    v146 = v146 .. (#v146 > 0 and " or " or "") .. v148;
                    v147[v148:lower()] = true;
                end;

                v147._string = v146;
                u145[i] = v147;
            end;

            return function(...) -- Line: 841
                -- upvalues: u145 (ref), u3 (ref), u143 (copy)
                local v149 = table.pack(...);

                for i, _ in ipairs(u145) do
                    local v150 = typeof(v149[i]);
                    local v151 = u145[i];

                    if not (v151[v150:lower()] or v151.any) then
                        if u3 then
                            warn(("[Network] Invalid argument #%d to %s (%s expected, got %s)"):format(i, u143.Name, v151._string, v150));
                        end;

                        return false;
                    end;
                end;

                return true, ...;
            end;
        end
    }
});

if u2 then
    function u1.LogTraffic(p152, p153) -- Line: 866
        -- upvalues: u1 (copy)
        if u1.Logging then
            return;
        end;

        warn("Logging Network Traffic...");
        u1.Logging = {};
        local u154 = tick();
        task.delay(p153, function() -- Line: 873
            -- upvalues: u154 (copy), u1 (ref)
            local v155 = tick() - u154;
            local Logging = u1.Logging;
            u1.Logging = nil;
            local v156 = {};

            for _, v in pairs(Logging) do
                local v157 = v[2];
                local v158 = v[3];
                local v159 = v156[v158];

                if not v159 then
                    v159 = {
                        total = 0
                    };
                    v156[v158] = v159;
                end;

                local v160 = v159[v157];

                if not v160 then
                    v160 = {
                        dataIn = {},
                        dataOut = {}
                    };
                    v159[v157] = v160;
                end;

                local v161 = v[1] and v160.dataIn or v160.dataOut;
                v161[#v161 + 1] = v;
                v159.total = v159.total + 1;
            end;

            for i, v in pairs(v156) do
                warn(string.format("Player \'%s\', total received: %d", i.Name, v.total));
                v.total = nil;

                for i2, v2 in pairs(v) do
                    local dataIn = v2.dataIn;

                    if #dataIn > 0 then
                        warn(string.format("   %s %s: %d (%.2f/s)", "FireServer", i2.Name, #dataIn, #dataIn / v155));
                        local v162 = math.min(#dataIn, 3);

                        for i3 = 1, v162 do
                            local v163 = (i3 - 1) / math.max(1, v162 - 1) * (#dataIn - 1) + 1 + 0.5;
                            local v164 = math.floor(v163);
                            local v165 = dataIn[1];
                            local v166 = "";

                            for i4 = 4, math.min(#v165, 7) do
                                local v167 = v165[i4];
                                v166 = v166 .. (#v166 > 0 and ", " or "") .. (typeof(v167) == "string" and "string[" .. #v167 .. "]" or typeof(v167));
                            end;

                            warn(("      %d: %s"):format(v164, v166));
                        end;
                    end;

                    local dataOut = v2.dataOut;

                    if #dataOut > 0 then
                        warn(string.format("   %s %s: %d (%.2f/s)", "FireClient", i2.Name, #dataOut, #dataOut / v155));
                        local v168 = math.min(#dataOut, 3);

                        for i3 = 1, v168 do
                            local v169 = (i3 - 1) / math.max(1, v168 - 1) * (#dataOut - 1) + 1 + 0.5;
                            local v170 = math.floor(v169);
                            local v171 = dataOut[v170];
                            local v172 = "";

                            for i4 = 4, math.min(#v171, 7) do
                                local v173 = v171[i4];
                                v172 = v172 .. (#v172 > 0 and ", " or "") .. (typeof(v173) == "string" and "string[" .. #v173 .. "]" or typeof(v173));
                            end;

                            warn(string.format("      %d: %s", v170, v172));
                        end;
                    end;
                end;
            end;
        end);
    end;
end;

local u174 = {};
local u175 = {};

function u1.AddReference(p176, p177, p178, ...) -- Line: 963
    -- upvalues: u174 (copy), u175 (copy)
    local v179 = {
        Type = p178,
        Reference = p177,
        Objects = { ... },
        Aliases = {}
    };

    if not u174[p178] then
        u174[p178] = {};
        u175[p178] = {};
    end;

    u174[p178][v179.Reference] = v179;
    local v180 = u175[p178];

    for _, v in ipairs(v179.Objects) do
        local v181 = v180[v] or {};
        v180[v] = v181;
        v180 = v181;
    end;

    v180.__Data = v179;
end;

function u1.AddReferenceAlias(p182, p183, p184, ...) -- Line: 988
    -- upvalues: u174 (copy), u175 (copy)
    local v185 = u174[p184] and u174[p184][p183];

    if not v185 then
        warn("Tried to add an alias to a non-existing reference");

        return;
    end;

    local v186 = { ... };
    v185.Aliases[#v185.Aliases + 1] = v186;
    local v187 = u175[p184];

    for _, v in ipairs(v186) do
        local v188 = v187[v] or {};
        v187[v] = v188;
        v187 = v188;
    end;

    v187.__Data = v185;
end;

function u1.RemoveReference(p189, p190, p191) -- Line: 1008
    -- upvalues: u174 (copy), u175 (copy)
    local u192 = u174[p191] and u174[p191][p190];

    if not u192 then
        warn("Tried to remove a non-existing reference");

        return;
    end;

    u174[p191][u192.Reference] = nil;

    local function rem(p193, p194, p195) -- Line: 1017
        -- upvalues: rem (copy), u192 (copy)
        if p195 <= #p194 then
            local v196 = p194[p195];
            local v197 = p193[v196];
            rem(v197, p194, p195 + 1);

            if next(v197) == nil then
                p193[v196] = nil;
            end;
        elseif p193.__Data == u192 then
            p193.__Data = nil;
        end;
    end;

    local v198 = u175[u192.Type];
    local Objects = u192.Objects;

    if #Objects >= 1 then
        local v199 = Objects[1];
        local v200 = v198[v199];
        rem(v200, Objects, 2);

        if next(v200) == nil then
            v198[v199] = nil;
        end;
    elseif v198.__Data == u192 then
        v198.__Data = nil;
    end;

    for _, v in ipairs(u192.Aliases) do
        if #v >= 1 then
            local v201 = v[1];
            local v202 = v198[v201];
            rem(v202, v, 2);

            if next(v202) == nil then
                v198[v201] = nil;
            end;
        elseif v198.__Data == u192 then
            v198.__Data = nil;
        end;
    end;
end;

function u1.GetObject(p203, p204, p205) -- Line: 1040
    -- upvalues: u174 (copy)
    local v206 = u174[p205] and u174[p205][p204];

    if v206 then
        return unpack(v206.Objects);
    end;

    return nil;
end;

function u1.GetReference(p207, ...) -- Line: 1049
    -- upvalues: u174 (copy), u175 (copy)
    local v208 = { ... };
    local v209 = table.remove(v208);

    if not u174[v209] then
        return nil;
    end;

    local v210 = u175[v209];

    for _, v in ipairs(v208) do
        v210 = v210[v];

        if not v210 then
            break;
        end;
    end;

    if v210 then
        v210 = v210.__Data;
    end;

    return v210 and v210.Reference or nil;
end;

return u1;