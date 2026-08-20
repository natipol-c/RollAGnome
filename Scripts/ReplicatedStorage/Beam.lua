--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Beam
  Path:     game.ReplicatedStorage.Library.Beam
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:42:59 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Beam = script.Beam;
local u1 = {};
u1.__index = u1;

function u1.new(u2) -- Line: 25
    -- upvalues: u1 (copy), Beam (copy), RunService (copy)
    if not u2 then
        return;
    end;

    local One = u2.One;
    local Two = u2.Two;
    local EndFunc = u2.EndFunc;

    if One and Two then
        local u3 = setmetatable({}, u1);
        u3.Beam = Beam:Clone();
        u3.A0 = Instance.new("Attachment");
        u3.A0.Name = "A0";
        u3.A0.Parent = Two;
        u3.A1 = Instance.new("Attachment");
        u3.A1.Name = "A1";
        u3.A1.Parent = One;
        u3.Point1 = One;
        u3.Point2 = Two;
        u3.Beam.Attachment0 = u3.A0;
        u3.Beam.Attachment1 = u3.A1;
        u3.Beam.Parent = workspace;
        u3.EndFunc = EndFunc;

        if u2.Distance then
            u3.connection = RunService.RenderStepped:Connect(function() -- Line: 56
                -- upvalues: u3 (copy), u2 (copy)
                if (u3.Point1.Position - u3.Point2.Position).Magnitude <= u2.Distance then
                    u3:Destroy();
                end;
            end);
        end;

        return u3;
    end;
end;

function u1.Destroy(p4) -- Line: 66
    if p4.connection then
        p4.connection:Disconnect();
        p4.connection = nil;
    end;

    p4.Beam:Destroy();
    p4.A0:Destroy();
    p4.A1:Destroy();

    if p4.EndFunc then
        p4.EndFunc();
    end;
end;

return u1;