--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Zone
  Path:     game.ReplicatedStorage.Library.Configs.ConchTypes.Zone
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:23 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Library = require(ReplicatedStorage.Library);
local v1 = Library.get("Conch");
local v2 = {};

for i in Library.get("Zones") do
    v2[i] = i;
end;

return v1.register_type("Zone", v1.args.enum_map(v2));