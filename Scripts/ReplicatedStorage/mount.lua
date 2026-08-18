--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     mount
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.centau_vide@0.3.1.vide.mount
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:05 2026
]]

-- Decompiled with Potassium's decompiler.

if not game then
    script = require("test/relative-string");
end;

local root = require(script.Parent.root);
local apply = require(script.Parent.apply);

return function(u1, u2) -- Line: 6, Name: mount
    -- upvalues: root (copy), apply (copy)
    return root(function() -- Line: 7
        -- upvalues: u1 (copy), u2 (copy), apply (ref)
        local v3 = u1();

        if u2 then
            apply(u2, { v3 });
        end;
    end);
end;