--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Index
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Tabs.Index
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:08 2026
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
local Pets = require(ReplicatedStorage.Library.Configs.Pets);
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
local u21 = nil;
local u22 = nil;
local u23 = nil;
local u24 = nil;
local u25 = "Fruits";
local u26 = "Normal";
local u27 = "Normal";
local u28 = "Normal";
local u29 = "All";
local u30 = "All";
local u31 = "All";
local u32 = 0;
local u33 = {
    Starbush = true,
    ["Starbush Fruit"] = true
};

local function countsForFruitIndex(p34, p35) -- Line: 55
    -- upvalues: u33 (copy)
    return not u33[p34] and not u33[p35];
end;

local function updateMutationImage(p36, p37, p38) -- Line: 60
    -- upvalues: MutationImages (copy)
    local v39 = next;
    local v40, v41 = p36:GetDescendants();

    for _, v in v39, v40, v41 do
        if v:GetAttribute("REMOVE") then
            v:Destroy();
        end;
    end;

    if not p38 or p37 == "Normal" then
        return;
    end;

    local v42 = MutationImages:FindFirstChild(p37 == "HUGE" and "Huge" or p37);

    if v42 then
        local v43 = v42:Clone();
        v43.Parent = p36;
        v43:SetAttribute("REMOVE", true);
    end;
end;

local function updateSelectedButtons() -- Line: 78
    -- upvalues: u11 (ref), u25 (ref), u12 (ref), u13 (ref), u24 (ref), u20 (ref), u21 (ref), u27 (ref), u22 (ref), u26 (ref), u23 (ref), u28 (ref), u18 (ref), u30 (ref), u17 (ref), u29 (ref), u19 (ref), u31 (ref)
    if u11 then
        u11.Visible = u25 == "Fruits";
    end;

    if u12 then
        u12.Visible = u25 == "Gnomes" and true or u25 == "Night";
    end;

    if u13 then
        u13.Visible = u25 == "Pets";
    end;

    if u24 then
        u24.Visible = u25 == "Fruits";
    end;

    local v44 = next;
    local v45, v46 = u20:GetChildren();

    for _, v in v44, v45, v46 do
        if v:IsA("Frame") then
            local Selected = v.Frame:FindFirstChild("Selected");

            if Selected then
                Selected.Visible = v.Name == u25;
            end;
        end;
    end;

    if u21 then
        u21.Visible = u25 == "Gnomes" and true or u25 == "Night";

        for _, child in u21:GetChildren() do
            if child:IsA("Frame") then
                local Selected = child.Frame:FindFirstChild("Selected");

                if Selected then
                    Selected.Visible = child.Name == u27;
                end;
            end;
        end;
    end;

    if u22 then
        u22.Visible = u25 == "Fruits";

        for _, child in u22:GetChildren() do
            if child:IsA("Frame") then
                local Selected = child.Frame:FindFirstChild("Selected");

                if Selected then
                    Selected.Visible = child.Name == u26;
                end;
            end;
        end;
    end;

    if u23 then
        u23.Visible = u25 == "Pets";

        for _, child in u23:GetChildren() do
            if child:IsA("Frame") then
                local Selected = child.Frame:FindFirstChild("Selected");

                if Selected then
                    Selected.Visible = child.Name == u28;
                end;
            end;
        end;
    end;

    if u18 then
        for _, child in u18:GetChildren() do
            if child:IsA("Frame") then
                local Selected = child.Frame:FindFirstChild("Selected");

                if Selected then
                    Selected.Visible = child.Name == u30;
                end;
            end;
        end;
    end;

    if u17 then
        for _, child in u17:GetChildren() do
            if child:IsA("Frame") then
                local Selected = child.Frame:FindFirstChild("Selected");

                if Selected then
                    Selected.Visible = child.Name == u29;
                end;
            end;
        end;
    end;

    if u19 then
        for _, child in u19:GetChildren() do
            if child:IsA("Frame") then
                local Selected = child.Frame:FindFirstChild("Selected");

                if Selected then
                    Selected.Visible = child.Name == u31;
                end;
            end;
        end;
    end;
end;

local function ownsPetWithMutation(p47, p48, p49) -- Line: 171
    for _, v in { "pets", "inventory" } do
        local v50 = p47[v];

        if type(v50) == "table" then
            for _, v2 in v50 do
                if type(v2) == "table" and (v2.name == p48 and (v ~= "inventory" or v2.type == "Pet")) then
                    if p49 == "Normal" then
                        return true;
                    end;

                    local mutations = v2.mutations;

                    if type(mutations) == "table" and table.find(mutations, p49) then
                        return true;
                    end;
                end;
            end;
        end;
    end;

    return false;
end;

local function updateIndexMulti() -- Line: 194
    -- upvalues: u24 (ref), Replication (copy), u5 (copy), u33 (copy), u32 (ref), u2 (copy)
    if not u24 then
        return;
    end;

    local v51 = Replication.Data.best_fruit or {};
    local v52 = 0;
    local v53 = 0;

    for i, v in next, u5 do
        local v54;

        if v.fruit then
            v54 = v.fruit.name or i;
        else
            v54 = i;
        end;

        if not u33[i] and not u33[v54] then
            v53 = v53 + 1;

            if v51[v54] then
                v52 = v52 + 1;
            end;
        end;
    end;

    local v55 = v53 > 0 and (v52 / v53 or 0) or 0;
    local v56 = math.floor(v55 * 100);
    local v57 = v56 >= 100 and 100 or (v56 >= 75 and 75 or (v56 >= 50 and 50 or (v56 >= 25 and 25 or 0)));
    u24.Frame.Percent.Text = `({v56}%)`;
    u24.Frame.TextLabel.Text = `{v52}/{v53}`;
    u24.Progress.Bar.Size = UDim2.fromScale(v55, 0.5);

    if u32 < v57 then
        u32 = v57;
        task.spawn(function() -- Line: 230
            -- upvalues: u2 (ref)
            u2:InvokeServer("IndexMulti");
        end);
    end;
end;

local function display() -- Line: 236
    -- upvalues: updateSelectedButtons (copy), u14 (ref), u15 (ref), u16 (ref), Replication (copy), updateIndexMulti (copy), u25 (ref), u5 (copy), u29 (ref), u26 (ref), updateMutationImage (copy), u30 (ref), u6 (copy), u27 (ref), u4 (copy), u3 (copy), Pets (copy), u31 (ref), ownsPetWithMutation (copy), u28 (ref)
    updateSelectedButtons();
    local v58 = next;
    local v59, v60 = u14:GetChildren();

    for _, v in v58, v59, v60 do
        if v:IsA("Frame") then
            v:Destroy();
        end;
    end;

    local v61 = next;
    local v62, v63 = u15:GetChildren();

    for _, v in v61, v62, v63 do
        if v:IsA("Frame") then
            v:Destroy();
        end;
    end;

    if u16 then
        local v64 = next;
        local v65, v66 = u16:GetChildren();

        for _, v in v64, v65, v66 do
            if v:IsA("Frame") then
                v:Destroy();
            end;
        end;
    end;

    local Data = Replication.Data;
    local v67 = Data.discovered or {};
    local best_fruit = Data.best_fruit;
    local v68 = Data.best_farmers or {};
    local v69 = Data.best_fruit_mutations or {};
    local v70 = Data.best_farmer_mutations or {};
    local v71 = Data.discovered_pets or {};
    local v72 = Data.discovered_mutations or {};
    local v73 = v72.Fruits or {};
    local v74 = v72.Gnomes or {};
    local v75 = v72.Pets or {};
    updateIndexMulti();

    if u25 == "Fruits" then
        local v76 = {};

        for i, v in next, u5 do
            local filter = v.filter;

            if (u29 ~= "Main" or not filter) and (u29 ~= "Night" or filter == "Night") then
                table.insert(v76, {
                    name = i,
                    info = v,
                    price = v.sell_price or (1 / 0)
                });
            end;
        end;

        table.sort(v76, function(p77, p78) -- Line: 284
            if p77.price == p78.price then
                return p77.name < p78.name;
            end;

            return p77.price < p78.price;
        end);

        for i, v in ipairs(v76) do
            local name = v.name;
            local info = v.info;
            local icon = info.icon;
            local v79;

            if info.fruit then
                v79 = info.fruit.name;
                icon = info.fruit.icon;
            else
                v79 = name;
            end;

            local v80 = best_fruit[v79];
            local v81 = v80 == nil;

            if u26 ~= "Normal" then
                v80 = v69[v79] and v69[v79][u26];
                v81 = not (v73[v79] and v73[v79][u26]);
            end;

            local v82 = script.Fruit_Template:Clone();
            v82.Name = name;
            v82.LayoutOrder = i;
            v82.Icon.Image = icon;
            updateMutationImage(v82.Icon, u26, not v81);
            v82.Icon.ImageColor3 = v81 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
            v82.Rarity.Visible = not v81;
            v82.Record.Visible = not v81;

            if not v81 then
                v82.Rarity.Text = v80 and `{v80} kg` or "";
            end;

            v82.Parent = u14;
        end;

        return;
    end;

    if u25 ~= "Gnomes" and u25 ~= "Night" then
        if u25 == "Pets" and u16 then
            local v83 = {};

            for i, v in Pets do
                local filter = v.filter;

                if (u31 ~= "Main" or not filter) and (u31 == "All" or (u31 == "Main" or filter == u31)) then
                    table.insert(v83, {
                        name = i,
                        info = v,
                        order = v.order or (1 / 0),
                        price = v.price or (1 / 0)
                    });
                end;
            end;

            table.sort(v83, function(p84, p85) -- Line: 390
                if p84.order ~= p85.order then
                    return p84.order < p85.order;
                end;

                if p84.price == p85.price then
                    return p84.name < p85.name;
                end;

                return p84.price < p85.price;
            end);

            for i, v in ipairs(v83) do
                local name = v.name;
                local info = v.info;
                local v86;

                if v71[name] == nil then
                    v86 = not ownsPetWithMutation(Data, name, "Normal");
                else
                    v86 = false;
                end;

                if u28 ~= "Normal" then
                    v86 = not (v75[name] and v75[name][u28]) and not ownsPetWithMutation(Data, name, u28);
                end;

                local v87 = (script:FindFirstChild("Pet_Template") or script.Gnome_Template):Clone();
                v87.Name = name;
                v87.LayoutOrder = i;
                v87.Icon.Image = info.icon or "";
                updateMutationImage(v87.Icon, u28, not v86);
                u4:SetLabel(info.rarity, v87.Rarity);
                u4:SetColor(info.rarity, v87.RNGNumber);
                v87.Icon.ImageColor3 = v86 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
                v87.RNGNumber.TextColor3 = Color3.fromRGB(255, 255, 255);
                v87.RNGNumber.Text = v86 and "???" or (info.rng or "");
                v87.Parent = u16;
            end;
        end;

        return;
    end;

    if u25 == "Night" then
        u30 = "Night";
        updateSelectedButtons();
    end;

    local v88 = {};

    for i, v in u6 do
        local v89 = v.filter or (v.night_index and "Night" or nil);

        if (u30 ~= "Main" or not v89) and (u30 ~= "Night" or v89 == "Night") then
            table.insert(v88, {
                name = i,
                info = v,
                price = v.price or (1 / 0)
            });
        end;
    end;

    table.sort(v88, function(p90, p91) -- Line: 343
        if p90.price == p91.price then
            return p90.name < p91.name;
        end;

        return p90.price < p91.price;
    end);

    for i, v in ipairs(v88) do
        local name = v.name;
        local info = v.info;
        local v92 = v67[name] == nil;
        local v93 = v68[name];

        if u27 ~= "Normal" then
            v93 = v70[name] and v70[name][u27];
            v92 = not (v74[name] and v74[name][u27]);
        end;

        local v94 = script.Gnome_Template:Clone();
        v94.Name = name;
        v94.LayoutOrder = i;
        v94.Icon.Image = info.icon or "";
        updateMutationImage(v94.Icon, u27, not v92);
        u4:SetLabel(info.real_rarity, v94.Rarity);
        u4:SetColor(info.real_rarity, v94.RNGNumber);
        v94.Icon.ImageColor3 = v92 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
        v94.RNGNumber.TextColor3 = Color3.fromRGB(255, 255, 255);
        v94.RNGNumber.Text = v92 and "???" or (v93 and `1/{u3.Comma(v93)}` or info.rarity);
        v94.Parent = u15;
    end;
end;

local function open() -- Line: 429
    -- upvalues: display (copy)
    display();
end;

local function close() -- Line: 434
    -- upvalues: u8 (ref)
    for _, v in next, u8 do
        v:Disconnect();
    end;

    u8 = {};
end;

function v7.Start(p95, p96) -- Line: 442
    -- upvalues: u9 (ref), u10 (ref), u1 (copy), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref), u22 (ref), u23 (ref), u24 (ref), u25 (ref), display (copy), u27 (ref), u26 (ref), u28 (ref), u30 (ref), u29 (ref), u31 (ref), u8 (ref)
    u9 = p96;
    u10 = u1(u9, "Menu");
    u11 = u1(u10, "FruitFrame");
    u12 = u1(u10, "GnomeFrame");
    u13 = u1(u10, "PetFrame");
    u14 = u1(u11, "List");
    u15 = u1(u12, "List");
    local v97 = u13 and u1(u13, "List");
    u16 = v97;
    u17 = u1(u11, "Filter");
    u18 = u1(u12, "Filter");
    local v98 = u13 and u1(u13, "Filter");
    u19 = v98;
    u20 = u1(u10, "Buttons");
    u21 = u1(u10, "Gnome_Mutations");
    u22 = u1(u10, "Plant_Mutations") or u1(u10, "Fruit_Mutations");
    u23 = u1(u10, "Pet_Mutations");
    u24 = u1(u10, "IndexMulti");
    local v99 = next;
    local v100, v101 = u20:GetChildren();
    local u102 = false;

    for _, v in v99, v100, v101 do
        if v:IsA("Frame") then
            u1(v, "Button").MouseButton1Click:Connect(function() -- Line: 466
                -- upvalues: u25 (ref), v (copy), u102 (ref), display (ref)
                if u25 == v.Name then
                    return;
                end;

                if u102 then
                    return;
                end;

                u102 = true;
                u25 = v.Name;
                display();
                task.wait(0.2);
                u102 = false;
            end);
        end;
    end;

    if u21 then
        local v103 = next;
        local v104, v105 = u21:GetChildren();

        for _, v in v103, v104, v105 do
            if v:IsA("Frame") and v.Name ~= "SPACE" then
                u1(v, "Button").MouseButton1Click:Connect(function() -- Line: 484
                    -- upvalues: u27 (ref), v (copy), display (ref)
                    u27 = v.Name;
                    display();
                end);
            end;
        end;
    end;

    if u22 then
        local v106 = next;
        local v107, v108 = u22:GetChildren();

        for _, v in v106, v107, v108 do
            if v:IsA("Frame") then
                u1(v, "Button").MouseButton1Click:Connect(function() -- Line: 495
                    -- upvalues: u26 (ref), v (copy), display (ref)
                    u26 = v.Name;
                    display();
                end);
            end;
        end;
    end;

    if u23 then
        local v109 = next;
        local v110, v111 = u23:GetChildren();

        for _, v in v109, v110, v111 do
            if v:IsA("Frame") and v.Name ~= "SPACE" then
                u1(v, "Button").MouseButton1Click:Connect(function() -- Line: 506
                    -- upvalues: u28 (ref), v (copy), display (ref)
                    u28 = v.Name;
                    display();
                end);
            end;
        end;
    end;

    local v112 = next;
    local v113, v114 = u18:GetChildren();

    for _, v in v112, v113, v114 do
        if v:IsA("Frame") then
            u1(v, "Button").MouseButton1Click:Connect(function() -- Line: 516
                -- upvalues: u30 (ref), v (copy), display (ref)
                u30 = v.Name;
                display();
            end);
        end;
    end;

    if u17 then
        local v115 = next;
        local v116, v117 = u17:GetChildren();

        for _, v in v115, v116, v117 do
            if v:IsA("Frame") then
                u1(v, "Button").MouseButton1Click:Connect(function() -- Line: 526
                    -- upvalues: u29 (ref), v (copy), display (ref)
                    u29 = v.Name;
                    display();
                end);
            end;
        end;
    end;

    if u19 then
        local v118 = next;
        local v119, v120 = u19:GetChildren();

        for _, v in v118, v119, v120 do
            if v:IsA("Frame") then
                u1(v, "Button").MouseButton1Click:Connect(function() -- Line: 537
                    -- upvalues: u31 (ref), v (copy), display (ref)
                    u31 = v.Name;
                    display();
                end);
            end;
        end;
    end;

    u9:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 544
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