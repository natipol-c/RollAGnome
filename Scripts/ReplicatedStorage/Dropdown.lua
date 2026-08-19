--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Dropdown
  Path:     game.ReplicatedStorage.Library.Imported.TopbarPlus.Elements.Dropdown
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:26 2026
]]

-- Decompiled with Potassium's decompiler.

return function(u1) -- Line: 1
    local Frame = Instance.new("Frame");
    Frame.Name = "Dropdown";
    Frame.AutomaticSize = Enum.AutomaticSize.XY;
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.AnchorPoint = Vector2.new(0.5, 0);
    Frame.Position = UDim2.new(0.5, 0, 1, 10);
    Frame.ZIndex = -2;
    Frame.ClipsDescendants = true;
    Frame.Parent = u1.widget;
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
    ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar;
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
    local UIPadding = Instance.new("UIPadding");
    UIPadding.Name = "DropdownPadding";
    UIPadding.PaddingTop = UDim.new(0, 8);
    UIPadding.PaddingBottom = UDim.new(0, 8);
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
    u1.dropdownChildAdded:Connect(function(u2) -- Line: 58
        local _, u3 = u2:modifyTheme({
            { "Widget", "BorderSize", 0 },
            { "IconCorners", "CornerRadius", UDim.new(0, 4) },
            { "Widget", "MinimumWidth", 190 },
            { "Widget", "MinimumHeight", 56 },
            { "IconLabel", "TextSize", 19 },
            { "PaddingLeft", "Size", UDim2.fromOffset(25, 0) },
            { "Notice", "Position", UDim2.new(1, -24, 0, 5) },
            { "ContentsList", "HorizontalAlignment", Enum.HorizontalAlignment.Left },
            { "Selection", "Size", UDim2.new(1, -8, 1, -8) },
            { "Selection", "Position", UDim2.new(0, 4, 0, 4) }
        });
        task.defer(function() -- Line: 72
            -- upvalues: u2 (copy), u3 (copy)
            u2.joinJanitor:add(function() -- Line: 73
                -- upvalues: u2 (ref), u3 (ref)
                u2:removeModification(u3);
            end);
        end);
    end);
    u1.dropdownSet:Connect(function(p4) -- Line: 78
        -- upvalues: u1 (copy), iconModule (copy)
        for _, v in pairs(u1.dropdownIcons) do
            iconModule.getIconByUID(v):destroy();
        end;

        local _ = #p4;

        if type(p4) == "table" then
            for _, v in pairs(p4) do
                v:joinDropdown(u1);
            end;
        end;
    end);
    local Utility = require(script.Parent.Parent.Utility);
    dropdownJanitor:add(u1.toggled:Connect(function() -- Line: 95, Name: updateVisibility
        -- upvalues: Utility (copy), Frame (copy), u1 (copy)
        Utility.setVisible(Frame, u1.isSelected, "InternalDropdown");
    end));
    Utility.setVisible(Frame, u1.isSelected, "InternalDropdown");
    local u5 = 0;
    local u6 = false;

    local function updateMaxIcons() -- Line: 107
        -- upvalues: u5 (ref), u6 (ref), updateMaxIcons (copy), Frame (copy), ScrollingFrame (copy), iconModule (copy), u1 (copy), UIPadding (copy)
        u5 = u5 + 1;

        if u6 then
            return;
        end;

        local u7 = u5;
        u6 = true;
        task.defer(function() -- Line: 116
            -- upvalues: u6 (ref), u5 (ref), u7 (copy), updateMaxIcons (ref)
            u6 = false;

            if u5 ~= u7 then
                updateMaxIcons();
            end;
        end);
        local v8 = Frame:GetAttribute("MaxIcons");

        if not v8 then
            return;
        end;

        local v9 = {};

        for _, child in pairs(ScrollingFrame:GetChildren()) do
            if child:IsA("GuiObject") then
                table.insert(v9, { child, child.AbsolutePosition.Y });
            end;
        end;

        table.sort(v9, function(p10, p11) -- Line: 133
            return p10[2] < p11[2];
        end);
        local v12 = 0;
        local v13 = false;

        for i = 1, v8 do
            local v14 = v9[i];

            if not v14 then
                break;
            end;

            local v15 = v14[1];
            v12 = v12 + v15.AbsoluteSize.Y;
            local v16 = v15:GetAttribute("WidgetUID");

            if v16 then
                v16 = iconModule.getIconByUID(v16);
            end;

            if v16 then
                local v17;

                if v13 then
                    v17 = nil;
                else
                    v17 = u1:getInstance("ClickRegion");
                    v13 = true;
                end;

                v16:getInstance("ClickRegion").NextSelectionUp = v17;
            end;
        end;

        ScrollingFrame.Size = UDim2.fromOffset(0, v12 + UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset);
    end;

    dropdownJanitor:add(ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(updateMaxIcons));
    dropdownJanitor:add(ScrollingFrame.ChildAdded:Connect(updateMaxIcons));
    dropdownJanitor:add(ScrollingFrame.ChildRemoved:Connect(updateMaxIcons));
    dropdownJanitor:add(Frame:GetAttributeChangedSignal("MaxIcons"):Connect(updateMaxIcons));
    dropdownJanitor:add(u1.childThemeModified:Connect(updateMaxIcons));
    updateMaxIcons();

    return Frame;
end;