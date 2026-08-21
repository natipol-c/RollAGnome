--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GnomeUtil
  Path:     game.ReplicatedStorage.Library.Configs.GnomeUtil
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:31 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local u1 = require(ReplicatedStorage.Library).get("Mutations");
local Particles = ReplicatedStorage.Assets.Particles;
local u2 = {};
local u3 = {
    Golden = Color3.fromRGB(255, 176, 0),
    Diamond = Color3.fromRGB(69, 174, 255)
};

local function getParticlePart(p4) -- Line: 32
    local ParticlePart = p4:FindFirstChild("ParticlePart");

    if not ParticlePart then
        local v5, v6 = p4:GetBoundingBox();
        ParticlePart = Instance.new("Part");
        ParticlePart.CFrame = v5;
        ParticlePart.Size = v6;
        ParticlePart.Transparency = 1;
        ParticlePart.Anchored = false;
        ParticlePart.CanCollide = false;
        ParticlePart.CanQuery = false;
        ParticlePart.Parent = p4;
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p4.PrimaryPart;
        WeldConstraint.Part1 = ParticlePart;
        WeldConstraint.Parent = ParticlePart;
    end;

    return ParticlePart;
end;

function u2.applyMutations(p7, p8) -- Line: 53
    -- upvalues: u1 (copy), u3 (copy), getParticlePart (copy), Particles (copy)
    local v9 = u1:toTable(p8);

    for _, v in u1:toTable(v9) do
        for _, descendant in p7:GetDescendants() do
            if descendant:IsA("BasePart") and (not descendant:GetAttribute("BLOCK") and u3[v]) then
                if descendant:IsA("MeshPart") then
                    descendant.TextureID = "";
                end;

                descendant.Color = u3[v];
            end;
        end;
    end;

    if table.find(v9, "Toxic") then
        local v10 = getParticlePart(p7);
        local Toxic = Particles:FindFirstChild("Toxic");

        if Toxic and not v10:FindFirstChild("Toxic") then
            local v11 = next;
            local v12, v13 = Toxic:GetChildren();

            for _, v in v11, v12, v13 do
                v:Clone().Parent = v10;
            end;

            for _, descendant in p7:GetDescendants() do
                if descendant:IsA("BasePart") then
                    if descendant:IsA("MeshPart") then
                        descendant.TextureID = "";
                    end;

                    descendant.Color = Color3.fromRGB(42, 217, 112);
                end;
            end;
        end;
    end;

    if table.find(v9, "Cursed") then
        local v14 = getParticlePart(p7);
        local Cursed = Particles:FindFirstChild("Cursed");

        if Cursed and not v14:FindFirstChild("Cursed") then
            local v15 = next;
            local v16, v17 = Cursed:GetChildren();

            for _, v in v15, v16, v17 do
                v:Clone().Parent = v14;
            end;

            local Folder = Instance.new("Folder");
            Folder.Name = "Cursed";
            Folder.Parent = v14;
        end;

        for _, descendant in p7:GetDescendants() do
            if descendant:IsA("BasePart") and math.random() < 0.4 then
                if descendant:IsA("MeshPart") then
                    descendant.TextureID = "";
                end;

                descendant.Color = Color3.fromRGB(166, 94, 255);
                descendant.Material = Enum.Material.ForceField;
            end;
        end;
    end;

    if table.find(v9, "Night") then
        local v18 = getParticlePart(p7);
        local Night = Particles:FindFirstChild("Night");

        if Night and not v18:FindFirstChild("Runes") then
            local v19 = next;
            local v20, v21 = Night:GetChildren();

            for _, v in v19, v20, v21 do
                v:Clone().Parent = v18;
            end;
        end;
    end;

    if table.find(v9, "Charged") then
        local v22 = getParticlePart(p7);
        local Charged = Particles:FindFirstChild("Charged");

        if Charged and not v22:FindFirstChild("Charged") then
            Charged:Clone().Parent = v22;
        end;
    end;

    if table.find(v9, "Solar") then
        local v23 = getParticlePart(p7);
        local Solar = Particles:FindFirstChild("Solar");

        if Solar and not v23:FindFirstChild("SolarA") then
            local v24 = next;
            local v25, v26 = Solar:GetChildren();

            for _, v in v24, v25, v26 do
                v:Clone().Parent = v23;
            end;
        end;
    end;

    if table.find(v9, "Frozen") then
        local v27, v28 = p7:GetBoundingBox();
        local Part = Instance.new("Part");
        Part.Material = "Ice";
        Part.Color = Color3.fromRGB(0, 170, 255);
        Part.Transparency = 0.5;
        Part.Anchored = false;
        Part.CanCollide = false;
        Part.Massless = true;
        Part.Size = Vector3.new(v28.X, v28.Y, v28.Z);
        Part:PivotTo(v27);
        Part.Parent = p7;
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p7.PrimaryPart;
        WeldConstraint.Part1 = Part;
        WeldConstraint.Parent = Part;
    end;
end;

function u2.getModel(p29, p30, p31) -- Line: 169
    -- upvalues: ReplicatedStorage (copy), u2 (copy)
    local v32 = ReplicatedStorage.Assets.Farmers:FindFirstChild(p29);

    if v32 then
        local v33 = v32:Clone();
        v33:SetAttribute("Mutations", p30 or "");
        v33:SetAttribute("Huge", p31 == true);

        if p31 then
            v33:ScaleTo(v33:GetScale() * 1.8);
        end;

        u2.applyMutations(v33, p30);

        return v33;
    end;
end;

function u2.getDisplayModel(p34, p35, p36) -- Line: 184
    -- upvalues: ReplicatedStorage (copy), u2 (copy)
    local v37 = ReplicatedStorage.Assets:FindFirstChild("FarmerPerformance"):FindFirstChild(p34) or ReplicatedStorage.Assets.Farmers:FindFirstChild(p34);

    if v37 then
        local v38 = v37:Clone();
        v38:SetAttribute("Mutations", p35 or "");
        v38:SetAttribute("Huge", p36 == true);

        if p36 then
            v38:ScaleTo(v38:GetScale() * 1.8);
        end;

        u2.applyMutations(v38, p35);

        return v38;
    end;
end;

return u2;