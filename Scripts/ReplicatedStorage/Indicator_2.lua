--[[
  Type:     ModuleScript
  Method:   cached
  Name:     Indicator
  Path:     game.ReplicatedStorage.SatchelLoader.Satchel.Packages._Index.1foreverhd_topbarplus@3.3.1.topbarplus.Elements.Indicator
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:05 2026
]]

-- Decompiled with Potassium's decompiler.

return function(u1, p2) -- Line: 1
    local widget = u1.widget;
    local v3 = u1:getInstance("Contents");
    local Frame = Instance.new("Frame");
    Frame.Name = "Indicator";
    Frame.LayoutOrder = 9999999;
    Frame.ZIndex = 6;
    Frame.Size = UDim2.new(0, 42, 0, 42);
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0);
    Frame.BackgroundTransparency = 1;
    Frame.Position = UDim2.new(1, 0, 0.5, 0);
    Frame.BorderSizePixel = 0;
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    Frame.Parent = v3;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "IndicatorButton";
    Frame2.BorderColor3 = Color3.fromRGB(0, 0, 0);
    Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame2.BorderSizePixel = 0;
    Frame2.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    Frame2.Parent = Frame;
    local GuiService = game:GetService("GuiService");
    local GamepadService = game:GetService("GamepadService");
    local u4 = u1:getInstance("ClickRegion");

    local function selectionChanged() -- Line: 28
        -- upvalues: GuiService (copy), u4 (copy), Frame2 (copy)
        if GuiService.SelectedObject == u4 then
            Frame2.BackgroundTransparency = 1;
            Frame2.Position = UDim2.new(0.5, -2, 0.5, 0);
            Frame2.Size = UDim2.fromScale(1.2, 1.2);

            return;
        end;

        Frame2.BackgroundTransparency = 0.75;
        Frame2.Position = UDim2.new(0.5, 2, 0.5, 0);
        Frame2.Size = UDim2.fromScale(1, 1);
    end;

    u1.janitor:add(GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(selectionChanged));
    selectionChanged();
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.LayoutOrder = 2;
    ImageLabel.ZIndex = 15;
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel.Size = UDim2.new(0.5, 0, 0.5, 0);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0);
    ImageLabel.Image = "rbxasset://textures/ui/Controls/XboxController/DPadUp@2x.png";
    ImageLabel.Parent = Frame2;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(1, 0);
    UICorner.Parent = Frame2;
    local UserInputService = game:GetService("UserInputService");

    local function setIndicatorVisible(p5) -- Line: 58
        -- upvalues: Frame (copy), GamepadService (copy), u1 (copy)
        if p5 == nil then
            p5 = Frame.Visible;
        end;

        if GamepadService.GamepadCursorEnabled then
            p5 = false;
        end;

        if p5 then
            u1:modifyTheme({ "PaddingRight", "Size", UDim2.new(0, 0, 1, 0) }, "IndicatorPadding");
        elseif Frame.Visible then
            u1:removeModification("IndicatorPadding");
        end;

        u1:modifyTheme({ "Indicator", "Visible", p5 });
        u1.updateSize:Fire();
    end;

    u1.janitor:add(GamepadService:GetPropertyChangedSignal("GamepadCursorEnabled"):Connect(setIndicatorVisible));
    u1.indicatorSet:Connect(function(p6) -- Line: 74
        -- upvalues: ImageLabel (copy), UserInputService (copy), setIndicatorVisible (copy)
        local v7;

        if p6 then
            ImageLabel.Image = UserInputService:GetImageForKeyCode(p6);
            v7 = true;
        else
            v7 = false;
        end;

        setIndicatorVisible(v7);
    end);
    widget:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 83, Name: updateSize
        -- upvalues: widget (copy), Frame (copy)
        local v8 = widget.AbsoluteSize.Y * 0.96;
        Frame.Size = UDim2.new(0, v8, 0, v8);
    end);
    local v9 = widget.AbsoluteSize.Y * 0.96;
    Frame.Size = UDim2.new(0, v9, 0, v9);

    return Frame;
end;