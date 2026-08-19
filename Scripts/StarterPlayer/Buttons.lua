--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Buttons
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Buttons
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:29 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
Library.get("Network");
Library.get("Signal");
local u2 = u1(Players.LocalPlayer, "PlayerGui");
local v3 = {};

local function added(p4) -- Line: 31
    -- upvalues: u2 (copy), u1 (copy)
    if not p4:IsDescendantOf(u2) then
        return;
    end;

    if not p4:IsA("Frame") then
        return;
    end;

    local u5 = p4:FindFirstChild("Frame") or p4;
    local v6 = u1(p4, "Button");

    if not (u5 and v6) then
        return;
    end;

    v6.MouseEnter:Connect(function() -- Line: 42
        -- upvalues: u5 (copy)
        u5.Size = UDim2.fromScale(1.04, 1.04);
    end);
    v6.MouseLeave:Connect(function() -- Line: 45
        -- upvalues: u5 (copy)
        u5.Size = UDim2.fromScale(1, 1);
    end);
    v6.MouseButton1Down:Connect(function() -- Line: 48
        -- upvalues: u5 (copy)
        u5.Size = UDim2.fromScale(0.93, 0.93);
    end);
    v6.MouseButton1Click:Connect(function() -- Line: 51
        -- upvalues: u5 (copy)
        _G.Play("Tap");
        u5.Size = UDim2.fromScale(1.04, 1.04);
    end);
end;

function v3.Initialize(p7) -- Line: 57
    -- upvalues: CollectionService (copy), added (copy)
    CollectionService:GetInstanceAddedSignal("BUTTON"):Connect(added);
    local v8 = next;
    local v9, v10 = CollectionService:GetTagged("BUTTON");

    for _, v in v8, v9, v10 do
        task.spawn(function() -- Line: 61
            -- upvalues: added (ref), v (copy)
            added(v);
        end);
    end;
end;

return v3;