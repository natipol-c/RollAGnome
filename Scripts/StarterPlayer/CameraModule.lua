--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CameraModule
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:29 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local u2 = { "CameraMinZoomDistance", "CameraMaxZoomDistance", "CameraMode", "DevCameraOcclusionMode", "DevComputerCameraMode", "DevTouchCameraMode", "DevComputerMovementMode", "DevTouchMovementMode", "DevEnableMouseLock" };
local u3 = { "ComputerCameraMovementMode", "ComputerMovementMode", "ControlMode", "GamepadCameraSensitivity", "MouseSensitivity", "RotationType", "TouchCameraMovementMode", "TouchMovementMode" };
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local VRService = game:GetService("VRService");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local CommonUtils = script.Parent:WaitForChild("CommonUtils");
local ConnectionUtil = require(CommonUtils:WaitForChild("ConnectionUtil"));
local FlagUtil = require(CommonUtils:WaitForChild("FlagUtil"));
local CameraUtils = require(script:WaitForChild("CameraUtils"));
local CameraInput = require(script:WaitForChild("CameraInput"));
local ClassicCamera = require(script:WaitForChild("ClassicCamera"));
local OrbitalCamera = require(script:WaitForChild("OrbitalCamera"));
local LegacyCamera = require(script:WaitForChild("LegacyCamera"));
local VehicleCamera = require(script:WaitForChild("VehicleCamera"));
local VRCamera = require(script:WaitForChild("VRCamera"));
local VRVehicleCamera = require(script:WaitForChild("VRVehicleCamera"));
local Invisicam = require(script:WaitForChild("Invisicam"));
local Poppercam = require(script:WaitForChild("Poppercam"));
local TransparencyController = require(script:WaitForChild("TransparencyController"));
local MouseLockController = require(script:WaitForChild("MouseLockController"));
local u4 = {};
local u5 = {};

if not Players.LocalPlayer then
    return {};
end;

assert(Players.LocalPlayer, "Strict typing check");
local PlayerScripts = Players.LocalPlayer:WaitForChild("PlayerScripts");
PlayerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Default);
PlayerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Follow);
PlayerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Classic);
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Default);
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Follow);
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Classic);
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.CameraToggle);
local u6 = FlagUtil.getUserFlag("UserPlayerConnectionMemoryLeak");
local u7 = FlagUtil.getUserFlag("UserPSFixCameraControllerReset");

function u1.new() -- Line: 144
    -- upvalues: TransparencyController (copy), u6 (copy), ConnectionUtil (copy), u1 (copy), Players (copy), MouseLockController (copy), RunService (copy), u2 (copy), u3 (copy), UserGameSettings (copy), UserInputService (copy)
    local v8 = {
        activeTransparencyController = TransparencyController.new()
    };
    local v9;

    if u6 then
        v9 = ConnectionUtil.new();
    else
        v9 = nil;
    end;

    v8.connectionUtil = v9;
    local u10 = setmetatable(v8, u1);
    u10.activeCameraController = nil;
    u10.activeOcclusionModule = nil;
    u10.activeMouseLockController = nil;
    u10.currentComputerCameraMovementMode = nil;
    u10.cameraSubjectChangedConn = nil;
    u10.cameraTypeChangedConn = nil;

    for _, v in pairs(Players:GetPlayers()) do
        u10:OnPlayerAdded(v);
    end;

    Players.PlayerAdded:Connect(function(p11) -- Line: 167
        -- upvalues: u10 (copy)
        u10:OnPlayerAdded(p11);
    end);

    if u6 then
        Players.PlayerRemoving:Connect(function(p12) -- Line: 172
            -- upvalues: u10 (copy)
            u10:OnPlayerRemoving(p12);
        end);
    end;

    u10.activeTransparencyController:Enable(true);
    u10.activeMouseLockController = MouseLockController.new();
    assert(u10.activeMouseLockController, "Strict typing check");
    local v13 = u10.activeMouseLockController:GetBindableToggleEvent();

    if v13 then
        v13:Connect(function() -- Line: 184
            -- upvalues: u10 (copy)
            u10:OnMouseLockToggled();
        end);
    end;

    u10:ActivateCameraController();
    u10:ActivateOcclusionModule(Players.LocalPlayer.DevCameraOcclusionMode);
    u10:OnCurrentCameraChanged();
    RunService:BindToRenderStep("cameraRenderUpdate", Enum.RenderPriority.Camera.Value, function(p14) -- Line: 192
        -- upvalues: u10 (copy)
        u10:Update(p14);
    end);

    for _, v in pairs(u2) do
        Players.LocalPlayer:GetPropertyChangedSignal(v):Connect(function() -- Line: 196
            -- upvalues: u10 (copy), v (copy)
            u10:OnLocalPlayerCameraPropertyChanged(v);
        end);
    end;

    for _, v in pairs(u3) do
        UserGameSettings:GetPropertyChangedSignal(v):Connect(function() -- Line: 202
            -- upvalues: u10 (copy), v (copy)
            u10:OnUserGameSettingsPropertyChanged(v);
        end);
    end;

    game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 206
        -- upvalues: u10 (copy)
        u10:OnCurrentCameraChanged();
    end);
    UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function() -- Line: 209
        -- upvalues: u10 (copy)
        u10:OnPreferredInputChanged();
    end);

    return u10;
end;

function u1.GetCameraMovementModeFromSettings(p15) -- Line: 216
    -- upvalues: Players (copy), CameraUtils (copy), UserInputService (copy), UserGameSettings (copy)
    if Players.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        return CameraUtils.ConvertCameraModeEnumToStandard(Enum.ComputerCameraMovementMode.Classic);
    end;

    local v16, v17;

    if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
        v16 = CameraUtils.ConvertCameraModeEnumToStandard(Players.LocalPlayer.DevTouchCameraMode);
        v17 = CameraUtils.ConvertCameraModeEnumToStandard(UserGameSettings.TouchCameraMovementMode);
    else
        v16 = CameraUtils.ConvertCameraModeEnumToStandard(Players.LocalPlayer.DevComputerCameraMode);
        v17 = CameraUtils.ConvertCameraModeEnumToStandard(UserGameSettings.ComputerCameraMovementMode);
    end;

    if v16 == Enum.DevComputerCameraMovementMode.UserChoice then
        return v17;
    end;

    return v16;
end;

function u1.ActivateOcclusionModule(p18, p19) -- Line: 241
    -- upvalues: Poppercam (copy), Invisicam (copy), u5 (copy), Players (copy)
    local v20;

    if p19 == Enum.DevCameraOcclusionMode.Zoom then
        v20 = Poppercam;
    else
        if p19 ~= Enum.DevCameraOcclusionMode.Invisicam then
            warn("CameraScript ActivateOcclusionModule called with unsupported mode");

            return;
        end;

        v20 = Invisicam;
    end;

    p18.occlusionMode = p19;

    if p18.activeOcclusionModule and p18.activeOcclusionModule:GetOcclusionMode() == p19 then
        if not p18.activeOcclusionModule:GetEnabled() then
            p18.activeOcclusionModule:Enable(true);
        end;

        return;
    end;

    local activeOcclusionModule = p18.activeOcclusionModule;
    p18.activeOcclusionModule = u5[v20];

    if not p18.activeOcclusionModule then
        p18.activeOcclusionModule = v20.new();

        if p18.activeOcclusionModule then
            u5[v20] = p18.activeOcclusionModule;
        end;
    end;

    if p18.activeOcclusionModule then
        if p18.activeOcclusionModule:GetOcclusionMode() ~= p19 then
            warn("CameraScript ActivateOcclusionModule mismatch: ", p18.activeOcclusionModule:GetOcclusionMode(), "~=", p19);
        end;

        if activeOcclusionModule then
            if activeOcclusionModule == p18.activeOcclusionModule then
                warn("CameraScript ActivateOcclusionModule failure to detect already running correct module");
            else
                activeOcclusionModule:Enable(false);
            end;
        end;

        if p19 == Enum.DevCameraOcclusionMode.Invisicam then
            if Players.LocalPlayer.Character then
                p18.activeOcclusionModule:CharacterAdded(Players.LocalPlayer.Character, Players.LocalPlayer);
            end;
        else
            for _, v in pairs(Players:GetPlayers()) do
                if v and v.Character then
                    p18.activeOcclusionModule:CharacterAdded(v.Character, v);
                end;
            end;

            p18.activeOcclusionModule:OnCameraSubjectChanged(game.Workspace.CurrentCamera.CameraSubject);
        end;

        p18.activeOcclusionModule:Enable(true);
    end;
end;

function u1.ShouldUseVehicleCamera(p21) -- Line: 320
    local CurrentCamera = workspace.CurrentCamera;

    if not CurrentCamera then
        return false;
    end;

    local CameraType = CurrentCamera.CameraType;
    local CameraSubject = CurrentCamera.CameraSubject;
    local v22 = CameraType == Enum.CameraType.Custom and true or CameraType == Enum.CameraType.Follow;
    local v23 = CameraSubject and CameraSubject:IsA("VehicleSeat") or false;
    local v24 = p21.occlusionMode ~= Enum.DevCameraOcclusionMode.Invisicam;

    if v23 then
        if not v22 then
            v24 = v22;
        end;
    else
        v24 = v23;
    end;

    return v24;
end;

function u1.ActivateCameraController(p25) -- Line: 336
    -- upvalues: LegacyCamera (copy), VRService (copy), VRCamera (copy), ClassicCamera (copy), OrbitalCamera (copy), VRVehicleCamera (copy), VehicleCamera (copy), u4 (copy), u7 (copy)
    local CameraType = workspace.CurrentCamera.CameraType;
    local v26 = p25:GetCameraMovementModeFromSettings();
    local v27 = nil;

    if CameraType == Enum.CameraType.Scriptable then
        if p25.activeCameraController then
            p25.activeCameraController:Enable(false);
            p25.activeCameraController = nil;
        end;

        return;
    end;

    if CameraType == Enum.CameraType.Custom then
        v26 = p25:GetCameraMovementModeFromSettings();
    elseif CameraType == Enum.CameraType.Track then
        v26 = Enum.ComputerCameraMovementMode.Classic;
    elseif CameraType == Enum.CameraType.Follow then
        v26 = Enum.ComputerCameraMovementMode.Follow;
    elseif CameraType == Enum.CameraType.Orbital then
        v26 = Enum.ComputerCameraMovementMode.Orbital;
    elseif CameraType == Enum.CameraType.Attach or (CameraType == Enum.CameraType.Watch or CameraType == Enum.CameraType.Fixed) then
        v27 = LegacyCamera;
    else
        warn("CameraScript encountered an unhandled Camera.CameraType value: ", CameraType);
    end;

    if not v27 then
        if VRService.VREnabled then
            v27 = VRCamera;
        elseif v26 == Enum.ComputerCameraMovementMode.Classic or (v26 == Enum.ComputerCameraMovementMode.Follow or (v26 == Enum.ComputerCameraMovementMode.Default or v26 == Enum.ComputerCameraMovementMode.CameraToggle)) then
            v27 = ClassicCamera;
        else
            if v26 ~= Enum.ComputerCameraMovementMode.Orbital then
                warn("ActivateCameraController did not select a module.");

                return;
            end;

            v27 = OrbitalCamera;
        end;
    end;

    if p25:ShouldUseVehicleCamera() then
        if VRService.VREnabled then
            v27 = VRVehicleCamera;
        else
            v27 = VehicleCamera;
        end;
    end;

    local v28;

    if u4[v27] then
        v28 = u4[v27];

        if u7 then
            if v28.Reset and p25.activeCameraController ~= v28 then
                v28:Reset();
            end;
        elseif v28.Reset then
            v28:Reset();
        end;
    else
        v28 = v27.new();
        u4[v27] = v28;
    end;

    if p25.activeCameraController then
        if p25.activeCameraController == v28 then
            if not p25.activeCameraController:GetEnabled() then
                p25.activeCameraController:Enable(true);
            end;
        else
            if v28.HandleSubjectDistance then
                v28:HandleSubjectDistance(p25.activeCameraController);
            end;

            p25.activeCameraController:Enable(false);
            p25.activeCameraController = v28;
            p25.activeCameraController:Enable(true);
        end;
    elseif v28 ~= nil then
        p25.activeCameraController = v28;
        assert(p25.activeCameraController, "Strict typing check");
        p25.activeCameraController:Enable(true);
    end;

    if p25.activeCameraController then
        p25.activeCameraController:SetCameraMovementMode(v26);
        p25.activeCameraController:SetCameraType(CameraType);
    end;
end;

function u1.OnCameraSubjectChanged(p29) -- Line: 445
    local CurrentCamera = workspace.CurrentCamera;
    local v30;

    if CurrentCamera then
        v30 = CurrentCamera.CameraSubject;
    else
        v30 = nil;
    end;

    if p29.activeTransparencyController then
        p29.activeTransparencyController:SetSubject(v30);
    end;

    if p29.activeOcclusionModule then
        p29.activeOcclusionModule:OnCameraSubjectChanged(v30);
    end;

    p29:ActivateCameraController();
end;

function u1.OnCameraTypeChanged(p31, p32) -- Line: 460
    -- upvalues: UserInputService (copy), CameraUtils (copy)
    if p32 == Enum.CameraType.Scriptable and UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
        CameraUtils.restoreMouseBehavior();
    end;

    p31:ActivateCameraController();
end;

function u1.OnCurrentCameraChanged(u33) -- Line: 472
    local CurrentCamera = game.Workspace.CurrentCamera;

    if not CurrentCamera then
        return;
    end;

    if u33.cameraSubjectChangedConn then
        u33.cameraSubjectChangedConn:Disconnect();
    end;

    if u33.cameraTypeChangedConn then
        u33.cameraTypeChangedConn:Disconnect();
    end;

    u33.cameraSubjectChangedConn = CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function() -- Line: 484
        -- upvalues: u33 (copy)
        u33:OnCameraSubjectChanged();
    end);
    u33.cameraTypeChangedConn = CurrentCamera:GetPropertyChangedSignal("CameraType"):Connect(function() -- Line: 488
        -- upvalues: u33 (copy), CurrentCamera (copy)
        u33:OnCameraTypeChanged(CurrentCamera.CameraType);
    end);
    u33:OnCameraSubjectChanged();
    u33:OnCameraTypeChanged(CurrentCamera.CameraType);
end;

function u1.OnLocalPlayerCameraPropertyChanged(p34, p35) -- Line: 496
    -- upvalues: Players (copy)
    if p35 == "CameraMode" then
        if Players.LocalPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
            if Players.LocalPlayer.CameraMode == Enum.CameraMode.Classic then
                p34:ActivateCameraController();

                return;
            end;

            warn("Unhandled value for property player.CameraMode: ", Players.LocalPlayer.CameraMode);

            return;
        end;

        if not p34.activeCameraController or p34.activeCameraController:GetModuleName() ~= "ClassicCamera" then
            p34:ActivateCameraController();
        end;

        if p34.activeCameraController then
            p34.activeCameraController:UpdateForDistancePropertyChange();
        end;
    else
        if p35 == "DevComputerCameraMode" or p35 == "DevTouchCameraMode" then
            p34:ActivateCameraController();

            return;
        end;

        if p35 == "DevCameraOcclusionMode" then
            p34:ActivateOcclusionModule(Players.LocalPlayer.DevCameraOcclusionMode);

            return;
        end;

        if p35 == "CameraMinZoomDistance" or p35 == "CameraMaxZoomDistance" then
            if p34.activeCameraController then
                p34.activeCameraController:UpdateForDistancePropertyChange();
            end;
        else
            if p35 == "DevTouchMovementMode" then
                return;
            end;

            if p35 == "DevComputerMovementMode" then
                return;
            end;

            local _ = p35 == "DevEnableMouseLock";
        end;
    end;
end;

function u1.OnUserGameSettingsPropertyChanged(p36, p37) -- Line: 538
    if p37 == "ComputerCameraMovementMode" or p37 == "TouchCameraMovementMode" then
        p36:ActivateCameraController();
    end;
end;

function u1.OnPreferredInputChanged(p38) -- Line: 544
    p38:ActivateCameraController();
end;

function u1.Update(p39, p40) -- Line: 554
    -- upvalues: CameraInput (copy)
    if p39.activeCameraController then
        p39.activeCameraController:UpdateMouseBehavior();
        local v41, v42 = p39.activeCameraController:Update(p40);

        if p39.activeOcclusionModule and not p39.activeCameraController.skipOcclusion then
            v41, v42 = p39.activeOcclusionModule:Update(p40, v41, v42);
        end;

        local CurrentCamera = game.Workspace.CurrentCamera;
        CurrentCamera.CFrame = v41;
        CurrentCamera.Focus = v42;

        if p39.activeTransparencyController then
            p39.activeTransparencyController:Update(p40);
        end;

        if CameraInput.getInputEnabled() then
            CameraInput.resetInputForFrameEnd();
        end;
    end;
end;

function u1.OnCharacterAdded(p43, p44, p45) -- Line: 580
    if p43.activeOcclusionModule then
        p43.activeOcclusionModule:CharacterAdded(p44, p45);
    end;
end;

function u1.OnCharacterRemoving(p46, p47, p48) -- Line: 586
    if p46.activeOcclusionModule then
        p46.activeOcclusionModule:CharacterRemoving(p47, p48);
    end;
end;

function u1.OnPlayerAdded(u49, u50) -- Line: 592
    -- upvalues: u6 (copy)
    if u6 then
        if u49.connectionUtil then
            u49.connectionUtil:trackConnection(`{u50.UserId}CharacterAdded`, u50.CharacterAdded:Connect(function(p51) -- Line: 596
                -- upvalues: u49 (copy), u50 (copy)
                u49:OnCharacterAdded(p51, u50);
            end));
            u49.connectionUtil:trackConnection(`{u50.UserId}CharacterRemoving`, u50.CharacterRemoving:Connect(function(p52) -- Line: 599
                -- upvalues: u49 (copy), u50 (copy)
                u49:OnCharacterRemoving(p52, u50);
            end));
        end;
    else
        u50.CharacterAdded:Connect(function(p53) -- Line: 604
            -- upvalues: u49 (copy), u50 (copy)
            u49:OnCharacterAdded(p53, u50);
        end);
        u50.CharacterRemoving:Connect(function(p54) -- Line: 607
            -- upvalues: u49 (copy), u50 (copy)
            u49:OnCharacterRemoving(p54, u50);
        end);
    end;
end;

function u1.OnPlayerRemoving(p55, p56) -- Line: 613
    if p55.connectionUtil then
        p55.connectionUtil:disconnect((`{p56.UserId}CharacterAdded`));
        p55.connectionUtil:disconnect((`{p56.UserId}CharacterRemoving`));
    end;
end;

function u1.OnMouseLockToggled(p57) -- Line: 621
    if p57.activeMouseLockController then
        local v58 = p57.activeMouseLockController:GetIsMouseLocked();
        local v59 = p57.activeMouseLockController:GetMouseLockOffset();

        if p57.activeCameraController then
            p57.activeCameraController:SetIsMouseLocked(v58);
            p57.activeCameraController:SetMouseLockOffset(v59);
        end;
    end;
end;

u1.new();

return {};