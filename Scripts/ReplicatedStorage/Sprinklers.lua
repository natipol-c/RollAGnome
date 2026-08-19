--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Sprinklers
  Path:     game.ReplicatedStorage.Library.Configs.Sprinklers
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    ["Basic Sprinkler"] = {
        icon = "rbxassetid://118180797413268",
        type = "GrowthSpeed",
        ring = "SprinklerRing",
        range = 11,
        duration = 120,
        multi = 0.25,
        order = 1
    },
    ["Golden Sprinkler"] = {
        icon = "rbxassetid://107557464952088",
        type = "GrowthSpeed",
        ring = "SprinklerRing",
        range = 14,
        duration = 180,
        multi = 0.75,
        order = 2
    },
    ["Mutation Mister"] = {
        icon = "rbxassetid://113068016852801",
        type = "MutationLuck",
        ring = "MutationRing",
        range = 18,
        duration = 300,
        multi = 0.15,
        order = 3
    }
};