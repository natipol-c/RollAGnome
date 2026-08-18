--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     VRCamera
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.VRCamera
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:09 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local VRService = game:GetService("VRService");
UserSettings():GetService("UserGameSettings");
require(script.Parent:WaitForChild("CameraInput"));
require(script.Parent:WaitForChild("CameraUtils"));
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local u1 = require(CommonUtils:WaitForChild("FlagUtil")).getUserFlag("UserVRRemoveLuaEdgeBlur");
local VRBaseCamera = require(script.Parent:WaitForChild("VRBaseCamera"));
local u2 = setmetatable({}, VRBaseCamera);
u2.__index = u2;

function u2.new() -- Line: 32
    -- upvalues: VRBaseCamera (copy), u2 (copy), Players (copy)
    local v3 = VRBaseCamera.new();
    local v4 = setmetatable(v3, u2);
    v4.lastUpdate = tick();
    v4.focusOffset = CFrame.new();
    v4:Reset();
    v4.controlModule = require(Players.LocalPlayer:WaitForChild("PlayerScripts").PlayerModule:WaitForChild("ControlModule"));
    v4.savedAutoRotate = true;

    return v4;
end;

function u2.Reset(p5) -- Line: 45
    -- upvalues: VRBaseCamera (copy)
    p5.needsReset = true;
    p5.needsBlackout = true;
    p5.motionDetTime = 0;
    p5.blackOutTimer = 0;
    p5.lastCameraResetPosition = nil;
    VRBaseCamera.Reset(p5);
end;

function u2.Update(p6, p7) -- Line: 54
    -- upvalues: Players (copy), u1 (copy), VRService (copy)
    local CurrentCamera = workspace.CurrentCamera;
    local CFrame2 = CurrentCamera.CFrame;
    local Focus = CurrentCamera.Focus;
    local LocalPlayer = Players.LocalPlayer;
    p6:GetHumanoid();
    local _ = CurrentCamera.CameraSubject;

    if p6.lastUpdate == nil or p7 > 1 then
        p6.lastCameraTransform = nil;
    end;

    p6:UpdateFadeFromBlack(p7);

    if not u1 then
        p6:UpdateEdgeBlur(LocalPlayer, p7);
    end;

    local lastSubjectPosition = p6.lastSubjectPosition;
    local v8 = p6:GetSubjectPosition();

    if p6.needsBlackout then
        p6:StartFadeFromBlack();
        local v9 = math.clamp(p7, 0.0001, 0.1);
        p6.blackOutTimer = p6.blackOutTimer + v9;

        if p6.blackOutTimer > 0.1 and game:IsLoaded() then
            p6.needsBlackout = false;
            p6.needsReset = true;
        end;
    end;

    if v8 and (LocalPlayer and CurrentCamera) then
        local v10 = p6:GetVRFocus(v8, p7);

        if p6:IsInFirstPerson() then
            if VRService.AvatarGestures then
                CFrame2, Focus = p6:UpdateImmersionCamera(p7, CFrame2, v10, lastSubjectPosition, v8);
            else
                CFrame2, Focus = p6:UpdateFirstPersonTransform(p7, CFrame2, v10, lastSubjectPosition, v8);
            end;
        elseif VRService.ThirdPersonFollowCamEnabled then
            CFrame2, Focus = p6:UpdateThirdPersonFollowTransform(p7, CFrame2, v10, lastSubjectPosition, v8);
        else
            CFrame2, Focus = p6:UpdateThirdPersonComfortTransform(p7, CFrame2, v10, lastSubjectPosition, v8);
        end;

        p6.lastCameraTransform = CFrame2;
        p6.lastCameraFocus = Focus;
    end;

    p6.lastUpdate = tick();

    return CFrame2, Focus;
end;

function u2.GetAvatarFeetWorldYValue(p11) -- Line: 118
    local CameraSubject = workspace.CurrentCamera.CameraSubject;

    if not CameraSubject then
        return nil;
    end;

    if not (CameraSubject:IsA("Humanoid") and CameraSubject.RootPart) then
        return nil;
    end;

    local RootPart = CameraSubject.RootPart;

    return RootPart.Position.Y - RootPart.Size.Y / 2 - CameraSubject.HipHeight;
end;

function u2.UpdateFirstPersonTransform(p12, p13, p14, p15, p16, p17) -- Line: 133
    -- upvalues: Players (copy), u1 (copy)
    if p12.needsReset then
        p12:StartFadeFromBlack();
        p12.needsReset = false;
    end;

    local LocalPlayer = Players.LocalPlayer;

    if not u1 and (p16 - p17).magnitude > 0.01 then
        p12:StartVREdgeBlur(LocalPlayer);
    end;

    local p = p15.p;
    local v18 = p12:GetCameraLookVector();
    local Unit = Vector3.new(v18.X, 0, v18.Z).Unit;
    local v19 = p12:getRotation(p13);
    local v20 = p12:CalculateNewLookVectorFromArg(Unit, Vector2.new(v19, 0));

    return CFrame.new(p - 0.5 * v20, p), p15;
end;

function u2.UpdateImmersionCamera(p21, p22, p23, p24, p25, p26) -- Line: 161
    -- upvalues: Players (copy), VRService (copy), u1 (copy)
    local v27 = p21:GetSubjectCFrame();
    local CurrentCamera = workspace.CurrentCamera;
    local Character = Players.LocalPlayer.Character;
    local v28 = p21:GetHumanoid();

    if not v28 then
        return CurrentCamera.CFrame, CurrentCamera.Focus;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return CurrentCamera.CFrame, CurrentCamera.Focus;
    end;

    p21.characterOrientation = HumanoidRootPart:FindFirstChild("CharacterAlignOrientation");

    if not p21.characterOrientation then
        local RootAttachment = HumanoidRootPart:FindFirstChild("RootAttachment");

        if not RootAttachment then
            return;
        end;

        p21.characterOrientation = Instance.new("AlignOrientation");
        p21.characterOrientation.Name = "CharacterAlignOrientation";
        p21.characterOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
        p21.characterOrientation.Attachment0 = RootAttachment;
        p21.characterOrientation.RigidityEnabled = true;
        p21.characterOrientation.Parent = HumanoidRootPart;
    end;

    if p21.characterOrientation.Enabled == false then
        p21.characterOrientation.Enabled = true;
    end;

    if p21.needsReset then
        p21.needsReset = false;
        p21.savedAutoRotate = v28.AutoRotate;
        v28.AutoRotate = false;

        if p21.NoRecenter then
            p21.NoRecenter = false;
            VRService:RecenterUserHeadCFrame();
        end;

        p21:StartFadeFromBlack();
    elseif v28.Sit then
        if not u1 and (v27.Position - CurrentCamera.CFrame.Position).Magnitude > 0.01 then
            p21:StartVREdgeBlur(Players.LocalPlayer);
        end;
    else
        local v29 = p21.controlModule:GetEstimatedVRTorsoFrame();
        p21.characterOrientation.CFrame = CurrentCamera.CFrame * v29;

        if p21.controlModule.inputMoveVector.Magnitude > 0 then
            p21.motionDetTime = 0.1;
        end;

        if p21.controlModule.inputMoveVector.Magnitude > 0 or p21.motionDetTime > 0 then
            p21.motionDetTime = p21.motionDetTime - p22;

            if not u1 then
                p21:StartVREdgeBlur(Players.LocalPlayer);
            end;

            local v30 = VRService:GetUserCFrame(Enum.UserCFrame.Head);
            local HumanoidRootPart2 = Character.HumanoidRootPart;
            local v31 = CurrentCamera.CFrame * (v30.Rotation + v30.Position * CurrentCamera.HeadScale) * CFrame.new(0, -0.7 * HumanoidRootPart2.Size.Y / 2, 0);
            local LookVector = HumanoidRootPart2.CFrame.LookVector;
            local v32 = p26 - (v31 - Vector3.new(LookVector.X, 0, LookVector.Z).Unit * HumanoidRootPart2.Size.Y * 0.125).Position + CurrentCamera.CFrame.Position;
            local v33 = Vector3.new(v32.X, p26.Y, v32.Z);
            v27 = CurrentCamera.CFrame.Rotation + v33;
        else
            v27 = CurrentCamera.CFrame.Rotation + Vector3.new(CurrentCamera.CFrame.Position.X, p26.Y, CurrentCamera.CFrame.Position.Z);
        end;

        local v34 = p21:getRotation(p22);

        if math.abs(v34) > 0 then
            local v35 = VRService:GetUserCFrame(Enum.UserCFrame.Head);
            local v36 = v35.Rotation + v35.Position * CurrentCamera.HeadScale;
            local v37 = v27 * v36;
            v27 = CFrame.new(v37.Position) * CFrame.Angles(0, -math.rad(v34 * 90), 0) * v37.Rotation * v36:Inverse();
        end;
    end;

    return v27, v27 * CFrame.new(0, 0, -0.5);
end;

function u2.UpdateThirdPersonComfortTransform(p38, p39, p40, p41, p42, p43) -- Line: 277
    -- upvalues: Players (copy), VRService (copy)
    local v44 = p38:GetCameraToSubjectDistance();
    local v45 = v44 < 0.5 and 0.5 or v44;

    if p42 ~= nil and p38.lastCameraFocus ~= nil then
        local _ = Players.LocalPlayer;
        local v46 = p38.controlModule:GetMoveVector();
        local v47 = (p42 - p43).magnitude > 0.01 and true or v46.magnitude > 0.01;

        if v47 then
            p38.motionDetTime = 0.1;
        end;

        p38.motionDetTime = p38.motionDetTime - p39;

        if (p38.motionDetTime > 0 and true or v47) and not p38.needsReset then
            local lastCameraFocus = p38.lastCameraFocus;
            p38.VRCameraFocusFrozen = true;

            return p40, lastCameraFocus;
        end;

        local v48 = p38.lastCameraResetPosition == nil and true or (p43 - p38.lastCameraResetPosition).Magnitude > 1;
        local v49 = p38:getRotation(p39);

        if math.abs(v49) > 0 then
            local v50 = p41:ToObjectSpace(p40);
            p40 = p41 * CFrame.Angles(0, -v49, 0) * v50;
        end;

        if p38.VRCameraFocusFrozen and v48 or p38.needsReset then
            VRService:RecenterUserHeadCFrame();
            p38.VRCameraFocusFrozen = false;
            p38.needsReset = false;
            p38.lastCameraResetPosition = p43;
            p38:ResetZoom();
            p38:StartFadeFromBlack();
            local v51 = p38:GetHumanoid();
            local v52 = v51.Torso and v51.Torso.CFrame.lookVector or Vector3.new(1, 0, 0);
            local v53 = Vector3.new(v52.X, 0, v52.Z);
            local v54 = p41.Position - v53 * v45;
            local v55 = Vector3.new(p41.Position.X, v54.Y, p41.Position.Z);
            p40 = CFrame.new(v54, v55);
        end;
    end;

    return p40, p41;
end;

function u2.UpdateThirdPersonFollowTransform(p56, p57, p58, p59, p60, p61) -- Line: 344
    -- upvalues: VRService (copy), Players (copy), u1 (copy)
    local CurrentCamera = workspace.CurrentCamera;
    local v62 = p56:GetCameraToSubjectDistance();
    local v63 = p56:GetVRFocus(p61, p57);

    if p56.needsReset then
        p56.needsReset = false;
        VRService:RecenterUserHeadCFrame();
        p56:ResetZoom();
        p56:StartFadeFromBlack();
    end;

    if p56.recentered then
        local v64 = p56:GetSubjectCFrame();

        if not v64 then
            return CurrentCamera.CFrame, CurrentCamera.Focus;
        end;

        local v65 = v63 * v64.Rotation * CFrame.new(0, 0, v62);
        p56.focusOffset = v63:ToObjectSpace(v65);
        p56.recentered = false;

        return v65, v63;
    end;

    local v66 = v63:ToWorldSpace(p56.focusOffset);
    local _ = Players.LocalPlayer;
    local controlModule = p56.controlModule;
    local v67 = controlModule:GetMoveVector();

    if (p60 - p61).magnitude > 0.01 or v67.magnitude > 0 then
        local v68 = controlModule:GetEstimatedVRTorsoFrame();
        local v69 = CurrentCamera.CFrame * (v68.Rotation + v68.Position * CurrentCamera.HeadScale);
        local LookVector = v69.LookVector;
        local v70 = Vector3.new(LookVector.X, 0, LookVector.Z).Unit * v62;
        v66 = v66:Lerp(CFrame.new(CurrentCamera.CFrame.Position + (v63.Position - v70) - v69.Position) * v66.Rotation, 0.01);
    end;

    local v71 = p56:getRotation(p57);

    if math.abs(v71) > 0 then
        local v72 = v63:ToObjectSpace(v66);
        v66 = v63 * CFrame.Angles(0, -v71, 0) * v72;
    end;

    p56.focusOffset = v63:ToObjectSpace(v66);
    local v73 = v66 * CFrame.new(0, 0, -v62);

    if not u1 and (v73.Position - CurrentCamera.Focus.Position).Magnitude > 0.01 then
        p56:StartVREdgeBlur(Players.LocalPlayer);
    end;

    return v66, v73;
end;

function u2.LeaveFirstPerson(p74) -- Line: 424
    -- upvalues: VRBaseCamera (copy)
    VRBaseCamera.LeaveFirstPerson(p74);
    p74.needsReset = true;

    if p74.VRBlur then
        p74.VRBlur.Visible = false;
    end;

    if p74.characterOrientation then
        p74.characterOrientation.Enabled = false;
    end;

    local v75 = p74:GetHumanoid();

    if v75 then
        v75.AutoRotate = p74.savedAutoRotate;
    end;
end;

return u2;