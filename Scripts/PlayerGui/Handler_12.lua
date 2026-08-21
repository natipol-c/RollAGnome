--[[
  Type:     LocalScript
  Method:   cached
  Name:     Handler
  Path:     game.Players.Palukalima37806.PlayerGui.Notifications.Frame.OnboardingBridgeMessage.Handler
  Service:  PlayerGui
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:43 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
local v2 = Library.get("Network");
script.Parent.Visible = ReplicatedStorage:GetAttribute("CraftBridgeOnboarding");
ReplicatedStorage:GetAttributeChangedSignal("CraftBridgeOnboarding"):Connect(function() -- Line: 26, Name: update
    -- upvalues: ReplicatedStorage (copy)
    script.Parent.Visible = ReplicatedStorage:GetAttribute("CraftBridgeOnboarding");
end);
v2:BindEvents({
    ChangeBridgeMessage = function() -- Line: 35, Name: ChangeBridgeMessage
        -- upvalues: CollectionService (copy), u1 (copy), ReplicatedStorage (copy)
        script.Parent.Text = "Place the bridge";
        local u3 = u1(CollectionService:GetTagged("OnboardingBridge")[1], "Waypoint");
        u3.Enabled = true;
        local u4 = nil;
        u4 = ReplicatedStorage:GetAttributeChangedSignal("CraftBridgeOnboarding"):Connect(function() -- Line: 43
            -- upvalues: u3 (copy), u4 (ref)
            u3.Enabled = false;
            u4:Disconnect();
        end);
    end
});