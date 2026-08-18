--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Overflow
  Path:     game.ReplicatedStorage.Library.Imported.TopbarPlus.Features.Overflow
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:06 2026
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
local u7 = nil;

function u1.start(p8) -- Line: 23
    -- upvalues: u7 (ref), u4 (ref), u2 (copy), Utility (copy), u1 (copy), CurrentCamera (copy)
    u7 = p8;
    u4 = u7.iconsDictionary;
    local v9 = nil;

    for _, v in pairs(u7.container) do
        if v9 == nil then
            if v.ScreenInsets == Enum.ScreenInsets.TopbarSafeInsets then
                v9 = v;
            end;
        end;

        for _, child in pairs(v.Holders:GetChildren()) do
            if child:GetAttribute("IsAHolder") then
                u2[child.Name] = child;
            end;
        end;
    end;

    local u10 = false;
    local u12 = Utility.createStagger(0.1, function(p11) -- Line: 41
        -- upvalues: u10 (ref), u1 (ref)
        if not u10 then
            return;
        end;

        if not p11 then
            u1.updateAvailableIcons("Center");
        end;

        u1.updateBoundary("Left");
        u1.updateBoundary("Right");
    end);
    task.delay(1, function() -- Line: 51
        -- upvalues: u10 (ref), u12 (copy)
        u10 = true;
        u12();
    end);
    u7.iconAdded:Connect(u12);
    u7.iconRemoved:Connect(u12);
    u7.iconChanged:Connect(u12);
    CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line: 61
        -- upvalues: u12 (copy)
        u12(true);
    end);
    v9:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 64
        -- upvalues: u12 (copy)
        u12(true);
    end);
end;

function u1.getWidth(p13, p14) -- Line: 69
    local widget = p13.widget;

    return widget:GetAttribute("TargetWidth") or widget.AbsoluteSize.X;
end;

function u1.getAvailableIcons(p15) -- Line: 74
    -- upvalues: u3 (copy), u1 (copy)
    return u3[p15] or u1.updateAvailableIcons(p15);
end;

function u1.updateAvailableIcons(p16) -- Line: 82
    -- upvalues: u2 (copy), u4 (ref), u6 (copy), u3 (copy)
    local _ = u2[p16].UIListLayout;
    local v17 = 0;
    local v18 = {};

    for _, v in pairs(u4) do
        local parentIconUID = v.parentIconUID;

        if (not parentIconUID or u6[parentIconUID]) and (v.alignment == p16 and not u6[v.UID]) then
            table.insert(v18, v);
            v17 = v17 + 1;
        end;
    end;

    if v17 <= 0 then
        return {};
    end;

    table.sort(v18, function(p19, p20) -- Line: 106
        local LayoutOrder = p19.widget.LayoutOrder;
        local LayoutOrder2 = p20.widget.LayoutOrder;
        local parentIconUID = p19.parentIconUID;
        local parentIconUID2 = p20.parentIconUID;

        if parentIconUID == parentIconUID2 then
            if LayoutOrder < LayoutOrder2 then
                return true;
            end;

            if LayoutOrder2 < LayoutOrder then
                return false;
            end;

            return p19.widget.AbsolutePosition.X < p20.widget.AbsolutePosition.X;
        end;

        if parentIconUID2 then
            return false;
        end;

        if parentIconUID then
            return true;
        end;
    end);
    u3[p16] = v18;

    return v18;
end;

function u1.getRealXPositions(p21, p22) -- Line: 132
    -- upvalues: u2 (copy), Utility (copy), u1 (copy)
    local v23 = p21 == "Left";
    local v24 = u2[p21];
    local X = v24.AbsolutePosition.X;
    local Offset = v24.UIListLayout.Padding.Offset;
    local v25 = v23 and X and X or X + v24.AbsoluteSize.X;
    local v26 = {};

    if v23 then
        Utility.reverseTable(p22);
    end;

    for i = #p22, 1, -1 do
        local v27 = p22[i];
        local v28 = u1.getWidth(v27);

        if not v23 then
            v25 = v25 - v28;
        end;

        v26[v27.UID] = v25;

        if v23 then
            v25 = v25 + v28;
        end;

        v25 = v25 + (v23 and Offset and Offset or -Offset);
    end;

    return v26;
end;

function u1.updateBoundary(p29) -- Line: 162
    -- upvalues: u2 (copy), u1 (copy), u5 (copy), u7 (ref), u6 (copy), Utility (copy)
    local v30 = u2[p29];
    local UIListLayout = v30.UIListLayout;
    local X = v30.AbsolutePosition.X;
    local X2 = v30.AbsoluteSize.X;
    local Offset = UIListLayout.Padding.Offset;
    local Offset2 = UIListLayout.Padding.Offset;
    local v31 = u1.updateAvailableIcons(p29);
    local v32 = 0;
    local v33 = 0;

    for _, v in pairs(v31) do
        v32 = v32 + (u1.getWidth(v) + Offset2);
        v33 = v33 + 1;
    end;

    if v33 <= 0 then
        return;
    end;

    local v34 = p29 == "Left";
    local v35 = not v34;
    local v36 = u5[p29];

    if not v36 and (not (p29 == "Central") and #v31 > 0) then
        v36 = u7.new();
        v36:setImage(6069276526, "Deselected");
        v36:setName("Overflow" .. p29);
        v36:setOrder(v34 and -9999999 or 9999999);
        v36:setAlignment(p29);
        v36:autoDeselect(false);
        v36.isAnOverflow = true;
        v36:select("OverflowStart", v36);
        v36:setEnabled(false);
        u5[p29] = v36;
        u6[v36.UID] = true;
    end;

    local v37 = p29 == "Left" and "Right" or "Left";
    local v38 = u1.updateAvailableIcons(v37);
    local v39 = v34 and v38[1];

    if not v39 then
        if v35 then
            v39 = v38[#v38];
        else
            v39 = v35;
        end;
    end;

    local v40 = u5[v37];
    local v41;

    if v34 then
        v41 = X + X2 or X;
    else
        v41 = X;
    end;

    if v39 then
        local _ = v39.widget;
        local v42 = u1.getRealXPositions(v37, v38)[v39.UID];
        local v43 = u1.getWidth(v39);
        v41 = v34 and v42 - Offset or v42 + v43 + Offset;
    end;

    local v44 = u1.getAvailableIcons("Center");
    local v45 = v44[v34 and 1 or #v44];

    if v45 and not v45.hasRelocatedInOverflow then
        local v46 = v34 and v31[#v31];

        if not v46 then
            if v35 then
                v46 = v31[1];
            else
                v46 = v35;
            end;
        end;

        local X3 = v45.widget.AbsolutePosition.X;
        local X4 = v46.widget.AbsolutePosition.X;
        local v47 = u1.getWidth(v46);
        local v48 = v34 and X3 - Offset or X3 + u1.getWidth(v45) + Offset;

        if v34 then
            X4 = X4 + v47 or X4;
        end;

        if v34 then
            if v48 < X4 then
                v45:align("Left");
                v45.hasRelocatedInOverflow = true;
            end;
        elseif v35 and X4 < v48 then
            v45:align("Right");
            v45.hasRelocatedInOverflow = true;
        end;
    end;

    if v36 then
        local v49 = v36:getInstance("Menu");
        local v50 = X + X2;

        if v49 and v40 then
            local X3 = v40.widget.AbsolutePosition.X;
            local v51 = u1.getWidth(v40);
            local v52 = v34 and X3 - Offset or X3 + v51 + Offset;
            local v53 = v40:getInstance("Menu");
            local v54 = X + X2 / 2;
            local v55 = v34 and v54 - Offset / 2 or v54 + Offset / 2;

            if v49.AbsoluteCanvasSize.X >= v53.AbsoluteCanvasSize.X then
                v55 = v52;
            end;

            X2 = v34 and v55 - X or v50 - v55;
        end;

        local v56;

        if v49 then
            v56 = v49:GetAttribute("MaxWidth");
        else
            v56 = v49;
        end;

        local v57 = Utility.round(X2);

        if v49 and v56 ~= v57 then
            v49:SetAttribute("MaxWidth", v57);
        end;
    end;

    local v58 = u1.getRealXPositions(p29, v31);
    local v59 = false;

    for i = #v31, 1, -1 do
        local v60 = v31[i];
        local v61 = u1.getWidth(v60);
        local v62 = v58[v60.UID];

        if v34 and v41 <= v62 + v61 or v35 and v62 <= v41 then
            v59 = true;
        end;
    end;

    for i = #v31, 1, -1 do
        local v63 = v31[i];

        if not u6[v63.UID] then
            if v59 and not v63.parentIconUID then
                v63:joinMenu(v36);
            elseif not v59 and v63.parentIconUID then
                v63:leave();
            end;
        end;
    end;

    if v36.isEnabled ~= v59 then
        v36:setEnabled(v59);
    end;

    if v36.isEnabled and not v36.overflowAlreadyOpened then
        v36.overflowAlreadyOpened = true;
        v36:select();
    end;
end;

return u1;