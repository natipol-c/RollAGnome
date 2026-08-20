--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     WeeklyDeal
  Path:     game.ReplicatedStorage.Library.Configs.WeeklyDeal
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:04 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Deal1 = {
        endTime = 1787421600,
        rewards = { {
                name = "Skip30Min",
                text = "Skip 30 Minutes"
            }, {
                name = "2xMoneyBoost",
                text = "2x Money Boost",
                duration = 1800
            }, {
                name = "4xLuckBoost",
                text = "4x Luck Boost",
                duration = 1800
            } }
    },
    Deal2 = {
        endTime = 1787421600,
        rewards = { {
                name = "Gamepass",
                text = "VIP",
                gamepassName = "VIP"
            }, {
                name = "Skip30Min",
                text = "Skip 30 Minutes"
            }, {
                name = "4xLuckBoost",
                text = "4x Luck Boost",
                duration = 1800
            } }
    }
};