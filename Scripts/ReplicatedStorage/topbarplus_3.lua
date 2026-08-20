--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     topbarplus
  Path:     game.ReplicatedStorage.SatchelLoader.Satchel.Packages._Index.1foreverhd_topbarplus@3.3.1.topbarplus
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Thu Aug 20 23:43:04 2026
]]

-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local ContentProvider = game:GetService("ContentProvider");
local StarterGui = game:GetService("StarterGui");
local Players = game:GetService("Players");
require(script.Types);
local u1 = script;
local Reference = require(u1.Reference);
local v2 = Reference.getObject();
local v3;

if v2 then
    v3 = v2.Value;
else
    v3 = v2;
end;

if v3 and v3 ~= u1 then
    return require(v3);
end;

if not v2 then
    Reference.addToReplicatedStorage();
end;

local GoodSignal = require(u1.Packages.GoodSignal);
local Janitor = require(u1.Packages.Janitor);
local Utility = require(u1.Utility);
local Themes = require(u1.Features.Themes);
local Gamepad = require(u1.Features.Gamepad);
local Overflow = require(u1.Features.Overflow);
local u4 = {};
u4.__index = u4;
local LocalPlayer = Players.LocalPlayer;
local Themes2 = u1.Features.Themes;
local u5 = {};
local u6 = GoodSignal.new();
local Elements = u1.Elements;
local u7 = 0;
u4.baseDisplayOrderChanged = GoodSignal.new();
u4.baseDisplayOrder = 10;
u4.baseTheme = require(Themes2.Default);
u4.isOldTopbar = false;
u4.iconsDictionary = u5;
u4.insetHeightChanged = GoodSignal.new();
u4.container = require(Elements.Container)(u4);
u4.topbarEnabled = true;
u4.iconAdded = GoodSignal.new();
u4.iconRemoved = GoodSignal.new();
u4.iconChanged = GoodSignal.new();

function u4.getIcons() -- Line: 105
    -- upvalues: u4 (copy)
    return u4.iconsDictionary;
end;

function u4.getIconByUID(p8) -- Line: 109
    -- upvalues: u4 (copy)
    return u4.iconsDictionary[p8] or nil;
end;

function u4.getIcon(p9) -- Line: 117
    -- upvalues: u4 (copy), u5 (copy)
    local v10 = u4.getIconByUID(p9);

    if v10 then
        return v10;
    end;

    for _, v in pairs(u5) do
        if v.name == p9 then
            return v;
        end;
    end;

    return nil;
end;

function u4.setTopbarEnabled(p11, p12) -- Line: 130
    -- upvalues: u4 (copy)
    if typeof(p11) ~= "boolean" then
        p11 = u4.topbarEnabled;
    end;

    if not p12 then
        u4.topbarEnabled = p11;
    end;

    for _, v in pairs(u4.container) do
        v.Enabled = p11;
    end;
end;

function u4.modifyBaseTheme(p13) -- Line: 142
    -- upvalues: Themes (copy), u4 (copy), u5 (copy)
    local v14 = Themes.getModifications(p13);

    for _, v in pairs(v14) do
        for _, v4 in pairs(u4.baseTheme) do
            Themes.merge(v4, v);
        end;
    end;

    for _, v in pairs(u5) do
        v:setTheme(u4.baseTheme);
    end;
end;

function u4.setDisplayOrder(p15) -- Line: 154
    -- upvalues: u4 (copy)
    u4.baseDisplayOrder = p15;
    u4.baseDisplayOrderChanged:Fire(p15);
end;

task.defer(Gamepad.start, u4);
task.defer(Overflow.start, u4);
task.defer(function() -- Line: 164
    -- upvalues: LocalPlayer (copy), u4 (copy), u1 (copy)
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");

    for _, v in pairs(u4.container) do
        v.Parent = PlayerGui;
    end;

    require(u1.Attribute);
end);

function u4.new() -- Line: 175
    -- upvalues: u4 (copy), Janitor (copy), Utility (copy), u5 (copy), GoodSignal (copy), u1 (copy), Elements (copy), u7 (ref), UserInputService (copy), u6 (copy), StarterGui (copy)
    local u16 = {};
    setmetatable(u16, u4);
    local v17 = Janitor.new();
    u16.janitor = v17;
    u16.themesJanitor = v17:add(Janitor.new());
    u16.singleClickJanitor = v17:add(Janitor.new());
    u16.captionJanitor = v17:add(Janitor.new());
    u16.joinJanitor = v17:add(Janitor.new());
    u16.menuJanitor = v17:add(Janitor.new());
    u16.dropdownJanitor = v17:add(Janitor.new());
    local u18 = Utility.generateUID();
    u5[u18] = u16;
    v17:add(function() -- Line: 192
        -- upvalues: u5 (ref), u18 (copy)
        u5[u18] = nil;
    end);
    u16.selected = v17:add(GoodSignal.new());
    u16.deselected = v17:add(GoodSignal.new());
    u16.toggled = v17:add(GoodSignal.new());
    u16.viewingStarted = v17:add(GoodSignal.new());
    u16.viewingEnded = v17:add(GoodSignal.new());
    u16.stateChanged = v17:add(GoodSignal.new());
    u16.notified = v17:add(GoodSignal.new());
    u16.noticeStarted = v17:add(GoodSignal.new());
    u16.noticeChanged = v17:add(GoodSignal.new());
    u16.endNotices = v17:add(GoodSignal.new());
    u16.toggleKeyAdded = v17:add(GoodSignal.new());
    u16.fakeToggleKeyChanged = v17:add(GoodSignal.new());
    u16.alignmentChanged = v17:add(GoodSignal.new());
    u16.updateSize = v17:add(GoodSignal.new());
    u16.resizingComplete = v17:add(GoodSignal.new());
    u16.joinedParent = v17:add(GoodSignal.new());
    u16.menuSet = v17:add(GoodSignal.new());
    u16.dropdownSet = v17:add(GoodSignal.new());
    u16.updateMenu = v17:add(GoodSignal.new());
    u16.startMenuUpdate = v17:add(GoodSignal.new());
    u16.childThemeModified = v17:add(GoodSignal.new());
    u16.indicatorSet = v17:add(GoodSignal.new());
    u16.dropdownChildAdded = v17:add(GoodSignal.new());
    u16.menuChildAdded = v17:add(GoodSignal.new());
    u16.iconModule = u1;
    u16.UID = u18;
    u16.isEnabled = true;
    u16.enabled = u16.isEnabled;
    u16.isSelected = false;
    u16.isViewing = false;
    u16.joinedFrame = false;
    u16.parentIconUID = false;
    u16.deselectWhenOtherIconSelected = true;
    u16.totalNotices = 0;
    u16.activeState = "Deselected";
    u16.alignment = "";
    u16.originalAlignment = "";
    u16.appliedTheme = {};
    u16.appearance = {};
    u16.cachedInstances = {};
    u16.cachedNamesToInstances = {};
    u16.cachedCollectives = {};
    u16.bindedToggleKeys = {};
    u16.customBehaviours = {};
    u16.toggleItems = {};
    u16.bindedEvents = {};
    u16.notices = {};
    u16.menuIcons = {};
    u16.dropdownIcons = {};
    u16.childIconsDict = {};
    u16.creationTime = os.clock();
    u16.widget = v17:add(require(Elements.Widget)(u16, u4));
    u16:setAlignment();
    u7 = u7 + 1;
    local v19 = u7 * 0.01 + 1;
    u16:setOrder(v19, "deselected");
    u16:setOrder(v19, "selected");
    u16:setTheme(u4.baseTheme);
    local v20 = u16:getInstance("ClickRegion");

    local function handleToggle() -- Line: 268
        -- upvalues: u16 (copy)
        if u16.locked then
            return;
        end;

        if u16.isSelected then
            u16:deselect("User", u16);

            return;
        end;

        u16:select("User", u16);
    end;

    local u21 = false;
    local u22 = false;
    v20.MouseButton1Click:Connect(function() -- Line: 280
        -- upvalues: u21 (ref), u22 (ref), u16 (copy)
        if u21 then
            return;
        end;

        u22 = true;
        task.delay(0.01, function() -- Line: 285
            -- upvalues: u22 (ref)
            u22 = false;
        end);

        if u16.locked then
            return;
        end;

        if u16.isSelected then
            u16:deselect("User", u16);

            return;
        end;

        u16:select("User", u16);
    end);
    v20.TouchTap:Connect(function() -- Line: 290
        -- upvalues: u22 (ref), u21 (ref), u16 (copy)
        if u22 then
            return;
        end;

        u21 = true;
        task.delay(0.01, function() -- Line: 297
            -- upvalues: u21 (ref)
            u21 = false;
        end);

        if u16.locked then
            return;
        end;

        if u16.isSelected then
            u16:deselect("User", u16);

            return;
        end;

        u16:select("User", u16);
    end);
    v17:add(UserInputService.InputBegan:Connect(function(p23, p24) -- Line: 304
        -- upvalues: u16 (copy)
        if u16.locked then
            return;
        end;

        if u16.bindedToggleKeys[p23.KeyCode] and not p24 then
            if u16.locked then
                return;
            end;

            if u16.isSelected then
                u16:deselect("User", u16);

                return;
            end;

            u16:select("User", u16);
        end;
    end));

    local function viewingEnded() -- Line: 326
        -- upvalues: u16 (copy)
        if u16.locked then
            return;
        end;

        u16.isViewing = false;
        u16.viewingEnded:Fire(true);
        u16:setState(nil, "User", u16);
    end;

    u16.joinedParent:Connect(function() -- Line: 334
        -- upvalues: u16 (copy)
        if u16.isViewing then
            if u16.locked then
                return;
            end;

            u16.isViewing = false;
            u16.viewingEnded:Fire(true);
            u16:setState(nil, "User", u16);
        end;
    end);
    v20.MouseEnter:Connect(function() -- Line: 339
        -- upvalues: UserInputService (ref), u16 (copy)
        local v25 = not UserInputService.KeyboardEnabled;

        if u16.locked then
            return;
        end;

        u16.isViewing = true;
        u16.viewingStarted:Fire(true);

        if not v25 then
            u16:setState("Viewing", "User", u16);
        end;
    end);
    local u26 = 0;
    v17:add(UserInputService.TouchEnded:Connect(viewingEnded));
    v20.MouseLeave:Connect(viewingEnded);
    v20.SelectionGained:Connect(function(p27) -- Line: 316, Name: viewingStarted
        -- upvalues: u16 (copy)
        if u16.locked then
            return;
        end;

        u16.isViewing = true;
        u16.viewingStarted:Fire(true);

        if not p27 then
            u16:setState("Viewing", "User", u16);
        end;
    end);
    v20.SelectionLost:Connect(viewingEnded);
    v20.MouseButton1Down:Connect(function() -- Line: 348
        -- upvalues: u16 (copy), UserInputService (ref), u26 (ref)
        if not u16.locked and UserInputService.TouchEnabled then
            u26 = u26 + 1;
            local u28 = u26;
            task.delay(0.2, function() -- Line: 352
                -- upvalues: u28 (copy), u26 (ref), u16 (ref)
                if u28 == u26 then
                    if u16.locked then
                        return;
                    end;

                    u16.isViewing = true;
                    u16.viewingStarted:Fire(true);
                    u16:setState("Viewing", "User", u16);
                end;
            end);
        end;
    end);
    v20.MouseButton1Up:Connect(function() -- Line: 359
        -- upvalues: u26 (ref)
        u26 = u26 + 1;
    end);
    local u29 = u16:getInstance("IconOverlay");
    u16.viewingStarted:Connect(function() -- Line: 365
        -- upvalues: u29 (copy), u16 (copy)
        u29.Visible = not u16.overlayDisabled;
    end);
    u16.viewingEnded:Connect(function() -- Line: 368
        -- upvalues: u29 (copy)
        u29.Visible = false;
    end);
    v17:add(u6:Connect(function(p30) -- Line: 373
        -- upvalues: u16 (copy)
        if p30 ~= u16 and (u16.deselectWhenOtherIconSelected and p30.deselectWhenOtherIconSelected) then
            u16:deselect("AutoDeselect", p30);
        end;
    end));
    local v31 = debug.info(2, "s");
    local v32 = string.split(v31, ".");
    local v33 = game;
    local v34 = nil;

    for _, v in pairs(v32) do
        v33 = v33:FindFirstChild(v);

        if not v33 then
            break;
        end;

        if v33:IsA("ScreenGui") then
            v34 = v33;
        end;
    end;

    if v33 and (v34 and v34.ResetOnSpawn == true) then
        u16.originsScreenGui = v34;
        Utility.localPlayerRespawned(function() -- Line: 399
            -- upvalues: u16 (copy)
            u16:destroy();
        end);
    end;

    u16.toggled:Connect(function(p35) -- Line: 405
        -- upvalues: u16 (copy), u4 (ref)
        u16.noticeChanged:Fire(u16.totalNotices);

        for i, _ in pairs(u16.childIconsDict) do
            local v36 = u4.getIconByUID(i);
            v36.noticeChanged:Fire(v36.totalNotices);

            if not p35 and v36.isSelected then
                for _, _ in pairs(v36.childIconsDict) do
                    v36:deselect("HideParentFeature", u16);
                end;
            end;
        end;
    end);
    u16.selected:Connect(function() -- Line: 428
        -- upvalues: u16 (copy), StarterGui (ref)
        if #u16.dropdownIcons > 0 then
            if StarterGui:GetCore("ChatActive") and u16.alignment ~= "Right" then
                u16.chatWasPreviouslyActive = true;
                StarterGui:SetCore("ChatActive", false);
            end;

            if StarterGui:GetCoreGuiEnabled("PlayerList") and u16.alignment ~= "Left" then
                u16.playerlistWasPreviouslyActive = true;
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
            end;
        end;
    end);
    u16.deselected:Connect(function() -- Line: 441
        -- upvalues: u16 (copy), StarterGui (ref)
        if u16.chatWasPreviouslyActive then
            u16.chatWasPreviouslyActive = nil;
            StarterGui:SetCore("ChatActive", true);
        end;

        if u16.playerlistWasPreviouslyActive then
            u16.playerlistWasPreviouslyActive = nil;
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true);
        end;
    end);
    task.delay(0.1, function() -- Line: 455
        -- upvalues: u16 (copy)
        if u16.activeState == "Deselected" then
            u16.stateChanged:Fire("Deselected");
            u16:refresh();
        end;
    end);
    u4.iconAdded:Fire(u16);

    return u16;
end;

function u4.setName(p37, p38) -- Line: 471
    p37.widget.Name = p38;
    p37.name = p38;

    return p37;
end;

function u4.setState(p39, p40, p41, p42) -- Line: 477
    -- upvalues: Utility (copy), u6 (copy)
    local v43 = Utility.formatStateName(p40 or (p39.isSelected and "Selected" or "Deselected"));

    if p39.activeState == v43 then
        return;
    end;

    local isSelected = p39.isSelected;
    p39.activeState = v43;

    if v43 == "Deselected" then
        p39.isSelected = false;

        if isSelected then
            p39.toggled:Fire(false, p41, p42);
            p39.deselected:Fire(p41, p42);
        end;

        p39:_setToggleItemsVisible(false, p41, p42);
    elseif v43 == "Selected" then
        p39.isSelected = true;

        if not isSelected then
            p39.toggled:Fire(true, p41, p42);
            p39.selected:Fire(p41, p42);
            u6:Fire(p39, p41, p42);
        end;

        p39:_setToggleItemsVisible(true, p41, p42);
    end;

    p39.stateChanged:Fire(v43, p41, p42);
end;

function u4.getInstance(u44, u45) -- Line: 510
    -- upvalues: Themes (copy)
    local v46 = u44.cachedNamesToInstances[u45];

    if v46 then
        return v46;
    end;

    local function cacheInstance(u47, u48) -- Line: 518
        -- upvalues: u44 (copy)
        if not u44.cachedInstances[u48] then
            local v49 = u48:GetAttribute("Collective");

            if v49 then
                v49 = u44.cachedCollectives[v49];
            end;

            if v49 then
                table.insert(v49, u48);
            end;

            u44.cachedNamesToInstances[u47] = u48;
            u44.cachedInstances[u48] = true;
            u48.Destroying:Once(function() -- Line: 528
                -- upvalues: u44 (ref), u47 (copy), u48 (copy)
                u44.cachedNamesToInstances[u47] = nil;
                u44.cachedInstances[u48] = nil;
            end);
        end;
    end;

    local widget = u44.widget;
    cacheInstance("Widget", widget);

    if u45 == "Widget" then
        return widget;
    end;

    local u50 = nil;

    local function scanChildren(p51) -- Line: 541
        -- upvalues: u44 (copy), Themes (ref), scanChildren (copy), cacheInstance (copy), u45 (copy), u50 (ref)
        for _, child in pairs(p51:GetChildren()) do
            local v52 = child:GetAttribute("WidgetUID");

            if not v52 or v52 == u44.UID then
                local v53 = Themes.getRealInstance(child) or child;
                scanChildren(v53);

                if v53:IsA("GuiBase") or (v53:IsA("UIBase") or v53:IsA("ValueBase")) then
                    local Name = v53.Name;
                    cacheInstance(Name, v53);

                    if Name == u45 then
                        u50 = v53;
                    end;
                end;
            end;
        end;
    end;

    scanChildren(widget);

    return u50;
end;

function u4.getCollective(p54, p55) -- Line: 570
    local v56 = p54.cachedCollectives[p55];

    if v56 then
        return v56;
    end;

    local v57 = {};

    for i, _ in pairs(p54.cachedInstances) do
        if i:GetAttribute("Collective") == p55 then
            table.insert(v57, i);
        end;
    end;

    p54.cachedCollectives[p55] = v57;

    return v57;
end;

function u4.getInstanceOrCollective(p58, p59) -- Line: 591
    local v60 = {};
    local v61 = p58:getInstance(p59);

    if v61 then
        table.insert(v60, v61);
    end;

    if #v60 == 0 then
        v60 = p58:getCollective(p59);
    end;

    return v60;
end;

function u4.getStateGroup(p62, p63) -- Line: 605
    local v64 = p63 or p62.activeState;
    local v65 = p62.appearance[v64];

    if not v65 then
        v65 = {};
        p62.appearance[v64] = v65;
    end;

    return v65;
end;

function u4.refreshAppearance(p66, p67, p68) -- Line: 615
    -- upvalues: Themes (copy)
    Themes.refresh(p66, p67, p68);

    return p66;
end;

function u4.refresh(p69) -- Line: 620
    p69:refreshAppearance(p69.widget);
    p69.updateSize:Fire();

    return p69;
end;

function u4.updateParent(p70) -- Line: 626
    -- upvalues: u4 (copy)
    local v71 = u4.getIconByUID(p70.parentIconUID);

    if v71 then
        v71.updateSize:Fire();
    end;
end;

function u4.setBehaviour(p72, p73, p74, p75, p76) -- Line: 633
    p72.customBehaviours[p73 .. "-" .. p74] = p75;

    if p76 then
        local v77 = p72:getInstanceOrCollective(p73);

        for _, v in pairs(v77) do
            p72:refreshAppearance(v, p74);
        end;
    end;
end;

function u4.modifyTheme(p78, p79, p80) -- Line: 646
    -- upvalues: Themes (copy)
    return p78, Themes.modify(p78, p79, p80);
end;

function u4.modifyChildTheme(p81, p82, p83) -- Line: 651
    -- upvalues: u4 (copy)
    p81.childModifications = p82;
    p81.childModificationsUID = p83;

    for i, _ in pairs(p81.childIconsDict) do
        u4.getIconByUID(i):modifyTheme(p82, p83);
    end;

    p81.childThemeModified:Fire();

    return p81;
end;

function u4.removeModification(p84, p85) -- Line: 664
    -- upvalues: Themes (copy)
    Themes.remove(p84, p85);

    return p84;
end;

function u4.removeModificationWith(p86, p87, p88, p89) -- Line: 669
    -- upvalues: Themes (copy)
    Themes.removeWith(p86, p87, p88, p89);

    return p86;
end;

function u4.setTheme(p90, p91) -- Line: 674
    -- upvalues: Themes (copy)
    Themes.set(p90, p91);

    return p90;
end;

function u4.setEnabled(p92, p93) -- Line: 679
    p92.isEnabled = p93;
    p92.enabled = p92.isEnabled;
    p92.widget.Visible = p93;
    p92:updateParent();

    return p92;
end;

function u4.select(p94, p95, p96) -- Line: 687
    p94:setState("Selected", p95, p96);

    return p94;
end;

function u4.deselect(p97, p98, p99) -- Line: 692
    p97:setState("Deselected", p98, p99);

    return p97;
end;

function u4.notify(p100, p101, p102) -- Line: 697
    -- upvalues: Elements (copy), u4 (copy)
    if not p100.notice then
        p100.notice = require(Elements.Notice)(p100, u4);
    end;

    p100.noticeStarted:Fire(p101, p102);

    return p100;
end;

function u4.clearNotices(p103) -- Line: 711
    p103.endNotices:Fire();

    return p103;
end;

function u4.disableOverlay(p104, p105) -- Line: 716
    p104.overlayDisabled = p105;

    return p104;
end;

u4.disableStateOverlay = u4.disableOverlay;

function u4.setImage(p106, u107, p108) -- Line: 722
    -- upvalues: ContentProvider (copy)
    p106:modifyTheme({
        "IconImage",
        "Image",
        u107,
        p108
    });
    task.spawn(function() -- Line: 726
        -- upvalues: u107 (copy), ContentProvider (ref)
        local v109;

        if tonumber(u107) then
            v109 = `rbxassetid://{u107}`;
        else
            v109 = u107;
        end;

        if ContentProvider:GetAssetFetchStatus(v109) ~= Enum.AssetFetchStatus.Success then
            pcall(ContentProvider.PreloadAsync, ContentProvider, { v109 });
        end;
    end);

    return p106;
end;

function u4.setLabel(p110, p111, p112) -- Line: 738
    p110:modifyTheme({
        "IconLabel",
        "Text",
        p111,
        p112
    });

    return p110;
end;

function u4.setOrder(p113, p114, p115) -- Line: 743
    local v116 = p114 * 100;
    p113:modifyTheme({
        "IconSpot",
        "LayoutOrder",
        v116,
        p115
    });
    p113:modifyTheme({
        "Widget",
        "LayoutOrder",
        v116,
        p115
    });

    return p113;
end;

function u4.setCornerRadius(p117, p118, p119) -- Line: 752
    p117:modifyTheme({
        "IconCorners",
        "CornerRadius",
        p118,
        p119
    });

    return p117;
end;

function u4.align(p120, p121, p122) -- Line: 757
    -- upvalues: u4 (copy)
    local v123 = tostring(p121):lower();
    local v124 = (v123 == "mid" or v123 == "centre") and "center" or v123;
    local v125 = v124 ~= "left" and (v124 ~= "center" and v124 ~= "right") and "left" or v124;
    local v126 = v125 == "center" and u4.container.TopbarCentered or u4.container.TopbarStandard;
    local Holders = v126.Holders;
    local v127 = string.upper((string.sub(v125, 1, 1))) .. string.sub(v125, 2);

    if not p122 then
        p120.originalAlignment = v127;
    end;

    local joinedFrame = p120.joinedFrame;
    local v128 = Holders[v127];
    p120.screenGui = v126;
    p120.alignmentHolder = v128;

    if not p120.isDestroyed then
        p120.widget.Parent = joinedFrame or v128;
    end;

    p120.alignment = v127;
    p120.alignmentChanged:Fire(v127);
    u4.iconChanged:Fire(p120);

    return p120;
end;

u4.setAlignment = u4.align;

function u4.setLeft(p129) -- Line: 786
    p129:setAlignment("Left");

    return p129;
end;

function u4.setMid(p130) -- Line: 791
    p130:setAlignment("Center");

    return p130;
end;

function u4.setRight(p131) -- Line: 796
    p131:setAlignment("Right");

    return p131;
end;

function u4.setWidth(p132, p133, p134) -- Line: 801
    p132:modifyTheme({
        "Widget",
        "DesiredWidth",
        p133,
        p134
    });

    return p132;
end;

function u4.setImageScale(p135, p136, p137) -- Line: 809
    p135:modifyTheme({
        "IconImageScale",
        "Value",
        p136,
        p137
    });

    return p135;
end;

function u4.setImageRatio(p138, p139, p140) -- Line: 814
    p138:modifyTheme({
        "IconImageRatio",
        "AspectRatio",
        p139,
        p140
    });

    return p138;
end;

function u4.setTextSize(p141, p142, p143) -- Line: 819
    p141:modifyTheme({
        "IconLabel",
        "TextSize",
        p142,
        p143
    });

    return p141;
end;

function u4.setTextFont(p144, p145, p146, p147, p148) -- Line: 824
    local v149 = p146 or Enum.FontWeight.Regular;
    local v150 = p147 or Enum.FontStyle.Normal;
    local v151 = nil;
    local v152 = typeof(p145);

    if v152 == "number" then
        v151 = Font.fromId(p145, v149, v150);
    elseif v152 == "EnumItem" then
        v151 = Font.fromEnum(p145);
    elseif v152 == "string" and not p145:match("rbxasset") then
        v151 = Font.fromName(p145, v149, v150);
    end;

    p144:modifyTheme({
        "IconLabel",
        "FontFace",
        v151 or Font.new(p145, v149, v150),
        p148
    });

    return p144;
end;

function u4.bindToggleItem(p153, p154) -- Line: 845
    if not (p154:IsA("GuiObject") or p154:IsA("LayerCollector")) then
        error("Toggle item must be a GuiObject or LayerCollector!");
    end;

    p153.toggleItems[p154] = true;
    p153:_updateSelectionInstances();

    return p153;
end;

function u4.unbindToggleItem(p155, p156) -- Line: 854
    p155.toggleItems[p156] = nil;
    p155:_updateSelectionInstances();

    return p155;
end;

function u4._updateSelectionInstances(p157) -- Line: 860
    for i, _ in pairs(p157.toggleItems) do
        local v158 = {};

        for _, descendant in pairs(i:GetDescendants()) do
            if (descendant:IsA("TextButton") or descendant:IsA("ImageButton")) and descendant.Active then
                table.insert(v158, descendant);
            end;
        end;

        p157.toggleItems[i] = v158;
    end;
end;

function u4._setToggleItemsVisible(p159, p160, p161, p162) -- Line: 874
    for i, _ in pairs(p159.toggleItems) do
        if not p162 or (p162 == p159 or p162.toggleItems[i] == nil) then
            i[i:IsA("LayerCollector") and "Enabled" or "Visible"] = p160;
        end;
    end;
end;

function u4.bindEvent(u163, p164, u165) -- Line: 886
    local v166 = u163[p164];
    local v167;

    if v166 then
        if typeof(v166) == "table" then
            v167 = v166.Connect;
        else
            v167 = false;
        end;
    else
        v167 = v166;
    end;

    assert(v167, "argument[1] must be a valid topbarplus icon event name!");
    local v168 = typeof(u165) == "function";
    assert(v168, "argument[2] must be a function!");
    u163.bindedEvents[p164] = v166:Connect(function(...) -- Line: 890
        -- upvalues: u165 (copy), u163 (copy)
        u165(u163, ...);
    end);

    return u163;
end;

function u4.unbindEvent(p169, p170) -- Line: 896
    local v171 = p169.bindedEvents[p170];

    if v171 then
        v171:Disconnect();
        p169.bindedEvents[p170] = nil;
    end;

    return p169;
end;

function u4.bindToggleKey(p172, p173) -- Line: 905
    local v174 = typeof(p173) == "EnumItem";
    assert(v174, "argument[1] must be a KeyCode EnumItem!");
    p172.bindedToggleKeys[p173] = true;
    p172.toggleKeyAdded:Fire(p173);
    p172:setCaption("_hotkey_");

    return p172;
end;

function u4.unbindToggleKey(p175, p176) -- Line: 913
    local v177 = typeof(p176) == "EnumItem";
    assert(v177, "argument[1] must be a KeyCode EnumItem!");
    p175.bindedToggleKeys[p176] = nil;

    return p175;
end;

function u4.call(u178, u179, ...) -- Line: 919
    local u180 = table.pack(...);
    task.spawn(function() -- Line: 921
        -- upvalues: u179 (copy), u178 (copy), u180 (copy)
        u179(u178, table.unpack(u180));
    end);

    return u178;
end;

function u4.addToJanitor(p181, p182, p183, p184) -- Line: 927
    p181.janitor:add(p182, p183, p184);

    return p181;
end;

function u4.lock(p185) -- Line: 932
    p185:getInstance("ClickRegion").Visible = false;
    p185.locked = true;

    return p185;
end;

function u4.unlock(p186) -- Line: 940
    p186:getInstance("ClickRegion").Visible = true;
    p186.locked = false;

    return p186;
end;

function u4.debounce(p187, p188) -- Line: 947
    p187:lock();
    task.wait(p188);
    p187:unlock();

    return p187;
end;

function u4.autoDeselect(p189, p190) -- Line: 954
    p189.deselectWhenOtherIconSelected = p190 == nil and true or p190;

    return p189;
end;

function u4.oneClick(u191, p192) -- Line: 964
    local singleClickJanitor = u191.singleClickJanitor;
    singleClickJanitor:clean();

    if p192 or p192 == nil then
        singleClickJanitor:add(u191.selected:Connect(function() -- Line: 970
            -- upvalues: u191 (copy)
            u191:deselect("OneClick", u191);
        end));
    end;

    u191.oneClickEnabled = true;

    return u191;
end;

function u4.setCaption(p193, p194) -- Line: 978
    -- upvalues: Elements (copy)
    if p194 == "_hotkey_" and p193.captionText then
        return p193;
    end;

    local captionJanitor = p193.captionJanitor;
    p193.captionJanitor:clean();

    if not p194 or p194 == "" then
        p193.caption = nil;
        p193.captionText = nil;

        return p193;
    end;

    local v195 = captionJanitor:add(require(Elements.Caption)(p193));
    v195:SetAttribute("CaptionText", p194);
    p193.caption = v195;
    p193.captionText = p194;

    return p193;
end;

function u4.setCaptionHint(p196, p197) -- Line: 996
    local v198 = typeof(p197) == "EnumItem";
    assert(v198, "argument[1] must be a KeyCode EnumItem!");
    p196.fakeToggleKey = p197;
    p196.fakeToggleKeyChanged:Fire(p197);
    p196:setCaption("_hotkey_");

    return p196;
end;

function u4.leave(p199) -- Line: 1004
    p199.joinJanitor:clean();

    return p199;
end;

function u4.joinMenu(p200, p201) -- Line: 1010
    -- upvalues: Utility (copy)
    Utility.joinFeature(p200, p201, p201.menuIcons, p201:getInstance("Menu"));
    p201.menuChildAdded:Fire(p200);

    return p200;
end;

function u4.setMenu(p202, p203) -- Line: 1016
    p202.menuSet:Fire(p203);

    return p202;
end;

function u4.setFrozenMenu(p204, p205) -- Line: 1021
    p204:freezeMenu(p205);
    p204:setMenu(p205);
end;

function u4.freezeMenu(u206) -- Line: 1026
    u206:select("FrozenMenu", u206);
    u206:bindEvent("deselected", function(p207) -- Line: 1030
        -- upvalues: u206 (copy)
        p207:select("FrozenMenu", u206);
    end);
    u206:modifyTheme({ "IconSpot", "Visible", false });
end;

function u4.joinDropdown(p208, p209) -- Line: 1036
    -- upvalues: Utility (copy)
    p209:getDropdown();
    Utility.joinFeature(p208, p209, p209.dropdownIcons, p209:getInstance("DropdownScroller"));
    p209.dropdownChildAdded:Fire(p208);

    return p208;
end;

function u4.getDropdown(p210) -- Line: 1043
    -- upvalues: Elements (copy)
    local dropdown = p210.dropdown;

    if not dropdown then
        dropdown = require(Elements.Dropdown)(p210);
        p210.dropdown = dropdown;
        p210:clipOutside(dropdown);
    end;

    return dropdown;
end;

function u4.setDropdown(p211, p212) -- Line: 1053
    p211:getDropdown();
    p211.dropdownSet:Fire(p212);

    return p211;
end;

function u4.clipOutside(p213, p214) -- Line: 1059
    -- upvalues: Utility (copy)
    local v215 = Utility.clipOutside(p213, p214);
    p213:refreshAppearance(p214);

    return p213, v215;
end;

function u4.setIndicator(p216, p217) -- Line: 1070
    -- upvalues: Elements (copy), u4 (copy)
    if not p216.indicator then
        p216.indicator = p216.janitor:add(require(Elements.Indicator)(p216, u4));
    end;

    p216.indicatorSet:Fire(p217);
end;

function u4.convertLabelToNumberSpinner(u218, u219, u220) -- Line: 1082
    task.defer(function() -- Line: 1083
        -- upvalues: u218 (copy), u219 (copy), u220 (copy)
        local u221 = u218:getInstance("IconLabel");
        u221.Transparency = 1;
        u219.Parent = u221.Parent;
        u219.Size = UDim2.fromScale(1, 1);
        u219.AnchorPoint = Vector2.new(0.5, 0.5);
        u219.Position = UDim2.new(0.5, 0, 0.5, 0);
        u219.TextXAlignment = Enum.TextXAlignment.Center;
        u219.ClipsDescendants = false;

        for _, v in ipairs({ "FontFace", "BorderSizePixel", "BorderColor3", "Rotation", "TextStrokeTransparency", "TextStrokeColor3", "TextStrokeTransparency", "TextColor3" }) do
            u219[v] = u221[v];
            u218:addToJanitor(u221:GetPropertyChangedSignal(v):Connect(function() -- Line: 1106
                -- upvalues: u219 (ref), v (copy), u221 (copy)
                u219[v] = u221[v];
            end));
        end;

        local function getSpinnerSizeAndDigitCount() -- Line: 1113
            -- upvalues: u219 (ref)
            local v222 = 0;
            local v223 = 0;

            for _, child in u219.Frame:GetChildren() do
                local v224 = string.lower(child.Name);

                if v224 == "digit" then
                    v222 = v222 + child.AbsoluteSize.X;
                    v223 = v223 + 1;
                elseif (v224 == "prefix" or (v224 == "suffix" or v224 == "comma")) and child.Text ~= "" then
                    v222 = v222 + child.AbsoluteSize.X;
                    v223 = v223 + 1;
                end;
            end;

            return v222, v223;
        end;

        local function getLabelParentContainerXSize() -- Line: 1131
            -- upvalues: u221 (copy), u219 (ref)
            local Parent = u221.Parent;

            if Parent then
                Parent = Parent.Parent;
            end;

            if Parent == nil then
                return 0;
            end;

            if Parent.IconImage.Visible == true then
                return u219.Frame.AbsoluteSize.X + u221.Parent.Parent.IconImage.AbsoluteSize.X;
            end;

            return Parent.AbsoluteSize.X;
        end;

        local function getNumberSpinnerXSize() -- Line: 1143
            -- upvalues: u219 (ref)
            return u219.Frame.AbsoluteSize.X;
        end;

        local function adjustSize() -- Line: 1147
            -- upvalues: getSpinnerSizeAndDigitCount (copy), u218 (ref), u219 (ref), u221 (copy)
            local v225, v226 = getSpinnerSizeAndDigitCount();

            if v226 < 18 then
                u218:setLabel(u219.Value);
            end;

            local X = u219.Frame.AbsoluteSize.X;

            while v225 < X and u218.isDestroyed ~= true do
                task.wait(0.05);

                if v226 > 0 and v226 < 8 then
                    u219.TextSize = u221.TextSize;
                    break;
                end;

                local v227 = u219;
                v227.TextSize = v227.TextSize + 1;
                X = u219.Frame.AbsoluteSize.X;
                v225, v226 = getSpinnerSizeAndDigitCount();
            end;

            local Parent = u221.Parent;

            if Parent then
                Parent = Parent.Parent;
            end;

            local v228;

            if Parent == nil then
                v228 = 0;
            elseif Parent.IconImage.Visible == true then
                v228 = u219.Frame.AbsoluteSize.X + u221.Parent.Parent.IconImage.AbsoluteSize.X;
            else
                v228 = Parent.AbsoluteSize.X;
            end;

            while v228 < v225 and u218.isDestroyed ~= true do
                task.wait(0.05);

                if v226 < 8 and v226 > 0 then
                    u219.TextSize = u221.TextSize;

                    return;
                end;

                local v229 = u219;
                v229.TextSize = v229.TextSize - 1;
                local Parent2 = u221.Parent;

                if Parent2 then
                    Parent2 = Parent2.Parent;
                end;

                if Parent2 == nil then
                    v228 = 0;
                elseif Parent2.IconImage.Visible == true then
                    v228 = u219.Frame.AbsoluteSize.X + u221.Parent.Parent.IconImage.AbsoluteSize.X;
                else
                    v228 = Parent2.AbsoluteSize.X;
                end;

                v225, v226 = getSpinnerSizeAndDigitCount();
            end;
        end;

        u218:addToJanitor(u219.Frame.ChildAdded:Connect(adjustSize));
        u218:addToJanitor(u219.Frame.ChildRemoved:Connect(adjustSize));
        u218:addToJanitor(u218.iconAdded:Connect(function() -- Line: 1185
            -- upvalues: adjustSize (copy)
            task.wait(1);
            adjustSize();
        end));
        u218:updateParent();
        u219.Name = "LabelSpinner";
        u219.Prefix = "$";
        u219.Commas = true;
        u219.Decimals = 0;
        u219.Duration = 0.25;
        u219.Value = 10;
        task.wait(0.2);

        if typeof(u220) == "function" then
            u220();
        end;
    end);

    return u218;
end;

function u4.destroy(p230) -- Line: 1212
    -- upvalues: u4 (copy)
    if p230.isDestroyed then
        return;
    end;

    p230:clearNotices();

    if p230.parentIconUID then
        p230:leave();
    end;

    p230.isDestroyed = true;
    p230.janitor:clean();
    u4.iconRemoved:Fire(p230);
end;

u4.Destroy = u4.destroy;

return u4;