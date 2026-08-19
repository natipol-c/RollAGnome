--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     show
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.centau_vide@0.3.1.vide.show
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:25 2026
]]

-- Decompiled with Potassium's decompiler.

if not game then
    script = require("test/relative-string");
end;

local switch = require(script.Parent.switch);

return function(u1, p2, p3) -- Line: 5, Name: show
    -- upvalues: switch (copy)
    return switch(function() -- Line: 6, Name: truthy
        -- upvalues: u1 (copy)
        return u1() and true or false;
    end)({
        [true] = p2,
        [false] = p3
    });
end;