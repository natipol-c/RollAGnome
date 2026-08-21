--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Gift
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Tabs.Gift
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:39 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Library = require(ReplicatedStorage.Library);
require(ReplicatedStorage.Replication);
Library.get("Find");
local u1 = Library.get("Network");
local u2 = Library.get("Products");
Library.get("SimpleTween");
local u3 = Library.get("Signal");
local LocalPlayer = Players.LocalPlayer;
local v4 = {};
local u5 = {};
local u6 = {
    name = nil,
    type = nil,
    id = nil
};
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = false;

local function open() -- Line: 41
    -- upvalues: u14 (ref), u9 (ref)
    if not u14 then
        u14 = true;
        u9.ScrollBarThickness = workspace.CurrentCamera.ViewportSize.X * (u9.ScrollBarThickness / 2200);
    end;

    Send_Buttons();
end;

local function close() -- Line: 58
    -- upvalues: u13 (ref), u5 (ref), u3 (copy)
    if u13 then
        u13();
    end;

    for _, v in next, u5 do
        for _, v2 in next, v do
            v2:Disconnect();
        end;
    end;

    u5 = {};
    u3.Fire("OpenTab", "Shop");
end;

function v4.Start(p15, p16) -- Line: 73
    -- upvalues: u7 (ref), u8 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref), Players (copy), u3 (copy), u6 (ref), u13 (ref), u14 (ref), close (copy)
    u7 = p16;
    u8 = u7.Menu;
    u9 = u8.Frame.List;
    u10 = u8.Title;
    u11 = u10.GiftingName;
    u12 = u9.Template:Clone();
    u9.Template:Destroy();
    local v17 = next;
    local v18, v19 = Players:GetPlayers();

    for _, v in v17, v18, v19 do
        create(v);
    end;

    Players.PlayerAdded:Connect(function(p20) -- Line: 91
        create(p20);
    end);
    Players.PlayerRemoving:Connect(function(p21) -- Line: 94
        -- upvalues: u9 (ref)
        if u9:FindFirstChild(p21.Name) then
            u9[p21.Name]:Destroy();
        end;
    end);
    u3.new("WantsToGift"):Connect(function(p22, p23) -- Line: 100
        -- upvalues: u6 (ref), u11 (ref), u3 (ref), u13 (ref)
        if not p22 then
            return;
        end;

        u6 = p22;
        u11.Text = p22.name;
        u3.Fire("OpenTab", "Gift", {});
        u13 = p23;
    end);
    u7:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 114
        -- upvalues: u7 (ref), u14 (ref), u9 (ref), close (ref)
        if not u7.Enabled then
            close();

            return;
        end;

        if not u14 then
            u14 = true;
            u9.ScrollBarThickness = workspace.CurrentCamera.ViewportSize.X * (u9.ScrollBarThickness / 2200);
        end;

        Send_Buttons();
    end);
end;

function Send_Buttons()
    -- upvalues: u9 (ref), u5 (ref), u6 (ref), u1 (copy), u2 (copy)
    local v24 = next;
    local v25, v26 = u9:GetChildren();

    for _, v in v24, v25, v26 do
        if v:IsA("Frame") and v.Name ~= "Spacer" then
            local Gift = v.Gift;
            local _ = Gift.Frame;
            local Button = Gift.Button;
            local u27 = false;
            u5[v] = {};
            Button.MouseButton1Click:Connect(function() -- Line: 133
                -- upvalues: u6 (ref), u27 (ref), u1 (ref), v (copy), u2 (ref)
                if not u6.name and u6.type then
                    return;
                end;

                if not u27 then
                    u27 = true;

                    if u6.type == "gamepass" then
                        local v28 = u1:InvokeServer("CheckIfOwned", v.Name, u6.name);
                        task.wait();

                        if v28 then
                            u2.prompt(u2.products.gifting[u6.name].id, "product");
                        end;
                    elseif u6.type == "product" then
                        local v29 = u1:InvokeServer("GiftPlayer", v.Name);
                        task.wait();

                        if v29 then
                            u2.prompt(u6.id, "product");
                        end;
                    end;

                    task.wait(0.2);
                    u27 = false;
                end;
            end);
        end;
    end;
end;

function create(p30)
    -- upvalues: LocalPlayer (copy), u9 (ref), u12 (ref)
    if p30 == LocalPlayer then
        return;
    end;

    if u9:FindFirstChild(p30.Name) then
        return;
    end;

    task.wait(5);
    local _ = p30.UserId;
    local u31 = u12:Clone();
    u31.Icon.Image = p30:GetAttribute("Headshot");
    u31.Name = p30.Name;
    u31.PlayerName.Text = p30.Name;
    u31.PlayerDisplayName.Text = "@" .. p30.DisplayName;
    u31.Parent = u9;

    if _G.AddToStroke == nil then
        task.spawn(function() -- Line: 179
            -- upvalues: u31 (copy)
            repeat
                task.wait(0.1);
            until _G.AddToStroke ~= nil;

            local v32 = next;
            local v33, v34 = u31:GetDescendants();

            for _, v in v32, v33, v34 do
                if v:IsA("UIStroke") then
                    _G.AddToStroke(v);
                end;
            end;
        end);

        return;
    end;

    local v35 = next;
    local v36, v37 = u31:GetDescendants();

    for _, v in v35, v36, v37 do
        if v:IsA("UIStroke") then
            _G.AddToStroke(v);
        end;
    end;
end;

return v4;