--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Crops
  Path:     game.ReplicatedStorage.Library.Configs.Crops
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:30 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Plants = require(script.Parent.Plants);
local Mutations = require(script.Parent.Mutations);
local Assets = ReplicatedStorage.Assets;
local Plants2 = Assets.Plants;
local Fruit = Assets:FindFirstChild("Fruit");
local Particles = Assets.Particles;
local u1 = {};

local function toMutationList(p2) -- Line: 26
    if type(p2) == "string" then
        return p2 == "" and {} or string.split(p2, "_");
    end;

    return type(p2) ~= "table" and {} or p2;
end;

local function getMutationModel(p3, p4) -- Line: 41
    -- upvalues: toMutationList (copy)
    for _, v in toMutationList(p4) do
        local v5 = p3.models or p3.mutation_models;
        local v6;

        if type(v5) == "table" then
            v6 = v5[v];
        else
            v6 = false;
        end;

        if typeof(v6) == "Instance" then
            return v6;
        end;

        local v7;

        if type(p3.mutations) == "table" then
            v7 = p3.mutations[v];
        else
            v7 = false;
        end;

        local v8;

        if type(v7) == "table" then
            v8 = v7.model;
        else
            v8 = false;
        end;

        if typeof(v8) == "Instance" then
            return v8;
        end;
    end;
end;

local function getConfiguredModel(p9, p10, p11) -- Line: 57
    -- upvalues: getMutationModel (copy), Fruit (copy), Plants2 (copy)
    local v12 = getMutationModel(p9, p11);

    if v12 then
        return v12;
    end;

    if typeof(p9.model) == "Instance" then
        return p9.model;
    end;

    local v13 = p9.modelName or p10;

    if type(v13) == "string" then
        return Fruit and Fruit:FindFirstChild(v13) or Plants2:FindFirstChild(v13);
    end;

    return nil;
end;

local function getFruitCrop(p14, p15) -- Line: 74
    -- upvalues: Plants (copy), getConfiguredModel (copy)
    for i, v in Plants do
        local fruit = v.fruit;

        if type(fruit) == "table" and fruit.name == p14 then
            return {
                type = "Fruit",
                name = p14,
                parentPlantName = i,
                parentPlantConfig = v,
                config = fruit,
                model = getConfiguredModel(fruit, p14, p15),
                icon = fruit.icon or v.icon,
                sell_price = fruit.sell_price or v.sell_price,
                weight = fruit.weight or v.weight,
                growth_time = fruit.growth_time
            };
        end;
    end;
end;

function u1.get(p16, p17) -- Line: 94
    -- upvalues: Plants (copy), getConfiguredModel (copy), getFruitCrop (copy)
    if type(p16) ~= "string" then
        return nil;
    end;

    local v18 = Plants[p16];

    return v18 and {
        type = "Plant",
        name = p16,
        config = v18,
        model = getConfiguredModel(v18, p16, p17),
        icon = v18.icon,
        sell_price = v18.sell_price,
        weight = v18.weight,
        growth_time = v18.growth_time
    } or getFruitCrop(p16, p17);
end;

local function getParticlePart(p19) -- Line: 114
    local ParticlePart = p19:FindFirstChild("ParticlePart");

    if not ParticlePart then
        local v20, v21 = p19:GetBoundingBox();
        ParticlePart = Instance.new("Part");
        ParticlePart.CFrame = v20;
        ParticlePart.Size = v21;
        ParticlePart.Transparency = 1;
        ParticlePart.Anchored = false;
        ParticlePart.CanCollide = false;
        ParticlePart.CanQuery = false;
        ParticlePart.Parent = p19;
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p19.CenterPart;
        WeldConstraint.Part1 = ParticlePart;
        WeldConstraint.Parent = ParticlePart;
    end;

    return ParticlePart;
end;

function u1.applyMutations(p22, p23) -- Line: 135
    -- upvalues: Mutations (copy), toMutationList (copy), getParticlePart (copy), Particles (copy)
    local v24 = Mutations:toTable(p23);

    for _, v in toMutationList(v24) do
        if v == "Golden" then
            for _, descendant in p22:GetDescendants() do
                if descendant:IsA("BasePart") and not descendant:GetAttribute("BLOCK") then
                    descendant.Color = Color3.fromRGB(255, 176, 0);
                end;
            end;
        elseif v == "Diamond" then
            for _, descendant in p22:GetDescendants() do
                if descendant:IsA("BasePart") and not descendant:GetAttribute("BLOCK") then
                    descendant.Color = Color3.fromRGB(69, 174, 255);
                end;
            end;
        end;
    end;

    if table.find(v24, "Toxic") then
        local v25 = getParticlePart(p22);
        local Toxic = Particles:FindFirstChild("Toxic");

        if Toxic and not v25:FindFirstChild("Toxic") then
            local v26 = next;
            local v27, v28 = Toxic:GetChildren();

            for _, v in v26, v27, v28 do
                v:Clone().Parent = v25;
            end;

            for _, descendant in p22:GetDescendants() do
                if descendant:IsA("BasePart") and not descendant:GetAttribute("BLOCK") then
                    descendant.Color = Color3.fromRGB(42, 217, 112);
                end;
            end;
        end;
    end;

    if table.find(v24, "Cursed") then
        local v29 = getParticlePart(p22);
        local Cursed = Particles:FindFirstChild("Cursed");

        if Cursed and not v29:FindFirstChild("Cursed") then
            local v30 = next;
            local v31, v32 = Cursed:GetChildren();

            for _, v in v30, v31, v32 do
                v:Clone().Parent = v29;
            end;

            local Folder = Instance.new("Folder");
            Folder.Name = "Cursed";
            Folder.Parent = v29;
        end;

        for _, descendant in p22:GetDescendants() do
            if descendant:IsA("BasePart") and math.random() < 0.4 then
                if descendant:IsA("MeshPart") then
                    descendant.TextureID = "";
                end;

                descendant.Color = Color3.fromRGB(166, 94, 255);
                descendant.Material = Enum.Material.ForceField;
            end;
        end;
    end;

    if table.find(v24, "Night") then
        local v33 = getParticlePart(p22);
        local NightSmall = Particles:FindFirstChild("NightSmall");

        if NightSmall and not v33:FindFirstChild("FireFlibook") then
            local v34 = next;
            local v35, v36 = NightSmall:GetChildren();

            for _, v in v34, v35, v36 do
                v:Clone().Parent = v33;
            end;
        end;
    end;

    if table.find(v24, "Charged") then
        local v37 = getParticlePart(p22);
        local Charged = Particles:FindFirstChild("Charged");

        if Charged and not v37:FindFirstChild("Charged") then
            Charged:Clone().Parent = v37;
        end;
    end;

    if table.find(v24, "Solar") then
        local v38 = getParticlePart(p22);
        local Small_Solar = Particles:FindFirstChild("Small_Solar");

        if Small_Solar and not v38:FindFirstChild("SolarA") then
            local v39 = next;
            local v40, v41 = Small_Solar:GetChildren();

            for _, v in v39, v40, v41 do
                v:Clone().Parent = v38;
            end;
        end;
    end;

    if table.find(v24, "Frozen") then
        local v42, v43 = p22:GetBoundingBox();
        local Part = Instance.new("Part");
        Part.Material = "Ice";
        Part.Color = Color3.fromRGB(0, 170, 255);
        Part.Transparency = 0.5;
        Part.Anchored = false;
        Part.CanCollide = false;
        Part.Massless = true;
        Part.Size = Vector3.new(v43.X - 0.05, v43.Y - 0.05, v43.Z - 0.05);
        Part:PivotTo(v42);
        Part.Parent = p22;
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p22.CenterPart;
        WeldConstraint.Part1 = Part;
        WeldConstraint.Parent = Part;
    end;

    if table.find(v24, "Shiny") then
        for _, descendant in p22:GetDescendants() do
            if descendant:IsA("BasePart") and not descendant:GetAttribute("BLOCK") then
                local Color = descendant.Color;
                local fromRGB = Color3.fromRGB;
                local v44 = math.floor(Color.R * 255) + 75;
                local v45 = math.clamp(v44, 0, 255);
                local v46 = math.floor(Color.G * 255) + 75;
                local v47 = math.clamp(v46, 0, 255);
                local v48 = math.floor(Color.B * 255) + 75;
                descendant.Color = fromRGB(v45, v47, (math.clamp(v48, 0, 255)));
            end;
        end;
    end;
end;

function u1.getModel(p49, p50) -- Line: 272
    -- upvalues: u1 (copy)
    local v51 = u1.get(p49, p50);

    if v51 then
        v51 = v51.model;
    end;

    if v51 then
        local v52 = v51:Clone();
        u1.applyMutations(v52, p50);

        return v52;
    end;
end;

function u1.getPrice(p53, p54, p55) -- Line: 283
    -- upvalues: u1 (copy), Mutations (copy), toMutationList (copy)
    local v56 = u1.get(p53);

    if v56 then
        v56 = v56.sell_price;
    end;

    if type(v56) ~= "number" then
        return nil;
    end;

    local v57 = p54 == nil and 1 or p54;

    if type(v57) ~= "number" or v57 ~= v57 then
        return nil;
    end;

    if v57 == (1 / 0) or v57 == (-1 / 0) then
        return nil;
    end;

    return Mutations:buffStat(v56 * v57, toMutationList(p55));
end;

return u1;