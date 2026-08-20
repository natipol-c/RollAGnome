--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Glitch
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Glitch
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:09 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local Library = require(ReplicatedStorage.Library);
Library.get("CameraShaker");
Library.get("Network");
local LocalPlayer = game.Players.LocalPlayer;
(LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart", 10);
local u1 = {};

local function HideModel(p2) -- Line: 36
    -- upvalues: u1 (copy)
    if not p2 then
        return;
    end;

    for _, descendant in ipairs(p2:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant:IsA("MeshPart") then
            u1[descendant] = descendant.Transparency;
            descendant.Transparency = 1;
        elseif descendant:IsA("Decal") then
            u1[descendant] = descendant.Transparency;
            descendant.Transparency = 1;
        end;
    end;
end;

local function ShowModel(p3) -- Line: 52
    -- upvalues: u1 (copy)
    if not p3 then
        return;
    end;

    for _, descendant in ipairs(p3:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant:IsA("MeshPart") then
            descendant.Transparency = u1[descendant] or 0;
        elseif descendant:IsA("Decal") then
            descendant.Transparency = u1[descendant] or 0;
        end;

        u1[descendant] = nil;
    end;
end;

local function ToggleCollision(p4, p5) -- Line: 65
    for _, descendant in pairs(p4:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = p5;
        end;
    end;
end;

local function GetClone(p6) -- Line: 75
    -- upvalues: Players (copy)
    if p6 then
        local v7 = Players:GetPlayerFromCharacter(p6);

        if not v7 then
            return p6:Clone();
        end;

        local v8 = p6:FindFirstChildOfClass("Humanoid");
        local v9;

        if v8 then
            v9 = v8:GetAppliedDescription();
        else
            v9 = Players:GetHumanoidDescriptionFromUserId(v7.UserId);
        end;

        local v10 = Players:CreateHumanoidModelFromDescription(v9, Enum.HumanoidRigType.R15);
        v10.Name = p6.Name .. "_Dummy";

        return v10;
    end;
end;

local u16 = {
    Glitch = function(p11) -- Line: 102, Name: Glitch
        -- upvalues: GetClone (copy), ToggleCollision (copy), HideModel (copy), ShowModel (copy)
        if not p11 then
            return;
        end;

        local v12 = GetClone(p11);
        v12.Parent = workspace;
        v12.Name = "";
        ToggleCollision(v12, false);
        HideModel(p11);

        for _ = 1, math.random(2, 3) do
            local v13 = p11:GetPivot();
            local v14 = math.random(-50, 50) / 100;
            local v15 = math.random(-50, 50) / 100;
            v12:PivotTo(v13 + Vector3.new(v14, 0, v15));
            task.wait();
        end;

        ShowModel(p11);
        v12:Destroy();
    end
};

function u16.Initialize(p17) -- Line: 131
    -- upvalues: RunService (copy), CollectionService (copy), u16 (copy)
    local u18 = tick();
    RunService.Heartbeat:Connect(function() -- Line: 134
        -- upvalues: u18 (ref), CollectionService (ref), u16 (ref)
        local v19 = tick();

        if v19 - u18 >= 1 then
            u18 = v19;

            for _, v in pairs(CollectionService:GetTagged("Glitch")) do
                if v:IsDescendantOf(workspace) then
                    u16.Glitch(v);
                end;
            end;
        end;
    end);
end;

return u16;