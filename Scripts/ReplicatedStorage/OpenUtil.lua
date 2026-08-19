--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     OpenUtil
  Path:     game.ReplicatedStorage.Library.OpenUtil
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:23 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Farmer RNG");
local u2 = Library.get("Farmers");
local v3 = {};

local function ApplyLuckToWeights(p4, p5) -- Line: 10
    -- upvalues: u2 (copy)
    local v6 = math.max(p5 or 1, 1);
    local _ = 1 / v6;
    local v7 = {};
    local v8 = 0;

    for i, v in pairs(p4) do
        local _ = u2[i];
        local v9 = v ^ (1 / v6);
        v7[i] = v9;
        v8 = v8 + v9;
    end;

    return v7, v8;
end;

local function ApplyLuckToSizeWeights(p10, p11) -- Line: 33
    local v12 = 1 / math.max(p11 or 1, 1);
    local v13 = 0;
    local v14 = {};

    for _, v in ipairs(p10) do
        local v15 = v.Weight ^ v12;
        v13 = v13 + v15;
        table.insert(v14, {
            Name = v.Name,
            Weight = v15,
            ScaleRange = v.ScaleRange,
            MultRange = v.MultRange
        });
    end;

    return v14, v13;
end;

function v3.Roll(p16, p17, p18, p19) -- Line: 56
    -- upvalues: u1 (copy), ApplyLuckToWeights (copy)
    local v20 = p18 or 1;
    local v21 = u1[p17];

    if not v21 then
        return nil, nil;
    end;

    if p19 then
        local v22 = {};

        for i, _ in pairs(v21.contents) do
            table.insert(v22, i);
        end;

        if #v22 > 0 then
            return v22[math.random(1, #v22)];
        end;
    else
        local v23, v24 = ApplyLuckToWeights(v21.contents, v20);
        local v25 = math.random() * v24;

        for i, v in pairs(v23) do
            if v25 <= v then
                return i;
            end;

            v25 = v25 - v;
        end;
    end;

    return nil;
end;

return v3;