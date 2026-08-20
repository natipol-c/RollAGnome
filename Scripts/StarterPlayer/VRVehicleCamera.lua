--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     VRVehicleCamera
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.VRVehicleCamera
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:10 2026
]]

-- Decompiled with Potassium's decompiler.

local success, result = pcall(function() -- Line: 8
    return UserSettings():IsUserFeatureEnabled("UserVRVehicleCameraOrbital");
end);
local u1 = success and result;
local u2 = { 0, 30 };
local VRBaseCamera = require(script.Parent:WaitForChild("VRBaseCamera"));
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"));
local CameraInput = require(script.Parent:WaitForChild("CameraInput"));
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local VRService = game:GetService("VRService");
local Lighting = game:GetService("Lighting");
local LocalPlayer = Players.LocalPlayer;
local mapClamp = CameraUtils.mapClamp;
local VehicleCameraConfig = require(script.Parent:WaitForChild("VehicleCamera"):FindFirstChild("VehicleCameraConfig"));
local u3 = RaycastParams.new();
u3.FilterType = Enum.RaycastFilterType.Exclude;
u3.IgnoreWater = true;

local function yawVelocity(p4, p5) -- Line: 44
    local v6 = p5.YVector:Dot(p4);

    return math.abs(v6);
end;

local function computeCameraCFrame(p7, p8, p9) -- Line: 48
    local v10 = math.atan2(p8.X, p8.Z);

    return CFrame.new(p7.Position + p8 * p9) * CFrame.Angles(0, v10, 0);
end;

local function vrOccludeDisplace(p11, p12, p13, p14) -- Line: 53
    -- upvalues: LocalPlayer (copy), u3 (copy)
    local v15 = math.atan2(p12.X, p12.Z);
    local v16 = CFrame.new(p11.Position + p12 * p13) * CFrame.Angles(0, v15, 0);
    local CurrentCamera = workspace.CurrentCamera;

    if not CurrentCamera then
        return v16;
    end;

    local Position = p11.Position;
    local v17 = (v16.Position - Position) * Vector3.new(1, 0, 1);
    local Magnitude = v17.Magnitude;

    if Magnitude < 0.5 then
        return v16;
    end;

    local v18 = { CurrentCamera };

    if p14 then
        table.insert(v18, p14);
    end;

    local v19 = LocalPlayer and LocalPlayer.Character;

    if v19 then
        table.insert(v18, v19);
    end;

    u3.FilterDescendantsInstances = v18;
    local Unit = v17.Unit;
    local v20 = workspace:Raycast(Position, v17, u3);

    if v20 and v20.Normal:Dot(Unit) < 0 then
        local v21 = (v20.Position - Position).Magnitude - 0.5;

        if v21 < Magnitude then
            local v22 = math.max(v21, 0.5);

            return CFrame.new(p11.Position + Unit * v22) * v16.Rotation;
        end;
    end;

    return v16;
end;

local u23 = OverlapParams.new();
u23.FilterType = Enum.RaycastFilterType.Exclude;

local function findObstructions(p24, p25, p26, p27) -- Line: 89
    -- upvalues: VRService (copy), LocalPlayer (copy), u3 (copy), u23 (copy)
    local CurrentCamera = workspace.CurrentCamera;

    if not CurrentCamera then
        return 0, {};
    end;

    local Position = p25.Position;
    local v28 = VRService:GetUserCFrame(Enum.UserCFrame.Head);
    local v29 = p24 * (CFrame.new(v28.Position * CurrentCamera.HeadScale) * v28.Rotation);
    local v30 = v29.Position - Position;
    local Magnitude = v30.Magnitude;

    if Magnitude < 0.5 then
        return 0, {};
    end;

    local v31 = { CurrentCamera };

    if p27 then
        table.insert(v31, p27);
    end;

    local v32 = LocalPlayer and LocalPlayer.Character;

    if v32 then
        table.insert(v31, v32);
    end;

    u3.FilterDescendantsInstances = v31;
    local v33 = workspace:Raycast(Position, v30, u3);

    if v33 then
        local Magnitude2 = (v33.Position - Position).Magnitude;

        if Magnitude2 < Magnitude then
            local v34 = (1 - -v30.Unit:Dot(v29.LookVector)) / 0.1339745962155613;
            local v35 = math.clamp(v34, 0, 1);
            local v36 = math.max(v35, 1 - Magnitude2 / p26, 0.15);
            local Position2 = v33.Position;
            local Position3 = v29.Position;
            local v37 = Vector3.new(2, 2, (Position3 - Position2).Magnitude);
            local v38 = CFrame.lookAt((Position2 + Position3) / 2, Position3);
            u23.FilterDescendantsInstances = v31;

            return v36, workspace:GetPartBoundsInBox(v38, v37, u23);
        end;
    end;

    return 0, {};
end;

local u39 = 0.016666666666666666;
local u40 = setmetatable({}, VRBaseCamera);
u40.__index = u40;

function u40.new() -- Line: 141
    -- upvalues: u1 (ref), VRBaseCamera (copy), u40 (copy), RunService (copy), u39 (ref)
    if not u1 then
        return require(script.Parent:WaitForChild("VRVehicleCameraDeprecated")).new();
    end;

    local v41 = VRBaseCamera.new();
    local v42 = setmetatable(v41, u40);
    v42.skipOcclusion = true;
    v42:Reset();

    if v42.thirdPersonOptionChanged then
        v42.thirdPersonOptionChanged:Disconnect();
        v42.thirdPersonOptionChanged = nil;
    end;

    RunService.Stepped:Connect(function(p43, p44) -- Line: 156
        -- upvalues: u39 (ref)
        u39 = p44;
    end);

    return v42;
end;

function u40.Reset(p45) -- Line: 163
    -- upvalues: CameraUtils (copy), u2 (copy)
    local CurrentCamera = workspace.CurrentCamera;
    local v46;

    if CurrentCamera then
        v46 = CurrentCamera.CameraSubject;
    else
        v46 = CurrentCamera;
    end;

    assert(CurrentCamera, "VRVehicleCamera initialization error");
    assert(v46);
    assert(v46:IsA("VehicleSeat"));
    p45.lastOrbitalDir = nil;
    p45.wasInFirstPerson = nil;
    local v47 = v46:GetConnectedParts(true);
    table.insert(v47, v46);
    local v48, v49 = CameraUtils.getLooseBoundingSphere(v47);
    p45.vehicleModel = v46:FindFirstAncestorOfClass("Model") or v46.Parent;
    p45.assemblyRadius = math.max(v49, 5);
    p45.assemblyOffset = v46.CFrame:Inverse() * v48;
    p45.gamepadZoomLevels = {};

    for _, v in u2 do
        table.insert(p45.gamepadZoomLevels, v * p45.headScale * p45.assemblyRadius / 10);
    end;

    p45.lastCameraFocus = nil;

    if not p45:IsInFirstPerson() then
        p45:SetCameraToSubjectDistance(p45.gamepadZoomLevels[#p45.gamepadZoomLevels]);
    end;

    p45.needsReset = false;
end;

function u40._getThirdPersonLocalOffset(p50) -- Line: 197
    -- upvalues: VehicleCameraConfig (copy)
    return p50.assemblyOffset + Vector3.new(0, p50.assemblyRadius * VehicleCameraConfig.verticalCenterOffset, 0);
end;

function u40._getFirstPersonLocalOffset(p51, p52) -- Line: 201
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character and Character.Parent then
        local Head = Character:FindFirstChild("Head");

        if Head and Head:IsA("BasePart") then
            return p52:Inverse() * Head.Position;
        end;
    end;

    return p51:_getThirdPersonLocalOffset();
end;

function u40._vrOccludeVignette(p53, p54, p55, p56) -- Line: 215
    -- upvalues: findObstructions (copy), Lighting (copy), LocalPlayer (copy)
    local v57 = math.atan2(p55.X, p55.Z);
    local v58 = CFrame.new(p54.Position + p55 * p56) * CFrame.Angles(0, v57, 0);
    local v59, v60 = findObstructions(v58, p54, p56, p53.vehicleModel);
    local VRFade = Lighting:FindFirstChild("VRFade");

    if not VRFade then
        VRFade = Instance.new("ColorCorrectionEffect");
        VRFade.Name = "VRFade";
        VRFade.Parent = Lighting;
    end;

    VRFade.Brightness = -v59;

    if p53.lastOccludedParts then
        for _, v in p53.lastOccludedParts do
            v.LocalTransparencyModifier = 0;
        end;
    end;

    if #v60 > 0 then
        for _, v in v60 do
            v.LocalTransparencyModifier = 1;
        end;

        p53:StartVREdgeBlur(LocalPlayer, true);
    end;

    p53.lastOccludedParts = v60;

    return v58;
end;

function u40.Update(p61) -- Line: 242
    -- upvalues: u39 (ref), LocalPlayer (copy)
    local v62 = u39;
    u39 = 0;
    p61:UpdateFadeFromBlack(v62);
    p61:UpdateEdgeBlur(LocalPlayer, v62);
    local v63, v64 = p61:_updateStepRotation(v62);

    return v63, v64;
end;

function u40._updateStepRotation(p65, p66) -- Line: 254
    -- upvalues: mapClamp (copy), CameraInput (copy), VehicleCameraConfig (copy), vrOccludeDisplace (copy)
    local v67 = p65:GetSubjectCFrame();
    local v68 = p65:GetCameraToSubjectDistance();
    local v69 = mapClamp(v68, 0.5, p65.assemblyRadius, 1, 0);
    local v70 = v67 * p65:_getThirdPersonLocalOffset():Lerp(p65:_getFirstPersonLocalOffset(v67), v69);
    local new = CFrame.new;
    local v71 = p65:GetCameraHeight();
    local v72 = new(v70 + Vector3.new(0, v71, 0));

    if p65.needsReset or p65.recentered then
        p65.lastOrbitalDir = nil;
        p65.needsReset = false;
        p65.recentered = false;
    end;

    local lastOrbitalDir = p65.lastOrbitalDir;

    if not lastOrbitalDir then
        lastOrbitalDir = (v67.LookVector * Vector3.new(-1, 0, -1)).Unit;
        p65:StartFadeFromBlack();
    end;

    local v73 = (p65:GetSubjectVelocity() * Vector3.new(1, 0, 1)).Magnitude > 2;

    if v73 then
        CameraInput.getRotation(p66);
    else
        local v74 = p65:getRotation(p66);

        if math.abs(v74) > 0 then
            lastOrbitalDir = (CFrame.Angles(0, -v74, 0) * CFrame.new(lastOrbitalDir)).Position.Unit;
            p65.lastRotateTime = os.clock();
        end;
    end;

    local v75;

    if p65:IsInFirstPerson() then
        if not p65.wasInFirstPerson or v73 then
            lastOrbitalDir = (v67.LookVector * Vector3.new(-1, 0, -1)).Unit;
            p65.wasInFirstPerson = true;
        end;

        local v76 = math.atan2(-v67.LookVector.X, -v67.LookVector.Z);

        if p65.lastVehicleYaw then
            local v77 = (v76 - p65.lastVehicleYaw + 3.141592653589793) % 6.283185307179586 - 3.141592653589793;

            if math.abs(v77) > 0.001 then
                lastOrbitalDir = (CFrame.Angles(0, v77, 0) * CFrame.new(lastOrbitalDir)).Position.Unit;
            end;
        end;

        p65.lastVehicleYaw = v76;
        local v78 = math.atan2(lastOrbitalDir.X, lastOrbitalDir.Z);
        v75 = CFrame.new(v72.Position + lastOrbitalDir * v68) * CFrame.Angles(0, v78, 0);
    else
        p65.wasInFirstPerson = false;
        p65.lastVehicleYaw = nil;
        local v79 = p65.lastRotateTime and os.clock() - p65.lastRotateTime < VehicleCameraConfig.autocorrectDelay;

        if v73 and not v79 then
            local Unit = (v67.LookVector * Vector3.new(-1, 0, -1)).Unit;
            local v80 = lastOrbitalDir:Dot(Unit);
            local v81 = math.clamp(v80, -1, 1);
            local v82 = math.acos(v81);
            local v83 = p65:GetSubjectRotVelocity();
            local v84 = v67.YVector:Dot(v83);
            local v85 = math.abs(v84);
            lastOrbitalDir = lastOrbitalDir:Lerp(Unit, (math.min(0.01 + v82 / 3.141592653589793 * 0.05 + v85 * 0.02, 0.15)));
        end;

        v75 = vrOccludeDisplace(v72, lastOrbitalDir, v68, p65.vehicleModel);
    end;

    p65.lastOrbitalDir = lastOrbitalDir;

    return v75, v75 * CFrame.new(0, 0, -v68);
end;

return u40;