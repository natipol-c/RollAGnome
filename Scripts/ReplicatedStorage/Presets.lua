--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Presets
  Path:     game.ReplicatedStorage.Library.Imported.EasyVisuals.Presets
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:04 2026
]]

-- Decompiled with Potassium's decompiler.

local v1 = {};

for _, descendant in script:GetDescendants() do
    if descendant:IsA("ModuleScript") then
        v1[descendant.Name] = require(descendant);
    end;
end;

return v1;