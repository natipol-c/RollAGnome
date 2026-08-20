--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Received
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Received
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:07 2026
]]

-- Decompiled with Potassium's decompiler.

local GamepadService = game:GetService("GamepadService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("ContentProvider");
require(ReplicatedStorage.Replication);
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Network");
local u2 = Library.get("SimpleTween");
Library.get("Numbers");
Library.get("Signal");
local u3 = Library.get("Rarities");
local LocalPlayer = Players.LocalPlayer;
local Frames = game.Lighting.Frames;
local v4 = {};
local u5 = {};
local u6 = {};
local u7 = false;
local u8 = false;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;

local function close() -- Line: 43
    -- upvalues: u5 (ref)
    for _, v in next, u5 do
        v:Cancel();
    end;

    u5 = {};
end;

local function received(u13) -- Line: 51
    -- upvalues: u8 (ref), u6 (copy), u9 (ref), ReplicatedStorage (copy), u10 (ref), u12 (ref), u11 (ref), u3 (copy), Frames (copy), u2 (copy), LocalPlayer (copy), GamepadService (copy), u5 (ref), u7 (ref), received (copy)
    if u8 then
        u6[#u6 + 1] = u13;

        return;
    end;

    u9.TextLabel.Visible = false;
    u8 = true;
    ReplicatedStorage:SetAttribute("FrameOpen", true);
    local u14 = nil;
    u9.Button.Visible = false;
    u10.Size = UDim2.fromScale(0, 0.17);
    u9.DarkColor.BackgroundTransparency = 1;
    local Naming = u12.Naming;
    Naming.ItemName.Size = UDim2.fromScale(1, 1);
    Naming.Frame.Size = UDim2.fromScale(0.03, 1);
    Naming.ItemName.Text = u13.name;
    Naming.Frame.Size = UDim2.new(0.03, Naming.ItemName.TextBounds.X, 1, 0);
    u11.Icon.Image = u13.image or "";
    u3:SetLabel(u13.rarity, u12.Rarity);
    _G.Play("ReceivedSFX");
    task.delay(0.5, function() -- Line: 83
        -- upvalues: Frames (ref), u2 (ref)
        Frames.Size = 0;
        Frames.Enabled = true;
        u2:Tween(Frames, 0.3, "Sine", "Out", {
            Size = 10
        });
    end);
    u9.Enabled = true;
    u2:Tween(u10, 0.5, "Quint", "Out", {
        Size = UDim2.fromScale(1, 0.17)
    });
    u2:Tween(u9.DarkColor, 0.5, "Quint", "Out", {
        BackgroundTransparency = 0.3
    });
    u9.Info.Icon.Size = UDim2.fromScale(0, 0);
    u9.Info.Frame.Position = UDim2.fromScale(-0.45, 0.525);
    u2:Tween(u12, 0.5, "Quint", "Out", {
        Position = UDim2.fromScale(0.45, 0.56)
    }, nil, function() -- Line: 105
        -- upvalues: u2 (ref), u9 (ref)
        u2:Tween(u9.Info.Icon, 0.4, "Back", "Out", {
            Size = UDim2.fromScale(1.2, 1.2)
        });
    end);
    task.wait(1);

    if LocalPlayer:GetAttribute("Device") == "Controller" and not GamepadService.GamepadCursorEnabled then
        GamepadService:EnableGamepadCursor(nil);
    end;

    u9.TextLabel.Visible = true;
    u9.Button.Visible = true;
    u14 = u9.Button.MouseButton1Click:Connect(function() -- Line: 122
        -- upvalues: u8 (ref), u14 (ref), LocalPlayer (ref), GamepadService (ref), u9 (ref), u5 (ref), Frames (ref), u7 (ref), u6 (ref), received (ref), u13 (copy)
        u8 = false;
        u14:Disconnect();

        if LocalPlayer:GetAttribute("Device") == "Controller" then
            GamepadService:DisableGamepadCursor();
        end;

        u9.Enabled = false;

        for _, v in next, u5 do
            v:Cancel();
        end;

        u5 = {};
        Frames.Enabled = false;
        u7 = true;

        if #u6 > 0 then
            for i, v in next, u6 do
                u6[i] = nil;
                received(v);
            end;
        end;

        if u13.Callback then
            u13.Callback();
        end;
    end);
end;

function v4.Start(p15, p16) -- Line: 150
    -- upvalues: u9 (ref), u10 (ref), u11 (ref), u12 (ref), u1 (copy), received (copy)
    u9 = p16.Parent:WaitForChild("Received");
    u10 = u9.BlackFrame;
    u11 = u9.Info;
    u12 = u11.Frame;
    u1:BindEvents({
        Received = function(...) -- Line: 158, Name: Received
            -- upvalues: received (ref)
            received(...);
        end
    });
end;

return v4;