--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Rarities
  Path:     game.ReplicatedStorage.Library.Configs.Rarities
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:30 2026
]]

-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local u1 = {
    Common = {
        rotation = 90,
        order = 1,
        color = ColorSequence.new(Color3.fromRGB(217, 217, 217), Color3.fromRGB(158, 158, 158))
    },
    Uncommon = {
        order = 2,
        color = ColorSequence.new(Color3.fromRGB(132, 255, 0), Color3.fromRGB(23, 226, 0))
    },
    Rare = {
        order = 3,
        color = ColorSequence.new(Color3.fromRGB(0, 208, 255), Color3.fromRGB(0, 157, 255))
    },
    Epic = {
        rotation = 90,
        order = 4,
        color = ColorSequence.new(Color3.fromRGB(255, 0, 251), Color3.fromRGB(204, 0, 255))
    },
    Legendary = {
        order = 5,
        color = ColorSequence.new(Color3.fromRGB(255, 234, 0), Color3.fromRGB(255, 149, 0))
    },
    Mythic = {
        rotation = 0,
        order = 6,
        color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 60, 60)),
            ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 140, 40)),
            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 220, 50)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(70, 220, 70)),
            ColorSequenceKeypoint.new(0.66, Color3.fromRGB(70, 120, 255)),
            ColorSequenceKeypoint.new(0.83, Color3.fromRGB(130, 70, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 70, 255))
        })
    },
    Secret = {
        push = true,
        speed = 0.8,
        rotation = 90,
        order = 7,
        color = ColorSequence.new(Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 143, 145), Color3.fromRGB(62, 0, 1))
    },
    Godly = {
        push = true,
        speed = 0.7,
        rotation = 90,
        order = 7.5,
        color = ColorSequence.new(Color3.fromRGB(255, 230, 120), Color3.fromRGB(255, 120, 0))
    },
    ROBUX = {
        push = true,
        speed = 0.5,
        rotation = 15,
        order = 8,
        color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 100)),
            ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 120, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0, 255, 100)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 255))
        })
    },
    IMPOSSIBLE = {
        rotation = 0,
        order = 8,
        color = ColorSequence.new(Color3.fromRGB(255, 0, 255), Color3.fromRGB(255, 0, 0))
    },
    ["???"] = {
        rotation = 0,
        order = 8,
        color = ColorSequence.new(Color3.fromRGB(255, 0, 255), Color3.fromRGB(255, 0, 0))
    },
    VOID = {
        rotation = 90,
        order = 8.5,
        color = ColorSequence.new(Color3.fromRGB(80, 0, 120), Color3.fromRGB(20, 0, 40))
    },
    HELLFIRE = {
        push = true,
        speed = 0.6,
        rotation = 90,
        order = 9,
        color = ColorSequence.new(Color3.fromRGB(255, 60, 0), Color3.fromRGB(255, 0, 0))
    },
    CELESTIAL = {
        push = true,
        speed = 0.5,
        rotation = 0,
        order = 10,
        color = ColorSequence.new(Color3.fromRGB(255, 255, 200), Color3.fromRGB(180, 220, 255))
    }
};

local function animateGradient(u2, p3) -- Line: 116
    -- upvalues: TweenService (copy)
    if not p3.push then
        return;
    end;

    local UIGradient = u2.UIGradient;

    if not UIGradient then
        return;
    end;

    local GradientAnimConnection = u2:FindFirstChild("GradientAnimConnection");

    if GradientAnimConnection then
        GradientAnimConnection:Destroy();
    end;

    local BindableEvent = Instance.new("BindableEvent");
    BindableEvent.Name = "GradientAnimConnection";
    BindableEvent.Parent = u2;
    local u4 = 6 / (p3.speed or 1);
    local u5 = p3.rotation or 90;
    task.spawn(function() -- Line: 134
        -- upvalues: BindableEvent (copy), u2 (copy), UIGradient (copy), u5 (copy), TweenService (ref), u4 (copy)
        local u6 = true;
        BindableEvent.Destroying:Connect(function() -- Line: 136
            -- upvalues: u6 (ref)
            u6 = false;
        end);

        while u6 and (u2.Parent and (UIGradient and UIGradient.Parent)) do
            UIGradient.Rotation = u5;
            local v7 = TweenService:Create(UIGradient, TweenInfo.new(u4, Enum.EasingStyle.Linear), {
                Rotation = u5 + 360
            });
            v7:Play();
            v7.Completed:Wait();

            if not (u6 and UIGradient.Parent) then
                break;
            end;
        end;
    end);
end;

function u1.SetLabel(p8, p9, p10) -- Line: 157
    -- upvalues: u1 (copy), animateGradient (copy)
    local UIGradient = p10.UIGradient;

    if not UIGradient then
        warn("NO GRADIENT FOUND");

        return;
    end;

    local v11 = u1[p9];
    local v12;

    if v11 then
        v12 = p9;
    else
        v12 = "Common";
        v11 = u1[v12];
    end;

    p10.Text = tostring(p9 or v12);
    UIGradient.Color = v11.color;
    UIGradient.Rotation = v11.rotation or 90;
    animateGradient(p10, v11);
end;

function u1.SetColor(p13, p14, p15) -- Line: 173
    -- upvalues: u1 (copy), animateGradient (copy)
    local UIGradient = p15.UIGradient;

    if not UIGradient then
        return;
    end;

    local v16 = u1[p14] or u1.Common;
    UIGradient.Color = v16.color;
    UIGradient.Rotation = v16.rotation or 90;
    animateGradient(p15, v16);
end;

return u1;