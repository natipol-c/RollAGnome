--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     FlagUtil
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CommonUtils.FlagUtil
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:30 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    getUserFlag = function(u1) -- Line: 11, Name: getUserFlag
        local success, result = pcall(function() -- Line: 12
            -- upvalues: u1 (copy)
            return UserSettings():IsUserFeatureEnabled(u1);
        end);

        return success and result;
    end
};