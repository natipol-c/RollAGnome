--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     VehicleController
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule.VehicleController
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:10 2026
]]

-- Decompiled with Potassium's decompiler.

local ContextActionService = game:GetService("ContextActionService");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 27
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.CONTROL_ACTION_PRIORITY = p2;
    v3.enabled = false;
    v3.vehicleSeat = nil;
    v3.throttle = 0;
    v3.steer = 0;
    v3.acceleration = 0;
    v3.decceleration = 0;
    v3.turningRight = 0;
    v3.turningLeft = 0;
    v3.vehicleMoveVector = Vector3.new(0, 0, 0);
    v3.autoPilot = {};
    v3.autoPilot.MaxSpeed = 0;
    v3.autoPilot.MaxSteeringAngle = 0;

    return v3;
end;

function u1.BindContextActions(u4) -- Line: 51
    -- upvalues: ContextActionService (copy)
    ContextActionService:BindActionAtPriority("throttleAccel", function(p5, p6, p7) -- Line: 53
        -- upvalues: u4 (copy)
        u4:OnThrottleAccel(p5, p6, p7);

        return Enum.ContextActionResult.Pass;
    end, false, u4.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonR2);
    ContextActionService:BindActionAtPriority("throttleDeccel", function(p8, p9, p10) -- Line: 57
        -- upvalues: u4 (copy)
        u4:OnThrottleDeccel(p8, p9, p10);

        return Enum.ContextActionResult.Pass;
    end, false, u4.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonL2);
    ContextActionService:BindActionAtPriority("arrowSteerRight", function(p11, p12, p13) -- Line: 62
        -- upvalues: u4 (copy)
        u4:OnSteerRight(p11, p12, p13);

        return Enum.ContextActionResult.Pass;
    end, false, u4.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Right);
    ContextActionService:BindActionAtPriority("arrowSteerLeft", function(p14, p15, p16) -- Line: 66
        -- upvalues: u4 (copy)
        u4:OnSteerLeft(p14, p15, p16);

        return Enum.ContextActionResult.Pass;
    end, false, u4.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Left);
end;

function u1.Enable(p17, p18, p19) -- Line: 72
    -- upvalues: ContextActionService (copy)
    if p18 == p17.enabled and p19 == p17.vehicleSeat then
        return;
    end;

    p17.enabled = p18;
    p17.vehicleMoveVector = Vector3.new(0, 0, 0);

    if p18 then
        if p19 then
            p17.vehicleSeat = p19;
            p17:SetupAutoPilot();
            p17:BindContextActions();
        end;
    else
        ContextActionService:UnbindAction("throttleAccel");
        ContextActionService:UnbindAction("throttleDeccel");
        ContextActionService:UnbindAction("arrowSteerRight");
        ContextActionService:UnbindAction("arrowSteerLeft");
        p17.vehicleSeat = nil;
    end;
end;

function u1.OnThrottleAccel(p20, p21, p22, p23) -- Line: 98
    if p22 == Enum.UserInputState.End or p22 == Enum.UserInputState.Cancel then
        p20.acceleration = 0;
    else
        p20.acceleration = -1;
    end;

    p20.throttle = p20.acceleration + p20.decceleration;
end;

function u1.OnThrottleDeccel(p24, p25, p26, p27) -- Line: 107
    if p26 == Enum.UserInputState.End or p26 == Enum.UserInputState.Cancel then
        p24.decceleration = 0;
    else
        p24.decceleration = 1;
    end;

    p24.throttle = p24.acceleration + p24.decceleration;
end;

function u1.OnSteerRight(p28, p29, p30, p31) -- Line: 116
    if p30 == Enum.UserInputState.End or p30 == Enum.UserInputState.Cancel then
        p28.turningRight = 0;
    else
        p28.turningRight = 1;
    end;

    p28.steer = p28.turningRight + p28.turningLeft;
end;

function u1.OnSteerLeft(p32, p33, p34, p35) -- Line: 125
    if p34 == Enum.UserInputState.End or p34 == Enum.UserInputState.Cancel then
        p32.turningLeft = 0;
    else
        p32.turningLeft = -1;
    end;

    p32.steer = p32.turningRight + p32.turningLeft;
end;

function u1.Update(p36, p37, p38, p39) -- Line: 135
    if not p36.vehicleSeat then
        return p37, false;
    end;

    if p38 then
        local v40 = p37 + Vector3.new(p36.steer, 0, p36.throttle);
        p36.vehicleSeat.ThrottleFloat = -v40.Z;
        p36.vehicleSeat.SteerFloat = v40.X;

        return v40, true;
    end;

    local v41 = p36.vehicleSeat.Occupant.RootPart.CFrame:VectorToObjectSpace(p37);
    p36.vehicleSeat.ThrottleFloat = p36:ComputeThrottle(v41);
    p36.vehicleSeat.SteerFloat = p36:ComputeSteer(v41);

    return Vector3.new(0, 0, 0), true;
end;

function u1.ComputeThrottle(p42, p43) -- Line: 161
    return p43 == Vector3.new(0, 0, 0) and 0 or -p43.Z;
end;

function u1.ComputeSteer(p44, p45) -- Line: 170
    return p45 == Vector3.new(0, 0, 0) and 0 or -math.atan2(-p45.x, -p45.z) * 57.29577951308232 / p44.autoPilot.MaxSteeringAngle;
end;

function u1.SetupAutoPilot(p46) -- Line: 179
    p46.autoPilot.MaxSpeed = p46.vehicleSeat.MaxSpeed;
    p46.autoPilot.MaxSteeringAngle = 35;
end;

return u1;