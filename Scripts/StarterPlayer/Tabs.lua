--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Tabs
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Tabs
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:28 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local GamepadService = game:GetService("GamepadService");
local UserInputService = game:GetService("UserInputService");
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Controller");
local u2 = Library.get("Find");
local u3 = Library.get("SimpleTween");
local u4 = Library.get("Signal");
local u5 = Library.get("Network");
local Frames = game.Lighting.Frames;
local _ = workspace.CurrentCamera;
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
PlayerGui:WaitForChild("Display");
local Tabs = PlayerGui:WaitForChild("Tabs");
local u6 = nil;
local v7 = {};
local u8 = {};
local u9 = {};
local u10 = {};
local u11 = {};
local u12 = {};

function CloseTab(p13, p14)
    -- upvalues: u12 (copy), u2 (copy), Tabs (copy), u10 (copy), u11 (copy), u6 (ref), GamepadService (copy), u4 (copy), Frames (copy), u3 (copy), ReplicatedStorage (copy), u9 (copy), u5 (copy)
    local v15 = p14 or {};

    if u12[p13] then
        for i, v in next, u12[p13].Close do
            v15[i] = v;
        end;
    end;

    if type(p13) == "string" then
        p13 = u2(Tabs, p13);
    end;

    if not p13 then
        return;
    end;

    local Name = p13.Name;
    local v16;

    if u10[Name] == nil then
        v16 = false;
    else
        local v17 = u10[Name];
        u10[Name] = nil;
        OpenTab(v17);
        v16 = true;
    end;

    if u11[Name] then
        local v18 = u11[Name];
        u11[Name] = nil;
        OpenTab(v18);
        v16 = true;
    end;

    local v19 = v15.ForceClose and true or v16;

    if not v19 then
        if u6 == "Controller" then
            GamepadService:DisableGamepadCursor();
        elseif u6 == "Mobile" then
            u4.Fire("ToggleToolbar", true);
        end;
    end;

    if p13 then
        local v20 = u2(p13, "Menu");

        if not v19 and v15.Fullscreen then
            u4.Fire("Display", "Fullscreen", true);
        end;

        if not (v19 or v15.KeepEffects) then
            v20.Visible = false;

            if Frames.Enabled then
                u3:Tween(Frames, 0.1, "Sine", "In", {
                    Size = 0
                }, nil, function() -- Line: 108
                    -- upvalues: Frames (ref)
                    Frames.Enabled = false;
                end);
            end;

            ReplicatedStorage:SetAttribute("FrameOpen", false);
        end;

        p13.Enabled = false;

        if u9[Name] and v15.IgnoreCallback == nil then
            if type(u9[Name]) == "string" then
                u5:FireServer(u9[Name]);
            else
                u9[Name]();
            end;

            u9[Name] = nil;
        end;
    end;
end;

function OpenTab(p21, p22)
    -- upvalues: u12 (copy), u2 (copy), Tabs (copy), u9 (copy), u4 (copy), u6 (ref), GamepadService (copy), Frames (copy), u3 (copy), ReplicatedStorage (copy), u11 (copy), u10 (copy)
    local v23 = p22 or {};

    if u12[p21] then
        for i, v in next, u12[p21].Open do
            v23[i] = v;
        end;
    end;

    if type(p21) == "string" then
        p21 = u2(Tabs, p21);
    end;

    local Name = p21.Name;

    if not u9[Name] then
        u9[Name] = v23.Callback;
    end;

    if v23.SoundOnOpen then
        _G.Play(v23.SoundOnOpen);
    end;

    local v24 = next;
    local v25, v26 = Tabs:GetChildren();
    local v27 = false;

    for _, v in v24, v25, v26 do
        if v.Enabled and v ~= p21 then
            CloseTab(v.Name, {
                KeepEffects = true,
                ForceClose = true,
                IgnoreCallback = v23.IgnoreCallback
            });
            v27 = v.Name;
        end;
    end;

    if not p21 then
        return;
    end;

    local v28 = u2(p21, "Menu");
    v28.Visible = true;

    if v23.Fullscreen then
        u4.Fire("Display", "Fullscreen", false);
    end;

    if u6 == "Controller" then
        if not GamepadService.GamepadCursorEnabled then
            GamepadService:EnableGamepadCursor(nil);
        end;
    elseif u6 == "Mobile" then
        u4.Fire("ToggleToolbar", false);
    end;

    if not Frames.Enabled then
        Frames.Size = 0;
        Frames.Enabled = true;
        u3:Tween(Frames, 0.2, "Sine", "Out", {
            Size = 15
        });
    end;

    v28.Position = p21:GetAttribute("Position") + UDim2.fromScale(0, 0.07);
    task.wait();
    p21.Enabled = true;
    u3:Tween(v28, 0.2, "Sine", "Out", {
        Position = p21:GetAttribute("Position")
    });
    ReplicatedStorage:SetAttribute("FrameOpen", true);

    if v23.OpenFrameOnClose ~= nil then
        u11[Name] = v23.OpenFrameOnClose;
    end;

    if v23.OpenWhenClose ~= nil and v27 then
        u10[Name] = v27;
    end;
end;

local function ToggleTab(p29, ...) -- Line: 224
    -- upvalues: Tabs (copy)
    if _G.CancelFrames then
        return;
    end;

    local v30 = Tabs:FindFirstChild(p29);

    if not v30 then
        return;
    end;

    if v30.Enabled then
        CloseTab(p29);

        return;
    end;

    OpenTab(p29, ...);
end;

local function CloseAll() -- Line: 241
    -- upvalues: Tabs (copy)
    local v31 = next;
    local v32, v33 = Tabs:GetChildren();

    for _, v in v31, v32, v33 do
        if v.Enabled then
            CloseTab(v.Name);

            return v.Name;
        end;
    end;
end;

function v7.Start(p34) -- Line: 250
    -- upvalues: Tabs (copy), UserInputService (copy), CloseAll (copy), u4 (copy), ToggleTab (copy), u5 (copy), u1 (copy), u6 (ref), ReplicatedStorage (copy), GamepadService (copy), u8 (copy)
    local v35 = next;
    local v36, v37 = Tabs:GetChildren();

    for _, v in v35, v36, v37 do
        v.Enabled = false;
        v:SetAttribute("Position", v.Menu.Position);

        if UserInputService.TouchEnabled then
            if v.Menu:GetAttribute("MobileSize") then
                v.Menu.Size = v.Menu:GetAttribute("MobileSize");
            end;

            if v.Menu:GetAttribute("MobilePos") then
                v.Menu.Position = v.Menu:GetAttribute("MobilePos");
                v:SetAttribute("Position", v.Menu.Position);
            end;
        end;

        local Close = v:FindFirstChild("Close");

        if Close then
            Close.Value.Button.MouseButton1Click:Connect(function() -- Line: 271
                -- upvalues: CloseAll (ref)
                _G.Play("Tap");
                CloseAll();
            end);
        end;

        local u38 = script:FindFirstChild(v.Name);

        if u38 then
            task.spawn(function() -- Line: 282
                -- upvalues: u38 (ref), Tabs (ref)
                local v39 = Tabs:FindFirstChild(u38.Name);

                if v39 then
                    u38 = require(u38);
                    u38:Start(v39);
                end;
            end);
        end;
    end;

    u4.new("OpenTab"):Connect(function(...) -- Line: 295
        OpenTab(...);
    end);
    u4.new("CloseTab"):Connect(function(...) -- Line: 299
        CloseTab(...);
    end);
    u4.new("ToggleTab"):Connect(function(...) -- Line: 303
        -- upvalues: ToggleTab (ref)
        ToggleTab(...);
    end);
    u4.new("CloseAllTabs"):Connect(function(...) -- Line: 306
        -- upvalues: CloseAll (ref)
        CloseAll(...);
    end);
    u5:BindEvents({
        OpenTab = function(...) -- Line: 312, Name: OpenTab
            OpenTab(...);
        end
    });
    u1:Connect(function(p40) -- Line: 319
        -- upvalues: u6 (ref), ReplicatedStorage (ref), GamepadService (ref), Tabs (ref), UserInputService (ref), u8 (ref), CloseAll (ref)
        u6 = p40;

        if p40 == "Controller" and (ReplicatedStorage:GetAttribute("FrameOpen") and not GamepadService.GamepadCursorEnabled) then
            GamepadService:EnableGamepadCursor(nil);
        end;

        local v41 = next;
        local v42, v43 = Tabs:GetChildren();

        for _, v in v41, v42, v43 do
            local Close = v:FindFirstChild("Close");

            if Close then
                local Label = Close.Value.Label;

                if p40 == "Controller" then
                    local v44 = UserInputService:GetImageForKeyCode(Enum.KeyCode.DPadUp);

                    if string.find(v44, "XboxController") then
                        Label.Text = "B";
                    else
                        Label.Text = "O";
                    end;
                else
                    Label.Text = "X";
                end;
            end;
        end;

        if u8.Controller then
            u8.Controller.Ended:Disconnect();
        end;

        if p40 == "Controller" then
            u8.Controller = {};
            u8.Controller.Ended = UserInputService.InputEnded:Connect(function(p45, p46) -- Line: 357
                -- upvalues: ReplicatedStorage (ref), CloseAll (ref)
                if _G.DisableControllerClose then
                    return;
                end;

                if p46 then
                    return;
                end;

                if not ReplicatedStorage:GetAttribute("FrameOpen") then
                    return;
                end;

                if p45.KeyCode == Enum.KeyCode.ButtonB then
                    _G.Play("Tap");
                    CloseAll();
                end;
            end);
        end;
    end);
end;

return v7;