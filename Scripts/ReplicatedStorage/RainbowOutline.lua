--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     RainbowOutline
  Path:     game.ReplicatedStorage.Library.Imported.EasyVisuals.Presets.RainbowOutline
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:24 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local Parent = require(script.Parent.Parent);

return function(p1, u2, p3) -- Line: 5
    -- upvalues: Parent (copy), RunService (copy)
    local u4 = Parent.Stroke.new(p1, p3);
    local u5 = Parent.Gradient.new(u4.Instance, Parent.Templates.Rainbow.Color, 0);
    local u6 = 5;
    local u7 = nil;
    u7 = RunService.Heartbeat:Connect(function(p8) -- Line: 11
        -- upvalues: u4 (copy), u7 (ref), u6 (ref), u2 (copy), u5 (copy)
        if not u4.Instance or u4.Instance.Parent == nil then
            u7:Disconnect();
        end;

        u6 = u6 + u2 * p8;
        u5:SetRotation(u6, 1);
    end);

    return {
        Effects = { u5, u4 },
        Connections = { u7 }
    };
end;