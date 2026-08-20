--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SimplePath
  Path:     game.ReplicatedStorage.Library.Imported.SimplePath
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:03 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    TIME_VARIANCE = 0.07,
    COMPARISON_CHECKS = 1,
    JUMP_WHEN_STUCK = true
};
local PathfindingService = game:GetService("PathfindingService");
local Players = game:GetService("Players");

local function output(p2, p3) -- Line: 24
    p2((p2 == error and "SimplePath Error: " or "SimplePath: ") .. p3);
end;

local u4 = {
    StatusType = {
        Idle = "Idle",
        Active = "Active"
    },
    ErrorType = {
        LimitReached = "LimitReached",
        TargetUnreachable = "TargetUnreachable",
        ComputationError = "ComputationError",
        AgentStuck = "AgentStuck"
    }
};

function u4.__index(p5, p6) -- Line: 39
    -- upvalues: u4 (copy)
    if p6 == "Stopped" and not p5._humanoid then
        local v7 = error;
        v7((v7 == error and "SimplePath Error: " or "SimplePath: ") .. "Attempt to use Path.Stopped on a non-humanoid.");
    end;

    return p5._events[p6] and p5._events[p6].Event or p6 == "LastError" and p5._lastError or (p6 == "Status" and p5._status or u4[p6]);
end;

local Part = Instance.new("Part");
Part.Size = Vector3.new(0.3, 0.3, 0.3);
Part.Anchored = true;
Part.CanCollide = false;
Part.Material = Enum.Material.Neon;
Part.Shape = Enum.PartType.Ball;

local function declareError(p8, p9) -- Line: 58
    p8._lastError = p9;
    p8._events.Error:Fire(p9);
end;

local function createVisualWaypoints(p10) -- Line: 64
    -- upvalues: Part (copy)
    local v11 = {};

    for _, v in ipairs(p10) do
        local v12 = Part:Clone();
        v12.Position = v.Position;
        v12.Parent = workspace;
        v12.Color = v == p10[#p10] and Color3.fromRGB(0, 255, 0) or (v.Action == Enum.PathWaypointAction.Jump and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 139, 0));
        table.insert(v11, v12);
    end;

    return v11;
end;

local function destroyVisualWaypoints(p13) -- Line: 80
    if p13 then
        for _, v in ipairs(p13) do
            v:Destroy();
        end;
    end;
end;

local function getNonHumanoidWaypoint(p14) -- Line: 90
    for i = 2, #p14._waypoints do
        if (p14._waypoints[i].Position - p14._waypoints[i - 1].Position).Magnitude > 0.1 then
            return i;
        end;
    end;

    return 2;
end;

local function setJumpState(u15) -- Line: 101
    pcall(function() -- Line: 102
        -- upvalues: u15 (copy)
        if u15._humanoid:GetState() ~= Enum.HumanoidStateType.Jumping and u15._humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
            u15._humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
        end;
    end);
end;

local function move(u16) -- Line: 110
    if u16._waypoints[u16._currentWaypoint].Action == Enum.PathWaypointAction.Jump then
        pcall(function() -- Line: 102
            -- upvalues: u16 (copy)
            if u16._humanoid:GetState() ~= Enum.HumanoidStateType.Jumping and u16._humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
                u16._humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
            end;
        end);
    end;

    u16._humanoid:MoveTo(u16._waypoints[u16._currentWaypoint].Position);
end;

local function disconnectMoveConnection(p17) -- Line: 119
    p17._moveConnection:Disconnect();
    p17._moveConnection = nil;
end;

local function invokeWaypointReached(p18) -- Line: 125
    p18._events.WaypointReached:Fire(p18._agent, p18._waypoints[p18._currentWaypoint - 1], p18._waypoints[p18._currentWaypoint]);
end;

local function moveToFinished(u19, p20) -- Line: 131
    -- upvalues: u4 (copy)
    if not getmetatable(u19) then
        return;
    end;

    if not u19._humanoid then
        if p20 and u19._currentWaypoint + 1 <= #u19._waypoints then
            u19._events.WaypointReached:Fire(u19._agent, u19._waypoints[u19._currentWaypoint - 1], u19._waypoints[u19._currentWaypoint]);
            u19._currentWaypoint = u19._currentWaypoint + 1;

            return;
        end;

        if p20 then
            local _visualWaypoints = u19._visualWaypoints;

            if _visualWaypoints then
                for _, v in ipairs(_visualWaypoints) do
                    v:Destroy();
                end;
            end;

            u19._visualWaypoints = nil;
            u19._target = nil;
            u19._events.Reached:Fire(u19._agent, u19._waypoints[u19._currentWaypoint]);

            return;
        end;

        local _visualWaypoints = u19._visualWaypoints;

        if _visualWaypoints then
            for _, v in ipairs(_visualWaypoints) do
                v:Destroy();
            end;
        end;

        u19._visualWaypoints = nil;
        u19._target = nil;
        local TargetUnreachable = u19.ErrorType.TargetUnreachable;
        u19._lastError = TargetUnreachable;
        u19._events.Error:Fire(TargetUnreachable);

        return;
    end;

    if p20 and u19._currentWaypoint + 1 <= #u19._waypoints then
        if u19._currentWaypoint + 1 < #u19._waypoints then
            u19._events.WaypointReached:Fire(u19._agent, u19._waypoints[u19._currentWaypoint - 1], u19._waypoints[u19._currentWaypoint]);
        end;

        u19._currentWaypoint = u19._currentWaypoint + 1;

        if u19._waypoints[u19._currentWaypoint].Action == Enum.PathWaypointAction.Jump then
            pcall(function() -- Line: 102
                -- upvalues: u19 (copy)
                if u19._humanoid:GetState() ~= Enum.HumanoidStateType.Jumping and u19._humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
                    u19._humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
                end;
            end);
        end;

        u19._humanoid:MoveTo(u19._waypoints[u19._currentWaypoint].Position);

        return;
    end;

    if p20 then
        u19._moveConnection:Disconnect();
        u19._moveConnection = nil;
        u19._status = u4.StatusType.Idle;
        local _visualWaypoints = u19._visualWaypoints;

        if _visualWaypoints then
            for _, v in ipairs(_visualWaypoints) do
                v:Destroy();
            end;
        end;

        u19._visualWaypoints = nil;
        u19._events.Reached:Fire(u19._agent, u19._waypoints[u19._currentWaypoint]);

        return;
    end;

    u19._moveConnection:Disconnect();
    u19._moveConnection = nil;
    u19._status = u4.StatusType.Idle;
    local _visualWaypoints = u19._visualWaypoints;

    if _visualWaypoints then
        for _, v in ipairs(_visualWaypoints) do
            v:Destroy();
        end;
    end;

    u19._visualWaypoints = nil;
    local TargetUnreachable = u19.ErrorType.TargetUnreachable;
    u19._lastError = TargetUnreachable;
    u19._events.Error:Fire(TargetUnreachable);
end;

local function comparePosition(u21) -- Line: 173
    if u21._currentWaypoint == #u21._waypoints then
        return;
    end;

    u21._position._count = (u21._agent.PrimaryPart.Position - u21._position._last).Magnitude <= 0.07 and (u21._position._count + 1 or 0) or 0;
    u21._position._last = u21._agent.PrimaryPart.Position;

    if u21._position._count >= u21._settings.COMPARISON_CHECKS then
        if u21._settings.JUMP_WHEN_STUCK then
            pcall(function() -- Line: 102
                -- upvalues: u21 (copy)
                if u21._humanoid:GetState() ~= Enum.HumanoidStateType.Jumping and u21._humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
                    u21._humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
                end;
            end);
        end;

        local AgentStuck = u21.ErrorType.AgentStuck;
        u21._lastError = AgentStuck;
        u21._events.Error:Fire(AgentStuck);
    end;
end;

function u4.GetNearestCharacter(p22) -- Line: 186
    -- upvalues: Players (copy)
    local v23 = (1 / 0);
    local v24 = nil;

    for _, v in ipairs(Players:GetPlayers()) do
        if v.Character and (v.Character.PrimaryPart.Position - p22).Magnitude < v23 then
            v24 = v.Character;
            v23 = (v.Character.PrimaryPart.Position - p22).Magnitude;
        end;
    end;

    return v24;
end;

function u4.new(p25, p26, p27) -- Line: 197
    -- upvalues: u1 (copy), PathfindingService (copy), u4 (copy)
    if not (p25 and (p25:IsA("Model") and p25.PrimaryPart)) then
        local v28 = error;
        v28((v28 == error and "SimplePath Error: " or "SimplePath: ") .. "Pathfinding agent must be a valid Model Instance with a set PrimaryPart.");
    end;

    local v29 = {
        _status = "Idle",
        _t = 0,
        _settings = p27 or u1,
        _events = {
            Reached = Instance.new("BindableEvent"),
            WaypointReached = Instance.new("BindableEvent"),
            Blocked = Instance.new("BindableEvent"),
            Error = Instance.new("BindableEvent"),
            Stopped = Instance.new("BindableEvent")
        },
        _agent = p25,
        _primary = p25.PrimaryPart,
        _humanoid = p25:FindFirstChildOfClass("Humanoid"),
        _path = PathfindingService:CreatePath(p26),
        _position = {
            _count = 0,
            _last = Vector3.new()
        }
    };
    local u30 = setmetatable(v29, u4);

    for i, v in pairs(u1) do
        u30._settings[i] = u30._settings[i] == nil and v and v or u30._settings[i];
    end;

    u30._path.Blocked:Connect(function(...) -- Line: 229
        -- upvalues: u30 (copy)
        if u30._currentWaypoint <= ... and (... <= u30._currentWaypoint + 1 and u30._humanoid) then
            local u31 = u30;
            pcall(function() -- Line: 102
                -- upvalues: u31 (copy)
                if u31._humanoid:GetState() ~= Enum.HumanoidStateType.Jumping and u31._humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
                    u31._humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
                end;
            end);
            u30._events.Blocked:Fire(u30._agent, u30._waypoints[...]);
        end;
    end);

    return u30;
end;

function u4.Destroy(p32) -- Line: 241
    for _, v in ipairs(p32._events) do
        v:Destroy();
    end;

    p32._events = nil;

    if rawget(p32, "_visualWaypoints") then
        local _visualWaypoints = p32._visualWaypoints;

        if _visualWaypoints then
            for _, v in ipairs(_visualWaypoints) do
                v:Destroy();
            end;
        end;

        p32._visualWaypoints = nil;
    end;

    p32._path:Destroy();
    setmetatable(p32, nil);

    for i, _ in pairs(p32) do
        p32[i] = nil;
    end;
end;

function u4.Stop(p33) -- Line: 256
    -- upvalues: u4 (copy)
    if not p33._humanoid then
        local v34 = error;
        v34((v34 == error and "SimplePath Error: " or "SimplePath: ") .. "Attempt to call Path:Stop() on a non-humanoid.");

        return;
    end;

    if p33._status == u4.StatusType.Idle then
        return;
    end;

    p33._moveConnection:Disconnect();
    p33._moveConnection = nil;
    p33._status = u4.StatusType.Idle;
    local _visualWaypoints = p33._visualWaypoints;

    if _visualWaypoints then
        for _, v in ipairs(_visualWaypoints) do
            v:Destroy();
        end;
    end;

    p33._visualWaypoints = nil;
    p33._events.Stopped:Fire(p33._model);
end;

function u4.Run(u35, u36) -- Line: 273
    -- upvalues: moveToFinished (copy), u4 (copy), comparePosition (copy), createVisualWaypoints (copy), getNonHumanoidWaypoint (copy)
    if u36 or (u35._humanoid or not u35._target) then
        if not u36 or typeof(u36) ~= "Vector3" and not u36:IsA("BasePart") then
            local v37 = error;
            v37((v37 == error and "SimplePath Error: " or "SimplePath: ") .. "Pathfinding target must be a valid Vector3 or BasePart.");
        end;

        if os.clock() - u35._t <= u35._settings.TIME_VARIANCE and u35._humanoid then
            task.wait(os.clock() - u35._t);
            local LimitReached = u35.ErrorType.LimitReached;
            u35._lastError = LimitReached;
            u35._events.Error:Fire(LimitReached);

            return false;
        end;

        if u35._humanoid then
            u35._t = os.clock();
        end;

        local success, _ = pcall(function() -- Line: 296
            -- upvalues: u35 (copy), u36 (copy)
            u35._path:ComputeAsync(u35._agent.PrimaryPart.Position, typeof(u36) == "Vector3" and u36 or u36.Position);
        end);

        if not success or (u35._path.Status == Enum.PathStatus.NoPath or (#u35._path:GetWaypoints() < 2 or u35._humanoid and u35._humanoid:GetState() == Enum.HumanoidStateType.Freefall)) then
            local _visualWaypoints = u35._visualWaypoints;

            if _visualWaypoints then
                for _, v in ipairs(_visualWaypoints) do
                    v:Destroy();
                end;
            end;

            u35._visualWaypoints = nil;
            task.wait();
            local ComputationError = u35.ErrorType.ComputationError;
            u35._lastError = ComputationError;
            u35._events.Error:Fire(ComputationError);

            return false;
        end;

        u35._status = u35._humanoid and u4.StatusType.Active or u4.StatusType.Idle;
        u35._target = u36;
        pcall(function() -- Line: 316
            -- upvalues: u35 (copy)
            u35._agent.PrimaryPart:SetNetworkOwner(nil);
        end);
        u35._waypoints = u35._path:GetWaypoints();
        u35._currentWaypoint = 2;

        if u35._humanoid then
            comparePosition(u35);
        end;

        local _visualWaypoints = u35._visualWaypoints;

        if _visualWaypoints then
            for _, v in ipairs(_visualWaypoints) do
                v:Destroy();
            end;
        end;

        local v38 = u35.Visualize and createVisualWaypoints(u35._waypoints);
        u35._visualWaypoints = v38;
        local v39 = u35._humanoid and (u35._moveConnection or u35._humanoid.MoveToFinished:Connect(function(...) -- Line: 334
            -- upvalues: moveToFinished (ref), u35 (copy)
            moveToFinished(u35, ...);
        end));
        u35._moveConnection = v39;

        if u35._humanoid then
            u35._primary:SetNetworkOwner(nil);
            u35._humanoid:MoveTo(u35._waypoints[u35._currentWaypoint].Position);
        elseif #u35._waypoints == 2 then
            u35._target = nil;
            local _visualWaypoints2 = u35._visualWaypoints;

            if _visualWaypoints2 then
                for _, v in ipairs(_visualWaypoints2) do
                    v:Destroy();
                end;
            end;

            u35._visualWaypoints = nil;
            u35._events.Reached:Fire(u35._agent, u35._waypoints[2]);
        else
            u35._currentWaypoint = getNonHumanoidWaypoint(u35);
            moveToFinished(u35, true);
        end;

        return true;
    end;

    moveToFinished(u35, true);
end;

return u4;