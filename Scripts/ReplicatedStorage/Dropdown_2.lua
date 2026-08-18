--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Dropdown
  Path:     game.ReplicatedStorage.SatchelLoader.Satchel.Packages._Index.1foreverhd_topbarplus@3.3.1.topbarplus.Elements.Dropdown
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:06 2026
]]

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Themes = require(script.Parent.Parent.Features.Themes);

return function(u1) -- Line: 5
    -- upvalues: Themes (copy), TweenService (copy), RunService (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "Dropdown";
    Frame.AutomaticSize = Enum.AutomaticSize.X;
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.AnchorPoint = Vector2.new(0.5, 0);
    Frame.Position = UDim2.new(0.5, 0, 1, 10);
    Frame.ZIndex = -2;
    Frame.ClipsDescendants = true;
    Frame.Parent = u1.widget;
    local GuiService = game:GetService("GuiService");
    u1:setBehaviour("Dropdown", "BackgroundTransparency", function(p2) -- Line: 20
        -- upvalues: GuiService (copy)
        if p2 == 1 then
            return p2;
        end;

        return p2 * GuiService.PreferredTransparency;
    end);
    u1.janitor:add(GuiService:GetPropertyChangedSignal("PreferredTransparency"):Connect(function() -- Line: 28
        -- upvalues: u1 (copy), Frame (copy)
        u1:refreshAppearance(Frame, "BackgroundTransparency");
    end));
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "DropdownCorner";
    UICorner.CornerRadius = UDim.new(0, 10);
    UICorner.Parent = Frame;
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Name = "DropdownScroller";
    ScrollingFrame.AutomaticSize = Enum.AutomaticSize.X;
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.AnchorPoint = Vector2.new(0, 0);
    ScrollingFrame.Position = UDim2.new(0, 0, 0, 0);
    ScrollingFrame.ZIndex = -1;
    ScrollingFrame.ClipsDescendants = true;
    ScrollingFrame.Visible = true;
    ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.None;
    ScrollingFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right;
    ScrollingFrame.Active = false;
    ScrollingFrame.ScrollingEnabled = true;
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame.ScrollBarThickness = 5;
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255);
    ScrollingFrame.ScrollBarImageTransparency = 0.8;
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0);
    ScrollingFrame.Selectable = false;
    ScrollingFrame.Active = true;
    ScrollingFrame.Parent = Frame;
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Name = "DropdownSpeed";
    NumberValue.Value = 0.07;
    NumberValue.Parent = Frame;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.Name = "DropdownPadding";
    UIPadding.PaddingTop = UDim.new(0, 0);
    UIPadding.PaddingBottom = UDim.new(0, 0);
    UIPadding.Parent = ScrollingFrame;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.Name = "DropdownList";
    UIListLayout.FillDirection = Enum.FillDirection.Vertical;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    UIListLayout.HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly;
    UIListLayout.Parent = ScrollingFrame;
    local dropdownJanitor = u1.dropdownJanitor;
    local iconModule = require(u1.iconModule);
    u1.dropdownChildAdded:Connect(function(u3) -- Line: 81
        local _, u4 = u3:modifyTheme({
            { "Widget", "BorderSize", 0 },
            { "IconCorners", "CornerRadius", UDim.new(0, 10) },
            { "Widget", "MinimumWidth", 190 },
            { "Widget", "MinimumHeight", 58 },
            { "IconLabel", "TextSize", 20 },
            { "IconOverlay", "Size", UDim2.new(1, 0, 1, 0) },
            { "PaddingLeft", "Size", UDim2.fromOffset(25, 0) },
            { "Notice", "Position", UDim2.new(1, -24, 0, 5) },
            { "ContentsList", "HorizontalAlignment", Enum.HorizontalAlignment.Left },
            { "Selection", "Size", UDim2.new(1, -0, 1, -0) },
            { "Selection", "Position", UDim2.new(0, 0, 0, 0) }
        });
        task.defer(function() -- Line: 95
            -- upvalues: u3 (copy), u4 (copy)
            u3.joinJanitor:add(function() -- Line: 96
                -- upvalues: u3 (ref), u4 (ref)
                u3:removeModification(u4);
            end);
        end);
    end);
    u1.dropdownSet:Connect(function(p5) -- Line: 101
        -- upvalues: u1 (copy), iconModule (copy)
        for _, v in pairs(u1.dropdownIcons) do
            iconModule.getIconByUID(v):destroy();
        end;

        if type(p5) == "table" then
            for _, v in pairs(p5) do
                v:joinDropdown(u1);
            end;
        end;
    end);

    local function updateMaxIcons() -- Line: 113
        -- upvalues: Frame (copy), ScrollingFrame (copy), UIPadding (copy)
        local v6 = Frame:GetAttribute("MaxIcons");

        if not v6 then
            return 0;
        end;

        local v7 = {};

        for _, child in pairs(ScrollingFrame:GetChildren()) do
            if child:IsA("GuiObject") and child.Visible then
                table.insert(v7, child);
            end;
        end;

        table.sort(v7, function(p8, p9) -- Line: 124
            return p8.AbsolutePosition.Y < p9.AbsolutePosition.Y;
        end);
        local v10 = math.ceil(v6);
        local v11 = 0;

        for i = 1, v10 do
            local v12 = v7[i];

            if not v12 then
                break;
            end;

            local Y = v12.AbsoluteSize.Y;
            local v13;

            if i == v10 then
                v13 = v10 ~= v6;
            else
                v13 = false;
            end;

            if v13 then
                Y = Y * (v6 - v10 + 1);
            end;

            v11 = v11 + Y;
        end;

        return v11 + (UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset);
    end;

    local u14 = nil;
    local u15 = nil;
    local u16 = nil;
    local u17 = nil;

    local function getTweenInfo() -- Line: 145
        -- upvalues: Themes (ref), Frame (copy), u16 (ref), u17 (ref), NumberValue (copy)
        local v18 = Themes.getInstanceValue(Frame, "MaxIcons") or 1;

        if u16 and (u16 == v18 and u17) then
            return u17;
        end;

        local v19 = TweenInfo.new(NumberValue.Value * v18, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
        u17 = v19;
        u16 = v18;

        return v19;
    end;

    local function updateVisibility() -- Line: 159
        -- upvalues: Themes (ref), Frame (copy), u16 (ref), u17 (ref), NumberValue (copy), u14 (ref), u15 (ref), u1 (copy), updateMaxIcons (copy), TweenService (ref)
        local v20 = Themes.getInstanceValue(Frame, "MaxIcons") or 1;
        local v21;

        if u16 and (u16 == v20 and u17) then
            v21 = u17;
        else
            v21 = TweenInfo.new(NumberValue.Value * v20, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
            u17 = v21;
            u16 = v20;
        end;

        if u14 then
            u14:Cancel();
            u14 = nil;
        end;

        if u15 then
            u15:Cancel();
            u15 = nil;
        end;

        if not u1.isSelected then
            u15 = TweenService:Create(Frame, TweenInfo.new(0), {
                Size = UDim2.new(0, Frame.Size.X.Offset, 0, 0)
            });
            u15:Play();
            u15.Completed:Connect(function() -- Line: 187
                -- upvalues: u15 (ref)
                u15 = nil;
            end);

            return;
        end;

        local v22 = updateMaxIcons();
        Frame.Visible = true;
        Frame.BackgroundTransparency = 0;
        Frame.Size = UDim2.new(0, Frame.Size.X.Offset, 0, 0);
        u14 = TweenService:Create(Frame, v21, {
            Size = UDim2.new(0, Frame.Size.X.Offset, 0, v22)
        });
        u14:Play();
        u14.Completed:Connect(function() -- Line: 180
            -- upvalues: u14 (ref)
            u14 = nil;
        end);
    end;

    dropdownJanitor:add(u1.toggled:Connect(updateVisibility));
    updateVisibility();

    local function updateChildSize() -- Line: 197
        -- upvalues: Themes (ref), Frame (copy), u16 (ref), u17 (ref), NumberValue (copy), u1 (copy), u14 (ref), u15 (ref), RunService (ref), updateMaxIcons (copy), TweenService (ref)
        local v23 = Themes.getInstanceValue(Frame, "MaxIcons") or 1;
        local v24;

        if u16 and (u16 == v23 and u17) then
            v24 = u17;
        else
            v24 = TweenInfo.new(NumberValue.Value * v23, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
            u17 = v24;
            u16 = v23;
        end;

        if not u1.isSelected then
            return;
        end;

        if u14 then
            u14:Cancel();
            u14 = nil;
        end;

        if u15 then
            u15:Cancel();
            u15 = nil;
        end;

        RunService.Heartbeat:Wait();
        local v25 = updateMaxIcons();
        u14 = TweenService:Create(Frame, v24, {
            Size = UDim2.new(0, Frame.Size.X.Offset, 0, v25)
        });
        u14:Play();
        u14.Completed:Connect(function() -- Line: 215
            -- upvalues: u14 (ref)
            u14 = nil;
        end);
    end;

    dropdownJanitor:add(u1.toggled:Connect(updateVisibility));
    local u26 = 0;
    local u27 = false;

    local function updateMaxIconsListener() -- Line: 228
        -- upvalues: u26 (ref), u27 (ref), updateMaxIconsListener (copy), Frame (copy), ScrollingFrame (copy), iconModule (copy), u1 (copy), UIPadding (copy)
        u26 = u26 + 1;

        if u27 then
            return;
        end;

        local u28 = u26;
        u27 = true;
        task.defer(function() -- Line: 233
            -- upvalues: u27 (ref), u26 (ref), u28 (copy), updateMaxIconsListener (ref)
            u27 = false;

            if u26 ~= u28 then
                updateMaxIconsListener();
            end;
        end);
        local v29 = Frame:GetAttribute("MaxIcons");

        if not v29 then
            return;
        end;

        local v30 = {};

        for _, child in pairs(ScrollingFrame:GetChildren()) do
            if child:IsA("GuiObject") and child.Visible then
                table.insert(v30, { child, child.AbsolutePosition.Y });
            end;
        end;

        table.sort(v30, function(p31, p32) -- Line: 248
            return p31[2] < p32[2];
        end);
        local v33 = math.ceil(v29);
        local v34 = 0;
        local v35 = false;

        for i = 1, v33 do
            local v36 = v30[i];

            if not v36 then
                break;
            end;

            local v37 = v36[1];
            local Y = v37.AbsoluteSize.Y;
            local v38;

            if i == v33 then
                v38 = v33 ~= v29;
            else
                v38 = false;
            end;

            if v38 then
                Y = Y * (v29 - v33 + 1);
            end;

            v34 = v34 + Y;

            if not v38 then
                local v39 = v37:GetAttribute("WidgetUID");

                if v39 then
                    v39 = iconModule.getIconByUID(v39);
                end;

                if v39 then
                    local v40;

                    if v35 then
                        v40 = nil;
                    else
                        v40 = u1:getInstance("ClickRegion");
                        v35 = true;
                    end;

                    v39:getInstance("ClickRegion").NextSelectionUp = v40;
                end;
            end;
        end;

        ScrollingFrame.Size = UDim2.fromOffset(0, v34 + (UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset));
    end;

    dropdownJanitor:add(ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(updateMaxIconsListener));
    dropdownJanitor:add(ScrollingFrame.ChildAdded:Connect(updateMaxIconsListener));
    dropdownJanitor:add(ScrollingFrame.ChildRemoved:Connect(updateChildSize));
    dropdownJanitor:add(ScrollingFrame.ChildRemoved:Connect(updateMaxIconsListener));
    dropdownJanitor:add(Frame:GetAttributeChangedSignal("MaxIcons"):Connect(updateMaxIconsListener));
    dropdownJanitor:add(Frame:GetAttributeChangedSignal("MaxIcons"):Connect(updateChildSize));
    dropdownJanitor:add(u1.childThemeModified:Connect(updateMaxIconsListener));
    updateMaxIconsListener();

    local function connectVisibilityListeners(p41) -- Line: 293
        -- upvalues: updateChildSize (copy)
        if p41:IsA("GuiObject") then
            p41:GetPropertyChangedSignal("Visible"):Connect(updateChildSize);
        end;
    end;

    for _, child in pairs(ScrollingFrame:GetChildren()) do
        if child:IsA("GuiObject") then
            child:GetPropertyChangedSignal("Visible"):Connect(updateChildSize);
        end;
    end;

    ScrollingFrame.ChildAdded:Connect(function(p42) -- Line: 304
        -- upvalues: RunService (ref), updateChildSize (copy)
        RunService.Heartbeat:Wait();

        if p42:IsA("GuiObject") then
            p42:GetPropertyChangedSignal("Visible"):Connect(updateChildSize);
        end;

        updateChildSize();
    end);
    Frame.Visible = false;

    return Frame;
end;