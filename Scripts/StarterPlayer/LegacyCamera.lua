--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     LegacyCamera
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.LegacyCamera
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:09 2026
]]

-- Decompiled with Potassium's decompiler.

Vector2.new();
require(script.Parent:WaitForChild("CameraUtils"));
local CameraInput = require(script.Parent:WaitForChild("CameraInput"));
local Players = game:GetService("Players");
local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"));
local u1 = setmetatable({}, BaseCamera);
u1.__index = u1;

function u1.new() -- Line: 21
    -- upvalues: BaseCamera (copy), u1 (copy)
    local v2 = BaseCamera.new();
    local v3 = setmetatable(v2, u1);
    v3.cameraType = Enum.CameraType.Fixed;
    v3.lastUpdate = tick();
    v3.lastDistanceToSubject = nil;

    return v3;
end;

function u1.GetModuleName(p4) -- Line: 31
    return "LegacyCamera";
end;

function u1.SetCameraToSubjectDistance(p5, p6) -- Line: 36
    -- upvalues: BaseCamera (copy)
    return BaseCamera.SetCameraToSubjectDistance(p5, p6);
end;

function u1.Update(p7, p8) -- Line: 40
    -- upvalues: Players (copy), CameraInput (copy)
    if not p7.cameraType then
        return nil, nil;
    end;

    local v9 = tick();
    local v10 = v9 - p7.lastUpdate;
    local CurrentCamera = workspace.CurrentCamera;
    local CFrame2 = CurrentCamera.CFrame;
    local Focus = CurrentCamera.Focus;
    local LocalPlayer = Players.LocalPlayer;
    local v11 = CameraInput.getRotation(p8);

    if p7.lastUpdate == nil or v10 > 1 then
        p7.lastDistanceToSubject = nil;
    end;

    local v12 = p7:GetSubjectPosition();

    if p7.cameraType == Enum.CameraType.Fixed then
        if v12 and (LocalPlayer and CurrentCamera) then
            local v13 = p7:GetCameraToSubjectDistance();
            local v14 = p7:CalculateNewLookVectorFromArg(nil, v11);
            Focus = CurrentCamera.Focus;
            CFrame2 = CFrame.new(CurrentCamera.CFrame.p, CurrentCamera.CFrame.p + v13 * v14);
        end;
    elseif p7.cameraType == Enum.CameraType.Attach then
        local v15 = p7:GetSubjectCFrame();
        local v16 = CurrentCamera.CFrame:ToEulerAnglesYXZ();
        local _, v17 = v15:ToEulerAnglesYXZ();
        local v18 = math.clamp(v16 - v11.Y, -1.3962634015954636, 1.3962634015954636);
        Focus = CFrame.new(v15.p) * CFrame.fromEulerAnglesYXZ(v18, v17, 0);
        CFrame2 = Focus * CFrame.new(0, 0, p7:StepZoom());
    else
        if p7.cameraType ~= Enum.CameraType.Watch then
            return CurrentCamera.CFrame, CurrentCamera.Focus;
        end;

        if v12 and (LocalPlayer and CurrentCamera) then
            local v19 = nil;

            if v12 == CurrentCamera.CFrame.p then
                warn("Camera cannot watch subject in same position as itself");

                return CurrentCamera.CFrame, CurrentCamera.Focus;
            end;

            local v20 = p7:GetHumanoid();

            if v20 and v20.RootPart then
                local v21 = v12 - CurrentCamera.CFrame.p;
                v19 = v21.unit;

                if p7.lastDistanceToSubject and p7.lastDistanceToSubject == p7:GetCameraToSubjectDistance() then
                    p7:SetCameraToSubjectDistance(v21.magnitude);
                end;
            end;

            local v22 = p7:GetCameraToSubjectDistance();
            local v23 = p7:CalculateNewLookVectorFromArg(v19, v11);
            Focus = CFrame.new(v12);
            CFrame2 = CFrame.new(v12 - v22 * v23, v12);
            p7.lastDistanceToSubject = v22;
        end;
    end;

    p7.lastUpdate = v9;

    return CFrame2, Focus;
end;

return u1;