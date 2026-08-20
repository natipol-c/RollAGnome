--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     VRBaseCamera
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.VRBaseCamera
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:09 2026
]]

-- Decompiled with Potassium's decompiler.

local success, result = pcall(function() -- Line: 17
    return UserSettings():IsUserFeatureEnabled("UserVRVehicleCameraOrbital");
end);
local u1 = success and result;
local VRService = game:GetService("VRService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Lighting = game:GetService("Lighting");
local RunService = game:GetService("RunService");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local CameraInput = require(script.Parent:WaitForChild("CameraInput"));
local ZoomController = require(script.Parent:WaitForChild("ZoomController"));
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local u2 = require(CommonUtils:WaitForChild("FlagUtil")).getUserFlag("UserVRRemoveLuaEdgeBlur");
local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"));
local u3 = setmetatable({}, BaseCamera);
u3.__index = u3;

function u3.new() -- Line: 42
    -- upvalues: BaseCamera (copy), u3 (copy)
    local v4 = BaseCamera.new();
    local v5 = setmetatable(v4, u3);
    v5.gamepadZoomLevels = { 0, 7 };
    v5.headScale = 1;
    v5:SetCameraToSubjectDistance(7);
    v5.VRFadeResetTimer = 0;
    v5.VREdgeBlurTimer = 0;
    v5.gamepadResetConnection = nil;
    v5.needsReset = true;
    v5.recentered = false;
    v5:Reset();

    return v5;
end;

function u3.Reset(p6) -- Line: 68
    p6.stepRotateTimeout = 0;
end;

function u3.GetModuleName(p7) -- Line: 72
    return "VRBaseCamera";
end;

function u3.GamepadZoomPress(p8) -- Line: 76
    -- upvalues: BaseCamera (copy)
    BaseCamera.GamepadZoomPress(p8);
    p8:GamepadReset();
    p8:ResetZoom();
end;

function u3.GamepadReset(p9) -- Line: 84
    p9.stepRotateTimeout = 0;
    p9.needsReset = true;
end;

function u3.ResetZoom(p10) -- Line: 89
    -- upvalues: ZoomController (copy)
    ZoomController.SetZoomParameters(p10.currentSubjectDistance, 0);
    ZoomController.ReleaseSpring();
end;

function u3.OnEnabledChanged(u11) -- Line: 94
    -- upvalues: BaseCamera (copy), CameraInput (copy), VRService (copy), u1 (ref), u2 (copy), LocalPlayer (copy), Lighting (copy)
    BaseCamera.OnEnabledChanged(u11);

    if u11.enabled then
        u11.gamepadResetConnection = CameraInput.gamepadReset:Connect(function() -- Line: 98
            -- upvalues: u11 (copy)
            u11:GamepadReset();
        end);
        u11.thirdPersonOptionChanged = VRService:GetPropertyChangedSignal("ThirdPersonFollowCamEnabled"):Connect(function() -- Line: 103
            -- upvalues: u1 (ref), u11 (copy)
            if u1 then
                u11:Reset();

                return;
            end;

            if not u11:IsInFirstPerson() then
                u11:Reset();
            end;
        end);
        u11.vrRecentered = VRService.UserCFrameChanged:Connect(function(p12, p13) -- Line: 114
            -- upvalues: u11 (copy)
            if p12 == Enum.UserCFrame.Floor then
                u11.recentered = true;
            end;
        end);

        return;
    end;

    if u11.inFirstPerson then
        u11:GamepadZoomPress();
    end;

    if u11.thirdPersonOptionChanged then
        u11.thirdPersonOptionChanged:Disconnect();
        u11.thirdPersonOptionChanged = nil;
    end;

    if u11.vrRecentered then
        u11.vrRecentered:Disconnect();
        u11.vrRecentered = nil;
    end;

    if u11.cameraHeadScaleChangedConn then
        u11.cameraHeadScaleChangedConn:Disconnect();
        u11.cameraHeadScaleChangedConn = nil;
    end;

    if u11.gamepadResetConnection then
        u11.gamepadResetConnection:Disconnect();
        u11.gamepadResetConnection = nil;
    end;

    if not u2 then
        u11.VREdgeBlurTimer = 0;
        u11:UpdateEdgeBlur(LocalPlayer, 1);
    end;

    local VRFade = Lighting:FindFirstChild("VRFade");

    if VRFade then
        VRFade.Brightness = 0;
    end;
end;

function u3.OnCurrentCameraChanged(u14) -- Line: 158
    -- upvalues: BaseCamera (copy)
    BaseCamera.OnCurrentCameraChanged(u14);

    if u14.cameraHeadScaleChangedConn then
        u14.cameraHeadScaleChangedConn:Disconnect();
        u14.cameraHeadScaleChangedConn = nil;
    end;

    local CurrentCamera = workspace.CurrentCamera;

    if CurrentCamera then
        u14.cameraHeadScaleChangedConn = CurrentCamera:GetPropertyChangedSignal("HeadScale"):Connect(function() -- Line: 170
            -- upvalues: u14 (copy)
            u14:OnHeadScaleChanged();
        end);
        u14:OnHeadScaleChanged();
    end;
end;

function u3.OnHeadScaleChanged(p15) -- Line: 175
    local HeadScale = workspace.CurrentCamera.HeadScale;

    for i, v in p15.gamepadZoomLevels do
        p15.gamepadZoomLevels[i] = v * HeadScale / p15.headScale;
    end;

    p15:SetCameraToSubjectDistance(p15:GetCameraToSubjectDistance() * HeadScale / p15.headScale);
    p15.headScale = HeadScale;
end;

function u3.GetVRFocus(p16, p17, p18) -- Line: 191
    local v19 = p16.lastCameraFocus or p17;
    local x = p16.cameraTranslationConstraints.x;
    local v20 = math.min(1, p16.cameraTranslationConstraints.y + p18);
    p16.cameraTranslationConstraints = Vector3.new(x, v20, p16.cameraTranslationConstraints.z);
    local v21 = p16:GetCameraHeight();
    local v22 = Vector3.new(0, v21, 0);

    return CFrame.new(Vector3.new(p17.x, v19.y, p17.z):Lerp(p17 + v22, p16.cameraTranslationConstraints.y));
end;

function u3.StartFadeFromBlack(p23) -- Line: 207
    -- upvalues: UserGameSettings (copy), Lighting (copy)
    if UserGameSettings.VignetteEnabled == false then
        return;
    end;

    local VRFade = Lighting:FindFirstChild("VRFade");

    if not VRFade then
        VRFade = Instance.new("ColorCorrectionEffect");
        VRFade.Name = "VRFade";
        VRFade.Parent = Lighting;
    end;

    VRFade.Brightness = -1;
    p23.VRFadeResetTimer = 0.1;
end;

function u3.UpdateFadeFromBlack(p24, p25) -- Line: 222
    -- upvalues: Lighting (copy)
    local VRFade = Lighting:FindFirstChild("VRFade");

    if p24.VRFadeResetTimer > 0 then
        p24.VRFadeResetTimer = math.max(p24.VRFadeResetTimer - p25, 0);
        local VRFade2 = Lighting:FindFirstChild("VRFade");

        if VRFade2 and VRFade2.Brightness < 0 then
            VRFade2.Brightness = math.min(VRFade2.Brightness + p25 * 10, 0);
        end;
    elseif VRFade then
        VRFade.Brightness = 0;
    end;
end;

function u3.StartVREdgeBlur(p26, p27, p28) -- Line: 238
    -- upvalues: UserGameSettings (copy), RunService (copy), VRService (copy)
    if not p28 and UserGameSettings.VignetteEnabled == false then
        return;
    end;

    local VRBlurPart = workspace.CurrentCamera:FindFirstChild("VRBlurPart");

    if not VRBlurPart then
        VRBlurPart = Instance.new("Part");
        VRBlurPart.Name = "VRBlurPart";
        VRBlurPart.Parent = workspace.CurrentCamera;
        VRBlurPart.CanTouch = false;
        VRBlurPart.CanCollide = false;
        VRBlurPart.CanQuery = false;
        VRBlurPart.Anchored = true;
        VRBlurPart.Size = Vector3.new(0.44, 0.47, 1);
        VRBlurPart.Transparency = 1;
        VRBlurPart.CastShadow = false;
        RunService.RenderStepped:Connect(function(p29) -- Line: 258
            -- upvalues: VRService (ref), VRBlurPart (ref)
            local v30 = VRService:GetUserCFrame(Enum.UserCFrame.Head);
            local v31 = workspace.CurrentCamera.CFrame * (CFrame.new(v30.p * workspace.CurrentCamera.HeadScale) * (v30 - v30.p));
            VRBlurPart.CFrame = v31 * CFrame.Angles(0, 3.141592653589793, 0) + v31.LookVector * (1.05 * workspace.CurrentCamera.HeadScale);
            VRBlurPart.Size = Vector3.new(0.44, 0.47, 1) * workspace.CurrentCamera.HeadScale;
        end);
    end;

    local VRBlurScreen = p27.PlayerGui:FindFirstChild("VRBlurScreen");
    local v32;

    if VRBlurScreen then
        v32 = VRBlurScreen:FindFirstChild("VRBlur");
    else
        v32 = nil;
    end;

    if not v32 then
        local v33 = VRBlurScreen or (Instance.new("SurfaceGui") or Instance.new("ScreenGui"));
        v33.Name = "VRBlurScreen";
        v33.Parent = p27.PlayerGui;
        v33.Adornee = VRBlurPart;
        v32 = Instance.new("ImageLabel");
        v32.Name = "VRBlur";
        v32.Parent = v33;
        v32.Image = "rbxasset://textures/ui/VR/edgeBlur.png";
        v32.AnchorPoint = Vector2.new(0.5, 0.5);
        v32.Position = UDim2.new(0.5, 0, 0.5, 0);
        v32.Size = UDim2.fromScale(workspace.CurrentCamera.ViewportSize.X * 2.3 / 512, workspace.CurrentCamera.ViewportSize.Y * 2.3 / 512);
        v32.BackgroundTransparency = 1;
        v32.Active = true;
        v32.ScaleType = Enum.ScaleType.Stretch;
    end;

    v32.Visible = true;
    v32.ImageTransparency = 0;
    p26.VREdgeBlurTimer = 0.14;
end;

function u3.UpdateEdgeBlur(p34, p35, p36) -- Line: 307
    local VRBlurScreen = p35.PlayerGui:FindFirstChild("VRBlurScreen");
    local v37;

    if VRBlurScreen then
        v37 = VRBlurScreen:FindFirstChild("VRBlur");
    else
        v37 = nil;
    end;

    if v37 then
        if p34.VREdgeBlurTimer > 0 then
            p34.VREdgeBlurTimer = p34.VREdgeBlurTimer - p36;
            local VRBlurScreen2 = p35.PlayerGui:FindFirstChild("VRBlurScreen");
            local v38 = VRBlurScreen2 and VRBlurScreen2:FindFirstChild("VRBlur");

            if v38 then
                v38.ImageTransparency = 1 - math.clamp(p34.VREdgeBlurTimer, 0.01, 0.14) * 7.142857142857142;
            end;
        else
            v37.Visible = false;
        end;
    end;
end;

function u3.GetCameraHeight(p39) -- Line: 332
    return p39.inFirstPerson and 0 or 0.25881904510252074 * p39.currentSubjectDistance;
end;

function u3.GetSubjectCFrame(p40) -- Line: 339
    -- upvalues: BaseCamera (copy)
    local v41 = BaseCamera.GetSubjectCFrame(p40);
    local CurrentCamera = workspace.CurrentCamera;

    if CurrentCamera then
        CurrentCamera = CurrentCamera.CameraSubject;
    end;

    if not CurrentCamera then
        return v41;
    end;

    if CurrentCamera:IsA("Humanoid") and (CurrentCamera:GetState() == Enum.HumanoidStateType.Dead and CurrentCamera == p40.lastSubject) then
        v41 = p40.lastSubjectCFrame;
    end;

    if v41 then
        p40.lastSubjectCFrame = v41;
    end;

    return v41;
end;

function u3.GetSubjectPosition(p42) -- Line: 365
    -- upvalues: BaseCamera (copy)
    local v43 = BaseCamera.GetSubjectPosition(p42);
    local CurrentCamera = game.Workspace.CurrentCamera;

    if CurrentCamera then
        CurrentCamera = CurrentCamera.CameraSubject;
    end;

    if not CurrentCamera then
        return nil;
    end;

    if CurrentCamera:IsA("Humanoid") then
        if CurrentCamera:GetState() == Enum.HumanoidStateType.Dead and CurrentCamera == p42.lastSubject then
            v43 = p42.lastSubjectPosition;
        end;
    elseif CurrentCamera:IsA("VehicleSeat") then
        v43 = CurrentCamera.CFrame.p + CurrentCamera.CFrame:vectorToWorldSpace(Vector3.new(0, 4, 0));
    end;

    p42.lastSubjectPosition = v43;

    return v43;
end;

function u3.getRotation(p44, p45) -- Line: 394
    -- upvalues: CameraInput (copy), UserGameSettings (copy)
    local v46 = CameraInput.getRotation(p45);

    if UserGameSettings.VRSmoothRotationEnabled then
        return v46.X;
    end;

    if math.abs(v46.X) > 0.03 then
        if p44.stepRotateTimeout > 0 then
            p44.stepRotateTimeout = p44.stepRotateTimeout - p45;
        end;

        if p44.stepRotateTimeout <= 0 then
            local v47 = (v46.X < 0 and -1 or 1) * 0.5235987755982988;
            p44:StartFadeFromBlack();
            p44.stepRotateTimeout = 0.25;

            return v47;
        end;
    elseif math.abs(v46.X) < 0.02 then
        p44.stepRotateTimeout = 0;
    end;

    return 0;
end;

function u3.HandleSubjectDistance(p48, p49) -- Line: 429
    -- upvalues: u1 (ref)
    if u1 and (p49 and (p49.IsInFirstPerson and p49:IsInFirstPerson())) then
        p48:SetCameraToSubjectDistance(0);
    end;
end;

return u3;