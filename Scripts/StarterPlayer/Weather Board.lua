--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Weather Board
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Weather Board
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:09 2026
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
    local events = u1.events;
    local Position = eventIcon.Position;

    local function getOffsetPosition(p18) -- Line: 76
        -- upvalues: Position (copy)
        return UDim2.new(Position.X.Scale, Position.X.Offset, Position.Y.Scale + p18, Position.Y.Offset);
    end;

    task.spawn(function() -- Line: 85
        -- upvalues: events (copy), u15 (copy), eventIcon (copy), Position (copy), TweenService (ref), u16 (copy), u17 (copy)
        for i = 1, 12 do
            local v19 = events[math.random(1, #events)];
            u15.eventName.Text = v19.name;
            u15.eventName.TextColor3 = v19.color;
            u15.eventIcon.Image = v19.icon;
            eventIcon.Position = UDim2.new(Position.X.Scale, Position.X.Offset, Position.Y.Scale + 0.15, Position.Y.Offset);
            local v20 = TweenService:Create(eventIcon, TweenInfo.new(i / 12 * 0.12 + 0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(Position.X.Scale, Position.X.Offset, Position.Y.Scale + -0.15, Position.Y.Offset)
            });
            v20:Play();
            v20.Completed:Wait();
            eventIcon.Position = Position;
        end;

        u15.eventName.Text = u16.name;
        u15.eventName.TextColor3 = u16.color;
        u15.eventIcon.Image = u16.icon;
        eventIcon.Position = UDim2.new(Position.X.Scale, Position.X.Offset, Position.Y.Scale + 0.2, Position.Y.Offset);
        local v21 = TweenService:Create(eventIcon, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = Position
        });
        v21:Play();
        v21.Completed:Wait();

        if u17 then
            u17();
        end;
    end);
end;

local function getEventConfig(p22) -- Line: 117
    -- upvalues: u1 (copy)
    for _, v in u1.events do
        if v.name == p22 then
            return v;
        end;
    end;

    return nil;
end;

local function setBoardIdle(p23, p24) -- Line: 126
    -- upvalues: u2 (copy)
    p23.nextLabel.Text = "Next Event in:";
    p23.countdown.Visible = true;

    if p24 then
        p23.eventName.Text = p24.name;
        p23.eventName.TextColor3 = p24.color;
        p23.eventIcon.Image = p24.icon;

        return;
    end;

    p23.eventName.Text = "?";
    p23.eventName.TextColor3 = u2;
    p23.eventIcon.Image = "";
end;

local function setBoardActive(p25, p26) -- Line: 141
    p25.nextLabel.Text = "Event Active:";
    p25.eventName.Text = p26.name;
    p25.eventName.TextColor3 = p26.color;
    p25.eventIcon.Image = p26.icon;
end;

local function updateAllBoards() -- Line: 150
    -- upvalues: ReplicatedStorage (copy), u1 (copy), u6 (ref), u4 (ref), u5 (ref), u3 (copy), u2 (copy), rollEventPanel (copy)
    local v27 = ReplicatedStorage:GetAttribute("WeatherEvent");
    local v28 = ReplicatedStorage:GetAttribute("WeatherUpcomingEvent");
    local v29 = ReplicatedStorage:GetAttribute("WeatherEndTime");
    local v30 = ReplicatedStorage:GetAttribute("WeatherRolling");
    local v31;

    if v27 == nil then
        v31 = false;
    else
        v31 = v29 ~= nil;
    end;

    local u32;

    if v31 then
        for _, u32 in u1.events do
            if u32.name == v27 then
                break;
            end;
        end;

        if not u32 then
            u32 = nil;
        end;
    else
        u32 = nil;
    end;

    local v33;

    if v31 or not v28 then
        v33 = nil;
    else
        for _, v33 in u1.events do
            if v33.name == v28 then
                break;
            end;
        end;

        if not v33 then
            v33 = nil;
        end;
    end;

    local v34;

    if v31 then
        v34 = v27 ~= u6;
    else
        v34 = v31;
    end;

    if not v31 then
        u4 = false;
        u5 = false;

        for _, v in u3 do
            v.nextLabel.Text = "Next Event in:";
            v.countdown.Visible = true;

            if v33 then
                v.eventName.Text = v33.name;
                v.eventName.TextColor3 = v33.color;
                v.eventIcon.Image = v33.icon;
            else
                v.eventName.Text = "?";
                v.eventName.TextColor3 = u2;
                v.eventIcon.Image = "";
            end;
        end;

        u6 = v27;

        return;
    end;

    if not v34 or (not v30 or u4) then
        if not (v30 or u4) then
            u5 = true;
        end;

        if u5 then
            for _, v in u3 do
                v.nextLabel.Text = "Event Active:";
                v.eventName.Text = u32.name;
                v.eventName.TextColor3 = u32.color;
                v.eventIcon.Image = u32.icon;
            end;
        end;

        u6 = v27;

        return;
    end;

    u4 = true;
    u5 = false;
    u6 = v27;

    for _, v in u3 do
        v.nextLabel.Text = "Rolling...";
        rollEventPanel(v, u32, function() -- Line: 180
            -- upvalues: u5 (ref), u4 (ref), u3 (ref), u32 (copy)
            u5 = true;
            u4 = false;

            for _, v2 in u3 do
                local v35 = u32;
                v2.nextLabel.Text = "Event Active:";
                v2.eventName.Text = v35.name;
                v2.eventName.TextColor3 = v35.color;
                v2.eventIcon.Image = v35.icon;
            end;
        end);
    end;
end;

local function startCountdownLoop() -- Line: 206
    -- upvalues: RunService (copy), ReplicatedStorage (copy), formatCountdown (copy), u3 (copy)
    RunService.Heartbeat:Connect(function() -- Line: 207
        -- upvalues: ReplicatedStorage (ref), formatCountdown (ref), u3 (ref)
        local v36 = ReplicatedStorage:GetAttribute("WeatherEndTime");
        local v37 = ReplicatedStorage:GetAttribute("WeatherNextTime");
        local v38 = os.time();
        local v39;

        if v36 and v38 < v36 then
            v39 = v36 - v38;
        else
            v39 = (not v37 or v38 >= v37) and 0 or v37 - v38;
        end;

        local v40 = formatCountdown(v39);

        for _, v in u3 do
            v.countdown.Text = v40;
        end;
    end);
end;

local function onPartAdded(p41) -- Line: 229
    -- upvalues: buildBoard (copy), u3 (copy), updateAllBoards (copy)
    if not p41:IsA("BasePart") then
        return;
    end;

    u3[p41] = buildBoard(p41);
    updateAllBoards();
end;

local function onPartRemoved(p42) -- Line: 238
    -- upvalues: u3 (copy)
    local v43 = u3[p42];

    if v43 then
        v43.gui:Destroy();
        u3[p42] = nil;
    end;
end;

function v7.Initialize(p44) -- Line: 247
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
    RunService.Heartbeat:Connect(function() -- Line: 207
        -- upvalues: ReplicatedStorage (ref), formatCountdown (ref), u3 (ref)
        local v45 = ReplicatedStorage:GetAttribute("WeatherEndTime");
        local v46 = ReplicatedStorage:GetAttribute("WeatherNextTime");
        local v47 = os.time();
        local v48;

        if v45 and v47 < v45 then
            v48 = v45 - v47;
        else
            v48 = (not v46 or v47 >= v46) and 0 or v46 - v47;
        end;

        local v49 = formatCountdown(v48);

        for _, v in u3 do
            v.countdown.Text = v49;
        end;
    end);
end;

return v7;