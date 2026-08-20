--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Main
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Main
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:07 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("ContentProvider");
game:GetService("GuiService");
local UserInputService = game:GetService("UserInputService");
local SocialService = game:GetService("SocialService");
require(ReplicatedStorage.Replication);
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Network");
Library.get("Numbers");
local u2 = Library.get("Products");
local u3 = Library.get("Signal");
local u4 = Library.get("Find");
Library.get("Stats");
Library.get("SimpleTween");
local u5 = Library.get("TopbarPlus");
local _ = ReplicatedStorage.Assets;
local LocalPlayer = Players.LocalPlayer;
local _ = u4(LocalPlayer, "Plot").Value;
local _ = workspace.CurrentCamera;
local v6 = {};
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;

local function canSendGameInvite(u12) -- Line: 45
    -- upvalues: SocialService (copy)
    local success, result = pcall(function() -- Line: 46
        -- upvalues: SocialService (ref), u12 (copy)
        return SocialService:CanSendGameInviteAsync(u12);
    end);

    return success and result;
end;

function v6.Start(p13, p14) -- Line: 52
    -- upvalues: u7 (ref), u8 (ref), u4 (copy), u10 (ref), u11 (ref), u9 (ref), UserInputService (copy), u5 (copy), u3 (copy)
    u7 = p14;
    u8 = u4(u7, "Right");
    u10 = u4(u7, "Indicators");
    u11 = u4(u7, "Boosts");
    u9 = u4(u10, "OtherButtons");

    if UserInputService.TouchEnabled then
        u8.UIScale.Scale = 1.45;
        u8.Position = UDim2.fromScale(0.99, 0.45);
        u10.UIScale.Scale = 1.45;
        u10.Position = UDim2.fromScale(0.02, 0.4);
        u11.UIScale.Scale = 1.45;
    end;

    Buttons();
    local u15 = false;
    u5.new():setImage("rbxassetid://136218027159968"):align(UserInputService.TouchEnabled and "Right" or "Left"):bindEvent("selected", function(p16) -- Line: 76
        -- upvalues: u15 (ref), u3 (ref)
        _G.Play("Tap");
        p16:deselect();

        if not u15 then
            u15 = true;
            u3.Fire("ToggleTab", "Settings");
            task.wait(0.2);
            u15 = false;
        end;
    end);
end;

function Buttons()
    -- upvalues: u8 (ref), u9 (ref), u4 (copy), LocalPlayer (copy), SocialService (copy), u3 (copy), u2 (copy), u1 (copy)
    task.spawn(function() -- Line: 93
        -- upvalues: u8 (ref), u9 (ref), u4 (ref), LocalPlayer (ref), SocialService (ref), u3 (ref), u2 (ref), u1 (ref)
        local v17 = u8.Frame:GetChildren();
        local v18 = next;
        local v19, v20 = u9:GetChildren();
        local u21 = false;

        for _, v in v18, v19, v20 do
            table.insert(v17, v);
        end;

        for _, v in next, v17 do
            if v:IsA("Frame") then
                u4(v, "Button").MouseButton1Click:Connect(function() -- Line: 106
                    -- upvalues: LocalPlayer (ref), u21 (ref), v (copy), SocialService (ref), u3 (ref), u2 (ref), u1 (ref)
                    if LocalPlayer:GetAttribute("DisableButtons") then
                        return;
                    end;

                    if u21 then
                        return;
                    end;

                    u21 = true;

                    if v.Name == "Invite" then
                        local u22 = LocalPlayer;
                        local success, result = pcall(function() -- Line: 46
                            -- upvalues: SocialService (ref), u22 (copy)
                            return SocialService:CanSendGameInviteAsync(u22);
                        end);

                        if success and result then
                            local ExperienceInviteOptions = Instance.new("ExperienceInviteOptions");
                            ExperienceInviteOptions.PromptMessage = "Each friend gives a +5% $$$ Boost!";
                            SocialService:PromptGameInvite(LocalPlayer, ExperienceInviteOptions);
                        end;
                    elseif v.Name == "Upgrade" then
                        u3.Fire("CloseAllTabs");
                        u3.Fire("Open Upgrade Tree");
                    elseif v.Name == "AutoSell" then
                        if u2.check("Auto Sell") then
                            u1:FireServer("ToggleAutoSell");
                        else
                            u2.prompt("Auto Sell", "gamepass");
                        end;
                    else
                        u3.Fire("ToggleTab", v.Name);
                    end;

                    task.wait(0.2);
                    u21 = false;
                end);
            end;
        end;
    end);
end;

return v6;