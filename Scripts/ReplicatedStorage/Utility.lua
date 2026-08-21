--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Utility
  Path:     game.ReplicatedStorage.Library.Configs.ConchTypes.Utility
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:31 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Library = require(ReplicatedStorage.Library);
local v1 = Library.get("Conch");
local v2 = {};

for i, v in Library.get("UtilityItems") do
    if typeof(v) == "table" and v.name then
        v2[i] = v.name;
    end;
end;

return v1.register_type("Utility", v1.args.enum_new(v2));