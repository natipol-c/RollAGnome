--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ViewportModel
  Path:     game.ReplicatedStorage.Library.Imported.ViewportModel
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:24 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = { 0, 1, 2, 3, 4, 5, 6, 7 };
local u2 = { 0, 1, 3, 4, 5, 7 };
local u3 = { 0, 1, 4, 5, 6 };

local function GetIndices(p4) -- Line: 13
    -- upvalues: u2 (copy), u3 (copy), u1 (copy)
    if p4:IsA("WedgePart") then
        return u2;
    end;

    if p4:IsA("CornerWedgePart") then
        return u3;
    end;

    return u1;
end;

local function GetCorners(p5, p6, p7) -- Line: 26
    local v8 = table.create(#p7);

    for i, v in p7 do
        local v9 = math.floor(v * 0.25) % 2 * 2 - 1;
        local v10 = math.floor(v * 0.5) % 2 * 2 - 1;
        v8[i] = p5 * (p6 * Vector3.new(v9, v10, v % 2 * 2 - 1));
    end;

    return v8;
end;

local function GetModelPointCloud(p11) -- Line: 42
    -- upvalues: u2 (copy), u3 (copy), u1 (copy), GetCorners (copy)
    local v12 = p11:GetDescendants();
    local v13 = table.create(#v12 * 5);

    for _, v in v12 do
        if v:IsA("BasePart") then
            local v14;

            if v:IsA("WedgePart") then
                v14 = u2;
            elseif v:IsA("CornerWedgePart") then
                v14 = u3;
            else
                v14 = u1;
            end;

            local v15 = GetCorners(v.CFrame, v.Size * 0.5, v14);
            table.move(v15, 1, #v15, #v13 + 1, v13);
        end;
    end;

    return v13;
end;

local function ViewProjectionEdgeHits(p16, p17, p18, p19) -- Line: 63
    local v20 = (-1 / 0);
    local v21 = (1 / 0);

    for _, v in p16 do
        local v22 = p19 * (p18 - v.Z);
        local v23 = v[p17] + v22;
        local v24 = v[p17] - v22;
        v20 = math.max(v20, v23, v24);
        v21 = math.min(v21, v23, v24);
    end;

    return v20, v21;
end;

local u25 = {};
u25.__index = u25;

function u25.new(p26, p27) -- Line: 116
    -- upvalues: u25 (copy)
    local v28 = setmetatable({
        Model = nil,
        _ModelSize = Vector3.new(0, 0, 0),
        _ModelRadius = 0,
        _Viewport = nil,
        ViewportFrame = p26,
        Camera = p27,
        _Points = {},
        _ModelCFrame = CFrame.identity
    }, u25);
    v28:Calibrate();

    return v28;
end;

function u25.SetModel(p29, p30) -- Line: 139
    -- upvalues: GetModelPointCloud (copy)
    local v31, v32 = p30:GetBoundingBox();
    p29.Model = p30;
    p29._Points = GetModelPointCloud(p30);
    p29._ModelCFrame = v31;
    p29._ModelSize = v32;
    p29._ModelRadius = v32.Magnitude * 0.5;
end;

function u25.Calibrate(p33) -- Line: 152
    local AbsoluteSize = p33.ViewportFrame.AbsoluteSize;
    local v34 = AbsoluteSize.X / AbsoluteSize.Y;
    local v35 = math.rad(p33.Camera.FieldOfView * 0.5);
    local v36 = math.tan(v35);
    local v37 = math.atan(v36 * v34);
    local v38 = math.tan(v37);
    local v39 = math.atan(v36) * math.min(1, v34);
    p33._Viewport = {
        Aspect = v34,
        Y_Fov2 = v35,
        TanY_Fov2 = v36,
        X_Fov2 = v37,
        TanX_Fov2 = v38,
        C_Fov2 = v39,
        SinC_Fov2 = math.sin(v39)
    };
end;

function u25.GetFitDistance(p40, p41) -- Line: 184
    return (p40._ModelRadius + (not p41 and 0 or (p41 - p40._ModelCFrame.Position).Magnitude)) / p40._Viewport.SinC_Fov2;
end;

function u25.GetMinimumFitCFrame(p42, p43) -- Line: 193
    -- upvalues: ViewProjectionEdgeHits (copy)
    if not p42.Model then
        return CFrame.identity;
    end;

    local v44 = (p43 - p43.Position):Inverse();
    local _Points = p42._Points;
    local v45 = table.create(#_Points);
    local v46 = 0;

    for i, v in _Points do
        local v47 = v44 * v;
        v46 = math.min(v46, v47.Z);
        v45[i] = v47;
    end;

    local v48, v49 = ViewProjectionEdgeHits(v45, "X", v46, p42._Viewport.TanX_Fov2);
    local v50, v51 = ViewProjectionEdgeHits(v45, "Y", v46, p42._Viewport.TanY_Fov2);
    local v52 = math.max((v48 - v49) * 0.5 / p42._Viewport.TanX_Fov2, (v50 - v51) * 0.5 / p42._Viewport.TanY_Fov2);

    return p43 * CFrame.new((v48 + v49) * 0.5, (v50 + v51) * 0.5, v46 + v52);
end;

return u25;