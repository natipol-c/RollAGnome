--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AtomicBinding
  Path:     game.StarterPlayer.StarterPlayerScripts.RbxCharacterSounds.AtomicBinding
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:10 2026
]]

-- Decompiled with Potassium's decompiler.

local function parsePath(p1) -- Line: 4
    local v2 = string.split(p1, "/");

    for i = #v2, 1, -1 do
        if v2[i] == "" then
            table.remove(v2, i);
        end;
    end;

    return v2;
end;

local function isManifestResolved(p3, p4) -- Line: 14
    local v5 = 0;

    for _ in pairs(p3) do
        v5 = v5 + 1;
    end;

    assert(v5 <= p4, v5);

    return v5 == p4;
end;

local function unbindNodeDescend(p6, p7) -- Line: 24
    -- upvalues: unbindNodeDescend (copy)
    if p6.instance == nil then
        return;
    end;

    p6.instance = nil;
    local connections = p6.connections;

    if connections then
        for _, v in ipairs(connections) do
            v:Disconnect();
        end;

        table.clear(connections);
    end;

    if p7 and p6.alias then
        p7[p6.alias] = nil;
    end;

    local children = p6.children;

    if children then
        for _, v in pairs(children) do
            unbindNodeDescend(v, p7);
        end;
    end;
end;

local u8 = {};
u8.__index = u8;

function u8.new(p9, p10) -- Line: 54
    -- upvalues: parsePath (copy), u8 (copy)
    local v11 = {};
    local v12 = 1;
    local v13 = {};
    local v14 = {};
    local v15 = {};
    local v16 = {};

    for i, v in pairs(p9) do
        v11[i] = parsePath(v);
        v12 = v12 + 1;
    end;

    return setmetatable({
        _boundFn = p10,
        _parsedManifest = v11,
        _manifestSizeTarget = v12,
        _dtorMap = v13,
        _connections = v14,
        _rootInstToRootNode = v15,
        _rootInstToManifest = v16
    }, u8);
end;

function u8._startBoundFn(p17, p18, p19) -- Line: 80
    local _boundFn = p17._boundFn;
    local _dtorMap = p17._dtorMap;
    local v20 = _dtorMap[p18];

    if v20 then
        v20();
        _dtorMap[p18] = nil;
    end;

    local v21 = _boundFn(p19);

    if v21 then
        _dtorMap[p18] = v21;
    end;
end;

function u8._stopBoundFn(p22, p23) -- Line: 96
    local _dtorMap = p22._dtorMap;
    local v24 = _dtorMap[p23];

    if v24 then
        v24();
        _dtorMap[p23] = nil;
    end;
end;

function u8.bindRoot(u25, u26) -- Line: 106
    -- upvalues: unbindNodeDescend (copy)
    debug.profilebegin("AtomicBinding:BindRoot");
    local _parsedManifest = u25._parsedManifest;
    local _rootInstToRootNode = u25._rootInstToRootNode;
    local _rootInstToManifest = u25._rootInstToManifest;
    local _manifestSizeTarget = u25._manifestSizeTarget;
    assert(_rootInstToManifest[u26] == nil);
    local u27 = {};
    _rootInstToManifest[u26] = u27;
    debug.profilebegin("BuildTree");
    local v28 = {
        alias = "root",
        instance = u26
    };

    if next(_parsedManifest) then
        v28.children = {};
        v28.connections = {};
    end;

    _rootInstToRootNode[u26] = v28;

    for i, v in pairs(_parsedManifest) do
        local v29 = v28;

        for i2, v2 in ipairs(v) do
            local v30 = v28.children[v2] or {};

            if i2 == #v then
                if v30.alias ~= nil then
                    error("Multiple aliases assigned to one instance");
                end;

                v30.alias = i;
            else
                v30.children = v30.children or {};
                v30.connections = v30.connections or {};
            end;

            v28.children[v2] = v30;
            v28 = v30;
        end;

        v28 = v29;
    end;

    debug.profileend();

    local function processNode(p31) -- Line: 160
        -- upvalues: u27 (copy), processNode (copy), u25 (copy), u26 (copy), unbindNodeDescend (ref), _manifestSizeTarget (copy)
        local u32 = assert(p31.instance);
        local children = p31.children;
        local alias = p31.alias;
        local v33 = not children;

        if alias then
            u27[alias] = u32;
        end;

        if not v33 then
            local function processAddChild(p34) -- Line: 172
                -- upvalues: children (copy), processNode (ref)
                local v35 = children[p34.Name];

                if not v35 or v35.instance ~= nil then
                    return;
                end;

                v35.instance = p34;
                processNode(v35);
            end;

            local function processDeleteChild(p36) -- Line: 183
                -- upvalues: children (copy), u25 (ref), u26 (ref), unbindNodeDescend (ref), u27 (ref), u32 (copy), processNode (ref)
                local Name = p36.Name;
                local v37 = children[Name];

                if not v37 then
                    return;
                end;

                if v37.instance ~= p36 then
                    return;
                end;

                u25:_stopBoundFn(u26);
                unbindNodeDescend(v37, u27);
                assert(v37.instance == nil);
                local v38 = u32:FindFirstChild(Name);
                local v39 = v38 and children[v38.Name];

                if v39 then
                    if v39.instance ~= nil then
                        return;
                    end;

                    v39.instance = v38;
                    processNode(v39);
                end;
            end;

            for _, child in ipairs(u32:GetChildren()) do
                local v40 = children[child.Name];

                if v40 then
                    if v40.instance == nil then
                        v40.instance = child;
                        processNode(v40);
                    end;
                end;
            end;

            table.insert(p31.connections, u32.ChildAdded:Connect(processAddChild));
            table.insert(p31.connections, u32.ChildRemoved:Connect(processDeleteChild));
        end;

        if v33 then
            local v41 = _manifestSizeTarget;
            local v42 = 0;

            for _ in pairs(u27) do
                v42 = v42 + 1;
            end;

            assert(v42 <= v41, v42);

            if v42 == v41 then
                u25:_startBoundFn(u26, u27);
            end;
        end;
    end;

    debug.profilebegin("ResolveTree");
    processNode(v28);
    debug.profileend();
    debug.profileend();
end;

function u8.unbindRoot(p43, p44) -- Line: 236
    -- upvalues: unbindNodeDescend (copy)
    local _rootInstToRootNode = p43._rootInstToRootNode;
    local _rootInstToManifest = p43._rootInstToManifest;
    p43:_stopBoundFn(p44);
    local v45 = _rootInstToRootNode[p44];

    if v45 then
        unbindNodeDescend(v45, (assert(_rootInstToManifest[p44])));
        _rootInstToRootNode[p44] = nil;
    end;

    _rootInstToManifest[p44] = nil;
end;

function u8.destroy(p46) -- Line: 252
    -- upvalues: unbindNodeDescend (copy)
    debug.profilebegin("AtomicBinding:destroy");

    for _, v in pairs(p46._dtorMap) do
        v:destroy();
    end;

    table.clear(p46._dtorMap);

    for _, v in ipairs(p46._connections) do
        v:Disconnect();
    end;

    table.clear(p46._connections);
    local _rootInstToManifest = p46._rootInstToManifest;

    for i, v in pairs(p46._rootInstToRootNode) do
        unbindNodeDescend(v, (assert(_rootInstToManifest[i])));
    end;

    table.clear(p46._rootInstToManifest);
    table.clear(p46._rootInstToRootNode);
    debug.profileend();
end;

return u8;