--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     observeCharacters
  Path:     game.ReplicatedStorage.Library.Imported.Observers.observeCharacters
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:00 2026
]]

-- Decompiled with Potassium's decompiler.

local observePlayer = require(script.Parent.observePlayer);
local observeCharacter = require(script.Parent.observeCharacter);

return function(u1) -- Line: 22, Name: observeCharacters
    -- upvalues: observePlayer (copy), observeCharacter (copy)
    return observePlayer(function(p2) -- Line: 23
        -- upvalues: observeCharacter (ref), u1 (copy)
        return observeCharacter(p2, u1);
    end);
end;