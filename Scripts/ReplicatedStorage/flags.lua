--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     flags
  Path:     game.ReplicatedStorage.Library.Imported.Conch.roblox_packages..pesde.centau_vide@0.3.1.vide.flags
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:35 2026
]]

-- Decompiled with Potassium's decompiler.

local function inline_test() -- Line: 1
    return debug.info(1, "n");
end;

return {
    batch = false,
    strict = not (debug.info(1, "n") ~= "inline_test")
};