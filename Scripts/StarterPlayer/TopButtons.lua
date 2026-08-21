--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     TopButtons
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.TopButtons
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:39 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local Library = require(ReplicatedStorage.Library);
require(ReplicatedStorage.Replication);
local u1 = Library.get("Find");
Library.get("Numbers");
Library.get("SimpleTween");
Library.get("Signal");
Library.get("Products");
local LocalPlayer = Players.LocalPlayer;
local Value = u1(LocalPlayer, "Plot").Value;
local u2 = nil;

return {
    Start = function(p3, p4) -- Line: 32, Name: Start
        -- upvalues: u2 (ref), u1 (copy), UserInputService (copy), LocalPlayer (copy), Value (ref)
        u2 = p4;
        u2 = u1(p4, "Frame");

        if UserInputService.TouchEnabled then
            u2.Parent.UIScale.Scale = 1.35;
        end;

        local v5 = next;
        local v6, v7 = u2:GetChildren();

        for _, v in v5, v6, v7 do
            if v:IsA("Frame") then
                local Button = v:WaitForChild("Button");
                local u8 = false;
                Button.MouseButton1Click:Connect(function() -- Line: 46
                    -- upvalues: u8 (ref), LocalPlayer (ref), v (copy), Value (ref), u1 (ref)
                    if u8 then
                        return;
                    end;

                    u8 = true;
                    local CurrentCamera = workspace.CurrentCamera;
                    local v9 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();

                    if v.Name == "Base" then
                        v9:PivotTo(Value:WaitForChild("Spawn"):GetPivot() + Vector3.new(0, 1, 0));
                    elseif v.Name == "Sell" then
                        v9:PivotTo(Value:WaitForChild("Teleports"):WaitForChild("Sell"):GetPivot() + Vector3.new(0, 1, 0));
                    elseif v.Name == "Shop" then
                        v9:PivotTo(Value:WaitForChild("Teleports"):WaitForChild("Shop"):GetPivot() + Vector3.new(0, 1, 0));
                    end;

                    CurrentCamera.CFrame = u1(v9, "Head").CFrame * CFrame.fromEulerAnglesXYZ(-0.17453292519943295, 0, 0);
                    task.wait(0.3);
                    u8 = false;
                end);
            end;
        end;
    end
};