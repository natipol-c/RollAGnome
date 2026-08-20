--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     changed
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.centau_vide@0.3.1.vide.changed
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:02 2026
]]

-- Decompiled with Potassium's decompiler.

if not game then
    script = require("test/relative-string");
end;

local u1 = require(script.Parent.action)();
local cleanup = require(script.Parent.cleanup);

return function(u2, u3) -- Line: 6, Name: changed
    -- upvalues: u1 (copy), cleanup (copy)
    return u1(function(u4) -- Line: 7
        -- upvalues: u2 (copy), u3 (copy), cleanup (ref)
        local u5 = u4:GetPropertyChangedSignal(u2):Connect(function() -- Line: 8
            -- upvalues: u3 (ref), u4 (copy), u2 (ref)
            u3(u4[u2]);
        end);
        cleanup(function() -- Line: 12
            -- upvalues: u5 (copy)
            u5:Disconnect();
        end);
        u3(u4[u2]);
    end);
end;