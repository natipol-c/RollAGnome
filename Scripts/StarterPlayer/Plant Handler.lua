--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Plant Handler
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Plant Handler
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:08 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
game:GetService("PathfindingService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Workspace = game:GetService("Workspace");
local Replication = require(ReplicatedStorage.Replication);
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Crops");
local u2 = Library.get("Find");
local u3 = Library.get("Mutations");
local u4 = Library.get("Network");
local u5 = Library.get("Numbers");
local u6 = Library.get("Signal");
local CollectionEffect = require(script.Parent.CollectionEffect);
local Assets = ReplicatedStorage.Assets;
local CropInfo = Assets.Billboards.CropInfo;
local LocalPlayer = Players.LocalPlayer;
local u7 = u2(LocalPlayer, "Plot");
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = {};
local u13 = {};
local u14 = {};
local u15 = {};
local u16 = {};
local u17 = {};
local u18 = nil;
local u19 = OverlapParams.new();
local u20 = nil;
local u21 = 1;
local u22 = 1;
local u23 = nil;
local u24 = RaycastParams.new();
local u25 = false;
u19.FilterType = Enum.RaycastFilterType.Include;
u19.FilterDescendantsInstances = u15;
u24.FilterType = Enum.RaycastFilterType.Include;
local v26 = {};

local function getCollectionRange() -- Line: 66
    -- upvalues: Replication (copy)
    return Replication.Data.collection_range or 10;
end;

local function isGardenHit(p27) -- Line: 70
    -- upvalues: u7 (copy)
    local Value = u7.Value;

    if Value then
        Value = Value:FindFirstChild("Ground");
    end;

    if p27 then
        p27 = p27.Instance;
    end;

    if Value then
        if p27 then
            p27 = p27 == Value and true or p27:IsDescendantOf(Value);
        end;
    else
        p27 = Value;
    end;

    return p27;
end;

local function setRingRange(p28) -- Line: 78
    -- upvalues: u20 (ref), u21 (ref), u22 (ref), u23 (ref)
    if not u20 then
        return;
    end;

    if u20:IsA("Model") then
        u20:ScaleTo(u21 * (p28 / u22));

        return;
    end;

    if u20:IsA("BasePart") and u23 then
        u20.Size = Vector3.new(p28, u23.Y, p28);
    end;
end;

local function setRingVisible(p29) -- Line: 88
    -- upvalues: u20 (ref)
    if not u20 then
        return;
    end;

    if u20:IsA("BasePart") then
        u20.Transparency = p29 and 0.9 or 1;

        return;
    end;

    for _, descendant in u20:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Transparency = p29 and 0.9 or 1;
        end;
    end;
end;

local function startCollectionRing() -- Line: 103
    -- upvalues: u9 (ref), Assets (copy), LocalPlayer (copy), u20 (ref), u21 (ref), u22 (ref), u23 (ref), Workspace (copy), Replication (copy), RunService (copy), u7 (copy), u24 (copy), setRingVisible (copy)
    if u9 then
        return;
    end;

    local Ring = Assets:FindFirstChild("Ring");

    if not Ring then
        return;
    end;

    LocalPlayer:SetAttribute("CanCollect", false);
    u20 = Ring:Clone();

    if u20:IsA("Model") then
        u21 = u20:GetScale();
        local _, v30 = u20:GetBoundingBox();
        u22 = math.max(v30.X, v30.Z, 0.01);
    else
        u23 = u20.Size;
    end;

    u20.Parent = Workspace;
    local v31 = Replication.Data.collection_range or 10;

    if u20 then
        if u20:IsA("Model") then
            u20:ScaleTo(u21 * (v31 / u22));
        elseif u20:IsA("BasePart") and u23 then
            u20.Size = Vector3.new(v31, u23.Y, v31);
        end;
    end;

    Replication:Connect("collection_range", function(p32) -- Line: 121
        -- upvalues: u20 (ref), u21 (ref), u22 (ref), u23 (ref)
        local v33 = p32 or 10;

        if not u20 then
            return;
        end;

        if u20:IsA("Model") then
            u20:ScaleTo(u21 * (v33 / u22));

            return;
        end;

        if u20:IsA("BasePart") and u23 then
            u20.Size = Vector3.new(v33, u23.Y, v33);
        end;
    end);
    u9 = RunService.RenderStepped:Connect(function() -- Line: 125
        -- upvalues: LocalPlayer (ref), u20 (ref), u7 (ref), u24 (ref), Workspace (ref), setRingVisible (ref)
        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        if not (Character and u20) then
            return;
        end;

        local Value = u7.Value;

        if Value then
            Value = Value:FindFirstChild("Ground");
        end;

        u24.FilterDescendantsInstances = Value and { Value } or {};
        local v34 = Workspace:Raycast(Character.Position, Vector3.new(0, -100, 0), u24);
        local Value2 = u7.Value;

        if Value2 then
            Value2 = Value2:FindFirstChild("Ground");
        end;

        local v35;

        if v34 then
            v35 = v34.Instance;
        else
            v35 = v34;
        end;

        if Value2 then
            if v35 then
                v35 = v35 == Value2 and true or v35:IsDescendantOf(Value2);
            end;
        else
            v35 = Value2;
        end;

        local v36 = v35 == true;
        LocalPlayer:SetAttribute("CanCollect", v36);
        setRingVisible(v36);
        local v37 = CFrame.new(v34 and v34.Position or Character.Position);

        if u20:IsA("Model") then
            u20:PivotTo(v37);

            return;
        end;

        if u20:IsA("BasePart") then
            u20.CFrame = v37;
        end;
    end);
end;

local function playCollectVisual(p38, p39, p40, p41) -- Line: 148
    -- upvalues: LocalPlayer (copy), u1 (copy), CollectionEffect (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    local v42 = u1.getModel(p38, p41);

    if not v42 then
        return;
    end;

    local v43 = type(p40) == "number" and p40 and p40 or 1;
    local v44 = typeof(p39) == "CFrame" and p39 and p39 or CFrame.new();
    v42:ScaleTo(v42:GetScale() * v43);
    v42:PivotTo(v44);
    CollectionEffect.Play(v42, Character, function() -- Line: 161
        _G.Play("Collect_" .. math.random(1, 4));
    end);
end;

local function refreshOverlapFilter() -- Line: 166
    -- upvalues: u19 (copy), u15 (copy)
    u19.FilterDescendantsInstances = u15;
end;

local function addBoundaryBox(p45) -- Line: 170
    -- upvalues: u15 (copy), u19 (copy)
    table.insert(u15, p45);
    u19.FilterDescendantsInstances = u15;
end;

local function removeBoundaryBox(p46) -- Line: 175
    -- upvalues: u15 (copy), u19 (copy)
    local v47 = table.find(u15, p46);

    if v47 then
        table.remove(u15, v47);
        u19.FilterDescendantsInstances = u15;
    end;
end;

local function getCenterPart(p48) -- Line: 183
    return p48:FindFirstChild("CenterPart", true);
end;

local function getAttachment(p49) -- Line: 187
    if p49 then
        p49 = p49:FindFirstChild("Attachment");
    end;

    return p49;
end;

local function getTimeText(p50) -- Line: 191
    -- upvalues: u5 (copy), Workspace (copy)
    local v51 = p50:GetAttribute("SecondsUntilReady");

    if type(v51) == "number" then
        local formatSemicolonTime = u5.formatSemicolonTime;
        local v52 = math.ceil(v51);

        return formatSemicolonTime((math.max(v52, 0)));
    end;

    local v53 = p50:GetAttribute("GrowthStartTime");
    local v54 = p50:GetAttribute("CropInfoTotalGrowTime") or p50:GetAttribute("TotalGrowTime");

    if type(v53) ~= "number" or type(v54) ~= "number" then
        return "";
    end;

    local v55 = p50:GetAttribute("GrowthSpeedMulti");
    local v56 = p50:GetAttribute("PlayerGrowthSpeedMulti");
    local v57 = type(v55) == "number" and v55 and v55 or 0;
    local v58 = math.max(v57, 0) + 1;
    local v59 = type(v56) == "number" and v56 and v56 or 0;
    local v60 = v58 + math.max(v59, 0);
    local v61 = p50:GetAttribute("GrowthElapsedOffset");
    local v62 = p50:GetAttribute("GrowthSpeedStartTime");
    local v63 = Workspace:GetServerTimeNow() - v53;

    if type(v61) == "number" and type(v62) == "number" then
        v63 = v61 + (Workspace:GetServerTimeNow() - v62) * v60;
    end;

    local v64 = math.ceil(v54 - v63);
    local v65 = math.max(v64, 0);

    return u5.formatSemicolonTime(v65);
end;

local function updateCropInfoStatic(p66, p67) -- Line: 221
    -- upvalues: u3 (copy)
    local PlantName = p66:FindFirstChild("PlantName");
    local Mutations = p66:FindFirstChild("Mutations");

    if PlantName and PlantName:IsA("TextLabel") then
        PlantName.Text = p67:GetAttribute("PlantName") or (p67:GetAttribute("FruitName") or p67.Name);
    end;

    if Mutations then
        u3:updateList(Mutations, (u3:toTable(p67:GetAttribute("Mutations"))));
    end;
end;

local function isFullyReady(p68) -- Line: 237
    local v69 = p68:GetAttribute("READY") and p68:GetAttribute("FruitReady") ~= false;

    return v69;
end;

local function readyToCollect(p70) -- Line: 241
    if p70 and p70.Parent then
    end;
end;

local function collectPlant(u71) -- Line: 247
    -- upvalues: u16 (copy), LocalPlayer (copy), u4 (copy)
    if u71 and not u16[u71] then
        local v72 = u71:GetAttribute("READY") and u71:GetAttribute("FruitReady") ~= false;

        if v72 then
            if LocalPlayer:GetAttribute("CanCollect") ~= true then
                return;
            end;

            u16[u71] = true;
            u4:InvokeServer("CollectPlant", u71);
            task.delay(0.5, function() -- Line: 255
                -- upvalues: u16 (ref), u71 (copy)
                u16[u71] = nil;
            end);
        end;
    end;
end;

local function clearWaterPrompts() -- Line: 260
    -- upvalues: u18 (ref), u17 (copy)
    if u18 then
        u18:Disconnect();
        u18 = nil;
    end;

    for i, v in u17 do
        if v.Connection then
            v.Connection:Disconnect();
        end;

        if v.Attachment then
            v.Attachment:Destroy();
        end;

        u17[i] = nil;
    end;
end;

local function addWaterPrompt(u73) -- Line: 277
    -- upvalues: u17 (copy), LocalPlayer (copy), u4 (copy), clearWaterPrompts (copy)
    if u17[u73] or not u73:IsA("Model") then
        return;
    end;

    local CenterPart = u73:FindFirstChild("CenterPart", true);

    if not CenterPart then
        return;
    end;

    local v74 = script.Attachment:Clone();
    local v75 = v74:FindFirstChildWhichIsA("ProximityPrompt", true);

    if not v75 then
        v74:Destroy();

        return;
    end;

    u17[u73] = {
        Attachment = v74,
        Connection = v75.Triggered:Connect(function(p76) -- Line: 292
            -- upvalues: LocalPlayer (ref), u4 (ref), u73 (copy), clearWaterPrompts (ref)
            if p76 and p76 ~= LocalPlayer then
                return;
            end;

            u4:FireServer("WaterPlant", u73);
            clearWaterPrompts();
        end)
    };
    v74.Parent = CenterPart;
end;

local function startWaterPrompts() -- Line: 303
    -- upvalues: clearWaterPrompts (copy), u7 (copy), u2 (copy), addWaterPrompt (copy), u18 (ref)
    clearWaterPrompts();
    local Value = u7.Value;

    if Value then
        Value = u2(Value, "Plants");
    end;

    if not Value then
        return;
    end;

    for _, child in Value:GetChildren() do
        addWaterPrompt(child);
    end;

    u18 = Value.ChildAdded:Connect(addWaterPrompt);
end;

local function clearReadyConnection(p77) -- Line: 317
    -- upvalues: u13 (copy)
    local v78 = u13[p77];

    if not v78 then
        return;
    end;

    for _, v in v78 do
        v:Disconnect();
    end;

    u13[p77] = nil;
end;

local function waitUntilReadyToCollect(u79) -- Line: 328
    -- upvalues: u13 (copy)
    if not u79 or u13[u79] then
        return;
    end;

    local v80 = u79:GetAttribute("READY") and u79:GetAttribute("FruitReady") ~= false;

    if v80 then
        return;
    end;

    local function check() -- Line: 332
        -- upvalues: u79 (copy), u13 (ref)
        local v81 = u79;
        local v82 = v81:GetAttribute("READY") and v81:GetAttribute("FruitReady") ~= false;

        if not v82 then
            return;
        end;

        local v83 = u79;
        local v84 = u13[v83];

        if v84 then
            for _, v in v84 do
                v:Disconnect();
            end;

            u13[v83] = nil;
        end;

        local v85 = u79;

        if v85 and not v85.Parent then
        end;
    end;

    u13[u79] = { u79:GetAttributeChangedSignal("READY"):Connect(check), u79:GetAttributeChangedSignal("FruitReady"):Connect(check), u79.Destroying:Connect(function() -- Line: 342
            -- upvalues: u79 (copy), u13 (ref)
            local v86 = u79;
            local v87 = u13[v86];

            if not v87 then
                return;
            end;

            for _, v in v87 do
                v:Disconnect();
            end;

            u13[v86] = nil;
        end) };
end;

local function updateCropInfoTime(p88, p89) -- Line: 348
    -- upvalues: getTimeText (copy), u5 (copy)
    local TimeRemaining = p88:FindFirstChild("TimeRemaining");
    local v90;

    if TimeRemaining then
        v90 = TimeRemaining:FindFirstChild("Time");
    else
        v90 = TimeRemaining;
    end;

    local v91;

    if TimeRemaining then
        v91 = TimeRemaining:FindFirstChild("TimeMulti");
    else
        v91 = TimeRemaining;
    end;

    if v90 then
        local v92 = p89:GetAttribute("READY") and p89:GetAttribute("FruitReady") ~= false;
        TimeRemaining.Visible = not v92;
        v90.Text = getTimeText(p89);
    end;

    if v91 then
        local v93 = p89:GetAttribute("GrowthSpeedMulti");
        local v94;

        if type(v93) == "number" then
            v94 = v93 > 0;
        else
            v94 = false;
        end;

        v91.Visible = v94;

        if v91.Visible then
            v91.Text = `(x{u5.Comma(1 + v93)})`;
        end;
    end;
end;

local function getPlantDistance(p95, p96) -- Line: 367
    local CenterPart = p95:FindFirstChild("CenterPart", true);
    local v97;

    if CenterPart then
        v97 = CenterPart:FindFirstChild("Attachment");
    else
        v97 = CenterPart;
    end;

    if not (CenterPart and v97) then
        return;
    end;

    local Magnitude = (CenterPart.Position - p96.Position).Magnitude;

    if Magnitude <= 10 then
        return Magnitude;
    end;
end;

local function startCropInfo(u98) -- Line: 378
    -- upvalues: u8 (ref), RunService (copy), u12 (copy), LocalPlayer (copy), CropInfo (copy), updateCropInfoStatic (copy), updateCropInfoTime (copy)
    if u8 then
        u8:Disconnect();
    end;

    local u99 = 0;
    u8 = RunService.RenderStepped:Connect(function() -- Line: 385
        -- upvalues: u99 (ref), u98 (copy), u12 (ref), u8 (ref), LocalPlayer (ref), CropInfo (ref), updateCropInfoStatic (ref), updateCropInfoTime (ref)
        if tick() - u99 < 0.1 then
            return;
        end;

        u99 = tick();

        if not u98.Parent then
            for i, v in u12 do
                v:Destroy();
                u12[i] = nil;
            end;

            u8:Disconnect();
            u8 = nil;

            return;
        end;

        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        if not Character then
            for i, v in u12 do
                v:Destroy();
                u12[i] = nil;
            end;

            return;
        end;

        local v100 = {};

        for _, child in u98:GetChildren() do
            if child:IsA("Model") then
                local CenterPart = child:FindFirstChild("CenterPart", true);
                local v101;

                if CenterPart then
                    v101 = CenterPart:FindFirstChild("Attachment");
                else
                    v101 = CenterPart;
                end;

                local v102;

                if CenterPart and v101 then
                    v102 = (CenterPart.Position - Character.Position).Magnitude;

                    if v102 > 10 then
                        v102 = nil;
                    end;
                else
                    v102 = nil;
                end;

                if v102 then
                    local CenterPart2 = child:FindFirstChild("CenterPart", true);

                    if CenterPart2 then
                        CenterPart2 = CenterPart2:FindFirstChild("Attachment");
                    end;

                    if CenterPart2 then
                        v100[child] = true;
                        local v103 = u12[child];

                        if not v103 then
                            v103 = CropInfo:Clone();
                            u12[child] = v103;
                            updateCropInfoStatic(v103, child);
                        end;

                        v103.Parent = CenterPart2;
                        updateCropInfoTime(v103, child);
                    end;
                end;
            end;
        end;

        for i, v in u12 do
            if not v100[i] then
                v:Destroy();
                u12[i] = nil;
            end;
        end;
    end);
end;

local function addCollectHitbox(u104, u105) -- Line: 437
    -- upvalues: u15 (copy), u19 (copy), u14 (copy)
    if u104:IsA("Model") then
        local u106 = nil;
        local u107 = {};
        local u108 = {};
        local u109 = false;
        local u110 = false;

        local function cleanup() -- Line: 446
            -- upvalues: u109 (ref), u108 (copy), u106 (ref), u15 (ref), u19 (ref), u107 (copy)
            if u109 then
                return;
            end;

            u109 = true;

            for _, v in u108 do
                v:Disconnect();
            end;

            table.clear(u108);

            if u106 then
                local v111 = table.find(u15, u106);

                if v111 then
                    table.remove(u15, v111);
                    u19.FilterDescendantsInstances = u15;
                end;

                u106:Destroy();
                u106 = nil;
            end;

            for _, v in u107 do
                v:Destroy();
            end;

            table.clear(u107);
        end;

        local function create() -- Line: 467
            -- upvalues: u109 (ref), u104 (copy), u105 (copy), u110 (ref), u107 (copy), u106 (ref), u15 (ref), u19 (ref)
            if not u109 then
                local v112 = u104;
                local v113 = v112:GetAttribute("READY") and v112:GetAttribute("FruitReady") ~= false;

                if v113 then
                    if u105 and u104.Parent ~= u105 then
                        u104.Parent = u105;
                    end;

                    if not u110 then
                        u110 = true;
                        local v114 = {};

                        for _, descendant in u104:GetDescendants() do
                            if descendant:GetAttribute("FruitName") and (descendant:IsA("Model") or descendant:IsA("BasePart")) then
                                table.insert(v114, descendant);
                            end;
                        end;

                        if #v114 == 0 then
                            table.insert(v114, u104);
                        end;

                        for _, v in v114 do
                            local v115, v116;

                            if v:IsA("Model") then
                                v115, v116 = v:GetBoundingBox();
                            else
                                v115 = v.CFrame;
                                v116 = v.Size;
                            end;

                            local Part = Instance.new("Part");
                            Part.Name = "ReadyBoundingBox";
                            Part.Anchored = true;
                            Part.CanCollide = false;
                            Part.CanTouch = false;
                            Part.CanQuery = false;
                            Part.Transparency = 1;
                            Part.Size = v116;
                            Part.CFrame = v115;
                            Part.Parent = u104;
                            table.insert(u107, Part);
                        end;
                    end;

                    if u106 then
                        return;
                    end;

                    local v117 = u104:GetAttribute("PlantRadius") or 0;

                    if v117 <= 0 then
                        return;
                    end;

                    u106 = Instance.new("Part");
                    u106.Name = "CollectHitbox";
                    u106.Anchored = true;
                    u106.CanCollide = false;
                    u106.CanTouch = false;
                    u106.CanQuery = true;
                    u106.Transparency = 1;
                    u106.Size = Vector3.new(v117 * 2, 5, v117 * 2);
                    u106.CFrame = u104:GetPivot();
                    u106.Parent = u104;
                    table.insert(u15, u106);
                    u19.FilterDescendantsInstances = u15;
                end;
            end;
        end;

        local v118 = u104:GetAttributeChangedSignal("READY");
        table.insert(u108, v118:Connect(create));
        local v119 = u104:GetAttributeChangedSignal("FruitReady");
        table.insert(u108, v119:Connect(create));
        table.insert(u108, u104.Destroying:Connect(function() -- Line: 531
            -- upvalues: cleanup (copy), u14 (ref), u104 (copy)
            cleanup();
            u14[u104] = nil;
        end));
        create();

        return cleanup;
    end;
end;

local function startCollectOverlapLoop() -- Line: 540
    -- upvalues: u10 (ref), RunService (copy), u15 (copy), LocalPlayer (copy), Replication (copy), Workspace (copy), u19 (copy), u16 (copy), collectPlant (copy)
    if u10 then
        return;
    end;

    local u120 = 0;
    u10 = RunService.RenderStepped:Connect(function() -- Line: 545
        -- upvalues: u120 (ref), u15 (ref), LocalPlayer (ref), Replication (ref), Workspace (ref), u19 (ref), u16 (ref), collectPlant (ref)
        if tick() - u120 < 0.25 then
            return;
        end;

        u120 = tick();

        if #u15 == 0 then
            return;
        end;

        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        if not Character then
            return;
        end;

        local v121 = 0;

        for _, v in Workspace:GetPartBoundsInRadius(Character.Position, (Replication.Data.collection_range or 10) / 2, u19) do
            local Parent = v.Parent;

            if Parent and not u16[Parent] then
                collectPlant(Parent);
                v121 = v121 + 1;

                if v121 >= 3 then
                    break;
                end;
            end;
        end;
    end);
end;

local function gotPlot(p122) -- Line: 570
    -- upvalues: u11 (ref), u12 (copy), u13 (copy), u14 (copy), clearWaterPrompts (copy), u15 (copy), u19 (copy), u2 (copy), waitUntilReadyToCollect (copy), addCollectHitbox (copy), u8 (ref), RunService (copy), LocalPlayer (copy), CropInfo (copy), updateCropInfoStatic (copy), updateCropInfoTime (copy)
    if u11 then
        u11:Disconnect();
        u11 = nil;
    end;

    for i, v in u12 do
        v:Destroy();
        u12[i] = nil;
    end;

    for i in u13 do
        local v123 = u13[i];

        if v123 then
            for _, v in v123 do
                v:Disconnect();
            end;

            u13[i] = nil;
        end;
    end;

    for i, v in u14 do
        v();
        u14[i] = nil;
    end;

    clearWaterPrompts();

    for _, v in u15 do
        v:Destroy();
    end;

    table.clear(u15);
    u19.FilterDescendantsInstances = u15;
    local u124 = u2(p122, "Plants");
    local u125 = u2(p122, "ReadyToCollect");

    for _, child in u124:GetChildren() do
        if child:IsA("Model") then
            waitUntilReadyToCollect(child);
            u14[child] = addCollectHitbox(child, u125);
        end;
    end;

    u11 = u124.ChildAdded:Connect(function(p126) -- Line: 602
        -- upvalues: waitUntilReadyToCollect (ref), u14 (ref), addCollectHitbox (ref), u125 (copy)
        if p126:IsA("Model") then
            waitUntilReadyToCollect(p126);
            u14[p126] = addCollectHitbox(p126, u125);
        end;
    end);

    if u8 then
        u8:Disconnect();
    end;

    local u127 = 0;
    u8 = RunService.RenderStepped:Connect(function() -- Line: 385
        -- upvalues: u127 (ref), u124 (copy), u12 (ref), u8 (ref), LocalPlayer (ref), CropInfo (ref), updateCropInfoStatic (ref), updateCropInfoTime (ref)
        if tick() - u127 < 0.1 then
            return;
        end;

        u127 = tick();

        if not u124.Parent then
            for i, v in u12 do
                v:Destroy();
                u12[i] = nil;
            end;

            u8:Disconnect();
            u8 = nil;

            return;
        end;

        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        if not Character then
            for i, v in u12 do
                v:Destroy();
                u12[i] = nil;
            end;

            return;
        end;

        local v128 = {};

        for _, child in u124:GetChildren() do
            if child:IsA("Model") then
                local CenterPart = child:FindFirstChild("CenterPart", true);
                local v129;

                if CenterPart then
                    v129 = CenterPart:FindFirstChild("Attachment");
                else
                    v129 = CenterPart;
                end;

                local v130;

                if CenterPart and v129 then
                    v130 = (CenterPart.Position - Character.Position).Magnitude;

                    if v130 > 10 then
                        v130 = nil;
                    end;
                else
                    v130 = nil;
                end;

                if v130 then
                    local CenterPart2 = child:FindFirstChild("CenterPart", true);

                    if CenterPart2 then
                        CenterPart2 = CenterPart2:FindFirstChild("Attachment");
                    end;

                    if CenterPart2 then
                        v128[child] = true;
                        local v131 = u12[child];

                        if not v131 then
                            v131 = CropInfo:Clone();
                            u12[child] = v131;
                            updateCropInfoStatic(v131, child);
                        end;

                        v131.Parent = CenterPart2;
                        updateCropInfoTime(v131, child);
                    end;
                end;
            end;
        end;

        for i, v in u12 do
            if not v128[i] then
                v:Destroy();
                u12[i] = nil;
            end;
        end;
    end);
end;

function v26.Initialize(p132) -- Line: 611
    -- upvalues: u25 (ref), u10 (ref), RunService (copy), u15 (copy), LocalPlayer (copy), Replication (copy), Workspace (copy), u19 (copy), u16 (copy), collectPlant (copy), startCollectionRing (copy), u4 (copy), playCollectVisual (copy), u7 (copy), gotPlot (copy), u6 (copy), startWaterPrompts (copy), clearWaterPrompts (copy)
    if u25 then
        return;
    end;

    u25 = true;

    if not u10 then
        local u133 = 0;
        u10 = RunService.RenderStepped:Connect(function() -- Line: 545
            -- upvalues: u133 (ref), u15 (ref), LocalPlayer (ref), Replication (ref), Workspace (ref), u19 (ref), u16 (ref), collectPlant (ref)
            if tick() - u133 < 0.25 then
                return;
            end;

            u133 = tick();

            if #u15 == 0 then
                return;
            end;

            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChild("HumanoidRootPart");
            end;

            if not Character then
                return;
            end;

            local v134 = 0;

            for _, v in Workspace:GetPartBoundsInRadius(Character.Position, (Replication.Data.collection_range or 10) / 2, u19) do
                local Parent = v.Parent;

                if Parent and not u16[Parent] then
                    collectPlant(Parent);
                    v134 = v134 + 1;

                    if v134 >= 3 then
                        break;
                    end;
                end;
            end;
        end);
    end;

    startCollectionRing();
    u4:BindEvents({
        WaterPlantSound = function(p135, p136) -- Line: 619, Name: WaterPlantSound
            if p135 then
                p135 = p135:FindFirstChild("CenterPart", true);
            end;

            if p135 then
                _G.Play(p136, p135);
            end;
        end,

        CollectPlantVisual = function(u137, p138, p139, p140) -- Line: 626, Name: CollectPlantVisual
            -- upvalues: playCollectVisual (ref)
            if type(u137) == "table" then
                task.spawn(function() -- Line: 628
                    -- upvalues: u137 (copy), playCollectVisual (ref)
                    for i, v in u137 do
                        task.spawn(playCollectVisual, v.name, v.pivot, v.scale, v.mutations);

                        if i % 4 == 0 then
                            task.wait();
                        else
                            task.wait(0.03);
                        end;
                    end;
                end);

                return;
            end;

            playCollectVisual(u137, p138, p139, p140);
        end
    });

    if u7.Value then
        gotPlot(u7.Value);
    else
        u7.Changed:Once(function() -- Line: 648
            -- upvalues: gotPlot (ref), u7 (ref)
            gotPlot(u7.Value);
        end);
    end;

    u6.new("WaterPlant"):Connect(function(p141) -- Line: 653
        -- upvalues: startWaterPrompts (ref), clearWaterPrompts (ref)
        if p141 then
            startWaterPrompts();

            return;
        end;

        clearWaterPrompts();
    end);
end;

return v26;