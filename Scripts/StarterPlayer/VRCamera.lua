--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     VRCamera
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.VRCamera
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:10 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local VRService = game:GetService("VRService");
UserSettings():GetService("UserGameSettings");
require(script.Parent:WaitForChild("CameraInput"));
require(script.Parent:WaitForChild("CameraUtils"));
local VRCameraTeleportDetector = require(script.Parent:WaitForChild("VRCameraTeleportDetector"));
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local FlagUtil = require(CommonUtils:WaitForChild("FlagUtil"));
local u1 = FlagUtil.getUserFlag("UserVRRemoveLuaEdgeBlur");
local u2 = FlagUtil.getUserFlag("UserVRRecenterOnExternalTeleport");
local VRBaseCamera = require(script.Parent:WaitForChild("VRBaseCamera"));
local u3 = setmetatable({}, VRBaseCamera);
u3.__index = u3;

function u3.new() -- Line: 34
    -- upvalues: VRBaseCamera (copy), u3 (copy), Players (copy)
    local v4 = VRBaseCamera.new();
    local v5 = setmetatable(v4, u3);
    v5.lastUpdate = tick();
    v5.focusOffset = CFrame.new();
    v5:Reset();
    v5.controlModule = require(Players.LocalPlayer:WaitForChild("PlayerScripts").PlayerModule:WaitForChild("ControlModule"));
    v5.savedAutoRotate = true;

    return v5;
end;

function u3.Reset(p6) -- Line: 47
    -- upvalues: VRBaseCamera (copy)
    p6.needsReset = true;
    p6.needsBlackout = true;
    p6.motionDetTime = 0;
    p6.blackOutTimer = 0;
    p6.lastCameraResetPosition = nil;
    VRBaseCamera.Reset(p6);
end;

function u3.Update(p7, p8) -- Line: 56
    -- upvalues: Players (copy), u1 (copy), VRService (copy)
    local CurrentCamera = workspace.CurrentCamera;
    local CFrame2 = CurrentCamera.CFrame;
    local Focus = CurrentCamera.Focus;
    local LocalPlayer = Players.LocalPlayer;
    p7:GetHumanoid();
    local _ = CurrentCamera.CameraSubject;

    if p7.lastUpdate == nil or p8 > 1 then
        p7.lastCameraTransform = nil;
    end;

    p7:UpdateFadeFromBlack(p8);

    if not u1 then
        p7:UpdateEdgeBlur(LocalPlayer, p8);
    end;

    local lastSubjectPosition = p7.lastSubjectPosition;
    local v9 = p7:GetSubjectPosition();

    if p7.needsBlackout then
        p7:StartFadeFromBlack();
        local v10 = math.clamp(p8, 0.0001, 0.1);
        p7.blackOutTimer = p7.blackOutTimer + v10;

        if p7.blackOutTimer > 0.1 and game:IsLoaded() then
            p7.needsBlackout = false;
            p7.needsReset = true;
        end;
    end;

    if v9 and (LocalPlayer and CurrentCamera) then
        local v11 = p7:GetVRFocus(v9, p8);

        if p7:IsInFirstPerson() then
            if VRService.AvatarGestures then
                CFrame2, Focus = p7:UpdateImmersionCamera(p8, CFrame2, v11, lastSubjectPosition, v9);
            else
                CFrame2, Focus = p7:UpdateFirstPersonTransform(p8, CFrame2, v11, lastSubjectPosition, v9);
            end;
        elseif VRService.ThirdPersonFollowCamEnabled then
            CFrame2, Focus = p7:UpdateThirdPersonFollowTransform(p8, CFrame2, v11, lastSubjectPosition, v9);
        else
            CFrame2, Focus = p7:UpdateThirdPersonComfortTransform(p8, CFrame2, v11, lastSubjectPosition, v9);
        end;

        p7.lastCameraTransform = CFrame2;
        p7.lastCameraFocus = Focus;
    end;

    p7.lastUpdate = tick();

    return CFrame2, Focus;
end;

function u3.GetAvatarFeetWorldYValue(p12) -- Line: 120
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

function u3.UpdateFirstPersonTransform(p13, p14, p15, p16, p17, p18) -- Line: 135
    -- upvalues: Players (copy), u1 (copy)
    if p13.needsReset then
        p13:StartFadeFromBlack();
        p13.needsReset = false;
    end;

    local LocalPlayer = Players.LocalPlayer;

    if not u1 and (p17 - p18).magnitude > 0.01 then
        p13:StartVREdgeBlur(LocalPlayer);
    end;

    local p = p16.p;
    local v19 = p13:GetCameraLookVector();
    local Unit = Vector3.new(v19.X, 0, v19.Z).Unit;
    local v20 = p13:getRotation(p14);
    local v21 = p13:CalculateNewLookVectorFromArg(Unit, Vector2.new(v20, 0));

    return CFrame.new(p - 0.5 * v21, p), p16;
end;

function u3.UpdateImmersionCamera(p22, p23, p24, p25, p26, p27) -- Line: 163
    -- upvalues: Players (copy), u2 (copy), VRService (copy), u1 (copy), VRCameraTeleportDetector (copy)
    local v28 = p22:GetSubjectCFrame();
    local CurrentCamera = workspace.CurrentCamera;
    local Character = Players.LocalPlayer.Character;
    local v29 = p22:GetHumanoid();

    if not v29 then
        return CurrentCamera.CFrame, CurrentCamera.Focus;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return CurrentCamera.CFrame, CurrentCamera.Focus;
    end;

    local v30;

    if u2 then
        v30 = not p26 and 0 or Vector3.new(p27.X - p26.X, 0, p27.Z - p26.Z).Magnitude;
    else
        v30 = nil;
    end;

    p22.characterOrientation = HumanoidRootPart:FindFirstChild("CharacterAlignOrientation");

    if not p22.characterOrientation then
        local RootAttachment = HumanoidRootPart:FindFirstChild("RootAttachment");

        if not RootAttachment then
            return;
        end;

        p22.characterOrientation = Instance.new("AlignOrientation");
        p22.characterOrientation.Name = "CharacterAlignOrientation";
        p22.characterOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
        p22.characterOrientation.Attachment0 = RootAttachment;
        p22.characterOrientation.RigidityEnabled = true;
        p22.characterOrientation.Parent = HumanoidRootPart;
    end;

    if p22.characterOrientation.Enabled == false then
        p22.characterOrientation.Enabled = true;
    end;

    if p22.needsReset then
        p22.needsReset = false;
        p22.savedAutoRotate = v29.AutoRotate;
        v29.AutoRotate = false;

        if u2 then
            VRService:RecenterUserHeadCFrame();
            p22.lastTeleportRecenter = tick();
        end;

        p22:StartFadeFromBlack();
    elseif v29.Sit then
        if not u1 and (v28.Position - CurrentCamera.CFrame.Position).Magnitude > 0.01 then
            p22:StartVREdgeBlur(Players.LocalPlayer);
        end;
    else
        local v31 = p22.controlModule:GetEstimatedVRTorsoFrame();
        p22.characterOrientation.CFrame = CurrentCamera.CFrame * v31;

        if p22.controlModule.inputMoveVector.Magnitude > 0 then
            p22.motionDetTime = 0.1;
        end;

        if p22.controlModule.inputMoveVector.Magnitude > 0 or p22.motionDetTime > 0 then
            p22.motionDetTime = p22.motionDetTime - p23;

            if not u1 then
                p22:StartVREdgeBlur(Players.LocalPlayer);
            end;

            local v32 = VRService:GetUserCFrame(Enum.UserCFrame.Head);
            local HumanoidRootPart2 = Character.HumanoidRootPart;
            local v33 = CurrentCamera.CFrame * (v32.Rotation + v32.Position * CurrentCamera.HeadScale) * CFrame.new(0, -0.7 * HumanoidRootPart2.Size.Y / 2, 0);
            local LookVector = HumanoidRootPart2.CFrame.LookVector;
            local v34 = p27 - (v33 - Vector3.new(LookVector.X, 0, LookVector.Z).Unit * HumanoidRootPart2.Size.Y * 0.125).Position + CurrentCamera.CFrame.Position;
            local v35 = Vector3.new(v34.X, p27.Y, v34.Z);
            v28 = CurrentCamera.CFrame.Rotation + v35;
        elseif u2 and VRCameraTeleportDetector.shouldRecenter(p22.prevSubjStep, v30, p22.lastTeleportRecenter, tick()) then
            local v36 = VRService:GetUserCFrame(Enum.UserCFrame.Head);
            local HumanoidRootPart2 = Character.HumanoidRootPart;
            local v37 = CurrentCamera.CFrame * (v36.Rotation + v36.Position * CurrentCamera.HeadScale) * CFrame.new(0, -0.7 * HumanoidRootPart2.Size.Y / 2, 0);
            local LookVector = HumanoidRootPart2.CFrame.LookVector;
            local v38 = p27 - (v37 - Vector3.new(LookVector.X, 0, LookVector.Z).Unit * HumanoidRootPart2.Size.Y * 0.125).Position + CurrentCamera.CFrame.Position;
            local v39 = Vector3.new(v38.X, p27.Y, v38.Z);
            v28 = CurrentCamera.CFrame.Rotation + v39;
            VRService:RecenterUserHeadCFrame();
            p22:StartFadeFromBlack();
            p22.lastTeleportRecenter = tick();
        else
            v28 = CurrentCamera.CFrame.Rotation + Vector3.new(CurrentCamera.CFrame.Position.X, p27.Y, CurrentCamera.CFrame.Position.Z);
        end;

        local v40 = p22:getRotation(p23);

        if math.abs(v40) > 0 then
            local v41 = VRService:GetUserCFrame(Enum.UserCFrame.Head);
            local v42 = v41.Rotation + v41.Position * CurrentCamera.HeadScale;
            local v43 = v28 * v42;
            v28 = CFrame.new(v43.Position) * CFrame.Angles(0, -math.rad(v40 * 90), 0) * v43.Rotation * v42:Inverse();
        end;
    end;

    if u2 then
        p22.prevSubjStep = v30;
    end;

    return v28, v28 * CFrame.new(0, 0, -0.5);
end;

function u3.UpdateThirdPersonComfortTransform(p44, p45, p46, p47, p48, p49) -- Line: 320
    -- upvalues: Players (copy), VRService (copy)
    local v50 = p44:GetCameraToSubjectDistance();
    local v51 = v50 < 0.5 and 0.5 or v50;

    if p48 ~= nil and p44.lastCameraFocus ~= nil then
        local _ = Players.LocalPlayer;
        local v52 = p44.controlModule:GetMoveVector();
        local v53 = (p48 - p49).magnitude > 0.01 and true or v52.magnitude > 0.01;

        if v53 then
            p44.motionDetTime = 0.1;
        end;

        p44.motionDetTime = p44.motionDetTime - p45;

        if (p44.motionDetTime > 0 and true or v53) and not p44.needsReset then
            local lastCameraFocus = p44.lastCameraFocus;
            p44.VRCameraFocusFrozen = true;

            return p46, lastCameraFocus;
        end;

        local v54 = p44.lastCameraResetPosition == nil and true or (p49 - p44.lastCameraResetPosition).Magnitude > 1;
        local v55 = p44:getRotation(p45);

        if math.abs(v55) > 0 then
            local v56 = p47:ToObjectSpace(p46);
            p46 = p47 * CFrame.Angles(0, -v55, 0) * v56;
        end;

        if p44.VRCameraFocusFrozen and v54 or p44.needsReset then
            VRService:RecenterUserHeadCFrame();
            p44.VRCameraFocusFrozen = false;
            p44.needsReset = false;
            p44.lastCameraResetPosition = p49;
            p44:ResetZoom();
            p44:StartFadeFromBlack();
            local v57 = p44:GetHumanoid();
            local v58 = v57.Torso and v57.Torso.CFrame.lookVector or Vector3.new(1, 0, 0);
            local v59 = Vector3.new(v58.X, 0, v58.Z);
            local v60 = p47.Position - v59 * v51;
            local v61 = Vector3.new(p47.Position.X, v60.Y, p47.Position.Z);
            p46 = CFrame.new(v60, v61);
        end;
    end;

    return p46, p47;
end;

function u3.UpdateThirdPersonFollowTransform(p62, p63, p64, p65, p66, p67) -- Line: 387
    -- upvalues: VRService (copy), Players (copy), u1 (copy)
    local CurrentCamera = workspace.CurrentCamera;
    local v68 = p62:GetCameraToSubjectDistance();
    local v69 = p62:GetVRFocus(p67, p63);

    if p62.needsReset then
        p62.needsReset = false;
        VRService:RecenterUserHeadCFrame();
        p62:ResetZoom();
        p62:StartFadeFromBlack();
    end;

    if p62.recentered then
        local v70 = p62:GetSubjectCFrame();

        if not v70 then
            return CurrentCamera.CFrame, CurrentCamera.Focus;
        end;

        local v71 = v69 * v70.Rotation * CFrame.new(0, 0, v68);
        p62.focusOffset = v69:ToObjectSpace(v71);
        p62.recentered = false;

        return v71, v69;
    end;

    local v72 = v69:ToWorldSpace(p62.focusOffset);
    local _ = Players.LocalPlayer;
    local controlModule = p62.controlModule;
    local v73 = controlModule:GetMoveVector();

    if (p66 - p67).magnitude > 0.01 or v73.magnitude > 0 then
        local v74 = controlModule:GetEstimatedVRTorsoFrame();
        local v75 = CurrentCamera.CFrame * (v74.Rotation + v74.Position * CurrentCamera.HeadScale);
        local LookVector = v75.LookVector;
        local v76 = Vector3.new(LookVector.X, 0, LookVector.Z).Unit * v68;
        v72 = v72:Lerp(CFrame.new(CurrentCamera.CFrame.Position + (v69.Position - v76) - v75.Position) * v72.Rotation, 0.01);
    end;

    local v77 = p62:getRotation(p63);

    if math.abs(v77) > 0 then
        local v78 = v69:ToObjectSpace(v72);
        v72 = v69 * CFrame.Angles(0, -v77, 0) * v78;
    end;

    p62.focusOffset = v69:ToObjectSpace(v72);
    local v79 = v72 * CFrame.new(0, 0, -v68);

    if not u1 and (v79.Position - CurrentCamera.Focus.Position).Magnitude > 0.01 then
        p62:StartVREdgeBlur(Players.LocalPlayer);
    end;

    return v72, v79;
end;

function u3.LeaveFirstPerson(p80) -- Line: 467
    -- upvalues: VRBaseCamera (copy)
    VRBaseCamera.LeaveFirstPerson(p80);
    p80.needsReset = true;

    if p80.VRBlur then
        p80.VRBlur.Visible = false;
    end;

    if p80.characterOrientation then
        p80.characterOrientation.Enabled = false;
    end;

    local v81 = p80:GetHumanoid();

    if v81 then
        v81.AutoRotate = p80.savedAutoRotate;
    end;
end;

return u3;