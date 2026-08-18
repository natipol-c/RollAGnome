--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     EventCurrency
  Path:     game.ReplicatedStorage.Library.Configs.ConchTypes.EventCurrency
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:04 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Library = require(ReplicatedStorage.Library);
local v1 = Library.get("Conch");
local v2 = {};

for i, v in Library.get("EventCurrency") do
    if typeof(v) == "table" then
        v2[`{v.name or i} ({i})`] = i;
    end;
end;

return v1.register_type("EventCurrency", v1.args.enum_map(v2));