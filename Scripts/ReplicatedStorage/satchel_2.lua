--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     satchel
  Path:     game.ReplicatedStorage.SatchelLoader.Satchel.Packages.satchel
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:04 2026
]]

-- Decompiled with Potassium's decompiler.

local ContextActionService = game:GetService("ContextActionService");
local TextChatService = game:GetService("TextChatService");
local UserInputService = game:GetService("UserInputService");
local StarterGui = game:GetService("StarterGui");
local GuiService = game:GetService("GuiService");
local RunService = game:GetService("RunService");
local VRService = game:GetService("VRService");
local Players = game:GetService("Players");
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local v1 = require(game.ReplicatedStorage.Library).get("Signal");
local u2 = {
    OpenClose = nil,
    IsOpen = false,
    StateChanged = Instance.new("BindableEvent"),
    ModuleName = "Backpack",
    KeepVRTopbarOpen = true,
    VRIsExclusive = true,
    VRClosesNonExclusive = true,
    BackpackEmpty = Instance.new("BindableEvent")
};
u2.BackpackEmpty.Name = "BackpackEmpty";
u2.BackpackItemAdded = Instance.new("BindableEvent");
u2.BackpackItemAdded.Name = "BackpackAdded";
u2.BackpackItemRemoved = Instance.new("BindableEvent");
u2.BackpackItemRemoved.Name = "BackpackRemoved";
local v3 = script;
local v4 = GuiService.PreferredTransparency or 1;
local u5 = not v3:GetAttribute("OutlineEquipBorder") or false;
local u6 = v3:GetAttribute("InsetIconPadding");
local u7 = v3:GetAttribute("BackgroundTransparency") or 0.3;
local u8 = u7 * v4;
local v9 = UDim.new(0, 8);
local u10 = v3:GetAttribute("BackgroundColor3") or Color3.new(0.09803921568627451, 0.10588235294117647, 0.11372549019607843);
local u11 = v3:GetAttribute("EquipBorderColor3") or Color3.new(0, 0.6352941176470588, 1);
local u12 = v3:GetAttribute("BackgroundTransparency") or 0.3;
local u13 = u12 * v4;
local u14 = v3:GetAttribute("EquipBorderSizePixel") or 5;
local u15 = v3:GetAttribute("CornerRadius") or UDim.new(0, 8);
local u16 = Color3.new(1, 1, 1);
local u17 = u15 - UDim.new(0, 5) or UDim.new(0, 3);
local u18 = v3:GetAttribute("BackgroundColor3") or Color3.new(0.09803921568627451, 0.10588235294117647, 0.11372549019607843);
local u19 = v3:GetAttribute("TextColor3") or Color3.new(1, 1, 1);
local u20 = v3:GetAttribute("TextStrokeTransparency") or 0.5;
local u21 = v3:GetAttribute("TextStrokeColor3") or Color3.new(0, 0, 0);
local v22 = Color3.new(0.09803921568627451, 0.10588235294117647, 0.11372549019607843);
local u23 = v4 * 0.2;
local v24 = Color3.new(1, 1, 1);
local v25 = UDim.new(0, 3);
local u26 = v3:GetAttribute("FontFace") or Font.new("rbxasset://fonts/families/IBMPlexSansJP.json");
local u27 = v3:GetAttribute("TextSize") or 16;
local Value = Enum.KeyCode.Backspace.Value;
local Value2 = Enum.KeyCode.Zero.Value;
local u28 = {
    [Enum.UserInputType.MouseButton1] = true,
    [Enum.UserInputType.MouseButton2] = true,
    [Enum.UserInputType.MouseButton3] = true,
    [Enum.UserInputType.MouseMovement] = true,
    [Enum.UserInputType.MouseWheel] = true
};
local u29 = {
    [Enum.UserInputType.Gamepad1] = true,
    [Enum.UserInputType.Gamepad2] = true,
    [Enum.UserInputType.Gamepad3] = true,
    [Enum.UserInputType.Gamepad4] = true,
    [Enum.UserInputType.Gamepad5] = true,
    [Enum.UserInputType.Gamepad6] = true,
    [Enum.UserInputType.Gamepad7] = true,
    [Enum.UserInputType.Gamepad8] = true
};
local u30 = true;
local u31 = require(script.Parent.topbarplus).new():setName("Inventory"):setImage("rbxasset://textures/ui/TopBar/inventoryOn.png", "Selected"):setImage("rbxasset://textures/ui/TopBar/inventoryOff.png", "Deselected"):setImageScale(1):setCaption("Inventory"):bindToggleKey(Enum.KeyCode.Backquote):autoDeselect(false):setOrder(-1);
u31.toggled:Connect(function() -- Line: 178
    -- upvalues: GuiService (copy), u2 (copy)
    if not GuiService.MenuIsOpen then
        u2.OpenClose();
    end;
end);
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.DisplayOrder = 120;
ScreenGui.IgnoreGuiInset = true;
ScreenGui.ResetOnSpawn = false;
ScreenGui.Name = "BackpackGui";
ScreenGui.Parent = PlayerGui;
local u32 = GuiService:IsTenFootInterface();
local u33;

if u32 then
    u33 = 100;
    u27 = 24;
else
    u33 = 60;
end;

local u34 = false;
local v35 = UserInputService.TouchEnabled and workspace.CurrentCamera.ViewportSize.X < 1024;
local LocalPlayer = Players.LocalPlayer;
local u36 = nil;
local u37 = nil;
local u38 = nil;
local u39 = nil;
local u40 = nil;
local u41 = nil;
local u42 = nil;
local u43 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local Humanoid = u43:WaitForChild("Humanoid");
local Backpack = LocalPlayer:WaitForChild("Backpack");
local u44 = {};
local u45 = nil;
local u46 = {};
local u47 = {};
local u48 = {};
local u49 = 0;
local u50 = nil;
local u51 = false;
local u52 = false;
local u53 = false;
local u54 = false;
local u55 = {};
local u56 = false;
local u57 = "All";
local VREnabled = VRService.VREnabled;
local u58 = VREnabled and 6 or (v35 and 6 or 10);
local u59 = VREnabled and 3 or (v35 and 2 or 4);
local u60 = nil;

local function EvaluateBackpackPanelVisibility(p61) -- Line: 243
    -- upvalues: u31 (copy), u30 (ref), VRService (copy)
    return p61 and (u31.enabled and u30) and VRService.VREnabled;
end;

local function ShowVRBackpackPopup() -- Line: 247
end;

local function FindLowestEmpty() -- Line: 253
    -- upvalues: u58 (copy), u44 (copy)
    for i = 1, u58 do
        local v62 = u44[i];

        if not v62.Tool then
            return v62;
        end;
    end;

    return nil;
end;

function u2.IsInventoryEmpty() -- Line: 263
    -- upvalues: u58 (copy), u44 (copy)
    for i = u58 + 1, #u44 do
        local v63 = u44[i];

        if v63 and v63.Tool then
            return false;
        end;
    end;

    return true;
end;

local function UseGazeSelection() -- Line: 275
    return false;
end;

local function ToolMatchesFilter(p64) -- Line: 279
    -- upvalues: u57 (ref)
    if not p64 then
        return false;
    end;

    local v65 = p64:GetAttribute("type");

    return (u57 == "All" or v65 == u57) and true or v65 == "Bypass";
end;

local function AdjustHotbarFrames() -- Line: 286
    -- upvalues: u38 (ref), u58 (copy), u44 (copy), u57 (ref)
    local Visible = u38.Visible;
    local v66 = Visible and u58 or 0;
    local v67 = 0;

    if not Visible then
        for i = 1, u58 do
            local v68 = u44[i];

            if v68.Tool then
                local Tool = v68.Tool;
                local v69;

                if Tool then
                    local v70 = Tool:GetAttribute("type");
                    v69 = (u57 == "All" or v70 == u57) and true or v70 == "Bypass";
                else
                    v69 = false;
                end;

                if v69 then
                    v66 = v66 + 1;
                end;
            end;
        end;
    end;

    for i = 1, u58 do
        local v71 = u44[i];
        local v72;

        if v71.Tool then
            local Tool = v71.Tool;

            if Tool then
                local v73 = Tool:GetAttribute("type");
                v72 = (u57 == "All" or v73 == u57) and true or v73 == "Bypass";
            else
                v72 = false;
            end;

            if not v72 then
                if Visible then
                    v72 = not v71.Tool;
                else
                    v72 = Visible;
                end;
            end;
        elseif Visible then
            v72 = not v71.Tool;
        else
            v72 = Visible;
        end;

        if v72 then
            v67 = v67 + 1;
            v71:Readjust(v67, v66);
            v71.Frame.Visible = true;
        else
            v71.Frame.Visible = false;
        end;
    end;
end;

local function UpdateScrollingFrameCanvasSize() -- Line: 313
    -- upvalues: u40 (ref), u33 (ref), u41 (ref)
    local v74 = math.floor(u40.AbsoluteSize.X / (u33 + 5));
    local v75 = (#u41:GetChildren() - 1) / v74;
    local v76 = math.ceil(v75) * (u33 + 5) + 5;
    u40.CanvasSize = UDim2.fromOffset(0, v76);
end;

local function AdjustInventoryFrames() -- Line: 320
    -- upvalues: u58 (copy), u44 (copy), u57 (ref), u40 (ref), u33 (ref), u41 (ref)
    for i = u58 + 1, #u44 do
        local v77 = u44[i];

        if v77.Tool then
            local v78 = v77.Tool:GetAttribute("Order");
            print(v78);

            if typeof(v78) == "number" then
                v77.Frame.LayoutOrder = v78;
            else
                v77.Frame.LayoutOrder = 9999 + v77.Index;
            end;

            local Frame = v77.Frame;
            local Tool = v77.Tool;
            local v79;

            if Tool then
                local v80 = Tool:GetAttribute("type");
                v79 = (u57 == "All" or v80 == u57) and true or v80 == "Bypass";
            else
                v79 = false;
            end;

            Frame.Visible = v79;
        else
            v77.Frame.LayoutOrder = 9999 + v77.Index;
            v77.Frame.Visible = false;
        end;
    end;

    local v81 = math.floor(u40.AbsoluteSize.X / (u33 + 5));
    local v82 = (#u41:GetChildren() - 1) / v81;
    local v83 = math.ceil(v82) * (u33 + 5) + 5;
    u40.CanvasSize = UDim2.fromOffset(0, v83);
end;

local function UpdateBackpackLayout() -- Line: 341
    -- upvalues: u37 (ref), u58 (copy), u33 (ref), u38 (ref), u59 (copy), VREnabled (copy), u40 (ref), AdjustHotbarFrames (copy), AdjustInventoryFrames (copy)
    u37.Size = UDim2.new(0, u58 * (u33 + 5) + 5, 0, u33 + 5 + 5);
    u37.Position = UDim2.new(0.5, -u37.Size.X.Offset / 2, 1, -u37.Size.Y.Offset);
    u38.Size = UDim2.new(0, u37.Size.X.Offset, 0, u37.Size.Y.Offset * u59 + 40 + (VREnabled and 80 or 0));
    u38.Position = UDim2.new(0.5, -u38.Size.X.Offset / 2, 1, u37.Position.Y.Offset - u38.Size.Y.Offset);
    u40.Size = UDim2.new(1, u40.ScrollBarThickness + 1, 1, -40 - (VREnabled and 80 or 0));
    u40.Position = UDim2.fromOffset(0, 40 + (VREnabled and 40 or 0));
    AdjustHotbarFrames();
    AdjustInventoryFrames();
end;

local function Clamp(p84, p85, p86) -- Line: 375
    local v87 = math.max(p84, p86);

    return math.min(p85, v87);
end;

local function CheckBounds(p88, p89, p90) -- Line: 379
    local AbsolutePosition = p88.AbsolutePosition;
    local AbsoluteSize = p88.AbsoluteSize;
    local v91;

    if AbsolutePosition.X < p89 and (p89 <= AbsolutePosition.X + AbsoluteSize.X and AbsolutePosition.Y < p90) then
        v91 = p90 <= AbsolutePosition.Y + AbsoluteSize.Y;
    else
        v91 = false;
    end;

    return v91;
end;

local function GetOffset(p92, p93) -- Line: 385
    return (p92.AbsolutePosition + p92.AbsoluteSize / 2 - p93).Magnitude;
end;

local function DisableActiveHopper() -- Line: 390
    -- upvalues: u50 (ref), u46 (copy)
    u50:ToggleSelect();
    u46[u50]:UpdateEquipView();
    u50 = nil;
end;

local function UnequipAllTools() -- Line: 396
    -- upvalues: Humanoid (ref), u50 (ref), u46 (copy)
    if Humanoid then
        Humanoid:UnequipTools();

        if u50 then
            u50:ToggleSelect();
            u46[u50]:UpdateEquipView();
            u50 = nil;
        end;
    end;
end;

local function EquipNewTool(p94) -- Line: 405
    -- upvalues: Humanoid (ref), u50 (ref), u46 (copy)
    if Humanoid then
        Humanoid:UnequipTools();

        if u50 then
            u50:ToggleSelect();
            u46[u50]:UpdateEquipView();
            u50 = nil;
        end;
    end;

    Humanoid:EquipTool(p94);
end;

local function IsEquipped(p95) -- Line: 411
    -- upvalues: u43 (ref)
    if p95 then
        p95 = p95.Parent == u43;
    end;

    return p95;
end;

local function MakeSlot(p96, p97) -- Line: 416
    -- upvalues: u44 (copy), u13 (ref), u37 (ref), u33 (ref), u58 (copy), u38 (ref), UserInputService (copy), u49 (ref), u52 (ref), u34 (ref), ContextActionService (copy), u42 (ref), u46 (copy), u45 (ref), u43 (ref), u60 (ref), u14 (copy), u11 (copy), u5 (copy), u40 (ref), u41 (ref), u57 (ref), Humanoid (ref), u50 (ref), Backpack (ref), u10 (copy), u16 (copy), u15 (copy), u6 (copy), u19 (copy), u20 (copy), u21 (copy), u26 (copy), u27 (ref), u18 (copy), u17 (copy), MakeSlot (copy), u54 (ref), u47 (copy), Value2 (copy), u48 (copy), u31 (copy)
    local v98 = p97 or #u44 + 1;
    local u99 = {
        Tool = nil,
        Index = v98,
        Frame = nil
    };
    local u100 = nil;
    local u101 = nil;
    local u102 = nil;
    local u103 = nil;
    local u104 = nil;
    local u105 = nil;
    local u106 = nil;
    local u107 = nil;
    local u108 = nil;
    local u109 = nil;

    local function UpdateSlotFading() -- Line: 443
        -- upvalues: u100 (ref), u13 (ref)
        u100.SelectionImageObject = nil;
        u100.BackgroundTransparency = u100.Draggable and 0 or u13;
    end;

    function u99.Readjust(p110, p111, p112) -- Line: 449
        -- upvalues: u37 (ref), u33 (ref), u100 (ref)
        u100.Position = UDim2.fromOffset(u37.Size.X.Offset / 2 - u33 / 2 + (u33 + 5) * (p111 - (p112 / 2 + 0.5)), 5);
    end;

    function u99.Fill(p113, u114) -- Line: 459
        -- upvalues: u102 (ref), u99 (copy), u103 (ref), u109 (ref), u107 (ref), u104 (ref), u105 (ref), u58 (ref), u38 (ref), UserInputService (ref), u100 (ref), u49 (ref), u52 (ref), u34 (ref), ContextActionService (ref), u42 (ref), u46 (ref), u45 (ref), u44 (ref)
        if not u114 then
            return p113:Clear();
        end;

        p113.Tool = u114;

        local function assignToolData() -- Line: 468
            -- upvalues: u114 (copy), u102 (ref), u99 (ref), u103 (ref), u109 (ref), u107 (ref)
            local TextureId = u114.TextureId;
            u102.Image = TextureId;

            if u99.Tool ~= nil then
                u102:SetAttribute("mutations", (u99.Tool:GetAttribute("Mutations")));
                u102:AddTag("MutationImage");
            end;

            if TextureId == "" then
                u103.Visible = true;
            else
                u103.Visible = false;
            end;

            u103.Text = u114.Name;
            local v115 = u114:GetAttribute("Subtitle");

            if v115 and (typeof(v115) == "string" and v115 ~= "x1") then
                u109.Text = v115;
                u109.Visible = true;
            else
                u109.Text = "";
                u109.Visible = false;
            end;

            if u107 and u114:IsA("Tool") then
                u107.Text = u114.ToolTip;
                u107.Size = UDim2.fromOffset(0, 16);
                u107.Position = UDim2.new(0.5, 0, 0, -5);
            end;
        end;

        assignToolData();

        if u104 then
            u104:Disconnect();
            u104 = nil;
        end;

        if u105 then
            u105:Disconnect();
            u105 = nil;
        end;

        u104 = u114.Changed:Connect(function(p116) -- Line: 517
            -- upvalues: assignToolData (copy)
            if p116 == "TextureId" or (p116 == "Name" or p116 == "ToolTip") then
                assignToolData();
            end;
        end);
        u105 = u114:GetAttributeChangedSignal("Subtitle"):Connect(function() -- Line: 523
            -- upvalues: u114 (copy), u109 (ref)
            local v117 = u114:GetAttribute("Subtitle");

            if v117 and typeof(v117) == "string" then
                u109.Text = v117;
                u109.Visible = true;

                return;
            end;

            u109.Text = "";
            u109.Visible = false;
        end);
        local v118 = p113.Index <= u58;

        if (not v118 or u38.Visible) and not UserInputService.VREnabled then
            u100.Draggable = true;
        end;

        p113:UpdateEquipView();

        if v118 then
            u49 = u49 + 1;

            if u52 and (u49 >= 1 and not u34) then
                u34 = true;
                ContextActionService:BindAction("BackpackHotbarEquip", u42, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
            end;
        end;

        u46[u114] = p113;
        local v119;

        for i = 1, u58 do
            v119 = u44[i];

            if not v119.Tool then
                break;
            end;
        end;

        u45 = v119;

        if u58 < p113.Index then
            local v120 = u114:GetAttribute("Order");

            if typeof(v120) == "number" then
                p113.Frame.LayoutOrder = v120;

                return;
            end;

            p113.Frame.LayoutOrder = 9999 + p113.Index;
        end;
    end;

    function u99.Clear(p121) -- Line: 573
        -- upvalues: u104 (ref), u105 (ref), u102 (ref), u103 (ref), u109 (ref), u107 (ref), u100 (ref), u58 (ref), u49 (ref), u34 (ref), ContextActionService (ref), u46 (ref), u45 (ref), u44 (ref)
        if not p121.Tool then
            return;
        end;

        if u104 then
            u104:Disconnect();
            u104 = nil;
        end;

        if u105 then
            u105:Disconnect();
            u105 = nil;
        end;

        u102.Image = "";
        u103.Text = "";
        u109.Text = "";
        u109.Visible = false;
        u102:SetAttribute("mutations", nil);
        u102:RemoveTag("MutationImage");
        local v122 = next;
        local v123, v124 = u102:GetChildren();

        for _, v in v122, v123, v124 do
            if v.Name ~= "Corner" then
                v:Destroy();
            end;
        end;

        if u107 then
            u107.Text = "";
            u107.Visible = false;
        end;

        u100.Draggable = false;
        p121:UpdateEquipView(true);

        if p121.Index <= u58 then
            u49 = u49 - 1;

            if u49 < 1 then
                u34 = false;
                ContextActionService:UnbindAction("BackpackHotbarEquip");
            end;
        end;

        u46[p121.Tool] = nil;
        p121.Tool = nil;
        local v125;

        for i = 1, u58 do
            v125 = u44[i];

            if not v125.Tool then
                break;
            end;
        end;

        u45 = v125;

        if u58 < p121.Index then
            p121.Frame.LayoutOrder = 9999 + p121.Index;
        end;
    end;

    function u99.UpdateEquipView(p126, p127) -- Line: 630
        -- upvalues: u43 (ref), u60 (ref), u99 (copy), u106 (ref), u14 (ref), u11 (ref), u5 (ref), u102 (ref), u100 (ref), u13 (ref)
        if p127 or false then
            if u106 then
                u106.Parent = nil;
            end;
        else
            local Tool = p126.Tool;

            if Tool then
                Tool = Tool.Parent == u43;
            end;

            if Tool then
                u60 = u99;

                if not u106 then
                    u106 = Instance.new("UIStroke");
                    u106.Name = "Border";
                    u106.Thickness = u14;
                    u106.Color = u11;
                    u106.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                    u106:SetAttribute("Block", true);
                end;

                if u5 == true then
                    u106.Parent = u102;
                else
                    u106.Parent = u100;
                end;
            elseif u106 then
                u106.Parent = nil;
            end;
        end;

        u100.SelectionImageObject = nil;
        u100.BackgroundTransparency = u100.Draggable and 0 or u13;
    end;

    function u99.IsEquipped(p128) -- Line: 655
        -- upvalues: u43 (ref)
        local Tool = p128.Tool;

        if Tool then
            Tool = Tool.Parent == u43;
        end;

        return Tool;
    end;

    function u99.Delete(p129) -- Line: 659
        -- upvalues: u100 (ref), u44 (ref), u40 (ref), u33 (ref), u41 (ref)
        u100:Destroy();
        table.remove(u44, p129.Index);

        for i = p129.Index, #u44 do
            u44[i]:SlideBack();
        end;

        local v130 = math.floor(u40.AbsoluteSize.X / (u33 + 5));
        local v131 = (#u41:GetChildren() - 1) / v130;
        local v132 = math.ceil(v131) * (u33 + 5) + 5;
        u40.CanvasSize = UDim2.fromOffset(0, v132);
    end;

    function u99.Swap(p133, p134) -- Line: 672
        local Tool = p133.Tool;
        local Tool2 = p134.Tool;
        p133:Clear();

        if Tool2 then
            p134:Clear();
            p133:Fill(Tool2);
        end;

        if Tool then
            p134:Fill(Tool);

            return;
        end;

        p134:Clear();
    end;

    function u99.SlideBack(p135) -- Line: 686
        -- upvalues: u100 (ref)
        p135.Index = p135.Index - 1;
        u100.Name = p135.Index;
        u100.LayoutOrder = p135.Index;
    end;

    function u99.TurnNumber(p136, p137) -- Line: 692
        -- upvalues: u108 (ref)
        if u108 then
            u108.Visible = p137;
        end;
    end;

    function u99.SetClickability(p138, p139) -- Line: 698
        -- upvalues: UserInputService (ref), u100 (ref), u13 (ref)
        if p138.Tool then
            if UserInputService.VREnabled then
                u100.Draggable = false;
            else
                u100.Draggable = not p139;
            end;

            u100.SelectionImageObject = nil;
            u100.BackgroundTransparency = u100.Draggable and 0 or u13;
        end;
    end;

    function u99.CheckTerms(p140, p141) -- Line: 709
        -- upvalues: u103 (ref), u107 (ref)
        local u142 = 0;

        local function checkEm(p143, p144) -- Line: 711
            -- upvalues: u142 (ref)
            local _, v145 = p143:lower():gsub(p144, "");
            u142 = u142 + v145;
        end;

        local Tool = p140.Tool;

        if Tool then
            for i in pairs(p141) do
                local _, v146 = u103.Text:lower():gsub(i, "");
                u142 = u142 + v146;

                if Tool:IsA("Tool") then
                    local _, v147 = (u107 and u107.Text or ""):lower():gsub(i, "");
                    u142 = u142 + v147;
                end;
            end;
        end;

        return u142;
    end;

    function u99.Select(p148) -- Line: 729
        -- upvalues: u99 (copy), u58 (ref), u57 (ref), u43 (ref), Humanoid (ref), u50 (ref), u46 (ref), Backpack (ref)
        local Tool = u99.Tool;

        if Tool then
            if u99.Index <= u58 then
                local v149;

                if Tool then
                    local v150 = Tool:GetAttribute("type");
                    v149 = (u57 == "All" or v150 == u57) and true or v150 == "Bypass";
                else
                    v149 = false;
                end;

                if not v149 then
                    return;
                end;
            end;

            local v151;

            if Tool then
                v151 = Tool.Parent == u43;
            else
                v151 = Tool;
            end;

            if v151 then
                if Humanoid then
                    Humanoid:UnequipTools();

                    if u50 then
                        u50:ToggleSelect();
                        u46[u50]:UpdateEquipView();
                        u50 = nil;
                    end;
                end;
            elseif Tool.Parent == Backpack then
                if Humanoid then
                    Humanoid:UnequipTools();

                    if u50 then
                        u50:ToggleSelect();
                        u46[u50]:UpdateEquipView();
                        u50 = nil;
                    end;
                end;

                Humanoid:EquipTool(Tool);
            end;
        end;
    end;

    u100 = Instance.new("TextButton");
    u100.Name = tostring(v98);
    u100.BackgroundColor3 = u10;
    u100.BorderColor3 = u16;
    u100.Text = "";
    u100.BorderSizePixel = 0;
    u100.Size = UDim2.fromOffset(u33, u33);
    u100.Active = true;
    u100.Draggable = false;
    u100.BackgroundTransparency = u13;
    u100.MouseButton1Click:Connect(function() -- Line: 754
        -- upvalues: u99 (copy)
        if game.ReplicatedStorage:GetAttribute("DisableToolbar") then
            return;
        end;

        changeSlot(u99);
    end);
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "Corner";
    UICorner.CornerRadius = u15;
    UICorner.Parent = u100;
    u99.Frame = u100;
    local Frame = Instance.new("Frame");
    Frame.Name = "SelectionObjectClipper";
    Frame.BackgroundTransparency = 1;
    Frame.Visible = false;
    Frame.Parent = u100;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Selector";
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Size = UDim2.fromScale(1, 1);
    ImageLabel.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png";
    ImageLabel.ScaleType = Enum.ScaleType.Slice;
    ImageLabel.SliceCenter = Rect.new(12, 12, 52, 52);
    ImageLabel.Parent = Frame;
    u102 = Instance.new("ImageLabel");
    u102.BackgroundTransparency = 1;
    u102.Name = "Icon";
    u102.Size = UDim2.fromScale(0.7, 0.7);
    u102.Position = UDim2.fromScale(0.5, 0.5);
    u102.AnchorPoint = Vector2.new(0.5, 0.5);

    if u6 == true then
        u102.Size = UDim2.new(1, -u14 * 2, 1, -u14 * 2);
    else
        u102.Size = UDim2.fromScale(1, 1);
    end;

    u102.Parent = u100;
    local UICorner2 = Instance.new("UICorner");
    UICorner2.Name = "Corner";

    if u6 == true then
        UICorner2.CornerRadius = u15 - UDim.new(0, u14);
    else
        UICorner2.CornerRadius = u15;
    end;

    u102.ZIndex = 3;
    UICorner2.Parent = u102;
    u103 = Instance.new("TextLabel");
    u103.BackgroundTransparency = 1;
    u103.Name = "ToolName";
    u103.Text = "";
    u103.TextColor3 = u19;
    u103.TextStrokeTransparency = u20;
    u103.TextStrokeColor3 = u21;
    u103.FontFace = Font.new(u26.Family, Enum.FontWeight.Medium, Enum.FontStyle.Normal);
    u103.TextSize = u27;
    u103.Size = UDim2.new(1, -u14 * 2, 1, -u14 * 2);
    u103.Position = UDim2.fromScale(0.5, 0.5);
    u103.AnchorPoint = Vector2.new(0.5, 0.5);
    u103.TextWrapped = true;
    u103.TextTruncate = Enum.TextTruncate.AtEnd;
    u103.Parent = u100;
    u109 = Instance.new("TextLabel");
    u109.BackgroundTransparency = 1;
    u109.Name = "Subtitle";
    u109.Text = "";
    u109.Visible = false;
    u109.TextColor3 = u19;
    u109.TextStrokeTransparency = u20;
    u109.TextStrokeColor3 = u21;
    u109.FontFace = Font.new(u26.Family, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    u109.TextSize = u27 * 1.2;
    u109.TextXAlignment = Enum.TextXAlignment.Right;
    u109.TextYAlignment = Enum.TextYAlignment.Bottom;
    u109.Size = UDim2.new(1, -8, 1, -8);
    u109.Position = UDim2.fromScale(0.5, 0.5);
    u109.AnchorPoint = Vector2.new(0.5, 0.5);
    u109.ZIndex = 4;
    u109.Parent = u100;
    u99.Frame.LayoutOrder = u99.Index;

    if v98 <= u58 then
        u107 = Instance.new("TextLabel");
        u107.Name = "ToolTip";
        u107.Text = "";
        u107.Size = UDim2.fromScale(1, 1);
        u107.TextColor3 = u19;
        u107.TextStrokeTransparency = u20;
        u107.TextStrokeColor3 = u21;
        u107.FontFace = Font.new(u26.Family, Enum.FontWeight.Medium, Enum.FontStyle.Normal);
        u107.TextSize = u27;
        u107.ZIndex = 2;
        u107.TextWrapped = false;
        u107.TextYAlignment = Enum.TextYAlignment.Center;
        u107.BackgroundColor3 = u18;
        u107.BackgroundTransparency = u13;
        u107.AnchorPoint = Vector2.new(0.5, 1);
        u107.BorderSizePixel = 0;
        u107.Visible = false;
        u107.AutomaticSize = Enum.AutomaticSize.X;
        u107.Parent = u100;
        local UICorner3 = Instance.new("UICorner");
        UICorner3.Name = "Corner";
        UICorner3.CornerRadius = u17;
        UICorner3.Parent = u107;
        local UIPadding = Instance.new("UIPadding");
        UIPadding.PaddingLeft = UDim.new(0, 4);
        UIPadding.PaddingRight = UDim.new(0, 4);
        UIPadding.PaddingTop = UDim.new(0, 4);
        UIPadding.PaddingBottom = UDim.new(0, 4);
        UIPadding.Parent = u107;
        u100.MouseEnter:Connect(function() -- Line: 873
            -- upvalues: u107 (ref)
            if u107.Text ~= "" then
                u107.Visible = true;
            end;
        end);
        u100.MouseLeave:Connect(function() -- Line: 878
            -- upvalues: u107 (ref)
            u107.Visible = false;
        end);

        function u99.MoveToInventory(p152) -- Line: 882
            -- upvalues: u99 (copy), u58 (ref), MakeSlot (ref), u41 (ref), u43 (ref), Humanoid (ref), u50 (ref), u46 (ref), u54 (ref), u38 (ref)
            if u99.Index <= u58 then
                local Tool = u99.Tool;
                p152:Clear();
                local v153 = MakeSlot(u41);
                v153:Fill(Tool);

                if Tool then
                    Tool = Tool.Parent == u43;
                end;

                if Tool and Humanoid then
                    Humanoid:UnequipTools();

                    if u50 then
                        u50:ToggleSelect();
                        u46[u50]:UpdateEquipView();
                        u50 = nil;
                    end;
                end;

                if u54 then
                    v153.Frame.Visible = false;
                    v153.Parent = u38;
                end;
            end;
        end;

        if v98 < 10 or v98 == u58 then
            local v154 = v98 < 10 and (v98 or 0) or 0;
            u108 = Instance.new("TextLabel");
            u108.BackgroundTransparency = 1;
            u108.Name = "Number";
            u108.TextColor3 = u19;
            u108.TextStrokeTransparency = u20;
            u108.TextStrokeColor3 = u21;
            u108.ZIndex = 4;
            u108.TextScaled = true;
            u108.Text = tostring(v154);
            u108.FontFace = Font.new(u26.Family, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
            u108.Size = UDim2.fromScale(0.3, 0.3);
            u108.Position = UDim2.fromScale(0, 0.05);
            u108.Visible = false;
            u108.Parent = u100;
            u47[Value2 + v154] = u99.Select;
        end;
    end;

    local Position = u100.Position;
    local u155 = 0;
    local u156 = nil;
    u100.DragBegin:Connect(function(p157) -- Line: 926
        -- upvalues: u48 (ref), u100 (ref), Position (ref), u31 (ref), u102 (ref), u103 (ref), u108 (ref), u109 (ref), u156 (ref), u41 (ref), u38 (ref), u101 (ref)
        u48[u100] = true;
        Position = p157;
        u100.BorderSizePixel = 2;
        u31:lock();
        u100.ZIndex = 2;
        u102.ZIndex = 2;
        u103.ZIndex = 2;
        u100.Parent.ZIndex = 2;

        if u108 then
            u108.ZIndex = 2;
            u109.ZIndex = 2;
        end;

        u156 = u100.Parent;

        if u156 == u41 then
            local v158 = UDim2.new(0, u100.AbsolutePosition.X - u38.AbsolutePosition.X, 0, u100.AbsolutePosition.Y - u38.AbsolutePosition.Y);
            u100.Parent = u38;
            u100.Position = v158;
            u101 = Instance.new("Frame");
            u101.Name = "FakeSlot";
            u101.LayoutOrder = u100.LayoutOrder;
            u101.Size = u100.Size;
            u101.BackgroundTransparency = 1;
            u101.Parent = u41;
        end;
    end);
    u100.DragStopped:Connect(function(p159, p160) -- Line: 970
        -- upvalues: u101 (ref), u100 (ref), Position (ref), u156 (ref), u31 (ref), u102 (ref), u103 (ref), u108 (ref), u109 (ref), u48 (ref), u99 (copy), u38 (ref), u58 (ref), u155 (ref), u45 (ref), u37 (ref), u44 (ref), u43 (ref), Humanoid (ref), u50 (ref), u46 (ref), u54 (ref)
        if u101 then
            u101:Destroy();
        end;

        local v161 = os.clock();
        u100.Position = Position;
        u100.Parent = u156;
        u100.BorderSizePixel = 0;
        u31:unlock();
        u100.ZIndex = 1;
        u102.ZIndex = 1;
        u103.ZIndex = 1;
        u156.ZIndex = 1;

        if u108 then
            u108.ZIndex = 1;
            u109.ZIndex = 1;
        end;

        u48[u100] = nil;

        if not u99.Tool then
            return;
        end;

        local v162 = u38;
        local AbsolutePosition = v162.AbsolutePosition;
        local AbsoluteSize = v162.AbsoluteSize;
        local v163;

        if AbsolutePosition.X < p159 and (p159 <= AbsolutePosition.X + AbsoluteSize.X and AbsolutePosition.Y < p160) then
            v163 = p160 <= AbsolutePosition.Y + AbsoluteSize.Y;
        else
            v163 = false;
        end;

        if v163 then
            if u99.Index <= u58 then
                u99:MoveToInventory();
            end;

            if u58 < u99.Index and v161 - u155 < 0.5 then
                if u45 then
                    local Tool = u99.Tool;
                    u99:Clear();
                    u45:Fill(Tool);
                    u99:Delete();
                    v161 = 0;
                else
                    v161 = 0;
                end;
            end;
        else
            local v164 = u37;
            local AbsolutePosition2 = v164.AbsolutePosition;
            local AbsoluteSize2 = v164.AbsoluteSize;
            local v165;

            if AbsolutePosition2.X < p159 and (p159 <= AbsolutePosition2.X + AbsoluteSize2.X and AbsolutePosition2.Y < p160) then
                v165 = p160 <= AbsolutePosition2.Y + AbsoluteSize2.Y;
            else
                v165 = false;
            end;

            if v165 then
                local v166 = { (1 / 0), nil };

                for i = 1, u58 do
                    local v167 = u44[i];
                    local Frame2 = v167.Frame;
                    local v168 = Vector2.new(p159, p160);
                    local Magnitude = (Frame2.AbsolutePosition + Frame2.AbsoluteSize / 2 - v168).Magnitude;

                    if Magnitude < v166[1] then
                        v166 = { Magnitude, v167 };
                    end;
                end;

                local v169 = v166[2];

                if v169 ~= u99 then
                    u99:Swap(v169);

                    if u58 < u99.Index then
                        local Tool = u99.Tool;

                        if Tool then
                            if Tool then
                                Tool = Tool.Parent == u43;
                            end;

                            if Tool and Humanoid then
                                Humanoid:UnequipTools();

                                if u50 then
                                    u50:ToggleSelect();
                                    u46[u50]:UpdateEquipView();
                                    u50 = nil;
                                end;
                            end;

                            if u54 then
                                u99.Frame.Visible = false;
                                u99.Frame.Parent = u38;
                            end;
                        else
                            u99:Delete();
                        end;
                    end;
                end;
            elseif u99.Index <= u58 then
                u99:MoveToInventory();
            end;
        end;

        u155 = v161;
    end);
    u100.Parent = p96;
    u44[v98] = u99;

    if u58 < v98 then
        local v170 = math.floor(u40.AbsoluteSize.X / (u33 + 5));
        local v171 = (#u41:GetChildren() - 1) / v170;
        local v172 = math.ceil(v171) * (u33 + 5) + 5;
        u40.CanvasSize = UDim2.fromOffset(0, v172);
    end;

    return u99;
end;

v1.new("ChangeFilter"):Connect(function(p173) -- Line: 1081
    -- upvalues: u57 (ref), u44 (copy), u58 (copy), Humanoid (ref), u50 (ref), u46 (copy), AdjustHotbarFrames (copy), u40 (ref), u33 (ref), u41 (ref)
    u57 = p173;

    for _, v in ipairs(u44) do
        if v.Index <= u58 then
            if v.Tool then
                local Tool = v.Tool;
                local v174;

                if Tool then
                    local v175 = Tool:GetAttribute("type");
                    v174 = (u57 == "All" or v175 == u57) and true or v175 == "Bypass";
                else
                    v174 = false;
                end;

                if not v174 and (v:IsEquipped() and Humanoid) then
                    Humanoid:UnequipTools();

                    if u50 then
                        u50:ToggleSelect();
                        u46[u50]:UpdateEquipView();
                        u50 = nil;
                    end;
                end;
            end;
        elseif v.Tool then
            local Frame = v.Frame;
            local Tool = v.Tool;
            local v176;

            if Tool then
                local v177 = Tool:GetAttribute("type");
                v176 = (u57 == "All" or v177 == u57) and true or v177 == "Bypass";
            else
                v176 = false;
            end;

            Frame.Visible = v176;
        else
            v.Frame.Visible = false;
        end;
    end;

    AdjustHotbarFrames();
    local v178 = math.floor(u40.AbsoluteSize.X / (u33 + 5));
    local v179 = (#u41:GetChildren() - 1) / v178;
    local v180 = math.ceil(v179) * (u33 + 5) + 5;
    u40.CanvasSize = UDim2.fromOffset(0, v180);
end);

local function OnChildAdded(p181) -- Line: 1102
    -- upvalues: u43 (ref), Humanoid (ref), u50 (ref), u46 (copy), u51 (ref), LocalPlayer (ref), u45 (ref), MakeSlot (copy), u41 (ref), u44 (copy), Backpack (ref), AdjustHotbarFrames (copy), u58 (copy), u57 (ref), u38 (ref), u2 (copy)
    if not (p181:IsA("Tool") or p181:IsA("HopperBin")) then
        if p181:IsA("Humanoid") and p181.Parent == u43 then
            Humanoid = p181;
        end;

        return;
    end;

    local _ = p181.Parent == u43;

    if u50 and p181.Parent == u43 then
        u50:ToggleSelect();
        u46[u50]:UpdateEquipView();
        u50 = nil;
    end;

    if not u51 and (p181.Parent == u43 and not u46[p181]) then
        local StarterGear = LocalPlayer:FindFirstChild("StarterGear");

        if StarterGear and StarterGear:FindFirstChild(p181.Name) then
            u51 = true;

            for i = (u45 or MakeSlot(u41)).Index, 1, -1 do
                local v182 = u44[i];
                local v183 = i - 1;

                if v183 > 0 then
                    u44[v183]:Swap(v182);
                else
                    v182:Fill(p181);
                end;
            end;

            for _, child in pairs(u43:GetChildren()) do
                if child:IsA("Tool") and child ~= p181 then
                    child.Parent = Backpack;
                end;
            end;

            AdjustHotbarFrames();

            return;
        end;
    end;

    local v184 = u46[p181];

    if v184 then
        v184:UpdateEquipView();
    else
        local v185;

        if p181:GetAttribute("type") == "Defense" then
            local Tool = u44[u58].Tool;

            if Tool then
                u44[u58]:Clear();
            end;

            for i = u58 - 1, 2, -1 do
                local Tool2 = u44[i].Tool;

                if Tool2 then
                    u44[i]:Clear();
                    u44[i + 1]:Fill(Tool2);
                end;
            end;

            v185 = u44[2];
            v185:Fill(p181);

            if Tool then
                local v186 = MakeSlot(u41);
                v186:Fill(Tool);
                local Frame = v186.Frame;
                local v187;

                if Tool then
                    local v188 = Tool:GetAttribute("type");
                    v187 = (u57 == "All" or v188 == u57) and true or v188 == "Bypass";
                else
                    v187 = false;
                end;

                Frame.Visible = v187;
            end;
        else
            local v189 = p181:GetAttribute("ForceSlot");

            if typeof(v189) == "number" and u44[v189] then
                if u44[v189].Tool then
                    local Tool = u44[u58].Tool;

                    if Tool then
                        u44[u58]:Clear();
                        local v190 = MakeSlot(u41);
                        v190:Fill(Tool);
                        local Frame = v190.Frame;
                        local v191;

                        if Tool then
                            local v192 = Tool:GetAttribute("type");
                            v191 = (u57 == "All" or v192 == u57) and true or v192 == "Bypass";
                        else
                            v191 = false;
                        end;

                        Frame.Visible = v191;
                    end;

                    for i = u58 - 1, v189, -1 do
                        local Tool2 = u44[i].Tool;

                        if Tool2 then
                            u44[i]:Clear();
                            u44[i + 1]:Fill(Tool2);
                        end;
                    end;
                end;

                v185 = u44[v189];
                v185:Fill(p181);
            else
                v185 = u45 or MakeSlot(u41);
                v185:Fill(p181);
            end;
        end;

        if u58 < v185.Index then
            local Frame = v185.Frame;
            local v193;

            if p181 then
                local v194 = p181:GetAttribute("type");
                v193 = (u57 == "All" or v194 == u57) and true or v194 == "Bypass";
            else
                v193 = false;
            end;

            Frame.Visible = v193;
        end;

        if v185.Index <= u58 and not u38.Visible then
            AdjustHotbarFrames();
        end;

        if p181:IsA("HopperBin") and p181.Active then
            if Humanoid then
                Humanoid:UnequipTools();

                if u50 then
                    u50:ToggleSelect();
                    u46[u50]:UpdateEquipView();
                    u50 = nil;
                end;
            end;

            u50 = p181;
        end;
    end;

    u2.BackpackItemAdded:Fire();
end;

local function OnChildRemoved(p195) -- Line: 1265
    -- upvalues: u43 (ref), Backpack (ref), u46 (copy), u58 (copy), u38 (ref), AdjustHotbarFrames (copy), u50 (ref), u2 (copy), u44 (copy)
    if not (p195:IsA("Tool") or p195:IsA("HopperBin")) then
        return;
    end;

    local Parent = p195.Parent;

    if Parent == u43 or Parent == Backpack then
        return;
    end;

    local v196 = u46[p195];

    if v196 then
        v196:Clear();

        if u58 < v196.Index then
            v196:Delete();
        elseif not u38.Visible then
            AdjustHotbarFrames();
        end;
    end;

    if p195 == u50 then
        u50 = nil;
    end;

    u2.BackpackItemRemoved:Fire();
    local v197 = true;

    for i = u58 + 1, #u44 do
        local v198 = u44[i];

        if v198 and v198.Tool then
            v197 = false;
            break;
        end;
    end;

    if v197 then
        u2.BackpackEmpty:Fire();
    end;
end;

local function OnCharacterAdded(p199) -- Line: 1299
    -- upvalues: u44 (copy), u58 (copy), u50 (ref), u55 (ref), u43 (ref), OnChildRemoved (copy), OnChildAdded (copy), Backpack (ref), LocalPlayer (ref), AdjustHotbarFrames (copy)
    for i = #u44, 1, -1 do
        local v200 = u44[i];

        if v200.Tool then
            v200:Clear();
        end;

        if u58 < i then
            v200:Delete();
        end;
    end;

    u50 = nil;

    for _, v in pairs(u55) do
        v:Disconnect();
    end;

    u55 = {};
    u43 = p199;
    table.insert(u55, p199.ChildRemoved:Connect(OnChildRemoved));
    table.insert(u55, p199.ChildAdded:Connect(OnChildAdded));

    for _, child in pairs(p199:GetChildren()) do
        OnChildAdded(child);
    end;

    Backpack = LocalPlayer:WaitForChild("Backpack");
    table.insert(u55, Backpack.ChildRemoved:Connect(OnChildRemoved));
    table.insert(u55, Backpack.ChildAdded:Connect(OnChildAdded));

    for _, child in pairs(Backpack:GetChildren()) do
        OnChildAdded(child);
    end;

    AdjustHotbarFrames();
end;

local function OnInputBegan(p201, p202) -- Line: 1338
    -- upvalues: TextChatService (copy), u53 (ref), u52 (ref), Value (copy), u47 (copy), u38 (ref), u31 (copy)
    if game.ReplicatedStorage:GetAttribute("DisableToolbar") then
        return;
    end;

    local v203 = TextChatService:FindFirstChildOfClass("ChatInputBarConfiguration");
    local v204 = p201.UserInputType == Enum.UserInputType.Keyboard and (not u53 and (not v203.IsFocused and (u52 or p201.KeyCode.Value == Value))) and u47[p201.KeyCode.Value];

    if v204 then
        v204(p202);
    end;

    local UserInputType = p201.UserInputType;

    if not p202 and (UserInputType == Enum.UserInputType.MouseButton1 or UserInputType == Enum.UserInputType.Touch) and u38.Visible then
        u31:deselect();
    end;
end;

local function OnUISChanged() -- Line: 1365
    -- upvalues: UserInputService (copy), u58 (copy), u44 (copy), u28 (copy), u29 (copy)
    if UserInputService:GetLastInputType() == Enum.UserInputType.Touch then
        for i = 1, u58 do
            u44[i]:TurnNumber(false);
        end;

        return;
    end;

    if UserInputService:GetLastInputType() == Enum.UserInputType.Keyboard then
        for i = 1, u58 do
            u44[i]:TurnNumber(true);
        end;

        return;
    end;

    for _, v in pairs(u28) do
        if UserInputService:GetLastInputType() == v then
            for i = 1, u58 do
                u44[i]:TurnNumber(true);
            end;

            return;
        end;
    end;

    for _, v in pairs(u29) do
        if UserInputService:GetLastInputType() == v then
            for i = 1, u58 do
                u44[i]:TurnNumber(false);
            end;

            return;
        end;
    end;
end;

local u205 = nil;
local u206 = nil;

local function u207() -- Line: 1406
end;

function unbindAllGamepadEquipActions()
    -- upvalues: ContextActionService (copy)
    ContextActionService:UnbindAction("BackpackHasGamepadFocus");
    ContextActionService:UnbindAction("BackpackCloseInventory");
end;

u42 = function(p208, p209, u210) -- Line: 1485
    -- upvalues: u205 (ref), u206 (ref), Humanoid (ref), u50 (ref), u46 (copy), u58 (copy), u44 (copy), u57 (ref), u60 (ref)
    if p209 ~= Enum.UserInputState.Begin then
        return;
    end;

    if u205 and (u205.KeyCode == Enum.KeyCode.ButtonR1 and u210.KeyCode == Enum.KeyCode.ButtonL1 or u205.KeyCode == Enum.KeyCode.ButtonL1 and u210.KeyCode == Enum.KeyCode.ButtonR1) and os.clock() - u206 <= 0.06 then
        if Humanoid then
            Humanoid:UnequipTools();

            if u50 then
                u50:ToggleSelect();
                u46[u50]:UpdateEquipView();
                u50 = nil;
            end;
        end;

        u205 = u210;
        u206 = os.clock();

        return;
    end;

    u205 = u210;
    u206 = os.clock();
    task.delay(0.06, function() -- Line: 1513
        -- upvalues: u205 (ref), u210 (copy), u58 (ref), u44 (ref), u57 (ref), Humanoid (ref), u50 (ref), u46 (ref), u60 (ref)
        if u205 ~= u210 then
            return;
        end;

        local v211 = u210.KeyCode == Enum.KeyCode.ButtonL1 and -1 or 1;

        for i = 1, u58 do
            if u44[i]:IsEquipped() then
                local v212 = v211 + i;
                local v213 = false;

                if u58 < v212 then
                    v212 = 1;
                    v213 = true;
                elseif v212 < 1 then
                    v212 = u58;
                    v213 = true;
                end;

                local v214 = v212;

                while true do
                    if u44[v212].Tool then
                        local Tool = u44[v212].Tool;
                        local v215;

                        if Tool then
                            local v216 = Tool:GetAttribute("type");
                            v215 = (u57 == "All" or v216 == u57) and true or v216 == "Bypass";
                        else
                            v215 = false;
                        end;

                        if v215 then
                            if not v213 then
                                u44[v212]:Select();

                                return;
                            end;

                            if Humanoid then
                                Humanoid:UnequipTools();

                                if u50 then
                                    u50:ToggleSelect();
                                    u46[u50]:UpdateEquipView();
                                    u50 = nil;
                                end;
                            end;

                            u60 = nil;

                            return;
                        end;
                    end;

                    v212 = v212 + v211;

                    if v212 == v214 then
                        return;
                    end;

                    if u58 < v212 then
                        v212 = 1;
                        v213 = true;
                    elseif v212 < 1 then
                        v212 = u58;
                        v213 = true;
                    end;
                end;
            end;
        end;

        if u60 and u60.Tool then
            local Tool = u60.Tool;
            local v217;

            if Tool then
                local v218 = Tool:GetAttribute("type");
                v217 = (u57 == "All" or v218 == u57) and true or v218 == "Bypass";
            else
                v217 = false;
            end;

            if v217 then
                u60:Select();

                return;
            end;
        end;

        for i = v211 == -1 and (u58 or 1) or 1, v211 == -1 and 1 or u58, v211 do
            if u44[i].Tool then
                local Tool = u44[i].Tool;
                local v219;

                if Tool then
                    local v220 = Tool:GetAttribute("type");
                    v219 = (u57 == "All" or v220 == u57) and true or v220 == "Bypass";
                else
                    v219 = false;
                end;

                if v219 then
                    u44[i]:Select();

                    return;
                end;
            end;
        end;
    end);
end;

function getGamepadSwapSlot()
    -- upvalues: u44 (copy)
    for i = 1, #u44 do
        if u44[i].Frame.BorderSizePixel > 0 then
            return u44[i];
        end;
    end;
end;

function changeSlot(u221)
    -- upvalues: VRService (copy), u38 (ref), GuiService (copy), u39 (ref), u58 (copy)
    if u221.Frame == GuiService.SelectedObject and (not VRService.VREnabled or u38.Visible) then
        local v222 = getGamepadSwapSlot();

        if not v222 then
            local Size = u221.Frame.Size;
            local Position = u221.Frame.Position;
            u221.Frame:TweenSizeAndPosition(Size + UDim2.fromOffset(10, 10), Position - UDim2.fromOffset(5, 5), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true, function() -- Line: 1626
                -- upvalues: u221 (copy), Size (copy), Position (copy)
                u221.Frame:TweenSizeAndPosition(Size, Position, Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.1, true);
            end);
            u221.Frame.BorderSizePixel = 3;
            u39.SelectionImageObject.Visible = true;

            return;
        end;

        v222.Frame.BorderSizePixel = 0;

        if v222 ~= u221 then
            u221:Swap(v222);
            u39.SelectionImageObject.Visible = false;

            if u58 < u221.Index and not u221.Tool then
                if GuiService.SelectedObject == u221.Frame then
                    GuiService.SelectedObject = v222.Frame;
                end;

                u221:Delete();
            end;

            if u58 < v222.Index and not v222.Tool then
                if GuiService.SelectedObject == v222.Frame then
                    GuiService.SelectedObject = u221.Frame;
                end;

                v222:Delete();
            end;
        end;
    else
        u221:Select();
        u39.SelectionImageObject.Visible = false;
    end;
end;

function vrMoveSlotToInventory()
    -- upvalues: VRService (copy), u39 (ref)
    if not VRService.VREnabled then
        return;
    end;

    local v223 = getGamepadSwapSlot();

    if v223 and v223.Tool then
        v223.Frame.BorderSizePixel = 0;
        v223:MoveToInventory();
        u39.SelectionImageObject.Visible = false;
    end;
end;

function enableGamepadInventoryControl()
    -- upvalues: u38 (ref), u31 (copy), ContextActionService (copy), u207 (copy), GuiService (copy), u37 (ref)
    local function v225() -- Line: 1660
        -- upvalues: u38 (ref), u31 (ref)
        if getGamepadSwapSlot() then
            local v224 = getGamepadSwapSlot();

            if v224 then
                v224.Frame.BorderSizePixel = 0;
            end;
        elseif u38.Visible then
            u31:deselect();
        end;
    end;

    ContextActionService:BindAction("BackpackHasGamepadFocus", u207, false, Enum.UserInputType.Gamepad1);
    ContextActionService:BindAction("BackpackCloseInventory", v225, false, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonStart);

    if true then
        GuiService.SelectedObject = u37:FindFirstChild("1");
    end;
end;

function disableGamepadInventoryControl()
    -- upvalues: u58 (copy), u44 (copy), GuiService (copy), u36 (ref)
    unbindAllGamepadEquipActions();

    for i = 1, u58 do
        local v226 = u44[i];

        if v226 and v226.Frame then
            v226.Frame.BorderSizePixel = 0;
        end;
    end;

    if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(u36) then
        GuiService.SelectedObject = nil;
    end;
end;

local function bindBackpackHotbarAction() -- Line: 1708
    -- upvalues: u52 (ref), u34 (ref), ContextActionService (copy), u42 (ref)
    if u52 and not u34 then
        u34 = true;
        ContextActionService:BindAction("BackpackHotbarEquip", u42, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
    end;
end;

local function unbindBackpackHotbarAction() -- Line: 1721
    -- upvalues: u34 (ref), ContextActionService (copy)
    disableGamepadInventoryControl();
    u34 = false;
    ContextActionService:UnbindAction("BackpackHotbarEquip");
end;

function gamepadDisconnected()
    -- upvalues: u56 (ref)
    u56 = false;
    disableGamepadInventoryControl();
end;

function gamepadConnected()
    -- upvalues: u56 (ref), GuiService (copy), u36 (ref), u49 (ref), u52 (ref), u34 (ref), ContextActionService (copy), u42 (ref), u38 (ref)
    u56 = true;
    GuiService:AddSelectionParent("BackpackSelection", u36);

    if u49 >= 1 and (u52 and not u34) then
        u34 = true;
        ContextActionService:BindAction("BackpackHotbarEquip", u42, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
    end;

    if u38.Visible then
        enableGamepadInventoryControl();
    end;
end;

local function OnIconChanged(u227) -- Line: 1745
    -- upvalues: StarterGui (copy), u52 (ref), u36 (ref), u49 (ref), u34 (ref), ContextActionService (copy), u42 (ref)
    pcall(function() -- Line: 1746
        -- upvalues: u227 (ref), StarterGui (ref), u52 (ref), u36 (ref), u49 (ref), u34 (ref), ContextActionService (ref), u42 (ref)
        local v228 = u227 and StarterGui:GetCore("TopbarEnabled");
        u227 = v228;
        u52 = u227;
        u36.Visible = u227;

        if u227 then
            if u49 >= 1 and (u52 and not u34) then
                u34 = true;
                ContextActionService:BindAction("BackpackHotbarEquip", u42, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
            end;
        else
            disableGamepadInventoryControl();
            u34 = false;
            ContextActionService:UnbindAction("BackpackHotbarEquip");
        end;
    end);
end;

local function MakeVRRoundButton(p229, p230) -- Line: 1771
    local ImageButton = Instance.new("ImageButton");
    ImageButton.BackgroundTransparency = 1;
    ImageButton.Name = p229;
    ImageButton.Size = UDim2.fromOffset(40, 40);
    ImageButton.Image = "rbxasset://textures/ui/Keyboard/close_button_background.png";
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Icon";
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Size = UDim2.fromScale(0.5, 0.5);
    ImageLabel.Position = UDim2.fromScale(0.25, 0.25);
    ImageLabel.Image = p230;
    ImageLabel.Parent = ImageButton;
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.BackgroundTransparency = 1;
    ImageLabel2.Name = "Selection";
    ImageLabel2.Size = UDim2.fromScale(0.9, 0.9);
    ImageLabel2.Position = UDim2.fromScale(0.05, 0.05);
    ImageLabel2.Image = "rbxasset://textures/ui/Keyboard/close_button_selection.png";
    ImageButton.SelectionImageObject = ImageLabel2;

    return ImageButton, ImageLabel, ImageLabel2;
end;

u36 = Instance.new("Frame");
u36.BackgroundTransparency = 1;
u36.Name = "Backpack";
u36.Size = UDim2.fromScale(1, 1);
u36.Visible = false;
u36.Parent = ScreenGui;
u37 = Instance.new("Frame");
u37.BackgroundTransparency = 1;
u37.Name = "Hotbar";
u37.Size = UDim2.fromScale(1, 1);
u37.Parent = u36;

for i = 1, u58 do
    local v231 = MakeSlot(u37, i);
    v231.Frame.Visible = false;

    if not u45 then
        u45 = v231;
    end;
end;

local ImageLabel = Instance.new("ImageLabel");
ImageLabel.BackgroundTransparency = 1;
ImageLabel.Name = "LeftBumper";
ImageLabel.Size = UDim2.fromOffset(40, 40);
ImageLabel.Position = UDim2.new(0, -ImageLabel.Size.X.Offset, 0.5, -ImageLabel.Size.Y.Offset / 2);
local ImageLabel2 = Instance.new("ImageLabel");
ImageLabel2.BackgroundTransparency = 1;
ImageLabel2.Name = "RightBumper";
ImageLabel2.Size = UDim2.fromOffset(40, 40);
ImageLabel2.Position = UDim2.new(1, 0, 0.5, -ImageLabel2.Size.Y.Offset / 2);
u38 = Instance.new("Frame");
u38.Name = "Inventory";
u38.Size = UDim2.fromScale(1, 1);
u38.BackgroundTransparency = u8;
u38.BackgroundColor3 = u10;
u38.Active = true;
u38.Visible = false;
u38.Parent = u36;
local UICorner = Instance.new("UICorner");
UICorner.Name = "Corner";
UICorner.CornerRadius = v9;
UICorner.Parent = u38;
u39 = Instance.new("TextButton");
u39.Name = "VRInventorySelector";
u39.Position = UDim2.new(0, 0, 0, 0);
u39.Size = UDim2.fromScale(1, 1);
u39.BackgroundTransparency = 1;
u39.Text = "";
u39.Parent = u38;
local ImageLabel3 = Instance.new("ImageLabel");
ImageLabel3.BackgroundTransparency = 1;
ImageLabel3.Name = "Selector";
ImageLabel3.Size = UDim2.fromScale(1, 1);
ImageLabel3.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png";
ImageLabel3.ScaleType = Enum.ScaleType.Slice;
ImageLabel3.SliceCenter = Rect.new(12, 12, 52, 52);
ImageLabel3.Visible = false;
u39.SelectionImageObject = ImageLabel3;
u39.MouseButton1Click:Connect(function() -- Line: 1868
    vrMoveSlotToInventory();
end);
u40 = Instance.new("ScrollingFrame");
u40.BackgroundTransparency = 1;
u40.Name = "ScrollingFrame";
u40.Size = UDim2.fromScale(1, 1);
u40.Selectable = false;
u40.ScrollingDirection = Enum.ScrollingDirection.Y;
u40.BorderSizePixel = 0;
u40.ScrollBarThickness = 8;
u40.ScrollBarImageColor3 = Color3.new(1, 1, 1);
u40.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar;
u40.CanvasSize = UDim2.new(0, 0, 0, 0);
u40.Parent = u38;
u41 = Instance.new("Frame");
u41.BackgroundTransparency = 1;
u41.Name = "UIGridFrame";
u41.Selectable = false;
u41.Size = UDim2.new(1, -10, 1, 0);
u41.Position = UDim2.fromOffset(5, 0);
u41.Parent = u40;
local UIGridLayout = Instance.new("UIGridLayout");
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder;
UIGridLayout.CellSize = UDim2.fromOffset(u33, u33);
UIGridLayout.CellPadding = UDim2.fromOffset(5, 5);
UIGridLayout.Parent = u41;
local u232 = MakeVRRoundButton("ScrollUpButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png");
u232.Size = UDim2.fromOffset(34, 34);
u232.Position = UDim2.new(0.5, -u232.Size.X.Offset / 2, 0, 43);
u232.Icon.Position = u232.Icon.Position - UDim2.fromOffset(0, 2);
u232.MouseButton1Click:Connect(function() -- Line: 1905
    -- upvalues: u40 (ref), u33 (ref)
    local new = Vector2.new;
    local X = u40.CanvasPosition.X;
    local v233 = u40.CanvasSize.Y.Offset - u40.AbsoluteWindowSize.Y;
    local v234 = math.max(0, u40.CanvasPosition.Y - (u33 + 5));
    u40.CanvasPosition = new(X, (math.min(v233, v234)));
end);
local u235 = MakeVRRoundButton("ScrollDownButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png");
u235.Rotation = 180;
u235.Icon.Position = u235.Icon.Position - UDim2.fromOffset(0, 2);
u235.Size = UDim2.fromOffset(34, 34);
u235.Position = UDim2.new(0.5, -u235.Size.X.Offset / 2, 1, -u235.Size.Y.Offset - 3);
u235.MouseButton1Click:Connect(function() -- Line: 1922
    -- upvalues: u40 (ref), u33 (ref)
    local new = Vector2.new;
    local X = u40.CanvasPosition.X;
    local v236 = u40.CanvasSize.Y.Offset - u40.AbsoluteWindowSize.Y;
    local v237 = math.max(0, u40.CanvasPosition.Y + (u33 + 5));
    u40.CanvasPosition = new(X, (math.min(v236, v237)));
end);
u40.Changed:Connect(function(p238) -- Line: 1933
    -- upvalues: u40 (ref), u232 (ref), u235 (ref)
    if p238 == "AbsoluteWindowSize" or (p238 == "CanvasPosition" or p238 == "CanvasSize") then
        local v239 = u40.CanvasPosition.Y < u40.CanvasSize.Y.Offset - u40.AbsoluteWindowSize.Y;
        u232.Visible = u40.CanvasPosition.Y ~= 0;
        u235.Visible = v239;
    end;
end);
UpdateBackpackLayout();
local Frame = Instance.new("Frame");
Frame.Name = "GamepadHintsFrame";
Frame.Size = UDim2.fromOffset(u37.Size.X.Offset, u32 and 95 or 60);
Frame.BackgroundTransparency = u8;
Frame.BackgroundColor3 = u10;
Frame.Visible = false;
Frame.Parent = u36;
local UIListLayout = Instance.new("UIListLayout");
UIListLayout.Name = "Layout";
UIListLayout.Padding = UDim.new(0, 25);
UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
UIListLayout.Parent = Frame;
local UICorner2 = Instance.new("UICorner");
UICorner2.Name = "Corner";
UICorner2.CornerRadius = v9;
UICorner2.Parent = Frame;

local function addGamepadHint(p240, p241) -- Line: 1969
    -- upvalues: Frame (copy), u32 (copy), u26 (copy)
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "HintFrame";
    Frame2.AutomaticSize = Enum.AutomaticSize.XY;
    Frame2.BackgroundTransparency = 1;
    Frame2.Parent = Frame;
    local UIListLayout2 = Instance.new("UIListLayout");
    UIListLayout2.Name = "Layout";
    UIListLayout2.Padding = u32 and UDim.new(0, 20) or UDim.new(0, 12);
    UIListLayout2.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout2.VerticalAlignment = Enum.VerticalAlignment.Center;
    UIListLayout2.Parent = Frame2;
    local ImageLabel4 = Instance.new("ImageLabel");
    ImageLabel4.Name = "HintImage";
    ImageLabel4.Size = u32 and UDim2.fromOffset(60, 60) or UDim2.fromOffset(30, 30);
    ImageLabel4.BackgroundTransparency = 1;
    ImageLabel4.Image = p240;
    ImageLabel4.Parent = Frame2;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "HintText";
    TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
    TextLabel.FontFace = Font.new(u26.Family, Enum.FontWeight.Medium, Enum.FontStyle.Normal);
    TextLabel.TextSize = u32 and 32 or 19;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = p241;
    TextLabel.TextColor3 = Color3.new(1, 1, 1);
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.TextYAlignment = Enum.TextYAlignment.Center;
    TextLabel.TextWrapped = true;
    TextLabel.Parent = Frame2;
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint.MaxTextSize = TextLabel.TextSize;
    UITextSizeConstraint.Parent = TextLabel;
end;

addGamepadHint(UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonX), "Remove From Hotbar");
addGamepadHint(UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonA), "Select/Swap");
addGamepadHint(UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonB), "Close Backpack");

local function resizeGamepadHintsFrame() -- Line: 2013
    -- upvalues: Frame (copy), u37 (ref), u32 (copy), u38 (ref)
    Frame.Size = UDim2.new(u37.Size.X.Scale, u37.Size.X.Offset, 0, u32 and 95 or 60);
    Frame.Position = UDim2.new(u37.Position.X.Scale, u37.Position.X.Offset, u38.Position.Y.Scale, u38.Position.Y.Offset - Frame.Size.Y.Offset - 5);
    local v242 = Frame:GetChildren();
    local v243 = {};
    local v244 = 0;

    for _, v in pairs(v242) do
        if v:IsA("GuiObject") then
            table.insert(v243, v);
        end;
    end;

    for i = 1, #v243 do
        if v243[i]:IsA("GuiObject") then
            v243[i].Size = UDim2.new(1, 0, 1, -5);
            v243[i].Position = UDim2.new(0, 0, 0, 0);
            v244 = v244 + (v243[i].HintText.Position.X.Offset + v243[i].HintText.TextBounds.X);
        end;
    end;

    local v245 = (Frame.AbsoluteSize.X - v244) / (#v243 - 1);

    for i = 1, #v243 do
        v243[i].Position = i == 1 and UDim2.new(0, 0, 0, 0) or UDim2.new(0, v243[i - 1].Position.X.Offset + v243[i - 1].Size.X.Offset + v245, 0, 0);
        v243[i].Size = UDim2.new(0, v243[i].HintText.Position.X.Offset + v243[i].HintText.TextBounds.X, 1, -5);
    end;
end;

local Frame2 = Instance.new("Frame");
Frame2.Name = "Search";
Frame2.BackgroundColor3 = v22;
Frame2.BackgroundTransparency = u23;
Frame2.Size = UDim2.new(0, 190, 0, 30);
Frame2.Position = UDim2.new(1, -Frame2.Size.X.Offset - 5, 0, 5);
Frame2.Parent = u38;
local UICorner3 = Instance.new("UICorner");
UICorner3.Name = "Corner";
UICorner3.CornerRadius = v25;
UICorner3.Parent = Frame2;
local UIStroke = Instance.new("UIStroke");
UIStroke.Name = "Border";
UIStroke.Color = v24;
UIStroke.Thickness = 1;
UIStroke.Transparency = 0.8;
UIStroke.Parent = Frame2;
UIStroke:SetAttribute("Block", true);
local TextBox = Instance.new("TextBox");
TextBox.BackgroundTransparency = 1;
TextBox.Name = "TextBox";
TextBox.Text = "";
TextBox.TextColor3 = u19;
TextBox.TextStrokeTransparency = u20;
TextBox.TextStrokeColor3 = u21;
TextBox.FontFace = Font.new(u26.Family, Enum.FontWeight.Medium, Enum.FontStyle.Normal);
TextBox.PlaceholderText = "Search";
TextBox.TextColor3 = u19;
TextBox.TextTransparency = u20;
TextBox.TextStrokeColor3 = u21;
TextBox.ClearTextOnFocus = false;
TextBox.TextTruncate = Enum.TextTruncate.AtEnd;
TextBox.TextSize = u27;
TextBox.TextXAlignment = Enum.TextXAlignment.Left;
TextBox.TextYAlignment = Enum.TextYAlignment.Center;
TextBox.Size = UDim2.new(0, 154, 0, 14);
TextBox.AnchorPoint = Vector2.new(0, 0.5);
TextBox.Position = UDim2.new(0, 8, 0.5, 0);
TextBox.ZIndex = 2;
TextBox.Parent = Frame2;
local TextButton = Instance.new("TextButton");
TextButton.Name = "X";
TextButton.Text = "";
TextButton.Size = UDim2.fromOffset(30, 30);
TextButton.Position = UDim2.new(1, -TextButton.Size.X.Offset, 0.5, -TextButton.Size.Y.Offset / 2);
TextButton.ZIndex = 4;
TextButton.Visible = false;
TextButton.BackgroundTransparency = 1;
TextButton.Parent = Frame2;
local ImageButton = Instance.new("ImageButton");
ImageButton.Name = "X";
ImageButton.Image = "rbxasset://textures/ui/InspectMenu/x.png";
ImageButton.BackgroundTransparency = 1;
ImageButton.Size = UDim2.new(0, Frame2.Size.Y.Offset - 20, 0, Frame2.Size.Y.Offset - 20);
ImageButton.AnchorPoint = Vector2.new(0.5, 0.5);
ImageButton.Position = UDim2.fromScale(0.5, 0.5);
ImageButton.ZIndex = 1;
ImageButton.BorderSizePixel = 0;
ImageButton.Parent = TextButton;

local function search() -- Line: 2151
    -- upvalues: TextBox (copy), u58 (copy), u44 (copy), u38 (ref), u54 (ref), u41 (ref), u40 (ref), u33 (ref), TextButton (copy)
    local v246 = {};

    for i in TextBox.Text:gmatch("%S+") do
        v246[i:lower()] = true;
    end;

    local v247 = {};

    for i = u58 + 1, #u44 do
        local v248 = u44[i];
        local v249 = { v248, (v248:CheckTerms(v246)) };
        table.insert(v247, v249);
        v248.Frame.Visible = false;
        v248.Frame.Parent = u38;
    end;

    table.sort(v247, function(p250, p251) -- Line: 2166
        return p250[2] > p251[2];
    end);
    u54 = true;
    local v252 = 0;

    for _, v in ipairs(v247) do
        local v253 = v[1];

        if v[2] > 0 then
            v253.Frame.Visible = true;
            v253.Frame.Parent = u41;
            v253.Frame.LayoutOrder = u58 + v252;
            v252 = v252 + 1;
        end;
    end;

    u40.CanvasPosition = Vector2.new(0, 0);
    local v254 = math.floor(u40.AbsoluteSize.X / (u33 + 5));
    local v255 = (#u41:GetChildren() - 1) / v254;
    local v256 = math.ceil(v255) * (u33 + 5) + 5;
    u40.CanvasSize = UDim2.fromOffset(0, v256);
    TextButton.ZIndex = 3;
end;

local function clearResults() -- Line: 2188
    -- upvalues: TextButton (copy), u54 (ref), u58 (copy), u44 (copy), u41 (ref), u40 (ref), u33 (ref)
    if TextButton.ZIndex > 0 then
        u54 = false;

        for i = u58 + 1, #u44 do
            local v257 = u44[i];

            if v257.Tool then
                local v258 = v257.Tool:GetAttribute("Order");

                if typeof(v258) == "number" then
                    v257.Frame.LayoutOrder = v258;
                else
                    v257.Frame.LayoutOrder = 9999 + v257.Index;
                end;

                v257.Frame.Visible = true;
            else
                v257.Frame.LayoutOrder = 9999 + v257.Index;
                v257.Frame.Visible = false;
            end;

            v257.Frame.Parent = u41;
        end;

        TextButton.ZIndex = 0;
    end;

    local v259 = math.floor(u40.AbsoluteSize.X / (u33 + 5));
    local v260 = (#u41:GetChildren() - 1) / v259;
    local v261 = math.ceil(v260) * (u33 + 5) + 5;
    u40.CanvasSize = UDim2.fromOffset(0, v261);
end;

TextButton.MouseButton1Click:Connect(function() -- Line: 2214, Name: reset
    -- upvalues: clearResults (copy), TextBox (copy)
    clearResults();
    TextBox.Text = "";
end);
TextBox.Changed:Connect(function(p262) -- Line: 2219, Name: onChanged
    -- upvalues: TextBox (copy), u20 (copy), clearResults (copy), search (copy), TextButton (copy)
    if p262 == "Text" then
        local Text = TextBox.Text;

        if Text == "" then
            TextBox.TextTransparency = u20;
            clearResults();
        elseif Text ~= "" then
            TextBox.TextTransparency = 0;
            search();
        end;

        local v263;

        if Text == "" then
            v263 = false;
        else
            v263 = Text ~= "";
        end;

        TextButton.Visible = v263;
    end;
end);
TextBox.FocusLost:Connect(function(p264) -- Line: 2233, Name: focusLost
    -- upvalues: search (copy)
    if p264 then
        search();
    end;
end);
u2.StateChanged.Event:Connect(function(p265) -- Line: 2244
    -- upvalues: clearResults (copy), TextBox (copy)
    if not p265 then
        clearResults();
        TextBox.Text = "";
    end;
end);

u47[Enum.KeyCode.Escape.Value] = function(p266) -- Line: 2252
    -- upvalues: clearResults (copy), TextBox (copy)
    if p266 then
        clearResults();
        TextBox.Text = "";
    end;
end;

UserInputService.LastInputTypeChanged:Connect(function(p267) -- Line: 2257, Name: detectGamepad
    -- upvalues: UserInputService (copy), Frame2 (copy)
    if p267 == Enum.UserInputType.Gamepad1 and not UserInputService.VREnabled then
        Frame2.Visible = false;

        return;
    end;

    Frame2.Visible = true;
end);
GuiService.MenuOpened:Connect(function() -- Line: 2268
    -- upvalues: ScreenGui (copy), u31 (copy)
    ScreenGui.Enabled = false;
    u31:setEnabled(false);
end);
GuiService.MenuClosed:Connect(function() -- Line: 2274
    -- upvalues: ScreenGui (copy), u31 (copy)
    ScreenGui.Enabled = true;
    u31:setEnabled(true);
end);

local function u271(p268, p269, p270) -- Line: 2281
    -- upvalues: GuiService (copy), u58 (copy), u44 (copy)
    if p269 ~= Enum.UserInputState.Begin then
        return;
    end;

    if not GuiService.SelectedObject then
        return;
    end;

    for i = 1, u58 do
        if u44[i].Frame == GuiService.SelectedObject and u44[i].Tool then
            u44[i]:MoveToInventory();

            return;
        end;
    end;
end;

local function openClose() -- Line: 2297
    -- upvalues: u48 (copy), u38 (ref), AdjustHotbarFrames (copy), u37 (ref), u58 (copy), u44 (copy), u56 (ref), u29 (copy), UserInputService (copy), resizeGamepadHintsFrame (copy), Frame (copy), ContextActionService (copy), u271 (copy), u2 (copy)
    if not next(u48) then
        u38.Visible = not u38.Visible;
        local Visible = u38.Visible;
        AdjustHotbarFrames();
        u37.Active = not u37.Active;

        for i = 1, u58 do
            u44[i]:SetClickability(not Visible);
        end;
    end;

    if u38.Visible then
        if u56 then
            if u29[UserInputService:GetLastInputType()] then
                resizeGamepadHintsFrame();
                Frame.Visible = not UserInputService.VREnabled;
            end;

            enableGamepadInventoryControl();
        end;
    else
        if u56 then
            Frame.Visible = false;
        end;

        disableGamepadInventoryControl();
    end;

    if u38.Visible then
        ContextActionService:BindAction("BackpackRemoveSlot", u271, false, Enum.KeyCode.ButtonX);
    else
        ContextActionService:UnbindAction("BackpackRemoveSlot");
    end;

    u2.IsOpen = u38.Visible;
    u2.StateChanged:Fire(u38.Visible);
end;

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
u2.OpenClose = openClose;

while not LocalPlayer do
    task.wait();
    LocalPlayer = Players.LocalPlayer;
end;

LocalPlayer.CharacterAdded:Connect(OnCharacterAdded);

if LocalPlayer.Character then
    OnCharacterAdded(LocalPlayer.Character);
end;

UserInputService.InputBegan:Connect(OnInputBegan);
UserInputService.TextBoxFocused:Connect(function() -- Line: 2360
    -- upvalues: u53 (ref)
    u53 = true;
end);
UserInputService.TextBoxFocusReleased:Connect(function() -- Line: 2363
    -- upvalues: u53 (ref)
    u53 = false;
end);

u47[Value] = function() -- Line: 2368
    -- upvalues: u50 (ref), Humanoid (ref), u46 (copy)
    if u50 and Humanoid then
        Humanoid:UnequipTools();

        if u50 then
            u50:ToggleSelect();
            u46[u50]:UpdateEquipView();
            u50 = nil;
        end;
    end;
end;

UserInputService.LastInputTypeChanged:Connect(OnUISChanged);
OnUISChanged();

if UserInputService:GetGamepadConnected(Enum.UserInputType.Gamepad1) then
    gamepadConnected();
end;

UserInputService.GamepadConnected:Connect(function(p272) -- Line: 2382
    if p272 == Enum.UserInputType.Gamepad1 then
        gamepadConnected();
    end;
end);
UserInputService.GamepadDisconnected:Connect(function(p273) -- Line: 2387
    if p273 == Enum.UserInputType.Gamepad1 then
        gamepadDisconnected();
    end;
end);

function u2.SetBackpackEnabled(p274, p275) -- Line: 2395
    -- upvalues: u30 (ref)
    u30 = p275;
end;

function u2.IsOpened(p276) -- Line: 2400
    -- upvalues: u2 (copy)
    return u2.IsOpen;
end;

function u2.GetBackpackEnabled(p277) -- Line: 2405
    -- upvalues: u30 (ref)
    return u30;
end;

function u2.GetStateChangedEvent(p278) -- Line: 2410
    -- upvalues: u2 (copy)
    return u2.StateChanged;
end;

RunService.Heartbeat:Connect(function() -- Line: 2415
    -- upvalues: u30 (ref), StarterGui (copy), u52 (ref), u36 (ref), u49 (ref), u34 (ref), ContextActionService (copy), u42 (ref)
    local u279 = u30;
    pcall(function() -- Line: 1746
        -- upvalues: u279 (ref), StarterGui (ref), u52 (ref), u36 (ref), u49 (ref), u34 (ref), ContextActionService (ref), u42 (ref)
        local v280 = u279 and StarterGui:GetCore("TopbarEnabled");
        u279 = v280;
        u52 = u279;
        u36.Visible = u279;

        if u279 then
            if u49 >= 1 and (u52 and not u34) then
                u34 = true;
                ContextActionService:BindAction("BackpackHotbarEquip", u42, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
            end;
        else
            disableGamepadInventoryControl();
            u34 = false;
            ContextActionService:UnbindAction("BackpackHotbarEquip");
        end;
    end);
end);

local function OnPreferredTransparencyChanged() -- Line: 2420
    -- upvalues: GuiService (copy), u8 (ref), u7 (copy), u38 (ref), u13 (ref), u12 (copy), u44 (copy), u23 (ref), Frame2 (copy)
    local PreferredTransparency = GuiService.PreferredTransparency;
    u8 = u7 * PreferredTransparency;
    u38.BackgroundTransparency = u8;
    u13 = u12 * PreferredTransparency;

    for _, v in ipairs(u44) do
        v.Frame.BackgroundTransparency = u13;
    end;

    u23 = PreferredTransparency * 0.2;
    Frame2.BackgroundTransparency = u23;
end;

GuiService:GetPropertyChangedSignal("PreferredTransparency"):Connect(OnPreferredTransparencyChanged);

return u2;