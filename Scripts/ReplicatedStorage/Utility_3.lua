--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Utility
  Path:     game.ReplicatedStorage.SatchelLoader.Satchel.Packages._Index.1foreverhd_topbarplus@3.3.1.topbarplus.Utility
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 00:11:26 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
local LocalPlayer = game:GetService("Players").LocalPlayer;

function u1.createStagger(p2, u3, u4) -- Line: 13
    local u5 = false;
    local u6 = false;
    local u7 = (not p2 or p2 == 0) and 0.01 or p2;

    local function staggeredCallback(...) -- Line: 29
        -- upvalues: u5 (ref), u6 (ref), u4 (copy), u7 (ref), u3 (copy), staggeredCallback (copy)
        if u5 then
            u6 = true;

            return;
        end;

        local u8 = table.pack(...);
        u5 = true;
        u6 = false;
        task.spawn(function() -- Line: 37
            -- upvalues: u4 (ref), u7 (ref), u3 (ref), u8 (copy)
            if u4 then
                task.wait(u7);
            end;

            u3(table.unpack(u8));
        end);
        task.delay(u7, function() -- Line: 43
            -- upvalues: u5 (ref), u6 (ref), staggeredCallback (ref), u8 (copy)
            u5 = false;

            if u6 then
                staggeredCallback(table.unpack(u8));
            end;
        end);
    end;

    return staggeredCallback;
end;

function u1.round(p9) -- Line: 55
    return math.floor(p9 + 0.5);
end;

function u1.reverseTable(p10) -- Line: 60
    for i = 1, math.floor(#p10 / 2) do
        local v11 = #p10 - i + 1;
        local v12 = p10[i];
        p10[i] = p10[v11];
        p10[v11] = v12;
    end;
end;

function u1.copyTable(p13) -- Line: 67
    -- upvalues: u1 (copy)
    local v14 = type(p13) == "table";
    assert(v14, "First argument must be a table");
    local v15 = table.create(#p13);

    for i, v in pairs(p13) do
        if type(v) == "table" then
            v15[i] = u1.copyTable(v);
        else
            v15[i] = v;
        end;
    end;

    return v15;
end;

local u16 = { "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "<", ">", "?", "@", "{", "}", "[", "]", "!", "(", ")", "=", "+", "~", "#" };

function u1.generateUID(p17) -- Line: 82
    -- upvalues: u16 (copy)
    local v18 = u16;
    local v19 = #v18;
    local v20 = "";

    for _ = 1, p17 or 8 do
        v20 = v20 .. v18[math.random(1, v19)];
    end;

    return v20;
end;

local u21 = {};

function u1.setVisible(u22, p23, p24) -- Line: 95
    -- upvalues: u21 (copy)
    local v25 = u21[u22];

    if not v25 then
        v25 = {};
        u21[u22] = v25;
        u22.Destroying:Once(function() -- Line: 104
            -- upvalues: u21 (ref), u22 (copy)
            u21[u22] = nil;
        end);
    end;

    if p23 then
        v25[p24] = nil;
    else
        v25[p24] = true;
    end;

    if p23 then
        for _, _ in pairs(v25) do
            p23 = false;
            break;
        end;
    end;

    u22.Visible = p23;
end;

function u1.formatStateName(p26) -- Line: 123
    return string.upper((string.sub(p26, 1, 1))) .. string.lower((string.sub(p26, 2)));
end;

function u1.localPlayerRespawned(p27) -- Line: 127
    -- upvalues: LocalPlayer (copy)
    LocalPlayer.CharacterRemoving:Connect(p27);
end;

function u1.getClippedContainer(p28) -- Line: 137
    local ClippedContainer = p28:FindFirstChild("ClippedContainer");

    if not ClippedContainer then
        ClippedContainer = Instance.new("Folder");
        ClippedContainer.Name = "ClippedContainer";
        ClippedContainer.Parent = p28;
    end;

    return ClippedContainer;
end;

local Janitor = require(script.Parent.Packages.Janitor);
local GuiService = game:GetService("GuiService");

function u1.clipOutside(u29, u30) -- Line: 151
    -- upvalues: Janitor (copy), u1 (copy), GuiService (copy)
    local u31 = u29.janitor:add(Janitor.new());
    u30.Destroying:Once(function() -- Line: 153
        -- upvalues: u31 (copy)
        u31:Destroy();
    end);
    u29.janitor:add(u30);
    local Parent = u30.Parent;
    local u32 = u31:add(Instance.new("Frame"));
    u32:SetAttribute("IsAClippedClone", true);
    u32.Name = u30.Name;
    u32.AnchorPoint = u30.AnchorPoint;
    u32.Size = u30.Size;
    u32.Position = u30.Position;
    u32.BackgroundTransparency = 1;
    u32.LayoutOrder = u30.LayoutOrder;
    u32.Parent = Parent;
    local ObjectValue = Instance.new("ObjectValue");
    ObjectValue.Name = "OriginalInstance";
    ObjectValue.Value = u30;
    ObjectValue.Parent = u32;
    local v33 = ObjectValue:Clone();
    u30:SetAttribute("HasAClippedClone", true);
    v33.Name = "ClippedClone";
    v33.Value = u32;
    v33.Parent = u30;
    local u34 = nil;
    local iconModule = require(u29.iconModule);
    local container = iconModule.container;

    local function updateScreenGui() -- Line: 183
        -- upvalues: Parent (copy), u34 (ref), container (copy), u30 (copy), u1 (ref)
        local v35 = Parent:FindFirstAncestorWhichIsA("ScreenGui");

        if not string.match(v35.Name, "Clipped") then
            v35 = container[v35.Name .. "Clipped"];
        end;

        u34 = v35;
        u30.AnchorPoint = Vector2.new(0, 0);
        u30.Parent = u1.getClippedContainer(u34);
    end;

    u31:add(u29.alignmentChanged:Connect(updateScreenGui));
    updateScreenGui();

    for _, child in pairs(u30:GetChildren()) do
        if child:IsA("UIAspectRatioConstraint") then
            child:Clone().Parent = u32;
        end;
    end;

    local widget = u29.widget;
    local u36 = false;
    local u37 = u30:GetAttribute("IgnoreVisibilityUpdater");

    local function updateVisibility() -- Line: 205
        -- upvalues: u37 (copy), widget (copy), u36 (ref), u1 (ref), u30 (copy)
        if u37 then
            return;
        end;

        local Visible = widget.Visible;

        if u36 then
            Visible = false;
        end;

        u1.setVisible(u30, Visible, "ClipHandler");
    end;

    u31:add(widget:GetPropertyChangedSignal("Visible"):Connect(updateVisibility));
    local u38 = nil;

    local function checkIfOutsideParentXBounds() -- Line: 218
        -- upvalues: u29 (copy), u30 (copy), iconModule (copy), u36 (ref), u37 (copy), widget (copy), u1 (ref), u38 (ref), checkIfOutsideParentXBounds (copy), u31 (copy)
        task.defer(function() -- Line: 220
            -- upvalues: u29 (ref), u30 (ref), iconModule (ref), u36 (ref), u37 (ref), widget (ref), u1 (ref), u38 (ref), checkIfOutsideParentXBounds (ref), u31 (ref)
            local v39 = nil;
            local UID = u29.UID;
            local v40;

            if u30:GetAttribute("ClipToJoinedParent") then
                v40 = UID;

                for _ = 1, 10 do
                    local v41 = iconModule.getIconByUID(UID);

                    if not v41 then
                        break;
                    end;

                    local joinedFrame = v41.joinedFrame;
                    UID = v41.parentIconUID;

                    if not joinedFrame then
                        break;
                    end;

                    if joinedFrame and joinedFrame.Name == "DropdownScroller" then
                        v39 = joinedFrame;
                        break;
                    end;

                    v39 = joinedFrame;
                end;
            else
                v40 = UID;
            end;

            if not v39 then
                u36 = false;

                if u37 then
                    return;
                end;

                local Visible = widget.Visible;

                if u36 then
                    Visible = false;
                end;

                u1.setVisible(u30, Visible, "ClipHandler");

                return;
            end;

            local AbsolutePosition = v39.AbsolutePosition;
            local AbsoluteSize = v39.AbsoluteSize;
            local v42 = u30.AbsolutePosition + u30.AbsoluteSize / 2;
            local v43 = v42.X < AbsolutePosition.X or (v42.X > AbsolutePosition.X + AbsoluteSize.X or (v42.Y < AbsolutePosition.Y or v42.Y > AbsolutePosition.Y + AbsoluteSize.Y));

            if v43 ~= u36 then
                u36 = v43;

                if not u37 then
                    local Visible = widget.Visible;

                    if u36 then
                        Visible = false;
                    end;

                    u1.setVisible(u30, Visible, "ClipHandler");
                end;
            end;

            if v39:IsA("ScrollingFrame") and u38 ~= v39 then
                u38 = v39;
                u31:add(v39:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() -- Line: 265
                    -- upvalues: checkIfOutsideParentXBounds (ref)
                    checkIfOutsideParentXBounds();
                end), "Disconnect", "TrackUtilityScroller-" .. v40);
            end;
        end);
    end;

    local CurrentCamera = workspace.CurrentCamera;
    local u44 = u30:GetAttribute("AdditionalOffsetX") or 0;

    local function trackProperty(u45) -- Line: 275
        -- upvalues: u32 (copy), CurrentCamera (copy), u30 (copy), GuiService (ref), u34 (ref), iconModule (copy), u44 (copy), u29 (copy), u36 (ref), u37 (copy), widget (copy), u1 (ref), u38 (ref), checkIfOutsideParentXBounds (copy), u31 (copy)
        local u46 = "Absolute" .. u45;

        local function updateProperty() -- Line: 277
            -- upvalues: u32 (ref), u46 (copy), u45 (copy), CurrentCamera (ref), u30 (ref), GuiService (ref), u34 (ref), iconModule (ref), u44 (ref), u29 (ref), u36 (ref), u37 (ref), widget (ref), u1 (ref), u38 (ref), checkIfOutsideParentXBounds (ref), u31 (ref)
            local v47 = u32[u46];
            local v48 = UDim2.fromOffset(v47.X, v47.Y);

            if u45 == "Position" then
                local v49 = CurrentCamera.ViewportSize.X - u30.AbsoluteSize.X - 4;
                local Offset = v48.X.Offset;

                if Offset < 4 then
                    v49 = 4;
                elseif v49 >= Offset then
                    v49 = Offset;
                end;

                local v50 = UDim2.fromOffset(v49, v48.Y.Offset);
                local X = workspace.CurrentCamera.ViewportSize.X;
                local X2 = u34.AbsoluteSize.X;
                local X3 = u34.AbsolutePosition.X;

                if not iconModule.isOldTopbar then
                    X3 = X - X2 - 0;
                end;

                v48 = v50 + UDim2.fromOffset(-(X3 - u44), GuiService.TopbarInset.Height);
                task.defer(function() -- Line: 220
                    -- upvalues: u29 (ref), u30 (ref), iconModule (ref), u36 (ref), u37 (ref), widget (ref), u1 (ref), u38 (ref), checkIfOutsideParentXBounds (ref), u31 (ref)
                    local v51 = nil;
                    local UID = u29.UID;
                    local v52;

                    if u30:GetAttribute("ClipToJoinedParent") then
                        v52 = UID;

                        for _ = 1, 10 do
                            local v53 = iconModule.getIconByUID(UID);

                            if not v53 then
                                break;
                            end;

                            local joinedFrame = v53.joinedFrame;
                            UID = v53.parentIconUID;

                            if not joinedFrame then
                                break;
                            end;

                            if joinedFrame and joinedFrame.Name == "DropdownScroller" then
                                v51 = joinedFrame;
                                break;
                            end;

                            v51 = joinedFrame;
                        end;
                    else
                        v52 = UID;
                    end;

                    if not v51 then
                        u36 = false;

                        if u37 then
                            return;
                        end;

                        local Visible = widget.Visible;

                        if u36 then
                            Visible = false;
                        end;

                        u1.setVisible(u30, Visible, "ClipHandler");

                        return;
                    end;

                    local AbsolutePosition = v51.AbsolutePosition;
                    local AbsoluteSize = v51.AbsoluteSize;
                    local v54 = u30.AbsolutePosition + u30.AbsoluteSize / 2;
                    local v55 = v54.X < AbsolutePosition.X or (v54.X > AbsolutePosition.X + AbsoluteSize.X or (v54.Y < AbsolutePosition.Y or v54.Y > AbsolutePosition.Y + AbsoluteSize.Y));

                    if v55 ~= u36 then
                        u36 = v55;

                        if not u37 then
                            local Visible = widget.Visible;

                            if u36 then
                                Visible = false;
                            end;

                            u1.setVisible(u30, Visible, "ClipHandler");
                        end;
                    end;

                    if v51:IsA("ScrollingFrame") and u38 ~= v51 then
                        u38 = v51;
                        u31:add(v51:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() -- Line: 265
                            -- upvalues: checkIfOutsideParentXBounds (ref)
                            checkIfOutsideParentXBounds();
                        end), "Disconnect", "TrackUtilityScroller-" .. v52);
                    end;
                end);
            end;

            u30[u45] = v48;
        end;

        local u56 = u1.createStagger(0.01, updateProperty);
        u31:add(u32:GetPropertyChangedSignal(u46):Connect(u56));
        u31:add(u32:GetAttributeChangedSignal("ForceUpdate"):Connect(function() -- Line: 317
            -- upvalues: u56 (copy)
            u56();
        end));
        local v57 = u1.createStagger(0.5, updateProperty, true);
        u31:add(u32:GetPropertyChangedSignal(u46):Connect(v57));

        if u45 == "Position" then
            u31:add(u34:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 336
                -- upvalues: u56 (copy)
                u56();
            end));
        end;
    end;

    task.delay(0.1, checkIfOutsideParentXBounds);
    task.defer(function() -- Line: 220
        -- upvalues: u29 (copy), u30 (copy), iconModule (copy), u36 (ref), u37 (copy), widget (copy), u1 (ref), u38 (ref), checkIfOutsideParentXBounds (copy), u31 (copy)
        local v58 = nil;
        local UID = u29.UID;
        local v59;

        if u30:GetAttribute("ClipToJoinedParent") then
            v59 = UID;

            for _ = 1, 10 do
                local v60 = iconModule.getIconByUID(UID);

                if not v60 then
                    break;
                end;

                local joinedFrame = v60.joinedFrame;
                UID = v60.parentIconUID;

                if not joinedFrame then
                    break;
                end;

                if joinedFrame and joinedFrame.Name == "DropdownScroller" then
                    v58 = joinedFrame;
                    break;
                end;

                v58 = joinedFrame;
            end;
        else
            v59 = UID;
        end;

        if not v58 then
            u36 = false;

            if u37 then
                return;
            end;

            local Visible = widget.Visible;

            if u36 then
                Visible = false;
            end;

            u1.setVisible(u30, Visible, "ClipHandler");

            return;
        end;

        local AbsolutePosition = v58.AbsolutePosition;
        local AbsoluteSize = v58.AbsoluteSize;
        local v61 = u30.AbsolutePosition + u30.AbsoluteSize / 2;
        local v62 = v61.X < AbsolutePosition.X or (v61.X > AbsolutePosition.X + AbsoluteSize.X or (v61.Y < AbsolutePosition.Y or v61.Y > AbsolutePosition.Y + AbsoluteSize.Y));

        if v62 ~= u36 then
            u36 = v62;

            if not u37 then
                local Visible = widget.Visible;

                if u36 then
                    Visible = false;
                end;

                u1.setVisible(u30, Visible, "ClipHandler");
            end;
        end;

        if v58:IsA("ScrollingFrame") and u38 ~= v58 then
            u38 = v58;
            u31:add(v58:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() -- Line: 265
                -- upvalues: checkIfOutsideParentXBounds (ref)
                checkIfOutsideParentXBounds();
            end), "Disconnect", "TrackUtilityScroller-" .. v59);
        end;
    end);

    if not u37 then
        local Visible = widget.Visible;

        if u36 then
            Visible = false;
        end;

        u1.setVisible(u30, Visible, "ClipHandler");
    end;

    trackProperty("Position");
    u31:add(u30:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 348
    end));

    if u30:GetAttribute("TrackCloneSize") then
        trackProperty("Size");
    else
        u31:add(u30:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 358
            -- upvalues: u30 (copy), u32 (copy)
            local AbsoluteSize = u30.AbsoluteSize;
            u32.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y);
        end));
    end;

    return u32;
end;

function u1.joinFeature(u63, u64, u65, p66) -- Line: 367
    local joinJanitor = u63.joinJanitor;
    joinJanitor:clean();

    if not p66 then
        u63:leave();

        return;
    end;

    u63.parentIconUID = u64.UID;
    u63.joinedFrame = p66;
    joinJanitor:add(u64.alignmentChanged:Connect(function() -- Line: 378, Name: updateAlignent
        -- upvalues: u64 (copy), u63 (copy)
        local alignment = u64.alignment;
        u63:setAlignment(alignment == "Center" and "Left" or alignment, true);
    end));
    local alignment = u64.alignment;
    u63:setAlignment(alignment == "Center" and "Left" or alignment, true);
    u63:modifyTheme({ "IconButton", "BackgroundTransparency", 1 }, "JoinModification");
    u63:modifyTheme({ "ClickRegion", "Active", false }, "JoinModification");

    if u64.childModifications then
        task.defer(function() -- Line: 393
            -- upvalues: u63 (copy), u64 (copy)
            u63:modifyTheme(u64.childModifications, u64.childModificationsUID);
        end);
    end;

    local u67 = u63:getInstance("ClickRegion");

    local function makeSelectable() -- Line: 399
        -- upvalues: u67 (copy), u64 (copy)
        u67.Selectable = u64.isSelected;
    end;

    joinJanitor:add(u64.toggled:Connect(makeSelectable));
    task.defer(makeSelectable);
    joinJanitor:add(function() -- Line: 404
        -- upvalues: u67 (copy)
        u67.Selectable = true;
    end);
    local UID = u63.UID;
    table.insert(u65, UID);
    u64:autoDeselect(false);
    u64.childIconsDict[UID] = true;

    if not u64.isEnabled then
        u64:setEnabled(true);
    end;

    u63.joinedParent:Fire(u64);
    joinJanitor:add(function() -- Line: 422
        -- upvalues: u63 (copy), u65 (copy), UID (copy), u64 (copy)
        if not u63.joinedFrame then
            return;
        end;

        for i, v in pairs(u65) do
            if v == UID then
                table.remove(u65, i);
                break;
            end;
        end;

        local v68 = require(u63.iconModule).getIconByUID(u63.parentIconUID);

        if not v68 then
            return;
        end;

        u63:setAlignment(u63.originalAlignment);
        u63.parentIconUID = false;
        u63.joinedFrame = false;
        u63:removeModification("JoinModification");
        local v69 = true;
        local childIconsDict = v68.childIconsDict;
        childIconsDict[UID] = nil;

        for _, _ in pairs(childIconsDict) do
            v69 = false;
            break;
        end;

        if v69 and not v68.isAnOverflow then
            v68:setEnabled(false);
        end;

        local alignment2 = u64.alignment;
        u63:setAlignment(alignment2 == "Center" and "Left" or alignment2, true);
    end);
end;

return u1;