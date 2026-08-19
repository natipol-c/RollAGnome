--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Mouse
  Path:     game.ReplicatedStorage.Library.Imported.Mouse
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:24 2026
]]

-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Camera = workspace.Camera;
local u1 = game.Players.LocalPlayer:GetMouse();

local function onRenderStep(p2, p3) -- Line: 7
    if p2.ticks % 2 == 0 then
        p2.currentPosition = p2:GetPosition();
    else
        p2.previousPosition = p2:GetPosition();
    end;

    p2.ticks = p2.ticks % 10 + 1;
end;

local u4 = {};
u4.__index = u4;

function u4.new() -- Line: 19
    -- upvalues: RunService (copy), u4 (copy)
    local u5 = {
        filterDescendants = {},
        filterType = nil,
        collisionGroup = "Default",
        rayLength = 150,
        currentPosition = Vector2.new(0, 0),
        previousPosition = Vector2.new(0, 0),
        ticks = 1
    };
    RunService:BindToRenderStep("MeasureMouseMovement", Enum.RenderPriority.Input.Value, function(p6) -- Line: 29
        -- upvalues: u5 (copy)
        local v7 = u5;

        if v7.ticks % 2 == 0 then
            v7.currentPosition = v7:GetPosition();
        else
            v7.previousPosition = v7:GetPosition();
        end;

        v7.ticks = v7.ticks % 10 + 1;
    end);
    setmetatable(u5, u4);

    return u5;
end;

function u4.GetViewSize(p8) -- Line: 37
    -- upvalues: Camera (copy)
    return Camera.ViewportSize;
end;

function u4.GetPosition(p9) -- Line: 41
    -- upvalues: UserInputService (copy)
    return UserInputService:GetMouseLocation();
end;

function u4.GetUnitRay(p10) -- Line: 45
    -- upvalues: Camera (copy)
    local v11 = p10:GetPosition();

    return Camera:ViewportPointToRay(v11.x, v11.y);
end;

function u4.GetOrigin(p12) -- Line: 50
    return p12:GetUnitRay().Origin;
end;

function u4.GetDelta(p13) -- Line: 54
    return p13.currentPosition - p13.previousPosition;
end;

function u4.ScreenPointToRay(p14) -- Line: 58
    local v15 = RaycastParams.new();
    v15.FilterDescendantsInstances = p14.filterDescendants;
    v15.FilterType = p14.filterType;
    v15.CollisionGroup = p14.collisionGroup;

    return v15;
end;

function u4.CastRay(p16) -- Line: 66
    local v17 = p16:ScreenPointToRay();

    return workspace:Raycast(p16:GetOrigin(), p16:GetUnitRay().Direction * p16.rayLength, v17);
end;

function u4.GetHit(p18) -- Line: 71
    local v19 = p18:CastRay();

    return v19 and v19.Position or nil;
end;

function u4.GetTarget(p20) -- Line: 76
    local v21 = p20:CastRay();

    return v21 and v21.Instance or nil;
end;

function u4.GetTargetFilter(p22) -- Line: 81
    return p22.filterDescendants;
end;

function u4.SetTargetFilter(p23, p24) -- Line: 85
    local v25 = typeof(p24);

    if v25 == "Instance" then
        p23.filterDescendants = { p24 };

        return;
    end;

    if v25 == "table" then
        p23.filterDescendants = p24;

        return;
    end;

    error("object expected an instance or a table of instances, received: " .. v25);
end;

function u4.SetCollisionGroup(p26, p27) -- Line: 96
    p26.collisionGroup = p27;
end;

function u4.GetRayLength(p28) -- Line: 100
    return p28.rayLength;
end;

function u4.SetRayLength(p29, p30) -- Line: 104
    local v31 = typeof(p30);
    local v32;

    if v31 == "number" then
        v32 = p30 >= 0;
    else
        v32 = false;
    end;

    assert(v32, "length expected a number, received: " .. v31);
    p29.rayLength = p30;
end;

function u4.GetFilterType(p33) -- Line: 110
    return p33.filterType;
end;

function u4.SetFilterType(p34, p35) -- Line: 114
    local v36 = Enum.RaycastFilterType:GetEnumItems();

    if table.find(v36, p35) then
        p34.filterType = p35;

        return;
    end;

    error("Invalid raycast filter type provided");
end;

function u4.EnableIcon(p37) -- Line: 123
    -- upvalues: UserInputService (copy)
    UserInputService.MouseIconEnabled = true;
end;

function u4.DisableIcon(p38) -- Line: 127
    -- upvalues: UserInputService (copy)
    UserInputService.MouseIconEnabled = false;
end;

function u4.ChangeIcon(p39, p40) -- Line: 131
    -- upvalues: u1 (copy)
    u1.Icon = p40;
end;

return u4;