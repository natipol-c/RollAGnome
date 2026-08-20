--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     EasyVisuals
  Path:     game.ReplicatedStorage.Library.Imported.EasyVisuals
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:00 2026
]]

-- Decompiled with Potassium's decompiler.

local Presets = script.Presets;
local u1 = {
    Gradient = require(script.Gradient),
    Stroke = require(script.Stroke),
    Dropshadow = require(script.Dropshadow),
    Templates = require(script.GradientTemplates)
};
u1.__index = u1;
u1.CurrentEffects = {};
local u2 = {
    GuiObject = "Visible",
    ScreenGui = "Enabled",
    BillboardGui = "Enabled",
    SurfaceGui = "Enabled"
};

local function ValidateIsPreset(p3) -- Line: 32
    -- upvalues: Presets (copy)
    return Presets:FindFirstChild(p3) ~= nil;
end;

function u1.new(u4, p5, p6, p7, p8, p9, p10, p11) -- Line: 36
    -- upvalues: Presets (copy), u2 (copy), u1 (copy)
    assert(u4, "UIInstance not provided");
    assert(p5, "EffectType not provided");
    local v12 = u4:IsA("GuiObject");
    assert(v12, "UIInstance is not a GuiObject");
    local v13 = typeof(p5) == "string";
    assert(v13, "effectType is not a string");
    local v14 = Presets:FindFirstChild(p5) ~= nil;
    assert(v14, "effectType is not a valid preset");

    if p6 then
        local v15 = typeof(p6) == "number";
        assert(v15, "speed is not a number");
    end;

    if p7 then
        local v16 = typeof(p7) == "number";
        assert(v16, "size is not a number");
    end;

    if p9 then
        local v17 = typeof(p9) == "ColorSequence" and true or typeof(p9) == "Color3";
        assert(v17, "customColor is not a ColorSequence or Color3");
    end;

    if p10 then
        local v18 = typeof(p10) == "NumberSequence" and true or typeof(p10) == "number";
        assert(v18, "customTransparency is not a NumberSequence or number");
    end;

    local u19 = {
        IsPaused = false,
        Diagnostic = "DIAGNOSTIC VALUE",
        UIInstance = u4,
        ResumesOnShown = p11 == nil and true or p11,
        EffectObjects = {},
        SavedObjects = {},
        Connections = {},
        Speed = p6 or 0.007,
        Size = p7 or 1
    };

    local function RecursiveAncestryChanged(u20) -- Line: 69
        -- upvalues: u2 (ref), RecursiveAncestryChanged (copy), u19 (copy)
        if not u20 then
            return;
        end;

        if u20:IsA("PlayerGui") or u20:IsA("Workspace") then
            return;
        end;

        local u21 = u2[u20.ClassName];

        if not u21 then
            RecursiveAncestryChanged(u20.Parent);

            return;
        end;

        local Connections = u19.Connections;
        local v22 = u20:GetPropertyChangedSignal(u21);
        table.insert(Connections, v22:Connect(function() -- Line: 86
            -- upvalues: u19 (ref), u20 (copy), u21 (copy)
            u19.IsPaused = not u20[u21];

            if u19.IsPaused then
                u19:Pause();

                return;
            end;

            if u19.ResumesOnShown then
                u19:Resume();
            end;
        end));
        RecursiveAncestryChanged(u20.Parent);
    end;

    RecursiveAncestryChanged(u4);

    if p8 then
        for _, child in u4:GetChildren() do
            if child:IsA("UIStroke") or child:IsA("UIGradient") then
                table.insert(u19.SavedObjects, child);
                child.Parent = nil;
            end;
        end;
    end;

    local v23 = require(Presets:FindFirstChild(p5))(u4, u19.Speed, u19.Size, p9, p10);

    if v23.Connections then
        for _, v in v23.Connections do
            table.insert(u19.Connections, v);
        end;
    end;

    if v23.Effects then
        for _, v in v23.Effects do
            table.insert(u19.EffectObjects, v);
        end;
    end;

    u19.Connection = u4.AncestryChanged:Connect(function() -- Line: 124
        -- upvalues: u4 (copy), u19 (copy)
        if not u4:IsDescendantOf(game) then
            u19:Destroy();
        end;
    end);

    return setmetatable(u19, u1);
end;

function u1.Pause(p24) -- Line: 133
    for _, v in p24.EffectObjects do
        if v.Pause then
            v:Pause();
        end;
    end;
end;

function u1.Resume(p25) -- Line: 142
    for _, v in p25.EffectObjects do
        if v.Resume then
            v:Resume();
        end;
    end;
end;

function u1.Destroy(p26) -- Line: 151
    for _, v in p26.SavedObjects do
        v.Parent = p26.UIInstance;
    end;

    for _, v in p26.Connections do
        v:Disconnect();
    end;

    table.clear(p26.SavedObjects);
    table.clear(p26.Connections);

    for _, v in p26.EffectObjects do
        if v.Destroy then
            v:Destroy();
        end;
    end;

    p26.Connection:Disconnect();
end;

return table.freeze(u1);