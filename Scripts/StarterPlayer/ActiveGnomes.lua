--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ActiveGnomes
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Tabs.ActiveGnomes
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:28 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Replication = require(ReplicatedStorage.Replication);
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
local u2 = Library.get("Network");
local u3 = Library.get("Numbers");
local u4 = Library.get("Signal");
local u5 = Library.get("SimpleTween");
local u6 = Library.get("Farmers");
local u7 = Library.get("Plants");
local u8 = Library.get("Crops");
local u9 = Library.get("Levels");
local u10 = Library.get("Rarities");
local v11 = {};
local u12 = {};
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = nil;
local u21 = nil;
local Template = script.Template;

local function tweenToTop(u22) -- Line: 42
    -- upvalues: u20 (ref), RunService (copy), u13 (ref), u5 (copy)
    if not (u22 and u20) then
        return;
    end;

    task.defer(function() -- Line: 45
        -- upvalues: RunService (ref), u22 (copy), u20 (ref), u13 (ref), u5 (ref)
        RunService.Heartbeat:Wait();

        if not (u22.Parent and u20.Parent) then
            return;
        end;

        local v23 = u22.AbsolutePosition.Y - u20.AbsolutePosition.Y + u20.CanvasPosition.Y;
        local v24 = math.max(0, u20.AbsoluteCanvasSize.Y - u20.AbsoluteWindowSize.Y);
        local v25 = math.clamp(v23, 0, v24);

        if u13 then
            u13:Cancel();
            u13 = nil;
        end;

        u13 = u5:Tween(u20, 0.25, "Quad", "Out", {
            CanvasPosition = Vector2.new(u20.CanvasPosition.X, v25)
        });
    end);
end;

local function DisplayButtons(u26, p27, p28) -- Line: 65
    -- upvalues: u14 (ref), Template (copy), u15 (ref), u16 (ref), u21 (ref), u20 (ref), RunService (copy), u13 (ref), u5 (copy)
    if u14 and u14:FindFirstChild("UIStroke") then
        u14.UIStroke.Color = Template.UIStroke.Color;
    end;

    u14 = u26;
    u15 = p27;
    u16 = p28;

    if u26:FindFirstChild("UIStroke") then
        u26.UIStroke.Color = Color3.new(1, 1, 1);
    end;

    u21.LayoutOrder = u26.LayoutOrder + 1;
    u21.Visible = true;

    if u26 then
        if not u20 then
            return;
        end;

        task.defer(function() -- Line: 45
            -- upvalues: RunService (ref), u26 (copy), u20 (ref), u13 (ref), u5 (ref)
            RunService.Heartbeat:Wait();

            if not (u26.Parent and u20.Parent) then
                return;
            end;

            local v29 = u26.AbsolutePosition.Y - u20.AbsolutePosition.Y + u20.CanvasPosition.Y;
            local v30 = math.max(0, u20.AbsoluteCanvasSize.Y - u20.AbsoluteWindowSize.Y);
            local v31 = math.clamp(v29, 0, v30);

            if u13 then
                u13:Cancel();
                u13 = nil;
            end;

            u13 = u5:Tween(u20, 0.25, "Quad", "Out", {
                CanvasPosition = Vector2.new(u20.CanvasPosition.X, v31)
            });
        end);
    end;
end;

local function clearSelection() -- Line: 83
    -- upvalues: u21 (ref), u14 (ref), u15 (ref), u16 (ref)
    u21.Visible = false;
    u14 = nil;
    u15 = nil;
    u16 = nil;
end;

local function getPriceText(p32) -- Line: 90
    -- upvalues: u3 (copy)
    return p32 >= 100000 and u3.Suffix(p32) or u3.Comma(p32);
end;

local function clearList() -- Line: 94
    -- upvalues: u20 (ref)
    for _, child in u20:GetChildren() do
        if child:GetAttribute("ActiveGnome") then
            child:Destroy();
        end;
    end;
end;

local function addGnome(u33, u34, p35) -- Line: 102
    -- upvalues: u6 (copy), u7 (copy), u9 (copy), u8 (copy), Template (copy), u3 (copy), u10 (copy), u20 (ref), u12 (ref), DisplayButtons (copy)
    local v36 = u6[u34.name];

    if not v36 then
        return;
    end;

    local plant = v36.plant;
    local v37 = u7[plant];

    if not v37 then
        return;
    end;

    local v38 = u9.getProgress(u34.level, u34.xp);

    if v37.fruit then
        plant = v37.fruit.name or plant;
    end;

    local v39 = u8.get(plant, u34.mutations);
    local v40 = u8.getPrice(plant, u34.huge and 1.5 or 1, u34.mutations or "") or (v37.sell_price or 0);
    local u41 = Template:Clone();
    u41.Name = tostring(u33);
    u41.LayoutOrder = p35 * 2;
    u41.Visible = true;
    u41:SetAttribute("ActiveGnome", true);
    u41.GnomeName.Text = u34.huge and `HUGE {u34.name}` or u34.name;
    local Frame = u41.Frame;
    Frame.Icon.Image = v36.icon or "";
    Frame.Rarity.Text = u34.rarity and `1/{u3.Comma(u34.rarity)}` or v36.rarity;
    u10:SetColor(v36.real_rarity, Frame.Rarity);
    u41.Level.Level.Text = `LVL {v38.level}`;
    u41.Level.LevelBar.Bar.Size = UDim2.fromScale(v38.alpha, 1);
    u41.Level.LevelBar.Bar.Visible = v38.alpha > 0.01;
    local Price = u41.ValueIncrease.Price;
    local v42 = u9.getValue(v40, v38.level - 1);
    Price.Text = `{v42 >= 100000 and u3.Suffix(v42) or u3.Comma(v42)}$`;
    local AfterLevel = u41.ValueIncrease.AfterLevel;
    local v43 = u9.getValue(v40, v38.level);
    AfterLevel.Text = `> {v43 >= 100000 and u3.Suffix(v43) or u3.Comma(v43)}$`;
    u41.UnitInfo.Label.Text = "Sell price for a";
    u41.UnitInfo.Icon.Image = v39 and v39.icon or (v37.icon or "");
    u41.Parent = u20;
    u12[#u12 + 1] = u41.Button.Activated:Connect(function() -- Line: 139
        -- upvalues: DisplayButtons (ref), u41 (copy), u33 (copy), u34 (copy)
        DisplayButtons(u41, u33, u34);
    end);
end;

local function open() -- Line: 144
    -- upvalues: clearList (copy), u21 (ref), Replication (copy), u6 (copy), addGnome (copy), u1 (copy), u12 (ref), u15 (ref), u2 (copy), u14 (ref), u16 (ref), u4 (copy)
    clearList();
    u21.Visible = false;
    local v44 = {};

    for i, v in Replication.Data.farmers or {} do
        if type(v) == "table" then
            v44[#v44 + 1] = {
                id = i,
                info = v,
                order = u6[v.name] and u6[v.name].order or 0
            };
        end;
    end;

    table.sort(v44, function(p45, p46) -- Line: 160
        return p45.order > p46.order;
    end);

    for i, v in v44 do
        addGnome(v.id, v.info, i);
    end;

    local v47 = u1(u21, "Buttons");
    local v48;

    if v47 then
        v48 = u1(v47, "PickUp");
    else
        v48 = v47;
    end;

    if v47 then
        v47 = u1(v47, "Find");
    end;

    if v48 and v48:FindFirstChild("Button") then
        u12[#u12 + 1] = v48.Button.Activated:Connect(function() -- Line: 173
            -- upvalues: u15 (ref), u2 (ref), u21 (ref), u14 (ref), u16 (ref)
            if not u15 then
                return;
            end;

            u2:FireServer("PickupFarmer", u15);
            u21.Visible = false;

            if u14 then
                u14:Destroy();
                u14 = nil;
                u15 = nil;
                u16 = nil;
            end;
        end);
    end;

    if v47 and v47:FindFirstChild("Button") then
        u12[#u12 + 1] = v47.Button.Activated:Connect(function() -- Line: 187
            -- upvalues: u15 (ref), u4 (ref)
            if not u15 then
                return;
            end;

            u4.Fire("ShowDisplayedFarmer", u15);
            u4.Fire("CloseTab", "ActiveGnomes");
        end);
    end;
end;

local function close() -- Line: 195
    -- upvalues: u12 (ref), u14 (ref), u15 (ref), u16 (ref), clearList (copy)
    for _, v in next, u12 do
        v:Disconnect();
    end;

    u12 = {};
    u14 = nil;
    u15 = nil;
    u16 = nil;
    clearList();
end;

function v11.Start(p49, p50) -- Line: 207
    -- upvalues: u17 (ref), u18 (ref), u1 (copy), u19 (ref), u20 (ref), u21 (ref), close (copy), open (copy)
    u17 = p50;
    u18 = u1(u17, "Menu");
    u19 = u1(u18, "Frame");
    u20 = u1(u19, "List");
    u21 = u1(u20, "InfoButtons");
    u21.Visible = false;
    u17:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 215
        -- upvalues: u17 (ref), close (ref), open (ref)
        if u17.Enabled then
            open();

            return;
        end;

        close();
    end);
end;

return v11;