--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Commands
  Path:     game.ReplicatedStorage.Library.Commands
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:42:59 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Network");

return {
    Initialize = function(p2) -- Line: 9, Name: Initialize
        -- upvalues: u1 (copy), Library (copy)
        if not u1:InvokeServer("ViewCommands") then
            return;
        end;

        local v3 = Library.get("Conch");
        Library.get("ConchTypes");
        v3.initiate_default_lifecycle();
        v3.ui.bind_to(Enum.KeyCode.F2);
    end
};