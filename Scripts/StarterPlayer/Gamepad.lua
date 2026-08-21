--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Gamepad
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule.Gamepad
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:41 2026
]]

-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local ContextActionService = game:GetService("ContextActionService");
script.Parent.Parent:WaitForChild("CommonUtils");
local None = Enum.UserInputType.None;
local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"));
local u1 = setmetatable({}, BaseCharacterController);
u1.__index = u1;

function u1.new(p2) -- Line: 23
    -- upvalues: BaseCharacterController (copy), u1 (copy), None (copy)
    local v3 = BaseCharacterController.new();
    local v4 = setmetatable(v3, u1);
    v4.CONTROL_ACTION_PRIORITY = p2;
    v4.forwardValue = 0;
    v4.backwardValue = 0;
    v4.leftValue = 0;
    v4.rightValue = 0;
    v4.activeGamepad = None;
    v4.gamepadConnectedConn = nil;
    v4.gamepadDisconnectedConn = nil;

    return v4;
end;

function u1.Enable(p5, p6) -- Line: 39
    -- upvalues: None (copy)
    if p6 == p5.enabled then
        return true;
    end;

    p5.forwardValue = 0;
    p5.backwardValue = 0;
    p5.leftValue = 0;
    p5.rightValue = 0;
    p5.moveVector = Vector3.new(0, 0, 0);
    p5.isJumping = false;

    if p6 then
        p5.activeGamepad = p5:GetHighestPriorityGamepad();

        if p5.activeGamepad == None then
            return false;
        end;

        p5:BindContextActions();
        p5:ConnectGamepadConnectionListeners();
    else
        p5:UnbindContextActions();
        p5:DisconnectGamepadConnectionListeners();
        p5.activeGamepad = None;
    end;

    p5.enabled = p6;

    return true;
end;

function u1.GetHighestPriorityGamepad(p7) -- Line: 75
    -- upvalues: UserInputService (copy), None (copy)
    local v8 = UserInputService:GetConnectedGamepads();
    local v9 = None;

    for _, v in pairs(v8) do
        if v.Value < v9.Value then
            v9 = v;
        end;
    end;

    return v9;
end;

function u1.BindContextActions(u10) -- Line: 86
    -- upvalues: None (copy), ContextActionService (copy)
    if u10.activeGamepad == None then
        return false;
    end;

    ContextActionService:BindActivate(u10.activeGamepad, Enum.KeyCode.ButtonR2);
    ContextActionService:BindActionAtPriority("jumpAction", function(p11, p12, p13) -- Line: 93
        -- upvalues: u10 (copy)
        u10.isJumping = p12 == Enum.UserInputState.Begin;

        return Enum.ContextActionResult.Sink;
    end, false, u10.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonA);
    ContextActionService:BindActionAtPriority("moveThumbstick", function(p14, p15, p16) -- Line: 98
        -- upvalues: u10 (copy)
        if p15 == Enum.UserInputState.Cancel then
            u10.moveVector = Vector3.new(0, 0, 0);

            return Enum.ContextActionResult.Sink;
        end;

        if u10.activeGamepad ~= p16.UserInputType then
            return Enum.ContextActionResult.Pass;
        end;

        if p16.KeyCode == Enum.KeyCode.Thumbstick1 then
            if p16.Position.magnitude > 0.2 then
                u10.moveVector = Vector3.new(p16.Position.X, 0, -p16.Position.Y);
            else
                u10.moveVector = Vector3.new(0, 0, 0);
            end;

            return Enum.ContextActionResult.Sink;
        end;
    end, false, u10.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Thumbstick1);

    return true;
end;

function u1.UnbindContextActions(p17) -- Line: 127
    -- upvalues: None (copy), ContextActionService (copy)
    if p17.activeGamepad ~= None then
        ContextActionService:UnbindActivate(p17.activeGamepad, Enum.KeyCode.ButtonR2);
    end;

    ContextActionService:UnbindAction("moveThumbstick");
    ContextActionService:UnbindAction("jumpAction");
end;

function u1.OnNewGamepadConnected(p18) -- Line: 135
    -- upvalues: None (copy)
    local v19 = p18:GetHighestPriorityGamepad();

    if v19 == p18.activeGamepad then
        return;
    end;

    if v19 == None then
        warn("Gamepad:OnNewGamepadConnected found no connected gamepads");
        p18:UnbindContextActions();

        return;
    end;

    if p18.activeGamepad ~= None then
        p18:UnbindContextActions();
    end;

    p18.activeGamepad = v19;
    p18:BindContextActions();
end;

function u1.OnCurrentGamepadDisconnected(p20) -- Line: 162
    -- upvalues: None (copy), ContextActionService (copy)
    if p20.activeGamepad ~= None then
        ContextActionService:UnbindActivate(p20.activeGamepad, Enum.KeyCode.ButtonR2);
    end;

    local v21 = p20:GetHighestPriorityGamepad();

    if p20.activeGamepad == None or v21 ~= p20.activeGamepad then
        if v21 == None then
            p20:UnbindContextActions();
            p20.activeGamepad = None;

            return;
        end;

        p20.activeGamepad = v21;
        ContextActionService:BindActivate(p20.activeGamepad, Enum.KeyCode.ButtonR2);

        return;
    end;

    warn("Gamepad:OnCurrentGamepadDisconnected found the supposedly disconnected gamepad in connectedGamepads.");
    p20:UnbindContextActions();
    p20.activeGamepad = None;
end;

function u1.ConnectGamepadConnectionListeners(u22) -- Line: 187
    -- upvalues: UserInputService (copy)
    u22.gamepadConnectedConn = UserInputService.GamepadConnected:Connect(function(p23) -- Line: 188
        -- upvalues: u22 (copy)
        u22:OnNewGamepadConnected();
    end);
    u22.gamepadDisconnectedConn = UserInputService.GamepadDisconnected:Connect(function(p24) -- Line: 192
        -- upvalues: u22 (copy)
        if u22.activeGamepad == p24 then
            u22:OnCurrentGamepadDisconnected();
        end;
    end);
end;

function u1.DisconnectGamepadConnectionListeners(p25) -- Line: 200
    if p25.gamepadConnectedConn then
        p25.gamepadConnectedConn:Disconnect();
        p25.gamepadConnectedConn = nil;
    end;

    if p25.gamepadDisconnectedConn then
        p25.gamepadDisconnectedConn:Disconnect();
        p25.gamepadDisconnectedConn = nil;
    end;
end;

return u1;