--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Animations
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Gnome Handler.Animations
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:09 2026
]]

-- Decompiled with Potassium's decompiler.

local Animations = game:GetService("ReplicatedStorage").Assets.Animations;
local u1 = {};
u1.__index = u1;

local function hasMutation(p2, p3) -- Line: 24
    local v4 = p2 and p2:GetAttribute("Mutations") or "";

    if type(v4) == "string" and v4 ~= "" then
        return table.find(string.split(v4, "_"), p3) ~= nil;
    end;

    return false;
end;

function u1.new(p5, p6) -- Line: 33
    -- upvalues: Animations (copy), u1 (copy)
    local v7 = Animations:FindFirstChild(p5);

    if v7 then
        local v8 = setmetatable({}, u1);
        v8.folder = v7;
        v8.model = p6;
        local v9 = p6:FindFirstChildWhichIsA("AnimationController");
        local _ = v8.humanoid or v9;
        v8.animator = v9;
        v8.tracks = {};
        v8.connections = {};
        v8.playingAnimation = nil;
        v8.playingAnimationName = nil;
        v8:LoadAnimations();

        return v8;
    end;

    warn("Could not find animations module");
end;

function u1.LoadAnimations(u10) -- Line: 55
    local ContentProvider = game:GetService("ContentProvider");
    local v11 = next;
    local v12, v13 = u10.folder:GetChildren();
    local v14 = {};

    for _, v in v11, v12, v13 do
        if v:IsA("Animation") then
            table.insert(v14, v);
        end;
    end;

    ContentProvider:PreloadAsync(v14);

    for _, v in next, v14 do
        local u15 = u10.animator:LoadAnimation(v);
        u10.tracks[v.Name] = u15;

        if v.Name == "Walk" then
            local connections = u10.connections;
            local v16 = u15:GetMarkerReachedSignal("Step");
            table.insert(connections, v16:Connect(function(p17) -- Line: 73
                -- upvalues: u10 (copy), u15 (copy)
                if u10.playingAnimation ~= u15 then
                    return;
                end;

                local v18 = u10.model:FindFirstChild("HumanoidRootPart") or u10.model:FindFirstChild("RootPart");

                if not v18 then
                    return;
                end;

                local v19 = u10.model:GetAttribute("GnomeStepGroup") or 1;

                if p17 == "Step1" then
                    _G.Play(`GnomeStep{v19}_1`, v18);

                    return;
                end;

                if p17 == "Step2" then
                    _G.Play(`GnomeStep{v19}_2`, v18);
                end;
            end));
        end;
    end;
end;

function u1.Stop(p20) -- Line: 91
    if p20.playingAnimation then
        p20.playingAnimation:Stop();
        p20.playingAnimation = nil;
    end;

    p20.playingAnimationName = nil;
end;

function u1.ChangeAnimation(p21, p22, p23) -- Line: 99
    local v24 = p23 or 1;
    local model = p21.model;
    local v25 = model and model:GetAttribute("Mutations") or "";
    local v26;

    if type(v25) == "string" and v25 ~= "" then
        v26 = table.find(string.split(v25, "_"), "Frozen") ~= nil;
    else
        v26 = false;
    end;

    if v26 then
        p21:Stop();

        return;
    end;

    if p21.tracks[p22] then
        if p21.playingAnimationName == p22 and p21.playingAnimation then
            p21.playingAnimation:AdjustSpeed(v24);

            return p21.playingAnimation;
        end;

        if p21.playingAnimation then
            if p21.playingAnimation.Name == p22 then
                p21.playingAnimation:AdjustSpeed(v24);

                return p21.playingAnimation;
            end;

            p21.playingAnimation:Stop();
            p21.playingAnimation = nil;
        end;

        p21.tracks[p22]:Play();
        p21.playingAnimation = p21.tracks[p22];
        p21.playingAnimation:AdjustSpeed(v24);
        p21.playingAnimationName = p22;

        return p21.playingAnimation;
    end;
end;

function u1.Play(p27, p28, p29) -- Line: 132
    local v30 = p29 or 1;
    local model = p27.model;
    local v31 = model and model:GetAttribute("Mutations") or "";
    local v32;

    if type(v31) == "string" and v31 ~= "" then
        v32 = table.find(string.split(v31, "_"), "Frozen") ~= nil;
    else
        v32 = false;
    end;

    if v32 then
        return;
    end;

    if p27.tracks[p28] then
        local v33 = p27.tracks[p28];
        v33:Play();
        v33:AdjustSpeed(v30);

        return v33;
    end;
end;

function u1.Destroy(p34) -- Line: 149
    for _, v in next, p34.connections do
        v:Disconnect();
    end;

    for _, v in next, p34.tracks do
        v:Stop();
        v:Destroy();
    end;
end;

return u1;