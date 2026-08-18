--[[
  Type:     LocalScript
  Method:   decompile
  Name:     ProximityPromptScript
  Path:     game.StarterPlayer.StarterPlayerScripts.ProximityPromptScript
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:09 2026
]]

-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local ProximityPromptService = game:GetService("ProximityPromptService");
local TweenService = game:GetService("TweenService");
local TextService = game:GetService("TextService");
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
local u1 = {
    [Enum.KeyCode.ButtonX] = "rbxasset://textures/ui/Controls/xboxX.png",
    [Enum.KeyCode.ButtonY] = "rbxasset://textures/ui/Controls/xboxY.png",
    [Enum.KeyCode.ButtonA] = "rbxasset://textures/ui/Controls/xboxA.png",
    [Enum.KeyCode.ButtonB] = "rbxasset://textures/ui/Controls/xboxB.png",
    [Enum.KeyCode.DPadLeft] = "rbxasset://textures/ui/Controls/dpadLeft.png",
    [Enum.KeyCode.DPadRight] = "rbxasset://textures/ui/Controls/dpadRight.png",
    [Enum.KeyCode.DPadUp] = "rbxasset://textures/ui/Controls/dpadUp.png",
    [Enum.KeyCode.DPadDown] = "rbxasset://textures/ui/Controls/dpadDown.png",
    [Enum.KeyCode.ButtonSelect] = "rbxasset://textures/ui/Controls/xboxmenu.png",
    [Enum.KeyCode.ButtonL1] = "rbxasset://textures/ui/Controls/xboxLS.png",
    [Enum.KeyCode.ButtonR1] = "rbxasset://textures/ui/Controls/xboxRS.png"
};
local u2 = {
    [Enum.KeyCode.Backspace] = "rbxasset://textures/ui/Controls/backspace.png",
    [Enum.KeyCode.Return] = "rbxasset://textures/ui/Controls/return.png",
    [Enum.KeyCode.LeftShift] = "rbxasset://textures/ui/Controls/shift.png",
    [Enum.KeyCode.RightShift] = "rbxasset://textures/ui/Controls/shift.png",
    [Enum.KeyCode.Tab] = "rbxasset://textures/ui/Controls/tab.png"
};
local u3 = {
    ["\'"] = "rbxasset://textures/ui/Controls/apostrophe.png",
    [","] = "rbxasset://textures/ui/Controls/comma.png",
    ["`"] = "rbxasset://textures/ui/Controls/graveaccent.png",
    ["."] = "rbxasset://textures/ui/Controls/period.png",
    [" "] = "rbxasset://textures/ui/Controls/spacebar.png"
};
local u4 = {
    [Enum.KeyCode.LeftControl] = "Ctrl",
    [Enum.KeyCode.RightControl] = "Ctrl",
    [Enum.KeyCode.LeftAlt] = "Alt",
    [Enum.KeyCode.RightAlt] = "Alt",
    [Enum.KeyCode.F1] = "F1",
    [Enum.KeyCode.F2] = "F2",
    [Enum.KeyCode.F3] = "F3",
    [Enum.KeyCode.F4] = "F4",
    [Enum.KeyCode.F5] = "F5",
    [Enum.KeyCode.F6] = "F6",
    [Enum.KeyCode.F7] = "F7",
    [Enum.KeyCode.F8] = "F8",
    [Enum.KeyCode.F9] = "F9",
    [Enum.KeyCode.F10] = "F10",
    [Enum.KeyCode.F11] = "F11",
    [Enum.KeyCode.F12] = "F12"
};

local function getScreenGui() -- Line: 60
    -- upvalues: PlayerGui (copy)
    local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts");

    if ProximityPrompts == nil then
        ProximityPrompts = Instance.new("ScreenGui");
        ProximityPrompts.Name = "ProximityPrompts";
        ProximityPrompts.ResetOnSpawn = false;
        ProximityPrompts.Parent = PlayerGui;
    end;

    return ProximityPrompts;
end;

local function setUpCircularProgressBar(p5) -- Line: 71
    local UIGradient = p5.LeftGradient.ProgressBarImage.UIGradient;
    local UIGradient2 = p5.RightGradient.ProgressBarImage.UIGradient;
    p5.Progress.Changed:Connect(function(p6) -- Line: 76
        -- upvalues: UIGradient (copy), UIGradient2 (copy)
        local v7 = math.clamp(p6 * 360, 0, 360);
        UIGradient.Rotation = math.clamp(v7, 180, 360);
        UIGradient2.Rotation = math.clamp(v7, 0, 180);
    end);
end;

local function createPrompt(u8, p9, p10) -- Line: 83
    -- upvalues: TweenService (copy), u1 (copy), UserInputService (copy), u2 (copy), u3 (copy), u4 (copy), TextService (copy)
    local u11 = {};
    local u12 = {};
    local u13 = {};
    local u14 = {};
    local v15 = TweenInfo.new(u8.HoldDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
    TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local u16 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local u17 = TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
    local v18 = TweenInfo.new(0, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
    local u19 = nil;
    local v20 = u8:GetAttribute("Theme");

    if v20 then
        local v21 = script:FindFirstChild(v20);

        if v21 then
            u19 = v21:Clone();
        end;
    end;

    if u19 == nil then
        u19 = script.Default:Clone();
    end;

    u19.Enabled = true;
    local PromptFrame = u19.PromptFrame;
    local InputFrame = PromptFrame.InputFrame;
    local ActionText = PromptFrame.ActionText;
    local ObjectText = PromptFrame.ObjectText;
    local BackgroundTransparency = PromptFrame.BackgroundTransparency;
    local ImageTransparency = PromptFrame.ImageTransparency;
    PromptFrame.BackgroundTransparency = 1;
    PromptFrame.ImageTransparency = 1;
    local v22 = {
        BackgroundTransparency = 1,
        ImageTransparency = 1,
        Size = UDim2.fromScale(0.5, 1)
    };
    table.insert(u11, TweenService:Create(PromptFrame, u16, v22));
    local v23 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = BackgroundTransparency,
        ImageTransparency = ImageTransparency
    };
    table.insert(u12, TweenService:Create(PromptFrame, u16, v23));
    local v24 = {
        BackgroundTransparency = 1,
        ImageTransparency = 1,
        Size = UDim2.fromScale(0.5, 1)
    };
    table.insert(u13, TweenService:Create(PromptFrame, u16, v24));
    local v25 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = BackgroundTransparency,
        ImageTransparency = ImageTransparency
    };
    table.insert(u14, TweenService:Create(PromptFrame, u16, v25));

    local function setupUIStrokeTweens(p26) -- Line: 126
        -- upvalues: u11 (copy), TweenService (ref), u16 (copy), u12 (copy), u13 (copy), u14 (copy)
        local Transparency = p26.Transparency;
        p26.Transparency = 1;
        table.insert(u11, TweenService:Create(p26, u16, {
            Transparency = 1
        }));
        table.insert(u12, TweenService:Create(p26, u16, {
            Transparency = Transparency
        }));
        table.insert(u13, TweenService:Create(p26, u16, {
            Transparency = 1
        }));
        table.insert(u14, TweenService:Create(p26, u16, {
            Transparency = Transparency
        }));
    end;

    local function setupGUIObjectTweens(p27) -- Line: 135
        -- upvalues: u11 (copy), TweenService (ref), u16 (copy), u12 (copy), u13 (copy), u14 (copy)
        local BackgroundTransparency2 = p27.BackgroundTransparency;
        p27.BackgroundTransparency = 1;
        table.insert(u11, TweenService:Create(p27, u16, {
            BackgroundTransparency = 1
        }));
        table.insert(u12, TweenService:Create(p27, u16, {
            BackgroundTransparency = BackgroundTransparency2
        }));
        table.insert(u13, TweenService:Create(p27, u16, {
            BackgroundTransparency = 1
        }));
        table.insert(u14, TweenService:Create(p27, u16, {
            BackgroundTransparency = BackgroundTransparency2
        }));
    end;

    local function setupTextLabelTweens(p28) -- Line: 144
        -- upvalues: u11 (copy), TweenService (ref), u16 (copy), u12 (copy), u13 (copy), u14 (copy)
        local TextTransparency = p28.TextTransparency;
        local TextStrokeTransparency = p28.TextStrokeTransparency;
        p28.TextTransparency = 1;
        p28.TextStrokeTransparency = 1;
        table.insert(u11, TweenService:Create(p28, u16, {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }));
        table.insert(u12, TweenService:Create(p28, u16, {
            TextTransparency = TextTransparency,
            TextStrokeTransparency = TextStrokeTransparency
        }));
        table.insert(u13, TweenService:Create(p28, u16, {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }));
        table.insert(u14, TweenService:Create(p28, u16, {
            TextTransparency = TextTransparency,
            TextStrokeTransparency = TextStrokeTransparency
        }));
    end;

    local function setupImageLabelTweens(p29) -- Line: 155
        -- upvalues: u11 (copy), TweenService (ref), u16 (copy), u12 (copy), u13 (copy), u14 (copy)
        local ImageTransparency2 = p29.ImageTransparency;
        p29.ImageTransparency = 1;
        table.insert(u11, TweenService:Create(p29, u16, {
            ImageTransparency = 1
        }));
        table.insert(u12, TweenService:Create(p29, u16, {
            ImageTransparency = ImageTransparency2
        }));
        table.insert(u13, TweenService:Create(p29, u16, {
            ImageTransparency = 1
        }));
        table.insert(u14, TweenService:Create(p29, u16, {
            ImageTransparency = ImageTransparency2
        }));
    end;

    local function setupUnexpectedChildTweens(p30) -- Line: 164
        -- upvalues: setupUIStrokeTweens (copy), setupGUIObjectTweens (copy), setupTextLabelTweens (copy), setupImageLabelTweens (copy), setupUnexpectedChildTweens (copy)
        if p30:IsA("UIStroke") then
            setupUIStrokeTweens(p30);
        elseif not p30:IsA("UIGradient") and p30:IsA("GuiObject") then
            setupGUIObjectTweens(p30);

            if p30:IsA("TextLabel") then
                setupTextLabelTweens(p30);
            elseif p30:IsA("ImageLabel") then
                setupImageLabelTweens(p30);
            end;
        end;

        for _, child in pairs(p30:GetChildren()) do
            setupUnexpectedChildTweens(child);
        end;
    end;

    local v31 = {
        [InputFrame] = false,
        [ActionText] = true,
        [ObjectText] = true
    };

    for _, child in pairs(PromptFrame:GetChildren()) do
        if v31[child] == nil then
            setupUnexpectedChildTweens(child);
        elseif v31[child] == true then
            for _, child2 in pairs(child:GetChildren()) do
                setupUnexpectedChildTweens(child2);
            end;
        end;
    end;

    local Frame = InputFrame.Frame;
    local UIScale = Frame.UIScale;
    table.insert(u11, TweenService:Create(UIScale, u16, {
        Scale = p9 == Enum.ProximityPromptInputType.Touch and 1.6 or 1.33
    }));
    table.insert(u12, TweenService:Create(UIScale, u16, {
        Scale = 1
    }));
    setupTextLabelTweens(ActionText);
    setupTextLabelTweens(ObjectText);
    local ButtonFrame = Frame.ButtonFrame;
    (function() -- Line: 211, Name: setupButtonFrameTweens
        -- upvalues: ButtonFrame (copy), u13 (copy), TweenService (ref), u17 (copy), u14 (copy)
        local BackgroundTransparency2 = ButtonFrame.BackgroundTransparency;
        local ImageTransparency2 = ButtonFrame.ImageTransparency;
        table.insert(u13, TweenService:Create(ButtonFrame, u17, {
            BackgroundTransparency = 1,
            ImageTransparency = 1
        }));
        table.insert(u14, TweenService:Create(ButtonFrame, u17, {
            BackgroundTransparency = BackgroundTransparency2,
            ImageTransparency = ImageTransparency2
        }));

        for _, v in pairs(ButtonFrame:getChildren()) do
            if v:IsA("UIStroke") then
                local Transparency = v.Transparency;
                table.insert(u13, TweenService:Create(v, u17, {
                    Transparency = 1
                }));
                table.insert(u14, TweenService:Create(v, u17, {
                    Transparency = Transparency
                }));
            end;
        end;
    end)();
    local ButtonImage = Frame.ButtonImage;
    local ButtonText = Frame.ButtonText;
    local ButtonTextImage = Frame.ButtonTextImage;

    local function setupButtonTextTweens() -- Line: 233
        -- upvalues: ButtonText (copy), u13 (copy), TweenService (ref), u17 (copy), u14 (copy)
        local TextTransparency = ButtonText.TextTransparency;
        local TextStrokeTransparency = ButtonText.TextStrokeTransparency;
        local BackgroundTransparency2 = ButtonText.BackgroundTransparency;
        ButtonText.BackgroundTransparency = 1;
        ButtonText.TextStrokeTransparency = 1;
        ButtonText.TextTransparency = 1;
        table.insert(u13, TweenService:Create(ButtonText, u17, {
            TextTransparency = 1,
            TextStrokeTransparency = 1,
            BackgroundTransparency = 1
        }));
        table.insert(u14, TweenService:Create(ButtonText, u17, {
            TextTransparency = TextTransparency,
            TextStrokeTransparency = TextStrokeTransparency,
            BackgroundTransparency = BackgroundTransparency2
        }));

        for _, v in pairs(ButtonText:getChildren()) do
            if v:IsA("UIStroke") then
                local Transparency = v.Transparency;
                table.insert(u13, TweenService:Create(v, u17, {
                    Transparency = 1
                }));
                table.insert(u14, TweenService:Create(v, u17, {
                    Transparency = Transparency
                }));
            end;
        end;
    end;

    local function setupButtonImageTweens() -- Line: 253
        -- upvalues: ButtonImage (copy), u13 (copy), TweenService (ref), u17 (copy), u14 (copy)
        local ImageTransparency2 = ButtonImage.ImageTransparency;
        local BackgroundTransparency2 = ButtonImage.BackgroundTransparency;
        ButtonImage.BackgroundTransparency = 1;
        ButtonImage.ImageTransparency = 1;
        table.insert(u13, TweenService:Create(ButtonImage, u17, {
            ImageTransparency = 1,
            BackgroundTransparency = 1
        }));
        table.insert(u14, TweenService:Create(ButtonImage, u17, {
            ImageTransparency = ImageTransparency2,
            BackgroundTransparency = BackgroundTransparency2
        }));
    end;

    local function setupIconTweens() -- Line: 262
        -- upvalues: ButtonTextImage (copy), u13 (copy), TweenService (ref), u17 (copy), u14 (copy)
        local BackgroundTransparency2 = ButtonTextImage.BackgroundTransparency;
        local ImageTransparency2 = ButtonTextImage.ImageTransparency;
        ButtonTextImage.BackgroundTransparency = 1;
        ButtonTextImage.ImageTransparency = 1;
        table.insert(u13, TweenService:Create(ButtonTextImage, u17, {
            ImageTransparency = 1,
            BackgroundTransparency = 1
        }));
        table.insert(u14, TweenService:Create(ButtonTextImage, u17, {
            ImageTransparency = ImageTransparency2,
            BackgroundTransparency = BackgroundTransparency2
        }));
    end;

    if p9 == Enum.ProximityPromptInputType.Gamepad then
        if u1[u8.GamepadKeyCode] then
            setupIconTweens();
            ButtonTextImage.Image = u1[u8.GamepadKeyCode];
            ButtonText.Visible = false;
            ButtonImage.Visible = false;
            ButtonTextImage.Visible = true;
        end;
    elseif p9 == Enum.ProximityPromptInputType.Touch then
        setupButtonImageTweens();
        ButtonImage.Image = "rbxasset://textures/ui/Controls/TouchTapIcon.png";
        ButtonText.Visible = false;
        ButtonTextImage.Visible = false;
        ButtonImage.Visible = true;
    else
        setupButtonImageTweens();
        ButtonImage.Visible = true;
        local v32 = UserInputService:GetStringForKeyCode(u8.KeyboardKeyCode);
        local v33 = u2[u8.KeyboardKeyCode];

        if v33 == nil then
            v33 = u3[v32];
        end;

        if v33 == nil then
            v32 = u4[u8.KeyboardKeyCode] or v32;
        end;

        if v33 then
            setupIconTweens();
            ButtonTextImage.Image = v33;
            ButtonText.Visible = false;
            ButtonTextImage.Visible = true;
        elseif v32 == nil or v32 == "" then
            error("ProximityPrompt \'" .. u8.Name .. "\' has an unsupported keycode for rendering UI: " .. tostring(u8.KeyboardKeyCode));
        else
            if string.len(v32) > 2 then
                ButtonText.TextSize = math.round(ButtonText.TextSize * 6 / 7);
            end;

            setupButtonTextTweens();
            ButtonText.Text = v32;
            ButtonTextImage.Visible = false;
            ButtonText.Visible = true;
        end;
    end;

    if p9 == Enum.ProximityPromptInputType.Touch or u8.ClickablePrompt then
        local TextButton = u19.TextButton;
        local u34 = false;
        TextButton.InputBegan:Connect(function(p35) -- Line: 336
            -- upvalues: u8 (copy), u34 (ref)
            if (p35.UserInputType == Enum.UserInputType.Touch or p35.UserInputType == Enum.UserInputType.MouseButton1) and p35.UserInputState ~= Enum.UserInputState.Change then
                u8:InputHoldBegin();
                u34 = true;
            end;
        end);
        TextButton.InputEnded:Connect(function(p36) -- Line: 343
            -- upvalues: u34 (ref), u8 (copy)
            if (p36.UserInputType == Enum.UserInputType.Touch or p36.UserInputType == Enum.UserInputType.MouseButton1) and u34 then
                u34 = false;
                u8:InputHoldEnd();
            end;
        end);
        u19.Active = true;
    end;

    if u8.HoldDuration > 0 then
        local ProgressBar = Frame.ProgressBar;
        local UIGradient = ProgressBar.LeftGradient.ProgressBarImage.UIGradient;
        local UIGradient2 = ProgressBar.RightGradient.ProgressBarImage.UIGradient;
        ProgressBar.Progress.Changed:Connect(function(p37) -- Line: 76
            -- upvalues: UIGradient (copy), UIGradient2 (copy)
            local v38 = math.clamp(p37 * 360, 0, 360);
            UIGradient.Rotation = math.clamp(v38, 180, 360);
            UIGradient2.Rotation = math.clamp(v38, 0, 180);
        end);
        table.insert(u11, TweenService:Create(ProgressBar.Progress, v15, {
            Value = 1
        }));
        table.insert(u12, TweenService:Create(ProgressBar.Progress, v18, {
            Value = 0
        }));
    end;

    local u39, u40;

    if u8.HoldDuration > 0 then
        u39 = u8.PromptButtonHoldBegan:Connect(function() -- Line: 368
            -- upvalues: u11 (copy)
            for _, v in ipairs(u11) do
                v:Play();
            end;
        end);
        u40 = u8.PromptButtonHoldEnded:Connect(function() -- Line: 374
            -- upvalues: u12 (copy)
            for _, v in ipairs(u12) do
                v:Play();
            end;
        end);
    else
        u39 = nil;
        u40 = nil;
    end;

    local u41 = u8.Triggered:Connect(function() -- Line: 381
        -- upvalues: u13 (copy)
        for _, v in ipairs(u13) do
            v:Play();
        end;
    end);
    local u42 = u8.TriggerEnded:Connect(function() -- Line: 387
        -- upvalues: u14 (copy)
        for _, v in ipairs(u14) do
            v:Play();
        end;
    end);

    local function updateUIFromPrompt() -- Line: 393
        -- upvalues: u8 (copy), ActionText (copy), TextService (ref), ObjectText (copy), u19 (ref)
        local GetTextBoundsParams = Instance.new("GetTextBoundsParams");
        GetTextBoundsParams.Text = u8.ActionText;
        GetTextBoundsParams.Font = ActionText.FontFace;
        GetTextBoundsParams.Size = ActionText.TextSize;
        GetTextBoundsParams.Width = 1000;
        local v43 = TextService:GetTextBoundsAsync(GetTextBoundsParams);
        local GetTextBoundsParams2 = Instance.new("GetTextBoundsParams");
        GetTextBoundsParams2.Text = u8.ObjectText;
        GetTextBoundsParams2.Font = ObjectText.FontFace;
        GetTextBoundsParams2.Size = ObjectText.TextSize;
        GetTextBoundsParams2.Width = 1000;
        local v44 = TextService:GetTextBoundsAsync(GetTextBoundsParams2);
        local v45 = math.max(v43.X, v44.X);
        local v46 = (u8.ActionText == nil or u8.ActionText == "") and (u8.ObjectText == nil or u8.ObjectText == "") and 72 or v45 + 72 + 24;
        ActionText.Position = UDim2.new(0.5, 72 - v46 / 2, 0, (u8.ObjectText == nil or u8.ObjectText == "") and 0 or 9);
        ObjectText.Position = UDim2.new(0.5, 72 - v46 / 2, 0, -10);
        ActionText.Text = u8.ActionText;
        ObjectText.Text = u8.ObjectText;
        ActionText.AutoLocalize = u8.AutoLocalize;
        ActionText.RootLocalizationTable = u8.RootLocalizationTable;
        ObjectText.AutoLocalize = u8.AutoLocalize;
        ObjectText.RootLocalizationTable = u8.RootLocalizationTable;
        u19.Size = UDim2.fromOffset(v46, 72);
        u19.SizeOffset = Vector2.new(u8.UIOffset.X / u19.Size.Width.Offset, u8.UIOffset.Y / u19.Size.Height.Offset);
    end;

    local u47 = u8.Changed:Connect(updateUIFromPrompt);
    updateUIFromPrompt();
    u19.Adornee = u8.Parent;
    u19.Parent = p10;

    for _, v in ipairs(u14) do
        v:Play();
    end;

    local u48 = nil;
    local u49 = nil;

    local function cleanup() -- Line: 450
        -- upvalues: u39 (ref), u40 (ref), u48 (ref), u49 (ref), u41 (ref), u42 (ref), u47 (copy), u13 (copy), u19 (ref)
        if u39 then
            u39:Disconnect();
        end;

        if u40 then
            u40:Disconnect();
        end;

        if u48 then
            u48:Disconnect();
        end;

        if u49 then
            u49:Disconnect();
        end;

        u41:Disconnect();
        u42:Disconnect();
        u47:Disconnect();

        for _, v in ipairs(u13) do
            v:Play();
        end;

        wait(0.2);
        u19.Parent = nil;
    end;

    u48 = u8.Destroying:Once(function() -- Line: 478
        -- upvalues: cleanup (copy)
        cleanup();
    end);
    u49 = u8.PromptHidden:Once(function() -- Line: 482
        -- upvalues: cleanup (copy)
        cleanup();
    end);
end;

local function onLoad() -- Line: 487
    -- upvalues: ProximityPromptService (copy), PlayerGui (copy), createPrompt (copy)
    ProximityPromptService.PromptShown:Connect(function(p50, p51) -- Line: 488
        -- upvalues: PlayerGui (ref), createPrompt (ref)
        if p50.Style == Enum.ProximityPromptStyle.Default then
            return;
        end;

        local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts");

        if ProximityPrompts == nil then
            ProximityPrompts = Instance.new("ScreenGui");
            ProximityPrompts.Name = "ProximityPrompts";
            ProximityPrompts.ResetOnSpawn = false;
            ProximityPrompts.Parent = PlayerGui;
        end;

        createPrompt(p50, p51, ProximityPrompts);
    end);
end;

ProximityPromptService.PromptShown:Connect(function(p52, p53) -- Line: 488
    -- upvalues: PlayerGui (copy), createPrompt (copy)
    if p52.Style == Enum.ProximityPromptStyle.Default then
        return;
    end;

    local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts");

    if ProximityPrompts == nil then
        ProximityPrompts = Instance.new("ScreenGui");
        ProximityPrompts.Name = "ProximityPrompts";
        ProximityPrompts.ResetOnSpawn = false;
        ProximityPrompts.Parent = PlayerGui;
    end;

    createPrompt(p52, p53, ProximityPrompts);
end);