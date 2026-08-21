--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Widget
  Path:     game.ReplicatedStorage.Library.Imported.TopbarPlus.Elements.Widget
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:35 2026
]]

-- Decompiled with Potassium's decompiler.

return function(u1, u2) -- Line: 6
    local Frame = Instance.new("Frame");
    Frame:SetAttribute("WidgetUID", u1.UID);
    Frame.Name = "Widget";
    Frame.BackgroundTransparency = 1;
    Frame.Visible = true;
    Frame.ZIndex = 20;
    Frame.Active = false;
    Frame.ClipsDescendants = true;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "IconButton";
    Frame2.Visible = true;
    Frame2.ZIndex = 2;
    Frame2.BorderSizePixel = 0;
    Frame2.Parent = Frame;
    Frame2.ClipsDescendants = true;
    Frame2.Active = false;
    u1.deselected:Connect(function() -- Line: 25
        -- upvalues: Frame2 (copy)
        Frame2.ClipsDescendants = true;
    end);
    u1.selected:Connect(function() -- Line: 28
        -- upvalues: u1 (copy), Frame2 (copy)
        task.defer(function() -- Line: 29
            -- upvalues: u1 (ref), Frame2 (ref)
            u1.resizingComplete:Once(function() -- Line: 30
                -- upvalues: u1 (ref), Frame2 (ref)
                if u1.isSelected then
                    Frame2.ClipsDescendants = false;
                end;
            end);
        end);
    end);
    local UICorner = Instance.new("UICorner");
    UICorner:SetAttribute("Collective", "IconCorners");
    UICorner.Parent = Frame2;
    local u3 = require(script.Parent.Menu)(u1);
    local MenuUIListLayout = u3.MenuUIListLayout;
    local MenuGap = u3.MenuGap;
    u3.Parent = Frame2;
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "IconSpot";
    Frame3.BackgroundColor3 = Color3.fromRGB(225, 225, 225);
    Frame3.BackgroundTransparency = 0.9;
    Frame3.Visible = true;
    Frame3.AnchorPoint = Vector2.new(0, 0.5);
    Frame3.ZIndex = 5;
    Frame3.Parent = u3;
    UICorner:Clone().Parent = Frame3;
    local v4 = Frame3:Clone();
    v4.Name = "IconOverlay";
    v4.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    v4.ZIndex = Frame3.ZIndex + 1;
    v4.Size = UDim2.new(1, 0, 1, 0);
    v4.Position = UDim2.new(0, 0, 0, 0);
    v4.AnchorPoint = Vector2.new(0, 0);
    v4.Visible = false;
    v4.Parent = Frame3;
    local TextButton = Instance.new("TextButton");
    TextButton:SetAttribute("CorrespondingIconUID", u1.UID);
    TextButton.Name = "ClickRegion";
    TextButton.BackgroundTransparency = 1;
    TextButton.Visible = true;
    TextButton.Text = "";
    TextButton.ZIndex = 20;
    TextButton.Selectable = true;
    TextButton.SelectionGroup = true;
    TextButton.Parent = Frame3;
    require(script.Parent.Parent.Features.Gamepad).registerButton(TextButton);
    UICorner:Clone().Parent = TextButton;
    local Frame4 = Instance.new("Frame");
    Frame4.Name = "Contents";
    Frame4.BackgroundTransparency = 1;
    Frame4.Size = UDim2.fromScale(1, 1);
    Frame4.Parent = Frame3;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.Name = "ContentsList";
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly;
    UIListLayout.Padding = UDim.new(0, 3);
    UIListLayout.Parent = Frame4;
    local Frame5 = Instance.new("Frame");
    Frame5.Name = "PaddingLeft";
    Frame5.LayoutOrder = 1;
    Frame5.ZIndex = 5;
    Frame5.BorderColor3 = Color3.fromRGB(0, 0, 0);
    Frame5.BackgroundTransparency = 1;
    Frame5.BorderSizePixel = 0;
    Frame5.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    Frame5.Parent = Frame4;
    local Frame6 = Instance.new("Frame");
    Frame6.Name = "PaddingCenter";
    Frame6.LayoutOrder = 3;
    Frame6.ZIndex = 5;
    Frame6.Size = UDim2.new(0, 0, 1, 0);
    Frame6.BorderColor3 = Color3.fromRGB(0, 0, 0);
    Frame6.BackgroundTransparency = 1;
    Frame6.BorderSizePixel = 0;
    Frame6.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    Frame6.Parent = Frame4;
    local Frame7 = Instance.new("Frame");
    Frame7.Name = "PaddingRight";
    Frame7.LayoutOrder = 5;
    Frame7.ZIndex = 5;
    Frame7.BorderColor3 = Color3.fromRGB(0, 0, 0);
    Frame7.BackgroundTransparency = 1;
    Frame7.BorderSizePixel = 0;
    Frame7.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    Frame7.Parent = Frame4;
    local Frame8 = Instance.new("Frame");
    Frame8.Name = "IconLabelContainer";
    Frame8.LayoutOrder = 4;
    Frame8.ZIndex = 3;
    Frame8.AnchorPoint = Vector2.new(0, 0.5);
    Frame8.Size = UDim2.new(0, 0, 0.5, 0);
    Frame8.BackgroundTransparency = 1;
    Frame8.Position = UDim2.new(0.5, 0, 0.5, 0);
    Frame8.Parent = Frame4;
    local TextLabel = Instance.new("TextLabel");
    local u5 = workspace.CurrentCamera.ViewportSize.X + 200;
    TextLabel.Name = "IconLabel";
    TextLabel.LayoutOrder = 4;
    TextLabel.ZIndex = 15;
    TextLabel.AnchorPoint = Vector2.new(0, 0);
    TextLabel.Size = UDim2.new(0, u5, 1, 0);
    TextLabel.ClipsDescendants = false;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Position = UDim2.fromScale(0, 0);
    TextLabel.RichText = true;
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Text = "";
    TextLabel.TextWrapped = true;
    TextLabel.TextWrap = true;
    TextLabel.TextScaled = false;
    TextLabel.Active = false;
    TextLabel.AutoLocalize = true;
    TextLabel.Parent = Frame8;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "IconImage";
    ImageLabel.LayoutOrder = 2;
    ImageLabel.ZIndex = 15;
    ImageLabel.AnchorPoint = Vector2.new(0, 0.5);
    ImageLabel.Size = UDim2.new(0, 0, 0.5, 0);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Position = UDim2.new(0, 11, 0.5, 0);
    ImageLabel.ScaleType = Enum.ScaleType.Stretch;
    ImageLabel.Active = false;
    ImageLabel.Parent = Frame4;
    local v6 = UICorner:Clone();
    v6:SetAttribute("Collective", nil);
    v6.CornerRadius = UDim.new(0, 0);
    v6.Name = "IconImageCorner";
    v6.Parent = ImageLabel;
    local TweenService = game:GetService("TweenService");
    local u7 = 0;

    local function handleLabelAndImageChangesUnstaggered(p8) -- Line: 184
        -- upvalues: u1 (copy), TextLabel (copy), ImageLabel (copy), Frame8 (copy), Frame5 (copy), Frame6 (copy), Frame7 (copy), Frame2 (copy), UIListLayout (copy), Frame4 (copy), Frame (copy), u5 (copy), u3 (copy), Frame3 (copy), MenuUIListLayout (copy), MenuGap (copy), TweenService (copy), TextButton (copy), u7 (ref), u2 (copy)
        task.defer(function() -- Line: 191
            -- upvalues: u1 (ref), TextLabel (ref), ImageLabel (ref), Frame8 (ref), Frame5 (ref), Frame6 (ref), Frame7 (ref), Frame2 (ref), UIListLayout (ref), Frame4 (ref), Frame (ref), u5 (ref), u3 (ref), Frame3 (ref), MenuUIListLayout (ref), MenuGap (ref), TweenService (ref), TextButton (ref), u7 (ref), u2 (ref)
            local indicator = u1.indicator;

            if indicator then
                indicator = indicator.Visible;
            end;

            local v9 = indicator or TextLabel.Text ~= "";
            local v10;

            if ImageLabel.Image == "" then
                v10 = false;
            else
                v10 = ImageLabel.Image ~= nil;
            end;

            local _ = Enum.HorizontalAlignment.Center;
            local v11 = UDim2.fromScale(1, 1);

            if v10 and not v9 then
                Frame8.Visible = false;
                ImageLabel.Visible = true;
                Frame5.Visible = false;
                Frame6.Visible = false;
                Frame7.Visible = false;
            elseif v10 or not v9 then
                if v10 and v9 then
                    Frame8.Visible = true;
                    ImageLabel.Visible = true;
                    Frame5.Visible = true;
                    Frame6.Visible = not indicator;
                    Frame7.Visible = not indicator;
                    local _ = Enum.HorizontalAlignment.Left;
                end;
            else
                Frame8.Visible = true;
                ImageLabel.Visible = false;
                Frame5.Visible = true;
                Frame6.Visible = false;
                Frame7.Visible = true;
            end;

            Frame2.Size = v11;

            local function getItemWidth(p12) -- Line: 221
                return p12:GetAttribute("TargetWidth") or p12.AbsoluteSize.X;
            end;

            local Offset = UIListLayout.Padding.Offset;
            Frame8.Size = UDim2.new(0, TextLabel.TextBounds.X, TextLabel.Size.Y.Scale, 0);
            local v13 = Offset;

            for _, child in pairs(Frame4:GetChildren()) do
                if child:IsA("GuiObject") and child.Visible == true then
                    v13 = v13 + ((child:GetAttribute("TargetWidth") or child.AbsoluteSize.X) + Offset);
                end;
            end;

            local v14 = Frame:GetAttribute("MinimumWidth");
            local v15 = Frame:GetAttribute("MinimumHeight");
            local v16 = Frame:GetAttribute("BorderSize");
            local v17 = math.clamp(v13, v14, u5);
            local v18 = 0;
            local v19 = #u1.menuIcons > 0 and u1.isSelected;

            if v19 then
                for _, child in pairs(u3:GetChildren()) do
                    if child ~= Frame3 and (child:IsA("GuiObject") and child.Visible) then
                        v18 = v18 + ((child:GetAttribute("TargetWidth") or child.AbsoluteSize.X) + MenuUIListLayout.Padding.Offset);
                    end;
                end;

                if not Frame3.Visible then
                    local v20 = Frame3;
                    v17 = v17 - ((v20:GetAttribute("TargetWidth") or v20.AbsoluteSize.X) + MenuUIListLayout.Padding.Offset * 2 + v16);
                end;

                v18 = v18 - v16 * 0.5;
                v17 = v17 + (v18 - v16 * 0.75);
            end;

            if v19 then
                v19 = Frame3.Visible;
            end;

            MenuGap.Visible = v19;
            local v21 = Frame:GetAttribute("DesiredWidth");

            if v21 then
                if v17 >= v21 then
                    v21 = v17;
                end;
            else
                v21 = v17;
            end;

            u1.updateMenu:Fire();
            local v22 = math.max(v21 - v18, v14) - v16 * 2;
            local v23 = u3:GetAttribute("MenuWidth");

            if v23 then
                v23 = v23 + v22 + MenuUIListLayout.Padding.Offset + 10;
            end;

            if v23 then
                local v24 = u3:GetAttribute("MaxWidth");

                if v24 then
                    v23 = math.max(v24, v14);
                end;

                u3:SetAttribute("MenuCanvasWidth", v21);

                if v23 >= v21 then
                    v23 = v21;
                end;
            else
                v23 = v21;
            end;

            local Quint = Enum.EasingStyle.Quint;
            local Out = Enum.EasingDirection.Out;
            local v25 = Frame3;
            local v26 = v25:GetAttribute("TargetWidth") or v25.AbsoluteSize.X;
            local v27 = math.max(v22, v26, Frame3.AbsoluteSize.X);
            local v28 = Frame;
            local v29 = v28:GetAttribute("TargetWidth") or v28.AbsoluteSize.X;
            local v30 = math.max(v23, v29, Frame.AbsoluteSize.X);
            local v31 = TweenInfo.new(v27 / 750, Quint, Out);
            local v32 = TweenInfo.new(v30 / 750, Quint, Out);
            TweenService:Create(Frame3, v31, {
                Position = UDim2.new(0, v16, 0.5, 0),
                Size = UDim2.new(0, v22, 1, -v16 * 2)
            }):Play();
            TweenService:Create(TextButton, v31, {
                Size = UDim2.new(0, v22, 1, 0)
            }):Play();
            local v33 = UDim2.fromOffset(v23, v15);

            if Frame.Size.Y.Offset ~= v15 then
                Frame.Size = v33;
            end;

            Frame:SetAttribute("TargetWidth", v33.X.Offset);
            TweenService:Create(Frame, v32, {
                Size = v33
            }):Play();
            u7 = u7 + 1;

            for i = 1, v32.Time * 100 do
                task.delay(i / 100, function() -- Line: 303
                    -- upvalues: u2 (ref), u1 (ref)
                    u2.iconChanged:Fire(u1);
                end);
            end;

            task.delay(v32.Time - 0.2, function() -- Line: 307
                -- upvalues: u7 (ref), u1 (ref)
                u7 = u7 - 1;
                task.defer(function() -- Line: 309
                    -- upvalues: u7 (ref), u1 (ref)
                    if u7 == 0 then
                        u1.resizingComplete:Fire();
                    end;
                end);
            end);
            u1:updateParent();
        end);
    end;

    local u34 = require(script.Parent.Parent.Utility).createStagger(0.01, handleLabelAndImageChangesUnstaggered);
    local u35 = true;
    u1:setBehaviour("IconLabel", "Text", u34);
    u1:setBehaviour("IconLabel", "FontFace", function(p36) -- Line: 322
        -- upvalues: TextLabel (copy), u34 (copy), u35 (ref)
        if TextLabel.FontFace == p36 then
            return;
        end;

        task.spawn(function() -- Line: 327
            -- upvalues: u34 (ref), u35 (ref)
            u34();

            if u35 then
                u35 = false;

                for _ = 1, 10 do
                    task.wait(1);
                    u34();
                end;
            end;
        end);
    end);

    local function updateBorderSize() -- Line: 350
        -- upvalues: Frame (copy), u1 (copy), Frame3 (copy), u3 (copy), MenuGap (copy), MenuUIListLayout (copy), u34 (copy)
        task.defer(function() -- Line: 351
            -- upvalues: Frame (ref), u1 (ref), Frame3 (ref), u3 (ref), MenuGap (ref), MenuUIListLayout (ref), u34 (ref)
            local v37 = Frame:GetAttribute("BorderSize");
            local alignment = u1.alignment;
            local v38;

            if Frame3.Visible == false then
                v38 = 0;
            elseif alignment == "Right" then
                v38 = -v37 or v37;
            else
                v38 = v37;
            end;

            u3.Position = UDim2.new(0, v38, 0, 0);
            MenuGap.Size = UDim2.fromOffset(v37, 0);
            MenuUIListLayout.Padding = UDim.new(0, 0);
            u34();
        end);
    end;

    u1:setBehaviour("Widget", "BorderSize", updateBorderSize);
    u1:setBehaviour("IconSpot", "Visible", updateBorderSize);
    u1.startMenuUpdate:Connect(u34);
    u1.updateSize:Connect(u34);
    u1:setBehaviour("ContentsList", "HorizontalAlignment", u34);
    u1:setBehaviour("Widget", "Visible", u34);
    u1:setBehaviour("Widget", "DesiredWidth", u34);
    u1:setBehaviour("Widget", "MinimumWidth", u34);
    u1:setBehaviour("Widget", "MinimumHeight", u34);
    u1:setBehaviour("Indicator", "Visible", u34);
    u1:setBehaviour("IconImageRatio", "AspectRatio", u34);
    u1:setBehaviour("IconImage", "Image", function(p39) -- Line: 372
        -- upvalues: ImageLabel (copy), u34 (copy)
        local v40 = tonumber(p39) and "http://www.roblox.com/asset/?id=" .. p39 or (p39 or "");

        if ImageLabel.Image ~= v40 then
            u34();
        end;

        return v40;
    end);
    u1.alignmentChanged:Connect(function(p41) -- Line: 379
        -- upvalues: MenuUIListLayout (copy), Frame (copy), u1 (copy), Frame3 (copy), u3 (copy), MenuGap (copy), u34 (copy)
        MenuUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment[p41 == "Center" and "Left" or p41];
        task.defer(function() -- Line: 351
            -- upvalues: Frame (ref), u1 (ref), Frame3 (ref), u3 (ref), MenuGap (ref), MenuUIListLayout (ref), u34 (ref)
            local v42 = Frame:GetAttribute("BorderSize");
            local alignment = u1.alignment;
            local v43;

            if Frame3.Visible == false then
                v43 = 0;
            elseif alignment == "Right" then
                v43 = -v42 or v42;
            else
                v43 = v42;
            end;

            u3.Position = UDim2.new(0, v43, 0, 0);
            MenuGap.Size = UDim2.fromOffset(v42, 0);
            MenuUIListLayout.Padding = UDim.new(0, 0);
            u34();
        end);
    end);
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Name = "IconImageScale";
    NumberValue.Parent = ImageLabel;
    NumberValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 390
        -- upvalues: ImageLabel (copy), NumberValue (copy)
        ImageLabel.Size = UDim2.new(NumberValue.Value, 0, NumberValue.Value, 0);
    end);
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint.Name = "IconImageRatio";
    UIAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize;
    UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height;
    UIAspectRatioConstraint.Parent = ImageLabel;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "IconGradient";
    UIGradient.Enabled = true;
    UIGradient.Parent = Frame2;
    local UIGradient2 = Instance.new("UIGradient");
    UIGradient2.Name = "IconSpotGradient";
    UIGradient2.Enabled = true;
    UIGradient2.Parent = Frame3;

    return Frame;
end;