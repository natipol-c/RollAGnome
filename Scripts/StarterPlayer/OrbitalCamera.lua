--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     OrbitalCamera
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.OrbitalCamera
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:41 2026
]]

-- Decompiled with Potassium's decompiler.

local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local u1 = require(CommonUtils:WaitForChild("FlagUtil")).getUserFlag("UserFixOrbitalCameraAzimuth");
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"));
local CameraInput = require(script.Parent:WaitForChild("CameraInput"));
local Players = game:GetService("Players");
local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"));
local u2 = setmetatable({}, BaseCamera);
u2.__index = u2;

function u2.new() -- Line: 46
    -- upvalues: BaseCamera (copy), u2 (copy)
    local v3 = BaseCamera.new();
    local v4 = setmetatable(v3, u2);
    v4.lastUpdate = tick();
    v4.changedSignalConnections = {};
    v4.refAzimuthRad = nil;
    v4.curAzimuthRad = nil;
    v4.minAzimuthAbsoluteRad = nil;
    v4.maxAzimuthAbsoluteRad = nil;
    v4.useAzimuthLimits = nil;
    v4.curElevationRad = nil;
    v4.minElevationRad = nil;
    v4.maxElevationRad = nil;
    v4.curDistance = nil;
    v4.minDistance = nil;
    v4.maxDistance = nil;
    v4.gamepadDollySpeedMultiplier = 1;
    v4.lastUserPanCamera = tick();
    v4.externalProperties = {};
    v4.externalProperties.InitialDistance = 25;
    v4.externalProperties.MinDistance = 10;
    v4.externalProperties.MaxDistance = 100;
    v4.externalProperties.InitialElevation = 35;
    v4.externalProperties.MinElevation = 35;
    v4.externalProperties.MaxElevation = 35;
    v4.externalProperties.ReferenceAzimuth = -45;
    v4.externalProperties.CWAzimuthTravel = 90;
    v4.externalProperties.CCWAzimuthTravel = 90;
    v4.externalProperties.UseAzimuthLimits = false;
    v4:LoadNumberValueParameters();

    return v4;
end;

function u2.LoadOrCreateNumberValueParameter(u5, u6, p7, u8) -- Line: 85
    local v9 = script:FindFirstChild(u6);

    if v9 and v9:IsA(p7) then
        u5.externalProperties[u6] = v9.Value;
    else
        if u5.externalProperties[u6] == nil then
            return;
        end;

        v9 = Instance.new(p7);
        v9.Name = u6;
        v9.Parent = script;
        v9.Value = u5.externalProperties[u6];
    end;

    if u8 then
        if u5.changedSignalConnections[u6] then
            u5.changedSignalConnections[u6]:Disconnect();
        end;

        u5.changedSignalConnections[u6] = v9.Changed:Connect(function(p10) -- Line: 105
            -- upvalues: u5 (copy), u6 (copy), u8 (copy)
            u5.externalProperties[u6] = p10;
            u8(u5);
        end);
    end;
end;

function u2.SetAndBoundsCheckAzimuthValues(p11) -- Line: 112
    local v12 = math.rad(p11.externalProperties.ReferenceAzimuth);
    local v13 = math.rad(p11.externalProperties.CWAzimuthTravel);
    p11.minAzimuthAbsoluteRad = v12 - math.abs(v13);
    local v14 = math.rad(p11.externalProperties.ReferenceAzimuth);
    local v15 = math.rad(p11.externalProperties.CCWAzimuthTravel);
    p11.maxAzimuthAbsoluteRad = v14 + math.abs(v15);
    p11.useAzimuthLimits = p11.externalProperties.UseAzimuthLimits;

    if p11.useAzimuthLimits then
        p11.curAzimuthRad = math.max(p11.curAzimuthRad, p11.minAzimuthAbsoluteRad);
        p11.curAzimuthRad = math.min(p11.curAzimuthRad, p11.maxAzimuthAbsoluteRad);
    end;
end;

function u2.SetAndBoundsCheckElevationValues(p16) -- Line: 122
    local v17 = math.max(p16.externalProperties.MinElevation, -80);
    local v18 = math.min(p16.externalProperties.MaxElevation, 80);
    local v19 = math.min(v17, v18);
    p16.minElevationRad = math.rad(v19);
    local v20 = math.max(v17, v18);
    p16.maxElevationRad = math.rad(v20);
    p16.curElevationRad = math.max(p16.curElevationRad, p16.minElevationRad);
    p16.curElevationRad = math.min(p16.curElevationRad, p16.maxElevationRad);
end;

function u2.SetAndBoundsCheckDistanceValues(p21) -- Line: 138
    p21.minDistance = p21.externalProperties.MinDistance;
    p21.maxDistance = p21.externalProperties.MaxDistance;
    p21.curDistance = math.max(p21.curDistance, p21.minDistance);
    p21.curDistance = math.min(p21.curDistance, p21.maxDistance);
end;

function u2.LoadNumberValueParameters(p22) -- Line: 146
    -- upvalues: u1 (copy)
    p22:LoadOrCreateNumberValueParameter("InitialElevation", "NumberValue", nil);
    p22:LoadOrCreateNumberValueParameter("InitialDistance", "NumberValue", nil);
    local v23;

    if u1 then
        v23 = p22.SetAndBoundsCheckAzimuthValues;
    else
        v23 = p22.SetAndBoundsCheckAzimuthValue;
    end;

    p22:LoadOrCreateNumberValueParameter("ReferenceAzimuth", "NumberValue", v23);
    p22:LoadOrCreateNumberValueParameter("CWAzimuthTravel", "NumberValue", p22.SetAndBoundsCheckAzimuthValues);
    p22:LoadOrCreateNumberValueParameter("CCWAzimuthTravel", "NumberValue", p22.SetAndBoundsCheckAzimuthValues);
    p22:LoadOrCreateNumberValueParameter("MinElevation", "NumberValue", p22.SetAndBoundsCheckElevationValues);
    p22:LoadOrCreateNumberValueParameter("MaxElevation", "NumberValue", p22.SetAndBoundsCheckElevationValues);
    p22:LoadOrCreateNumberValueParameter("MinDistance", "NumberValue", p22.SetAndBoundsCheckDistanceValues);
    p22:LoadOrCreateNumberValueParameter("MaxDistance", "NumberValue", p22.SetAndBoundsCheckDistanceValues);
    p22:LoadOrCreateNumberValueParameter("UseAzimuthLimits", "BoolValue", p22.SetAndBoundsCheckAzimuthValues);
    p22.curAzimuthRad = math.rad(p22.externalProperties.ReferenceAzimuth);
    p22.curElevationRad = math.rad(p22.externalProperties.InitialElevation);
    p22.curDistance = p22.externalProperties.InitialDistance;
    p22:SetAndBoundsCheckAzimuthValues();
    p22:SetAndBoundsCheckElevationValues();
    p22:SetAndBoundsCheckDistanceValues();
end;

function u2.GetModuleName(p24) -- Line: 172
    return "OrbitalCamera";
end;

function u2.SetInitialOrientation(p25, p26) -- Line: 176
    -- upvalues: CameraUtils (copy)
    if not (p26 and p26.RootPart) then
        warn("OrbitalCamera could not set initial orientation due to missing humanoid");

        return;
    end;

    assert(p26.RootPart, "");
    local Unit = (p26.RootPart.CFrame.LookVector - Vector3.new(0, 0.23, 0)).Unit;
    local v27 = CameraUtils.GetAngleBetweenXZVectors(Unit, p25:GetCameraLookVector());
    local Y = p25:GetCameraLookVector().Y;
    local v28 = math.asin(Y) - math.asin(Unit.Y);
    CameraUtils.IsFinite(v27);
    CameraUtils.IsFinite(v28);
end;

function u2.GetCameraToSubjectDistance(p29) -- Line: 194
    return p29.curDistance;
end;

function u2.SetCameraToSubjectDistance(p30, p31) -- Line: 198
    -- upvalues: Players (copy)
    if Players.LocalPlayer then
        p30.currentSubjectDistance = math.clamp(p31, p30.minDistance, p30.maxDistance);
        p30.currentSubjectDistance = math.max(p30.currentSubjectDistance, p30.FIRST_PERSON_DISTANCE_THRESHOLD);
    end;

    p30.inFirstPerson = false;
    p30:UpdateMouseBehavior();

    return p30.currentSubjectDistance;
end;

function u2.CalculateNewLookVector(p32, p33, p34) -- Line: 211
    local v35 = p33 or p32:GetCameraLookVector();
    local v36 = math.asin(v35.Y);
    local v37 = math.clamp(p34.Y, v36 - 1.3962634015954636, v36 - -1.3962634015954636);
    local v38 = Vector2.new(p34.X, v37);
    local v39 = CFrame.new(Vector3.new(0, 0, 0), v35);

    return (CFrame.Angles(0, -v38.X, 0) * v39 * CFrame.Angles(-v38.Y, 0, 0)).LookVector;
end;

function u2.Update(p40, p41) -- Line: 222
    -- upvalues: CameraInput (copy), Players (copy)
    local v42 = tick();
    local v43 = v42 - p40.lastUpdate;
    local v44 = CameraInput.getRotation(p41) ~= Vector2.new();
    local CurrentCamera = workspace.CurrentCamera;
    local CFrame2 = CurrentCamera.CFrame;
    local Focus = CurrentCamera.Focus;
    local LocalPlayer = Players.LocalPlayer;
    local v45;

    if CurrentCamera then
        v45 = CurrentCamera.CameraSubject;
    else
        v45 = CurrentCamera;
    end;

    local v46;

    if v45 then
        v46 = v45:IsA("VehicleSeat");
    else
        v46 = v45;
    end;

    local v47;

    if v45 then
        v47 = v45:IsA("SkateboardPlatform");
    else
        v47 = v45;
    end;

    if p40.lastUpdate == nil or v43 > 1 then
        p40.lastCameraTransform = nil;
    end;

    if v44 then
        p40.lastUserPanCamera = tick();
    end;

    local v48 = p40:GetSubjectPosition();

    if v48 and (LocalPlayer and CurrentCamera) then
        if p40.gamepadDollySpeedMultiplier ~= 1 then
            p40:SetCameraToSubjectDistance(p40.currentSubjectDistance * p40.gamepadDollySpeedMultiplier);
        end;

        Focus = CFrame.new(v48);
        local v49 = CameraInput.getRotation(p41);
        p40.curAzimuthRad = p40.curAzimuthRad - v49.X;

        if p40.useAzimuthLimits then
            p40.curAzimuthRad = math.clamp(p40.curAzimuthRad, p40.minAzimuthAbsoluteRad, p40.maxAzimuthAbsoluteRad);
        else
            p40.curAzimuthRad = p40.curAzimuthRad == 0 and 0 or (math.sign(p40.curAzimuthRad) * (math.abs(p40.curAzimuthRad) % 6.283185307179586) or 0);
        end;

        p40.curElevationRad = math.clamp(p40.curElevationRad + v49.Y, p40.minElevationRad, p40.maxElevationRad);
        local v50 = v48 + p40.currentSubjectDistance * (CFrame.fromEulerAnglesYXZ(-p40.curElevationRad, p40.curAzimuthRad, 0) * Vector3.new(0, 0, 1));
        CFrame2 = CFrame.new(v50, v48);
        p40.lastCameraTransform = CFrame2;
        p40.lastCameraFocus = Focus;

        if (v46 or v47) and v45:IsA("BasePart") then
            p40.lastSubjectCFrame = v45.CFrame;
        else
            p40.lastSubjectCFrame = nil;
        end;
    end;

    p40.lastUpdate = v42;

    return CFrame2, Focus;
end;

return u2;