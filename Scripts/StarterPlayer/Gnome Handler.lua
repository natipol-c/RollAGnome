--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Gnome Handler
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Gnome Handler
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:08 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local Animations = require(script.Animations);
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
local v2 = Library.get("Mouse");
local u3 = Library.get("Network");
local u4 = Library.get("Numbers");
local u5 = Library.get("Rarities");
local u6 = Library.get("Mutations");
local u7 = Library.get("Signal");
local u8 = Library.get("SimpleTween");
local u9 = Library.get("GnomeUtil");
local u10 = Library.get("Crops");
local u11 = Library.get("Levels");
local u12 = Library.get("Farmers");
local u13 = Library.get("Plants");
local Assets = ReplicatedStorage.Assets;
local Billboards = Assets.Billboards;
local FarmerInfo = Billboards.FarmerInfo;
local FarmerOverhead = Billboards.FarmerOverhead;
local LocalPlayer = Players.LocalPlayer;
local v14 = u1(LocalPlayer, "PlayerGui");
local u15 = v14:FindFirstChild("Billboards") or u1(v14, "BillboardGuis");
local Plot = LocalPlayer:FindFirstChild("Plot");
local u16 = v2.new();
local u17 = {};
local u18 = {};
local u19 = {};
local u20 = nil;
local u21 = nil;
local u22 = nil;
local u23 = nil;
local u24 = nil;
local u25 = {};
local u26 = {};
local u27 = false;
local u28 = nil;
local Part = Instance.new("Part");
local Highlight = script.Highlight;
Part.Name = "FarmerInfoPart";
Part.Anchored = true;
Part.CanCollide = false;
Part.CanTouch = false;
Part.CanQuery = false;
Part.Transparency = 1;
Part.Size = Vector3.new(1, 1, 1);
FarmerInfo.Parent = u15;
local v29 = {};
local u30 = RaycastParams.new();
u30.FilterType = Enum.RaycastFilterType.Include;

local function getRarityText(p31, p32) -- Line: 84
    -- upvalues: u4 (copy)
    return p32 and `1/{u4.Comma(p32)}` or p31.rarity;
end;

local function getPriceText(p33) -- Line: 88
    -- upvalues: u4 (copy)
    return p33 >= 100000 and u4.Suffix(p33) or u4.Comma(p33);
end;

local function getGnomeSpeedText(p34) -- Line: 92
    if p34 then
        p34 = p34:GetAttribute("GnomeSpeed");
    end;

    local v35 = type(p34) == "number" and p34 and p34 or 1;

    return v35 == 1 and "" or ` (x{string.format("%.1f", v35):gsub("%.0$", "")})`;
end;

local function updatePlantTime() -- Line: 103
    -- upvalues: FarmerInfo (copy), u20 (ref), u4 (copy), getGnomeSpeedText (copy)
    local Frame = FarmerInfo:FindFirstChild("Frame");

    if Frame then
        Frame = Frame:FindFirstChild("PlantTime");
    end;

    if not (Frame and Frame:IsA("TextLabel")) then
        return;
    end;

    local v36 = u20 and u20:GetAttribute("NextPlant");

    if type(v36) ~= "number" then
        Frame.Text = "";

        return;
    end;

    local v37 = v36 - workspace:GetServerTimeNow();
    local v38 = math.ceil(v37);
    local v39 = math.max(v38, 0);

    if v39 > 0 then
        Frame.Text = `{u4.formatSemicolonTime(v39)}{getGnomeSpeedText(u20)}`;
        Frame.TextColor3 = Color3.fromRGB(255, 0, 0);

        return;
    end;

    Frame.Text = `Ready to Plant{getGnomeSpeedText(u20)}`;
    Frame.TextColor3 = Color3.fromRGB(0, 255, 0);
end;

local function startPlantTime() -- Line: 124
    -- upvalues: u21 (ref), updatePlantTime (copy), RunService (copy)
    if u21 then
        u21:Disconnect();
    end;

    updatePlantTime();
    u21 = RunService.RenderStepped:Connect(updatePlantTime);
end;

local function stopPlantTime() -- Line: 133
    -- upvalues: u21 (ref)
    if u21 then
        u21:Disconnect();
        u21 = nil;
    end;
end;

local function setFarmerOverhead(p40, p41) -- Line: 140
    if p40 then
        p40 = p40:FindFirstChild("Overhead");
    end;

    if p40 and p40:IsA("BillboardGui") then
        p40.Enabled = p41;
    end;
end;

local function getFarmerSellPrice(p42, p43, p44) -- Line: 147
    -- upvalues: u6 (copy)
    local v45 = u6:buffStat(p42, p43);

    if p44 then
        v45 = v45 * 1.5;
    end;

    return math.floor(v45 / 2);
end;

local function clearPickupPrompt() -- Line: 156
    -- upvalues: u23 (ref), u22 (ref)
    if u23 then
        u23:Disconnect();
        u23 = nil;
    end;

    if u22 then
        u22:Destroy();
        u22 = nil;
    end;
end;

local function addPickupPrompt(u46) -- Line: 167
    -- upvalues: u23 (ref), u22 (ref), u3 (copy)
    if u23 then
        u23:Disconnect();
        u23 = nil;
    end;

    if u22 then
        u22:Destroy();
        u22 = nil;
    end;

    if not u46.PrimaryPart then
        return;
    end;

    if u46:GetAttribute("SamePlayer") ~= true then
        return;
    end;

    local u47 = script.ProximityPrompt:Clone();
    u47.ActionText = "Pick Up";
    u47.MaxActivationDistance = 35;
    u47.GamepadKeyCode = Enum.KeyCode.ButtonB;
    u47.KeyboardKeyCode = Enum.KeyCode.F;
    u47.Parent = u46.PrimaryPart;
    u22 = u47;
    u23 = u47.Triggered:Connect(function() -- Line: 179
        -- upvalues: u47 (copy), u3 (ref), u46 (copy)
        u47.Enabled = false;
        u3:FireServer("PickupFarmer", u46.Name);
    end);
end;

local function updateFarmerInfoLevel(p48) -- Line: 185
    -- upvalues: FarmerInfo (copy), u11 (copy), u4 (copy), u12 (copy), u13 (copy), u10 (copy)
    local Frame = FarmerInfo:FindFirstChild("Frame");
    local v49 = u11.getLevel(p48:GetAttribute("Level"));
    local v50 = u11.getXP(p48:GetAttribute("XP"));
    local v51 = u11.getProgress(v49, v50);
    local LevelLabel = Frame:FindFirstChild("LevelLabel");

    if LevelLabel and LevelLabel:IsA("TextLabel") then
        LevelLabel.Text = `Level {v51.level}`;
    end;

    local LevelBar = Frame:FindFirstChild("LevelBar");

    if LevelBar then
        local LevelLabel2 = LevelBar:FindFirstChild("LevelLabel");

        if LevelLabel2 and LevelLabel2:IsA("TextLabel") then
            LevelLabel2.Text = `{u4.Comma(v51.xp)}/{u4.Comma(v51.requiredXP)} xp`;
        end;

        local Bar = LevelBar:FindFirstChild("Bar");

        if Bar then
            Bar.Size = UDim2.fromScale(v51.alpha, 1);
            Bar.Visible = v51.alpha > 0.01;
        end;
    end;

    local v52 = u12[p48:GetAttribute("FarmerName") or p48.Name];

    if v52 then
        local plant = v52.plant;
        local v53 = u13[plant];
        local UnitInfo = Frame:FindFirstChild("UnitInfo");
        local v54 = UnitInfo and UnitInfo:FindFirstChild("Icon");

        if v54 then
            local icon = v53.icon;

            if v53.fruit then
                icon = v53.fruit.icon;
            end;

            v54.Image = icon;
        end;

        local ValueIncrease = Frame:FindFirstChild("ValueIncrease");

        if ValueIncrease then
            local Price = ValueIncrease:FindFirstChild("Price");
            local AfterPrice = ValueIncrease:FindFirstChild("AfterPrice");

            if v53.fruit then
                plant = v53.fruit.name or plant;
            end;

            local v55 = u10.getPrice(plant, p48:GetAttribute("Huge") and 1.5 or 1, p48:GetAttribute("Mutations") or "") or v53.sell_price;

            if Price then
                local v56 = u11.getValue(v55, v51.level - 1);
                Price.Text = `{v56 >= 100000 and u4.Suffix(v56) or u4.Comma(v56)}$`;
            end;

            if AfterPrice then
                local v57 = u11.getValue(v55, v51.level);
                AfterPrice.Text = `{v57 >= 100000 and u4.Suffix(v57) or u4.Comma(v57)}$`;
            end;
        end;
    end;
end;

local function updateFarmerOverheadLevel(p58) -- Line: 250
    -- upvalues: u11 (copy)
    local v59;

    if p58 then
        v59 = p58:FindFirstChild("Overhead");
    else
        v59 = p58;
    end;

    if v59 then
        v59 = v59:FindFirstChild("Level");
    end;

    if v59 and v59:IsA("TextLabel") then
        v59.Text = `Level {u11.getLevel(p58:GetAttribute("Level"))}`;
    end;
end;

local function displayFarmer(p60) -- Line: 258
    -- upvalues: u20 (ref), u21 (ref), u23 (ref), u22 (ref), updateFarmerInfoLevel (copy), FarmerInfo (copy), Part (copy), updatePlantTime (copy), RunService (copy), Highlight (copy), addPickupPrompt (copy)
    local RootPart = p60:FindFirstChild("RootPart");

    if not RootPart then
        return;
    end;

    if u20 and u20 ~= p60 then
        if u21 then
            u21:Disconnect();
            u21 = nil;
        end;

        if u23 then
            u23:Disconnect();
            u23 = nil;
        end;

        if u22 then
            u22:Destroy();
            u22 = nil;
        end;

        local v61 = u20;

        if v61 then
            v61 = v61:FindFirstChild("Overhead");
        end;

        if v61 and v61:IsA("BillboardGui") then
            v61.Enabled = true;
        end;
    end;

    u20 = p60;
    local v62;

    if p60 then
        v62 = p60:FindFirstChild("Overhead");
    else
        v62 = p60;
    end;

    if v62 and v62:IsA("BillboardGui") then
        v62.Enabled = false;
    end;

    updateFarmerInfoLevel(p60);
    local Sell = FarmerInfo:FindFirstChild("Sell", true);

    if Sell and Sell:IsA("GuiObject") then
        Sell.Visible = p60:GetAttribute("SamePlayer") == true;
    end;

    FarmerInfo.Enabled = true;
    Part.CFrame = RootPart.CFrame;
    Part.Parent = workspace;
    FarmerInfo.Adornee = Part;

    if u21 then
        u21:Disconnect();
    end;

    updatePlantTime();
    u21 = RunService.RenderStepped:Connect(updatePlantTime);
    Highlight.Enabled = true;
    Highlight.Adornee = p60;
    Highlight.Parent = p60;
    addPickupPrompt(p60);
end;

local function deselectFarmer() -- Line: 288
    -- upvalues: u20 (ref), u21 (ref), u23 (ref), u22 (ref), Highlight (copy), FarmerInfo (copy), Part (copy)
    if not u20 then
        return;
    end;

    if u21 then
        u21:Disconnect();
        u21 = nil;
    end;

    if u23 then
        u23:Disconnect();
        u23 = nil;
    end;

    if u22 then
        u22:Destroy();
        u22 = nil;
    end;

    local v63 = u20;

    if v63 then
        v63 = v63:FindFirstChild("Overhead");
    end;

    if v63 and v63:IsA("BillboardGui") then
        v63.Enabled = true;
    end;

    Highlight.Enabled = false;
    Highlight.Adornee = nil;
    Highlight.Parent = nil;
    FarmerInfo.Enabled = false;
    FarmerInfo.Adornee = nil;
    Part.Parent = nil;
    u20 = nil;
end;

local function getFarmerFromHit(p64) -- Line: 303
    -- upvalues: u17 (copy)
    if not p64 or p64.Name ~= "Hitbox" then
        return;
    end;

    local Parent = p64.Parent;

    if Parent and u17[Parent:GetAttribute("OwnerUserId")] == Parent.Parent then
        return Parent;
    end;
end;

local function updateMouseFilter() -- Line: 311
    -- upvalues: u17 (copy), u16 (copy)
    local v65 = {};

    for _, v in u17 do
        table.insert(v65, v);
    end;

    u16:SetTargetFilter(v65);
    u16:SetFilterType(Enum.RaycastFilterType.Include);
end;

local function getPlotUnderPlayer() -- Line: 321
    -- upvalues: LocalPlayer (copy), u19 (copy), u30 (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local v66 = {};
    local v67 = {};

    for _, v in u19 do
        local Boundary = v.Boundary;

        if Boundary and Boundary.Parent then
            table.insert(v66, Boundary);
            v67[Boundary] = v;
        end;
    end;

    if #v66 ~= 0 then
        u30.FilterDescendantsInstances = v66;
        local v68 = workspace:Raycast(Character.Position, Vector3.new(0, -100, 0), u30);

        if v68 then
            v68 = v67[v68.Instance];
        end;

        return v68;
    end;
end;

local function setPlotDisplayed(p69, p70) -- Line: 342
    -- upvalues: u18 (copy), u20 (ref), u21 (ref), u23 (ref), u22 (ref), Highlight (copy), FarmerInfo (copy), Part (copy)
    if p69.Displayed == p70 then
        return;
    end;

    p69.Displayed = p70;

    if p70 then
        for _, child in p69.Workers:GetChildren() do
            p69.AddFarmer(child);
        end;

        p69.WorkerConnection = p69.Workers.ChildAdded:Connect(p69.AddFarmer);
        u18[p69.Player.UserId] = p69.WorkerConnection;

        return;
    end;

    if p69.WorkerConnection then
        p69.WorkerConnection:Disconnect();
        p69.WorkerConnection = nil;
        u18[p69.Player.UserId] = nil;
    end;

    if u20 and (u20:IsDescendantOf(p69.ClientFarmers) and u20) then
        if u21 then
            u21:Disconnect();
            u21 = nil;
        end;

        if u23 then
            u23:Disconnect();
            u23 = nil;
        end;

        if u22 then
            u22:Destroy();
            u22 = nil;
        end;

        local v71 = u20;

        if v71 then
            v71 = v71:FindFirstChild("Overhead");
        end;

        if v71 and v71:IsA("BillboardGui") then
            v71.Enabled = true;
        end;

        Highlight.Enabled = false;
        Highlight.Adornee = nil;
        Highlight.Parent = nil;
        FarmerInfo.Enabled = false;
        FarmerInfo.Adornee = nil;
        Part.Parent = nil;
        u20 = nil;
    end;

    p69.ClientFarmers:ClearAllChildren();
end;

local function startPlotDisplayLoop() -- Line: 366
    -- upvalues: u24 (ref), RunService (copy), getPlotUnderPlayer (copy), u19 (copy), Players (copy), u18 (copy), u20 (ref), u21 (ref), u23 (ref), u22 (ref), Highlight (copy), FarmerInfo (copy), Part (copy), setPlotDisplayed (copy)
    if u24 then
        return;
    end;

    local u72 = 0;
    u24 = RunService.Heartbeat:Connect(function() -- Line: 370
        -- upvalues: u72 (ref), getPlotUnderPlayer (ref), u19 (ref), Players (ref), u18 (ref), u20 (ref), u21 (ref), u23 (ref), u22 (ref), Highlight (ref), FarmerInfo (ref), Part (ref), setPlotDisplayed (ref)
        local v73 = os.clock();

        if v73 - u72 < 0.25 then
            return;
        end;

        u72 = v73;
        local v74 = getPlotUnderPlayer();

        for _, v in u19 do
            if v.Player:IsDescendantOf(Players) and v.Plot.Parent then
                setPlotDisplayed(v, v == v74);
            else
                if v.Displayed ~= false then
                    v.Displayed = false;

                    if v.WorkerConnection then
                        v.WorkerConnection:Disconnect();
                        v.WorkerConnection = nil;
                        u18[v.Player.UserId] = nil;
                    end;

                    if u20 and (u20:IsDescendantOf(v.ClientFarmers) and u20) then
                        if u21 then
                            u21:Disconnect();
                            u21 = nil;
                        end;

                        if u23 then
                            u23:Disconnect();
                            u23 = nil;
                        end;

                        if u22 then
                            u22:Destroy();
                            u22 = nil;
                        end;

                        local v75 = u20;

                        if v75 then
                            v75 = v75:FindFirstChild("Overhead");
                        end;

                        if v75 and v75:IsA("BillboardGui") then
                            v75.Enabled = true;
                        end;

                        Highlight.Enabled = false;
                        Highlight.Adornee = nil;
                        Highlight.Parent = nil;
                        FarmerInfo.Enabled = false;
                        FarmerInfo.Adornee = nil;
                        Part.Parent = nil;
                        u20 = nil;
                    end;

                    v.ClientFarmers:ClearAllChildren();
                end;

                u19[v.Player.UserId] = nil;
            end;
        end;
    end);
end;

local function setupInput() -- Line: 388
    -- upvalues: UserInputService (copy), u16 (copy), u17 (copy), displayFarmer (copy), u20 (ref), u21 (ref), u23 (ref), u22 (ref), Highlight (copy), FarmerInfo (copy), Part (copy)
    UserInputService.InputEnded:Connect(function(p76, p77) -- Line: 389
        -- upvalues: u16 (ref), u17 (ref), displayFarmer (ref), u20 (ref), u21 (ref), u23 (ref), u22 (ref), Highlight (ref), FarmerInfo (ref), Part (ref)
        if p77 then
            return;
        end;

        if p76.UserInputType ~= Enum.UserInputType.MouseButton1 and p76.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        local v78 = u16:GetTarget();
        local v79;

        if v78 and v78.Name == "Hitbox" then
            v79 = v78.Parent;

            if not v79 or u17[v79:GetAttribute("OwnerUserId")] ~= v79.Parent then
                v79 = nil;
            end;
        else
            v79 = nil;
        end;

        if v79 then
            displayFarmer(v79);

            return;
        end;

        if not u20 then
            return;
        end;

        if u21 then
            u21:Disconnect();
            u21 = nil;
        end;

        if u23 then
            u23:Disconnect();
            u23 = nil;
        end;

        if u22 then
            u22:Destroy();
            u22 = nil;
        end;

        local v80 = u20;

        if v80 then
            v80 = v80:FindFirstChild("Overhead");
        end;

        if v80 and v80:IsA("BillboardGui") then
            v80.Enabled = true;
        end;

        Highlight.Enabled = false;
        Highlight.Adornee = nil;
        Highlight.Parent = nil;
        FarmerInfo.Enabled = false;
        FarmerInfo.Adornee = nil;
        Part.Parent = nil;
        u20 = nil;
    end);
end;

local function setupFarmerInfo() -- Line: 406
    -- upvalues: FarmerInfo (copy), u15 (copy), Part (copy), Highlight (copy)
    FarmerInfo.Enabled = false;
    FarmerInfo.Adornee = nil;
    FarmerInfo.Parent = u15;
    Part.Parent = nil;
    Highlight.Enabled = false;
    Highlight.Parent = nil;
end;

local function setupSellButton() -- Line: 415
    -- upvalues: FarmerInfo (copy), u20 (ref), u12 (copy), u6 (copy), u4 (copy), u3 (copy), u21 (ref), u23 (ref), u22 (ref), Highlight (copy), Part (copy)
    local Sell = FarmerInfo:FindFirstChild("Sell", true);
    local v81;

    if Sell and Sell:IsA("GuiButton") or not Sell then
        v81 = Sell;
    else
        v81 = Sell:FindFirstChild("Button", true);
    end;

    if not (v81 and v81:IsA("GuiButton")) then
        return;
    end;

    Sell:AddTag("BUTTON");
    v81.Activated:Connect(function() -- Line: 424
        -- upvalues: u20 (ref), u12 (ref), u6 (ref), u4 (ref), u3 (ref), u21 (ref), u23 (ref), u22 (ref), Highlight (ref), FarmerInfo (ref), Part (ref)
        local u82 = u20;

        if not u82 then
            return;
        end;

        if u82:GetAttribute("SamePlayer") ~= true then
            return;
        end;

        local v83 = u82:GetAttribute("FarmerName") or u82.Name;
        local v84 = u12[v83];
        local v85;

        if v84 then
            v85 = v84.price;
        else
            v85 = v84;
        end;

        if type(v85) ~= "number" then
            return;
        end;

        local Name = u82.Name;
        local v86 = u82:GetAttribute("Huge") and `HUGE {v84.DisplayName or v83}` or (v84.DisplayName or v83);
        local v87 = u82:GetAttribute("Mutations") or "";
        local v88 = u82:GetAttribute("Huge") == true;
        local v89 = u6:buffStat(v85, v87);

        if v88 then
            v89 = v89 * 1.5;
        end;

        local v90 = math.floor(v89 / 2);
        _G.AreYouSure({
            Message = `Sell {v86} for {u4.Comma(v90)}$?`,
            Price = v90,

            Callback = function(p91) -- Line: 441, Name: Callback
                -- upvalues: u3 (ref), Name (copy), u20 (ref), u82 (copy), u21 (ref), u23 (ref), u22 (ref), Highlight (ref), FarmerInfo (ref), Part (ref)
                if not p91 then
                    return;
                end;

                u3:FireServer("SellFarmer", Name);

                if u20 == u82 then
                    if not u20 then
                        return;
                    end;

                    if u21 then
                        u21:Disconnect();
                        u21 = nil;
                    end;

                    if u23 then
                        u23:Disconnect();
                        u23 = nil;
                    end;

                    if u22 then
                        u22:Destroy();
                        u22 = nil;
                    end;

                    local v92 = u20;

                    if v92 then
                        v92 = v92:FindFirstChild("Overhead");
                    end;

                    if v92 and v92:IsA("BillboardGui") then
                        v92.Enabled = true;
                    end;

                    Highlight.Enabled = false;
                    Highlight.Adornee = nil;
                    Highlight.Parent = nil;
                    FarmerInfo.Enabled = false;
                    FarmerInfo.Adornee = nil;
                    Part.Parent = nil;
                    u20 = nil;
                end;
            end
        });
    end);
end;

local function createHitbox(p93) -- Line: 453
    local RootPart = p93:FindFirstChild("RootPart");

    if not RootPart then
        return;
    end;

    local v94, v95 = p93:GetBoundingBox();
    local Part2 = Instance.new("Part");
    Part2.Name = "Hitbox";
    Part2.Size = v95;
    Part2.Transparency = 1;
    Part2.CanCollide = false;
    Part2.CanTouch = false;
    Part2.CanQuery = true;
    Part2.Massless = true;
    Part2.CFrame = v94;
    Part2.Parent = p93;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = Part2;
    WeldConstraint.Part1 = RootPart;
    WeldConstraint.Parent = Part2;
end;

local function createBillboard(p96) -- Line: 476
    -- upvalues: u12 (copy), FarmerOverhead (copy), u4 (copy), u11 (copy), u6 (copy), u5 (copy)
    local v97 = p96:GetAttribute("FarmerName") or p96.Name;
    local v98 = u12[v97];

    if not v98 then
        return;
    end;

    local v99 = FarmerOverhead:Clone();
    v99.Name = "Overhead";
    v99.Parent = p96;
    v99.Adornee = p96.RootPart;
    v99.FarmerName.Text = p96:GetAttribute("Huge") and `HUGE {v98.DisplayName or v97}` or (v98.DisplayName or v97);
    local Label = v99.Label;
    local v100 = p96:GetAttribute("RolledRarity");
    Label.Text = `[ {v100 and `1/{u4.Comma(v100)}` or v98.rarity} ]`;
    v99.Level.Text = `Level {u11.getLevel(p96:GetAttribute("Level"))}`;
    u6:updateList(v99:FindFirstChild("Mutations"), p96:GetAttribute("Mutations") or "");
    u5:SetColor(v98.real_rarity, v99.Label);
end;

local function prepareGnomeModel(p101) -- Line: 493
    local RootPart = p101:FindFirstChild("RootPart");
    local v102 = p101:FindFirstChildWhichIsA("AnimationController") ~= nil;
    p101.PrimaryPart = RootPart;

    for _, descendant in p101:GetDescendants() do
        if descendant:IsA("BasePart") then
            if v102 then
                descendant.Anchored = descendant == RootPart;
            else
                descendant.Anchored = true;
            end;

            descendant.CanCollide = false;
        end;
    end;
end;

local function getLookAtCFrame(p103, p104, p105) -- Line: 510
    local v106 = Vector3.new(p104.X - p103.X, 0, p104.Z - p103.Z);

    if v106.Magnitude > 0.001 then
        return CFrame.lookAt(p104, p104 + v106.Unit);
    end;

    local v107 = p105 - p105.Position;

    return CFrame.new(p104) * v107;
end;

local function getGnomeSpeed(p108) -- Line: 525
    local v109 = p108:GetAttribute("GnomeSpeed");

    return type(v109) == "number" and math.max(v109, 0.1) or 1;
end;

local function hasMutation(p110, p111) -- Line: 530
    -- upvalues: u6 (copy)
    local v112 = p110 and p110:GetAttribute("Mutations") or "";

    if type(v112) == "string" and v112 ~= "" then
        return table.find(u6:toTable(v112), p111) ~= nil;
    end;

    return false;
end;

local function updateGnomeTrail(p113) -- Line: 539
    -- upvalues: Assets (copy)
    local v114;

    if p113 then
        v114 = p113:FindFirstChild("RootPart") or p113.PrimaryPart;
    else
        v114 = p113;
    end;

    if not v114 then
        return;
    end;

    local CoffeeTrail = v114:FindFirstChild("CoffeeTrail");
    local v115 = p113:GetAttribute("GnomeSpeed");

    if (type(v115) == "number" and (math.max(v115, 0.1) or 1) or 1) <= 1 then
        if CoffeeTrail then
            CoffeeTrail:Destroy();
        end;

        local CoffeeTrailAttachment1 = v114:FindFirstChild("CoffeeTrailAttachment1");

        if CoffeeTrailAttachment1 then
            CoffeeTrailAttachment1:Destroy();
        end;

        local CoffeeTrailAttachment2 = v114:FindFirstChild("CoffeeTrailAttachment2");

        if CoffeeTrailAttachment2 then
            CoffeeTrailAttachment2:Destroy();
        end;

        return;
    end;

    if CoffeeTrail then
        return;
    end;

    local CoffeeTrail2 = Assets:FindFirstChild("CoffeeTrail");

    if not CoffeeTrail2 then
        return;
    end;

    local Attachment1 = CoffeeTrail2:FindFirstChild("Attachment1");
    local Attachment2 = CoffeeTrail2:FindFirstChild("Attachment2");
    local Trail = CoffeeTrail2:FindFirstChild("Trail");

    if not (Attachment1 and (Attachment2 and Trail)) then
        return;
    end;

    local v116 = Attachment1:Clone();
    v116.Name = "CoffeeTrailAttachment1";
    v116.Parent = v114;
    local v117 = Attachment2:Clone();
    v117.Name = "CoffeeTrailAttachment2";
    v117.Parent = v114;
    local v118 = Trail:Clone();
    v118.Name = "CoffeeTrail";
    v118.Attachment0 = v116;
    v118.Attachment1 = v117;
    v118.Parent = v114;
end;

local function clearGnomeItemPrompts() -- Line: 583
    -- upvalues: u26 (copy), u25 (copy)
    for _, v in u26 do
        v:Disconnect();
    end;

    table.clear(u26);

    for _, v in u25 do
        v:Destroy();
    end;

    table.clear(u25);
end;

local function stopGivingGnomeItem() -- Line: 595
    -- upvalues: u27 (ref), u28 (ref), clearGnomeItemPrompts (copy)
    u27 = false;
    u28 = nil;
    clearGnomeItemPrompts();
end;

local function addGnomeItemPrompt(u119) -- Line: 601
    -- upvalues: u27 (ref), u25 (copy), u26 (copy), u28 (ref), Plot (ref), u3 (copy)
    if not u27 or (not u119 or u25[u119]) then
        return;
    end;

    local v120 = u119:FindFirstChild("RootPart") or u119.PrimaryPart;

    if not v120 then
        return;
    end;

    local u121 = script.ProximityPrompt:Clone();
    u121.Parent = v120;
    u25[u119] = u121;
    table.insert(u26, u121.Triggered:Connect(function() -- Line: 611
        -- upvalues: u28 (ref), Plot (ref), u119 (copy), u121 (copy), u3 (ref)
        if not u28 then
            return;
        end;

        local v122 = Plot and Plot.Value;

        if v122 then
            v122 = v122:FindFirstChild("Workers");
        end;

        if v122 then
            v122 = v122:FindFirstChild(u119.Name);
        end;

        if not v122 then
            return;
        end;

        u121.Enabled = false;
        u3:FireServer("GiveFarmerItem", v122, u28);
    end));
    table.insert(u26, u119.Destroying:Connect(function() -- Line: 623
        -- upvalues: u25 (ref), u119 (copy), u121 (copy)
        if u25[u119] == u121 then
            u25[u119] = nil;
        end;

        u121:Destroy();
    end));
end;

local function showGnomeItemPrompts(p123) -- Line: 631
    -- upvalues: clearGnomeItemPrompts (copy), u27 (ref), u28 (ref), u17 (copy), LocalPlayer (copy), addGnomeItemPrompt (copy), u26 (copy)
    clearGnomeItemPrompts();
    u27 = true;
    u28 = p123;
    local v124 = u17[LocalPlayer.UserId];

    if not v124 then
        return;
    end;

    for _, child in v124:GetChildren() do
        addGnomeItemPrompt(child);
    end;

    table.insert(u26, v124.ChildAdded:Connect(addGnomeItemPrompt));
end;

local function gotPlot(u125, p126) -- Line: 647
    -- upvalues: LocalPlayer (copy), u1 (copy), u19 (copy), u17 (copy), u20 (ref), u21 (ref), u23 (ref), u22 (ref), Highlight (copy), FarmerInfo (copy), Part (copy), u18 (copy), updateMouseFilter (copy), u9 (copy), createBillboard (copy), createHitbox (copy), prepareGnomeModel (copy), addGnomeItemPrompt (copy), updateGnomeTrail (copy), Animations (copy), u6 (copy), u8 (copy), getLookAtCFrame (copy), updateFarmerOverheadLevel (copy), updateFarmerInfoLevel (copy), getPlotUnderPlayer (copy)
    local u127 = u125 == LocalPlayer;
    local v128 = u1(p126, "Workers");
    local v129 = u19[u125.UserId];
    local v130 = u17[u125.UserId];

    if v130 then
        if u20 and (u20:IsDescendantOf(v130) and u20) then
            if u21 then
                u21:Disconnect();
                u21 = nil;
            end;

            if u23 then
                u23:Disconnect();
                u23 = nil;
            end;

            if u22 then
                u22:Destroy();
                u22 = nil;
            end;

            local v131 = u20;

            if v131 then
                v131 = v131:FindFirstChild("Overhead");
            end;

            if v131 and v131:IsA("BillboardGui") then
                v131.Enabled = true;
            end;

            Highlight.Enabled = false;
            Highlight.Adornee = nil;
            Highlight.Parent = nil;
            FarmerInfo.Enabled = false;
            FarmerInfo.Adornee = nil;
            Part.Parent = nil;
            u20 = nil;
        end;

        v130:Destroy();
    end;

    if u18[u125.UserId] then
        u18[u125.UserId]:Disconnect();
        u18[u125.UserId] = nil;
    end;

    if v129 and v129.WorkerConnection then
        v129.WorkerConnection:Disconnect();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "ClientFarmers";
    Folder.Parent = p126;
    u17[u125.UserId] = Folder;
    updateMouseFilter();
    local u132 = {
        Displayed = false,
        WorkerConnection = nil,
        Player = u125,
        Plot = p126,
        Workers = v128,
        ClientFarmers = Folder,
        Boundary = p126:FindFirstChild("PLOTBOUNDARY", true)
    };
    u19[u125.UserId] = u132;

    function u132.AddFarmer(u133) -- Line: 683
        -- upvalues: u132 (copy), Folder (copy), u9 (ref), u125 (copy), u127 (copy), createBillboard (ref), createHitbox (ref), prepareGnomeModel (ref), addGnomeItemPrompt (ref), updateGnomeTrail (ref), Animations (ref), u6 (ref), u8 (ref), getLookAtCFrame (ref), updateFarmerOverheadLevel (ref), u20 (ref), updateFarmerInfoLevel (ref), u21 (ref), u23 (ref), u22 (ref), Highlight (ref), FarmerInfo (ref), Part (ref)
        local v134 = u133:GetAttribute("FarmerName");

        if not u132.Displayed then
            return;
        end;

        if Folder:FindFirstChild(u133.Name) then
            return;
        end;

        local u135;

        if v134 then
            u135 = u9.getModel(v134, u133:GetAttribute("Mutations"), u133:GetAttribute("Huge"));
        else
            u135 = v134;
        end;

        if not u135 then
            return;
        end;

        u135.Name = u133.Name;
        u135:SetAttribute("FarmerName", v134);
        u135:SetAttribute("OwnerUserId", u125.UserId);
        u135:SetAttribute("SamePlayer", u127);
        u135:SetAttribute("NextPlant", u133:GetAttribute("NextPlant"));
        u135:SetAttribute("GnomeSpeed", u133:GetAttribute("GnomeSpeed"));
        u135:SetAttribute("RolledRarity", u133:GetAttribute("RolledRarity"));
        u135:SetAttribute("Level", u133:GetAttribute("Level"));
        u135:SetAttribute("XP", u133:GetAttribute("XP"));
        u135:SetAttribute("GnomeStepGroup", math.random(1, 3));
        createBillboard(u135);
        createHitbox(u135);
        u135:PivotTo(u133:GetPivot());
        prepareGnomeModel(u135);
        u135.Parent = Folder;
        addGnomeItemPrompt(u135);
        updateGnomeTrail(u135);
        local Gnome = Animations.new("Gnome", u135);

        if Gnome then
            Gnome:ChangeAnimation("Idle", math.random(70, 120) / 100);
        end;

        task.spawn(function() -- Line: 716
            -- upvalues: u135 (copy), u6 (ref)
            while u135.Parent do
                task.wait(math.random(250, 600) / 10);

                if not u135.Parent then
                    return;
                end;

                local v136 = u135;
                local v137 = v136 and v136:GetAttribute("Mutations") or "";
                local v138;

                if type(v137) == "string" and v137 ~= "" then
                    v138 = table.find(u6:toTable(v137), "Frozen") ~= nil;
                else
                    v138 = false;
                end;

                if not v138 then
                    _G.Play(`GnomeTalk{math.random(1, 5)}`, u135:FindFirstChild("RootPart"));
                end;
            end;
        end);
        local u139 = 0;
        local u140 = nil;

        local function cancelActiveTween() -- Line: 728
            -- upvalues: u140 (ref)
            if u140 then
                u140:Cancel();
                u140 = nil;
            end;
        end;

        local function tweenToCFrame(p141, p142) -- Line: 735
            -- upvalues: u135 (copy), u140 (ref), u8 (ref)
            if not u135.PrimaryPart then
                u135:PivotTo(p141);

                return true;
            end;

            u140 = u8:TweenModel(u135, p142, "Linear", "Out", p141);
            local v143 = u140;

            if not v143 then
                return false;
            end;

            local v144 = v143.Completed:Wait();

            if u140 == v143 then
                u140 = nil;
            end;

            return v144 == Enum.PlaybackState.Completed;
        end;

        local function tweenToPosition(p145) -- Line: 759
            -- upvalues: u140 (ref), u135 (copy), getLookAtCFrame (ref), tweenToCFrame (copy)
            if u140 then
                u140:Cancel();
                u140 = nil;
            end;

            local v146 = u135:GetPivot();
            local Magnitude = (p145 - v146.Position).Magnitude;

            if Magnitude <= 0.05 then
                u135:PivotTo(getLookAtCFrame(v146.Position, p145, v146));

                return true;
            end;

            local v147 = getLookAtCFrame(v146.Position, p145, v146);

            if not tweenToCFrame(CFrame.new(v146.Position) * v147.Rotation, 0.15) then
                return false;
            end;

            local v148 = u135:GetAttribute("GnomeSpeed");

            return tweenToCFrame(v147, Magnitude / (8 * (type(v148) == "number" and (math.max(v148, 0.1) or 1) or 1)));
        end;

        local function move() -- Line: 778
            -- upvalues: u133 (copy), u139 (ref), u140 (ref), Gnome (copy), u135 (copy), u6 (ref), tweenToPosition (copy)
            local Position = u133:GetPivot().Position;

            if not Position then
                return;
            end;

            u139 = u139 + 1;

            if u140 then
                u140:Cancel();
                u140 = nil;
            end;

            local u149 = u139;
            task.spawn(function() -- Line: 786
                -- upvalues: Gnome (ref), u135 (ref), u6 (ref), tweenToPosition (ref), Position (copy), u149 (copy), u139 (ref)
                if Gnome then
                    local v150 = u135;
                    local v151 = v150 and v150:GetAttribute("Mutations") or "";
                    local v152;

                    if type(v151) == "string" and v151 ~= "" then
                        v152 = table.find(u6:toTable(v151), "Frozen") ~= nil;
                    else
                        v152 = false;
                    end;

                    if not v152 then
                        local v153 = u135:GetAttribute("GnomeSpeed");
                        Gnome:ChangeAnimation("Walk", type(v153) == "number" and (math.max(v153, 0.1) or 1) or 1);
                    end;
                end;

                tweenToPosition(Position);

                if u149 == u139 and Gnome then
                    local v154 = u135;
                    local v155 = v154 and v154:GetAttribute("Mutations") or "";
                    local v156;

                    if type(v155) == "string" and v155 ~= "" then
                        v156 = table.find(u6:toTable(v155), "Frozen") ~= nil;
                    else
                        v156 = false;
                    end;

                    if not v156 then
                        Gnome:ChangeAnimation("Idle", math.random(70, 120) / 100);
                    end;
                end;
            end);
        end;

        local u157 = u133:GetAttributeChangedSignal("MoveId"):Connect(move);
        local u165 = u133:GetAttributeChangedSignal("PlantId"):Connect(function() -- Line: 803
            -- upvalues: u139 (ref), u140 (ref), u135 (copy), Gnome (copy), u6 (ref), u133 (copy)
            u139 = u139 + 1;

            if u140 then
                u140:Cancel();
                u140 = nil;
            end;

            task.delay(1.5, function() -- Line: 807
                -- upvalues: u135 (ref)
                if u135.Parent then
                    _G.Play("GnomePlant", u135:FindFirstChild("RootPart"));
                end;
            end);

            if Gnome then
                local v158 = u135;
                local v159 = v158 and v158:GetAttribute("Mutations") or "";
                local v160;

                if type(v159) == "string" and v159 ~= "" then
                    v160 = table.find(u6:toTable(v159), "Frozen") ~= nil;
                else
                    v160 = false;
                end;

                if not v160 then
                    Gnome:ChangeAnimation("Plant");
                end;
            end;

            local v161 = u133:GetAttribute("PlantDuration") or 2;
            task.delay(v161, function() -- Line: 818
                -- upvalues: Gnome (ref), u135 (ref), u6 (ref)
                if Gnome and u135.Parent then
                    local v162 = u135;
                    local v163 = v162 and v162:GetAttribute("Mutations") or "";
                    local v164;

                    if type(v163) == "string" and v163 ~= "" then
                        v164 = table.find(u6:toTable(v163), "Frozen") ~= nil;
                    else
                        v164 = false;
                    end;

                    if not v164 then
                        Gnome:ChangeAnimation("Idle", math.random(70, 120) / 100);
                    end;
                end;
            end);
        end);
        local u166 = u133:GetAttributeChangedSignal("NextPlant"):Connect(function() -- Line: 826
            -- upvalues: u135 (copy), u133 (copy)
            u135:SetAttribute("NextPlant", u133:GetAttribute("NextPlant"));
        end);
        local u167 = u133:GetAttributeChangedSignal("GnomeSpeed"):Connect(function() -- Line: 831
            -- upvalues: u135 (copy), u133 (copy), updateGnomeTrail (ref)
            u135:SetAttribute("GnomeSpeed", u133:GetAttribute("GnomeSpeed"));
            updateGnomeTrail(u135);
        end);
        local u172 = u133:GetAttributeChangedSignal("Mutations"):Connect(function() -- Line: 837
            -- upvalues: u133 (copy), u135 (copy), u9 (ref), u6 (ref), Gnome (copy)
            local v168 = u133:GetAttribute("Mutations") or "";
            u135:SetAttribute("Mutations", v168);
            u9.applyMutations(u135, v168);
            local Overhead = u135:FindFirstChild("Overhead");

            if Overhead then
                u6:updateList(Overhead:FindFirstChild("Mutations"), v168);
            end;

            if Gnome then
                local v169 = u135;
                local v170 = v169 and v169:GetAttribute("Mutations") or "";
                local v171;

                if type(v170) == "string" and v170 ~= "" then
                    v171 = table.find(u6:toTable(v170), "Frozen") ~= nil;
                else
                    v171 = false;
                end;

                if v171 then
                    Gnome:Stop();
                end;
            end;
        end);
        local u173 = u133:GetAttributeChangedSignal("Level"):Connect(function() -- Line: 853
            -- upvalues: u135 (copy), u133 (copy), updateFarmerOverheadLevel (ref), u20 (ref), updateFarmerInfoLevel (ref)
            u135:SetAttribute("Level", u133:GetAttribute("Level"));
            updateFarmerOverheadLevel(u135);

            if u20 == u135 then
                updateFarmerInfoLevel(u135);
            end;
        end);
        local u174 = u133:GetAttributeChangedSignal("XP"):Connect(function() -- Line: 862
            -- upvalues: u135 (copy), u133 (copy), u20 (ref), updateFarmerInfoLevel (ref)
            u135:SetAttribute("XP", u133:GetAttribute("XP"));

            if u20 == u135 then
                updateFarmerInfoLevel(u135);
            end;
        end);
        local u175 = false;

        local function cleanup() -- Line: 870
            -- upvalues: u175 (ref), u139 (ref), u140 (ref), u157 (copy), u165 (copy), u166 (copy), u167 (copy), u172 (copy), u173 (copy), u174 (copy), Gnome (copy), u20 (ref), u135 (copy), u21 (ref), u23 (ref), u22 (ref), Highlight (ref), FarmerInfo (ref), Part (ref)
            if u175 then
                return;
            end;

            u175 = true;
            u139 = u139 + 1;

            if u140 then
                u140:Cancel();
                u140 = nil;
            end;

            u157:Disconnect();
            u165:Disconnect();
            u166:Disconnect();
            u167:Disconnect();
            u172:Disconnect();
            u173:Disconnect();
            u174:Disconnect();

            if Gnome then
                Gnome:Destroy();
            end;

            if u20 == u135 then
                if not u20 then
                    return;
                end;

                if u21 then
                    u21:Disconnect();
                    u21 = nil;
                end;

                if u23 then
                    u23:Disconnect();
                    u23 = nil;
                end;

                if u22 then
                    u22:Destroy();
                    u22 = nil;
                end;

                local v176 = u20;

                if v176 then
                    v176 = v176:FindFirstChild("Overhead");
                end;

                if v176 and v176:IsA("BillboardGui") then
                    v176.Enabled = true;
                end;

                Highlight.Enabled = false;
                Highlight.Adornee = nil;
                Highlight.Parent = nil;
                FarmerInfo.Enabled = false;
                FarmerInfo.Adornee = nil;
                Part.Parent = nil;
                u20 = nil;
            end;
        end;

        u133.Destroying:Once(function() -- Line: 890
            -- upvalues: cleanup (copy), u135 (copy)
            cleanup();
            u135:Destroy();
        end);
        u135.Destroying:Once(cleanup);
    end;

    if getPlotUnderPlayer() == u132 then
        if u132.Displayed == true then
            return;
        end;

        u132.Displayed = true;

        for _, child in u132.Workers:GetChildren() do
            u132.AddFarmer(child);
        end;

        u132.WorkerConnection = u132.Workers.ChildAdded:Connect(u132.AddFarmer);
        u18[u132.Player.UserId] = u132.WorkerConnection;
    end;
end;

function v29.Initialize(p177) -- Line: 904
    -- upvalues: FarmerInfo (copy), u15 (copy), Part (copy), Highlight (copy), setupSellButton (copy), UserInputService (copy), u16 (copy), u17 (copy), displayFarmer (copy), u20 (ref), u21 (ref), u23 (ref), u22 (ref), u24 (ref), RunService (copy), getPlotUnderPlayer (copy), u19 (copy), Players (copy), u18 (copy), setPlotDisplayed (copy), Plot (ref), LocalPlayer (copy), gotPlot (copy), updateMouseFilter (copy), u3 (copy), u27 (ref), u28 (ref), clearGnomeItemPrompts (copy), u7 (copy), showGnomeItemPrompts (copy)
    FarmerInfo.Enabled = false;
    FarmerInfo.Adornee = nil;
    FarmerInfo.Parent = u15;
    Part.Parent = nil;
    Highlight.Enabled = false;
    Highlight.Parent = nil;
    setupSellButton();
    UserInputService.InputEnded:Connect(function(p178, p179) -- Line: 389
        -- upvalues: u16 (ref), u17 (ref), displayFarmer (ref), u20 (ref), u21 (ref), u23 (ref), u22 (ref), Highlight (ref), FarmerInfo (ref), Part (ref)
        if p179 then
            return;
        end;

        if p178.UserInputType ~= Enum.UserInputType.MouseButton1 and p178.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        local v180 = u16:GetTarget();
        local v181;

        if v180 and v180.Name == "Hitbox" then
            v181 = v180.Parent;

            if not v181 or u17[v181:GetAttribute("OwnerUserId")] ~= v181.Parent then
                v181 = nil;
            end;
        else
            v181 = nil;
        end;

        if v181 then
            displayFarmer(v181);

            return;
        end;

        if not u20 then
            return;
        end;

        if u21 then
            u21:Disconnect();
            u21 = nil;
        end;

        if u23 then
            u23:Disconnect();
            u23 = nil;
        end;

        if u22 then
            u22:Destroy();
            u22 = nil;
        end;

        local v182 = u20;

        if v182 then
            v182 = v182:FindFirstChild("Overhead");
        end;

        if v182 and v182:IsA("BillboardGui") then
            v182.Enabled = true;
        end;

        Highlight.Enabled = false;
        Highlight.Adornee = nil;
        Highlight.Parent = nil;
        FarmerInfo.Enabled = false;
        FarmerInfo.Adornee = nil;
        Part.Parent = nil;
        u20 = nil;
    end);

    if not u24 then
        local u183 = 0;
        u24 = RunService.Heartbeat:Connect(function() -- Line: 370
            -- upvalues: u183 (ref), getPlotUnderPlayer (ref), u19 (ref), Players (ref), u18 (ref), u20 (ref), u21 (ref), u23 (ref), u22 (ref), Highlight (ref), FarmerInfo (ref), Part (ref), setPlotDisplayed (ref)
            local v184 = os.clock();

            if v184 - u183 < 0.25 then
                return;
            end;

            u183 = v184;
            local v185 = getPlotUnderPlayer();

            for _, v in u19 do
                if v.Player:IsDescendantOf(Players) and v.Plot.Parent then
                    setPlotDisplayed(v, v == v185);
                else
                    if v.Displayed ~= false then
                        v.Displayed = false;

                        if v.WorkerConnection then
                            v.WorkerConnection:Disconnect();
                            v.WorkerConnection = nil;
                            u18[v.Player.UserId] = nil;
                        end;

                        if u20 and (u20:IsDescendantOf(v.ClientFarmers) and u20) then
                            if u21 then
                                u21:Disconnect();
                                u21 = nil;
                            end;

                            if u23 then
                                u23:Disconnect();
                                u23 = nil;
                            end;

                            if u22 then
                                u22:Destroy();
                                u22 = nil;
                            end;

                            local v186 = u20;

                            if v186 then
                                v186 = v186:FindFirstChild("Overhead");
                            end;

                            if v186 and v186:IsA("BillboardGui") then
                                v186.Enabled = true;
                            end;

                            Highlight.Enabled = false;
                            Highlight.Adornee = nil;
                            Highlight.Parent = nil;
                            FarmerInfo.Enabled = false;
                            FarmerInfo.Adornee = nil;
                            Part.Parent = nil;
                            u20 = nil;
                        end;

                        v.ClientFarmers:ClearAllChildren();
                    end;

                    u19[v.Player.UserId] = nil;
                end;
            end;
        end);
    end;

    Plot = Plot or LocalPlayer:WaitForChild("Plot");

    if Plot.Value then
        gotPlot(LocalPlayer, Plot.Value);
    else
        Plot.Changed:Once(function() -- Line: 914
            -- upvalues: gotPlot (ref), LocalPlayer (ref), Plot (ref)
            gotPlot(LocalPlayer, Plot.Value);
        end);
    end;

    local function PlayerAdded(p187) -- Line: 919
        -- upvalues: LocalPlayer (ref), Players (ref), gotPlot (ref)
        if p187 == LocalPlayer then
            return;
        end;

        local Plot2 = p187:FindFirstChild("Plot");

        while not Plot2 and p187:IsDescendantOf(Players) do
            task.wait(0.1);
            Plot2 = p187:FindFirstChild("Plot");
        end;

        if not Plot2 then
            return;
        end;

        if not Plot2.Value then
            repeat
                task.wait(0.1);
            until Plot2.Value ~= nil or not p187:IsDescendantOf(Players);
        end;

        if not p187:IsDescendantOf(Players) then
            return;
        end;

        gotPlot(p187, Plot2.Value);
    end;

    for _, v in ipairs(Players:GetPlayers()) do
        PlayerAdded(v);
    end;

    Players.PlayerAdded:Connect(PlayerAdded);
    Players.PlayerRemoving:Connect(function(p188) -- Line: 941
        -- upvalues: u19 (ref), u18 (ref), u20 (ref), u21 (ref), u23 (ref), u22 (ref), Highlight (ref), FarmerInfo (ref), Part (ref), u17 (ref), updateMouseFilter (ref)
        local v189 = u19[p188.UserId];

        if v189 then
            if v189.Displayed ~= false then
                v189.Displayed = false;

                if v189.WorkerConnection then
                    v189.WorkerConnection:Disconnect();
                    v189.WorkerConnection = nil;
                    u18[v189.Player.UserId] = nil;
                end;

                if u20 and (u20:IsDescendantOf(v189.ClientFarmers) and u20) then
                    if u21 then
                        u21:Disconnect();
                        u21 = nil;
                    end;

                    if u23 then
                        u23:Disconnect();
                        u23 = nil;
                    end;

                    if u22 then
                        u22:Destroy();
                        u22 = nil;
                    end;

                    local v190 = u20;

                    if v190 then
                        v190 = v190:FindFirstChild("Overhead");
                    end;

                    if v190 and v190:IsA("BillboardGui") then
                        v190.Enabled = true;
                    end;

                    Highlight.Enabled = false;
                    Highlight.Adornee = nil;
                    Highlight.Parent = nil;
                    FarmerInfo.Enabled = false;
                    FarmerInfo.Adornee = nil;
                    Part.Parent = nil;
                    u20 = nil;
                end;

                v189.ClientFarmers:ClearAllChildren();
            end;

            u19[p188.UserId] = nil;
        end;

        local v191 = u17[p188.UserId];

        if v191 then
            if u20 and (u20:IsDescendantOf(v191) and u20) then
                if u21 then
                    u21:Disconnect();
                    u21 = nil;
                end;

                if u23 then
                    u23:Disconnect();
                    u23 = nil;
                end;

                if u22 then
                    u22:Destroy();
                    u22 = nil;
                end;

                local v192 = u20;

                if v192 then
                    v192 = v192:FindFirstChild("Overhead");
                end;

                if v192 and v192:IsA("BillboardGui") then
                    v192.Enabled = true;
                end;

                Highlight.Enabled = false;
                Highlight.Adornee = nil;
                Highlight.Parent = nil;
                FarmerInfo.Enabled = false;
                FarmerInfo.Adornee = nil;
                Part.Parent = nil;
                u20 = nil;
            end;

            v191:Destroy();
            u17[p188.UserId] = nil;
        end;

        if u18[p188.UserId] then
            u18[p188.UserId]:Disconnect();
            u18[p188.UserId] = nil;
        end;

        updateMouseFilter();
    end);
    u3:BindEvents({
        StopGivingGnome = function(p193) -- Line: 964, Name: StopGivingGnome
            -- upvalues: u27 (ref), u28 (ref), clearGnomeItemPrompts (ref)
            _G.Play(p193);
            u27 = false;
            u28 = nil;
            clearGnomeItemPrompts();
        end
    });
    u7.new("GiveGnomeItem"):Connect(function(p194, p195) -- Line: 971
        -- upvalues: showGnomeItemPrompts (ref), u27 (ref), u28 (ref), clearGnomeItemPrompts (ref)
        if p194 then
            showGnomeItemPrompts(p195);

            return;
        end;

        u27 = false;
        u28 = nil;
        clearGnomeItemPrompts();
    end);
    u7.new("ShowDisplayedFarmer"):Connect(function(p196) -- Line: 980
        -- upvalues: u17 (ref), displayFarmer (ref)
        for _, v in u17 do
            local v197 = v:FindFirstChild((tostring(p196)));

            if v197 then
                displayFarmer(v197);

                return;
            end;
        end;
    end);
end;

return v29;