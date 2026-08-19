--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Pets Handler
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Pets Handler
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:29 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local Library = require(ReplicatedStorage.Library);
local v1 = Library.get("Find");
local v2 = Library.get("Mouse");
local u3 = Library.get("Network");
local u4 = Library.get("Numbers");
local u5 = Library.get("Rarities");
local u6 = Library.get("Signal");
local u7 = Library.get("Mutations");
local PetsUtil = require(ReplicatedStorage.Library.Configs.PetsUtil);
local Animations = require(script.Animations);
local Pets = require(ReplicatedStorage.Library.Configs.Pets);
local LocalPlayer = Players.LocalPlayer;
local v8 = v1(LocalPlayer, "PlayerGui");
local v9 = v8:FindFirstChild("Billboards") or v1(v8, "BillboardGuis");
local PetInfo = ReplicatedStorage.Assets.Billboards.PetInfo;
local u10 = v2.new();
local v11 = {};
local u12 = nil;
local u13 = {};
local u14 = {};
local u15 = {};
local u16 = nil;
local u17 = nil;
local u18 = nil;
local Highlight = script.Highlight;
local Part = Instance.new("Part");
local u19 = RaycastParams.new();
u19.FilterType = Enum.RaycastFilterType.Include;
Part.Name = "PetInfoPart";
Part.Anchored = true;
Part.CanCollide = false;
Part.CanTouch = false;
Part.CanQuery = false;
Part.Transparency = 1;
Part.Size = Vector3.new(1, 1, 1);
PetInfo.Parent = v9;
Highlight.Enabled = false;
Highlight.Parent = nil;

local function isPetTool(p20) -- Line: 53
    local v21;

    if p20 == nil then
        v21 = false;
    else
        v21 = p20:IsA("Tool");

        if v21 then
            if p20:GetAttribute("type") == "Pet" then
                v21 = type(p20:GetAttribute("PetName")) == "string";
            else
                v21 = false;
            end;
        end;
    end;

    return v21;
end;

local function getBoundary() -- Line: 57
    -- upvalues: LocalPlayer (copy)
    local Plot = LocalPlayer:FindFirstChild("Plot");

    if Plot then
        Plot = Plot.Value;
    end;

    if Plot then
        Plot = Plot:FindFirstChild("PLOTBOUNDARY", true);
    end;

    return Plot;
end;

local function getPlacePivot() -- Line: 63
    -- upvalues: LocalPlayer (copy), u19 (copy)
    local v22 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
    local Plot = LocalPlayer:FindFirstChild("Plot");

    if Plot then
        Plot = Plot.Value;
    end;

    if Plot then
        Plot = Plot:FindFirstChild("PLOTBOUNDARY", true);
    end;

    if not (v22 and Plot) then
        return nil;
    end;

    local v23 = Vector3.new(v22.CFrame.LookVector.X, 0, v22.CFrame.LookVector.Z);

    if v23.Magnitude <= 0 then
        return nil;
    end;

    local Unit = v23.Unit;
    u19.FilterDescendantsInstances = { Plot };
    local v24 = workspace:Raycast(v22.Position + Unit * 2 + Vector3.new(0, 4, 0), Vector3.new(-0, -12, -0), u19);

    return v24 and CFrame.lookAt(v24.Position, v24.Position - Unit) or nil;
end;

local function prepModel(p25) -- Line: 78
    local v26 = p25:FindFirstChild("RootPart") or (p25.PrimaryPart or p25:FindFirstChildWhichIsA("BasePart", true));
    p25.PrimaryPart = p25.PrimaryPart or v26;
    local v27 = p25:FindFirstChildWhichIsA("Humanoid");

    if v27 then
        v27.AutoRotate = true;
        v27.WalkSpeed = 8;
    end;

    for _, descendant in p25:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.Massless = true;
        end;
    end;
end;

local function changeAnimation(p28, p29, p30) -- Line: 96
    if not p28 then
        return;
    end;

    p28:ChangeAnimation(p29 == "Walk" and not p28.tracks.Walk and "Idle" or p29, p30);
end;

local function getPetSpeed(p31) -- Line: 104
    local v32;

    if p31 then
        v32 = p31.config;
    else
        v32 = p31;
    end;

    local v33 = p31 and (p31.speed or p31.Speed);

    if v33 then
        v32 = v33;
    elseif v32 then
        v32 = v32.speed or v32.Speed;
    end;

    return (type(v32) ~= "number" or v32 <= 0) and 8 or v32;
end;

local function flatLook(p34, p35, p36) -- Line: 110
    local v37 = Vector3.new(p35.X - p34.X, 0, p35.Z - p34.Z);

    return v37.Magnitude > 0.001 and CFrame.lookAt(p35, p35 + v37.Unit) or CFrame.new(p35) * p36.Rotation;
end;

local function getRarityText(p38, p39) -- Line: 115
    -- upvalues: u4 (copy)
    return p39 and `1/{u4.Comma(p39)}` or p38.rng;
end;

local function addOverhead(p40, p41, p42, p43, p44) -- Line: 119
    -- upvalues: ReplicatedStorage (copy), PetsUtil (copy), u4 (copy), u5 (copy), u7 (copy)
    local PetOverhead = ReplicatedStorage.Assets.Billboards:FindFirstChild("PetOverhead");

    if not (PetOverhead and p40.PrimaryPart) then
        return;
    end;

    local v45 = PetOverhead:Clone();
    v45.Name = "Overhead";
    local PetName = v45:FindFirstChild("PetName");
    local Label = v45:FindFirstChild("Label");
    local Price = v45:FindFirstChild("Price");
    local Timer = v45:FindFirstChild("Timer");

    if Price then
        Price:Destroy();
    end;

    if Timer then
        Timer:Destroy();
    end;

    if PetName and PetName:IsA("TextLabel") then
        PetName.Text = PetsUtil.getDisplayName(p41.name, p42, p43);
    end;

    if Label and Label:IsA("TextLabel") then
        Label.Text = `[ {p44 and `1/{u4.Comma(p44)}` or p41.rng} ]`;
        u5:SetColor(p41.rarity, Label);
    end;

    u7:updateList(v45:FindFirstChild("Mutations"), p42);
    v45.Adornee = p40.PrimaryPart;
    v45.Parent = p40;
end;

local function setPetOverhead(p46, p47) -- Line: 143
    if p46 then
        p46 = p46:FindFirstChild("Overhead");
    end;

    if p46 and p46:IsA("BillboardGui") then
        p46.Enabled = p47;
    end;
end;

local function clearPickupPrompt() -- Line: 150
    -- upvalues: u18 (ref), u17 (ref)
    if u18 then
        u18:Disconnect();
        u18 = nil;
    end;

    if u17 then
        u17:Destroy();
        u17 = nil;
    end;
end;

local function addPickupPrompt(u48) -- Line: 161
    -- upvalues: u18 (ref), u17 (ref), u3 (copy)
    if u18 then
        u18:Disconnect();
        u18 = nil;
    end;

    if u17 then
        u17:Destroy();
        u17 = nil;
    end;

    if not u48.PrimaryPart then
        return;
    end;

    if u48:GetAttribute("SamePlayer") ~= true then
        return;
    end;

    local u49 = script.ProximityPrompt:Clone();
    u49.ActionText = "Pick Up";
    u49.MaxActivationDistance = 35;
    u49.GamepadKeyCode = Enum.KeyCode.ButtonB;
    u49.KeyboardKeyCode = Enum.KeyCode.F;
    u49.Parent = u48.PrimaryPart;
    u17 = u49;
    u18 = u49.Triggered:Connect(function() -- Line: 173
        -- upvalues: u49 (copy), u3 (ref), u48 (copy)
        u49.Enabled = false;
        u3:FireServer("PickupPet", u48.Name);
    end);
end;

local function setText(p50, p51, p52) -- Line: 179
    if p50 then
        p50 = p50:FindFirstChild(p51);
    end;

    if p50 and p50:IsA("TextLabel") then
        p50.Text = p52;
    end;

    return p50;
end;

local function updatePetInfo(p53) -- Line: 185
    -- upvalues: Pets (copy), PetInfo (copy), PetsUtil (copy), u5 (copy)
    local v54 = Pets[p53:GetAttribute("PetName")];
    local Frame = PetInfo:FindFirstChild("Frame");

    if not (v54 and Frame) then
        return;
    end;

    local v55 = PetsUtil.getDisplayName(v54.name, p53:GetAttribute("Mutations"), p53:GetAttribute("Huge"));
    local v56;

    if Frame then
        v56 = Frame:FindFirstChild("PetName");
    else
        v56 = Frame;
    end;

    if v56 and v56:IsA("TextLabel") then
        v56.Text = v55;
    end;

    local v57 = v54.desc or "";
    local v58;

    if Frame then
        v58 = Frame:FindFirstChild("Description");
    else
        v58 = Frame;
    end;

    if v58 and v58:IsA("TextLabel") then
        v58.Text = v57;
    end;

    local rarity = v54.rarity;

    if Frame then
        Frame = Frame:FindFirstChild("Rarity");
    end;

    if Frame and Frame:IsA("TextLabel") then
        Frame.Text = rarity;
    end;

    if Frame and Frame:IsA("TextLabel") then
        u5:SetColor(v54.rarity, Frame);
    end;
end;

local function deselectPet() -- Line: 199
    -- upvalues: u16 (ref), u18 (ref), u17 (ref), Highlight (copy), PetInfo (copy), Part (copy)
    if not u16 then
        return;
    end;

    if u18 then
        u18:Disconnect();
        u18 = nil;
    end;

    if u17 then
        u17:Destroy();
        u17 = nil;
    end;

    local v59 = u16;

    if v59 then
        v59 = v59:FindFirstChild("Overhead");
    end;

    if v59 and v59:IsA("BillboardGui") then
        v59.Enabled = true;
    end;

    Highlight.Enabled = false;
    Highlight.Adornee = nil;
    Highlight.Parent = nil;
    PetInfo.Enabled = false;
    PetInfo.Adornee = nil;
    Part.Parent = nil;
    u16 = nil;
end;

local function displayPet(p60) -- Line: 212
    -- upvalues: u16 (ref), u18 (ref), u17 (ref), updatePetInfo (copy), PetInfo (copy), Part (copy), Highlight (copy), addPickupPrompt (copy)
    local v61 = p60.PrimaryPart or (p60:FindFirstChild("HumanoidRootPart") or p60:FindFirstChild("RootPart"));

    if not v61 then
        return;
    end;

    if u16 and u16 ~= p60 then
        if u18 then
            u18:Disconnect();
            u18 = nil;
        end;

        if u17 then
            u17:Destroy();
            u17 = nil;
        end;

        local v62 = u16;

        if v62 then
            v62 = v62:FindFirstChild("Overhead");
        end;

        if v62 and v62:IsA("BillboardGui") then
            v62.Enabled = true;
        end;
    end;

    u16 = p60;
    local v63;

    if p60 then
        v63 = p60:FindFirstChild("Overhead");
    else
        v63 = p60;
    end;

    if v63 and v63:IsA("BillboardGui") then
        v63.Enabled = false;
    end;

    updatePetInfo(p60);
    PetInfo.Enabled = true;
    Part.CFrame = v61.CFrame;
    Part.Parent = workspace;
    PetInfo.Adornee = Part;
    Highlight.Enabled = true;
    Highlight.Adornee = p60;
    Highlight.Parent = p60;
    addPickupPrompt(p60);
end;

local function getPetFromHit(p64) -- Line: 234
    -- upvalues: u13 (copy)
    if not p64 or p64.Name ~= "Hitbox" then
        return nil;
    end;

    local Parent = p64.Parent;

    if Parent and (Parent:IsA("Model") and u13[Parent.Parent]) then
        return Parent;
    end;

    return nil;
end;

local function updateMouseFilter() -- Line: 240
    -- upvalues: u13 (copy), u10 (copy)
    local v65 = {};

    for i in u13 do
        table.insert(v65, i);
    end;

    u10:SetTargetFilter(v65);
    u10:SetFilterType(Enum.RaycastFilterType.Include);
end;

local function createHitbox(p66) -- Line: 250
    local v67 = p66.PrimaryPart or (p66:FindFirstChild("HumanoidRootPart") or p66:FindFirstChild("RootPart"));

    if not (v67 and v67:IsA("BasePart")) then
        return;
    end;

    local v68, v69 = p66:GetBoundingBox();
    local Part2 = Instance.new("Part");
    Part2.Name = "Hitbox";
    Part2.Size = v69;
    Part2.Transparency = 1;
    Part2.CanCollide = false;
    Part2.CanTouch = false;
    Part2.CanQuery = true;
    Part2.Massless = true;
    Part2.CFrame = v68;
    Part2.Parent = p66;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = Part2;
    WeldConstraint.Part1 = v67;
    WeldConstraint.Parent = Part2;
end;

local function renderPet(u70, u71) -- Line: 272
    -- upvalues: renderPet (copy), Pets (copy), PetsUtil (copy), prepModel (copy), addOverhead (copy), LocalPlayer (copy), createHitbox (copy), Animations (copy), RunService (copy), TweenService (copy), flatLook (copy), u16 (ref), u18 (ref), u17 (ref), Highlight (copy), PetInfo (copy), Part (copy)
    if not u70:IsA("Model") then
        return;
    end;

    local v72 = u70:GetAttribute("PetName");

    if type(v72) ~= "string" then
        u70:GetAttributeChangedSignal("PetName"):Once(function() -- Line: 277
            -- upvalues: renderPet (ref), u70 (copy), u71 (copy)
            renderPet(u70, u71);
        end);

        return;
    end;

    local u73 = Pets[v72];

    if not u71.Parent or u71:FindFirstChild(u70.Name) then
        return;
    end;

    if not u73 then
        return warn("Missing pet config", v72);
    end;

    if not u73.model then
        return warn("Missing pet model", v72);
    end;

    local v74 = u70:GetAttribute("Mutations") or "";
    local v75 = u70:GetAttribute("Huge") == true;
    local v76 = u70:GetAttribute("RolledRarity");

    if type(v76) ~= "number" then
        v76 = nil;
    end;

    local u77 = PetsUtil.getModel(v72, v74, v75) or u73.model:Clone();
    u77.Name = u70.Name;
    prepModel(u77);
    addOverhead(u77, u73, v74, v75, v76);
    u77:PivotTo(u70:GetPivot());
    u77:SetAttribute("PetName", v72);
    u77:SetAttribute("Mutations", v74);
    u77:SetAttribute("Huge", v75);
    u77:SetAttribute("RolledRarity", v76);
    u77:SetAttribute("OwnerUserId", u70:GetAttribute("OwnerUserId"));
    u77:SetAttribute("SamePlayer", u70:GetAttribute("OwnerUserId") == LocalPlayer.UserId);
    createHitbox(u77);
    u77.Parent = u71;
    local u78 = Animations.new(v72, u77);
    local v79 = "Idle";
    local v80 = math.random(70, 120) / 100;

    if u78 then
        u78:ChangeAnimation(v79 == "Walk" and not u78.tracks.Walk and "Idle" or v79, v80);
    end;

    local u81 = 0;
    local u82 = false;
    local u83 = nil;
    local u88 = u70:GetAttributeChangedSignal("ActionSpin"):Connect(function() -- Line: 312
        -- upvalues: u82 (ref), u81 (ref), u83 (ref), u77 (copy), RunService (ref)
        if u82 then
            return;
        end;

        u82 = true;
        u81 = u81 + 1;
        u83 = nil;
        local v84 = u77:FindFirstChildWhichIsA("Humanoid");

        if v84 and u77.PrimaryPart then
            v84:MoveTo(u77.PrimaryPart.Position);
        end;

        task.spawn(function() -- Line: 323
            -- upvalues: u77 (ref), RunService (ref), u82 (ref)
            local v85 = u77:GetPivot();
            local v86 = os.clock();

            while u77.Parent and os.clock() - v86 < 0.35 do
                local v87 = (os.clock() - v86) / 0.35;
                u77:PivotTo(v85 * CFrame.Angles(0, 6.283185307179586 * v87, 0));
                RunService.RenderStepped:Wait();
            end;

            if u77.Parent then
                u77:PivotTo(v85);
            end;

            u82 = false;
        end);
    end);

    local function move() -- Line: 339
        -- upvalues: u77 (copy), u70 (copy), u81 (ref), u83 (ref), u78 (copy), u73 (copy), TweenService (ref), flatLook (ref)
        local u89 = u77:FindFirstChildWhichIsA("Humanoid");
        local PrimaryPart = u77.PrimaryPart;
        local Position = u70:GetPivot().Position;
        local u90 = u70:GetAttribute("MoveDuration");
        local u91 = u70:GetAttribute("MoveSpeed");

        if not PrimaryPart then
            return;
        end;

        u81 = u81 + 1;
        u83 = Position;
        local u92 = u81;
        task.spawn(function() -- Line: 351
            -- upvalues: Position (copy), PrimaryPart (copy), u78 (ref), u90 (copy), u73 (ref), u91 (copy), u89 (copy), u92 (copy), u81 (ref), u77 (ref), TweenService (ref), flatLook (ref), u83 (ref)
            local Magnitude = (Position - PrimaryPart.Position).Magnitude;

            if Magnitude <= 0.75 then
                local v93 = u78;
                local v94 = "Idle";
                local v95 = math.random(70, 120) / 100;

                if not v93 then
                    return;
                end;

                v93:ChangeAnimation(v94 == "Walk" and not v93.tracks.Walk and "Idle" or v94, v95);

                return;
            end;

            local v96;

            if type(u90) == "number" and u90 > 0 then
                v96 = u90;
            else
                local v97 = u73;
                local v98;

                if v97 then
                    v98 = v97.config;
                else
                    v98 = v97;
                end;

                local v99 = v97 and (v97.speed or v97.Speed);

                if v99 then
                    v98 = v99;
                elseif v98 then
                    v98 = v98.speed or v98.Speed;
                end;

                v96 = Magnitude / ((type(v98) ~= "number" or v98 <= 0) and 8 or v98);
            end;

            local v100 = u78;
            local v101 = "Walk";
            local v102 = type(u91) ~= "number" and 1 or u91;

            if v100 then
                v100:ChangeAnimation(v101 == "Walk" and not v100.tracks.Walk and "Idle" or v101, v102);
            end;

            if u89 then
                local v103 = Magnitude / math.max(v96, 0.05);
                u89.WalkSpeed = math.max(v103, 1);
                u89:MoveTo(Position);
                local v104 = os.clock();

                while u92 == u81 and (not u77:GetAttribute("ActionLocked") and (u77.Parent and (PrimaryPart.Parent and ((PrimaryPart.Position - Position).Magnitude > 0.75 and os.clock() - v104 < v96 + 1)))) do
                    task.wait(0.05);
                end;

                if u77:GetAttribute("ActionLocked") and PrimaryPart.Parent then
                    u89:MoveTo(PrimaryPart.Position);
                end;
            else
                local function tweenTo(p105, p106) -- Line: 373
                    -- upvalues: u77 (ref), u92 (ref), u81 (ref), TweenService (ref)
                    local CFrameValue = Instance.new("CFrameValue");
                    CFrameValue.Value = u77:GetPivot();
                    local v108 = CFrameValue.Changed:Connect(function(p107) -- Line: 376
                        -- upvalues: u92 (ref), u81 (ref), u77 (ref)
                        if u92 == u81 and (not u77:GetAttribute("ActionLocked") and u77.Parent) then
                            u77:PivotTo(p107);
                        end;
                    end);
                    local v109 = TweenService:Create(CFrameValue, TweenInfo.new(math.max(p106, 0.05), Enum.EasingStyle.Linear), {
                        Value = p105
                    });
                    v109:Play();
                    v109.Completed:Wait();
                    v108:Disconnect();
                    CFrameValue:Destroy();
                end;

                local v110 = u77:GetPivot();
                local v111 = flatLook(v110.Position, Position, v110);
                tweenTo(CFrame.new(v110.Position) * v111.Rotation, 0.15);

                if u92 == u81 and not u77:GetAttribute("ActionLocked") then
                    tweenTo(v111, v96);
                end;
            end;

            if u92 == u81 and u83 == Position then
                local v112 = u78;
                local v113 = "Idle";
                local v114 = math.random(70, 120) / 100;

                if not v112 then
                    return;
                end;

                v112:ChangeAnimation(v113 == "Walk" and not v112.tracks.Walk and "Idle" or v113, v114);
            end;
        end);
    end;

    local u115 = RunService.Heartbeat:Connect(function() -- Line: 401
        -- upvalues: u82 (ref), u77 (copy), u83 (ref), u70 (copy), move (copy)
        if u82 then
            return;
        end;

        if u77:GetAttribute("ActionLocked") then
            return;
        end;

        if u83 ~= u70:GetPivot().Position and (u70:GetPivot().Position - u77:GetPivot().Position).Magnitude > 0.75 then
            move();
        end;
    end);
    local u116 = false;

    local function cleanup() -- Line: 410
        -- upvalues: u116 (ref), u81 (ref), u115 (copy), u88 (copy), u78 (copy), u16 (ref), u77 (copy), u18 (ref), u17 (ref), Highlight (ref), PetInfo (ref), Part (ref)
        if u116 then
            return;
        end;

        u116 = true;
        u81 = u81 + 1;
        u115:Disconnect();
        u88:Disconnect();

        if u78 then
            u78:Destroy();
        end;

        if u16 == u77 then
            if not u16 then
                return;
            end;

            if u18 then
                u18:Disconnect();
                u18 = nil;
            end;

            if u17 then
                u17:Destroy();
                u17 = nil;
            end;

            local v117 = u16;

            if v117 then
                v117 = v117:FindFirstChild("Overhead");
            end;

            if v117 and v117:IsA("BillboardGui") then
                v117.Enabled = true;
            end;

            Highlight.Enabled = false;
            Highlight.Adornee = nil;
            Highlight.Parent = nil;
            PetInfo.Enabled = false;
            PetInfo.Adornee = nil;
            Part.Parent = nil;
            u16 = nil;
        end;
    end;

    u70.Destroying:Once(function() -- Line: 420
        -- upvalues: u116 (ref), u81 (ref), u115 (copy), u88 (copy), u78 (copy), u16 (ref), u77 (copy), u18 (ref), u17 (ref), Highlight (ref), PetInfo (ref), Part (ref)
        if not u116 then
            u116 = true;
            u81 = u81 + 1;
            u115:Disconnect();
            u88:Disconnect();

            if u78 then
                u78:Destroy();
            end;

            if u16 == u77 and u16 then
                if u18 then
                    u18:Disconnect();
                    u18 = nil;
                end;

                if u17 then
                    u17:Destroy();
                    u17 = nil;
                end;

                local v118 = u16;

                if v118 then
                    v118 = v118:FindFirstChild("Overhead");
                end;

                if v118 and v118:IsA("BillboardGui") then
                    v118.Enabled = true;
                end;

                Highlight.Enabled = false;
                Highlight.Adornee = nil;
                Highlight.Parent = nil;
                PetInfo.Enabled = false;
                PetInfo.Adornee = nil;
                Part.Parent = nil;
                u16 = nil;
            end;
        end;

        u77:Destroy();
    end);
    u77.Destroying:Once(cleanup);
end;

local function clearPetConnections(p119) -- Line: 427
    -- upvalues: u14 (copy)
    local v120 = u14[p119];

    if not v120 then
        return;
    end;

    for _, v in v120 do
        v:Disconnect();
    end;

    u14[p119] = nil;
end;

local function clearPlayerPets(p121) -- Line: 437
    -- upvalues: u14 (copy), u12 (ref), u16 (ref), u18 (ref), u17 (ref), Highlight (copy), PetInfo (copy), Part (copy), u13 (copy), updateMouseFilter (copy)
    local v122 = u14[p121];

    if v122 then
        for _, v in v122 do
            v:Disconnect();
        end;

        u14[p121] = nil;
    end;

    local v123 = u12 and u12[p121];

    if v123 then
        if u16 and (u16:IsDescendantOf(v123) and u16) then
            if u18 then
                u18:Disconnect();
                u18 = nil;
            end;

            if u17 then
                u17:Destroy();
                u17 = nil;
            end;

            local v124 = u16;

            if v124 then
                v124 = v124:FindFirstChild("Overhead");
            end;

            if v124 and v124:IsA("BillboardGui") then
                v124.Enabled = true;
            end;

            Highlight.Enabled = false;
            Highlight.Adornee = nil;
            Highlight.Parent = nil;
            PetInfo.Enabled = false;
            PetInfo.Adornee = nil;
            Part.Parent = nil;
            u16 = nil;
        end;

        u13[v123] = nil;
        v123:Destroy();
        u12[p121] = nil;
    end;

    updateMouseFilter();
end;

local function watchPlot(u125, p126) -- Line: 452
    -- upvalues: u12 (ref), u14 (copy), u16 (ref), u18 (ref), u17 (ref), Highlight (copy), PetInfo (copy), Part (copy), u13 (copy), updateMouseFilter (copy), renderPet (copy)
    u12 = u12 or {};
    local v127 = u14[u125];

    if v127 then
        for _, v in v127 do
            v:Disconnect();
        end;

        u14[u125] = nil;
    end;

    local v128 = u12[u125];

    if v128 then
        if u16 and (u16:IsDescendantOf(v128) and u16) then
            if u18 then
                u18:Disconnect();
                u18 = nil;
            end;

            if u17 then
                u17:Destroy();
                u17 = nil;
            end;

            local v129 = u16;

            if v129 then
                v129 = v129:FindFirstChild("Overhead");
            end;

            if v129 and v129:IsA("BillboardGui") then
                v129.Enabled = true;
            end;

            Highlight.Enabled = false;
            Highlight.Adornee = nil;
            Highlight.Parent = nil;
            PetInfo.Enabled = false;
            PetInfo.Adornee = nil;
            Part.Parent = nil;
            u16 = nil;
        end;

        u13[v128] = nil;
        v128:Destroy();
        u12[u125] = nil;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "ClientPets";
    Folder.Parent = p126;
    u12[u125] = Folder;
    u13[Folder] = true;
    u14[u125] = {};
    updateMouseFilter();

    local function addPet(p130) -- Line: 474
        -- upvalues: renderPet (ref), Folder (copy)
        renderPet(p130, Folder);
    end;

    local Pets2 = p126:FindFirstChild("Pets");

    if Pets2 then
        for _, child in Pets2:GetChildren() do
            renderPet(child, Folder);
        end;

        table.insert(u14[u125], Pets2.ChildAdded:Connect(addPet));

        return;
    end;

    local u131 = nil;
    u131 = p126.DescendantAdded:Connect(function(p132) -- Line: 484
        -- upvalues: u131 (ref), renderPet (ref), Folder (copy), u14 (ref), u125 (copy), addPet (copy)
        if p132.Name ~= "Pets" then
            return;
        end;

        u131:Disconnect();

        for _, child in p132:GetChildren() do
            renderPet(child, Folder);
        end;

        table.insert(u14[u125], p132.ChildAdded:Connect(addPet));
    end);
    table.insert(u14[u125], u131);
end;

local function watchPlayerPets(u133) -- Line: 494
    -- upvalues: watchPlot (copy), u15 (copy), u14 (copy), u12 (ref), u16 (ref), u18 (ref), u17 (ref), Highlight (copy), PetInfo (copy), Part (copy), u13 (copy), updateMouseFilter (copy)
    local v134 = u133:FindFirstChild("Plot") or u133:WaitForChild("Plot", 10);

    if not v134 then
        return;
    end;

    if v134.Value then
        watchPlot(u133, v134.Value);
    end;

    if u15[u133] then
        u15[u133]:Disconnect();
    end;

    u15[u133] = v134.Changed:Connect(function(p135) -- Line: 505
        -- upvalues: watchPlot (ref), u133 (copy), u14 (ref), u12 (ref), u16 (ref), u18 (ref), u17 (ref), Highlight (ref), PetInfo (ref), Part (ref), u13 (ref), updateMouseFilter (ref)
        if p135 then
            watchPlot(u133, p135);

            return;
        end;

        local v136 = u133;
        local v137 = u14[v136];

        if v137 then
            for _, v in v137 do
                v:Disconnect();
            end;

            u14[v136] = nil;
        end;

        local v138 = u12 and u12[v136];

        if v138 then
            if u16 and (u16:IsDescendantOf(v138) and u16) then
                if u18 then
                    u18:Disconnect();
                    u18 = nil;
                end;

                if u17 then
                    u17:Destroy();
                    u17 = nil;
                end;

                local v139 = u16;

                if v139 then
                    v139 = v139:FindFirstChild("Overhead");
                end;

                if v139 and v139:IsA("BillboardGui") then
                    v139.Enabled = true;
                end;

                Highlight.Enabled = false;
                Highlight.Adornee = nil;
                Highlight.Parent = nil;
                PetInfo.Enabled = false;
                PetInfo.Adornee = nil;
                Part.Parent = nil;
                u16 = nil;
            end;

            u13[v138] = nil;
            v138:Destroy();
            u12[v136] = nil;
        end;

        updateMouseFilter();
    end);
end;

local function clearPlayer(p140) -- Line: 514
    -- upvalues: u14 (copy), u12 (ref), u16 (ref), u18 (ref), u17 (ref), Highlight (copy), PetInfo (copy), Part (copy), u13 (copy), updateMouseFilter (copy), u15 (copy)
    local v141 = u14[p140];

    if v141 then
        for _, v in v141 do
            v:Disconnect();
        end;

        u14[p140] = nil;
    end;

    local v142 = u12 and u12[p140];

    if v142 then
        if u16 and (u16:IsDescendantOf(v142) and u16) then
            if u18 then
                u18:Disconnect();
                u18 = nil;
            end;

            if u17 then
                u17:Destroy();
                u17 = nil;
            end;

            local v143 = u16;

            if v143 then
                v143 = v143:FindFirstChild("Overhead");
            end;

            if v143 and v143:IsA("BillboardGui") then
                v143.Enabled = true;
            end;

            Highlight.Enabled = false;
            Highlight.Adornee = nil;
            Highlight.Parent = nil;
            PetInfo.Enabled = false;
            PetInfo.Adornee = nil;
            Part.Parent = nil;
            u16 = nil;
        end;

        u13[v142] = nil;
        v142:Destroy();
        u12[p140] = nil;
    end;

    updateMouseFilter();

    if u15[p140] then
        u15[p140]:Disconnect();
        u15[p140] = nil;
    end;
end;

function v11.Initialize(p144) -- Line: 522
    -- upvalues: PetInfo (copy), Part (copy), Players (copy), watchPlayerPets (copy), clearPlayer (copy), u6 (copy), LocalPlayer (copy), u3 (copy), getPlacePivot (copy), u12 (ref), displayPet (copy), UserInputService (copy), u10 (copy), u13 (copy), u16 (ref), u18 (ref), u17 (ref), Highlight (copy)
    PetInfo.Enabled = false;
    PetInfo.Adornee = nil;
    Part.Parent = nil;

    for _, v in Players:GetPlayers() do
        task.spawn(watchPlayerPets, v);
    end;

    Players.PlayerAdded:Connect(function(p145) -- Line: 531
        -- upvalues: watchPlayerPets (ref)
        task.spawn(watchPlayerPets, p145);
    end);
    Players.PlayerRemoving:Connect(clearPlayer);
    u6.new("PlacePet"):Connect(function(p146) -- Line: 537
        -- upvalues: LocalPlayer (ref), u3 (ref), getPlacePivot (ref)
        local v147;

        if p146 == nil then
            v147 = false;
        else
            v147 = p146:IsA("Tool");

            if v147 then
                if p146:GetAttribute("type") == "Pet" then
                    v147 = type(p146:GetAttribute("PetName")) == "string";
                else
                    v147 = false;
                end;
            end;
        end;

        if not v147 or p146.Parent ~= LocalPlayer.Character then
            return;
        end;

        if not u3:InvokeServer("CanPlacePet", p146) then
            _G.Play("Negative");

            return;
        end;

        local v148 = getPlacePivot();

        if not v148 then
            _G.Play("Negative");

            return;
        end;

        u3:FireServer("PlacePet", p146, v148);
        _G.Play("Placed");
    end);
    u6.new("ShowDisplayedPet"):Connect(function(p149) -- Line: 554
        -- upvalues: u12 (ref), LocalPlayer (ref), displayPet (ref)
        local v150 = u12 and u12[LocalPlayer];

        if v150 then
            v150 = v150:FindFirstChild((tostring(p149)));
        end;

        if v150 and v150:IsA("Model") then
            displayPet(v150);
        end;
    end);
    UserInputService.InputEnded:Connect(function(p151, p152) -- Line: 562
        -- upvalues: u10 (ref), u13 (ref), displayPet (ref), u16 (ref), u18 (ref), u17 (ref), Highlight (ref), PetInfo (ref), Part (ref)
        if p152 then
            return;
        end;

        if p151.UserInputType ~= Enum.UserInputType.MouseButton1 and p151.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        local v153 = u10:GetTarget();
        local v154;

        if v153 and v153.Name == "Hitbox" then
            v154 = v153.Parent;

            if not (v154 and (v154:IsA("Model") and u13[v154.Parent])) then
                v154 = nil;
            end;
        else
            v154 = nil;
        end;

        if v154 then
            displayPet(v154);

            return;
        end;

        if not u16 then
            return;
        end;

        if u18 then
            u18:Disconnect();
            u18 = nil;
        end;

        if u17 then
            u17:Destroy();
            u17 = nil;
        end;

        local v155 = u16;

        if v155 then
            v155 = v155:FindFirstChild("Overhead");
        end;

        if v155 and v155:IsA("BillboardGui") then
            v155.Enabled = true;
        end;

        Highlight.Enabled = false;
        Highlight.Adornee = nil;
        Highlight.Parent = nil;
        PetInfo.Enabled = false;
        PetInfo.Adornee = nil;
        Part.Parent = nil;
        u16 = nil;
    end);
end;

return v11;