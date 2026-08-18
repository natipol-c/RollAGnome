--[[
  Type:     LocalScript
  Method:   decompile
  Name:     RbxCharacterSounds
  Path:     game.StarterPlayer.StarterPlayerScripts.RbxCharacterSounds
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:10 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local SoundService = game:GetService("SoundService");
local AtomicBinding = require(script:WaitForChild("AtomicBinding"));

local function loadFlag(u1) -- Line: 12
    local success, result = pcall(function() -- Line: 13
        -- upvalues: u1 (copy)
        return UserSettings():IsUserFeatureEnabled(u1);
    end);

    return success and result;
end;

local u2 = "UserSoundsUseRelativeVelocity2";
local success, result = pcall(function() -- Line: 13
    -- upvalues: u2 (copy)
    return UserSettings():IsUserFeatureEnabled(u2);
end);
local u3 = success and result;
local u4 = "UserNewCharacterSoundsApi3";
local success2, result2 = pcall(function() -- Line: 13
    -- upvalues: u4 (copy)
    return UserSettings():IsUserFeatureEnabled(u4);
end);
local u5 = success2 and result2;
local u6 = "UserFixCharSoundsEmitters";
local success3, result3 = pcall(function() -- Line: 13
    -- upvalues: u6 (copy)
    return UserSettings():IsUserFeatureEnabled(u6);
end);
local u7 = success3 and result3;
local u8 = "UserFixCharSoundsEmitterRootPart";
local success4, result4 = pcall(function() -- Line: 13
    -- upvalues: u8 (copy)
    return UserSettings():IsUserFeatureEnabled(u8);
end);
local u9 = success4 and result4;
local u10 = {
    Climbing = {
        SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3",
        Looped = true
    },
    Died = {
        SoundId = "rbxasset://sounds/uuhhh.mp3"
    },
    FreeFalling = {
        SoundId = "rbxasset://sounds/action_falling.ogg",
        Looped = true
    },
    GettingUp = {
        SoundId = "rbxasset://sounds/action_get_up.mp3"
    },
    Jumping = {
        SoundId = "rbxasset://sounds/action_jump.mp3"
    },
    Landing = {
        SoundId = "rbxasset://sounds/action_jump_land.mp3"
    },
    Running = {
        SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3",
        Looped = true,
        Pitch = 1.85
    },
    Splash = {
        SoundId = "rbxasset://sounds/impact_water.mp3"
    },
    Swimming = {
        SoundId = "rbxasset://sounds/action_swim.mp3",
        Looped = true,
        Pitch = 1.6
    }
};
local u11 = {
    Climbing = {
        AssetId = "rbxasset://sounds/action_footsteps_plastic.mp3",
        Looping = true
    },
    Died = {
        AssetId = "rbxasset://sounds/uuhhh.mp3"
    },
    FreeFalling = {
        AssetId = "rbxasset://sounds/action_falling.ogg",
        Looping = true
    },
    GettingUp = {
        AssetId = "rbxasset://sounds/action_get_up.mp3"
    },
    Jumping = {
        AssetId = "rbxasset://sounds/action_jump.mp3"
    },
    Landing = {
        AssetId = "rbxasset://sounds/action_jump_land.mp3"
    },
    Running = {
        AssetId = "rbxasset://sounds/action_footsteps_plastic.mp3",
        Looping = true,
        PlaybackSpeed = 1.85
    },
    Splash = {
        AssetId = "rbxasset://sounds/impact_water.mp3"
    },
    Swimming = {
        AssetId = "rbxasset://sounds/action_swim.mp3",
        Looping = true,
        PlaybackSpeed = 1.6
    }
};

local function map(p12, p13, p14, p15, p16) -- Line: 97
    return (p12 - p13) * (p16 - p15) / (p14 - p13) + p15;
end;

local function getRelativeVelocity(p17, p18) -- Line: 101
    if not p17 then
        return p18;
    end;

    local v19 = p17.ActiveController and (p17.ActiveController:IsA("GroundController") and p17.GroundSensor or p17.ActiveController:IsA("ClimbController") and p17.ClimbSensor);

    if v19 and v19.SensedPart then
        return p18 - v19.SensedPart:GetVelocityAtPosition(p17.RootPart.Position);
    end;

    return p18;
end;

local function playSound(p20, p21) -- Line: 118
    -- upvalues: u5 (copy)
    if not p21 then
        p20.TimePosition = 0;
    end;

    if u5 and p20:IsA("AudioPlayer") then
        p20:Play();

        return;
    end;

    p20.Playing = true;
end;

local function stopSound(p22) -- Line: 129
    -- upvalues: u5 (copy)
    if u5 and p22:IsA("AudioPlayer") then
        p22:Stop();

        return;
    end;

    p22.Playing = false;
end;

local function playSoundIf(p23, p24) -- Line: 137
    -- upvalues: u5 (copy)
    if u5 and p23:IsA("AudioPlayer") then
        if p23.IsPlaying and not p24 then
            p23:Stop();

            return;
        end;

        if not p23.IsPlaying and p24 then
            p23:Play();
        end;
    else
        p23.Playing = p24;
    end;
end;

local function setSoundLooped(p25, p26) -- Line: 149
    -- upvalues: u5 (copy)
    if u5 and p25:IsA("AudioPlayer") then
        p25.Looping = p26;

        return;
    end;

    p25.Looped = p26;
end;

local function shallowCopy(p27) -- Line: 157
    local v28 = {};

    for i, v in pairs(p27) do
        v28[i] = v;
    end;

    return v28;
end;

local u72 = AtomicBinding.new({
    humanoid = "Humanoid",
    rootPart = "HumanoidRootPart"
}, function(p29) -- Line: 165, Name: initializeSoundSystem
    -- upvalues: u3 (copy), u5 (copy), SoundService (copy), u7 (copy), u9 (copy), Players (copy), u11 (copy), u10 (copy), getRelativeVelocity (copy), RunService (copy)
    local humanoid = p29.humanoid;
    local rootPart = p29.rootPart;
    local u30 = nil;
    local u31;

    if u3 then
        u31 = humanoid.Parent:FindFirstChild("ControllerManager");
    else
        u31 = nil;
    end;

    local u32 = {};

    if u5 and SoundService.CharacterSoundsUseNewApi == Enum.RolloutState.Enabled then
        local v33 = nil;
        local v34 = nil;

        if u7 then
            if u9 then
                v34 = humanoid.RootPart or humanoid.Parent;
            else
                v34 = humanoid.RootPart;
            end;
        else
            v33 = Players.LocalPlayer.Character;
        end;

        local v35 = 5;
        local v36 = {};

        while v35 < 150 do
            v36[v35] = 5 / v35;
            v35 = v35 * 1.25;
        end;

        v36[150] = 0;

        if u7 then
            u30 = Instance.new("AudioEmitter", v34);
        else
            u30 = Instance.new("AudioEmitter", v33);
        end;

        u30.Name = "RbxCharacterSoundsEmitter";
        u30:SetDistanceAttenuation(v36);

        for i, v in pairs(u11) do
            local AudioPlayer = Instance.new("AudioPlayer");
            local Wire = Instance.new("Wire");
            AudioPlayer.Name = i;
            Wire.Name = i .. "Wire";
            AudioPlayer.Archivable = false;
            AudioPlayer.Volume = 0.65;

            for i2, v2 in pairs(v) do
                AudioPlayer[i2] = v2;
            end;

            AudioPlayer.Parent = rootPart;
            Wire.Parent = AudioPlayer;
            Wire.SourceInstance = AudioPlayer;
            Wire.TargetInstance = u30;
            u32[i] = AudioPlayer;
        end;
    else
        for i, v in pairs(u10) do
            local Sound = Instance.new("Sound");
            Sound.Name = i;
            Sound.Archivable = false;
            Sound.RollOffMinDistance = 5;
            Sound.RollOffMaxDistance = 150;
            Sound.Volume = 0.65;

            for i2, v2 in pairs(v) do
                Sound[i2] = v2;
            end;

            Sound.Parent = rootPart;
            u32[i] = Sound;
        end;
    end;

    local u37 = {};

    local function stopPlayingLoopedSounds(p38) -- Line: 241
        -- upvalues: u37 (copy), u5 (ref)
        local v39 = pairs;
        local v40 = {};
        local v41 = p38 or nil;

        for i, v in pairs(u37) do
            v40[i] = v;
        end;

        for i in v39(v40) do
            if i ~= v41 then
                if u5 and i:IsA("AudioPlayer") then
                    i:Stop();
                else
                    i.Playing = false;
                end;

                u37[i] = nil;
            end;
        end;
    end;

    local u44 = {
        [Enum.HumanoidStateType.FallingDown] = function() -- Line: 253
            -- upvalues: stopPlayingLoopedSounds (copy)
            stopPlayingLoopedSounds();
        end,

        [Enum.HumanoidStateType.GettingUp] = function() -- Line: 257
            -- upvalues: stopPlayingLoopedSounds (copy), u32 (copy), u5 (ref)
            stopPlayingLoopedSounds();
            local GettingUp = u32.GettingUp;
            GettingUp.TimePosition = 0;

            if u5 and GettingUp:IsA("AudioPlayer") then
                GettingUp:Play();

                return;
            end;

            GettingUp.Playing = true;
        end,

        [Enum.HumanoidStateType.Jumping] = function() -- Line: 262
            -- upvalues: stopPlayingLoopedSounds (copy), u32 (copy), u5 (ref)
            stopPlayingLoopedSounds();
            local Jumping = u32.Jumping;
            Jumping.TimePosition = 0;

            if u5 and Jumping:IsA("AudioPlayer") then
                Jumping:Play();

                return;
            end;

            Jumping.Playing = true;
        end,

        [Enum.HumanoidStateType.Swimming] = function() -- Line: 267
            -- upvalues: rootPart (copy), u32 (copy), u5 (ref), stopPlayingLoopedSounds (copy), u37 (copy)
            local v42 = math.abs(rootPart.AssemblyLinearVelocity.Y);

            if v42 > 0.1 then
                u32.Splash.Volume = math.clamp((v42 - 100) * 0.72 / 250 + 0.28, 0, 1);
                local Splash = u32.Splash;
                Splash.TimePosition = 0;

                if u5 and Splash:IsA("AudioPlayer") then
                    Splash:Play();
                else
                    Splash.Playing = true;
                end;
            end;

            stopPlayingLoopedSounds(u32.Swimming);
            local Swimming = u32.Swimming;

            if u5 and Swimming:IsA("AudioPlayer") then
                Swimming:Play();
            else
                Swimming.Playing = true;
            end;

            u37[u32.Swimming] = true;
        end,

        [Enum.HumanoidStateType.Freefall] = function() -- Line: 278
            -- upvalues: u32 (copy), stopPlayingLoopedSounds (copy), u5 (ref), u37 (copy)
            u32.FreeFalling.Volume = 0;
            stopPlayingLoopedSounds(u32.FreeFalling);
            local FreeFalling = u32.FreeFalling;

            if u5 and FreeFalling:IsA("AudioPlayer") then
                FreeFalling.Looping = true;
            else
                FreeFalling.Looped = true;
            end;

            if u32.FreeFalling:IsA("Sound") then
                u32.FreeFalling.PlaybackRegionsEnabled = true;
            end;

            u32.FreeFalling.LoopRegion = NumberRange.new(2, 9);
            local FreeFalling2 = u32.FreeFalling;
            FreeFalling2.TimePosition = 0;

            if u5 and FreeFalling2:IsA("AudioPlayer") then
                FreeFalling2:Play();
            else
                FreeFalling2.Playing = true;
            end;

            u37[u32.FreeFalling] = true;
        end,

        [Enum.HumanoidStateType.Landed] = function() -- Line: 292
            -- upvalues: stopPlayingLoopedSounds (copy), rootPart (copy), u32 (copy), u5 (ref)
            stopPlayingLoopedSounds();
            local v43 = math.abs(rootPart.AssemblyLinearVelocity.Y);

            if v43 > 75 then
                u32.Landing.Volume = math.clamp((v43 - 50) * 1 / 50 + 0, 0, 1);
                local Landing = u32.Landing;
                Landing.TimePosition = 0;

                if u5 and Landing:IsA("AudioPlayer") then
                    Landing:Play();

                    return;
                end;

                Landing.Playing = true;
            end;
        end,

        [Enum.HumanoidStateType.Running] = function() -- Line: 301
            -- upvalues: stopPlayingLoopedSounds (copy), u32 (copy), u5 (ref), u37 (copy)
            stopPlayingLoopedSounds(u32.Running);
            local Running = u32.Running;

            if u5 and Running:IsA("AudioPlayer") then
                Running:Play();
            else
                Running.Playing = true;
            end;

            u37[u32.Running] = true;
        end,

        [Enum.HumanoidStateType.Climbing] = function() -- Line: 307
            -- upvalues: u32 (copy), rootPart (copy), u3 (ref), getRelativeVelocity (ref), u31 (ref), u5 (ref), stopPlayingLoopedSounds (copy), u37 (copy)
            local Climbing = u32.Climbing;
            local AssemblyLinearVelocity = rootPart.AssemblyLinearVelocity;

            if u3 then
                AssemblyLinearVelocity = getRelativeVelocity(u31, AssemblyLinearVelocity);
            end;

            if math.abs(AssemblyLinearVelocity.Y) > 0.1 then
                if u5 and Climbing:IsA("AudioPlayer") then
                    Climbing:Play();
                else
                    Climbing.Playing = true;
                end;

                stopPlayingLoopedSounds(Climbing);
            else
                stopPlayingLoopedSounds();
            end;

            u37[Climbing] = true;
        end,

        [Enum.HumanoidStateType.Seated] = function() -- Line: 320
            -- upvalues: stopPlayingLoopedSounds (copy)
            stopPlayingLoopedSounds();
        end,

        [Enum.HumanoidStateType.Dead] = function() -- Line: 324
            -- upvalues: stopPlayingLoopedSounds (copy), u32 (copy), u5 (ref)
            stopPlayingLoopedSounds();
            local Died = u32.Died;
            Died.TimePosition = 0;

            if u5 and Died:IsA("AudioPlayer") then
                Died:Play();

                return;
            end;

            Died.Playing = true;
        end
    };
    local u56 = {
        [u32.Climbing] = function(p45, p46, p47) -- Line: 332
            -- upvalues: u3 (ref), getRelativeVelocity (ref), u31 (ref), u5 (ref)
            if u3 then
                p47 = getRelativeVelocity(u31, p47);
            end;

            local v48 = p47.Magnitude > 0.1;

            if u5 and p46:IsA("AudioPlayer") then
                if p46.IsPlaying and not v48 then
                    p46:Stop();

                    return;
                end;

                if not p46.IsPlaying and v48 then
                    p46:Play();
                end;
            else
                p46.Playing = v48;
            end;
        end,

        [u32.FreeFalling] = function(p49, p50, p51) -- Line: 337
            if p51.Magnitude > 75 then
                p50.Volume = math.clamp(p50.Volume + p49 * 0.9, 0, 1);

                return;
            end;

            p50.Volume = 0;
        end,

        [u32.Running] = function(p52, p53, p54) -- Line: 345
            -- upvalues: humanoid (copy), u5 (ref)
            local v55;

            if p54.Magnitude > 0.5 then
                v55 = humanoid.MoveDirection.Magnitude > 0.5;
            else
                v55 = false;
            end;

            if u5 and p53:IsA("AudioPlayer") then
                if p53.IsPlaying and not v55 then
                    p53:Stop();

                    return;
                end;

                if not p53.IsPlaying and v55 then
                    p53:Play();
                end;
            else
                p53.Playing = v55;
            end;
        end
    };
    local u57 = {
        [Enum.HumanoidStateType.RunningNoPhysics] = Enum.HumanoidStateType.Running
    };
    local u58 = u57[humanoid:GetState()] or humanoid:GetState();

    local function transitionTo(p59) -- Line: 357
        -- upvalues: u44 (copy), u58 (ref)
        local v60 = u44[p59];

        if v60 then
            v60();
        end;

        u58 = p59;
    end;

    local v61 = u58;
    local v62 = u44[v61];

    if v62 then
        v62();
    end;

    u58 = v61;
    local u67 = humanoid.StateChanged:Connect(function(p63, p64) -- Line: 369
        -- upvalues: u57 (copy), u58 (ref), u44 (copy)
        local v65 = u57[p64] or p64;

        if v65 ~= u58 then
            local v66 = u44[v65];

            if v66 then
                v66();
            end;

            u58 = v65;
        end;
    end);
    local u71 = RunService.Stepped:Connect(function(p68, p69) -- Line: 377
        -- upvalues: u37 (copy), u56 (copy), rootPart (copy)
        for i in pairs(u37) do
            local v70 = u56[i];

            if v70 then
                v70(p69, i, rootPart.AssemblyLinearVelocity);
            end;
        end;
    end);

    return function() -- Line: 388, Name: terminate
        -- upvalues: u67 (copy), u71 (copy), u9 (ref), u30 (ref), u32 (copy)
        u67:Disconnect();
        u71:Disconnect();

        if u9 and u30 then
            u30:Destroy();
        end;

        for _, v in pairs(u32) do
            v:Destroy();
        end;

        table.clear(u32);
    end;
end);
local u73 = {};

local function characterAdded(p74) -- Line: 415
    -- upvalues: u72 (copy)
    u72:bindRoot(p74);
end;

local function characterRemoving(p75) -- Line: 419
    -- upvalues: u72 (copy)
    u72:unbindRoot(p75);
end;

local function playerAdded(p76) -- Line: 423
    -- upvalues: u73 (copy), u72 (copy), characterAdded (copy), characterRemoving (copy)
    local v77 = u73[p76];

    if not v77 then
        v77 = {};
        u73[p76] = v77;
    end;

    if p76.Character then
        u72:bindRoot(p76.Character);
    end;

    table.insert(v77, p76.CharacterAdded:Connect(characterAdded));
    table.insert(v77, p76.CharacterRemoving:Connect(characterRemoving));
end;

local function playerRemoving(p78) -- Line: 437
    -- upvalues: u73 (copy), u72 (copy)
    local v79 = u73[p78];

    if v79 then
        for _, v in ipairs(v79) do
            v:Disconnect();
        end;

        u73[p78] = nil;
    end;

    if p78.Character then
        u72:unbindRoot(p78.Character);
    end;
end;

for _, v in ipairs(Players:GetPlayers()) do
    task.spawn(playerAdded, v);
end;

Players.PlayerAdded:Connect(playerAdded);
Players.PlayerRemoving:Connect(playerRemoving);