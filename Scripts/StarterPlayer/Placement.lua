--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Placement
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Placement
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:29 2026
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
    -- upvalues: u7 (copy), LocalPlayer (copy), u16 (ref), u17 (ref), CurrentCamera (copy), u12 (copy), UserInputService (copy), GuiService (copy)
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

    local v27 = {};

    for _, v in {
        LocalPlayer.Character,
        u16,
        u17,
        CurrentCamera,
        workspace.Plants,
        workspace:FindFirstChild("Farmers"),
        workspace:FindFirstChild("Workers"),
        v26,
        v25
    } do
        if v then
            table.insert(v27, v);
        end;
    end;

    u12.FilterDescendantsInstances = v27;
    local v28;

    if LocalPlayer:GetAttribute("Device") == "Mobile" then
        v28 = true;
    else
        v28 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.GamepadEnabled;
    end;

    if not v28 then
        if LocalPlayer:GetAttribute("Device") == "Controller" then
            local v29 = CurrentCamera.ViewportSize / 2;
            local v30 = CurrentCamera:ViewportPointToRay(v29.X, v29.Y);

            return workspace:Raycast(v30.Origin, v30.Direction * 1000, u12);
        end;

        local v31 = UserInputService:GetMouseLocation();
        local Y = GuiService:GetGuiInset().Y;
        local v32 = CurrentCamera:ScreenPointToRay(v31.X, v31.Y - Y);

        return workspace:Raycast(v32.Origin, v32.Direction * 1000, u12);
    end;

    local v33 = Vector3.new(p24.CFrame.LookVector.X, 0, p24.CFrame.LookVector.Z);

    if v33.Magnitude > 0 then
        return workspace:Raycast(p24.Position + v33.Unit * 6 + Vector3.new(0, 20, 0), Vector3.new(0, -40, 0), u12);
    end;
end;

local function placeCurrent() -- Line: 110
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

local function stop() -- Line: 133
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

local function setHighlight(p34) -- Line: 166
    -- upvalues: Highlight (copy), u14 (copy), u15 (copy)
    Highlight.Enabled = true;
    Highlight.FillColor = p34 and u14 or u15;
    Highlight.OutlineColor = p34 and u14 or u15;
end;

local function isGroundValid(p35, p36) -- Line: 172
    if not (p35 and p36) then
        return false;
    end;

    local Instance2 = p35.Instance;

    return Instance2 == p36 and true or Instance2:IsDescendantOf(p36);
end;

local function getFloorIdFromGround(p37, p38) -- Line: 182
    while p37 and p37 ~= p38 do
        local v39 = string.match(p37.Name, "^Floor(%d+)$");

        if v39 then
            return v39;
        end;

        p37 = p37.Parent;
    end;

    return "1";
end;

local function isBoxClear(p40, p41, p42) -- Line: 195
    -- upvalues: u7 (copy), LocalPlayer (copy), CurrentCamera (copy), u13 (copy)
    if p42 == "Farmer" or p42 == "Fertilizer" then
        return true;
    end;

    local v43, v44 = p40:GetBoundingBox();
    local v45 = u7 and u7.Value;
    local v46;

    if v45 then
        v46 = v45:FindFirstChild("Plants");
    else
        v46 = v45;
    end;

    if v45 then
        v45 = v45:FindFirstChild("Workers");
    end;

    local v47 = {};

    for _, v in {
        LocalPlayer.Character,
        p40,
        CurrentCamera,
        p41,
        v45,
        workspace:FindFirstChild("Farmers"),
        workspace:FindFirstChild("Workers")
    } do
        if v then
            table.insert(v47, v);
        end;
    end;

    local v48 = Vector3.new(v44.X * 0.95, v44.Y * 0.9, v44.Z * 0.95);
    u13.FilterDescendantsInstances = v47;
    local v49 = workspace:GetPartBoundsInBox(v43, v48, u13);

    for _, v in ipairs(v49) do
        if p42 ~= "Farmer" and (v46 and (v:IsDescendantOf(v46) and v.Transparency < 1)) then
            return false;
        end;

        if v.CanCollide and v.Transparency < 1 then
            return false;
        end;
    end;

    return true;
end;

local function normalizeItemType(p50) -- Line: 243
    local v51 = type(p50) == "string" and p50 and p50 or "";
    local v52 = string.lower(v51);

    return (v52 == "gnome" or v52 == "farmer") and "Farmer" or ((v52 == "sprikler" or v52 == "sprinkler") and "Sprinkler" or ((v52 == "fertilizer" or v52 == "fertiliser") and "Fertilizer" or v51));
end;

local function findPlacementAsset(p53, p54) -- Line: 258
    -- upvalues: Assets (copy)
    for _, v in {
        Assets:FindFirstChild(p54),
        Assets:FindFirstChild(p54 .. "s"),
        Assets:FindFirstChild("Items"),
        Assets:FindFirstChild("Tools")
    } do
        if v then
            local v = v:FindFirstChild(p53) or v:FindFirstChild(p54);
        end;

        if v then
            return v;
        end;
    end;
end;

local function getRangeTemplate(p55) -- Line: 274
    -- upvalues: Assets (copy)
    return Assets:FindFirstChild(p55 and p55.ring or "SprinklerRing") or Assets:FindFirstChild("SprinklerRing");
end;

local function getFertilizerTemplate() -- Line: 279
    -- upvalues: Assets (copy)
    return Assets:FindFirstChild("FertilizerPart");
end;

local function modelFromInstance(p56, p57) -- Line: 283
    if not p56 then
        return;
    end;

    if p56:IsA("Model") then
        local v58 = p56:Clone();

        if not v58.PrimaryPart then
            v58.PrimaryPart = v58:FindFirstChildWhichIsA("BasePart", true);
        end;

        return v58;
    end;

    local Model = Instance.new("Model");
    Model.Name = p57;

    if p56:IsA("BasePart") then
        local v59 = p56:Clone();
        v59.Name = "PrimaryPart";
        v59.Parent = Model;
        Model.PrimaryPart = v59;
    elseif p56:IsA("Tool") then
        for _, descendant in p56:GetDescendants() do
            if descendant:IsA("BasePart") then
                local v60 = descendant:Clone();
                v60.Anchored = true;
                v60.Parent = Model;

                if descendant.Name == "Handle" or not Model.PrimaryPart then
                    Model.PrimaryPart = v60;
                end;
            end;
        end;
    end;

    if Model.PrimaryPart then
        return Model;
    end;

    Model:Destroy();
end;

local function createPlaceholderModel(p61, p62) -- Line: 324
    local Model = Instance.new("Model");
    Model.Name = p61;
    local Part = Instance.new("Part");
    Part.Name = "PrimaryPart";
    Part.Size = p62 == "Sprinkler" and Vector3.new(2, 0.4, 2) or Vector3.new(2, 2, 2);
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.Color = p62 == "Sprinkler" and Color3.fromRGB(70, 180, 255) or Color3.fromRGB(255, 255, 255);
    Part.Material = Enum.Material.SmoothPlastic;
    Part.Shape = p62 == "Sprinkler" and Enum.PartType.Cylinder or Enum.PartType.Block;
    Part.Parent = Model;
    Model.PrimaryPart = Part;

    return Model;
end;

local function addRangePart(p63, p64) -- Line: 343
    -- upvalues: Assets (copy)
    local v65;

    if p64 then
        v65 = p64.range;
    else
        v65 = p64;
    end;

    if type(v65) ~= "number" or v65 <= 0 then
        return;
    end;

    local v66 = Assets:FindFirstChild(p64 and (p64.ring or "SprinklerRing") or "SprinklerRing") or Assets:FindFirstChild("SprinklerRing");

    if v66 and v66:IsA("BasePart") then
        local v67 = v65 * 2;
        local v68 = v66:Clone();
        v68.Name = p64 and p64.ring or "Range";
        v68:SetAttribute("VisualOnly", true);
        v68:SetAttribute("Range", v65);
        v68:SetAttribute("Diameter", v67);
        v68.Anchored = true;
        v68.CanCollide = false;
        v68.CanTouch = false;
        v68.CanQuery = false;
        v68.CastShadow = false;
        v68.Size = Vector3.new(v67, v68.Size.Y, v67);
        v68.CFrame = p63:GetPivot();
        v68.Parent = workspace.Previews;

        return v68;
    end;
end;

local function getPreviewModel(p69, p70, p71) -- Line: 369
    -- upvalues: u4 (copy), findPlacementAsset (copy), modelFromInstance (copy), u5 (copy), createPlaceholderModel (copy), Assets (copy), u6 (copy)
    if p70 == "Farmer" then
        local v72 = p71 and (p71:GetAttribute("Mutations") or "") or "";

        if p71 then
            p69 = p71:GetAttribute("FarmerName") or p69;
        end;

        if p71 then
            p71 = p71:GetAttribute("Huge") == true;
        end;

        return u4.getModel(p69, v72, p71) or u4.getDisplayModel(p69, v72, p71), p69;
    end;

    if p70 == "Sprinkler" then
        local v73 = modelFromInstance(findPlacementAsset(p69, p70), p69);
        local v74 = u5[p69];
        local v75 = v73 or createPlaceholderModel(p69, p70);

        if v75 then
            if v74 then
                v74 = v74.range;
            end;

            v75:SetAttribute("Range", v74);
        end;

        return v75, p69;
    end;

    if p70 == "Fertilizer" then
        local v76 = modelFromInstance(Assets:FindFirstChild("FertilizerPart"), p69);
        local v77 = u6[p69];
        local v78 = v76 or createPlaceholderModel(p69, p70);

        if v78 and v78.PrimaryPart then
            if v77 then
                v77 = v77.range;
            end;

            local v79 = type(v77) == "number" and v77 * 2 or v78.PrimaryPart.Size.X;
            v78.PrimaryPart.Size = Vector3.new(v79, v78.PrimaryPart.Size.Y, v79);
            v78:SetAttribute("Range", v77);
        end;

        return v78, p69;
    end;
end;

local function start(p80, p81) -- Line: 406
    -- upvalues: u9 (ref), u3 (copy), LocalPlayer (copy), UserInputService (copy), u16 (ref), getPreviewModel (copy), u21 (ref), u22 (ref), u17 (ref), addRangePart (copy), u5 (copy), Highlight (copy), RunService (copy), u7 (copy), getAimResult (copy), u18 (ref), u15 (copy), u19 (ref), isBoxClear (copy), u20 (ref), getFloorIdFromGround (copy), u14 (copy), u10 (ref), placeCurrent (copy)
    if u9 then
        return;
    end;

    local Fire = u3.Fire;
    local v82;

    if LocalPlayer:GetAttribute("Device") == "Mobile" then
        v82 = true;
    else
        v82 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.GamepadEnabled;
    end;

    Fire("PlaceButton", v82);
    local Character = LocalPlayer.Character;
    local Backpack = LocalPlayer:FindFirstChild("Backpack");
    local v83 = Character and Character:FindFirstChild(p80);

    if v83 then
        Backpack = v83;
    elseif Backpack then
        Backpack = Backpack:FindFirstChild(p80);
    end;

    local v84 = p81 or (Backpack and (Backpack:GetAttribute("type") or "Farmer") or "Farmer");
    local v85 = type(v84) == "string" and (v84 or "") or "";
    local v86 = string.lower(v85);
    local v87 = (v86 == "gnome" or v86 == "farmer") and "Farmer" or ((v86 == "sprikler" or v86 == "sprinkler") and "Sprinkler" or ((v86 == "fertilizer" or v86 == "fertiliser") and "Fertilizer" or v85));
    local v88, v89 = getPreviewModel(p80, v87, Backpack);
    u16 = v88;

    if not u16 then
        return;
    end;

    u21 = v89;
    u22 = v87;

    if u16.PrimaryPart then
        u16.PrimaryPart.Anchored = true;
    end;

    local v90 = next;
    local v91, v92 = u16:GetDescendants();

    for _, v in v90, v91, v92 do
        if v:IsA("BasePart") then
            v.Anchored = true;
            v.CanCollide = false;
        end;
    end;

    u16.Parent = workspace.Previews;

    if v87 == "Sprinkler" then
        u17 = addRangePart(u16, u5[v89]);
    end;

    Highlight.Parent = u16;
    Highlight.Adornee = u16;
    local u93 = tick();
    u9 = RunService.RenderStepped:Connect(function() -- Line: 445
        -- upvalues: u93 (ref), LocalPlayer (ref), u7 (ref), u16 (ref), getAimResult (ref), u18 (ref), Highlight (ref), u15 (ref), u17 (ref), u19 (ref), isBoxClear (ref), u22 (ref), u20 (ref), getFloorIdFromGround (ref), u14 (ref)
        if tick() - u93 <= 0.01 then
            return;
        end;

        u93 = tick();
        local v94 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");

        if not v94 then
            return;
        end;

        local Ground = u7.Value:FindFirstChild("Ground");

        if not Ground then
            return;
        end;

        if not u16 then
            return;
        end;

        local v95 = getAimResult(v94);

        if not v95 then
            u18 = false;
            Highlight.Enabled = true;
            Highlight.FillColor = u15;
            Highlight.OutlineColor = u15;

            return;
        end;

        local Position = v95.Position;
        local Position2 = u7.Value:GetPivot().Position;
        local v96 = Vector3.new(Position.X - Position2.X, 0, Position.Z - Position2.Z);

        if v96.Magnitude <= 0 then
            return;
        end;

        local v97 = CFrame.lookAt(Position, Position + v96.Unit);
        u16:PivotTo(v97);

        if u17 then
            u17.CFrame = v97;
        end;

        u19 = v97;
        local v98;

        if v95 and Ground then
            local Instance2 = v95.Instance;
            v98 = Instance2 == Ground and true or Instance2:IsDescendantOf(Ground);
        else
            v98 = false;
        end;

        u18 = v98 and isBoxClear(u16, Ground, u22);
        u20 = v98 and getFloorIdFromGround(v95.Instance, Ground) or "1";
        local v99 = u18;
        Highlight.Enabled = true;
        Highlight.FillColor = v99 and u14 or u15;
        Highlight.OutlineColor = v99 and u14 or u15;
    end);
    local v100;

    if LocalPlayer:GetAttribute("Device") == "Mobile" then
        v100 = true;
    else
        v100 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.GamepadEnabled;
    end;

    if not v100 then
        u10 = UserInputService.InputBegan:Connect(function(p101, p102) -- Line: 492
            -- upvalues: placeCurrent (ref)
            if p102 then
                return;
            end;

            if p101.UserInputType == Enum.UserInputType.MouseButton1 or (p101.KeyCode == Enum.KeyCode.ButtonA or p101.KeyCode == Enum.KeyCode.ButtonR2) then
                task.spawn(placeCurrent);
            end;
        end);
    end;
end;

function v8.Initialize(p103) -- Line: 504
    -- upvalues: u16 (ref), u18 (ref), u20 (ref), placeCurrent (copy), u3 (copy), stop (copy), start (copy), u2 (copy)
    function _G.GetPlacingItem() -- Line: 506
        -- upvalues: u16 (ref), u18 (ref), u20 (ref)
        return u16, u18, u20;
    end;

    _G.PlaceCurrentItem = placeCurrent;
    u3.new("Place"):Connect(function(p104, p105, p106) -- Line: 511
        -- upvalues: stop (ref), start (ref)
        if p104 then
            start(p105, p106);

            return;
        end;

        stop();
    end);
    u2:BindEvents({
        StopPlacement = function() -- Line: 521, Name: StopPlacement
            -- upvalues: stop (ref)
            stop();
        end
    });
end;

return v8;