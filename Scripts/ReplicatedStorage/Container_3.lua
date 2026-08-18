--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Container
  Path:     game.ReplicatedStorage.SatchelLoader.Satchel.Packages._Index.1foreverhd_topbarplus@3.3.1.topbarplus.Elements.Container
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:06 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = false;
local u2 = 0;

return function(u3) -- Line: 3
    -- upvalues: u1 (ref), u2 (ref)
    local GuiService = game:GetService("GuiService");
    local Players = game:GetService("Players");
    local v4 = {};
    local u5 = require(script.Parent.Parent.Packages.GoodSignal).new();
    local u6 = GuiService:GetGuiInset();
    local u7 = 0;
    local u8 = 0;
    local u9 = 0;
    local u10 = 0;

    local function checkInset(p11) -- Line: 17
        -- upvalues: GuiService (copy), u3 (copy), u10 (ref), checkInset (copy), Players (copy), u1 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u5 (copy), u2 (ref)
        local Height = GuiService.TopbarInset.Height;
        local v12 = Height <= 36;
        local v13 = GuiService:IsTenFootInterface();
        u3.isOldTopbar = v12;
        u10 = u10 + 1;

        if Height == 0 and p11 == nil then
            task.defer(function() -- Line: 28
                -- upvalues: checkInset (ref)
                task.wait(8);
                checkInset("ForceConvertToOld");
            end);
        elseif u10 == 1 then
            task.delay(5, function() -- Line: 33
                -- upvalues: Players (ref), u10 (ref), checkInset (ref)
                Players.LocalPlayer:WaitForChild("PlayerGui");

                if u10 == 1 then
                    checkInset();
                end;
            end);
        end;

        if u3.isOldTopbar and (not v13 and (u1 == false and (Height ~= 0 or p11 == "ForceConvertToOld"))) then
            u1 = true;
            task.defer(function() -- Line: 45
                -- upvalues: u3 (ref), GuiService (ref)
                local Classic = require(script.Parent.Parent.Features.Themes.Classic);
                u3.modifyBaseTheme(Classic);

                local function decideToHideTopbar() -- Line: 52
                    -- upvalues: GuiService (ref), u3 (ref)
                    if GuiService.MenuIsOpen then
                        u3.setTopbarEnabled(false, true);

                        return;
                    end;

                    u3.setTopbarEnabled();
                end;

                GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(decideToHideTopbar);

                if GuiService.MenuIsOpen then
                    u3.setTopbarEnabled(false, true);

                    return;
                end;

                u3.setTopbarEnabled();
            end);
        end;

        u6 = GuiService:GetGuiInset();
        u7 = v12 and 12 or u6.Y - 50;
        u8 = v12 and 2 or 0;
        u9 = -2;

        if v13 then
            u7 = 10;
            u8 = -9;
        end;

        if GuiService.TopbarInset.Height == 0 and not u1 then
            u8 = u8 + 13;
            u9 = 50;
        end;

        u5:Fire(u6);
        local Y = u6.Y;

        if Y ~= u2 then
            u2 = Y;
            task.defer(function() -- Line: 83
                -- upvalues: u3 (ref), Y (copy)
                u3.insetHeightChanged:Fire(Y);
            end);
        end;
    end;

    GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(checkInset);
    checkInset("FirstTime");
    local ScreenGui = Instance.new("ScreenGui");
    u5:Connect(function() -- Line: 93
        -- upvalues: ScreenGui (copy), u7 (ref)
        ScreenGui:SetAttribute("StartInset", u7);
    end);
    ScreenGui.Name = "TopbarStandard";
    ScreenGui.Enabled = true;
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets;
    v4[ScreenGui.Name] = ScreenGui;
    u3.baseDisplayOrderChanged:Connect(function() -- Line: 103
        -- upvalues: ScreenGui (copy), u3 (copy)
        ScreenGui.DisplayOrder = u3.baseDisplayOrder;
    end);
    local Frame = Instance.new("Frame");
    Frame.Name = "Holders";
    Frame.BackgroundTransparency = 1;
    u5:Connect(function() -- Line: 110
        -- upvalues: Frame (copy), u8 (ref), u9 (ref)
        Frame.Position = UDim2.new(0, 0, 0, u8);
        Frame.Size = UDim2.new(1, 0, 1, u9);
    end);
    Frame.Visible = true;
    Frame.ZIndex = 1;
    Frame.Parent = ScreenGui;
    local u14 = ScreenGui:Clone();
    local Holders = u14.Holders;

    local function updateCenteredHoldersHeight() -- Line: 120
        -- upvalues: Holders (copy), GuiService (copy), u9 (ref)
        Holders.Size = UDim2.new(1, 0, 0, GuiService.TopbarInset.Height + u9);
    end;

    u14.Name = "TopbarCentered";
    u14.ScreenInsets = Enum.ScreenInsets.None;
    u3.baseDisplayOrderChanged:Connect(function() -- Line: 125
        -- upvalues: u14 (copy), u3 (copy)
        u14.DisplayOrder = u3.baseDisplayOrder;
    end);
    v4[u14.Name] = u14;
    u5:Connect(updateCenteredHoldersHeight);
    Holders.Size = UDim2.new(1, 0, 0, GuiService.TopbarInset.Height + u9);
    local u15 = ScreenGui:Clone();
    u15.Name = u15.Name .. "Clipped";
    u15.DisplayOrder = u15.DisplayOrder + 1;
    u3.baseDisplayOrderChanged:Connect(function() -- Line: 136
        -- upvalues: u15 (copy), u3 (copy)
        u15.DisplayOrder = u3.baseDisplayOrder + 1;
    end);
    v4[u15.Name] = u15;
    local u16 = u14:Clone();
    u16.Name = u16.Name .. "Clipped";
    u16.DisplayOrder = u16.DisplayOrder + 1;
    u3.baseDisplayOrderChanged:Connect(function() -- Line: 144
        -- upvalues: u16 (copy), u3 (copy)
        u16.DisplayOrder = u3.baseDisplayOrder + 1;
    end);
    v4[u16.Name] = u16;
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame:SetAttribute("IsAHolder", true);
    ScrollingFrame.Name = "Left";
    u5:Connect(function() -- Line: 153
        -- upvalues: ScrollingFrame (copy), u7 (ref)
        ScrollingFrame.Position = UDim2.fromOffset(u7, 0);
    end);
    ScrollingFrame.Size = UDim2.new(1, -24, 1, 0);
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.Visible = true;
    ScrollingFrame.ZIndex = 1;
    ScrollingFrame.Active = false;
    ScrollingFrame.ClipsDescendants = true;
    ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.None;
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, -1);
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.X;
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.X;
    ScrollingFrame.ScrollBarThickness = 0;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.Selectable = false;
    ScrollingFrame.ScrollingEnabled = false;
    ScrollingFrame.ElasticBehavior = Enum.ElasticBehavior.Never;
    ScrollingFrame.Parent = Frame;
    local UIListLayout = Instance.new("UIListLayout");
    u5:Connect(function() -- Line: 174
        -- upvalues: UIListLayout (copy), u7 (ref)
        UIListLayout.Padding = UDim.new(0, u7);
    end);
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom;
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
    UIListLayout.Parent = ScrollingFrame;
    local u17 = ScrollingFrame:Clone();
    u5:Connect(function() -- Line: 184
        -- upvalues: u17 (copy), u7 (ref)
        u17.UIListLayout.Padding = UDim.new(0, u7);
    end);
    u17.ScrollingEnabled = false;
    u17.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    u17.Name = "Center";
    u17.Parent = Holders;
    local u18 = ScrollingFrame:Clone();
    u5:Connect(function() -- Line: 193
        -- upvalues: u18 (copy), u7 (ref)
        u18.UIListLayout.Padding = UDim.new(0, u7);
    end);
    u18.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right;
    u18.Name = "Right";
    u18.AnchorPoint = Vector2.new(1, 0);
    u18.Position = UDim2.new(1, -12, 0, 0);
    u18.Parent = Frame;
    u5:Fire(u6);

    return v4;
end;