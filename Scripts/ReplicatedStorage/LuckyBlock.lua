--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     LuckyBlock
  Path:     game.ReplicatedStorage.Library.Configs.ConchTypes.LuckyBlock
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

for i, v in Library.get("Lucky Blocks") do
    if typeof(v) == "table" and v.name then
        v2[`{v.name} ({i})`] = i;
    end;
end;

return v1.register_type("LuckyBlock", v1.args.enum_map(v2));