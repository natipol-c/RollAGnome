--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Gamepad
  Path:     game.ReplicatedStorage.SatchelLoader.Satchel.Packages._Index.1foreverhd_topbarplus@3.3.1.topbarplus.Features.Gamepad
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:06 2026
]]

-- Decompiled with Potassium's decompiler.

local GamepadService = game:GetService("GamepadService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local DPadUp = Enum.KeyCode.DPadUp;
local Gamepad = Enum.PreferredInput.Gamepad;
local u1 = {};
local u2 = nil;

function u1.start(p3) -- Line: 26
    -- upvalues: u2 (ref), DPadUp (copy), GuiService (copy), UserInputService (copy), Gamepad (copy), u1 (copy), GamepadService (copy)
    u2 = p3;
    local v4;

    if u2.highlightKey == nil then
        v4 = DPadUp;
    else
        v4 = u2.highlightKey;
    end;

    u2.highlightKey = v4;
    u2.highlightIcon = false;
    task.delay(1, function() -- Line: 35
        -- upvalues: u2 (ref), GuiService (ref), DPadUp (ref), UserInputService (ref), Gamepad (ref), u1 (ref), GamepadService (ref)
        local iconsDictionary = u2.iconsDictionary;

        local function getIconFromSelectedObject() -- Line: 38
            -- upvalues: GuiService (ref), iconsDictionary (copy)
            local SelectedObject = GuiService.SelectedObject;

            if SelectedObject then
                SelectedObject = SelectedObject:GetAttribute("CorrespondingIconUID");
            end;

            if SelectedObject then
                SelectedObject = iconsDictionary[SelectedObject];
            end;

            return SelectedObject;
        end;

        local u5 = nil;
        local u6 = DPadUp ~= u2.highlightKey;
        local u7 = DPadUp ~= u2.highlightKey;
        local Selection = require(script.Parent.Parent.Elements.Selection);

        local function updateSelectedObject() -- Line: 50
            -- upvalues: GuiService (ref), iconsDictionary (copy), UserInputService (ref), Gamepad (ref), Selection (copy), u2 (ref), u5 (ref), u7 (ref), u6 (ref), u1 (ref)
            local SelectedObject = GuiService.SelectedObject;

            if SelectedObject then
                SelectedObject = SelectedObject:GetAttribute("CorrespondingIconUID");
            end;

            if SelectedObject then
                SelectedObject = iconsDictionary[SelectedObject];
            end;

            local v8 = UserInputService.PreferredInput == Gamepad;

            if not SelectedObject then
                local v9;

                if v8 and not u6 then
                    v9 = u2.highlightKey;
                else
                    v9 = nil;
                end;

                if not u5 then
                    u5 = u1.getIconToHighlight();
                end;

                if v9 == u2.highlightKey then
                    u6 = true;
                end;

                if u5 then
                    u5:setIndicator(v9);
                end;

                return;
            end;

            if v8 then
                local v10 = SelectedObject:getInstance("ClickRegion");
                local selection = SelectedObject.selection;

                if not selection then
                    selection = SelectedObject.janitor:add(Selection(u2));
                    selection:SetAttribute("IgnoreVisibilityUpdater", true);
                    selection.Parent = SelectedObject.widget;
                    SelectedObject.selection = selection;
                    SelectedObject:refreshAppearance(selection);
                end;

                v10.SelectionImageObject = selection.Selection;
            end;

            if u5 and u5 ~= SelectedObject then
                u5:setIndicator();
            end;

            local v11;

            if v8 and not (u7 or SelectedObject.parentIconUID) then
                v11 = Enum.KeyCode.ButtonB;
            else
                v11 = nil;
            end;

            u5 = SelectedObject;
            u2.lastHighlightedIcon = SelectedObject;
            SelectedObject:setIndicator(v11);
        end;

        GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(updateSelectedObject);

        local function preferredInputChanged() -- Line: 93
            -- upvalues: UserInputService (ref), Gamepad (ref), u6 (ref), u7 (ref), updateSelectedObject (copy)
            if UserInputService.PreferredInput ~= Gamepad then
                u6 = false;
                u7 = false;
            end;

            updateSelectedObject();
        end;

        UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(preferredInputChanged);

        if UserInputService.PreferredInput ~= Gamepad then
            u6 = false;
            u7 = false;
        end;

        updateSelectedObject();
        UserInputService.InputBegan:Connect(function(p12, p13) -- Line: 109
            -- upvalues: GuiService (ref), iconsDictionary (copy), u2 (ref), u1 (ref), GamepadService (ref)
            if p12.UserInputType ~= Enum.UserInputType.MouseButton1 then
                if p12.KeyCode ~= u2.highlightKey then
                    return;
                end;

                local v14 = u1.getIconToHighlight();

                if v14 then
                    if GamepadService.GamepadCursorEnabled then
                        task.wait(0.2);
                        GamepadService:DisableGamepadCursor();
                    end;

                    GuiService.SelectedObject = v14:getInstance("ClickRegion");
                end;

                return;
            end;

            local SelectedObject = GuiService.SelectedObject;

            if SelectedObject then
                SelectedObject = SelectedObject:GetAttribute("CorrespondingIconUID");
            end;

            if SelectedObject then
                SelectedObject = iconsDictionary[SelectedObject];
            end;

            if SelectedObject then
                GuiService.SelectedObject = nil;
            end;
        end);
    end);
end;

function u1.getIconToHighlight() -- Line: 136
    -- upvalues: u2 (ref)
    local iconsDictionary = u2.iconsDictionary;
    local v15 = u2.highlightIcon or u2.lastHighlightedIcon;

    if not v15 then
        local v16 = nil;

        for _, v in pairs(iconsDictionary) do
            if not v.parentIconUID and (not v16 or v.widget.AbsolutePosition.X < v16) then
                v16 = v.widget.AbsolutePosition.X;
                v15 = v;
            end;
        end;
    end;

    return v15;
end;

function u1.registerButton(u17) -- Line: 158
    -- upvalues: UserInputService (copy), GamepadService (copy), GuiService (copy)
    local u18 = false;
    u17.InputBegan:Connect(function(p19) -- Line: 164
        -- upvalues: u18 (ref)
        u18 = true;
        task.wait();
        task.wait();
        u18 = false;
    end);
    local u22 = UserInputService.InputBegan:Connect(function(p20) -- Line: 173
        -- upvalues: u18 (ref), GamepadService (ref), GuiService (ref), u17 (copy)
        task.wait();

        if p20.KeyCode == Enum.KeyCode.ButtonA and u18 then
            task.wait(0.2);
            GamepadService:DisableGamepadCursor();
            GuiService.SelectedObject = u17;

            return;
        end;

        local v21 = GuiService.SelectedObject == u17;
        local Name = p20.KeyCode.Name;

        if table.find({ "ButtonB", "ButtonSelect" }, Name) and (v21 and (Name ~= "ButtonSelect" or GamepadService.GamepadCursorEnabled)) then
            GuiService.SelectedObject = nil;
        end;
    end);
    u17.Destroying:Once(function() -- Line: 194
        -- upvalues: u22 (copy)
        u22:Disconnect();
    end);
end;

return u1;