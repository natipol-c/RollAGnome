--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Widget
  Path:     game.ReplicatedStorage.SatchelLoader.Satchel.Packages._Index.1foreverhd_topbarplus@3.3.1.topbarplus.Elements.Widget
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:36 2026
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
        -- upvalues: Frame2 (copy), u1 (copy)
        Frame2.ClipsDescendants = true;
        task.delay(0.2, function() -- Line: 27
            -- upvalues: u1 (ref), Frame2 (ref)
            if u1.isSelected then
                Frame2.ClipsDescendants = false;
            end;
        end);
    end);
    local GuiService = game:GetService("GuiService");
    u1:setBehaviour("IconButton", "BackgroundTransparency", function(p3) -- Line: 36
        -- upvalues: GuiService (copy)
        if p3 == 1 then
            return p3;
        end;

        return p3 * GuiService.PreferredTransparency;
    end);
    u1.janitor:add(GuiService:GetPropertyChangedSignal("PreferredTransparency"):Connect(function() -- Line: 44
        -- upvalues: u1 (copy), Frame2 (copy)
        u1:refreshAppearance(Frame2, "BackgroundTransparency");
    end));
    local UICorner = Instance.new("UICorner");
    UICorner:SetAttribute("Collective", "IconCorners");
    UICorner.Name = "UICorner";
    UICorner.Parent = Frame2;
    local u4 = require(script.Parent.Menu)(u1);
    local MenuUIListLayout = u4.MenuUIListLayout;
    local MenuGap = u4.MenuGap;
    u4.Parent = Frame2;
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "IconSpot";
    Frame3.BackgroundColor3 = Color3.fromRGB(225, 225, 225);
    Frame3.BackgroundTransparency = 0.9;
    Frame3.Visible = true;
    Frame3.AnchorPoint = Vector2.new(0, 0.5);
    Frame3.ZIndex = 5;
    Frame3.Parent = u4;
    UICorner:Clone().Parent = Frame3;
    local v5 = Frame3:Clone();
    v5.UICorner.Name = "OverlayUICorner";
    v5.Name = "IconOverlay";
    v5.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    v5.ZIndex = Frame3.ZIndex + 1;
    v5.Size = UDim2.new(1, 0, 1, 0);
    v5.Position = UDim2.new(0, 0, 0, 0);
    v5.AnchorPoint = Vector2.new(0, 0);
    v5.Visible = false;
    v5.Parent = Frame3;
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
    local u6 = workspace.CurrentCamera.ViewportSize.X + 200;
    TextLabel.Name = "IconLabel";
    TextLabel.LayoutOrder = 4;
    TextLabel.ZIndex = 15;
    TextLabel.AnchorPoint = Vector2.new(0, 0);
    TextLabel.Size = UDim2.new(0, u6, 1, 0);
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
    local v7 = UICorner:Clone();
    v7:SetAttribute("Collective", nil);
    v7.CornerRadius = UDim.new(0, 0);
    v7.Name = "IconImageCorner";
    v7.Parent = ImageLabel;
    local TweenService = game:GetService("TweenService");
    local u8 = 0;

    local function handleLabelAndImageChangesUnstaggered(p9) -- Line: 195
        -- upvalues: u1 (copy), TextLabel (copy), ImageLabel (copy), Frame8 (copy), Frame5 (copy), Frame6 (copy), Frame7 (copy), Frame2 (copy), UIListLayout (copy), Frame4 (copy), Frame (copy), u6 (copy), u4 (copy), Frame3 (copy), MenuUIListLayout (copy), MenuGap (copy), TweenService (copy), TextButton (copy), u8 (ref), u2 (copy)
        task.defer(function() -- Line: 202
            -- upvalues: u1 (ref), TextLabel (ref), ImageLabel (ref), Frame8 (ref), Frame5 (ref), Frame6 (ref), Frame7 (ref), Frame2 (ref), UIListLayout (ref), Frame4 (ref), Frame (ref), u6 (ref), u4 (ref), Frame3 (ref), MenuUIListLayout (ref), MenuGap (ref), TweenService (ref), TextButton (ref), u8 (ref), u2 (ref)
            local indicator = u1.indicator;

            if indicator then
                indicator = indicator.Visible;
            end;

            local v10 = indicator or TextLabel.Text ~= "";
            local v11;

            if ImageLabel.Image == "" then
                v11 = false;
            else
                v11 = ImageLabel.Image ~= nil;
            end;

            local _ = Enum.HorizontalAlignment.Center;
            local v12 = UDim2.fromScale(1, 1);

            if v11 and not v10 then
                Frame8.Visible = false;
                ImageLabel.Visible = true;
                Frame5.Visible = false;
                Frame6.Visible = false;
                Frame7.Visible = false;
            elseif v11 or not v10 then
                if v11 and v10 then
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

            Frame2.Size = v12;

            local function getItemWidth(p13) -- Line: 232
                return p13:GetAttribute("TargetWidth") or p13.AbsoluteSize.X;
            end;

            local Offset = UIListLayout.Padding.Offset;
            Frame8.Size = UDim2.new(0, TextLabel.TextBounds.X, TextLabel.Size.Y.Scale, 0);
            local v14 = Offset;

            for _, child in pairs(Frame4:GetChildren()) do
                if child:IsA("GuiObject") and child.Visible == true then
                    v14 = v14 + ((child:GetAttribute("TargetWidth") or child.AbsoluteSize.X) + Offset);
                end;
            end;

            local v15 = Frame:GetAttribute("MinimumWidth");
            local v16 = Frame:GetAttribute("MinimumHeight");
            local v17 = Frame:GetAttribute("BorderSize");
            local v18 = math.clamp(v14, v15, u6);
            local v19 = 0;
            local v20 = #u1.menuIcons > 0 and u1.isSelected;

            if v20 then
                for _, child in pairs(u4:GetChildren()) do
                    if child ~= Frame3 and (child:IsA("GuiObject") and child.Visible) then
                        v19 = v19 + ((child:GetAttribute("TargetWidth") or child.AbsoluteSize.X) + MenuUIListLayout.Padding.Offset);
                    end;
                end;

                if not Frame3.Visible then
                    local v21 = Frame3;
                    v18 = v18 - ((v21:GetAttribute("TargetWidth") or v21.AbsoluteSize.X) + MenuUIListLayout.Padding.Offset * 2 + v17);
                end;

                v19 = v19 - v17 * 0.5;
                v18 = v18 + (v19 - v17 * 0.75);
            end;

            if v20 then
                v20 = Frame3.Visible;
            end;

            MenuGap.Visible = v20;
            local v22 = Frame:GetAttribute("DesiredWidth");

            if v22 then
                if v18 >= v22 then
                    v22 = v18;
                end;
            else
                v22 = v18;
            end;

            u1.updateMenu:Fire();
            local v23 = math.max(v22 - v19, v15) - v17 * 2;
            local v24 = u4:GetAttribute("MenuWidth");

            if v24 then
                v24 = v24 + v23 + MenuUIListLayout.Padding.Offset + 10;
            end;

            if v24 then
                local v25 = u4:GetAttribute("MaxWidth");

                if v25 then
                    v24 = math.max(v25, v15);
                end;

                u4:SetAttribute("MenuCanvasWidth", v22);

                if v24 >= v22 then
                    v24 = v22;
                end;
            else
                v24 = v22;
            end;

            local Quint = Enum.EasingStyle.Quint;
            local Out = Enum.EasingDirection.Out;
            local v26 = Frame3;
            local v27 = v26:GetAttribute("TargetWidth") or v26.AbsoluteSize.X;
            local v28 = math.max(v23, v27, Frame3.AbsoluteSize.X);
            local v29 = Frame;
            local v30 = v29:GetAttribute("TargetWidth") or v29.AbsoluteSize.X;
            local v31 = math.max(v24, v30, Frame.AbsoluteSize.X);
            local v32 = TweenInfo.new(v28 / 750, Quint, Out);
            local v33 = TweenInfo.new(v31 / 750, Quint, Out);
            TweenService:Create(Frame3, v32, {
                Position = UDim2.new(0, v17, 0.5, 0),
                Size = UDim2.new(0, v23, 1, -v17 * 2)
            }):Play();
            TweenService:Create(TextButton, v32, {
                Size = UDim2.new(0, v23, 1, 0)
            }):Play();
            local v34 = UDim2.fromOffset(v24, v16);

            if Frame.Size.Y.Offset ~= v16 then
                Frame.Size = v34;
            end;

            Frame:SetAttribute("TargetWidth", v34.X.Offset);
            TweenService:Create(Frame, v33, {
                Size = v34
            }):Play();
            u8 = u8 + 1;

            for i = 1, v33.Time * 100 do
                task.delay(i / 100, function() -- Line: 314
                    -- upvalues: u2 (ref), u1 (ref)
                    u2.iconChanged:Fire(u1);
                end);
            end;

            task.delay(v33.Time - 0.2, function() -- Line: 318
                -- upvalues: u8 (ref), u1 (ref)
                u8 = u8 - 1;
                task.defer(function() -- Line: 320
                    -- upvalues: u8 (ref), u1 (ref)
                    if u8 == 0 then
                        u1.resizingComplete:Fire();
                    end;
                end);
            end);
            u1:updateParent();
        end);
    end;

    local u35 = require(script.Parent.Parent.Utility).createStagger(0.01, handleLabelAndImageChangesUnstaggered);
    local u36 = true;
    u1:setBehaviour("IconLabel", "Text", u35);
    u1:setBehaviour("IconLabel", "FontFace", function(p37) -- Line: 333
        -- upvalues: TextLabel (copy), u35 (copy), u36 (ref)
        if TextLabel.FontFace == p37 then
            return;
        end;

        task.spawn(function() -- Line: 338
            -- upvalues: u35 (ref), u36 (ref)
            u35();

            if u36 then
                u36 = false;

                for _ = 1, 10 do
                    task.wait(1);
                    u35();
                end;
            end;
        end);
    end);

    local function updateBorderSize() -- Line: 360
        -- upvalues: Frame (copy), u1 (copy), Frame3 (copy), u4 (copy), MenuGap (copy), MenuUIListLayout (copy), u35 (copy)
        task.defer(function() -- Line: 361
            -- upvalues: Frame (ref), u1 (ref), Frame3 (ref), u4 (ref), MenuGap (ref), MenuUIListLayout (ref), u35 (ref)
            local v38 = Frame:GetAttribute("BorderSize");
            local alignment = u1.alignment;
            local v39;

            if Frame3.Visible == false then
                v39 = 0;
            elseif alignment == "Right" then
                v39 = -v38 or v38;
            else
                v39 = v38;
            end;

            u4.Position = UDim2.new(0, v39, 0, 0);
            MenuGap.Size = UDim2.fromOffset(v38, 0);
            MenuUIListLayout.Padding = UDim.new(0, 0);
            u35();
        end);
    end;

    u1:setBehaviour("Widget", "BorderSize", updateBorderSize);
    u1:setBehaviour("IconSpot", "Visible", updateBorderSize);
    u1.startMenuUpdate:Connect(u35);
    u1.updateSize:Connect(u35);
    u1:setBehaviour("ContentsList", "HorizontalAlignment", u35);
    u1:setBehaviour("Widget", "Visible", u35);
    u1:setBehaviour("Widget", "DesiredWidth", u35);
    u1:setBehaviour("Widget", "MinimumWidth", u35);
    u1:setBehaviour("Widget", "MinimumHeight", u35);
    u1:setBehaviour("Indicator", "Visible", u35);
    u1:setBehaviour("IconImageRatio", "AspectRatio", u35);
    u1:setBehaviour("IconImage", "Image", function(p40) -- Line: 382
        -- upvalues: ImageLabel (copy), u35 (copy)
        local v41 = tonumber(p40) and "http://www.roblox.com/asset/?id=" .. p40 or (p40 or "");

        if ImageLabel.Image ~= v41 then
            u35();
        end;

        return v41;
    end);
    u1.alignmentChanged:Connect(function(p42) -- Line: 389
        -- upvalues: MenuUIListLayout (copy), Frame (copy), u1 (copy), Frame3 (copy), u4 (copy), MenuGap (copy), u35 (copy)
        MenuUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment[p42 == "Center" and "Left" or p42];
        task.defer(function() -- Line: 361
            -- upvalues: Frame (ref), u1 (ref), Frame3 (ref), u4 (ref), MenuGap (ref), MenuUIListLayout (ref), u35 (ref)
            local v43 = Frame:GetAttribute("BorderSize");
            local alignment = u1.alignment;
            local v44;

            if Frame3.Visible == false then
                v44 = 0;
            elseif alignment == "Right" then
                v44 = -v43 or v43;
            else
                v44 = v43;
            end;

            u4.Position = UDim2.new(0, v44, 0, 0);
            MenuGap.Size = UDim2.fromOffset(v43, 0);
            MenuUIListLayout.Padding = UDim.new(0, 0);
            u35();
        end);
    end);
    local LocalPlayer = game:GetService("Players").LocalPlayer;
    local LocaleId = LocalPlayer.LocaleId;
    u1.janitor:add(LocalPlayer:GetPropertyChangedSignal("LocaleId"):Connect(function() -- Line: 401
        -- upvalues: LocalPlayer (copy), LocaleId (ref), u1 (copy)
        task.delay(0.2, function() -- Line: 402
            -- upvalues: LocalPlayer (ref), LocaleId (ref), u1 (ref)
            local LocaleId2 = LocalPlayer.LocaleId;

            if LocaleId2 ~= LocaleId then
                LocaleId = LocaleId2;
                u1:refresh();
                task.wait(0.5);
                u1:refresh();
            end;
        end);
    end));
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Name = "IconImageScale";
    NumberValue.Parent = ImageLabel;
    NumberValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 416
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