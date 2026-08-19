--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     MouseLockController
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.MouseLockController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:30 2026
]]

-- Decompiled with Potassium's decompiler.

local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local FlagUtil = require(CommonUtils:WaitForChild("FlagUtil"));
local Value = Enum.ContextActionPriority.Medium.Value;
local Players = game:GetService("Players");
local ContextActionService = game:GetService("ContextActionService");
local UserInputService = game:GetService("UserInputService");
local GameSettings = UserSettings().GameSettings;
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"));
local u1 = FlagUtil.getUserFlag("UserFixStuckShiftLock");
local u2 = {};
u2.__index = u2;

function u2.new() -- Line: 33
    -- upvalues: u2 (copy), GameSettings (copy), Players (copy), UserInputService (copy)
    local u3 = setmetatable({}, u2);
    u3.isMouseLocked = false;
    u3.savedMouseCursor = nil;
    u3.boundKeys = { Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift };
    u3.mouseLockToggledEvent = Instance.new("BindableEvent");
    local BoundKeys = script:FindFirstChild("BoundKeys");

    if not (BoundKeys and BoundKeys:IsA("StringValue")) then
        if BoundKeys then
            BoundKeys:Destroy();
        end;

        BoundKeys = Instance.new("StringValue");
        assert(BoundKeys, "");
        BoundKeys.Name = "BoundKeys";
        BoundKeys.Value = "LeftShift,RightShift";
        BoundKeys.Parent = script;
    end;

    if BoundKeys then
        BoundKeys.Changed:Connect(function(p4) -- Line: 58
            -- upvalues: u3 (copy)
            u3:OnBoundKeysObjectChanged(p4);
        end);
        u3:OnBoundKeysObjectChanged(BoundKeys.Value);
    end;

    GameSettings.Changed:Connect(function(p5) -- Line: 65
        -- upvalues: u3 (copy)
        if p5 == "ControlMode" or p5 == "ComputerMovementMode" then
            u3:UpdateMouseLockAvailability();
        end;
    end);
    Players.LocalPlayer:GetPropertyChangedSignal("DevEnableMouseLock"):Connect(function() -- Line: 72
        -- upvalues: u3 (copy)
        u3:UpdateMouseLockAvailability();
    end);
    Players.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function() -- Line: 77
        -- upvalues: u3 (copy)
        u3:UpdateMouseLockAvailability();
    end);
    UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function() -- Line: 81
        -- upvalues: u3 (copy)
        u3:UpdateMouseLockAvailability();
    end);
    u3:UpdateMouseLockAvailability();

    return u3;
end;

function u2.GetIsMouseLocked(p6) -- Line: 90
    return p6.isMouseLocked;
end;

function u2.GetBindableToggleEvent(p7) -- Line: 94
    return p7.mouseLockToggledEvent.Event;
end;

function u2.GetMouseLockOffset(p8) -- Line: 98
    return Vector3.new(1.75, 0, 0);
end;

function u2.UpdateMouseLockAvailability(p9) -- Line: 102
    -- upvalues: Players (copy), GameSettings (copy), UserInputService (copy)
    local v10 = UserInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse and (Players.LocalPlayer.DevEnableMouseLock and (GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove)) and not (Players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable);

    if v10 ~= p9.enabled then
        p9:EnableMouseLock(v10);
    end;
end;

function u2.OnBoundKeysObjectChanged(p11, p12) -- Line: 115
    p11.boundKeys = {};

    for i in string.gmatch(p12, "[^%s,]+") do
        for _, v in pairs(Enum.KeyCode:GetEnumItems()) do
            if i == v.Name then
                p11.boundKeys[#p11.boundKeys + 1] = v;
                break;
            end;
        end;
    end;

    p11:UnbindContextActions();
    p11:BindContextActions();
end;

function u2.OnMouseLockToggled(p13) -- Line: 130
    -- upvalues: CameraUtils (copy)
    p13.isMouseLocked = not p13.isMouseLocked;

    if p13.isMouseLocked then
        local CursorImage = script:FindFirstChild("CursorImage");

        if CursorImage and (CursorImage:IsA("StringValue") and CursorImage.Value) then
            CameraUtils.setMouseIconOverride(CursorImage.Value);
        else
            if CursorImage then
                CursorImage:Destroy();
            end;

            local StringValue = Instance.new("StringValue");
            assert(StringValue, "");
            StringValue.Name = "CursorImage";
            StringValue.Value = "rbxasset://textures/MouseLockedCursor.png";
            StringValue.Parent = script;
            CameraUtils.setMouseIconOverride("rbxasset://textures/MouseLockedCursor.png");
        end;
    else
        CameraUtils.restoreMouseIcon();
    end;

    p13.mouseLockToggledEvent:Fire();
end;

function u2.DoMouseLockSwitch(p14, p15, p16, p17) -- Line: 155
    if p16 ~= Enum.UserInputState.Begin then
        return Enum.ContextActionResult.Pass;
    end;

    p14:OnMouseLockToggled();

    return Enum.ContextActionResult.Sink;
end;

function u2.BindContextActions(u18) -- Line: 163
    -- upvalues: ContextActionService (copy), Value (copy)
    ContextActionService:BindActionAtPriority("MouseLockSwitchAction", function(p19, p20, p21) -- Line: 164
        -- upvalues: u18 (copy)
        return u18:DoMouseLockSwitch(p19, p20, p21);
    end, false, Value, unpack(u18.boundKeys));
end;

function u2.UnbindContextActions(p22) -- Line: 169
    -- upvalues: ContextActionService (copy)
    ContextActionService:UnbindAction("MouseLockSwitchAction");
end;

function u2.IsMouseLocked(p23) -- Line: 173
    return p23.enabled and p23.isMouseLocked;
end;

function u2.EnableMouseLock(p24, p25) -- Line: 177
    -- upvalues: CameraUtils (copy), u1 (copy)
    if p25 ~= p24.enabled then
        p24.enabled = p25;

        if p24.enabled then
            p24:BindContextActions();

            return;
        end;

        CameraUtils.restoreMouseIcon();
        p24:UnbindContextActions();

        if u1 then
            if p24.isMouseLocked then
                p24.isMouseLocked = false;
                p24.mouseLockToggledEvent:Fire();
            end;
        else
            if p24.isMouseLocked then
                p24.mouseLockToggledEvent:Fire();
            end;

            p24.isMouseLocked = false;
        end;
    end;
end;

return u2;