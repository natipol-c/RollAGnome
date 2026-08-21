--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Give Item
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Give Item
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:41 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Crops");
local u2 = Library.get("Farmers");
local u3 = Library.get("Network");
local u4 = Library.get("Signal");
local Pets = require(ReplicatedStorage.Library.Configs.Pets);
local LocalPlayer = Players.LocalPlayer;
local v5 = {};
local u6 = nil;
local u7 = {};
local u8 = nil;

local function normalizeItemType(p9) -- Line: 32
    local v10 = type(p9) == "string" and string.lower(p9) or nil;

    if v10 == "fruit" or v10 == "plant" then
        return "Plant";
    end;

    if v10 == "farmer" or v10 == "gnome" then
        return "Farmer";
    end;

    if v10 == "pet" then
        return "Pet";
    end;
end;

local function toolMatchesItemType(p11, p12) -- Line: 43
    if p11 then
        p11 = p11:GetAttribute("type");
    end;

    local v13;

    if type(p12) == "string" then
        v13 = string.lower(p12) or nil;
    else
        v13 = nil;
    end;

    local v14 = (v13 == "fruit" or v13 == "plant") and "Plant" or ((v13 == "farmer" or v13 == "gnome") and "Farmer" or (v13 == "pet" and "Pet" or nil));

    return v14 == nil and (p11 == "Plant" or (p11 == "Farmer" or p11 == "Pet")) and true or p11 == v14;
end;

local function getHeldGiftTool(p15) -- Line: 50
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

    local v18 = (v17 == "fruit" or v17 == "plant") and "Plant" or ((v17 == "farmer" or v17 == "gnome") and "Farmer" or (v17 == "pet" and "Pet" or nil));

    if (v18 ~= nil or v16 ~= "Plant" and (v16 ~= "Farmer" and v16 ~= "Pet")) and v16 ~= v18 then
        return;
    end;

    if type(Character:GetAttribute("Id")) == "string" then
        return Character;
    end;
end;

local function getToolDisplayInfo(p19) -- Line: 61
    -- upvalues: u1 (copy), u2 (copy), Pets (copy)
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

    if v20 == "Farmer" then
        local v22 = p19:GetAttribute("FarmerName") or p19.Name;
        local v23 = u2[v22];

        if v23 then
            return v23.DisplayName or v22, p19:GetAttribute("Subtitle") or "x1";
        end;

        return;
    end;

    if v20 ~= "Pet" then
        return;
    end;

    local v24 = p19:GetAttribute("PetName") or (p19:GetAttribute("ItemName") or p19.Name);
    local v25 = Pets[v24];

    if v25 then
        return v25.name or v24, p19:GetAttribute("Subtitle") or v24;
    end;
end;

local function clearPrompts() -- Line: 86
    -- upvalues: Players (copy), LocalPlayer (copy)
    local v26 = next;
    local v27, v28 = Players:GetPlayers();

    for _, v in v26, v27, v28 do
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

local function stopGiving() -- Line: 99
    -- upvalues: u8 (ref), clearPrompts (copy)
    u8 = nil;
    clearPrompts();
end;

local function addPrompts(p29, u30) -- Line: 104
    -- upvalues: clearPrompts (copy), u8 (ref), LocalPlayer (copy), getToolDisplayInfo (copy), Players (copy), u3 (copy)
    clearPrompts();
    local v31;

    if p29 then
        v31 = u30 or nil;
    else
        v31 = nil;
    end;

    u8 = v31;
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChildWhichIsA("Tool");
    end;

    if Character then
        local v32;

        if Character then
            v32 = Character:GetAttribute("type");
        else
            v32 = Character;
        end;

        local v33;

        if type(u30) == "string" then
            v33 = string.lower(u30) or nil;
        else
            v33 = nil;
        end;

        local v34 = (v33 == "fruit" or v33 == "plant") and "Plant" or ((v33 == "farmer" or v33 == "gnome") and "Farmer" or (v33 == "pet" and "Pet" or nil));

        if v34 == nil and (v32 == "Plant" or (v32 == "Farmer" or v32 == "Pet")) and true or v32 == v34 then
            if type(Character:GetAttribute("Id")) ~= "string" then
                Character = nil;
            end;
        else
            Character = nil;
        end;
    else
        Character = nil;
    end;

    if p29 then
        if not Character then
            return;
        end;

        if not getToolDisplayInfo(Character) then
            return;
        end;
    end;

    local v35 = next;
    local v36, v37 = Players:GetPlayers();

    for _, v in v35, v36, v37 do
        if v ~= LocalPlayer then
            local Character2 = v.Character;

            if Character2 then
                local HumanoidRootPart = Character2:FindFirstChild("HumanoidRootPart");

                if HumanoidRootPart and p29 then
                    local ProximityPrompt = Instance.new("ProximityPrompt");
                    ProximityPrompt.Name = "GiveItemPrompt";
                    ProximityPrompt.ObjectText = "";
                    ProximityPrompt.ActionText = "Give";
                    ProximityPrompt.MaxActivationDistance = 10;
                    ProximityPrompt.HoldDuration = 1;
                    ProximityPrompt.RequiresLineOfSight = false;
                    ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom;
                    ProximityPrompt.Parent = HumanoidRootPart;
                    local u38 = false;
                    ProximityPrompt.Triggered:Connect(function() -- Line: 136
                        -- upvalues: Character (ref), u30 (copy), LocalPlayer (ref), clearPrompts (ref), getToolDisplayInfo (ref), u38 (ref), v (copy), u3 (ref)
                        local v39 = u30;
                        local Character3 = LocalPlayer.Character;

                        if Character3 then
                            Character3 = Character3:FindFirstChildWhichIsA("Tool");
                        end;

                        if Character3 then
                            local v40;

                            if Character3 then
                                v40 = Character3:GetAttribute("type");
                            else
                                v40 = Character3;
                            end;

                            local v41;

                            if type(v39) == "string" then
                                v41 = string.lower(v39) or nil;
                            else
                                v41 = nil;
                            end;

                            local v42 = (v41 == "fruit" or v41 == "plant") and "Plant" or ((v41 == "farmer" or v41 == "gnome") and "Farmer" or (v41 == "pet" and "Pet" or nil));

                            if v42 == nil and (v40 == "Plant" or (v40 == "Farmer" or v40 == "Pet")) and true or v40 == v42 then
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

                        local u43 = Character:GetAttribute("Id");
                        local v44, v45 = getToolDisplayInfo(Character);

                        if not v44 then
                            return;
                        end;

                        if u38 then
                            return;
                        end;

                        u38 = true;
                        _G.AreYouSure({
                            Message = `Do you want to give your {v44} ({v45}) to {v.DisplayName}?`,

                            Callback = function(p46) -- Line: 152, Name: Callback
                                -- upvalues: u3 (ref), v (ref), u43 (copy)
                                if p46 then
                                    u3:FireServer("RequestGiftItem", v, u43);
                                end;
                            end
                        });
                        task.wait(1);
                        u38 = false;
                    end);
                end;
            end;
        end;
    end;
end;

local function disconnectToolConnections() -- Line: 165
    -- upvalues: u7 (ref)
    for _, v in u7 do
        v:Disconnect();
    end;

    u7 = {};
end;

local function watchCharacter(p47) -- Line: 173
    -- upvalues: u7 (ref), clearPrompts (copy), addPrompts (copy), u8 (ref), LocalPlayer (copy)
    for _, v in u7 do
        v:Disconnect();
    end;

    u7 = {};
    clearPrompts();

    if not p47 then
        return;
    end;

    table.insert(u7, p47.ChildAdded:Connect(function(p48) -- Line: 178
        -- upvalues: addPrompts (ref), u8 (ref)
        if not p48:IsA("Tool") then
            return;
        end;

        task.defer(addPrompts, true, u8);
    end));
    table.insert(u7, p47.ChildRemoved:Connect(function(p49) -- Line: 183
        -- upvalues: addPrompts (ref), u8 (ref), LocalPlayer (ref)
        if not p49:IsA("Tool") then
            return;
        end;

        task.defer(function() -- Line: 185
            -- upvalues: addPrompts (ref), u8 (ref), LocalPlayer (ref)
            local v50 = u8;
            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChildWhichIsA("Tool");
            end;

            if Character then
                local v51;

                if Character then
                    v51 = Character:GetAttribute("type");
                else
                    v51 = Character;
                end;

                local v52;

                if type(v50) == "string" then
                    v52 = string.lower(v50) or nil;
                else
                    v52 = nil;
                end;

                local v53 = (v52 == "fruit" or v52 == "plant") and "Plant" or ((v52 == "farmer" or v52 == "gnome") and "Farmer" or (v52 == "pet" and "Pet" or nil));

                if v53 == nil and (v51 == "Plant" or (v51 == "Farmer" or v51 == "Pet")) and true or v51 == v53 then
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
    task.defer(function() -- Line: 190
        -- upvalues: addPrompts (ref), u8 (ref), LocalPlayer (ref)
        local v54 = u8;
        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChildWhichIsA("Tool");
        end;

        if Character then
            local v55;

            if Character then
                v55 = Character:GetAttribute("type");
            else
                v55 = Character;
            end;

            local v56;

            if type(v54) == "string" then
                v56 = string.lower(v54) or nil;
            else
                v56 = nil;
            end;

            local v57 = (v56 == "fruit" or v56 == "plant") and "Plant" or ((v56 == "farmer" or v56 == "gnome") and "Farmer" or (v56 == "pet" and "Pet" or nil));

            if v57 == nil and (v55 == "Plant" or (v55 == "Farmer" or v55 == "Pet")) and true or v55 == v57 then
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

function v5.Initialize(p58) -- Line: 195
    -- upvalues: u4 (copy), addPrompts (copy), watchCharacter (copy), LocalPlayer (copy), u3 (copy), u6 (ref), u8 (ref), clearPrompts (copy)
    u4.new("GiveItem"):Connect(addPrompts);
    watchCharacter(LocalPlayer.Character);
    LocalPlayer.CharacterAdded:Connect(watchCharacter);
    local u59 = nil;
    u3:BindEvents({
        CancelGiftPrompt = function() -- Line: 203, Name: CancelGiftPrompt
            -- upvalues: u6 (ref), u59 (ref)
            if u6 and u59 then
                u59();
            end;
        end,

        StopGivingItem = function() -- Line: 209, Name: StopGivingItem
            -- upvalues: u8 (ref), clearPrompts (ref)
            u8 = nil;
            clearPrompts();
        end
    });
    u3:BindFunctions({
        GiftItemPrompt = function(p60, p61, p62) -- Line: 215, Name: GiftItemPrompt
            -- upvalues: u6 (ref), u59 (ref), u4 (ref)
            if u6 then
                return false;
            end;

            u6 = true;
            local u63 = false;
            local u64 = false;

            u59 = function() -- Line: 222
                -- upvalues: u64 (ref), u63 (ref), u4 (ref)
                if not u64 then
                    u63 = false;
                    u64 = true;
                    u4.Fire("CloseTab", "Are You Sure");
                end;
            end;

            _G.AreYouSure({
                Message = `{p60} wants to gift you a {p61} ({p62}). Accept?`,

                Callback = function(p65) -- Line: 232, Name: Callback
                    -- upvalues: u63 (ref), u64 (ref)
                    u63 = p65 == true;
                    u64 = true;
                end
            });
            local v66 = 0;

            while not u64 do
                v66 = v66 + task.wait();

                if v66 >= 30 then
                    u63 = false;
                    u64 = true;
                    u4.Fire("CloseTab", "Are You Sure");
                end;
            end;

            u59 = nil;
            u6 = nil;

            return u63;
        end
    });
end;

return v5;