--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Numbers
  Path:     game.ReplicatedStorage.Library.Numbers
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:42:59 2026
]]

-- Decompiled with Potassium's decompiler.

local Suffixes = require(script.Data).Suffixes;
local u6 = {
    Round = function(p1, p2) -- Line: 16, Name: Round
        local v3 = typeof(p2) ~= "number" and 1 or p2;

        return math.round(p1 / v3) * v3;
    end,

    roundNumber = function(p4, p5) -- Line: 23, Name: roundNumber
        return tonumber(string.format("%." .. (p5 or 0) .. "f", p4));
    end
};

function u6.RemoveZeros(p7) -- Line: 27
    -- upvalues: u6 (copy)
    local v8 = tostring(p7);
    local v9 = string.split(v8, ".")[1];
    local v10 = 1;

    for _ = 1, string.len(v9) - 2 do
        v10 = v10 * 10;
    end;

    return u6.Round(p7, v10);
end;

function u6.Suffix(p11, p12) -- Line: 43
    -- upvalues: Suffixes (copy)
    for i = 1, #Suffixes do
        if tonumber(p11) < 10 ^ (i * 3) then
            local v13 = math.floor(p11 / (10 ^ ((i - 1) * 3) / 100)) / 100;

            if p12 then
                v13 = math.round(v13 * 10) / 10;
            end;

            return v13 .. Suffixes[i];
        end;
    end;
end;

function u6.getAmount(p14) -- Line: 57
    -- upvalues: u6 (copy)
    if p14 >= 100000000000 then
        return u6.Suffix(p14);
    end;

    return u6.Comma(p14);
end;

function u6.FormatTimeFull(p15) -- Line: 65
    local v16, v17 = math.modf(p15 / 86400);
    local v18, v19 = math.modf(v17 * 24);
    local v20, v21 = math.modf(v19 * 60);
    local v22 = math.floor(v21 * 60);

    if v16 > 0 then
        return ("%dd %dh %dm"):format(v16, v18, v20);
    end;

    if v18 > 0 then
        return ("%dh %dm %ds"):format(v18, v20, v22);
    end;

    if v20 > 0 then
        return ("%dm %ds"):format(v20, v22);
    end;

    return ("%ds"):format(v22);
end;

function u6.FormatTimePriority(p23) -- Line: 85
    local v24 = math.floor(p23 + 0.5);
    local v25 = math.max(0, v24);
    local v26 = math.floor(v25 / 86400);
    local v27 = math.floor(v25 % 86400 / 3600);
    local v28 = math.floor(v25 % 3600 / 60);
    local v29 = v25 % 60;

    if v26 > 0 then
        return string.format("%dd %dh", v26, v27);
    end;

    if v27 > 0 then
        return string.format("%dh %dm", v27, v28);
    end;

    if v28 > 0 then
        return string.format("%dm %ds", v28, v29);
    end;

    return string.format("%ds", v29);
end;

function u6.ToHMS(p30) -- Line: 105
    return string.format("%2ih %2im %2is", p30 / 3600, p30 / 60 % 60, p30 % 60);
end;

function u6.ToHM(p31) -- Line: 109
    return string.format("%ih %im", p31 / 3600, p31 / 60 % 60);
end;

function u6.ToM(p32) -- Line: 114
    return string.format("%im", p32 / 60 % 60);
end;

function u6.ToMS(p33) -- Line: 120
    return string.format("%im %is", p33 / 60 % 60, p33 % 60);
end;

function u6.formatSemicolonTime(p34) -- Line: 124
    local v35 = math.floor(p34 / 60);

    return string.format("%02d:%02d", v35, p34 % 60);
end;

function u6.Comma(p36) -- Line: 132
    -- upvalues: u6 (copy)
    if p36 >= 1000000000 then
        return u6.Suffix(p36);
    end;

    local v37, v38, v39 = string.match(p36, "^([^%d]*%d)(%d*)(.-)$");

    return v37 .. v38:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v39;
end;

function u6.ConvertNumberToOrderedData(p40) -- Line: 142
    local v41;

    if p40 == 0 then
        v41 = 0;
    else
        local v42 = math.log(p40) / 9.999999505838704e-8;
        v41 = math.floor(v42) or 0;
    end;

    return v41;
end;

function u6.ConvertOrderedDataToNumber(p43) -- Line: 147
    return math.floor(p43 ~= 0 and 1.0000001 ^ p43 or 0);
end;

function u6.AddIdentifier(p44) -- Line: 152
    local v45;

    if p44 % 10 == 1 and p44 ~= 11 then
        v45 = p44 .. "st";
    elseif p44 % 10 == 2 and p44 ~= 12 then
        v45 = p44 .. "nd";
    elseif p44 % 10 == 3 and p44 ~= 13 then
        v45 = p44 .. "rd";
    else
        v45 = p44 .. "th";
    end;

    return tostring(v45);
end;

function u6.GetTime() -- Line: 168
    local v46 = os.date("*t", os.time());

    return {
        month = v46.month,
        day = v46.day,
        year = v46.year,
        hour = v46.hour,
        minute = v46.min
    };
end;

function u6.ConvertToTwelve(p47, p48) -- Line: 174
    local v49;

    if p47 > 12 then
        p47 = p47 - 12;
        v49 = "pm";
    else
        v49 = "am";
    end;

    return string.format("%s:%s %s", p47, p48, v49);
end;

local function CovertToTwelve(p50) -- Line: 190
    if p50 > 12 then
        return p50 - 12, "pm";
    end;

    return p50, "am";
end;

return u6;