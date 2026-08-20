--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CameraInput
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.CameraInput
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:10 2026
]]

-- Decompiled with Potassium's decompiler.

local ContextActionService = game:GetService("ContextActionService");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
game:GetService("RunService");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local VRService = game:GetService("VRService");
local GuiService = game:GetService("GuiService");
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local FlagUtil = require(CommonUtils:WaitForChild("FlagUtil"));
local u1 = FlagUtil.getUserFlag("UserPSSinkUnknownTouchEvents");
local v2 = FlagUtil.getUserFlag("UserPSTextboxResetCameraInput");
local v3 = FlagUtil.getUserFlag("UserFixVRCameraGamepadReset");
local LocalPlayer = Players.LocalPlayer;
local Value = Enum.ContextActionPriority.Medium.Value;
local u4 = Vector2.new(1, 0.77) * 0.06981317007977318 * 60;
local u5 = Vector2.new(1, 0.77) * 0.008726646259971648;
local u6 = Vector2.new(1, 0.77) * 0.12217304763960307;
local u7 = Vector2.new(1, 0.66) * 0.017453292519943295;
local BindableEvent = Instance.new("BindableEvent");
local BindableEvent2 = Instance.new("BindableEvent");
local Event = BindableEvent.Event;
local Event2 = BindableEvent2.Event;
UserInputService.InputBegan:Connect(function(p8, p9) -- Line: 45
    -- upvalues: BindableEvent (copy)
    if not p9 and p8.UserInputType == Enum.UserInputType.MouseButton2 then
        BindableEvent:Fire();
    end;
end);
UserInputService.InputEnded:Connect(function(p10, p11) -- Line: 51
    -- upvalues: BindableEvent2 (copy)
    if p10.UserInputType == Enum.UserInputType.MouseButton2 then
        BindableEvent2:Fire();
    end;
end);

local function thumbstickCurve(p12) -- Line: 62
    local v13 = (math.abs(p12) - 0.1) / 0.9 * 2;
    local v14 = (math.exp(v13) - 1) / 6.38905609893065;

    return math.sign(p12) * math.clamp(v14, 0, 1);
end;

local function adjustTouchPitchSensitivity(p15) -- Line: 76
    local CurrentCamera = workspace.CurrentCamera;

    if not CurrentCamera then
        return p15;
    end;

    local v16 = CurrentCamera.CFrame:ToEulerAnglesYXZ();

    if p15.Y * v16 >= 0 then
        return p15;
    end;

    local v17 = (1 - (math.abs(v16) * 2 / 3.141592653589793) ^ 0.75) * 0.75 + 0.25;

    return Vector2.new(1, v17) * p15;
end;

local function isInDynamicThumbstickArea(p18) -- Line: 102
    -- upvalues: LocalPlayer (copy)
    local v19 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if v19 then
        v19 = v19:FindFirstChild("TouchGui");
    end;

    local v20;

    if v19 then
        v20 = v19:FindFirstChild("TouchControlFrame");
    else
        v20 = v19;
    end;

    if v20 then
        v20 = v20:FindFirstChild("DynamicThumbstickFrame");
    end;

    if not v20 then
        return false;
    end;

    if not v19.Enabled then
        return false;
    end;

    local AbsolutePosition = v20.AbsolutePosition;
    local v21 = AbsolutePosition + v20.AbsoluteSize;
    local v22;

    if p18.X >= AbsolutePosition.X and (p18.Y >= AbsolutePosition.Y and p18.X <= v21.X) then
        v22 = p18.Y <= v21.Y;
    else
        v22 = false;
    end;

    return v22;
end;

local v23 = {};
local u24 = {};
local u25 = 0;

local function incPanInputCount() -- Line: 132
    -- upvalues: u25 (ref)
    u25 = math.max(0, u25 + 1);
end;

local function decPanInputCount() -- Line: 136
    -- upvalues: u25 (ref)
    u25 = math.max(0, u25 - 1);
end;

local function resetPanInputCount() -- Line: 140
    -- upvalues: u25 (ref)
    u25 = 0;
end;

local u26 = {
    Thumbstick2 = Vector2.new()
};
local u27 = {
    Left = 0,
    Right = 0,
    I = 0,
    O = 0
};
local u28 = {
    Wheel = 0,
    Pinch = 0,
    Movement = Vector2.new(),
    Pan = Vector2.new()
};
local u29 = {
    Pinch = 0,
    Move = Vector2.new()
};
local BindableEvent3 = Instance.new("BindableEvent");
v23.gamepadZoomPress = BindableEvent3.Event;
local u30;

if v3 then
    u30 = Instance.new("BindableEvent");
    v23.gamepadReset = u30.Event;
else
    u30 = VRService.VREnabled and Instance.new("BindableEvent") or nil;

    if VRService.VREnabled then
        v23.gamepadReset = u30.Event;
    end;
end;

function v23.getRotationActivated() -- Line: 179
    -- upvalues: u25 (ref), u26 (copy)
    return u25 > 0 and true or u26.Thumbstick2.Magnitude > 0;
end;

function v23.getRotation(p31, p32) -- Line: 183
    -- upvalues: UserGameSettings (copy), u27 (copy), u26 (copy), u28 (copy), adjustTouchPitchSensitivity (copy), u29 (copy), u4 (copy), u5 (copy), u6 (copy), u7 (copy)
    local v33 = Vector2.new(1, UserGameSettings:GetCameraYInvertValue());
    local v34 = Vector2.new(u27.Right - u27.Left, 0) * p31;
    local v35 = u26.Thumbstick2 * UserGameSettings.GamepadCameraSensitivity * p31;
    local Movement = u28.Movement;
    local Pan = u28.Pan;
    local v36 = adjustTouchPitchSensitivity(u29.Move);

    if p32 then
        v34 = Vector2.new();
    end;

    return (v34 * 2.0943951023931953 + v35 * u4 + Movement * u5 + Pan * u6 + v36 * u7) * v33;
end;

function v23.getZoomDelta() -- Line: 208
    -- upvalues: u27 (copy), u28 (copy), u29 (copy)
    return (u27.O - u27.I) * 0.1 + (-u28.Wheel + u28.Pinch) * 1 + -u29.Pinch * 0.04;
end;

local function thumbstick(p37, p38, p39) -- Line: 216
    -- upvalues: u26 (copy), thumbstickCurve (ref)
    local Position = p39.Position;
    u26[p39.KeyCode.Name] = Vector2.new(thumbstickCurve(Position.X), -thumbstickCurve(Position.Y));

    return Enum.ContextActionResult.Pass;
end;

local function mouseMovement(p40) -- Line: 222
    -- upvalues: u28 (copy)
    local Delta = p40.Delta;
    u28.Movement = Vector2.new(Delta.X, Delta.Y);
end;

local function mouseWheel(p41, p42, p43) -- Line: 227
    -- upvalues: u28 (copy)
    u28.Wheel = p43.Position.Z;

    return Enum.ContextActionResult.Pass;
end;

local function keypress(p44, p45, p46) -- Line: 232
    -- upvalues: u27 (copy)
    u27[p46.KeyCode.Name] = p45 == Enum.UserInputState.Begin and 1 or 0;
end;

local function gamepadZoomPress(p47, p48, p49) -- Line: 236
    -- upvalues: BindableEvent3 (copy)
    if p48 == Enum.UserInputState.Begin then
        BindableEvent3:Fire();
    end;
end;

local function gamepadReset(p50, p51, p52) -- Line: 242
    -- upvalues: u30 (ref)
    if p51 == Enum.UserInputState.Begin then
        u30:Fire();
    end;
end;

local function resetInputDevices() -- Line: 248
    -- upvalues: u26 (copy), u27 (copy), u28 (copy), u29 (copy), u25 (ref)
    for _, v in pairs({
        u26,
        u27,
        u28,
        u29
    }) do
        for i, v4 in pairs(v) do
            if type(v4) == "boolean" then
                v[i] = false;
            else
                v[i] = v[i] * 0;
            end;
        end;
    end;

    u25 = 0;
end;

local u53 = {};
local u54 = nil;
local u55 = nil;

local function touchBegan(p56, p57) -- Line: 274
    -- upvalues: u54 (ref), isInDynamicThumbstickArea (copy), u25 (ref), u53 (ref)
    assert(p56.UserInputType == Enum.UserInputType.Touch);
    assert(p56.UserInputState == Enum.UserInputState.Begin);

    if u54 == nil and (isInDynamicThumbstickArea(p56.Position) and not p57) then
        u54 = p56;

        return;
    end;

    if not p57 then
        u25 = math.max(0, u25 + 1);
    end;

    u53[p56] = p57;
end;

local function touchEnded(p58, p59) -- Line: 294
    -- upvalues: u54 (ref), u53 (ref), u55 (ref), u25 (ref)
    assert(p58.UserInputType == Enum.UserInputType.Touch);
    assert(p58.UserInputState == Enum.UserInputState.End);

    if p58 == u54 then
        u54 = nil;
    end;

    if u53[p58] == false then
        u55 = nil;
        u25 = math.max(0, u25 - 1);
    end;

    u53[p58] = nil;
end;

local function touchChanged(p60, p61) -- Line: 313
    -- upvalues: u54 (ref), u53 (ref), u1 (copy), u29 (copy), u55 (ref)
    assert(p60.UserInputType == Enum.UserInputType.Touch);
    assert(p60.UserInputState == Enum.UserInputState.Change);

    if p60 == u54 then
        return;
    end;

    if u53[p60] == nil then
        if u1 then
            u53[p60] = true;
        else
            u53[p60] = p61;
        end;
    end;

    local v62 = {};

    for i, v in pairs(u53) do
        if not v then
            table.insert(v62, i);
        end;
    end;

    if #v62 == 1 and u53[p60] == false then
        local Delta = p60.Delta;
        local v63 = u29;
        v63.Move = v63.Move + Vector2.new(Delta.X, Delta.Y);
    end;

    if #v62 ~= 2 then
        u55 = nil;

        return;
    end;

    local Magnitude = (v62[1].Position - v62[2].Position).Magnitude;

    if u55 then
        local v64 = u29;
        v64.Pinch = v64.Pinch + (Magnitude - u55);
    end;

    u55 = Magnitude;
end;

local function resetTouchState() -- Line: 361
    -- upvalues: u53 (ref), u54 (ref), u55 (ref), u25 (ref)
    u53 = {};
    u54 = nil;
    u55 = nil;
    u25 = 0;
end;

local function pointerAction(p65, p66, p67, p68) -- Line: 369
    -- upvalues: u28 (copy)
    if not p68 then
        u28.Wheel = p65;
        u28.Pan = p66;
        u28.Pinch = -p67;
    end;
end;

local function inputBegan(p69, p70) -- Line: 377
    -- upvalues: touchBegan (ref), u25 (ref)
    if p69.UserInputType == Enum.UserInputType.Touch then
        touchBegan(p69, p70);

        return;
    end;

    if p69.UserInputType == Enum.UserInputType.MouseButton2 and not p70 then
        u25 = math.max(0, u25 + 1);
    end;
end;

local function inputChanged(p71, p72) -- Line: 386
    -- upvalues: touchChanged (ref), u28 (copy)
    if p71.UserInputType == Enum.UserInputType.Touch then
        touchChanged(p71, p72);

        return;
    end;

    if p71.UserInputType == Enum.UserInputType.MouseMovement then
        local Delta = p71.Delta;
        u28.Movement = Vector2.new(Delta.X, Delta.Y);
    end;
end;

local function inputEnded(p73, p74) -- Line: 395
    -- upvalues: touchEnded (ref), u25 (ref)
    if p73.UserInputType == Enum.UserInputType.Touch then
        touchEnded(p73, p74);

        return;
    end;

    if p73.UserInputType == Enum.UserInputType.MouseButton2 then
        u25 = math.max(0, u25 - 1);
    end;
end;

local u75 = false;

function v23.setInputEnabled(p76) -- Line: 406
    -- upvalues: u75 (ref), resetInputDevices (copy), resetTouchState (ref), ContextActionService (copy), thumbstick (copy), Value (copy), keypress (copy), VRService (copy), gamepadReset (copy), gamepadZoomPress (copy), u24 (ref), UserInputService (copy), inputBegan (copy), inputChanged (copy), inputEnded (copy), pointerAction (copy), GuiService (copy)
    if u75 == p76 then
        return;
    end;

    u75 = p76;
    resetInputDevices();
    resetTouchState();

    if not u75 then
        ContextActionService:UnbindAction("RbxCameraThumbstick");
        ContextActionService:UnbindAction("RbxCameraMouseMove");
        ContextActionService:UnbindAction("RbxCameraMouseWheel");
        ContextActionService:UnbindAction("RbxCameraKeypress");
        ContextActionService:UnbindAction("RbxCameraGamepadZoom");

        if VRService.VREnabled then
            ContextActionService:UnbindAction("RbxCameraGamepadReset");
        end;

        for _, v in pairs(u24) do
            v:Disconnect();
        end;

        u24 = {};

        return;
    end;

    ContextActionService:BindActionAtPriority("RbxCameraThumbstick", thumbstick, false, Value, Enum.KeyCode.Thumbstick2);
    ContextActionService:BindActionAtPriority("RbxCameraKeypress", keypress, false, Value, Enum.KeyCode.Left, Enum.KeyCode.Right, Enum.KeyCode.I, Enum.KeyCode.O);

    if VRService.VREnabled then
        ContextActionService:BindAction("RbxCameraGamepadReset", gamepadReset, false, Enum.KeyCode.ButtonL3);
    end;

    ContextActionService:BindAction("RbxCameraGamepadZoom", gamepadZoomPress, false, Enum.KeyCode.ButtonR3);
    table.insert(u24, UserInputService.InputBegan:Connect(inputBegan));
    table.insert(u24, UserInputService.InputChanged:Connect(inputChanged));
    table.insert(u24, UserInputService.InputEnded:Connect(inputEnded));
    table.insert(u24, UserInputService.PointerAction:Connect(pointerAction));
    table.insert(u24, GuiService.MenuOpened:connect(resetTouchState));
end;

function v23.getInputEnabled() -- Line: 475
    -- upvalues: u75 (ref)
    return u75;
end;

function v23.resetInputForFrameEnd() -- Line: 479
    -- upvalues: u28 (copy), u29 (copy)
    u28.Movement = Vector2.new();
    u29.Move = Vector2.new();
    u29.Pinch = 0;
    u28.Wheel = 0;
    u28.Pan = Vector2.new();
    u28.Pinch = 0;
end;

UserInputService.WindowFocused:Connect(resetInputDevices);
UserInputService.WindowFocusReleased:Connect(resetInputDevices);

if v2 then
    UserInputService.TextBoxFocusReleased:Connect(resetInputDevices);
end;

local u77 = false;
local u78 = false;
local u79 = 0;

function v23.getHoldPan() -- Line: 503
    -- upvalues: u77 (ref)
    return u77;
end;

function v23.getTogglePan() -- Line: 507
    -- upvalues: u78 (ref)
    return u78;
end;

function v23.getPanning() -- Line: 511
    -- upvalues: u78 (ref), u77 (ref)
    return u78 or u77;
end;

function v23.setTogglePan(p80) -- Line: 515
    -- upvalues: u78 (ref)
    u78 = p80;
end;

local u81 = false;
local u82 = nil;
local u83 = nil;

function v23.enableCameraToggleInput() -- Line: 523
    -- upvalues: u81 (ref), u77 (ref), u78 (ref), u82 (ref), u83 (ref), Event (ref), u79 (ref), Event2 (ref), UserInputService (copy)
    if u81 then
        return;
    end;

    u81 = true;
    u77 = false;
    u78 = false;

    if u82 then
        u82:Disconnect();
    end;

    if u83 then
        u83:Disconnect();
    end;

    u82 = Event:Connect(function() -- Line: 540
        -- upvalues: u77 (ref), u79 (ref)
        u77 = true;
        u79 = tick();
    end);
    u83 = Event2:Connect(function() -- Line: 545
        -- upvalues: u77 (ref), u79 (ref), u78 (ref), UserInputService (ref)
        u77 = false;

        if tick() - u79 < 0.3 and (u78 or UserInputService:GetMouseDelta().Magnitude < 2) then
            u78 = not u78;
        end;
    end);
end;

function v23.disableCameraToggleInput() -- Line: 553
    -- upvalues: u81 (ref), u82 (ref), u83 (ref)
    if not u81 then
        return;
    end;

    u81 = false;

    if u82 then
        u82:Disconnect();
        u82 = nil;
    end;

    if u83 then
        u83:Disconnect();
        u83 = nil;
    end;
end;

return v23;