--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AvatarAbilitiesInterface
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule.AvatarAbilitiesInterface
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:10 2026
]]

-- Decompiled with Potassium's decompiler.

local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");

if require(CommonUtils:WaitForChild("FlagUtil")).getUserFlag("UserAllowAbilityControls") then
    local Players = game:GetService("Players");
    local v1 = {};
    local u2 = nil;
    local u3 = nil;
    local BindableEvent = Instance.new("BindableEvent");
    local u4 = nil;
    local u5 = false;

    local function characterAdded(p6) -- Line: 16
        -- upvalues: u2 (ref), u3 (ref), u4 (ref), BindableEvent (copy)
        u2 = nil;
        u3 = nil;

        if u4 then
            u4:Disconnect();
            u4 = nil;
        end;

        if p6 then
            u2 = p6:FindFirstChild("AbilityManagerActor");
            u3 = p6:FindFirstChildOfClass("Humanoid");

            while not u3 do
                p6.ChildAdded:wait();
                u3 = p6:FindFirstChildOfClass("Humanoid");
            end;

            BindableEvent:Fire();
            u4 = u3:GetPropertyChangedSignal("EvaluateStateMachine"):Connect(function() -- Line: 33
                -- upvalues: BindableEvent (ref)
                BindableEvent:Fire();
            end);
        end;
    end;

    local function lazyInit() -- Line: 39
        -- upvalues: u5 (ref), Players (copy), characterAdded (copy)
        if u5 then
            return;
        end;

        u5 = true;
        local LocalPlayer = Players.LocalPlayer;

        if LocalPlayer then
            LocalPlayer.characterAdded:Connect(characterAdded);

            if LocalPlayer.Character then
                characterAdded(LocalPlayer.Character);
            end;
        end;
    end;

    function v1.isEnabled() -- Line: 54
        -- upvalues: u5 (ref), Players (copy), characterAdded (copy), u2 (ref), u3 (ref)
        if not u5 then
            u5 = true;
            local LocalPlayer = Players.LocalPlayer;

            if LocalPlayer then
                LocalPlayer.characterAdded:Connect(characterAdded);

                if LocalPlayer.Character then
                    characterAdded(LocalPlayer.Character);
                end;
            end;
        end;

        local v7;

        if u2 == nil then
            v7 = false;
        else
            v7 = u3 and not u3.EvaluateStateMachine;
        end;

        return v7;
    end;

    function v1.GetEnabledChangedSignal() -- Line: 59
        -- upvalues: u5 (ref), Players (copy), characterAdded (copy), BindableEvent (copy)
        if not u5 then
            u5 = true;
            local LocalPlayer = Players.LocalPlayer;

            if LocalPlayer then
                LocalPlayer.characterAdded:Connect(characterAdded);

                if LocalPlayer.Character then
                    characterAdded(LocalPlayer.Character);
                end;
            end;
        end;

        return BindableEvent.Event;
    end;

    return v1;
end;