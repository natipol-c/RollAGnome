--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ActivePets
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Tabs.ActivePets
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:29 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Replication = require(ReplicatedStorage.Replication);
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
local u2 = Library.get("Network");
local u3 = Library.get("Signal");
local u4 = Library.get("SimpleTween");
local u5 = Library.get("Rarities");
local Pets = require(ReplicatedStorage.Library.Configs.Pets);
local v6 = {};
local u7 = {};
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local Template = script.Template;

local function tweenToTop(u16) -- Line: 37
    -- upvalues: u14 (ref), RunService (copy), u8 (ref), u4 (copy)
    if not (u16 and u14) then
        return;
    end;

    task.defer(function() -- Line: 40
        -- upvalues: RunService (ref), u16 (copy), u14 (ref), u8 (ref), u4 (ref)
        RunService.Heartbeat:Wait();

        if not (u16.Parent and u14.Parent) then
            return;
        end;

        local v17 = u16.AbsolutePosition.Y - u14.AbsolutePosition.Y + u14.CanvasPosition.Y;
        local v18 = math.max(0, u14.AbsoluteCanvasSize.Y - u14.AbsoluteWindowSize.Y);
        local v19 = math.clamp(v17, 0, v18);

        if u8 then
            u8:Cancel();
            u8 = nil;
        end;

        u8 = u4:Tween(u14, 0.25, "Quad", "Out", {
            CanvasPosition = Vector2.new(u14.CanvasPosition.X, v19)
        });
    end);
end;

local function DisplayButtons(u20, p21) -- Line: 60
    -- upvalues: u9 (ref), Template (copy), u10 (ref), u15 (ref), u14 (ref), RunService (copy), u8 (ref), u4 (copy)
    if u9 and u9:FindFirstChild("UIStroke") then
        u9.UIStroke.Color = Template.UIStroke.Color;
    end;

    u9 = u20;
    u10 = p21;

    if u20:FindFirstChild("UIStroke") then
        u20.UIStroke.Color = Color3.new(1, 1, 1);
    end;

    u15.LayoutOrder = u20.LayoutOrder + 1;
    u15.Visible = true;

    if u20 then
        if not u14 then
            return;
        end;

        task.defer(function() -- Line: 40
            -- upvalues: RunService (ref), u20 (copy), u14 (ref), u8 (ref), u4 (ref)
            RunService.Heartbeat:Wait();

            if not (u20.Parent and u14.Parent) then
                return;
            end;

            local v22 = u20.AbsolutePosition.Y - u14.AbsolutePosition.Y + u14.CanvasPosition.Y;
            local v23 = math.max(0, u14.AbsoluteCanvasSize.Y - u14.AbsoluteWindowSize.Y);
            local v24 = math.clamp(v22, 0, v23);

            if u8 then
                u8:Cancel();
                u8 = nil;
            end;

            u8 = u4:Tween(u14, 0.25, "Quad", "Out", {
                CanvasPosition = Vector2.new(u14.CanvasPosition.X, v24)
            });
        end);
    end;
end;

local function clearSelection() -- Line: 77
    -- upvalues: u15 (ref), u9 (ref), u10 (ref)
    u15.Visible = false;
    u9 = nil;
    u10 = nil;
end;

local function clearList() -- Line: 83
    -- upvalues: u14 (ref)
    for _, child in u14:GetChildren() do
        if child:GetAttribute("ActivePet") then
            child:Destroy();
        end;
    end;
end;

local function addPet(u25, p26, p27) -- Line: 91
    -- upvalues: Pets (copy), Template (copy), u5 (copy), u14 (ref), u7 (ref), DisplayButtons (copy)
    local v28 = Pets[p26.name];

    if not v28 then
        return;
    end;

    local u29 = Template:Clone();
    u29.Name = tostring(u25);
    u29.LayoutOrder = p27 * 2;
    u29.Visible = true;
    u29:SetAttribute("ActivePet", true);
    u29.PetName.Text = v28.name;
    local Frame = u29.Frame;
    Frame.Icon.Image = v28.icon or "";
    Frame.Rarity.Text = v28.rng and `[ {v28.rng} ]` or v28.rarity;
    u5:SetColor(v28.rarity, Frame.Rarity);
    u29.Rarity.Text = v28.rarity;
    u5:SetColor(v28.rarity, u29.Rarity);
    u29.Description.Text = v28.desc or "";
    u29.Parent = u14;
    u7[#u7 + 1] = u29.Button.Activated:Connect(function() -- Line: 113
        -- upvalues: DisplayButtons (ref), u29 (copy), u25 (copy)
        DisplayButtons(u29, u25);
    end);
end;

local function open() -- Line: 118
    -- upvalues: clearList (copy), u15 (ref), Replication (copy), Pets (copy), addPet (copy), u1 (copy), u7 (ref), u10 (ref), u2 (copy), u9 (ref), u3 (copy)
    clearList();
    u15.Visible = false;
    local v30 = {};

    for i, v in Replication.Data.pets or {} do
        if type(v) == "table" then
            v30[#v30 + 1] = {
                id = i,
                info = v,
                order = Pets[v.name] and Pets[v.name].order or 0
            };
        end;
    end;

    table.sort(v30, function(p31, p32) -- Line: 134
        return p31.order > p32.order;
    end);

    for i, v in v30 do
        addPet(v.id, v.info, i);
    end;

    local v33 = u1(u15, "Buttons");
    local v34;

    if v33 then
        v34 = u1(v33, "PickUp");
    else
        v34 = v33;
    end;

    if v33 then
        v33 = u1(v33, "Find");
    end;

    if v34 and v34:FindFirstChild("Button") then
        u7[#u7 + 1] = v34.Button.Activated:Connect(function() -- Line: 147
            -- upvalues: u10 (ref), u2 (ref), u9 (ref), u15 (ref)
            if not u10 then
                return;
            end;

            u2:FireServer("PickupPet", u10);

            if u9 then
                u9:Destroy();
            end;

            u15.Visible = false;
            u9 = nil;
            u10 = nil;
        end);
    end;

    if v33 and v33:FindFirstChild("Button") then
        u7[#u7 + 1] = v33.Button.Activated:Connect(function() -- Line: 158
            -- upvalues: u10 (ref), u3 (ref)
            if not u10 then
                return;
            end;

            u3.Fire("ShowDisplayedPet", u10);
            u3.Fire("CloseTab", "ActivePets");
        end);
    end;
end;

local function close() -- Line: 166
    -- upvalues: u7 (ref), u9 (ref), u10 (ref), clearList (copy)
    for _, v in next, u7 do
        v:Disconnect();
    end;

    u7 = {};
    u9 = nil;
    u10 = nil;
    clearList();
end;

function v6.Start(p35, p36) -- Line: 177
    -- upvalues: u11 (ref), u12 (ref), u1 (copy), u13 (ref), u14 (ref), u15 (ref), close (copy), open (copy)
    u11 = p36;
    u12 = u1(u11, "Menu");
    u13 = u1(u12, "Frame");
    u14 = u1(u13, "List");
    u15 = u1(u14, "InfoButtons");
    u15.Visible = false;
    u11:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 185
        -- upvalues: u11 (ref), close (ref), open (ref)
        if u11.Enabled then
            open();

            return;
        end;

        close();
    end);
end;

return v6;