--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Backpack
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Backpack
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:08 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
local Replication = require(ReplicatedStorage.Replication);
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
Library.get("Network");
local u2 = Library.get("Signal");
Library.get("SimpleTween");
local v3 = {};
script.Buttons:Clone();
local u4 = script.Filters:Clone();
local u5 = script.MaxInventory:Clone();
local u6 = nil;
local u7 = nil;
local u8 = nil;

local function getInventoryAmount(p9) -- Line: 31
    local v10 = 0;

    for _, v in next, p9 or {} do
        v10 = v10 + (type(v) == "table" and (v.amount or 1) or 1);
    end;

    return v10;
end;

function v3.Start(p11, p12) -- Line: 41
    -- upvalues: u6 (ref), u1 (copy), u7 (ref), u8 (ref), u2 (copy), ReplicatedStorage (copy), u4 (copy), u5 (copy), Replication (copy), getInventoryAmount (copy)
    u6 = u1(p12.Parent, "BackpackGui");
    u7 = u1(u6, "Backpack");
    u8 = u1(u7, "Inventory");
    u2.new("ToggleToolbar"):Connect(function(p13) -- Line: 46
        -- upvalues: u6 (ref), ReplicatedStorage (ref)
        u6.Enabled = p13;
        ReplicatedStorage:SetAttribute("DisableToolbar", not p13);
    end);
    u4.Parent = u8;
    u5.Parent = u8;

    local function update() -- Line: 56
        -- upvalues: Replication (ref), getInventoryAmount (ref), u5 (ref)
        local Data = Replication.Data;
        u5.Text = `Max Items: ({getInventoryAmount(Data.inventory)}/{Data.max_inventory or 100})`;
    end;

    local Data = Replication.Data;
    u5.Text = `Max Items: ({getInventoryAmount(Data.inventory)}/{Data.max_inventory or 100})`;
    Replication:Connect("inventory", update);
    Replication:Connect("max_inventory", update);
    local v14 = next;
    local v15, v16 = u4:GetChildren();

    for _, v in v14, v15, v16 do
        if v:IsA("Frame") then
            local v17 = u1(v, "Button");
            local u18 = false;
            v17.MouseButton1Click:Connect(function() -- Line: 78
                -- upvalues: u18 (ref), u4 (ref), v (copy), u2 (ref)
                if u18 then
                    return;
                end;

                u18 = true;
                local v19 = next;
                local v20, v21 = u4:GetChildren();

                for _, v2 in v19, v20, v21 do
                    if v2:IsA("Frame") then
                        v2.Frame.UIStroke.Color = Color3.fromRGB(0, 0, 0);
                    end;
                end;

                v.Frame.UIStroke.Color = Color3.fromRGB(255, 255, 255);
                u2.Fire("ChangeFilter", v.Name);
                task.wait(0.2);
                u18 = false;
            end);
        end;
    end;
end;

return v3;