--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     StartMode
  Path:     game.StarterPlayer.StarterPlayerScripts.Device Detector.StartMode
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:29 2026
]]

-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;

return function() -- Line: 10, Name: set_InitialDevice
    -- upvalues: UserInputService (copy), LocalPlayer (copy)
    LocalPlayer:SetAttribute("Device", UserInputService.GamepadEnabled and "Controller" or (UserInputService.KeyboardEnabled and "Keyboard" or (UserInputService.TouchEnabled and "Mobile" or "Keyboard")));
end;