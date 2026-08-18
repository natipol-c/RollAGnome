--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Give Item
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Give Item
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:09 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Crops");
local u2 = Library.get("Farmers");
local u3 = Library.get("Network");
local u4 = Library.get("Signal");
local LocalPlayer = Players.LocalPlayer;
local v5 = {};
local u6 = nil;
local u7 = {};
local u8 = nil;

local function normalizeItemType(p9) -- Line: 31
    local v10 = type(p9) == "string" and string.lower(p9) or nil;

    if v10 == "fruit" or v10 == "plant" then
        return "Plant";
    end;

    if v10 == "farmer" or v10 == "gnome" then
        return "Farmer";
    end;
end;

local function toolMatchesItemType(p11, p12) -- Line: 40
    if p11 then
        p11 = p11:GetAttribute("type");
    end;

    local v13;

    if type(p12) == "string" then
        v13 = string.lower(p12) or nil;
    else
        v13 = nil;
    end;

    local v14 = (v13 == "fruit" or v13 == "plant") and "Plant" or ((v13 == "farmer" or v13 == "gnome") and "Farmer" or nil);

    return v14 == nil and (p11 == "Plant" or p11 == "Farmer") and true or p11 == v14;
end;

local function getHeldGiftTool(p15) -- Line: 47
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChildWhichIsA("Tool");
    end;

    if not Character then
        return;
    end;

    local v16;

    if Character then
        v16 = Character:GetAttribute("type");
    else
        v16 = Character;
    end;

    local v17;

    if type(p15) == "string" then
        v17 = string.lower(p15) or nil;
    else
        v17 = nil;
    end;

    local v18 = (v17 == "fruit" or v17 == "plant") and "Plant" or ((v17 == "farmer" or v17 == "gnome") and "Farmer" or nil);

    if (v18 ~= nil or v16 ~= "Plant" and v16 ~= "Farmer") and v16 ~= v18 then
        return;
    end;

    if type(Character:GetAttribute("Id")) == "string" then
        return Character;
    end;
end;

local function getToolDisplayInfo(p19) -- Line: 58
    -- upvalues: u1 (copy), u2 (copy)
    if not p19 then
        return;
    end;

    local v20 = p19:GetAttribute("type");

    if v20 == "Plant" then
        local Name = p19.Name;
        local v21 = u1.get(Name, p19:GetAttribute("Mutations"));

        if v21 then
            return v21.name or Name, p19:GetAttribute("Subtitle") or "";
        end;

        return;
    end;

    if v20 ~= "Farmer" then
        return;
    end;

    local v22 = p19:GetAttribute("FarmerName") or p19.Name;
    local v23 = u2[v22];

    if v23 then
        return v23.DisplayName or v22, p19:GetAttribute("Subtitle") or "x1";
    end;
end;

local function clearPrompts() -- Line: 77
    -- upvalues: Players (copy), LocalPlayer (copy)
    local v24 = next;
    local v25, v26 = Players:GetPlayers();

    for _, v in v24, v25, v26 do
        if v ~= LocalPlayer then
            local Character = v.Character;

            if Character then
                Character = Character:FindFirstChild("HumanoidRootPart");
            end;

            if Character then
                Character = Character:FindFirstChild("GiveItemPrompt");
            end;

            if Character then
                Character:Destroy();
            end;
        end;
    end;
end;

local function stopGiving() -- Line: 90
    -- upvalues: u8 (ref), clearPrompts (copy)
    u8 = nil;
    clearPrompts();
end;

local function addPrompts(p27, u28) -- Line: 95
    -- upvalues: clearPrompts (copy), u8 (ref), LocalPlayer (copy), getToolDisplayInfo (copy), Players (copy), u3 (copy)
    clearPrompts();
    local v29;

    if p27 then
        v29 = u28 or nil;
    else
        v29 = nil;
    end;

    u8 = v29;
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChildWhichIsA("Tool");
    end;

    if Character then
        local v30;

        if Character then
            v30 = Character:GetAttribute("type");
        else
            v30 = Character;
        end;

        local v31;

        if type(u28) == "string" then
            v31 = string.lower(u28) or nil;
        else
            v31 = nil;
        end;

        local v32 = (v31 == "fruit" or v31 == "plant") and "Plant" or ((v31 == "farmer" or v31 == "gnome") and "Farmer" or nil);

        if v32 == nil and (v30 == "Plant" or v30 == "Farmer") and true or v30 == v32 then
            if type(Character:GetAttribute("Id")) ~= "string" then
                Character = nil;
            end;
        else
            Character = nil;
        end;
    else
        Character = nil;
    end;

    if p27 then
        if not Character then
            return;
        end;

        if not getToolDisplayInfo(Character) then
            return;
        end;
    end;

    local v33 = next;
    local v34, v35 = Players:GetPlayers();

    for _, v in v33, v34, v35 do
        if v ~= LocalPlayer then
            local Character2 = v.Character;

            if Character2 then
                local HumanoidRootPart = Character2:FindFirstChild("HumanoidRootPart");

                if HumanoidRootPart and p27 then
                    local ProximityPrompt = Instance.new("ProximityPrompt");
                    ProximityPrompt.Name = "GiveItemPrompt";
                    ProximityPrompt.ObjectText = "";
                    ProximityPrompt.ActionText = "Give";
                    ProximityPrompt.MaxActivationDistance = 10;
                    ProximityPrompt.HoldDuration = 1;
                    ProximityPrompt.RequiresLineOfSight = false;
                    ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom;
                    ProximityPrompt.Parent = HumanoidRootPart;
                    local u36 = false;
                    ProximityPrompt.Triggered:Connect(function() -- Line: 127
                        -- upvalues: Character (ref), u28 (copy), LocalPlayer (ref), clearPrompts (ref), getToolDisplayInfo (ref), u36 (ref), v (copy), u3 (ref)
                        local v37 = u28;
                        local Character3 = LocalPlayer.Character;

                        if Character3 then
                            Character3 = Character3:FindFirstChildWhichIsA("Tool");
                        end;

                        if Character3 then
                            local v38;

                            if Character3 then
                                v38 = Character3:GetAttribute("type");
                            else
                                v38 = Character3;
                            end;

                            local v39;

                            if type(v37) == "string" then
                                v39 = string.lower(v37) or nil;
                            else
                                v39 = nil;
                            end;

                            local v40 = (v39 == "fruit" or v39 == "plant") and "Plant" or ((v39 == "farmer" or v39 == "gnome") and "Farmer" or nil);

                            if v40 == nil and (v38 == "Plant" or v38 == "Farmer") and true or v38 == v40 then
                                if type(Character3:GetAttribute("Id")) ~= "string" then
                                    Character3 = nil;
                                end;
                            else
                                Character3 = nil;
                            end;
                        else
                            Character3 = nil;
                        end;

                        Character = Character3;

                        if not Character then
                            clearPrompts();

                            return;
                        end;

                        local u41 = Character:GetAttribute("Id");
                        local v42, v43 = getToolDisplayInfo(Character);

                        if not v42 then
                            return;
                        end;

                        if u36 then
                            return;
                        end;

                        u36 = true;
                        _G.AreYouSure({
                            Message = `Do you want to give your {v42} ({v43}) to {v.DisplayName}?`,

                            Callback = function(p44) -- Line: 143, Name: Callback
                                -- upvalues: u3 (ref), v (ref), u41 (copy)
                                if p44 then
                                    u3:FireServer("RequestGiftItem", v, u41);
                                end;
                            end
                        });
                        task.wait(1);
                        u36 = false;
                    end);
                end;
            end;
        end;
    end;
end;

local function disconnectToolConnections() -- Line: 156
    -- upvalues: u7 (ref)
    for _, v in u7 do
        v:Disconnect();
    end;

    u7 = {};
end;

local function watchCharacter(p45) -- Line: 164
    -- upvalues: u7 (ref), clearPrompts (copy), addPrompts (copy), u8 (ref), LocalPlayer (copy)
    for _, v in u7 do
        v:Disconnect();
    end;

    u7 = {};
    clearPrompts();

    if not p45 then
        return;
    end;

    table.insert(u7, p45.ChildAdded:Connect(function(p46) -- Line: 169
        -- upvalues: addPrompts (ref), u8 (ref)
        if not p46:IsA("Tool") then
            return;
        end;

        task.defer(addPrompts, true, u8);
    end));
    table.insert(u7, p45.ChildRemoved:Connect(function(p47) -- Line: 174
        -- upvalues: addPrompts (ref), u8 (ref), LocalPlayer (ref)
        if not p47:IsA("Tool") then
            return;
        end;

        task.defer(function() -- Line: 176
            -- upvalues: addPrompts (ref), u8 (ref), LocalPlayer (ref)
            local v48 = u8;
            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChildWhichIsA("Tool");
            end;

            if Character then
                local v49;

                if Character then
                    v49 = Character:GetAttribute("type");
                else
                    v49 = Character;
                end;

                local v50;

                if type(v48) == "string" then
                    v50 = string.lower(v48) or nil;
                else
                    v50 = nil;
                end;

                local v51 = (v50 == "fruit" or v50 == "plant") and "Plant" or ((v50 == "farmer" or v50 == "gnome") and "Farmer" or nil);

                if v51 == nil and (v49 == "Plant" or v49 == "Farmer") and true or v49 == v51 then
                    if type(Character:GetAttribute("Id")) ~= "string" then
                        Character = nil;
                    end;
                else
                    Character = nil;
                end;
            else
                Character = nil;
            end;

            addPrompts(Character ~= nil, u8);
        end);
    end));
    task.defer(function() -- Line: 181
        -- upvalues: addPrompts (ref), u8 (ref), LocalPlayer (ref)
        local v52 = u8;
        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChildWhichIsA("Tool");
        end;

        if Character then
            local v53;

            if Character then
                v53 = Character:GetAttribute("type");
            else
                v53 = Character;
            end;

            local v54;

            if type(v52) == "string" then
                v54 = string.lower(v52) or nil;
            else
                v54 = nil;
            end;

            local v55 = (v54 == "fruit" or v54 == "plant") and "Plant" or ((v54 == "farmer" or v54 == "gnome") and "Farmer" or nil);

            if v55 == nil and (v53 == "Plant" or v53 == "Farmer") and true or v53 == v55 then
                if type(Character:GetAttribute("Id")) ~= "string" then
                    Character = nil;
                end;
            else
                Character = nil;
            end;
        else
            Character = nil;
        end;

        addPrompts(Character ~= nil, u8);
    end);
end;

function v5.Initialize(p56) -- Line: 186
    -- upvalues: u4 (copy), addPrompts (copy), watchCharacter (copy), LocalPlayer (copy), u3 (copy), u6 (ref), u8 (ref), clearPrompts (copy)
    u4.new("GiveItem"):Connect(addPrompts);
    watchCharacter(LocalPlayer.Character);
    LocalPlayer.CharacterAdded:Connect(watchCharacter);
    local u57 = nil;
    u3:BindEvents({
        CancelGiftPrompt = function() -- Line: 194, Name: CancelGiftPrompt
            -- upvalues: u6 (ref), u57 (ref)
            if u6 and u57 then
                u57();
            end;
        end,

        StopGivingItem = function() -- Line: 200, Name: StopGivingItem
            -- upvalues: u8 (ref), clearPrompts (ref)
            u8 = nil;
            clearPrompts();
        end
    });
    u3:BindFunctions({
        GiftItemPrompt = function(p58, p59, p60) -- Line: 206, Name: GiftItemPrompt
            -- upvalues: u6 (ref), u57 (ref), u4 (ref)
            if u6 then
                return false;
            end;

            u6 = true;
            local u61 = false;
            local u62 = false;

            u57 = function() -- Line: 213
                -- upvalues: u62 (ref), u61 (ref), u4 (ref)
                if not u62 then
                    u61 = false;
                    u62 = true;
                    u4.Fire("CloseTab", "Are You Sure");
                end;
            end;

            _G.AreYouSure({
                Message = `{p58} wants to gift you a {p59} ({p60}). Accept?`,

                Callback = function(p63) -- Line: 223, Name: Callback
                    -- upvalues: u61 (ref), u62 (ref)
                    u61 = p63 == true;
                    u62 = true;
                end
            });
            local v64 = 0;

            while not u62 do
                v64 = v64 + task.wait();

                if v64 >= 30 then
                    u61 = false;
                    u62 = true;
                    u4.Fire("CloseTab", "Are You Sure");
                end;
            end;

            u57 = nil;
            u6 = nil;

            return u61;
        end
    });
end;

return v5;