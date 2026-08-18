--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Upgrade Tree
  Path:     game.ReplicatedStorage.Library.Configs.Upgrade Tree
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:04 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Gnomes = {
        DiamondGnomes = {
            Name = "Diamond",
            Desc = "Allows rolled gnomes to roll GOLDEN",
            Icon = "rbxassetid://90538868569226",
            Type = "DiamondGnomes",
            Set = "true",
            Price = 155000,
            Position = Vector2.new(-2, 0),
            Requires = { "GoldenGnomes" }
        },
        GnomeSpeed1 = {
            Name = "Gnome Plant Speed I",
            Icon = "rbxassetid://123246072096860",
            Type = "GnomePlantSpeed",
            Set = 1.1,
            Price = 4950000,
            Position = Vector2.new(1, 2),
            Requires = { "Rebirth3_1" }
        },
        GnomeSpeed2 = {
            Name = "Gnome Plant Speed II",
            Icon = "rbxassetid://123246072096860",
            Type = "GnomePlantSpeed",
            Set = 1.15,
            Price = 16850000,
            Position = Vector2.new(2, 3),
            Requires = { "Rebirth_Node3" }
        },
        GnomeSpeed3 = {
            Name = "Gnome Plant Speed III",
            Icon = "rbxassetid://123246072096860",
            Type = "GnomePlantSpeed",
            Set = 1.2,
            Price = 49850000,
            Position = Vector2.new(1, 4),
            Requires = { "GnomeSpeed2" }
        },
        GnomeSpeed4 = {
            Name = "Gnome Plant Speed IV",
            Icon = "rbxassetid://123246072096860",
            Type = "GnomePlantSpeed",
            Set = 1.2,
            Price = 139000000,
            Position = Vector2.new(2, 5),
            Requires = { "Rebirth_Node4" }
        },
        GnomeSpeed5 = {
            Name = "Gnome Plant Speed V",
            Icon = "rbxassetid://123246072096860",
            Type = "GnomePlantSpeed",
            Set = 1.25,
            Price = 349850000,
            Position = Vector2.new(3, 5),
            Requires = { "GnomeSpeed4" }
        },
        GnomeSpeed6 = {
            Name = "Gnome Plant Speed VI",
            Icon = "rbxassetid://123246072096860",
            Type = "GnomePlantSpeed",
            Set = 1.25,
            Price = 645800000,
            Position = Vector2.new(4, 3),
            Requires = { "Rebirth_Node5" }
        },
        GnomeXP1 = {
            Name = "Good Gnome XP I",
            Icon = "rbxassetid://90343472176471",
            Type = "OfflineGnomeXP",
            Set = 1.1,
            Price = 8500000,
            Position = Vector2.new(-1, 3),
            Requires = { "Rebirth3_1" }
        },
        GnomeXP2 = {
            Name = "Insane Gnome XP II",
            Icon = "rbxassetid://90343472176471",
            Type = "OfflineGnomeXP",
            Set = 1.1,
            Price = 24500000,
            Position = Vector2.new(-2, 5),
            Requires = { "Rebirth4_12" }
        },
        GnomeXP3 = {
            Name = "Insane Gnome XP III",
            Icon = "rbxassetid://90343472176471",
            Type = "OfflineGnomeXP",
            Set = 1.15,
            Price = 49500000,
            Position = Vector2.new(-3, 6),
            Requires = { "GnomeXP2" }
        },
        GnomeXP4 = {
            Name = "ULTRA Gnome XP IV",
            Icon = "rbxassetid://90343472176471",
            Type = "OfflineGnomeXP",
            Set = 1.2,
            Price = 169850000,
            Position = Vector2.new(-5, 6),
            Requires = { "Rebirth5_12" }
        },
        GnomeXP5 = {
            Name = "ULTRA Gnome XP V",
            Icon = "rbxassetid://90343472176471",
            Type = "OfflineGnomeXP",
            Set = 1.25,
            Price = 379850000,
            Position = Vector2.new(-5, 5),
            Requires = { "GnomeXP4" }
        },
        GnomesBack = {
            Name = "Gnomes",
            Icon = "\"\"",
            OpensPage = "Main",
            BackButton = true,
            Position = Vector2.new(0, 0),
            Requires = {}
        },
        GoldenGnomes = {
            Name = "Golden",
            Desc = "Allows rolled gnomes to roll GOLDEN",
            Icon = "rbxassetid://102046552858719",
            Type = "GoldenGnomes",
            Set = "true",
            Price = 85000,
            Position = Vector2.new(-1, 0),
            Requires = { "MutatedGnomes" }
        },
        HugeGnomes = {
            Name = "HUGE",
            Desc = "Allows rolled gnomes to roll HUGE",
            Icon = "rbxassetid://87669526635451",
            Type = "HugeGnomes",
            Set = "true",
            Price = 549000,
            Position = Vector2.new(-3, 1),
            Requires = { "DiamondGnomes" }
        },
        LRebirth_Node1 = {
            Name = "Rebirth 3 Required",
            RequiredRebirth = 3,
            Position = Vector2.new(4, -5),
            Requires = { "MutationLuck3" }
        },
        LRebirth_Node2 = {
            Name = "Rebirth 4 Required",
            RequiredRebirth = 4,
            Position = Vector2.new(6, -6),
            Requires = { "MutationLuck4" }
        },
        LRebirth_Node3 = {
            Name = "Rebirth 5 Required",
            RequiredRebirth = 5,
            Position = Vector2.new(8, -5),
            Requires = { "MutationLuck6" }
        },
        LRebirth_Node4 = {
            Name = "Rebirth 6 Required",
            RequiredRebirth = 6,
            Position = Vector2.new(6, -2),
            Requires = { "MutationLuck8" }
        },
        MutatedGnomes = {
            Name = "Mutated Gnomes",
            Desc = "Allows rolled gnomes to roll GOLDEN",
            Icon = "rbxassetid://100521396059781",
            Type = "MutatedGnomes",
            Price = 45000,
            Position = Vector2.new(1, -1),
            Requires = { "LuckIII" }
        },
        MutationLuck1 = {
            Name = "Basic Luck I",
            Icon = "rbxassetid://94949780075192",
            Type = "MutationLuck",
            Price = 92500,
            Position = Vector2.new(2, -2),
            Requires = { "MutatedGnomes" }
        },
        MutationLuck12 = {
            Name = "Luck I",
            Icon = "rbxassetid://138363228547583",
            Type = "MutationLuck",
            Price = 519000,
            Position = Vector2.new(-4, 2),
            Requires = { "HugeGnomes" }
        },
        MutationLuck122 = {
            Name = "Luck I",
            Icon = "rbxassetid://138363228547583",
            Type = "MutationLuck",
            Price = 275000,
            Position = Vector2.new(-2, -1),
            Requires = { "DiamondGnomes" }
        },
        MutationLuck2 = {
            Name = "Basic Luck II",
            Icon = "rbxassetid://94949780075192",
            Type = "MutationLuck",
            Price = 495000,
            Position = Vector2.new(2, -3),
            Requires = { "MutationLuck1" }
        },
        MutationLuck22 = {
            Name = "Luck II",
            Icon = "rbxassetid://138363228547583",
            Type = "MutationLuck",
            Price = 1149000,
            Position = Vector2.new(-5, 2),
            Requires = { "MutationLuck12" }
        },
        MutationLuck222 = {
            Name = "Luck II",
            Icon = "rbxassetid://138363228547583",
            Type = "MutationLuck",
            Price = 695000,
            Position = Vector2.new(-1, -2),
            Requires = { "MutationLuck122" }
        },
        MutationLuck3 = {
            Name = "Basic Luck III",
            Icon = "rbxassetid://94949780075192",
            Type = "MutationLuck",
            Price = 895000,
            Position = Vector2.new(3, -4),
            Requires = { "MutationLuck2" }
        },
        MutationLuck4 = {
            Name = "Better Mutation Luck I",
            Icon = "rbxassetid://94949780075192",
            Type = "MutationLuck",
            Price = 3495000,
            Position = Vector2.new(5, -6),
            Requires = { "LRebirth_Node1" }
        },
        MutationLuck5 = {
            Name = "Better Mutation Luck II",
            Icon = "rbxassetid://94949780075192",
            Type = "MutationLuck",
            Price = 14650000,
            Position = Vector2.new(7, -6),
            Requires = { "LRebirth_Node2" }
        },
        MutationLuck6 = {
            Name = "Better Mutation Luck III",
            Icon = "rbxassetid://94949780075192",
            Type = "MutationLuck",
            Price = 32850000,
            Position = Vector2.new(8, -6),
            Requires = { "MutationLuck5" }
        },
        MutationLuck7 = {
            Name = "INSANE Mutation Luck IV",
            Icon = "rbxassetid://94949780075192",
            Type = "MutationLuck",
            Price = 97850000,
            Position = Vector2.new(7, -4),
            Requires = { "LRebirth_Node3" }
        },
        MutationLuck8 = {
            Name = "INSANE Mutation Luck V",
            Icon = "rbxassetid://94949780075192",
            Type = "MutationLuck",
            Price = 299850000,
            Position = Vector2.new(6, -3),
            Requires = { "MutationLuck7" }
        },
        MutationLuck9 = {
            Name = "INSANE Mutation Luck VI",
            Icon = "rbxassetid://94949780075192",
            Type = "MutationLuck",
            Price = 625850000,
            Position = Vector2.new(7, -2),
            Requires = { "LRebirth_Node4" }
        },
        OfflinePerks = {
            Name = "Offline Perks",
            Desc = "Allows rolled gnomes to roll GOLDEN",
            Icon = "rbxassetid://121969243910714",
            Price = 1000000,
            Position = Vector2.new(0, 1),
            Requires = { "LuckIII" }
        },
        Rebirth3_1 = {
            Name = "Rebirth 3 Required",
            RequiredRebirth = 3,
            Position = Vector2.new(0, 2),
            Requires = { "OfflinePerks" }
        },
        Rebirth4_12 = {
            Name = "Rebirth 4 Required",
            RequiredRebirth = 4,
            Position = Vector2.new(-1, 4),
            Requires = { "GnomeXP1" }
        },
        Rebirth5_12 = {
            Name = "Rebirth 5 Required",
            RequiredRebirth = 5,
            Position = Vector2.new(-4, 6),
            Requires = { "GnomeXP3" }
        },
        Rebirth_Node3 = {
            Name = "Rebirth 4 Required",
            RequiredRebirth = 4,
            Position = Vector2.new(2, 2),
            Requires = { "GnomeSpeed1" }
        },
        Rebirth_Node4 = {
            Name = "Rebirth 5 Required",
            RequiredRebirth = 5,
            Position = Vector2.new(1, 5),
            Requires = { "GnomeSpeed3" }
        },
        Rebirth_Node5 = {
            Name = "Rebirth 6 Required",
            RequiredRebirth = 6,
            Position = Vector2.new(4, 4),
            Requires = { "GnomeSpeed5" }
        }
    },
    Main = {
        Garden = {
            Name = "Garden",
            Icon = "rbxassetid://93681716206322",
            Type = "Expansion",
            Set = 0,
            Price = 0,
            Position = Vector2.new(-0, -0),
            Requires = {}
        },
        GnomePage = {
            Name = "Gnomes",
            Icon = "rbxassetid://76140911228963",
            OpensPage = "Gnomes",
            Position = Vector2.new(-1, -3),
            Requires = { "LuckIII" }
        },
        GrowthSpeed1 = {
            Name = "Grow Speed",
            Icon = "rbxassetid://74900767763694",
            Type = "GrowthSpeed",
            Set = 1,
            Price = 1000,
            Position = Vector2.new(0, 1),
            Requires = { "Garden" }
        },
        InsaneLuckIII = {
            Name = "INSANE Luck I",
            Desc = "Increases luck when rolling gnomes,",
            Icon = "rbxassetid://126591904580272",
            Type = "RollLuck",
            Set = 3.65,
            FakeValue = 140,
            Price = 4500000,
            Position = Vector2.new(0, -7),
            Requires = { "SuperLuckIII" }
        },
        InsaneLuckIII2 = {
            Name = "INSANE Luck II",
            Desc = "Increases luck when rolling gnomes,",
            Icon = "rbxassetid://119907191308327",
            Type = "RollLuck",
            Set = 3.7,
            FakeValue = 175,
            Price = 7500000,
            Position = Vector2.new(-0, -8),
            Requires = { "InsaneLuckIII" }
        },
        InsaneLuckIII3 = {
            Name = "INSANE Luck III",
            Desc = "Increases luck when rolling gnomes,",
            Icon = "rbxassetid://123390449025228",
            Type = "RollLuck",
            Set = 3.75,
            FakeValue = 205,
            Price = 10000000,
            Position = Vector2.new(1, -9),
            Requires = { "InsaneLuckIII2" }
        },
        InsaneLuckIII4 = {
            Name = "INSANE Luck IV",
            Desc = "Increases luck when rolling gnomes,",
            Icon = "rbxassetid://123390449025228",
            Type = "RollLuck",
            Set = 3.85,
            FakeValue = 230,
            Price = 14999999,
            Position = Vector2.new(2, -9),
            Requires = { "InsaneLuckIII3" }
        },
        InsaneLuckIII5 = {
            Name = "INSANE Luck V",
            Desc = "Increases luck when rolling gnomes,",
            Icon = "rbxassetid://123390449025228",
            Type = "RollLuck",
            Set = 3.95,
            FakeValue = 275,
            Price = 19999998,
            Position = Vector2.new(3, -9),
            Requires = { "InsaneLuckIII4" }
        },
        LuckI = {
            Name = "Luck I",
            Desc = "Increases luck when rolling gnomes,",
            Icon = "rbxassetid://109531581446793",
            Type = "RollLuck",
            Set = 1.3,
            FakeValue = 2,
            Price = 500,
            Position = Vector2.new(1, -2),
            Requires = { "PodiumRolls1" }
        },
        LuckII = {
            Name = "Luck II",
            Desc = "Increases luck when rolling gnomes,",
            Icon = "rbxassetid://125161607176368",
            Type = "RollLuck",
            Set = 1.6,
            FakeValue = 4,
            Price = 3500,
            Position = Vector2.new(0, -2),
            Requires = { "LuckI" }
        },
        LuckIII = {
            Name = "Luck III",
            Desc = "Increases luck when rolling gnomes,",
            Icon = "rbxassetid://132991483523287",
            Type = "RollLuck",
            Set = 2,
            FakeValue = 7,
            Price = 17500,
            Position = Vector2.new(-0, -3),
            Requires = { "LuckII" }
        },
        LuckIV = {
            Name = "Super Luck I",
            Desc = "Increases luck when rolling gnomes,",
            Icon = "rbxassetid://77350723942979",
            Type = "RollLuck",
            Set = 2.2,
            FakeValue = 12,
            Price = 42500,
            Position = Vector2.new(1, -4),
            Requires = { "LuckIII" }
        },
        LuckV = {
            Name = "Super Luck II",
            Desc = "Increases luck when rolling gnomes,",
            Icon = "rbxassetid://134237508484000",
            Type = "RollLuck",
            Set = 2.4,
            FakeValue = 20,
            Price = 92500,
            Position = Vector2.new(2, -5),
            Requires = { "LuckIV" }
        },
        LuckVI = {
            Name = "Super Luck III",
            Desc = "Increases luck when rolling gnomes,",
            Icon = "rbxassetid://134345509272011",
            Type = "RollLuck",
            Set = 2.7,
            FakeValue = 32,
            Price = 198500,
            Position = Vector2.new(3, -6),
            Requires = { "LuckV" }
        },
        MoneyMultiplier1 = {
            Name = "More Money I",
            Desc = "Money Multi",
            Icon = "rbxassetid://91462461900582",
            Type = "MoneyMulti",
            Set = 1,
            Price = 198500,
            Position = Vector2.new(4, -6),
            Requires = { "LuckVI" }
        },
        MoneyMultiplier2 = {
            Name = "More Money II",
            Desc = "Money Multi",
            Icon = "rbxassetid://90689367387682",
            Type = "MoneyMulti",
            Set = 1.05,
            Price = 498500,
            Position = Vector2.new(5, -7),
            Requires = { "MoneyMultiplier1" }
        },
        MoneyMultiplier3 = {
            Name = "More Money III",
            Desc = "Money Multi",
            Icon = "rbxassetid://111599881951106",
            Type = "MoneyMulti",
            Set = 1.1,
            Price = 895000,
            Position = Vector2.new(6, -8),
            Requires = { "MoneyMultiplier2" }
        },
        MoneyMultiplier4 = {
            Name = "More Money IV",
            Desc = "Money Multi",
            Icon = "rbxassetid://121744614085691",
            Type = "MoneyMulti",
            Set = 1.15,
            Price = 1899000,
            Position = Vector2.new(7, -8),
            Requires = { "MoneyMultiplier3" }
        },
        MoneyMultiplier5 = {
            Name = "More Money V",
            Desc = "Money Multi",
            Icon = "rbxassetid://121744614085691",
            Type = "MoneyMulti",
            Set = 1.2,
            Price = 3495000,
            Position = Vector2.new(7, -7),
            Requires = { "MoneyMultiplier4" }
        },
        PlantsPage = {
            Name = "Plants",
            Icon = "rbxassetid://126292809512743",
            OpensPage = "Plants",
            Position = Vector2.new(1, 1),
            Requires = { "GrowthSpeed1" }
        },
        PlayerPage = {
            Name = "Player",
            Icon = "rbxassetid://75371307729352",
            OpensPage = "Player",
            Position = Vector2.new(-1, 2),
            Requires = { "GrowthSpeed1" }
        },
        PlotExpansion1 = {
            Name = "Expansion 1",
            Icon = "rbxassetid://93681716206322",
            Type = "Expansion",
            Set = 1,
            Price = 30000,
            Position = Vector2.new(-1, 0),
            Requires = { "Garden" }
        },
        PlotExpansion2 = {
            Name = "Expansion 2",
            Icon = "rbxassetid://93681716206322",
            Type = "Expansion",
            Set = 2,
            Price = 100000,
            Position = Vector2.new(-2, 0),
            Requires = { "PlotExpansion1" }
        },
        PlotExpansion3 = {
            Name = "Expansion 3",
            Icon = "rbxassetid://93681716206322",
            Type = "Expansion",
            Set = 3,
            Price = 2500000,
            Position = Vector2.new(-3, 2),
            Requires = { "Rebirth1_1" }
        },
        PlotExpansion4 = {
            Name = "Expansion 4",
            Icon = "rbxassetid://93681716206322",
            Type = "Expansion",
            Set = 4,
            Price = 22500000,
            Position = Vector2.new(-5, 3),
            Requires = { "Rebirth3_1" }
        },
        PlotExpansion5 = {
            Name = "Expansion 5",
            Icon = "rbxassetid://93681716206322",
            Type = "Expansion",
            Set = 5,
            Price = 349000000,
            Position = Vector2.new(-5, 1),
            Requires = { "Rebirth5_1" }
        },
        PodiumRolls1 = {
            Name = "+2 Rolls",
            Desc = "More podiums when rolling.",
            Icon = "rbxassetid://85432431764153",
            Type = "PodiumRolls",
            Set = 2,
            Price = 50,
            Position = Vector2.new(1, -1),
            Requires = { "Garden" }
        },
        PodiumRolls2 = {
            Name = "+3 Rolls",
            Desc = "More podiums when rolling.",
            Icon = "rbxassetid://85432431764153",
            Type = "PodiumRolls",
            Set = 3,
            Price = 3500,
            Position = Vector2.new(2, -2),
            Requires = { "PodiumRolls1" }
        },
        PodiumRolls3 = {
            Name = "+4 Rolls",
            Desc = "More podiums when rolling.",
            Icon = "rbxassetid://85432431764153",
            Type = "PodiumRolls",
            Set = 4,
            Price = 35000,
            Position = Vector2.new(3, -3),
            Requires = { "PodiumRolls2" }
        },
        PodiumRolls4 = {
            Name = "+5 Rolls",
            Desc = "More podiums when rolling.",
            Icon = "rbxassetid://85432431764153",
            Type = "PodiumRolls",
            Set = 5,
            Price = 175000,
            Position = Vector2.new(3, -4),
            Requires = { "PodiumRolls3" }
        },
        PodiumRolls5 = {
            Name = "+6 Rolls",
            Desc = "More podiums when rolling.",
            Icon = "rbxassetid://85432431764153",
            Type = "PodiumRolls",
            Set = 6,
            Price = 649000,
            Position = Vector2.new(4, -4),
            Requires = { "PodiumRolls4" }
        },
        PodiumRolls6 = {
            Name = "+7 Rolls",
            Desc = "More podiums when rolling.",
            Icon = "rbxassetid://85432431764153",
            Type = "PodiumRolls",
            Set = 7,
            Price = 16950000,
            Position = Vector2.new(6, -4),
            Requires = { "Rebirth3_2" }
        },
        PodiumRolls7 = {
            Name = "+8 Rolls",
            Desc = "More podiums when rolling.",
            Icon = "rbxassetid://85432431764153",
            Type = "PodiumRolls",
            Set = 8,
            Price = 49950000,
            Position = Vector2.new(7, -4),
            Requires = { "PodiumRolls6" }
        },
        PodiumRolls8 = {
            Name = "+9 Rolls",
            Desc = "More podiums when rolling.",
            Icon = "rbxassetid://85432431764153",
            Type = "PodiumRolls",
            Set = 9,
            Price = 239850000,
            Position = Vector2.new(9, -5),
            Requires = { "Rebirth6_2" }
        },
        PodiumRolls9 = {
            Name = "+10 Rolls",
            Desc = "More podiums when rolling.",
            Icon = "rbxassetid://85432431764153",
            Type = "PodiumRolls",
            Set = 10,
            Price = 495000000,
            Position = Vector2.new(10, -6),
            Requires = { "PodiumRolls8" }
        },
        Rebirth1_1 = {
            Name = "Rebirth 1 Required",
            RequiredRebirth = 1,
            Position = Vector2.new(-3, 1),
            Requires = { "PlotExpansion2" }
        },
        Rebirth3_1 = {
            Name = "Rebirth 3 Required",
            RequiredRebirth = 3,
            Position = Vector2.new(-4, 3),
            Requires = { "PlotExpansion3" }
        },
        Rebirth3_2 = {
            Name = "Rebirth 4 Required",
            RequiredRebirth = 4,
            Position = Vector2.new(5, -4),
            Requires = { "PodiumRolls5" }
        },
        Rebirth5_1 = {
            Name = "Rebirth 5 Required",
            RequiredRebirth = 5,
            Position = Vector2.new(-5, 2),
            Requires = { "PlotExpansion4" }
        },
        Rebirth6_2 = {
            Name = "Rebirth 6 Required",
            RequiredRebirth = 6,
            Position = Vector2.new(8, -4),
            Requires = { "PodiumRolls7" }
        },
        RollSpeedI = {
            Name = "Roll Speed I",
            Desc = "Increases luck when rolling gnomes,",
            Icon = "rbxassetid://106038455594886",
            Type = "RollSpeed",
            Set = 1.1,
            Price = 500,
            Position = Vector2.new(2, -1),
            Requires = { "PodiumRolls1" }
        },
        RollSpeedII = {
            Name = "Roll Speed II",
            Desc = "Increases luck when rolling gnomes,",
            Icon = "rbxassetid://106038455594886",
            Type = "RollSpeed",
            Set = 1.2,
            Price = 3500,
            Position = Vector2.new(3, -1),
            Requires = { "RollSpeedI" }
        },
        RollSpeedIII = {
            Name = "Roll Speed III",
            Desc = "Increases luck when rolling gnomes,",
            Icon = "rbxassetid://106038455594886",
            Type = "RollSpeed",
            Set = 1.3,
            Price = 4750,
            Position = Vector2.new(4, -1),
            Requires = { "RollSpeedII" }
        },
        RollSpeedIV = {
            Name = "Roll Speed IV",
            Desc = "Increases luck when rolling gnomes,",
            Icon = "rbxassetid://106038455594886",
            Type = "RollSpeed",
            Set = 1.4,
            Price = 9500,
            Position = Vector2.new(5, -2),
            Requires = { "RollSpeedIII" }
        },
        RollSpeedIX = {
            Name = "Roll Speed IX",
            Desc = "Increases luck when rolling gnomes,",
            Icon = "rbxassetid://106038455594886",
            Type = "RollSpeed",
            Set = 1.9,
            Price = 250000,
            Position = Vector2.new(6, 0),
            Requires = { "RollSpeedVIII" }
        },
        RollSpeedV = {
            Name = "Roll Speed V",
            Desc = "Increases luck when rolling gnomes,",
            Icon = "rbxassetid://106038455594886",
            Type = "RollSpeed",
            Set = 1.5,
            Price = 17500,
            Position = Vector2.new(6, -2),
            Requires = { "RollSpeedIV" }
        },
        RollSpeedVI = {
            Name = "Roll Speed VI",
            Desc = "Increases luck when rolling gnomes,",
            Icon = "rbxassetid://106038455594886",
            Type = "RollSpeed",
            Set = 1.6,
            Price = 45000,
            Position = Vector2.new(7, -2),
            Requires = { "RollSpeedV" }
        },
        RollSpeedVII = {
            Name = "Roll Speed VII",
            Desc = "Increases luck when rolling gnomes,",
            Icon = "rbxassetid://106038455594886",
            Type = "RollSpeed",
            Set = 1.7,
            Price = 75000,
            Position = Vector2.new(8, -2),
            Requires = { "RollSpeedVI" }
        },
        RollSpeedVIII = {
            Name = "Roll Speed VIII",
            Desc = "Increases luck when rolling gnomes,",
            Icon = "rbxassetid://106038455594886",
            Type = "RollSpeed",
            Set = 1.8,
            Price = 125000,
            Position = Vector2.new(7, -1),
            Requires = { "RollSpeedVII" }
        },
        RollSpeedX = {
            Name = "Roll Speed X",
            Desc = "Increases luck when rolling gnomes,",
            Icon = "rbxassetid://106038455594886",
            Type = "RollSpeed",
            Set = 2,
            Price = 500000,
            Position = Vector2.new(5, 0),
            Requires = { "RollSpeedIX" }
        },
        SECRETLuck1 = {
            Name = "SECRET Luck I",
            Desc = "Increases secret luck when rolling gnomes,",
            Icon = "rbxassetid://138611827768141",
            Type = "SecretLuck",
            Set = 1,
            Price = 8499998,
            Position = Vector2.new(-1, -6),
            Requires = { "InsaneLuckIII" }
        },
        SECRETLuck2 = {
            Name = "SECRET Luck II",
            Desc = "Increases secret luck when rolling gnomes,",
            Icon = "rbxassetid://138611827768141",
            Type = "SecretLuck",
            Set = 1.5,
            Price = 12500000,
            Position = Vector2.new(-2, -6),
            Requires = { "SECRETLuck1" }
        },
        SECRETLuck3 = {
            Name = "SECRET Luck III",
            Desc = "Increases secret luck when rolling gnomes,",
            Icon = "rbxassetid://138611827768141",
            Type = "SecretLuck",
            Set = 2,
            Price = 18500000,
            Position = Vector2.new(-3, -6),
            Requires = { "SECRETLuck2" }
        },
        SECRETLuck4 = {
            Name = "SECRET Luck IV",
            Desc = "Increases secret luck when rolling gnomes,",
            Icon = "rbxassetid://138611827768141",
            Type = "SecretLuck",
            Set = 2.25,
            Price = 26500000,
            Position = Vector2.new(-4, -5),
            Requires = { "SECRETLuck3" }
        },
        SECRETLuck5 = {
            Name = "SECRET Luck V",
            Desc = "Increases secret luck when rolling gnomes,",
            Icon = "rbxassetid://138611827768141",
            Type = "SecretLuck",
            Set = 2.5,
            Price = 49000000,
            Position = Vector2.new(-4, -4),
            Requires = { "SECRETLuck4" }
        },
        SuperLuckI = {
            Name = "ULTRA Luck I",
            Desc = "Increases luck when rolling gnomes,",
            Icon = "rbxassetid://73976656653696",
            Type = "RollLuck",
            Set = 100,
            FakeValue = 50,
            Price = 495000,
            Position = Vector2.new(3, -7),
            Requires = { "LuckVI" }
        },
        SuperLuckII = {
            Name = "ULTRA Luck II",
            Desc = "Increases luck when rolling gnomes,",
            Icon = "rbxassetid://72320898280522",
            Type = "RollLuck",
            Set = 3.2,
            FakeValue = 75,
            Price = 1000000,
            Position = Vector2.new(2, -7),
            Requires = { "SuperLuckI" }
        },
        SuperLuckIII = {
            Name = "ULTRA Luck III",
            Desc = "Increases luck when rolling gnomes,",
            Icon = "rbxassetid://102664952634516",
            Type = "RollLuck",
            Set = 3.5,
            FakeValue = 105,
            Price = 2500000,
            Position = Vector2.new(1, -7),
            Requires = { "SuperLuckII" }
        },
        SuperPrinter1 = {
            Name = "Super Printer I",
            Desc = "Money Multi",
            Icon = "rbxassetid://122071831236462",
            Type = "MoneyMulti",
            Set = 1.3,
            Price = 12500000,
            Position = Vector2.new(7, -6),
            Requires = { "MoneyMultiplier5" }
        },
        SuperPrinter2 = {
            Name = "Super Printer II",
            Desc = "Money Multi",
            Icon = "rbxassetid://122071831236462",
            Type = "MoneyMulti",
            Set = 1.4,
            Price = 19950000,
            Position = Vector2.new(8, -6),
            Requires = { "SuperPrinter1" }
        },
        SuperPrinter3 = {
            Name = "Super Printer III",
            Desc = "Money Multi",
            Icon = "rbxassetid://122071831236462",
            Type = "MoneyMulti",
            Set = 1.5,
            Price = 36799000,
            Position = Vector2.new(9, -7),
            Requires = { "SuperPrinter2" }
        },
        SuperPrinter4 = {
            Name = "Super Printer IV",
            Desc = "Money Multi",
            Icon = "rbxassetid://122071831236462",
            Type = "MoneyMulti",
            Set = 1.525,
            Price = 74950000,
            Position = Vector2.new(9, -8),
            Requires = { "SuperPrinter3" }
        },
        SuperPrinter5 = {
            Name = "Super Printer V",
            Desc = "Money Multi",
            Icon = "rbxassetid://122071831236462",
            Type = "MoneyMulti",
            Set = 1.55,
            Price = 195999999,
            Position = Vector2.new(9, -9),
            Requires = { "SuperPrinter4" }
        }
    },
    ["Offline Upgrades"] = {},
    Plants = {
        BetterDirt1 = {
            Name = "Good Dirt",
            Icon = "rbxassetid://100785175960568",
            Type = "BetterDirt",
            Set = 1,
            Price = 35000,
            Position = Vector2.new(-3, 3),
            Requires = { "GrowthSpeed1" }
        },
        BetterDirt2 = {
            Name = "Great Dirt",
            Icon = "rbxassetid://132014430924465",
            Type = "BetterDirt",
            Set = 2,
            Price = 98500,
            Position = Vector2.new(-4, 3),
            Requires = { "BetterDirt1" }
        },
        BetterDirt3 = {
            Name = "Better Dirt",
            Icon = "rbxassetid://88838047062309",
            Type = "BetterDirt",
            Set = 3,
            Price = 214900,
            Position = Vector2.new(-5, 4),
            Requires = { "BetterDirt2" }
        },
        BetterDirt4 = {
            Name = "Best Dirt",
            Icon = "rbxassetid://117880176180889",
            Type = "BetterDirt",
            Set = 4,
            Price = 849000,
            Position = Vector2.new(-5, 5),
            Requires = { "BetterDirt3" }
        },
        DiamondPlants = {
            Name = "Diamond",
            Icon = "rbxassetid://74182598177936",
            Type = "DiamondPlants",
            Set = "true",
            Price = 79000,
            Position = Vector2.new(-3, 6),
            Requires = { "GoldenPlants" }
        },
        GoldenPlants = {
            Name = "Golden",
            Icon = "rbxassetid://102872529223261",
            Type = "GoldenPlants",
            Set = "true",
            Price = 45000,
            Position = Vector2.new(-3, 5),
            Requires = { "MutatedPlants" }
        },
        GrowthSpeed2 = {
            Name = "Grow Speed II",
            Icon = "rbxassetid://123442537154110",
            Type = "GrowthSpeed",
            Set = 2,
            Price = 3500,
            Position = Vector2.new(-1, 2),
            Requires = { "GrowthSpeed1" }
        },
        GrowthSpeed3 = {
            Name = "Grow Speed III",
            Icon = "rbxassetid://105005915132476",
            Type = "GrowthSpeed",
            Set = 3,
            Price = 12500,
            Position = Vector2.new(-0, 1),
            Requires = { "GrowthSpeed2" }
        },
        GrowthSpeed4 = {
            Name = "Grow Speed IV",
            Icon = "rbxassetid://136406151953821",
            Type = "GrowthSpeed",
            Set = 4,
            Price = 35000,
            Position = Vector2.new(1, -0),
            Requires = { "GrowthSpeed3" }
        },
        GrowthSpeed5 = {
            Name = "Grow Speed V",
            Icon = "rbxassetid://94661271174165",
            Type = "GrowthSpeed",
            Set = 5,
            Price = 94500,
            Position = Vector2.new(2, 0),
            Requires = { "GrowthSpeed4" }
        },
        MutatedPlants = {
            Name = "Mutated Fruit",
            Icon = "rbxassetid://107710186316416",
            Type = "MutatedPlants",
            Set = "true",
            Price = 17500,
            Position = Vector2.new(-2, 4),
            Requires = { "GrowthSpeed1" }
        },
        PlantGrowthSpeed1 = {
            Name = "Fast Plant Growth I",
            Icon = "rbxassetid://70640268514060",
            Type = "OfflineGrowthSpeed",
            Set = 1.1,
            Price = 5850000,
            Position = Vector2.new(-2, 1),
            Requires = { "Rebirth3_2" }
        },
        PlantGrowthSpeed2 = {
            Name = "Faster Plant Growth II",
            Icon = "rbxassetid://70640268514060",
            Type = "OfflineGrowthSpeed",
            Set = 1.2,
            Price = 19850000,
            Position = Vector2.new(-0, -1),
            Requires = { "Rebirth4_1" }
        },
        PlantGrowthSpeed3 = {
            Name = "Faster Plant Growth III",
            Icon = "rbxassetid://70640268514060",
            Type = "OfflineGrowthSpeed",
            Set = 1.3,
            Price = 64850000,
            Position = Vector2.new(-0, -2),
            Requires = { "PlantGrowthSpeed2" }
        },
        PlantGrowthSpeed4 = {
            Name = "ULTRA Plant Growth IV",
            Icon = "rbxassetid://70640268514060",
            Type = "OfflineGrowthSpeed",
            Set = 1.35,
            Price = 179875000,
            Position = Vector2.new(-2, -2),
            Requires = { "PlantGrowthSpeed3" }
        },
        PlantGrowthSpeed5 = {
            Name = "ULTRA Plant Growth Speed V",
            Icon = "rbxassetid://70640268514060",
            Type = "OfflineGrowthSpeed",
            Set = 1.375,
            Price = 349850000,
            Position = Vector2.new(-3, -1),
            Requires = { "PlantGrowthSpeed4" }
        },
        PlantGrowthSpeed6 = {
            Name = "OP Plant Growth Speed VI",
            Icon = "rbxassetid://70640268514060",
            Type = "OfflineGrowthSpeed",
            Set = 1.4,
            Price = 895000000,
            Position = Vector2.new(-4, 1),
            Requires = { "Rebirth6_1" }
        },
        PlantsBack = {
            Name = "Plants",
            Icon = "\"\"",
            OpensPage = "Main",
            BackButton = true,
            Position = Vector2.new(-2, 3),
            Requires = {}
        },
        Rebirth3_2 = {
            Name = "Rebirth 3 Required",
            RequiredRebirth = 3,
            Position = Vector2.new(-2, 2),
            Requires = { "GrowthSpeed1" }
        },
        Rebirth4_1 = {
            Name = "Rebirth 4 Required",
            RequiredRebirth = 4,
            Position = Vector2.new(-1, -0),
            Requires = { "PlantGrowthSpeed1" }
        },
        Rebirth5_1 = {
            Name = "Rebirth 5 Required",
            RequiredRebirth = 5,
            Position = Vector2.new(-1, -2),
            Requires = { "PlantGrowthSpeed3" }
        },
        Rebirth6_1 = {
            Name = "Rebirth 6 Required",
            RequiredRebirth = 6,
            Position = Vector2.new(-4, 0),
            Requires = { "PlantGrowthSpeed5" }
        },
        ReduceTime1 = {
            Name = "Reduce Time I",
            Icon = "rbxassetid://140174006099472",
            Type = "GrowthSpeed",
            Set = 5.25,
            Price = 64500,
            Position = Vector2.new(2, 1),
            Requires = { "GrowthSpeed5" }
        },
        ReduceTime2 = {
            Name = "Reduce Time II",
            Icon = "rbxassetid://112088074500234",
            Type = "GrowthSpeed",
            Set = 5.5,
            Price = 179000,
            Position = Vector2.new(1, 2),
            Requires = { "ReduceTime1" }
        },
        ReduceTime3 = {
            Name = "Reduce Time III",
            Icon = "rbxassetid://120329300507614",
            Type = "GrowthSpeed",
            Set = 5.75,
            Price = 375000,
            Position = Vector2.new(1, 3),
            Requires = { "ReduceTime2" }
        },
        ReduceTime4 = {
            Name = "Reduce Time IV",
            Icon = "rbxassetid://76810069964672",
            Type = "GrowthSpeed",
            Set = 6,
            Price = 895000,
            Position = Vector2.new(2, 3),
            Requires = { "ReduceTime3" }
        },
        ReduceTime5 = {
            Name = "Reduce Time V",
            Icon = "rbxassetid://136406151953821",
            Type = "GrowthSpeed",
            Set = 6.25,
            Price = 1795000,
            Position = Vector2.new(2, 4),
            Requires = { "ReduceTime4" }
        },
        ShinyPlants = {
            Name = "Shiny",
            Icon = "rbxassetid://120900268461370",
            Type = "ShinyPlants",
            Set = "true",
            Price = 199000,
            Position = Vector2.new(-2, 6),
            Requires = { "DiamondPlants" }
        },
        UltraDirt1 = {
            Name = "ULTRA Dirt I",
            Icon = "rbxassetid://108036301695841",
            Type = "BetterDirt",
            Set = 4.1,
            Price = 1895000,
            Position = Vector2.new(-5, 6),
            Requires = { "BetterDirt4" }
        },
        UltraDirt2 = {
            Name = "ULTRA Dirt II",
            Icon = "rbxassetid://96803582859022",
            Type = "BetterDirt",
            Set = 4.2,
            Price = 3495000,
            Position = Vector2.new(-6, 7),
            Requires = { "UltraDirt1" }
        },
        UltraDirt3 = {
            Name = "ULTRA Dirt III",
            Icon = "rbxassetid://117880176180889",
            Type = "BetterDirt",
            Set = 4.3,
            Price = 7950000,
            Position = Vector2.new(-7, 7),
            Requires = { "UltraDirt2" }
        },
        UltraDirt4 = {
            Name = "ULTRA Dirt IV",
            Icon = "rbxassetid://127055106325385",
            Type = "BetterDirt",
            Set = 4.4,
            Price = 16595000,
            Position = Vector2.new(-7, 6),
            Requires = { "UltraDirt3" }
        },
        UltraDirt5 = {
            Name = "ULTRA Dirt V",
            Icon = "rbxassetid://117880176180889",
            Type = "BetterDirt",
            Set = 4.5,
            Price = 49500000,
            Position = Vector2.new(-7, 5),
            Requires = { "UltraDirt4" }
        }
    },
    Player = {
        CollectRange1 = {
            Name = "Range I",
            Icon = "rbxassetid://75371307729352",
            Type = "CollectRange",
            Set = 12,
            Price = 50000,
            Position = Vector2.new(-2, 4),
            Requires = { "GrowthSpeed1" }
        },
        CollectRange2 = {
            Name = "Range II",
            Icon = "rbxassetid://75371307729352",
            Type = "CollectRange",
            Set = 14,
            Price = 125000,
            Position = Vector2.new(-2, 5),
            Requires = { "CollectRange1" }
        },
        CollectRange3 = {
            Name = "Range III",
            Icon = "rbxassetid://79120135426803",
            Type = "CollectRange",
            Set = 16,
            Price = 399000,
            Position = Vector2.new(-3, 6),
            Requires = { "CollectRange2" }
        },
        CollectRange4 = {
            Name = "Bigger Range I",
            Icon = "rbxassetid://79120135426803",
            Type = "CollectRange",
            Set = 19,
            Price = 899000,
            Position = Vector2.new(-5, 6),
            Requires = { "Rebirth3_12" }
        },
        CollectRange5 = {
            Name = "Larger Range II",
            Icon = "rbxassetid://79120135426803",
            Type = "CollectRange",
            Set = 22,
            Price = 4450000,
            Position = Vector2.new(-5, 4),
            Requires = { "Rebirth4_122" }
        },
        CollectRange6 = {
            Name = "Larger Range III",
            Icon = "rbxassetid://79120135426803",
            Type = "CollectRange",
            Set = 26,
            Price = 17950000,
            Position = Vector2.new(-5, 3),
            Requires = { "CollectRange5" }
        },
        CollectRange7 = {
            Name = "Insane Range IV",
            Icon = "rbxassetid://79120135426803",
            Type = "CollectRange",
            Set = 31,
            Price = 49500000,
            Position = Vector2.new(-7, 4),
            Requires = { "Rebirth5_1222" }
        },
        CollectRange8 = {
            Name = "Insane Range V",
            Icon = "rbxassetid://79120135426803",
            Type = "CollectRange",
            Set = 36,
            Price = 129850000,
            Position = Vector2.new(-7, 5),
            Requires = { "CollectRange7" }
        },
        CollectRange9 = {
            Name = "OP Range Vi",
            Icon = "rbxassetid://79120135426803",
            Type = "CollectRange",
            Set = 40,
            Price = 249000000,
            Position = Vector2.new(-7, 7),
            Requires = { "Rebirth6_12222" }
        },
        GnomesBack2 = {
            Name = "Gnomes",
            Icon = "\"\"",
            OpensPage = "Main",
            BackButton = true,
            Position = Vector2.new(-1, 3),
            Requires = {}
        },
        InventorySpace1 = {
            Name = "+25 Inv Space",
            Type = "InventorySpace",
            Set = 25,
            Price = 65000,
            Position = Vector2.new(-1, 2),
            Requires = { "GrowthSpeed1" }
        },
        InventorySpace2 = {
            Name = "+25 Inv Space",
            Type = "InventorySpace",
            Set = 25,
            Price = 125000,
            Position = Vector2.new(0, 1),
            Requires = { "InventorySpace1" }
        },
        InventorySpace3 = {
            Name = "+25 Inv Space",
            Type = "InventorySpace",
            Set = 25,
            Price = 245000,
            Position = Vector2.new(1, 1),
            Requires = { "InventorySpace2" }
        },
        InventorySpace4 = {
            Name = "+25 Inv Space",
            Type = "InventorySpace",
            Set = 25,
            Price = 750000,
            Position = Vector2.new(1, 2),
            Requires = { "InventorySpace3" }
        },
        InventorySpace5 = {
            Name = "+25 Inv Space",
            Type = "InventorySpace",
            Set = 25,
            Price = 1750000,
            Position = Vector2.new(2, 2),
            Requires = { "InventorySpace4" }
        },
        InventorySpace6 = {
            Name = "+25 Inv Space",
            Type = "InventorySpace",
            Set = 25,
            Price = 3495000,
            Position = Vector2.new(3, 1),
            Requires = { "InventorySpace5" }
        },
        Rebirth3_12 = {
            Name = "Rebirth 3 Required",
            RequiredRebirth = 3,
            Position = Vector2.new(-4, 6),
            Requires = { "CollectRange3" }
        },
        Rebirth4_122 = {
            Name = "Rebirth 4 Required",
            RequiredRebirth = 4,
            Position = Vector2.new(-5, 5),
            Requires = { "CollectRange4" }
        },
        Rebirth5_1222 = {
            Name = "Rebirth 5 Required",
            RequiredRebirth = 5,
            Position = Vector2.new(-6, 3),
            Requires = { "CollectRange6" }
        },
        Rebirth6_12222 = {
            Name = "Rebirth 6 Required",
            RequiredRebirth = 6,
            Position = Vector2.new(-7, 6),
            Requires = { "CollectRange8" }
        }
    }
};