--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GrowPlants
  Path:     game.ReplicatedStorage.Library.GrowPlants
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:30 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local u1 = {};
local u2 = {};
local u3 = {};
local u4 = false;
local u5 = nil;
local u6 = {};
local u7;

if RunService:IsServer() then
    u7 = script:FindFirstChild("GrowthStarted") or Instance.new("RemoteEvent");
    u7.Name = "GrowthStarted";
    u7.Parent = script;
else
    u7 = script:WaitForChild("GrowthStarted");
end;

local function getParts(p8) -- Line: 30
    local v9 = {};

    if p8:IsA("BasePart") then
        if p8:GetAttribute("BLOCK") == nil then
            table.insert(v9, p8);

            return v9;
        end;
    else
        for _, descendant in p8:GetDescendants() do
            if descendant:IsA("BasePart") and descendant:GetAttribute("BLOCK") == nil then
                table.insert(v9, descendant);
            end;
        end;
    end;

    return v9;
end;

local function getStages(p10) -- Line: 48
    local v11 = {};

    for _, child in p10:GetChildren() do
        local v12 = tonumber(child.Name);

        if v12 then
            table.insert(v11, {
                Order = v12,
                Instance = child
            });
        end;
    end;

    table.sort(v11, function(p13, p14) -- Line: 58
        return p13.Order < p14.Order;
    end);

    return v11;
end;

local function countGrowthParts(p15) -- Line: 65
    -- upvalues: getStages (copy), getParts (copy)
    local v16 = 0;

    for _, v in getStages(p15) do
        v16 = v16 + #getParts(v.Instance);
    end;

    return v16;
end;

local function hasScaleOut(p17, p18) -- Line: 75
    while p18 and p18 ~= p17.Parent do
        if p18:GetAttribute("ScaleOut") == true then
            return true;
        end;

        if p18 == p17 then
            break;
        end;

        p18 = p18.Parent;
    end;

    return false;
end;

local function getGrowAxis(p19) -- Line: 89
    local v20 = p19:GetAttribute("GrowAxis");

    return v20 ~= "X" and (v20 ~= "Y" and v20 ~= "Z") and "Y" or v20;
end;

local function capturePart(p21, p22) -- Line: 99
    -- upvalues: hasScaleOut (copy)
    local v23 = p22:GetPivot();
    local v24 = v23:ToObjectSpace(p22.CFrame);
    local Position = v24.Position;
    local v25;

    if hasScaleOut(p21, p22) then
        Position = Position * 0.001;
        local v26 = math.max(p22.Size.X * 0.001, 0.01);
        local v27 = math.max(p22.Size.Y * 0.001, 0.01);
        local v28 = math.max(p22.Size.Z * 0.001, 0.01);
        v25 = Vector3.new(v26, v27, v28);
    else
        local v29 = p22:GetAttribute("GrowAxis");
        local v30 = v29 ~= "X" and (v29 ~= "Y" and v29 ~= "Z") and "Y" or v29;
        v25 = p22.Size;

        if v30 == "X" then
            Position = Vector3.new(Position.X * 0.001, Position.Y, Position.Z);
            local v31 = math.max(p22.Size.X * 0.001, 0.01);
            v25 = Vector3.new(v31, p22.Size.Y, p22.Size.Z);
        elseif v30 == "Y" then
            Position = Vector3.new(Position.X, Position.Y * 0.001, Position.Z);
            local X = p22.Size.X;
            local v32 = math.max(p22.Size.Y * 0.001, 0.01);
            v25 = Vector3.new(X, v32, p22.Size.Z);
        elseif v30 == "Z" then
            Position = Vector3.new(Position.X, Position.Y, Position.Z * 0.001);
            local X = p22.Size.X;
            local Y = p22.Size.Y;
            local v33 = math.max(p22.Size.Z * 0.001, 0.01);
            v25 = Vector3.new(X, Y, v33);
        end;
    end;

    return {
        Part = p22,
        OriginalSize = p22.Size,
        OriginalCFrame = p22.CFrame,
        OriginalTransparency = p22.Transparency,
        OriginalCanCollide = p22.CanCollide,
        StartSize = v25,
        StartCFrame = v23 * CFrame.new(Position) * v24.Rotation
    };
end;

local function captureStage(p34) -- Line: 166
    -- upvalues: getParts (copy), capturePart (copy)
    local v35 = {
        Height = p34:IsA("Model") and p34:GetExtentsSize().Y or p34.Size.Y,
        Parts = {}
    };

    for _, v in getParts(p34) do
        local Parts = v35.Parts;
        local v36 = capturePart(p34, v);
        table.insert(Parts, v36);
    end;

    return v35;
end;

local function prehideStage(p37) -- Line: 179
    -- upvalues: getParts (copy)
    for _, v in getParts(p37) do
        v.LocalTransparencyModifier = 1;
        v.CanCollide = false;
    end;
end;

local function prehidePlant(p38) -- Line: 186
    -- upvalues: getStages (copy), getParts (copy)
    for _, v in getStages(p38) do
        for _, v2 in getParts(v.Instance) do
            v2.LocalTransparencyModifier = 1;
            v2.CanCollide = false;
        end;
    end;
end;

local function prehideDescendant(p39) -- Line: 192
    if not p39:IsA("BasePart") or p39:GetAttribute("BLOCK") ~= nil then
        for _, descendant in p39:GetDescendants() do
            if descendant:IsA("BasePart") and descendant:GetAttribute("BLOCK") == nil then
                descendant.LocalTransparencyModifier = 1;
                descendant.CanCollide = false;
            end;
        end;

        return;
    end;

    p39.LocalTransparencyModifier = 1;
    p39.CanCollide = false;
end;

local function hidePart(p40) -- Line: 207
    local Part = p40.Part;

    if Part.Parent then
        Part.LocalTransparencyModifier = 1;
        Part.CanCollide = false;
    end;
end;

local function setPartProgress(p41, p42) -- Line: 215
    local Part = p41.Part;

    if Part.Parent then
        Part.LocalTransparencyModifier = 0;
        Part.Transparency = p41.OriginalTransparency;
        Part.CanCollide = p41.OriginalCanCollide;
        Part.Size = p41.StartSize:Lerp(p41.OriginalSize, p42);
        Part.CFrame = p41.StartCFrame:Lerp(p41.OriginalCFrame, p42);
    end;
end;

local function hideStage(p43) -- Line: 226
    for _, v in p43.Parts do
        local Part = v.Part;

        if Part.Parent then
            Part.LocalTransparencyModifier = 1;
            Part.CanCollide = false;
        end;
    end;
end;

local function setStageProgress(p44, p45) -- Line: 232
    for _, v in p44.Parts do
        local Part = v.Part;

        if Part.Parent then
            Part.LocalTransparencyModifier = 0;
            Part.Transparency = v.OriginalTransparency;
            Part.CanCollide = v.OriginalCanCollide;
            Part.Size = v.StartSize:Lerp(v.OriginalSize, p45);
            Part.CFrame = v.StartCFrame:Lerp(v.OriginalCFrame, p45);
        end;
    end;
end;

local function getStageProgress(p46, p47) -- Line: 238
    if p47.EndTime <= p46 then
        return 1;
    end;

    if p46 <= p47.StartTime then
        return 0;
    end;

    local v48 = p47.EndTime - p47.StartTime;

    return v48 > 0 and math.clamp((p46 - p47.StartTime) / v48, 0, 1) or 1;
end;

local function getGrowthSpeed(p49) -- Line: 252
    local v50 = p49:GetAttribute("GrowthSpeedMulti");
    local v51 = p49:GetAttribute("PlayerGrowthSpeedMulti");
    local v52 = type(v50) == "number" and v50 and v50 or 0;
    local v53 = math.max(v52, 0) + 1;
    local v54 = type(v51) == "number" and v51 and v51 or 0;

    return v53 + math.max(v54, 0);
end;

local u55 = nil;

local function setPlantProgress(p56) -- Line: 263
    -- upvalues: u55 (ref), u2 (copy)
    local Plant = p56.Plant;
    local v57 = Plant:GetAttribute("GrowthStartTime");
    local v58 = Plant:GetAttribute("TotalGrowTime");

    if type(v57) ~= "number" or type(v58) ~= "number" then
        return;
    end;

    local v59 = u55(Plant);

    for _, v in p56.Stages do
        local v60;

        if v.EndTime <= v59 then
            v60 = 1;
        elseif v59 <= v.StartTime then
            v60 = 0;
        else
            local v61 = v.EndTime - v.StartTime;
            v60 = v61 > 0 and (math.clamp((v59 - v.StartTime) / v61, 0, 1) or 1) or 1;
        end;

        if v60 <= 0 then
            for _, v2 in v.Data.Parts do
                local Part = v2.Part;

                if Part.Parent then
                    Part.LocalTransparencyModifier = 1;
                    Part.CanCollide = false;
                end;
            end;
        else
            for _, v2 in v.Data.Parts do
                local Part = v2.Part;

                if Part.Parent then
                    Part.LocalTransparencyModifier = 0;
                    Part.Transparency = v2.OriginalTransparency;
                    Part.CanCollide = v2.OriginalCanCollide;
                    Part.Size = v2.StartSize:Lerp(v2.OriginalSize, v60);
                    Part.CFrame = v2.StartCFrame:Lerp(v2.OriginalCFrame, v60);
                end;
            end;
        end;
    end;

    if v58 <= v59 or Plant:GetAttribute("READY") then
        for _, v in p56.Stages do
            for _, v2 in v.Data.Parts do
                local Part = v2.Part;

                if Part.Parent then
                    Part.LocalTransparencyModifier = 0;
                    Part.Transparency = v2.OriginalTransparency;
                    Part.CanCollide = v2.OriginalCanCollide;
                    Part.Size = v2.StartSize:Lerp(v2.OriginalSize, 1);
                    Part.CFrame = v2.StartCFrame:Lerp(v2.OriginalCFrame, 1);
                end;
            end;
        end;

        if p56.DescendantConnection then
            p56.DescendantConnection:Disconnect();
            p56.DescendantConnection = nil;
        end;

        u2[Plant] = nil;
    end;
end;

u55 = function(p62) -- Line: 295
    local v63 = p62:GetAttribute("GrowthStartTime");
    local v64 = p62:GetAttribute("TotalGrowTime");

    if type(v63) == "number" and type(v64) == "number" then
        local v65 = p62:GetAttribute("GrowthElapsedOffset");
        local v66 = p62:GetAttribute("GrowthSpeedStartTime");

        if type(v65) ~= "number" or type(v66) ~= "number" then
            local v67 = workspace:GetServerTimeNow() - v63;

            return math.clamp(v67, 0, v64);
        end;

        local v68 = workspace:GetServerTimeNow() - v66;
        local v69 = p62:GetAttribute("GrowthSpeedMulti");
        local v70 = p62:GetAttribute("PlayerGrowthSpeedMulti");
        local v71 = type(v69) == "number" and v69 and v69 or 0;
        local v72 = math.max(v71, 0) + 1;
        local v73 = type(v70) == "number" and v70 and v70 or 0;
        local v74 = v65 + v68 * (v72 + math.max(v73, 0));

        return math.clamp(v74, 0, v64);
    end;
end;

local function getStageForDescendant(p75, p76) -- Line: 310
    for _, v in p75.Stages do
        if p76 == v.Stage or p76:IsDescendantOf(v.Stage) then
            return v;
        end;
    end;
end;

local function trackLatePart(p77, p78) -- Line: 318
    -- upvalues: getStageForDescendant (copy), capturePart (copy), u55 (ref)
    if not p78:IsA("BasePart") or p78:GetAttribute("BLOCK") ~= nil then
        return;
    end;

    local v79 = getStageForDescendant(p77, p78);

    if not v79 then
        return;
    end;

    p78.LocalTransparencyModifier = 1;
    p78.CanCollide = false;
    local v80 = capturePart(v79.Stage, p78);
    table.insert(v79.Data.Parts, v80);
    local v81 = u55(p77.Plant);
    local v82;

    if v81 then
        local v83;

        if v79.EndTime <= v81 then
            v83 = 1;
        elseif v81 <= v79.StartTime then
            v83 = 0;
        else
            local v84 = v79.EndTime - v79.StartTime;
            v83 = v84 > 0 and math.clamp((v81 - v79.StartTime) / v84, 0, 1) or 1;
        end;

        v82 = v83 or 0;
    else
        v82 = 0;
    end;

    if v82 <= 0 then
        local Part = v80.Part;

        if Part.Parent then
            Part.LocalTransparencyModifier = 1;
            Part.CanCollide = false;
        end;
    else
        local Part = v80.Part;

        if Part.Parent then
            Part.LocalTransparencyModifier = 0;
            Part.Transparency = v80.OriginalTransparency;
            Part.CanCollide = v80.OriginalCanCollide;
            Part.Size = v80.StartSize:Lerp(v80.OriginalSize, v82);
            Part.CFrame = v80.StartCFrame:Lerp(v80.OriginalCFrame, v82);
        end;
    end;
end;

local function trackLateDescendant(p85, p86) -- Line: 338
    -- upvalues: trackLatePart (copy)
    if p86:IsA("BasePart") then
        trackLatePart(p85, p86);

        return;
    end;

    for _, descendant in p86:GetDescendants() do
        if descendant:IsA("BasePart") then
            trackLatePart(p85, descendant);
        end;
    end;
end;

local function getDistance(p87) -- Line: 351
    local CurrentCamera = workspace.CurrentCamera;
    local Character = game:GetService("Players").LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    local v88 = Character and Character.Position;

    if v88 then
        CurrentCamera = v88;
    elseif CurrentCamera then
        CurrentCamera = CurrentCamera.CFrame.Position;
    end;

    return not CurrentCamera and (1 / 0) or (p87:GetPivot().Position - CurrentCamera).Magnitude;
end;

local function trackPlant(u89) -- Line: 361
    -- upvalues: u3 (copy), u2 (copy), getStages (copy), getParts (copy), captureStage (copy), trackLateDescendant (copy), setPlantProgress (copy)
    local v90 = u3[u89];

    if v90 and v90.Connection then
        v90.Connection:Disconnect();
    end;

    u3[u89] = nil;

    if u2[u89] or not u89.Parent then
        return;
    end;

    local v91 = u89:GetAttribute("GrowthStartTime");
    local v92 = u89:GetAttribute("TotalGrowTime");

    if type(v91) ~= "number" or type(v92) ~= "number" then
        return;
    end;

    local v93 = getStages(u89);

    if #v93 == 0 then
        return;
    end;

    local v94 = {};
    local v95 = 0;

    for _, v in v93 do
        for _, v2 in getParts(v.Instance) do
            v2.LocalTransparencyModifier = 1;
            v2.CanCollide = false;
        end;

        local v96 = captureStage(v.Instance);
        table.insert(v94, {
            StartTime = 0,
            EndTime = 0,
            Stage = v.Instance,
            Data = v96
        });
        v95 = v95 + v96.Height;
    end;

    for _, v in v94 do
        for _, v2 in v.Data.Parts do
            local Part = v2.Part;

            if Part.Parent then
                Part.LocalTransparencyModifier = 1;
                Part.CanCollide = false;
            end;
        end;
    end;

    local v97 = 0;

    for _, v in v94 do
        local v98 = v95 > 0 and v92 * (v.Data.Height / v95) or v92 / #v94;
        v.StartTime = v97;
        v.EndTime = v97 + v98;
        v97 = v.EndTime;
    end;

    u2[u89] = {
        LastUpdate = 0,
        LastDistanceUpdate = 0,
        UpdateRate = 2,
        Plant = u89,
        Stages = v94
    };
    u2[u89].DescendantConnection = u89.DescendantAdded:Connect(function(p99) -- Line: 413
        -- upvalues: u2 (ref), u89 (copy), trackLateDescendant (ref)
        local v100 = u2[u89];

        if v100 then
            trackLateDescendant(v100, p99);
        end;
    end);
    setPlantProgress(u2[u89]);
end;

local function startUpdateLoop() -- Line: 423
    -- upvalues: u5 (ref), RunService (copy), u2 (copy), getDistance (copy), setPlantProgress (copy)
    if u5 then
        return;
    end;

    u5 = RunService.Heartbeat:Connect(function() -- Line: 426
        -- upvalues: u2 (ref), getDistance (ref), setPlantProgress (ref)
        local v101 = os.clock();

        for i, v in u2 do
            if i.Parent then
                if v101 - v.LastDistanceUpdate >= 0.5 then
                    v.LastDistanceUpdate = v101;
                    v.UpdateRate = getDistance(i) <= 200 and 0.5 or 2;
                end;

                if v101 - v.LastUpdate >= v.UpdateRate then
                    v.LastUpdate = v101;
                    setPlantProgress(v);
                end;
            else
                if v.DescendantConnection then
                    v.DescendantConnection:Disconnect();
                end;

                u2[i] = nil;
            end;
        end;
    end);
end;

local function getStartTime(p102, p103, p104) -- Line: 453
    local v105 = workspace:GetServerTimeNow();

    if type(p104) == "number" then
        return v105 - math.clamp(p104, 0, p103);
    end;

    if type(p104) == "table" then
        if type(p104.StartTime) == "number" then
            return p104.StartTime;
        end;

        if type(p104.Elapsed) == "number" then
            return v105 - math.clamp(p104.Elapsed, 0, p103);
        end;
    end;

    local v106 = p102:GetAttribute("GrowthStartTime");

    if type(v106) == "number" then
        return v106;
    end;

    return v105;
end;

local function scheduleReady(u107, u108, u109) -- Line: 477
    -- upvalues: u55 (ref), scheduleReady (copy)
    local v110 = u107:GetAttribute("GrowthSpeedMulti");
    local v111 = u107:GetAttribute("PlayerGrowthSpeedMulti");
    local v112 = type(v110) == "number" and v110 and v110 or 0;
    local v113 = math.max(v112, 0) + 1;
    local v114 = type(v111) == "number" and v111 and v111 or 0;
    local v115 = v113 + math.max(v114, 0);
    local v116 = u108 - (u55(u107) or 0);
    local v117 = math.max(v116, 0) / v115;

    if v117 <= 0 then
        u107:SetAttribute("READY", true);

        return;
    end;

    task.delay(v117, function() -- Line: 487
        -- upvalues: u107 (copy), u109 (copy), u108 (copy), u55 (ref), scheduleReady (ref)
        if not u107.Parent then
            return;
        end;

        if u107:GetAttribute("GrowthTimerVersion") ~= u109 then
            return;
        end;

        if u107:GetAttribute("TotalGrowTime") ~= u108 then
            return;
        end;

        if u108 <= (u55(u107) or 0) then
            u107:SetAttribute("READY", true);

            return;
        end;

        scheduleReady(u107, u108, u109);
    end);
end;

function u1.Start(p118, u119, p120, p121) -- Line: 500
    -- upvalues: RunService (copy), getStartTime (copy), getStages (copy), getParts (copy), u7 (ref), u6 (copy), u55 (ref), scheduleReady (copy)
    local v122 = RunService:IsServer();
    assert(v122, "GrowPlants:Start must be called by the server");

    if not u119 or type(p120) ~= "number" then
        return;
    end;

    local u123 = math.max(p120, 0);
    local v124 = getStartTime(u119, u123, p121);
    local v125 = workspace:GetServerTimeNow() - v124;
    local v126 = math.clamp(v125, 0, u123);
    local v127 = (u119:GetAttribute("GrowthTimerVersion") or 0) + 1;
    u119:SetAttribute("GrowthStartTime", v124);
    u119:SetAttribute("TotalGrowTime", u123);
    u119:SetAttribute("GrowthElapsedOffset", v126);
    u119:SetAttribute("GrowthSpeedStartTime", workspace:GetServerTimeNow());
    u119:SetAttribute("GrowthTimerVersion", v127);
    u119:SetAttribute("READY", u123 <= v126);
    local v128 = 0;

    for _, v in getStages(u119) do
        v128 = v128 + #getParts(v.Instance);
    end;

    u119:SetAttribute("GrowthPartCount", v128);

    if p121 == nil then
        u7:FireAllClients(u119);
    end;

    if u6[u119] then
        for _, v in u6[u119] do
            v:Disconnect();
        end;
    end;

    local function refreshSpeed() -- Line: 527
        -- upvalues: u119 (copy), u55 (ref), u123 (ref), scheduleReady (ref)
        if not u119.Parent then
            return;
        end;

        if u119:GetAttribute("READY") then
            return;
        end;

        local v129 = u55(u119) or 0;
        local v130 = (u119:GetAttribute("GrowthTimerVersion") or 0) + 1;
        u119:SetAttribute("GrowthElapsedOffset", v129);
        u119:SetAttribute("GrowthSpeedStartTime", workspace:GetServerTimeNow());
        u119:SetAttribute("GrowthTimerVersion", v130);

        if u123 <= v129 then
            u119:SetAttribute("READY", true);

            return;
        end;

        scheduleReady(u119, u123, v130);
    end;

    u6[u119] = { u119:GetAttributeChangedSignal("GrowthSpeedMulti"):Connect(refreshSpeed), u119:GetAttributeChangedSignal("PlayerGrowthSpeedMulti"):Connect(refreshSpeed) };
    u119.Destroying:Once(function() -- Line: 548
        -- upvalues: u6 (ref), u119 (copy)
        if u6[u119] then
            for _, v in u6[u119] do
                v:Disconnect();
            end;

            u6[u119] = nil;
        end;
    end);

    if v126 < u123 then
        scheduleReady(u119, u123, v127);
    end;
end;

function u1.GetElapsed(p131, p132) -- Line: 562
    -- upvalues: u55 (ref)
    return u55(p132) or 0;
end;

function u1.GetProgress(p133, p134) -- Line: 566
    -- upvalues: u1 (copy)
    local v135 = p134:GetAttribute("TotalGrowTime");

    return (type(v135) ~= "number" or v135 <= 0) and 1 or u1:GetElapsed(p134) / v135;
end;

function u1.InitializeClient(p136) -- Line: 575
    -- upvalues: RunService (copy), u4 (ref), u2 (copy), u3 (copy), prehideDescendant (copy), getStages (copy), getParts (copy), trackPlant (copy), u5 (ref), getDistance (copy), setPlantProgress (copy), u7 (ref)
    local v137 = RunService:IsClient();
    assert(v137, "GrowPlants:InitializeClient must be called by a client");

    if u4 then
        return;
    end;

    u4 = true;
    local Plots = workspace:WaitForChild("Plots");

    local function tryAnimate(u138, p139) -- Line: 582
        -- upvalues: Plots (copy), tryAnimate (copy), u2 (ref), u3 (ref), prehideDescendant (ref), getStages (ref), getParts (ref), RunService (ref), trackPlant (ref)
        if not u138:IsA("Model") then
            return;
        end;

        if not u138:IsDescendantOf(Plots) then
            return;
        end;

        if not u138:GetAttribute("GrowthStartTime") then
            if p139 then
                u138:GetAttributeChangedSignal("GrowthStartTime"):Once(function() -- Line: 587
                    -- upvalues: tryAnimate (ref), u138 (copy)
                    tryAnimate(u138, true);
                end);
            end;

            return;
        end;

        if u2[u138] or u3[u138] then
            return;
        end;

        if not p139 then
            trackPlant(u138);

            return;
        end;

        u3[u138] = {
            Connection = u138.DescendantAdded:Connect(prehideDescendant)
        };

        for _, v in getStages(u138) do
            for _, v2 in getParts(v.Instance) do
                v2.LocalTransparencyModifier = 1;
                v2.CanCollide = false;
            end;
        end;

        task.defer(function() -- Line: 601
            -- upvalues: u138 (copy), u3 (ref), getStages (ref), getParts (ref), RunService (ref), trackPlant (ref)
            local v140 = os.clock();
            local v141 = u138:GetAttribute("GrowthPartCount") or 0;

            while u138.Parent and (u3[u138] and v141 > 0) do
                local v142 = 0;

                for _, v in getStages(u138) do
                    v142 = v142 + #getParts(v.Instance);
                end;

                if v142 >= v141 or os.clock() - v140 >= 2 then
                    break;
                end;

                for _, v in getStages(u138) do
                    for _, v2 in getParts(v.Instance) do
                        v2.LocalTransparencyModifier = 1;
                        v2.CanCollide = false;
                    end;
                end;

                RunService.Heartbeat:Wait();
            end;

            if u3[u138] then
                if not u138.Parent then
                    local v143 = u3[u138];

                    if v143.Connection then
                        v143.Connection:Disconnect();
                    end;

                    u3[u138] = nil;

                    return;
                end;

                trackPlant(u138);
            end;
        end);
    end;

    if not u5 then
        u5 = RunService.Heartbeat:Connect(function() -- Line: 426
            -- upvalues: u2 (ref), getDistance (ref), setPlantProgress (ref)
            local v144 = os.clock();

            for i, v in u2 do
                if i.Parent then
                    if v144 - v.LastDistanceUpdate >= 0.5 then
                        v.LastDistanceUpdate = v144;
                        v.UpdateRate = getDistance(i) <= 200 and 0.5 or 2;
                    end;

                    if v144 - v.LastUpdate >= v.UpdateRate then
                        v.LastUpdate = v144;
                        setPlantProgress(v);
                    end;
                else
                    if v.DescendantConnection then
                        v.DescendantConnection:Disconnect();
                    end;

                    u2[i] = nil;
                end;
            end;
        end);
    end;

    u7.OnClientEvent:Connect(function(p145) -- Line: 633
        -- upvalues: tryAnimate (copy)
        tryAnimate(p145, true);
    end);

    for _, descendant in Plots:GetDescendants() do
        if descendant:IsA("Model") then
            if descendant:IsDescendantOf(Plots) then
                if descendant:GetAttribute("GrowthStartTime") then
                    if not u2[descendant] then
                        if not u3[descendant] then
                            trackPlant(descendant);
                        end;
                    end;
                end;
            end;
        end;
    end;

    Plots.DescendantAdded:Connect(function(p146) -- Line: 640
        -- upvalues: tryAnimate (copy)
        tryAnimate(p146, true);
    end);
end;

return u1;