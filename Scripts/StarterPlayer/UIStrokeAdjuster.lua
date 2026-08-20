--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     UIStrokeAdjuster
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.UIStrokeAdjuster
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:07 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = Vector2.new(1917, 1156);
local CollectionService = game:GetService("CollectionService");
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui", 100);
local CurrentCamera = workspace.CurrentCamera;
local u2 = false;

local function average(p3) -- Line: 43
    return (p3.X + p3.Y) / 2;
end;

local function getScreenRatio() -- Line: 48
    -- upvalues: CurrentCamera (copy), u1 (copy)
    local ViewportSize = CurrentCamera.ViewportSize;
    local v4 = u1;

    return (ViewportSize.X + ViewportSize.Y) / 2 / ((v4.X + v4.Y) / 2);
end;

local function tagRecursive(p5, u6, u7) -- Line: 54
    -- upvalues: CollectionService (copy), tagRecursive (copy)
    if p5:GetAttribute("Block") then
        return;
    end;

    if p5:IsA(u6) then
        CollectionService:AddTag(p5, u7);
    end;

    for _, child in p5:GetChildren() do
        tagRecursive(child, u6, u7);
    end;

    p5.ChildAdded:Connect(function(p8) -- Line: 63
        -- upvalues: tagRecursive (ref), u6 (copy), u7 (copy)
        tagRecursive(p8, u6, u7);
    end);
end;

local u9 = {};

local function updateStrokes() -- Line: 72
    -- upvalues: u2 (ref), CurrentCamera (copy), u1 (copy), u9 (copy)
    u2 = false;
    local ViewportSize = CurrentCamera.ViewportSize;
    local v10 = u1;
    local v11 = (ViewportSize.X + ViewportSize.Y) / 2 / ((v10.X + v10.Y) / 2);

    for i, v in u9 do
        if i.Parent then
            i.Thickness = v * v11;
        else
            u9[i] = nil;
        end;
    end;
end;

local function queueUpdate() -- Line: 85
    -- upvalues: u2 (ref), updateStrokes (copy)
    if u2 then
        return;
    end;

    u2 = true;
    task.defer(updateStrokes);
end;

CollectionService:GetInstanceAddedSignal("ScreenGui"):Connect(function(p12) -- Line: 92
    -- upvalues: tagRecursive (copy)
    tagRecursive(p12, "UIStroke", "ScreenStroke");
end);
CollectionService:GetInstanceAddedSignal("ScreenStroke"):Connect(function(p13) -- Line: 97
    -- upvalues: u9 (copy), u2 (ref), updateStrokes (copy)
    u9[p13] = p13.Thickness;

    if u2 then
        return;
    end;

    u2 = true;
    task.defer(updateStrokes);
end);
CollectionService:GetInstanceAddedSignal("NeedStroke"):Connect(function(p14) -- Line: 104
    -- upvalues: tagRecursive (copy)
    tagRecursive(p14, "UIStroke", "ScreenStroke");
end);
CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(queueUpdate);

function _G.AddToStroke(p15) -- Line: 111
    -- upvalues: u9 (copy), u2 (ref), updateStrokes (copy)
    u9[p15] = p15.Thickness;

    if u2 then
        return;
    end;

    u2 = true;
    task.defer(updateStrokes);
end;

task.delay(1, function() -- Line: 122
    -- upvalues: tagRecursive (copy), PlayerGui (copy)
    tagRecursive(PlayerGui, "ScreenGui", "ScreenGui");
end);

return {};