--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Opening Effect
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Opening Effect
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:08 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Network");
local u2 = Library.get("OpenUtil");
local u3 = Library.get("SimpleTween");
local Assets = ReplicatedStorage.Assets;
local Particles = Assets.Particles;
local FarmerPerformance = Assets:WaitForChild("FarmerPerformance");
local LocalPlayer = Players.LocalPlayer;
local Preview = workspace.Preview;
local RNG = Preview.RNG;
local u4 = { "9", "2", "1", "3", "10", "8", "6", "4", "5", "7" };
local v5 = {};

local function getRollSpeed(p6) -- Line: 43
    if p6 then
        p6 = p6:GetAttribute("RollSpeed");
    end;

    return (type(p6) ~= "number" or p6 <= 0) and 1 or p6;
end;

local function getRollDuration(p7) -- Line: 52
    local v8 = 0.025;
    local v9 = 0;

    for _ = 1, 14 do
        v9 = v9 + v8 / p7;
        v8 = v8 * 1.15;
    end;

    return v9;
end;

local function createSoundPart(p10) -- Line: 63
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Size = Vector3.new(1, 1, 1);
    Part.Transparency = 1;
    Part:PivotTo(p10);
    Part.Parent = workspace;

    return Part;
end;

local function removeModels(p11) -- Line: 77
    for _, child in ipairs(p11:GetChildren()) do
        if child:IsA("Model") then
            child:Destroy();
        end;
    end;
end;

local function showRollModel(p12, p13, p14, p15, p16) -- Line: 85
    -- upvalues: FarmerPerformance (copy), u3 (copy)
    local v17 = FarmerPerformance:FindFirstChild(p13);

    if not v17 then
        return;
    end;

    local u18 = v17:Clone();
    local v19 = u18:GetScale();
    u18:ScaleTo(v19 * 0.8);
    u18.RootPart.Anchored = true;
    u18:PivotTo(p14);
    u18.Parent = p12;
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = u18:GetScale();
    u3:Tween(NumberValue, p15, "Back", "Out", {
        Value = v19
    });
    local v20 = NumberValue.Changed:Connect(function() -- Line: 103
        -- upvalues: u18 (ref), NumberValue (copy)
        u18:ScaleTo(NumberValue.Value);
    end);
    task.wait(p15);
    v20:Disconnect();
    NumberValue:Destroy();

    if not p16 then
        u18:Destroy();
    end;
end;

local function emitParticleEffect(p21, p22) -- Line: 117
    local v23 = p21:Clone();
    v23.Parent = workspace;
    v23:PivotTo(p22);
    local v24 = next;
    local v25, v26 = v23.Attachment:GetChildren();

    for _, v in v24, v25, v26 do
        v:Emit(v:GetAttribute("EmitCount"));
    end;

    return v23;
end;

local function scheduleCleanup(u27) -- Line: 129
    task.delay(5, function() -- Line: 130
        -- upvalues: u27 (copy)
        for _, v in ipairs(u27) do
            v:Destroy();
        end;
    end);
end;

local function showOpeningEffect(p28, p29, p30, p31, p32, p33, p34) -- Line: 137
    -- upvalues: RNG (copy), Preview (copy), u2 (copy), showRollModel (copy), emitParticleEffect (copy), Particles (copy), LocalPlayer (copy), u1 (copy)
    local pivot = p28.pivot;
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Size = Vector3.new(1, 1, 1);
    Part.Transparency = 1;
    Part:PivotTo(pivot);
    Part.Parent = workspace;

    if p31 then
        _G.Play("EggHatch", Part);

        if p28.huge then
            _G.Play("HugeGnomeTick", Part);
        end;
    end;

    local v35 = RNG:Clone();
    v35.Parent = Preview;
    local v36 = p28.huge and 70 or 14;
    local v37 = v36 * (v36 + 1) / 2;
    local v38 = 0.025;

    for i = 1, v36 do
        local v39 = u2:Roll(p29, nil, true);
        local v40 = i * 6.8 / v37;
        showRollModel(v35, v39, pivot, p28.huge and v40 and v40 or v38 / p33, false);

        if p31 and not p28.huge then
            _G.Play("GnomeTick", Part);
        end;

        v38 = v38 * 1.15;
    end;

    local v41 = emitParticleEffect(Particles.Reveal, pivot + Vector3.new(0, 2, 0));

    if p31 then
        _G.Play("Reveal", Part);
        _G.Play(p28.huge and "RevealHugeGnome" or `Reveal{p34}`, Part);
    end;

    if p31 then
        local u42 = { Part, v41, v35 };
        task.delay(5, function() -- Line: 130
            -- upvalues: u42 (copy)
            for _, v in ipairs(u42) do
                v:Destroy();
            end;
        end);
    else
        local u43 = { Part, v41, v35 };
        task.delay(5, function() -- Line: 130
            -- upvalues: u43 (copy)
            for _, v in ipairs(u43) do
                v:Destroy();
            end;
        end);
    end;

    if p31 and LocalPlayer == p30 then
        u1:FireServer("RevealRNG", p32);
    end;

    task.wait(0.25 / p33);
end;

local function getOrderedRolls(p44) -- Line: 187
    -- upvalues: u4 (copy)
    local v45 = {};
    local v46 = {};

    for _, v in u4 do
        local v47 = p44[v];

        if v47 then
            table.insert(v45, {
                name = v,
                info = v47
            });
        end;
    end;

    for i, v in pairs(p44) do
        if not table.find(u4, i) then
            table.insert(v46, {
                name = i,
                info = v
            });
        end;
    end;

    table.sort(v46, function(p48, p49) -- Line: 210
        local v50 = tonumber(p48.name);
        local v51 = tonumber(p49.name);

        if v50 and v51 then
            return v50 < v51;
        end;

        return tostring(p48.name) < tostring(p49.name);
    end);

    for _, v in v46 do
        table.insert(v45, v);
    end;

    return v45;
end;

local function rollRNG(p52, p53, p54) -- Line: 227
    -- upvalues: LocalPlayer (copy), getOrderedRolls (copy), showOpeningEffect (copy)
    local v55 = LocalPlayer == p52;
    local v56;

    if p52 then
        v56 = p52:GetAttribute("RollSpeed");
    else
        v56 = p52;
    end;

    local v57 = (type(v56) ~= "number" or v56 <= 0) and 1 or v56;

    for i, v in ipairs((getOrderedRolls(p54))) do
        showOpeningEffect(v.info, p53, p52, v55, v.name, v57, i);
    end;
end;

function v5.Initialize(p58) -- Line: 242
    -- upvalues: u1 (copy), rollRNG (copy)
    u1:BindEvents({
        RollRNG = rollRNG
    });
end;

return v5;