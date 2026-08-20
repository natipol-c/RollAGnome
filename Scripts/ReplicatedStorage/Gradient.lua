--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Gradient
  Path:     game.ReplicatedStorage.Library.Imported.EasyVisuals.Gradient
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:00 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");

local function evalColorSequence(p1, p2) -- Line: 58
    local v3 = p2 + 1;
    local v4 = {};

    for i = 0, 2 do
        for i2 = 1, #p1 do
            table.insert(v4, {
                Time = p1[i2].Time + i,
                Value = p1[i2].Value
            });
        end;
    end;

    for i = 1, #v4 - 1 do
        local v5 = v4[i];
        local v6 = v4[i + 1];

        if v5.Time <= v3 and v3 < v6.Time then
            local v7 = (v3 - v5.Time) / (v6.Time - v5.Time);

            return Color3.new((v6.Value.R - v5.Value.R) * v7 + v5.Value.R, (v6.Value.G - v5.Value.G) * v7 + v5.Value.G, (v6.Value.B - v5.Value.B) * v7 + v5.Value.B);
        end;
    end;
end;

local function evalNumberSequence(p8, p9) -- Line: 86
    local v10 = p9 + 1;
    local v11 = {};

    for i = 0, 2 do
        for i2 = 1, #p8 do
            table.insert(v11, {
                Time = p8[i2].Time + i,
                Value = p8[i2].Value
            });
        end;
    end;

    for i = 1, #v11 - 1 do
        local v12 = v11[i];
        local v13 = v11[i + 1];

        if v12.Time <= v10 and v10 < v13.Time then
            return v12.Value + (v13.Value - v12.Value) * ((v10 - v12.Time) / (v13.Time - v12.Time));
        end;
    end;
end;

local u14 = {};
u14.__index = u14;

function u14.new(p15, p16, p17) -- Line: 115
    -- upvalues: RunService (copy), u14 (copy)
    assert(p15, "UIInstance not provided");
    local v18 = p15:IsA("GuiObject") or p15:IsA("UIStroke");
    assert(v18, "UIInstance is not a GuiObject or UIStroke");
    assert(p16, "ColorSequence not provided");
    assert(p17, "TransparencySequence not provided");
    local v19 = typeof(p16) == "ColorSequence";
    assert(v19, "ColorSequence is not a ColorSequence");
    local v20 = typeof(p17) == "number" and true or typeof(p17) == "NumberSequence";
    assert(v20, "TransparencySequence is not a number or NumberSequence");
    assert(#p16.Keypoints <= 19, "ColorSequence has too many keypoints");

    if typeof(p17) == "NumberSequence" then
        assert(#p17.Keypoints <= 19, "TransparencySequence has too many keypoints");
    end;

    local u21 = {
        UIInstance = p15,
        Instance = p15:FindFirstChildWhichIsA("UIGradient") or Instance.new("UIGradient"),
        IsPaused = false,
        ColorSequenceTarget = p16,
        ColorSequence = p16,
        TrueColorSequence = nil,
        ColorSequenceBlendRate = 1,
        TransparencySequenceTarget = nil,
        TransparencySequence = nil,
        TrueTransparencySequence = nil,
        TransparencySequenceBlendRate = 1,
        Offset = 0,
        OffsetTarget = nil,
        OffsetSpeed = 0,
        OffsetSpeedTarget = 0,
        OffsetAcceleration = 1,
        TransparencyOffset = 0,
        TransparencyOffsetTarget = nil,
        TransparencyOffsetSpeed = 0,
        TransparencyOffsetSpeedTarget = 0,
        TransparencyOffsetAcceleration = 1,
        Rotation = 0,
        RotationSpeed = 0,
        RotationSpeedTarget = 0,
        RotationAcceleration = 0,
        RotationTarget = nil,
        Connection = nil,
        IsText = false
    };

    if typeof(p17) == "number" then
        u21.TransparencySequenceTarget = NumberSequence.new({ NumberSequenceKeypoint.new(0, p17), NumberSequenceKeypoint.new(1, p17) });
    elseif typeof(p17) == "NumberSequence" then
        u21.TransparencySequenceTarget = p17;
    else
        warn("Weird type of data?");
    end;

    u21.TransparencySequence = u21.TransparencySequenceTarget;

    if p15:IsA("TextLabel") or (p15:IsA("TextBox") or p15:IsA("TextButton")) then
        u21.IsText = true;
    end;

    u21.Connection = RunService.Heartbeat:Connect(function(p22) -- Line: 178
        -- upvalues: u21 (copy)
        if u21.IsPaused then
            return;
        end;

        if not u21.UIInstance or u21.UIInstance.Parent == nil then
            u21:Destroy();

            return;
        end;

        if u21.ColorSequenceBlendRate == 1 then
            u21.ColorSequence = u21.ColorSequenceTarget;
        else
            u21:EqualizeColorSequenceKeypoints();
        end;

        if u21.TransparencySequenceBlendRate == 1 then
            u21.TransparencySequence = u21.TransparencySequenceTarget;
        end;

        if u21.OffsetTarget then
            u21.Offset = u21.Offset + (u21.OffsetTarget - u21.Offset) * u21.OffsetAcceleration;
        else
            u21.OffsetSpeed = u21.OffsetSpeed + (u21.OffsetSpeedTarget - u21.OffsetSpeed) * u21.OffsetAcceleration * p22;
            local v23 = u21;
            v23.Offset = v23.Offset + u21.OffsetSpeed * p22;
        end;

        if u21.TransparencyOffsetTarget then
            u21.TransparencyOffset = u21.TransparencyOffset + (u21.TransparencyOffsetTarget - u21.TransparencyOffset) * u21.TransparencyOffsetAcceleration;
        else
            u21.TransparencyOffsetSpeed = u21.TransparencyOffsetSpeed + (u21.TransparencyOffsetSpeedTarget - u21.TransparencyOffsetSpeed) * u21.TransparencyOffsetAcceleration * p22;
            local v24 = u21;
            v24.TransparencyOffset = v24.TransparencyOffset + u21.TransparencyOffsetSpeed * p22;
        end;

        if u21.RotationTarget then
            u21.Rotation = u21.Rotation + (u21.RotationTarget - u21.Rotation) * u21.RotationAcceleration;
        else
            u21.RotationSpeed = u21.RotationSpeed + (u21.RotationSpeedTarget - u21.RotationSpeed) * u21.RotationAcceleration * p22;
            local v25 = u21;
            v25.Rotation = v25.Rotation + u21.RotationSpeed * p22;
        end;

        u21.Instance.Rotation = u21.Rotation;
        u21.Instance.Color = u21:CalculateTrueColorSequence();
        u21.Instance.Transparency = u21:CalculateTrueTransparencySequence();
    end);
    u21.Instance.Parent = u21.UIInstance;

    return setmetatable(u21, u14);
end;

function u14.SetColorSequence(p26, p27, p28) -- Line: 228
    local v29 = typeof(p27) == "ColorSequence";
    assert(v29, "Sequence argument is nil or not a ColorSequence");
    p26.ColorSequenceBlendRate = p28 or 1;
    p26.ColorSequenceTarget = p27;

    return p26.ColorSequenceTarget;
end;

function u14.SetOffset(p30, p31, p32) -- Line: 237
    local v33 = typeof(p31) == "number";
    assert(v33, "Offset isn\'t a number");
    local v34 = typeof(p32) == "number";
    assert(v34, "Acceleration isn\'t a number");
    p30.OffsetTarget = p31;
    p30.OffsetSpeed = 0;
    p30.OffsetSpeedTarget = 0;
    p30.OffsetAcceleration = math.clamp(p32, 0, 1);
end;

function u14.SetOffsetSpeed(p35, p36, p37) -- Line: 249
    local v38 = typeof(p36) == "number";
    assert(v38, "Offset isn\'t a number");
    local v39 = typeof(p37) == "number";
    assert(v39, "Acceleration isn\'t a number");
    p35.OffsetSpeedTarget = p36;
    p35.OffsetTarget = nil;
    p35.OffsetAcceleration = math.clamp(p37, 0, 1);
end;

function u14.SetRotation(p40, p41, p42) -- Line: 260
    local v43 = typeof(p41) == "number";
    assert(v43, "Offset isn\'t a number");
    local v44 = typeof(p42) == "number";
    assert(v44, "Acceleration isn\'t a number");
    p40.RotationTarget = p41;
    p40.RotationSpeed = 0;
    p40.RotationSpeedTarget = 0;
    p40.RotationAcceleration = math.clamp(p42, 0, 1);
end;

function u14.SetRotationSpeed(p45, p46, p47) -- Line: 272
    local v48 = typeof(p46) == "number";
    assert(v48, "Offset isn\'t a number");
    local v49 = typeof(p47) == "number";
    assert(v49, "Acceleration isn\'t a number");
    p45.RotationSpeedTarget = p46;
    p45.RotationTarget = nil;
    p45.RotationAcceleration = math.clamp(p47, 0, 1);
end;

function u14.SetTransparencyOffset(p50, p51, p52) -- Line: 283
    local v53 = typeof(p51) == "number";
    assert(v53, "Offset isn\'t a number");
    local v54 = typeof(p52) == "number";
    assert(v54, "Acceleration isn\'t a number");
    p50.TransparencyOffsetTarget = p51;
    p50.TransparencyOffsetSpeed = 0;
    p50.TransparencyOffsetSpeedTarget = 0;
    p50.TransparencyOffsetAcceleration = math.clamp(p52, 0, 1);
end;

function u14.SetTransparencyOffsetSpeed(p55, p56, p57) -- Line: 295
    local v58 = typeof(p56) == "number";
    assert(v58, "Offset isn\'t a number");
    local v59 = typeof(p57) == "number";
    assert(v59, "Acceleration isn\'t a number");
    p55.TransparencyOffsetSpeedTarget = p56;
    p55.TransparencyOffsetTarget = nil;
    p55.TransparencyOffsetAcceleration = math.clamp(p57, 0, 1);
end;

function u14.SetTransparencySequence(p60, p61, p62) -- Line: 306
    assert(p61, "Transparency is nil");
    local v63 = typeof(p62) == "number";
    assert(v63, "Acceleration isn\'t a number");

    if typeof(p61) == "number" then
        p60.TransparencyTarget = NumberSequence.new({ NumberSequenceKeypoint.new(0, p61), NumberSequenceKeypoint.new(1, p61) });
    elseif typeof(p61) == "NumberSequence" then
        p60.TransparencyTarget = p61;
    else
        warn("Weird type of data?");
    end;

    p60.TransparencyAcceleration = math.clamp(p62, 0, 1);
end;

function u14.EqualizeColorSequenceKeypoints(p64) -- Line: 323
    -- upvalues: evalColorSequence (copy)
    local Keypoints = p64.ColorSequenceTarget.Keypoints;
    local Keypoints2 = p64.ColorSequence.Keypoints;
    local v65 = {};

    if #Keypoints == #Keypoints2 then
        for _, v in Keypoints do
            local v66 = evalColorSequence(Keypoints2, v.Time):Lerp(v.Value, p64.ColorSequenceBlendRate);
            local v67 = ColorSequenceKeypoint.new(v.Time, v66);
            table.insert(v65, v67);
        end;
    else
        for _, v in Keypoints do
            local v68 = ColorSequenceKeypoint.new(v.Time, evalColorSequence(Keypoints2, v.Time));
            table.insert(v65, v68);
        end;
    end;

    p64.ColorSequence = ColorSequence.new(v65);
end;

function u14.EqualizeTransparencySequenceKeypoints(p69) -- Line: 345
    -- upvalues: evalNumberSequence (copy)
    local Keypoints = p69.TransparencySequenceTarget.Keypoints;
    local Keypoints2 = p69.TransparencySequence.Keypoints;
    local v70 = {};

    if #Keypoints == #Keypoints2 then
        for _, v in Keypoints do
            local v71 = evalNumberSequence(Keypoints2, v.Time):Lerp(v.Value, p69.TransparencySequenceBlendRate);
            local v72 = NumberSequenceKeypoint.new(v.Time, v71);
            table.insert(v70, v72);
        end;
    else
        for _, v in Keypoints do
            local v73 = NumberSequenceKeypoint.new(v.Time, evalNumberSequence(Keypoints2, v.Time));
            table.insert(v70, v73);
        end;
    end;

    print(v70[1].Value, v70[2].Value, v70[3].Value, v70[4].Value, v70[5].Value);
    p69.TransparencySequence = NumberSequence.new(v70);
end;

function u14.CalculateTrueColorSequence(p74) -- Line: 368
    -- upvalues: evalColorSequence (copy)
    local v75 = 100;
    local v76 = 5;
    local v77 = {};

    for _, v in p74.ColorSequence.Keypoints do
        local v78 = v.Time + p74.Offset;

        if v78 > 1 or v78 < 0 then
            v78 = v78 % 1;
        end;

        local v79 = ColorSequenceKeypoint.new(v78, v.Value);

        if v79.Time <= v75 then
            v77[v76 - 1] = v79;
            v76 = v76 - 1;
            v75 = v79.Time;
        else
            v77[#v77 + 1] = v79;
        end;
    end;

    local v80 = {};

    for _, v in v77 do
        table.insert(v80, v);
    end;

    table.sort(v80, function(p81, p82) -- Line: 393
        return p81.Time < p82.Time;
    end);

    if v80[1].Time ~= 0 then
        local v83 = ColorSequenceKeypoint.new(0, evalColorSequence(v80, 0));
        table.insert(v80, 1, v83);
    end;

    if v80[#v80].Time ~= 1 then
        local v84 = ColorSequenceKeypoint.new(1, evalColorSequence(v80, 1));
        table.insert(v80, v84);
    end;

    p74.TrueColorSequence = ColorSequence.new(v80);

    return p74.TrueColorSequence;
end;

function u14.CalculateTrueTransparencySequence(p85) -- Line: 411
    -- upvalues: evalNumberSequence (copy)
    if #p85.TransparencySequenceTarget.Keypoints == 2 and p85.TransparencySequenceTarget.Keypoints[1].Value == p85.TransparencySequenceTarget.Keypoints[2].Value then
        p85.TrueTransparencySequence = p85.TransparencySequenceTarget;

        return p85.TrueTransparencySequence;
    end;

    local v86 = #p85.TransparencySequence.Keypoints + 1;
    local v87 = (1 / 0);
    local v88 = {};

    for _, v in p85.TransparencySequence.Keypoints do
        local v89 = v.Time + p85.TransparencyOffset;

        if v89 > 1 or v89 < 0 then
            v89 = v89 % 1;
        end;

        local v90 = NumberSequenceKeypoint.new(v89, v.Value);

        if v90.Time <= v87 then
            v88[v86 - 1] = v90;
            v86 = v86 - 1;
            v87 = v90.Time;
        else
            v88[#v88 + 1] = v90;
        end;
    end;

    local v91 = {};

    for _, v in v88 do
        table.insert(v91, v);
    end;

    table.sort(v91, function(p92, p93) -- Line: 443
        return p92.Time < p93.Time;
    end);

    if v91[1].Time ~= 0 then
        local v94 = NumberSequenceKeypoint.new(0, evalNumberSequence(v91, 0));
        table.insert(v91, 1, v94);
    end;

    if v91[#v91].Time ~= 1 then
        local v95 = evalNumberSequence(v91, 1);
        local v96 = NumberSequenceKeypoint.new(1, v95);
        table.insert(v91, v96);
    end;

    p85.TrueTransparencySequence = NumberSequence.new(v91);

    return p85.TrueTransparencySequence;
end;

function u14.Pause(p97) -- Line: 462
    p97.IsPaused = true;
end;

function u14.Resume(p98) -- Line: 466
    p98.IsPaused = false;
end;

function u14.Destroy(p99) -- Line: 470
    p99.Connection:Disconnect();

    if p99.Instance then
        p99.Instance:Destroy();
        p99.Instance = nil;
    end;
end;

return table.freeze(u14);