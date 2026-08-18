--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     OpenUtil
  Path:     game.ReplicatedStorage.Library.OpenUtil
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:04 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Farmer RNG");
local u2 = Library.get("Farmers");
local v3 = {};

local function ApplyLuckToWeights(p4, p5) -- Line: 10
    -- upvalues: u2 (copy)
    local v6 = 1 / math.max(p5 or 1, 1);
    local v7 = {};
    local v8 = 0;

    for i, v in pairs(p4) do
        local v9 = u2[i];
        local v10;

        if v9 and v9.real_rarity == "IMPOSSIBLE" then
            v10 = math.max(0.6, v6);
        else
            v10 = v6;
        end;

        local v11 = v ^ v10;
        v7[i] = v11;
        v8 = v8 + v11;
    end;

    return v7, v8;
end;

local function ApplyLuckToSizeWeights(p12, p13) -- Line: 36
    local v14 = 1 / math.max(p13 or 1, 1);
    local v15 = 0;
    local v16 = {};

    for _, v in ipairs(p12) do
        local v17 = v.Weight ^ v14;
        v15 = v15 + v17;
        table.insert(v16, {
            Name = v.Name,
            Weight = v17,
            ScaleRange = v.ScaleRange,
            MultRange = v.MultRange
        });
    end;

    return v16, v15;
end;

function v3.Roll(p18, p19, p20, p21) -- Line: 59
    -- upvalues: u1 (copy), ApplyLuckToWeights (copy)
    local v22 = p20 or 1;
    local v23 = u1[p19];

    if not v23 then
        return nil, nil;
    end;

    if p21 then
        local v24 = {};

        for i, _ in pairs(v23.contents) do
            table.insert(v24, i);
        end;

        if #v24 > 0 then
            return v24[math.random(1, #v24)];
        end;
    else
        local v25, v26 = ApplyLuckToWeights(v23.contents, v22);
        local v27 = math.random() * v26;

        for i, v in pairs(v25) do
            if v27 <= v then
                return i;
            end;

            v27 = v27 - v;
        end;
    end;

    return nil;
end;

return v3;