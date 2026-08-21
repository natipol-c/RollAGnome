--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Main
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Main
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

local function updateMobileButtons() -- Line: 45
    -- upvalues: UserInputService (copy), ReplicatedStorage (copy), u8 (ref), u9 (ref)
    if not UserInputService.TouchEnabled then
        return;
    end;

    local v12 = ReplicatedStorage:GetAttribute("FrameOpen") == true;

    if u8 then
        u8.Visible = not v12;
    end;

    if u9 then
        u9.Visible = not v12;
    end;
end;

local function canSendGameInvite(u13) -- Line: 57
    -- upvalues: SocialService (copy)
    local success, result = pcall(function() -- Line: 58
        -- upvalues: SocialService (ref), u13 (copy)
        return SocialService:CanSendGameInviteAsync(u13);
    end);

    return success and result;
end;

function v6.Start(p14, p15) -- Line: 64
    -- upvalues: u7 (ref), u8 (ref), u4 (copy), u10 (ref), u11 (ref), u9 (ref), UserInputService (copy), ReplicatedStorage (copy), updateMobileButtons (copy), u5 (copy), u3 (copy)
    u7 = p15;
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

    if UserInputService.TouchEnabled then
        local v16 = ReplicatedStorage:GetAttribute("FrameOpen") == true;

        if u8 then
            u8.Visible = not v16;
        end;

        if u9 then
            u9.Visible = not v16;
        end;
    end;

    ReplicatedStorage:GetAttributeChangedSignal("FrameOpen"):Connect(updateMobileButtons);
    local u17 = false;
    u5.new():setImage("rbxassetid://136218027159968"):align(UserInputService.TouchEnabled and "Right" or "Left"):bindEvent("selected", function(p18) -- Line: 90
        -- upvalues: u17 (ref), u3 (ref)
        _G.Play("Tap");
        p18:deselect();

        if not u17 then
            u17 = true;
            u3.Fire("ToggleTab", "Settings");
            task.wait(0.2);
            u17 = false;
        end;
    end);
end;

function Buttons()
    -- upvalues: u8 (ref), u9 (ref), u4 (copy), LocalPlayer (copy), SocialService (copy), u3 (copy), u2 (copy), u1 (copy)
    task.spawn(function() -- Line: 107
        -- upvalues: u8 (ref), u9 (ref), u4 (ref), LocalPlayer (ref), SocialService (ref), u3 (ref), u2 (ref), u1 (ref)
        local v19 = u8.Frame:GetChildren();
        local v20 = next;
        local v21, v22 = u9:GetChildren();
        local u23 = false;

        for _, v in v20, v21, v22 do
            table.insert(v19, v);
        end;

        for _, v in next, v19 do
            if v:IsA("Frame") then
                u4(v, "Button").MouseButton1Click:Connect(function() -- Line: 120
                    -- upvalues: LocalPlayer (ref), u23 (ref), v (copy), SocialService (ref), u3 (ref), u2 (ref), u1 (ref)
                    if LocalPlayer:GetAttribute("DisableButtons") then
                        return;
                    end;

                    if u23 then
                        return;
                    end;

                    u23 = true;

                    if v.Name == "Invite" then
                        local u24 = LocalPlayer;
                        local success, result = pcall(function() -- Line: 58
                            -- upvalues: SocialService (ref), u24 (copy)
                            return SocialService:CanSendGameInviteAsync(u24);
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
                    u23 = false;
                end);
            end;
        end;
    end);
end;

return v6;