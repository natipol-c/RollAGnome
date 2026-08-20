--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Shop
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Tabs.Shop
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:08 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("MarketplaceService");
require(ReplicatedStorage.Replication);
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
Library.get("Network");
local u2 = Library.get("Numbers");
local u3 = Library.get("Products");
local u4 = Library.get("Signal");
Library.get("Rarities");
local LocalPlayer = Players.LocalPlayer;
local v5 = {};
local u6 = {};
local u7 = {};
local u8 = {};
local u9 = {};
local u10 = {};
local u11 = {};
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = false;

local function open() -- Line: 44
    -- upvalues: u16 (ref), u15 (ref), u3 (copy), ReplicatedStorage (copy), u1 (copy), u9 (ref), u8 (ref), u2 (copy), u10 (ref), LocalPlayer (copy), u11 (ref), u4 (copy), u7 (ref)
    if not u16 then
        u16 = true;
        u15.ScrollBarThickness = workspace.CurrentCamera.ViewportSize.X * (u15.ScrollBarThickness / 1793);
    end;

    local serverLuck = u3.products.serverLuck;

    local function update(p17) -- Line: 61
        -- upvalues: ReplicatedStorage (ref), u1 (ref), serverLuck (copy)
        local v18 = tonumber(ReplicatedStorage:GetAttribute("LuckLevel"));
        local v19 = tostring(v18 >= 4 and 4 or v18);
        local v20 = u1(p17, "List");
        local v21 = u1(v20, "After");
        local v22 = u1(v20, "Before");
        local v23 = u1(p17, "Purchase");
        local v24 = u1(u1(v23, "Frame"), "Price");
        local v25 = u1(v24, "PriceLabel");
        u1(v24, "Label");
        local v26 = serverLuck[v19];

        if not v26 then
            return;
        end;

        v23.Visible = true;
        v25.Text = v26.price;
        v22.Text = v26.before;
        v21.Text = v26.text;
    end;

    for _, v in next, u9 do
        if v:IsDescendantOf(u15) then
            local v27 = u1(v, "Purchase");
            u1(v27, "Frame");
            local v28 = u1(v27, "Button");
            local u29 = u1(v, "TimeRemaining");
            local u30 = false;
            update(v);
            u8[u29] = {};
            u8[u29].update = ReplicatedStorage:GetAttributeChangedSignal("LuckTime"):Connect(function() -- Line: 104
                -- upvalues: ReplicatedStorage (ref), u29 (copy), u2 (ref)
                local v31 = ReplicatedStorage:GetAttribute("LuckTime");

                if v31 == nil or v31 == 0 then
                    u29.Visible = false;

                    return;
                end;

                u29.Visible = true;
                u29.Text = "(" .. u2.ToMS(v31) .. ")";
            end);
            u8[u29].changed = ReplicatedStorage:GetAttributeChangedSignal("LuckLevel"):Connect(function() -- Line: 114
                -- upvalues: update (copy), v (copy)
                update(v);
            end);
            u8[v] = {};
            v28.ZIndex = 9999;
            u8[v].MouseButton1Click = v28.MouseButton1Click:Connect(function() -- Line: 122
                -- upvalues: u30 (ref), ReplicatedStorage (ref), u3 (ref), serverLuck (copy)
                if not u30 then
                    u30 = true;
                    local v32 = tonumber(ReplicatedStorage:GetAttribute("LuckLevel"));
                    local v33 = tostring(v32 >= 4 and 4 or v32);
                    u3.prompt(serverLuck[v33].id, "product");
                    task.wait(0.2);
                    u30 = false;
                end;
            end);
        end;
    end;

    local gamepasses = u3.gamepasses;

    for _, v in next, u10 do
        if v:IsDescendantOf(LocalPlayer) then
            local Name = v.Name;

            if gamepasses[Name] then
                local v34 = u1(v, "Buttons");
                local v35 = u1(v34, "Buy");
                local v36 = u1(v34, "Owned");
                local v37 = u3.check(Name);
                v35.Visible = not v37;
                v36.Visible = v37;
                local v38 = next;
                local v39, v40 = v34:GetChildren();

                for _, v2 in v38, v39, v40 do
                    if v2:IsA("Frame") then
                        local v41 = u1(v2, "Frame");
                        local v42 = u1(v2, "Button");
                        local u43 = false;

                        if v2.Name == "Buy" then
                            local v44 = u1(u1(v41, "Price"), "PriceLabel");
                            local v45 = gamepasses[Name];

                            if v45 then
                                if v45.price then
                                    if v45.price == "ERR" then
                                        v44.Text = "NFS";
                                    else
                                        v44.Text = u2.Comma(v45.price);
                                    end;

                                    u8[v2] = {};
                                    v42.ZIndex = 9999;
                                    v42.Modal = true;
                                    table.insert(u11, v42);
                                    u8[v2].MouseButton1Click = v42.MouseButton1Click:Connect(function() -- Line: 188
                                        -- upvalues: u43 (ref), v2 (copy), u3 (ref), Name (copy), u4 (ref)
                                        if not u43 then
                                            u43 = true;

                                            if v2.Name == "Buy" then
                                                u3.prompt(Name, "gamepass");
                                            elseif v2.Name == "Gift" then
                                                u4.Fire("WantsToGift", {
                                                    type = "gamepass",
                                                    name = Name
                                                });
                                            end;

                                            task.wait(0.2);
                                            u43 = false;
                                        end;
                                    end);
                                end;
                            end;
                        else
                            u8[v2] = {};
                            v42.ZIndex = 9999;
                            v42.Modal = true;
                            table.insert(u11, v42);
                            u8[v2].MouseButton1Click = v42.MouseButton1Click:Connect(function() -- Line: 188
                                -- upvalues: u43 (ref), v2 (copy), u3 (ref), Name (copy), u4 (ref)
                                if not u43 then
                                    u43 = true;

                                    if v2.Name == "Buy" then
                                        u3.prompt(Name, "gamepass");
                                    elseif v2.Name == "Gift" then
                                        u4.Fire("WantsToGift", {
                                            type = "gamepass",
                                            name = Name
                                        });
                                    end;

                                    task.wait(0.2);
                                    u43 = false;
                                end;
                            end);
                        end;
                    end;
                end;
            end;
        end;
    end;

    local boosts = u3.products.boosts;

    for _, v in next, u7 do
        if v:IsDescendantOf(u15) then
            local Name = v.Name;

            if boosts[Name] then
                local v46 = u1(v, "Buttons");
                local v47 = next;
                local v48, v49 = v46:GetChildren();

                for _, v2 in v47, v48, v49 do
                    if v2:IsA("Frame") then
                        local v50 = u1(v2, "Frame");
                        local v51 = u1(v2, "Button");
                        local u52 = false;

                        if v2.Name == "Buy" then
                            local v53 = u1(u1(v50, "Price"), "PriceLabel");
                            local v54 = boosts[Name];

                            if v54 then
                                if v54.price then
                                    v53.Text = u2.Comma(v54.price);
                                    u8[v2] = {};
                                    v51.ZIndex = 9999;
                                    u8[v2].MouseButton1Click = v51.MouseButton1Click:Connect(function() -- Line: 240
                                        -- upvalues: u52 (ref), v2 (copy), u3 (ref), boosts (copy), Name (copy), u4 (ref)
                                        if not u52 then
                                            u52 = true;

                                            if v2.Name == "Buy" then
                                                u3.prompt(boosts[Name].id, "product");
                                            elseif v2.Name == "Gift" then
                                                u4.Fire("WantsToGift", {
                                                    type = "product",
                                                    name = boosts[Name].name,
                                                    id = boosts[Name].id
                                                }, function() -- Line: 247
                                                    -- upvalues: u4 (ref)
                                                    u4.Fire("OpenTab", "Shop");
                                                end);
                                            end;

                                            task.wait(0.2);
                                            u52 = false;
                                        end;
                                    end);
                                end;
                            end;
                        else
                            u8[v2] = {};
                            v51.ZIndex = 9999;
                            u8[v2].MouseButton1Click = v51.MouseButton1Click:Connect(function() -- Line: 240
                                -- upvalues: u52 (ref), v2 (copy), u3 (ref), boosts (copy), Name (copy), u4 (ref)
                                if not u52 then
                                    u52 = true;

                                    if v2.Name == "Buy" then
                                        u3.prompt(boosts[Name].id, "product");
                                    elseif v2.Name == "Gift" then
                                        u4.Fire("WantsToGift", {
                                            type = "product",
                                            name = boosts[Name].name,
                                            id = boosts[Name].id
                                        }, function() -- Line: 247
                                            -- upvalues: u4 (ref)
                                            u4.Fire("OpenTab", "Shop");
                                        end);
                                    end;

                                    task.wait(0.2);
                                    u52 = false;
                                end;
                            end);
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

local function close() -- Line: 261
    -- upvalues: u8 (ref), u11 (ref)
    for _, v in next, u8 do
        for i, v2 in next, v do
            if i == "poll" and typeof(v2) == "thread" then
                task.cancel(v2);
            elseif typeof(v2) == "RBXScriptConnection" then
                v2:Disconnect();
            end;
        end;
    end;

    for _, v in u11 do
        v.Modal = false;
    end;

    u11 = {};
    u8 = {};
end;

function v5.Start(p55, p56) -- Line: 280
    -- upvalues: u12 (ref), u13 (ref), u1 (copy), u14 (ref), u15 (ref), u6 (ref), CollectionService (copy), u7 (ref), u9 (ref), u10 (ref), close (copy), open (copy)
    u12 = p56;
    u13 = u1(u12, "Menu");
    u14 = u1(u13, "Frame");
    u15 = u1(u14, "List");
    u6 = CollectionService:GetTagged("Bundles_Shop");
    u7 = CollectionService:GetTagged("Boosts_Shop");
    u9 = CollectionService:GetTagged("ServerLuck_Shop");
    u10 = CollectionService:GetTagged("Gamepass_Shop");
    u12:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 291
        -- upvalues: u12 (ref), close (ref), open (ref)
        if u12.Enabled then
            open();

            return;
        end;

        close();
    end);
end;

return v5;