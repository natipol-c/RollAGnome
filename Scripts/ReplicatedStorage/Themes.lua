--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Themes
  Path:     game.ReplicatedStorage.Library.Imported.TopbarPlus.Features.Themes
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:03 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
local Utility = require(script.Parent.Parent.Utility);
local Default = require(script.Default);

function u1.getThemeValue(p2, p3, p4, p5) -- Line: 16
    if p2 then
        for _, v in pairs(p2) do
            local v6, v7, v8 = unpack(v);

            if p3 == v6 and p4 == v7 then
                return v8;
            end;
        end;
    end;
end;

function u1.getInstanceValue(u9, u10) -- Line: 27
    local success, result = pcall(function() -- Line: 28
        -- upvalues: u9 (copy), u10 (copy)
        return u9[u10];
    end);

    if not success then
        result = u9:GetAttribute(u10);
    end;

    return result;
end;

function u1.getRealInstance(p11) -- Line: 37
    if not p11:GetAttribute("IsAClippedClone") then
        return;
    end;

    local OriginalInstance = p11:FindFirstChild("OriginalInstance");

    if OriginalInstance then
        return OriginalInstance.Value;
    end;
end;

function u1.getClippedClone(p12) -- Line: 48
    if not p12:GetAttribute("HasAClippedClone") then
        return;
    end;

    local ClippedClone = p12:FindFirstChild("ClippedClone");

    if ClippedClone then
        return ClippedClone.Value;
    end;
end;

function u1.refresh(p13, p14, p15) -- Line: 59
    -- upvalues: u1 (copy)
    if p15 then
        local v16 = p13:getStateGroup();
        local v17 = u1.getThemeValue(v16, p14.Name, p15) or u1.getInstanceValue(p14, p15);
        u1.apply(p13, p14, p15, v17, true);

        return;
    end;

    local v18 = p13:getStateGroup();

    if not v18 then
        return;
    end;

    local v19 = {
        [p14.Name] = p14
    };

    for _, descendant in pairs(p14:GetDescendants()) do
        local v20 = descendant:GetAttribute("Collective");

        if v20 then
            v19[v20] = descendant;
        end;

        v19[descendant.Name] = descendant;
    end;

    for _, v in pairs(v18) do
        local v21, v22, v23 = unpack(v);
        local v24 = v19[v21];

        if v24 then
            u1.apply(p13, v24.Name, v22, v23, true);
        end;
    end;
end;

function u1.apply(p25, p26, u27, u28, p29) -- Line: 92
    -- upvalues: u1 (copy)
    if p25.isDestroyed then
        return;
    end;

    local v30;

    if typeof(p26) == "Instance" then
        p26 = p26.Name;
        v30 = { p26 };
    else
        v30 = p25:getInstanceOrCollective(p26);
    end;

    local v31 = p25.customBehaviours[p26 .. "-" .. u27];

    for _, v in pairs(v30) do
        local v32 = u1.getClippedClone(v);

        if v32 then
            table.insert(v30, v32);
        end;
    end;

    for _, v in pairs(v30) do
        if u27 ~= "Position" or not u1.getClippedClone(v) then
            if (u27 ~= "Size" or not u1.getRealInstance(v)) and (p29 or u28 ~= u1.getInstanceValue(v, u27)) then
                if v31 then
                    local v33 = v31(u28, v, u27);

                    if v33 ~= nil then
                        u28 = v33;
                    end;
                end;

                if not pcall(function() -- Line: 138
                    -- upvalues: v (copy), u27 (copy), u28 (ref)
                    v[u27] = u28;
                end) then
                    v:SetAttribute(u27, u28);
                end;
            end;
        end;
    end;
end;

function u1.getModifications(p34) -- Line: 152
    return typeof(p34[1]) ~= "table" and { p34 } or p34;
end;

function u1.merge(p35, p36, p37) -- Line: 161
    -- upvalues: u1 (copy)
    local v38, v39, v40, v41 = table.unpack(p36);
    local v42, v43, _, v44 = table.unpack(p35);

    if v38 ~= v42 or (v39 ~= v43 or not u1.statesMatch(v41, v44)) then
        return false;
    end;

    p35[3] = v40;

    if p37 then
        p37(p35);
    end;

    return true;
end;

function u1.modify(u45, u46, u47) -- Line: 174
    -- upvalues: Utility (copy), u1 (copy)
    task.spawn(function() -- Line: 182
        -- upvalues: u47 (ref), Utility (ref), u46 (ref), u1 (ref), u45 (copy)
        u47 = u47 or Utility.generateUID();
        u46 = u1.getModifications(u46);

        for _, v in pairs(u46) do
            local u48, u49, u50, v51 = table.unpack(v);

            if v51 == nil then
                u1.modify(u45, {
                    u48,
                    u49,
                    u50,
                    "Selected"
                }, u47);
                u1.modify(u45, {
                    u48,
                    u49,
                    u50,
                    "Viewing"
                }, u47);
            end;

            local u52 = Utility.formatStateName(v51 or "Deselected");
            local u53 = u45:getStateGroup(u52);

            local function nowSetIt() -- Line: 194
                -- upvalues: u52 (copy), u45 (ref), u1 (ref), u48 (copy), u49 (copy), u50 (copy)
                if u52 == u45.activeState then
                    u1.apply(u45, u48, u49, u50);
                end;
            end;

            (function() -- Line: 199, Name: updateRecord
                -- upvalues: u53 (copy), u1 (ref), v (copy), u47 (ref), u52 (copy), u45 (ref), u48 (copy), u49 (copy), u50 (copy)
                for _, v2 in pairs(u53) do
                    if u1.merge(v2, v, function(p54) -- Line: 201
                        -- upvalues: u47 (ref), u52 (ref), u45 (ref), u1 (ref), u48 (ref), u49 (ref), u50 (ref)
                        p54[5] = u47;

                        if u52 == u45.activeState then
                            u1.apply(u45, u48, u49, u50);
                        end;
                    end) then
                        return;
                    end;
                end;

                table.insert(u53, {
                    u48,
                    u49,
                    u50,
                    u52,
                    u47
                });

                if u52 == u45.activeState then
                    u1.apply(u45, u48, u49, u50);
                end;
            end)();
        end;
    end);

    return u47;
end;

function u1.remove(p55, p56) -- Line: 219
    -- upvalues: u1 (copy)
    for _, v in pairs(p55.appearance) do
        for i = #v, 1, -1 do
            if v[i][5] == p56 then
                table.remove(v, i);
            end;
        end;
    end;

    u1.rebuild(p55);
end;

function u1.removeWith(p57, p58, p59, p60) -- Line: 232
    -- upvalues: u1 (copy)
    for i, v in pairs(p57.appearance) do
        if p60 == i or not p60 then
            for i2 = #v, 1, -1 do
                local v61 = v[i2];

                if v61[1] == p58 and v61[2] == p59 then
                    table.remove(v, i2);
                end;
            end;
        end;
    end;

    u1.rebuild(p57);
end;

function u1.change(p62) -- Line: 248
    -- upvalues: u1 (copy)
    local v63 = p62:getStateGroup();

    for _, v in pairs(v63) do
        local v64, v65, v66 = unpack(v);
        u1.apply(p62, v64, v65, v66);
    end;
end;

function u1.set(u67, p68) -- Line: 258
    -- upvalues: u1 (copy)
    local themesJanitor = u67.themesJanitor;
    themesJanitor:clean();
    themesJanitor:add(u67.stateChanged:Connect(function() -- Line: 264
        -- upvalues: u1 (ref), u67 (copy)
        u1.change(u67);
    end));

    if typeof(p68) == "Instance" and p68:IsA("ModuleScript") then
        p68 = require(p68);
    end;

    u67.appliedTheme = p68;
    u1.rebuild(u67);
end;

function u1.statesMatch(p69, p70) -- Line: 274
    local v71;

    if p69 then
        v71 = string.lower(p69);
    else
        v71 = p69;
    end;

    local v72;

    if p70 then
        v72 = string.lower(p70);
    else
        v72 = p70;
    end;

    return v71 == v72 and true or not (p69 and p70);
end;

function u1.rebuild(u73) -- Line: 281
    -- upvalues: u1 (copy), Utility (copy), Default (copy)
    local appliedTheme = u73.appliedTheme;
    local u74 = { "Deselected", "Selected", "Viewing" };
    (function() -- Line: 288, Name: generateTheme
        -- upvalues: u74 (copy), u1 (ref), Utility (ref), Default (ref), appliedTheme (copy), u73 (copy)
        for _, v in pairs(u74) do
            local u75 = {};

            local function updateDetails(p76, p77) -- Line: 294
                -- upvalues: u1 (ref), Utility (ref), u75 (copy)
                if not p76 then
                    return;
                end;

                for _, v2 in pairs(p76) do
                    local v78 = v2[5];

                    if u1.statesMatch(p77, v2[4]) then
                        local v79 = v2[1] .. "-" .. v2[2];
                        local v80 = Utility.copyTable(v2);
                        v80[5] = v78;
                        u75[v79] = v80;
                    end;
                end;
            end;

            if v == "Selected" then
                updateDetails(Default, "Deselected");
            end;

            updateDetails(Default, "Empty");
            updateDetails(Default, v);

            if appliedTheme ~= Default then
                if v == "Selected" then
                    updateDetails(appliedTheme, "Deselected");
                end;

                updateDetails(Default, "Empty");
                updateDetails(appliedTheme, v);
            end;

            local v81 = {};
            local v82 = u73.appearance[v];

            if v82 then
                for _, v2 in pairs(v82) do
                    local v83 = v2[5];

                    if v83 ~= nil then
                        table.insert(v81, {
                            v2[1],
                            v2[2],
                            v2[3],
                            v,
                            v83
                        });
                    end;
                end;
            end;

            updateDetails(v81, v);
            local v84 = {};

            for _, v2 in pairs(u75) do
                table.insert(v84, v2);
            end;

            u73.appearance[v] = v84;
        end;

        u1.change(u73);
    end)();
end;

return u1;