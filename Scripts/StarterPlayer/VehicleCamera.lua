--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     VehicleCamera
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.VehicleCamera
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:09 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = { 0, 15, 30 };
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"));
local CameraInput = require(script.Parent:WaitForChild("CameraInput"));
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"));
require(script.Parent:WaitForChild("ZoomController"));
local VehicleCameraCore = require(script:WaitForChild("VehicleCameraCore"));
local VehicleCameraConfig = require(script:WaitForChild("VehicleCameraConfig"));
local LocalPlayer = Players.LocalPlayer;
local _ = CameraUtils.map;
local Spring = CameraUtils.Spring;
local mapClamp = CameraUtils.mapClamp;
local sanitizeAngle = CameraUtils.sanitizeAngle;

local function pitchVelocity(p2, p3) -- Line: 31
    local v4 = p3.XVector:Dot(p2);

    return math.abs(v4);
end;

local function yawVelocity(p5, p6) -- Line: 36
    local v7 = p6.YVector:Dot(p5);

    return math.abs(v7);
end;

local u8 = 0.016666666666666666;
RunService.Stepped:Connect(function(p9, p10) -- Line: 42
    -- upvalues: u8 (ref)
    u8 = p10;
end);
local u11 = setmetatable({}, BaseCamera);
u11.__index = u11;

function u11.new() -- Line: 49
    -- upvalues: BaseCamera (copy), u11 (copy)
    local v12 = BaseCamera.new();
    local v13 = setmetatable(v12, u11);
    v13:Reset();

    return v13;
end;

function u11.Reset(p14) -- Line: 55
    -- upvalues: VehicleCameraCore (copy), Spring (copy), VehicleCameraConfig (copy), CameraUtils (copy), u1 (copy)
    p14.vehicleCameraCore = VehicleCameraCore.new(p14:GetSubjectCFrame());
    p14.pitchSpring = Spring.new(0, -math.rad(VehicleCameraConfig.pitchBaseAngle));
    p14.yawSpring = Spring.new(0, 0);
    p14.lastPanTick = 0;
    local CurrentCamera = workspace.CurrentCamera;
    local v15;

    if CurrentCamera then
        v15 = CurrentCamera.CameraSubject;
    else
        v15 = CurrentCamera;
    end;

    assert(CurrentCamera);
    assert(v15);
    assert(v15:IsA("VehicleSeat"));
    local v16 = v15:GetConnectedParts(true);
    local v17, v18 = CameraUtils.getLooseBoundingSphere(v16);
    p14.assemblyRadius = math.max(v18, 5);
    p14.assemblyOffset = v15.CFrame:Inverse() * v17;
    p14.gamepadZoomLevels = {};

    for _, v in u1 do
        table.insert(p14.gamepadZoomLevels, v * p14.assemblyRadius / 10);
    end;

    p14:SetCameraToSubjectDistance(p14.gamepadZoomLevels[#p14.gamepadZoomLevels]);
end;

function u11._StepRotation(p19, p20, p21) -- Line: 85
    -- upvalues: CameraInput (copy), sanitizeAngle (copy), VehicleCameraConfig (copy), mapClamp (copy)
    local yawSpring = p19.yawSpring;
    local pitchSpring = p19.pitchSpring;
    local v22 = CameraInput.getRotation(p20, true);
    local v23 = -v22.Y;
    yawSpring.pos = sanitizeAngle(yawSpring.pos + -v22.X);
    pitchSpring.pos = sanitizeAngle((math.clamp(pitchSpring.pos + v23, -1.3962634015954636, 1.3962634015954636)));

    if CameraInput.getRotationActivated() then
        p19.lastPanTick = os.clock();
    end;

    local v24 = -math.rad(VehicleCameraConfig.pitchBaseAngle);
    local v25 = math.rad(VehicleCameraConfig.pitchDeadzoneAngle);

    if os.clock() - p19.lastPanTick > VehicleCameraConfig.autocorrectDelay then
        local v26 = mapClamp(p21, VehicleCameraConfig.autocorrectMinCarSpeed, VehicleCameraConfig.autocorrectMaxCarSpeed, 0, VehicleCameraConfig.autocorrectResponse);
        yawSpring.freq = v26;
        pitchSpring.freq = v26;

        if yawSpring.freq < 0.001 then
            yawSpring.vel = 0;
        end;

        if pitchSpring.freq < 0.001 then
            pitchSpring.vel = 0;
        end;

        local v27 = sanitizeAngle(v24 - pitchSpring.pos);

        if math.abs(v27) <= v25 then
            pitchSpring.goal = pitchSpring.pos;
        else
            pitchSpring.goal = v24;
        end;
    else
        yawSpring.freq = 0;
        yawSpring.vel = 0;
        pitchSpring.freq = 0;
        pitchSpring.vel = 0;
        pitchSpring.goal = v24;
    end;

    return CFrame.fromEulerAnglesYXZ(pitchSpring:step(p20), yawSpring:step(p20), 0);
end;

function u11._GetThirdPersonLocalOffset(p28) -- Line: 148
    -- upvalues: VehicleCameraConfig (copy)
    return p28.assemblyOffset + Vector3.new(0, p28.assemblyRadius * VehicleCameraConfig.verticalCenterOffset, 0);
end;

function u11._GetFirstPersonLocalOffset(p29, p30) -- Line: 152
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character and Character.Parent then
        local Head = Character:FindFirstChild("Head");

        if Head and Head:IsA("BasePart") then
            return p30:Inverse() * Head.Position;
        end;
    end;

    return p29:_GetThirdPersonLocalOffset();
end;

function u11.Update(p31) -- Line: 166
    -- upvalues: u8 (ref), mapClamp (copy)
    local CurrentCamera = workspace.CurrentCamera;
    local v32;

    if CurrentCamera then
        v32 = CurrentCamera.CameraSubject;
    else
        v32 = CurrentCamera;
    end;

    local vehicleCameraCore = p31.vehicleCameraCore;
    assert(CurrentCamera);
    assert(v32);
    assert(v32:IsA("VehicleSeat"));
    local v33 = u8;
    u8 = 0;
    local v34 = p31:GetSubjectCFrame();
    local v35 = p31:GetSubjectVelocity();
    local v36 = p31:GetSubjectRotVelocity();
    local v37 = v35:Dot(v34.ZVector);
    local v38 = math.abs(v37);
    local v39 = v34.YVector:Dot(v36);
    local v40 = math.abs(v39);
    local v41 = v34.XVector:Dot(v36);
    local v42 = math.abs(v41);
    local v43 = p31:StepZoom();
    local v44 = p31:_StepRotation(v33, v38);
    local v45 = mapClamp(v43, 0.5, p31.assemblyRadius, 1, 0);
    local v46 = p31:_GetThirdPersonLocalOffset():Lerp(p31:_GetFirstPersonLocalOffset(v34), v45);
    vehicleCameraCore:setTransform(v34);
    local v47 = vehicleCameraCore:step(v33, v42, v40, v45);
    local v48 = CFrame.new(v34 * v46) * v47 * v44;

    return v48 * CFrame.new(0, 0, v43), v48;
end;

function u11.ApplyVRTransform(p49) -- Line: 211
end;

return u11;