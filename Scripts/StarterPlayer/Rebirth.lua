--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Rebirth
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Interface.Tabs.Rebirth
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:29 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Replication = require(ReplicatedStorage.Replication);
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
local u2 = Library.get("Network");
local u3 = Library.get("Numbers");
local u4 = Library.get("Signal");
local u5 = Library.get("Products");
local u6 = Library.get("Farmers");
local u7 = Library.get("Rebirths");
local LocalPlayer = game.Players.LocalPlayer;
local v8 = {};
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = nil;
local u21 = 0;

local function getAmount(p22) -- Line: 36
    -- upvalues: u3 (copy)
    if p22 >= 100000000000 then
        return u3.Suffix(p22);
    end;

    return u3.Comma(p22);
end;

local function getRebirth() -- Line: 43
    -- upvalues: Replication (copy)
    local v23 = Replication.Data.stats or {};

    return v23.rebirth or v23.rebirths or 0;
end;

local function hasGnome(p24) -- Line: 48
    -- upvalues: Replication (copy)
    local v25 = Replication.Data.discovered or {};

    return v25[p24] == true and true or table.find(v25, p24) ~= nil;
end;

local function clearList(p26) -- Line: 53
    if not p26 then
        return;
    end;

    local v27 = next;
    local v28, v29 = p26:GetChildren();

    for _, v in v27, v28, v29 do
        if v:IsA("Frame") then
            v:Destroy();
        end;
    end;
end;

local function canRebirth(p30) -- Line: 63
    -- upvalues: Replication (copy)
    local v31 = Replication.Data.stats or {};
    local v32 = p30.requirements or {};

    if (v31.money or 0) < (v32.money or 0) then
        return false;
    end;

    for _, v in next, v32.gnomes or {} do
        local v33 = Replication.Data.discovered or {};

        if v33[v] ~= true and table.find(v33, v) == nil then
            return false;
        end;
    end;

    return true;
end;

local function updateToggle() -- Line: 80
    -- upvalues: u19 (ref), Replication (copy), u7 (copy), canRebirth (copy), u21 (ref), u4 (copy)
    if not u19 then
        return;
    end;

    local v34 = Replication.Data.stats or {};
    local v35 = (v34.rebirth or v34.rebirths or 0) + 1;
    local v36 = u7[`Rebirth{v35}`];
    local v37 = v36 and canRebirth(v36) or false;
    u19.Visible = v37;

    if v37 and u21 ~= v35 then
        u21 = v35;
        u4.Fire("Notification", {
            message = "You can now rebirth"
        });
    end;
end;

local function close() -- Line: 96
    -- upvalues: clearList (copy), u14 (ref), u15 (ref), updateToggle (copy)
    clearList(u14);
    clearList(u15);
    updateToggle();
end;

local function open() -- Line: 102
    -- upvalues: clearList (copy), u14 (ref), u15 (ref), updateToggle (copy), Replication (copy), u7 (copy), u11 (ref), u12 (ref), u13 (ref), u16 (ref), u3 (copy), u6 (copy), u17 (ref), canRebirth (copy)
    clearList(u14);
    clearList(u15);
    updateToggle();
    local v38 = Replication.Data.stats or {};
    local v39 = v38.rebirth or v38.rebirths or 0;
    local v40 = v39 + 1;
    local v41 = u7[`Rebirth{v40}`];
    u11.Visible = v41 ~= nil;

    if u12 then
        u12.Visible = not v41;
    end;

    if u13 then
        local v42;

        if v41 then
            v42 = `Rebirth {v39} -> {v40}`;
        else
            v42 = `Rebirth {v39}`;
        end;

        u13.Text = v42;
    end;

    if not v41 then
        return;
    end;

    local v43 = Replication.Data.stats or {};
    local v44 = v41.requirements or {};
    local v45 = v44.money or 0;
    local v46 = v45 > 0 and (math.clamp((v43.money or 0) / v45, 0, 1) or 1) or 1;
    local Label = u16.Label;
    local v47 = v43.money or 0;
    local v48;

    if v47 >= 100000000000 then
        v48 = u3.Suffix(v47);
    else
        v48 = u3.Comma(v47);
    end;

    local v49;

    if v45 >= 100000000000 then
        v49 = u3.Suffix(v45);
    else
        v49 = u3.Comma(v45);
    end;

    Label.Text = `${v48} / ${v49}`;
    u16.Bar.Size = UDim2.fromScale(v46, u16.Bar.Size.Y.Scale);

    for _, v in next, v44.gnomes or {} do
        local v50 = u6[v];

        if v50 then
            local v51 = Replication.Data.discovered or {};
            local v52 = v51[v] == true and true or table.find(v51, v) ~= nil;
            local v53 = script.RequiredGnomes:Clone();
            v53.Name = v;
            v53.Icon.Image = v50.icon or "";
            v53.Icon.ImageColor3 = v52 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0);
            v53.Label.Text = v50.name or v;
            v53.Visible = true;
            v53.Parent = u15;
        end;
    end;

    local v54 = {};

    for _, v in next, v41.ui or {} do
        table.insert(v54, v);
    end;

    table.sort(v54, function(p55, p56) -- Line: 144
        return (p55.order or 0) < (p56.order or 0);
    end);

    for _, v in next, v54 do
        local v57 = (script:FindFirstChild(v.template == "MaxGnomes" and "RollLuck" or (v.template or "Template")) or script.Template):Clone();
        v57.Name = v.text or (v.template or "Reward");
        v57.LayoutOrder = v.order or 0;
        v57.Icon.Image = v.icon or "";
        v57.Label.Text = v.text or "";

        if v57:FindFirstChild("Mutli") then
            v57.Mutli.Text = v.multi or "";
        end;

        v57.Visible = true;
        v57.Parent = u14;
    end;

    u17.Rebirth.Frame.Block.Visible = not canRebirth(v41);
    updateToggle();
end;

function v8.Start(p58, p59) -- Line: 167
    -- upvalues: u9 (ref), u10 (ref), u1 (copy), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), u2 (copy), u4 (copy), LocalPlayer (copy), u5 (copy), Replication (copy), open (copy), clearList (copy), updateToggle (copy)
    u9 = p59;
    u10 = u1(u9, "Menu");
    u11 = u1(u10, "Frame");
    u12 = u10:FindFirstChild("MAX");
    u13 = u1(u1(u10, "Title"), "Title");
    local v60 = u1(u11, "Rewards");
    local v61 = u1(u11, "Requirements");
    u14 = u1(v60, "List");
    u15 = u1(v61, "List");
    u16 = u1(v61, "Progress");
    u17 = u1(u11, "Buttons");
    u18 = u1(u1(u1(u9.Parent.Parent:FindFirstChild("Display"), "Right"), "Frame"), "Rebirth");
    local v62 = u18 and u1(u1(u18, "Frame"), "Noti");
    u19 = v62;
    local v63 = u1(u17, "RobuxRebirth");
    local v64 = v63 and u1(v63, "Button");
    u20 = v64;
    local u65 = false;
    u17.Rebirth.Button.MouseButton1Click:Connect(function() -- Line: 191
        -- upvalues: u65 (ref), u2 (ref), u4 (ref), LocalPlayer (ref), u1 (ref)
        if u65 then
            return;
        end;

        u65 = true;
        _G.AreYouSure({
            Message = "Are you sure you want to rebirth?",

            Callback = function(p66) -- Line: 197, Name: Callback
                -- upvalues: u2 (ref), u4 (ref), LocalPlayer (ref), u1 (ref)
                if not (p66 and u2:InvokeServer("Rebirth")) then
                    u4.Fire("OpenTab", "Rebirth");

                    return;
                end;

                _G.Play("Rebirth");
                u4.Fire("CloseTab", "Rebirth");
                workspace.CurrentCamera.CFrame = u1(LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait(), "Head").CFrame * CFrame.fromEulerAnglesXYZ(-0.17453292519943295, 0, 0);
            end
        });
        task.wait(0.2);
        u65 = false;
    end);
    local u67 = false;

    if u20 then
        u20.MouseButton1Click:Connect(function() -- Line: 219
            -- upvalues: u67 (ref), u5 (ref), Replication (ref), u4 (ref)
            if u67 then
                return;
            end;

            local v68 = u5.products and u5.products.rebirth;

            if v68 then
                local v69 = Replication.Data.stats or {};
                v68 = u5.products.rebirth[(v69.rebirth or (v69.rebirths or 0)) + 1];
            end;

            if not v68 then
                return;
            end;

            u67 = true;
            u5.prompt(v68, "product");
            u4.Fire("CloseTab", "Rebirth");
            task.wait(1);
            u67 = false;
        end);
    end;

    u9:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 234
        -- upvalues: u9 (ref), open (ref), clearList (ref), u14 (ref), u15 (ref), updateToggle (ref)
        if u9.Enabled then
            open();

            return;
        end;

        clearList(u14);
        clearList(u15);
        updateToggle();
    end);
    Replication:Connect("stats", function(p70) -- Line: 242
        -- upvalues: u9 (ref), open (ref), updateToggle (ref)
        if type(p70) ~= "table" then
            return;
        end;

        if u9.Enabled then
            open();

            return;
        end;

        updateToggle();
    end);
    Replication:Connect("discovered", function() -- Line: 251
        -- upvalues: u9 (ref), open (ref), updateToggle (ref)
        if u9.Enabled then
            open();

            return;
        end;

        updateToggle();
    end);
    updateToggle();
end;

return v8;