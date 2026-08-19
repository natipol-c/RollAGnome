--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GnomeUtil
  Path:     game.ReplicatedStorage.Library.Configs.GnomeUtil
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:23 2026
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

    if table.find(v9, "Frozen") then
        local v23, v24 = p7:GetBoundingBox();
        local Part = Instance.new("Part");
        Part.Material = "Ice";
        Part.Color = Color3.fromRGB(0, 170, 255);
        Part.Transparency = 0.5;
        Part.Anchored = false;
        Part.CanCollide = false;
        Part.Massless = true;
        Part.Size = Vector3.new(v24.X, v24.Y, v24.Z);
        Part:PivotTo(v23);
        Part.Parent = p7;
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p7.PrimaryPart;
        WeldConstraint.Part1 = Part;
        WeldConstraint.Parent = Part;
    end;
end;

function u2.getModel(p25, p26, p27) -- Line: 159
    -- upvalues: ReplicatedStorage (copy), u2 (copy)
    local v28 = ReplicatedStorage.Assets.Farmers:FindFirstChild(p25);

    if v28 then
        local v29 = v28:Clone();
        v29:SetAttribute("Mutations", p26 or "");
        v29:SetAttribute("Huge", p27 == true);

        if p27 then
            v29:ScaleTo(v29:GetScale() * 1.8);
        end;

        u2.applyMutations(v29, p26);

        return v29;
    end;
end;

function u2.getDisplayModel(p30, p31, p32) -- Line: 174
    -- upvalues: ReplicatedStorage (copy), u2 (copy)
    local v33 = ReplicatedStorage.Assets:FindFirstChild("FarmerPerformance"):FindFirstChild(p30) or ReplicatedStorage.Assets.Farmers:FindFirstChild(p30);

    if v33 then
        local v34 = v33:Clone();
        v34:SetAttribute("Mutations", p31 or "");
        v34:SetAttribute("Huge", p32 == true);

        if p32 then
            v34:ScaleTo(v34:GetScale() * 1.8);
        end;

        u2.applyMutations(v34, p31);

        return v34;
    end;
end;

return u2;