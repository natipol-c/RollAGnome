--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Farmers
  Path:     game.ReplicatedStorage.Library.Configs.Farmers
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:04 2026
]]

-- Decompiled with Potassium's decompiler.

local Farmers = game:GetService("ReplicatedStorage").Assets.Farmers;

return {
    ["Carrot Gnome"] = {
        icon = "rbxassetid://94728431042454",
        plant = "Carrot",
        rarity = "1/2",
        real_rarity = "Common",
        price = 5,
        order = 1,
        model = Farmers["Carrot Gnome"],
        plant_duration = { 2, 3 }
    },
    ["Corn Gnome"] = {
        icon = "rbxassetid://134803275162130",
        plant = "Corn Stalk",
        rarity = "1/3",
        real_rarity = "Common",
        price = 10,
        order = 2,
        model = Farmers["Corn Gnome"],
        plant_duration = { 3, 5 }
    },
    ["Strawberry Gnome"] = {
        icon = "rbxassetid://82437197838481",
        plant = "Strawberry Bush",
        rarity = "1/10",
        real_rarity = "Common",
        price = 25,
        order = 3,
        model = Farmers["Strawberry Gnome"],
        plant_duration = { 8, 12 }
    },
    ["Pumpkin Gnome"] = {
        icon = "rbxassetid://101606142443350",
        plant = "Pumpkin Patch",
        rarity = "1/10",
        real_rarity = "Common",
        price = 40,
        order = 4,
        model = Farmers["Pumpkin Gnome"],
        plant_duration = { 10, 15 }
    },
    ["Watermelon Gnome"] = {
        icon = "rbxassetid://126791458709030",
        plant = "Watermelon Patch",
        rarity = "1/25",
        real_rarity = "Common",
        price = 200,
        order = 5,
        model = Farmers["Watermelon Gnome"],
        plant_duration = { 14, 20 }
    },
    ["Pineapple Gnome"] = {
        icon = "rbxassetid://112004411887489",
        plant = "Pineapple Plant",
        rarity = "1/50",
        real_rarity = "Common",
        price = 500,
        order = 6,
        model = Farmers["Pineapple Gnome"],
        plant_duration = { 18, 28 },
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
            } }
    },
    ["Cabbage Gnome"] = {
        icon = "rbxassetid://72872327855999",
        plant = "Cabbage",
        rarity = "1/75",
        real_rarity = "Common",
        price = 285,
        order = 7,
        model = Farmers["Cabbage Gnome"],
        plant_duration = { 24, 35 },
        range = { {
                min = 72,
                max = 75,
                weight = 70
            }, {
                min = 75,
                max = 80,
                weight = 24
            }, {
                min = 80,
                max = 84,
                weight = 5.9
            }, {
                min = 84,
                max = 90,
                weight = 0.1
            } }
    },
    ["Pear Gnome"] = {
        icon = "rbxassetid://108453504630505",
        plant = "Pear Tree",
        rarity = "1/100",
        real_rarity = "Common",
        price = 325,
        order = 8,
        model = Farmers["Pear Gnome"],
        plant_duration = { 28, 38 },
        range = { {
                min = 96,
                max = 100,
                weight = 70
            }, {
                min = 100,
                max = 106,
                weight = 24
            }, {
                min = 106,
                max = 112,
                weight = 5.9
            }, {
                min = 112,
                max = 120,
                weight = 0.1
            } }
    },
    ["Grape Gnome"] = {
        icon = "rbxassetid://109456372018118",
        plant = "Grape Vine",
        rarity = "1/125",
        real_rarity = "Common",
        price = 375,
        order = 9,
        model = Farmers["Grape Gnome"],
        plant_duration = { 32, 42 },
        range = { {
                min = 120,
                max = 125,
                weight = 70
            }, {
                min = 125,
                max = 133,
                weight = 24
            }, {
                min = 133,
                max = 140,
                weight = 5.9
            }, {
                min = 140,
                max = 150,
                weight = 0.1
            } }
    },
    ["Blueberry Gnome"] = {
        icon = "rbxassetid://78767569939536",
        plant = "Blueberry Bush",
        rarity = "1/150",
        real_rarity = "Common",
        price = 400,
        order = 10,
        model = Farmers["Blueberry Gnome"],
        plant_duration = { 36, 46 },
        range = { {
                min = 144,
                max = 150,
                weight = 70
            }, {
                min = 150,
                max = 159,
                weight = 24
            }, {
                min = 159,
                max = 168,
                weight = 5.9
            }, {
                min = 168,
                max = 180,
                weight = 0.1
            } }
    },
    ["Avocado Gnome"] = {
        icon = "rbxassetid://137490153572680",
        plant = "Avocado Tree",
        rarity = "1/200",
        real_rarity = "Common",
        price = 500,
        order = 11,
        model = Farmers["Avocado Gnome"],
        plant_duration = { 40, 50 },
        range = { {
                min = 180,
                max = 200,
                weight = 70
            }, {
                min = 200,
                max = 230,
                weight = 24
            }, {
                min = 230,
                max = 270,
                weight = 5.9
            }, {
                min = 270,
                max = 400,
                weight = 0.1
            } }
    },
    ["Pepper Gnome"] = {
        icon = "rbxassetid://110935225530101",
        plant = "Pepper Plant",
        rarity = "1/250",
        real_rarity = "Common",
        price = 600,
        order = 12,
        model = Farmers["Pepper Gnome"],
        plant_duration = { 44, 55 },
        range = { {
                min = 210,
                max = 250,
                weight = 70
            }, {
                min = 250,
                max = 315,
                weight = 24
            }, {
                min = 315,
                max = 410,
                weight = 5.9
            }, {
                min = 410,
                max = 625,
                weight = 0.1
            } }
    },
    ["Cherry Blossom Gnome"] = {
        icon = "rbxassetid://125705409134514",
        plant = "Cherry Blossom",
        rarity = "1/350",
        real_rarity = "Uncommon",
        price = 700,
        order = 13,
        model = Farmers["Cherry Blossom Gnome"],
        plant_duration = { 48, 60 },
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
            } }
    },
    ["Banana Gnome"] = {
        icon = "rbxassetid://120403948937224",
        plant = "Banana Tree",
        rarity = "1/500",
        real_rarity = "Uncommon",
        price = 2500,
        order = 14,
        model = Farmers["Banana Gnome"],
        plant_duration = { 52, 65 },
        range = { {
                min = 480,
                max = 500,
                weight = 70
            }, {
                min = 500,
                max = 530,
                weight = 24
            }, {
                min = 530,
                max = 565,
                weight = 5.9
            }, {
                min = 565,
                max = 600,
                weight = 0.1
            } }
    },
    ["Peach Gnome"] = {
        icon = "rbxassetid://80586744336944",
        plant = "Peach Tree",
        rarity = "1/1,000",
        real_rarity = "Uncommon",
        price = 3250,
        order = 15,
        model = Farmers["Peach Gnome"],
        plant_duration = { 56, 65 },
        range = { {
                min = 850,
                max = 1000,
                weight = 70
            }, {
                min = 1000,
                max = 1300,
                weight = 24
            }, {
                min = 1300,
                max = 1700,
                weight = 5.9
            }, {
                min = 1700,
                max = 2500,
                weight = 0.1
            } }
    },
    ["Kiwi Gnome"] = {
        icon = "rbxassetid://103662258783961",
        plant = "Kiwi Tree",
        rarity = "1/1,500",
        real_rarity = "Uncommon",
        price = 4250,
        order = 16,
        model = Farmers["Kiwi Gnome"],
        plant_duration = { 55, 70 },
        range = { {
                min = 1275,
                max = 1500,
                weight = 70
            }, {
                min = 1500,
                max = 1950,
                weight = 24
            }, {
                min = 1950,
                max = 2550,
                weight = 5.9
            }, {
                min = 2550,
                max = 3750,
                weight = 0.1
            } }
    },
    ["Coconut Gnome"] = {
        icon = "rbxassetid://105194046626388",
        plant = "Coconut Tree",
        rarity = "1/2,500",
        real_rarity = "Uncommon",
        price = 5000,
        order = 17,
        model = Farmers["Coconut Gnome"],
        plant_duration = { 60, 75 },
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
            } }
    },
    ["Mango Gnome"] = {
        icon = "rbxassetid://99305897616534",
        plant = "Mango Tree",
        rarity = "1/5,000",
        real_rarity = "Rare",
        price = 10000,
        order = 18,
        model = Farmers["Mango Gnome"],
        plant_duration = { 70, 80 },
        range = { {
                min = 4750,
                max = 5000,
                weight = 70
            }, {
                min = 5000,
                max = 5400,
                weight = 24
            }, {
                min = 5400,
                max = 6000,
                weight = 5.9
            }, {
                min = 6000,
                max = 7000,
                weight = 0.1
            } }
    },
    ["Lemon Gnome"] = {
        icon = "rbxassetid://124435131215557",
        plant = "Lemon Tree",
        rarity = "1/7,500",
        real_rarity = "Rare",
        price = 12500,
        order = 19,
        model = Farmers["Lemon Gnome"],
        plant_duration = { 75, 90 },
        range = { {
                min = 6900,
                max = 7500,
                weight = 70
            }, {
                min = 7500,
                max = 8100,
                weight = 24
            }, {
                min = 8100,
                max = 9000,
                weight = 5.9
            }, {
                min = 9000,
                max = 10500,
                weight = 0.1
            } }
    },
    ["Apple Gnome"] = {
        icon = "rbxassetid://79522720122339",
        plant = "Apple Tree",
        rarity = "1/10,000",
        real_rarity = "Rare",
        price = 15000,
        order = 20,
        model = Farmers["Apple Gnome"],
        plant_duration = { 80, 95 },
        range = { {
                min = 9500,
                max = 10000,
                weight = 70
            }, {
                min = 10000,
                max = 11000,
                weight = 24
            }, {
                min = 11000,
                max = 12500,
                weight = 5.9
            }, {
                min = 12500,
                max = 15000,
                weight = 0.1
            } }
    },
    ["Dragonfruit Gnome"] = {
        icon = "rbxassetid://118236627007000",
        plant = "Dragonfruit Tree",
        rarity = "1/15,000",
        real_rarity = "Rare",
        price = 18500,
        order = 21,
        model = Farmers["Dragonfruit Gnome"],
        plant_duration = { 85, 105 },
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
            } }
    },
    ["Pomegranate Gnome"] = {
        icon = "rbxassetid://119883772020840",
        plant = "Pomegranate Tree",
        rarity = "1/20,000",
        real_rarity = "Rare",
        price = 24500,
        order = 22,
        model = Farmers["Pomegranate Gnome"],
        plant_duration = { 90, 110 },
        range = { {
                min = 18400,
                max = 20000,
                weight = 70
            }, {
                min = 20000,
                max = 21600,
                weight = 24
            }, {
                min = 21600,
                max = 24000,
                weight = 5.9
            }, {
                min = 24000,
                max = 28000,
                weight = 0.1
            } }
    },
    ["Starfruit Gnome"] = {
        icon = "rbxassetid://100742773079847",
        plant = "Starfruit Tree",
        rarity = "1/25,000",
        real_rarity = "Epic",
        price = 30000,
        order = 23,
        model = Farmers["Starfruit Gnome"],
        plant_duration = { 95, 115 },
        range = { {
                min = 23500,
                max = 25000,
                weight = 70
            }, {
                min = 25000,
                max = 27500,
                weight = 24
            }, {
                min = 27500,
                max = 31500,
                weight = 5.9
            }, {
                min = 31500,
                max = 37500,
                weight = 0.1
            } }
    },
    ["Jackfruit Gnome"] = {
        icon = "rbxassetid://82000783887803",
        plant = "Jackfruit Tree",
        rarity = "1/50,000",
        real_rarity = "Epic",
        price = 50000,
        order = 24,
        model = Farmers["Jackfruit Gnome"],
        plant_duration = { 100, 120 },
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
            } }
    },
    ["Blood Orange Gnome"] = {
        icon = "rbxassetid://112008240126891",
        plant = "Blood Orange Tree",
        rarity = "1/75,000",
        real_rarity = "Epic",
        price = 70000,
        order = 25,
        model = Farmers["Blood Orange Gnome"],
        plant_duration = { 105, 125 },
        range = { {
                min = 70000,
                max = 75000,
                weight = 70
            }, {
                min = 75000,
                max = 85000,
                weight = 24
            }, {
                min = 85000,
                max = 100000,
                weight = 5.9
            }, {
                min = 100000,
                max = 125000,
                weight = 0.1
            } }
    },
    ["Giant Avocado Gnome"] = {
        icon = "rbxassetid://85787155101622",
        plant = "Giant Avocado Tree",
        rarity = "1/150,000",
        real_rarity = "Legendary",
        price = 300000,
        order = 26,
        model = Farmers["Giant Avocado Gnome"],
        plant_duration = { 110, 135 },
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
            } }
    },
    ["King Apple Gnome"] = {
        icon = "rbxassetid://70716674967687",
        plant = "King Apple Tree",
        rarity = "1/250,000",
        real_rarity = "Legendary",
        price = 700000,
        order = 27,
        model = Farmers["King Apple Gnome"],
        plant_duration = { 115, 140 },
        range = { {
                min = 235000,
                max = 250000,
                weight = 70
            }, {
                min = 250000,
                max = 280000,
                weight = 24
            }, {
                min = 280000,
                max = 325000,
                weight = 5.9
            }, {
                min = 325000,
                max = 400000,
                weight = 0.1
            } }
    },
    ["Giant Peach Gnome"] = {
        icon = "rbxassetid://94273723063175",
        plant = "Giant Peach Tree",
        rarity = "1/350,000",
        real_rarity = "Legendary",
        price = 1200000,
        order = 28,
        model = Farmers["Giant Peach Gnome"],
        plant_duration = { 120, 145 },
        range = { {
                min = 325000,
                max = 350000,
                weight = 70
            }, {
                min = 350000,
                max = 395000,
                weight = 24
            }, {
                min = 395000,
                max = 465000,
                weight = 5.9
            }, {
                min = 465000,
                max = 600000,
                weight = 0.1
            } }
    },
    ["Ruby Pear Gnome"] = {
        icon = "rbxassetid://88489647894843",
        plant = "Ruby Pear Tree",
        rarity = "1/500,000",
        real_rarity = "Mythic",
        price = 5000000,
        order = 29,
        model = Farmers["Ruby Pear Gnome"],
        plant_duration = { 125, 155 },
        range = { {
                min = 465000,
                max = 500000,
                weight = 70
            }, {
                min = 500000,
                max = 575000,
                weight = 24
            }, {
                min = 575000,
                max = 700000,
                weight = 5.9
            }, {
                min = 700000,
                max = 900000,
                weight = 0.1
            } }
    },
    ["Crystal Apple Gnome"] = {
        icon = "rbxassetid://86364409526227",
        plant = "Crystal Apple Tree",
        rarity = "1/750,000",
        real_rarity = "Mythic",
        price = 15000000,
        order = 30,
        model = Farmers["Crystal Apple Gnome"],
        plant_duration = { 130, 160 },
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
            } }
    },
    ["Frost Gnome"] = {
        icon = "rbxassetid://125705956840662",
        plant = "Frost Pear Tree",
        rarity = "1/1,500,000",
        real_rarity = "Mythic",
        price = 25000000,
        order = 31,
        model = Farmers["Frost Gnome"],
        plant_duration = { 140, 170 },
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
            } }
    },
    ["Celestial Starfruit Gnome"] = {
        icon = "rbxassetid://96134363819709",
        plant = "Celestial Starfruit Tree",
        rarity = "1/2,000,000",
        real_rarity = "Mythic",
        price = 25000000,
        order = 32,
        model = Farmers["Celestial Starfruit Gnome"],
        plant_duration = { 145, 175 },
        range = { {
                min = 1600000,
                max = 2000000,
                weight = 70
            }, {
                min = 2000000,
                max = 2400000,
                weight = 24
            }, {
                min = 2400000,
                max = 3000000,
                weight = 5.9
            }, {
                min = 3000000,
                max = 20000000,
                weight = 0.1
            } }
    },
    ["Ghost Gnome"] = {
        icon = "rbxassetid://100807506722310",
        plant = "Ghost Tree",
        rarity = "1/5,000,000",
        real_rarity = "Mythic",
        price = 35000000,
        order = 1,
        filter = "Night",
        model = Farmers["Ghost Gnome"],
        plant_duration = { 150, 180 },
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
            } }
    },
    ["Comet Gnome"] = {
        icon = "rbxassetid://129947610640382",
        plant = "Comet Tree",
        rarity = "1/15,000,000",
        real_rarity = "Mythic",
        price = 45000000,
        order = 2,
        filter = "Night",
        model = Farmers["Comet Gnome"],
        plant_duration = { 155, 185 },
        range = { {
                min = 13800000,
                max = 15000000,
                weight = 70
            }, {
                min = 15000000,
                max = 16200000,
                weight = 24
            }, {
                min = 16200000,
                max = 18000000,
                weight = 5.9
            }, {
                min = 18000000,
                max = 21000000,
                weight = 0.1
            } }
    },
    ["Moon Gnome"] = {
        icon = "rbxassetid://112086184191096",
        plant = "Moonfruit Tree",
        rarity = "1/2,500,000",
        real_rarity = "Godly",
        price = 50000000,
        order = 33,
        model = Farmers["Moon Gnome"],
        plant_duration = { 160, 190 },
        range = { {
                min = 2000000,
                max = 2500000,
                weight = 70
            }, {
                min = 2500000,
                max = 3000000,
                weight = 24
            }, {
                min = 3000000,
                max = 3750000,
                weight = 5.9
            }, {
                min = 3750000,
                max = 25000000,
                weight = 0.1
            } }
    },
    ["Rainbow Mango Gnome"] = {
        icon = "rbxassetid://85866624457205",
        plant = "Rainbow Mango Tree",
        rarity = "1/25,000,000",
        real_rarity = "Godly",
        price = 75000000,
        order = 34,
        model = Farmers["Rainbow Mango Gnome"],
        plant_duration = { 165, 195 },
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
            } }
    },
    ["Shadow Gnome"] = {
        icon = "rbxassetid://121969243910714",
        plant = "Shadow Shroom",
        rarity = "1/50,000,000",
        real_rarity = "Godly",
        price = 80000000,
        order = 3,
        filter = "Night",
        model = Farmers["Shadow Gnome"],
        plant_duration = { 170, 200 },
        range = { {
                min = 46000000,
                max = 50000000,
                weight = 70
            }, {
                min = 50000000,
                max = 54000000,
                weight = 24
            }, {
                min = 54000000,
                max = 60000000,
                weight = 5.9
            }, {
                min = 60000000,
                max = 70000000,
                weight = 0.1
            } }
    },
    ["Eclipse Gnome"] = {
        icon = "rbxassetid://120721340042522",
        plant = "Eclipse Plant",
        rarity = "1/100,000,000",
        real_rarity = "Godly",
        price = 150000000,
        order = 4,
        filter = "Night",
        model = Farmers["Eclipse Gnome"],
        plant_duration = { 175, 205 },
        range = { {
                min = 92000000,
                max = 100000000,
                weight = 70
            }, {
                min = 100000000,
                max = 108000000,
                weight = 24
            }, {
                min = 108000000,
                max = 120000000,
                weight = 5.9
            }, {
                min = 120000000,
                max = 140000000,
                weight = 0.1
            } }
    },
    ["Sun Gnome"] = {
        icon = "rbxassetid://71766756276088",
        plant = "Sunfruit Tree",
        rarity = "1/10,000,000,000",
        real_rarity = "IMPOSSIBLE",
        price = 250000000,
        order = 35,
        model = Farmers["Sun Gnome"],
        plant_duration = { 180, 215 },
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
            } }
    },
    ["Celestial Peach Gnome"] = {
        icon = "rbxassetid://140068742452279",
        plant = "Celestial Peach Tree",
        rarity = "1/50,000,000,000",
        real_rarity = "IMPOSSIBLE",
        price = 350000000,
        order = 36,
        model = Farmers["Celestial Peach Gnome"],
        plant_duration = { 185, 225 },
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
            } }
    },
    ["Lightning Gnome"] = {
        icon = "rbxassetid://124829917631238",
        plant = "Lightning Tree",
        rarity = "1/100,000,000,000",
        real_rarity = "IMPOSSIBLE",
        price = 500000000,
        order = 37,
        model = Farmers["Lightning Gnome"],
        plant_duration = { 195, 235 },
        range = { {
                min = 80000000000,
                max = 100000000000,
                weight = 70
            }, {
                min = 100000000000,
                max = 120000000000,
                weight = 24
            }, {
                min = 120000000000,
                max = 150000000000,
                weight = 5.9
            }, {
                min = 150000000000,
                max = 1000000000000,
                weight = 0.1
            } }
    },
    ["Galaxy Gnome"] = {
        icon = "rbxassetid://105533584170579",
        plant = "Galaxy Tree",
        rarity = "1/500,000,000,000",
        real_rarity = "IMPOSSIBLE",
        price = 700000000,
        order = 38,
        model = Farmers["Galaxy Gnome"],
        plant_duration = { 205, 245 },
        range = { {
                min = 400000000000,
                max = 500000000000,
                weight = 70
            }, {
                min = 500000000000,
                max = 600000000000,
                weight = 24
            }, {
                min = 600000000000,
                max = 750000000000,
                weight = 5.9
            }, {
                min = 750000000000,
                max = 5000000000000,
                weight = 0.1
            } }
    },
    ["X Gnome"] = {
        icon = "rbxassetid://91141792067091",
        plant = "X Tree",
        rarity = "1/1,299,409,187,999",
        real_rarity = "IMPOSSIBLE",
        price = 1200000000,
        order = 39,
        model = Farmers["X Gnome"],
        plant_duration = { 215, 255 },
        range = { {
                min = 800000000000,
                max = 1000000000000,
                weight = 70
            }, {
                min = 1000000000000,
                max = 1200000000000,
                weight = 24
            }, {
                min = 1200000000000,
                max = 1500000000000,
                weight = 5.9
            }, {
                min = 1500000000000,
                max = 10000000000000,
                weight = 0.1
            } }
    },
    ["Starbush Gnome"] = {
        icon = "rbxassetid://90774878800449",
        plant = "Starbush",
        rarity = "1/2,347,189,998,451",
        real_rarity = "IMPOSSIBLE",
        price = 1200000000,
        order = 39,
        model = Farmers["Starbush Gnome"],
        plant_duration = { 225, 265 },
        range = { {
                min = 800000000000,
                max = 1000000000000,
                weight = 70
            }, {
                min = 1000000000000,
                max = 1200000000000,
                weight = 24
            }, {
                min = 1200000000000,
                max = 1500000000000,
                weight = 5.9
            }, {
                min = 1500000000000,
                max = 10000000000000,
                weight = 0.1
            } }
    },
    ["Nebula Gnome"] = {
        icon = "rbxassetid://103472778312265",
        plant = "Nebula Plant",
        rarity = "1/75,000,000,000",
        real_rarity = "IMPOSSIBLE",
        price = 435000000,
        order = 5,
        filter = "Night",
        model = Farmers["Nebula Gnome"],
        plant_duration = { 200, 235 },
        range = { {
                min = 60000000000,
                max = 75000000000,
                weight = 70
            }, {
                min = 75000000000,
                max = 90000000000,
                weight = 24
            }, {
                min = 90000000000,
                max = 112500000000,
                weight = 5.9
            }, {
                min = 112500000000,
                max = 750000000000,
                weight = 0.1
            } }
    }
};