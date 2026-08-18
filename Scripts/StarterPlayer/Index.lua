--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Index
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Tabs.Index
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:08 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Replication = require(ReplicatedStorage.Replication);
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
local u2 = Library.get("Network");
local u3 = Library.get("Numbers");
local u4 = Library.get("Rarities");
Library.get("Signal");
Library.get("SimpleTween");
local u5 = Library.get("Plants");
local u6 = Library.get("Farmers");
local MutationImages = ReplicatedStorage.Assets.MutationImages;
local _ = Players.LocalPlayer;
local v7 = {};
local u8 = {};
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = nil;
local u21 = "Fruits";
local u22 = "Normal";
local u23 = "Normal";
local u24 = "All";
local u25 = "All";
local u26 = 0;
local u27 = {
    Starbush = true,
    ["Starbush Fruit"] = true
};

local function countsForFruitIndex(p28, p29) -- Line: 52
    -- upvalues: u27 (copy)
    return not u27[p28] and not u27[p29];
end;

local function updateMutationImage(p30, p31, p32) -- Line: 57
    -- upvalues: MutationImages (copy)
    local v33 = next;
    local v34, v35 = p30:GetDescendants();

    for _, v in v33, v34, v35 do
        if v:GetAttribute("REMOVE") then
            v:Destroy();
        end;
    end;

    if not p32 or p31 == "Normal" then
        return;
    end;

    local v36 = MutationImages:FindFirstChild(p31 == "HUGE" and "Huge" or p31);

    if v36 then
        local v37 = v36:Clone();
        v37.Parent = p30;
        v37:SetAttribute("REMOVE", true);
    end;
end;

local function updateSelectedButtons() -- Line: 75
    -- upvalues: u11 (ref), u21 (ref), u12 (ref), u20 (ref), u17 (ref), u18 (ref), u23 (ref), u19 (ref), u22 (ref), u16 (ref), u25 (ref), u15 (ref), u24 (ref)
    if u11 then
        u11.Visible = u21 == "Fruits";
    end;

    if u12 then
        u12.Visible = u21 == "Gnomes" and true or u21 == "Night";
    end;

    if u20 then
        u20.Visible = u21 == "Fruits";
    end;

    local v38 = next;
    local v39, v40 = u17:GetChildren();

    for _, v in v38, v39, v40 do
        if v:IsA("Frame") then
            local Selected = v.Frame:FindFirstChild("Selected");

            if Selected then
                Selected.Visible = v.Name == u21;
            end;
        end;
    end;

    if u18 then
        u18.Visible = u21 == "Gnomes" and true or u21 == "Night";

        for _, child in u18:GetChildren() do
            if child:IsA("Frame") then
                local Selected = child.Frame:FindFirstChild("Selected");

                if Selected then
                    Selected.Visible = child.Name == u23;
                end;
            end;
        end;
    end;

    if u19 then
        u19.Visible = u21 == "Fruits";

        for _, child in u19:GetChildren() do
            if child:IsA("Frame") then
                local Selected = child.Frame:FindFirstChild("Selected");

                if Selected then
                    Selected.Visible = child.Name == u22;
                end;
            end;
        end;
    end;

    if u16 then
        for _, child in u16:GetChildren() do
            if child:IsA("Frame") then
                local Selected = child.Frame:FindFirstChild("Selected");

                if Selected then
                    Selected.Visible = child.Name == u25;
                end;
            end;
        end;
    end;

    if u15 then
        for _, child in u15:GetChildren() do
            if child:IsA("Frame") then
                local Selected = child.Frame:FindFirstChild("Selected");

                if Selected then
                    Selected.Visible = child.Name == u24;
                end;
            end;
        end;
    end;
end;

local function updateIndexMulti() -- Line: 142
    -- upvalues: u20 (ref), Replication (copy), u5 (copy), u27 (copy), u26 (ref), u2 (copy)
    if not u20 then
        return;
    end;

    local v41 = Replication.Data.best_fruit or {};
    local v42 = 0;
    local v43 = 0;

    for i, v in next, u5 do
        local v44;

        if v.fruit then
            v44 = v.fruit.name or i;
        else
            v44 = i;
        end;

        if not u27[i] and not u27[v44] then
            v43 = v43 + 1;

            if v41[v44] then
                v42 = v42 + 1;
            end;
        end;
    end;

    local v45 = v43 > 0 and (v42 / v43 or 0) or 0;
    local v46 = math.floor(v45 * 100);
    local v47 = v46 >= 100 and 100 or (v46 >= 75 and 75 or (v46 >= 50 and 50 or (v46 >= 25 and 25 or 0)));
    u20.Frame.Percent.Text = `({v46}%)`;
    u20.Frame.TextLabel.Text = `{v42}/{v43}`;
    u20.Progress.Bar.Size = UDim2.fromScale(v45, 0.5);

    if u26 < v47 then
        u26 = v47;
        task.spawn(function() -- Line: 178
            -- upvalues: u2 (ref)
            u2:InvokeServer("IndexMulti");
        end);
    end;
end;

local function display() -- Line: 184
    -- upvalues: updateSelectedButtons (copy), u13 (ref), u14 (ref), Replication (copy), updateIndexMulti (copy), u21 (ref), u5 (copy), u24 (ref), u22 (ref), updateMutationImage (copy), u25 (ref), u6 (copy), u23 (ref), u4 (copy), u3 (copy)
    updateSelectedButtons();
    local v48 = next;
    local v49, v50 = u13:GetChildren();

    for _, v in v48, v49, v50 do
        if v:IsA("Frame") then
            v:Destroy();
        end;
    end;

    local v51 = next;
    local v52, v53 = u14:GetChildren();

    for _, v in v51, v52, v53 do
        if v:IsA("Frame") then
            v:Destroy();
        end;
    end;

    local Data = Replication.Data;
    local v54 = Data.discovered or {};
    local best_fruit = Data.best_fruit;
    local v55 = Data.best_farmers or {};
    local v56 = Data.best_fruit_mutations or {};
    local v57 = Data.best_farmer_mutations or {};
    local v58 = Data.discovered_mutations or {};
    local v59 = v58.Fruits or {};
    local v60 = v58.Gnomes or {};
    updateIndexMulti();

    if u21 ~= "Fruits" then
        if u21 == "Gnomes" or u21 == "Night" then
            if u21 == "Night" then
                u25 = "Night";
                updateSelectedButtons();
            end;

            local v61 = {};

            for i, v in u6 do
                local v62 = v.filter or (v.night_index and "Night" or nil);

                if (u25 ~= "Main" or not v62) and (u25 ~= "Night" or v62 == "Night") then
                    table.insert(v61, {
                        name = i,
                        info = v,
                        price = v.price or (1 / 0)
                    });
                end;
            end;

            table.sort(v61, function(p63, p64) -- Line: 282
                if p63.price == p64.price then
                    return p63.name < p64.name;
                end;

                return p63.price < p64.price;
            end);

            for i, v in ipairs(v61) do
                local name = v.name;
                local info = v.info;
                local v65 = v54[name] == nil;
                local v66 = v55[name];

                if u23 ~= "Normal" then
                    v66 = v57[name] and v57[name][u23];
                    v65 = not (v60[name] and v60[name][u23]);
                end;

                local v67 = script.Gnome_Template:Clone();
                v67.Name = name;
                v67.LayoutOrder = i;
                v67.Icon.Image = info.icon or "";
                updateMutationImage(v67.Icon, u23, not v65);
                u4:SetLabel(info.real_rarity, v67.Rarity);
                u4:SetColor(info.real_rarity, v67.RNGNumber);
                v67.Icon.ImageColor3 = v65 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
                v67.RNGNumber.TextColor3 = Color3.fromRGB(255, 255, 255);
                v67.RNGNumber.Text = v65 and "???" or (v66 and `1/{u3.Comma(v66)}` or info.rarity);
                v67.Parent = u14;
            end;
        end;

        return;
    end;

    local v68 = {};

    for i, v in next, u5 do
        local filter = v.filter;

        if (u24 ~= "Main" or not filter) and (u24 ~= "Night" or filter == "Night") then
            table.insert(v68, {
                name = i,
                info = v,
                price = v.sell_price or (1 / 0)
            });
        end;
    end;

    table.sort(v68, function(p69, p70) -- Line: 223
        if p69.price == p70.price then
            return p69.name < p70.name;
        end;

        return p69.price < p70.price;
    end);

    for i, v in ipairs(v68) do
        local name = v.name;
        local info = v.info;
        local icon = info.icon;
        local v71;

        if info.fruit then
            v71 = info.fruit.name;
            icon = info.fruit.icon;
        else
            v71 = name;
        end;

        local v72 = best_fruit[v71];
        local v73 = v72 == nil;

        if u22 ~= "Normal" then
            v72 = v56[v71] and v56[v71][u22];
            v73 = not (v59[v71] and v59[v71][u22]);
        end;

        local v74 = script.Fruit_Template:Clone();
        v74.Name = name;
        v74.LayoutOrder = i;
        v74.Icon.Image = icon;
        updateMutationImage(v74.Icon, u22, not v73);
        v74.Icon.ImageColor3 = v73 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
        v74.Rarity.Visible = not v73;
        v74.Record.Visible = not v73;

        if not v73 then
            v74.Rarity.Text = v72 and `{v72} kg` or "";
        end;

        v74.Parent = u13;
    end;
end;

local function open() -- Line: 317
    -- upvalues: display (copy)
    display();
end;

local function close() -- Line: 322
    -- upvalues: u8 (ref)
    for _, v in next, u8 do
        v:Disconnect();
    end;

    u8 = {};
end;

function v7.Start(p75, p76) -- Line: 330
    -- upvalues: u9 (ref), u10 (ref), u1 (copy), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref), display (copy), u23 (ref), u22 (ref), u25 (ref), u24 (ref), u8 (ref)
    u9 = p76;
    u10 = u1(u9, "Menu");
    u11 = u1(u10, "FruitFrame");
    u12 = u1(u10, "GnomeFrame");
    u13 = u1(u11, "List");
    u14 = u1(u12, "List");
    u15 = u1(u11, "Filter");
    u16 = u1(u12, "Filter");
    u17 = u1(u10, "Buttons");
    u18 = u1(u10, "Gnome_Mutations");
    u19 = u1(u10, "Plant_Mutations") or u1(u10, "Fruit_Mutations");
    u20 = u1(u10, "IndexMulti");
    local v77 = next;
    local v78, v79 = u17:GetChildren();
    local u80 = false;

    for _, v in v77, v78, v79 do
        if v:IsA("Frame") then
            u1(v, "Button").MouseButton1Click:Connect(function() -- Line: 350
                -- upvalues: u21 (ref), v (copy), u80 (ref), display (ref)
                if u21 == v.Name then
                    return;
                end;

                if u80 then
                    return;
                end;

                u80 = true;
                u21 = v.Name;
                display();
                task.wait(0.2);
                u80 = false;
            end);
        end;
    end;

    local v81 = next;
    local v82, v83 = u18:GetChildren();

    for _, v in v81, v82, v83 do
        if v:IsA("Frame") and v.Name ~= "SPACE" then
            u1(v, "Button").MouseButton1Click:Connect(function() -- Line: 367
                -- upvalues: u23 (ref), v (copy), display (ref)
                u23 = v.Name;
                display();
            end);
        end;
    end;

    local v84 = next;
    local v85, v86 = u19:GetChildren();

    for _, v in v84, v85, v86 do
        if v:IsA("Frame") then
            u1(v, "Button").MouseButton1Click:Connect(function() -- Line: 376
                -- upvalues: u22 (ref), v (copy), display (ref)
                u22 = v.Name;
                display();
            end);
        end;
    end;

    local v87 = next;
    local v88, v89 = u16:GetChildren();

    for _, v in v87, v88, v89 do
        if v:IsA("Frame") then
            u1(v, "Button").MouseButton1Click:Connect(function() -- Line: 385
                -- upvalues: u25 (ref), v (copy), display (ref)
                u25 = v.Name;
                display();
            end);
        end;
    end;

    if u15 then
        local v90 = next;
        local v91, v92 = u15:GetChildren();

        for _, v in v90, v91, v92 do
            if v:IsA("Frame") then
                u1(v, "Button").MouseButton1Click:Connect(function() -- Line: 395
                    -- upvalues: u24 (ref), v (copy), display (ref)
                    u24 = v.Name;
                    display();
                end);
            end;
        end;
    end;

    u9:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 402
        -- upvalues: u9 (ref), u8 (ref), display (ref)
        if u9.Enabled then
            display();

            return;
        end;

        for _, v in next, u8 do
            v:Disconnect();
        end;

        u8 = {};
    end);
end;

return v7;