--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Poppercam
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.Poppercam
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:10 2026
]]

-- Decompiled with Potassium's decompiler.

local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local FlagUtil = require(CommonUtils:WaitForChild("FlagUtil"));
local ZoomController = require(script.Parent:WaitForChild("ZoomController"));
local u1 = FlagUtil.getUserFlag("UserFixCameraFPError");
local u2 = {};
u2.__index = u2;
local u3 = CFrame.new();

local function cframeToAxis(p4) -- Line: 17
    local v5, v6 = p4:ToAxisAngle();

    return v5 * v6;
end;

local function axisToCFrame(p7) -- Line: 22
    -- upvalues: u3 (copy)
    local Magnitude = p7.Magnitude;

    if Magnitude > 0.00001 then
        return CFrame.fromAxisAngle(p7, Magnitude);
    end;

    return u3;
end;

local function extractRotation(p8) -- Line: 30
    local _, _, _, v9, v10, v11, v12, v13, v14, v15, v16, v17 = p8:GetComponents();

    return CFrame.new(0, 0, 0, v9, v10, v11, v12, v13, v14, v15, v16, v17);
end;

function u2.new() -- Line: 35
    -- upvalues: u2 (copy)
    return setmetatable({
        lastCFrame = nil
    }, u2);
end;

function u2.Step(p18, p19, p20) -- Line: 41
    -- upvalues: u3 (copy)
    local v21 = p18.lastCFrame or p20;
    p18.lastCFrame = p20;
    local Position = p20.Position;
    local _, _, _, v22, v23, v24, v25, v26, v27, v28, v29, v30 = p20:GetComponents();
    local u31 = CFrame.new(0, 0, 0, v22, v23, v24, v25, v26, v27, v28, v29, v30);
    local p = v21.p;
    local _, _, _, v32, v33, v34, v35, v36, v37, v38, v39, v40 = v21:GetComponents();
    local v41 = CFrame.new(0, 0, 0, v32, v33, v34, v35, v36, v37, v38, v39, v40);
    local u42 = (Position - p) / p19;
    local v43, v44 = (u31 * v41:inverse()):ToAxisAngle();
    local u45 = v43 * v44 / p19;

    return {
        extrapolate = function(p46) -- Line: 56, Name: extrapolate
            -- upvalues: u42 (copy), Position (copy), u45 (copy), u3 (ref), u31 (copy)
            local v47 = u45 * p46;
            local Magnitude = v47.Magnitude;
            local v48;

            if Magnitude > 0.00001 then
                v48 = CFrame.fromAxisAngle(v47, Magnitude);
            else
                v48 = u3;
            end;

            return v48 * u31 + (u42 * p46 + Position);
        end,

        posVelocity = u42,
        rotVelocity = u45
    };
end;

function u2.Reset(p49) -- Line: 69
    p49.lastCFrame = nil;
end;

local BaseOcclusion = require(script.Parent:WaitForChild("BaseOcclusion"));
local u50 = setmetatable({}, BaseOcclusion);
u50.__index = u50;

function u50.new() -- Line: 79
    -- upvalues: BaseOcclusion (copy), u50 (copy), u2 (copy)
    local v51 = BaseOcclusion.new();
    local v52 = setmetatable(v51, u50);
    v52.focusExtrapolator = u2.new();

    return v52;
end;

function u50.GetOcclusionMode(p53) -- Line: 85
    return Enum.DevCameraOcclusionMode.Zoom;
end;

function u50.Enable(p54, p55) -- Line: 89
    p54.focusExtrapolator:Reset();
end;

function u50.Update(p56, p57, p58, p59, p60) -- Line: 93
    -- upvalues: u1 (copy), ZoomController (copy)
    local v61;

    if u1 then
        v61 = CFrame.lookAlong(p59.p, -p58.LookVector) * CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1);
    else
        v61 = CFrame.new(p59.p, p58.p) * CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1);
    end;

    local v62 = p56.focusExtrapolator:Step(p57, v61);
    local v63 = ZoomController.Update(p57, v61, v62);

    return v61 * CFrame.new(0, 0, v63), p59;
end;

function u50.CharacterAdded(p64, p65, p66) -- Line: 117
end;

function u50.CharacterRemoving(p67, p68, p69) -- Line: 121
end;

function u50.OnCameraSubjectChanged(p70, p71) -- Line: 124
end;

return u50;