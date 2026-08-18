--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Dropshadow
  Path:     game.ReplicatedStorage.Library.Imported.EasyVisuals.Dropshadow
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:04 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4, p5) -- Line: 30
    -- upvalues: RunService (copy), u1 (copy)
    assert(p2, "UIInstance not provided");
    local v6 = p2:IsA("GuiObject") or p2:IsA("UIStroke");
    assert(v6, "UIInstance is not a GuiObject or UIStroke");

    if p3 then
        local v7 = typeof(p3) == "Color3";
        assert(v7, "Color is not a Color3");
    end;

    if p4 then
        local v8 = typeof(p4) == "number";
        assert(v8, "Transparency is not a number");
    end;

    if p5 then
        local v9 = typeof(p5) == "Vector2";
        assert(v9, "Offset is not a Vector2");
    end;

    local u10 = {
        UIInstance = p2,
        Instance = p2:Clone(),
        IsPaused = false,
        Color = p3 or Color3.new(),
        ColorTarget = p3 or Color3.new(),
        ColorAcceleration = 1,
        Transparency = p4 or 0,
        TransparencyTarget = p4 or 0,
        TransparencyAcceleration = 1,
        Offset = p5 or Vector2.new(-4, 4),
        OffsetTarget = p5 or Vector2.new(),
        OffsetAcceleration = 1,
        Connection = nil,
        IsText = false
    };
    u10.Instance.Size = UDim2.new(1, 0, 1, 0);
    u10.Instance:ClearAllChildren();
    u10.Instance.Position = UDim2.new(0, u10.Offset.X, 0, u10.Offset.Y);

    if p2:IsA("TextLabel") or (p2:IsA("TextBox") or p2:IsA("TextButton")) then
        u10.Instance.TextColor3 = u10.Color;
        u10.IsText = true;
    end;

    u10.Instance.Parent = u10.UIInstance;
    u10.Connection = RunService.Heartbeat:Connect(function(p11) -- Line: 73
        -- upvalues: u10 (copy)
        if u10.IsPaused then
            return;
        end;

        if not u10.UIInstance or u10.UIInstance.Parent == nil then
            u10:Destroy();

            return;
        end;

        u10.Color = u10.Color:Lerp(u10.ColorTarget, u10.ColorAcceleration);
        u10.Offset = u10.Offset:Lerp(u10.OffsetTarget, u10.OffsetAcceleration);
        u10.Transparency = u10.Transparency + (u10.TransparencyTarget - u10.Transparency) * u10.TransparencyAcceleration;
        u10.Instance.Position = UDim2.new(0, u10.Offset.X, 0, u10.Offset.Y);

        if u10.IsText then
            u10.Instance.Text = u10.UIInstance.Text;
            u10.Instance.TextTransparency = u10.Transparency;
            u10.Instance.TextColor3 = u10.Color;
        end;

        u10.Instance.ZIndex = u10.UIInstance.ZIndex - 1;
    end);

    return setmetatable(u10, u1);
end;

function u1.SetOffset(p12, p13, p14) -- Line: 101
    local v15 = typeof(p13) == "Vector2";
    assert(v15, "Offset isn\'t a Vector2");
    local v16 = typeof(p14) == "number";
    assert(v16, "Acceleration isn\'t a number");
    p12.OffsetTarget = p13;
    p12.OffsetAcceleration = math.clamp(p14, 0, 1);
end;

function u1.SetTransparency(p17, p18, p19) -- Line: 111
    local v20 = typeof(p18) == "number";
    assert(v20, "Transparency isn\'t a number");
    local v21 = typeof(p19) == "number";
    assert(v21, "Acceleration isn\'t a number");
    p17.TransparencyTarget = p18;
    p17.TransparencyAcceleration = math.clamp(p19, 0, 1);
end;

function u1.SetColor(p22, p23, p24) -- Line: 121
    local v25 = typeof(p23) == "Color3";
    assert(v25, "Color isn\'t a Color3");
    local v26 = typeof(p24) == "number";
    assert(v26, "Acceleration isn\'t a number");
    p22.ColorTarget = p23;
    p22.ColorAcceleration = math.clamp(p24, 0, 1);
end;

function u1.Pause(p27) -- Line: 131
    p27.IsPaused = true;
end;

function u1.Resume(p28) -- Line: 135
    p28.IsPaused = false;
end;

function u1.Destroy(p29) -- Line: 139
    p29.Connection:Disconnect();

    if p29.Instance then
        p29.Instance:Destroy();
        p29.Instance = nil;
    end;
end;

return table.freeze(u1);