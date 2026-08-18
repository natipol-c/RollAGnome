--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CameraUtils
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.CameraUtils
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:09 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local u1 = {};

local function round(p2) -- Line: 12
    return math.floor(p2 + 0.5);
end;

local u3 = {};
u3.__index = u3;

function u3.new(p4, p5) -- Line: 21
    -- upvalues: u3 (copy)
    return setmetatable({
        vel = 0,
        freq = p4,
        goal = p5,
        pos = p5
    }, u3);
end;

function u3.step(p6, p7) -- Line: 31
    local v8 = p6.freq * 2 * 3.141592653589793;
    local goal = p6.goal;
    local vel = p6.vel;
    local v9 = p6.pos - goal;
    local v10 = math.exp(-v8 * p7);
    local v11 = (v9 * (v8 * p7 + 1) + vel * p7) * v10 + goal;
    p6.pos = v11;
    p6.vel = (vel * (1 - v8 * p7) - v9 * (v8 * v8 * p7)) * v10;

    return v11;
end;

u1.Spring = u3;

function u1.map(p12, p13, p14, p15, p16) -- Line: 53
    return (p12 - p13) * (p16 - p15) / (p14 - p13) + p15;
end;

function u1.mapClamp(p17, p18, p19, p20, p21) -- Line: 58
    local v22 = math.min(p20, p21);
    local v23 = math.max(p20, p21);

    return math.clamp((p17 - p18) * (p21 - p20) / (p19 - p18) + p20, v22, v23);
end;

function u1.getLooseBoundingSphere(p24) -- Line: 67
    local v25 = table.create(#p24);

    for i, v in pairs(p24) do
        v25[i] = v.Position;
    end;

    local v26 = v25[1];
    local v27 = v26;
    local v28 = 0;

    for _, v in ipairs(v25) do
        local Magnitude = (v - v26).Magnitude;

        if v28 < Magnitude then
            v27 = v;
            v28 = Magnitude;
        end;
    end;

    local v29 = v27;
    local v30 = 0;

    for _, v in ipairs(v25) do
        local Magnitude = (v - v27).Magnitude;

        if v30 < Magnitude then
            v29 = v;
            v30 = Magnitude;
        end;
    end;

    local v31 = (v27 + v29) * 0.5;
    local v32 = (v27 - v29).Magnitude * 0.5;

    for _, v in ipairs(v25) do
        local Magnitude = (v - v31).Magnitude;

        if v32 < Magnitude then
            v31 = v31 + (Magnitude - v32) * 0.5 * (v - v31).Unit;
            v32 = (Magnitude + v32) * 0.5;
        end;
    end;

    return v31, v32;
end;

function u1.sanitizeAngle(p33) -- Line: 123
    return (p33 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793;
end;

function u1.Round(p34, p35) -- Line: 128
    local v36 = 10 ^ p35;

    return math.floor(p34 * v36 + 0.5) / v36;
end;

function u1.IsFinite(p37) -- Line: 133
    local v38;

    if p37 == p37 and p37 ~= (1 / 0) then
        v38 = p37 ~= (-1 / 0);
    else
        v38 = false;
    end;

    return v38;
end;

function u1.IsFiniteVector3(p39) -- Line: 137
    -- upvalues: u1 (copy)
    local v40 = u1.IsFinite(p39.X) and u1.IsFinite(p39.Y) and u1.IsFinite(p39.Z);

    return v40;
end;

function u1.GetAngleBetweenXZVectors(p41, p42) -- Line: 142
    return math.atan2(p42.X * p41.Z - p42.Z * p41.X, p42.X * p41.X + p42.Z * p41.Z);
end;

function u1.RotateVectorByAngleAndRound(p43, p44, p45) -- Line: 146
    if p43.Magnitude <= 0 then
        return 0;
    end;

    local Unit = p43.Unit;
    local v46 = math.atan2(Unit.Z, Unit.X);
    local v47 = (math.atan2(Unit.Z, Unit.X) + p44) / p45 + 0.5;

    return math.floor(v47) * p45 - v46;
end;

local function SCurveTranform(p48) -- Line: 160
    local v49 = math.clamp(p48, -1, 1);

    if v49 >= 0 then
        return v49 * 0.35 / (0.35 - v49 + 1);
    end;

    return -(-v49 * 0.8 / (v49 + 0.8 + 1));
end;

local function toSCurveSpace(p50) -- Line: 169
    return (math.abs(p50) * 2 - 1) * 1.1 - 0.1;
end;

local function fromSCurveSpace(p51) -- Line: 173
    return p51 / 2 + 0.5;
end;

function u1.GamepadLinearToCurve(p52) -- Line: 177
    local function onAxis(p53) -- Line: 178
        local v54 = math.abs(p53);
        local v55 = (math.abs(v54) * 2 - 1) * 1.1 - 0.1;
        local v56 = math.clamp(v55, -1, 1);
        local v57;

        if v56 >= 0 then
            v57 = v56 * 0.35 / (0.35 - v56 + 1);
        else
            v57 = -(-v56 * 0.8 / (v56 + 0.8 + 1));
        end;

        return math.clamp((v57 / 2 + 0.5) * (p53 < 0 and -1 or 1), -1, 1);
    end;

    local new = Vector2.new;
    local X = p52.X;
    local v58 = math.abs(X);
    local v59 = (math.abs(v58) * 2 - 1) * 1.1 - 0.1;
    local v60 = math.clamp(v59, -1, 1);
    local v61;

    if v60 >= 0 then
        v61 = v60 * 0.35 / (0.35 - v60 + 1);
    else
        v61 = -(-v60 * 0.8 / (v60 + 0.8 + 1));
    end;

    local v62 = math.clamp((v61 / 2 + 0.5) * (X < 0 and -1 or 1), -1, 1);
    local Y = p52.Y;
    local v63 = math.abs(Y);
    local v64 = (math.abs(v63) * 2 - 1) * 1.1 - 0.1;
    local v65 = math.clamp(v64, -1, 1);
    local v66;

    if v65 >= 0 then
        v66 = v65 * 0.35 / (0.35 - v65 + 1);
    else
        v66 = -(-v65 * 0.8 / (v65 + 0.8 + 1));
    end;

    return new(v62, (math.clamp((v66 / 2 + 0.5) * (Y < 0 and -1 or 1), -1, 1)));
end;

function u1.ConvertCameraModeEnumToStandard(p67) -- Line: 191
    if p67 == Enum.TouchCameraMovementMode.Default then
        return Enum.ComputerCameraMovementMode.Follow;
    end;

    if p67 == Enum.ComputerCameraMovementMode.Default then
        return Enum.ComputerCameraMovementMode.Classic;
    end;

    if p67 == Enum.TouchCameraMovementMode.Classic or (p67 == Enum.DevTouchCameraMovementMode.Classic or (p67 == Enum.DevComputerCameraMovementMode.Classic or p67 == Enum.ComputerCameraMovementMode.Classic)) then
        return Enum.ComputerCameraMovementMode.Classic;
    end;

    if p67 == Enum.TouchCameraMovementMode.Follow or (p67 == Enum.DevTouchCameraMovementMode.Follow or (p67 == Enum.DevComputerCameraMovementMode.Follow or p67 == Enum.ComputerCameraMovementMode.Follow)) then
        return Enum.ComputerCameraMovementMode.Follow;
    end;

    if p67 == Enum.TouchCameraMovementMode.Orbital or (p67 == Enum.DevTouchCameraMovementMode.Orbital or (p67 == Enum.DevComputerCameraMovementMode.Orbital or p67 == Enum.ComputerCameraMovementMode.Orbital)) then
        return Enum.ComputerCameraMovementMode.Orbital;
    end;

    if p67 == Enum.ComputerCameraMovementMode.CameraToggle or p67 == Enum.DevComputerCameraMovementMode.CameraToggle then
        return Enum.ComputerCameraMovementMode.CameraToggle;
    end;

    if p67 == Enum.DevTouchCameraMovementMode.UserChoice or p67 == Enum.DevComputerCameraMovementMode.UserChoice then
        return Enum.DevComputerCameraMovementMode.UserChoice;
    end;

    return Enum.ComputerCameraMovementMode.Classic;
end;

local function getMouse() -- Line: 240
    -- upvalues: Players (copy)
    local LocalPlayer = Players.LocalPlayer;

    if not LocalPlayer then
        Players:GetPropertyChangedSignal("LocalPlayer"):Wait();
        LocalPlayer = Players.LocalPlayer;
    end;

    assert(LocalPlayer);

    return LocalPlayer:GetMouse();
end;

local u68 = "";
local u69 = nil;

function u1.setMouseIconOverride(p70) -- Line: 252
    -- upvalues: Players (copy), u69 (ref), u68 (ref)
    local LocalPlayer = Players.LocalPlayer;

    if not LocalPlayer then
        Players:GetPropertyChangedSignal("LocalPlayer"):Wait();
        LocalPlayer = Players.LocalPlayer;
    end;

    assert(LocalPlayer);
    local v71 = LocalPlayer:GetMouse();

    if v71.Icon ~= u69 then
        u68 = v71.Icon;
    end;

    v71.Icon = p70;
    u69 = p70;
end;

function u1.restoreMouseIcon() -- Line: 263
    -- upvalues: Players (copy), u69 (ref), u68 (ref)
    local LocalPlayer = Players.LocalPlayer;

    if not LocalPlayer then
        Players:GetPropertyChangedSignal("LocalPlayer"):Wait();
        LocalPlayer = Players.LocalPlayer;
    end;

    assert(LocalPlayer);
    local v72 = LocalPlayer:GetMouse();

    if v72.Icon == u69 then
        v72.Icon = u68;
    end;

    u69 = nil;
end;

local Default = Enum.MouseBehavior.Default;
local u73 = nil;

function u1.setMouseBehaviorOverride(p74) -- Line: 274
    -- upvalues: UserInputService (copy), u73 (ref), Default (ref)
    if UserInputService.MouseBehavior ~= u73 then
        Default = UserInputService.MouseBehavior;
    end;

    UserInputService.MouseBehavior = p74;
    u73 = p74;
end;

function u1.restoreMouseBehavior() -- Line: 283
    -- upvalues: UserInputService (copy), u73 (ref), Default (ref)
    if UserInputService.MouseBehavior == u73 then
        UserInputService.MouseBehavior = Default;
    end;

    u73 = nil;
end;

local MovementRelative = Enum.RotationType.MovementRelative;
local u75 = nil;

function u1.setRotationTypeOverride(p76) -- Line: 292
    -- upvalues: UserGameSettings (copy), u75 (ref), MovementRelative (ref)
    if UserGameSettings.RotationType ~= u75 then
        MovementRelative = UserGameSettings.RotationType;
    end;

    UserGameSettings.RotationType = p76;
    u75 = p76;
end;

function u1.restoreRotationType() -- Line: 301
    -- upvalues: UserGameSettings (copy), u75 (ref), MovementRelative (ref)
    if UserGameSettings.RotationType == u75 then
        UserGameSettings.RotationType = MovementRelative;
    end;

    u75 = nil;
end;

return u1;