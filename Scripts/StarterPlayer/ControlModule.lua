--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ControlModule
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:30 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local Workspace = game:GetService("Workspace");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local VRService = game:GetService("VRService");
script.Parent:WaitForChild("CommonUtils");
local Keyboard = require(script:WaitForChild("Keyboard"));
local Gamepad = require(script:WaitForChild("Gamepad"));
local DynamicThumbstick = require(script:WaitForChild("DynamicThumbstick"));
local success, result = pcall(function() -- Line: 41
    return UserSettings():IsUserFeatureEnabled("UserDynamicThumbstickSafeAreaUpdate");
end);
local u2 = success and result;
local TouchThumbstick = require(script:WaitForChild("TouchThumbstick"));
local ClickToMoveController = require(script:WaitForChild("ClickToMoveController"));
local TouchJump = require(script:WaitForChild("TouchJump"));
local VehicleController = require(script:WaitForChild("VehicleController"));
local success2, result2 = pcall(function() -- Line: 58
    return UserSettings():IsUserFeatureEnabled("UserPlayerScriptsSupportMicroGamepad");
end);
local u3 = success2 and result2;
local Value = Enum.ContextActionPriority.Medium.Value;
local u4 = {
    [Enum.TouchMovementMode.DPad] = DynamicThumbstick,
    [Enum.DevTouchMovementMode.DPad] = DynamicThumbstick,
    [Enum.TouchMovementMode.Thumbpad] = DynamicThumbstick,
    [Enum.DevTouchMovementMode.Thumbpad] = DynamicThumbstick,
    [Enum.TouchMovementMode.Thumbstick] = TouchThumbstick,
    [Enum.DevTouchMovementMode.Thumbstick] = TouchThumbstick,
    [Enum.TouchMovementMode.DynamicThumbstick] = DynamicThumbstick,
    [Enum.DevTouchMovementMode.DynamicThumbstick] = DynamicThumbstick,
    [Enum.TouchMovementMode.ClickToMove] = ClickToMoveController,
    [Enum.DevTouchMovementMode.ClickToMove] = ClickToMoveController,
    [Enum.TouchMovementMode.Default] = DynamicThumbstick,
    [Enum.ComputerMovementMode.Default] = Keyboard,
    [Enum.ComputerMovementMode.KeyboardMouse] = Keyboard,
    [Enum.DevComputerMovementMode.KeyboardMouse] = Keyboard,
    [Enum.DevComputerMovementMode.Scriptable] = nil,
    [Enum.ComputerMovementMode.ClickToMove] = ClickToMoveController,
    [Enum.DevComputerMovementMode.ClickToMove] = ClickToMoveController
};

function u1.new() -- Line: 92
    -- upvalues: u1 (copy), Players (copy), VehicleController (copy), Value (copy), RunService (copy), UserGameSettings (copy), GuiService (copy), UserInputService (copy)
    local u5 = setmetatable({}, u1);
    u5.controllers = {};
    u5.activeControlModule = nil;
    u5.activeController = nil;
    u5.touchJumpController = nil;
    u5.moveFunction = Players.LocalPlayer.Move;
    u5.humanoid = nil;
    u5.controlsEnabled = true;
    u5.humanoidSeatedConn = nil;
    u5.vehicleController = nil;
    u5.touchControlFrame = nil;
    u5.currentTorsoAngle = 0;
    u5.inputMoveVector = Vector3.new(0, 0, 0);
    u5.vehicleController = VehicleController.new(Value);
    Players.LocalPlayer.CharacterAdded:Connect(function(p6) -- Line: 117
        -- upvalues: u5 (copy)
        u5:OnCharacterAdded(p6);
    end);
    Players.LocalPlayer.CharacterRemoving:Connect(function(p7) -- Line: 118
        -- upvalues: u5 (copy)
        u5:OnCharacterRemoving(p7);
    end);

    if Players.LocalPlayer.Character then
        u5:OnCharacterAdded(Players.LocalPlayer.Character);
    end;

    RunService:BindToRenderStep("ControlScriptRenderstep", Enum.RenderPriority.Input.Value, function(p8) -- Line: 123
        -- upvalues: u5 (copy)
        u5:OnRenderStepped(p8);
    end);
    UserGameSettings:GetPropertyChangedSignal("TouchMovementMode"):Connect(function() -- Line: 127
        -- upvalues: u5 (copy)
        u5:UpdateMovementMode();
    end);
    Players.LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(function() -- Line: 130
        -- upvalues: u5 (copy)
        u5:UpdateMovementMode();
    end);
    UserGameSettings:GetPropertyChangedSignal("ComputerMovementMode"):Connect(function() -- Line: 134
        -- upvalues: u5 (copy)
        u5:UpdateMovementMode();
    end);
    Players.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function() -- Line: 137
        -- upvalues: u5 (copy)
        u5:UpdateMovementMode();
    end);
    u5.playerGui = nil;
    u5.touchGui = nil;
    u5.playerGuiAddedConn = nil;
    GuiService:GetPropertyChangedSignal("TouchControlsEnabled"):Connect(function() -- Line: 146
        -- upvalues: u5 (copy)
        u5:UpdateMovementMode();
        u5:UpdateActiveControlModuleEnabled();
    end);
    UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function() -- Line: 151
        -- upvalues: u5 (copy)
        u5:UpdateMovementMode();
    end);
    u5.playerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if not u5.playerGui then
        u5.playerGuiAddedConn = Players.LocalPlayer.ChildAdded:Connect(function(p9) -- Line: 157
            -- upvalues: u5 (copy)
            if p9:IsA("PlayerGui") then
                u5.playerGui = p9;
                u5.playerGuiAddedConn:Disconnect();
                u5.playerGuiAddedConn = nil;
                u5:UpdateMovementMode();
            end;
        end);
    end;

    u5:UpdateMovementMode();

    return u5;
end;

function u1.GetMoveVector(p10) -- Line: 175
    return not p10.activeController and Vector3.new(0, 0, 0) or p10.activeController:GetMoveVector();
end;

local function NormalizeAngle(p11) -- Line: 182
    local v12 = (p11 + 12.566370614359172) % 6.283185307179586;

    if v12 > 3.141592653589793 then
        v12 = v12 - 6.283185307179586;
    end;

    return v12;
end;

local function AverageAngle(p13, p14) -- Line: 190
    local v15 = (p14 - p13 + 12.566370614359172) % 6.283185307179586;

    if v15 > 3.141592653589793 then
        v15 = v15 - 6.283185307179586;
    end;

    local v16 = (p13 + v15 / 2 + 12.566370614359172) % 6.283185307179586;

    if v16 > 3.141592653589793 then
        v16 = v16 - 6.283185307179586;
    end;

    return v16;
end;

function u1.GetEstimatedVRTorsoFrame(p17) -- Line: 195
    -- upvalues: VRService (copy)
    local v18 = VRService:GetUserCFrame(Enum.UserCFrame.Head);
    local _, v19, _ = v18:ToEulerAnglesYXZ();
    local v20 = -v19;

    if VRService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) and VRService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand) then
        local v21 = VRService:GetUserCFrame(Enum.UserCFrame.LeftHand);
        local v22 = VRService:GetUserCFrame(Enum.UserCFrame.RightHand);
        local v23 = v18.Position - v21.Position;
        local v24 = v18.Position - v22.Position;
        local v25 = -math.atan2(v23.X, v23.Z);
        local v26 = (-math.atan2(v24.X, v24.Z) - v25 + 12.566370614359172) % 6.283185307179586;

        if v26 > 3.141592653589793 then
            v26 = v26 - 6.283185307179586;
        end;

        local v27 = (v25 + v26 / 2 + 12.566370614359172) % 6.283185307179586;

        if v27 > 3.141592653589793 then
            v27 = v27 - 6.283185307179586;
        end;

        local v28 = (v20 - p17.currentTorsoAngle + 12.566370614359172) % 6.283185307179586;

        if v28 > 3.141592653589793 then
            v28 = v28 - 6.283185307179586;
        end;

        local v29 = (v27 - p17.currentTorsoAngle + 12.566370614359172) % 6.283185307179586;

        if v29 > 3.141592653589793 then
            v29 = v29 - 6.283185307179586;
        end;

        local v30;

        if v29 > -1.5707963267948966 then
            v30 = v29 < 1.5707963267948966;
        else
            v30 = false;
        end;

        if not v30 then
            v29 = v28;
        end;

        local v31 = math.min(v29, v28);
        local v32 = math.max(v29, v28);
        local v33 = 0;

        if v31 > 0 then
            v32 = v31;
        elseif v32 >= 0 then
            v32 = v33;
        end;

        p17.currentTorsoAngle = v32 + p17.currentTorsoAngle;
    else
        p17.currentTorsoAngle = v20;
    end;

    return CFrame.new(v18.Position) * CFrame.fromEulerAnglesYXZ(0, -p17.currentTorsoAngle, 0);
end;

function u1.GetActiveController(p34) -- Line: 239
    return p34.activeController;
end;

function u1.UpdateActiveControlModuleEnabled(u35) -- Line: 244
    -- upvalues: Players (copy), UserInputService (copy), ClickToMoveController (copy), TouchThumbstick (copy), DynamicThumbstick (copy), TouchJump (copy), GuiService (copy)
    local function _() -- Line: 246
        -- upvalues: u35 (copy), Players (ref)
        u35.activeController:Enable(false);

        if u35.touchJumpController then
            u35.touchJumpController:Enable(false);
        end;

        if u35.moveFunction then
            u35.moveFunction(Players.LocalPlayer, Vector3.new(0, 0, 0), true);
        end;
    end;

    local function v36() -- Line: 257
        -- upvalues: u35 (copy), UserInputService (ref), ClickToMoveController (ref), TouchThumbstick (ref), DynamicThumbstick (ref), TouchJump (ref), Players (ref)
        if u35.touchControlFrame and (UserInputService.PreferredInput == Enum.PreferredInput.Touch and (u35.activeControlModule == ClickToMoveController or (u35.activeControlModule == TouchThumbstick or u35.activeControlModule == DynamicThumbstick))) then
            if not u35.controllers[TouchJump] then
                u35.controllers[TouchJump] = TouchJump.new();
            end;

            u35.touchJumpController = u35.controllers[TouchJump];
            u35.touchJumpController:Enable(true, u35.touchControlFrame);
        elseif u35.touchJumpController then
            u35.touchJumpController:Enable(false);
        end;

        if u35.activeControlModule == ClickToMoveController then
            u35.activeController:Enable(true, Players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice, u35.touchJumpController);

            return;
        end;

        if u35.touchControlFrame then
            u35.activeController:Enable(true, u35.touchControlFrame);

            return;
        end;

        u35.activeController:Enable(true);
    end;

    if not u35.activeController then
        return;
    end;

    if not u35.controlsEnabled then
        u35.activeController:Enable(false);

        if u35.touchJumpController then
            u35.touchJumpController:Enable(false);
        end;

        if u35.moveFunction then
            u35.moveFunction(Players.LocalPlayer, Vector3.new(0, 0, 0), true);
        end;

        return;
    end;

    if GuiService.TouchControlsEnabled or (UserInputService.PreferredInput ~= Enum.PreferredInput.Touch or u35.activeControlModule ~= ClickToMoveController and (u35.activeControlModule ~= TouchThumbstick and u35.activeControlModule ~= DynamicThumbstick)) then
        v36();

        return;
    end;

    u35.activeController:Enable(false);

    if u35.touchJumpController then
        u35.touchJumpController:Enable(false);
    end;

    if u35.moveFunction then
        u35.moveFunction(Players.LocalPlayer, Vector3.new(0, 0, 0), true);
    end;
end;

function u1.Enable(p37, p38) -- Line: 315
    local v39 = p38 == nil and true or p38;

    if p37.controlsEnabled == v39 then
        return;
    end;

    p37.controlsEnabled = v39;

    if not p37.activeController then
        return;
    end;

    p37:UpdateActiveControlModuleEnabled();
end;

function u1.Disable(p40) -- Line: 330
    p40:Enable(false);
end;

function u1.SelectComputerMovementModule(p41) -- Line: 336
    -- upvalues: UserInputService (copy), Players (copy), u3 (ref), Gamepad (copy), Keyboard (copy), UserGameSettings (copy), ClickToMoveController (copy), u4 (copy)
    if not (UserInputService.KeyboardEnabled or UserInputService.GamepadEnabled) then
        return nil, false;
    end;

    local v42 = nil;
    local DevComputerMovementMode = Players.LocalPlayer.DevComputerMovementMode;

    if DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice then
        local u43 = false;

        if u3 then
            pcall(function() -- Line: 347
                -- upvalues: u43 (ref), UserInputService (ref)
                u43 = UserInputService.PreferredInput == Enum.PreferredInput.MicroGamepad;
            end);
        end;

        if UserInputService.PreferredInput == Enum.PreferredInput.Gamepad or u43 then
            v42 = Gamepad;
        elseif UserInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse then
            v42 = Keyboard;
        end;

        if UserGameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove and v42 == Keyboard then
            v42 = ClickToMoveController;
        end;
    else
        v42 = u4[DevComputerMovementMode];

        if not v42 and DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable then
            warn("No character control module is associated with DevComputerMovementMode ", DevComputerMovementMode);
        end;
    end;

    if v42 then
        return v42, true;
    end;

    if DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable then
        return nil, true;
    end;

    return nil, false;
end;

function u1.SelectTouchModule(p44) -- Line: 385
    -- upvalues: Players (copy), u4 (copy), UserGameSettings (copy)
    local DevTouchMovementMode = Players.LocalPlayer.DevTouchMovementMode;
    local v45;

    if DevTouchMovementMode == Enum.DevTouchMovementMode.UserChoice then
        v45 = u4[UserGameSettings.TouchMovementMode];
    else
        if DevTouchMovementMode == Enum.DevTouchMovementMode.Scriptable then
            return nil, true;
        end;

        v45 = u4[DevTouchMovementMode];
    end;

    return v45, true;
end;

local function getGamepadRightThumbstickPosition() -- Line: 398
    -- upvalues: UserInputService (copy)
    local v46 = UserInputService:GetGamepadState(Enum.UserInputType.Gamepad1);

    for _, v in pairs(v46) do
        if v.KeyCode == Enum.KeyCode.Thumbstick2 then
            return v.Position;
        end;
    end;

    return Vector3.new(0, 0, 0);
end;

function u1.calculateRawMoveVector(p47, p48, p49) -- Line: 408
    -- upvalues: Workspace (copy), VRService (copy), getGamepadRightThumbstickPosition (copy)
    local CurrentCamera = Workspace.CurrentCamera;

    if not CurrentCamera then
        return p49;
    end;

    local CFrame2 = CurrentCamera.CFrame;

    if VRService.VREnabled and p48.RootPart then
        VRService:GetUserCFrame(Enum.UserCFrame.Head);
        local v50 = p47:GetEstimatedVRTorsoFrame();

        if (CurrentCamera.Focus.Position - CFrame2.Position).Magnitude < 3 then
            CFrame2 = CFrame2 * v50;
        else
            CFrame2 = CurrentCamera.CFrame * (v50.Rotation + v50.Position * CurrentCamera.HeadScale);
        end;
    end;

    if p48:GetState() ~= Enum.HumanoidStateType.Swimming then
        local _, _, _, v51, v52, v53, _, _, v54, _, _, v51 = CFrame2:GetComponents();

        if v54 >= 1 or v54 <= -1 then
            v53 = -v52 * math.sign(v54);
        end;

        local v55 = math.sqrt(v51 * v51 + v53 * v53);

        return Vector3.new((v51 * p49.X + v53 * p49.Z) / v55, 0, (v51 * p49.Z - v53 * p49.X) / v55);
    end;

    if not VRService.VREnabled then
        return CFrame2:VectorToWorldSpace(p49);
    end;

    local v56 = Vector3.new(p49.X, 0, p49.Z);

    if v56.Magnitude < 0.01 then
        return Vector3.new(0, 0, 0);
    end;

    local v57 = -getGamepadRightThumbstickPosition().Y * 1.3962634015954636;
    local v58 = math.atan2(-v56.X, -v56.Z);
    local _, v59, _ = CFrame2:ToEulerAnglesYXZ();

    return CFrame.fromEulerAnglesYXZ(v57, v58 + v59, 0).LookVector;
end;

function u1.OnRenderStepped(p60, p61) -- Line: 467
    -- upvalues: Gamepad (copy), VRService (copy), Players (copy)
    if p60.activeController and (p60.activeController.enabled and p60.humanoid) then
        local v62 = p60.activeController:GetMoveVector();
        local v63 = p60.activeController:IsMoveVectorCameraRelative();
        local v64 = p60:GetClickToMoveController();

        if p60.activeController == v64 then
            v64:OnRenderStepped(p61);
        elseif v62.magnitude > 0 then
            v64:CleanupPath();
        else
            v64:OnRenderStepped(p61);
            v62 = v64:GetMoveVector();
            v63 = v64:IsMoveVectorCameraRelative();
        end;

        if p60.vehicleController then
            local v65;
            v62, v65 = p60.vehicleController:Update(v62, v63, p60.activeControlModule == Gamepad);
        end;

        if v63 then
            v62 = p60:calculateRawMoveVector(p60.humanoid, v62);
        end;

        p60.inputMoveVector = v62;

        if VRService.VREnabled then
            v62 = p60:updateVRMoveVector(v62);
        end;

        p60.moveFunction(Players.LocalPlayer, v62, false);
        local humanoid = p60.humanoid;
        local v66 = p60.activeController:GetIsJumping() or p60.touchJumpController and p60.touchJumpController:GetIsJumping();
        humanoid.Jump = v66;
    end;
end;

function u1.updateVRMoveVector(p67, p68) -- Line: 516
    -- upvalues: VRService (copy)
    local CurrentCamera = workspace.CurrentCamera;

    if p68.Magnitude ~= 0 or ((CurrentCamera.Focus.Position - CurrentCamera.CFrame.Position).Magnitude >= 5 or (not VRService.AvatarGestures or (not p67.humanoid or p67.humanoid.Sit))) then
        return p68;
    end;

    local v69 = VRService:GetUserCFrame(Enum.UserCFrame.Head);
    local v70 = (CurrentCamera.CFrame * (v69.Rotation + v69.Position * CurrentCamera.HeadScale) * CFrame.new(0, -0.7 * p67.humanoid.RootPart.Size.Y / 2, 0)).Position - p67.humanoid.RootPart.CFrame.Position;

    return Vector3.new(v70.x, 0, v70.z);
end;

function u1.OnHumanoidSeated(p71, p72, p73) -- Line: 541
    -- upvalues: Value (copy)
    if p72 then
        if p73 and p73:IsA("VehicleSeat") then
            if not p71.vehicleController then
                p71.vehicleController = p71.vehicleController.new(Value);
            end;

            p71.vehicleController:Enable(true, p73);
        end;
    elseif p71.vehicleController then
        p71.vehicleController:Enable(false, p73);
    end;
end;

function u1.OnCharacterAdded(u74, p75) -- Line: 556
    u74.humanoid = p75:FindFirstChildOfClass("Humanoid");

    while not u74.humanoid do
        p75.ChildAdded:wait();
        u74.humanoid = p75:FindFirstChildOfClass("Humanoid");
    end;

    if u74.humanoidSeatedConn then
        u74.humanoidSeatedConn:Disconnect();
        u74.humanoidSeatedConn = nil;
    end;

    u74.humanoidSeatedConn = u74.humanoid.Seated:Connect(function(p76, p77) -- Line: 567
        -- upvalues: u74 (copy)
        u74:OnHumanoidSeated(p76, p77);
    end);
    u74:UpdateMovementMode();
end;

function u1.OnCharacterRemoving(p78, p79) -- Line: 574
    p78.humanoid = nil;
    p78:UpdateMovementMode();
end;

function u1.UpdateTouchGuiVisibility(p80) -- Line: 580
    -- upvalues: GuiService (copy), UserInputService (copy)
    local v81 = p80.humanoid and GuiService.TouchControlsEnabled and UserInputService.PreferredInput == Enum.PreferredInput.Touch;

    if v81 and not p80.touchGui then
        p80:CreateTouchGuiContainer();
    end;

    if p80.touchGui then
        p80.touchGui.Enabled = v81 and true or false;
    end;
end;

function u1.SwitchToController(p82, p83) -- Line: 599
    -- upvalues: Value (copy)
    if p83 then
        if not p82.controllers[p83] then
            p82.controllers[p83] = p83.new(Value);
        end;

        if p82.activeController ~= p82.controllers[p83] then
            if p82.activeController then
                p82.activeController:Enable(false);
            end;

            p82.activeController = p82.controllers[p83];
            p82.activeControlModule = p83;
            p82:UpdateActiveControlModuleEnabled();
        end;

        return;
    end;

    if p82.activeController then
        p82.activeController:Enable(false);
    end;

    p82.activeController = nil;
    p82.activeControlModule = nil;
end;

function u1.UpdateMovementMode(p84) -- Line: 638
    -- upvalues: UserInputService (copy)
    p84:UpdateTouchGuiVisibility();

    if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
        local v85, v86 = p84:SelectTouchModule();

        if v86 and p84.touchControlFrame then
            p84:SwitchToController(v85);
        end;
    else
        p84:SwitchToController((p84:SelectComputerMovementModule()));
    end;
end;

function u1.CreateTouchGuiContainer(p87) -- Line: 654
    -- upvalues: u2 (ref)
    if not p87.playerGui then
        return;
    end;

    if p87.touchGui then
        p87.touchGui:Destroy();
    end;

    p87.touchGui = Instance.new("ScreenGui");
    p87.touchGui.Name = "TouchGui";
    p87.touchGui.ResetOnSpawn = false;
    p87.touchGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;

    if u2 then
        p87.touchGui.ClipToDeviceSafeArea = false;
    end;

    p87.touchControlFrame = Instance.new("Frame");
    p87.touchControlFrame.Name = "TouchControlFrame";
    p87.touchControlFrame.Size = UDim2.new(1, 0, 1, 0);
    p87.touchControlFrame.BackgroundTransparency = 1;
    p87.touchControlFrame.Parent = p87.touchGui;
    p87.touchGui.Parent = p87.playerGui;
end;

function u1.GetClickToMoveController(p88) -- Line: 680
    -- upvalues: ClickToMoveController (copy), Value (copy)
    if not p88.controllers[ClickToMoveController] then
        p88.controllers[ClickToMoveController] = ClickToMoveController.new(Value);
    end;

    return p88.controllers[ClickToMoveController];
end;

return u1.new();