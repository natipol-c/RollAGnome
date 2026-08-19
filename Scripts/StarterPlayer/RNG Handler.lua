--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     RNG Handler
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.RNG Handler
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:29 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("CollectionService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
local u2 = Library.get("Network");
local u3 = Library.get("Products");
local u4 = Library.get("Signal");
local u5 = Library.get("SimpleTween");
local _ = ReplicatedStorage.Assets;
local LocalPlayer = Players.LocalPlayer;
local u6 = u1(LocalPlayer, "Plot");
local v7 = {};

local function gotPlot(p8) -- Line: 32
    -- upvalues: u1 (copy), LocalPlayer (copy), u5 (copy), u2 (copy), ReplicatedStorage (copy), u4 (copy), u3 (copy)
    local v9 = u1(p8, "RNG");
    local v10 = u1(v9, "Preview");
    local u11 = u1(u1(v9, "RNGButton"), "Press");
    local v12 = u1(u11, "ClickDetector");
    local u13 = false;
    v12.MouseClick:Connect(function() -- Line: 43
        -- upvalues: LocalPlayer (ref), u13 (ref), u11 (copy), u5 (ref), u2 (ref), ReplicatedStorage (ref)
        if LocalPlayer:GetAttribute("Rolling") then
            return;
        end;

        if u13 then
            return;
        end;

        u13 = true;
        _G.Play("ButtonPress", u11);
        u11.Color = Color3.fromRGB(255, 255, 255);
        local u14 = u11:Clone();
        u14:ClearAllChildren();
        u14.CanCollide = false;
        u14.Parent = workspace;
        u14.Color = Color3.fromRGB(255, 255, 255);
        u14.Transparency = 0.7;
        u5:Tween(u14, 0.3, "Quint", "Out", {
            Transparency = 1,
            Size = Vector3.new(u14.Size.X * 3, u14.Size.Y, u14.Size.Z * 3)
        }, nil, function() -- Line: 64
            -- upvalues: u14 (copy)
            u14:Destroy();
        end);
        local CFrame2 = u11.CFrame;
        u11:PivotTo(u11:GetPivot() * CFrame.new(0, -0.3, 0));
        u5:Tween(u11, 0.2, "Quad", "InOut", {
            CFrame = CFrame2,
            Color = Color3.fromRGB(169, 0, 0)
        });
        local v15 = u2:InvokeServer("Roll");
        task.wait();

        if not v15 then
            warn("BRUH");
        end;

        local v16 = ReplicatedStorage:GetAttribute("IsDay");
        u11.Color = (v16 == nil and true or v16) and Color3.fromRGB(65, 159, 24) or Color3.fromRGB(170, 0, 170);
        task.wait(0.2);
        u13 = false;
    end);

    local function updateButton() -- Line: 94
        -- upvalues: ReplicatedStorage (ref), LocalPlayer (ref), u11 (copy)
        local v17 = ReplicatedStorage:GetAttribute("IsDay");

        if LocalPlayer:GetAttribute("Rolling") then
            return;
        end;

        u11.Color = v17 and Color3.fromRGB(65, 159, 24) or Color3.fromRGB(170, 0, 170);
    end;

    updateButton();
    ReplicatedStorage:GetAttributeChangedSignal("IsDay"):Connect(updateButton);
    local u18 = u1(u1(v9, "AutoRoll"), "Press");
    local v19 = u1(u18, "BillboardGui");
    local u20 = u1(v19, "Label");
    local u21 = u1(v19, "Stop");
    local v22 = u1(u18, "ClickDetector");
    local u23 = false;
    v22.MouseClick:Connect(function() -- Line: 116
        -- upvalues: u23 (ref), u18 (copy), u5 (ref), LocalPlayer (ref), u2 (ref), u4 (ref), u3 (ref)
        if u23 then
            return;
        end;

        u23 = true;
        _G.Play("ButtonPress", u18);
        u18.Color = Color3.fromRGB(255, 255, 255);
        local u24 = u18:Clone();
        u24:ClearAllChildren();
        u24.CanCollide = false;
        u24.Parent = workspace;
        u24.Color = Color3.fromRGB(255, 255, 255);
        u24.Transparency = 0.7;
        u5:Tween(u24, 0.3, "Quint", "Out", {
            Transparency = 1,
            Size = Vector3.new(u24.Size.X * 3, u24.Size.Y, u24.Size.Z * 3)
        }, nil, function() -- Line: 137
            -- upvalues: u24 (copy)
            u24:Destroy();
        end);
        local CFrame2 = u18.CFrame;
        u18:PivotTo(u18:GetPivot() * CFrame.new(0, -0.3, 0));
        u5:Tween(u18, 0.2, "Quad", "InOut", {
            CFrame = CFrame2,
            Color = Color3.fromRGB(255, 162, 0)
        });

        if not LocalPlayer:GetAttribute("AutoRolling") then
            if u3.check("Auto Roll") then
                u4.Fire("OpenTab", "AutoRoll");
            else
                u3.prompt("Auto Roll", "gamepass");
            end;

            task.wait(0.2);
            u23 = false;

            return;
        end;

        u2:FireServer("SetAutoRolling", false);
        u4.Fire("StopAutoRoll");
        task.wait(0.2);
        u23 = false;
    end);

    local function updateAutoButton() -- Line: 176
        -- upvalues: LocalPlayer (ref), u18 (copy), u20 (copy), u21 (copy)
        local v25 = LocalPlayer:GetAttribute("AutoRolling");
        u18.Color = v25 and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 162, 0);
        u20.Visible = not v25;
        u21.Visible = v25;
    end;

    local v26 = LocalPlayer:GetAttribute("AutoRolling");
    u18.Color = v26 and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 162, 0);
    u20.Visible = not v26;
    u21.Visible = v26;
    LocalPlayer:GetAttributeChangedSignal("AutoRolling"):Connect(updateAutoButton);

    local function added(u27) -- Line: 190
        -- upvalues: u5 (ref), u1 (ref), LocalPlayer (ref), u2 (ref)
        local v28 = u27:GetScale();
        u27:ScaleTo(v28 * 0.8);
        local NumberValue = Instance.new("NumberValue");
        NumberValue.Value = u27:GetScale();
        u5:Tween(NumberValue, 0.25, "Back", "Out", {
            Value = v28
        });
        NumberValue.Changed:Connect(function() -- Line: 202
            -- upvalues: u27 (copy), NumberValue (copy)
            u27:ScaleTo(NumberValue.Value);
        end);
        local v29 = script.Attachment:Clone();
        v29.Parent = u27;
        local v30 = u1(v29, "ProximityPrompt");
        local u31 = nil;
        local u32 = nil;
        local u33 = false;

        if game:GetService("UserInputService").TouchEnabled then
            v30.Style = "Default";
        end;

        local function cleanup() -- Line: 219
            -- upvalues: u33 (ref), u31 (ref), u32 (ref)
            if u33 then
                return;
            end;

            u33 = true;

            if u31 then
                u31:Disconnect();
                u31 = nil;
            end;

            if u32 then
                u32:Disconnect();
                u32 = nil;
            end;
        end;

        u31 = v30.Triggered:Connect(function(p34) -- Line: 234
            -- upvalues: LocalPlayer (ref), u2 (ref), u27 (copy)
            if p34 ~= LocalPlayer then
                return;
            end;

            u2:FireServer("BuyFarmer", u27);
        end);
        u32 = u27.Destroying:Once(cleanup);
    end;

    for _, child in ipairs(v10:GetChildren()) do
        added(child);
    end;

    v10.ChildAdded:Connect(added);
end;

function v7.Initialize(p35) -- Line: 248
    -- upvalues: u2 (copy), LocalPlayer (copy), u6 (copy), gotPlot (copy)
    u2:BindEvents({
        EquipTutorialGnome = function(p36) -- Line: 250, Name: EquipTutorialGnome
            -- upvalues: LocalPlayer (ref)
            if LocalPlayer:GetAttribute("Device") ~= "Mobile" then
                return;
            end;

            local v37 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();

            if v37 then
                v37 = v37:FindFirstChildWhichIsA("Humanoid");
            end;

            local Backpack = LocalPlayer:FindFirstChild("Backpack");

            if not (v37 and Backpack) then
                return;
            end;

            local v38 = os.clock();
            local v39 = nil;

            while true do
                if v39 or os.clock() - v38 >= 2 then
                    if v39 then
                        v37:EquipTool(v39);
                    end;

                    return;
                end;

                for _, child in Backpack:GetChildren() do
                    if child:IsA("Tool") and child:GetAttribute("Id") == p36 then
                        v39 = child;
                        break;
                    end;
                end;

                if not v39 then
                    task.wait();
                end;
            end;
        end
    });

    if u6.Value then
        gotPlot(u6.Value);

        return;
    end;

    u6.Changed:Once(function() -- Line: 281
        -- upvalues: gotPlot (ref), u6 (ref)
        gotPlot(u6.Value);
    end);
end;

return v7;