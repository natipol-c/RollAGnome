--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     BaseCamera
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.BaseCamera
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:30 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
game:GetService("UserInputService");
local VRService = game:GetService("VRService");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local ConnectionUtil = require(CommonUtils:WaitForChild("ConnectionUtil"));
require(CommonUtils:WaitForChild("FlagUtil"));
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"));
local ZoomController = require(script.Parent:WaitForChild("ZoomController"));
local CameraToggleStateController = require(script.Parent:WaitForChild("CameraToggleStateController"));
local CameraInput = require(script.Parent:WaitForChild("CameraInput"));
local CameraUI = require(script.Parent:WaitForChild("CameraUI"));
local LocalPlayer = Players.LocalPlayer;
Vector2.new(0, 0);
local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 70
    -- upvalues: u1 (copy), ConnectionUtil (copy), LocalPlayer (copy), UserGameSettings (copy)
    local v2 = setmetatable({}, u1);
    v2._connections = ConnectionUtil.new();
    v2.gamepadZoomLevels = { 0, 10, 20 };
    v2.FIRST_PERSON_DISTANCE_THRESHOLD = 1;
    v2.cameraType = nil;
    v2.cameraMovementMode = nil;
    v2.lastCameraTransform = nil;
    v2.lastUserPanCamera = tick();
    v2.humanoidRootPart = nil;
    v2.humanoidCache = {};
    v2.lastSubject = nil;
    v2.lastSubjectPosition = Vector3.new(0, 5, 0);
    v2.lastSubjectCFrame = CFrame.new(v2.lastSubjectPosition);
    v2.currentSubjectDistance = math.clamp(12.5, LocalPlayer.CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance);
    v2.inFirstPerson = false;
    v2.inMouseLockedMode = false;
    v2.resetCameraAngle = true;
    v2.enabled = false;
    v2.cameraChangedConn = nil;
    v2.shouldUseVRRotation = false;
    v2.VRRotationIntensityAvailable = false;
    v2.lastVRRotationIntensityCheckTime = 0;
    v2.lastVRRotationTime = 0;
    v2.vrRotateKeyCooldown = {};
    v2.cameraTranslationConstraints = Vector3.new(1, 1, 1);
    v2.humanoidJumpOrigin = nil;
    v2.trackingHumanoid = nil;
    v2.cameraFrozen = false;
    v2.subjectStateChangedConn = nil;
    v2.gamepadZoomPressConnection = nil;
    v2.mouseLockOffset = Vector3.new(0, 0, 0);
    UserGameSettings:SetCameraYInvertVisible();
    UserGameSettings:SetGamepadCameraSensitivityVisible();

    return v2;
end;

function u1.GetModuleName(p3) -- Line: 130
    return "BaseCamera";
end;

function u1._setUpConfigurations(u4) -- Line: 134
    -- upvalues: LocalPlayer (copy)
    u4._connections:trackConnection("CHARACTER_ADDED", LocalPlayer.CharacterAdded:Connect(function(p5) -- Line: 135
        -- upvalues: u4 (copy)
        u4:OnCharacterAdded(p5);
    end));
    u4.humanoidRootPart = nil;
    u4._connections:trackConnection("CAMERA_MODE_CHANGED", LocalPlayer:GetPropertyChangedSignal("CameraMode"):Connect(function() -- Line: 140
        -- upvalues: u4 (copy)
        u4:OnPlayerCameraPropertyChange();
    end));
    u4._connections:trackConnection("CAMERA_MIN_DISTANCE_CHANGED", LocalPlayer:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(function() -- Line: 143
        -- upvalues: u4 (copy)
        u4:OnPlayerCameraPropertyChange();
    end));
    u4._connections:trackConnection("CAMERA_MAX_DISTANCE_CHANGED", LocalPlayer:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(function() -- Line: 146
        -- upvalues: u4 (copy)
        u4:OnPlayerCameraPropertyChange();
    end));
    u4:OnPlayerCameraPropertyChange();
end;

function u1.OnCharacterAdded(p6, p7) -- Line: 152
    p6.resetCameraAngle = p6.resetCameraAngle or p6:GetEnabled();
    p6.humanoidRootPart = nil;
end;

function u1.GetHumanoidRootPart(p8) -- Line: 159
    -- upvalues: LocalPlayer (copy)
    local v9 = (not p8.humanoidRootPart and LocalPlayer.Character and true or false) and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

    if v9 then
        p8.humanoidRootPart = v9.RootPart;
    end;

    return p8.humanoidRootPart;
end;

function u1.GetBodyPartToFollow(p10, p11, p12) -- Line: 171
    if p11:GetState() == Enum.HumanoidStateType.Dead then
        local Parent = p11.Parent;

        if Parent and Parent:IsA("Model") then
            return Parent:FindFirstChild("Head") or p11.RootPart;
        end;
    end;

    return p11.RootPart;
end;

function u1.GetSubjectCFrame(p13) -- Line: 183
    local lastSubjectCFrame = p13.lastSubjectCFrame;
    local CurrentCamera = workspace.CurrentCamera;

    if CurrentCamera then
        CurrentCamera = CurrentCamera.CameraSubject;
    end;

    if not CurrentCamera then
        return lastSubjectCFrame;
    end;

    if CurrentCamera:IsA("Humanoid") then
        local v14 = CurrentCamera:GetState() == Enum.HumanoidStateType.Dead;
        local CameraOffset = CurrentCamera.CameraOffset;

        if p13:GetIsMouseLocked() then
            CameraOffset = Vector3.new();
        end;

        local RootPart = CurrentCamera.RootPart;

        if v14 and (CurrentCamera.Parent and CurrentCamera.Parent:IsA("Model")) then
            RootPart = CurrentCamera.Parent:FindFirstChild("Head") or RootPart;
        end;

        if RootPart and RootPart:IsA("BasePart") then
            local v15;

            if CurrentCamera.RigType == Enum.HumanoidRigType.R15 then
                if CurrentCamera.AutomaticScalingEnabled then
                    v15 = Vector3.new(0, 1.5, 0);
                    local RootPart2 = CurrentCamera.RootPart;

                    if RootPart == RootPart2 then
                        v15 = v15 + Vector3.new(0, (RootPart2.Size.Y - 2) / 2, 0);
                    end;
                else
                    v15 = Vector3.new(0, 2, 0);
                end;
            else
                v15 = Vector3.new(0, 1.5, 0);
            end;

            lastSubjectCFrame = RootPart.CFrame * CFrame.new((v14 and Vector3.new(0, 0, 0) or v15) + CameraOffset);
        end;
    elseif CurrentCamera:IsA("BasePart") then
        lastSubjectCFrame = CurrentCamera.CFrame;
    elseif CurrentCamera:IsA("Model") then
        if CurrentCamera.PrimaryPart then
            lastSubjectCFrame = CurrentCamera:GetPrimaryPartCFrame();
        else
            lastSubjectCFrame = CFrame.new();
        end;
    end;

    if lastSubjectCFrame then
        p13.lastSubjectCFrame = lastSubjectCFrame;
    end;

    return lastSubjectCFrame;
end;

function u1.GetSubjectVelocity(p16) -- Line: 257
    local CurrentCamera = workspace.CurrentCamera;

    if CurrentCamera then
        CurrentCamera = CurrentCamera.CameraSubject;
    end;

    if not CurrentCamera then
        return Vector3.new(0, 0, 0);
    end;

    if CurrentCamera:IsA("BasePart") then
        return CurrentCamera.Velocity;
    end;

    if CurrentCamera:IsA("Humanoid") then
        local RootPart = CurrentCamera.RootPart;

        if RootPart then
            return RootPart.Velocity;
        end;
    else
        local v17 = CurrentCamera:IsA("Model") and CurrentCamera.PrimaryPart;

        if v17 then
            return v17.Velocity;
        end;
    end;

    return Vector3.new(0, 0, 0);
end;

function u1.GetSubjectRotVelocity(p18) -- Line: 286
    local CurrentCamera = workspace.CurrentCamera;

    if CurrentCamera then
        CurrentCamera = CurrentCamera.CameraSubject;
    end;

    if not CurrentCamera then
        return Vector3.new(0, 0, 0);
    end;

    if CurrentCamera:IsA("BasePart") then
        return CurrentCamera.RotVelocity;
    end;

    if CurrentCamera:IsA("Humanoid") then
        local RootPart = CurrentCamera.RootPart;

        if RootPart then
            return RootPart.RotVelocity;
        end;
    else
        local v19 = CurrentCamera:IsA("Model") and CurrentCamera.PrimaryPart;

        if v19 then
            return v19.RotVelocity;
        end;
    end;

    return Vector3.new(0, 0, 0);
end;

function u1.StepZoom(p20) -- Line: 315
    -- upvalues: CameraInput (copy), ZoomController (copy)
    local currentSubjectDistance = p20.currentSubjectDistance;
    local v21 = CameraInput.getZoomDelta();

    if math.abs(v21) > 0 then
        local v22;

        if v21 > 0 then
            v22 = math.max(currentSubjectDistance + v21 * (currentSubjectDistance * 0.5 + 1), p20.FIRST_PERSON_DISTANCE_THRESHOLD);
        else
            v22 = math.max((currentSubjectDistance + v21) / (1 - v21 * 0.5), 0.5);
        end;

        p20:SetCameraToSubjectDistance(v22 < p20.FIRST_PERSON_DISTANCE_THRESHOLD and 0.5 or v22);
    end;

    return ZoomController.GetZoomRadius();
end;

function u1.GetSubjectPosition(p23) -- Line: 340
    local lastSubjectPosition = p23.lastSubjectPosition;
    local CurrentCamera = game.Workspace.CurrentCamera;

    if CurrentCamera then
        CurrentCamera = CurrentCamera.CameraSubject;
    end;

    if not CurrentCamera then
        return nil;
    end;

    if CurrentCamera:IsA("Humanoid") then
        local v24 = CurrentCamera:GetState() == Enum.HumanoidStateType.Dead;
        local CameraOffset = CurrentCamera.CameraOffset;

        if p23:GetIsMouseLocked() then
            CameraOffset = Vector3.new();
        end;

        local RootPart = CurrentCamera.RootPart;

        if v24 and (CurrentCamera.Parent and CurrentCamera.Parent:IsA("Model")) then
            RootPart = CurrentCamera.Parent:FindFirstChild("Head") or RootPart;
        end;

        if RootPart and RootPart:IsA("BasePart") then
            local v25;

            if CurrentCamera.RigType == Enum.HumanoidRigType.R15 then
                if CurrentCamera.AutomaticScalingEnabled then
                    v25 = Vector3.new(0, 1.5, 0);

                    if RootPart == CurrentCamera.RootPart then
                        v25 = v25 + Vector3.new(0, CurrentCamera.RootPart.Size.Y / 2 - 1, 0);
                    end;
                else
                    v25 = Vector3.new(0, 2, 0);
                end;
            else
                v25 = Vector3.new(0, 1.5, 0);
            end;

            lastSubjectPosition = RootPart.CFrame.p + RootPart.CFrame:vectorToWorldSpace((v24 and Vector3.new(0, 0, 0) or v25) + CameraOffset);
        end;
    elseif CurrentCamera:IsA("VehicleSeat") then
        lastSubjectPosition = CurrentCamera.CFrame.p + CurrentCamera.CFrame:vectorToWorldSpace(Vector3.new(0, 5, 0));
    elseif CurrentCamera:IsA("SkateboardPlatform") then
        lastSubjectPosition = CurrentCamera.CFrame.p + Vector3.new(0, 5, 0);
    elseif CurrentCamera:IsA("BasePart") then
        lastSubjectPosition = CurrentCamera.CFrame.p;
    elseif CurrentCamera:IsA("Model") then
        if CurrentCamera.PrimaryPart then
            lastSubjectPosition = CurrentCamera:GetPrimaryPartCFrame().p;
        else
            lastSubjectPosition = CurrentCamera:GetModelCFrame().p;
        end;
    end;

    p23.lastSubject = CurrentCamera;
    p23.lastSubjectPosition = lastSubjectPosition;

    return lastSubjectPosition;
end;

function u1.OnCurrentCameraChanged(u26) -- Line: 418
    if u26.cameraSubjectChangedConn then
        u26.cameraSubjectChangedConn:Disconnect();
        u26.cameraSubjectChangedConn = nil;
    end;

    local CurrentCamera = game.Workspace.CurrentCamera;

    if CurrentCamera then
        u26.cameraSubjectChangedConn = CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function() -- Line: 427
            -- upvalues: u26 (copy)
            u26:OnNewCameraSubject();
        end);
        u26:OnNewCameraSubject();
    end;
end;

function u1.OnPlayerCameraPropertyChange(p27) -- Line: 434
    p27:SetCameraToSubjectDistance(p27.currentSubjectDistance);
end;

function u1.InputTranslationToCameraAngleChange(p28, p29, p30) -- Line: 439
    return p29 * p30;
end;

function u1.GamepadZoomPress(p31) -- Line: 445
    -- upvalues: LocalPlayer (copy)
    local v32 = p31:GetCameraToSubjectDistance();
    local CameraMaxZoomDistance = LocalPlayer.CameraMaxZoomDistance;

    for i = #p31.gamepadZoomLevels, 1, -1 do
        local v33 = p31.gamepadZoomLevels[i];

        if CameraMaxZoomDistance >= v33 then
            if v33 < LocalPlayer.CameraMinZoomDistance then
                v33 = LocalPlayer.CameraMinZoomDistance;

                if CameraMaxZoomDistance == v33 then
                    break;
                end;
            end;

            if v33 + (CameraMaxZoomDistance - v33) / 2 < v32 then
                p31:SetCameraToSubjectDistance(v33);

                return;
            end;

            CameraMaxZoomDistance = v33;
        end;
    end;

    p31:SetCameraToSubjectDistance(p31.gamepadZoomLevels[#p31.gamepadZoomLevels]);
end;

function u1.Enable(p34, p35) -- Line: 482
    if p34.enabled ~= p35 then
        p34.enabled = p35;
        p34:OnEnabledChanged();
    end;
end;

function u1.OnEnabledChanged(u36) -- Line: 490
    -- upvalues: CameraInput (copy), LocalPlayer (copy)
    if not u36.enabled then
        u36._connections:disconnectAll();
        CameraInput.setInputEnabled(false);

        if u36.gamepadZoomPressConnection then
            u36.gamepadZoomPressConnection:Disconnect();
            u36.gamepadZoomPressConnection = nil;
        end;

        u36:Cleanup();

        return;
    end;

    u36:_setUpConfigurations();
    CameraInput.setInputEnabled(true);
    u36.gamepadZoomPressConnection = CameraInput.gamepadZoomPress:Connect(function() -- Line: 496
        -- upvalues: u36 (copy)
        u36:GamepadZoomPress();
    end);

    if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        u36.currentSubjectDistance = 0.5;

        if not u36.inFirstPerson then
            u36:EnterFirstPerson();
        end;
    end;

    if u36.cameraChangedConn then
        u36.cameraChangedConn:Disconnect();
        u36.cameraChangedConn = nil;
    end;

    u36.cameraChangedConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 508
        -- upvalues: u36 (copy)
        u36:OnCurrentCameraChanged();
    end);
    u36:OnCurrentCameraChanged();
end;

function u1.GetEnabled(p37) -- Line: 526
    return p37.enabled;
end;

function u1.Cleanup(p38) -- Line: 530
    -- upvalues: CameraUtils (copy)
    if p38.subjectStateChangedConn then
        p38.subjectStateChangedConn:Disconnect();
        p38.subjectStateChangedConn = nil;
    end;

    if p38.cameraChangedConn then
        p38.cameraChangedConn:Disconnect();
        p38.cameraChangedConn = nil;
    end;

    p38.lastCameraTransform = nil;
    p38.lastSubjectCFrame = nil;
    CameraUtils.restoreMouseBehavior();
end;

function u1.UpdateMouseBehavior(p39) -- Line: 547
    -- upvalues: UserGameSettings (copy), CameraUI (copy), CameraInput (copy), CameraToggleStateController (copy), CameraUtils (copy)
    if p39.isCameraToggle and UserGameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove == false then
        CameraUI.setCameraModeToastEnabled(true);
        CameraInput.enableCameraToggleInput();
        CameraToggleStateController(p39.inFirstPerson);

        return;
    end;

    CameraUI.setCameraModeToastEnabled(false);
    CameraInput.disableCameraToggleInput();

    if p39.inFirstPerson or p39.inMouseLockedMode then
        CameraUtils.setRotationTypeOverride(Enum.RotationType.CameraRelative);
        CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter);

        return;
    end;

    CameraUtils.restoreRotationType();

    if CameraInput.getRotationActivated() then
        CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCurrentPosition);

        return;
    end;

    CameraUtils.restoreMouseBehavior();
end;

function u1.UpdateForDistancePropertyChange(p40) -- Line: 575
    p40:SetCameraToSubjectDistance(p40.currentSubjectDistance);
end;

function u1.SetCameraToSubjectDistance(p41, p42) -- Line: 581
    -- upvalues: LocalPlayer (copy), ZoomController (copy)
    local currentSubjectDistance = p41.currentSubjectDistance;

    if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        p41.currentSubjectDistance = 0.5;

        if not p41.inFirstPerson then
            p41:EnterFirstPerson();
        end;
    else
        local v43 = math.clamp(p42, LocalPlayer.CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance);

        if v43 < 1 then
            p41.currentSubjectDistance = 0.5;

            if not p41.inFirstPerson then
                p41:EnterFirstPerson();
            end;
        else
            p41.currentSubjectDistance = v43;

            if p41.inFirstPerson then
                p41:LeaveFirstPerson();
            end;
        end;
    end;

    ZoomController.SetZoomParameters(p41.currentSubjectDistance, (math.sign(p42 - currentSubjectDistance)));

    return p41.currentSubjectDistance;
end;

function u1.SetCameraType(p44, p45) -- Line: 615
    p44.cameraType = p45;
end;

function u1.GetCameraType(p46) -- Line: 620
    return p46.cameraType;
end;

function u1.SetCameraMovementMode(p47, p48) -- Line: 625
    p47.cameraMovementMode = p48;
end;

function u1.GetCameraMovementMode(p49) -- Line: 629
    return p49.cameraMovementMode;
end;

function u1.SetIsMouseLocked(p50, p51) -- Line: 633
    p50.inMouseLockedMode = p51;
end;

function u1.GetIsMouseLocked(p52) -- Line: 637
    return p52.inMouseLockedMode;
end;

function u1.SetMouseLockOffset(p53, p54) -- Line: 641
    p53.mouseLockOffset = p54;
end;

function u1.GetMouseLockOffset(p55) -- Line: 645
    return p55.mouseLockOffset;
end;

function u1.InFirstPerson(p56) -- Line: 649
    return p56.inFirstPerson;
end;

function u1.EnterFirstPerson(p57) -- Line: 653
    p57.inFirstPerson = true;
    p57:UpdateMouseBehavior();
end;

function u1.LeaveFirstPerson(p58) -- Line: 658
    p58.inFirstPerson = false;
    p58:UpdateMouseBehavior();
end;

function u1.GetCameraToSubjectDistance(p59) -- Line: 664
    return p59.currentSubjectDistance;
end;

function u1.GetMeasuredDistanceToFocus(p60) -- Line: 671
    local CurrentCamera = game.Workspace.CurrentCamera;

    if CurrentCamera then
        return (CurrentCamera.CoordinateFrame.p - CurrentCamera.Focus.p).magnitude;
    end;

    return nil;
end;

function u1.GetCameraLookVector(p61) -- Line: 679
    return game.Workspace.CurrentCamera and game.Workspace.CurrentCamera.CFrame.LookVector or Vector3.new(0, 0, 1);
end;

function u1.CalculateNewLookCFrameFromArg(p62, p63, p64) -- Line: 683
    local v65 = p63 or p62:GetCameraLookVector();
    local v66 = math.asin(v65.Y);
    local v67 = math.clamp(p64.Y, v66 + -1.3962634015954636, v66 + 1.3962634015954636);
    local v68 = Vector2.new(p64.X, v67);
    local v69 = CFrame.new(Vector3.new(0, 0, 0), v65);

    return CFrame.Angles(0, -v68.X, 0) * v69 * CFrame.Angles(-v68.Y, 0, 0);
end;

function u1.CalculateNewLookVectorFromArg(p70, p71, p72) -- Line: 693
    return p70:CalculateNewLookCFrameFromArg(p71, p72).LookVector;
end;

function u1.CalculateNewLookVectorVRFromArg(p73, p74) -- Line: 698
    local unit = ((p73:GetSubjectPosition() - game.Workspace.CurrentCamera.CFrame.p) * Vector3.new(1, 0, 1)).unit;
    local v75 = Vector2.new(p74.X, 0);
    local v76 = CFrame.new(Vector3.new(0, 0, 0), unit);

    return ((CFrame.Angles(0, -v75.X, 0) * v76 * CFrame.Angles(-v75.Y, 0, 0)).LookVector * Vector3.new(1, 0, 1)).unit;
end;

function u1.GetHumanoid(p77) -- Line: 708
    -- upvalues: LocalPlayer (copy)
    local v78 = LocalPlayer and LocalPlayer.Character;

    if not v78 then
        return nil;
    end;

    local v79 = p77.humanoidCache[LocalPlayer];

    if v79 and v79.Parent == v78 then
        return v79;
    end;

    p77.humanoidCache[LocalPlayer] = nil;
    local v80 = v78:FindFirstChildOfClass("Humanoid");

    if v80 then
        p77.humanoidCache[LocalPlayer] = v80;
    end;

    return v80;
end;

function u1.GetHumanoidPartToFollow(p81, p82, p83) -- Line: 726
    if p83 ~= Enum.HumanoidStateType.Dead then
        return p82.Torso;
    end;

    local Parent = p82.Parent;

    if Parent then
        return Parent:FindFirstChild("Head") or p82.Torso;
    end;

    return p82.Torso;
end;

function u1.OnNewCameraSubject(p84) -- Line: 740
    if p84.subjectStateChangedConn then
        p84.subjectStateChangedConn:Disconnect();
        p84.subjectStateChangedConn = nil;
    end;
end;

function u1.IsInFirstPerson(p85) -- Line: 747
    return p85.inFirstPerson;
end;

function u1.Update(p86, p87) -- Line: 751
    error("BaseCamera:Update() This is a virtual function that should never be getting called.", 2);
end;

function u1.GetCameraHeight(p88) -- Line: 755
    -- upvalues: VRService (copy)
    return (not VRService.VREnabled or p88.inFirstPerson) and 0 or 0.25881904510252074 * p88.currentSubjectDistance;
end;

return u1;