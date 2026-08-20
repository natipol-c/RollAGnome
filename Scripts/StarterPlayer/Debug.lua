--[[
  Type:     LocalScript
  Method:   decompile
  Name:     Debug
  Path:     game.StarterPlayer.StarterPlayerScripts.Debug
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:09 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Replication);
local v1 = require(ReplicatedStorage.Library).get("Numbers");
local LocalPlayer = Players.LocalPlayer;

if LocalPlayer.UserId ~= 157086476 and LocalPlayer.UserId ~= 63311152 then
    return;
end;

local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "CoordsHud";
ScreenGui.ResetOnSpawn = false;
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
local TextLabel = Instance.new("TextLabel");
TextLabel.Name = "Readout";
TextLabel.AnchorPoint = Vector2.new(0, 1);
TextLabel.Position = UDim2.new(0, 10, 1, -10);
TextLabel.Size = UDim2.new(0, 0, 0, 26);
TextLabel.AutomaticSize = Enum.AutomaticSize.X;
TextLabel.BackgroundTransparency = 0.35;
TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
TextLabel.BorderSizePixel = 0;
TextLabel.Font = Enum.Font.Code;
TextLabel.TextSize = 16;
TextLabel.TextColor3 = Color3.new(1, 1, 1);
TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
TextLabel.Parent = ScreenGui;
local v2 = 0;

while true do
    TextLabel.Text = ` Time Played: {v1.FormatTimePriority(v2)} `;
    v2 = v2 + 1;
    task.wait(1);
end;