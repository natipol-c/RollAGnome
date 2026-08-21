--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Notifications
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Notifications
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
local u2 = Library.get("Network");
Library.get("Numbers");
local u3 = Library.get("SimpleTween");
local u4 = Library.get("Signal");
local _ = Players.LocalPlayer;
local Presets = script.Presets;
local UIScale = script.UIScale;
local v5 = {};
local u6 = nil;
local u7 = nil;

local function Notification(p8) -- Line: 35
    -- upvalues: Presets (copy), UserInputService (copy), UIScale (copy), u7 (ref), u6 (ref), u3 (copy)
    local message = p8.message;
    local v9 = p8.color or Color3.fromRGB(255, 255, 255);
    local sound = p8.sound;
    local preset = p8.preset;
    local v10 = p8.wait or 5;
    local v11 = p8.bottom or false;

    if not message then
        print(p8);

        return;
    end;

    local u12 = preset and Presets:FindFirstChild(preset):Clone() or script.Title:Clone();
    u12.TextColor3 = v9;
    u12.Text = message;

    if UserInputService.TouchEnabled then
        UIScale:Clone().Parent = u12;
    end;

    u12:SetAttribute("Wait", v10);
    u12.Parent = v11 and u7 or u6;

    if sound then
        _G.Play(sound);
    end;

    task.delay(v10, function() -- Line: 60
        -- upvalues: u3 (ref), u12 (copy)
        u3:Tween(u12.UIStroke, 0.5, "Quad", "InOut", {
            Transparency = 1
        });
        u3:Tween(u12, 0.5, "Quad", "InOut", {
            TextTransparency = 1
        }, nil, function() -- Line: 67
            -- upvalues: u12 (ref)
            u12:Destroy();
        end);
    end);
end;

function v5.Start(p13, p14) -- Line: 73
    -- upvalues: u6 (ref), u1 (copy), u7 (ref), UserInputService (copy), u4 (copy), Notification (copy), u2 (copy), UIScale (copy)
    u6 = u1(p14.Parent, "Notifications").Frame;
    u6.Parent.Enabled = true;
    u7 = u1(p14.Parent, "Notifications").BottomFrame;

    if UserInputService.TouchEnabled then
        u6.Position = UDim2.fromScale(0.5, 0.15);
    end;

    u4.new("Notification"):Connect(Notification);
    u2:BindEvents({
        Notify = Notification
    });

    if not UserInputService.TouchEnabled then
        return;
    end;

    local v15 = next;
    local v16, v17 = u6:GetChildren();

    for _, v in v15, v16, v17 do
        if v:IsA("TextLabel") or v:IsA("Frame") then
            UIScale:Clone().Parent = v;
        end;
    end;

    local v18 = next;
    local v19, v20 = u7:GetChildren();

    for _, v in v18, v19, v20 do
        if v:IsA("TextLabel") or v:IsA("Frame") then
            UIScale:Clone().Parent = v;
        end;
    end;
end;

return v5;