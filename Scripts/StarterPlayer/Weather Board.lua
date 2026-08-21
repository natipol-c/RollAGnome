--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Weather Board
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Weather Board
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:41 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local u1 = require(ReplicatedStorage.Library).get("WeatherEvents");
local SurfaceGui = script:WaitForChild("SurfaceGui");
local u2 = Color3.fromRGB(0, 255, 120);
local u3 = {};
local u4 = false;
local u5 = false;
local u6 = nil;
local v7 = {};

local function formatCountdown(p8) -- Line: 23
    if p8 <= 0 then
        return "0s";
    end;

    local v9 = math.floor(p8 / 3600);
    local v10 = math.floor(p8 % 3600 / 60);
    local v11 = p8 % 60;

    if v9 > 0 then
        return string.format("%dh %dm", v9, v10);
    end;

    if v10 > 0 then
        return string.format("%dm %ds", v10, v11);
    end;

    return string.format("%ds", v11);
end;

local function buildBoard(p12) -- Line: 39
    -- upvalues: SurfaceGui (copy), Players (copy)
    local v13 = SurfaceGui:Clone();
    v13.Adornee = p12;
    v13.Parent = Players.LocalPlayer:WaitForChild("PlayerGui");
    local v14 = v13:FindFirstChild("Outer", true) or v13:FindFirstChildWhichIsA("Frame");
    local Header = v14:FindFirstChild("Header");
    local NextLabel = Header:FindFirstChild("NextLabel");
    local Countdown = Header:FindFirstChild("Countdown");
    local RollClip = v14:FindFirstChild("RollClip", true);
    local RollInner = RollClip:FindFirstChild("RollInner");

    return {
        gui = v13,
        outer = v14,
        header = Header,
        countdown = Countdown,
        nextLabel = NextLabel,
        eventRollClip = RollClip,
        eventRollInner = RollInner,
        eventIcon = RollInner:FindFirstChild("Icon"),
        eventName = RollInner:FindFirstChild("EventName")
    };
end;

local function rollEventPanel(u15, u16, u17) -- Line: 69
    -- upvalues: u1 (copy), TweenService (copy)
    local eventIcon = u15.eventIcon;
    local u18 = {};

    for _, v in u1.events do
        if not v.admin then
            table.insert(u18, v);
        end;
    end;

    local Position = eventIcon.Position;

    local function getOffsetPosition(p19) -- Line: 81
        -- upvalues: Position (copy)
        return UDim2.new(Position.X.Scale, Position.X.Offset, Position.Y.Scale + p19, Position.Y.Offset);
    end;

    task.spawn(function() -- Line: 90
        -- upvalues: u18 (copy), u15 (copy), eventIcon (copy), Position (copy), TweenService (ref), u16 (copy), u17 (copy)
        if #u18 < 1 then
            return;
        end;

        for i = 1, 12 do
            local v20 = u18[math.random(1, #u18)];
            u15.eventName.Text = v20.name;
            u15.eventName.TextColor3 = v20.color;
            u15.eventIcon.Image = v20.icon;
            eventIcon.Position = UDim2.new(Position.X.Scale, Position.X.Offset, Position.Y.Scale + 0.15, Position.Y.Offset);
            local v21 = TweenService:Create(eventIcon, TweenInfo.new(i / 12 * 0.12 + 0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(Position.X.Scale, Position.X.Offset, Position.Y.Scale + -0.15, Position.Y.Offset)
            });
            v21:Play();
            v21.Completed:Wait();
            eventIcon.Position = Position;
        end;

        u15.eventName.Text = u16.name;
        u15.eventName.TextColor3 = u16.color;
        u15.eventIcon.Image = u16.icon;
        eventIcon.Position = UDim2.new(Position.X.Scale, Position.X.Offset, Position.Y.Scale + 0.2, Position.Y.Offset);
        local v22 = TweenService:Create(eventIcon, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = Position
        });
        v22:Play();
        v22.Completed:Wait();

        if u17 then
            u17();
        end;
    end);
end;

local function getEventConfig(p23) -- Line: 126
    -- upvalues: u1 (copy)
    for _, v in u1.events do
        if v.name == p23 then
            return v;
        end;
    end;

    return nil;
end;

local function setBoardIdle(p24, p25) -- Line: 135
    -- upvalues: u2 (copy)
    p24.nextLabel.Text = "Next Event in:";
    p24.countdown.Visible = true;

    if p25 then
        p24.eventName.Text = p25.name;
        p24.eventName.TextColor3 = p25.color;
        p24.eventIcon.Image = p25.icon;

        return;
    end;

    p24.eventName.Text = "?";
    p24.eventName.TextColor3 = u2;
    p24.eventIcon.Image = "";
end;

local function setBoardActive(p26, p27) -- Line: 150
    p26.nextLabel.Text = "Event Active:";
    p26.eventName.Text = p27.name;
    p26.eventName.TextColor3 = p27.color;
    p26.eventIcon.Image = p27.icon;
end;

local function updateAllBoards() -- Line: 159
    -- upvalues: ReplicatedStorage (copy), u1 (copy), u6 (ref), u4 (ref), u5 (ref), u3 (copy), u2 (copy), rollEventPanel (copy)
    local v28 = ReplicatedStorage:GetAttribute("WeatherEvent");
    local v29 = ReplicatedStorage:GetAttribute("WeatherUpcomingEvent");
    local v30 = ReplicatedStorage:GetAttribute("WeatherEndTime");
    local v31 = ReplicatedStorage:GetAttribute("WeatherRolling");
    local v32;

    if v28 == nil then
        v32 = false;
    else
        v32 = v30 ~= nil;
    end;

    local u33;

    if v32 then
        for _, u33 in u1.events do
            if u33.name == v28 then
                break;
            end;
        end;

        if not u33 then
            u33 = nil;
        end;
    else
        u33 = nil;
    end;

    local v34;

    if v32 or not v29 then
        v34 = nil;
    else
        for _, v34 in u1.events do
            if v34.name == v29 then
                break;
            end;
        end;

        if not v34 then
            v34 = nil;
        end;
    end;

    local v35;

    if v32 then
        v35 = v28 ~= u6;
    else
        v35 = v32;
    end;

    if not v32 then
        u4 = false;
        u5 = false;

        for _, v in u3 do
            v.nextLabel.Text = "Next Event in:";
            v.countdown.Visible = true;

            if v34 then
                v.eventName.Text = v34.name;
                v.eventName.TextColor3 = v34.color;
                v.eventIcon.Image = v34.icon;
            else
                v.eventName.Text = "?";
                v.eventName.TextColor3 = u2;
                v.eventIcon.Image = "";
            end;
        end;

        u6 = v28;

        return;
    end;

    if not v35 or (not v31 or u4) then
        if not (v31 or u4) then
            u5 = true;
        end;

        if u5 then
            for _, v in u3 do
                v.nextLabel.Text = "Event Active:";
                v.eventName.Text = u33.name;
                v.eventName.TextColor3 = u33.color;
                v.eventIcon.Image = u33.icon;
            end;
        end;

        u6 = v28;

        return;
    end;

    u4 = true;
    u5 = false;
    u6 = v28;

    for _, v in u3 do
        v.nextLabel.Text = "Rolling...";
        rollEventPanel(v, u33, function() -- Line: 189
            -- upvalues: u5 (ref), u4 (ref), u3 (ref), u33 (copy)
            u5 = true;
            u4 = false;

            for _, v2 in u3 do
                local v36 = u33;
                v2.nextLabel.Text = "Event Active:";
                v2.eventName.Text = v36.name;
                v2.eventName.TextColor3 = v36.color;
                v2.eventIcon.Image = v36.icon;
            end;
        end);
    end;
end;

local function startCountdownLoop() -- Line: 215
    -- upvalues: RunService (copy), ReplicatedStorage (copy), formatCountdown (copy), u3 (copy)
    RunService.Heartbeat:Connect(function() -- Line: 216
        -- upvalues: ReplicatedStorage (ref), formatCountdown (ref), u3 (ref)
        local v37 = ReplicatedStorage:GetAttribute("WeatherEndTime");
        local v38 = ReplicatedStorage:GetAttribute("WeatherNextTime");
        local v39 = os.time();
        local v40;

        if v37 and v39 < v37 then
            v40 = v37 - v39;
        else
            v40 = (not v38 or v39 >= v38) and 0 or v38 - v39;
        end;

        local v41 = formatCountdown(v40);

        for _, v in u3 do
            v.countdown.Text = v41;
        end;
    end);
end;

local function onPartAdded(p42) -- Line: 238
    -- upvalues: buildBoard (copy), u3 (copy), updateAllBoards (copy)
    if not p42:IsA("BasePart") then
        return;
    end;

    u3[p42] = buildBoard(p42);
    updateAllBoards();
end;

local function onPartRemoved(p43) -- Line: 247
    -- upvalues: u3 (copy)
    local v44 = u3[p43];

    if v44 then
        v44.gui:Destroy();
        u3[p43] = nil;
    end;
end;

function v7.Initialize(p45) -- Line: 256
    -- upvalues: CollectionService (copy), onPartAdded (copy), onPartRemoved (copy), ReplicatedStorage (copy), updateAllBoards (copy), RunService (copy), formatCountdown (copy), u3 (copy)
    for _, v in CollectionService:GetTagged("WeatherEventBoardPart") do
        task.spawn(onPartAdded, v);
    end;

    CollectionService:GetInstanceAddedSignal("WeatherEventBoardPart"):Connect(onPartAdded);
    CollectionService:GetInstanceRemovedSignal("WeatherEventBoardPart"):Connect(onPartRemoved);
    ReplicatedStorage:GetAttributeChangedSignal("WeatherEvent"):Connect(updateAllBoards);
    ReplicatedStorage:GetAttributeChangedSignal("WeatherEndTime"):Connect(updateAllBoards);
    ReplicatedStorage:GetAttributeChangedSignal("WeatherNextTime"):Connect(updateAllBoards);
    ReplicatedStorage:GetAttributeChangedSignal("WeatherRolling"):Connect(updateAllBoards);
    ReplicatedStorage:GetAttributeChangedSignal("WeatherUpcomingEvent"):Connect(updateAllBoards);
    updateAllBoards();
    RunService.Heartbeat:Connect(function() -- Line: 216
        -- upvalues: ReplicatedStorage (ref), formatCountdown (ref), u3 (ref)
        local v46 = ReplicatedStorage:GetAttribute("WeatherEndTime");
        local v47 = ReplicatedStorage:GetAttribute("WeatherNextTime");
        local v48 = os.time();
        local v49;

        if v46 and v48 < v46 then
            v49 = v46 - v48;
        else
            v49 = (not v47 or v48 >= v47) and 0 or v47 - v48;
        end;

        local v50 = formatCountdown(v49);

        for _, v in u3 do
            v.countdown.Text = v50;
        end;
    end);
end;

return v7;