--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Sell
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Sell
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.2
  Game:     Roll_A_Gnome (117539213094671)
  Time:     Mon Aug 17 02:37:08 2026
]]

-- Decompiled with Potassium's decompiler.

local GamepadService = game:GetService("GamepadService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Library = require(ReplicatedStorage.Library);
local u1 = Library.get("Find");
local u2 = Library.get("Network");
local u3 = Library.get("Numbers");
Library.get("Signal");
local u4 = Library.get("SimpleTween");
Library.get("Plants");
local SellBillboard = ReplicatedStorage.Assets.Billboards.SellBillboard;
local u5 = SellBillboard:WaitForChild("Frame"):WaitForChild("Template"):Clone();
SellBillboard.Frame.Template:Destroy();
local LocalPlayer = Players.LocalPlayer;
local u6 = u1(u1(LocalPlayer, "PlayerGui"), "BillboardGuis");
local u7 = u1(LocalPlayer, "Plot");
local ClosePointer = script.ClosePointer;
local v8 = {};
local u9 = {};
local u10 = false;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = 0;
local u16 = {};

local function getSellPart(p17) -- Line: 56
    if p17:IsA("BasePart") then
        return p17;
    end;

    if p17:IsA("Model") then
        local Part = p17:FindFirstChild("Part");
        local PrimaryPart = p17.PrimaryPart;

        if PrimaryPart then
            Part = PrimaryPart;
        elseif not (Part and (Part:IsA("BasePart") and Part)) then
            Part = p17:FindFirstChildWhichIsA("BasePart", true);
        end;

        return Part;
    end;
end;

local function close() -- Line: 69
    -- upvalues: GamepadService (copy), u13 (ref), u9 (copy), u11 (ref), u12 (ref)
    if GamepadService.GamepadCursorEnabled then
        GamepadService:DisableGamepadCursor();
    end;

    if u13 then
        u13:Disconnect();
        u13 = nil;
    end;

    for _, v in u9 do
        v:Disconnect();
    end;

    table.clear(u9);

    if u11 then
        u11:Destroy();
        u11 = nil;
    end;

    if u12 then
        u12.Enabled = true;
        u12 = nil;
    end;
end;

local function cancelTextMessageTweens() -- Line: 95
    -- upvalues: u16 (copy)
    for _, v in u16 do
        pcall(function() -- Line: 97
            -- upvalues: v (copy)
            v:Cancel();
            v:Destroy();
        end);
    end;

    table.clear(u16);
end;

local function getGraphemeCount(p18) -- Line: 105
    local u19 = string.gsub(p18, "<[^<>]->", "");
    local u20 = 0;

    return pcall(function() -- Line: 109
        -- upvalues: u19 (copy), u20 (ref)
        for _ in utf8.graphemes(u19) do
            u20 = u20 + 1;
        end;
    end) and u20 or #u19;
end;

local function typeWrite(u21, u22, u23, u24) -- Line: 118
    u21.Text = u22;
    u21.MaxVisibleGraphemes = 0;
    task.spawn(function() -- Line: 122
        -- upvalues: u22 (copy), u23 (copy), u21 (copy), u24 (copy)
        local u25 = string.gsub(u22, "<[^<>]->", "");
        local u26 = 0;

        for i = 1, pcall(function() -- Line: 109
            -- upvalues: u25 (copy), u26 (ref)
            for _ in utf8.graphemes(u25) do
                u26 = u26 + 1;
            end;
        end) and u26 or #u25 do
            if not (u23() and u21.Parent) then
                return;
            end;

            u21.MaxVisibleGraphemes = i;
            task.wait(0.025);
        end;

        if not (u23() and u24) then
            return;
        end;

        local success, result = pcall(u24);

        if not success then
            warn("Sell typewriter callback failed:", result);
        end;
    end);
end;

local function createFrame(p27, p28, u29) -- Line: 137
    -- upvalues: u1 (copy), u5 (copy), u9 (copy), u10 (ref), GamepadService (copy), u4 (copy), ClosePointer (copy)
    local v30 = u1(p27, "Frame");
    local v31 = u5:Clone();
    v31.Size = UDim2.fromScale(0, 0);
    local v32 = u1(u1(v31, "Frame"), "TextLabel");
    local MouseButton1Click = u1(v31, "Button").MouseButton1Click;
    table.insert(u9, MouseButton1Click:Connect(function() -- Line: 146
        -- upvalues: u10 (ref), GamepadService (ref), u29 (copy)
        if u10 then
            return;
        end;

        u10 = true;

        if GamepadService.GamepadCursorEnabled then
            GamepadService:DisableGamepadCursor();
        end;

        u29();
        task.wait(0.5);
        u10 = false;
    end));
    v32.Text = p28;
    v31.Parent = v30;
    u4:Tween(v31, 0.2, "Back", "Out", {
        Size = UDim2.fromScale(1, 0.11)
    });

    if p28 == "Sell Inventory!" and ClosePointer.Parent == script then
        ClosePointer.Parent = v31;
    end;

    task.wait(0.1);
end;

local function setupDailyDeal(p33) -- Line: 174
    -- upvalues: u1 (copy), u2 (copy), u3 (copy), u9 (copy), RunService (copy), u10 (ref), close (copy), u14 (ref)
    local v34 = u1(u1(p33, "Frame"), "DailyDeal");
    local v35 = u1(v34, "Frame");
    local v36 = u1(v34, "Button");
    local u37 = u1(u1(v35, "List"), "Price");
    local u38 = u2:InvokeServer("GetDailyDeal");
    local u39 = os.clock() + (type(u38) == "table" and (u38.remaining or 0) or 0);

    local function update() -- Line: 185
        -- upvalues: u39 (copy), u38 (copy), u37 (copy), u3 (ref)
        local v40 = u39 - os.clock();
        local v41 = math.max(v40, 0);

        if type(u38) == "table" and u38.ready then
            u37.Text = `{u3.Comma(u38.value or 0)}$`;

            return;
        end;

        u37.Text = u3.FormatTimeFull(v41);
    end;

    update();
    table.insert(u9, RunService.Heartbeat:Connect(update));
    table.insert(u9, v36.MouseButton1Click:Connect(function() -- Line: 198
        -- upvalues: u10 (ref), u2 (ref), close (ref), u14 (ref), u3 (ref)
        if u10 then
            return;
        end;

        u10 = true;
        local v42 = u2:InvokeServer("DailyDeal");
        task.wait();
        close();

        if v42 == "No Plants" then
            u14("You have no plants to sell.");
        elseif type(v42) == "table" and v42.sold then
            u14((`ULTRA Daily Deal! Here is <font color="#FFC800">{u3.Comma(v42.amount)}$</font>`));
        elseif type(v42) == "table" then
            u14((`Come back in <font color="#FFC800">{u3.FormatTimeFull(v42.remaining)}</font>`));
        end;

        task.wait(0.5);
        u10 = false;
    end));
end;

local function getBillboard() -- Line: 219
    -- upvalues: LocalPlayer (copy), u1 (copy), SellBillboard (copy), u6 (copy)
    local v43 = u1(LocalPlayer.Character, "HumanoidRootPart");
    local v44 = SellBillboard:Clone();
    v44.Parent = u6;
    v44.Adornee = v43;

    return v44;
end;

local function setupBillboard() -- Line: 230
    -- upvalues: LocalPlayer (copy), u1 (copy), SellBillboard (copy), u6 (copy), u11 (ref), setupDailyDeal (copy), createFrame (copy), u2 (copy), close (copy), u14 (ref), u3 (copy)
    local v45 = u1(LocalPlayer.Character, "HumanoidRootPart");
    local v46 = SellBillboard:Clone();
    v46.Parent = u6;
    v46.Adornee = v45;
    u11 = v46;
    setupDailyDeal(v46);
    createFrame(v46, "1. Sell Inventory!", function() -- Line: 235
        -- upvalues: u2 (ref), close (ref), u14 (ref), u3 (ref)
        local v47 = u2:InvokeServer("SellAll");
        task.wait();
        close();

        if v47 == "No Plants" then
            u14("You have no plants to sell.");

            return;
        end;

        if not v47 then
            return;
        end;

        u14((`Sweet! Here is <font color="#FFC800">{u3.Comma(v47)}$</font>`));
    end);
    createFrame(v46, "2. Sell Just This!", function() -- Line: 246
        -- upvalues: u2 (ref), close (ref), u14 (ref), u3 (ref)
        local v48 = u2:InvokeServer("SellThis");
        task.wait();
        close();

        if v48 == "Not Holding" then
            u14("You are not holding anything.");

            return;
        end;

        if not v48 then
            return;
        end;

        u14((`Here is <font color="#FFC800">{u3.Comma(v48)}$</font>`));
    end);
    createFrame(v46, "3. How much for this?", function() -- Line: 257
        -- upvalues: u2 (ref), close (ref), u14 (ref), u3 (ref)
        local v49 = u2:InvokeServer("HowMuch");
        task.wait();
        close();

        if v49 == "Not Holding" then
            u14("You are not holding anything.");

            return;
        end;

        if not v49 then
            return;
        end;

        u14((`I'd give you <font color="#FFC800">{u3.Comma(v49)}$</font>`));
    end);
    createFrame(v46, "4. Sell Gnome", function() -- Line: 268
        -- upvalues: u2 (ref), close (ref), u14 (ref), u3 (ref)
        local v50 = u2:InvokeServer("SellGnome");
        task.wait();
        close();

        if v50 == "Not Holding" then
            u14("You are not holding anything.");

            return;
        end;

        if not v50 then
            return;
        end;

        u14((`Here is <font color="#FFC800">{u3.Comma(v50)}$</font>`));
    end);
    createFrame(v46, "5. Sell All Gnomes", function() -- Line: 279
        -- upvalues: u2 (ref), close (ref), u14 (ref), u3 (ref)
        local v51 = u2:InvokeServer("SellAllGnomes");
        task.wait();
        close();

        if v51 == "Not Holding" then
            u14("You are not holding anything.");

            return;
        end;

        if not v51 then
            return;
        end;

        u14((`Here is <font color="#FFC800">{u3.Comma(v51)}$</font>`));
    end);
    createFrame(v46, "6. Nevermind.", function() -- Line: 290
        -- upvalues: close (ref)
        close();
    end);
end;

local function setupSell() -- Line: 295
    -- upvalues: u7 (copy), getSellPart (copy), u12 (ref), LocalPlayer (copy), GamepadService (copy), setupBillboard (copy), u13 (ref), RunService (copy), close (copy), u1 (copy), u14 (ref), u15 (ref), cancelTextMessageTweens (copy), u16 (copy), u4 (copy)
    if not u7.Value then
        u7.Changed:Wait();
    end;

    local Sell = u7.Value:WaitForChild("Points"):WaitForChild("Sell");
    local u52 = getSellPart(Sell);

    if not u52 then
        return;
    end;

    local ProximityPrompt = script.ProximityPrompt;
    ProximityPrompt.Parent = u52;
    ProximityPrompt.Triggered:Connect(function() -- Line: 308
        -- upvalues: ProximityPrompt (copy), u12 (ref), LocalPlayer (ref), GamepadService (ref), setupBillboard (ref), u13 (ref), RunService (ref), u52 (copy), close (ref)
        ProximityPrompt.Enabled = false;
        u12 = ProximityPrompt;

        if LocalPlayer:GetAttribute("Device") == "Controller" and not GamepadService.GamepadCursorEnabled then
            GamepadService:EnableGamepadCursor(nil);
        end;

        setupBillboard();
        u13 = RunService.Heartbeat:Connect(function() -- Line: 317
            -- upvalues: LocalPlayer (ref), u52 (ref), close (ref)
            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChild("HumanoidRootPart");
            end;

            if Character and (Character.Position - u52.Position).Magnitude >= 15 then
                close();
            end;
        end);
    end);
    local u53 = u1(u1(Sell, "SellCharacter"), "TextBubble");
    local u54 = u1(u53, "Frame");
    local u55 = u1(u53, "TextLabel");
    local u56 = u55:FindFirstChildWhichIsA("UIStroke");
    local BackgroundTransparency = u54.BackgroundTransparency;

    u14 = function(p57) -- Line: 333
        -- upvalues: u15 (ref), u53 (copy), u55 (copy), cancelTextMessageTweens (ref), u54 (copy), BackgroundTransparency (copy), u56 (copy), u16 (ref), u4 (ref)
        u15 = u15 + 1;
        local u58 = u15;
        local u59 = tostring(p57 or "");

        local function isCurrent() -- Line: 337
            -- upvalues: u58 (copy), u15 (ref), u53 (ref), u55 (ref)
            local v60;

            if u58 == u15 then
                v60 = u53.Parent and u55.Parent;
            else
                v60 = false;
            end;

            return v60;
        end;

        cancelTextMessageTweens();
        u53.Enabled = true;
        u54.BackgroundTransparency = BackgroundTransparency;
        u55.TextTransparency = 0;

        if u56 then
            u56.Transparency = 0;
        end;

        local u61 = u55;

        local function u64() -- Line: 349
            -- upvalues: u58 (copy), u15 (ref), u53 (ref), u55 (ref), u16 (ref), u4 (ref), u54 (ref), u56 (ref), BackgroundTransparency (ref), cancelTextMessageTweens (ref)
            task.wait(3);
            local v62;

            if u58 == u15 then
                v62 = u53.Parent and u55.Parent;
            else
                v62 = false;
            end;

            if not v62 then
                return;
            end;

            table.insert(u16, u4:Tween(u55, 0.5, "Sine", "InOut", {
                TextTransparency = 1
            }));
            table.insert(u16, u4:Tween(u54, 0.5, "Sine", "InOut", {
                BackgroundTransparency = 1
            }));

            if u56 then
                table.insert(u16, u4:Tween(u56, 0.5, "Sine", "InOut", {
                    Transparency = 1
                }));
            end;

            task.wait(0.5);
            local v63;

            if u58 == u15 then
                v63 = u53.Parent and u55.Parent;
            else
                v63 = false;
            end;

            if not v63 then
                return;
            end;

            u53.Enabled = false;
            u55.MaxVisibleGraphemes = -1;
            u54.BackgroundTransparency = BackgroundTransparency;
            u55.TextTransparency = 0;

            if u56 then
                u56.Transparency = 0;
            end;

            cancelTextMessageTweens();
        end;

        u61.Text = u59;
        u61.MaxVisibleGraphemes = 0;
        task.spawn(function() -- Line: 122
            -- upvalues: u59 (copy), isCurrent (copy), u61 (copy), u64 (copy)
            local u65 = string.gsub(u59, "<[^<>]->", "");
            local u66 = 0;

            for i = 1, pcall(function() -- Line: 109
                -- upvalues: u65 (copy), u66 (ref)
                for _ in utf8.graphemes(u65) do
                    u66 = u66 + 1;
                end;
            end) and u66 or #u65 do
                if not (isCurrent() and u61.Parent) then
                    return;
                end;

                u61.MaxVisibleGraphemes = i;
                task.wait(0.025);
            end;

            if not (isCurrent() and u64) then
                return;
            end;

            local success, result = pcall(u64);

            if not success then
                warn("Sell typewriter callback failed:", result);
            end;
        end);
    end;
end;

function v8.Initialize(p67) -- Line: 380
    -- upvalues: setupSell (copy)
    setupSell();
end;

return v8;