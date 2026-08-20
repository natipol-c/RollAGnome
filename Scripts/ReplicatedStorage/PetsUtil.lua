--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PetsUtil
  Path:     game.ReplicatedStorage.Library.Configs.PetsUtil
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:04 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Mutations = require(ReplicatedStorage.Library.Configs.Mutations);
local Pets = ReplicatedStorage.Assets:WaitForChild("Pets");
local u1 = {};
local u2 = {
    Golden = Color3.fromRGB(255, 176, 0),
    Diamond = Color3.fromRGB(69, 174, 255)
};

local function toMutationTable(p3, p4) -- Line: 16
    -- upvalues: Mutations (copy)
    local v5 = Mutations:toTable(p3);

    if p4 == true and not table.find(v5, "Huge") then
        table.insert(v5, "Huge");
    end;

    return v5;
end;

function u1.applyMutations(p6, p7, p8) -- Line: 24
    -- upvalues: Mutations (copy), u2 (copy)
    local v9 = Mutations:toTable(p7);

    if p8 == true and not table.find(v9, "Huge") then
        table.insert(v9, "Huge");
    end;

    local v10 = table.find(v9, "Huge") ~= nil;
    p6:SetAttribute("Mutations", Mutations:toString(v9));
    p6:SetAttribute("Huge", v10);

    for _, v in v9 do
        local v11 = u2[v];

        if v11 then
            for _, descendant in p6:GetDescendants() do
                if descendant:IsA("BasePart") and not descendant:GetAttribute("BLOCK") then
                    if descendant:IsA("MeshPart") then
                        descendant.TextureID = "";
                    end;

                    descendant.Color = v11;
                end;
            end;
        end;
    end;

    if v10 and p6:GetAttribute("PetHugeApplied") ~= true then
        p6:SetAttribute("PetHugeApplied", true);
        p6:ScaleTo(p6:GetScale() * 2);
    end;
end;

function u1.getDisplayName(p12, p13, p14) -- Line: 48
    -- upvalues: Mutations (copy)
    local find = table.find;
    local v15 = Mutations:toTable(p13);

    if p14 == true and not table.find(v15, "Huge") then
        table.insert(v15, "Huge");
    end;

    if find(v15, "Huge") ~= nil then
        p12 = `HUGE {p12}` or p12;
    end;

    return p12;
end;

function u1.getModel(p16, p17, p18) -- Line: 52
    -- upvalues: Pets (copy), u1 (copy)
    local v19 = Pets:FindFirstChild(p16);

    if not (v19 and v19:IsA("Model")) then
        return nil;
    end;

    local v20 = v19:Clone();
    u1.applyMutations(v20, p17 or {}, p18);

    return v20;
end;

function u1.getDisplayModel(p21, p22, p23) -- Line: 61
    -- upvalues: u1 (copy)
    return u1.getModel(p21, p22, p23);
end;

return u1;