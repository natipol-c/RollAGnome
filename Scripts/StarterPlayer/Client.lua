--[[
  Type:     LocalScript
  Method:   decompile
  Name:     Client
  Path:     game.StarterPlayer.StarterPlayerScripts.Client
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:07 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local StarterGui = game:GetService("StarterGui");
game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local Library = require(ReplicatedStorage.Library);
local Replication = require(ReplicatedStorage:WaitForChild("Replication", 5));
local v1 = Library.get("Network");
local u2 = Library.get("Products");
local _ = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;

if not LocalPlayer.Character then
    LocalPlayer.CharacterAdded:Wait();
end;

local u3 = {};

function get(p4)
    -- upvalues: u3 (copy)
    if not p4 then
        return;
    end;

    local Name = p4.Name;

    if u3[Name] then
        return u3[Name];
    end;

    if p4:IsA("ModuleScript") then
        u3[Name] = require(p4);

        return u3[Name];
    end;
end;

local function disableReset() -- Line: 45
    -- upvalues: StarterGui (copy)
    task.spawn(function() -- Line: 46
        -- upvalues: StarterGui (ref)
        while not pcall(function() -- Line: 48
            -- upvalues: StarterGui (ref)
            StarterGui:SetCore("ResetButtonCallback", false);
        end) do
            task.wait(1);
        end;
    end);
end;

function _G.GetClientModule(p5) -- Line: 90
    -- upvalues: u3 (copy)
    if not u3[p5] then
        task.wait(0.5);
    end;

    return u3[p5];
end;

v1:BindEvents({
    prompt_gamepass = function(p6) -- Line: 99, Name: prompt_gamepass
        -- upvalues: u2 (copy)
        u2.prompt(p6, "gamepass");
    end,

    prompt_product = function(p7) -- Line: 103, Name: prompt_product
        -- upvalues: u2 (copy)
        if not p7 then
            return;
        end;

        u2.prompt(p7, "product");
    end
});
UserInputService.WindowFocused:Connect(function() -- Line: 110
    _G.InWindow = true;
end);
UserInputService.WindowFocusReleased:Connect(function() -- Line: 114
    _G.InWindow = false;
end);
task.wait();
(function() -- Line: 57, Name: Initialize
    -- upvalues: Replication (copy), ReplicatedStorage (copy), Library (copy)
    Replication:Initialize();

    repeat
        task.wait(0.1);
    until ReplicatedStorage:GetAttribute("DataLoaded");

    Library:Initialize();
    local v8 = next;
    local v9, v10 = script:GetChildren();

    for _, v in v8, v9, v10 do
        if v:IsA("ModuleScript") then
            task.spawn(function() -- Line: 67
                -- upvalues: v (ref)
                v = get(v);

                if v.Initialize ~= nil then
                    v:Initialize();
                end;
            end);
        end;
    end;

    local v11 = next;
    local v12, v13 = script.Controllers:GetChildren();

    for _, v in v11, v12, v13 do
        if v:IsA("ModuleScript") then
            task.spawn(function() -- Line: 78
                -- upvalues: v (ref)
                v = get(v);

                if v.Initialize ~= nil then
                    v:Initialize();
                end;
            end);
        end;
    end;
end)();