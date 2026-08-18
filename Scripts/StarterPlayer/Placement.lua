--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Placement
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Placement
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:09 2026
]]

-- Decompiled with Potassium's decompiler.

local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
game:GetService("ServerStorage");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local Library = require(ReplicatedStorage.Library);
local v1 = Library.get("Find");
local u2 = Library.get("Network");
local u3 = Library.get("Signal");
local u4 = Library.get("GnomeUtil");
local u5 = Library.get("Sprinklers");
local u6 = Library.get("Fertilizer");
local LocalPlayer = Players.LocalPlayer;
local u7 = v1(LocalPlayer, "Plot");
local CurrentCamera = workspace.CurrentCamera;
local Assets = ReplicatedStorage.Assets;
local Highlight = script.Highlight;
local v8 = {};
local u9 = nil;
local u10 = nil;
local u11 = false;
local u12 = RaycastParams.new();
u12.FilterType = Enum.RaycastFilterType.Exclude;
local u13 = OverlapParams.new();
u13.FilterType = Enum.RaycastFilterType.Exclude;
local u14 = Color3.fromRGB(255, 255, 255);
local u15 = Color3.fromRGB(255, 0, 0);
local u16 = nil;
local u17 = nil;
local u18 = false;
local u19 = nil;
local u20 = "1";
local u21 = nil;
local u22 = nil;

local function isMobile() -- Line: 61
    -- upvalues: LocalPlayer (copy), UserInputService (copy)
    local v23;

    if LocalPlayer:GetAttribute("Device") == "Mobile" then
        v23 = true;
    else
        v23 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.GamepadEnabled;
    end;

    return v23;
end;

local function getAimResult(p24) -- Line: 66
    -- upvalues: u7 (copy), u12 (copy), LocalPlayer (copy), u16 (ref), u17 (ref), CurrentCamera (copy), UserInputService (copy), GuiService (copy)
    local v25 = u7 and u7.Value;
    local v26;

    if v25 then
        v26 = v25:FindFirstChild("Plants");
    else
        v26 = v25;
    end;

    if v25 then
        v25 = v25:FindFirstChild("Workers");
    end;

    u12.FilterDescendantsInstances = {
        LocalPlayer.Character,
        u16,
        u17,
        CurrentCamera,
        workspace.Plants,
        workspace:FindFirstChild("Farmers"),
        workspace:FindFirstChild("Workers"),
        v26,
        v25
    };
    local v27;

    if LocalPlayer:GetAttribute("Device") == "Mobile" then
        v27 = true;
    else
        v27 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.GamepadEnabled;
    end;

    if not v27 then
        if LocalPlayer:GetAttribute("Device") == "Controller" then
            local v28 = CurrentCamera.ViewportSize / 2;
            local v29 = CurrentCamera:ViewportPointToRay(v28.X, v28.Y);

            return workspace:Raycast(v29.Origin, v29.Direction * 1000, u12);
        end;

        local v30 = UserInputService:GetMouseLocation();
        local Y = GuiService:GetGuiInset().Y;
        local v31 = CurrentCamera:ScreenPointToRay(v30.X, v30.Y - Y);

        return workspace:Raycast(v31.Origin, v31.Direction * 1000, u12);
    end;

    local v32 = Vector3.new(p24.CFrame.LookVector.X, 0, p24.CFrame.LookVector.Z);

    if v32.Magnitude > 0 then
        return workspace:Raycast(p24.Position + v32.Unit * 6 + Vector3.new(0, 20, 0), Vector3.new(0, -40, 0), u12);
    end;
end;

local function placeCurrent() -- Line: 104
    -- upvalues: u11 (ref), u16 (ref), u18 (ref), u2 (copy), u22 (ref), u21 (ref), u19 (ref), u20 (ref)
    if u11 then
        return;
    end;

    u11 = true;

    if not u16 then
        u11 = false;

        return;
    end;

    if not u18 then
        _G.Play("Negative");
        task.wait(0.1);
        u11 = false;

        return;
    end;

    u2:FireServer("Place", u22, u21 or u16.Name, u19 or u16:GetPivot(), u20);
    _G.Play("Placed");
    task.wait(0.5);
    u11 = false;
end;

local function stop() -- Line: 127
    -- upvalues: u9 (ref), u10 (ref), u3 (copy), Highlight (copy), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref), u22 (ref), u11 (ref)
    if u9 then
        u9:Disconnect();
        u9 = nil;
    end;

    if u10 then
        u10:Disconnect();
        u10 = nil;
    end;

    u3.Fire("PlaceButton", false);
    Highlight.Adornee = nil;
    Highlight.Enabled = false;
    Highlight.Parent = script;

    if u16 then
        u16:Destroy();
        u16 = nil;
    end;

    if u17 then
        u17:Destroy();
        u17 = nil;
    end;

    u18 = false;
    u19 = nil;
    u20 = "1";
    u21 = nil;
    u22 = nil;
    u11 = false;
end;

local function setHighlight(p33) -- Line: 160
    -- upvalues: Highlight (copy), u14 (copy), u15 (copy)
    Highlight.Enabled = true;
    Highlight.FillColor = p33 and u14 or u15;
    Highlight.OutlineColor = p33 and u14 or u15;
end;

local function isGroundValid(p34, p35) -- Line: 166
    if not (p34 and p35) then
        return false;
    end;

    local Instance2 = p34.Instance;

    return Instance2 == p35 and true or Instance2:IsDescendantOf(p35);
end;

local function getFloorIdFromGround(p36, p37) -- Line: 176
    while p36 and p36 ~= p37 do
        local v38 = string.match(p36.Name, "^Floor(%d+)$");

        if v38 then
            return v38;
        end;

        p36 = p36.Parent;
    end;

    return "1";
end;

local function isBoxClear(p39, p40, p41) -- Line: 189
    -- upvalues: u7 (copy), u13 (copy), LocalPlayer (copy), CurrentCamera (copy)
    if p41 == "Farmer" or p41 == "Fertilizer" then
        return true;
    end;

    local v42, v43 = p39:GetBoundingBox();
    local v44 = u7 and u7.Value;
    local v45;

    if v44 then
        v45 = v44:FindFirstChild("Plants");
    else
        v45 = v44;
    end;

    if v44 then
        v44 = v44:FindFirstChild("Workers");
    end;

    local v46 = Vector3.new(v43.X * 0.95, v43.Y * 0.9, v43.Z * 0.95);
    u13.FilterDescendantsInstances = {
        LocalPlayer.Character,
        p39,
        CurrentCamera,
        p40
    };
    local v47 = workspace:GetPartBoundsInBox(v42, v46, u13);

    for _, v in ipairs(v47) do
        if p41 ~= "Farmer" and (v45 and (v:IsDescendantOf(v45) and v.Transparency < 1)) then
            return false;
        end;

        if p41 ~= "Farmer" and (v44 and (v:IsDescendantOf(v44) and v.Transparency < 1)) then
            return false;
        end;

        if v.CanCollide and v.Transparency < 1 then
            return false;
        end;
    end;

    return true;
end;

local function normalizeItemType(p48) -- Line: 231
    local v49 = type(p48) == "string" and p48 and p48 or "";
    local v50 = string.lower(v49);

    return (v50 == "gnome" or v50 == "farmer") and "Farmer" or ((v50 == "sprikler" or v50 == "sprinkler") and "Sprinkler" or ((v50 == "fertilizer" or v50 == "fertiliser") and "Fertilizer" or v49));
end;

local function findPlacementAsset(p51, p52) -- Line: 246
    -- upvalues: Assets (copy)
    for _, v in {
        Assets:FindFirstChild(p52),
        Assets:FindFirstChild(p52 .. "s"),
        Assets:FindFirstChild("Items"),
        Assets:FindFirstChild("Tools")
    } do
        if v then
            local v = v:FindFirstChild(p51) or v:FindFirstChild(p52);
        end;

        if v then
            return v;
        end;
    end;
end;

local function getRangeTemplate(p53) -- Line: 262
    -- upvalues: Assets (copy)
    return Assets:FindFirstChild(p53 and p53.ring or "SprinklerRing") or Assets:FindFirstChild("SprinklerRing");
end;

local function getFertilizerTemplate() -- Line: 267
    -- upvalues: Assets (copy)
    return Assets:FindFirstChild("FertilizerPart");
end;

local function modelFromInstance(p54, p55) -- Line: 271
    if not p54 then
        return;
    end;

    if p54:IsA("Model") then
        local v56 = p54:Clone();

        if not v56.PrimaryPart then
            v56.PrimaryPart = v56:FindFirstChildWhichIsA("BasePart", true);
        end;

        return v56;
    end;

    local Model = Instance.new("Model");
    Model.Name = p55;

    if p54:IsA("BasePart") then
        local v57 = p54:Clone();
        v57.Name = "PrimaryPart";
        v57.Parent = Model;
        Model.PrimaryPart = v57;
    elseif p54:IsA("Tool") then
        for _, descendant in p54:GetDescendants() do
            if descendant:IsA("BasePart") then
                local v58 = descendant:Clone();
                v58.Anchored = true;
                v58.Parent = Model;

                if descendant.Name == "Handle" or not Model.PrimaryPart then
                    Model.PrimaryPart = v58;
                end;
            end;
        end;
    end;

    if Model.PrimaryPart then
        return Model;
    end;

    Model:Destroy();
end;

local function createPlaceholderModel(p59, p60) -- Line: 312
    local Model = Instance.new("Model");
    Model.Name = p59;
    local Part = Instance.new("Part");
    Part.Name = "PrimaryPart";
    Part.Size = p60 == "Sprinkler" and Vector3.new(2, 0.4, 2) or Vector3.new(2, 2, 2);
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.Color = p60 == "Sprinkler" and Color3.fromRGB(70, 180, 255) or Color3.fromRGB(255, 255, 255);
    Part.Material = Enum.Material.SmoothPlastic;
    Part.Shape = p60 == "Sprinkler" and Enum.PartType.Cylinder or Enum.PartType.Block;
    Part.Parent = Model;
    Model.PrimaryPart = Part;

    return Model;
end;

local function addRangePart(p61, p62) -- Line: 331
    -- upvalues: Assets (copy)
    local v63;

    if p62 then
        v63 = p62.range;
    else
        v63 = p62;
    end;

    if type(v63) ~= "number" or v63 <= 0 then
        return;
    end;

    local v64 = Assets:FindFirstChild(p62 and (p62.ring or "SprinklerRing") or "SprinklerRing") or Assets:FindFirstChild("SprinklerRing");

    if v64 and v64:IsA("BasePart") then
        local v65 = v63 * 2;
        local v66 = v64:Clone();
        v66.Name = p62 and p62.ring or "Range";
        v66:SetAttribute("VisualOnly", true);
        v66:SetAttribute("Range", v63);
        v66:SetAttribute("Diameter", v65);
        v66.Anchored = true;
        v66.CanCollide = false;
        v66.CanTouch = false;
        v66.CanQuery = false;
        v66.CastShadow = false;
        v66.Size = Vector3.new(v65, v66.Size.Y, v65);
        v66.CFrame = p61:GetPivot();
        v66.Parent = workspace.Previews;

        return v66;
    end;
end;

local function getPreviewModel(p67, p68, p69) -- Line: 357
    -- upvalues: u4 (copy), findPlacementAsset (copy), modelFromInstance (copy), u5 (copy), createPlaceholderModel (copy), Assets (copy), u6 (copy)
    if p68 == "Farmer" then
        local v70 = p69 and (p69:GetAttribute("Mutations") or "") or "";

        if p69 then
            p67 = p69:GetAttribute("FarmerName") or p67;
        end;

        if p69 then
            p69 = p69:GetAttribute("Huge") == true;
        end;

        return u4.getModel(p67, v70, p69) or u4.getDisplayModel(p67, v70, p69), p67;
    end;

    if p68 == "Sprinkler" then
        local v71 = modelFromInstance(findPlacementAsset(p67, p68), p67);
        local v72 = u5[p67];
        local v73 = v71 or createPlaceholderModel(p67, p68);

        if v73 then
            if v72 then
                v72 = v72.range;
            end;

            v73:SetAttribute("Range", v72);
        end;

        return v73, p67;
    end;

    if p68 == "Fertilizer" then
        local v74 = modelFromInstance(Assets:FindFirstChild("FertilizerPart"), p67);
        local v75 = u6[p67];
        local v76 = v74 or createPlaceholderModel(p67, p68);

        if v76 and v76.PrimaryPart then
            if v75 then
                v75 = v75.range;
            end;

            local v77 = type(v75) == "number" and v75 * 2 or v76.PrimaryPart.Size.X;
            v76.PrimaryPart.Size = Vector3.new(v77, v76.PrimaryPart.Size.Y, v77);
            v76:SetAttribute("Range", v75);
        end;

        return v76, p67;
    end;
end;

local function start(p78, p79) -- Line: 394
    -- upvalues: u9 (ref), u3 (copy), LocalPlayer (copy), UserInputService (copy), u16 (ref), getPreviewModel (copy), u21 (ref), u22 (ref), u17 (ref), addRangePart (copy), u5 (copy), Highlight (copy), RunService (copy), u7 (copy), getAimResult (copy), u18 (ref), u15 (copy), u19 (ref), isBoxClear (copy), u20 (ref), getFloorIdFromGround (copy), u14 (copy), u10 (ref), placeCurrent (copy)
    if u9 then
        return;
    end;

    local Fire = u3.Fire;
    local v80;

    if LocalPlayer:GetAttribute("Device") == "Mobile" then
        v80 = true;
    else
        v80 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.GamepadEnabled;
    end;

    Fire("PlaceButton", v80);
    local Character = LocalPlayer.Character;
    local Backpack = LocalPlayer:FindFirstChild("Backpack");
    local v81 = Character and Character:FindFirstChild(p78);

    if v81 then
        Backpack = v81;
    elseif Backpack then
        Backpack = Backpack:FindFirstChild(p78);
    end;

    local v82 = p79 or (Backpack and (Backpack:GetAttribute("type") or "Farmer") or "Farmer");
    local v83 = type(v82) == "string" and (v82 or "") or "";
    local v84 = string.lower(v83);
    local v85 = (v84 == "gnome" or v84 == "farmer") and "Farmer" or ((v84 == "sprikler" or v84 == "sprinkler") and "Sprinkler" or ((v84 == "fertilizer" or v84 == "fertiliser") and "Fertilizer" or v83));
    local v86, v87 = getPreviewModel(p78, v85, Backpack);
    u16 = v86;

    if not u16 then
        return;
    end;

    u21 = v87;
    u22 = v85;

    if u16.PrimaryPart then
        u16.PrimaryPart.Anchored = true;
    end;

    local v88 = next;
    local v89, v90 = u16:GetDescendants();

    for _, v in v88, v89, v90 do
        if v:IsA("BasePart") then
            v.Anchored = true;
            v.CanCollide = false;
        end;
    end;

    u16.Parent = workspace.Previews;

    if v85 == "Sprinkler" then
        u17 = addRangePart(u16, u5[v87]);
    end;

    Highlight.Parent = u16;
    Highlight.Adornee = u16;
    local u91 = tick();
    u9 = RunService.RenderStepped:Connect(function() -- Line: 433
        -- upvalues: u91 (ref), LocalPlayer (ref), u7 (ref), u16 (ref), getAimResult (ref), u18 (ref), Highlight (ref), u15 (ref), u17 (ref), u19 (ref), isBoxClear (ref), u22 (ref), u20 (ref), getFloorIdFromGround (ref), u14 (ref)
        if tick() - u91 <= 0.01 then
            return;
        end;

        u91 = tick();
        local v92 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");

        if not v92 then
            return;
        end;

        local Ground = u7.Value:FindFirstChild("Ground");

        if not Ground then
            return;
        end;

        if not u16 then
            return;
        end;

        local v93 = getAimResult(v92);

        if not v93 then
            u18 = false;
            Highlight.Enabled = true;
            Highlight.FillColor = u15;
            Highlight.OutlineColor = u15;

            return;
        end;

        local Position = v93.Position;
        local Position2 = u7.Value:GetPivot().Position;
        local v94 = Vector3.new(Position.X - Position2.X, 0, Position.Z - Position2.Z);

        if v94.Magnitude <= 0 then
            return;
        end;

        local v95 = CFrame.lookAt(Position, Position + v94.Unit);
        u16:PivotTo(v95);

        if u17 then
            u17.CFrame = v95;
        end;

        u19 = v95;
        local v96;

        if v93 and Ground then
            local Instance2 = v93.Instance;
            v96 = Instance2 == Ground and true or Instance2:IsDescendantOf(Ground);
        else
            v96 = false;
        end;

        u18 = v96 and isBoxClear(u16, Ground, u22);
        u20 = v96 and getFloorIdFromGround(v93.Instance, Ground) or "1";
        local v97 = u18;
        Highlight.Enabled = true;
        Highlight.FillColor = v97 and u14 or u15;
        Highlight.OutlineColor = v97 and u14 or u15;
    end);
    local v98;

    if LocalPlayer:GetAttribute("Device") == "Mobile" then
        v98 = true;
    else
        v98 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.GamepadEnabled;
    end;

    if not v98 then
        u10 = UserInputService.InputBegan:Connect(function(p99, p100) -- Line: 480
            -- upvalues: placeCurrent (ref)
            if p100 then
                return;
            end;

            if p99.UserInputType == Enum.UserInputType.MouseButton1 or (p99.KeyCode == Enum.KeyCode.ButtonA or p99.KeyCode == Enum.KeyCode.ButtonR2) then
                task.spawn(placeCurrent);
            end;
        end);
    end;
end;

function v8.Initialize(p101) -- Line: 492
    -- upvalues: u16 (ref), u18 (ref), u20 (ref), placeCurrent (copy), u3 (copy), stop (copy), start (copy), u2 (copy)
    function _G.GetPlacingItem() -- Line: 494
        -- upvalues: u16 (ref), u18 (ref), u20 (ref)
        return u16, u18, u20;
    end;

    _G.PlaceCurrentItem = placeCurrent;
    u3.new("Place"):Connect(function(p102, p103, p104) -- Line: 499
        -- upvalues: stop (ref), start (ref)
        if p102 then
            start(p103, p104);

            return;
        end;

        stop();
    end);
    u2:BindEvents({
        StopPlacement = function() -- Line: 509, Name: StopPlacement
            -- upvalues: stop (ref)
            stop();
        end
    });
end;

return v8;