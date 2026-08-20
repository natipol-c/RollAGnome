--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SystemMessages
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.SystemMessages
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:09 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("TextChatService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Players = game:GetService("Players");
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Network");
local u2 = Library.get("SimpleTween");
local u3 = Library.get("UsernameColor");
local Notifications = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Notifications");
local v4 = {};
local u5 = utf8.char(57344);

local function CreateGlobalAnnouncement(p6, p7, p8) -- Line: 31
    -- upvalues: u5 (copy), u3 (copy), Notifications (copy), u2 (copy)
    local v9 = script.Admin:Clone();
    v9.AdminName.Text = `[{p6}{u5}]: `;
    v9.AdminName.TextColor3 = u3.get(p6);
    v9.Message.Text = p8;
    v9.ImageLabel.Image = `rbxthumb://type=AvatarHeadShot&id={p7}&w=420&h=420`;
    v9.Parent = Notifications.Frame;
    v9.Visible = true;
    task.wait(5);
    u2:Tween(v9, 0.5, "Back", "In", {
        Size = UDim2.fromScale(0, 0)
    });
    task.wait(1);
    v9:Destroy();
end;

function v4.Initialize(p10) -- Line: 52
    -- upvalues: u1 (copy), CreateGlobalAnnouncement (copy)
    u1:BindEvents({
        GlobalAnnouncement = function(...) -- Line: 54, Name: GlobalAnnouncement
            -- upvalues: CreateGlobalAnnouncement (ref)
            task.spawn(CreateGlobalAnnouncement, ...);
        end
    });
end;

return v4;