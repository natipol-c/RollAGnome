--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     FireStroke
  Path:     game.ReplicatedStorage.Library.Imported.EasyVisuals.Presets.FireStroke
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:00 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local Parent = require(script.Parent.Parent);

return function(p1, u2, p3) -- Line: 5
    -- upvalues: Parent (copy), RunService (copy)
    local u4 = Parent.Gradient.new(p1, Parent.Templates.Fire.Color, 0);
    u4:SetRotation(-75, 1);
    u4:SetOffsetSpeed(u2, 1);
    local u5 = 0;
    local u6 = nil;
    u6 = RunService.Heartbeat:Connect(function(p7) -- Line: 12
        -- upvalues: u4 (copy), u6 (ref), u5 (ref), u2 (copy)
        if not u4.Instance or u4.Instance.Parent == nil then
            u6:Disconnect();
        end;

        u5 = u5 + u2 * p7;
        u4:SetRotation(u5, 1);
    end);
    local v8 = Parent.Stroke.new(p1, p3);
    local v9 = Parent.Gradient.new(v8.Instance, Parent.Templates.Fire.Color, 0);
    v9:SetRotation(75, 1);
    v9:SetOffsetSpeed(-u2, 1);

    return {
        Effects = { u4, v9, v8 },
        Connections = { u6 }
    };
end;