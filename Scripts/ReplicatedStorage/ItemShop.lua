--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ItemShop
  Path:     game.ReplicatedStorage.Library.Configs.ItemShop
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:31 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Items = {
        ["Basic Sprinkler"] = {
            name = "Basic Sprinkler",
            rarity = "Rare",
            desc = "<font color=\'#ffff00\'>1.25x</font> Crop Growth Speed (2min)",
            type = "Sprinkler",
            minStock = 1,
            maxStock = 4,
            price = 2000,
            chanceInStock = 100,
            order = 1
        },
        ["Golden Sprinkler"] = {
            name = "Golden Sprinkler",
            rarity = "Rare",
            desc = "<font color=\'#ffff00\'>1.75x</font> Crop Growth Speed (3min)",
            type = "Sprinkler",
            minStock = 1,
            maxStock = 3,
            price = 7500,
            chanceInStock = 50,
            order = 2
        },
        ["Basic Watering Can"] = {
            name = "Basic Watering Can",
            rarity = "Rare",
            desc = "Reducing growth time by <font color=\'#ffff00\'>10%</font>",
            type = "WateringCan",
            minStock = 1,
            maxStock = 3,
            price = 17500,
            chanceInStock = 40,
            order = 3
        },
        Fertilizer = {
            name = "Fertilizer",
            rarity = "Epic",
            desc = "Influences Size by up to <font color=\'#37ff00\'>100%</font> (3min)",
            type = "Fertilizer",
            minStock = 1,
            maxStock = 2,
            price = 14500,
            chanceInStock = 35,
            order = 4
        },
        ["Gnome Coffee"] = {
            name = "Gnome Coffee",
            rarity = "Legendary",
            desc = "Gnomes plant <font color=\'#ffff00\'>50%</font> faster (3min)",
            type = "GnomeItem",
            minStock = 1,
            maxStock = 2,
            price = 5000,
            chanceInStock = 25,
            order = 5
        },
        ["Gold Watering Can"] = {
            name = "Gold Watering Can",
            rarity = "Legendary",
            desc = "Reducing growth time by <font color=\'#ffff00\'>25%</font>",
            type = "WateringCan",
            minStock = 1,
            maxStock = 2,
            price = 119000,
            chanceInStock = 20,
            order = 6
        },
        ["Good Fertilizer"] = {
            name = "Good Fertilizer",
            rarity = "Epic",
            desc = "Influences Size by up to <font color=\'#37ff00\'>300%</font> (3min)",
            type = "Fertilizer",
            minStock = 1,
            maxStock = 2,
            price = 32500,
            chanceInStock = 15,
            order = 7
        },
        ["Mutation Mister"] = {
            name = "Mutation Mister",
            rarity = "Legendary",
            desc = "Increases Mutation Odds by up to <font color=\'#37ff00\'>300%</font> (5min)",
            type = "Sprinkler",
            minStock = 1,
            maxStock = 1,
            price = 49500,
            chanceInStock = 10,
            order = 8
        }
    },
    Settings = {
        RestockDuration = 300,
        MinShopItems = 2,
        MaxShopItems = 3
    }
};