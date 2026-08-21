--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PathDisplay
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.ControlModule.PathDisplay
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:41 2026
]]

-- Decompiled with Potassium's decompiler.

local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local u1 = require(CommonUtils:WaitForChild("FlagUtil")).getUserFlag("UserRaycastUpdateAPI2");
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Exclude;
local u3 = {
    spacing = 8,
    image = "rbxasset://textures/Cursors/Gamepad/Pointer.png",
    imageSize = Vector2.new(2, 2)
};
local Model = Instance.new("Model");
Model.Name = "PathDisplayPoints";
local Part = Instance.new("Part");
Part.Anchored = true;
Part.CanCollide = false;
Part.Transparency = 1;
Part.Name = "PathDisplayAdornee";
Part.CFrame = CFrame.new(0, 0, 0);
Part.Parent = Model;
local u4 = 30;
local u5 = {};
local u6 = {};
local u7 = {};

for i = 1, u4 do
    local ImageHandleAdornment = Instance.new("ImageHandleAdornment");
    ImageHandleAdornment.Archivable = false;
    ImageHandleAdornment.Adornee = Part;
    ImageHandleAdornment.Image = u3.image;
    ImageHandleAdornment.Size = u3.imageSize;
    u5[i] = ImageHandleAdornment;
end;

local function retrieveFromPool() -- Line: 41
    -- upvalues: u5 (copy), u4 (ref)
    local v8 = u5[1];

    if not v8 then
        return nil;
    end;

    u5[1] = u5[u4];
    u5[u4] = nil;
    u4 = u4 - 1;

    return v8;
end;

local function returnToPool(p9) -- Line: 52
    -- upvalues: u4 (ref), u5 (copy)
    u4 = u4 + 1;
    u5[u4] = p9;
end;

local function renderPoint(p10, p11) -- Line: 57
    -- upvalues: u4 (ref), u5 (copy), u1 (copy), u2 (copy), Model (copy)
    if u4 == 0 then
        return nil;
    end;

    local v12 = u5[1];

    if v12 then
        u5[1] = u5[u4];
        u5[u4] = nil;
        u4 = u4 - 1;
    else
        v12 = nil;
    end;

    if u1 then
        u2.FilterDescendantsInstances = { game.Players.LocalPlayer.Character, workspace.CurrentCamera };
        local v13 = workspace:Raycast(p10 + Vector3.new(0, 2, 0), Vector3.new(0, -8, 0), u2);

        if not v13 then
            return nil;
        end;

        v12.CFrame = CFrame.lookAlong(v13.Position, v13.Normal);
        v12.Parent = Model;

        return v12;
    end;

    local v14 = Ray.new(p10 + Vector3.new(0, 2, 0), Vector3.new(0, -8, 0));
    local v15, v16, v17 = workspace:FindPartOnRayWithIgnoreList(v14, { game.Players.LocalPlayer.Character, workspace.CurrentCamera });

    if not v15 then
        return nil;
    end;

    v12.CFrame = CFrame.new(v16, v16 + v17);
    v12.Parent = Model;

    return v12;
end;

function u3.setCurrentPoints(p18) -- Line: 89
    -- upvalues: u6 (ref)
    if typeof(p18) == "table" then
        u6 = p18;

        return;
    end;

    u6 = {};
end;

function u3.clearRenderedPath() -- Line: 97
    -- upvalues: u7 (ref), u4 (ref), u5 (copy), Model (copy)
    for _, v in ipairs(u7) do
        v.Parent = nil;
        u4 = u4 + 1;
        u5[u4] = v;
    end;

    u7 = {};
    Model.Parent = nil;
end;

function u3.renderPath() -- Line: 106
    -- upvalues: u3 (copy), u6 (ref), u7 (ref), renderPoint (copy), Model (copy)
    u3.clearRenderedPath();

    if not u6 or #u6 == 0 then
        return;
    end;

    local v19 = #u6;
    u7[1] = renderPoint(u6[v19], true);

    if not u7[1] then
        return;
    end;

    local v20 = 0;

    while true do
        local v21 = u6[v19];

        if v19 < 2 then
            break;
        end;

        local v22 = u6[v19 - 1] - v21;
        local magnitude = v22.magnitude;

        if magnitude < v20 then
            v20 = v20 - magnitude;
            v19 = v19 - 1;
        else
            local v23 = renderPoint(v21 + v22.unit * v20, false);

            if v23 then
                u7[#u7 + 1] = v23;
            end;

            v20 = v20 + u3.spacing;
        end;
    end;

    Model.Parent = workspace.CurrentCamera;
end;

return u3;