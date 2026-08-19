--[[
  Type:     LocalScript
  Method:   decompile
  Name:     Camera
  Path:     game.StarterPlayer.StarterPlayerScripts.Camera
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:28 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
local v2 = Library.get("Network");
local v3 = Library.get("Signal");
local LocalPlayer = Players.LocalPlayer;
v2:BindEvents({
    ResetCamera = function() -- Line: 28, Name: ResetCamera
        -- upvalues: LocalPlayer (copy), u1 (copy)
        workspace.CurrentCamera.CFrame = u1(LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait(), "Head").CFrame * CFrame.fromEulerAnglesXYZ(-0.17453292519943295, 0, 0);
    end
});
v3.new("FlipCamera"):Connect(function() -- Line: 37
    -- upvalues: LocalPlayer (copy), u1 (copy)
    workspace.CurrentCamera.CFrame = u1(LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait(), "Head").CFrame * CFrame.fromEulerAnglesXYZ(0.3490658503988659, 2.9670597283903604, 0);
end);