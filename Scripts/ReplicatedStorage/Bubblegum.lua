--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Bubblegum
  Path:     game.ReplicatedStorage.Library.Imported.EasyVisuals.Presets.Bubblegum
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:32 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local Parent = require(script.Parent.Parent);

return function(p1, u2, u3) -- Line: 5
    -- upvalues: Parent (copy), RunService (copy)
    local v4 = Parent.Gradient.new(p1, Parent.Templates.Bubblegum.Color, 0);
    v4:SetRotation(-90, 1);
    v4:SetOffsetSpeed(u2, 1);
    local u5 = Parent.Stroke.new(p1, u3);
    local v6 = Parent.Gradient.new(u5.Instance, Parent.Templates.Bubblegum.Color, 0);
    v6:SetRotation(-45, 1);
    v6:SetOffsetSpeed(u2 * 0.9, 1);
    local u7 = u3 * 3;
    local u8 = nil;
    u8 = RunService.Heartbeat:Connect(function() -- Line: 17
        -- upvalues: u5 (copy), u8 (ref), u2 (copy), u7 (copy), u3 (copy)
        if not u5.Instance or u5.Instance.Parent == nil then
            u8:Disconnect();

            return;
        end;

        local v9 = tick() * u2;
        u5:SetSize(u3 * (u7 * math.sin(v9) + 1), 0.055);
    end);

    return {
        Effects = { v4, v6, u5 },
        Connections = { u8 }
    };
end;