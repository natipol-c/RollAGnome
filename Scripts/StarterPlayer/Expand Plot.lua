--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Expand Plot
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Expand Plot
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:08 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
local u2 = Library.get("Network");
local u3 = Library.get("Numbers");
local u4 = Library.get("Expand");
local u5 = ReplicatedStorage.Assets.Billboards.ExpandPlot:Clone();
local LocalPlayer = Players.LocalPlayer;
u5.Parent = u1(u1(LocalPlayer, "PlayerGui"), "BillboardGuis");
u5.Enabled = false;
local u6 = u1(LocalPlayer, "Plot");
local v7 = {};
local u8 = nil;

local function display(p9) -- Line: 40
    -- upvalues: u4 (copy), u5 (copy), u3 (copy), u8 (ref)
    local v10 = u4[p9.Name];

    if not v10 then
        return;
    end;

    local BoundaryPart = p9:FindFirstChild("BoundaryPart");
    u5.Price.Text = `{u3.Comma(v10)}$`;
    u5.Adornee = BoundaryPart or p9;
    u5.Enabled = true;
    u8 = p9;

    if BoundaryPart then
        BoundaryPart.Color = Color3.fromRGB(100, 100, 100);
    end;
end;

local function remove() -- Line: 57
    -- upvalues: u5 (copy), u8 (ref)
    u5.Adornee = nil;
    u5.Enabled = false;

    if not u8 then
        return;
    end;

    local BoundaryPart = u8:FindFirstChild("BoundaryPart");

    if BoundaryPart then
        BoundaryPart.Color = Color3.fromRGB(0, 0, 0);
    end;
end;

local function gotPlot(p11) -- Line: 68
    -- upvalues: u1 (copy), RunService (copy), LocalPlayer (copy), u5 (copy), u8 (ref), display (copy)
    local v12 = u1(p11, "ExpandPlot");
    local u13 = {};
    local u14 = {};
    local u15 = RaycastParams.new();
    u15.FilterType = Enum.RaycastFilterType.Include;
    u15.FilterDescendantsInstances = u13;

    local function addBoundaryPart(p16) -- Line: 76
        -- upvalues: u13 (copy), u14 (copy), u15 (copy)
        if p16.Name ~= "BoundaryPart" or not p16:IsA("BasePart") then
            return;
        end;

        if table.find(u13, p16) then
            return;
        end;

        local Parent = p16.Parent;

        if not Parent or Parent.Name == "Highlight" then
            return;
        end;

        p16.CanQuery = true;
        table.insert(u13, p16);
        u14[p16] = Parent;
        u15.FilterDescendantsInstances = u13;
    end;

    for _, descendant in v12:GetDescendants() do
        addBoundaryPart(descendant);
    end;

    local u17 = v12.DescendantAdded:Connect(addBoundaryPart);
    local u18 = nil;
    local u21 = RunService.Heartbeat:Connect(function() -- Line: 97
        -- upvalues: LocalPlayer (ref), u18 (ref), u5 (ref), u8 (ref), u15 (copy), u14 (copy), display (ref)
        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        if not Character then
            if u18 then
                u18 = nil;
                u5.Adornee = nil;
                u5.Enabled = false;

                if not u8 then
                    return;
                end;

                local BoundaryPart = u8:FindFirstChild("BoundaryPart");

                if BoundaryPart then
                    BoundaryPart.Color = Color3.fromRGB(0, 0, 0);
                end;
            end;

            return;
        end;

        local v19 = workspace:Raycast(Character.Position, Vector3.new(0, -20, 0), u15);
        local v20 = v19 and u14[v19.Instance] or nil;

        if v20 == u18 then
            return;
        end;

        u18 = v20;

        if u18 then
            display(u18);

            return;
        end;

        u5.Adornee = nil;
        u5.Enabled = false;

        if not u8 then
            return;
        end;

        local BoundaryPart = u8:FindFirstChild("BoundaryPart");

        if BoundaryPart then
            BoundaryPart.Color = Color3.fromRGB(0, 0, 0);
        end;
    end);
    p11.Destroying:Once(function() -- Line: 125
        -- upvalues: u21 (ref), u17 (copy), u5 (ref), u8 (ref)
        u21:Disconnect();
        u17:Disconnect();
        u5.Adornee = nil;
        u5.Enabled = false;

        if not u8 then
            return;
        end;

        local BoundaryPart = u8:FindFirstChild("BoundaryPart");

        if BoundaryPart then
            BoundaryPart.Color = Color3.fromRGB(0, 0, 0);
        end;
    end);
end;

function v7.Initialize(p22) -- Line: 132
    -- upvalues: u6 (copy), gotPlot (copy), u1 (copy), u5 (copy), u8 (ref), u4 (copy), u2 (copy)
    if u6.Value then
        gotPlot(u6.Value);
    else
        u6.Changed:Once(function() -- Line: 136
            -- upvalues: gotPlot (ref), u6 (ref)
            gotPlot(u6.Value);
        end);
    end;

    local v23 = u1(u1(u5, "Buy"), "Button");
    local u24 = false;
    v23.MouseButton1Click:Connect(function() -- Line: 145
        -- upvalues: u8 (ref), u24 (ref), u4 (ref), u2 (ref)
        if not u8 then
            return;
        end;

        if u24 then
            return;
        end;

        u24 = true;
        _G.AreYouSure({
            Message = "Are you sure you want to expand your plot?",
            Price = u4[u8.Name],

            Callback = function(p25) -- Line: 153, Name: Callback
                -- upvalues: u2 (ref), u8 (ref), u24 (ref)
                if p25 then
                    u2:FireServer("ExpandPlot", u8);
                end;

                task.delay(0.5, function() -- Line: 158
                    -- upvalues: u24 (ref)
                    u24 = false;
                end);
            end
        });
    end);
end;

return v7;