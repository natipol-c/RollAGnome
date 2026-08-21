--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     TopbarPlus
  Path:     game.ReplicatedStorage.Library.Imported.TopbarPlus
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.3
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Sat Aug 22 00:22:35 2026
]]

-- Decompiled with Potassium's decompiler.

game:GetService("LocalizationService");
local UserInputService = game:GetService("UserInputService");
game:GetService("RunService");
game:GetService("TextService");
local StarterGui = game:GetService("StarterGui");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
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
require(u1.Attribute);
local Themes = require(u1.Features.Themes);
local Gamepad = require(u1.Features.Gamepad);
local Overflow = require(u1.Features.Overflow);
local u4 = {};
u4.__index = u4;
local Themes2 = u1.Features.Themes;
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local u5 = {};
local u6 = GoodSignal.new();
local Elements = u1.Elements;
local u7 = 0;

if GuiService.TopbarInset.Height == 0 then
    GuiService:GetPropertyChangedSignal("TopbarInset"):Wait();
end;

u4.baseDisplayOrderChanged = GoodSignal.new();
u4.baseDisplayOrder = 10;
u4.baseTheme = require(Themes2.Default);
u4.isOldTopbar = GuiService.TopbarInset.Height == 36;
u4.iconsDictionary = u5;
u4.container = require(Elements.Container)(u4);
u4.topbarEnabled = true;
u4.iconAdded = GoodSignal.new();
u4.iconRemoved = GoodSignal.new();
u4.iconChanged = GoodSignal.new();

function u4.getIcons() -- Line: 112
    -- upvalues: u4 (copy)
    return u4.iconsDictionary;
end;

function u4.getIconByUID(p8) -- Line: 116
    -- upvalues: u4 (copy)
    local v9 = u4.iconsDictionary[p8];

    if v9 then
        return v9;
    end;
end;

function u4.getIcon(p10) -- Line: 123
    -- upvalues: u4 (copy), u5 (copy)
    local v11 = u4.getIconByUID(p10);

    if v11 then
        return v11;
    end;

    for _, v in pairs(u5) do
        if v.name == p10 then
            return v;
        end;
    end;
end;

function u4.setTopbarEnabled(p12, p13) -- Line: 135
    -- upvalues: u4 (copy)
    if typeof(p12) ~= "boolean" then
        p12 = u4.topbarEnabled;
    end;

    if not p13 then
        u4.topbarEnabled = p12;
    end;

    for _, v in pairs(u4.container) do
        v.Enabled = p12;
    end;
end;

function u4.modifyBaseTheme(p14) -- Line: 147
    -- upvalues: Themes (copy), u4 (copy), u5 (copy)
    local v15 = Themes.getModifications(p14);

    for _, v in pairs(v15) do
        for _, v4 in pairs(u4.baseTheme) do
            Themes.merge(v4, v);
        end;
    end;

    for _, v in pairs(u5) do
        v:setTheme(u4.baseTheme);
    end;
end;

function u4.setDisplayOrder(p16) -- Line: 159
    -- upvalues: u4 (copy)
    u4.baseDisplayOrder = p16;
    u4.baseDisplayOrderChanged:Fire(p16);
end;

task.defer(Gamepad.start, u4);
task.defer(Overflow.start, u4);

for _, v in pairs(u4.container) do
    v.Parent = PlayerGui;
end;

if u4.isOldTopbar then
    u4.modifyBaseTheme(require(Themes2.Classic));
end;

function u4.new() -- Line: 179
    -- upvalues: u4 (copy), Janitor (copy), Utility (copy), u5 (copy), GoodSignal (copy), u1 (copy), Elements (copy), u7 (ref), UserInputService (copy), u6 (copy), StarterGui (copy)
    local u17 = {};
    setmetatable(u17, u4);
    local v18 = Janitor.new();
    u17.janitor = v18;
    u17.themesJanitor = v18:add(Janitor.new());
    u17.singleClickJanitor = v18:add(Janitor.new());
    u17.captionJanitor = v18:add(Janitor.new());
    u17.joinJanitor = v18:add(Janitor.new());
    u17.menuJanitor = v18:add(Janitor.new());
    u17.dropdownJanitor = v18:add(Janitor.new());
    local u19 = Utility.generateUID();
    u5[u19] = u17;
    v18:add(function() -- Line: 196
        -- upvalues: u5 (ref), u19 (copy)
        u5[u19] = nil;
    end);
    u17.selected = v18:add(GoodSignal.new());
    u17.deselected = v18:add(GoodSignal.new());
    u17.toggled = v18:add(GoodSignal.new());
    u17.viewingStarted = v18:add(GoodSignal.new());
    u17.viewingEnded = v18:add(GoodSignal.new());
    u17.stateChanged = v18:add(GoodSignal.new());
    u17.notified = v18:add(GoodSignal.new());
    u17.noticeStarted = v18:add(GoodSignal.new());
    u17.noticeChanged = v18:add(GoodSignal.new());
    u17.endNotices = v18:add(GoodSignal.new());
    u17.toggleKeyAdded = v18:add(GoodSignal.new());
    u17.fakeToggleKeyChanged = v18:add(GoodSignal.new());
    u17.alignmentChanged = v18:add(GoodSignal.new());
    u17.updateSize = v18:add(GoodSignal.new());
    u17.resizingComplete = v18:add(GoodSignal.new());
    u17.joinedParent = v18:add(GoodSignal.new());
    u17.menuSet = v18:add(GoodSignal.new());
    u17.dropdownSet = v18:add(GoodSignal.new());
    u17.updateMenu = v18:add(GoodSignal.new());
    u17.startMenuUpdate = v18:add(GoodSignal.new());
    u17.childThemeModified = v18:add(GoodSignal.new());
    u17.indicatorSet = v18:add(GoodSignal.new());
    u17.dropdownChildAdded = v18:add(GoodSignal.new());
    u17.menuChildAdded = v18:add(GoodSignal.new());
    u17.iconModule = u1;
    u17.UID = u19;
    u17.isEnabled = true;
    u17.isSelected = false;
    u17.isViewing = false;
    u17.joinedFrame = false;
    u17.parentIconUID = false;
    u17.deselectWhenOtherIconSelected = true;
    u17.totalNotices = 0;
    u17.activeState = "Deselected";
    u17.alignment = "";
    u17.originalAlignment = "";
    u17.appliedTheme = {};
    u17.appearance = {};
    u17.cachedInstances = {};
    u17.cachedNamesToInstances = {};
    u17.cachedCollectives = {};
    u17.bindedToggleKeys = {};
    u17.customBehaviours = {};
    u17.toggleItems = {};
    u17.bindedEvents = {};
    u17.notices = {};
    u17.menuIcons = {};
    u17.dropdownIcons = {};
    u17.childIconsDict = {};
    u17.isOldTopbar = u4.isOldTopbar;
    u17.creationTime = os.clock();
    u17.widget = v18:add(require(Elements.Widget)(u17, u4));
    u17:setAlignment();
    u7 = u7 + 1;
    u17:setOrder(u7);
    u17:setTheme(u4.baseTheme);
    local v20 = u17:getInstance("ClickRegion");

    local function handleToggle() -- Line: 271
        -- upvalues: u17 (copy)
        if u17.locked then
            return;
        end;

        if u17.isSelected then
            u17:deselect("User", u17);

            return;
        end;

        u17:select("User", u17);
    end;

    local u21 = false;
    local u22 = false;
    v20.MouseButton1Click:Connect(function() -- Line: 283
        -- upvalues: u21 (ref), u22 (ref), u17 (copy)
        if u21 then
            return;
        end;

        u22 = true;
        task.delay(0.01, function() -- Line: 288
            -- upvalues: u22 (ref)
            u22 = false;
        end);

        if u17.locked then
            return;
        end;

        if u17.isSelected then
            u17:deselect("User", u17);

            return;
        end;

        u17:select("User", u17);
    end);
    v20.TouchTap:Connect(function() -- Line: 293
        -- upvalues: u22 (ref), u21 (ref), u17 (copy)
        if u22 then
            return;
        end;

        u21 = true;
        task.delay(0.01, function() -- Line: 300
            -- upvalues: u21 (ref)
            u21 = false;
        end);

        if u17.locked then
            return;
        end;

        if u17.isSelected then
            u17:deselect("User", u17);

            return;
        end;

        u17:select("User", u17);
    end);
    v18:add(UserInputService.InputBegan:Connect(function(p23, p24) -- Line: 307
        -- upvalues: u17 (copy)
        if u17.locked then
            return;
        end;

        if u17.bindedToggleKeys[p23.KeyCode] and not p24 then
            if u17.locked then
                return;
            end;

            if u17.isSelected then
                u17:deselect("User", u17);

                return;
            end;

            u17:select("User", u17);
        end;
    end));

    local function viewingEnded() -- Line: 329
        -- upvalues: u17 (copy)
        if u17.locked then
            return;
        end;

        u17.isViewing = false;
        u17.viewingEnded:Fire(true);
        u17:setState(nil, "User", u17);
    end;

    u17.joinedParent:Connect(function() -- Line: 337
        -- upvalues: u17 (copy)
        if u17.isViewing then
            if u17.locked then
                return;
            end;

            u17.isViewing = false;
            u17.viewingEnded:Fire(true);
            u17:setState(nil, "User", u17);
        end;
    end);
    v20.MouseEnter:Connect(function() -- Line: 342
        -- upvalues: UserInputService (ref), u17 (copy)
        local v25 = not UserInputService.KeyboardEnabled;

        if u17.locked then
            return;
        end;

        u17.isViewing = true;
        u17.viewingStarted:Fire(true);

        if not v25 then
            u17:setState("Viewing", "User", u17);
        end;
    end);
    local u26 = 0;
    v18:add(UserInputService.TouchEnded:Connect(viewingEnded));
    v20.MouseLeave:Connect(viewingEnded);
    v20.SelectionGained:Connect(function(p27) -- Line: 319, Name: viewingStarted
        -- upvalues: u17 (copy)
        if u17.locked then
            return;
        end;

        u17.isViewing = true;
        u17.viewingStarted:Fire(true);

        if not p27 then
            u17:setState("Viewing", "User", u17);
        end;
    end);
    v20.SelectionLost:Connect(viewingEnded);
    v20.MouseButton1Down:Connect(function() -- Line: 351
        -- upvalues: u17 (copy), UserInputService (ref), u26 (ref)
        if not u17.locked and UserInputService.TouchEnabled then
            u26 = u26 + 1;
            local u28 = u26;
            task.delay(0.2, function() -- Line: 355
                -- upvalues: u28 (copy), u26 (ref), u17 (ref)
                if u28 == u26 then
                    if u17.locked then
                        return;
                    end;

                    u17.isViewing = true;
                    u17.viewingStarted:Fire(true);
                    u17:setState("Viewing", "User", u17);
                end;
            end);
        end;
    end);
    v20.MouseButton1Up:Connect(function() -- Line: 362
        -- upvalues: u26 (ref)
        u26 = u26 + 1;
    end);
    local u29 = u17:getInstance("IconOverlay");
    u17.viewingStarted:Connect(function() -- Line: 368
        -- upvalues: u29 (copy), u17 (copy)
        u29.Visible = not u17.overlayDisabled;
    end);
    u17.viewingEnded:Connect(function() -- Line: 371
        -- upvalues: u29 (copy)
        u29.Visible = false;
    end);
    v18:add(u6:Connect(function(p30) -- Line: 376
        -- upvalues: u17 (copy)
        if p30 ~= u17 and (u17.deselectWhenOtherIconSelected and p30.deselectWhenOtherIconSelected) then
            u17:deselect("AutoDeselect", p30);
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
        Utility.localPlayerRespawned(function() -- Line: 401
            -- upvalues: u17 (copy)
            u17:destroy();
        end);
    end;

    u17:getInstance("NoticeLabel");
    u17.toggled:Connect(function(p35) -- Line: 408
        -- upvalues: u17 (copy), u4 (ref)
        u17.noticeChanged:Fire(u17.totalNotices);

        for i, _ in pairs(u17.childIconsDict) do
            local v36 = u4.getIconByUID(i);
            v36.noticeChanged:Fire(v36.totalNotices);

            if not p35 and v36.isSelected then
                for _, _ in pairs(v36.childIconsDict) do
                    v36:deselect("HideParentFeature", u17);
                end;
            end;
        end;
    end);
    u17.selected:Connect(function() -- Line: 431
        -- upvalues: u17 (copy), StarterGui (ref)
        if #u17.dropdownIcons > 0 then
            if StarterGui:GetCore("ChatActive") and u17.alignment ~= "Right" then
                u17.chatWasPreviouslyActive = true;
                StarterGui:SetCore("ChatActive", false);
            end;

            if StarterGui:GetCoreGuiEnabled("PlayerList") and u17.alignment ~= "Left" then
                u17.playerlistWasPreviouslyActive = true;
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
            end;
        end;
    end);
    u17.deselected:Connect(function() -- Line: 444
        -- upvalues: u17 (copy), StarterGui (ref)
        if u17.chatWasPreviouslyActive then
            u17.chatWasPreviouslyActive = nil;
            StarterGui:SetCore("ChatActive", true);
        end;

        if u17.playerlistWasPreviouslyActive then
            u17.playerlistWasPreviouslyActive = nil;
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true);
        end;
    end);
    task.delay(0.1, function() -- Line: 459
        -- upvalues: u17 (copy)
        if u17.activeState == "Deselected" then
            u17.stateChanged:Fire("Deselected");
            u17:refresh();
        end;
    end);
    u4.iconAdded:Fire(u17);

    return u17;
end;

function u4.setName(p37, p38) -- Line: 475
    p37.widget.Name = p38;
    p37.name = p38;

    return p37;
end;

function u4.setState(p39, p40, p41, p42) -- Line: 481
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

function u4.getInstance(u44, u45) -- Line: 514
    -- upvalues: Themes (copy)
    local v46 = u44.cachedNamesToInstances[u45];

    if v46 then
        return v46;
    end;

    local function cacheInstance(u47, u48) -- Line: 522
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
            u48.Destroying:Once(function() -- Line: 532
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

    local function scanChildren(p51) -- Line: 545
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

function u4.getCollective(p54, p55) -- Line: 575
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

function u4.getInstanceOrCollective(p58, p59) -- Line: 596
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

function u4.getStateGroup(p62, p63) -- Line: 610
    local v64 = p63 or p62.activeState;
    local v65 = p62.appearance[v64];

    if not v65 then
        v65 = {};
        p62.appearance[v64] = v65;
    end;

    return v65;
end;

function u4.refreshAppearance(p66, p67, p68) -- Line: 620
    -- upvalues: Themes (copy)
    Themes.refresh(p66, p67, p68);

    return p66;
end;

function u4.refresh(p69) -- Line: 625
    p69:refreshAppearance(p69.widget);
    p69.updateSize:Fire();

    return p69;
end;

function u4.updateParent(p70) -- Line: 631
    -- upvalues: u4 (copy)
    local v71 = u4.getIconByUID(p70.parentIconUID);

    if v71 then
        v71.updateSize:Fire();
    end;
end;

function u4.setBehaviour(p72, p73, p74, p75, p76) -- Line: 638
    p72.customBehaviours[p73 .. "-" .. p74] = p75;

    if p76 then
        local v77 = p72:getInstanceOrCollective(p73);

        for _, v in pairs(v77) do
            p72:refreshAppearance(v, p74);
        end;
    end;
end;

function u4.modifyTheme(p78, p79, p80) -- Line: 651
    -- upvalues: Themes (copy)
    return p78, Themes.modify(p78, p79, p80);
end;

function u4.modifyChildTheme(p81, p82, p83) -- Line: 656
    -- upvalues: u4 (copy)
    p81.childModifications = p82;
    p81.childModificationsUID = p83;

    for i, _ in pairs(p81.childIconsDict) do
        u4.getIconByUID(i):modifyTheme(p82, p83);
    end;

    p81.childThemeModified:Fire();

    return p81;
end;

function u4.removeModification(p84, p85) -- Line: 669
    -- upvalues: Themes (copy)
    Themes.remove(p84, p85);

    return p84;
end;

function u4.removeModificationWith(p86, p87, p88, p89) -- Line: 674
    -- upvalues: Themes (copy)
    Themes.removeWith(p86, p87, p88, p89);

    return p86;
end;

function u4.setTheme(p90, p91) -- Line: 679
    -- upvalues: Themes (copy)
    Themes.set(p90, p91);

    return p90;
end;

function u4.setEnabled(p92, p93) -- Line: 684
    p92.isEnabled = p93;
    p92.widget.Visible = p93;
    p92:updateParent();

    return p92;
end;

function u4.select(p94, p95, p96) -- Line: 691
    p94:setState("Selected", p95, p96);

    return p94;
end;

function u4.deselect(p97, p98, p99) -- Line: 696
    p97:setState("Deselected", p98, p99);

    return p97;
end;

function u4.notify(p100, p101, p102) -- Line: 701
    -- upvalues: Elements (copy), u4 (copy)
    if not p100.notice then
        p100.notice = require(Elements.Notice)(p100, u4);
    end;

    p100.noticeStarted:Fire(p101, p102);

    return p100;
end;

function u4.clearNotices(p103) -- Line: 715
    p103.endNotices:Fire();

    return p103;
end;

function u4.disableOverlay(p104, p105) -- Line: 720
    p104.overlayDisabled = p105;

    return p104;
end;

u4.disableStateOverlay = u4.disableOverlay;

function u4.setImage(p106, p107, p108) -- Line: 726
    p106:modifyTheme({
        "IconImage",
        "Image",
        p107,
        p108
    });

    return p106;
end;

function u4.setLabel(p109, p110, p111) -- Line: 731
    p109:modifyTheme({
        "IconLabel",
        "Text",
        p110,
        p111
    });

    return p109;
end;

function u4.setOrder(p112, p113, p114) -- Line: 736
    p112:modifyTheme({
        "Widget",
        "LayoutOrder",
        p113,
        p114
    });

    return p112;
end;

function u4.setCornerRadius(p115, p116, p117) -- Line: 741
    p115:modifyTheme({
        "IconCorners",
        "CornerRadius",
        p116,
        p117
    });

    return p115;
end;

function u4.align(p118, p119, p120) -- Line: 746
    -- upvalues: u4 (copy)
    local v121 = tostring(p119):lower();
    local v122 = (v121 == "mid" or v121 == "centre") and "center" or v121;
    local v123 = v122 ~= "left" and (v122 ~= "center" and v122 ~= "right") and "left" or v122;
    local v124 = v123 == "center" and u4.container.TopbarCentered or u4.container.TopbarStandard;
    local Holders = v124.Holders;
    local v125 = string.upper((string.sub(v123, 1, 1))) .. string.sub(v123, 2);

    if not p120 then
        p118.originalAlignment = v125;
    end;

    local joinedFrame = p118.joinedFrame;
    local v126 = Holders[v125];
    p118.screenGui = v124;
    p118.alignmentHolder = v126;

    if not p118.isDestroyed then
        p118.widget.Parent = joinedFrame or v126;
    end;

    p118.alignment = v125;
    p118.alignmentChanged:Fire(v125);
    u4.iconChanged:Fire(p118);

    return p118;
end;

u4.setAlignment = u4.align;

function u4.setLeft(p127) -- Line: 775
    p127:setAlignment("Left");

    return p127;
end;

function u4.setMid(p128) -- Line: 780
    p128:setAlignment("Center");

    return p128;
end;

function u4.setRight(p129) -- Line: 785
    p129:setAlignment("Right");

    return p129;
end;

function u4.setWidth(p130, p131, p132) -- Line: 790
    p130:modifyTheme({
        "Widget",
        "Size",
        UDim2.fromOffset(p131, p130.widget.Size.Y.Offset),
        p132
    });
    p130:modifyTheme({
        "Widget",
        "DesiredWidth",
        p131,
        p132
    });

    return p130;
end;

function u4.setImageScale(p133, p134, p135) -- Line: 800
    p133:modifyTheme({
        "IconImageScale",
        "Value",
        p134,
        p135
    });

    return p133;
end;

function u4.setImageRatio(p136, p137, p138) -- Line: 805
    p136:modifyTheme({
        "IconImageRatio",
        "AspectRatio",
        p137,
        p138
    });

    return p136;
end;

function u4.setTextSize(p139, p140, p141) -- Line: 810
    p139:modifyTheme({
        "IconLabel",
        "TextSize",
        p140,
        p141
    });

    return p139;
end;

function u4.setTextFont(p142, p143, p144, p145, p146) -- Line: 815
    local v147 = p144 or Enum.FontWeight.Regular;
    local v148 = p145 or Enum.FontStyle.Normal;
    local v149 = nil;
    local v150 = typeof(p143);

    if v150 == "number" then
        v149 = Font.fromId(p143, v147, v148);
    elseif v150 == "EnumItem" then
        v149 = Font.fromEnum(p143);
    elseif v150 == "string" and not p143:match("rbxasset") then
        v149 = Font.fromName(p143, v147, v148);
    end;

    p142:modifyTheme({
        "IconLabel",
        "FontFace",
        v149 or Font.new(p143, v147, v148),
        p146
    });

    return p142;
end;

function u4.bindToggleItem(p151, p152) -- Line: 836
    if not (p152:IsA("GuiObject") or p152:IsA("LayerCollector")) then
        error("Toggle item must be a GuiObject or LayerCollector!");
    end;

    p151.toggleItems[p152] = true;
    p151:_updateSelectionInstances();

    return p151;
end;

function u4.unbindToggleItem(p153, p154) -- Line: 845
    p153.toggleItems[p154] = nil;
    p153:_updateSelectionInstances();

    return p153;
end;

function u4._updateSelectionInstances(p155) -- Line: 851
    for i, _ in pairs(p155.toggleItems) do
        local v156 = {};

        for _, descendant in pairs(i:GetDescendants()) do
            if (descendant:IsA("TextButton") or descendant:IsA("ImageButton")) and descendant.Active then
                table.insert(v156, descendant);
            end;
        end;

        p155.toggleItems[i] = v156;
    end;
end;

function u4._setToggleItemsVisible(p157, p158, p159, p160) -- Line: 865
    for i, _ in pairs(p157.toggleItems) do
        if not p160 or (p160 == p157 or p160.toggleItems[i] == nil) then
            i[i:IsA("LayerCollector") and "Enabled" or "Visible"] = p158;
        end;
    end;
end;

function u4.bindEvent(u161, p162, u163) -- Line: 877
    local v164 = u161[p162];
    local v165;

    if v164 then
        if typeof(v164) == "table" then
            v165 = v164.Connect;
        else
            v165 = false;
        end;
    else
        v165 = v164;
    end;

    assert(v165, "argument[1] must be a valid topbarplus icon event name!");
    local v166 = typeof(u163) == "function";
    assert(v166, "argument[2] must be a function!");
    u161.bindedEvents[p162] = v164:Connect(function(...) -- Line: 881
        -- upvalues: u163 (copy), u161 (copy)
        u163(u161, ...);
    end);

    return u161;
end;

function u4.unbindEvent(p167, p168) -- Line: 887
    local v169 = p167.bindedEvents[p168];

    if v169 then
        v169:Disconnect();
        p167.bindedEvents[p168] = nil;
    end;

    return p167;
end;

function u4.bindToggleKey(p170, p171) -- Line: 896
    local v172 = typeof(p171) == "EnumItem";
    assert(v172, "argument[1] must be a KeyCode EnumItem!");
    p170.bindedToggleKeys[p171] = true;
    p170.toggleKeyAdded:Fire(p171);
    p170:setCaption("_hotkey_");

    return p170;
end;

function u4.unbindToggleKey(p173, p174) -- Line: 904
    local v175 = typeof(p174) == "EnumItem";
    assert(v175, "argument[1] must be a KeyCode EnumItem!");
    p173.bindedToggleKeys[p174] = nil;

    return p173;
end;

function u4.call(u176, u177, ...) -- Line: 910
    local u178 = table.pack(...);
    task.spawn(function() -- Line: 912
        -- upvalues: u177 (copy), u176 (copy), u178 (copy)
        u177(u176, table.unpack(u178));
    end);

    return u176;
end;

function u4.addToJanitor(p179, p180) -- Line: 918
    p179.janitor:add(p180);

    return p179;
end;

function u4.lock(p181) -- Line: 923
    p181:getInstance("ClickRegion").Visible = false;
    p181.locked = true;

    return p181;
end;

function u4.unlock(p182) -- Line: 931
    p182:getInstance("ClickRegion").Visible = true;
    p182.locked = false;

    return p182;
end;

function u4.debounce(p183, p184) -- Line: 938
    p183:lock();
    task.wait(p184);
    p183:unlock();

    return p183;
end;

function u4.autoDeselect(p185, p186) -- Line: 945
    p185.deselectWhenOtherIconSelected = p186 == nil and true or p186;

    return p185;
end;

function u4.oneClick(u187, p188) -- Line: 955
    local singleClickJanitor = u187.singleClickJanitor;
    singleClickJanitor:clean();

    if p188 or p188 == nil then
        singleClickJanitor:add(u187.selected:Connect(function() -- Line: 961
            -- upvalues: u187 (copy)
            u187:deselect("OneClick", u187);
        end));
    end;

    u187.oneClickEnabled = true;

    return u187;
end;

function u4.setCaption(p189, p190) -- Line: 969
    -- upvalues: Elements (copy)
    if p190 == "_hotkey_" and p189.captionText then
        return p189;
    end;

    local captionJanitor = p189.captionJanitor;
    p189.captionJanitor:clean();

    if not p190 or p190 == "" then
        p189.caption = nil;
        p189.captionText = nil;

        return p189;
    end;

    local v191 = captionJanitor:add(require(Elements.Caption)(p189));
    v191:SetAttribute("CaptionText", p190);
    p189.caption = v191;
    p189.captionText = p190;

    return p189;
end;

function u4.setCaptionHint(p192, p193) -- Line: 987
    local v194 = typeof(p193) == "EnumItem";
    assert(v194, "argument[1] must be a KeyCode EnumItem!");
    p192.fakeToggleKey = p193;
    p192.fakeToggleKeyChanged:Fire(p193);
    p192:setCaption("_hotkey_");

    return p192;
end;

function u4.leave(p195) -- Line: 995
    p195.joinJanitor:clean();

    return p195;
end;

function u4.joinMenu(p196, p197) -- Line: 1001
    -- upvalues: Utility (copy)
    Utility.joinFeature(p196, p197, p197.menuIcons, p197:getInstance("Menu"));
    p197.menuChildAdded:Fire(p196);

    return p196;
end;

function u4.setMenu(p198, p199) -- Line: 1007
    p198.menuSet:Fire(p199);

    return p198;
end;

function u4.setFrozenMenu(p200, p201) -- Line: 1012
    p200:freezeMenu(p201);
    p200:setMenu(p201);
end;

function u4.freezeMenu(u202) -- Line: 1017
    u202:select("FrozenMenu", u202);
    u202:bindEvent("deselected", function(p203) -- Line: 1021
        -- upvalues: u202 (copy)
        p203:select("FrozenMenu", u202);
    end);
    u202:modifyTheme({ "IconSpot", "Visible", false });
end;

function u4.joinDropdown(p204, p205) -- Line: 1027
    -- upvalues: Utility (copy)
    p205:getDropdown();
    Utility.joinFeature(p204, p205, p205.dropdownIcons, p205:getInstance("DropdownScroller"));
    p205.dropdownChildAdded:Fire(p204);

    return p204;
end;

function u4.getDropdown(p206) -- Line: 1034
    -- upvalues: Elements (copy)
    local dropdown = p206.dropdown;

    if not dropdown then
        dropdown = require(Elements.Dropdown)(p206);
        p206.dropdown = dropdown;
        p206:clipOutside(dropdown);
    end;

    return dropdown;
end;

function u4.setDropdown(p207, p208) -- Line: 1044
    p207:getDropdown();
    p207.dropdownSet:Fire(p208);

    return p207;
end;

function u4.clipOutside(p209, p210) -- Line: 1050
    -- upvalues: Utility (copy)
    local v211 = Utility.clipOutside(p209, p210);
    p209:refreshAppearance(p210);

    return p209, v211;
end;

function u4.setIndicator(p212, p213) -- Line: 1061
    -- upvalues: Elements (copy), u4 (copy)
    if not p212.indicator then
        p212.indicator = p212.janitor:add(require(Elements.Indicator)(p212, u4));
    end;

    p212.indicatorSet:Fire(p213);
end;

function u4.destroy(p214) -- Line: 1076
    -- upvalues: u4 (copy)
    if p214.isDestroyed then
        return;
    end;

    p214:clearNotices();

    if p214.parentIconUID then
        p214:leave();
    end;

    p214.isDestroyed = true;
    p214.janitor:clean();
    u4.iconRemoved:Fire(p214);
end;

u4.Destroy = u4.destroy;

return u4;