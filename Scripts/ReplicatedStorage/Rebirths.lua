--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Rebirths
  Path:     game.ReplicatedStorage.Library.Configs.Rebirths
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:03 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Rebirth1 = {
        requirements = {
            money = 1000000,
            gnomes = { "Mango Gnome", "Starfruit Gnome" }
        },
        perks = {
            rollLuck = 1.15,
            cashBonus = 5000,
            maxGnome = 1
        },
        ui = {
            rollLuck = {
                template = "RollLuck",
                icon = "rbxassetid://77350723942979",
                text = "Luck Multi",
                multi = "x1.15",
                order = 1
            },
            expansion = {
                template = "Template",
                icon = "rbxassetid://93681716206322",
                text = "More Expansions",
                order = 3
            },
            moreGnomes = {
                template = "MaxGnomes",
                icon = "rbxassetid://108695922326586",
                text = "Max Gnome",
                multi = "+1",
                order = 4
            },
            cashBonus = {
                template = "Template",
                icon = "rbxassetid://114870615867460",
                text = "+5,000 $",
                order = 5
            }
        }
    },
    Rebirth2 = {
        requirements = {
            money = 5000000,
            gnomes = { "Giant Avocado Gnome", "Giant Peach Gnome" }
        },
        perks = {
            rollLuck = 1.3,
            cashBonus = 10000,
            maxGnome = 1
        },
        ui = {
            rollLuck = {
                template = "RollLuck",
                icon = "rbxassetid://77350723942979",
                text = "Luck Multi",
                multi = "x1.3",
                order = 1
            },
            moreGnomes = {
                template = "MaxGnomes",
                icon = "rbxassetid://108695922326586",
                text = "Max Gnome",
                multi = "+1",
                order = 4
            },
            cashBonus = {
                template = "Template",
                icon = "rbxassetid://114870615867460",
                text = "+10,000 $",
                order = 5
            }
        }
    },
    Rebirth3 = {
        requirements = {
            money = 25500000,
            gnomes = { "Ruby Pear Gnome", "Frost Gnome" }
        },
        perks = {
            rollLuck = 1.5,
            cashBonus = 15000,
            maxGnome = 1
        },
        ui = {
            rollLuck = {
                template = "RollLuck",
                icon = "rbxassetid://77350723942979",
                text = "Luck Multi",
                multi = "x1.5",
                order = 1
            },
            expansion = {
                template = "Template",
                icon = "rbxassetid://93681716206322",
                text = "More Expansions",
                order = 3
            },
            moreGnomes = {
                template = "MaxGnomes",
                icon = "rbxassetid://108695922326586",
                text = "Max Gnome",
                multi = "+1",
                order = 4
            },
            cashBonus = {
                template = "Template",
                icon = "rbxassetid://114870615867460",
                text = "+15,000 $",
                order = 5
            }
        }
    },
    Rebirth4 = {
        requirements = {
            money = 95000000,
            gnomes = { "Crystal Apple Gnome", "Frost Gnome" }
        },
        perks = {
            rollLuck = 1.65,
            cashBonus = 20000,
            boosts = {
                ["2xMoney"] = 300
            }
        },
        ui = {
            rollLuck = {
                template = "RollLuck",
                icon = "rbxassetid://77350723942979",
                text = "Luck Multi",
                multi = "x1.65",
                order = 1
            },
            upgrades = {
                template = "Template",
                icon = "rbxassetid://133542814031041",
                text = "More Upgrades",
                order = 2
            },
            MoneyBoost = {
                template = "Template",
                icon = "rbxassetid://129974726398900",
                text = "5m $ Boost",
                order = 4
            },
            cashBonus = {
                template = "Template",
                icon = "rbxassetid://114870615867460",
                text = "+20,000 $",
                order = 5
            }
        }
    },
    Rebirth5 = {
        requirements = {
            money = 375000000,
            gnomes = { "Celestial Starfruit Gnome", "Comet Gnome" }
        },
        perks = {
            rollLuck = 1.8,
            cashBonus = 30000,
            maxGnome = 1,
            boosts = {
                ["2xMoney"] = 300,
                ["2xLuck"] = 300
            }
        },
        ui = {
            rollLuck = {
                template = "RollLuck",
                icon = "rbxassetid://77350723942979",
                text = "Luck Multi",
                multi = "x1.8",
                order = 1
            },
            upgrades = {
                template = "Template",
                icon = "rbxassetid://133542814031041",
                text = "More Upgrades",
                order = 2
            },
            expansion = {
                template = "Template",
                icon = "rbxassetid://93681716206322",
                text = "More Expansions",
                order = 4
            },
            moreGnomes = {
                template = "MaxGnomes",
                icon = "rbxassetid://108695922326586",
                text = "Max Gnome",
                multi = "+1",
                order = 3
            },
            MoneyBoost = {
                template = "Template",
                icon = "rbxassetid://129974726398900",
                text = "5m $ Boost",
                order = 5
            },
            LuckBoost = {
                template = "Template",
                icon = "rbxassetid://119719503226688",
                text = "5m Luck Boost",
                order = 6
            },
            cashBonus = {
                template = "Template",
                icon = "rbxassetid://114870615867460",
                text = "+30,000 $",
                order = 7
            }
        }
    },
    Rebirth6 = {
        requirements = {
            money = 650000000,
            gnomes = { "Eclipse Gnome", "Shadow Gnome" }
        },
        perks = {
            rollLuck = 2,
            cashBonus = 40000,
            boosts = {
                ["2xMoney"] = 300,
                ["2xLuck"] = 300
            }
        },
        ui = {
            rollLuck = {
                template = "RollLuck",
                icon = "rbxassetid://77350723942979",
                text = "Luck Multi",
                multi = "x2",
                order = 1
            },
            upgrades = {
                template = "Template",
                icon = "rbxassetid://133542814031041",
                text = "More Upgrades",
                order = 2
            },
            MoneyBoost = {
                template = "Template",
                icon = "rbxassetid://129974726398900",
                text = "5m $ Boost",
                order = 6
            },
            LuckBoost = {
                template = "Template",
                icon = "rbxassetid://119719503226688",
                text = "5m Luck Boost",
                order = 7
            },
            cashBonus = {
                template = "Template",
                icon = "rbxassetid://114870615867460",
                text = "+40,000 $",
                order = 5
            }
        }
    }
};