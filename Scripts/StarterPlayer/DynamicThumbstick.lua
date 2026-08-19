--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DynamicThumbstick
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule.DynamicThumbstick
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:30 2026
]]

-- Decompiled with Potassium's decompiler.

local Value = Enum.ContextActionPriority.High.Value;
local u1 = { 0.10999999999999999, 0.30000000000000004, 0.4, 0.5, 0.6, 0.7, 0.75 };
local u2 = #u1;
local u3 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local Players = game:GetService("Players");
local GuiService = game:GetService("GuiService");
local UserInputService = game:GetService("UserInputService");
local ContextActionService = game:GetService("ContextActionService");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local FlagUtil = require(CommonUtils:WaitForChild("FlagUtil"));
local u4 = FlagUtil.getUserFlag("UserAllowAbilityControls");
local u5 = FlagUtil.getUserFlag("UserAllowAbilityControlsBonus");
local success, result = pcall(function() -- Line: 42
    return UserSettings():IsUserFeatureEnabled("UserDynamicThumbstickSafeAreaUpdate");
end);
local u6 = success and result;
local u7;

if u4 then
    u7 = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"));
else
    u7 = nil;
end;

local LocalPlayer = Players.LocalPlayer;

if not LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait();
    LocalPlayer = Players.LocalPlayer;
end;

local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"));
local u8 = setmetatable({}, BaseCharacterController);
u8.__index = u8;

function u8.new() -- Line: 64
    -- upvalues: BaseCharacterController (copy), u8 (copy)
    local v9 = BaseCharacterController.new();
    local v10 = setmetatable(v9, u8);
    v10.moveTouchObject = nil;
    v10.moveTouchLockedIn = false;
    v10.moveTouchFirstChanged = false;
    v10.moveTouchStartPosition = nil;
    v10.startImage = nil;
    v10.endImage = nil;
    v10.middleImages = {};
    v10.startImageFadeTween = nil;
    v10.endImageFadeTween = nil;
    v10.middleImageFadeTweens = {};
    v10.isFirstTouch = true;
    v10.thumbstickFrame = nil;
    v10.onRenderSteppedConn = nil;
    v10.fadeInAndOutBalance = 0.5;
    v10.fadeInAndOutHalfDuration = 0.3;
    v10.hasFadedBackgroundInPortrait = false;
    v10.hasFadedBackgroundInLandscape = false;
    v10.tweenInAlphaStart = nil;
    v10.tweenOutAlphaStart = nil;

    return v10;
end;

function u8.GetIsJumping(p11) -- Line: 99
    local isJumping = p11.isJumping;
    p11.isJumping = false;

    return isJumping;
end;

function u8.Enable(p12, p13, p14) -- Line: 105
    if p13 == nil then
        return false;
    end;

    local v15 = p13 and true or false;

    if p12.enabled == v15 then
        return true;
    end;

    if v15 then
        if not p12.thumbstickFrame then
            p12:Create(p14);
        end;

        p12:BindContextActions();
    else
        p12:UnbindContextActions();
        p12:OnInputEnded();
    end;

    p12.enabled = v15;
    p12.thumbstickFrame.Visible = v15;

    return nil;
end;

function u8.OnInputEnded(p16) -- Line: 130
    p16.moveTouchObject = nil;
    p16.moveVector = Vector3.new(0, 0, 0);
    p16:FadeThumbstick(false);
end;

function u8.FadeThumbstick(p17, p18) -- Line: 136
    -- upvalues: TweenService (copy), u3 (copy), u1 (copy)
    if not p18 and p17.moveTouchObject then
        return;
    end;

    if p17.isFirstTouch then
        return;
    end;

    if p17.startImageFadeTween then
        p17.startImageFadeTween:Cancel();
    end;

    if p17.endImageFadeTween then
        p17.endImageFadeTween:Cancel();
    end;

    for i = 1, #p17.middleImages do
        if p17.middleImageFadeTweens[i] then
            p17.middleImageFadeTweens[i]:Cancel();
        end;
    end;

    if p18 then
        p17.startImageFadeTween = TweenService:Create(p17.startImage, u3, {
            ImageTransparency = 0
        });
        p17.startImageFadeTween:Play();
        p17.endImageFadeTween = TweenService:Create(p17.endImage, u3, {
            ImageTransparency = 0.2
        });
        p17.endImageFadeTween:Play();

        for i = 1, #p17.middleImages do
            p17.middleImageFadeTweens[i] = TweenService:Create(p17.middleImages[i], u3, {
                ImageTransparency = u1[i]
            });
            p17.middleImageFadeTweens[i]:Play();
        end;

        return;
    end;

    p17.startImageFadeTween = TweenService:Create(p17.startImage, u3, {
        ImageTransparency = 1
    });
    p17.startImageFadeTween:Play();
    p17.endImageFadeTween = TweenService:Create(p17.endImage, u3, {
        ImageTransparency = 1
    });
    p17.endImageFadeTween:Play();

    for i = 1, #p17.middleImages do
        p17.middleImageFadeTweens[i] = TweenService:Create(p17.middleImages[i], u3, {
            ImageTransparency = 1
        });
        p17.middleImageFadeTweens[i]:Play();
    end;
end;

function u8.FadeThumbstickFrame(p19, p20, p21) -- Line: 179
    p19.fadeInAndOutHalfDuration = p20 * 0.5;
    p19.fadeInAndOutBalance = p21;
    p19.tweenInAlphaStart = tick();
end;

function u8.InputInFrame(p22, p23) -- Line: 185
    local AbsolutePosition = p22.thumbstickFrame.AbsolutePosition;
    local v24 = AbsolutePosition + p22.thumbstickFrame.AbsoluteSize;
    local Position = p23.Position;

    return Position.X >= AbsolutePosition.X and (Position.Y >= AbsolutePosition.Y and (Position.X <= v24.X and Position.Y <= v24.Y));
end;

function u8.DoFadeInBackground(p25) -- Line: 197
    -- upvalues: LocalPlayer (ref)
    local v26 = LocalPlayer:FindFirstChildOfClass("PlayerGui");
    local v27 = false;

    if v26 then
        if v26.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft or v26.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight then
            v27 = p25.hasFadedBackgroundInLandscape;
            p25.hasFadedBackgroundInLandscape = true;
        elseif v26.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait then
            v27 = p25.hasFadedBackgroundInPortrait;
            p25.hasFadedBackgroundInPortrait = true;
        end;
    end;

    if not v27 then
        p25.fadeInAndOutHalfDuration = 0.3;
        p25.fadeInAndOutBalance = 0.5;
        p25.tweenInAlphaStart = tick();
    end;
end;

function u8.DoMove(p28, p29) -- Line: 220
    local v30;

    if p29.Magnitude < p28.radiusOfDeadZone then
        v30 = Vector3.new(0, 0, 0);
    else
        local v31 = p29.Unit * (1 - math.max(0, (p28.radiusOfMaxSpeed - p29.Magnitude) / p28.radiusOfMaxSpeed));
        v30 = Vector3.new(v31.X, 0, v31.Y);
    end;

    p28.moveVector = v30;
end;

function u8.LayoutMiddleImages(p32, p33, p34) -- Line: 238
    -- upvalues: u2 (copy)
    local v35 = p32.thumbstickSize / 2 + p32.middleSize;
    local v36 = p34 - p33;
    local v37 = v36.Magnitude - p32.thumbstickRingSize / 2 - p32.middleSize;
    local Unit = v36.Unit;
    local middleSpacing = p32.middleSpacing;

    if p32.middleSpacing * u2 < v37 then
        middleSpacing = v37 / u2;
    end;

    for i = 1, u2 do
        local v38 = p32.middleImages[i];
        local v39 = v35 + middleSpacing * (i - 1);

        if v35 + middleSpacing * (i - 2) < v37 then
            local v40 = p34 - Unit * v39;
            local v41 = math.clamp(1 - (v39 - v37) / middleSpacing, 0, 1);
            v38.Visible = true;
            v38.Position = UDim2.new(0, v40.X, 0, v40.Y);
            v38.Size = UDim2.new(0, p32.middleSize * v41, 0, p32.middleSize * v41);
        else
            v38.Visible = false;
        end;
    end;
end;

function u8.MoveStick(p42, p43) -- Line: 269
    local v44 = Vector2.new(p42.moveTouchStartPosition.X, p42.moveTouchStartPosition.Y) - p42.thumbstickFrame.AbsolutePosition;
    local v45 = Vector2.new(p43.X, p43.Y) - p42.thumbstickFrame.AbsolutePosition;
    p42.endImage.Position = UDim2.new(0, v45.X, 0, v45.Y);
    p42:LayoutMiddleImages(v44, v45);
end;

function u8.BindContextActions(u46) -- Line: 277
    -- upvalues: TweenService (copy), ContextActionService (copy), Value (copy), UserInputService (copy)
    local function inputBegan(p47) -- Line: 278
        -- upvalues: u46 (copy), TweenService (ref)
        if u46.moveTouchObject then
            return Enum.ContextActionResult.Pass;
        end;

        if not u46:InputInFrame(p47) then
            return Enum.ContextActionResult.Pass;
        end;

        if u46.isFirstTouch then
            u46.isFirstTouch = false;
            local v48 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
            TweenService:Create(u46.startImage, v48, {
                Size = UDim2.new(0, 0, 0, 0)
            }):Play();
            TweenService:Create(u46.endImage, v48, {
                Size = UDim2.new(0, u46.thumbstickSize, 0, u46.thumbstickSize),
                ImageColor3 = Color3.new(0, 0, 0)
            }):Play();
        end;

        u46.moveTouchLockedIn = false;
        u46.moveTouchObject = p47;
        u46.moveTouchStartPosition = p47.Position;
        u46.moveTouchFirstChanged = true;
        u46:DoFadeInBackground();

        return Enum.ContextActionResult.Pass;
    end;

    local function inputChanged(p49) -- Line: 310
        -- upvalues: u46 (copy)
        if p49 ~= u46.moveTouchObject then
            return Enum.ContextActionResult.Pass;
        end;

        if u46.moveTouchFirstChanged then
            u46.moveTouchFirstChanged = false;
            local v50 = Vector2.new(p49.Position.X - u46.thumbstickFrame.AbsolutePosition.X, p49.Position.Y - u46.thumbstickFrame.AbsolutePosition.Y);
            u46.startImage.Visible = true;
            u46.startImage.Position = UDim2.new(0, v50.X, 0, v50.Y);
            u46.endImage.Visible = true;
            u46.endImage.Position = u46.startImage.Position;
            u46:FadeThumbstick(true);
            u46:MoveStick(p49.Position);
        end;

        u46.moveTouchLockedIn = true;
        local v51 = Vector2.new(p49.Position.X - u46.moveTouchStartPosition.X, p49.Position.Y - u46.moveTouchStartPosition.Y);

        if math.abs(v51.X) > 0 or math.abs(v51.Y) > 0 then
            u46:DoMove(v51);
            u46:MoveStick(p49.Position);
        end;

        return Enum.ContextActionResult.Sink;
    end;

    local function inputEnded(p52) -- Line: 343
        -- upvalues: u46 (copy)
        if p52 == u46.moveTouchObject then
            u46:OnInputEnded();

            if u46.moveTouchLockedIn then
                return Enum.ContextActionResult.Sink;
            end;
        end;

        return Enum.ContextActionResult.Pass;
    end;

    ContextActionService:BindActionAtPriority("DynamicThumbstickAction", function(p53, p54, p55) -- Line: 353, Name: handleInput
        -- upvalues: inputBegan (copy), u46 (copy)
        if p54 == Enum.UserInputState.Begin then
            return inputBegan(p55);
        end;

        if p54 == Enum.UserInputState.Change then
            if p55 == u46.moveTouchObject then
                return Enum.ContextActionResult.Sink;
            end;

            return Enum.ContextActionResult.Pass;
        end;

        if p54 == Enum.UserInputState.End then
            if p55 == u46.moveTouchObject then
                u46:OnInputEnded();

                if u46.moveTouchLockedIn then
                    return Enum.ContextActionResult.Sink;
                end;
            end;

            return Enum.ContextActionResult.Pass;
        end;

        if p54 == Enum.UserInputState.Cancel then
            u46:OnInputEnded();
        end;
    end, false, Value, Enum.UserInputType.Touch);
    u46.TouchMovedCon = UserInputService.TouchMoved:Connect(function(p56, p57) -- Line: 376
        -- upvalues: inputChanged (copy)
        inputChanged(p56);
    end);
end;

function u8.UnbindContextActions(p58) -- Line: 381
    -- upvalues: ContextActionService (copy)
    ContextActionService:UnbindAction("DynamicThumbstickAction");

    if p58.TouchMovedCon then
        p58.TouchMovedCon:Disconnect();
    end;
end;

function u8.Create(u59, u60) -- Line: 389
    -- upvalues: u4 (copy), u6 (ref), u2 (copy), u1 (copy), u5 (copy), u7 (ref), RunService (copy), UserInputService (copy), GuiService (copy), LocalPlayer (ref)
    if u59.thumbstickFrame then
        u59.thumbstickFrame:Destroy();
        u59.thumbstickFrame = nil;

        if u59.onRenderSteppedConn then
            u59.onRenderSteppedConn:Disconnect();
            u59.onRenderSteppedConn = nil;
        end;

        if u59.absoluteSizeChangedConn then
            u59.absoluteSizeChangedConn:Disconnect();
            u59.absoluteSizeChangedConn = nil;
        end;

        if u4 and u59.avatarAbilitiesEnabledChangedConn then
            u59.avatarAbilitiesEnabledChangedConn:Disconnect();
            u59.avatarAbilitiesEnabledChangedConn = nil;
        end;
    end;

    local u61 = u6 and 100 or 0;
    u59.thumbstickFrame = Instance.new("Frame");
    u59.thumbstickFrame.BorderSizePixel = 0;
    u59.thumbstickFrame.Name = "DynamicThumbstickFrame";
    u59.thumbstickFrame.Visible = false;
    u59.thumbstickFrame.BackgroundTransparency = 1;
    u59.thumbstickFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    u59.thumbstickFrame.Active = false;
    u59.thumbstickFrame.Size = UDim2.new(0.4, u61, 0.6666666666666666, u61);
    u59.thumbstickFrame.Position = UDim2.new(0, -u61, 0.3333333333333333, 0);
    u59.startImage = Instance.new("ImageLabel");
    u59.startImage.Name = "ThumbstickStart";
    u59.startImage.Visible = true;
    u59.startImage.BackgroundTransparency = 1;
    u59.startImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
    u59.startImage.ImageRectOffset = Vector2.new(1, 1);
    u59.startImage.ImageRectSize = Vector2.new(144, 144);
    u59.startImage.ImageColor3 = Color3.new(0, 0, 0);
    u59.startImage.AnchorPoint = Vector2.new(0.5, 0.5);
    u59.startImage.ZIndex = 10;
    u59.startImage.Parent = u59.thumbstickFrame;
    u59.endImage = Instance.new("ImageLabel");
    u59.endImage.Name = "ThumbstickEnd";
    u59.endImage.Visible = true;
    u59.endImage.BackgroundTransparency = 1;
    u59.endImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
    u59.endImage.ImageRectOffset = Vector2.new(1, 1);
    u59.endImage.ImageRectSize = Vector2.new(144, 144);
    u59.endImage.AnchorPoint = Vector2.new(0.5, 0.5);
    u59.endImage.ZIndex = 10;
    u59.endImage.Parent = u59.thumbstickFrame;

    local function layoutThumbstickFrame(p62) -- Line: 410
        -- upvalues: u59 (copy), u61 (copy)
        if p62 then
            u59.thumbstickFrame.Size = UDim2.new(1, u61, 0.4, u61);
            u59.thumbstickFrame.Position = UDim2.new(0, -u61, 0.6, 0);

            return;
        end;

        u59.thumbstickFrame.Size = UDim2.new(0.4, u61, 0.6666666666666666, u61);
        u59.thumbstickFrame.Position = UDim2.new(0, -u61, 0.3333333333333333, 0);
    end;

    for i = 1, u2 do
        u59.middleImages[i] = Instance.new("ImageLabel");
        u59.middleImages[i].Name = "ThumbstickMiddle";
        u59.middleImages[i].Visible = false;
        u59.middleImages[i].BackgroundTransparency = 1;
        u59.middleImages[i].Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
        u59.middleImages[i].ImageRectOffset = Vector2.new(1, 1);
        u59.middleImages[i].ImageRectSize = Vector2.new(144, 144);
        u59.middleImages[i].ImageTransparency = u1[i];
        u59.middleImages[i].AnchorPoint = Vector2.new(0.5, 0.5);
        u59.middleImages[i].ZIndex = 9;
        u59.middleImages[i].Parent = u59.thumbstickFrame;
    end;

    local function ResizeThumbstick() -- Line: 466
        -- upvalues: u60 (copy), u4 (ref), u5 (ref), u7 (ref), u59 (copy), u61 (copy)
        local AbsoluteSize = u60.AbsoluteSize;
        local v63 = math.min(AbsoluteSize.X, AbsoluteSize.Y) > 500;

        if u4 then
            local v64 = u5 and (u7.isEnabled() and v63) and 1.6216216216216217 or (v63 and 2 or 1);
            u59.thumbstickSize = 45 * v64;
            u59.thumbstickRingSize = 20 * v64;
            u59.middleSize = 10 * v64;
            u59.middleSpacing = 14 * v64;
            u59.radiusOfDeadZone = 2 * v64;
            u59.radiusOfMaxSpeed = 20 * v64;
            local v65 = 74 * v64;

            if u7.isEnabled() then
                u59.startImage.Position = UDim2.new(0, v65 * 0.5 + u61 + (v63 and 100 or 64), 1, -v65 * 0.5 - u61 - (v63 and 112 or 64));
                u59.startImage.Size = UDim2.new(0, v65, 0, v65);
            else
                u59.startImage.Position = UDim2.new(0, u59.thumbstickRingSize * 3.3 + u61, 1, -u59.thumbstickRingSize * 2.8 - u61);
                u59.startImage.Size = UDim2.new(0, v65, 0, v65);
            end;
        else
            if v63 then
                u59.thumbstickSize = 90;
                u59.thumbstickRingSize = 40;
                u59.middleSize = 20;
                u59.middleSpacing = 28;
                u59.radiusOfDeadZone = 4;
                u59.radiusOfMaxSpeed = 40;
            else
                u59.thumbstickSize = 45;
                u59.thumbstickRingSize = 20;
                u59.middleSize = 10;
                u59.middleSpacing = 14;
                u59.radiusOfDeadZone = 2;
                u59.radiusOfMaxSpeed = 20;
            end;

            u59.startImage.Position = UDim2.new(0, u59.thumbstickRingSize * 3.3 + u61, 1, -u59.thumbstickRingSize * 2.8 - u61);
            u59.startImage.Size = UDim2.new(0, u59.thumbstickRingSize * 3.7, 0, u59.thumbstickRingSize * 3.7);
        end;

        u59.endImage.Position = u59.startImage.Position;
        u59.endImage.Size = UDim2.new(0, u59.thumbstickSize * 0.8, 0, u59.thumbstickSize * 0.8);
    end;

    ResizeThumbstick();
    u59.absoluteSizeChangedConn = u60:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeThumbstick);

    if u4 then
        u59.avatarAbilitiesEnabledChangedConn = u7.GetEnabledChangedSignal():Connect(ResizeThumbstick);
    end;

    local u66 = nil;

    local function onCurrentCameraChanged() -- Line: 534
        -- upvalues: u66 (ref), layoutThumbstickFrame (copy)
        if u66 then
            u66:Disconnect();
            u66 = nil;
        end;

        local CurrentCamera = workspace.CurrentCamera;

        if CurrentCamera then
            local function onViewportSizeChanged() -- Line: 541
                -- upvalues: CurrentCamera (copy), layoutThumbstickFrame (ref)
                local ViewportSize = CurrentCamera.ViewportSize;
                layoutThumbstickFrame(ViewportSize.X < ViewportSize.Y);
            end;

            u66 = CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(onViewportSizeChanged);
            local ViewportSize = CurrentCamera.ViewportSize;
            layoutThumbstickFrame(ViewportSize.X < ViewportSize.Y);
        end;
    end;

    workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(onCurrentCameraChanged);

    if workspace.CurrentCamera then
        onCurrentCameraChanged();
    end;

    u59.moveTouchStartPosition = nil;
    u59.startImageFadeTween = nil;
    u59.endImageFadeTween = nil;
    u59.middleImageFadeTweens = {};
    u59.onRenderSteppedConn = RunService.RenderStepped:Connect(function() -- Line: 561
        -- upvalues: u59 (copy)
        if u59.tweenInAlphaStart == nil then
            if u59.tweenOutAlphaStart ~= nil then
                local v67 = tick() - u59.tweenOutAlphaStart;
                local v68 = u59.fadeInAndOutHalfDuration * 2 - u59.fadeInAndOutHalfDuration * 2 * u59.fadeInAndOutBalance;
                u59.thumbstickFrame.BackgroundTransparency = math.min(v67 / v68, 1) * 0.35 + 0.65;

                if v68 < v67 then
                    u59.tweenOutAlphaStart = nil;
                end;
            end;
        else
            local v69 = tick() - u59.tweenInAlphaStart;
            local v70 = u59.fadeInAndOutHalfDuration * 2 * u59.fadeInAndOutBalance;
            u59.thumbstickFrame.BackgroundTransparency = 1 - math.min(v69 / v70, 1) * 0.35;

            if v70 < v69 then
                u59.tweenOutAlphaStart = tick();
                u59.tweenInAlphaStart = nil;
            end;
        end;
    end);
    u59.onTouchEndedConn = UserInputService.TouchEnded:connect(function(p71) -- Line: 580
        -- upvalues: u59 (copy)
        if p71 == u59.moveTouchObject then
            u59:OnInputEnded();
        end;
    end);
    GuiService.MenuOpened:connect(function() -- Line: 586
        -- upvalues: u59 (copy)
        if u59.moveTouchObject then
            u59:OnInputEnded();
        end;
    end);
    local u72 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    while not u72 do
        LocalPlayer.ChildAdded:wait();
        u72 = LocalPlayer:FindFirstChildOfClass("PlayerGui");
    end;

    local u73 = nil;
    local u74 = u72.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft and true or u72.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight;

    local function longShowBackground() -- Line: 602
        -- upvalues: u59 (copy)
        u59.fadeInAndOutHalfDuration = 2.5;
        u59.fadeInAndOutBalance = 0.05;
        u59.tweenInAlphaStart = tick();
    end;

    u73 = u72:GetPropertyChangedSignal("CurrentScreenOrientation"):Connect(function() -- Line: 608
        -- upvalues: u74 (copy), u72 (ref), u73 (ref), u59 (copy)
        if u74 and u72.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait or not u74 and u72.CurrentScreenOrientation ~= Enum.ScreenOrientation.Portrait then
            u73:disconnect();
            u59.fadeInAndOutHalfDuration = 2.5;
            u59.fadeInAndOutBalance = 0.05;
            u59.tweenInAlphaStart = tick();

            if u74 then
                u59.hasFadedBackgroundInPortrait = true;

                return;
            end;

            u59.hasFadedBackgroundInLandscape = true;
        end;
    end);
    u59.thumbstickFrame.Parent = u60;

    if game:IsLoaded() then
        u59.fadeInAndOutHalfDuration = 2.5;
        u59.fadeInAndOutBalance = 0.05;
        u59.tweenInAlphaStart = tick();
    else
        coroutine.wrap(function() -- Line: 628
            -- upvalues: u59 (copy)
            game.Loaded:Wait();
            u59.fadeInAndOutHalfDuration = 2.5;
            u59.fadeInAndOutBalance = 0.05;
            u59.tweenInAlphaStart = tick();
        end)();
    end;
end;

return u8;