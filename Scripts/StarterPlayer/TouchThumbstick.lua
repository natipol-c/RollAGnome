--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     TouchThumbstick
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule.TouchThumbstick
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:41 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local GuiService = game:GetService("GuiService");
local UserInputService = game:GetService("UserInputService");
UserSettings():GetService("UserGameSettings");
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local u1 = require(CommonUtils:WaitForChild("FlagUtil")).getUserFlag("UserAllowAbilityControls");
local u2;

if u1 then
    u2 = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"));
else
    u2 = nil;
end;

local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"));
local u3 = setmetatable({}, BaseCharacterController);
u3.__index = u3;

function u3.new() -- Line: 29
    -- upvalues: BaseCharacterController (copy), u3 (copy)
    local v4 = BaseCharacterController.new();
    local v5 = setmetatable(v4, u3);
    v5.isFollowStick = false;
    v5.thumbstickFrame = nil;
    v5.moveTouchObject = nil;
    v5.onTouchMovedConn = nil;
    v5.onTouchEndedConn = nil;
    v5.screenPos = nil;
    v5.stickImage = nil;
    v5.thumbstickSize = nil;

    return v5;
end;

function u3.Enable(p6, p7, p8) -- Line: 44
    if p7 == nil then
        return false;
    end;

    local v9 = p7 and true or false;

    if p6.enabled == v9 then
        return true;
    end;

    p6.moveVector = Vector3.new(0, 0, 0);
    p6.isJumping = false;

    if v9 then
        if not p6.thumbstickFrame then
            p6:Create(p8);
        end;

        p6.thumbstickFrame.Visible = true;
    else
        p6.thumbstickFrame.Visible = false;
        p6:OnInputEnded();
    end;

    p6.enabled = v9;
end;

function u3.OnInputEnded(p10) -- Line: 65
    p10.thumbstickFrame.Position = p10.screenPos;
    p10.stickImage.Position = UDim2.new(0, p10.thumbstickFrame.Size.X.Offset / 2 - p10.thumbstickSize / 4, 0, p10.thumbstickFrame.Size.Y.Offset / 2 - p10.thumbstickSize / 4);
    p10.moveVector = Vector3.new(0, 0, 0);
    p10.isJumping = false;
    p10.thumbstickFrame.Position = p10.screenPos;
    p10.moveTouchObject = nil;
end;

function u3.Create(u11, u12) -- Line: 74
    -- upvalues: u1 (copy), u2 (ref), UserInputService (copy), GuiService (copy)
    if u11.thumbstickFrame then
        u11.thumbstickFrame:Destroy();
        u11.thumbstickFrame = nil;

        if u11.onTouchMovedConn then
            u11.onTouchMovedConn:Disconnect();
            u11.onTouchMovedConn = nil;
        end;

        if u11.onTouchEndedConn then
            u11.onTouchEndedConn:Disconnect();
            u11.onTouchEndedConn = nil;
        end;

        if u11.absoluteSizeChangedConn then
            u11.absoluteSizeChangedConn:Disconnect();
            u11.absoluteSizeChangedConn = nil;
        end;

        if u1 and u11.avatarAbilitiesEnabledChangedConn then
            u11.avatarAbilitiesEnabledChangedConn:Disconnect();
            u11.avatarAbilitiesEnabledChangedConn = nil;
        end;
    end;

    u11.thumbstickFrame = Instance.new("Frame");
    u11.thumbstickFrame.Name = "ThumbstickFrame";
    u11.thumbstickFrame.Active = true;
    u11.thumbstickFrame.Visible = false;
    u11.thumbstickFrame.BackgroundTransparency = 1;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "OuterImage";
    ImageLabel.Image = "rbxasset://textures/ui/TouchControlsSheet.png";
    ImageLabel.ImageRectOffset = Vector2.new();
    ImageLabel.ImageRectSize = Vector2.new(220, 220);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Position = UDim2.new(0, 0, 0, 0);
    u11.stickImage = Instance.new("ImageLabel");
    u11.stickImage.Name = "StickImage";
    u11.stickImage.Image = "rbxasset://textures/ui/TouchControlsSheet.png";
    u11.stickImage.ImageRectOffset = Vector2.new(220, 0);
    u11.stickImage.ImageRectSize = Vector2.new(111, 111);
    u11.stickImage.BackgroundTransparency = 1;
    u11.stickImage.ZIndex = 2;

    local function ResizeThumbstick() -- Line: 120
        -- upvalues: u12 (copy), u1 (ref), u2 (ref), u11 (copy), ImageLabel (copy)
        local v13 = math.min(u12.AbsoluteSize.X, u12.AbsoluteSize.Y) <= 500;

        if u1 and u2.isEnabled() then
            u11.thumbstickSize = v13 and 72 or 120;
            u11.screenPos = UDim2.new(0, v13 and 64 or 100, 1, -u11.thumbstickSize - (v13 and 64 or 112));
        else
            u11.thumbstickSize = v13 and 70 or 120;
            u11.screenPos = v13 and UDim2.new(0, u11.thumbstickSize / 2 - 10, 1, -u11.thumbstickSize - 20) or UDim2.new(0, u11.thumbstickSize / 2, 1, -u11.thumbstickSize * 1.75);
        end;

        u11.thumbstickFrame.Size = UDim2.new(0, u11.thumbstickSize, 0, u11.thumbstickSize);
        u11.thumbstickFrame.Position = u11.screenPos;
        ImageLabel.Size = UDim2.new(0, u11.thumbstickSize, 0, u11.thumbstickSize);
        u11.stickImage.Size = UDim2.new(0, u11.thumbstickSize / 2, 0, u11.thumbstickSize / 2);
        u11.stickImage.Position = UDim2.new(0, u11.thumbstickSize / 2 - u11.thumbstickSize / 4, 0, u11.thumbstickSize / 2 - u11.thumbstickSize / 4);
    end;

    ResizeThumbstick();
    u11.absoluteSizeChangedConn = u12:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeThumbstick);

    if u1 then
        u11.avatarAbilitiesEnabledChangedConn = u2.GetEnabledChangedSignal():Connect(ResizeThumbstick);
    end;

    ImageLabel.Parent = u11.thumbstickFrame;
    u11.stickImage.Parent = u11.thumbstickFrame;
    local u14 = nil;

    local function DoMove(p15) -- Line: 154
        -- upvalues: u11 (copy)
        local v16 = p15 / (u11.thumbstickSize / 2);
        local magnitude = v16.magnitude;
        local v17;

        if magnitude < 0.05 then
            v17 = Vector3.new();
        else
            local v18 = v16.unit * math.min(1, (magnitude - 0.05) / 0.95);
            v17 = Vector3.new(v18.X, 0, v18.Y);
        end;

        u11.moveVector = v17;
    end;

    local function MoveStick(p19) -- Line: 172
        -- upvalues: u14 (ref), u11 (copy)
        local v20 = Vector2.new(p19.X - u14.X, p19.Y - u14.Y);
        local magnitude = v20.magnitude;
        local v21 = u11.thumbstickFrame.AbsoluteSize.X / 2;

        if u11.isFollowStick and v21 < magnitude then
            local v22 = v20.unit * v21;
            u11.thumbstickFrame.Position = UDim2.new(0, p19.X - u11.thumbstickFrame.AbsoluteSize.X / 2 - v22.X, 0, p19.Y - u11.thumbstickFrame.AbsoluteSize.Y / 2 - v22.Y);
        else
            local v23 = math.min(magnitude, v21);
            v20 = v20.unit * v23;
        end;

        u11.stickImage.Position = UDim2.new(0, v20.X + u11.stickImage.AbsoluteSize.X / 2, 0, v20.Y + u11.stickImage.AbsoluteSize.Y / 2);
    end;

    u11.thumbstickFrame.InputBegan:Connect(function(p24) -- Line: 189
        -- upvalues: u11 (copy), u14 (ref)
        if u11.moveTouchObject or (p24.UserInputType ~= Enum.UserInputType.Touch or p24.UserInputState ~= Enum.UserInputState.Begin) then
            return;
        end;

        u11.moveTouchObject = p24;
        u11.thumbstickFrame.Position = UDim2.new(0, p24.Position.X - u11.thumbstickFrame.Size.X.Offset / 2, 0, p24.Position.Y - u11.thumbstickFrame.Size.Y.Offset / 2);
        u14 = Vector2.new(u11.thumbstickFrame.AbsolutePosition.X + u11.thumbstickFrame.AbsoluteSize.X / 2, u11.thumbstickFrame.AbsolutePosition.Y + u11.thumbstickFrame.AbsoluteSize.Y / 2);
        Vector2.new(p24.Position.X - u14.X, p24.Position.Y - u14.Y);
    end);
    u11.onTouchMovedConn = UserInputService.TouchMoved:Connect(function(p25, p26) -- Line: 204
        -- upvalues: u11 (copy), u14 (ref), MoveStick (copy)
        if p25 == u11.moveTouchObject then
            u14 = Vector2.new(u11.thumbstickFrame.AbsolutePosition.X + u11.thumbstickFrame.AbsoluteSize.X / 2, u11.thumbstickFrame.AbsolutePosition.Y + u11.thumbstickFrame.AbsoluteSize.Y / 2);
            local v27 = Vector2.new(p25.Position.X - u14.X, p25.Position.Y - u14.Y) / (u11.thumbstickSize / 2);
            local magnitude = v27.magnitude;
            local v28;

            if magnitude < 0.05 then
                v28 = Vector3.new();
            else
                local v29 = v27.unit * math.min(1, (magnitude - 0.05) / 0.95);
                v28 = Vector3.new(v29.X, 0, v29.Y);
            end;

            u11.moveVector = v28;
            MoveStick(p25.Position);
        end;
    end);
    u11.onTouchEndedConn = UserInputService.TouchEnded:Connect(function(p30, p31) -- Line: 214
        -- upvalues: u11 (copy)
        if p30 == u11.moveTouchObject then
            u11:OnInputEnded();
        end;
    end);
    GuiService.MenuOpened:Connect(function() -- Line: 220
        -- upvalues: u11 (copy)
        if u11.moveTouchObject then
            u11:OnInputEnded();
        end;
    end);
    u11.thumbstickFrame.Parent = u12;
end;

return u3;