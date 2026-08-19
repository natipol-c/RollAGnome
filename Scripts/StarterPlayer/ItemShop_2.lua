--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ItemShop
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.ItemShop
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:29 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
Library.get("Network");
local u2 = Library.get("Numbers");
local u3 = Library.get("Signal");
Library.get("SimpleTween");
local LocalPlayer = Players.LocalPlayer;
u1(LocalPlayer, "PlayerGui");
local u4 = u1(LocalPlayer, "Plot");
local v5 = {};
local u6 = nil;
local ProximityPrompt = script.ProximityPrompt;

local function close() -- Line: 34
    -- upvalues: u6 (ref), ProximityPrompt (copy)
    if u6 then
        u6:Disconnect();
    end;

    ProximityPrompt.Enabled = true;
end;

local function gotPlot(p7) -- Line: 41
    -- upvalues: u1 (copy), ReplicatedStorage (copy), u2 (copy), ProximityPrompt (copy), u6 (ref), u3 (copy), RunService (copy), LocalPlayer (copy)
    local v8 = u1(u1(p7, "Points"), "ItemShop");
    local u9 = u1(u1(u1(u1(v8, "RestockSign"), "Board"), "SurfaceGui"), "Label");
    local u10 = u1(v8, "ItemShop");

    local function updateRestockLabel() -- Line: 51
        -- upvalues: ReplicatedStorage (ref), u9 (copy), u2 (ref)
        local v11 = ReplicatedStorage:GetAttribute("RestockSecondsLeft") or 0;
        u9.Text = `Restocks in {u2.formatSemicolonTime(v11)}`;
    end;

    local v12 = ReplicatedStorage:GetAttribute("RestockSecondsLeft") or 0;
    u9.Text = `Restocks in {u2.formatSemicolonTime(v12)}`;
    ReplicatedStorage:GetAttributeChangedSignal("RestockSecondsLeft"):Connect(updateRestockLabel);
    ProximityPrompt.Parent = u10;
    ProximityPrompt.Triggered:Connect(function() -- Line: 60
        -- upvalues: ProximityPrompt (ref), u6 (ref), u3 (ref), RunService (ref), LocalPlayer (ref), u10 (copy)
        ProximityPrompt.Enabled = false;

        if u6 then
            u6:Disconnect();
        end;

        ProximityPrompt.Enabled = true;
        u3.Fire("OpenTab", "ItemShop");
        u6 = RunService.Heartbeat:Connect(function() -- Line: 66
            -- upvalues: LocalPlayer (ref), u10 (ref), u3 (ref), u6 (ref), ProximityPrompt (ref)
            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChild("HumanoidRootPart");
            end;

            if Character and (Character.Position - u10.Position).Magnitude >= 15 then
                u3.Fire("CloseTab", "ItemShop");

                if u6 then
                    u6:Disconnect();
                end;

                ProximityPrompt.Enabled = true;
            end;
        end);
    end);
end;

function v5.Initialize(p13) -- Line: 77
    -- upvalues: u4 (copy), gotPlot (copy), u3 (copy), u6 (ref), ProximityPrompt (copy)
    if u4.Value then
        gotPlot(u4.Value);
    else
        u4.Changed:Once(function() -- Line: 81
            -- upvalues: gotPlot (ref), u4 (ref)
            gotPlot(u4.Value);
        end);
    end;

    u3.new("ClosedItemShop"):Connect(function() -- Line: 86
        -- upvalues: u6 (ref), ProximityPrompt (ref)
        if u6 then
            u6:Disconnect();
        end;

        ProximityPrompt.Enabled = true;
    end);
end;

return v5;