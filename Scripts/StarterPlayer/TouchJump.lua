--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     TouchJump
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule.TouchJump
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:30 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local GuiService = game:GetService("GuiService");
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local ConnectionUtil = require(CommonUtils:WaitForChild("ConnectionUtil"));
local CharacterUtil = require(CommonUtils:WaitForChild("CharacterUtil"));
local u1 = require(CommonUtils:WaitForChild("FlagUtil")).getUserFlag("UserAllowAbilityControls");
local u2;

if u1 then
    u2 = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"));
else
    u2 = nil;
end;

local u3 = { "rbxasset://textures/ui/Input/JumpButtonRegular.png", "rbxasset://textures/ui/Input/JumpButtonPressed.png" };
local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"));
local u4 = setmetatable({}, BaseCharacterController);
u4.__index = u4;

function u4.new() -- Line: 61
    -- upvalues: BaseCharacterController (copy), u4 (copy), ConnectionUtil (copy)
    local v5 = BaseCharacterController.new();
    local v6 = setmetatable(v5, u4);
    v6.parentUIFrame = nil;
    v6.jumpButton = nil;
    v6.externallyEnabled = false;
    v6.isJumping = false;
    v6._active = false;
    v6._connectionUtil = ConnectionUtil.new();

    return v6;
end;

function u4._reset(p7) -- Line: 75
    -- upvalues: u1 (copy), u2 (ref), u3 (copy)
    p7.isJumping = false;
    p7.touchObject = nil;

    if p7.jumpButton then
        if u1 and u2.isEnabled() then
            p7.jumpButton.Image = u3[1];

            return;
        end;

        p7.jumpButton.ImageRectOffset = Vector2.new(1, 146);
    end;
end;

function u4.EnableButton(u8, p9) -- Line: 90
    -- upvalues: GuiService (copy)
    if p9 == u8._active then
        return;
    end;

    if p9 then
        if not u8.jumpButton then
            u8:Create();
        end;

        u8.jumpButton.Visible = true;
        u8._connectionUtil:trackConnection("JUMP_INPUT_ENDED", u8.jumpButton.InputEnded:Connect(function(p10) -- Line: 105
            -- upvalues: u8 (copy)
            if p10 == u8.touchObject then
                u8:_reset();
            end;
        end));
        u8._connectionUtil:trackConnection("MENU_OPENED", GuiService.MenuOpened:Connect(function() -- Line: 115
            -- upvalues: u8 (copy)
            if u8.touchObject then
                u8:_reset();
            end;
        end));
    else
        if u8.jumpButton then
            u8.jumpButton.Visible = false;
        end;

        u8._connectionUtil:disconnect("JUMP_INPUT_ENDED");
        u8._connectionUtil:disconnect("MENU_OPENED");
    end;

    u8:_reset();
    u8._active = p9;
end;

function u4.UpdateEnabled(p11) -- Line: 132
    -- upvalues: CharacterUtil (copy)
    local v12 = CharacterUtil.getChild("Humanoid", "Humanoid");

    if v12 and p11.externallyEnabled and (v12.UseJumpPower and v12.JumpPower > 0 or not v12.UseJumpPower and v12.JumpHeight > 0) and v12:GetStateEnabled(Enum.HumanoidStateType.Jumping) then
        p11:EnableButton(true);

        return;
    end;

    p11:EnableButton(false);
end;

function u4._setupConfigurations(u13) -- Line: 141
    -- upvalues: CharacterUtil (copy)
    local function update() -- Line: 142
        -- upvalues: u13 (copy)
        u13:UpdateEnabled();
    end;

    local v17 = CharacterUtil.onChild("Humanoid", "Humanoid", function(p14) -- Line: 147
        -- upvalues: u13 (copy), update (copy)
        u13:UpdateEnabled();
        u13:_reset();
        u13._connectionUtil:trackConnection("HUMANOID_JUMP_POWER", p14:GetPropertyChangedSignal("JumpPower"):Connect(update));
        u13._connectionUtil:trackConnection("HUMANOID_JUMP_HEIGHT", p14:GetPropertyChangedSignal("JumpHeight"):Connect(update));
        u13._connectionUtil:trackConnection("HUMANOID_STATE_ENABLED_CHANGED", p14.StateEnabledChanged:Connect(function(p15, p16) -- Line: 160
            -- upvalues: u13 (ref)
            if p15 == Enum.HumanoidStateType.Jumping and p16 ~= u13._active then
                u13:UpdateEnabled();
            end;
        end));
    end);
    u13._connectionUtil:trackConnection("HUMANOID", v17);
end;

function u4.Enable(p18, p19, p20) -- Line: 172
    if p20 then
        p18.parentUIFrame = p20;
    end;

    if p18.externallyEnabled == p19 then
        return;
    end;

    p18.externallyEnabled = p19;
    p18:UpdateEnabled();

    if p19 then
        p18:_setupConfigurations();

        return;
    end;

    p18._connectionUtil:disconnectAll();
end;

function u4.Create(u21) -- Line: 189
    -- upvalues: u1 (copy), u2 (ref), u3 (copy)
    if not u21.parentUIFrame then
        return;
    end;

    if u21.jumpButton then
        u21.jumpButton:Destroy();
        u21.jumpButton = nil;
    end;

    if u21.absoluteSizeChangedConn then
        u21.absoluteSizeChangedConn:Disconnect();
        u21.absoluteSizeChangedConn = nil;
    end;

    if u1 and u21.avatarAbilitiesEnabledChangedConn then
        u21.avatarAbilitiesEnabledChangedConn:Disconnect();
        u21.avatarAbilitiesEnabledChangedConn = nil;
    end;

    u21.jumpButton = Instance.new("ImageButton");
    u21.jumpButton.Name = "JumpButton";
    u21.jumpButton.Visible = false;
    u21.jumpButton.BackgroundTransparency = 1;

    if u1 and u2.isEnabled() then
        u21.jumpButton.Image = u3[1];
    else
        u21.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
        u21.jumpButton.ImageRectOffset = Vector2.new(1, 146);
        u21.jumpButton.ImageRectSize = Vector2.new(144, 144);
    end;

    local function ResizeJumpButton() -- Line: 224
        -- upvalues: u21 (copy), u1 (ref), u2 (ref), u3 (ref)
        local v22 = math.min(u21.parentUIFrame.AbsoluteSize.x, u21.parentUIFrame.AbsoluteSize.y) <= 500;

        if not (u1 and u2.isEnabled()) then
            local v23 = v22 and 70 or 120;

            if u1 then
                u21.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
                u21.jumpButton.ImageRectOffset = Vector2.new(1, 146);
                u21.jumpButton.ImageRectSize = Vector2.new(144, 144);
            end;

            u21.jumpButton.Size = UDim2.new(0, v23, 0, v23);
            u21.jumpButton.Position = v22 and UDim2.new(1, -(v23 * 1.5 - 10), 1, -v23 - 20) or UDim2.new(1, -(v23 * 1.5 - 10), 1, -v23 * 1.75);

            return;
        end;

        local v24 = v22 and 72 or 120;
        u21.jumpButton.Image = u3[1];
        u21.jumpButton.ImageRectOffset = Vector2.new(0, 0);
        u21.jumpButton.ImageRectSize = Vector2.new(0, 0);
        u21.jumpButton.Size = UDim2.new(0, v24, 0, v24);
        u21.jumpButton.Position = UDim2.new(1, -v24 - (v22 and 64 or 100), 1, -v24 - (v22 and 64 or 112));
    end;

    ResizeJumpButton();
    u21.absoluteSizeChangedConn = u21.parentUIFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeJumpButton);

    if u1 then
        u21.avatarAbilitiesEnabledChangedConn = u2.GetEnabledChangedSignal():Connect(ResizeJumpButton);
    end;

    u21.touchObject = nil;
    u21.jumpButton.InputBegan:connect(function(p25) -- Line: 262
        -- upvalues: u21 (copy), u1 (ref), u2 (ref), u3 (ref)
        if u21.touchObject or (p25.UserInputType ~= Enum.UserInputType.Touch or p25.UserInputState ~= Enum.UserInputState.Begin) then
            return;
        end;

        u21.touchObject = p25;

        if u1 and u2.isEnabled() then
            u21.jumpButton.Image = u3[2];
        else
            u21.jumpButton.ImageRectOffset = Vector2.new(146, 146);
        end;

        u21.isJumping = true;
    end);
    u21.jumpButton.Parent = u21.parentUIFrame;
end;

return u4;