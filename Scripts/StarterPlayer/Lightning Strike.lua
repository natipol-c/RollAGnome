--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Lightning Strike
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Lightning Strike
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:29 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Library = require(ReplicatedStorage.Library);
local v1 = Library.get("CameraShaker");
local u2 = Library.get("Network");
local LightningExplode = ReplicatedStorage.Assets.Particles.LightningExplode;
local LocalPlayer = game.Players.LocalPlayer;
(LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart", 10);
local v3 = {};
local CurrentCamera = workspace.CurrentCamera;
local u5 = v1.new(Enum.RenderPriority.Camera.Value + 1, function(p4) -- Line: 36
    -- upvalues: CurrentCamera (copy)
    CurrentCamera.CFrame = CurrentCamera.CFrame * p4;
end);
local CameraShakeInstance = v1.CameraShakeInstance;

local function generateLightningPoints(p6, p7, p8, p9) -- Line: 45
    local v10 = { p6 };

    for i = 1, p8 - 1 do
        local v11 = p6:Lerp(p7, i / p8);
        local v12 = math.random(-p9, p9);
        local v13 = math.random(-p9, p9);
        local v14 = v11 + Vector3.new(v12, v13, math.random(-p9, p9));
        table.insert(v10, v14);
    end;

    table.insert(v10, p7);

    return v10;
end;

local function fadeOut(u15, u16) -- Line: 62
    -- upvalues: TweenService (copy)
    task.delay(0.1, function() -- Line: 63
        -- upvalues: TweenService (ref), u15 (copy), u16 (copy)
        local v17 = TweenService:Create(u15, TweenInfo.new(u16), {
            Transparency = 1
        });
        v17:Play();
        v17.Completed:Connect(function() -- Line: 66
            -- upvalues: u15 (ref)
            u15:Destroy();
        end);
    end);
end;

local function ShakeFromStrike(p18, p19, p20) -- Line: 72
    -- upvalues: CameraShakeInstance (copy), u5 (copy)
    local _ = workspace.CurrentCamera;
    local v21 = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");

    if not v21 then
        return;
    end;

    local Magnitude = (v21.Position - p18).Magnitude;

    if p19 < Magnitude then
        return;
    end;

    local v22 = 1 - math.clamp(Magnitude / p19, 0, 1);
    local v23 = CameraShakeInstance.new(p20 * v22, 10, 0, 1.5);
    v23.PositionInfluence = Vector3.new(0.25, 0.25, 0.25) * v22;
    v23.RotationInfluence = Vector3.new(4, 1, 1) * v22;
    u5:Shake(v23);
end;

local function createBoltFromPoints(p24, p25) -- Line: 91
    -- upvalues: TweenService (copy), ShakeFromStrike (copy)
    local v26 = math.random(250, 400) / 1000;

    for i = 1, #p25 - 1 do
        local v27 = p25[i];
        local v28 = p25[i + 1];
        local Magnitude = (v28 - v27).Magnitude;
        local Part = Instance.new("Part");
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CastShadow = false;
        Part.Material = Enum.Material.Neon;
        Part.Color = Color3.fromRGB(255, 255, 255);
        Part.Transparency = 0;
        Part.Size = Vector3.new(v26, v26, Magnitude);
        Part.CFrame = CFrame.new((v27 + v28) / 2, v28);
        Part.Parent = workspace;
        local u29 = 0.25;
        task.delay(0.1, function() -- Line: 63
            -- upvalues: TweenService (ref), Part (copy), u29 (copy)
            local v30 = TweenService:Create(Part, TweenInfo.new(u29), {
                Transparency = 1
            });
            v30:Play();
            v30.Completed:Connect(function() -- Line: 66
                -- upvalues: Part (ref)
                Part:Destroy();
            end);
        end);
    end;

    ShakeFromStrike(p24, 125, 3);
end;

local function fireLightning(p31, p32, p33) -- Line: 119
    -- upvalues: generateLightningPoints (copy), createBoltFromPoints (copy), LightningExplode (copy)
    createBoltFromPoints(p32, (generateLightningPoints(p31, p32, math.random(8, 12), (math.random(4, 7)))));

    if not p33 then
        return;
    end;

    local u34 = LightningExplode:Clone();
    u34.Position = p32;
    u34.Parent = workspace;
    local v35 = next;
    local v36, v37 = u34:GetDescendants();

    for _, v in v35, v36, v37 do
        if v:IsA("ParticleEmitter") then
            v:Emit(v:GetAttribute("EmitCount"));
        end;
    end;

    task.delay(4, function() -- Line: 137
        -- upvalues: u34 (copy)
        u34:Destroy();
    end);
end;

function v3.Initialize(p38) -- Line: 142
    -- upvalues: u5 (copy), u2 (copy), fireLightning (copy)
    u5:Start();
    u2:BindEvents({
        LightningStrike = function(u39, p40) -- Line: 147, Name: LightningStrike
            -- upvalues: fireLightning (ref)
            local v41;

            if u39:IsA("Model") then
                v41 = u39:FindFirstChild("Attachment").WorldCFrame.Position;
                u39 = Instance.new("Part");
                u39.Position = v41;
                u39.Transparency = 1;
                u39.Anchored = true;
                u39.CanCollide = false;
                u39.CanQuery = false;
                u39.Size = Vector3.new(1, 1, 1);
                u39.Parent = workspace;
                task.delay(6, function() -- Line: 165
                    -- upvalues: u39 (ref)
                    u39:Destroy();
                end);
            else
                v41 = u39.Position;
            end;

            local v42 = math.random(-25, 25);
            local v43 = v41 + Vector3.new(v42, 100, math.random(-25, 25));
            _G.Play("LightningStrike", u39);
            task.wait(2);
            fireLightning(v43, v41, p40);
        end
    });
end;

return v3;