--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Caption
  Path:     game.ReplicatedStorage.Library.Imported.TopbarPlus.Elements.Caption
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:03 2026
]]

-- Decompiled with Potassium's decompiler.

return function(u1) -- Line: 1
    local u2 = u1:getInstance("ClickRegion");
    local CanvasGroup = Instance.new("CanvasGroup");
    CanvasGroup.Name = "Caption";
    CanvasGroup.AnchorPoint = Vector2.new(0.5, 0);
    CanvasGroup.BackgroundTransparency = 1;
    CanvasGroup.BorderSizePixel = 0;
    CanvasGroup.GroupTransparency = 1;
    CanvasGroup.Position = UDim2.fromOffset(0, 0);
    CanvasGroup.Visible = true;
    CanvasGroup.ZIndex = 30;
    CanvasGroup.Parent = u2;
    local Frame = Instance.new("Frame");
    Frame.Name = "Box";
    Frame.AutomaticSize = Enum.AutomaticSize.XY;
    Frame.BackgroundColor3 = Color3.fromRGB(101, 102, 104);
    Frame.Position = UDim2.fromOffset(4, 7);
    Frame.ZIndex = 12;
    Frame.Parent = CanvasGroup;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Header";
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal);
    TextLabel.Text = "Caption";
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
    TextLabel.TextSize = 14;
    TextLabel.TextTruncate = Enum.TextTruncate.None;
    TextLabel.TextWrapped = false;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.AutomaticSize = Enum.AutomaticSize.X;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.LayoutOrder = 1;
    TextLabel.Size = UDim2.fromOffset(0, 16);
    TextLabel.ZIndex = 18;
    TextLabel.Parent = Frame;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.Name = "Layout";
    UIListLayout.Padding = UDim.new(0, 8);
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Parent = Frame;
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "CaptionCorner";
    UICorner.Parent = Frame;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.Name = "Padding";
    UIPadding.PaddingBottom = UDim.new(0, 12);
    UIPadding.PaddingLeft = UDim.new(0, 12);
    UIPadding.PaddingRight = UDim.new(0, 12);
    UIPadding.PaddingTop = UDim.new(0, 12);
    UIPadding.Parent = Frame;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Hotkeys";
    Frame2.AutomaticSize = Enum.AutomaticSize.Y;
    Frame2.BackgroundTransparency = 1;
    Frame2.LayoutOrder = 3;
    Frame2.Size = UDim2.fromScale(1, 0);
    Frame2.Visible = false;
    Frame2.Parent = Frame;
    local UIListLayout2 = Instance.new("UIListLayout");
    UIListLayout2.Name = "Layout1";
    UIListLayout2.Padding = UDim.new(0, 6);
    UIListLayout2.FillDirection = Enum.FillDirection.Vertical;
    UIListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    UIListLayout2.HorizontalFlex = Enum.UIFlexAlignment.None;
    UIListLayout2.ItemLineAlignment = Enum.ItemLineAlignment.Automatic;
    UIListLayout2.VerticalFlex = Enum.UIFlexAlignment.None;
    UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout2.Parent = Frame2;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Key1";
    ImageLabel.Image = "rbxasset://textures/ui/Controls/key_single.png";
    ImageLabel.ImageTransparency = 0.7;
    ImageLabel.ScaleType = Enum.ScaleType.Slice;
    ImageLabel.SliceCenter = Rect.new(5, 5, 23, 24);
    ImageLabel.AutomaticSize = Enum.AutomaticSize.X;
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.LayoutOrder = 1;
    ImageLabel.Size = UDim2.fromOffset(0, 30);
    ImageLabel.ZIndex = 15;
    ImageLabel.Parent = Frame2;
    local UIPadding2 = Instance.new("UIPadding");
    UIPadding2.Name = "Inset";
    UIPadding2.PaddingLeft = UDim.new(0, 8);
    UIPadding2.PaddingRight = UDim.new(0, 8);
    UIPadding2.Parent = ImageLabel;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.AutoLocalize = false;
    TextLabel2.Name = "LabelContent";
    TextLabel2.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal);
    TextLabel2.Text = "";
    TextLabel2.TextColor3 = Color3.fromRGB(189, 190, 190);
    TextLabel2.TextSize = 14;
    TextLabel2.AutomaticSize = Enum.AutomaticSize.X;
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Position = UDim2.fromOffset(0, -1);
    TextLabel2.Size = UDim2.fromScale(1, 1);
    TextLabel2.ZIndex = 16;
    TextLabel2.Parent = ImageLabel;
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.Name = "Caret";
    ImageLabel2.Image = "rbxasset://LuaPackages/Packages/_Index/UIBlox/UIBlox/AppImageAtlas/img_set_1x_1.png";
    ImageLabel2.ImageColor3 = Color3.fromRGB(101, 102, 104);
    ImageLabel2.ImageRectOffset = Vector2.new(260, 440);
    ImageLabel2.ImageRectSize = Vector2.new(16, 8);
    ImageLabel2.AnchorPoint = Vector2.new(0, 0.5);
    ImageLabel2.BackgroundTransparency = 1;
    ImageLabel2.Position = UDim2.new(0, 0, 0, 4);
    ImageLabel2.Rotation = 180;
    ImageLabel2.Size = UDim2.fromOffset(16, 8);
    ImageLabel2.ZIndex = 12;
    ImageLabel2.Parent = CanvasGroup;
    local ImageLabel3 = Instance.new("ImageLabel");
    ImageLabel3.Name = "DropShadow";
    ImageLabel3.Image = "rbxasset://LuaPackages/Packages/_Index/UIBlox/UIBlox/AppImageAtlas/img_set_1x_1.png";
    ImageLabel3.ImageColor3 = Color3.fromRGB(0, 0, 0);
    ImageLabel3.ImageRectOffset = Vector2.new(217, 486);
    ImageLabel3.ImageRectSize = Vector2.new(25, 25);
    ImageLabel3.ImageTransparency = 0.45;
    ImageLabel3.ScaleType = Enum.ScaleType.Slice;
    ImageLabel3.SliceCenter = Rect.new(12, 12, 13, 13);
    ImageLabel3.BackgroundTransparency = 1;
    ImageLabel3.Position = UDim2.fromOffset(0, 5);
    ImageLabel3.Size = UDim2.new(1, 0, 0, 48);
    ImageLabel3.Parent = CanvasGroup;
    Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 147
        -- upvalues: ImageLabel3 (copy), Frame (copy)
        ImageLabel3.Size = UDim2.new(1, 0, 0, Frame.AbsoluteSize.Y + 8);
    end);
    local captionJanitor = u1.captionJanitor;
    local _, u3 = u1:clipOutside(CanvasGroup);
    u3.AutomaticSize = Enum.AutomaticSize.None;
    captionJanitor:add(CanvasGroup:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 157, Name: matchSize
        -- upvalues: CanvasGroup (copy), u3 (copy)
        local AbsoluteSize = CanvasGroup.AbsoluteSize;
        u3.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y);
    end));
    local AbsoluteSize = CanvasGroup.AbsoluteSize;
    u3.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y);
    local u4 = false;
    local Header = CanvasGroup.Box.Header;
    local UserInputService = game:GetService("UserInputService");

    local function updateHotkey(p5) -- Line: 170
        -- upvalues: UserInputService (copy), CanvasGroup (copy), u1 (copy), Header (copy), TextLabel2 (copy), Frame2 (copy)
        local KeyboardEnabled = UserInputService.KeyboardEnabled;
        local v6 = CanvasGroup:GetAttribute("CaptionText") or "";
        local v7 = v6 == "_hotkey_";

        if not KeyboardEnabled and v7 then
            u1:setCaption();

            return;
        end;

        Header.Text = v6;
        Header.Visible = not v7;

        if p5 then
            TextLabel2.Text = p5.Name;
            Frame2.Visible = true;
        end;

        if not KeyboardEnabled then
            Frame2.Visible = false;
        end;
    end;

    CanvasGroup:GetAttributeChangedSignal("CaptionText"):Connect(updateHotkey);
    local Quad = Enum.EasingStyle.Quad;
    local u8 = TweenInfo.new(0.2, Quad, Enum.EasingDirection.In);
    local u9 = TweenInfo.new(0.2, Quad, Enum.EasingDirection.Out);
    local TweenService = game:GetService("TweenService");
    local RunService = game:GetService("RunService");

    local function getCaptionPosition(p10) -- Line: 196
        -- upvalues: u4 (ref)
        if p10 == nil then
            p10 = u4;
        end;

        return UDim2.new(0.5, 0, 1, p10 and 10 or 2);
    end;

    local function updatePosition(p11) -- Line: 203
        -- upvalues: u4 (ref), ImageLabel2 (copy), CanvasGroup (copy), u2 (copy), u3 (copy), u8 (copy), u9 (copy), TweenService (copy), RunService (copy)
        if not u4 then
            return;
        end;

        if p11 == nil then
            p11 = u4;
        end;

        local v12 = not p11;

        if v12 == nil then
            v12 = u4;
        end;

        local v13 = UDim2.new(0.5, 0, 1, v12 and 10 or 2);
        local v14;

        if p11 == nil then
            v14 = u4;
        else
            v14 = p11;
        end;

        local v15 = UDim2.new(0.5, 0, 1, v14 and 10 or 2);

        if p11 then
            ImageLabel2.Position = UDim2.fromOffset(0, ImageLabel2.Position.Y.Offset);
            CanvasGroup.AutomaticSize = Enum.AutomaticSize.XY;
            CanvasGroup.Size = UDim2.fromOffset(32, 53);
        else
            local AbsoluteSize2 = CanvasGroup.AbsoluteSize;
            CanvasGroup.AutomaticSize = Enum.AutomaticSize.Y;
            CanvasGroup.Size = UDim2.fromOffset(AbsoluteSize2.X, AbsoluteSize2.Y);
        end;

        local u16 = nil;

        local function updateCaret() -- Line: 232
            -- upvalues: u2 (ref), CanvasGroup (ref), ImageLabel2 (ref), u16 (ref)
            local v17 = u2.AbsolutePosition.X - CanvasGroup.AbsolutePosition.X + u2.AbsoluteSize.X / 2 - ImageLabel2.AbsoluteSize.X / 2;
            local Offset = ImageLabel2.Position.Y.Offset;
            local v18 = UDim2.fromOffset(v17, Offset);

            if u16 ~= v17 then
                u16 = v17;
                ImageLabel2.Position = UDim2.fromOffset(0, Offset);
                task.wait();
            end;

            ImageLabel2.Position = v18;
        end;

        u3.Position = v13;
        updateCaret();
        local v19 = TweenService:Create(u3, p11 and u8 or u9, {
            Position = v15
        });
        local u20 = RunService.Heartbeat:Connect(updateCaret);
        v19:Play();
        v19.Completed:Once(function() -- Line: 255
            -- upvalues: u20 (copy)
            u20:Disconnect();
        end);
    end;

    captionJanitor:add(u2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 260
        -- upvalues: updatePosition (copy)
        updatePosition();
    end));
    updatePosition(false);
    captionJanitor:add(u1.toggleKeyAdded:Connect(updateHotkey));

    for i, _ in pairs(u1.bindedToggleKeys) do
        local KeyboardEnabled = UserInputService.KeyboardEnabled;
        local v21 = CanvasGroup:GetAttribute("CaptionText") or "";
        local v22 = v21 == "_hotkey_";

        if KeyboardEnabled or not v22 then
            Header.Text = v21;
            Header.Visible = not v22;

            if i then
                TextLabel2.Text = i.Name;
                Frame2.Visible = true;
            end;

            if not KeyboardEnabled then
                Frame2.Visible = false;
            end;
        else
            u1:setCaption();
        end;

        break;
    end;

    captionJanitor:add(u1.fakeToggleKeyChanged:Connect(updateHotkey));
    local fakeToggleKey = u1.fakeToggleKey;

    if fakeToggleKey then
        local KeyboardEnabled = UserInputService.KeyboardEnabled;
        local v23 = CanvasGroup:GetAttribute("CaptionText") or "";
        local v24 = v23 == "_hotkey_";

        if KeyboardEnabled or not v24 then
            Header.Text = v23;
            Header.Visible = not v24;

            if fakeToggleKey then
                TextLabel2.Text = fakeToggleKey.Name;
                Frame2.Visible = true;
            end;

            if not KeyboardEnabled then
                Frame2.Visible = false;
            end;
        else
            u1:setCaption();
        end;
    end;

    local function setCaptionEnabled(p25) -- Line: 276
        -- upvalues: u4 (ref), u1 (copy), u8 (copy), u9 (copy), TweenService (copy), CanvasGroup (copy), updatePosition (copy), UserInputService (copy), Header (copy), Frame2 (copy)
        if u4 == p25 then
            return;
        end;

        local joinedFrame = u1.joinedFrame;

        if joinedFrame and string.match(joinedFrame.Name, "Dropdown") then
            p25 = false;
        end;

        u4 = p25;
        TweenService:Create(CanvasGroup, p25 and u8 or u9, {
            GroupTransparency = p25 and 0 or 1
        }):Play();
        updatePosition();
        local KeyboardEnabled = UserInputService.KeyboardEnabled;
        local v26 = CanvasGroup:GetAttribute("CaptionText") or "";
        local v27 = v26 == "_hotkey_";

        if not KeyboardEnabled and v27 then
            u1:setCaption();

            return;
        end;

        Header.Text = v26;
        Header.Visible = not v27;

        if not KeyboardEnabled then
            Frame2.Visible = false;
        end;
    end;

    local iconModule = require(u1.iconModule);
    captionJanitor:add(u1.stateChanged:Connect(function(p28) -- Line: 298
        -- upvalues: iconModule (copy), u1 (copy), setCaptionEnabled (copy)
        if p28 ~= "Viewing" then
            iconModule.captionLastClosedClock = os.clock();
            setCaptionEnabled(false);

            return;
        end;

        local captionLastClosedClock = iconModule.captionLastClosedClock;
        local v29 = (captionLastClosedClock and os.clock() - captionLastClosedClock or 999) < 0.3 and 0 or 0.5;
        task.delay(v29, function() -- Line: 303
            -- upvalues: u1 (ref), setCaptionEnabled (ref)
            if u1.activeState == "Viewing" then
                setCaptionEnabled(true);
            end;
        end);
    end));

    return CanvasGroup;
end;