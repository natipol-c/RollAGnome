--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Loading
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Loading
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:08 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
Library.get("Network");
local u2 = Library.get("SimpleTween");
local v3 = {};
local u4 = {};
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;

local function TweenOut(u9) -- Line: 28
    -- upvalues: u5 (ref), u2 (copy), u6 (ref), u4 (copy), u8 (ref)
    pcall(function() -- Line: 29
        -- upvalues: u9 (copy), u5 (ref), u2 (ref), u6 (ref), u4 (ref), u8 (ref)
        if u9 then
            u5.Enabled = false;

            return;
        end;

        u2:Tween(u6, 0.3, "Sine", "Out", {
            GroupTransparency = 1
        }, nil, function() -- Line: 36
            -- upvalues: u4 (ref), u8 (ref), u5 (ref)
            for i, v in next, u4 do
                v:Cancel();
                v:Destroy();
                local v10 = u8:FindFirstChild(i);

                if v10 then
                    v10.Icon.Position = UDim2.fromScale(0.5, 0.5);
                end;
            end;

            u5.Enabled = false;
        end);
    end);
end;

local function TweenIn(p11) -- Line: 50
    -- upvalues: u6 (ref), u5 (ref), u2 (copy), u8 (ref), u4 (copy)
    if p11 then
        _G.Play("PurchasePopup");
    end;

    u6.GroupTransparency = 1;
    u5.Enabled = true;
    u2:Tween(u6, 0.4, "Sine", "Out", {
        GroupTransparency = 0
    });
    task.spawn(function() -- Line: 63
        -- upvalues: u8 (ref), u4 (ref), u2 (ref)
        for i = 1, #u8:GetChildren() - 1 do
            local v12 = u8:FindFirstChild(i);

            if v12 then
                u4[i] = u2:Tween(v12.Icon, 0.4, "Sine", "InOut", {
                    Position = UDim2.fromScale(0.5, 0)
                }, true, nil, -1);
                task.wait(0.2);
            end;
        end;
    end);
end;

function v3.Start(p13, p14) -- Line: 80
    -- upvalues: u5 (ref), u6 (ref), u1 (copy), u7 (ref), u8 (ref)
    u5 = p14.Parent:WaitForChild("Loading");
    u6 = u1(u5, "Canvas");
    u7 = u1(u6, "Frame");
    u8 = u1(u7, "Dots");
end;

_G.Loading = {
    Prompt = function(p15, p16) -- Line: 96, Name: Prompt
        -- upvalues: TweenIn (copy), u5 (ref), u2 (copy), u6 (ref), u4 (copy), u8 (ref)
        if p15 then
            _G.PromptingProduct = true;
            TweenIn(p16);

            return;
        end;

        _G.PromptingProduct = nil;
        local u17 = nil;
        pcall(function() -- Line: 29
            -- upvalues: u17 (copy), u5 (ref), u2 (ref), u6 (ref), u4 (ref), u8 (ref)
            if u17 then
                u5.Enabled = false;

                return;
            end;

            u2:Tween(u6, 0.3, "Sine", "Out", {
                GroupTransparency = 1
            }, nil, function() -- Line: 36
                -- upvalues: u4 (ref), u8 (ref), u5 (ref)
                for i, v in next, u4 do
                    v:Cancel();
                    v:Destroy();
                    local v18 = u8:FindFirstChild(i);

                    if v18 then
                        v18.Icon.Position = UDim2.fromScale(0.5, 0.5);
                    end;
                end;

                u5.Enabled = false;
            end);
        end);
    end
};

return v3;