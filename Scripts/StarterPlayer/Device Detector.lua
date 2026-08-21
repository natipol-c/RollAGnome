--[[
  Type:     LocalScript
  Method:   decompile
  Name:     Device Detector
  Path:     game.StarterPlayer.StarterPlayerScripts.Device Detector
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:41 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
require(script.StartMode)();
local LocalPlayer = Players.LocalPlayer;
local u1 = {
    [Enum.UserInputType.Keyboard] = "Keyboard",
    [Enum.UserInputType.Touch] = "Mobile"
};

for i = 1, 8 do
    u1[Enum.UserInputType["Gamepad" .. tostring(i)]] = "Controller";
end;

local u2 = nil;
UserInputService.LastInputTypeChanged:Connect(function(p3) -- Line: 31, Name: setDevice
    -- upvalues: u1 (copy), LocalPlayer (copy), u2 (ref)
    local v4 = u1[p3];

    if v4 then
        LocalPlayer:SetAttribute("Device", v4);

        if u2 ~= v4 then
            u2 = v4;
        end;
    end;
end);