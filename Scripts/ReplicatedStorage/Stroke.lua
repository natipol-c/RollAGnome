--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Stroke
  Path:     game.ReplicatedStorage.Library.Imported.EasyVisuals.Stroke
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:00 2026
]]

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4, p5) -- Line: 32
    -- upvalues: RunService (copy), u1 (copy)
    assert(p2, "UIInstance not provided");
    local v6 = p2:IsA("GuiObject") or p2:IsA("UIStroke");
    assert(v6, "UIInstance is not a GuiObject or UIStroke");
    assert(p3, "Size not provided");
    local v7 = typeof(p3) == "number";
    assert(v7, "Size is not a number");

    if p4 then
        local v8 = typeof(p4) == "Color3";
        assert(v8, "Color is not a Color3");
    end;

    if p5 then
        local v9 = typeof(p5) == "number";
        assert(v9, "Transparency is not a number");
    end;

    local u10 = {
        UIInstance = p2,
        Instance = p2:FindFirstChildWhichIsA("UIStroke") or Instance.new("UIStroke"),
        IsPaused = false,
        Color = p4 or Color3.new(1, 1, 1),
        ColorTarget = p4 or Color3.new(1, 1, 1),
        ColorAcceleration = 1,
        Transparency = p5 or 0,
        TransparencyTarget = p5 or 0,
        TransparencyAcceleration = 1,
        Size = p3,
        SizeTarget = p3,
        SizeAcceleration = 1,
        Connection = nil,
        IsText = false
    };

    if p2:IsA("TextLabel") or (p2:IsA("TextBox") or p2:IsA("TextButton")) then
        u10.IsText = true;
    end;

    u10.Instance.Parent = u10.UIInstance;
    u10.Connection = RunService.Heartbeat:Connect(function(p11) -- Line: 70
        -- upvalues: u10 (copy)
        if u10.IsPaused then
            return;
        end;

        if not u10.UIInstance or u10.UIInstance.Parent == nil then
            u10:Destroy();

            return;
        end;

        u10.Color = u10.Color:Lerp(u10.ColorTarget, u10.ColorAcceleration * p11);
        u10.Size = u10.Size + (u10.SizeTarget - u10.Size) * u10.SizeAcceleration * p11;
        u10.Transparency = u10.Transparency + (u10.TransparencyTarget - u10.Transparency) * u10.TransparencyAcceleration * p11;
        u10.Instance.Transparency = u10.Transparency;
        u10.Instance.Color = u10.Color;
        u10.Instance.Thickness = u10.Size;
    end);

    return setmetatable(u10, u1);
end;

function u1.SetSize(p12, p13, p14) -- Line: 92
    local v15 = typeof(p13) == "number";
    assert(v15, "Size isn\'t a number");
    local v16 = typeof(p14) == "number";
    assert(v16, "Acceleration isn\'t a number");
    p12.SizeTarget = p13;
    p12.SizeAcceleration = math.clamp(p14, 0, 1);
end;

function u1.SetTransparency(p17, p18, p19) -- Line: 102
    local v20 = typeof(p18) == "number";
    assert(v20, "Transparency isn\'t a number");
    local v21 = typeof(p19) == "number";
    assert(v21, "Acceleration isn\'t a number");
    p17.TransparencyTarget = p18;
    p17.TransparencyAcceleration = math.clamp(p19, 0, 1);
end;

function u1.SetColor(p22, p23, p24) -- Line: 112
    local v25 = typeof(p23) == "Color3";
    assert(v25, "Color isn\'t a Color3");
    local v26 = typeof(p24) == "number";
    assert(v26, "Acceleration isn\'t a number");
    p22.ColorTarget = p23;
    p22.ColorAcceleration = math.clamp(p24, 0, 1);
end;

function u1.Pause(p27) -- Line: 122
    p27.IsPaused = true;
end;

function u1.Resume(p28) -- Line: 126
    p28.IsPaused = false;
end;

function u1.Destroy(p29) -- Line: 130
    p29.Connection:Disconnect();

    if p29.Instance then
        p29.Instance:Destroy();
        p29.Instance = nil;
    end;
end;

return table.freeze(u1);