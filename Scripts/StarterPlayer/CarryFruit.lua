--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CarryFruit
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Pets.Actions.CarryFruit
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:41 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Trove = require(ReplicatedStorage.Library.Imported.Trove);
local LocalPlayer = Players.LocalPlayer;
local u1 = {};

local function StopTween(p2) -- Line: 12
    -- upvalues: u1 (copy)
    local v3 = u1[p2];

    if not v3 then
        return;
    end;

    u1[p2] = nil;
    v3:Destroy();
end;

return function(u4, p5) -- Line: 20, Name: CarryFruit
    -- upvalues: LocalPlayer (copy), u1 (copy), Trove (copy), TweenService (copy)
    if typeof(u4) ~= "Instance" or type(p5) ~= "number" then
        return;
    end;

    if not (u4:IsA("Model") or u4:IsA("BasePart")) then
        return;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not (Character and Character:IsA("BasePart")) then
        return;
    end;

    local v6 = u1[u4];

    if v6 then
        u1[u4] = nil;
        v6:Destroy();
    end;

    local CFrameValue = Instance.new("CFrameValue");
    CFrameValue.Value = u4:GetPivot();
    local v7 = Trove.new();
    u1[u4] = v7;
    v7:Add(CFrameValue);
    v7:Connect(CFrameValue.Changed, function(p8) -- Line: 36
        -- upvalues: u4 (copy)
        if u4.Parent then
            u4:PivotTo(p8);
        end;
    end);
    v7:Connect(u4.Destroying, function() -- Line: 41
        -- upvalues: u4 (copy), u1 (ref)
        local v9 = u4;
        local v10 = u1[v9];

        if not v10 then
            return;
        end;

        u1[v9] = nil;
        v10:Destroy();
    end);
    local v11 = v7:Add(TweenService:Create(CFrameValue, TweenInfo.new(math.max(p5, 0), Enum.EasingStyle.Linear), {
        Value = CFrame.new(Character.Position + Vector3.new(0, 2, 0))
    }));
    v7:Connect(v11.Completed, function() -- Line: 50
        -- upvalues: u4 (copy), u1 (ref)
        local v12 = u4;
        local v13 = u1[v12];

        if not v13 then
            return;
        end;

        u1[v12] = nil;
        v13:Destroy();
    end);
    v11:Play();
end;