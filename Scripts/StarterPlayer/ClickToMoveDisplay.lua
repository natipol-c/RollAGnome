--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ClickToMoveDisplay
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule.ClickToMoveDisplay
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:10 2026
]]

-- Decompiled with Potassium's decompiler.

local v1 = {};
local u2 = "rbxasset://textures/ui/traildot.png";
local u3 = "rbxasset://textures/ui/waypoint.png";
local u4 = false;
local u5 = UDim2.new(0, 42, 0, 50);
local u6 = Vector2.new(0, 0.5);
local u7 = Vector2.new(0, 1);
local u8 = Vector2.new(0, 0.5);
local u9 = Vector2.new(0.1, 0.5);
local u10 = Vector2.new(-0.1, 0.5);
local u11 = Vector2.new(1.5, 1.5);
local u12 = RaycastParams.new();
u12.FilterType = Enum.RaycastFilterType.Exclude;
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Workspace = game:GetService("Workspace");
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local u13 = require(CommonUtils:WaitForChild("FlagUtil")).getUserFlag("UserRaycastUpdateAPI2");
local LocalPlayer = Players.LocalPlayer;

local function CreateWaypointTemplates() -- Line: 55
    -- upvalues: u11 (ref), u4 (ref), u2 (ref), u5 (copy), u6 (copy), u3 (ref), u8 (copy)
    local Part = Instance.new("Part");
    Part.Size = Vector3.new(1, 1, 1);
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.Name = "TrailDot";
    Part.Transparency = 1;
    local ImageHandleAdornment = Instance.new("ImageHandleAdornment");
    ImageHandleAdornment.Name = "TrailDotImage";
    ImageHandleAdornment.Size = u11;
    ImageHandleAdornment.SizeRelativeOffset = Vector3.new(0, 0, -0.1);
    ImageHandleAdornment.AlwaysOnTop = u4;
    ImageHandleAdornment.Image = u2;
    ImageHandleAdornment.Adornee = Part;
    ImageHandleAdornment.Parent = Part;
    local Part2 = Instance.new("Part");
    Part2.Size = Vector3.new(2, 2, 2);
    Part2.Anchored = true;
    Part2.CanCollide = false;
    Part2.Name = "EndWaypoint";
    Part2.Transparency = 1;
    local ImageHandleAdornment2 = Instance.new("ImageHandleAdornment");
    ImageHandleAdornment2.Name = "TrailDotImage";
    ImageHandleAdornment2.Size = u11;
    ImageHandleAdornment2.SizeRelativeOffset = Vector3.new(0, 0, -0.1);
    ImageHandleAdornment2.AlwaysOnTop = u4;
    ImageHandleAdornment2.Image = u2;
    ImageHandleAdornment2.Adornee = Part2;
    ImageHandleAdornment2.Parent = Part2;
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "EndWaypointBillboard";
    BillboardGui.Size = u5;
    BillboardGui.LightInfluence = 0;
    BillboardGui.SizeOffset = u6;
    BillboardGui.AlwaysOnTop = true;
    BillboardGui.Adornee = Part2;
    BillboardGui.Parent = Part2;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Image = u3;
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Size = UDim2.new(1, 0, 1, 0);
    ImageLabel.Parent = BillboardGui;
    local Part3 = Instance.new("Part");
    Part3.Size = Vector3.new(2, 2, 2);
    Part3.Anchored = true;
    Part3.CanCollide = false;
    Part3.Name = "FailureWaypoint";
    Part3.Transparency = 1;
    local ImageHandleAdornment3 = Instance.new("ImageHandleAdornment");
    ImageHandleAdornment3.Name = "TrailDotImage";
    ImageHandleAdornment3.Size = u11;
    ImageHandleAdornment3.SizeRelativeOffset = Vector3.new(0, 0, -0.1);
    ImageHandleAdornment3.AlwaysOnTop = u4;
    ImageHandleAdornment3.Image = u2;
    ImageHandleAdornment3.Adornee = Part3;
    ImageHandleAdornment3.Parent = Part3;
    local BillboardGui2 = Instance.new("BillboardGui");
    BillboardGui2.Name = "FailureWaypointBillboard";
    BillboardGui2.Size = u5;
    BillboardGui2.LightInfluence = 0;
    BillboardGui2.SizeOffset = u8;
    BillboardGui2.AlwaysOnTop = true;
    BillboardGui2.Adornee = Part3;
    BillboardGui2.Parent = Part3;
    local Frame = Instance.new("Frame");
    Frame.BackgroundTransparency = 1;
    Frame.Size = UDim2.new(0, 0, 0, 0);
    Frame.Position = UDim2.new(0.5, 0, 1, 0);
    Frame.Parent = BillboardGui2;
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.Image = u3;
    ImageLabel2.BackgroundTransparency = 1;
    ImageLabel2.Position = UDim2.new(0, -u5.X.Offset / 2, 0, -u5.Y.Offset);
    ImageLabel2.Size = u5;
    ImageLabel2.Parent = Frame;

    return Part, Part2, Part3;
end;

local u14, u15, u16 = CreateWaypointTemplates();

local function getTrailDotParent() -- Line: 141
    -- upvalues: Workspace (copy)
    local CurrentCamera = Workspace.CurrentCamera;
    local ClickToMoveDisplay = CurrentCamera:FindFirstChild("ClickToMoveDisplay");

    if not ClickToMoveDisplay then
        ClickToMoveDisplay = Instance.new("Model");
        ClickToMoveDisplay.Name = "ClickToMoveDisplay";
        ClickToMoveDisplay.Parent = CurrentCamera;
    end;

    return ClickToMoveDisplay;
end;

local function placePathWaypoint(p17, p18) -- Line: 152
    -- upvalues: u13 (copy), u12 (copy), Workspace (copy), LocalPlayer (copy)
    if u13 then
        u12.FilterDescendantsInstances = { Workspace.CurrentCamera, LocalPlayer.Character };
        local v19 = Workspace:Raycast(p18 + Vector3.new(0, 2.5, 0), Vector3.new(-0, -10, -0), u12);

        if v19 then
            p17.CFrame = CFrame.lookAlong(v19.Position, v19.Normal);
            local CurrentCamera = Workspace.CurrentCamera;
            local ClickToMoveDisplay = CurrentCamera:FindFirstChild("ClickToMoveDisplay");

            if not ClickToMoveDisplay then
                ClickToMoveDisplay = Instance.new("Model");
                ClickToMoveDisplay.Name = "ClickToMoveDisplay";
                ClickToMoveDisplay.Parent = CurrentCamera;
            end;

            p17.Parent = ClickToMoveDisplay;
        end;
    else
        local v20, v21, v22 = Workspace:FindPartOnRayWithIgnoreList(Ray.new(p18 + Vector3.new(0, 2.5, 0), Vector3.new(0, -10, 0)), { Workspace.CurrentCamera, LocalPlayer.Character });

        if v20 then
            p17.CFrame = CFrame.new(v21, v21 + v22);
            local CurrentCamera = Workspace.CurrentCamera;
            local ClickToMoveDisplay = CurrentCamera:FindFirstChild("ClickToMoveDisplay");

            if not ClickToMoveDisplay then
                ClickToMoveDisplay = Instance.new("Model");
                ClickToMoveDisplay.Name = "ClickToMoveDisplay";
                ClickToMoveDisplay.Parent = CurrentCamera;
            end;

            p17.Parent = ClickToMoveDisplay;
        end;
    end;
end;

local u23 = {};
u23.__index = u23;

function u23.Destroy(p24) -- Line: 177
    p24.DisplayModel:Destroy();
end;

function u23.NewDisplayModel(p25, p26) -- Line: 181
    -- upvalues: u14 (ref), placePathWaypoint (copy)
    local v27 = u14:Clone();
    placePathWaypoint(v27, p26);

    return v27;
end;

function u23.new(p28, p29) -- Line: 187
    -- upvalues: u23 (copy)
    local v30 = setmetatable({}, u23);
    v30.DisplayModel = v30:NewDisplayModel(p28);
    v30.ClosestWayPoint = p29;

    return v30;
end;

local u31 = {};
u31.__index = u31;

function u31.Destroy(p32) -- Line: 199
    p32.Destroyed = true;
    p32.Tween:Cancel();
    p32.DisplayModel:Destroy();
end;

function u31.NewDisplayModel(p33, p34) -- Line: 205
    -- upvalues: u15 (ref), placePathWaypoint (copy)
    local v35 = u15:Clone();
    placePathWaypoint(v35, p34);

    return v35;
end;

function u31.CreateTween(p36) -- Line: 211
    -- upvalues: TweenService (copy), u7 (copy)
    local v37 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, -1, true);
    local v38 = TweenService:Create(p36.DisplayModel.EndWaypointBillboard, v37, {
        SizeOffset = u7
    });
    v38:Play();

    return v38;
end;

function u31.TweenInFrom(p39, p40) -- Line: 222
    -- upvalues: TweenService (copy)
    p39.DisplayModel.EndWaypointBillboard.StudsOffset = Vector3.new(0, (p40 - p39.DisplayModel.Position).Y, 0);
    local v41 = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    local v42 = TweenService:Create(p39.DisplayModel.EndWaypointBillboard, v41, {
        StudsOffset = Vector3.new(0, 0, 0)
    });
    v42:Play();

    return v42;
end;

function u31.new(p43, p44, p45) -- Line: 236
    -- upvalues: u31 (copy)
    local u46 = setmetatable({}, u31);
    u46.DisplayModel = u46:NewDisplayModel(p43);
    u46.Destroyed = false;

    if p45 and (p45 - p43).Magnitude > 5 then
        u46.Tween = u46:TweenInFrom(p45);
        coroutine.wrap(function() -- Line: 243
            -- upvalues: u46 (copy)
            u46.Tween.Completed:Wait();

            if not u46.Destroyed then
                u46.Tween = u46:CreateTween();
            end;
        end)();
    else
        u46.Tween = u46:CreateTween();
    end;

    u46.ClosestWayPoint = p44;

    return u46;
end;

local u47 = {};
u47.__index = u47;

function u47.Hide(p48) -- Line: 260
    p48.DisplayModel.Parent = nil;
end;

function u47.Destroy(p49) -- Line: 264
    p49.DisplayModel:Destroy();
end;

function u47.NewDisplayModel(p50, p51) -- Line: 268
    -- upvalues: u16 (ref), placePathWaypoint (copy), u13 (copy), u12 (copy), Workspace (copy), LocalPlayer (copy)
    local v52 = u16:Clone();
    placePathWaypoint(v52, p51);

    if u13 then
        u12.FilterDescendantsInstances = { Workspace.CurrentCamera, LocalPlayer.Character };
        local v53 = Workspace:Raycast(p51 + Vector3.new(0, 2.5, 0), Vector3.new(-0, -10, -0), u12);

        if v53 then
            v52.CFrame = CFrame.lookAlong(v53.Position, v53.Normal);
            local CurrentCamera = Workspace.CurrentCamera;
            local ClickToMoveDisplay = CurrentCamera:FindFirstChild("ClickToMoveDisplay");

            if not ClickToMoveDisplay then
                ClickToMoveDisplay = Instance.new("Model");
                ClickToMoveDisplay.Name = "ClickToMoveDisplay";
                ClickToMoveDisplay.Parent = CurrentCamera;
            end;

            v52.Parent = ClickToMoveDisplay;

            return v52;
        end;
    else
        local v54, v55, v56 = Workspace:FindPartOnRayWithIgnoreList(Ray.new(p51 + Vector3.new(0, 2.5, 0), Vector3.new(0, -10, 0)), { Workspace.CurrentCamera, LocalPlayer.Character });

        if v54 then
            v52.CFrame = CFrame.new(v55, v55 + v56);
            local CurrentCamera = Workspace.CurrentCamera;
            local ClickToMoveDisplay = CurrentCamera:FindFirstChild("ClickToMoveDisplay");

            if not ClickToMoveDisplay then
                ClickToMoveDisplay = Instance.new("Model");
                ClickToMoveDisplay.Name = "ClickToMoveDisplay";
                ClickToMoveDisplay.Parent = CurrentCamera;
            end;

            v52.Parent = ClickToMoveDisplay;
        end;
    end;

    return v52;
end;

function u47.RunFailureTween(p57) -- Line: 292
    -- upvalues: TweenService (copy), u9 (copy), u10 (copy), u8 (copy)
    wait(0.125);
    local v58 = TweenInfo.new(0.0625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    local v59 = TweenService:Create(p57.DisplayModel.FailureWaypointBillboard, v58, {
        SizeOffset = u9
    });
    v59:Play();
    TweenService:Create(p57.DisplayModel.FailureWaypointBillboard.Frame, v58, {
        Rotation = 10
    }):Play();
    v59.Completed:wait();
    local v60 = TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 3, true);
    local v61 = TweenService:Create(p57.DisplayModel.FailureWaypointBillboard, v60, {
        SizeOffset = u10
    });
    v61:Play();
    local v62 = TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 3, true);
    TweenService:Create(p57.DisplayModel.FailureWaypointBillboard.Frame.ImageLabel, v62, {
        ImageColor3 = Color3.new(0.75, 0.75, 0.75)
    }):Play();
    TweenService:Create(p57.DisplayModel.FailureWaypointBillboard.Frame, v62, {
        Rotation = -10
    }):Play();
    v61.Completed:wait();
    local v63 = TweenInfo.new(0.0625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    local v64 = TweenService:Create(p57.DisplayModel.FailureWaypointBillboard, v63, {
        SizeOffset = u8
    });
    v64:Play();
    TweenService:Create(p57.DisplayModel.FailureWaypointBillboard.Frame, v63, {
        Rotation = 0
    }):Play();
    v64.Completed:wait();
    wait(0.125);
end;

function u47.new(p65) -- Line: 341
    -- upvalues: u47 (copy)
    local v66 = setmetatable({}, u47);
    v66.DisplayModel = v66:NewDisplayModel(p65);

    return v66;
end;

local Animation = Instance.new("Animation");
Animation.AnimationId = "rbxassetid://2874840706";
local u67 = nil;

local function getFailureAnimationTrack(p68) -- Line: 355
    -- upvalues: u67 (ref), Animation (copy)
    if p68 == nil then
        return u67;
    end;

    u67 = p68:LoadAnimation(Animation);
    assert(u67, "");
    u67.Priority = Enum.AnimationPriority.Action;
    u67.Looped = false;

    return u67;
end;

local function findPlayerHumanoid() -- Line: 366
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character then
        return Character:FindFirstChildOfClass("Humanoid");
    end;
end;

local function createTrailDots(p69, p70) -- Line: 373
    -- upvalues: u23 (copy), u31 (copy)
    local v71 = {};
    local v72 = 1;

    for i = 1, #p69 - 1 do
        local v73 = (p69[i].Position - p69[#p69].Position).Magnitude < 3;
        local v74;

        if i % 2 == 0 then
            v74 = not v73;
        else
            v74 = false;
        end;

        if v74 then
            v71[v72] = u23.new(p69[i].Position, i);
            v72 = v72 + 1;
        end;
    end;

    local v75 = u31.new(p69[#p69].Position, #p69, p70);
    table.insert(v71, v75);
    local v76 = {};
    local v77 = 1;

    for i = #v71, 1, -1 do
        v76[v77] = v71[i];
        v77 = v77 + 1;
    end;

    return v76;
end;

local function getTrailDotScale(p78, p79) -- Line: 398
    return p79 * (math.clamp(p78 - 10, 0, 90) / 90 * 1.5 + 1);
end;

local u80 = 0;

function v1.CreatePathDisplay(u81, p82) -- Line: 407
    -- upvalues: u80 (ref), createTrailDots (copy), RunService (copy), Workspace (copy), u11 (ref)
    u80 = u80 + 1;
    local u83 = createTrailDots(u81, p82);

    local function removePathBeforePoint(p84) -- Line: 411
        -- upvalues: u83 (copy)
        for i = #u83, 1, -1 do
            local v85 = u83[i];

            if v85.ClosestWayPoint > p84 then
                break;
            end;

            v85:Destroy();
            u83[i] = nil;
        end;
    end;

    local u86 = "ClickToMoveResizeTrail" .. u80;
    RunService:BindToRenderStep(u86, Enum.RenderPriority.Camera.Value - 1, function() -- Line: 425, Name: resizeTrailDots
        -- upvalues: u83 (copy), RunService (ref), u86 (copy), Workspace (ref), u11 (ref)
        if #u83 == 0 then
            RunService:UnbindFromRenderStep(u86);

            return;
        end;

        local p = Workspace.CurrentCamera.CFrame.p;

        for i = 1, #u83 do
            local TrailDotImage = u83[i].DisplayModel:FindFirstChild("TrailDotImage");

            if TrailDotImage then
                TrailDotImage.Size = u11 * (math.clamp((u83[i].DisplayModel.Position - p).Magnitude - 10, 0, 90) / 90 * 1.5 + 1);
            end;
        end;
    end);

    return function() -- Line: 441, Name: removePath
        -- upvalues: removePathBeforePoint (copy), u81 (copy)
        removePathBeforePoint(#u81);
    end, removePathBeforePoint;
end;

local u87 = nil;

function v1.DisplayFailureWaypoint(p88) -- Line: 449
    -- upvalues: u87 (ref), u47 (copy)
    if u87 then
        u87:Hide();
    end;

    local u89 = u47.new(p88);
    u87 = u89;
    coroutine.wrap(function() -- Line: 455
        -- upvalues: u89 (ref)
        u89:RunFailureTween();
        u89:Destroy();
        u89 = nil;
    end)();
end;

function v1.CreateEndWaypoint(p90) -- Line: 462
    -- upvalues: u31 (copy)
    return u31.new(p90);
end;

function v1.PlayFailureAnimation() -- Line: 466
    -- upvalues: LocalPlayer (copy), u67 (ref), Animation (copy)
    local Character = LocalPlayer.Character;
    local v91;

    if Character then
        v91 = Character:FindFirstChildOfClass("Humanoid");
    else
        v91 = nil;
    end;

    if v91 then
        local v92;

        if v91 == nil then
            v92 = u67;
        else
            u67 = v91:LoadAnimation(Animation);
            assert(u67, "");
            u67.Priority = Enum.AnimationPriority.Action;
            u67.Looped = false;
            v92 = u67;
        end;

        v92:Play();
    end;
end;

function v1.CancelFailureAnimation() -- Line: 474
    -- upvalues: u67 (ref)
    if u67 ~= nil and u67.IsPlaying then
        u67:Stop();
    end;
end;

function v1.SetWaypointTexture(p93) -- Line: 480
    -- upvalues: u2 (ref), u14 (ref), u15 (ref), u16 (ref), CreateWaypointTemplates (copy)
    u2 = p93;
    local v94, v95, v96 = CreateWaypointTemplates();
    u14 = v94;
    u15 = v95;
    u16 = v96;
end;

function v1.GetWaypointTexture() -- Line: 485
    -- upvalues: u2 (ref)
    return u2;
end;

function v1.SetWaypointRadius(p97) -- Line: 489
    -- upvalues: u11 (ref), u14 (ref), u15 (ref), u16 (ref), CreateWaypointTemplates (copy)
    u11 = Vector2.new(p97, p97);
    local v98, v99, v100 = CreateWaypointTemplates();
    u14 = v98;
    u15 = v99;
    u16 = v100;
end;

function v1.GetWaypointRadius() -- Line: 494
    -- upvalues: u11 (ref)
    return u11.X;
end;

function v1.SetEndWaypointTexture(p101) -- Line: 498
    -- upvalues: u3 (ref), u14 (ref), u15 (ref), u16 (ref), CreateWaypointTemplates (copy)
    u3 = p101;
    local v102, v103, v104 = CreateWaypointTemplates();
    u14 = v102;
    u15 = v103;
    u16 = v104;
end;

function v1.GetEndWaypointTexture() -- Line: 503
    -- upvalues: u3 (ref)
    return u3;
end;

function v1.SetWaypointsAlwaysOnTop(p105) -- Line: 507
    -- upvalues: u4 (ref), u14 (ref), u15 (ref), u16 (ref), CreateWaypointTemplates (copy)
    u4 = p105;
    local v106, v107, v108 = CreateWaypointTemplates();
    u14 = v106;
    u15 = v107;
    u16 = v108;
end;

function v1.GetWaypointsAlwaysOnTop() -- Line: 512
    -- upvalues: u4 (ref)
    return u4;
end;

return v1;