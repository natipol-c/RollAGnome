--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Sizes
  Path:     game.ReplicatedStorage.Library.Sizes
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:04 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    Default = {
        {
            name = "Small",
            weight = 500,
            multRange = { 0.7, 0.95 },
            scaleRange = { 0.7, 0.95 }
        },
        {
            name = "Normal",
            weight = 1000,
            multRange = { 1, 1 },
            scaleRange = { 1, 1.15 }
        },
        {
            name = "Medium",
            weight = 500,
            multRange = { 1.1, 1.25 },
            scaleRange = { 1.15, 1.25 }
        },
        {
            name = "Large",
            weight = 200,
            multRange = { 1.3, 1.7 },
            scaleRange = { 1.25, 1.4 }
        },
        {
            name = "Huge",
            weight = 80,
            multRange = { 1.8, 2.4 },
            scaleRange = { 1.4, 1.55 }
        },
        {
            name = "Titan",
            weight = 30,
            multRange = { 2.6, 3.4 },
            scaleRange = { 1.55, 1.7 }
        },
        {
            name = "Gigantic",
            weight = 12,
            multRange = { 4, 5.5 },
            scaleRange = { 1.7, 1.9 }
        },
        {
            name = "Colossal",
            weight = 5,
            multRange = { 6, 8 },
            scaleRange = { 1.9, 2.1 }
        },
        {
            name = "Titanic",
            weight = 2,
            multRange = { 9, 12 },
            scaleRange = { 2.1, 2.3 }
        },
        {
            name = "TripleTitanic",
            weight = 0.8,
            multRange = { 14, 18 },
            scaleRange = { 2.3, 2.6 }
        },
        {
            name = "UltraTitanic",
            weight = 0.3,
            multRange = { 20, 28 },
            scaleRange = { 2.6, 2.9 }
        },
        {
            name = "Omega",
            weight = 0.1,
            multRange = { 30, 45 },
            scaleRange = { 2.9, 3.2 }
        },
        {
            name = "Mythic",
            weight = 0.03,
            multRange = { 50, 70 },
            scaleRange = { 3.2, 3.5 }
        },
        {
            name = "MEGA",
            weight = 0.01,
            multRange = { 80, 100 },
            scaleRange = { 3.5, 3.8 }
        }
    }
};

for _, v in u1 do
    for _, v2 in v do
        local u2 = v2.multRange[1];
        local u3 = v2.multRange[2];
        local u4 = v2.scaleRange[1];
        local u5 = v2.scaleRange[2];

        function v2.multRange(p6) -- Line: 44
            -- upvalues: u4 (copy), u5 (copy), u2 (copy), u3 (copy)
            local v7 = (p6 - u4 == u5 - u4 or u5 - u4 == 0) and 1 or math.clamp((p6 - u4) / (u5 - u4), 0, 1);

            return math.lerp(u2, u3, v7);
        end;
    end;
end;

local function GetWeightedRandom(p8, p9) -- Line: 58
    local v10 = 0;

    for _, v in ipairs(p8) do
        local weight = v.weight;

        if v.scaleRange[1] > 1 then
            weight = weight * p9;
        end;

        v10 = v10 + weight;
    end;

    local v11 = math.random() * v10;
    local v12 = 0;

    for _, v in ipairs(p8) do
        local weight = v.weight;

        if v.scaleRange[1] > 1 then
            weight = weight * p9;
        end;

        v12 = v12 + weight;

        if v11 <= v12 then
            return v;
        end;
    end;
end;

function u1.get(p13) -- Line: 82
    -- upvalues: u1 (copy), GetWeightedRandom (copy)
    local v14 = GetWeightedRandom(u1.Default, p13 or 1);
    local v15 = math.random() * (v14.scaleRange[2] - v14.scaleRange[1]) + v14.scaleRange[1];
    local v16 = v14.multRange(v15);

    return {
        size = v14.name,
        scale = math.round(v15 * 1000) / 1000,
        multi = v16
    };
end;

return u1;