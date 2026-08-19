--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Menu
  Path:     game.ReplicatedStorage.SatchelLoader.Satchel.Packages._Index.1foreverhd_topbarplus@3.3.1.topbarplus.Elements.Menu
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:26 2026
]]

-- Decompiled with Potassium's decompiler.

return function(u1) -- Line: 1
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Name = "Menu";
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.Visible = true;
    ScrollingFrame.ZIndex = 1;
    ScrollingFrame.Size = UDim2.fromScale(1, 1);
    ScrollingFrame.ClipsDescendants = true;
    ScrollingFrame.TopImage = "";
    ScrollingFrame.BottomImage = "";
    ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.Always;
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, -1);
    ScrollingFrame.ScrollingEnabled = true;
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.X;
    ScrollingFrame.ZIndex = 20;
    ScrollingFrame.ScrollBarThickness = 3;
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255);
    ScrollingFrame.ScrollBarImageTransparency = 0.8;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.Selectable = false;
    local iconModule = require(u1.iconModule);
    local u2 = iconModule.container.TopbarStandard:FindFirstChild("UIListLayout", true):Clone();
    u2.Name = "MenuUIListLayout";
    u2.VerticalAlignment = Enum.VerticalAlignment.Center;
    u2.Parent = ScrollingFrame;
    local Frame = Instance.new("Frame");
    Frame.Name = "MenuGap";
    Frame.BackgroundTransparency = 1;
    Frame.Visible = false;
    Frame.AnchorPoint = Vector2.new(0, 0.5);
    Frame.ZIndex = 5;
    Frame.Parent = ScrollingFrame;
    local u3 = false;
    local Themes = require(script.Parent.Parent.Features.Themes);
    u1.menuChildAdded:Connect(function() -- Line: 39, Name: totalChildrenChanged
        -- upvalues: u1 (copy), u3 (ref), ScrollingFrame (copy), Themes (copy), u2 (copy)
        local menuJanitor = u1.menuJanitor;
        local v4 = #u1.menuIcons;

        if u3 then
            if v4 <= 0 then
                menuJanitor:clean();
                u3 = false;
            end;

            return;
        end;

        u3 = true;
        menuJanitor:add(u1.toggled:Connect(function() -- Line: 53
            -- upvalues: u1 (ref)
            if #u1.menuIcons > 0 then
                u1.updateSize:Fire();
            end;
        end));
        local _, u5 = u1:modifyTheme({ { "Menu", "Active", true } });
        task.defer(function() -- Line: 63
            -- upvalues: menuJanitor (copy), u1 (ref), u5 (copy)
            menuJanitor:add(function() -- Line: 64
                -- upvalues: u1 (ref), u5 (ref)
                u1:removeModification(u5);
            end);
        end);
        local X = ScrollingFrame.AbsoluteCanvasSize.X;

        local function rightAlignCanvas() -- Line: 73
            -- upvalues: u1 (ref), ScrollingFrame (ref), X (ref)
            if u1.alignment == "Right" then
                local X2 = ScrollingFrame.AbsoluteCanvasSize.X;
                local v6 = X - X2;
                X = X2;
                ScrollingFrame.CanvasPosition = Vector2.new(ScrollingFrame.CanvasPosition.X - v6, 0);
            end;
        end;

        menuJanitor:add(u1.selected:Connect(rightAlignCanvas));
        menuJanitor:add(ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(rightAlignCanvas));
        local v7 = u1:getStateGroup();

        if Themes.getThemeValue(v7, "IconImage", "Image", "Deselected") == Themes.getThemeValue(v7, "IconImage", "Image", "Selected") then
            local v8 = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Light, Enum.FontStyle.Normal);
            u1:removeModificationWith("IconLabel", "Text", "Viewing");
            u1:removeModificationWith("IconLabel", "Image", "Viewing");
            u1:modifyTheme({
                {
                    "IconLabel",
                    "FontFace",
                    v8,
                    "Selected"
                },
                { "IconLabel", "Text", "X", "Selected" },
                { "IconLabel", "TextSize", 20, "Selected" },
                { "IconLabel", "TextStrokeTransparency", 0.8, "Selected" },
                { "IconImage", "Image", "", "Selected" }
            });
        end;

        local u9 = u1:getInstance("MenuGap");
        menuJanitor:add(u1.alignmentChanged:Connect(function() -- Line: 104, Name: updateAlignent
            -- upvalues: u1 (ref), u9 (copy)
            local v10, v11;

            if u1.alignment == "Right" then
                v10 = 99999;
                v11 = 99998;
            else
                v10 = -99999;
                v11 = -99998;
            end;

            u1:modifyTheme({ "IconSpot", "LayoutOrder", v10 });
            u9.LayoutOrder = v11;
        end));
        local v12, v13;

        if u1.alignment == "Right" then
            v12 = 99999;
            v13 = 99998;
        else
            v12 = -99999;
            v13 = -99998;
        end;

        u1:modifyTheme({ "IconSpot", "LayoutOrder", v12 });
        u9.LayoutOrder = v13;
        ScrollingFrame:GetAttributeChangedSignal("MenuCanvasWidth"):Connect(function() -- Line: 120
            -- upvalues: ScrollingFrame (ref)
            local v14 = ScrollingFrame:GetAttribute("MenuCanvasWidth");
            local Y = ScrollingFrame.CanvasSize.Y;
            ScrollingFrame.CanvasSize = UDim2.new(0, v14, Y.Scale, Y.Offset);
        end);
        menuJanitor:add(u1.updateMenu:Connect(function() -- Line: 125
            -- upvalues: ScrollingFrame (ref), u2 (ref)
            local v15 = ScrollingFrame:GetAttribute("MaxIcons");

            if not v15 then
                return;
            end;

            local v16 = {};

            for _, child in pairs(ScrollingFrame:GetChildren()) do
                if child:GetAttribute("WidgetUID") and child.Visible then
                    table.insert(v16, { child, child.AbsolutePosition.X });
                end;
            end;

            table.sort(v16, function(p17, p18) -- Line: 137
                return p17[2] < p18[2];
            end);
            local v19 = 0;

            for i = 1, v15 do
                local v20 = v16[i];

                if not v20 then
                    break;
                end;

                v19 = v19 + (v20[1].AbsoluteSize.X + u2.Padding.Offset);
            end;

            ScrollingFrame:SetAttribute("MenuWidth", v19);
        end));

        local function startMenuUpdate() -- Line: 152
            -- upvalues: u1 (ref)
            task.delay(0.1, function() -- Line: 153
                -- upvalues: u1 (ref)
                u1.startMenuUpdate:Fire();
            end);
        end;

        menuJanitor:add(ScrollingFrame.ChildAdded:Connect(startMenuUpdate));
        menuJanitor:add(ScrollingFrame.ChildRemoved:Connect(startMenuUpdate));
        menuJanitor:add(ScrollingFrame:GetAttributeChangedSignal("MaxIcons"):Connect(startMenuUpdate));
        menuJanitor:add(ScrollingFrame:GetAttributeChangedSignal("MaxWidth"):Connect(startMenuUpdate));
        task.delay(0.1, function() -- Line: 153
            -- upvalues: u1 (ref)
            u1.startMenuUpdate:Fire();
        end);
    end);
    u1.menuSet:Connect(function(p21) -- Line: 165
        -- upvalues: u1 (copy), iconModule (copy)
        for _, v in pairs(u1.menuIcons) do
            iconModule.getIconByUID(v):destroy();
        end;

        if type(p21) == "table" then
            for _, v in pairs(p21) do
                v:joinMenu(u1);
            end;
        end;
    end);

    return ScrollingFrame;
end;