--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Overflow
  Path:     game.ReplicatedStorage.SatchelLoader.Satchel.Packages._Index.1foreverhd_topbarplus@3.3.1.topbarplus.Features.Overflow
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:05 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {};
local u3 = {};
local u4 = nil;
local CurrentCamera = workspace.CurrentCamera;
local u5 = {};
local u6 = {};
local Utility = require(script.Parent.Parent.Utility);
local u7 = false;
local u8 = false;
local u9 = nil;

function u1.start(p10) -- Line: 25
    -- upvalues: u9 (ref), u4 (ref), u2 (copy), Utility (copy), u1 (copy), u7 (ref), CurrentCamera (copy)
    u9 = p10;
    u4 = u9.iconsDictionary;
    local v11 = nil;

    for _, v in pairs(u9.container) do
        if v11 == nil then
            if v.ScreenInsets == Enum.ScreenInsets.TopbarSafeInsets then
                v11 = v;
            end;
        end;

        for _, child in pairs(v.Holders:GetChildren()) do
            if child:GetAttribute("IsAHolder") then
                u2[child.Name] = child;
            end;
        end;
    end;

    local u12 = false;
    local u14 = Utility.createStagger(0.1, function(p13) -- Line: 43
        -- upvalues: u12 (ref), u1 (ref)
        if not u12 then
            return;
        end;

        if not p13 then
            u1.updateAvailableIcons("Center");
        end;

        u1.updateBoundary("Left");
        u1.updateBoundary("Right");
    end);
    task.delay(0.5, function() -- Line: 53
        -- upvalues: u12 (ref), u14 (copy)
        u12 = true;
        u14();
    end);
    task.delay(2, function() -- Line: 57
        -- upvalues: u7 (ref), u14 (copy)
        u7 = true;
        u14();
    end);
    u9.iconAdded:Connect(u14);
    u9.iconRemoved:Connect(u14);
    u9.iconChanged:Connect(u14);
    CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line: 67
        -- upvalues: u14 (copy)
        u14(true);
    end);
    v11:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 70
        -- upvalues: u14 (copy)
        u14(true);
    end);
end;

function u1.getWidth(p15, p16) -- Line: 75
    local widget = p15.widget;

    return widget:GetAttribute("TargetWidth") or widget.AbsoluteSize.X;
end;

function u1.getAvailableIcons(p17) -- Line: 80
    -- upvalues: u3 (copy), u1 (copy)
    return u3[p17] or u1.updateAvailableIcons(p17);
end;

function u1.updateAvailableIcons(p18) -- Line: 88
    -- upvalues: u4 (ref), u6 (copy), u3 (copy)
    local v19 = 0;
    local v20 = {};

    for _, v in pairs(u4) do
        local parentIconUID = v.parentIconUID;

        if (not parentIconUID or u6[parentIconUID]) and (v.alignment == p18 and (not u6[v.UID] and v.isEnabled)) then
            table.insert(v20, v);
            v19 = v19 + 1;
        end;
    end;

    if v19 <= 0 then
        return {};
    end;

    table.sort(v20, function(p21, p22) -- Line: 110
        local LayoutOrder = p21.widget.LayoutOrder;
        local LayoutOrder2 = p22.widget.LayoutOrder;
        local parentIconUID = p21.parentIconUID;
        local parentIconUID2 = p22.parentIconUID;

        if parentIconUID ~= parentIconUID2 then
            if parentIconUID2 then
                return false;
            end;

            return parentIconUID and true or nil;
        end;

        if LayoutOrder < LayoutOrder2 then
            return true;
        end;

        if LayoutOrder2 < LayoutOrder then
            return false;
        end;

        return p21.widget.AbsolutePosition.X < p22.widget.AbsolutePosition.X;
    end);
    u3[p18] = v20;

    return v20;
end;

function u1.getRealXPositions(p23, p24) -- Line: 137
    -- upvalues: u2 (copy), Utility (copy), u1 (copy)
    local v25 = p23 == "Left";
    local v26 = u2[p23];
    local X = v26.AbsolutePosition.X;
    local Offset = v26.UIListLayout.Padding.Offset;
    local v27 = v25 and X and X or X + v26.AbsoluteSize.X;
    local v28 = {};

    if v25 then
        Utility.reverseTable(p24);
    end;

    for i = #p24, 1, -1 do
        local v29 = p24[i];
        local v30 = u1.getWidth(v29);

        if not v25 then
            v27 = v27 - v30;
        end;

        v28[v29.UID] = v27;

        if v25 then
            v27 = v27 + v30;
        end;

        v27 = v27 + (v25 and Offset and Offset or -Offset);
    end;

    return v28;
end;

function u1.updateBoundary(u31) -- Line: 166
    -- upvalues: u2 (copy), u1 (copy), u5 (copy), u9 (ref), u6 (copy), u8 (ref), u7 (ref), Utility (copy)
    local v32 = u2[u31];
    local UIListLayout = v32.UIListLayout;
    local X = v32.AbsolutePosition.X;
    local X2 = v32.AbsoluteSize.X;
    local Offset = UIListLayout.Padding.Offset;
    local Offset2 = UIListLayout.Padding.Offset;
    local u33 = u1.updateAvailableIcons(u31);
    local v34 = 0;
    local v35 = 0;

    for _, v in pairs(u33) do
        v34 = v34 + (u1.getWidth(v) + Offset2);
        v35 = v35 + 1;
    end;

    if v35 <= 0 then
        return;
    end;

    local u36 = u31 == "Left";
    local u37 = not u36;
    local v38 = u5[u31];

    if not v38 and (not (u31 == "Center") and #u33 > 0) then
        v38 = u9.new();
        v38:setImage(6069276526, "Deselected");
        v38:setName("Overflow" .. u31);
        v38:setOrder(u36 and -9999999 or 9999999);
        v38:setAlignment(u31);
        v38:autoDeselect(false);
        v38.isAnOverflow = true;
        v38:select("OverflowStart", v38);
        v38:setEnabled(false);
        u5[u31] = v38;
        u6[v38.UID] = true;

        if not u9.closeableOverflowMenus then
            v38:getInstance("IconSpot").Visible = false;
        end;
    end;

    local v39 = u31 == "Left" and "Right" or "Left";
    local v40 = u1.updateAvailableIcons(v39);
    local v41 = u36 and v40[1];

    if not v41 then
        if u37 then
            v41 = v40[#v40];
        else
            v41 = u37;
        end;
    end;

    local v42 = u5[v39];
    local v43;

    if u36 then
        v43 = X + X2 or X;
    else
        v43 = X;
    end;

    if v41 then
        local v44 = u1.getRealXPositions(v39, v40)[v41.UID];
        local v45 = u1.getWidth(v41);
        v43 = u36 and v44 - Offset or v44 + v45 + Offset;
    end;

    local u46 = 0;

    local function checkToShiftCentralIcon() -- Line: 233
        -- upvalues: u1 (ref), u36 (copy), u8 (ref), u31 (copy), u33 (copy), u37 (copy), Offset (copy), u7 (ref), u46 (ref), checkToShiftCentralIcon (copy)
        local v47 = u1.getAvailableIcons("Center");
        local v48 = v47[u36 and 1 or #v47];

        local function secondaryCheck() -- Line: 237
            -- upvalues: u8 (ref), u1 (ref), u31 (ref)
            if not u8 then
                u8 = true;
                task.delay(3, u1.updateBoundary, u31);
            end;
        end;

        if v48 and not v48.hasRelocatedInOverflow then
            local v49 = u36 and u33[#u33] or u37 and u33[1];
            local X3 = v48.widget.AbsolutePosition.X;
            local X4 = v49.widget.AbsolutePosition.X;
            local v50 = u1.getWidth(v49);
            local v51 = u36 and X3 - Offset or X3 + u1.getWidth(v48) + Offset;

            if u36 then
                X4 = X4 + v50 or X4;
            end;

            local v52 = false;

            if u36 then
                if v51 < X4 then
                    if not u7 then
                        if not u8 then
                            u8 = true;
                            task.delay(3, u1.updateBoundary, u31);
                        end;

                        return;
                    end;

                    v48:align("Left");
                    v48.hasRelocatedInOverflow = true;
                    v52 = true;
                end;
            elseif u37 and X4 < v51 then
                if not u7 or X4 < 0 then
                    if not u8 then
                        u8 = true;
                        task.delay(3, u1.updateBoundary, u31);
                    end;

                    return;
                end;

                v48:align("Right");
                v48.hasRelocatedInOverflow = true;
                v52 = true;
            end;

            if v52 then
                u46 = u46 + 1;

                if u46 <= 4 then
                    u1.updateAvailableIcons("Center");
                    checkToShiftCentralIcon();
                end;
            end;
        end;
    end;

    checkToShiftCentralIcon();

    if v38 then
        local v53 = v38:getInstance("Menu");
        local v54 = X + X2;

        if v53 and v42 then
            local X3 = v42.widget.AbsolutePosition.X;
            local v55 = u1.getWidth(v42);
            local v56 = u36 and X3 - Offset or X3 + v55 + Offset;
            local v57 = v42:getInstance("Menu");
            local v58 = X + X2 / 2;
            local v59 = u36 and v58 - Offset / 2 or v58 + Offset / 2;

            if v53.AbsoluteCanvasSize.X >= v57.AbsoluteCanvasSize.X then
                v59 = v56;
            end;

            X2 = u36 and v59 - X or v54 - v59;
        end;

        local v60;

        if v53 then
            v60 = v53:GetAttribute("MaxWidth");
        else
            v60 = v53;
        end;

        local v61 = Utility.round(X2);

        if v53 and v60 ~= v61 then
            v53:SetAttribute("MaxWidth", v61);
        end;
    end;

    local v62 = u1.getRealXPositions(u31, u33);
    local v63 = false;

    for i = #u33, 1, -1 do
        local v64 = u33[i];
        local v65 = u1.getWidth(v64);
        local v66 = v62[v64.UID];

        if u36 and v43 <= v66 + v65 or u37 and v66 <= v43 then
            v63 = true;
        end;
    end;

    for i = #u33, 1, -1 do
        local v67 = u33[i];

        if not u6[v67.UID] then
            if v63 and not v67.parentIconUID then
                v67:joinMenu(v38);
            elseif not v63 and v67.parentIconUID then
                v67:leave();
            end;
        end;
    end;

    if v38.isEnabled ~= v63 then
        v38:setEnabled(v63);
    end;

    if v38.isEnabled and not v38.overflowAlreadyOpened then
        v38.overflowAlreadyOpened = true;
        v38:select();
    end;
end;

return u1;