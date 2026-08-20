--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Attribute
  Path:     game.ReplicatedStorage.SatchelLoader.Satchel.Packages._Index.1foreverhd_topbarplus@3.3.1.topbarplus.Attribute
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:04 2026
]]

-- Decompiled with Potassium's decompiler.

task.defer(function() -- Line: 21
    local RunService = game:GetService("RunService");
    local VERSION = require(script.Parent.VERSION);
    VERSION.getAppVersion();
    VERSION.getLatestVersion();
    local _ = not VERSION.isUpToDate();
    RunService:IsStudio();
end);

return {};