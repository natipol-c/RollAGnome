--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Pets
  Path:     game.ReplicatedStorage.Library.Configs.Pets
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:04 2026
]]

-- Decompiled with Potassium's decompiler.

local Assets = require(script.Assets);
local Definitions = script.Definitions;

return {
    Dog = {
        name = "Dog",
        rarity = "Common",
        icon = "rbxassetid://83889201963668",
        desc = "Every <font color=\'#4fc0fa\'>60s-90s</font>, cuts a Gnome\'s plant time by <font color=\'#ffff00\'>10%</font>",
        rng = "1/2",
        resale_value = 0,
        price = 25000,
        order = 1,
        model = Assets.GetModel("Dog"),
        config = require(Definitions.Dog)
    },
    Cat = {
        name = "Cat",
        rarity = "Common",
        icon = "rbxassetid://103952235880547",
        desc = "Every <font color=\'#4fc0fa\'>60s-90s</font>, cuts a Gnome\'s plant time by <font color=\'#ffff00\'>15%</font>",
        rng = "1/10",
        resale_value = 0,
        price = 15000,
        order = 2,
        model = Assets.GetModel("Cat"),
        config = require(Definitions.Cat)
    },
    Bunny = {
        name = "Bunny",
        rarity = "Uncommon",
        icon = "rbxassetid://77768076392020",
        desc = "Every <font color=\'#4fc0fa\'>120s-180s</font>, cuts a Gnome\'s plant time by <font color=\'#ffff00\'>20%</font>",
        rng = "1/50",
        resale_value = 0,
        price = 35500,
        order = 3,
        range = { {
                min = 48,
                max = 50,
                weight = 70
            }, {
                min = 50,
                max = 53,
                weight = 24
            }, {
                min = 53,
                max = 56,
                weight = 5.9
            }, {
                min = 56,
                max = 60,
                weight = 0.1
            } },
        model = Assets.GetModel("Bunny"),
        config = require(Definitions.Bunny)
    },
    Cow = {
        name = "Cow",
        rarity = "Uncommon",
        icon = "rbxassetid://114756845374414",
        desc = "Every <font color=\'#4fc0fa\'>4m-5m</font>, makes a fruit <font color=\'#ffff00\'>5%</font> larger",
        rng = "1/350",
        resale_value = 0,
        price = 65500,
        order = 4,
        range = { {
                min = 295,
                max = 350,
                weight = 70
            }, {
                min = 350,
                max = 440,
                weight = 24
            }, {
                min = 440,
                max = 575,
                weight = 5.9
            }, {
                min = 575,
                max = 875,
                weight = 0.1
            } },
        model = Assets.GetModel("Cow"),
        config = require(Definitions.Cow)
    },
    Frog = {
        name = "Frog",
        rarity = "Rare",
        icon = "rbxassetid://121278629278802",
        desc = "Every <font color=\'#4fc0fa\'>3m-5m</font>, cuts plant Growth Time by <font color=\'#ffff00\'>15%</font>",
        rng = "1/2,500",
        resale_value = 0,
        price = 125000,
        order = 5,
        range = { {
                min = 2300,
                max = 2500,
                weight = 70
            }, {
                min = 2500,
                max = 2700,
                weight = 24
            }, {
                min = 2700,
                max = 3000,
                weight = 5.9
            }, {
                min = 3000,
                max = 3500,
                weight = 0.1
            } },
        model = Assets.GetModel("Frog"),
        config = require(Definitions.Frog)
    },
    Bee = {
        name = "Bee",
        rarity = "Rare",
        icon = "rbxassetid://91860110674222",
        desc = "Every <font color=\'#4fc0fa\'>3m-5m</font>, boosts a ripe fruit\'s Value by <font color=\'#ffff00\'>2.5%</font>",
        rng = "1/15,000",
        resale_value = 0,
        price = 750000,
        order = 6,
        range = { {
                min = 14250,
                max = 15000,
                weight = 70
            }, {
                min = 15000,
                max = 16500,
                weight = 24
            }, {
                min = 16500,
                max = 18500,
                weight = 5.9
            }, {
                min = 18500,
                max = 22000,
                weight = 0.1
            } },
        model = Assets.GetModel("Bee"),
        config = require(Definitions.Bee)
    },
    Turtle = {
        name = "Turtle",
        rarity = "Epic",
        icon = "rbxassetid://130067104519004",
        desc = "Every <font color=\'#4fc0fa\'>2m-3m</font>, gives a Gnome <font color=\'#ffff00\'>10%-20%</font> level XP",
        rng = "1/50,000",
        speed = 5,
        resale_value = 0,
        price = 1500000,
        order = 7,
        range = { {
                min = 47000,
                max = 50000,
                weight = 70
            }, {
                min = 50000,
                max = 56000,
                weight = 24
            }, {
                min = 56000,
                max = 65000,
                weight = 5.9
            }, {
                min = 65000,
                max = 80000,
                weight = 0.1
            } },
        model = Assets.GetModel("Turtle"),
        config = require(Definitions.Turtle)
    },
    Owl = {
        name = "Owl",
        rarity = "Epic",
        icon = "rbxassetid://102057358860293",
        desc = "Every <font color=\'#4fc0fa\'>3m-5m</font>, cuts a Gnome\'s plant time by <font color=\'#ffff00\'>75%</font>",
        rng = "1/150,000",
        resale_value = 0,
        price = 5500000,
        order = 8,
        range = { {
                min = 140000,
                max = 150000,
                weight = 70
            }, {
                min = 150000,
                max = 165000,
                weight = 24
            }, {
                min = 165000,
                max = 185000,
                weight = 5.9
            }, {
                min = 185000,
                max = 220000,
                weight = 0.1
            } },
        model = Assets.GetModel("Owl"),
        config = require(Definitions.Owl)
    },
    Pig = {
        name = "Pig",
        rarity = "Legendary",
        icon = "rbxassetid://97483832653172",
        desc = "Every <font color=\'#4fc0fa\'>4m-6m</font>, makes a fruit <font color=\'#ffff00\'>2.5%</font> bigger and <font color=\'#ffff00\'>5%</font> richer",
        rng = "1/750,000",
        resale_value = 0,
        price = 25000000,
        order = 10,
        range = { {
                min = 665000,
                max = 700000,
                weight = 70
            }, {
                min = 700000,
                max = 775000,
                weight = 24
            }, {
                min = 775000,
                max = 800000,
                weight = 5.9
            }, {
                min = 800000,
                max = 1000000,
                weight = 0.1
            } },
        model = Assets.GetModel("Pig"),
        config = require(Definitions.Pig)
    },
    Raccoon = {
        name = "Raccoon",
        rarity = "Legendary",
        icon = "rbxassetid://123983187840964",
        desc = "Every <font color=\'#4fc0fa\'>180s-300s</font>, finds <font color=\'#ffff00\'>2%-5%</font> Coins and maybe a shop item",
        rng = "1/1,500,000",
        resale_value = 0,
        price = 30000000,
        order = 11,
        range = { {
                min = 1000000,
                max = 1500000,
                weight = 70
            }, {
                min = 1500000,
                max = 2000000,
                weight = 24
            }, {
                min = 2000000,
                max = 2750000,
                weight = 5.9
            }, {
                min = 2750000,
                max = 10000000,
                weight = 0.1
            } },
        model = Assets.GetModel("Racoon"),
        config = require(Definitions.Raccoon)
    },
    Hornet = {
        name = "Hornet",
        rarity = "Mythic",
        icon = "rbxassetid://113573417845595",
        desc = "Every <font color=\'#4fc0fa\'>180s-300s</font>, cuts plant Growth Time by <font color=\'#ffff00\'>25%</font>",
        rng = "1/5,000,000",
        resale_value = 0,
        price = 60000000,
        order = 12,
        range = { {
                min = 4600000,
                max = 5000000,
                weight = 70
            }, {
                min = 5000000,
                max = 5400000,
                weight = 24
            }, {
                min = 5400000,
                max = 6000000,
                weight = 5.9
            }, {
                min = 6000000,
                max = 7000000,
                weight = 0.1
            } },
        model = Assets.GetModel("Hornet"),
        config = require(Definitions.Hornet)
    },
    Ant = {
        name = "Ant",
        rarity = "Mythic",
        icon = "rbxassetid://90429055249337",
        desc = "Every <font color=\'#4fc0fa\'>3m-5m</font>, collects a fruit with <font color=\'#ffff00\'>10%</font> Value",
        rng = "1/25,000,000",
        resale_value = 0,
        price = 90000000,
        order = 13,
        range = { {
                min = 23000000,
                max = 25000000,
                weight = 70
            }, {
                min = 25000000,
                max = 27000000,
                weight = 24
            }, {
                min = 27000000,
                max = 30000000,
                weight = 5.9
            }, {
                min = 30000000,
                max = 35000000,
                weight = 0.1
            } },
        model = Assets.GetModel("Ant"),
        config = require(Definitions.Ant)
    },
    ["Mutant Ant"] = {
        name = "Mutant Ant",
        rarity = "Godly",
        icon = "rbxassetid://90892555098576",
        desc = "Every <font color=\'#4fc0fa\'>300s</font>, collects up to <font color=\'#ffff00\'>5</font> fruits with <font color=\'#ffff00\'>95%</font> Value",
        rng = "1/10,000,000,000",
        resale_value = 0,
        price = 395000000,
        order = 14,
        range = { {
                min = 8000000000,
                max = 10000000000,
                weight = 70
            }, {
                min = 10000000000,
                max = 12000000000,
                weight = 24
            }, {
                min = 12000000000,
                max = 15000000000,
                weight = 5.9
            }, {
                min = 15000000000,
                max = 100000000000,
                weight = 0.1
            } },
        model = Assets.GetModel("Mutant Ant"),
        config = require(Definitions["Mutant Ant"])
    },
    ["Mutant Bee"] = {
        name = "Mutant Bee",
        rarity = "IMPOSSIBLE",
        icon = "rbxassetid://115393587645802",
        desc = "Every <font color=\'#4fc0fa\'>300s-600s</font>, gives a fruit a Mutation and <font color=\'#ffff00\'>100%</font> Value",
        rng = "1/50,000,000,000",
        resale_value = 0,
        price = 1000000000,
        order = 15,
        range = { {
                min = 40000000000,
                max = 50000000000,
                weight = 70
            }, {
                min = 50000000000,
                max = 60000000000,
                weight = 24
            }, {
                min = 60000000000,
                max = 75000000000,
                weight = 5.9
            }, {
                min = 75000000000,
                max = 500000000000,
                weight = 0.1
            } },
        model = Assets.GetModel("Mutant Bee"),
        config = require(Definitions["Mutant Bee"])
    }
};