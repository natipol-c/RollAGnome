--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     VRVehicleCameraDeprecated
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.VRVehicleCameraDeprecated
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:09 2026
]]

-- Decompiled with Potassium's decompiler.

local success, result = pcall(function() -- Line: 9
    return UserSettings():IsUserFeatureEnabled("UserVRVehicleCamera2");
end);
local u1 = success and result;
local u2 = { 0, 30 };
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local VRBaseCamera = require(script.Parent:WaitForChild("VRBaseCamera"));
local CameraInput = require(script.Parent:WaitForChild("CameraInput"));
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"));
require(script.Parent:WaitForChild("VehicleCamera"));
local VehicleCameraCore = require(script.Parent.VehicleCamera:FindFirstChild("VehicleCameraCore"));
local VehicleCameraConfig = require(script.Parent.VehicleCamera:FindFirstChild("VehicleCameraConfig"));
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local VRService = game:GetService("VRService");
local LocalPlayer = Players.LocalPlayer;
local Spring = CameraUtils.Spring;
local mapClamp = CameraUtils.mapClamp;
local sanitizeAngle = CameraUtils.sanitizeAngle;

local function pitchVelocity(p3, p4) -- Line: 46
    local v5 = p4.XVector:Dot(p3);

    return math.abs(v5);
end;

local function yawVelocity(p6, p7) -- Line: 51
    local v8 = p7.YVector:Dot(p6);

    return math.abs(v8);
end;

local u9 = 0.016666666666666666;
local u10 = setmetatable({}, VRBaseCamera);
u10.__index = u10;

function u10.new() -- Line: 59
    -- upvalues: VRBaseCamera (copy), u10 (copy), RunService (copy), u9 (ref)
    local v11 = VRBaseCamera.new();
    local v12 = setmetatable(v11, u10);
    v12:Reset();
    RunService.Stepped:Connect(function(p13, p14) -- Line: 64
        -- upvalues: u9 (ref)
        u9 = p14;
    end);

    return v12;
end;

function u10.Reset(p15) -- Line: 72
    -- upvalues: VehicleCameraCore (copy), u1 (ref), Spring (copy), VehicleCameraConfig (copy), CameraUtils (copy), u2 (copy)
    p15.vehicleCameraCore = VehicleCameraCore.new(p15:GetSubjectCFrame());

    if u1 then
        p15.pitchSpring = Spring.new(0, 0);
    else
        p15.pitchSpring = Spring.new(0, -math.rad(VehicleCameraConfig.pitchBaseAngle));
    end;

    p15.yawSpring = Spring.new(0, 0);

    if u1 then
        p15.lastPanTick = 0;
        p15.currentDriftAngle = 0;
        p15.needsReset = true;
    end;

    local CurrentCamera = workspace.CurrentCamera;
    local v16;

    if CurrentCamera then
        v16 = CurrentCamera.CameraSubject;
    else
        v16 = CurrentCamera;
    end;

    assert(CurrentCamera, "VRVehicleCamera initialization error");
    assert(v16);
    assert(v16:IsA("VehicleSeat"));
    local v17 = v16:GetConnectedParts(true);
    local v18, v19 = CameraUtils.getLooseBoundingSphere(v17);
    p15.assemblyRadius = math.max(v19, 5);
    p15.assemblyOffset = v16.CFrame:Inverse() * v18;
    p15.gamepadZoomLevels = {};

    for _, v in u2 do
        table.insert(p15.gamepadZoomLevels, v * p15.headScale * p15.assemblyRadius / 10);
    end;

    p15.lastCameraFocus = nil;
    p15:SetCameraToSubjectDistance(p15.gamepadZoomLevels[#p15.gamepadZoomLevels]);
end;

function u10._StepRotation(p20, p21, p22) -- Line: 112
    -- upvalues: sanitizeAngle (copy), CameraInput (copy), VehicleCameraConfig (copy), mapClamp (copy)
    local yawSpring = p20.yawSpring;
    local pitchSpring = p20.pitchSpring;
    local v23 = -p20:getRotation(p21);
    yawSpring.pos = sanitizeAngle(yawSpring.pos + v23);
    pitchSpring.pos = sanitizeAngle((math.clamp(pitchSpring.pos, -1.3962634015954636, 1.3962634015954636)));

    if CameraInput.getRotationActivated() then
        p20.lastPanTick = os.clock();
    end;

    local v24 = math.rad(VehicleCameraConfig.pitchDeadzoneAngle);

    if os.clock() - p20.lastPanTick > VehicleCameraConfig.autocorrectDelay then
        local v25 = mapClamp(p22, VehicleCameraConfig.autocorrectMinCarSpeed, VehicleCameraConfig.autocorrectMaxCarSpeed, 0, VehicleCameraConfig.autocorrectResponse);
        yawSpring.freq = v25;
        pitchSpring.freq = v25;

        if yawSpring.freq < 0.001 then
            yawSpring.vel = 0;
        end;

        if pitchSpring.freq < 0.001 then
            pitchSpring.vel = 0;
        end;

        local v26 = sanitizeAngle(0 - pitchSpring.pos);

        if math.abs(v26) <= v24 then
            pitchSpring.goal = pitchSpring.pos;
        else
            pitchSpring.goal = 0;
        end;
    else
        yawSpring.freq = 0;
        yawSpring.vel = 0;
        pitchSpring.freq = 0;
        pitchSpring.vel = 0;
        pitchSpring.goal = 0;
    end;

    return CFrame.fromEulerAnglesYXZ(pitchSpring:step(p21), yawSpring:step(p21), 0);
end;

function u10._GetThirdPersonLocalOffset(p27) -- Line: 176
    -- upvalues: VehicleCameraConfig (copy)
    return p27.assemblyOffset + Vector3.new(0, p27.assemblyRadius * VehicleCameraConfig.verticalCenterOffset, 0);
end;

function u10._GetFirstPersonLocalOffset(p28, p29) -- Line: 180
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character and Character.Parent then
        local Head = Character:FindFirstChild("Head");

        if Head and Head:IsA("BasePart") then
            return p29:Inverse() * Head.Position;
        end;
    end;

    return p28:_GetThirdPersonLocalOffset();
end;

function u10.Update(p30) -- Line: 194
    -- upvalues: u1 (ref), u9 (ref), LocalPlayer (copy), VRService (copy)
    if not u1 then
        return p30:UpdateComfortCamera();
    end;

    local v31 = u9;
    u9 = 0;
    p30:UpdateFadeFromBlack(v31);
    p30:UpdateEdgeBlur(LocalPlayer, v31);

    if VRService.ThirdPersonFollowCamEnabled then
        local v32, v33 = p30:UpdateStepRotation(v31);

        return v32, v33;
    end;

    local v34, v35 = p30:UpdateComfortCamera(v31);

    return v34, v35;
end;

function u10.addDrift(p36, p37, p38) -- Line: 217
    -- upvalues: LocalPlayer (copy), VRService (copy)
    local function NormalizeAngle(p39) -- Line: 218
        local v40 = (p39 + 12.566370614359172) % 6.283185307179586;

        if v40 > 3.141592653589793 then
            v40 = v40 - 6.283185307179586;
        end;

        return v40;
    end;

    local CurrentCamera = workspace.CurrentCamera;
    local v41 = p36:GetCameraToSubjectDistance();
    local v42 = p36:GetSubjectVelocity();
    local v43 = p36:GetSubjectCFrame();
    require(LocalPlayer:WaitForChild("PlayerScripts").PlayerModule:WaitForChild("ControlModule"));

    if v42.Magnitude > 0.1 then
        local v44 = VRService:GetUserCFrame(Enum.UserCFrame.Head);
        local v45 = CurrentCamera.CFrame * (v44.Rotation + v44.Position * CurrentCamera.HeadScale);
        local _, v46, _ = v45:ToEulerAnglesYXZ();
        local _, v47, _ = v43:ToEulerAnglesYXZ();
        local v48 = (v46 - p36.currentDriftAngle + 12.566370614359172) % 6.283185307179586;

        if v48 > 3.141592653589793 then
            v48 = v48 - 6.283185307179586;
        end;

        local v49 = (v47 - p36.currentDriftAngle + 12.566370614359172) % 6.283185307179586;

        if v49 > 3.141592653589793 then
            v49 = v49 - 6.283185307179586;
        end;

        local v50 = math.min(v49, v48);
        local v51 = math.max(v49, v48);
        local v52 = 0;

        if v50 > 0 then
            v51 = v50;
        elseif v51 >= 0 then
            v51 = v52;
        end;

        p36.currentDriftAngle = v51 + p36.currentDriftAngle;
        local LookVector = CFrame.fromEulerAnglesYXZ(0, p36.currentDriftAngle, 0).LookVector;
        local v53 = Vector3.new(LookVector.X, 0, LookVector.Z).Unit * v41;
        p37 = p37:Lerp(CFrame.new(CurrentCamera.CFrame.Position + (p38.Position - v53) - v45.Position) * CurrentCamera.CFrame.Rotation, 0.01);
    end;

    return p37, p38;
end;

function u10.UpdateRotationCamera(p54, p55) -- Line: 275
    -- upvalues: mapClamp (copy), LocalPlayer (copy)
    local CurrentCamera = workspace.CurrentCamera;
    local v56;

    if CurrentCamera then
        v56 = CurrentCamera.CameraSubject;
    else
        v56 = CurrentCamera;
    end;

    local vehicleCameraCore = p54.vehicleCameraCore;
    assert(CurrentCamera);
    assert(v56);
    assert(v56:IsA("VehicleSeat"));
    local v57 = p54:GetSubjectCFrame();
    local v58 = p54:GetSubjectVelocity();
    local v59 = p54:GetSubjectRotVelocity();
    local v60 = v58:Dot(v57.ZVector);
    local v61 = math.abs(v60);
    local v62 = v57.YVector:Dot(v59);
    local v63 = math.abs(v62);
    local v64 = v57.XVector:Dot(v59);
    local v65 = math.abs(v64);
    local v66 = p54:GetCameraToSubjectDistance();
    local v67 = mapClamp(v66, 0.5, p54.assemblyRadius, 1, 0);
    local v68 = p54:_GetThirdPersonLocalOffset():Lerp(p54:_GetFirstPersonLocalOffset(v57), v67);
    vehicleCameraCore:setTransform(v57);
    local v69 = vehicleCameraCore:step(p55, v65, v63, v67);
    local v70 = p54:_StepRotation(p55, v61);
    local v71 = p54:GetVRFocus(v57 * v68, p55) * v69 * v70;
    local v72 = v71 * CFrame.new(0, 0, v66);

    if v58.Magnitude > 0.1 then
        p54:StartVREdgeBlur(LocalPlayer);
    end;

    return v72, v71;
end;

function u10.UpdateStepRotation(p73, p74) -- Line: 322
    -- upvalues: mapClamp (copy), UserGameSettings (copy), VRService (copy), LocalPlayer (copy)
    local CurrentCamera = workspace.CurrentCamera;
    local lastSubjectCFrame = p73.lastSubjectCFrame;
    local v75 = p73:GetSubjectCFrame();
    local v76 = p73:GetSubjectVelocity();
    local v77 = p73:GetCameraToSubjectDistance();
    local v78 = mapClamp(v77, 0.5, p73.assemblyRadius, 1, 0);
    local v79 = p73:_GetThirdPersonLocalOffset():Lerp(p73:_GetFirstPersonLocalOffset(v75), v78);
    local v80 = p73:GetVRFocus(v75 * v79, p74);
    local v81, v82 = p73:addDrift(v80:ToWorldSpace(p73:GetVRFocus(lastSubjectCFrame * v79, p74):ToObjectSpace(CurrentCamera.CFrame)), v80);
    local v83 = p73:getRotation(p74);
    local v84;

    if math.abs(v83) > 0 then
        local v85 = v82:ToObjectSpace(v81);
        v84 = v82 * CFrame.Angles(0, -v83, 0) * v85;

        if not UserGameSettings.VRSmoothRotationEnabled then
            local v86 = VRService:GetUserCFrame(Enum.UserCFrame.Head);
            local v87 = v86.Rotation + v86.Position * CurrentCamera.HeadScale;
            local v88 = v82 * v75.Rotation;
            local v89 = v88:ToObjectSpace(v81 * v87);
            local v90 = Vector3.new(v89.X, 0, v89.Z).Unit:Dot(Vector3.new(0, 0, 1));
            local v91 = math.acos(v90);
            local v92 = v88:ToObjectSpace(v84 * v87);
            local v93 = Vector3.new(v92.X, 0, v92.Z).Unit:Dot(Vector3.new(0, 0, 1));

            if math.acos(v93) < v91 then
                if v83 < 0 then
                    v91 = v91 * -1;
                end;

                v84 = v82 * CFrame.Angles(0, -v91, 0) * v85;
            end;
        end;
    else
        v84 = v81;
    end;

    if v76.Magnitude > 0.1 then
        p73:StartVREdgeBlur(LocalPlayer);
    end;

    if p73.needsReset then
        p73.needsReset = false;
        VRService:RecenterUserHeadCFrame();
        p73:StartFadeFromBlack();
        p73:ResetZoom();
    end;

    if p73.recentered then
        v84 = v82 * v75.Rotation * CFrame.new(0, 0, v77);
        p73.recentered = false;
    end;

    return v84, v84 * CFrame.new(0, 0, -v77);
end;

function u10.UpdateComfortCamera(p94, p95) -- Line: 408
    -- upvalues: u1 (ref), u9 (ref), mapClamp (copy), LocalPlayer (copy)
    local CurrentCamera = workspace.CurrentCamera;
    local v96;

    if CurrentCamera then
        v96 = CurrentCamera.CameraSubject;
    else
        v96 = CurrentCamera;
    end;

    local vehicleCameraCore = p94.vehicleCameraCore;
    assert(CurrentCamera);
    assert(v96);
    assert(v96:IsA("VehicleSeat"));

    if not u1 then
        p95 = u9;
        u9 = 0;
    end;

    local v97 = p94:GetSubjectCFrame();
    local v98 = p94:GetSubjectVelocity();
    local v99 = p94:GetSubjectRotVelocity();
    local v100 = v98:Dot(v97.ZVector);
    math.abs(v100);
    local v101 = v97.YVector:Dot(v99);
    local v102 = math.abs(v101);
    local v103 = v97.XVector:Dot(v99);
    local v104 = math.abs(v103);
    local v105 = p94:StepZoom();
    local v106 = mapClamp(v105, 0.5, p94.assemblyRadius, 1, 0);
    local v107 = p94:_GetThirdPersonLocalOffset():Lerp(p94:_GetFirstPersonLocalOffset(v97), v106);
    vehicleCameraCore:setTransform(v97);
    local v108 = vehicleCameraCore:step(p95, v104, v102, v106);

    if not u1 then
        p94:UpdateFadeFromBlack(p95);
    end;

    local v109, v110;

    if p94:IsInFirstPerson() then
        local Unit = Vector3.new(v108.LookVector.X, 0, v108.LookVector.Z).Unit;
        local v111 = CFrame.new(v108.Position, Unit);
        v109 = CFrame.new(v97 * v107) * v111;
        v110 = v109 * CFrame.new(0, 0, v105);

        if u1 then
            if v98.Magnitude > 0.1 then
                p94:StartVREdgeBlur(LocalPlayer);
            end;
        else
            p94:StartVREdgeBlur(LocalPlayer);
        end;
    else
        v109 = CFrame.new(v97 * v107) * v108;
        v110 = v109 * CFrame.new(0, 0, v105);

        if not p94.lastCameraFocus then
            p94.lastCameraFocus = v109;
            p94.needsReset = true;
        end;

        local v112 = v109.Position - CurrentCamera.CFrame.Position;
        local magnitude = v112.magnitude;

        if v112.Unit:Dot(CurrentCamera.CFrame.LookVector) > 0.56 and (magnitude < 200 and not p94.needsReset) then
            v109 = p94.lastCameraFocus;
            local p = v109.p;
            local v113 = p94:GetCameraLookVector();
            local v114 = p94:CalculateNewLookVectorFromArg(Vector3.new(v113.X, 0, v113.Z).Unit, Vector2.new(0, 0));
            v110 = CFrame.new(p - v105 * v114, p);
        else
            p94.lastCameraFocus = p94:GetVRFocus(v97.Position, p95);
            p94.needsReset = false;
            p94:StartFadeFromBlack();
            p94:ResetZoom();
        end;

        if not u1 then
            p94:UpdateEdgeBlur(LocalPlayer, p95);
        end;
    end;

    return v110, v109;
end;

return u10;