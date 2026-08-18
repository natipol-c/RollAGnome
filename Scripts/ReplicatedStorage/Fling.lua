--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Fling
  Path:     game.ReplicatedStorage.Library.Fling
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:04 2026
]]

-- Decompiled with Potassium's decompiler.

local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
local ServerStorage = game:GetService("ServerStorage");
game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Parent = require(script.Parent);
local u1 = Parent.get("Network");
local u2 = Parent.get("Hammers");

return function(u3) -- Line: 30, Name: FlingNearestPlayerInFront
    -- upvalues: Players (copy), u2 (copy), ServerStorage (copy), u1 (copy), Debris (copy)
    if u3:GetAttribute("InTutorial") then
        return;
    end;

    local success, result = pcall(function() -- Line: 35
        -- upvalues: u3 (copy), Players (ref), u2 (ref), ServerStorage (ref), u1 (ref), Debris (ref)
        local Character = u3.Character;

        if not (Character and Character:FindFirstChild("HumanoidRootPart")) then
            return;
        end;

        local Position = Character.HumanoidRootPart.Position;
        local LookVector = Character.HumanoidRootPart.CFrame.LookVector;
        local v4 = nil;

        for _, v in ipairs(Players:GetPlayers()) do
            if v ~= u3 and (v.Character and not (v:GetAttribute("Flung") or (v:GetAttribute("InTutorial") or v.Character:FindFirstChildWhichIsA("ForceField")))) then
                local Character2 = v.Character;

                if Character2 then
                    Character2 = Character2:FindFirstChild("HumanoidRootPart");
                end;

                if Character2 and (Character2.Position - Position).Magnitude <= 9 then
                    v4 = v;
                end;
            end;
        end;

        local v5 = Character:FindFirstChildWhichIsA("Tool");
        local v6 = u2[v5.Name];

        if not v6 then
            return;
        end;

        local v7 = v4 and (v4.Character and v4.Character:FindFirstChild("HumanoidRootPart"));

        if v7 then
            if v4:GetAttribute("Holding") then
                ServerStorage.Communication.DropEgg:Fire(v4);
            elseif v4:GetAttribute("Stealing") then
                if v4:GetAttribute("StealingBrainrot") then
                    ServerStorage.Communication.ReturnBrainrot:Fire(v4);
                elseif v4:GetAttribute("StealingEgg") then
                    ServerStorage.Communication.ReturnEgg:Fire(v4);
                end;
            end;

            local Part = Instance.new("Part");
            Part.Size = Vector3.new(1, 1, 1);
            Part.Transparency = 1;
            Part.CanCollide = false;
            Part.Anchored = true;
            Part.CanQuery = false;
            Part:PivotTo(v7:GetPivot());
            u1:FireAllClients("PlaySound", "Play", v6.sound, Part);
            task.delay(2, function() -- Line: 102
                -- upvalues: Part (copy)
                Part:Destroy();
            end);
            ServerStorage.Communication.Ragdoll:Fire(v4, v5.Name, v6.ragdoll);
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.Velocity = LookVector * v6.velocity + Vector3.new(0, v6.vertical, 0);
            BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
            BodyVelocity.P = 10000;
            BodyVelocity.Parent = v7;
            Debris:AddItem(BodyVelocity, 0.25);
        end;
    end);

    if not success then
        warn("[Fling]:", result);
    end;
end;