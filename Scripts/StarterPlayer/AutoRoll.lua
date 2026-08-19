--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AutoRoll
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Tabs.AutoRoll
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:28 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Replication = require(ReplicatedStorage.Replication);
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
local u2 = Library.get("Network");
local u3 = Library.get("Signal");
local LocalPlayer = Players.LocalPlayer;
local v4 = {};
local u5 = {};
local u6 = {};
local u7 = false;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;

local function stopAutoRoll() -- Line: 32
    -- upvalues: u7 (ref)
    u7 = false;
end;

local function hasSelected() -- Line: 36
    -- upvalues: u6 (ref)
    for _, v in u6 do
        if v then
            return true;
        end;
    end;
end;

local function startAutoRoll() -- Line: 44
    -- upvalues: u7 (ref), LocalPlayer (copy), u2 (copy)
    if u7 then
        return;
    end;

    u7 = true;
    task.spawn(function() -- Line: 48
        -- upvalues: u7 (ref), LocalPlayer (ref), u2 (ref)
        while u7 do
            while u7 and LocalPlayer:GetAttribute("Rolling") do
                task.wait(0.1);
            end;

            if not u7 then
                break;
            end;

            local v13 = u2:InvokeServer("AutoRoll");

            if v13 == nil or v13 == true then
                break;
            end;

            task.wait(0.2);
        end;

        u7 = false;
        u2:FireServer("SetAutoRolling", false);
    end);
end;

local function updateButton(p14) -- Line: 70
    -- upvalues: u6 (ref)
    local v15 = u6[p14.Name] and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0);
    local UIStroke = p14:FindFirstChild("UIStroke");

    if UIStroke then
        UIStroke.Color = v15;
    end;

    local Frame = p14:FindFirstChild("Frame");

    if Frame then
        Frame.BackgroundColor3 = v15;
    end;

    if Frame then
        Frame = Frame:FindFirstChild("UIStroke");
    end;

    if Frame then
        Frame.Color = v15;
    end;
end;

local function open() -- Line: 91
    -- upvalues: u6 (ref), Replication (copy), u11 (ref), updateButton (copy), u5 (ref), u2 (copy), u12 (ref), u7 (ref), u3 (copy), LocalPlayer (copy)
    u6 = table.clone(Replication.Data.autos and Replication.Data.autos.roll or {});

    for _, child in u11:GetChildren() do
        if child:IsA("Frame") then
            updateButton(child);
            local Button = child:FindFirstChild("Button");

            if Button then
                table.insert(u5, Button.MouseButton1Click:Connect(function() -- Line: 100
                    -- upvalues: u6 (ref), child (copy), updateButton (ref), u2 (ref)
                    if u6[child.Name] then
                        u6[child.Name] = nil;
                    else
                        u6[child.Name] = true;
                    end;

                    updateButton(child);
                    u2:FireServer("SaveAutoRoll", u6);
                end));
            end;
        end;
    end;

    table.insert(u5, u12.Button.MouseButton1Click:Connect(function() -- Line: 114
        -- upvalues: u7 (ref), u2 (ref), u6 (ref), u3 (ref), LocalPlayer (ref)
        if u7 then
            u7 = false;
            u2:FireServer("SetAutoRolling", false);

            return;
        end;

        local v16 = nil;

        for _, v in u6 do
            if v then
                v16 = true;
                break;
            end;
        end;

        if not v16 then
            u3.Fire(
                "Notification",
                {
                    message = "Select at least one rarity.",
                    sound = "Negative",
                    preset = "Red",
                    wait = 3
                }
            );

            return;
        end;

        u2:FireServer("SetAutoRolling", true);
        u3.Fire("CloseTab", "AutoRoll");

        if u7 then
            return;
        end;

        u7 = true;
        task.spawn(function() -- Line: 48
            -- upvalues: u7 (ref), LocalPlayer (ref), u2 (ref)
            while u7 do
                while u7 and LocalPlayer:GetAttribute("Rolling") do
                    task.wait(0.1);
                end;

                if not u7 then
                    break;
                end;

                local v17 = u2:InvokeServer("AutoRoll");

                if v17 == nil or v17 == true then
                    break;
                end;

                task.wait(0.2);
            end;

            u7 = false;
            u2:FireServer("SetAutoRolling", false);
        end);
    end));
end;

local function close() -- Line: 136
    -- upvalues: u5 (ref)
    for _, v in next, u5 do
        v:Disconnect();
    end;

    u5 = {};
end;

function v4.Start(p18, p19) -- Line: 143
    -- upvalues: u8 (ref), u9 (ref), u1 (copy), u10 (ref), u11 (ref), u12 (ref), u5 (ref), open (copy), u3 (copy), stopAutoRoll (copy), LocalPlayer (copy), u7 (ref), u2 (copy)
    u8 = p19;
    u9 = u1(u8, "Menu");
    u10 = u1(u9, "Frame");
    u11 = u1(u10, "List");
    u12 = u1(u9, "StartRolling");
    u8:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 150
        -- upvalues: u8 (ref), u5 (ref), open (ref)
        if u8.Enabled then
            open();

            return;
        end;

        for _, v in next, u5 do
            v:Disconnect();
        end;

        u5 = {};
    end);
    u3.new("StopAutoRoll"):Connect(stopAutoRoll);
    LocalPlayer:GetAttributeChangedSignal("AutoRolling"):Connect(function() -- Line: 159
        -- upvalues: LocalPlayer (ref), u7 (ref), u2 (ref)
        if LocalPlayer:GetAttribute("AutoRolling") ~= true then
            u7 = false;

            return;
        end;

        if u7 then
            return;
        end;

        u7 = true;
        task.spawn(function() -- Line: 48
            -- upvalues: u7 (ref), LocalPlayer (ref), u2 (ref)
            while u7 do
                while u7 and LocalPlayer:GetAttribute("Rolling") do
                    task.wait(0.1);
                end;

                if not u7 then
                    break;
                end;

                local v20 = u2:InvokeServer("AutoRoll");

                if v20 == nil or v20 == true then
                    break;
                end;

                task.wait(0.2);
            end;

            u7 = false;
            u2:FireServer("SetAutoRolling", false);
        end);
    end);

    if LocalPlayer:GetAttribute("AutoRolling") == true then
        if u7 then
            return;
        end;

        u7 = true;
        task.spawn(function() -- Line: 48
            -- upvalues: u7 (ref), LocalPlayer (ref), u2 (ref)
            while u7 do
                while u7 and LocalPlayer:GetAttribute("Rolling") do
                    task.wait(0.1);
                end;

                if not u7 then
                    break;
                end;

                local v21 = u2:InvokeServer("AutoRoll");

                if v21 == nil or v21 == true then
                    break;
                end;

                task.wait(0.2);
            end;

            u7 = false;
            u2:FireServer("SetAutoRolling", false);
        end);
    end;
end;

return v4;