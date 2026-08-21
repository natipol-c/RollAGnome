--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Tutorial
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Tutorial
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:40 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Replication = require(ReplicatedStorage.Replication);
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
local u2 = Library.get("Beam");
local u3 = Library.get("Network");
local u4 = Library.get("Signal");
local u5 = Library.get("SimpleTween");
local LocalPlayer = Players.LocalPlayer;
local u6 = u1(LocalPlayer, "Plot");
local _ = script.Highlight;
local v7 = {};

local function gotPlot(p8) -- Line: 35
    -- upvalues: LocalPlayer (copy), u1 (copy), ReplicatedStorage (copy), Replication (copy), u3 (copy), u4 (copy), u2 (copy), u5 (copy)
    local v9 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
    local v10 = u1(v9, "HumanoidRootPart");

    if not v10 then
        repeat
            task.wait(0.1);
        until v9:FindFirstChild("HumanoidRootPart");
    end;

    repeat
        task.wait(0.1);
    until ReplicatedStorage:GetAttribute("DataLoaded");

    if Replication.Data.tutorial then
        return;
    end;

    u3:FireServer("Tutorial");
    u4.Fire("FlipCamera");
    LocalPlayer:SetAttribute("DisableButtons", true);
    task.wait(1);
    u4.Fire("TutorialMessage", "Roll a Gnome!");
    local v11 = u1(p8, "RNG");
    local v12 = u1(u1(v11, "RNGButton"), "Press");
    local v13 = u2.new({
        One = v10,
        Two = v12
    });

    repeat
        task.wait(0.1);
    until LocalPlayer:GetAttribute("PressedButton");

    u3:FireServer("TutorialStep", 2);
    u4.Fire("TutorialMessage");

    if v13 then
        v13:Destroy();
    end;

    repeat
        task.wait(0.1);
    until LocalPlayer:GetAttribute("RolledGnome");

    u3:FireServer("TutorialStep", 3);
    u4.Fire("TutorialMessage", "Buy the Gnome!");
    local v14 = u1(v11, "Preview");
    local v15 = v14:GetChildren()[1] or v14.ChildAdded:Wait();

    if not v15.PrimaryPart then
        repeat
            task.wait();
        until v15.PrimaryPart ~= nil;
    end;

    local v16 = u2.new({
        One = v10,
        Two = v15.PrimaryPart
    });

    repeat
        task.wait(0.1);
    until LocalPlayer:GetAttribute("BoughtGnome");

    if v16 then
        v16:Destroy();
    end;

    u3:FireServer("TutorialStep", 4);
    u4.Fire("TutorialMessage");
    task.wait(0.5);
    u4.Fire("TutorialMessage", "Open Upgrades!");
    LocalPlayer:SetAttribute("DisableButtons", false);
    u4.Fire("UpgradeButtonOutline", true);

    repeat
        task.wait(0.1);
    until LocalPlayer:GetAttribute("OpenedUpgrades");

    u3:FireServer("TutorialStep", 5);
    u4.Fire("GardenUpgradeOutline", true);
    u4.Fire("TutorialMessage", "Purchase \'Garden\'!");

    repeat
        task.wait(0.1);
    until LocalPlayer:GetAttribute("BoughtGarden");

    u3:FireServer("TutorialStep", 6);
    u4.Fire("GardenUpgradeOutline", false);
    u4.Fire("TutorialMessage", "Close Upgrades");
    u4.Fire("CloseUpgradesPointer", true);

    repeat
        task.wait(0.1);
    until LocalPlayer:GetAttribute("ClosedUpgrades");

    u3:FireServer("TutorialStep", 7);
    u4.Fire("CloseUpgradesPointer", false);
    u4.Fire("TutorialMessage");
    task.wait(0.5);
    u4.Fire("TutorialMessage", "Place your Gnome!");
    local TutorialPart = p8:WaitForChild("TutorialPart");
    local v17 = u2.new({
        One = v10,
        Two = TutorialPart
    });
    local u18 = true;
    task.spawn(function() -- Line: 143
        -- upvalues: TutorialPart (copy), u18 (ref), u5 (ref)
        TutorialPart.Position = TutorialPart.Position + Vector3.new(0, 5, 0);

        while u18 do
            local v19 = TutorialPart:Clone();
            v19.Size = v19.Size + Vector3.new(0, 10, 0);
            v19.Transparency = 0.4;
            v19:PivotTo(TutorialPart:GetPivot() - Vector3.new(0, 11, 0));
            v19.Color = Color3.fromRGB(0, 129, 255);
            v19.CanCollide = false;
            v19.CanQuery = false;
            v19.CastShadow = false;
            v19.Parent = workspace;
            u5:Tween(v19, 1, "Quad", "InOut", {
                Transparency = 1,
                Position = TutorialPart.Position + Vector3.new(0, 7, 0)
            }).Completed:Wait();
            v19:Destroy();
        end;
    end);

    repeat
        task.wait(0.1);
    until LocalPlayer:GetAttribute("PlacedGnome");

    if v17 then
        v17:Destroy();
    end;

    u3:FireServer("TutorialStep", 8);
    u4.Fire("TutorialMessage", "Wait for your Gnome to plant a carrot!");
    u18 = false;
    TutorialPart.Position = TutorialPart.Position - Vector3.new(0, 2, 0);

    repeat
        task.wait(0.1);
    until LocalPlayer:GetAttribute("GnomePlanted");

    u3:FireServer("TutorialStep", 9);
    local Plants = p8:WaitForChild("Plants");
    local v20 = Plants:GetChildren()[1] or Plants.ChildAdded:Wait();
    u4.Fire("TutorialMessage", "Wait for your carrot to grow.");

    repeat
        task.wait(0.1);
    until v20:GetAttribute("READY");

    u3:FireServer("TutorialStep", 10);
    u4.Fire("TutorialMessage", "Collect your carrot by walking up to it.");
    local v21 = u2.new({
        One = v10,
        Two = v20:FindFirstChild("CenterPart")
    });

    repeat
        task.wait(0.1);
    until LocalPlayer:GetAttribute("CollectedPlant");

    if v21 then
        v21:Destroy();
    end;

    u4.Fire("TutorialMessage");
    task.wait(0.5);
    u3:FireServer("TutorialStep", 11);
    u4.Fire("TutorialMessage", "Sell your carrot!");
    local v22 = u1(u1(u1(p8, "Points"), "Sell"), "Sell");
    u2.new({
        Distance = 10,
        One = v10,
        Two = v22
    });
    u4.Fire("SellInventory", true);

    repeat
        task.wait(0.1);
    until LocalPlayer:GetAttribute("SoldPlant");

    u3:FireServer("TutorialStep", 12);
    u4.Fire("TutorialMessage");
    task.wait(0.5);
    local u23 = u1(u1(LocalPlayer, "leaderstats"), "Money");

    local function update() -- Line: 236
        -- upvalues: u4 (ref), u23 (copy)
        u4.Fire("TutorialMessage", `Earn ${50}! (${u23.Value}/${50})`, true);
    end;

    u4.Fire("TutorialMessage", `Earn ${50}! (${u23.Value}/${50})`, true);
    local v24 = u23.Changed:Connect(update);

    repeat
        task.wait(0.1);
    until u23.Value >= 50;

    v24:Disconnect();
    u3:FireServer("TutorialStep", 13);
    u4.Fire("TutorialMessage");
    task.wait(0.5);
    u4.Fire("TutorialMessage", "Open Upgrades and Upgrade your Rolls!");
    u4.Fire("UpgradeButtonOutline", true);
    u4.Fire("PodiumRollsOutline", true);

    repeat
        task.wait(0.1);
    until LocalPlayer:GetAttribute("UpgradedRolls");

    u3:FireServer("TutorialStep", 14);
    u4.Fire("PodiumRollsOutline", false);
    u4.Fire("TutorialMessage");
    task.wait(1);
    u4.Fire("TutorialMessage", "That\'s it! Roll better Gnomes to Grow a HUGE Garden!");
    task.wait(6);
    u4.Fire("TutorialMessage");
end;

function v7.Initialize(p25) -- Line: 268
    -- upvalues: u6 (copy), gotPlot (copy)
    if u6.Value then
        gotPlot(u6.Value);

        return;
    end;

    u6.Changed:Once(function() -- Line: 273
        -- upvalues: gotPlot (ref), u6 (ref)
        gotPlot(u6.Value);
    end);
end;

return v7;