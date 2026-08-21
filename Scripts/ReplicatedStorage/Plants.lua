--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Plants
  Path:     game.ReplicatedStorage.Library.Configs.Plants
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:30 2026
]]

-- Decompiled with Potassium's decompiler.

local Assets = game:GetService("ReplicatedStorage").Assets;
local Plants = Assets.Plants;
local Fruit = Assets.Fruit;

return {
    Carrot = {
        icon = "rbxassetid://124354341531555",
        growth_time = 5,
        sell_price = 15,
        weight = 0.5,
        order = 1,
        model = Plants.Carrot
    },
    ["Corn Stalk"] = {
        icon = "",
        plant_radius = 1,
        growth_time = 5,
        sell_price = 45,
        weight = 1,
        order = 2,
        model = Plants["Corn Stalk"],
        fruit = {
            name = "Corn",
            icon = "rbxassetid://110614263973874",
            growth_time = 10,
            model = Fruit.Corn
        }
    },
    ["Strawberry Bush"] = {
        icon = "",
        plant_radius = 2,
        growth_time = 10,
        sell_price = 90,
        weight = 0.2,
        order = 3,
        model = Plants["Strawberry Bush"],
        fruit = {
            name = "Strawberry",
            icon = "rbxassetid://102186705414897",
            growth_time = 10,
            model = Fruit.Strawberry
        }
    },
    ["Pumpkin Patch"] = {
        icon = "",
        plant_radius = 2,
        growth_time = 15,
        sell_price = 180,
        weight = 3,
        order = 4,
        model = Plants["Pumpkin Patch"],
        fruit = {
            name = "Pumpkin",
            icon = "rbxassetid://91181684591511",
            growth_time = 15,
            model = Fruit.Pumpkin
        }
    },
    ["Watermelon Patch"] = {
        icon = "",
        plant_radius = 2,
        growth_time = 20,
        sell_price = 360,
        weight = 2.8,
        order = 5,
        model = Plants["Watermelon Patch"],
        fruit = {
            name = "Watermelon",
            icon = "rbxassetid://96488546923605",
            growth_time = 20,
            model = Fruit.Watermelon
        }
    },
    ["Pineapple Plant"] = {
        icon = "",
        plant_radius = 3,
        growth_time = 25,
        sell_price = 700,
        weight = 2,
        order = 6,
        model = Plants["Pineapple Plant"],
        fruit = {
            name = "Pineapple",
            icon = "rbxassetid://80648418256370",
            growth_time = 25,
            model = Fruit.Pineapple
        }
    },
    Cabbage = {
        icon = "rbxassetid://97147771668280",
        growth_time = 35,
        sell_price = 450,
        weight = 3,
        order = 7,
        model = Plants.Cabbage
    },
    ["Pear Tree"] = {
        icon = "",
        plant_radius = 1,
        growth_time = 30,
        sell_price = 500,
        weight = 2,
        order = 8,
        model = Plants["Pear Tree"],
        fruit = {
            name = "Pear",
            icon = "rbxassetid://113153002954086",
            growth_time = 25,
            model = Fruit.Pear
        }
    },
    ["Grape Vine"] = {
        icon = "",
        plant_radius = 1,
        growth_time = 30,
        sell_price = 550,
        weight = 1.5,
        order = 9,
        model = Plants["Grape Vine"],
        fruit = {
            name = "Grapes",
            icon = "rbxassetid://87301205996954",
            growth_time = 35,
            model = Fruit.Grape
        }
    },
    ["Blueberry Bush"] = {
        icon = "",
        growth_time = 40,
        sell_price = 585,
        weight = 1,
        order = 10,
        model = Plants["Blueberry Bush"],
        fruit = {
            name = "Blueberries",
            icon = "rbxassetid://136447759714128",
            growth_time = 35,
            model = Fruit.Blueberry
        }
    },
    ["Avocado Tree"] = {
        icon = "",
        plant_radius = 2,
        growth_time = 40,
        sell_price = 635,
        weight = 1,
        order = 11,
        model = Plants["Avocado Tree"],
        fruit = {
            name = "Avocado",
            icon = "rbxassetid://128243885181324",
            growth_time = 45,
            model = Fruit.Avocado
        }
    },
    ["Pepper Plant"] = {
        icon = "",
        plant_radius = 2,
        growth_time = 44,
        sell_price = 695,
        weight = 1,
        order = 12,
        model = Plants["Pepper Plant"],
        fruit = {
            name = "Pepper",
            icon = "rbxassetid://71222959543971",
            growth_time = 45,
            model = Fruit.Pepper
        }
    },
    ["Cherry Blossom"] = {
        icon = "",
        plant_radius = 2.2,
        growth_time = 45,
        sell_price = 750,
        weight = 1,
        order = 13,
        model = Plants["Cherry Blossom"],
        fruit = {
            name = "Cherry",
            icon = "rbxassetid://99984512626505",
            growth_time = 50,
            model = Fruit.Cherry
        }
    },
    ["Banana Tree"] = {
        icon = "",
        plant_radius = 2,
        growth_time = 45,
        sell_price = 800,
        weight = 1.5,
        order = 14,
        model = Plants["Banana Tree"],
        fruit = {
            name = "Banana",
            icon = "rbxassetid://101114166868505",
            growth_time = 50,
            model = Fruit.Banana
        }
    },
    ["Peach Tree"] = {
        icon = "",
        plant_radius = 2,
        growth_time = 45,
        sell_price = 875,
        weight = 1.3,
        order = 15,
        model = Plants["Peach Tree"],
        fruit = {
            name = "Peach",
            icon = "rbxassetid://134602208064688",
            growth_time = 55,
            model = Fruit.Peach
        }
    },
    ["Kiwi Tree"] = {
        icon = "",
        plant_radius = 2,
        growth_time = 45,
        sell_price = 945,
        weight = 1.6,
        order = 16,
        model = Plants["Kiwi Tree"],
        fruit = {
            name = "Kiwi",
            icon = "rbxassetid://115841036430659",
            growth_time = 55,
            model = Fruit.Kiwi
        }
    },
    ["Coconut Tree"] = {
        icon = "",
        plant_radius = 2,
        growth_time = 50,
        sell_price = 1250,
        weight = 2.2,
        order = 17,
        model = Plants["Coconut Tree"],
        fruit = {
            name = "Coconut",
            icon = "rbxassetid://101074009988919",
            growth_time = 60,
            model = Fruit.Coconut
        }
    },
    ["Mango Tree"] = {
        icon = "",
        plant_radius = 2,
        growth_time = 60,
        sell_price = 1500,
        weight = 2,
        order = 18,
        model = Plants["Mango Tree"],
        fruit = {
            name = "Mango",
            icon = "rbxassetid://90844453668072",
            growth_time = 60,
            model = Fruit.Mango
        }
    },
    ["Lemon Tree"] = {
        icon = "",
        plant_radius = 2,
        growth_time = 70,
        sell_price = 1750,
        weight = 1.6,
        order = 19,
        model = Plants["Lemon Tree"],
        fruit = {
            name = "Lemon",
            icon = "rbxassetid://73255900697503",
            growth_time = 60,
            model = Fruit.Lemon
        }
    },
    ["Apple Tree"] = {
        icon = "",
        plant_radius = 2,
        growth_time = 80,
        sell_price = 2500,
        weight = 2,
        order = 20,
        model = Plants["Apple Tree"],
        fruit = {
            name = "Apple",
            icon = "rbxassetid://80339461700809",
            growth_time = 70,
            model = Fruit.Apple
        }
    },
    ["Dragonfruit Tree"] = {
        icon = "",
        plant_radius = 4,
        growth_time = 70,
        sell_price = 3000,
        weight = 2.5,
        order = 21,
        model = Plants["Dragonfruit Tree"],
        fruit = {
            name = "Dragonfruit",
            icon = "rbxassetid://91583724680933",
            growth_time = 120,
            model = Fruit.Dragonfruit
        }
    },
    ["Pomegranate Tree"] = {
        icon = "",
        plant_radius = 3,
        growth_time = 70,
        sell_price = 6000,
        weight = 2.5,
        order = 22,
        model = Plants["Pomegranate Tree"],
        fruit = {
            name = "Pomegranate",
            icon = "rbxassetid://81883405599128",
            growth_time = 180,
            model = Fruit.Pomegranate
        }
    },
    ["Starfruit Tree"] = {
        icon = "",
        plant_radius = 3,
        growth_time = 45,
        sell_price = 12500,
        weight = 5,
        order = 23,
        model = Plants["Starfruit Tree"],
        fruit = {
            name = "Starfruit",
            icon = "rbxassetid://90206812252618",
            growth_time = 240,
            model = Fruit.Starfruit
        }
    },
    ["Jackfruit Tree"] = {
        icon = "",
        plant_radius = 4,
        growth_time = 60,
        sell_price = 16500,
        weight = 6,
        order = 24,
        model = Plants["Jackfruit Tree"],
        fruit = {
            name = "Jackfruit",
            icon = "rbxassetid://77805214248172",
            growth_time = 240,
            model = Fruit.Jackfruit
        }
    },
    ["Blood Orange Tree"] = {
        icon = "",
        plant_radius = 4,
        growth_time = 60,
        sell_price = 22500,
        weight = 7,
        order = 25,
        model = Plants["Blood Orange Tree"],
        fruit = {
            name = "Blood Orange",
            icon = "rbxassetid://72836038301037",
            growth_time = 360,
            model = Fruit["Blood Orange"]
        }
    },
    ["Giant Avocado Tree"] = {
        icon = "",
        plant_radius = 4,
        growth_time = 60,
        sell_price = 35000,
        weight = 10,
        order = 26,
        model = Plants["Giant Avocado Tree"],
        fruit = {
            name = "Giant Avocado",
            icon = "rbxassetid://70495030022635",
            growth_time = 480,
            model = Fruit["Giant Avocado"]
        }
    },
    ["King Apple Tree"] = {
        icon = "",
        plant_radius = 7,
        growth_time = 60,
        sell_price = 55000,
        weight = 7,
        order = 27,
        model = Plants["King Apple Tree"],
        fruit = {
            name = "King Apple",
            icon = "rbxassetid://134033939780429",
            growth_time = 540,
            model = Fruit["King Apple"]
        }
    },
    ["Giant Peach Tree"] = {
        icon = "",
        plant_radius = 7,
        growth_time = 180,
        sell_price = 65500,
        weight = 10,
        order = 28,
        model = Plants["Giant Peach Tree"],
        fruit = {
            name = "Giant Peach",
            icon = "rbxassetid://99135738528341",
            growth_time = 780,
            model = Fruit["Giant Peach"]
        }
    },
    ["Ruby Pear Tree"] = {
        icon = "",
        plant_radius = 7,
        growth_time = 120,
        sell_price = 67000,
        weight = 8,
        order = 29,
        model = Plants["Ruby Pear Tree"],
        fruit = {
            name = "Ruby Pear",
            icon = "rbxassetid://95562815168789",
            growth_time = 1020,
            model = Fruit["Ruby Pear"]
        }
    },
    ["Crystal Apple Tree"] = {
        icon = "",
        plant_radius = 7,
        growth_time = 120,
        sell_price = 100000,
        weight = 15,
        order = 30,
        model = Plants["Crystal Apple Tree"],
        fruit = {
            name = "Crystal Apple",
            icon = "rbxassetid://102381753931898",
            growth_time = 1500,
            model = Fruit["Crystal Apple"]
        }
    },
    ["Frost Pear Tree"] = {
        icon = "",
        plant_radius = 7,
        growth_time = 900,
        sell_price = 215000,
        weight = 33,
        order = 31,
        model = Plants["Frost Pear Tree"],
        fruit = {
            name = "Frost Pear",
            icon = "rbxassetid://102025419697794",
            growth_time = 1800,
            model = Fruit["Frost Pear"]
        }
    },
    ["Celestial Starfruit Tree"] = {
        icon = "",
        plant_radius = 7,
        growth_time = 1200,
        sell_price = 275000,
        weight = 18,
        order = 32,
        model = Plants["Celestial Starfruit Tree"],
        fruit = {
            name = "Celestial Starfruit",
            icon = "rbxassetid://140194071835173",
            growth_time = 1800,
            model = Fruit["Celestial Starfruit"]
        }
    },
    ["Ghost Tree"] = {
        icon = "",
        plant_radius = 5,
        growth_time = 1200,
        sell_price = 300000,
        weight = 5,
        order = 33,
        filter = "Night",
        model = Plants["Ghost Tree"],
        fruit = {
            name = "Ghost Apple",
            icon = "rbxassetid://86159979020863",
            growth_time = 1800,
            model = Fruit["Ghost Apple"]
        }
    },
    ["Comet Tree"] = {
        icon = "",
        plant_radius = 3,
        growth_time = 1200,
        sell_price = 325000,
        weight = 50,
        order = 34,
        filter = "Night",
        model = Plants["Comet Tree"],
        fruit = {
            name = "Comet",
            icon = "rbxassetid://107743796728698",
            growth_time = 1800,
            model = Fruit.Comet
        }
    },
    ["Moonfruit Tree"] = {
        icon = "",
        plant_radius = 7,
        growth_time = 600,
        sell_price = 375000,
        weight = 25,
        order = 35,
        model = Plants["Moonfruit Tree"],
        fruit = {
            name = "Moonfruit",
            icon = "rbxassetid://93378899018970",
            growth_time = 3000,
            model = Fruit.Moonfruit
        }
    },
    ["Rainbow Mango Tree"] = {
        icon = "",
        plant_radius = 7,
        growth_time = 900,
        sell_price = 395000,
        weight = 25,
        order = 36,
        model = Plants["Rainbow Mango Tree"],
        fruit = {
            name = "Rainbow Mango",
            icon = "rbxassetid://77997311340960",
            growth_time = 3600,
            model = Fruit["Rainbow Mango"]
        }
    },
    ["Shadow Shroom"] = {
        icon = "rbxassetid://89401351818621",
        growth_time = 4500,
        sell_price = 415000,
        weight = 23,
        order = 37,
        filter = "Night",
        model = Plants["Shadow Shroom"]
    },
    ["Eclipse Plant"] = {
        icon = "",
        plant_radius = 5,
        growth_time = 1500,
        sell_price = 750000,
        weight = 80,
        order = 38,
        filter = "Night",
        model = Plants["Eclipse Plant"],
        fruit = {
            name = "Eclipse",
            icon = "rbxassetid://87725114311632",
            growth_time = 3000,
            model = Fruit.Eclipse
        }
    },
    ["Sunfruit Tree"] = {
        icon = "",
        plant_radius = 7,
        growth_time = 2400,
        sell_price = 750000,
        weight = 30,
        order = 39,
        model = Plants["Sunfruit Tree"],
        fruit = {
            name = "Sunfruit",
            icon = "rbxassetid://103536280838463",
            growth_time = 2400,
            model = Fruit.Sunfruit
        }
    },
    ["Celestial Peach Tree"] = {
        icon = "",
        plant_radius = 7,
        growth_time = 1800,
        sell_price = 825000,
        weight = 40,
        order = 40,
        model = Plants["Celestial Peach Tree"],
        fruit = {
            name = "Celestial Peach",
            icon = "rbxassetid://117512918056438",
            growth_time = 3600,
            model = Fruit["Celestial Peach"]
        }
    },
    ["Nebula Plant"] = {
        icon = "",
        plant_radius = 5,
        growth_time = 3600,
        sell_price = 1000000,
        weight = 120,
        order = 41,
        filter = "Night",
        model = Plants["Nebula Plant"],
        fruit = {
            name = "Nebula",
            icon = "rbxassetid://112789797454453",
            growth_time = 3600,
            model = Fruit.Nebula
        }
    },
    ["Lightning Tree"] = {
        icon = "",
        plant_radius = 8,
        growth_time = 6000,
        sell_price = 1250000,
        weight = 55,
        order = 42,
        model = Plants["Lightning Tree"],
        fruit = {
            name = "Lightning Fruit",
            icon = "rbxassetid://102931908671497",
            growth_time = 3600,
            model = Fruit["Lightning Fruit"]
        }
    },
    ["Galaxy Tree"] = {
        icon = "",
        plant_radius = 6,
        growth_time = 6600,
        sell_price = 1500000,
        weight = 80,
        order = 43,
        model = Plants["Galaxy Tree"],
        fruit = {
            name = "Galaxy Fruit",
            icon = "rbxassetid://74587928181896",
            growth_time = 4200,
            model = Fruit["Galaxy Fruit"]
        }
    },
    ["X Tree"] = {
        icon = "",
        plant_radius = 6,
        growth_time = 6600,
        sell_price = 2500000,
        weight = 80,
        order = 44,
        model = Plants["X Tree"],
        fruit = {
            name = "X Fruit",
            icon = "rbxassetid://93344944179768",
            growth_time = 4200,
            model = Fruit["X Fruit"]
        }
    },
    Starbush = {
        icon = "",
        plant_radius = 6,
        growth_time = 7200,
        sell_price = 3550000,
        weight = 80,
        order = 45,
        model = Plants.Starbush,
        fruit = {
            name = "Starbush Fruit",
            icon = "rbxassetid://116939767530933",
            growth_time = 4800,
            model = Fruit["Starbush Fruit"]
        }
    }
};