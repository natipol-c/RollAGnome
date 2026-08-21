--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Mutation Images
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Mutation Images
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:40 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Library = require(ReplicatedStorage.Library);
local v1 = Library.get("Find");
local u2 = Library.get("Mutations");
Library.get("Network");
Library.get("Signal");
local u3 = v1(Players.LocalPlayer, "PlayerGui");
local MutationImages = ReplicatedStorage.Assets.MutationImages;
local v4 = {};

local function added(p5) -- Line: 35
    -- upvalues: u3 (copy), u2 (copy), MutationImages (copy)
    if not p5:IsDescendantOf(u3) then
        return;
    end;

    if not p5:IsA("ImageLabel") then
        return;
    end;

    local v6 = u2:toTable((p5:GetAttribute("mutations")));

    for _, v in next, v6 do
        if v == "Bloodmoon" then
            p5.ImageColor3 = Color3.fromRGB(255, 101, 101);
        end;

        local v7 = MutationImages:FindFirstChild(v);

        if v7 and not p5:FindFirstChild(v) then
            v7:Clone().Parent = p5;
        end;
    end;
end;

function v4.Initialize(p8) -- Line: 58
    -- upvalues: CollectionService (copy), added (copy)
    CollectionService:GetInstanceAddedSignal("MutationImage"):Connect(added);
    local v9 = next;
    local v10, v11 = CollectionService:GetTagged("MutationImage");

    for _, v in v9, v10, v11 do
        task.spawn(function() -- Line: 62
            -- upvalues: added (ref), v (copy)
            added(v);
        end);
    end;
end;

return v4;