--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Shine
  Path:     game.ReplicatedStorage.Library.Imported.EasyVisuals.Presets.Shine
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:24 2026
]]

-- Decompiled with Potassium's decompiler.

local Parent = require(script.Parent.Parent);

local function makeLighter(p1, p2) -- Line: 4
    return p1:Lerp(Color3.fromRGB(255, 255, 255), p2);
end;

local function findColorFromObject(p3) -- Line: 8
    return p3[({
        TextButton = "BackgroundColor3",
        TextLabel = "TextColor3",
        ImageLabel = "ImageColor3",
        ImageButton = "ImageColor3",
        Frame = "BackgroundColor3",
        ScrollingFrame = "BackgroundColor3",
        ViewportFrame = "BackgroundColor3"
    })[p3.ClassName]] or Color3.fromRGB(255, 255, 255);
end;

return function(p4, p5, p6, p7) -- Line: 28
    -- upvalues: findColorFromObject (copy), Parent (copy)
    local v8 = p7 or findColorFromObject(p4);
    local v9 = v8:Lerp(Color3.fromRGB(255, 255, 255), 0.417505);
    local v10 = ColorSequence.new({ ColorSequenceKeypoint.new(0, v8), ColorSequenceKeypoint.new(0.5, v9), ColorSequenceKeypoint.new(1, v8) });
    local v11 = Parent.Gradient.new(p4, v10, 0);
    v11:SetOffsetSpeed(p5 * 0.6, 1);
    v11:SetRotation(60, 1);

    return {
        Effects = { v11 }
    };
end;