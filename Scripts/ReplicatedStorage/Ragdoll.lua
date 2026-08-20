--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Ragdoll
  Path:     game.ReplicatedStorage.Library.Imported.Ragdoll
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:42:59 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
game:GetService("ReplicatedStorage");
game:GetService("RunService");
local HumanoidStateType = Enum.HumanoidStateType;
local u1 = {
    R15 = {
        Head = { "LeftUpperArm", "LeftUpperLeg", "LowerTorso", "RightUpperArm", "RightUpperLeg" },
        LeftFoot = { "LowerTorso", "UpperTorso" },
        LeftHand = { "LowerTorso", "UpperTorso" },
        RightFoot = { "LowerTorso", "UpperTorso" },
        RightHand = { "LowerTorso", "UpperTorso" },
        LeftLowerArm = { "LowerTorso", "UpperTorso" },
        LeftLowerLeg = { "LowerTorso", "UpperTorso" },
        LeftUpperArm = { "LeftUpperLeg", "LowerTorso", "UpperTorso", "RightUpperArm", "RightUpperLeg" },
        LeftUpperLeg = { "LowerTorso", "UpperTorso", "RightUpperLeg" },
        RightLowerArm = { "LowerTorso", "UpperTorso" },
        RightLowerLeg = { "LowerTorso", "UpperTorso" },
        RightUpperArm = { "RightUpperLeg", "LowerTorso", "UpperTorso", "LeftUpperLeg" },
        RightUpperLeg = { "LowerTorso", "UpperTorso" }
    },
    R6 = {
        Head = { "Left Arm", "Left Leg", "Torso", "Right Arm", "Right Leg" }
    }
};

local function getMotors(p2) -- Line: 35
    local _ = p2.Humanoid;
    local v3 = {};

    for _, child in p2:GetChildren() do
        for _, child2 in child:GetChildren() do
            if child2:IsA("Motor6D") then
                v3[#v3 + 1] = child2;
            end;
        end;
    end;

    return v3;
end;

local function createNoCollisionConstraints(p4, p5) -- Line: 51
    -- upvalues: u1 (copy)
    for i, v in u1[p5] do
        for _, v2 in v do
            local NoCollisionConstraint = Instance.new("NoCollisionConstraint");
            NoCollisionConstraint.Name = "RagdollNoCollide";
            NoCollisionConstraint.Part0 = p4[i];
            NoCollisionConstraint.Part1 = p4[v2];
            NoCollisionConstraint.Parent = p4;
        end;
    end;
end;

local u11 = {
    CreateJoints = function(p6) -- Line: 68, Name: CreateJoints
        -- upvalues: getMotors (copy), createNoCollisionConstraints (copy)
        if p6:IsA("Model") and p6:FindFirstChildOfClass("Humanoid") then
            local RigType = p6.Humanoid.RigType;
            local v7 = getMotors(p6);
            createNoCollisionConstraints(p6, RigType.Name);

            for _, v in v7 do
                local Attachment = Instance.new("Attachment");
                local Attachment2 = Instance.new("Attachment");
                Attachment.Name = "RagdollConstraint";
                Attachment2.Name = "RagdollConstraint";
                Attachment.CFrame = v.C0;
                Attachment2.CFrame = v.C1;
                Attachment.Parent = v.Part0;
                Attachment2.Parent = v.Part1;
                local v8 = v.Name:gsub("Right", ""):gsub("Left", ""):gsub("Joint", ""):gsub(" ", "");
                local v9 = (script[RigType.Name]:FindFirstChild(v8) or script[RigType.Name].Default):Clone();
                v9.Name = "RagdollConstraint";
                v9.Attachment0 = Attachment;
                v9.Attachment1 = Attachment2;
                v9.Parent = v.Part1;
            end;

            return v7;
        end;
    end,

    DestroyJoints = function(p10) -- Line: 103, Name: DestroyJoints
        if not p10 then
            return;
        end;

        for _, descendant in p10:GetDescendants() do
            if (descendant:IsA("Constraint") or (descendant:IsA("WeldConstraint") or descendant:IsA("Attachment"))) and descendant.Name == "RagdollConstraint" or descendant:IsA("NoCollisionConstraint") and descendant.Name == "RagdollNoCollide" then
                descendant:Destroy();
            end;
        end;
    end
};

function u11.Ragdoll(u12) -- Line: 117
    -- upvalues: u11 (copy)
    pcall(function() -- Line: 118
        -- upvalues: u11 (ref), u12 (copy)
        u11.CreateJoints(u12);
        local PrimaryPart = u12.PrimaryPart;
        local Humanoid = u12.Humanoid;
        Humanoid.WalkSpeed = 0;
        Humanoid.AutoRotate = false;
        PrimaryPart.CanCollide = false;
        u12.Head.CanCollide = true;
        u11.SetMotorsEnabled(u12, false);
    end);
end;

function u11.UnRagdoll(u13, u14) -- Line: 143
    -- upvalues: u11 (copy)
    pcall(function() -- Line: 144
        -- upvalues: u13 (copy), u11 (ref), u14 (copy)
        local Humanoid = u13.Humanoid;
        u11.DestroyJoints(u13);
        u11.SetMotorsEnabled(u13, true);

        if Humanoid.Health > 0 then
            if not u14 then
                Humanoid.WalkSpeed = 16;
            end;

            Humanoid.AutoRotate = true;
            u13.PrimaryPart.CanCollide = true;
            u13.Head.CanCollide = false;
        end;
    end);
end;

function u11.SetMotorsEnabled(u15, u16) -- Line: 170
    -- upvalues: getMotors (copy)
    pcall(function() -- Line: 171
        -- upvalues: getMotors (ref), u15 (copy), u16 (copy)
        for _, v in getMotors(u15) do
            v.Enabled = u16;
        end;
    end);
end;

function u11.IsRagdolled(p17) -- Line: 181
    -- upvalues: HumanoidStateType (copy)
    return p17:GetState() == HumanoidStateType.Physics;
end;

return u11;