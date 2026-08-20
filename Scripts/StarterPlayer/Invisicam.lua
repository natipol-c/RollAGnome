--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Invisicam
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.Invisicam
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:10 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local u1 = require(CommonUtils:WaitForChild("FlagUtil")).getUserFlag("UserRaycastUpdateAPI2");
local u2 = {
    LIMBS = 2,
    MOVEMENT = 3,
    CORNERS = 4,
    CIRCLE1 = 5,
    CIRCLE2 = 6,
    LIMBMOVE = 7,
    SMART_CIRCLE = 8,
    CHAR_OUTLINE = 9
};
local u3 = {
    Head = true,
    ["Left Arm"] = true,
    ["Right Arm"] = true,
    ["Left Leg"] = true,
    ["Right Leg"] = true,
    LeftLowerArm = true,
    RightLowerArm = true,
    LeftUpperLeg = true,
    RightUpperLeg = true
};
local u4 = { Vector3.new(1, 1, -1), Vector3.new(1, -1, -1), Vector3.new(-1, -1, -1), Vector3.new(-1, 1, -1) };
local u5 = RaycastParams.new();
u5.FilterType = Enum.RaycastFilterType.Exclude;
local u6 = RaycastParams.new();
u6.FilterType = Enum.RaycastFilterType.Include;

local function AssertTypes(p7, ...) -- Line: 71
    local v8 = {};
    local v9 = "";

    for _, v in pairs({ ... }) do
        v8[v] = true;
        v9 = v9 .. (v9 == "" and "" or " or ") .. v;
    end;

    local v10 = type(p7);
    assert(v8[v10], v9 .. " type expected, got: " .. v10);
end;

local function Det3x3(p11, p12, p13, p14, p15, p16, p17, p18, p19) -- Line: 83
    return p11 * (p15 * p19 - p16 * p18) - p12 * (p14 * p19 - p16 * p17) + p13 * (p14 * p18 - p15 * p17);
end;

local function RayIntersection(p20, p21, p22, p23) -- Line: 91
    local v24 = p21:Cross(p23);
    local v25 = p22.X - p20.X;
    local v26 = p22.Y - p20.Y;
    local v27 = p22.Z - p20.Z;
    local Y = p21.Y;
    local v28 = -p23.Y;
    local Y2 = v24.Y;
    local Z = p21.Z;
    local v29 = -p23.Z;
    local Z2 = v24.Z;
    local v30 = p21.X * (v28 * Z2 - Y2 * v29) - -p23.X * (Y * Z2 - Y2 * Z) + v24.X * (Y * v29 - v28 * Z);

    if v30 == 0 then
        return Vector3.new(0, 0, 0);
    end;

    local v31 = -p23.Y;
    local Y3 = v24.Y;
    local v32 = -p23.Z;
    local Z3 = v24.Z;
    local Y4 = p21.Y;
    local Y5 = v24.Y;
    local Z4 = p21.Z;
    local Z5 = v24.Z;
    local v33 = p20 + (v25 * (v31 * Z3 - Y3 * v32) - -p23.X * (v26 * Z3 - Y3 * v27) + v24.X * (v26 * v32 - v31 * v27)) / v30 * p21;
    local v34 = p22 + (p21.X * (v26 * Z5 - Y5 * v27) - v25 * (Y4 * Z5 - Y5 * Z4) + v24.X * (Y4 * v27 - v26 * Z4)) / v30 * p23;

    return (v34 - v33).Magnitude >= 0.25 and Vector3.new(0, 0, 0) or v33 + (v34 - v33) * 0.5;
end;

local BaseOcclusion = require(script.Parent:WaitForChild("BaseOcclusion"));
local u35 = setmetatable({}, BaseOcclusion);
u35.__index = u35;

function u35.new() -- Line: 124
    -- upvalues: BaseOcclusion (copy), u35 (copy), u2 (copy)
    local v36 = BaseOcclusion.new();
    local v37 = setmetatable(v36, u35);
    v37.char = nil;
    v37.humanoidRootPart = nil;
    v37.torsoPart = nil;
    v37.headPart = nil;
    v37.childAddedConn = nil;
    v37.childRemovedConn = nil;
    v37.behaviors = {};
    v37.behaviors[u2.LIMBS] = v37.LimbBehavior;
    v37.behaviors[u2.MOVEMENT] = v37.MoveBehavior;
    v37.behaviors[u2.CORNERS] = v37.CornerBehavior;
    v37.behaviors[u2.CIRCLE1] = v37.CircleBehavior;
    v37.behaviors[u2.CIRCLE2] = v37.CircleBehavior;
    v37.behaviors[u2.LIMBMOVE] = v37.LimbMoveBehavior;
    v37.behaviors[u2.SMART_CIRCLE] = v37.SmartCircleBehavior;
    v37.behaviors[u2.CHAR_OUTLINE] = v37.CharacterOutlineBehavior;
    v37.mode = u2.SMART_CIRCLE;
    v37.behaviorFunction = v37.SmartCircleBehavior;
    v37.savedHits = {};
    v37.trackedLimbs = {};
    v37.camera = game.Workspace.CurrentCamera;
    v37.enabled = false;

    return v37;
end;

function u35.Enable(p38, p39) -- Line: 157
    p38.enabled = p39;

    if not p39 then
        p38:Cleanup();
    end;
end;

function u35.GetOcclusionMode(p40) -- Line: 165
    return Enum.DevCameraOcclusionMode.Invisicam;
end;

function u35.LimbBehavior(p41, p42) -- Line: 170
    for i, _ in pairs(p41.trackedLimbs) do
        p42[#p42 + 1] = i.Position;
    end;
end;

function u35.MoveBehavior(p43, p44) -- Line: 176
    for i = 1, 3 do
        local Position = p43.humanoidRootPart.Position;
        local Velocity = p43.humanoidRootPart.Velocity;
        local v45 = Vector3.new(Velocity.X, 0, Velocity.Z).Magnitude / 2;
        p44[#p44 + 1] = Position + (i - 1) * p43.humanoidRootPart.CFrame.lookVector * v45;
    end;
end;

function u35.CornerBehavior(p46, p47) -- Line: 185
    -- upvalues: u4 (copy)
    local CFrame2 = p46.humanoidRootPart.CFrame;
    local Position = CFrame2.Position;
    local v48 = CFrame2 - Position;
    local v49 = p46.char:GetExtentsSize() / 2;
    p47[#p47 + 1] = Position;

    for i = 1, #u4 do
        p47[#p47 + 1] = Position + v48 * (v49 * u4[i]);
    end;
end;

function u35.CircleBehavior(p50, p51) -- Line: 196
    -- upvalues: u2 (copy)
    local v52;

    if p50.mode == u2.CIRCLE1 then
        v52 = p50.humanoidRootPart.CFrame;
    else
        local CoordinateFrame = p50.camera.CoordinateFrame;
        v52 = CoordinateFrame - CoordinateFrame.Position + p50.humanoidRootPart.Position;
    end;

    p51[#p51 + 1] = v52.Position;

    for i = 0, 9 do
        local v53 = 0.6283185307179586 * i;
        local v54 = math.cos(v53);
        local v55 = math.sin(v53);
        local v56 = Vector3.new(v54, v55, 0) * 3;
        p51[#p51 + 1] = v52 * v56;
    end;
end;

function u35.LimbMoveBehavior(p57, p58) -- Line: 212
    p57:LimbBehavior(p58);
    p57:MoveBehavior(p58);
end;

function u35.CharacterOutlineBehavior(p59, p60) -- Line: 217
    -- upvalues: u1 (copy), u6 (copy)
    local unit = p59.torsoPart.CFrame.upVector.unit;
    local unit2 = p59.torsoPart.CFrame.rightVector.unit;
    p60[#p60 + 1] = p59.torsoPart.CFrame.p;
    p60[#p60 + 1] = p59.torsoPart.CFrame.p + unit;
    p60[#p60 + 1] = p59.torsoPart.CFrame.p - unit;
    p60[#p60 + 1] = p59.torsoPart.CFrame.p + unit2;
    p60[#p60 + 1] = p59.torsoPart.CFrame.p - unit2;

    if p59.headPart then
        p60[#p60 + 1] = p59.headPart.CFrame.p;
    end;

    local v61 = CFrame.new(Vector3.new(0, 0, 0), (Vector3.new(p59.camera.CoordinateFrame.lookVector.X, 0, p59.camera.CoordinateFrame.lookVector.Z)));
    local v62 = p59.torsoPart and p59.torsoPart.Position or p59.humanoidRootPart.Position;
    local v63 = { p59.torsoPart };

    if p59.headPart then
        v63[#v63 + 1] = p59.headPart;
    end;

    for i = 1, 24 do
        local v64 = 6.283185307179586 * i / 24;
        local v65 = math.cos(v64);
        local v66 = math.sin(v64);
        local v67 = v61 * (Vector3.new(v65, v66, 0) * 3);
        local X = v67.X;
        local v68 = math.max(v67.Y, -2.25);
        local v69 = Vector3.new(X, v68, v67.Z);

        if u1 then
            u6.FilterDescendantsInstances = v63;
            local v70 = game.Workspace:Raycast(v62 + v69, -3 * v69, u6);

            if v70 then
                local Position = v70.Position;
                p60[#p60 + 1] = Position + 0.2 * (v62 - Position).unit;
            end;
        else
            local v71 = Ray.new(v62 + v69, -3 * v69);
            local v72, v73 = game.Workspace:FindPartOnRayWithWhitelist(v71, v63, false);

            if v72 then
                p60[#p60 + 1] = v73 + 0.2 * (v62 - v73).unit;
            end;
        end;
    end;
end;

function u35.SmartCircleBehavior(p74, p75) -- Line: 268
    -- upvalues: u1 (copy), u5 (copy), RayIntersection (copy)
    local unit = p74.torsoPart.CFrame.upVector.unit;
    local unit2 = p74.torsoPart.CFrame.rightVector.unit;
    p75[#p75 + 1] = p74.torsoPart.CFrame.p;
    p75[#p75 + 1] = p74.torsoPart.CFrame.p + unit;
    p75[#p75 + 1] = p74.torsoPart.CFrame.p - unit;
    p75[#p75 + 1] = p74.torsoPart.CFrame.p + unit2;
    p75[#p75 + 1] = p74.torsoPart.CFrame.p - unit2;

    if p74.headPart then
        p75[#p75 + 1] = p74.headPart.CFrame.p;
    end;

    local v76 = p74.camera.CFrame - p74.camera.CFrame.p;
    local v77 = Vector3.new(0, 0.5, 0) + (p74.torsoPart and p74.torsoPart.Position or p74.humanoidRootPart.Position);

    for i = 1, 24 do
        local v78 = 0.2617993877991494 * i - 1.5707963267948966;
        local v79 = math.cos(v78);
        local v80 = math.sin(v78);
        local v81 = v77 + v76 * (Vector3.new(v79, v80, 0) * 2.5);
        local v82 = v81 - p74.camera.CFrame.p;

        if u1 then
            u5.FilterDescendantsInstances = { p74.char };
            local v83 = game.Workspace:Raycast(v77, v81 - v77, u5);

            if v83 then
                local Normal = v83.Normal;
                local v84 = v83.Position + 0.1 * Normal.unit;
                local v85 = v84 - v77;
                local unit3 = v85:Cross(v82).unit:Cross(Normal).unit;
                local unit4 = (v84 - p74.camera.CFrame.p).unit;

                if v85.unit:Dot(-unit3) < v85.unit:Dot(unit4) then
                    v81 = RayIntersection(v84, unit3, v81, v82);

                    if v81.Magnitude > 0 then
                        local v86 = game.Workspace:Raycast(v84, v81 - v84, u5);

                        if v86 then
                            v81 = v86.Position + 0.1 * v86.Normal.Unit;
                        end;
                    else
                        v81 = v84;
                    end;
                else
                    v81 = v84;
                end;

                local v87 = game.Workspace:Raycast(v77, v81 - v77, u5);

                if v87 then
                    v81 = v87.Position - 0.1 * (v81 - v77).unit;
                end;
            end;

            p75[#p75 + 1] = v81;
        else
            local v88 = Ray.new(v77, v81 - v77);
            local v89, v90, v91 = game.Workspace:FindPartOnRayWithIgnoreList(v88, { p74.char }, false, false);

            if v89 then
                local v92 = v90 + 0.1 * v91.unit;
                local v93 = v92 - v77;
                local unit3 = v93:Cross(v82).unit:Cross(v91).unit;
                local unit4 = (v92 - p74.camera.CFrame.p).unit;

                if v93.unit:Dot(-unit3) < v93.unit:Dot(unit4) then
                    v81 = RayIntersection(v92, unit3, v81, v82);

                    if v81.Magnitude > 0 then
                        local v94 = Ray.new(v92, v81 - v92);
                        local v95, v96, v97 = game.Workspace:FindPartOnRayWithIgnoreList(v94, { p74.char }, false, false);

                        if v95 then
                            v81 = v96 + 0.1 * v97.unit;
                        end;
                    else
                        v81 = v92;
                    end;
                else
                    v81 = v92;
                end;

                local v98 = Ray.new(v77, v81 - v77);
                local v99, v100, _ = game.Workspace:FindPartOnRayWithIgnoreList(v98, { p74.char }, false, false);

                if v99 then
                    v81 = v100 - 0.1 * (v81 - v77).unit;
                end;
            end;

            p75[#p75 + 1] = v81;
        end;
    end;
end;

function u35.CheckTorsoReference(p101) -- Line: 403
    if p101.char then
        p101.torsoPart = p101.char:FindFirstChild("Torso");

        if not p101.torsoPart then
            p101.torsoPart = p101.char:FindFirstChild("UpperTorso");

            if not p101.torsoPart then
                p101.torsoPart = p101.char:FindFirstChild("HumanoidRootPart");
            end;
        end;

        p101.headPart = p101.char:FindFirstChild("Head");
    end;
end;

function u35.CharacterAdded(u102, p103, p104) -- Line: 417
    -- upvalues: Players (copy), u3 (copy)
    if p104 ~= Players.LocalPlayer then
        return;
    end;

    if u102.childAddedConn then
        u102.childAddedConn:Disconnect();
        u102.childAddedConn = nil;
    end;

    if u102.childRemovedConn then
        u102.childRemovedConn:Disconnect();
        u102.childRemovedConn = nil;
    end;

    u102.char = p103;
    u102.trackedLimbs = {};
    u102.childAddedConn = p103.ChildAdded:Connect(function(p105) -- Line: 433, Name: childAdded
        -- upvalues: u3 (ref), u102 (copy)
        if p105:IsA("BasePart") then
            if u3[p105.Name] then
                u102.trackedLimbs[p105] = true;
            end;

            if p105.Name == "Torso" or p105.Name == "UpperTorso" then
                u102.torsoPart = p105;
            end;

            if p105.Name == "Head" then
                u102.headPart = p105;
            end;
        end;
    end);
    u102.childRemovedConn = p103.ChildRemoved:Connect(function(p106) -- Line: 449, Name: childRemoved
        -- upvalues: u102 (copy)
        u102.trackedLimbs[p106] = nil;
        u102:CheckTorsoReference();
    end);

    for _, child in pairs(u102.char:GetChildren()) do
        if child:IsA("BasePart") then
            if u3[child.Name] then
                u102.trackedLimbs[child] = true;
            end;

            if child.Name == "Torso" or child.Name == "UpperTorso" then
                u102.torsoPart = child;
            end;

            if child.Name == "Head" then
                u102.headPart = child;
            end;
        end;
    end;
end;

function u35.SetMode(p107, p108) -- Line: 463
    -- upvalues: AssertTypes (copy), u2 (copy)
    AssertTypes(p108, "number");

    for _, v in pairs(u2) do
        if v == p108 then
            p107.mode = p108;
            p107.behaviorFunction = p107.behaviors[p107.mode];

            return;
        end;
    end;

    error("Invalid mode number");
end;

function u35.GetObscuredParts(p109) -- Line: 475
    return p109.savedHits;
end;

function u35.Cleanup(p110) -- Line: 480
    for i, v in pairs(p110.savedHits) do
        i.LocalTransparencyModifier = v;
    end;
end;

function u35.Update(u111, p112, p113, p114) -- Line: 486
    if not (u111.enabled and u111.char) then
        return p113, p114;
    end;

    u111.camera = game.Workspace.CurrentCamera;

    if not u111.humanoidRootPart then
        local v115 = u111.char:FindFirstChildOfClass("Humanoid");

        if v115 and v115.RootPart then
            u111.humanoidRootPart = v115.RootPart;
        else
            u111.humanoidRootPart = u111.char:FindFirstChild("HumanoidRootPart");

            if not u111.humanoidRootPart then
                return p113, p114;
            end;
        end;

        local u116 = nil;
        u116 = u111.humanoidRootPart.AncestryChanged:Connect(function(p117, p118) -- Line: 511
            -- upvalues: u111 (copy), u116 (ref)
            if p117 == u111.humanoidRootPart and not p118 then
                u111.humanoidRootPart = nil;

                if u116 and u116.Connected then
                    u116:Disconnect();
                    u116 = nil;
                end;
            end;
        end);
    end;

    if not u111.torsoPart then
        u111:CheckTorsoReference();

        if not u111.torsoPart then
            return p113, p114;
        end;
    end;

    local v119 = {};
    u111.behaviorFunction(u111, v119);
    local u120 = {};
    local v121 = { u111.char };

    local function add(p122) -- Line: 537
        -- upvalues: u120 (copy), u111 (copy)
        u120[p122] = true;

        if not u111.savedHits[p122] then
            u111.savedHits[p122] = p122.LocalTransparencyModifier;
        end;
    end;

    local v123 = u111.camera:GetPartsObscuringTarget({ u111.headPart and u111.headPart.CFrame.p or v119[1], u111.torsoPart and u111.torsoPart.CFrame.p or v119[2] }, v121);
    local v124 = 0;
    local v125 = {};
    local v126 = 0.75;
    local v127 = 0.75;

    for i = 1, #v123 do
        local v128 = v123[i];
        v124 = v124 + 1;
        v125[v128] = true;

        for _, child in pairs(v128:GetChildren()) do
            if child:IsA("Decal") or child:IsA("Texture") then
                v124 = v124 + 1;
                break;
            end;
        end;
    end;

    if v124 > 0 then
        v126 = math.pow(0.375 / v124 + 0.375, 1 / v124);
        v127 = math.pow(0.25 / v124 + 0.25, 1 / v124);
    end;

    local v129 = u111.camera:GetPartsObscuringTarget(v119, v121);
    local v130 = {};

    for i = 1, #v129 do
        local v131 = v129[i];
        v130[v131] = v125[v131] and v126 and v126 or v127;

        if v131.Transparency < v130[v131] then
            u120[v131] = true;

            if not u111.savedHits[v131] then
                u111.savedHits[v131] = v131.LocalTransparencyModifier;
            end;
        end;

        for _, child in pairs(v131:GetChildren()) do
            if (child:IsA("Decal") or child:IsA("Texture")) and child.Transparency < v130[v131] then
                v130[child] = v130[v131];
                u120[child] = true;

                if not u111.savedHits[child] then
                    u111.savedHits[child] = child.LocalTransparencyModifier;
                end;
            end;
        end;
    end;

    for i, v in pairs(u111.savedHits) do
        if u120[i] then
            i.LocalTransparencyModifier = i.Transparency < 1 and ((v130[i] - i.Transparency) / (1 - i.Transparency) or 0) or 0;
        else
            i.LocalTransparencyModifier = v;
            u111.savedHits[i] = nil;
        end;
    end;

    return p113, p114;
end;

return u35;