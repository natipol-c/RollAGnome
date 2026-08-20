--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Night Gnomes
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Night Gnomes
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:09 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Animations = require(script.Parent["Gnome Handler"].Animations);
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
local u2 = Library.get("Network");
local u3 = Library.get("Numbers");
local u4 = Library.get("Rarities");
local u5 = Library.get("Mutations");
local u6 = Library.get("GnomeUtil");
local u7 = Library.get("Levels");
local u8 = Library.get("SimpleTween");
local u9 = Library.get("Farmers");
local FarmerOverhead = ReplicatedStorage.Assets.Billboards.FarmerOverhead;
local u10 = u1(u1(workspace, "CenterArea"), "Night");
local u11 = u1(u10, "Gnomes");
local u12 = u1(u10, "End");
local v13 = {};
local u14 = nil;
local u15 = nil;
local u16 = nil;

local function getRarityText(p17, p18) -- Line: 42
    -- upvalues: u3 (copy)
    return p18 and `1/{u3.Comma(p18)}` or p17.rarity;
end;

local function getFarmerPrice(p19, p20, p21) -- Line: 46
    -- upvalues: u5 (copy)
    local price = p19.price;

    if type(price) ~= "number" then
        return nil;
    end;

    local v22 = u5:buffStat(price, p20);

    if p21 then
        v22 = v22 * 1.5;
    end;

    return math.floor(v22);
end;

local function createBillboard(p23) -- Line: 58
    -- upvalues: u9 (copy), FarmerOverhead (copy), u3 (copy), u7 (copy), u5 (copy), u4 (copy)
    local v24 = p23:GetAttribute("FarmerName") or p23.Name;
    local v25 = u9[v24];

    if not v25 then
        return;
    end;

    local v26 = FarmerOverhead:Clone();
    v26.Name = "Overhead";
    v26.Parent = p23;
    v26.Adornee = p23.RootPart;
    v26.MaxDistance = 150;
    v26.FarmerName.Text = p23:GetAttribute("Huge") and `HUGE {v25.DisplayName or v24}` or (v25.DisplayName or v24);
    local Label = v26.Label;
    local v27 = p23:GetAttribute("RolledRarity");
    Label.Text = `[ {v27 and `1/{u3.Comma(v27)}` or v25.rarity} ]`;
    v26.Level.Text = `Level {u7.getLevel(p23:GetAttribute("Level"))}`;
    u5:updateList(v26:FindFirstChild("Mutations"), p23:GetAttribute("Mutations") or "");
    local Price = v26:FindFirstChild("Price");

    if Price then
        local v28 = p23:GetAttribute("Mutations") or "";
        local v29 = p23:GetAttribute("Huge") == true;
        local price = v25.price;
        local v30;

        if type(price) == "number" then
            local v31 = u5:buffStat(price, v28);

            if v29 then
                v31 = v31 * 1.5;
            end;

            v30 = math.floor(v31);
        else
            v30 = nil;
        end;

        Price.Text = v30 and (`{u3.Comma(v30)}$` or "") or "";
        Price.Visible = v30 ~= nil;
    end;

    u4:SetColor(v25.real_rarity, v26.Label);
end;

local function prepareGnome(p32) -- Line: 83
    p32.PrimaryPart = p32:FindFirstChild("RootPart");

    for _, descendant in p32:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
        end;
    end;
end;

local function getMoveInfo(p33) -- Line: 95
    local v34 = p33:GetAttribute("StartMove") or workspace:GetServerTimeNow();
    local v35 = p33:GetAttribute("MoveDuration") or 0;
    local v36;

    if v35 > 0 then
        local v37 = (workspace:GetServerTimeNow() - v34) / v35;
        v36 = math.clamp(v37, 0, 1);
    else
        v36 = 1;
    end;

    return v36, math.max(v35 * (1 - v36), 0);
end;

local function getStartPivot(p38) -- Line: 103
    local v39 = p38:GetAttribute("StartPosition");

    if typeof(v39) == "Vector3" then
        return CFrame.new(v39) * p38:GetPivot().Rotation;
    end;

    return p38:GetPivot();
end;

local function addGnome(u40) -- Line: 112
    -- upvalues: u14 (ref), getMoveInfo (copy), u6 (copy), createBillboard (copy), u12 (copy), prepareGnome (copy), Animations (copy), u8 (copy), u1 (copy), u2 (copy)
    local v41 = u40:GetAttribute("FarmerName");

    if not v41 or u14:FindFirstChild(u40.Name) then
        return;
    end;

    local v42, v43 = getMoveInfo(u40);

    if v42 >= 1 then
        return;
    end;

    local u44 = u6.getModel(v41, u40:GetAttribute("Mutations") or "Night", u40:GetAttribute("Huge"));

    if not u44 then
        return;
    end;

    u44.Name = u40.Name;
    u44:SetAttribute("FarmerName", v41);
    u44:SetAttribute("Mutations", u40:GetAttribute("Mutations") or "Night");
    u44:SetAttribute("Huge", u40:GetAttribute("Huge"));
    u44:SetAttribute("RolledRarity", u40:GetAttribute("RolledRarity"));
    u44:SetAttribute("Level", u40:GetAttribute("Level"));
    u44:SetAttribute("XP", u40:GetAttribute("XP"));
    u44:SetAttribute("NightGnome", true);
    u44:SetAttribute("GnomeStepGroup", math.random(1, 3));
    createBillboard(u44);
    local v45 = u40:GetAttribute("StartPosition");
    local v46;

    if typeof(v45) == "Vector3" then
        v46 = CFrame.new(v45) * u40:GetPivot().Rotation;
    else
        v46 = u40:GetPivot();
    end;

    u44:PivotTo(v46:Lerp(u12:GetPivot(), v42));
    prepareGnome(u44);
    u44.Parent = u14;
    local Gnome = Animations.new("Gnome", u44);

    if Gnome then
        Gnome:ChangeAnimation("Walk");
    end;

    local u47 = u8:TweenModel(u44, v43, "Linear", "Out", u12:GetPivot(), nil, function() -- Line: 139
        -- upvalues: u44 (copy)
        if u44.Parent then
            u44:Destroy();
        end;
    end);
    local v48 = script.Attachment:Clone();
    v48.Parent = u44;
    local u49 = u1(v48, "ProximityPrompt");
    local u50 = nil;
    local u51 = nil;
    local u52 = nil;
    local u53 = nil;
    local u54 = false;

    local function cleanup() -- Line: 155
        -- upvalues: u54 (ref), u47 (ref), Gnome (ref), u50 (ref), u51 (ref), u52 (ref), u53 (ref)
        if u54 then
            return;
        end;

        u54 = true;

        if u47 then
            u47:Cancel();
            u47 = nil;
        end;

        if Gnome then
            Gnome:Destroy();
            Gnome = nil;
        end;

        if u50 then
            u50:Disconnect();
            u50 = nil;
        end;

        if u51 then
            u51:Disconnect();
            u51 = nil;
        end;

        if u52 then
            u52:Disconnect();
            u52 = nil;
        end;

        if u53 then
            u53:Disconnect();
            u53 = nil;
        end;
    end;

    u50 = u49.Triggered:Connect(function() -- Line: 197
        -- upvalues: u49 (copy), u2 (ref), u40 (copy)
        u49.Enabled = false;
        u2:FireServer("BuyFarmer", u40);
    end);
    u51 = u44.Destroying:Once(cleanup);
    u52 = u40.Destroying:Once(function() -- Line: 190, Name: removeGnome
        -- upvalues: cleanup (copy), u44 (copy)
        cleanup();

        if u44.Parent then
            u44:Destroy();
        end;
    end);
    u53 = u40.AncestryChanged:Connect(function(p55, p56) -- Line: 203
        -- upvalues: cleanup (copy), u44 (copy)
        if not p56 then
            cleanup();

            if u44.Parent then
                u44:Destroy();
            end;
        end;
    end);
end;

function v13.Initialize(p57) -- Line: 210
    -- upvalues: u14 (ref), u10 (copy), u11 (copy), addGnome (copy), u15 (ref), u16 (ref)
    u14 = u10:FindFirstChild("ClientGnomes") or Instance.new("Folder");
    u14.Name = "ClientGnomes";
    u14.Parent = u10;

    for _, child in u11:GetChildren() do
        addGnome(child);
    end;

    if u15 then
        u15:Disconnect();
    end;

    u15 = u11.ChildAdded:Connect(addGnome);

    if u16 then
        u16:Disconnect();
    end;

    u16 = u11.ChildRemoved:Connect(function(p58) -- Line: 227
        -- upvalues: u14 (ref)
        local v59 = u14:FindFirstChild(p58.Name);

        if v59 then
            v59:Destroy();
        end;
    end);
end;

return v13;