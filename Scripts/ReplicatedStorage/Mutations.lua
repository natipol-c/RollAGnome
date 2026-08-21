--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Mutations
  Path:     game.ReplicatedStorage.Library.Configs.Mutations
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:30 2026
]]

-- Decompiled with Potassium's decompiler.

local ConfigService = game:GetService("ConfigService");
game:GetService("Players");
game:GetService("ServerStorage");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local MutationLabels = ReplicatedStorage.Assets.Billboards.MutationLabels;
local u1 = {};
local u2 = {
    Golden = 0.5,
    Diamond = 0.1,
    Shiny = 0.5
};
local u3 = {
    Golden = 1.5,
    Diamond = 2,
    Shiny = 3,
    Fire = 1.5,
    Night = 1.5,
    Toxic = 1.85,
    Charged = 1.25,
    Frozen = 1.5,
    Cursed = 2,
    Solar = 2
};

function u1.buffStat(p4, p5, p6) -- Line: 53
    -- upvalues: u3 (copy)
    if type(p6) == "string" then
        p6 = p4:toTable(p6);
    end;

    for _, v in next, p6 or {} do
        if u3[v] then
            p5 = p5 * u3[v];
        end;
    end;

    return math.round(p5);
end;

function u1.getMutation(p7, p8, p9, p10, p11, p12) -- Line: 67
    -- upvalues: RunService (copy), ConfigService (copy), u2 (copy), ReplicatedStorage (copy), u1 (copy)
    if RunService:IsServer() then
        local v13 = {};
        local v14 = ConfigService:GetConfigAsync():GetValue("weather_events");
        u2.Toxic = v14.toxic.roll_chance;
        u2.Charged = v14.charged.roll_chance;
        u2.Frozen = v14.blizzard.roll_chance;
        u2.Cursed = v14.cursed.roll_chance;
        u2.Solar = v14.solarflare.roll_chance;
        local v15 = ReplicatedStorage:GetAttribute("MutationRush") or nil;
        local v16 = ReplicatedStorage:GetAttribute("MutationMulti") or nil;
        local v17 = type(p9) == "number" and (math.max(p9 - 1, 0) * 0.025 or 0) or 0;
        local v18 = type(p12) == "number" and (math.max(p12, 0) or 0) or 0;
        local v19 = 1 + v17 + v18;
        local v20 = math.clamp(u2.Golden * (v15 == "Golden" and v16 and v16 or 1) * v19, 0, 100);
        local v21 = math.clamp(u2.Diamond * (v15 == "Diamond" and v16 and v16 or 1) * v19, 0, 100);
        local v22 = math.random() * 100;

        if v22 <= v21 then
            table.insert(v13, "Diamond");
        elseif v22 <= v20 then
            table.insert(v13, "Golden");
        end;

        for i, v in next, u2 do
            if i ~= "Golden" and (i ~= "Diamond" and (i ~= "Toxic" or ReplicatedStorage:GetAttribute("Toxic"))) and ((i ~= "Charged" or ReplicatedStorage:GetAttribute("LightningStorm")) and ((i ~= "Frozen" or ReplicatedStorage:GetAttribute("Blizzard")) and ((i ~= "Cursed" or ReplicatedStorage:GetAttribute("Cursed")) and (i ~= "Solar" or ReplicatedStorage:GetAttribute("SolarFlare"))))) and math.clamp(v * (v15 == i and v16 and v16 or 1) * v19, 0, 100) >= math.random() * 100 then
                table.insert(v13, i);
            end;
        end;

        return u1:toString(v13);
    end;
end;

function u1.updateList(p23, p24, p25) -- Line: 163
    -- upvalues: u1 (copy), MutationLabels (copy)
    if not (p24 and p25) then
        return;
    end;

    for _, child in ipairs(p24:GetChildren()) do
        if child:IsA("TextLabel") or child:IsA("ImageLabel") then
            child:Destroy();
        end;
    end;

    if type(p25) == "string" then
        p25 = u1:toTable(p25);
    end;

    local v26 = {};

    for _, v in next, p25 do
        local v27 = MutationLabels:FindFirstChild(v);

        if v27 then
            table.insert(v26, v27);
        end;
    end;

    table.sort(v26, function(p28, p29) -- Line: 186
        return p28.LayoutOrder < p29.LayoutOrder;
    end);

    for i, v in ipairs(v26) do
        local v30 = v:Clone();
        v30.Parent = p24;
        v30.LayoutOrder = v.LayoutOrder;
        local v31 = MutationLabels:FindFirstChild(v.Name .. "Icon");

        if v31 and v31:IsA("ImageLabel") then
            local v32 = v31:Clone();
            v32.LayoutOrder = v.LayoutOrder - 0.1;
            v32.Parent = p24;
        end;

        if i < #v26 then
            local v33 = MutationLabels.Plus:Clone();
            v33.Name = "Plus";
            v33.LayoutOrder = v30.LayoutOrder + 0.1;
            v33.Parent = p24;
        end;
    end;

    p24.Visible = #v26 > 0;
end;

function u1.toTable(p34, p35) -- Line: 215
    if type(p35) == "table" then
        return p35;
    end;

    local v36 = p35 or "";

    return v36 == "" and {} or string.split(v36, "_");
end;

function u1.toString(p37, p38) -- Line: 226
    if type(p38) == "string" then
        p38 = p37:toTable(p38);
    end;

    return table.concat(p38 or {}, "_");
end;

return u1;