--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     WeatherEvents
  Path:     game.ReplicatedStorage.Library.Configs.WeatherEvents
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    EVENT_DURATION_MINUTES = 10,
    events = {
        {
            name = "Toxic",
            moduleName = "Toxic",
            mutation = "Toxic",
            icon = "rbxassetid://89783216390787",
            chatTag = "<font color=\"#62ff7f\">TOXIC</font>",
            color = Color3.fromRGB(98, 255, 127)
        },
        {
            name = "Lightning Storm",
            moduleName = "LightningStorm",
            mutation = "Charged",
            icon = "rbxassetid://133203746249649",
            chatTag = "<font color=\"#b7eeff\">LIGHTNING</font>",
            color = Color3.fromRGB(183, 238, 255)
        },
        {
            name = "Blizzard",
            moduleName = "Blizzard",
            mutation = "Frozen",
            icon = "rbxassetid://121554093470967",
            chatTag = "<font color=\"#7fcaff\">BLIZZARD</font>",
            color = Color3.fromRGB(127, 202, 255)
        },
        {
            name = "Cursed",
            moduleName = "Cursed",
            mutation = "Cursed",
            icon = "rbxassetid://93918592183528",
            chatTag = "<font color=\"#a65eff\">CURSED</font>",
            color = Color3.fromRGB(166, 94, 255)
        }
    }
};