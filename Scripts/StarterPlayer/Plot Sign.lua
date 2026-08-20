--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Plot Sign
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Plot Sign
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:09 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
require(ReplicatedStorage.Replication);
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
Library.get("Network");
Library.get("Numbers");
Library.get("Rebirth");
local PlotSign = ReplicatedStorage.Assets.Billboards.PlotSign;
local LocalPlayer = Players.LocalPlayer;
local u2 = u1(LocalPlayer, "Plot");
local Plots = workspace:WaitForChild("Plots");
local Folder = Instance.new("Folder");
Folder.Name = "HiddenPlots";
Folder.Parent = ReplicatedStorage;
local v3 = {};
local u4 = {};

local function hidePlot(p5) -- Line: 41
end;

local function showPlot(p6) -- Line: 47
end;

local function hideEmptyPlots() -- Line: 53
    -- upvalues: Plots (copy)
    local v7 = next;
    local v8, v9 = Plots:GetChildren();

    for _, v in v7, v8, v9 do
        if v:IsA("Model") then
            v:GetAttribute("TakenBy");
        end;
    end;
end;

function v3.Initialize(p10) -- Line: 63
    -- upvalues: LocalPlayer (copy), u2 (copy), PlotSign (copy), u1 (copy), u4 (copy), hideEmptyPlots (copy), Plots (copy), Players (copy)
    local function PlayerAdded(u11) -- Line: 65
        -- upvalues: LocalPlayer (ref), u2 (ref), PlotSign (ref), u1 (ref), u4 (ref)
        if u11 == LocalPlayer then
            task.spawn(function() -- Line: 67
                -- upvalues: u2 (ref), u11 (copy), PlotSign (ref)
                if not u2.Value then
                    repeat
                        task.wait(0.1);
                    until u2.Value ~= nil;
                end;

                if u2.Value:FindFirstChild("PlotSign") then
                    return;
                end;

                local v12 = u11:GetAttribute("BigHeadshot");

                if not v12 then
                    repeat
                        task.wait(0.1);
                    until u11:GetAttribute("BigHeadshot");

                    v12 = u11:GetAttribute("BigHeadshot");
                end;

                local v13 = PlotSign:Clone();
                v13.Frame.PlayerIcon.Image = v12;
                v13.Parent = u2.Value:WaitForChild("PlotBillboard", 5);
            end);

            return;
        end;

        local v14 = u1(u11, "Plot");

        if not v14 then
            return;
        end;

        if not v14.Value then
            repeat
                task.wait(0.1);
            until v14.Value ~= nil;
        end;

        u4[u11] = v14.Value;

        if v14.Value:FindFirstChild("PlotSign") then
            return;
        end;

        local v15 = u11:GetAttribute("BigHeadshot");

        if not v15 then
            repeat
                task.wait(0.1);
            until u11:GetAttribute("BigHeadshot");

            v15 = u11:GetAttribute("BigHeadshot");
        end;

        local v16 = PlotSign:Clone();
        v16.Frame.PlayerIcon.Image = v15;
        v16.Frame.PlayerName.Text = u11.DisplayName .. "\'s Plot";
        v16.Parent = v14.Value:WaitForChild("PlotBillboard", 5);
    end;

    local function PlayerRemoving(p17) -- Line: 109
        -- upvalues: LocalPlayer (ref), u4 (ref)
        if p17 == LocalPlayer then
            return;
        end;

        if u4[p17] then
            u4[p17] = nil;
        end;
    end;

    hideEmptyPlots();
    Plots.ChildAdded:Connect(function(p18) -- Line: 121
        if p18:IsA("Model") then
            p18:GetAttribute("TakenBy");
        end;
    end);
    PlayerAdded(LocalPlayer);

    for _, v in ipairs(Players:GetPlayers()) do
        PlayerAdded(v);
    end;

    Players.PlayerAdded:Connect(PlayerAdded);
    Players.PlayerRemoving:Connect(PlayerRemoving);
end;

return v3;