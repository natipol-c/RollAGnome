--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     UIScale
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.UIScale
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:08 2026
]]

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
game:GetService("ReplicatedStorage");
game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui");
local u1 = workspace.CurrentCamera or workspace:WaitForChild("Camera");
local u2 = Vector2.new(1829, 1153);
local zero = Vector2.zero;
local v3 = {};

local function getScale() -- Line: 31
    -- upvalues: u1 (copy), zero (copy), u2 (copy), UserInputService (copy)
    local ViewportSize = u1.ViewportSize;
    local v4 = math.max(zero.X, ViewportSize.X) / u2.X;
    local v5 = math.max(zero.Y, ViewportSize.Y) / u2.Y;

    if UserInputService.TouchEnabled then
        v4 = v4 * 1.15;
        v5 = v5 * 1.15;
    end;

    return math.min(v4, v5);
end;

local function applyUIScale(p6) -- Line: 44
    -- upvalues: u1 (copy), zero (copy), u2 (copy), UserInputService (copy)
    local u7 = p6:FindFirstChild("UIScale") or Instance.new("UIScale");
    local ViewportSize = u1.ViewportSize;
    local v8 = math.max(zero.X, ViewportSize.X) / u2.X;
    local v9 = math.max(zero.Y, ViewportSize.Y) / u2.Y;

    if UserInputService.TouchEnabled then
        v8 = v8 * 1.15;
        v9 = v9 * 1.15;
    end;

    u7.Scale = math.min(v8, v9);
    u7.Parent = p6;
    u1:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line: 49
        -- upvalues: u7 (copy), u1 (ref), zero (ref), u2 (ref), UserInputService (ref)
        local ViewportSize2 = u1.ViewportSize;
        local v10 = math.max(zero.X, ViewportSize2.X) / u2.X;
        local v11 = math.max(zero.Y, ViewportSize2.Y) / u2.Y;

        if UserInputService.TouchEnabled then
            v10 = v10 * 1.15;
            v11 = v11 * 1.15;
        end;

        u7.Scale = math.min(v10, v11);
    end);
end;

local function added(p12) -- Line: 54
    -- upvalues: PlayerGui (copy), applyUIScale (copy)
    if not p12:IsA("GuiObject") then
        return;
    end;

    if p12:GetAttribute("Sized") then
        return;
    end;

    if not p12:IsDescendantOf(PlayerGui) then
        return;
    end;

    p12:SetAttribute("Sized", true);
    applyUIScale(p12);
end;

function v3.Initialize(p13) -- Line: 63
    -- upvalues: CollectionService (copy), added (copy)
    local v14 = next;
    local v15, v16 = CollectionService:GetTagged("ScaleMenu");

    for _, v in v14, v15, v16 do
        added(v);
    end;

    CollectionService:GetInstanceAddedSignal("ScaleMenu"):Connect(added);
end;

return v3;