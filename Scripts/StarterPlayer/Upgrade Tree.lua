--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Upgrade Tree
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Upgrade Tree
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:39 2026
]]

-- Decompiled with Potassium's decompiler.

local ContentProvider = game:GetService("ContentProvider");
local GamepadService = game:GetService("GamepadService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local Library = require(ReplicatedStorage.Library);
local Replication = require(ReplicatedStorage.Replication);
local u1 = Library.get("Find");
local u2 = Library.get("Network");
local u3 = Library.get("Numbers");
local u4 = Library.get("Signal");
local u5 = Library.get("SimpleTween");
local u6 = Library.get("Upgrade Tree");
local LocalPlayer = Players.LocalPlayer;
local v7 = {};
local u8 = nil;
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
local u19 = false;
local u20 = nil;
local u21 = nil;
local u22 = 1;
local u23 = 1;
local u24 = false;
local u25 = 1;
local u26 = 0;
local zero = Vector2.zero;
local u27 = 0;
local u28 = {};
local u29 = {};
local u30 = {};
local u31 = {};
local u32 = {};
local u33 = "Main";
local u34 = nil;
local u35 = {
    blue = ColorSequence.new(Color3.fromRGB(138, 198, 255), Color3.fromRGB(0, 153, 255)),
    red = ColorSequence.new(Color3.fromRGB(255, 126, 128), Color3.fromRGB(255, 0, 4)),
    golden = ColorSequence.new(Color3.fromRGB(255, 200, 0), Color3.fromRGB(255, 115, 0)),
    orange = ColorSequence.new(Color3.fromRGB(255, 170, 44), Color3.fromRGB(255, 111, 0)),
    green = ColorSequence.new(Color3.fromRGB(180, 255, 19), Color3.fromRGB(33, 191, 22)),
    grey = ColorSequence.new(Color3.fromRGB(47, 47, 47), Color3.fromRGB(36, 36, 36))
};
local u36 = {
    red = Color3.fromRGB(255, 34, 38),
    golden = Color3.fromRGB(255, 201, 107)
};
local u37 = Color3.fromRGB(255, 255, 255);
local u38 = Color3.fromRGB(255, 44, 47);
local Data = Replication.Data;
local u39 = Data and (Data.upgrade_tree or {}) or {};

local function disconnectConnections() -- Line: 92
    -- upvalues: u28 (copy)
    for _, v in next, u28 do
        v:Disconnect();
    end;

    table.clear(u28);
end;

local function setZoom(p40) -- Line: 100
    -- upvalues: u22 (ref), u13 (ref)
    u22 = math.clamp(p40, 0.5, 1.8);
    u13.Scale = u22;
end;

local function updateMenuScale() -- Line: 105
    -- upvalues: u12 (ref), u25 (ref), LocalPlayer (copy)
    u12.Scale = u25 * (LocalPlayer:GetAttribute("Device") == "Mobile" and 1.35 or 1);
end;

local function getInputPosition(p41) -- Line: 109
    return Vector2.new(p41.Position.X, p41.Position.Y);
end;

local function refreshOwnedUpgrades() -- Line: 113
    -- upvalues: Data (ref), Replication (copy), u39 (ref)
    Data = Replication.Data;
    u39 = Data and Data.upgrade_tree or u39;
end;

local function getUpgradeConfig(p42) -- Line: 118
    -- upvalues: u6 (copy)
    for i, v in next, u6 do
        if type(v) == "table" then
            if v.Position then
                if i == p42 then
                    return v;
                end;
            elseif v[p42] then
                return v[p42];
            end;
        end;
    end;
end;

local function getRebirths() -- Line: 134
    -- upvalues: LocalPlayer (copy), Data (ref)
    local v43 = LocalPlayer:GetAttribute("rebirth");

    if v43 ~= nil then
        return v43;
    end;

    local v44 = LocalPlayer:GetAttribute("rebirths");

    if v44 ~= nil then
        return v44;
    end;

    local v45 = Data and Data.stats;

    return v45 and (v45.rebirth or v45.rebirths or 0) or 0;
end;

local function hasRequiredRebirth(p46) -- Line: 149
    -- upvalues: LocalPlayer (copy), Data (ref)
    local v47 = not p46.RequiredRebirth;

    if not v47 then
        local v48 = LocalPlayer:GetAttribute("rebirth");

        if v48 == nil then
            v48 = LocalPlayer:GetAttribute("rebirths");

            if v48 == nil then
                local v49 = Data and Data.stats;
                v48 = v49 and (v49.rebirth or (v49.rebirths or 0)) or 0;
            end;
        end;

        v47 = p46.RequiredRebirth <= v48;
    end;

    return v47;
end;

local u50 = nil;

local function ownsUpgrade(p51) -- Line: 155
    -- upvalues: u31 (copy), getUpgradeConfig (copy), LocalPlayer (copy), Data (ref), u50 (ref), u39 (ref)
    local v52 = u31[p51] or getUpgradeConfig(p51);

    if not (v52 and v52.RequiredRebirth) then
        if u39[p51] == true then
            return not v52 or u50(v52);
        end;

        return false;
    end;

    local v53 = not v52.RequiredRebirth;

    if not v53 then
        local v54 = LocalPlayer:GetAttribute("rebirth");

        if v54 == nil then
            v54 = LocalPlayer:GetAttribute("rebirths");

            if v54 == nil then
                local v55 = Data and Data.stats;
                v54 = v55 and (v55.rebirth or (v55.rebirths or 0)) or 0;
            end;
        end;

        v53 = v52.RequiredRebirth <= v54;
    end;

    if v53 then
        v53 = u50(v52);
    end;

    return v53;
end;

u50 = function(p56) -- Line: 168, Name: hasRequirements
    -- upvalues: u31 (copy), getUpgradeConfig (copy), LocalPlayer (copy), Data (ref), u50 (ref), u39 (ref)
    for _, v in next, p56.Requires or {} do
        local v57 = u31[v] or getUpgradeConfig(v);
        local v58;

        if v57 and v57.RequiredRebirth then
            v58 = not v57.RequiredRebirth;

            if not v58 then
                local v59 = LocalPlayer:GetAttribute("rebirth");

                if v59 == nil then
                    v59 = LocalPlayer:GetAttribute("rebirths");

                    if v59 == nil then
                        local v60 = Data and Data.stats;
                        v59 = v60 and (v60.rebirth or (v60.rebirths or 0)) or 0;
                    end;
                end;

                v58 = v57.RequiredRebirth <= v59;
            end;

            if v58 then
                v58 = u50(v57);
            end;
        elseif u39[v] == true then
            v58 = not v57 or u50(v57);
        else
            v58 = false;
        end;

        if not v58 then
            return false;
        end;
    end;

    return true;
end;

local function getPage() -- Line: 178
    -- upvalues: u6 (copy), u33 (ref)
    local Main = u6.Main;
    local v61;

    if type(Main) == "table" then
        v61 = Main.Position == nil;
    else
        v61 = false;
    end;

    return v61 and (u6[u33] or {}) or u6;
end;

local function clearNodes() -- Line: 189
    -- upvalues: u32 (copy), u29 (copy), u30 (copy), u31 (copy)
    for i, v in next, u32 do
        if v.Tween then
            v.Tween:Cancel();
        end;

        u32[i] = nil;
    end;

    for _, v in next, u29 do
        v:Destroy();
    end;

    table.clear(u29);
    table.clear(u30);
    table.clear(u31);
end;

local function scaleSize(p62, p63) -- Line: 206
    return UDim2.new(p62.X.Scale * p63, p62.X.Offset * p63, p62.Y.Scale * p63, p62.Y.Offset * p63);
end;

local function stopCanBuyEffect(p64) -- Line: 215
    -- upvalues: u32 (copy)
    local v65 = u32[p64];

    if not v65 then
        return;
    end;

    if v65.Tween then
        v65.Tween:Cancel();
    end;

    local Image = v65.Image;

    if Image then
        Image.Visible = false;
        Image.Size = UDim2.fromScale(1.1);
        Image.ImageTransparency = 0.5;
    end;

    u32[p64] = nil;
end;

local function startCanBuyEffect(u66) -- Line: 233
    -- upvalues: u32 (copy), u5 (copy)
    if u32[u66] then
        return;
    end;

    local CanBuy = u66:FindFirstChild("CanBuy", true);

    if not (CanBuy and (CanBuy:IsA("ImageLabel") or CanBuy:IsA("ImageButton"))) then
        return;
    end;

    local u67 = {
        Image = CanBuy
    };
    u32[u66] = u67;

    local function play() -- Line: 244
        -- upvalues: u32 (ref), u66 (copy), u67 (copy), CanBuy (copy), u5 (ref), play (copy)
        if u32[u66] ~= u67 then
            return;
        end;

        CanBuy.Visible = true;
        CanBuy.Size = UDim2.fromScale(1.1, 1.1);
        CanBuy.ImageTransparency = 0.5;
        u67.Tween = u5:Tween(CanBuy, 1, "Quad", "Out", {
            ImageTransparency = 1,
            Size = UDim2.fromScale(1.7, 1.7)
        }, false, function() -- Line: 254
            -- upvalues: play (ref)
            task.wait(1);
            play();
        end);
    end;

    play();
end;

local function preloadIcons() -- Line: 263
    -- upvalues: u6 (copy), ContentProvider (copy)
    local u68 = {};

    for _, v in next, u6 do
        if type(v) == "table" then
            if v.Icon then
                table.insert(u68, v.Icon);
            else
                for _, v2 in next, v do
                    if type(v2) == "table" and v2.Icon then
                        table.insert(u68, v2.Icon);
                    end;
                end;
            end;
        end;
    end;

    if #u68 > 0 then
        task.spawn(function() -- Line: 281
            -- upvalues: ContentProvider (ref), u68 (copy)
            ContentProvider:PreloadAsync(u68);
        end);
    end;
end;

local function getHexPosition(p69) -- Line: 287
    -- upvalues: u14 (ref), u11 (ref)
    local Offset = u14.Size.X.Offset;
    local v70 = Vector2.new(u11.Size.X.Offset / 2, u11.Size.Y.Offset / 2);
    local X = p69.X;

    return Vector2.new(v70.X + Offset * 0.8 * X, v70.Y + Offset * 0.46 * (p69.Y * 2 + X));
end;

local function getHexDistance(p71) -- Line: 301
    return (math.abs(p71.X) + math.abs(p71.Y) + math.abs(p71.X + p71.Y)) / 2;
end;

local function canBuy(p72) -- Line: 305
    -- upvalues: u31 (copy), u50 (ref), LocalPlayer (copy), Data (ref)
    local v73 = u31[p72];

    if not v73 then
        return false;
    end;

    if not u50(v73) then
        return false;
    end;

    local v74 = not v73.RequiredRebirth;

    if not v74 then
        local v75 = LocalPlayer:GetAttribute("rebirth");

        if v75 == nil then
            v75 = LocalPlayer:GetAttribute("rebirths");

            if v75 == nil then
                local v76 = Data and Data.stats;
                v75 = v76 and (v76.rebirth or (v76.rebirths or 0)) or 0;
            end;
        end;

        v74 = v73.RequiredRebirth <= v75;
    end;

    return v74;
end;

local function canBuyConfig(p77, p78) -- Line: 312
    -- upvalues: u31 (copy), getUpgradeConfig (copy), LocalPlayer (copy), Data (ref), u50 (ref), u39 (ref)
    if not p78 or (p78.OpensPage or p78.BackButton) then
        return false;
    end;

    local v79 = u31[p77] or getUpgradeConfig(p77);
    local v80;

    if v79 and v79.RequiredRebirth then
        v80 = not v79.RequiredRebirth;

        if not v80 then
            local v81 = LocalPlayer:GetAttribute("rebirth");

            if v81 == nil then
                v81 = LocalPlayer:GetAttribute("rebirths");

                if v81 == nil then
                    local v82 = Data and Data.stats;
                    v81 = v82 and (v82.rebirth or (v82.rebirths or 0)) or 0;
                end;
            end;

            v80 = v79.RequiredRebirth <= v81;
        end;

        if v80 then
            v80 = u50(v79);
        end;
    elseif u39[p77] == true then
        v80 = not v79 or u50(v79);
    else
        v80 = false;
    end;

    if v80 then
        return false;
    end;

    if p78.RequiredRebirth then
        return false;
    end;

    if p78.Price == nil then
        return false;
    end;

    if u50(p78) then
        return (Data and (Data.stats and Data.stats.money) or 0) >= p78.Price;
    end;

    return false;
end;

local function countBuyableInPage(p83) -- Line: 324
    -- upvalues: u6 (copy), canBuyConfig (copy)
    local v84 = u6[p83];

    if type(v84) ~= "table" or v84.Position then
        return 0;
    end;

    local v85 = 0;

    for i, v in next, v84 do
        if type(v) == "table" and canBuyConfig(i, v) then
            v85 = v85 + 1;
        end;
    end;

    return v85;
end;

local function updatePageNotification(p86, p87) -- Line: 340
    -- upvalues: countBuyableInPage (copy)
    local Noti = p86:FindFirstChild("Noti", true);

    if not Noti then
        return;
    end;

    local v88 = p87.OpensPage and countBuyableInPage(p87.OpensPage) or 0;
    Noti.Visible = v88 > 0;
    local TextLabel = Noti:FindFirstChild("TextLabel", true);

    if TextLabel and TextLabel:IsA("TextLabel") then
        TextLabel.Text = v88 > 99 and "99+" or tostring(v88);
    end;
end;

local function updatePriceColor(p89, p90, p91) -- Line: 353
    -- upvalues: Data (ref), u38 (copy), u37 (copy)
    local Price = (p89:FindFirstChild("Content") or p89):FindFirstChild("Price", true);

    if not (Price and Price:IsA("TextLabel")) then
        return;
    end;

    Price.TextColor3 = (not p91 and (p90.Price and (Data and (Data.stats and Data.stats.money) or 0) < p90.Price) and true or false) and u38 or u37;
end;

local function updateUpgradeNotification() -- Line: 364
    -- upvalues: u18 (ref), LocalPlayer (copy), Data (ref), Replication (copy), u39 (ref), u6 (copy), canBuyConfig (copy)
    if not u18 then
        return;
    end;

    if LocalPlayer:GetAttribute("InTutorial") then
        return;
    end;

    Data = Replication.Data;
    u39 = Data and Data.upgrade_tree or u39;
    local v92 = 0;

    for i, v in next, u6 do
        if type(v) == "table" then
            if v.Position then
                if canBuyConfig(i, v) then
                    v92 = v92 + 1;
                end;
            else
                for i2, v2 in next, v do
                    if type(v2) == "table" and canBuyConfig(i2, v2) then
                        v92 = v92 + 1;
                    end;
                end;
            end;
        end;
    end;

    u18.Visible = v92 > 0;
    local TextLabel = u18:FindFirstChild("TextLabel");

    if TextLabel then
        TextLabel.Text = v92 > 99 and "99+" or tostring(v92);
    end;
end;

local function isLocked(p93) -- Line: 396
    -- upvalues: u31 (copy), u50 (ref), LocalPlayer (copy), Data (ref), getUpgradeConfig (copy), u39 (ref)
    local v94 = u31[p93];

    if not v94 then
        return false;
    end;

    if v94.RequiredRebirth and u50(v94) then
        local v95 = not v94.RequiredRebirth;

        if not v95 then
            local v96 = LocalPlayer:GetAttribute("rebirth");

            if v96 == nil then
                v96 = LocalPlayer:GetAttribute("rebirths");

                if v96 == nil then
                    local v97 = Data and Data.stats;
                    v96 = v97 and (v97.rebirth or (v97.rebirths or 0)) or 0;
                end;
            end;

            v95 = v94.RequiredRebirth <= v96;
        end;

        if not v95 then
            return true;
        end;
    end;

    for _, v in next, v94.Requires or {} do
        local v98 = u31[v] or getUpgradeConfig(v);

        if v98 and (v98.RequiredRebirth and u50(v98)) then
            local v99 = u31[v] or getUpgradeConfig(v);
            local v100;

            if v99 and v99.RequiredRebirth then
                v100 = not v99.RequiredRebirth;

                if not v100 then
                    local v101 = LocalPlayer:GetAttribute("rebirth");

                    if v101 == nil then
                        v101 = LocalPlayer:GetAttribute("rebirths");

                        if v101 == nil then
                            local v102 = Data and Data.stats;
                            v101 = v102 and (v102.rebirth or (v102.rebirths or 0)) or 0;
                        end;
                    end;

                    v100 = v99.RequiredRebirth <= v101;
                end;

                if v100 then
                    v100 = u50(v99);
                end;
            elseif u39[v] == true then
                v100 = not v99 or u50(v99);
            else
                v100 = false;
            end;

            if not v100 then
                return true;
            end;
        end;

        local v103 = u31[v];
        local v104;

        if v103 and u50(v103) then
            v104 = not v103.RequiredRebirth;

            if not v104 then
                local v105 = LocalPlayer:GetAttribute("rebirth");

                if v105 == nil then
                    v105 = LocalPlayer:GetAttribute("rebirths");

                    if v105 == nil then
                        local v106 = Data and Data.stats;
                        v105 = v106 and (v106.rebirth or (v106.rebirths or 0)) or 0;
                    end;
                end;

                v104 = v103.RequiredRebirth <= v105;
            end;
        else
            v104 = false;
        end;

        if v104 then
            local v107 = u31[v] or getUpgradeConfig(v);
            local v108;

            if v107 and v107.RequiredRebirth then
                v108 = not v107.RequiredRebirth;

                if not v108 then
                    local v109 = LocalPlayer:GetAttribute("rebirth");

                    if v109 == nil then
                        v109 = LocalPlayer:GetAttribute("rebirths");

                        if v109 == nil then
                            local v110 = Data and Data.stats;
                            v109 = v110 and (v110.rebirth or (v110.rebirths or 0)) or 0;
                        end;
                    end;

                    v108 = v107.RequiredRebirth <= v109;
                end;

                if v108 then
                    v108 = u50(v107);
                end;
            elseif u39[v] == true then
                v108 = not v107 or u50(v107);
            else
                v108 = false;
            end;

            if not v108 then
                return true;
            end;
        end;
    end;

    return false;
end;

local function setContentVisible(p111, p112) -- Line: 418
    local v113 = p111:FindFirstChild("Content") or p111;
    local v114 = next;
    local v115, v116 = v113:GetChildren();

    for _, v in v114, v115, v116 do
        v.Visible = p112;
    end;
end;

local function normalNode(p117, p118, p119) -- Line: 425
    -- upvalues: u35 (copy), u36 (copy)
    local v120 = p117:FindFirstChild("Content") or p117;
    local Button = p117:FindFirstChild("Button", true);
    local Outline = p117:FindFirstChild("Outline", true);
    local v121;

    if Outline then
        v121 = Outline:FindFirstChild("UIGradient");
    else
        v121 = Outline;
    end;

    local Gradient = p117:FindFirstChild("Gradient", true);
    local Locked = p117:FindFirstChild("Locked", true);
    local Icon = v120:FindFirstChild("Icon", true);
    local UpgradeName = v120:FindFirstChild("UpgradeName", true);
    local Price = v120:FindFirstChild("Price", true);
    local SubTitle = v120:FindFirstChild("SubTitle", true);

    if Button then
        Button.Visible = true;
    end;

    if Outline then
        Outline.Visible = true;
    end;

    if v121 then
        v121.Enabled = not (p119 or p118.OpensPage) and not p118.BackButton;
    end;

    if p118.RequiredRebirth and p119 then
        if Gradient then
            Gradient.Color = u35.green;
        end;
    elseif p119 or (p118.OpensPage or p118.BackButton) then
        if p118.BackButton then
            if Gradient then
                Gradient.Color = u35.red;
            end;
        elseif p118.OpensPage then
            if Gradient then
                Gradient.Color = u35.golden;
            end;
        elseif Gradient then
            Gradient.Color = u35.blue;
        end;
    elseif Gradient then
        Gradient.Color = u35.grey;
    end;

    if Locked then
        Locked.Visible = false;
    end;

    if Icon then
        Icon.Visible = not p118.BackButton;
    end;

    if UpgradeName then
        UpgradeName.Visible = true;
    end;

    if Price then
        Price.Visible = not (p119 or p118.OpensPage) and not p118.BackButton;
    end;

    if SubTitle then
        SubTitle.Visible = p118.BackButton or p118.OpensPage;
    end;

    if p118.BackButton then
        if SubTitle then
            SubTitle.Text = "BACK";
            SubTitle.TextColor3 = u36.red;
        end;
    elseif p118.OpensPage and SubTitle then
        SubTitle.Text = "OPEN";
        SubTitle.TextColor3 = u36.golden;
    end;
end;

local function lockedNode(p122) -- Line: 478
    -- upvalues: u35 (copy)
    local v123 = p122:FindFirstChild("Content") or p122;
    local v124 = next;
    local v125, v126 = v123:GetChildren();

    for _, v in v124, v125, v126 do
        v.Visible = false;
    end;

    local Button = p122:FindFirstChild("Button", true);
    local Outline = p122:FindFirstChild("Outline", true);
    local Gradient = p122:FindFirstChild("Gradient", true);
    local Locked = p122:FindFirstChild("Locked", true);

    if Button then
        Button.Visible = false;
    end;

    if Outline then
        Outline.Visible = false;
    end;

    if Gradient then
        Gradient.Color = u35.grey;
    end;

    if Locked then
        Locked.Visible = true;
    end;
end;

local function rebirthNode(p127, p128, p129) -- Line: 491
    local v130 = p127:FindFirstChild("Content") or p127;
    local Button = p127:FindFirstChild("Button", true);
    local Outline = p127:FindFirstChild("Outline", true);
    local Icon = v130:FindFirstChild("Icon", true);
    local Locked = p127:FindFirstChild("Locked", true);
    local RebirthRequired = p127:FindFirstChild("RebirthRequired", true);
    local v131 = p127:FindFirstChild("Content") or p127;
    local v132 = next;
    local v133, v134 = v131:GetChildren();

    for _, v in v132, v133, v134 do
        v.Visible = true;
    end;

    if v130:IsA("GuiObject") then
        v130.Visible = true;
    end;

    local v135 = next;
    local v136, v137 = v130:GetDescendants();

    for _, v in v135, v136, v137 do
        if v:IsA("GuiObject") then
            v.Visible = true;
        end;
    end;

    if Button then
        Button.Visible = true;
    end;

    if Locked then
        Locked.Visible = false;
    end;

    if Outline then
        Outline.Visible = true;
    end;

    if Icon then
        Icon.Visible = true;

        if p128.Icon then
            Icon.Image = p128.Icon;
        end;
    end;

    local v138 = next;
    local v139, v140 = p127:GetDescendants();

    for _, v in v138, v139, v140 do
        if v:IsA("TextLabel") then
            v.Visible = v == RebirthRequired;
        end;
    end;

    if RebirthRequired then
        RebirthRequired.Visible = true;
        RebirthRequired.Text = ("Rebirth %s Required"):format(p128.RequiredRebirth or 0);
        RebirthRequired.TextWrapped = true;
    end;
end;

local function tweenNode(p141) -- Line: 531
    -- upvalues: u30 (copy), u5 (copy)
    local v142 = u30[p141];

    if not v142 then
        return;
    end;

    p141.Size = UDim2.fromOffset(0, 0);
    u5:Tween(p141, 0.25, "Back", "Out", {
        Size = v142
    });
end;

local function setNodeSize(p143, p144) -- Line: 541
    -- upvalues: u30 (copy)
    local v145 = u30[p143];

    if not v145 then
        return;
    end;

    p143.Size = UDim2.fromOffset(v145.X.Offset + p144, v145.Y.Offset + p144);
end;

local function setupNodeButton(u146, u147) -- Line: 548
    -- upvalues: u31 (copy), u30 (copy), LocalPlayer (copy), u26 (ref), u27 (ref), u50 (ref), Data (ref), u34 (ref), getUpgradeConfig (copy), u39 (ref), u2 (copy), u33 (ref)
    local Button = u146:FindFirstChild("Button", true);

    if not (Button and Button:IsA("GuiButton")) then
        return;
    end;

    local u148 = u31[u147];
    Button.MouseEnter:Connect(function() -- Line: 553
        -- upvalues: u146 (copy), u30 (ref)
        if not u146.Visible then
            return;
        end;

        local v149 = u146;
        local v150 = u30[v149];

        if not v150 then
            return;
        end;

        v149.Size = UDim2.fromOffset(v150.X.Offset + 8, v150.Y.Offset + 8);
    end);
    Button.MouseLeave:Connect(function() -- Line: 558
        -- upvalues: u146 (copy), u30 (ref)
        local v151 = u146;
        local v152 = u30[v151];

        if not v152 then
            return;
        end;

        v151.Size = UDim2.fromOffset(v152.X.Offset + 0, v152.Y.Offset + 0);
    end);
    Button.MouseButton1Down:Connect(function() -- Line: 562
        -- upvalues: u146 (copy), u30 (ref)
        if not u146.Visible then
            return;
        end;

        local v153 = u146;
        local v154 = u30[v153];

        if not v154 then
            return;
        end;

        v153.Size = UDim2.fromOffset(v154.X.Offset + -8, v154.Y.Offset + -8);
    end);
    Button.Activated:Connect(function(p155) -- Line: 567
        -- upvalues: LocalPlayer (ref), u26 (ref), u27 (ref), u148 (copy), u147 (copy), u31 (ref), u50 (ref), Data (ref), u34 (ref), getUpgradeConfig (ref), u39 (ref), u146 (copy), u30 (ref), u2 (ref), u33 (ref)
        if LocalPlayer:GetAttribute("Device") == "Controller" then
            if u26 ~= 0 then
                return;
            end;

            if p155 and (p155.KeyCode ~= Enum.KeyCode.Unknown and p155.KeyCode ~= Enum.KeyCode.ButtonA) then
                return;
            end;

            if os.clock() - u27 < 0.2 then
                return;
            end;
        end;

        if u148.OpensPage then
            local v156 = u31[u147];
            local v157;

            if v156 and u50(v156) then
                v157 = not v156.RequiredRebirth;

                if not v157 then
                    local v158 = LocalPlayer:GetAttribute("rebirth");

                    if v158 == nil then
                        v158 = LocalPlayer:GetAttribute("rebirths");

                        if v158 == nil then
                            local v159 = Data and Data.stats;
                            v158 = v159 and (v159.rebirth or (v159.rebirths or 0)) or 0;
                        end;
                    end;

                    v157 = v156.RequiredRebirth <= v158;
                end;
            else
                v157 = false;
            end;

            if not v157 then
                return;
            end;

            _G.Play("Tap");
            u34(u148.OpensPage, true);

            return;
        end;

        local v160 = u147;
        local v161 = u31[v160] or getUpgradeConfig(v160);
        local v162;

        if v161 and v161.RequiredRebirth then
            v162 = not v161.RequiredRebirth;

            if not v162 then
                local v163 = LocalPlayer:GetAttribute("rebirth");

                if v163 == nil then
                    v163 = LocalPlayer:GetAttribute("rebirths");

                    if v163 == nil then
                        local v164 = Data and Data.stats;
                        v163 = v164 and (v164.rebirth or (v164.rebirths or 0)) or 0;
                    end;
                end;

                v162 = v161.RequiredRebirth <= v163;
            end;

            if v162 then
                v162 = u50(v161);
            end;
        elseif u39[v160] == true then
            v162 = not v161 or u50(v161);
        else
            v162 = false;
        end;

        if not v162 then
            local v165 = u31[u147];
            local v166;

            if v165 and u50(v165) then
                v166 = not v165.RequiredRebirth;

                if not v166 then
                    local v167 = LocalPlayer:GetAttribute("rebirth");

                    if v167 == nil then
                        v167 = LocalPlayer:GetAttribute("rebirths");

                        if v167 == nil then
                            local v168 = Data and Data.stats;
                            v167 = v168 and (v168.rebirth or (v168.rebirths or 0)) or 0;
                        end;
                    end;

                    v166 = v165.RequiredRebirth <= v167;
                end;
            else
                v166 = false;
            end;

            if v166 then
                _G.Play("Tap");
                local v169 = u146;
                local v170 = u30[v169];

                if v170 then
                    v169.Size = UDim2.fromOffset(v170.X.Offset + 8, v170.Y.Offset + 8);
                end;

                if not u2:InvokeServer("Upgrade", u33, u147) then
                    return;
                end;

                _G.Play("Purchase");

                return;
            end;
        end;

        local v171 = u146;
        local v172 = u30[v171];

        if not v172 then
            return;
        end;

        v171.Size = UDim2.fromOffset(v172.X.Offset + 0, v172.Y.Offset + 0);
    end);
end;

local function updateNodes(p173) -- Line: 605
    -- upvalues: Data (ref), Replication (copy), u39 (ref), updateUpgradeNotification (ref), u29 (copy), u31 (copy), u50 (ref), getUpgradeConfig (copy), LocalPlayer (copy), isLocked (copy), rebirthNode (copy), normalNode (copy), updatePriceColor (copy), lockedNode (copy), updatePageNotification (copy), canBuyConfig (copy), startCanBuyEffect (copy), u32 (copy), tweenNode (copy), u5 (copy), u30 (copy)
    Data = Replication.Data;
    u39 = Data and Data.upgrade_tree or u39;
    updateUpgradeNotification();

    for i, v in next, u29 do
        local Visible = v.Visible;
        local v174 = v:GetAttribute("State");
        local v175 = u31[i];
        local v176 = u50(v175);
        local v177 = u31[i] or getUpgradeConfig(i);
        local v178;

        if v177 and v177.RequiredRebirth then
            v178 = not v177.RequiredRebirth;

            if not v178 then
                local v179 = LocalPlayer:GetAttribute("rebirth");

                if v179 == nil then
                    v179 = LocalPlayer:GetAttribute("rebirths");

                    if v179 == nil then
                        local v180 = Data and Data.stats;
                        v179 = v180 and (v180.rebirth or (v180.rebirths or 0)) or 0;
                    end;
                end;

                v178 = v177.RequiredRebirth <= v179;
            end;

            if v178 then
                v178 = u50(v177);
            end;
        elseif u39[i] == true then
            v178 = not v177 or u50(v177);
        else
            v178 = false;
        end;

        local v181;

        if v176 then
            local v182 = u31[i];

            if v182 and u50(v182) then
                v181 = not v182.RequiredRebirth;

                if not v181 then
                    local v183 = LocalPlayer:GetAttribute("rebirth");

                    if v183 == nil then
                        v183 = LocalPlayer:GetAttribute("rebirths");

                        if v183 == nil then
                            local v184 = Data and Data.stats;
                            v183 = v184 and (v184.rebirth or (v184.rebirths or 0)) or 0;
                        end;
                    end;

                    v181 = v182.RequiredRebirth <= v183;
                end;
            else
                v181 = false;
            end;

            if v181 then
                v181 = not v178;
            end;
        else
            v181 = v176;
        end;

        local v185 = not (v178 or v181) and isLocked(i);
        local v186 = "Hidden";

        if v175.RequiredRebirth and (v176 or v185) then
            v.Visible = true;
            rebirthNode(v, v175, v178);
            v186 = v178 and "Owned" or "Locked";
        elseif v176 and (v178 or v181) then
            v.Visible = true;
            normalNode(v, v175, v178);
            updatePriceColor(v, v175, v178);
            v186 = v178 and "Owned" or "Available";
        elseif v185 then
            v.Visible = true;
            lockedNode(v);
            v186 = "Locked";
        else
            v.Visible = false;
        end;

        updatePageNotification(v, v175);
        v:SetAttribute("State", v186);

        if v.Visible and canBuyConfig(i, u31[i]) then
            startCanBuyEffect(v);
        else
            local v187 = u32[v];

            if v187 then
                if v187.Tween then
                    v187.Tween:Cancel();
                end;

                local Image = v187.Image;

                if Image then
                    Image.Visible = false;
                    Image.Size = UDim2.fromScale(1.1);
                    Image.ImageTransparency = 0.5;
                end;

                u32[v] = nil;
            end;
        end;

        if p173 and v.Visible then
            if v186 == "Available" and (not Visible or v174 == "Locked") then
                tweenNode(v);
            elseif v186 == "Locked" and not Visible then
                v.Size = UDim2.fromOffset(0, 0);
                task.delay(0.1, function() -- Line: 650
                    -- upvalues: v (copy), u5 (ref), u30 (ref)
                    if v:GetAttribute("State") ~= "Locked" then
                        return;
                    end;

                    u5:Tween(v, 0.25, "Back", "Out", {
                        Size = u30[v]
                    });
                end);
            end;
        end;
    end;
end;

local function createNodes() -- Line: 661
    -- upvalues: u14 (ref), u15 (ref), u6 (copy), u33 (ref), getHexPosition (copy), u11 (ref), u29 (copy), u30 (copy), u31 (copy), u3 (copy), setupNodeButton (copy)
    u14.Visible = false;

    if u15 then
        u15.Visible = false;
    end;

    local v188 = next;
    local Main = u6.Main;
    local v189;

    if type(Main) == "table" then
        v189 = Main.Position == nil;
    else
        v189 = false;
    end;

    local v190, v191;

    if v189 then
        v190 = u6[u33] or {};
        v191 = nil;
    else
        v190 = u6;
        v191 = nil;
    end;

    for i, v in v188, v190, v191 do
        local v192 = getHexPosition(v.Position);
        local v193 = v.Offset or (v.PixelOffset or Vector2.zero);
        local v194 = v.RequiredRebirth and u15 or u14;

        if v194 then
            local v195 = v194:Clone();
            v195.Name = i;
            v195.Visible = false;
            v195.AnchorPoint = Vector2.new(0.5, 0.5);
            v195.Position = UDim2.fromOffset(v192.X + v193.X, v192.Y + v193.Y);
            local Position = v.Position;
            v195:SetAttribute("Distance", (math.abs(Position.X) + math.abs(Position.Y) + math.abs(Position.X + Position.Y)) / 2);
            v195.Parent = u11;
            u29[i] = v195;
            u30[v195] = v195.Size;
            u31[i] = v;
            local v196 = v195:FindFirstChild("Content") or v195;
            local UpgradeName = v196:FindFirstChild("UpgradeName", true);
            local Price = v196:FindFirstChild("Price", true);
            local Icon = v196:FindFirstChild("Icon", true);

            if UpgradeName then
                UpgradeName.Text = v.Name or i;
            end;

            if v.Price and Price then
                Price.Text = v.Price == 0 and "FREE" or u3.Suffix(v.Price) .. "$";
            end;

            if v.Icon and Icon then
                Icon.Image = v.Icon;
            end;

            setupNodeButton(v195, i);
        end;
    end;
end;

local function playOpenEffect() -- Line: 706
    -- upvalues: u29 (copy), u30 (copy), u5 (copy)
    for _, v in next, u29 do
        local u197 = u30[v];

        if u197 and v.Visible then
            v.Size = UDim2.fromOffset(0, 0);
            task.delay((v:GetAttribute("Distance") or 0) * 0.05, function() -- Line: 713
                -- upvalues: u5 (ref), v (copy), u197 (copy)
                u5:Tween(v, 0.2, "Back", "Out", {
                    Size = u197
                });
            end);
        end;
    end;
end;

u34 = function(p198, p199) -- Line: 721, Name: loadPage
    -- upvalues: u33 (ref), u11 (ref), clearNodes (copy), createNodes (copy), updateNodes (ref), playOpenEffect (copy)
    u33 = p198 or "Main";
    u11.Position = UDim2.fromScale(0.5, 0.5);
    clearNodes();
    createNodes();
    updateNodes();

    if p199 then
        playOpenEffect();
    end;
end;

local function open() -- Line: 734
    -- upvalues: u28 (copy), u19 (ref), u20 (ref), u21 (ref), u24 (ref), u26 (ref), zero (ref), u11 (ref), u22 (ref), u13 (ref), updateNodes (ref), playOpenEffect (copy), u16 (ref), LocalPlayer (copy), GamepadService (copy), u9 (ref), UserInputService (copy), u8 (ref), u27 (ref), u23 (ref), RunService (copy), u29 (copy)
    for _, v in next, u28 do
        v:Disconnect();
    end;

    table.clear(u28);
    u19 = false;
    u20 = nil;
    u21 = nil;
    u24 = false;
    u26 = 0;
    zero = Vector2.zero;
    u11.Position = UDim2.fromScale(0.5, 0.5);
    u22 = 1;
    u13.Scale = u22;
    updateNodes();
    playOpenEffect();
    u16.Visible = not LocalPlayer:GetAttribute("InTutorial") or LocalPlayer:GetAttribute("BoughtGarden");

    if LocalPlayer:GetAttribute("Device") == "Controller" and not GamepadService.GamepadCursorEnabled then
        GamepadService:EnableGamepadCursor(nil);
    end;

    table.insert(u28, u9.InputBegan:Connect(function(p200) -- Line: 752
        -- upvalues: u19 (ref), u21 (ref), u20 (ref)
        if p200.UserInputType ~= Enum.UserInputType.MouseButton1 and (p200.UserInputType ~= Enum.UserInputType.MouseButton2 and p200.UserInputType ~= Enum.UserInputType.Touch) then
            return;
        end;

        u19 = true;
        u21 = p200;
        u20 = Vector2.new(p200.Position.X, p200.Position.Y);
    end));
    table.insert(u28, UserInputService.InputBegan:Connect(function(p201) -- Line: 764
        -- upvalues: LocalPlayer (ref), u8 (ref)
        if LocalPlayer:GetAttribute("Device") == "Controller" and p201.KeyCode == Enum.KeyCode.ButtonB then
            u8.Enabled = false;
        end;
    end));
    table.insert(u28, UserInputService.InputEnded:Connect(function(p202) -- Line: 770
        -- upvalues: u21 (ref), u19 (ref), u20 (ref), u26 (ref), zero (ref)
        if p202 ~= u21 and (p202.UserInputType ~= Enum.UserInputType.MouseButton1 and (p202.UserInputType ~= Enum.UserInputType.MouseButton2 and p202.UserInputType ~= Enum.UserInputType.Touch)) then
            if p202.KeyCode == Enum.KeyCode.ButtonL2 or p202.KeyCode == Enum.KeyCode.ButtonR2 then
                u26 = 0;

                return;
            end;

            if p202.KeyCode == Enum.KeyCode.Thumbstick2 then
                zero = Vector2.zero;
            end;

            return;
        end;

        u19 = false;
        u20 = nil;
        u21 = nil;
    end));
    table.insert(u28, UserInputService.InputChanged:Connect(function(p203) -- Line: 785
        -- upvalues: u22 (ref), u13 (ref), zero (ref), u27 (ref), u26 (ref), u19 (ref), u24 (ref), u21 (ref), u20 (ref), LocalPlayer (ref), u11 (ref)
        if p203.UserInputType == Enum.UserInputType.MouseWheel then
            u22 = math.clamp(u22 + p203.Position.Z * 0.1, 0.5, 1.8);
            u13.Scale = u22;

            return;
        end;

        if p203.KeyCode == Enum.KeyCode.Thumbstick2 then
            local v204 = math.abs(p203.Position.X) > 0.15 and (p203.Position.X or 0) or 0;
            local v205 = math.abs(p203.Position.Y) > 0.15 and p203.Position.Y or 0;
            zero = Vector2.new(v204, -v205);

            return;
        end;

        if p203.KeyCode == Enum.KeyCode.ButtonR2 then
            u27 = os.clock();
            u26 = p203.Position.Z > 0.15 and 1 or 0;

            return;
        end;

        if p203.KeyCode ~= Enum.KeyCode.ButtonL2 then
            if u19 and (not u24 and (p203 == u21 or (p203.UserInputType == Enum.UserInputType.MouseMovement or p203.UserInputType == Enum.UserInputType.Touch))) then
                local v206 = Vector2.new(p203.Position.X, p203.Position.Y);
                local v207 = v206 - (u20 or v206);
                u20 = v206;

                if LocalPlayer:GetAttribute("Device") == "Mobile" then
                    v207 = v207 * 1.35;
                end;

                local v208 = u11;
                v208.Position = v208.Position + UDim2.fromOffset(v207.X, v207.Y);
            end;

            return;
        end;

        u27 = os.clock();
        u26 = p203.Position.Z > 0.15 and -1 or 0;
    end));
    table.insert(u28, UserInputService.TouchPinch:Connect(function(p209, p210, p211, p212) -- Line: 812
        -- upvalues: u24 (ref), u23 (ref), u22 (ref), u13 (ref), u20 (ref)
        if p212 == Enum.UserInputState.Begin then
            u24 = true;
            u23 = u22;

            return;
        end;

        if p212 ~= Enum.UserInputState.Change then
            if p212 == Enum.UserInputState.End then
                u24 = false;
                u20 = nil;
            end;

            return;
        end;

        u22 = math.clamp(u23 * p210, 0.5, 1.8);
        u13.Scale = u22;
    end));
    table.insert(u28, RunService.RenderStepped:Connect(function(p213) -- Line: 824
        -- upvalues: u26 (ref), u22 (ref), u13 (ref), zero (ref), u11 (ref)
        if u26 ~= 0 then
            u22 = math.clamp(u22 + u26 * 1.25 * p213, 0.5, 1.8);
            u13.Scale = u22;
        end;

        if zero.Magnitude > 0 then
            local v214 = u11;
            v214.Position = v214.Position + UDim2.fromOffset(zero.X * 650 * p213, zero.Y * 650 * p213);
        end;
    end));
    local v215 = LocalPlayer:GetAttributeChangedSignal("BoughtGarden");
    table.insert(u28, v215:Connect(function() -- Line: 836
        -- upvalues: u16 (ref), LocalPlayer (ref), u29 (ref), u8 (ref)
        u16.Visible = not LocalPlayer:GetAttribute("InTutorial") or LocalPlayer:GetAttribute("BoughtGarden");
        local v216 = u29.Garden and u29.Garden:FindFirstChild("TutorialPointer") or (u8:FindFirstChild("TutorialPointer") or script:FindFirstChild("TutorialPointer"));

        if v216 and LocalPlayer:GetAttribute("BoughtGarden") then
            v216.Visible = false;
            v216.Parent = u8;
        end;
    end));
end;

local function close() -- Line: 847
    -- upvalues: u28 (copy), u19 (ref), u20 (ref), u21 (ref), u24 (ref), u26 (ref), zero (ref), GamepadService (copy), u4 (copy), LocalPlayer (copy)
    for _, v in next, u28 do
        v:Disconnect();
    end;

    table.clear(u28);
    u19 = false;
    u20 = nil;
    u21 = nil;
    u24 = false;
    u26 = 0;
    zero = Vector2.zero;

    if GamepadService.GamepadCursorEnabled then
        GamepadService:DisableGamepadCursor();
    end;

    u4.Fire("ToggleToolbar", true);
    u4.Fire("ToggleDisplay", true);

    if LocalPlayer:GetAttribute("BoughtGarden") then
        LocalPlayer:SetAttribute("ClosedUpgrades", true);
    end;
end;

function v7.Start(p217, p218) -- Line: 868
    -- upvalues: u8 (ref), u1 (copy), u9 (ref), u10 (ref), u12 (ref), u25 (ref), u16 (ref), u11 (ref), u13 (ref), u14 (ref), u15 (ref), LocalPlayer (copy), u17 (ref), u18 (ref), u22 (ref), u23 (ref), preloadIcons (copy), u34 (ref), Replication (copy), u39 (ref), updateNodes (ref), GamepadService (copy), updateUpgradeNotification (ref), open (copy), close (copy), u4 (copy), u29 (copy)
    u8 = u1(p218.Parent, "UpgradeTree");
    u9 = u1(u8, "Back");
    u10 = u1(u8, "ScaleMenu");
    u12 = u1(u10, "UIScale");
    u25 = u12.Scale;
    u16 = u1(u8, "Close");
    u11 = u1(u10, "Contents");
    u13 = u1(u11, "UIScale");
    u14 = u1(u11, "Node");
    u15 = u1(u11, "Rebirth_Node");
    u12.Scale = u25 * (LocalPlayer:GetAttribute("Device") == "Mobile" and 1.35 or 1);
    u17 = u1(u1(u1(p218, "Right"), "Frame"), "Upgrade");
    u18 = u1(u1(u17, "Frame"), "Noti");
    u22 = u13.Scale;
    u23 = u22;
    preloadIcons();
    u34("Main");
    Replication:Connect("upgrade_tree", function(p219) -- Line: 893
        -- upvalues: u39 (ref), updateNodes (ref)
        u39 = p219 or {};
        updateNodes(true);
    end);
    Replication:Connect("stats", function() -- Line: 899
        -- upvalues: updateNodes (ref)
        updateNodes(true);
    end);

    local function updateRebirthNodes() -- Line: 904
        -- upvalues: updateNodes (ref)
        updateNodes(true);
    end;

    LocalPlayer:GetAttributeChangedSignal("rebirth"):Connect(updateRebirthNodes);
    LocalPlayer:GetAttributeChangedSignal("rebirths"):Connect(updateRebirthNodes);
    updateNodes(true);
    LocalPlayer:GetAttributeChangedSignal("Device"):Connect(function() -- Line: 913
        -- upvalues: u12 (ref), u25 (ref), LocalPlayer (ref), u8 (ref), GamepadService (ref)
        u12.Scale = u25 * (LocalPlayer:GetAttribute("Device") == "Mobile" and 1.35 or 1);

        if u8.Enabled and (LocalPlayer:GetAttribute("Device") == "Controller" and not GamepadService.GamepadCursorEnabled) then
            GamepadService:EnableGamepadCursor(nil);
        end;
    end);
    updateUpgradeNotification();
    u8:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 922
        -- upvalues: u8 (ref), open (ref), close (ref)
        if u8.Enabled then
            open();

            return;
        end;

        close();
    end);

    if u8.Enabled then
        open();
    end;

    u1(u16, "Button").MouseButton1Click:Connect(function() -- Line: 936
        -- upvalues: u8 (ref)
        u8.Enabled = false;
    end);
    u4.new("Open Upgrade Tree"):Connect(function() -- Line: 940
        -- upvalues: u8 (ref), u4 (ref)
        if u8.Enabled then
            return;
        end;

        u8.Enabled = true;
        u4.Fire("ToggleToolbar", false);
        u4.Fire("ToggleDisplay", false);
    end);
    u4.new("GardenUpgradeOutline"):Connect(function(p220) -- Line: 947
        -- upvalues: u8 (ref), LocalPlayer (ref), u29 (ref)
        local v221 = script:FindFirstChild("TutorialPointer") or u8:FindFirstChild("TutorialPointer");

        if not v221 then
            return;
        end;

        local v222;

        if p220 == true then
            v222 = not LocalPlayer:GetAttribute("BoughtGarden");
        else
            v222 = false;
        end;

        v221.Visible = v222;
        v221.Parent = v222 and u29.Garden or u8;
    end);
    u4.new("PodiumRollsOutline"):Connect(function(p223) -- Line: 956
        -- upvalues: u8 (ref), u11 (ref)
        local v224 = script:FindFirstChild("TutorialPointer") or (u8:FindFirstChild("TutorialPointer") or u11:FindFirstChild("PodiumRolls1"):FindFirstChild("TutorialPointer"));
        v224.Visible = p223;
        v224.Parent = p223 and u11:FindFirstChild("PodiumRolls1") or script;
    end);
end;

return v7;