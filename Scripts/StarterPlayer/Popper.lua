--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Popper
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.ZoomController.Popper
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:10 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local CommonUtils = script.Parent.Parent.Parent:WaitForChild("CommonUtils");
local FlagUtil = require(CommonUtils:WaitForChild("FlagUtil"));
local CameraWrapper = require(CommonUtils:WaitForChild("CameraWrapper"));
local ConnectionUtil = require(CommonUtils:WaitForChild("ConnectionUtil"));
local u1 = FlagUtil.getUserFlag("UserRaycastUpdateAPI2");
local u2 = FlagUtil.getUserFlag("UserCurrentCameraUpdate2");
local u3 = FlagUtil.getUserFlag("UserPlayerConnectionMemoryLeak");
local u4;

if u2 then
    u4 = CameraWrapper.new();
else
    u4 = nil;
end;

local u5;

if u2 then
    u5 = nil;
else
    u5 = game.Workspace.CurrentCamera;
end;

if u2 then
    u4:Enable();
end;

local min = math.min;
local tan = math.tan;
local rad = math.rad;
local new = Ray.new;
local u6 = RaycastParams.new();
u6.IgnoreWater = true;
u6.FilterType = Enum.RaycastFilterType.Exclude;
u6.RespectCanCollide = true;
local u7 = RaycastParams.new();
u7.IgnoreWater = true;
u7.FilterType = Enum.RaycastFilterType.Include;
local u8;

if u3 then
    u8 = ConnectionUtil.new();
else
    u8 = nil;
end;

local function getTotalTransparency(p9) -- Line: 43
    return 1 - (1 - p9.Transparency) * (1 - p9.LocalTransparencyModifier);
end;

local function eraseFromEnd(p10, p11) -- Line: 47
    for i = #p10, p11 + 1, -1 do
        p10[i] = nil;
    end;
end;

local u12 = nil;
local u13 = nil;
local u14;

if u2 then
    local function updateProjection() -- Line: 57
        -- upvalues: u4 (copy), rad (copy), u13 (ref), tan (copy), u12 (ref)
        local v15 = u4:getCamera();
        local v16 = rad(v15.FieldOfView);
        local ViewportSize = v15.ViewportSize;
        local v17 = ViewportSize.X / ViewportSize.Y;
        u13 = tan(v16 / 2) * 2;
        u12 = v17 * u13;
    end;

    u4:Connect("FieldOfView", updateProjection);
    u4:Connect("ViewportSize", updateProjection);
    local v18 = u4:getCamera();
    local v19 = rad(v18.FieldOfView);
    local ViewportSize = v18.ViewportSize;
    local v20 = ViewportSize.X / ViewportSize.Y;
    u13 = tan(v19 / 2) * 2;
    u12 = v20 * u13;
    u14 = u4:getCamera().NearPlaneZ;
    u4:Connect("NearPlaneZ", function() -- Line: 73
        -- upvalues: u14 (ref), u4 (copy)
        u14 = u4:getCamera().NearPlaneZ;
    end);
else
    local function v23() -- Line: 79
        -- upvalues: u5 (ref), rad (copy), u13 (ref), tan (copy), u12 (ref)
        local v21 = rad(u5.FieldOfView);
        local ViewportSize = u5.ViewportSize;
        local v22 = ViewportSize.X / ViewportSize.Y;
        u13 = tan(v21 / 2) * 2;
        u12 = v22 * u13;
    end;

    u5:GetPropertyChangedSignal("FieldOfView"):Connect(v23);
    u5:GetPropertyChangedSignal("ViewportSize"):Connect(v23);
    local v24 = rad(u5.FieldOfView);
    local ViewportSize = u5.ViewportSize;
    local v25 = ViewportSize.X / ViewportSize.Y;
    u13 = tan(v24 / 2) * 2;
    u12 = v25 * u13;
    u14 = u5.NearPlaneZ;
    u5:GetPropertyChangedSignal("NearPlaneZ"):Connect(function() -- Line: 93
        -- upvalues: u14 (ref), u5 (ref)
        u14 = u5.NearPlaneZ;
    end);
end;

local u26 = {};
local u27 = {};

local function refreshIgnoreList() -- Line: 102
    -- upvalues: u26 (ref), u27 (copy)
    local v28 = 1;
    u26 = {};

    for _, v in pairs(u27) do
        u26[v28] = v;
        v28 = v28 + 1;
    end;
end;

local function playerAdded(u29) -- Line: 111
    -- upvalues: u27 (copy), u26 (ref), u3 (copy), u8 (copy)
    local function characterAdded(p30) -- Line: 112
        -- upvalues: u27 (ref), u29 (copy), u26 (ref)
        u27[u29] = p30;
        local v31 = 1;
        u26 = {};

        for _, v in pairs(u27) do
            u26[v31] = v;
            v31 = v31 + 1;
        end;
    end;

    local function characterRemoving() -- Line: 116
        -- upvalues: u27 (ref), u29 (copy), u26 (ref)
        u27[u29] = nil;
        local v32 = 1;
        u26 = {};

        for _, v in pairs(u27) do
            u26[v32] = v;
            v32 = v32 + 1;
        end;
    end;

    if u3 then
        u8:trackConnection(`{u29.UserId}CharacterAdded`, u29.CharacterAdded:Connect(characterAdded));
        u8:trackConnection(`{u29.UserId}CharacterRemoving`, u29.CharacterRemoving:Connect(characterRemoving));
    else
        u29.CharacterAdded:Connect(characterAdded);
        u29.CharacterRemoving:Connect(characterRemoving);
    end;

    if u29.Character then
        u27[u29] = u29.Character;
        local v33 = 1;
        u26 = {};

        for _, v in pairs(u27) do
            u26[v33] = v;
            v33 = v33 + 1;
        end;
    end;
end;

local function playerRemoving(p34) -- Line: 134
    -- upvalues: u27 (copy), u26 (ref), u3 (copy), u8 (copy)
    u27[p34] = nil;
    local v35 = 1;
    u26 = {};

    for _, v in pairs(u27) do
        u26[v35] = v;
        v35 = v35 + 1;
    end;

    if u3 then
        u8:disconnect((`{p34.UserId}CharacterAdded`));
        u8:disconnect((`{p34.UserId}CharacterRemoving`));
    end;
end;

Players.PlayerAdded:Connect(playerAdded);
Players.PlayerRemoving:Connect(playerRemoving);

for _, v in ipairs(Players:GetPlayers()) do
    playerAdded(v);
end;

local v36 = 1;
u26 = {};

for _, v in pairs(u27) do
    u26[v36] = v;
    v36 = v36 + 1;
end;

local u37 = nil;
local u38 = nil;

if u2 then
    u4:Connect("CameraSubject", function() -- Line: 174
        -- upvalues: u4 (copy), u38 (ref)
        local CameraSubject = u4:getCamera().CameraSubject;

        if CameraSubject and CameraSubject:IsA("Humanoid") then
            u38 = CameraSubject.RootPart;

            return;
        end;

        if CameraSubject and CameraSubject:IsA("BasePart") then
            u38 = CameraSubject;

            return;
        end;

        u38 = nil;
    end);
else
    u5:GetPropertyChangedSignal("CameraSubject"):Connect(function() -- Line: 185
        -- upvalues: u5 (ref), u38 (ref)
        local CameraSubject = u5.CameraSubject;

        if CameraSubject:IsA("Humanoid") then
            u38 = CameraSubject.RootPart;

            return;
        end;

        if CameraSubject:IsA("BasePart") then
            u38 = CameraSubject;

            return;
        end;

        u38 = nil;
    end);
end;

local function canOcclude(p39) -- Line: 197
    -- upvalues: u1 (copy), u37 (ref)
    local v40;

    if 1 - (1 - p39.Transparency) * (1 - p39.LocalTransparencyModifier) < 0.25 then
        v40 = u1 or p39.CanCollide;

        if v40 then
            if u37 == (p39:GetRootPart() or p39) then
                v40 = false;
            else
                v40 = not p39:IsA("TrussPart");
            end;
        end;
    else
        v40 = false;
    end;

    return v40;
end;

local u41 = {
    Vector2.new(0.4, 0),
    Vector2.new(-0.4, 0),
    Vector2.new(0, -0.4),
    Vector2.new(0, 0.4),
    Vector2.new(0, 0.2)
};

local function getCollisionPoint(p42, p43) -- Line: 225
    -- upvalues: u1 (copy), u6 (copy), u26 (ref), new (copy)
    if u1 then
        u6.FilterDescendantsInstances = u26;
        local v44 = workspace:Raycast(p42, p43, u6);

        if v44 then
            return v44.Position, true;
        end;
    else
        local v45 = #u26;
        local v46;

        repeat
            local v47;
            v46, v47 = workspace:FindPartOnRayWithIgnoreList(new(p42, p43), u26, false, true);

            if v46 then
                if v46.CanCollide then
                    local v48 = u26;

                    for i = #v48, v45 + 1, -1 do
                        v48[i] = nil;
                    end;

                    return v47, true;
                end;

                u26[#u26 + 1] = v46;
            end;
        until not v46;

        local v49 = u26;

        for i = #v49, v45 + 1, -1 do
            v49[i] = nil;
        end;
    end;

    return p42 + p43, false;
end;

local function queryPoint(p50, p51, p52, p53) -- Line: 258
    -- upvalues: u26 (ref), u14 (ref), u1 (copy), u6 (copy), u37 (ref), u7 (copy), new (copy)
    debug.profilebegin("queryPoint");
    local v54 = #u26;
    local v55 = p52 + u14;
    local v56 = p50 + p51 * v55;
    local v57 = (1 / 0);
    local v58 = (1 / 0);
    local v59 = 0;
    local v60;

    if u1 then
        u6.FilterDescendantsInstances = u26;
        local v61 = p50;

        while true do
            local v62 = workspace:Raycast(p50, v56 - p50, u6);

            if not v62 then
                v60 = v57;
                break;
            end;

            v59 = v59 + 1;
            local Instance = v62.Instance;
            local Position = v62.Position;
            v60 = (Position - v61).Magnitude;

            if v59 >= 64 then
                v58 = v60;
                v60 = v57;
            else
                local v63;

                if 1 - (1 - Instance.Transparency) * (1 - Instance.LocalTransparencyModifier) < 0.25 then
                    v63 = u1 or Instance.CanCollide;

                    if v63 then
                        if u37 == (Instance:GetRootPart() or Instance) then
                            v63 = false;
                        else
                            v63 = not Instance:IsA("TrussPart");
                        end;
                    end;
                else
                    v63 = false;
                end;

                if v63 then
                    u7.FilterDescendantsInstances = { Instance };

                    if workspace:Raycast(v56, Position - v56, u7) then
                        local v64;

                        if p53 then
                            v64 = workspace:Raycast(p53, v56 - p53, u7) or workspace:Raycast(v56, p53 - v56, u7);
                        else
                            v64 = false;
                        end;

                        if v64 then
                            v58 = v60;
                            v60 = v57;
                        elseif v55 >= v57 then
                            v60 = v57;
                        end;
                    else
                        v58 = v60;
                        v60 = v57;
                    end;
                else
                    v60 = v57;
                end;
            end;

            u6:AddToFilter(Instance);
            p50 = Position - p51 * 0.001;

            if v58 < (1 / 0) or not Instance then
                break;
            end;

            v57 = v60;
        end;
    else
        local v65 = p50;

        while true do
            local v66;

            if true then
                local v67;
                v66, v67 = workspace:FindPartOnRayWithIgnoreList(new(p50, v56 - p50), u26, false, true);
                v59 = v59 + 1;

                if v66 then
                    local v68 = v59 >= 64;
                    local v69;

                    if 1 - (1 - v66.Transparency) * (1 - v66.LocalTransparencyModifier) < 0.25 then
                        v69 = u1 or v66.CanCollide;

                        if v69 then
                            if u37 == (v66:GetRootPart() or v66) then
                                v69 = false;
                            else
                                v69 = not v66:IsA("TrussPart");
                            end;
                        end;
                    else
                        v69 = false;
                    end;

                    if v69 or v68 then
                        local v70 = { v66 };
                        local v71 = workspace:FindPartOnRayWithWhitelist(new(v56, v67 - v56), v70, true);
                        v60 = (v67 - v65).Magnitude;

                        if v71 and not v68 then
                            local v72;

                            if p53 then
                                v72 = workspace:FindPartOnRayWithWhitelist(new(p53, v56 - p53), v70, true) or workspace:FindPartOnRayWithWhitelist(new(v56, p53 - v56), v70, true);
                            else
                                v72 = false;
                            end;

                            if v72 then
                                v58 = v60;
                                v60 = v57;
                            elseif v55 >= v57 then
                                v60 = v57;
                            end;
                        else
                            v58 = v60;
                            v60 = v57;
                        end;
                    else
                        v60 = v57;
                    end;

                    u26[#u26 + 1] = v66;
                    p50 = v67 - p51 * 0.001;
                else
                    v60 = v57;
                end;
            end;

            if v58 < (1 / 0) or not v66 then
                break;
            end;

            v57 = v60;
        end;

        local v73 = u26;

        for i = #v73, v54 + 1, -1 do
            v73[i] = nil;
        end;
    end;

    debug.profileend();

    return v60 - u14, v58 - u14;
end;

local function queryViewport(p74, p75) -- Line: 361
    -- upvalues: u5 (ref), u2 (copy), u4 (copy), u12 (ref), u13 (ref), u14 (ref), queryPoint (copy)
    debug.profilebegin("queryViewport");
    local p = p74.p;
    local rightVector = p74.rightVector;
    local upVector = p74.upVector;
    local v76 = -p74.lookVector;
    local v77;

    if u2 then
        v77 = u4:getCamera();
    else
        v77 = u5;
    end;

    u5 = v77;
    local ViewportSize = u5.ViewportSize;
    local v78 = (1 / 0);
    local v79 = (1 / 0);

    for i = 0, 1 do
        local v80 = rightVector * ((i - 0.5) * u12);

        for i2 = 0, 1 do
            local v81, v82 = queryPoint(p + u14 * (v80 + upVector * ((i2 - 0.5) * u13)), v76, p75, u5:ViewportPointToRay(ViewportSize.x * i, ViewportSize.y * i2).Origin);

            if v82 >= v78 then
                v82 = v78;
            end;

            if v81 < v79 then
                v79 = v81;
                v78 = v82;
            else
                v78 = v82;
            end;
        end;
    end;

    debug.profileend();

    return v79, v78;
end;

local function testPromotion(p83, p84, p85) -- Line: 404
    -- upvalues: getCollisionPoint (copy), min (copy), queryPoint (copy), u41 (copy)
    debug.profilebegin("testPromotion");
    local p = p83.p;
    local rightVector = p83.rightVector;
    local upVector = p83.upVector;
    local v86 = -p83.lookVector;
    debug.profilebegin("extrapolate");
    local Magnitude = (getCollisionPoint(p, p85.posVelocity * 1.25) - p).Magnitude;

    for i = 0, min(1.25, p85.rotVelocity.magnitude + Magnitude / p85.posVelocity.magnitude), 0.0625 do
        local v87 = p85.extrapolate(i);

        if p84 <= queryPoint(v87.p, -v87.lookVector, p84) then
            return false;
        end;
    end;

    debug.profileend();
    debug.profilebegin("testOffsets");

    for _, v in ipairs(u41) do
        local v88 = getCollisionPoint(p, rightVector * v.x + upVector * v.y);

        if queryPoint(v88, (p + v86 * p84 - v88).Unit, p84) == (1 / 0) then
            return false;
        end;
    end;

    debug.profileend();
    debug.profileend();

    return true;
end;

return function(p89, p90, p91) -- Line: 453, Name: Popper
    -- upvalues: u37 (ref), u38 (ref), queryViewport (copy), testPromotion (copy)
    debug.profilebegin("popper");
    u37 = u38 and u38:GetRootPart() or u38;
    local v92, v93 = queryViewport(p89, p90);

    if v93 >= p90 then
        v93 = p90;
    end;

    if v92 < v93 then
        if not testPromotion(p89, p90, p91) then
            v92 = v93;
        end;
    else
        v92 = v93;
    end;

    u37 = nil;
    debug.profileend();

    return v92;
end;