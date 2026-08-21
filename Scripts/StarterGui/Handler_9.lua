--[[
  Type:     LocalScript
  Method:   decompile
  Name:     Handler
  Path:     game.StarterGui.Notifications.Frame.OnboardingMessage.Handler
  Service:  StarterGui
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:38 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
local v2 = Library.get("Network");
Library.get("Signal");
script.Parent.Visible = ReplicatedStorage:GetAttribute("Onboarding");
ReplicatedStorage:GetAttributeChangedSignal("Onboarding"):Connect(function() -- Line: 27, Name: update
    -- upvalues: ReplicatedStorage (copy)
    script.Parent.Visible = ReplicatedStorage:GetAttribute("Onboarding");
end);
v2:BindEvents({
    ChangeOnboardingMessage = function() -- Line: 36, Name: ChangeOnboardingMessage
        -- upvalues: CollectionService (copy), u1 (copy), ReplicatedStorage (copy)
        script.Parent.Text = "Put Fuel in Generator until it reaches 100% ";
        local u3 = u1(CollectionService:GetTagged("Generator")[1], "Waypoint");
        u3.Enabled = true;
        local u4 = nil;
        u4 = ReplicatedStorage:GetAttributeChangedSignal("Onboarding"):Connect(function() -- Line: 44
            -- upvalues: u3 (copy), u4 (ref)
            u3.Enabled = false;
            u4:Disconnect();
        end);
    end
});