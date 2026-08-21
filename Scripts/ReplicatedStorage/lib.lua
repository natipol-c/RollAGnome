--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     lib
  Path:     game.ReplicatedStorage.Library.Imported.Conch.lib
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:33 2026
]]

-- Decompiled with Potassium's decompiler.

local v1 = require("./roblox_packages/conch");
local v2 = {
    ui = require("./roblox_packages/ui")
};

return setmetatable(v2, {
    __index = v1
});