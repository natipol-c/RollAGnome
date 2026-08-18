--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Caption
  Path:     game.ReplicatedStorage.SatchelLoader.Satchel.Packages._Index.1foreverhd_topbarplus@3.3.1.topbarplus.Elements.Caption
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:06 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = Color3.fromRGB(39, 41, 48);

return function(u2) -- Line: 3
    -- upvalues: u1 (copy)
    local u3 = u2:getInstance("ClickRegion");
    local CanvasGroup = Instance.new("CanvasGroup");
    CanvasGroup.Name = "Caption";
    CanvasGroup.AnchorPoint = Vector2.new(0.5, 0);
    CanvasGroup.BackgroundTransparency = 1;
    CanvasGroup.BorderSizePixel = 0;
    CanvasGroup.GroupTransparency = 1;
    CanvasGroup.Position = UDim2.fromOffset(0, 0);
    CanvasGroup.Visible = true;
    CanvasGroup.ZIndex = 30;
    CanvasGroup.Parent = u3;
    local Frame = Instance.new("Frame");
    Frame.Name = "Box";
    Frame.AutomaticSize = Enum.AutomaticSize.XY;
    Frame.BackgroundColor3 = u1;
    Frame.Position = UDim2.fromOffset(4, 7);
    Frame.ZIndex = 12;
    Frame.Parent = CanvasGroup;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Header";
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal);
    TextLabel.Text = "Caption";
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
    TextLabel.TextSize = 15;
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
    TextLabel2.TextSize = 15;
    TextLabel2.AutomaticSize = Enum.AutomaticSize.X;
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Position = UDim2.fromOffset(0, -1);
    TextLabel2.Size = UDim2.fromScale(1, 1);
    TextLabel2.ZIndex = 16;
    TextLabel2.Parent = ImageLabel;
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.Name = "Caret";
    ImageLabel2.Image = "rbxassetid://101906294438076";
    ImageLabel2.ImageColor3 = u1;
    ImageLabel2.AnchorPoint = Vector2.new(0, 0.5);
    ImageLabel2.BackgroundTransparency = 1;
    ImageLabel2.Position = UDim2.new(0, 0, 0, 4);
    ImageLabel2.Size = UDim2.fromOffset(16, 8);
    ImageLabel2.ZIndex = 12;
    ImageLabel2.Parent = CanvasGroup;
    local ImageLabel3 = Instance.new("ImageLabel");
    ImageLabel3.Visible = true;
    ImageLabel3.Name = "DropShadow";
    ImageLabel3.Image = "rbxassetid://124920646932671";
    ImageLabel3.ImageColor3 = Color3.fromRGB(0, 0, 0);
    ImageLabel3.ImageTransparency = 0.45;
    ImageLabel3.ScaleType = Enum.ScaleType.Slice;
    ImageLabel3.SliceCenter = Rect.new(12, 12, 13, 13);
    ImageLabel3.BackgroundTransparency = 1;
    ImageLabel3.Position = UDim2.fromOffset(0, 5);
    ImageLabel3.Size = UDim2.new(1, 0, 0, 48);
    ImageLabel3.Parent = CanvasGroup;
    Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 145
        -- upvalues: ImageLabel3 (copy), Frame (copy)
        ImageLabel3.Size = UDim2.new(1, 0, 0, Frame.AbsoluteSize.Y + 8);
    end);
    local captionJanitor = u2.captionJanitor;
    local _, u4 = u2:clipOutside(CanvasGroup);
    u4.AutomaticSize = Enum.AutomaticSize.None;
    captionJanitor:add(CanvasGroup:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 155, Name: matchSize
        -- upvalues: CanvasGroup (copy), u4 (copy)
        local AbsoluteSize = CanvasGroup.AbsoluteSize;
        u4.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y);
    end));
    local AbsoluteSize = CanvasGroup.AbsoluteSize;
    u4.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y);
    local u5 = false;
    local Header = CanvasGroup.Box.Header;
    local UserInputService = game:GetService("UserInputService");

    local function updateHotkey(p6) -- Line: 168
        -- upvalues: UserInputService (copy), CanvasGroup (copy), u2 (copy), Header (copy), TextLabel2 (copy), Frame2 (copy)
        local KeyboardEnabled = UserInputService.KeyboardEnabled;
        local v7 = CanvasGroup:GetAttribute("CaptionText") or "";
        local v8 = v7 == "_hotkey_";

        if not KeyboardEnabled and v8 then
            u2:setCaption();

            return;
        end;

        Header.Text = v7;
        Header.Visible = not v8;

        if p6 then
            TextLabel2.Text = p6.Name;
            Frame2.Visible = true;
        end;

        if not KeyboardEnabled then
            Frame2.Visible = false;
        end;
    end;

    CanvasGroup:GetAttributeChangedSignal("CaptionText"):Connect(updateHotkey);
    local Quad = Enum.EasingStyle.Quad;
    local u9 = TweenInfo.new(0.2, Quad, Enum.EasingDirection.In);
    local u10 = TweenInfo.new(0.2, Quad, Enum.EasingDirection.Out);
    local TweenService = game:GetService("TweenService");
    local RunService = game:GetService("RunService");

    local function getCaptionPosition(p11) -- Line: 194
        -- upvalues: u5 (ref)
        if p11 == nil then
            p11 = u5;
        end;

        return UDim2.new(0.5, 0, 1, p11 and 10 or 2);
    end;

    local function updatePosition(p12) -- Line: 201
        -- upvalues: u5 (ref), ImageLabel2 (copy), CanvasGroup (copy), u3 (copy), u4 (copy), u9 (copy), u10 (copy), TweenService (copy), RunService (copy)
        if not u5 then
            return;
        end;

        if p12 == nil then
            p12 = u5;
        end;

        local v13 = not p12;

        if v13 == nil then
            v13 = u5;
        end;

        local v14 = UDim2.new(0.5, 0, 1, v13 and 10 or 2);
        local v15;

        if p12 == nil then
            v15 = u5;
        else
            v15 = p12;
        end;

        local v16 = UDim2.new(0.5, 0, 1, v15 and 10 or 2);

        if p12 then
            ImageLabel2.Position = UDim2.fromOffset(0, ImageLabel2.Position.Y.Offset);
            CanvasGroup.AutomaticSize = Enum.AutomaticSize.XY;
            CanvasGroup.Size = UDim2.fromOffset(32, 53);
        else
            local AbsoluteSize2 = CanvasGroup.AbsoluteSize;
            CanvasGroup.AutomaticSize = Enum.AutomaticSize.Y;
            CanvasGroup.Size = UDim2.fromOffset(AbsoluteSize2.X, AbsoluteSize2.Y);
        end;

        local u17 = nil;

        local function updateCaret() -- Line: 230
            -- upvalues: u3 (ref), CanvasGroup (ref), ImageLabel2 (ref), u17 (ref)
            local v18 = u3.AbsolutePosition.X - CanvasGroup.AbsolutePosition.X + u3.AbsoluteSize.X / 2 - ImageLabel2.AbsoluteSize.X / 2;
            local Offset = ImageLabel2.Position.Y.Offset;
            local v19 = UDim2.fromOffset(v18, Offset);

            if u17 ~= v18 then
                u17 = v18;
                ImageLabel2.Position = UDim2.fromOffset(0, Offset);
                task.wait();
            end;

            ImageLabel2.Position = v19;
        end;

        u4.Position = v14;
        updateCaret();
        local v20 = TweenService:Create(u4, p12 and u9 or u10, {
            Position = v16
        });
        local u21 = RunService.Heartbeat:Connect(updateCaret);
        v20:Play();
        v20.Completed:Once(function() -- Line: 253
            -- upvalues: u21 (copy)
            u21:Disconnect();
        end);
    end;

    captionJanitor:add(u3:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 258
        -- upvalues: updatePosition (copy)
        updatePosition();
    end));
    updatePosition(false);
    captionJanitor:add(u2.toggleKeyAdded:Connect(updateHotkey));

    for i, _ in pairs(u2.bindedToggleKeys) do
        local KeyboardEnabled = UserInputService.KeyboardEnabled;
        local v22 = CanvasGroup:GetAttribute("CaptionText") or "";
        local v23 = v22 == "_hotkey_";

        if KeyboardEnabled or not v23 then
            Header.Text = v22;
            Header.Visible = not v23;

            if i then
                TextLabel2.Text = i.Name;
                Frame2.Visible = true;
            end;

            if not KeyboardEnabled then
                Frame2.Visible = false;
            end;
        else
            u2:setCaption();
        end;

        break;
    end;

    captionJanitor:add(u2.fakeToggleKeyChanged:Connect(updateHotkey));
    local fakeToggleKey = u2.fakeToggleKey;

    if fakeToggleKey then
        local KeyboardEnabled = UserInputService.KeyboardEnabled;
        local v24 = CanvasGroup:GetAttribute("CaptionText") or "";
        local v25 = v24 == "_hotkey_";

        if KeyboardEnabled or not v25 then
            Header.Text = v24;
            Header.Visible = not v25;

            if fakeToggleKey then
                TextLabel2.Text = fakeToggleKey.Name;
                Frame2.Visible = true;
            end;

            if not KeyboardEnabled then
                Frame2.Visible = false;
            end;
        else
            u2:setCaption();
        end;
    end;

    local function setCaptionEnabled(p26) -- Line: 274
        -- upvalues: u5 (ref), u2 (copy), u9 (copy), u10 (copy), TweenService (copy), CanvasGroup (copy), u4 (copy), updatePosition (copy), UserInputService (copy), Header (copy), Frame2 (copy)
        if u5 == p26 then
            return;
        end;

        local joinedFrame = u2.joinedFrame;

        if joinedFrame and string.match(joinedFrame.Name, "Dropdown") then
            p26 = false;
        end;

        u5 = p26;
        TweenService:Create(CanvasGroup, p26 and u9 or u10, {
            GroupTransparency = p26 and 0 or 1
        }):Play();

        if p26 then
            u4:SetAttribute("ForceUpdate", true);
        end;

        updatePosition();
        local KeyboardEnabled = UserInputService.KeyboardEnabled;
        local v27 = CanvasGroup:GetAttribute("CaptionText") or "";
        local v28 = v27 == "_hotkey_";

        if not KeyboardEnabled and v28 then
            u2:setCaption();

            return;
        end;

        Header.Text = v27;
        Header.Visible = not v28;

        if not KeyboardEnabled then
            Frame2.Visible = false;
        end;
    end;

    local iconModule = require(u2.iconModule);
    captionJanitor:add(u2.stateChanged:Connect(function(p29) -- Line: 299
        -- upvalues: iconModule (copy), u2 (copy), setCaptionEnabled (copy)
        if p29 ~= "Viewing" then
            iconModule.captionLastClosedClock = os.clock();
            setCaptionEnabled(false);

            return;
        end;

        local captionLastClosedClock = iconModule.captionLastClosedClock;
        local v30 = (captionLastClosedClock and os.clock() - captionLastClosedClock or 999) < 0.3 and 0 or 0.5;
        task.delay(v30, function() -- Line: 304
            -- upvalues: u2 (ref), setCaptionEnabled (ref)
            if u2.activeState == "Viewing" then
                setCaptionEnabled(true);
            end;
        end);
    end));

    return CanvasGroup;
end;