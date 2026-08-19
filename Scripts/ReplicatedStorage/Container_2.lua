--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Container
  Path:     game.ReplicatedStorage.Library.Imported.TopbarPlus.Elements.Container
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:26 2026
]]

-- Decompiled with Potassium's decompiler.

return function(u1) -- Line: 1
    local GuiService = game:GetService("GuiService");
    local isOldTopbar = u1.isOldTopbar;
    local v2 = {};
    local v3 = GuiService:GetGuiInset();
    local v4 = GuiService:IsTenFootInterface();
    local v5 = v4 and 10 or (isOldTopbar and 12 or v3.Y - 46);
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui:SetAttribute("StartInset", v5);
    ScreenGui.Name = "TopbarStandard";
    ScreenGui.Enabled = true;
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets;
    v2[ScreenGui.Name] = ScreenGui;
    ScreenGui.DisplayOrder = u1.baseDisplayOrder;
    u1.baseDisplayOrderChanged:Connect(function() -- Line: 22
        -- upvalues: ScreenGui (copy), u1 (copy)
        ScreenGui.DisplayOrder = u1.baseDisplayOrder;
    end);
    local Frame = Instance.new("Frame");
    local v6 = isOldTopbar and 2 or 0;
    local u7;

    if v4 then
        v6 = v6 + 13;
        u7 = 50;
    else
        u7 = -2;
    end;

    Frame.Name = "Holders";
    Frame.BackgroundTransparency = 1;
    Frame.Position = UDim2.new(0, 0, 0, v6);
    Frame.Size = UDim2.new(1, 0, 1, u7);
    Frame.Visible = true;
    Frame.ZIndex = 1;
    Frame.Parent = ScreenGui;
    local u8 = ScreenGui:Clone();
    local Holders = u8.Holders;
    local GuiService2 = game:GetService("GuiService");

    local function updateCenteredHoldersHeight() -- Line: 44
        -- upvalues: Holders (copy), GuiService2 (copy), u7 (ref)
        Holders.Size = UDim2.new(1, 0, 0, GuiService2.TopbarInset.Height + u7);
    end;

    u8.Name = "TopbarCentered";
    u8.ScreenInsets = Enum.ScreenInsets.None;
    u1.baseDisplayOrderChanged:Connect(function() -- Line: 49
        -- upvalues: u8 (copy), u1 (copy)
        u8.DisplayOrder = u1.baseDisplayOrder;
    end);
    v2[u8.Name] = u8;
    GuiService2:GetPropertyChangedSignal("TopbarInset"):Connect(updateCenteredHoldersHeight);
    Holders.Size = UDim2.new(1, 0, 0, GuiService2.TopbarInset.Height + u7);
    local u9 = ScreenGui:Clone();
    u9.Name = u9.Name .. "Clipped";
    u9.DisplayOrder = u9.DisplayOrder + 1;
    u1.baseDisplayOrderChanged:Connect(function() -- Line: 59
        -- upvalues: u9 (copy), u1 (copy)
        u9.DisplayOrder = u1.baseDisplayOrder + 1;
    end);
    v2[u9.Name] = u9;
    local u10 = u8:Clone();
    u10.Name = u10.Name .. "Clipped";
    u10.DisplayOrder = u10.DisplayOrder + 1;
    u1.baseDisplayOrderChanged:Connect(function() -- Line: 67
        -- upvalues: u10 (copy), u1 (copy)
        u10.DisplayOrder = u1.baseDisplayOrder + 1;
    end);
    v2[u10.Name] = u10;

    if isOldTopbar then
        task.defer(function() -- Line: 73
            -- upvalues: GuiService2 (copy), u1 (copy)
            local function decideToHideTopbar() -- Line: 74
                -- upvalues: GuiService2 (ref), u1 (ref)
                if GuiService2.MenuIsOpen then
                    u1.setTopbarEnabled(false, true);

                    return;
                end;

                u1.setTopbarEnabled();
            end;

            GuiService2:GetPropertyChangedSignal("MenuIsOpen"):Connect(decideToHideTopbar);

            if GuiService2.MenuIsOpen then
                u1.setTopbarEnabled(false, true);

                return;
            end;

            u1.setTopbarEnabled();
        end);
    end;

    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame:SetAttribute("IsAHolder", true);
    ScrollingFrame.Name = "Left";
    ScrollingFrame.Position = UDim2.fromOffset(v5, 0);
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
    UIListLayout.Padding = UDim.new(0, v5);
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom;
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
    UIListLayout.Parent = ScrollingFrame;
    local v11 = ScrollingFrame:Clone();
    v11.ScrollingEnabled = false;
    v11.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    v11.Name = "Center";
    v11.Parent = Holders;
    local v12 = ScrollingFrame:Clone();
    v12.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right;
    v12.Name = "Right";
    v12.AnchorPoint = Vector2.new(1, 0);
    v12.Position = UDim2.new(1, -12, 0, 0);
    v12.Parent = Frame;

    return v2;
end;