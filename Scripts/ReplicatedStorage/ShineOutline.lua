--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ShineOutline
  Path:     game.ReplicatedStorage.Library.Imported.EasyVisuals.Presets.ShineOutline
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:33 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local Parent = require(script.Parent.Parent);

local function makeLighter(p1, p2) -- Line: 5
    return p1:Lerp(Color3.fromRGB(255, 255, 255), p2);
end;

local function findColorFromObject(p3) -- Line: 9
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

return function(p4, u5, p6, p7) -- Line: 29
    -- upvalues: findColorFromObject (copy), Parent (copy), RunService (copy)
    local v8 = p7 or findColorFromObject(p4);
    local v9 = v8:Lerp(Color3.fromRGB(255, 255, 255), 0.6);
    local v10 = ColorSequence.new({ ColorSequenceKeypoint.new(0, v8), ColorSequenceKeypoint.new(0.5, v9), ColorSequenceKeypoint.new(1, v8) });
    local u11 = Parent.Stroke.new(p4, p6);
    local u12 = Parent.Gradient.new(u11.Instance, v10, 0);
    local u13 = 0.75;
    local u14 = nil;
    u14 = RunService.Heartbeat:Connect(function(p15) -- Line: 48
        -- upvalues: u11 (copy), u14 (ref), u13 (ref), u5 (copy), u12 (copy)
        if not u11.Instance or u11.Instance.Parent == nil then
            u14:Disconnect();
        end;

        u13 = u13 + u5 * p15;
        u12:SetRotation(u13, 1);
    end);

    return {
        Effects = { u12, u11 },
        Connections = { u14 }
    };
end;