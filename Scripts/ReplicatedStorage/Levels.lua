--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Levels
  Path:     game.ReplicatedStorage.Library.Levels
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:42:59 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    DEFAULT_LEVEL = 1,
    DEFAULT_XP = 0,
    BASE_REQUIRED_XP = 5,
    XP_CURVE = 1.2,
    VALUE_BONUS_PER_LEVEL = 0.1,
    MAX_START_LEVEL = 10,
    START_LEVEL_EXPONENT = 4
};
local u2 = {};
local u3 = 0;

for i = 1, u1.MAX_START_LEVEL do
    local v4 = (1 / i) ^ u1.START_LEVEL_EXPONENT;
    u2[i] = v4;
    u3 = u3 + v4;
end;

local function cleanNumber(p5, p6) -- Line: 29
    if type(p5) ~= "number" or p5 ~= p5 then
        return p6;
    end;

    if p5 == (1 / 0) or p5 == (-1 / 0) then
        return p6;
    end;

    return p5;
end;

function u1.getLevel(p7) -- Line: 40
    -- upvalues: u1 (copy)
    local DEFAULT_LEVEL = u1.DEFAULT_LEVEL;

    if type(p7) ~= "number" or p7 ~= p7 then
        return DEFAULT_LEVEL;
    end;

    if p7 == (1 / 0) or p7 == (-1 / 0) then
        return DEFAULT_LEVEL;
    end;

    return p7;
end;

function u1.getXP(p8) -- Line: 45
    -- upvalues: u1 (copy)
    local DEFAULT_XP = u1.DEFAULT_XP;

    if type(p8) == "number" and p8 == p8 then
        if p8 ~= (1 / 0) and p8 ~= (-1 / 0) then
            DEFAULT_XP = p8;
        end;
    end;

    local v9 = math.floor(DEFAULT_XP);

    return math.max(v9, u1.DEFAULT_XP);
end;

function u1.getRequiredXP(p10) -- Line: 50
    -- upvalues: u1 (copy)
    local v11 = u1.getLevel(p10);
    local v12 = math.floor(u1.BASE_REQUIRED_XP * v11 ^ u1.XP_CURVE);

    return math.max(v12, 1);
end;

function u1.getValueBonus(p13) -- Line: 55
    -- upvalues: u1 (copy)
    return u1.getLevel(p13) * u1.VALUE_BONUS_PER_LEVEL;
end;

function u1.getValueMultiplier(p14) -- Line: 60
    -- upvalues: u1 (copy)
    return 1 + u1.getValueBonus(p14);
end;

function u1.getValue(p15, p16) -- Line: 64
    -- upvalues: u1 (copy)
    local v17 = ((type(p15) ~= "number" or p15 ~= p15) and 0 or ((p15 == (1 / 0) or p15 == (-1 / 0)) and 0 or p15)) * u1.getValueMultiplier(p16);

    return math.round(v17);
end;

function u1.getStartingLevel() -- Line: 69
    -- upvalues: u3 (ref), u1 (copy), u2 (copy)
    local v18 = math.random() * u3;
    local v19 = 0;

    for i = 1, u1.MAX_START_LEVEL do
        v19 = v19 + u2[i];

        if v18 <= v19 then
            return i;
        end;
    end;

    return u1.DEFAULT_LEVEL;
end;

function u1.getProgress(p20, p21) -- Line: 83
    -- upvalues: u1 (copy)
    local v22 = u1.getRequiredXP(p20);
    local v23 = u1.getXP(p21);

    return {
        level = u1.getLevel(p20),
        xp = v23,
        requiredXP = v22,
        alpha = math.clamp(v23 / v22, 0, 1)
    };
end;

function u1.addXP(p24, p25, p26, p27) -- Line: 95
    -- upvalues: u1 (copy)
    local v28 = u1.getLevel(p24);
    local v29 = u1.getXP(p25);
    local v30 = u1.getXP(p26);
    local v31 = 0;
    local v32;

    if type(p27) == "number" then
        v32 = u1.DEFAULT_LEVEL <= p27;
    else
        v32 = false;
    end;

    local v33 = v32 and math.floor(p27) or nil;
    local v34 = v29 + v30;

    while u1.getRequiredXP(v28) <= v34 do
        if v33 and v33 <= v28 then
            v34 = u1.getRequiredXP(v28);
            break;
        end;

        v34 = v34 - u1.getRequiredXP(v28);
        v28 = v28 + 1;
        v31 = v31 + 1;
    end;

    return {
        level = v28,
        xp = v34,
        requiredXP = u1.getRequiredXP(v28),
        levelsGained = v31,
        leveledUp = v31 > 0
    };
end;

return u1;