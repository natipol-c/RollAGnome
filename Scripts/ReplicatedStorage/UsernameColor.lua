--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     UsernameColor
  Path:     game.ReplicatedStorage.Library.UsernameColor
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:30 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
game:GetService("ServerStorage");
game:GetService("ReplicatedStorage");
game:GetService("RunService");
local u1 = {
    Color3.new(0.9921568627450981, 0.1607843137254902, 0.2627450980392157),
    Color3.new(0.00392156862745098, 0.6352941176470588, 1),
    Color3.new(0.00784313725490196, 0.7215686274509804, 0.3411764705882353),
    BrickColor.new("Bright violet").Color,
    BrickColor.new("Bright orange").Color,
    BrickColor.new("Bright yellow").Color,
    BrickColor.new("Light reddish violet").Color,
    BrickColor.new("Brick yellow").Color
};
local v2 = {};

local function GetNameValue(p3) -- Line: 34
    local v4 = 0;

    for i = 1, #p3 do
        local v5 = string.sub(p3, i, i);
        local v6 = string.byte(v5);
        local v7 = #p3 - i + 1;

        if #p3 % 2 == 1 then
            v7 = v7 - 1;
        end;

        if v7 % 4 >= 2 then
            v6 = -v6;
        end;

        v4 = v4 + v6;
    end;

    return v4;
end;

function v2.get(u8) -- Line: 50
    -- upvalues: u1 (copy), GetNameValue (copy)
    local function ComputeNameColor() -- Line: 53
        -- upvalues: u1 (ref), GetNameValue (ref), u8 (copy)
        return u1[(GetNameValue(u8) + 0) % #u1 + 1];
    end;

    local v9 = u1[(GetNameValue(u8) + 0) % #u1 + 1];

    return Color3.fromRGB(v9.R * 255, v9.G * 255, v9.B * 255);
end;

return v2;