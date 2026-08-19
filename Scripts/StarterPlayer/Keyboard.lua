--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Keyboard
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule.Keyboard
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:30 2026
]]

-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local ContextActionService = game:GetService("ContextActionService");
script.Parent.Parent:WaitForChild("CommonUtils");
local u1 = Vector3.new();
local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"));
local u2 = setmetatable({}, BaseCharacterController);
u2.__index = u2;

function u2.new(p3) -- Line: 22
    -- upvalues: BaseCharacterController (copy), u2 (copy)
    local v4 = BaseCharacterController.new();
    local v5 = setmetatable(v4, u2);
    v5.CONTROL_ACTION_PRIORITY = p3;
    v5.forwardValue = 0;
    v5.backwardValue = 0;
    v5.leftValue = 0;
    v5.rightValue = 0;
    v5.jumpEnabled = true;

    return v5;
end;

function u2.Enable(p6, p7) -- Line: 37
    -- upvalues: u1 (copy)
    if p7 == p6.enabled then
        return true;
    end;

    p6.forwardValue = 0;
    p6.backwardValue = 0;
    p6.leftValue = 0;
    p6.rightValue = 0;
    p6.moveVector = u1;
    p6.jumpRequested = false;
    p6:UpdateJump();

    if p7 then
        p6:BindContextActions();
        p6:ConnectFocusEventListeners();
    else
        p6._connectionUtil:disconnectAll();
    end;

    p6.enabled = p7;

    return true;
end;

function u2.UpdateMovement(p8, p9) -- Line: 64
    -- upvalues: u1 (copy)
    if p9 == Enum.UserInputState.Cancel then
        p8.moveVector = u1;

        return;
    end;

    p8.moveVector = Vector3.new(p8.leftValue + p8.rightValue, 0, p8.forwardValue + p8.backwardValue);
end;

function u2.UpdateJump(p10) -- Line: 72
    p10.isJumping = p10.jumpRequested;
end;

function u2.BindContextActions(u11) -- Line: 76
    -- upvalues: ContextActionService (copy)
    ContextActionService:BindActionAtPriority("moveForwardAction", function(p12, p13, p14) -- Line: 82
        -- upvalues: u11 (copy)
        u11.forwardValue = p13 == Enum.UserInputState.Begin and -1 or 0;
        u11:UpdateMovement(p13);

        return Enum.ContextActionResult.Pass;
    end, false, u11.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterForward);
    ContextActionService:BindActionAtPriority("moveBackwardAction", function(p15, p16, p17) -- Line: 88
        -- upvalues: u11 (copy)
        u11.backwardValue = p16 == Enum.UserInputState.Begin and 1 or 0;
        u11:UpdateMovement(p16);

        return Enum.ContextActionResult.Pass;
    end, false, u11.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterBackward);
    ContextActionService:BindActionAtPriority("moveLeftAction", function(p18, p19, p20) -- Line: 94
        -- upvalues: u11 (copy)
        u11.leftValue = p19 == Enum.UserInputState.Begin and -1 or 0;
        u11:UpdateMovement(p19);

        return Enum.ContextActionResult.Pass;
    end, false, u11.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterLeft);
    ContextActionService:BindActionAtPriority("moveRightAction", function(p21, p22, p23) -- Line: 100
        -- upvalues: u11 (copy)
        u11.rightValue = p22 == Enum.UserInputState.Begin and 1 or 0;
        u11:UpdateMovement(p22);

        return Enum.ContextActionResult.Pass;
    end, false, u11.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterRight);
    ContextActionService:BindActionAtPriority("jumpAction", function(p24, p25, p26) -- Line: 106
        -- upvalues: u11 (copy)
        u11.jumpRequested = u11.jumpEnabled and p25 == Enum.UserInputState.Begin;
        u11:UpdateJump();

        return Enum.ContextActionResult.Pass;
    end, false, u11.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterJump);
    u11._connectionUtil:trackBoundFunction("moveForwardAction", function() -- Line: 125
        -- upvalues: ContextActionService (ref)
        ContextActionService:UnbindAction("moveForwardAction");
    end);
    u11._connectionUtil:trackBoundFunction("moveBackwardAction", function() -- Line: 126
        -- upvalues: ContextActionService (ref)
        ContextActionService:UnbindAction("moveBackwardAction");
    end);
    u11._connectionUtil:trackBoundFunction("moveLeftAction", function() -- Line: 127
        -- upvalues: ContextActionService (ref)
        ContextActionService:UnbindAction("moveLeftAction");
    end);
    u11._connectionUtil:trackBoundFunction("moveRightAction", function() -- Line: 128
        -- upvalues: ContextActionService (ref)
        ContextActionService:UnbindAction("moveRightAction");
    end);
    u11._connectionUtil:trackBoundFunction("jumpAction", function() -- Line: 129
        -- upvalues: ContextActionService (ref)
        ContextActionService:UnbindAction("jumpAction");
    end);
end;

function u2.ConnectFocusEventListeners(u27) -- Line: 132
    -- upvalues: u1 (copy), UserInputService (copy)
    local function onFocusReleased() -- Line: 133
        -- upvalues: u27 (copy), u1 (ref)
        u27.moveVector = u1;
        u27.forwardValue = 0;
        u27.backwardValue = 0;
        u27.leftValue = 0;
        u27.rightValue = 0;
        u27.jumpRequested = false;
        u27:UpdateJump();
    end;

    u27._connectionUtil:trackConnection("textBoxFocusReleased", UserInputService.TextBoxFocusReleased:Connect(onFocusReleased));
    u27._connectionUtil:trackConnection("textBoxFocused", UserInputService.TextBoxFocused:Connect(function(p28) -- Line: 143, Name: onTextFocusGained
        -- upvalues: u27 (copy)
        u27.jumpRequested = false;
        u27:UpdateJump();
    end));
    u27._connectionUtil:trackConnection("windowFocusReleased", UserInputService.WindowFocused:Connect(onFocusReleased));
end;

return u2;