--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     VRNavigation
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule.VRNavigation
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:41 2026
]]

-- Decompiled with Potassium's decompiler.

local VRService = game:GetService("VRService");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local PathfindingService = game:GetService("PathfindingService");
local ContextActionService = game:GetService("ContextActionService");
local StarterGui = game:GetService("StarterGui");
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local FlagUtil = require(CommonUtils:WaitForChild("FlagUtil"));
local u1 = nil;
local LocalPlayer = Players.LocalPlayer;
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Exclude;
local u3 = FlagUtil.getUserFlag("UserRaycastUpdateAPI2");

local function IsFinite(p4) -- Line: 42
    local v5;

    if p4 == p4 and p4 ~= (1 / 0) then
        v5 = p4 ~= (-1 / 0);
    else
        v5 = false;
    end;

    return v5;
end;

local function IsFiniteVector3(p6) -- Line: 46
    local x = p6.x;
    local v7;

    if x == x and x ~= (1 / 0) then
        v7 = x ~= (-1 / 0);
    else
        v7 = false;
    end;

    if v7 then
        local y = p6.y;

        if y == y and y ~= (1 / 0) then
            v7 = y ~= (-1 / 0);
        else
            v7 = false;
        end;

        if v7 then
            local z = p6.z;

            if z == z and z ~= (1 / 0) then
                v7 = z ~= (-1 / 0);
            else
                v7 = false;
            end;
        end;
    end;

    return v7;
end;

local BindableEvent = Instance.new("BindableEvent");
BindableEvent.Name = "MovementUpdate";
BindableEvent.Parent = script;
coroutine.wrap(function() -- Line: 54
    -- upvalues: u1 (ref)
    local PathDisplay = script.Parent:WaitForChild("PathDisplay");

    if PathDisplay then
        u1 = require(PathDisplay);
    end;
end)();
local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"));
local u8 = setmetatable({}, BaseCharacterController);
u8.__index = u8;

function u8.new(p9) -- Line: 67
    -- upvalues: BaseCharacterController (copy), u8 (copy)
    local v10 = BaseCharacterController.new();
    local v11 = setmetatable(v10, u8);
    v11.CONTROL_ACTION_PRIORITY = p9;
    v11.navigationRequestedConn = nil;
    v11.heartbeatConn = nil;
    v11.currentDestination = nil;
    v11.currentPath = nil;
    v11.currentPoints = nil;
    v11.currentPointIdx = 0;
    v11.expectedTimeToNextPoint = 0;
    v11.timeReachedLastPoint = tick();
    v11.moving = false;
    v11.isJumpBound = false;
    v11.moveLatch = false;
    v11.userCFrameEnabledConn = nil;

    return v11;
end;

function u8.SetLaserPointerMode(p12, u13) -- Line: 92
    -- upvalues: StarterGui (copy)
    pcall(function() -- Line: 93
        -- upvalues: StarterGui (ref), u13 (copy)
        StarterGui:SetCore("VRLaserPointerMode", u13);
    end);
end;

function u8.GetLocalHumanoid(p14) -- Line: 98
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character then
        for _, child in pairs(Character:GetChildren()) do
            if child:IsA("Humanoid") then
                return child;
            end;
        end;

        return nil;
    end;
end;

function u8.HasBothHandControllers(p15) -- Line: 112
    -- upvalues: VRService (copy)
    local v16 = VRService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) and VRService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand);

    return v16;
end;

function u8.HasAnyHandControllers(p17) -- Line: 116
    -- upvalues: VRService (copy)
    return VRService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) or VRService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand);
end;

function u8.IsMobileVR(p18) -- Line: 120
    -- upvalues: UserInputService (copy)
    return UserInputService.TouchEnabled;
end;

function u8.HasGamepad(p19) -- Line: 124
    -- upvalues: UserInputService (copy)
    return UserInputService.GamepadEnabled;
end;

function u8.ShouldUseNavigationLaser(p20) -- Line: 128
    if p20:IsMobileVR() then
        return true;
    end;

    if p20:HasBothHandControllers() then
        return false;
    end;

    return p20:HasAnyHandControllers() and true or not p20:HasGamepad();
end;

function u8.StartFollowingPath(p21, p22) -- Line: 150
    -- upvalues: BindableEvent (copy)
    currentPath = p22;
    currentPoints = currentPath:GetPointCoordinates();
    currentPointIdx = 1;
    moving = true;
    timeReachedLastPoint = tick();
    local v23 = p21:GetLocalHumanoid();

    if v23 and (v23.Torso and #currentPoints >= 1) then
        expectedTimeToNextPoint = (currentPoints[1] - v23.Torso.Position).magnitude / v23.WalkSpeed;
    end;

    BindableEvent:Fire("targetPoint", p21.currentDestination);
end;

function u8.GoToPoint(p24, p25) -- Line: 167
    -- upvalues: BindableEvent (copy)
    currentPath = true;
    currentPoints = { p25 };
    currentPointIdx = 1;
    moving = true;
    local v26 = p24:GetLocalHumanoid();
    local v27 = (v26.Torso.Position - p25).magnitude / v26.WalkSpeed;
    timeReachedLastPoint = tick();
    expectedTimeToNextPoint = v27;
    BindableEvent:Fire("targetPoint", p25);
end;

function u8.StopFollowingPath(p28) -- Line: 183
    currentPath = nil;
    currentPoints = nil;
    currentPointIdx = 0;
    moving = false;
    p28.moveVector = Vector3.new(0, 0, 0);
end;

function u8.TryComputePath(p29, p30, p31) -- Line: 191
    -- upvalues: PathfindingService (copy)
    local v32 = nil;
    local v33 = 0;

    while not v32 and v33 < 5 do
        v32 = PathfindingService:ComputeSmoothPathAsync(p30, p31, 200);
        v33 = v33 + 1;

        if v32.Status == Enum.PathStatus.ClosestNoPath or v32.Status == Enum.PathStatus.ClosestOutOfRange then
            return nil;
        end;

        if v32 and v32.Status == Enum.PathStatus.FailStartNotEmpty then
            p30 = p30 + (p31 - p30).Unit;
            v32 = nil;
        end;

        if v32 and v32.Status == Enum.PathStatus.FailFinishNotEmpty then
            p31 = p31 + Vector3.new(0, 1, 0);
            v32 = nil;
        end;
    end;

    return v32;
end;

function u8.OnNavigationRequest(p34, p35, p36) -- Line: 218
    -- upvalues: u1 (ref)
    local Position = p35.Position;
    local currentDestination = p34.currentDestination;
    local x = Position.x;
    local v37;

    if x == x and x ~= (1 / 0) then
        v37 = x ~= (-1 / 0);
    else
        v37 = false;
    end;

    if v37 then
        local y = Position.y;

        if y == y and y ~= (1 / 0) then
            v37 = y ~= (-1 / 0);
        else
            v37 = false;
        end;

        if v37 then
            local z = Position.z;

            if z == z and z ~= (1 / 0) then
                v37 = z ~= (-1 / 0);
            else
                v37 = false;
            end;
        end;
    end;

    if not v37 then
        return;
    end;

    p34.currentDestination = Position;
    local v38 = p34:GetLocalHumanoid();

    if not (v38 and v38.Torso) then
        return;
    end;

    local Position2 = v38.Torso.Position;

    if (p34.currentDestination - Position2).magnitude < 12 then
        p34:GoToPoint(p34.currentDestination);

        return;
    end;

    if currentDestination and (p34.currentDestination - currentDestination).magnitude <= 4 then
        if moving then
            p34.currentPoints[#currentPoints] = p34.currentDestination;

            return;
        end;

        p34:GoToPoint(p34.currentDestination);
    else
        local v39 = p34:TryComputePath(Position2, p34.currentDestination);

        if v39 then
            p34:StartFollowingPath(v39);

            if u1 then
                u1.setCurrentPoints(p34.currentPoints);
                u1.renderPath();
            end;
        else
            p34:StopFollowingPath();

            if u1 then
                u1.clearRenderedPath();
            end;
        end;
    end;
end;

function u8.OnJumpAction(p40, p41, p42, p43) -- Line: 264
    if p42 == Enum.UserInputState.Begin then
        p40.isJumping = true;
    end;

    return Enum.ContextActionResult.Sink;
end;

function u8.BindJumpAction(u44, p45) -- Line: 270
    -- upvalues: ContextActionService (copy)
    if p45 then
        if not u44.isJumpBound then
            u44.isJumpBound = true;
            ContextActionService:BindActionAtPriority("VRJumpAction", function() -- Line: 274
                -- upvalues: u44 (copy)
                return u44:OnJumpAction();
            end, false, u44.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonA);
        end;
    elseif u44.isJumpBound then
        u44.isJumpBound = false;
        ContextActionService:UnbindAction("VRJumpAction");
    end;
end;

function u8.ControlCharacterGamepad(p46, p47, p48, p49) -- Line: 285
    -- upvalues: u1 (ref), BindableEvent (copy)
    if p49.KeyCode ~= Enum.KeyCode.Thumbstick1 then
        return;
    end;

    if p48 ~= Enum.UserInputState.Cancel then
        if p48 == Enum.UserInputState.End then
            p46.moveVector = Vector3.new(0, 0, 0);

            if p46:ShouldUseNavigationLaser() then
                p46:BindJumpAction(false);
                p46:SetLaserPointerMode("Navigation");
            end;

            if p46.moveLatch then
                p46.moveLatch = false;
                BindableEvent:Fire("offtrack");
            end;
        else
            p46:StopFollowingPath();

            if u1 then
                u1.clearRenderedPath();
            end;

            if p46:ShouldUseNavigationLaser() then
                p46:BindJumpAction(true);
                p46:SetLaserPointerMode("Hidden");
            end;

            if p49.Position.magnitude > 0.22 then
                p46.moveVector = Vector3.new(p49.Position.X, 0, -p49.Position.Y);

                if p46.moveVector.magnitude > 0 then
                    p46.moveVector = p46.moveVector.unit * math.min(1, p49.Position.magnitude);
                end;

                p46.moveLatch = true;
            end;
        end;

        return Enum.ContextActionResult.Sink;
    end;

    p46.moveVector = Vector3.new(0, 0, 0);
end;

function u8.OnHeartbeat(p50, p51) -- Line: 328
    -- upvalues: u1 (ref), u3 (copy), u2 (copy), BindableEvent (copy)
    local moveVector = p50.moveVector;
    local v52 = p50:GetLocalHumanoid();

    if not (v52 and v52.Torso) then
        return;
    end;

    if p50.moving and p50.currentPoints then
        local Position = v52.Torso.Position;
        local v53 = (currentPoints[1] - Position) * Vector3.new(1, 0, 1);
        local magnitude = v53.magnitude;
        local v54 = v53 / magnitude;

        if magnitude < 1 then
            local v55 = currentPoints[1];
            local v56 = 0;

            for i, v in pairs(currentPoints) do
                if i ~= 1 then
                    v56 = v56 + (v - v55).magnitude / v52.WalkSpeed;
                    v55 = v;
                end;
            end;

            table.remove(currentPoints, 1);
            currentPointIdx = currentPointIdx + 1;

            if #currentPoints == 0 then
                p50:StopFollowingPath();

                if u1 then
                    u1.clearRenderedPath();
                end;

                return;
            end;

            if u1 then
                u1.setCurrentPoints(currentPoints);
                u1.renderPath();
            end;

            expectedTimeToNextPoint = (currentPoints[1] - Position).magnitude / v52.WalkSpeed;
            timeReachedLastPoint = tick();
        else
            if u3 then
                u2.FilterDescendantsInstances = { game.Players.LocalPlayer.Character, workspace.CurrentCamera };
                local v57 = workspace:Raycast(Position - Vector3.new(0, 1, 0), v54 * 3, u2);

                if v57 then
                    local v58 = workspace:Raycast(v57.Position + v54 * 0.5 + Vector3.new(0, 100, 0), Vector3.new(-0, -100, -0), u2).Position.Y - Position.Y;

                    if v58 < 6 and v58 > -2 then
                        v52.Jump = true;
                    end;
                end;
            else
                local v59 = { game.Players.LocalPlayer.Character, workspace.CurrentCamera };
                local v60 = Ray.new(Position - Vector3.new(0, 1, 0), v54 * 3);
                local v61, v62, _ = workspace:FindPartOnRayWithIgnoreList(v60, v59);

                if v61 then
                    local v63 = Ray.new(v62 + v54 * 0.5 + Vector3.new(0, 100, 0), Vector3.new(-0, -100, -0));
                    local _, v64, _ = workspace:FindPartOnRayWithIgnoreList(v63, v59);
                    local v65 = v64.Y - Position.Y;

                    if v65 < 6 and v65 > -2 then
                        v52.Jump = true;
                    end;
                end;
            end;

            if tick() - timeReachedLastPoint > expectedTimeToNextPoint + 2 then
                p50:StopFollowingPath();

                if u1 then
                    u1.clearRenderedPath();
                end;

                BindableEvent:Fire("offtrack");
            end;

            moveVector = p50.moveVector:Lerp(v54, p51 * 10);
        end;
    end;

    local x = moveVector.x;
    local v66;

    if x == x and x ~= (1 / 0) then
        v66 = x ~= (-1 / 0);
    else
        v66 = false;
    end;

    if v66 then
        local y = moveVector.y;

        if y == y and y ~= (1 / 0) then
            v66 = y ~= (-1 / 0);
        else
            v66 = false;
        end;

        if v66 then
            local z = moveVector.z;

            if z == z and z ~= (1 / 0) then
                v66 = z ~= (-1 / 0);
            else
                v66 = false;
            end;
        end;
    end;

    if v66 then
        p50.moveVector = moveVector;
    end;
end;

function u8.OnUserCFrameEnabled(p67) -- Line: 426
    if p67:ShouldUseNavigationLaser() then
        p67:BindJumpAction(false);
        p67:SetLaserPointerMode("Navigation");

        return;
    end;

    p67:BindJumpAction(true);
    p67:SetLaserPointerMode("Hidden");
end;

function u8.Enable(u68, p69) -- Line: 436
    -- upvalues: VRService (copy), RunService (copy), ContextActionService (copy)
    u68.moveVector = Vector3.new(0, 0, 0);
    u68.isJumping = false;

    if p69 then
        u68.navigationRequestedConn = VRService.NavigationRequested:Connect(function(p70, p71) -- Line: 442
            -- upvalues: u68 (copy)
            u68:OnNavigationRequest(p70, p71);
        end);
        u68.heartbeatConn = RunService.Heartbeat:Connect(function(p72) -- Line: 443
            -- upvalues: u68 (copy)
            u68:OnHeartbeat(p72);
        end);
        ContextActionService:BindAction("MoveThumbstick", function(p73, p74, p75) -- Line: 445
            -- upvalues: u68 (copy)
            return u68:ControlCharacterGamepad(p73, p74, p75);
        end, false, u68.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Thumbstick1);
        ContextActionService:BindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2);
        u68.userCFrameEnabledConn = VRService.UserCFrameEnabled:Connect(function() -- Line: 449
            -- upvalues: u68 (copy)
            u68:OnUserCFrameEnabled();
        end);
        u68:OnUserCFrameEnabled();
        VRService:SetTouchpadMode(Enum.VRTouchpad.Left, Enum.VRTouchpadMode.VirtualThumbstick);
        VRService:SetTouchpadMode(Enum.VRTouchpad.Right, Enum.VRTouchpadMode.ABXY);
        u68.enabled = true;

        return;
    end;

    u68:StopFollowingPath();
    ContextActionService:UnbindAction("MoveThumbstick");
    ContextActionService:UnbindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2);
    u68:BindJumpAction(false);
    u68:SetLaserPointerMode("Disabled");

    if u68.navigationRequestedConn then
        u68.navigationRequestedConn:Disconnect();
        u68.navigationRequestedConn = nil;
    end;

    if u68.heartbeatConn then
        u68.heartbeatConn:Disconnect();
        u68.heartbeatConn = nil;
    end;

    if u68.userCFrameEnabledConn then
        u68.userCFrameEnabledConn:Disconnect();
        u68.userCFrameEnabledConn = nil;
    end;

    u68.enabled = false;
end;

return u8;