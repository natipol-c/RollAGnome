--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     VehicleCameraCore
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.VehicleCamera.VehicleCameraCore
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:09 2026
]]

-- Decompiled with Potassium's decompiler.

local CameraUtils = require(script.Parent.Parent.CameraUtils);
local VehicleCameraConfig = require(script.Parent.VehicleCameraConfig);
local map = CameraUtils.map;
local mapClamp = CameraUtils.mapClamp;
local sanitizeAngle = CameraUtils.sanitizeAngle;

local function getYaw(p1) -- Line: 10
    -- upvalues: sanitizeAngle (copy)
    local _, v2 = p1:toEulerAnglesYXZ();

    return sanitizeAngle(v2);
end;

local function getPitch(p3) -- Line: 16
    -- upvalues: sanitizeAngle (copy)
    return sanitizeAngle((p3:toEulerAnglesYXZ()));
end;

local function stepSpringAxis(p4, p5, p6, p7, p8) -- Line: 22
    -- upvalues: sanitizeAngle (copy)
    local v9 = sanitizeAngle(p7 - p6);
    local v10 = math.exp(-p5 * p4);

    return sanitizeAngle((v9 * (1 + p5 * p4) + p8 * p4) * v10 + p6), (p8 * (1 - p5 * p4) - v9 * (p5 * p5 * p4)) * v10;
end;

local u11 = {};
u11.__index = u11;

function u11.new(p12, p13, p14) -- Line: 36
    -- upvalues: u11 (copy)
    return setmetatable({
        fRising = p12,
        fFalling = p13,
        g = p14,
        p = p14,
        v = p14 * 0
    }, u11);
end;

function u11.step(p15, p16) -- Line: 46
    local fRising = p15.fRising;
    local fFalling = p15.fFalling;
    local g = p15.g;
    local v = p15.v;

    if v > 0 then
        fFalling = fRising or fFalling;
    end;

    local v17 = 6.283185307179586 * fFalling;
    local v18 = p15.p - g;
    local v19 = math.exp(-v17 * p16);
    local v20 = (v18 * (1 + v17 * p16) + v * p16) * v19 + g;
    p15.p = v20;
    p15.v = (v * (1 - v17 * p16) - v18 * (v17 * v17 * p16)) * v19;

    return v20;
end;

local u21 = {};
u21.__index = u21;

function u21.new(p22) -- Line: 72
    -- upvalues: sanitizeAngle (copy), u11 (copy), VehicleCameraConfig (copy), u21 (copy)
    local v23 = typeof(p22) == "CFrame";
    assert(v23);
    local v24 = {
        yawV = 0,
        pitchV = 0
    };
    local _, v25 = p22:toEulerAnglesYXZ();
    v24.yawG = sanitizeAngle(v25);
    local _, v26 = p22:toEulerAnglesYXZ();
    v24.yawP = sanitizeAngle(v26);
    v24.pitchG = sanitizeAngle((p22:toEulerAnglesYXZ()));
    v24.pitchP = sanitizeAngle((p22:toEulerAnglesYXZ()));
    v24.fSpringYaw = u11.new(VehicleCameraConfig.yawReponseDampingRising, VehicleCameraConfig.yawResponseDampingFalling, 0);
    v24.fSpringPitch = u11.new(VehicleCameraConfig.pitchReponseDampingRising, VehicleCameraConfig.pitchResponseDampingFalling, 0);

    return setmetatable(v24, u21);
end;

function u21.setGoal(p27, p28) -- Line: 99
    -- upvalues: sanitizeAngle (copy)
    local v29 = typeof(p28) == "CFrame";
    assert(v29);
    local _, v30 = p28:toEulerAnglesYXZ();
    p27.yawG = sanitizeAngle(v30);
    p27.pitchG = sanitizeAngle((p28:toEulerAnglesYXZ()));
end;

function u21.getCFrame(p31) -- Line: 106
    return CFrame.fromEulerAnglesYXZ(p31.pitchP, p31.yawP, 0);
end;

function u21.step(p32, p33, p34, p35, p36) -- Line: 110
    -- upvalues: mapClamp (copy), map (copy), VehicleCameraConfig (copy), sanitizeAngle (copy)
    local v37 = typeof(p33) == "number";
    assert(v37);
    local v38 = typeof(p35) == "number";
    assert(v38);
    local v39 = typeof(p34) == "number";
    assert(v39);
    local v40 = typeof(p36) == "number";
    assert(v40);
    local fSpringYaw = p32.fSpringYaw;
    local fSpringPitch = p32.fSpringPitch;
    fSpringYaw.g = mapClamp(map(p36, 0, 1, p35, 0), math.rad(VehicleCameraConfig.cutoffMinAngularVelYaw), math.rad(VehicleCameraConfig.cutoffMaxAngularVelYaw), 1, 0);
    fSpringPitch.g = mapClamp(map(p36, 0, 1, p34, 0), math.rad(VehicleCameraConfig.cutoffMinAngularVelPitch), math.rad(VehicleCameraConfig.cutoffMaxAngularVelPitch), 1, 0);
    local v41 = 6.283185307179586 * VehicleCameraConfig.yawStiffness * fSpringYaw:step(p33);
    local v42 = 6.283185307179586 * VehicleCameraConfig.pitchStiffness * fSpringPitch:step(p33) * map(p36, 0, 1, 1, VehicleCameraConfig.firstPersonResponseMul);
    local v43 = v41 * map(p36, 0, 1, 1, VehicleCameraConfig.firstPersonResponseMul);
    local yawG = p32.yawG;
    local yawV = p32.yawV;
    local v44 = sanitizeAngle(p32.yawP - yawG);
    local v45 = math.exp(-v43 * p33);
    local v46 = sanitizeAngle((v44 * (1 + v43 * p33) + yawV * p33) * v45 + yawG);
    p32.yawP = v46;
    p32.yawV = (yawV * (1 - v43 * p33) - v44 * (v43 * v43 * p33)) * v45;
    local pitchG = p32.pitchG;
    local pitchV = p32.pitchV;
    local v47 = sanitizeAngle(p32.pitchP - pitchG);
    local v48 = math.exp(-v42 * p33);
    local v49 = sanitizeAngle((v47 * (1 + v42 * p33) + pitchV * p33) * v48 + pitchG);
    p32.pitchP = v49;
    p32.pitchV = (pitchV * (1 - v42 * p33) - v47 * (v42 * v42 * p33)) * v48;

    return p32:getCFrame();
end;

local u50 = {};
u50.__index = u50;

function u50.new(p51) -- Line: 167
    -- upvalues: u21 (copy), u50 (copy)
    local v52 = {
        vrs = u21.new(p51)
    };

    return setmetatable(v52, u50);
end;

function u50.step(p53, p54, p55, p56, p57) -- Line: 173
    return p53.vrs:step(p54, p55, p56, p57);
end;

function u50.setTransform(p58, p59) -- Line: 177
    p58.vrs:setGoal(p59);
end;

return u50;