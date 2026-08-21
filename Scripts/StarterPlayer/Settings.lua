--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Settings
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Tabs.Settings
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:39 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("UserInputService");
local Replication = require(ReplicatedStorage.Replication);
local Library = require(ReplicatedStorage.Library);
Library.get("Find");
local u1 = Library.get("Network");
Library.get("SimpleTween");
Library.get("Signal");
Library.get("Numbers");
local u2 = Library.get("Settings");
local LocalPlayer = Players.LocalPlayer;
local u3 = LocalPlayer:GetMouse();
local v4 = {};
local u5 = {};
local u6 = {};
local u7 = nil;
local u8 = {};
local u9 = nil;
local u10 = nil;
local u11 = nil;

local function open() -- Line: 41
    -- upvalues: LocalPlayer (copy), Replication (copy), u11 (ref), u8 (ref)
    local v12 = LocalPlayer:GetAttribute("Device");
    local Data = Replication.Data;
    u11.Vibrations.Visible = v12 == "Mobile" and true or v12 == "Controller";
    Button(u11:FindFirstChild("Vibrations"), Data);
    Button(u11:FindFirstChild("CameraShake"), Data);
    u8 = { u11:FindFirstChild("Music"), u11:FindFirstChild("Sounds") };
    Sliders(Data);
end;

local function close() -- Line: 54
    -- upvalues: u6 (ref), u1 (copy), u5 (ref)
    if next(u6) then
        u1:FireServer("SaveSettings", u6);
        u6 = {};
    end;

    for _, v in next, u5 do
        for _, v2 in next, v do
            v2:Disconnect();
        end;
    end;

    u5 = {};
end;

function v4.Start(p13, u14) -- Line: 69
    -- upvalues: u9 (ref), u10 (ref), u11 (ref), Replication (copy), u2 (copy), open (copy), close (copy)
    u9 = u14.Menu;
    u10 = u9.Frame;
    u11 = u10.List;
    u2:Start(Replication.Data.settings);
    u14:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 78
        -- upvalues: u14 (copy), open (ref), close (ref)
        if u14.Enabled then
            open();

            return;
        end;

        close();
    end);
end;

function updateForButton(p15, p16)
    if p16 then
        p15.BackgroundColor3 = Color3.fromRGB(47, 216, 0);
        p15.Label.Text = "On";

        return;
    end;

    p15.BackgroundColor3 = Color3.fromRGB(200, 0, 3);
    p15.Label.Text = "Off";
end;

function Button(p17, p18)
    -- upvalues: u5 (ref), u2 (copy), u6 (ref)
    local Toggle = p17.Toggle;
    local Button2 = Toggle.Button;
    local Name = p17.Name;
    local Frame = Toggle.Frame;
    local u19 = false;
    updateForButton(Frame, p18.settings[Name]);
    u5[p17] = {};
    u5[p17].MouseButton1Click = Button2.MouseButton1Click:Connect(function() -- Line: 110
        -- upvalues: u19 (ref), u2 (ref), Name (copy), Frame (copy), u6 (ref)
        if not u19 then
            u19 = true;

            if u2.check(Name) then
                u2.change(Name, false);
                updateForButton(Frame, false);
                u6[Name] = false;
            else
                u2.change(Name, true);
                updateForButton(Frame, true);
                u6[Name] = true;
            end;

            task.wait(0.2);
            u19 = false;
        end;
    end);
end;

function Sliders(p20)
    -- upvalues: u8 (ref), u5 (ref), u7 (ref), u3 (copy)
    local settings = p20.settings;

    for _, v in next, u8 do
        local Name = v.Name;
        local Slider = v.Slider;
        local SliderButton = Slider.SliderButton;
        setSlider(Slider, settings[Name]);
        local Button2 = SliderButton.Button;
        u5[Slider] = {};
        u5[Slider].DownMouseButton1Down = Button2.MouseButton1Down:Connect(function() -- Line: 153
            -- upvalues: u7 (ref), Slider (copy), Name (copy), u5 (ref), u3 (ref)
            if u7 == nil then
                u7 = Slider;
                computeSlide(Slider, Name);

                if not u5[Slider].Button1Up then
                    u5[Slider].Button1Up = u3.Button1Up:Connect(function() -- Line: 161
                        -- upvalues: u5 (ref), Slider (ref), u7 (ref)
                        u5[Slider].Button1Up:Disconnect();
                        u5[Slider].Button1Up = nil;

                        if u5[Slider].loop then
                            u5[Slider].loop:Disconnect();
                            u5[Slider].loop = nil;
                        end;

                        u7 = nil;
                    end);
                end;
            end;
        end);
        u5[Slider].MouseButton1Click = Button2.MouseButton1Up:Connect(function() -- Line: 178
            -- upvalues: u7 (ref), Slider (copy), u5 (ref)
            _G.Play("Tap");

            if u7 then
                local v21;

                if u7 == Slider then
                    v21 = Slider;
                else
                    v21 = u7;
                end;

                if u5[v21].Button1Up then
                    u5[v21].Button1Up:Disconnect();
                    u5[v21].Button1Up = nil;
                end;

                if u5[v21].loop then
                    u5[v21].loop:Disconnect();
                    u5[v21].loop = nil;
                end;

                u7 = nil;
            end;
        end);
    end;
end;

function setSlider(p22, p23)
    -- upvalues: LocalPlayer (copy)
    local SliderButton = p22.SliderButton;
    local X = SliderButton.AbsoluteSize.X;
    local v24 = p22.End.AbsolutePosition.X - p22.Start.AbsolutePosition.X;
    local v25 = v24 * (p23 / 100);
    local v26 = v25 / v24;
    p22.Slide.Size = UDim2.fromScale(v26, 3);
    SliderButton.Position = UDim2.new(0, v25 + X / 2, 0.5, 0);
    local Value = p22.Parent:FindFirstChild("Value");

    if Value then
        local v27 = math.round(v26 * 100);
        Value.Text = v27 .. "%";

        if p22.Parent.Name == "Camera Sensitivity" then
            LocalPlayer:SetAttribute("Sensitivity", v27 / 100);
        end;
    end;
end;

function computeSlide(u28, u29)
    -- upvalues: u3 (copy), u5 (ref), RunService (copy), u2 (copy), u6 (ref), LocalPlayer (copy)
    local SliderButton = u28.SliderButton;
    local Slide = u28.Slide;
    local u30 = SliderButton.AbsoluteSize.X / 2;
    local u31 = SliderButton.AbsolutePosition.X + u30 - u3.X;
    local _ = u28.AbsoluteSize.X;
    local X = u28.Start.AbsolutePosition.X;
    local u32 = u28.End.AbsolutePosition.X - X;

    if not u5[u28].loop then
        tick();
        tick();
        local u33 = 100;
        u5[u28].loop = RunService.RenderStepped:Connect(function() -- Line: 260
            -- upvalues: SliderButton (copy), u3 (ref), u31 (copy), u30 (copy), X (copy), u32 (copy), Slide (copy), u33 (ref), u2 (ref), u29 (copy), u6 (ref), u28 (copy), LocalPlayer (ref)
            local v34 = u3.X + u31 - u30 - X;

            if v34 <= 0 then
                v34 = 0;
            elseif u32 <= v34 then
                v34 = u32;
            end;

            local v35 = v34 / u32;
            SliderButton.Position = UDim2.new(0, v34 + SliderButton.AbsoluteSize.X / 2, 0.5, 0);
            Slide.Size = UDim2.fromScale(v35, 3);
            local v36 = math.round(v35 * 100);

            if u33 ~= v36 then
                u33 = v36;
                u2[u29].func(v36);
                u6[u29] = v36;
                local Value = u28.Parent:FindFirstChild("Value");

                if Value then
                    Value.Text = v36 .. "%";

                    if u28.Parent.Name == "Camera Sensitivity" then
                        LocalPlayer:SetAttribute("Sensitivity", v36 / 100);
                    end;
                end;
            end;
        end);
    end;
end;

return v4;