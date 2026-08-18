local Environment = (type(getgenv) == "function" and getgenv()) or (type(getgenv) == "table" and getgenv) or _G or {}
if type(table.clear) ~= "function" then
table.clear = function(t)
for k in pairs(t) do
t[k] = nil
end
end
end
if type(table.find) ~= "function" then
table.find = function(t, val)
for i, v in ipairs(t) do
if v == val then return i end
end
return nil
end
end
if type(table.clone) ~= "function" then
table.clone = function(t)
local c = {}
for k, v in pairs(t) do c[k] = v end
return c
end
end
if type(math.clamp) ~= "function" then
math.clamp = function(v, min, max)
if v < min then return min end
if v > max then return max end
return v
end
end
if type(math.round) ~= "function" then
math.round = function(v)
return math.floor(v + 0.5)
end
end
if type(typeof) ~= "function" then
typeof = type
end
if not game:IsLoaded() then
local start = os.clock()
repeat
task.wait(0.1)
until game:IsLoaded() or os.clock() - start > 10
end
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local GuiService = game:GetService("GuiService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
local startWait = os.clock()
while not LocalPlayer and os.clock() - startWait < 5 do
task.wait(0.1)
LocalPlayer = Players.LocalPlayer
end
end
local function getPlayerMoney()
local stats = type(Replication) == "table" and type(Replication.Data) == "table" and Replication.Data.stats or nil
local money = type(stats) == "table" and tonumber(stats.money) or nil
if money then
return money
end
local leaderstats = LocalPlayer and LocalPlayer:FindFirstChild("leaderstats")
local moneyValue = leaderstats and leaderstats:FindFirstChild("Money")
return moneyValue and tonumber(moneyValue.Value) or 0
end
if type(Environment.RollAGnomeRuntime) == "table" and type(Environment.RollAGnomeRuntime.Destroy) == "function" then
pcall(function() Environment.RollAGnomeRuntime.Destroy() end)
end
local Runtime = {
Alive = true,
Paused = false,
PauseSnapshot = {},
PendingPurchase = nil,
WaitingForMoney = false,
PendingPurchasePrice = 0,
Locks = {},
Rebirthing = false,
Connections = {},
Mobile = UserInputService.TouchEnabled,
TextBaseSizes = setmetatable({}, { __mode = "k" }),
GraphicsOriginal = setmetatable({}, { __mode = "k" }),
LastRemoteAt = {},
StartedAt = os.clock(),
Stats = {
Rolls = 0,
Bought = 0,
Placed = 0,
Expansions = 0,
Rebirths = 0,
Collected = 0,
Sold = 0,
Shop = 0,
Upgrades = 0,
},
}
Environment.RollAGnomeRuntime = Runtime
Runtime.ReserveAction = function(owner, groups, duration, priority)
local current = Runtime.PriorityAction
local now = os.clock()
priority = tonumber(priority) or 0
if current and current.Until > now and current.Owner ~= owner
and (tonumber(current.Priority) or 0) > priority
then
return false
end
local groupSet = {}
for _, group in ipairs(groups) do
groupSet[group] = true
end
Runtime.PriorityAction = {
Owner = owner,
Groups = groupSet,
Until = now + (duration or 2),
Priority = priority,
}
return true
end
Runtime.ClearActionReservation = function(owner)
if Runtime.PriorityAction and (not owner or Runtime.PriorityAction.Owner == owner) then
Runtime.PriorityAction = nil
end
end
Runtime.BeginAction = function(owner, groups)
if not Runtime.Alive or Runtime.Paused or Runtime.Rebirthing then
return nil
end
local reserved = Runtime.PriorityAction
if reserved and os.clock() >= reserved.Until then
Runtime.PriorityAction = nil
reserved = nil
end
if reserved and reserved.Owner ~= owner then
if groups[1] == "*" then
return nil
end
for _, group in ipairs(groups) do
if reserved.Groups[group] then
return nil
end
end
end
if groups[1] == "*" then
if next(Runtime.Locks) ~= nil then
return nil
end
Runtime.Rebirthing = true
else
for _, group in ipairs(groups) do
if Runtime.Locks[group] then
return nil
end
end
end
local token = { Owner = owner, Groups = groups }
for _, group in ipairs(groups) do
if group ~= "*" then
Runtime.Locks[group] = token
end
end
return token
end
Runtime.EndAction = function(token)
if not token then
return
end
for _, group in ipairs(token.Groups or {}) do
if group == "*" then
Runtime.Rebirthing = false
elseif Runtime.Locks[group] == token then
Runtime.Locks[group] = nil
end
end
end
Runtime.WithAction = function(owner, groups, callback)
local token = Runtime.BeginAction(owner, groups)
if not token then
return false, "busy"
end
local results = table.pack(pcall(callback))
Runtime.EndAction(token)
if not results[1] then
Runtime.LastActionError = tostring(results[2])
return false, "error"
end
return true, table.unpack(results, 2, results.n)
end
local function connect(signal, callback)
local ok, connection = pcall(function()
return signal:Connect(callback)
end)
if not ok or not connection then
return nil
end
table.insert(Runtime.Connections, connection)
return connection
end
local function safeCall(callback, ...)
local ok, result, extra = pcall(callback, ...)
return ok, result, extra
end
local Library
local okLib, lib = pcall(function()
return require(ReplicatedStorage:WaitForChild("Library", 10))
end)
if okLib and lib then
Library = lib
end
local Network
if Library and type(Library.get) == "function" then
pcall(function()
Network = Library.get("Network")
end)
end
local Replication
local okRep, rep = pcall(function()
return require(ReplicatedStorage:WaitForChild("Replication", 10))
end)
if okRep and rep then
Replication = rep
end
local function getConfig(name, fallback)
if not Library or type(Library.get) ~= "function" then
return fallback or {}
end
local val
local ok = pcall(function()
val = Library.get(name)
end)
if ok and type(val) == "table" then
return val
end
return fallback or {}
end
local FarmersConfig = getConfig("Farmers")
local PlantsConfig = getConfig("Plants")
local CropsUtil = getConfig("Crops")
local LevelsUtil = getConfig("Levels")
local SprinklersConfig = getConfig("Sprinklers")
Runtime.FertilizersConfig = getConfig("Fertilizer")
Runtime.WateringCansConfig = getConfig("WateringCans")
Runtime.GnomeItemsConfig = getConfig("GnomeItems")
local ItemShop = getConfig("ItemShop", { Items = {} })
local IndexConfig = getConfig("Index", { MUTATIONS = {} })
local PlotUpgrades = getConfig("Upgrades")
local UpgradeTree = getConfig("Upgrade Tree")
local ExpandPrices = getConfig("Expand")
local RebirthConfig = getConfig("Rebirths")
Runtime.ProduceNameLookup = {}
for plantName, config in pairs(PlantsConfig) do
Runtime.ProduceNameLookup[string.lower(tostring(plantName))] = true
if type(config) == "table" and type(config.fruit) == "table" and config.fruit.name then
Runtime.ProduceNameLookup[string.lower(tostring(config.fruit.name))] = true
end
end
Runtime.SelectionVersion = 0
Runtime.ProduceMutationCache = setmetatable({}, { __mode = "k" })
Runtime.ProduceToolCache = setmetatable({}, { __mode = "k" })
local Defaults = {
AutoRoll = false,
AutoBuyTarget = false,
AutoBuyRebirthGnomes = false,
PauseRollUntilAffordable = true,
RollPriority = "TargetFirst",
AutomationStrategy = "Balanced",
MovementPriority = "SmartTimeShare",
MoneyReservePercent = 0,
InventoryOverflowPolicy = "FlushAll",
AutoBest30 = false,
BestGnomeLimit = 30,
GnomeSellPolicy = "BelowBest",
AutoCollect = false,
AutoSellProduce = false,
AutoBuyShop = false,
AutoUseItems = false,
AutoGive = false,
AutoReceiveGift = false,
AutoBuyMutation = false,
AutoUpgrade = false,
AutoBuyExpansion = false,
AutoRebirth = false,
AntiAFK = true,
AutoRejoin = true,
AutoLoadConfig = false,
ConfigProfile = "default",
Language = "EN",
UIWidth = 720,
UIHeight = 500,
LowPingMode = false,
PotatoGraphics = false,
TextScale = 1,
BuyRarityTargets = {},
KeepRarityTargets = {},
SellRarityTargets = {},
MutationTargets = {},
KeepMutationTargets = {},
SellProduceMutationTargets = { Normal = true },
UseItemTargets = {},
ShopTargets = {},
GivePlayers = {},
ReceivePlayers = {},
}
local MasterAutomationKeys = {
"AutoRoll",
"AutoBuyTarget",
"AutoBuyRebirthGnomes",
"PauseRollUntilAffordable",
"AutoBest30",
"AutoCollect",
"AutoSellProduce",
"AutoBuyShop",
"AutoUseItems",
"AutoGive",
"AutoReceiveGift",
"AutoBuyMutation",
"AutoUpgrade",
"AutoBuyExpansion",
"AutoRebirth",
"AntiAFK",
"AutoRejoin",
}
local MasterAutomationKeySet = {}
for _, key in ipairs(MasterAutomationKeys) do
MasterAutomationKeySet[key] = true
end
local State = Environment.RollAGnomeSettings
if type(State) ~= "table" then
State = {}
Environment.RollAGnomeSettings = State
end
Runtime.HadAutoUseItems = State.AutoUseItems ~= nil
Runtime.LegacyAutoUseItems = State.AutoPlaceSprinklers == true or State.AutoGnomeCoffee == true
Runtime.LegacyUseItemTargets = type(State.SprinklerTargets) == "table" and State.SprinklerTargets or {}
Runtime.LegacySellProduceTargets = type(State.SellFruitMutationTargets) == "table" and State.SellFruitMutationTargets or {}
Runtime.LegacyAutoPlaceGnome = State.AutoPlaceGnome == true
Runtime.LegacyAutoSellTarget = State.AutoSellTarget == true
Runtime.HadGnomeSellPolicy = type(State.GnomeSellPolicy) == "string"
for key, value in pairs(Defaults) do
if State[key] == nil then
State[key] = type(value) == "table" and table.clone(value) or value
end
end
if not Runtime.HadAutoUseItems then
State.AutoUseItems = Runtime.LegacyAutoUseItems
for name, enabled in pairs(Runtime.LegacyUseItemTargets) do
State.UseItemTargets[name] = enabled
end
if State.AutoGnomeCoffee == true then
State.UseItemTargets["Gnome Coffee"] = true
end
end
if next(State.SellProduceMutationTargets) == nil then
for name, enabled in pairs(Runtime.LegacySellProduceTargets) do
if type(name) == "number" and type(enabled) == "string" then
State.SellProduceMutationTargets[enabled] = true
elseif enabled == true then
State.SellProduceMutationTargets[name] = true
end
end
if next(State.SellProduceMutationTargets) == nil then
State.SellProduceMutationTargets["Normal"] = true
end
end
if not Runtime.HadGnomeSellPolicy and Runtime.LegacyAutoSellTarget and State.AutoBest30 ~= true
and not Runtime.LegacyAutoPlaceGnome
then
State.GnomeSellPolicy = "SelectedRarities"
end
State.AutoBest30 = State.AutoBest30 == true or Runtime.LegacyAutoPlaceGnome or Runtime.LegacyAutoSellTarget
State.AutoPlaceSprinklers = nil
State.AutoGnomeCoffee = nil
State.SprinklerTargets = nil
State.SellFruitMutationTargets = nil
State.AutoPlaceGnome = nil
State.AutoSellTarget = nil
State.Language = string.upper(tostring(State.Language or "EN")) == "TH" and "TH" or "EN"
State.TextScale = math.clamp(tonumber(State.TextScale) or 1, 0.7, 1.6)
Runtime.MovementLease = nil
Runtime.AcquireMovementLease = function(owner, duration)
duration = math.clamp(tonumber(duration) or 2, 0.5, 4)
local now = os.clock()
local lease = Runtime.MovementLease
if lease and lease.Owner ~= owner and now < lease.Until then
return false, "LEASE ACTIVE BY " .. tostring(lease.Owner)
end
Runtime.MovementLease = {
Owner = owner,
Until = now + duration,
}
return true
end
Runtime.ReleaseMovementLease = function(owner)
if Runtime.MovementLease and (not owner or Runtime.MovementLease.Owner == owner) then
Runtime.MovementLease = nil
end
end
Runtime.GetBackpackItemCount = function()
local backpack = LocalPlayer and LocalPlayer:FindFirstChild("Backpack")
local character = LocalPlayer and LocalPlayer.Character
local count = 0
if backpack then
count = count + #backpack:GetChildren()
end
if character then
for _, child in ipairs(character:GetChildren()) do
if child:IsA("Tool") then
count = count + 1
end
end
end
return count
end
Runtime.IsBackpackNearFull = function()
local count = Runtime.GetBackpackItemCount()
return count >= 40
end
Runtime.EnsureBackpackSpace = function(minFreeSlots)
minFreeSlots = math.clamp(tonumber(minFreeSlots) or 1, 1, 5)
local count = Runtime.GetBackpackItemCount()
if count < 40 then
return true
end
return Runtime.PurgeInventoryOverflow()
end
Runtime.CanSpendDynamic = function(price, purpose)
price = math.max(0, tonumber(price) or 0)
local pending = Runtime.PendingPurchase
local strategy = (State and State.AutomationStrategy) or "Balanced"
local rollPriority = (State and State.RollPriority) or "TargetFirst"
local money = getPlayerMoney()
if (strategy == "GnomeHunter" or rollPriority == "TargetFirst") and pending and pending.Parent then
return false, "WAITING FOR TARGET GNOME"
end
if (strategy == "MaxProgression" or rollPriority == "RebirthFirst") and State and State.AutoRebirth then
local rebirthData = Runtime.GetNextRebirthData()
local requiredMoney = type(rebirthData) == "table" and type(rebirthData.requirements) == "table"
and tonumber(rebirthData.requirements.money) or 0
if purpose ~= "Rebirth" and (money - price < requiredMoney) then
return false, "RESERVED FOR REBIRTH"
end
end
if State and (tonumber(State.MoneyReservePercent) or 0) > 0 then
local reserveThreshold = money * (State.MoneyReservePercent / 100)
if money - price < reserveThreshold then
return false, "RESERVED PERCENTAGE"
end
end
return true
end
Runtime.EnsureEmptyHands = function(timeout)
timeout = timeout or 0.25
local character = LocalPlayer and LocalPlayer.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
if not character or not humanoid then
return true
end
if not character:FindFirstChildWhichIsA("Tool") then
return true
end
pcall(function()
humanoid:UnequipTools()
end)
local start = os.clock()
while os.clock() - start < timeout and Runtime.Alive do
if not character:FindFirstChildWhichIsA("Tool") then
return true
end
task.wait(0.025)
end
return not character:FindFirstChildWhichIsA("Tool")
end
Runtime.GetShopItemNames = function()
local result = {}
for name, data in pairs(ItemShop.Items or {}) do
if type(data) == "table" and not data.ignore then
table.insert(result, tostring(name))
end
end
if #result == 0 then
result = { "Basic Sprinkler", "Advanced Sprinkler", "Godly Sprinkler", "Master Sprinkler", "Basic Fertilizer", "Advanced Fertilizer", "Godly Fertilizer", "Master Fertilizer", "Watering Can", "Gnome Coffee" }
end
return result
end
local function ensurePresetTargets(preset)
if not Runtime.HasAnySelection(State.UseItemTargets) then
State.UseItemTargets["Gnome Coffee"] = true
for name, data in pairs(ItemShop.Items or {}) do
if type(data) == "table"
and (data.type == "Sprinkler" or data.type == "Fertilizer"
or data.type == "WateringCan" or data.type == "GnomeItem")
then
State.UseItemTargets[name] = true
end
end
end
if not Runtime.HasAnySelection(State.ShopTargets) then
for _, name in ipairs(Runtime.GetShopItemNames()) do
State.ShopTargets[name] = true
end
end
if not Runtime.HasAnySelection(State.SellProduceMutationTargets)
or (State.SellProduceMutationTargets["Normal"] and not next(State.SellProduceMutationTargets, "Normal"))
then
State.SellProduceMutationTargets["Normal"] = true
local allMutations = { "Normal", "Golden", "Diamond", "Shiny", "Fire", "Night", "Toxic", "Charged", "Frozen", "Cursed" }
for _, mut in ipairs(allMutations) do
State.SellProduceMutationTargets[mut] = true
end
end
if preset == "MoneyMachine" then
if not Runtime.HasAnySelection(State.BuyRarityTargets) then
State.BuyRarityTargets["IMPOSSIBLE"] = true
State.BuyRarityTargets["Godly"] = true
State.BuyRarityTargets["Mythic"] = true
end
if not Runtime.HasAnySelection(State.MutationTargets) then
State.MutationTargets["Night"] = true
State.MutationTargets["Cursed"] = true
State.MutationTargets["Shiny"] = true
end
elseif preset == "GnomeHunter" then
if not Runtime.HasAnySelection(State.BuyRarityTargets) then
State.BuyRarityTargets["IMPOSSIBLE"] = true
State.BuyRarityTargets["Godly"] = true
end
if not Runtime.HasAnySelection(State.MutationTargets) then
State.MutationTargets["Night"] = true
State.MutationTargets["Cursed"] = true
State.MutationTargets["Shiny"] = true
end
if not Runtime.HasAnySelection(State.KeepMutationTargets) then
State.KeepMutationTargets["Night"] = true
State.KeepMutationTargets["Cursed"] = true
State.KeepMutationTargets["Shiny"] = true
end
if not Runtime.HasAnySelection(State.KeepRarityTargets) then
State.KeepRarityTargets["IMPOSSIBLE"] = true
State.KeepRarityTargets["Godly"] = true
end
elseif preset == "Balanced" then
if not Runtime.HasAnySelection(State.BuyRarityTargets) then
State.BuyRarityTargets["IMPOSSIBLE"] = true
State.BuyRarityTargets["Godly"] = true
State.BuyRarityTargets["Mythic"] = true
end
if not Runtime.HasAnySelection(State.MutationTargets) then
State.MutationTargets["Night"] = true
State.MutationTargets["Cursed"] = true
State.MutationTargets["Shiny"] = true
end
if not Runtime.HasAnySelection(State.KeepMutationTargets) then
State.KeepMutationTargets["Night"] = true
State.KeepMutationTargets["Cursed"] = true
State.KeepMutationTargets["Shiny"] = true
end
if not Runtime.HasAnySelection(State.KeepRarityTargets) then
State.KeepRarityTargets["IMPOSSIBLE"] = true
State.KeepRarityTargets["Godly"] = true
State.KeepRarityTargets["Mythic"] = true
end
elseif preset == "MaxProgression" then
end
end
Runtime.MarkCustomStrategy = function()
if State and State.AutomationStrategy ~= "Custom" then
State.AutomationStrategy = "Custom"
if type(Runtime.RefreshStrategyUI) == "function" then
pcall(Runtime.RefreshStrategyUI)
end
end
end
Runtime.ApplyStrategyPreset = function(preset)
if not State then return end
State.AutomationStrategy = preset
if preset == "MaxProgression" then
State.AutoRoll = true
State.AutoBuyTarget = false
State.AutoBuyMutation = false
State.AutoBuyRebirthGnomes = true
State.PauseRollUntilAffordable = false
State.RollPriority = "RebirthFirst"
State.AutoBest30 = true
State.AutoCollect = true
State.AutoSellProduce = true
if next(State.SellProduceMutationTargets) == nil then
State.SellProduceMutationTargets["Normal"] = true
end
State.AutoUseItems = true
State.AutoBuyShop = true
State.AutoBuyExpansion = true
State.AutoUpgrade = true
State.AutoRebirth = true
elseif preset == "GnomeHunter" then
State.AutoRoll = true
State.AutoBuyTarget = true
State.AutoBuyMutation = true
State.AutoBuyRebirthGnomes = false
State.PauseRollUntilAffordable = true
State.RollPriority = "TargetFirst"
State.AutoBest30 = true
State.AutoCollect = true
State.AutoSellProduce = true
if next(State.SellProduceMutationTargets) == nil then
State.SellProduceMutationTargets["Normal"] = true
end
State.AutoUseItems = true
State.AutoBuyShop = true
State.AutoBuyExpansion = false
State.AutoUpgrade = false
State.AutoRebirth = false
elseif preset == "MoneyMachine" then
State.AutoRoll = false
State.AutoBuyTarget = false
State.AutoBuyMutation = false
State.AutoBuyRebirthGnomes = false
State.PauseRollUntilAffordable = false
State.RollPriority = "TargetFirst"
State.AutoBest30 = true
State.AutoCollect = true
State.AutoSellProduce = true
if next(State.SellProduceMutationTargets) == nil then
State.SellProduceMutationTargets["Normal"] = true
end
State.AutoUseItems = true
State.AutoBuyShop = true
State.AutoBuyExpansion = true
State.AutoUpgrade = true
State.AutoRebirth = false
Runtime.PendingPurchase = nil
Runtime.WaitingForMoney = false
Runtime.PendingPurchasePrice = 0
elseif preset == "Balanced" then
State.AutoRoll = true
State.AutoBuyTarget = true
State.AutoBuyMutation = true
State.AutoBuyRebirthGnomes = true
State.PauseRollUntilAffordable = true
State.RollPriority = "TargetFirst"
State.AutoBest30 = true
State.AutoCollect = true
State.AutoSellProduce = true
if next(State.SellProduceMutationTargets) == nil then
State.SellProduceMutationTargets["Normal"] = true
end
State.AutoBuyShop = true
State.AutoUseItems = true
State.AutoUpgrade = true
State.AutoBuyExpansion = true
State.AutoRebirth = true
elseif preset == "Custom" then
State.AutomationStrategy = "Custom"
end
if preset ~= "Custom" then
table.clear(State.BuyRarityTargets)
table.clear(State.MutationTargets)
table.clear(State.KeepMutationTargets)
table.clear(State.KeepRarityTargets)
table.clear(State.SellProduceMutationTargets)
table.clear(State.UseItemTargets)
table.clear(State.ShopTargets)
Runtime.SelectionVersion = Runtime.SelectionVersion + 1
ensurePresetTargets(preset)
end
if type(Runtime.ToggleRefreshers) == "table" then
for _, refresh in pairs(Runtime.ToggleRefreshers) do
if type(refresh) == "function" then pcall(refresh) end
end
end
if type(Runtime.RefreshRollPriorityUI) == "function" then
pcall(Runtime.RefreshRollPriorityUI)
end
if type(Runtime.RefreshGnomePolicyUI) == "function" then
pcall(Runtime.RefreshGnomePolicyUI)
end
if type(Runtime.RefreshStrategyUI) == "function" then
pcall(Runtime.RefreshStrategyUI)
end
if type(Runtime.RefreshVisibleLists) == "function" then
pcall(Runtime.RefreshVisibleLists, true)
end
end
local SelectionStateKeys = {
"BuyRarityTargets",
"KeepRarityTargets",
"SellRarityTargets",
"MutationTargets",
"KeepMutationTargets",
"SellProduceMutationTargets",
"UseItemTargets",
"ShopTargets",
"GivePlayers",
"ReceivePlayers",
}
Runtime.NormalizeSelection = function(selection)
if type(selection) ~= "table" then
return {}
end
local normalized = {}
for key, value in pairs(selection) do
local name
if type(key) == "string" then
local textValue = type(value) == "string" and string.lower(value) or nil
if value == true or value == 1 or textValue == "true" or textValue == "selected" then
name = key
end
elseif type(value) == "string" and value ~= "" then
name = value
end
if name then
normalized[name] = true
end
end
table.clear(selection)
for name in pairs(normalized) do
selection[name] = true
end
return selection
end
Runtime.NormalizeSelections = function()
for _, key in ipairs(SelectionStateKeys) do
State[key] = Runtime.NormalizeSelection(State[key])
end
end
Runtime.NormalizeAutomation = function(preferred)
Runtime.NormalizeSelections()
local validPolicies = { BelowBest = true, SelectedRarities = true, KeepExtras = true }
if not validPolicies[State.GnomeSellPolicy] then
State.GnomeSellPolicy = "BelowBest"
end
if State.RollPriority ~= "TargetFirst" and State.RollPriority ~= "RebirthFirst" then
State.RollPriority = "TargetFirst"
end
end
Runtime.NormalizeAutomation()
local CONFIG_ROOT = "RollAGnomeHub"
local CONFIG_FOLDER = CONFIG_ROOT .. "/configs"
local AUTOLOAD_FILE = CONFIG_ROOT .. "/autoload.txt"
local function sanitizeProfileName(name)
name = tostring(name or "default")
name = string.gsub(name, "[%c/\\:*?\"<>|]", "_")
name = string.gsub(name, "%.%.", "_")
name = string.sub(name, 1, 40)
return name ~= "" and name or "default"
end
local function ensureConfigFolders()
if type(makefolder) ~= "function" then
return false, "makefolder unavailable"
end
pcall(function() makefolder(CONFIG_ROOT) end)
pcall(function() makefolder(CONFIG_FOLDER) end)
return true
end
local function profilePath(name)
return CONFIG_FOLDER .. "/" .. sanitizeProfileName(name) .. ".json"
end
local function saveProfile(name)
name = sanitizeProfileName(name)
if type(writefile) ~= "function" then
return false, "writefile unavailable"
end
ensureConfigFolders()
Runtime.NormalizeSelections()
State.ConfigProfile = name
local payload = {}
for key in pairs(Defaults) do
payload[key] = State[key]
end
local encodedOk, encoded = pcall(function() return HttpService:JSONEncode(payload) end)
if not encodedOk then
return false, "encode failed"
end
local writeOk = pcall(function() writefile(profilePath(name), encoded) end)
if not writeOk then
return false, "write failed"
end
if State.AutoLoadConfig then
pcall(function() writefile(AUTOLOAD_FILE, name) end)
else
pcall(function() writefile(AUTOLOAD_FILE, "") end)
end
Environment.RollAGnomeProfile = name
return true, name
end
local function loadProfile(name)
name = sanitizeProfileName(name)
if type(readfile) ~= "function" then
return false, "readfile unavailable"
end
local readOk, encoded = pcall(function() return readfile(profilePath(name)) end)
if not readOk or type(encoded) ~= "string" or encoded == "" then
return false, "profile not found"
end
local decodeOk, decoded = pcall(function() return HttpService:JSONDecode(encoded) end)
if not decodeOk or type(decoded) ~= "table" then
return false, "invalid profile"
end
for key, defaultValue in pairs(Defaults) do
local value = decoded[key]
if value ~= nil and type(value) == type(defaultValue) then
if type(defaultValue) == "table" then
local target = type(State[key]) == "table" and State[key] or {}
table.clear(target)
for nestedKey, nestedValue in pairs(value) do
target[nestedKey] = nestedValue
end
State[key] = target
else
State[key] = value
end
end
end
if decoded.AutoUseItems == nil then
State.AutoUseItems = decoded.AutoPlaceSprinklers == true or decoded.AutoGnomeCoffee == true
table.clear(State.UseItemTargets)
if type(decoded.SprinklerTargets) == "table" then
for itemName, enabled in pairs(decoded.SprinklerTargets) do
State.UseItemTargets[itemName] = enabled
end
end
if decoded.AutoGnomeCoffee == true then
State.UseItemTargets["Gnome Coffee"] = true
end
end
if decoded.GnomeSellPolicy == nil then
if decoded.AutoSellTarget == true and decoded.AutoBest30 ~= true and decoded.AutoPlaceGnome ~= true then
State.GnomeSellPolicy = "SelectedRarities"
else
State.GnomeSellPolicy = "BelowBest"
end
end
State.AutoBest30 = State.AutoBest30 == true or decoded.AutoPlaceGnome == true or decoded.AutoSellTarget == true
State.AutoPlaceGnome = nil
State.AutoSellTarget = nil
if decoded.SellProduceMutationTargets == nil and type(decoded.SellFruitMutationTargets) == "table" then
table.clear(State.SellProduceMutationTargets)
for mutation, enabled in pairs(decoded.SellFruitMutationTargets) do
if type(mutation) == "number" and type(enabled) == "string" then
State.SellProduceMutationTargets[enabled] = true
elseif enabled == true then
State.SellProduceMutationTargets[mutation] = true
end
end
end
if decoded.KeepRarityTargets == nil and type(decoded.SellRarityTargets) == "table" then
table.clear(State.KeepRarityTargets)
for rarity, enabled in pairs(decoded.SellRarityTargets) do
if type(rarity) == "number" and type(enabled) == "string" then
State.KeepRarityTargets[enabled] = true
elseif enabled == true then
State.KeepRarityTargets[rarity] = true
end
end
end
State.ConfigProfile = name
Environment.RollAGnomeProfile = name
Runtime.NormalizeAutomation()
Runtime.PendingPurchase = nil
Runtime.WaitingForMoney = false
Runtime.PendingPurchasePrice = 0
Runtime.SelectionVersion = Runtime.SelectionVersion + 1
Runtime.GiftRecipientCache = nil
return true, name
end
if type(readfile) == "function" then
local pointerOk, pointer = pcall(function() return readfile(AUTOLOAD_FILE) end)
if pointerOk and type(pointer) == "string" and pointer ~= "" then
loadProfile(pointer)
end
end
local function getPlot()
local plotObject = Runtime.PlotObject
if not plotObject or plotObject.Parent ~= LocalPlayer then
plotObject = LocalPlayer:FindFirstChild("Plot")
Runtime.PlotObject = plotObject
end
return plotObject and plotObject.Value or nil
end
local function getFarmerName(instance)
if not instance then
return ""
end
return tostring(
instance:GetAttribute("FarmerName")
or instance:GetAttribute("DisplayName")
or instance:GetAttribute("GnomeName")
or instance.Name
)
end
local function getFarmerRarity(instance)
local config = FarmersConfig[getFarmerName(instance)]
if type(config) == "table" and type(config.real_rarity) == "string" then
return config.real_rarity
end
return tostring(instance and instance:GetAttribute("Rarity") or "")
end
local function isSelected(selection, name)
if type(selection) ~= "table" then
return false
end
if selection[name] == true then
return true
end
local lowered = string.lower(tostring(name))
for selected, enabled in pairs(selection) do
if enabled == true and string.lower(tostring(selected)) == lowered then
return true
end
end
return false
end
Runtime.HasAnySelection = function(selection)
if type(selection) == "table" then
for _, enabled in pairs(selection) do
if enabled == true then
return true
end
end
end
return false
end
Runtime.SetSelection = function(selection, name, enabled)
if type(selection) ~= "table" then
return false
end
Runtime.NormalizeSelection(selection)
local lowered = string.lower(tostring(name))
local changed = false
for selected in pairs(selection) do
if string.lower(tostring(selected)) == lowered then
changed = changed or selection[selected] ~= nil
selection[selected] = nil
end
end
if enabled == true then
selection[name] = true
changed = true
end
if changed then
Runtime.SelectionVersion = Runtime.SelectionVersion + 1
Runtime.GiftRecipientCache = nil
if type(Runtime.MarkCustomStrategy) == "function" then
Runtime.MarkCustomStrategy()
end
end
return enabled == true
end
Runtime.ToggleSelection = function(selection, name)
Runtime.NormalizeSelection(selection)
local enabled = not isSelected(selection, name)
Runtime.SetSelection(selection, name, enabled)
if enabled and selection == State.SellRarityTargets then
State.GnomeSellPolicy = "SelectedRarities"
if Runtime.RefreshGnomePolicyUI then
Runtime.RefreshGnomePolicyUI()
end
end
return enabled
end
Runtime.IsSelectedProduceMutation = function(tool)
if not tool then
return false
end
local valueObject = tool:FindFirstChild("Mutations") or tool:FindFirstChild("Mutation")
local rawMutations = tostring(tool:GetAttribute("Mutations") or tool:GetAttribute("Mutation")
or tool:GetAttribute("mutations") or tool:GetAttribute("mutation")
or (valueObject and valueObject:IsA("ValueBase") and valueObject.Value) or "")
local cached = Runtime.ProduceMutationCache[tool]
if cached and cached.Raw == rawMutations and cached.Version == Runtime.SelectionVersion then
return cached.Result
end
local mutations = string.gsub(rawMutations, "%s*[,|+]%s*", "_")
local result = false
if mutations == "" or string.lower(mutations) == "none" or string.lower(mutations) == "normal" then
result = isSelected(State.SellProduceMutationTargets, "Normal")
else
for mutation in string.gmatch(mutations, "[^_]+") do
mutation = string.match(mutation, "^%s*(.-)%s*$")
if isSelected(State.SellProduceMutationTargets, mutation) then
result = true
break
end
end
end
Runtime.ProduceMutationCache[tool] = {
Raw = rawMutations,
Version = Runtime.SelectionVersion,
Result = result,
}
return result
end
Runtime.IsProduceTool = function(tool)
if not tool or not tool:IsA("Tool") then
return false
end
if Runtime.ProduceToolCache[tool] then
return true
end
local itemType = string.lower(tostring(tool:GetAttribute("type") or tool:GetAttribute("Type") or ""))
if itemType == "plant" or itemType == "fruit" or itemType == "crop" or itemType == "produce" then
Runtime.ProduceToolCache[tool] = true
return true
end
local produceName = tostring(tool:GetAttribute("PlantName") or tool:GetAttribute("FruitName")
or tool:GetAttribute("CropName") or tool.Name)
local isProduce = Runtime.ProduceNameLookup[string.lower(produceName)] == true
if isProduce then
Runtime.ProduceToolCache[tool] = true
end
return isProduce
end
Runtime.GetGiftRecipient = function()
if not State.AutoGive then
return nil
end
local cached = Runtime.GiftRecipientCache
if cached and cached.Version == Runtime.SelectionVersion and cached.Until > os.clock()
and (not cached.Player or cached.Player.Parent == Players)
then
return cached.Player
end
local bestPlayer
local bestName
for _, player in ipairs(Players:GetPlayers()) do
if player ~= LocalPlayer and isSelected(State.GivePlayers, player.Name) then
local loweredName = string.lower(player.Name)
if not bestName or loweredName < bestName then
bestPlayer = player
bestName = loweredName
end
end
end
Runtime.GiftRecipientCache = {
Version = Runtime.SelectionVersion,
Until = os.clock() + 0.5,
Player = bestPlayer,
}
return bestPlayer
end
Runtime.IsGiftReserved = function(tool)
if not tool or not tool:IsA("Tool") or tool.Parent ~= LocalPlayer.Character or not Runtime.GetGiftRecipient() then
return false
end
local itemType = string.lower(tostring(tool:GetAttribute("type") or tool:GetAttribute("Type") or ""))
return type(tool:GetAttribute("Id")) == "string"
and (itemType == "plant" or itemType == "fruit" or itemType == "farmer" or itemType == "gnome")
end
local function invoke(remoteName, ...)
if Runtime.Paused then
return false, "paused"
end
if State.LowPingMode then
local now = os.clock()
local interval = remoteName == "CollectPlant" and 0.16 or remoteName == "Roll" and 0.12 or 0.05
local delay = interval - (now - (Runtime.LastRemoteAt[remoteName] or 0))
if delay > 0 then
task.wait(delay)
end
Runtime.LastRemoteAt[remoteName] = os.clock()
end
return safeCall(Network.InvokeServer, Network, remoteName, ...)
end
local function fire(remoteName, ...)
if Runtime.Paused then
return false, "paused"
end
if State.LowPingMode then
local now = os.clock()
local interval = remoteName == "CollectPlant" and 0.16 or remoteName == "Roll" and 0.12 or 0.05
local delay = interval - (now - (Runtime.LastRemoteAt[remoteName] or 0))
if delay > 0 then
task.wait(delay)
end
Runtime.LastRemoteAt[remoteName] = os.clock()
end
return safeCall(Network.FireServer, Network, remoteName, ...)
end
local Text64Alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local function decodeText64(encoded)
Runtime.Text64Cache = Runtime.Text64Cache or {}
local cached = Runtime.Text64Cache[encoded]
if cached then
return cached
end
local output, value, bits = {}, 0, 0
for index = 1, #encoded do
local position = string.find(Text64Alphabet, string.sub(encoded, index, index), 1, true)
if position then
value = value * 64 + position - 1
bits = bits + 6
if bits >= 8 then
bits = bits - 8
output[#output + 1] = string.char(math.floor(value / 2 ^ bits) % 256)
value = value % 2 ^ bits
end
end
end
local decoded = table.concat(output)
Runtime.Text64Cache[encoded] = decoded
return decoded
end
local function textKey(value)
local hash = 5381
for index = 1, #value do
hash = (hash * 33 + string.byte(value, index)) % 2147483647
end
return hash
end
local ThaiText = {
[749662789] = decodeText64("4LiB4Liz4Lir4LiZ4LiU4LmA4Lit4LiH"),
[1675149125] = decodeText64("4LmB4LiV4Liw4LmA4Lie4Li34LmI4Lit4Lib4Lil4Li44LiBCuC4o+C4sOC4muC4muC4l+C4s+C4h+C4suC4meC4leC5iOC4reC5gOC4meC4t+C5iOC4reC4h+C5g+C4meC5guC4q+C4oeC4lOC4m+C4o+C4sOC4q+C4ouC4seC4lOC4nuC4peC4seC4h+C4h+C4suC4mQ=="),
[2097717576] = decodeText64("4Lil4Liz4LiU4Lix4Lia4LiB4Liy4Lij4Lit4Lix4Lib4LmA4LiB4Lij4LiUCjEuIOC4reC4seC4m+C5gOC4geC4o+C4lOC5geC4m+C4peC4h+C4l+C4teC5iOC4quC4suC4oeC4suC4o+C4luC4i+C4t+C5ieC4reC5hOC4lOC5iQoyLiDguK3guLHguJvguYDguIHguKPguJTguKrguLLguKLguKrguIHguLTguKXguJfguLXguYjguJvguKXguJTguKXguYfguK3guIHguYHguKXguYnguKcK4Lij4Liw4Lia4Lia4LiI4Liw4Lib4LmJ4Lit4LiH4LiB4Lix4LiZ4LiB4Liy4Lij4LiL4Li34LmJ4Lit4LmA4LiB4Li04LiZ4LiC4LiZ4Liy4LiU4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li0"),
[1790338205] = decodeText64("Q3RybCArIEFsdCAgfCAg4LmA4Lib4Li04LiUIC8g4LiL4LmI4Lit4LiZ4Lir4LiZ4LmJ4Liy4LiV4LmI4Liy4LiHIFVJClBBVVNFIOC4q+C4ouC4uOC4lOC4geC4suC4o+C4l+C4s+C4h+C4suC4meC4l+C4seC5ieC4h+C4q+C4oeC4lCwgUkVTVU1FIOC4hOC4t+C4meC4hOC5iOC4suC4quC4luC4suC4meC4sOC5gOC4lOC4tOC4oQrguKPguLDguJrguJrguKLguLHguIfguITguIfguJfguLPguIfguLLguJnguJXguYjguK3guYDguJnguLfguYjguK3guIfguYDguKHguLfguYjguK3guJ7guLHguJrguKvguJnguYnguLLguJXguYjguLLguIc="),
[1119051639] = decodeText64("4LmA4Lil4Li34Lit4LiB4Lij4Li54Lib4LmB4Lia4Lia4LiB4Liy4Lij4LiI4Lix4LiU4Liq4Lij4Lij4LmA4LiH4Li04LiZ4LmB4Lil4Liw4Lil4Liz4LiU4Lix4Lia4LiB4Liy4Lij4LiX4Liz4LiH4Liy4LiZ4LiC4Lit4LiH4LiV4Lix4Lin4Lil4Liw4LiE4Lij"),
[847828358] = decodeText64("4Liq4Li44LmI4Lih4LmC4LiZ4Lih4LiV4LmI4Lit4LmA4LiZ4Li34LmI4Lit4LiH4LmB4Lil4Liw4Lij4Lit4Lic4Lil4Lil4Lix4Lie4LiY4LmM4LiX4Li44LiB4Lij4Lit4Lia"),
[1224226842] = decodeText64("4Lin4Liy4LiH4LmB4Lil4Liw4Lib4LiB4Lib4LmJ4Lit4LiH4LmC4LiZ4Lih4Lil4Liz4LiU4Lix4Lia4LiV4LmJ4LiZ4LmGIOC4leC4suC4oeC4iOC4s+C4meC4p+C4meC4l+C4teC5iOC4geC4s+C4q+C4meC4lA=="),
[897751219] = decodeText64("4LmC4LiZ4Lih"),
[2089098701] = decodeText64("4Lif4Liy4Lij4LmM4Lih"),
[530659912] = decodeText64("4Lit4Lix4Lib4LmA4LiB4Lij4LiU"),
[1368126117] = decodeText64("4LmC4LiL4LmA4LiK4Li14Lii4Lil"),
[1380572431] = decodeText64("4Lij4Liw4Lia4Lia"),
[742352128] = decodeText64("4LmC4Lib4Lij4LmE4Lif4Lil4LmM"),
[2106297831] = decodeText64("4LmC4Lir4Lih4LiU4LmB4Lil4Liw4LiB4Lil4Lii4Li44LiX4LiY4LmM"),
[1836895263] = decodeText64("4Liq4Li44LmI4Lih4LmC4LiZ4Lih4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li0"),
[1475304190] = decodeText64("4LiI4Lix4LiU4LiB4Liy4Lij4LmC4LiZ4Lih4LiX4Li14LmI4LiU4Li14LiX4Li14LmI4Liq4Li44LiU"),
[2085587169] = decodeText64("4LmA4LiB4LmH4Lia4LmA4LiB4Li14LmI4Lii4Lin4LmB4Lil4Liw4LiC4Liy4Lii4Lic4Lil4Lic4Lil4Li04LiV"),
[1331036383] = decodeText64("4LmA4Lib4LmJ4Liy4Lir4Lih4Liy4Lii4LiL4Li34LmJ4Lit4LmB4Lil4Liw4LiB4Liy4Lij4Lib4LmJ4Lit4LiH4LiB4Lix4LiZ"),
[1735995099] = decodeText64("4LiU4Li54LmB4Lil4Lif4Liy4Lij4LmM4Lih4LmB4Lil4Liw4Lia4Lix4Lif"),
[1898137625] = decodeText64("4LiL4Li34LmJ4Lit4LiC4Lit4LiH4Lij4LmJ4Liy4LiZ4LiE4LmJ4Liy4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li0"),
[1216664228] = decodeText64("4LiL4Li34LmJ4Lit4LmC4LiZ4Lih4LiX4Li14LmI4Liq4Li44LmI4Lih4LmE4LiU4LmJ4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li0"),
[1052934764] = decodeText64("4LiL4Li34LmJ4Lit4LmC4LiZ4Lih4LiX4Li14LmI4Liq4Li44LmI4Lih4LmE4LiU4LmJ4LiV4Liy4Lih4Lij4Liw4LiU4Lix4LiaIOC4oeC4tOC4p+C5gOC4leC4iuC4seC5iOC4mSDguKvguKPguLfguK3guJXguLHguKfguYDguIHguLTguJTguYPguKvguKHguYjguJfguLXguYjguYDguKXguLfguK3guIHguYTguKfguYk="),
[2130494790] = decodeText64("4Lir4Lii4Li44LiU4Liq4Li44LmI4Lih4Lij4Lit4LmA4LiH4Li04LiZ4LmA4Lih4Li34LmI4Lit4LmA4LiI4Lit4LiV4Lix4Lin4LiX4Li14LmI4LiV4LmJ4Lit4LiH4LiB4Liy4Lij"),
[1435780865] = decodeText64("4Lil4LmH4Lit4LiB4Lic4Lil4LiB4Liy4Lij4Liq4Li44LmI4Lih4LiX4Li14LmI4LiV4LmJ4Lit4LiH4LiB4Liy4Lij4LmE4Lin4LmJ4LiI4LiZ4LiB4Lin4LmI4Liy4LiI4Liw4Lih4Li14LmA4LiH4Li04LiZ4Lie4Lit4LiL4Li34LmJ4Lit"),
[1054944133] = decodeText64("4LiI4Lix4LiU4LiB4Liy4Lij4LmC4LiZ4Lih4LiX4Li14LmI4LmA4LiB4LmI4LiH4LiX4Li14LmI4Liq4Li44LiU4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li0"),
[247234402] = decodeText64("4Lin4Liy4LiH4LmB4Lil4Liw4Lib4LiB4Lib4LmJ4Lit4LiH4LmC4LiZ4Lih4Lil4Liz4LiU4Lix4Lia4LiV4LmJ4LiZ4LmGIOC4leC4suC4oeC4iOC4s+C4meC4p+C4meC4l+C4teC5iOC4geC4s+C4q+C4meC4lA=="),
[960687958] = decodeText64("4LmA4LiB4LmH4Lia4Lic4Lil4Lic4Lil4Li04LiV4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li0"),
[1207244955] = decodeText64("4Lin4Liy4Lij4LmM4Lib4LmE4Lib4LmA4LiB4LmH4Lia4Lic4Lil4Lic4Lil4Li04LiV4LiX4Li14LmI4Liq4Li44LiB4LmB4Lil4LmJ4Lin4LmB4Lil4Liw4LiB4Lil4Lix4Lia4Lih4Liy4LiX4Li14LmI4LmA4LiU4Li04Lih"),
[734608302] = decodeText64("4LiC4Liy4Lii4Lic4Lil4Lic4Lil4Li04LiV4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li0"),
[11884063] = decodeText64("4LiC4Liy4Lii4LmA4LiJ4Lie4Liy4Liw4Lic4Lil4Lic4Lil4Li04LiV4LiX4Li14LmI4Lih4Li14Lih4Li04Lin4LmA4LiV4LiK4Lix4LmI4LiZ4LiV4Lij4LiH4LiV4Liy4Lih4LiX4Li14LmI4LmA4Lil4Li34Lit4LiB4LmE4Lin4LmJ"),
[695356572] = decodeText64("4LmD4LiK4LmJ4LmE4Lit4LmA4LiX4Lih4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li0"),
[986399584] = decodeText64("4LmD4LiK4LmJ4Liq4Lib4Lij4Li04LiH4LmA4LiB4Lit4Lij4LmMIOC4m+C4uOC5i+C4oiDguJrguLHguKfguKPguJTguJnguYnguLMg4LmB4Lil4Liw4LiB4Liy4LmB4Lif4LiX4Li14LmI4LmA4Lil4Li34Lit4LiB4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li0"),
[1950563464] = decodeText64("4LiL4Li34LmJ4Lit4LiC4Lit4LiH4LmD4LiZ4Lij4LmJ4Liy4LiZ4LiE4LmJ4Liy4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li0"),
[2132620544] = decodeText64("4LiL4Li34LmJ4Lit4LmE4Lit4LmA4LiX4Lih4LiX4Li14LmI4LmA4Lil4Li34Lit4LiB4LiX4Lix4LiZ4LiX4Li14LmA4Lih4Li34LmI4Lit4Lih4Li14LiC4Lit4LiH4LmD4LiZ4Lij4LmJ4Liy4LiZ"),
[403129408] = decodeText64("4Liq4LmI4LiH4LmE4Lit4LmA4LiX4Lih4LmD4LiZ4Lih4Li34Lit4LmD4Lir4LmJ4LmA4Lie4Li34LmI4Lit4LiZ4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li0"),
[1517552053] = decodeText64("4Liq4LmI4LiH4Lic4Lil4Lic4Lil4Li04LiV4Lir4Lij4Li34Lit4LmC4LiZ4Lih4LiX4Li14LmI4LiW4Li34Lit4Lit4Lii4Li54LmI4LmD4LiZ4Lih4Li34Lit4LmD4Lir4LmJ4Lic4Li54LmJ4LmA4Lil4LmI4LiZ4LiX4Li14LmI4LmA4Lil4Li34Lit4LiB"),
[679397871] = decodeText64("4Lij4Lix4Lia4LiC4Lit4LiH4LiC4Lin4Lix4LiN4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li0"),
[634013570] = decodeText64("4Lij4Lix4Lia4LiC4Lit4LiH4LiC4Lin4Lix4LiN4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li04LmA4LiJ4Lie4Liy4Liw4LiI4Liy4LiB4LmA4Lie4Li34LmI4Lit4LiZ4LiX4Li14LmI4LmA4Lil4Li34Lit4LiB4LmE4Lin4LmJ4LmA4LiX4LmI4Liy4LiZ4Lix4LmJ4LiZ"),
[618208355] = decodeText64("4Lit4Lix4Lib4LmA4LiB4Lij4LiU4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li0"),
[1347313269] = decodeText64("4LiL4Li34LmJ4Lit4LiB4Liy4Lij4Lit4Lix4Lib4LmA4LiB4Lij4LiU4LmB4Lib4Lil4LiH4LmB4Lil4Liw4Lit4Lix4Lib4Liq4LiB4Li04Lil4LiV4LmJ4LiZ4LmE4Lih4LmJ4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li0"),
[196116111] = decodeText64("4LiC4Lii4Liy4Lii4LiX4Li14LmI4LiU4Li04LiZ4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li0"),
[328824634] = decodeText64("4LiL4Li34LmJ4Lit4LiB4Liy4Lij4LiC4Lii4Liy4Lii4Lie4Li34LmJ4LiZ4LiX4Li14LmI4LmB4Lib4Lil4LiH4LiX4Li14LmI4LiW4Li54LiB4LiX4Li14LmI4Liq4Li44LiU4LiX4Lix4LiZ4LiX4Li14LmA4Lih4Li34LmI4Lit4LmA4LiH4Li04LiZ4Lie4Lit"),
[602048425] = decodeText64("4LmA4LiB4Li04LiU4LmD4Lir4Lih4LmI4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li0IChSZWJpcnRoKQ=="),
[440181375] = decodeText64("4LmA4LiB4Li04LiU4LmD4Lir4Lih4LmI4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li04LmA4Lih4Li34LmI4Lit4LmA4LiH4Li04LiZ4LmB4Lil4Liw4LmC4LiZ4Lih4LiX4Li14LmI4LiE4LmJ4LiZ4Lie4Lia4LiE4Lij4Lia4LiV4Liy4Lih4LmA4LiH4Li34LmI4Lit4LiZ4LmE4LiC"),
[574315800] = decodeText64("4Lib4LmJ4Lit4LiH4LiB4Lix4LiZ4LiB4Liy4Lij4Lir4Lil4Li44LiUIChBbnRpLUFGSyk="),
[69350190] = decodeText64("4LiI4Liz4Lil4Lit4LiH4LiB4Liy4Lij4LiC4Lii4Lix4Lia4LiV4Lix4Lin4LmA4Lih4Li34LmI4Lit4Lij4Liw4Lia4Lia4LiV4Lij4Lin4LiI4Lie4Lia4Lin4LmI4Liy4Lic4Li54LmJ4LmA4Lil4LmI4LiZ4Lit4Lii4Li54LmI4LiZ4Li04LmI4LiH"),
[1059741808] = decodeText64("4LmA4LiK4Li34LmI4Lit4Lih4LiV4LmI4Lit4LmD4Lir4Lih4LmI4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li0"),
[2145984092] = decodeText64("4LiB4Lil4Lix4Lia4LmA4LiC4LmJ4Liy4LmA4LiL4Li04Lij4LmM4Lif4LmA4Lin4Lit4Lij4LmM4LmA4LiU4Li04Lih4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li04LmA4Lih4Li34LmI4Lit4LmA4LiB4Lih4Lir4Lil4Li44LiU4Lir4Lij4Li34Lit4LiV4Lix4LiU4LiB4Liy4Lij4LmA4LiK4Li34LmI4Lit4Lih4LiV4LmI4Lit"),
[1974862954] = decodeText64("4LmC4Lir4Lih4LiU4Lil4LiU4LiE4Lin4Liy4Lih4Lir4LiZ4LmI4Lin4LiHIChMb3cgUGluZyk="),
[1618525399] = decodeText64("4LmA4LiB4Lil4Li14LmI4Lii4LiB4Liy4Lij4Liq4LmI4LiH4LiC4LmJ4Lit4Lih4Li54Lil4LmE4Lib4Lii4Lix4LiH4LmA4LiL4Li04Lij4LmM4Lif4LmA4Lin4Lit4Lij4LmM4LmD4Lir4LmJ4LmA4Liq4LiW4Li14Lii4Lij4LiC4Li24LmJ4LiZ"),
[2034570322] = decodeText64("4LmC4Lir4Lih4LiU4Lig4Liy4Lie4LiB4Liy4LiBICjguKXguJTguYHguKXguYfguIEp"),
[864013862] = decodeText64("4Lib4Li04LiU4LmA4Lit4Lif4LmA4Lif4LiB4LiV4LmM4Lig4Liy4Lie4LiX4Li14LmI4LmE4Lih4LmI4LiI4Liz4LmA4Lib4LmH4LiZ4LiX4Lix4LmJ4LiH4Lir4Lih4LiU4LmA4Lie4Li34LmI4Lit4LmA4Lie4Li04LmI4Lih4LiE4Lin4Liy4Lih4Lil4Li34LmI4LiZ4LmE4Lir4Lil"),
[822158911] = decodeText64("4LmC4Lir4Lil4LiU4LmC4Lib4Lij4LmE4Lif4Lil4LmM4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li0"),
[384180709] = decodeText64("4LmC4Lir4Lil4LiU4LiB4Liy4Lij4LiV4Lix4LmJ4LiH4LiE4LmI4Liy4LmC4Lib4Lij4LmE4Lif4Lil4LmM4LiZ4Li14LmJ4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li04LmA4Lih4Li34LmI4Lit4LmA4Lib4Li04LiU4Liq4LiE4Lij4Li04Lib4LiV4LmM4LiE4Lij4Lix4LmJ4LiH4LiW4Lix4LiU4LmE4Lib"),
[1995119328] = decodeText64("4Lij4Liw4LiU4Lix4Lia4LmC4LiZ4Lih4LiX4Li14LmI4LiV4LmJ4Lit4LiH4LiB4Liy4Lij4LiL4Li34LmJ4Lit"),
[632921855] = decodeText64("4LmA4Lil4Li34Lit4LiB4Lij4Liw4LiU4Lix4Lia4LiE4Lin4Liy4Lih4Lir4Liy4Lii4Liy4LiB4LiX4Li14LmI4LiV4LmJ4Lit4LiH4LiB4Liy4Lij4LmD4Lir4LmJ4Lia4Lit4LiX4LiL4Li34LmJ4Lit4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li0"),
[478680938] = decodeText64("4Lih4Li04Lin4LmA4LiV4LiK4Lix4LmI4LiZ4LiX4Li14LmI4LiV4LmJ4Lit4LiH4LiB4Liy4Lij4LiL4Li34LmJ4Lit"),
[122919227] = decodeText64("4LmA4Lil4Li34Lit4LiB4Lih4Li04Lin4LmA4LiV4LiK4Lix4LmI4LiZ4LiX4Li14LmI4LiV4LmJ4Lit4LiH4LiB4Liy4Lij4LmD4Lir4LmJ4Lia4Lit4LiX4LiL4Li34LmJ4Lit4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li0"),
[547907862] = decodeText64("4Lij4Liw4LiU4Lix4Lia4LmC4LiZ4Lih4LiX4Li14LmI4LiV4LmJ4Lit4LiH4LiB4Liy4Lij4LmA4LiB4LmH4LiaICjguYTguKHguYjguILguLLguKIp"),
[1466324090] = decodeText64("4LmC4LiZ4Lih4LiX4Li14LmI4Lih4Li14Lij4Liw4LiU4Lix4Lia4LmA4Lir4Lil4LmI4Liy4LiZ4Li14LmJ4LiI4Liw4LiW4Li54LiB4Lib4LmJ4Lit4LiH4LiB4Lix4LiZ4LmB4Lil4Liw4LmA4LiB4LmH4Lia4LmE4Lin4LmJ4LmD4LiZ4LiV4Lix4Lin4LmA4Liq4Lih4LitIOC4q+C5ieC4suC4oeC4guC4suC4og=="),
[718391362] = decodeText64("4Lih4Li04Lin4LmA4LiV4LiK4Lix4LmI4LiZ4LiX4Li14LmI4LiV4LmJ4Lit4LiH4LiB4Liy4Lij4LmA4LiB4LmH4LiaICjguYTguKHguYjguILguLLguKIp"),
[1712556532] = decodeText64("4LmC4LiZ4Lih4LiX4Li14LmI4Lih4Li14Lih4Li04Lin4LmA4LiV4LiK4Lix4LmI4LiZ4LmA4Lir4Lil4LmI4Liy4LiZ4Li14LmJ4LiI4Liw4LiW4Li54LiB4Lib4LmJ4Lit4LiH4LiB4Lix4LiZ4LmB4Lil4Liw4LmA4LiB4LmH4Lia4LmE4Lin4LmJ4LmD4LiZ4LiV4Lix4Lin4LmA4Liq4Lih4LitIOC4q+C5ieC4suC4oeC4guC4suC4og=="),
[390114212] = decodeText64("4Lih4Li04Lin4LmA4LiV4LiK4Lix4LmI4LiZ4Lic4Lil4Lic4Lil4Li04LiV4LiX4Li14LmI4LiV4LmJ4Lit4LiH4LiB4Liy4Lij4LiC4Liy4Lii"),
[1526727371] = decodeText64("4Lic4Lil4Lic4Lil4Li04LiV4LiX4Li14LmI4Lih4Li14Lih4Li04Lin4LmA4LiV4LiK4Lix4LmI4LiZ4LiV4Liy4Lih4LiX4Li14LmI4LmA4Lil4Li34Lit4LiB4LiI4Liw4LiW4Li54LiB4LiZ4Liz4LmE4Lib4LiC4Liy4LiiICjguJXguLTguYrguIEgTm9ybWFsIOC5gOC4nuC4t+C5iOC4reC4guC4suC4ouC4nOC4seC4geC4mOC4o+C4o+C4oeC4lOC4sik="),
[68911190] = decodeText64("4LmE4Lit4LmA4LiX4Lih4Lif4Liy4Lij4LmM4Lih4LiX4Li14LmI4LiV4LmJ4Lit4LiH4LiB4Liy4Lij4LmD4LiK4LmJ"),
[178505180] = decodeText64("4LmA4LiJ4Lie4Liy4Liw4LmE4Lit4LmA4LiX4Lih4LiX4Li14LmI4LmA4Lil4Li34Lit4LiB4LmA4LiX4LmI4Liy4LiZ4Lix4LmJ4LiZ4LiX4Li14LmI4LiI4Liw4LiW4Li54LiB4LiZ4Liz4Lih4Liy4LmD4LiK4LmJ4LiH4Liy4LiZ4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li0"),
[1510124033] = decodeText64("4LmE4Lit4LmA4LiX4Lih4Lij4LmJ4Liy4LiZ4LiE4LmJ4Liy4LiX4Li14LmI4LiV4LmJ4Lit4LiH4LiB4Liy4Lij4LiL4Li34LmJ4Lit"),
[1699707406] = decodeText64("4LmE4Lit4LmA4LiX4Lih4LiX4Li14LmI4Lit4LiZ4Li44LiN4Liy4LiV4LmD4Lir4LmJ4Lij4Liw4Lia4Lia4LiL4Li34LmJ4Lit4LiI4Liy4LiB4Lij4LmJ4Liy4LiZ4LiE4LmJ4Liy4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li0"),
[395775933] = decodeText64("4Lij4Liy4Lii4LiK4Li34LmI4Lit4LmA4Lie4Li34LmI4Lit4LiZ4LiX4Li14LmI4LiV4LmJ4Lit4LiH4LiB4Liy4Lij4Liq4LmI4LiH4LiC4Lit4LiH4LmD4Lir4LmJ"),
[2048754197] = decodeText64("4LmA4Lil4Li34Lit4LiB4LmA4Lie4Li34LmI4Lit4LiZ4LmD4LiZ4LmA4LiL4Li04Lij4LmM4Lif4LmA4Lin4Lit4Lij4LmM4LiX4Li14LmI4LiV4LmJ4Lit4LiH4LiB4Liy4Lij4Liq4LmI4LiH4Lic4Lil4Lic4Lil4Li04LiV4Lir4Lij4Li34Lit4LmC4LiZ4Lih4LmD4Lir4LmJ"),
[1096463868] = decodeText64("4Lij4Liy4Lii4LiK4Li34LmI4Lit4LmA4Lie4Li34LmI4Lit4LiZ4LiX4Li14LmI4Lit4LiZ4Li44LiN4Liy4LiV4LmD4Lir4LmJ4Lij4Lix4Lia4LiC4Lit4LiH"),
[381601337] = decodeText64("4Lii4Lit4Lih4Lij4Lix4Lia4LiB4Liy4Lij4Liq4LmI4LiH4LiC4Lit4LiH4LiC4Lin4Lix4LiN4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li04LmA4LiJ4Lie4Liy4Liw4LiI4Liy4LiB4LmA4Lie4Li34LmI4Lit4LiZ4LiX4Li14LmI4LmA4Lil4Li34Lit4LiB4LmE4Lin4LmJ"),
[1489178280] = decodeText64("4LmA4Lil4Li34Lit4LiB4LiX4Lix4LmJ4LiH4Lir4Lih4LiU"),
[217603534] = decodeText64("4Lil4LmJ4Liy4LiH"),
[794030545] = decodeText64("4LiE4LmJ4LiZ4Lir4LiyLi4u"),
[1230004093] = decodeText64("4LmC4Lir4Lih4LiU4LiB4Lil4Lii4Li44LiX4LiY4LmM4LiB4Liy4Lij4LiX4Liz4LiH4Liy4LiZ"),
[873990212] = decodeText64("4LmA4Lil4Li34Lit4LiB4Lij4Li54Lib4LmB4Lia4Lia4LiB4Liy4Lij4LiX4Liz4LiH4Liy4LiZ4LiX4Li14LmI4LiV4LmJ4Lit4LiH4LiB4Liy4Lij4LmA4LiZ4LmJ4LiZ4LmA4Lib4LmH4LiZ4Lie4Li04LmA4Lio4Lip"),
[173500436] = decodeText64("4Liq4Lib4Li14LiU4Lij4Lix4LiZIFJlYmlydGg="),
[294679592] = decodeText64("4Lil4LmI4Liy4LmC4LiZ4Lih4LmA4LiX4Lie"),
[761187565] = decodeText64("4Lib4Lix4LmK4Lih4LmA4LiH4Li04LiZ4Lif4Liy4Lij4LmM4Lih"),
[314142064] = decodeText64("4Liq4Lih4LiU4Li44Lil4Lit4Lix4LiI4LiJ4Lij4Li04Lii4Liw"),
[1092575591] = decodeText64("4Lil4Liz4LiU4Lix4Lia4LiE4Lin4Liy4Lih4Liq4Liz4LiE4Lix4LiNICjguKrguLjguYjguKEgdnMgUmViaXJ0aCk="),
[2058004565] = decodeText64("4LmA4Lil4Li34Lit4LiB4Lij4Liw4Lir4Lin4LmI4Liy4LiH4LiB4Liy4Lij4Lir4Lii4Li44LiU4LiL4Li34LmJ4Lit4LmC4LiZ4Lih4LiX4Li14LmI4LiV4LmJ4Lit4LiH4LiB4Liy4LijIOC4q+C4o+C4t+C4reC4geC4suC4o+C4geC4lOC5gOC4geC4tOC4lOC5g+C4q+C4oeC5iOC4geC5iOC4reC4mQ=="),
[211053657] = decodeText64("4LiL4Li34LmJ4Lit4LmC4LiZ4Lih4LiB4LmI4Lit4LiZ"),
[1415884188] = decodeText64("4LmA4LiB4Li04LiU4LmD4Lir4Lih4LmI4LiB4LmI4Lit4LiZ"),
[564665951] = decodeText64("4LiI4Liz4LiZ4Lin4LiZ4LmC4LiZ4Lih4LiX4Li14LmI4LmA4LiB4LmI4LiH4LiX4Li14LmI4Liq4Li44LiU"),
[1402248995] = decodeText64("4Lij4Liw4Lia4Li44LiI4Liz4LiZ4Lin4LiZ4LmC4LiZ4Lih4LiX4Li14LmI4LiV4LmJ4Lit4LiH4LiB4Liy4Lij4Lin4Liy4LiH4Lil4LiH4LmB4Lib4Lil4LiHICgxIOC4luC4tuC4hyAxMDAg4LiV4Lix4LinKQ=="),
[790590637] = decodeText64("4LmC4Lir4Lih4LiU4Lie4Lix4LiB4Lir4LiZ4LmJ4Liy4LiI4LitICjguJvguKPguLDguKvguKLguLHguJTguJ7guKXguLHguIfguIfguLLguJkp"),
[923391854] = decodeText64("4Lia4Lit4LiX4LiX4Liz4LiH4Liy4LiZ4LiV4LmI4Lit4LmA4LiZ4Li34LmI4Lit4LiH4LmC4LiU4Lii4Lib4Li04LiU4LiB4Liy4Lij4Lib4Lij4Liw4Lih4Lin4Lil4Lic4LilIDNEIOC5geC4peC4sOC4iOC4s+C4geC4seC4lCAxMCBGUFM="),
[226089592] = decodeText64("4Lie4Lix4LiB4Lir4LiZ4LmJ4Liy4LiI4Lit"),
[237978446] = decodeText64("4LiC4LiZ4Liy4LiU4LiV4Lix4Lin4Lir4LiZ4Lix4LiH4Liq4Li34Lit"),
[1123865154] = decodeText64("4Lib4Lij4Lix4Lia4LiC4LiZ4Liy4LiU4LiV4Lix4Lin4Lir4LiZ4Lix4LiH4Liq4Li34Lit4LmD4LiZ4LmA4Lih4LiZ4Li54LiV4Lix4LmJ4LiH4LmB4LiV4LmIIDcwJSDguJbguLbguIcgMTYwJQ=="),
[98108697] = decodeText64("4LiK4Li34LmI4Lit4LmC4Lib4Lij4LmE4Lif4Lil4LmM"),
[1118359840] = decodeText64("4Lia4Lix4LiZ4LiX4Li24LiB4LmC4Lib4Lij4LmE4Lif4Lil4LmM"),
[1685611255] = decodeText64("4LmC4Lir4Lil4LiU4LmC4Lib4Lij4LmE4Lif4Lil4LmM"),
[193820477] = decodeText64("4LmA4LiC4LmJ4Liy4LmA4LiL4Li04Lij4LmM4Lif4LmD4Lir4Lih4LmI4LiX4Lix4LiZ4LiX4Li1"),
[1625187216] = decodeText64("4Liq4Lib4Lij4Li04LiH4LmA4LiB4Lit4Lij4LmM4LmB4Lil4Liw4Lib4Li44LmL4Lii4LiI4Liw4Lin4Liy4LiH4LiE4Lil4Li44Lih4Lie4Li34LiK4Lij4Liy4LiE4Liy4LmB4Lie4LiHLCDguJrguLHguKfguKPguJTguJnguYnguLPguIjguLDguKPguJTguJ7guLfguIrguJfguLXguYjguIHguLPguKXguLHguIfguYLguJUsIOC5geC4peC4sOC4geC4suC5geC4n+C4iOC4sOC5g+C4iuC5ieC4geC4seC4muC5guC4meC4oeC4l+C4teC5iOC5gOC4geC5iOC4h+C4l+C4teC5iOC4quC4uOC4lOC5g+C4meC5geC4m+C4peC4hw=="),
[895845879] = decodeText64("4Lil4Liz4LiU4Lix4Lia4LiB4Liy4Lij4Lit4Lix4Lib4LmA4LiB4Lij4LiUCjEuIOC4reC4seC4m+C5gOC4geC4o+C4lOC5geC4m+C4peC4h+C4l+C4teC5iOC5gOC4h+C4tOC4meC4nuC4reC4i+C4t+C5ieC4rQoyLiDguK3guLHguJvguYDguIHguKPguJTguKrguIHguLTguKXguJXguYnguJnguYTguKHguYnguJfguLXguYjguJvguKXguJTguKXguYfguK3guIHguYHguKXguYnguKcK4Lij4Liw4Lia4Lia4Lib4LmJ4Lit4LiH4LiB4Lix4LiZ4LiB4Liy4Lij4LiL4Li34LmJ4Lit4LmA4LiB4Li04LiZ4Lir4Lij4Li34Lit4LiE4Liz4Liq4Lix4LmI4LiH4LmE4Lih4LmI4LiW4Li54LiB4LiV4LmJ4Lit4LiH4Lit4Lix4LiV4LmC4LiZ4Lih4Lix4LiV4Li0"),
[146757810] = decodeText64("Q3RybCArIEFsdCAgfCAg4LmA4Lib4Li04LiUIC8g4LiL4LmI4Lit4LiZ4Lir4LiZ4LmJ4Liy4LiV4LmI4Liy4LiHIFVJClBBVVNFIOC5gOC4nuC4t+C5iOC4reC4q+C4ouC4uOC4lOC4muC4reC4l+C4l+C4seC5ieC4h+C4q+C4oeC4lCwgUkVTVU1FIOC5gOC4nuC4t+C5iOC4reC5g+C4q+C5ieC4l+C4s+C4h+C4suC4meC4leC5iOC4reC4leC4suC4oeC5gOC4lOC4tOC4oQrguKPguLDguJrguJrguKLguLHguIfguITguIfguJfguLPguIfguLLguJnguJXguYjguK3guYDguJnguLfguYjguK3guIfguYDguKHguLfguYjguK3guKLguYjguK3guKvguJnguYnguLLguJXguYjguLLguIc="),
[754771019] = decodeText64("4LmB4LiV4Liw4Lir4LiZ4LmJ4Liy4LiI4Lit4LmA4Lie4Li34LmI4Lit4Lib4Lil4Li44LiBCuC4muC4reC4l+C4geC4s+C4peC4seC4h+C4l+C4s+C4h+C4suC4meC4leC5iOC4reC5gOC4meC4t+C5iOC4reC4h+C5g+C4meC5guC4q+C4oeC4lOC4m+C4o+C4sOC4q+C4ouC4seC4lOC4nuC4peC4seC4h+C4h+C4suC4mQ=="),
}
local LanguageBindings = {}
local LanguageRefreshers = {}
local function translated(english)
if State.Language == "TH" then
return ThaiText[textKey(english)] or english
end
return english
end
local function bindLanguage(object, property, english)
object[property] = translated(english)
table.insert(LanguageBindings, {
Object = object,
Property = property,
English = english,
})
end
local function refreshLanguage()
for _, binding in ipairs(LanguageBindings) do
if binding.Object and binding.Object.Parent then
binding.Object[binding.Property] = translated(binding.English)
end
end
for _, refresh in ipairs(LanguageRefreshers) do
if type(refresh) == "function" then
pcall(refresh)
end
end
if type(Runtime.RefreshVisibleLists) == "function" then
pcall(function() Runtime.RefreshVisibleLists(true) end)
end
end
local collectRarityOptions
local collectShopOptions
local collectMutationOptions
local collectPlayerOptions
do
local Theme = {
Background = Color3.fromRGB(16, 18, 23),
Sidebar = Color3.fromRGB(20, 23, 29),
Surface = Color3.fromRGB(28, 32, 40),
SurfaceHover = Color3.fromRGB(35, 40, 50),
Accent = Color3.fromRGB(110, 168, 255),
AccentDark = Color3.fromRGB(60, 107, 178),
Text = Color3.fromRGB(238, 241, 247),
Muted = Color3.fromRGB(148, 157, 174),
Positive = Color3.fromRGB(75, 210, 139),
Negative = Color3.fromRGB(91, 98, 113),
}
Runtime.Theme = Theme
local function create(className, properties)
local object = Instance.new(className)
for property, value in pairs(properties or {}) do
if property ~= "Parent" then
object[property] = value
end
end
object.Parent = properties and properties.Parent or nil
if (className == "TextLabel" or className == "TextButton" or className == "TextBox")
and properties and type(properties.TextSize) == "number" then
Runtime.TextBaseSizes[object] = properties.TextSize
object.TextSize = math.clamp(math.floor(properties.TextSize * State.TextScale + 0.5), 7, 36)
end
return object
end
Runtime.ApplyTextScale = function()
State.TextScale = math.clamp(tonumber(State.TextScale) or 1, 0.7, 1.6)
for object, baseSize in pairs(Runtime.TextBaseSizes) do
if object and object.Parent then
object.TextSize = math.clamp(math.floor(baseSize * State.TextScale + 0.5), 7, 36)
end
end
if Runtime.TextScaleInput then
Runtime.TextScaleInput.Text = string.format("%d%%", math.floor(State.TextScale * 100 + 0.5))
end
end
local ScreenGui
do
local playerGui = LocalPlayer and (LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:FindFirstChild("PlayerGui"))
local coreGui
pcall(function()
coreGui = game:GetService("CoreGui")
end)
local hui
if type(gethui) == "function" then
pcall(function()
local h = gethui()
if typeof(h) == "Instance" then
hui = h
end
end)
end
local uiParents = {}
if coreGui then table.insert(uiParents, coreGui) end
if hui then table.insert(uiParents, hui) end
if playerGui then table.insert(uiParents, playerGui) end
for _, container in ipairs(uiParents) do
pcall(function()
local existing = container:FindFirstChild("RollAGnomeSimpleUI")
if existing then
existing:Destroy()
end
end)
end
ScreenGui = create("ScreenGui", {
Name = "RollAGnomeSimpleUI",
ResetOnSpawn = false,
IgnoreGuiInset = not Runtime.Mobile,
DisplayOrder = 1000,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
})
for _, container in ipairs(uiParents) do
local ok = pcall(function()
ScreenGui.Parent = container
end)
if ok and ScreenGui.Parent == container then
break
end
end
if not ScreenGui.Parent and playerGui then
pcall(function()
ScreenGui.Parent = playerGui
end)
end
Runtime.ScreenGui = ScreenGui
end
Runtime.Viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
local isMobile = Runtime.Mobile or UserInputService.TouchEnabled
local Window = {
D = isMobile
and Vector2.new(
math.clamp(math.floor(Runtime.Viewport.X * 0.84), 320, 580),
math.clamp(math.floor(Runtime.Viewport.Y * 0.80), 280, 440)
)
or Vector2.new(720, 500),
N = isMobile
and Vector2.new(math.min(280, Runtime.Viewport.X - 16), math.min(250, Runtime.Viewport.Y - 16))
or Vector2.new(520, 360),
C = isMobile and Vector2.new(54, 54) or Vector2.new(64, 64),
H = isMobile and 52 or 64,
B = isMobile and 110 or 156,
}
Window.S = Vector2.new(
math.clamp(tonumber(State.UIWidth) or Window.D.X, Window.N.X, math.max(Window.N.X, Runtime.Viewport.X - 8)),
math.clamp(tonumber(State.UIHeight) or Window.D.Y, Window.N.Y, math.max(Window.N.Y, Runtime.Viewport.Y - 8))
)
State.UIWidth = Window.S.X
State.UIHeight = Window.S.Y
local Main = create("Frame", {
Name = "Main",
Size = UDim2.fromOffset(Window.S.X, Window.S.Y),
Position = UDim2.new(0.5, -Window.S.X / 2, 0.5, -Window.S.Y / 2),
BackgroundColor3 = Theme.Background,
BorderSizePixel = 0,
ClipsDescendants = true,
Parent = ScreenGui,
})
Runtime.Main = Main
local MainCorner = create("UICorner", { CornerRadius = UDim.new(0, 12), Parent = Main })
local MainStroke = create("UIStroke", { Color = Color3.fromRGB(49, 55, 68), Thickness = 1, Parent = Main })
Window.R = create("TextButton", {
Name = "ResizeHandle",
Size = UDim2.fromOffset(Runtime.Mobile and 38 or 24, Runtime.Mobile and 38 or 24),
Position = UDim2.new(1, Runtime.Mobile and -38 or -24, 1, Runtime.Mobile and -38 or -24),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Text = "",
AutoButtonColor = false,
ZIndex = 20,
Parent = Main,
})
for index, length in ipairs({ 7, 11, 15 }) do
local line = create("Frame", {
Size = UDim2.fromOffset(length, 2),
Position = UDim2.new(1, -length - 2, 1, -(index * 4)),
Rotation = -45,
BackgroundColor3 = Theme.Muted,
BorderSizePixel = 0,
ZIndex = 21,
Parent = Window.R,
})
create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = line })
end
Window.L = create("TextLabel", {
Size = UDim2.fromOffset(82, 20),
Position = UDim2.new(1, -108, 1, -25),
BackgroundColor3 = Theme.Surface,
BackgroundTransparency = 0.08,
BorderSizePixel = 0,
Font = Enum.Font.GothamMedium,
Text = string.format("%d x %d", Window.S.X, Window.S.Y),
TextColor3 = Theme.Muted,
TextSize = 9,
Visible = false,
ZIndex = 20,
Parent = Main,
})
create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = Window.L })
local Header = create("Frame", {
Size = UDim2.new(1, 0, 0, Window.H),
BackgroundColor3 = Theme.Sidebar,
BorderSizePixel = 0,
Parent = Main,
})
local TitleLabel = create("TextLabel", {
Size = UDim2.new(0, 300, 0, 27),
Position = UDim2.fromOffset(20, 9),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
Text = "ROLL A GNOME",
TextColor3 = Theme.Text,
TextSize = 17,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = Header,
})
local LiveLabel = create("TextLabel", {
Size = UDim2.new(1, -260, 0, 18),
Position = UDim2.fromOffset(20, 36),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
Text = State.Language == "TH" and decodeText64("4LiB4Liz4Lil4Lix4LiH4LmA4Lij4Li04LmI4Lih4Lij4Liw4Lia4LiaLi4u") or "LIVE | starting...",
TextColor3 = Theme.Positive,
TextSize = 11,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = Header,
})
Runtime.LiveLabel = LiveLabel
local Minimize = create("TextButton", {
Size = UDim2.fromOffset(34, 30),
Position = UDim2.new(1, -90, 0, 17),
BackgroundColor3 = Theme.Surface,
BorderSizePixel = 0,
Font = Enum.Font.GothamBold,
Text = "",
TextColor3 = Theme.Text,
TextSize = 15,
AutoButtonColor = false,
Parent = Header,
})
local MinimizeCorner = create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = Minimize })
local MinimizeStroke = create("UIStroke", {
Color = Color3.fromRGB(49, 55, 68),
Thickness = 1,
Parent = Minimize,
})
local MinimizeIcon = create("Frame", {
Size = UDim2.fromOffset(13, 2),
Position = UDim2.new(0.5, -6, 0.5, 3),
BackgroundColor3 = Theme.Text,
BorderSizePixel = 0,
Parent = Minimize,
})
create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = MinimizeIcon })
local CompactAccent = create("Frame", {
Size = UDim2.fromOffset(28, 3),
Position = UDim2.fromOffset(15, 7),
BackgroundColor3 = Theme.Accent,
BorderSizePixel = 0,
Visible = false,
Parent = Minimize,
})
create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = CompactAccent })
local CompactTitle = create("TextLabel", {
Size = UDim2.fromOffset(64, 28),
Position = UDim2.fromOffset(0, 10),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
Text = "G",
TextColor3 = Theme.Text,
TextSize = 21,
TextXAlignment = Enum.TextXAlignment.Center,
Visible = false,
Parent = Minimize,
})
local CompactSubtitle = create("TextLabel", {
Size = UDim2.fromOffset(64, 12),
Position = UDim2.fromOffset(0, 38),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
Text = "HUB",
TextColor3 = Theme.Muted,
TextSize = 8,
TextXAlignment = Enum.TextXAlignment.Center,
Visible = false,
Parent = Minimize,
})
Runtime.CompactSubtitle = CompactSubtitle
local CompactArrow = create("Frame", {
Size = UDim2.fromOffset(7, 7),
Position = UDim2.fromOffset(51, 44),
BackgroundColor3 = Theme.Positive,
BorderSizePixel = 0,
Visible = false,
Parent = Minimize,
})
create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = CompactArrow })
Runtime.CompactArrow = CompactArrow
local Close = create("TextButton", {
Size = UDim2.fromOffset(34, 30),
Position = UDim2.new(1, -48, 0, 17),
BackgroundColor3 = Theme.Surface,
BorderSizePixel = 0,
Font = Enum.Font.GothamBold,
Text = "",
AutoButtonColor = false,
Parent = Header,
})
create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = Close })
local CloseStroke = create("UIStroke", {
Color = Color3.fromRGB(67, 53, 60),
Thickness = 1,
Parent = Close,
})
local CloseIconA = create("Frame", {
Size = UDim2.fromOffset(13, 2),
Position = UDim2.new(0.5, -6, 0.5, -1),
Rotation = 45,
BackgroundColor3 = Color3.fromRGB(255, 154, 166),
BorderSizePixel = 0,
Parent = Close,
})
local CloseIconB = create("Frame", {
Size = UDim2.fromOffset(13, 2),
Position = UDim2.new(0.5, -6, 0.5, -1),
Rotation = -45,
BackgroundColor3 = Color3.fromRGB(255, 154, 166),
BorderSizePixel = 0,
Parent = Close,
})
create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = CloseIconA })
create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = CloseIconB })
local MasterControl = create("TextButton", {
Size = UDim2.fromOffset(76, 30),
Position = UDim2.new(1, -174, 0, 17),
BackgroundColor3 = Theme.AccentDark,
BorderSizePixel = 0,
Font = Enum.Font.GothamBold,
Text = "PAUSE",
TextColor3 = Theme.Text,
TextSize = 10,
AutoButtonColor = false,
Parent = Header,
})
create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = MasterControl })
local MasterControlStroke = create("UIStroke", {
Color = Theme.Accent,
Transparency = 0.35,
Thickness = 1,
Parent = MasterControl,
})
local LanguageControl = create("TextButton", {
Size = UDim2.fromOffset(44, 30),
Position = UDim2.new(1, -226, 0, 17),
BackgroundColor3 = Theme.Surface,
BorderSizePixel = 0,
Font = Enum.Font.GothamBold,
Text = State.Language,
TextColor3 = Theme.Text,
TextSize = 10,
AutoButtonColor = false,
Parent = Header,
})
create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = LanguageControl })
create("UIStroke", {
Color = Color3.fromRGB(49, 55, 68),
Thickness = 1,
Parent = LanguageControl,
})
local Sidebar = create("Frame", {
Size = UDim2.new(0, Window.B, 1, -Window.H),
Position = UDim2.fromOffset(0, Window.H),
BackgroundColor3 = Theme.Sidebar,
BorderSizePixel = 0,
Parent = Main,
})
local MenuLabel = create("TextLabel", {
Size = UDim2.new(1, -28, 0, 20),
Position = UDim2.fromOffset(14, 12),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
Text = "MENU",
TextColor3 = Theme.Muted,
TextSize = 9,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = Sidebar,
})
local Navigation = create("ScrollingFrame", {
Size = UDim2.new(1, -16, 1, -50),
Position = UDim2.fromOffset(8, 40),
BackgroundTransparency = 1,
BorderSizePixel = 0,
CanvasSize = UDim2.new(),
AutomaticCanvasSize = Enum.AutomaticSize.Y,
ScrollingDirection = Enum.ScrollingDirection.Y,
ScrollBarThickness = Runtime.Mobile and 2 or 0,
ScrollBarImageColor3 = Theme.Accent,
Parent = Sidebar,
})
create("UIListLayout", {
Padding = UDim.new(0, 7),
SortOrder = Enum.SortOrder.LayoutOrder,
Parent = Navigation,
})
local Content = create("Frame", {
Size = UDim2.new(1, -Window.B, 1, -Window.H),
Position = UDim2.fromOffset(Window.B, Window.H),
BackgroundTransparency = 1,
Parent = Main,
})
Runtime.ApplyResponsiveLayout = function()
local narrow = Runtime.Mobile or Window.S.X < 620
local tiny = Window.S.X < 300
local compact = Main.Size.X.Offset == Window.C.X and Main.Size.Y.Offset == Window.C.Y
local signature = (narrow and 1 or 0) + (tiny and 2 or 0) + (compact and 4 or 0)
if Runtime.LayoutSignature == signature then
return
end
Runtime.LayoutSignature = signature
Window.B = narrow and 112 or 156
Sidebar.Size = UDim2.new(0, Window.B, 1, -Window.H)
Sidebar.Position = UDim2.fromOffset(0, Window.H)
Content.Size = UDim2.new(1, -Window.B, 1, -Window.H)
Content.Position = UDim2.fromOffset(Window.B, Window.H)
if not compact then
TitleLabel.Position = UDim2.fromOffset(narrow and 12 or 20, 9)
TitleLabel.Size = UDim2.new(0, tiny and 34 or narrow and 104 or 300, 0, 27)
TitleLabel.Text = tiny and "G" or narrow and "GNOME" or "ROLL A GNOME"
LiveLabel.Position = UDim2.fromOffset(20, 36)
LiveLabel.Size = UDim2.new(1, -260, 0, 18)
LanguageControl.Size = UDim2.fromOffset(narrow and 38 or 44, 30)
LanguageControl.Position = UDim2.new(1, narrow and -186 or -226, 0, narrow and 13 or 17)
MasterControl.Size = UDim2.fromOffset(narrow and 64 or 76, 30)
MasterControl.Position = UDim2.new(1, narrow and -144 or -174, 0, narrow and 13 or 17)
Minimize.Size = UDim2.fromOffset(narrow and 32 or 34, 30)
Minimize.Position = UDim2.new(1, narrow and -76 or -90, 0, narrow and 13 or 17)
Close.Size = UDim2.fromOffset(narrow and 32 or 34, 30)
Close.Position = UDim2.new(1, narrow and -40 or -48, 0, narrow and 13 or 17)
end
LiveLabel.Visible = not compact and not narrow
MenuLabel.Visible = not narrow
Navigation.Position = UDim2.fromOffset(8, narrow and 10 or 40)
Navigation.Size = UDim2.new(1, -16, 1, narrow and -20 or -50)
end
Runtime.ApplyResponsiveLayout()
Runtime.SaveGraphicsProperty = function(object, property, value)
if not object then
return
end
local saved = Runtime.GraphicsOriginal[object]
if not saved then
saved = {}
Runtime.GraphicsOriginal[object] = saved
end
if saved[property] == nil then
local ok, original = pcall(function()
return object[property]
end)
if not ok then
return
end
saved[property] = { original }
end
pcall(function()
object[property] = value
end)
end
Runtime.ApplyPotatoInstance = function(object)
if object:IsA("BasePart") then
Runtime.SaveGraphicsProperty(object, "CastShadow", false)
Runtime.SaveGraphicsProperty(object, "Reflectance", 0)
Runtime.SaveGraphicsProperty(object, "Material", Enum.Material.Plastic)
if object:IsA("MeshPart") then
Runtime.SaveGraphicsProperty(object, "RenderFidelity", Enum.RenderFidelity.Performance)
Runtime.SaveGraphicsProperty(object, "TextureID", "")
end
elseif object:IsA("SpecialMesh") then
Runtime.SaveGraphicsProperty(object, "TextureId", "")
elseif object:IsA("SurfaceAppearance") then
Runtime.SaveGraphicsProperty(object, "ColorMap", "")
Runtime.SaveGraphicsProperty(object, "MetalnessMap", "")
Runtime.SaveGraphicsProperty(object, "NormalMap", "")
Runtime.SaveGraphicsProperty(object, "RoughnessMap", "")
elseif object:IsA("Decal") or object:IsA("Texture") then
Runtime.SaveGraphicsProperty(object, "Transparency", 1)
elseif object:IsA("ParticleEmitter") or object:IsA("Trail") or object:IsA("Beam")
or object:IsA("Smoke") or object:IsA("Fire") or object:IsA("Sparkles")
or object:IsA("PostEffect") then
Runtime.SaveGraphicsProperty(object, "Enabled", false)
elseif object:IsA("Atmosphere") then
Runtime.SaveGraphicsProperty(object, "Density", 0)
Runtime.SaveGraphicsProperty(object, "Haze", 0)
Runtime.SaveGraphicsProperty(object, "Glare", 0)
end
end
Runtime.RestorePotatoObjects = function(generation, yielding)
local processed = 0
for object, properties in pairs(Runtime.GraphicsOriginal) do
if Runtime.PotatoGeneration ~= generation or Runtime.PotatoApplied then
return
end
if object then
for property, original in pairs(properties) do
pcall(function()
object[property] = original[1]
end)
end
end
processed = processed + 1
if yielding and processed % 150 == 0 then
task.wait()
end
end
if Runtime.PotatoGeneration == generation and not Runtime.PotatoApplied then
table.clear(Runtime.GraphicsOriginal)
end
end
Runtime.ApplyPotatoGraphics = function(enabled)
if Runtime.PotatoApplied == enabled and not (not enabled and Runtime.ForceGraphicsRestore) then
return
end
Runtime.PotatoApplied = enabled
Runtime.PotatoGeneration = (Runtime.PotatoGeneration or 0) + 1
local generation = Runtime.PotatoGeneration
if enabled then
Runtime.SaveGraphicsProperty(game:GetService("Lighting"), "GlobalShadows", false)
Runtime.SaveGraphicsProperty(game:GetService("Lighting"), "FogEnd", 1000000)
Runtime.SaveGraphicsProperty(workspace.Terrain, "WaterWaveSize", 0)
Runtime.SaveGraphicsProperty(workspace.Terrain, "WaterWaveSpeed", 0)
Runtime.SaveGraphicsProperty(workspace.Terrain, "WaterReflectance", 0)
Runtime.SaveGraphicsProperty(workspace.Terrain, "Decoration", false)
if Runtime.OriginalQuality == nil then
pcall(function()
Runtime.OriginalQuality = settings().Rendering.QualityLevel
end)
end
pcall(function()
settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end)
task.spawn(function()
local processed = 0
for _, root in ipairs({ workspace, game:GetService("Lighting") }) do
for _, object in ipairs(root:GetDescendants()) do
if Runtime.PotatoGeneration ~= generation or not Runtime.PotatoApplied then
return
end
Runtime.ApplyPotatoInstance(object)
processed = processed + 1
if processed % 150 == 0 then
task.wait()
end
end
end
end)
else
if Runtime.ForceGraphicsRestore then
Runtime.RestorePotatoObjects(generation, false)
else
task.spawn(Runtime.RestorePotatoObjects, generation, true)
end
if Runtime.OriginalQuality ~= nil then
pcall(function()
settings().Rendering.QualityLevel = Runtime.OriginalQuality
end)
Runtime.OriginalQuality = nil
end
end
end
Runtime.SleepOverlay = create("TextButton", {
Name = "ScreenSleep",
Size = UDim2.fromScale(1, 1),
BackgroundColor3 = Color3.new(0, 0, 0),
BorderSizePixel = 0,
Font = Enum.Font.GothamBold,
Text = translated("TAP TO WAKE\nAutomation continues in low-power mode"),
TextColor3 = Color3.fromRGB(185, 195, 210),
TextSize = 18,
AutoButtonColor = false,
Visible = false,
ZIndex = 1000,
Parent = ScreenGui,
})
bindLanguage(Runtime.SleepOverlay, "Text", "TAP TO WAKE\nAutomation continues in low-power mode")
Runtime.SetScreenSleep = function(enabled)
if Runtime.ScreenSleeping == enabled then
return
end
Runtime.ScreenSleeping = enabled
if enabled then
Runtime.MainWasVisible = Main.Visible
Runtime.SleepOverlay.Visible = true
Main.Visible = false
pcall(function()
game:GetService("RunService"):Set3dRenderingEnabled(false)
end)
if type(getfpscap) == "function" then
pcall(function()
Runtime.OriginalFpsCap = getfpscap()
end)
end
if type(setfpscap) == "function" then
pcall(function() setfpscap(10) end)
end
else
pcall(function()
game:GetService("RunService"):Set3dRenderingEnabled(true)
end)
if type(setfpscap) == "function" then
pcall(function() setfpscap(Runtime.OriginalFpsCap or 60) end)
end
Runtime.SleepOverlay.Visible = false
Main.Visible = Runtime.MainWasVisible ~= false
end
end
Runtime.OnToggleChanged = function(key, enabled)
if key == "PotatoGraphics" then
Runtime.ApplyPotatoGraphics(enabled)
elseif key == "LowPingMode" and not enabled then
table.clear(Runtime.LastRemoteAt)
elseif key == "AutoBest30" and Runtime.RefreshGnomePolicyUI then
Runtime.RefreshGnomePolicyUI()
end
end
local pages = {}
local navButtons = {}
local navIndicators = {}
local selectedPage
local function showPage(name)
selectedPage = name
for pageName, page in pairs(pages) do
page.Visible = pageName == name
end
for pageName, button in pairs(navButtons) do
button.BackgroundColor3 = pageName == name and Theme.AccentDark or Theme.Surface
button.TextColor3 = pageName == name and Theme.Text or Theme.Muted
navIndicators[pageName].Visible = pageName == name
end
if Runtime.RefreshVisibleLists then
task.defer(Runtime.RefreshVisibleLists, false)
end
end
local function addPage(name)
local button = create("TextButton", {
Name = name,
Size = UDim2.new(1, 0, 0, 42),
BackgroundColor3 = Theme.Surface,
BorderSizePixel = 0,
Font = Enum.Font.GothamMedium,
Text = translated(name),
TextColor3 = Theme.Muted,
TextSize = 13,
TextXAlignment = Enum.TextXAlignment.Left,
AutoButtonColor = false,
Parent = Navigation,
})
bindLanguage(button, "Text", name)
create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = button })
create("UIPadding", { PaddingLeft = UDim.new(0, 17), Parent = button })
local indicator = create("Frame", {
Size = UDim2.fromOffset(3, 20),
Position = UDim2.new(0, -11, 0.5, -10),
BackgroundColor3 = Theme.Accent,
BorderSizePixel = 0,
Visible = false,
Parent = button,
})
create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = indicator })
local page = create("ScrollingFrame", {
Name = name,
Size = UDim2.new(1, -36, 1, -24),
Position = UDim2.fromOffset(18, 12),
BackgroundTransparency = 1,
BorderSizePixel = 0,
ScrollBarThickness = Runtime.Mobile and 3 or 4,
ScrollBarImageColor3 = Theme.Accent,
CanvasSize = UDim2.new(),
AutomaticCanvasSize = Enum.AutomaticSize.Y,
ElasticBehavior = (Enum and Enum.ElasticBehavior and Enum.ElasticBehavior.WhenScrollable) or nil,
ScrollingDirection = Enum.ScrollingDirection.Y,
Visible = false,
Parent = Content,
})
create("UIListLayout", {
Padding = UDim.new(0, 12),
SortOrder = Enum.SortOrder.LayoutOrder,
Parent = page,
})
create("UIPadding", {
PaddingTop = UDim.new(0, 4),
PaddingBottom = UDim.new(0, 28),
Parent = page,
})
navButtons[name] = button
navIndicators[name] = indicator
pages[name] = page
connect(button.Activated, function()
showPage(name)
end)
connect(button.MouseEnter, function()
if selectedPage ~= name then
button.BackgroundColor3 = Theme.SurfaceHover
end
end)
connect(button.MouseLeave, function()
if selectedPage ~= name then
button.BackgroundColor3 = Theme.Surface
end
end)
return page
end
local GnomesPage = addPage("Gnomes")
local FarmPage = addPage("Farm")
local UpgradePage = addPage("Upgrade")
local SocialPage = addPage("Social")
local SystemPage = addPage("System")
local ShopPage = FarmPage
local ConfigPage = SystemPage
local function addGroupLabel(parent, title)
local row = create("Frame", {
Size = UDim2.new(1, 0, 0, 36),
BackgroundTransparency = 1,
Parent = parent,
})
local label = create("TextLabel", {
Size = UDim2.new(0, 210, 1, 0),
Position = UDim2.fromOffset(2, 0),
BackgroundTransparency = 1,
Font = Enum.Font.GothamBold,
Text = translated(title),
TextColor3 = Theme.Accent,
TextSize = 11,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = row,
})
bindLanguage(label, "Text", title)
local line = create("Frame", {
Size = UDim2.new(1, -220, 0, 1),
Position = UDim2.new(0, 220, 0.5, 0),
BackgroundColor3 = Color3.fromRGB(45, 52, 65),
BorderSizePixel = 0,
Parent = row,
})
return row
end
local toggleRefreshers = {}
Runtime.ToggleRefreshers = toggleRefreshers
local function addToggle(parent, title, description, key)
local row = create("Frame", {
Size = UDim2.new(1, 0, 0, 64),
BackgroundColor3 = Theme.Surface,
BorderSizePixel = 0,
Parent = parent,
})
create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = row })
local titleLabel = create("TextLabel", {
Size = UDim2.new(1, -84, 0, 22),
Position = UDim2.fromOffset(16, 11),
BackgroundTransparency = 1,
Font = Enum.Font.GothamMedium,
Text = translated(title),
TextColor3 = Theme.Text,
TextSize = 13,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = row,
})
bindLanguage(titleLabel, "Text", title)
local descriptionLabel = create("TextLabel", {
Size = UDim2.new(1, -84, 0, 18),
Position = UDim2.fromOffset(16, 34),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
Text = translated(description),
TextColor3 = Theme.Muted,
TextSize = 11,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
Parent = row,
})
bindLanguage(descriptionLabel, "Text", description)
local switch = create("TextButton", {
Size = UDim2.fromOffset(48, 26),
Position = UDim2.new(1, -64, 0.5, -13),
BorderSizePixel = 0,
Text = "",
AutoButtonColor = false,
Parent = row,
})
create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = switch })
local knob = create("Frame", {
Size = UDim2.fromOffset(20, 20),
BorderSizePixel = 0,
BackgroundColor3 = Theme.Text,
Parent = switch,
})
create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = knob })
local function refresh()
local enabled = State[key] == true
switch.BackgroundColor3 = enabled and Theme.Accent or Theme.Negative
knob.Position = enabled and UDim2.fromOffset(25, 3) or UDim2.fromOffset(3, 3)
end
toggleRefreshers[key] = refresh
connect(switch.Activated, function()
if Runtime.Paused and MasterAutomationKeySet[key] then
return
end
State[key] = not State[key]
Runtime.NormalizeAutomation(key)
for otherKey, otherRefresh in pairs(toggleRefreshers) do
if otherKey ~= key then
if type(otherRefresh) == "function" then pcall(otherRefresh) end
end
end
refresh()
if MasterAutomationKeySet[key] and State.AutomationStrategy ~= "Custom" then
State.AutomationStrategy = "Custom"
if type(Runtime.RefreshStrategyUI) == "function" then
pcall(Runtime.RefreshStrategyUI)
end
end
Runtime.OnToggleChanged(key, State[key])
end)
refresh()
return row
end
local function addSection(parent, title, detail)
local box = create("Frame", {
Size = UDim2.new(1, 0, 0, 248),
BackgroundColor3 = Theme.Surface,
BorderSizePixel = 0,
Parent = parent,
})
create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = box })
local sectionTitle = create("TextLabel", {
Size = UDim2.new(1, -160, 0, 22),
Position = UDim2.fromOffset(16, 12),
BackgroundTransparency = 1,
Font = Enum.Font.GothamMedium,
Text = translated(title),
TextColor3 = Theme.Text,
TextSize = 13,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = box,
})
bindLanguage(sectionTitle, "Text", title)
local subtitle = create("TextLabel", {
Size = UDim2.new(1, -160, 0, 16),
Position = UDim2.fromOffset(16, 33),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
Text = translated(detail),
TextColor3 = Theme.Muted,
TextSize = 10,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = box,
})
bindLanguage(subtitle, "Text", detail)
return box, subtitle
end
local listRenderers = {}
local function addMultiSelect(parent, title, detail, selection, optionProvider, preserveOrder)
local box, subtitle = addSection(parent, title, detail)
local actionRow = create("Frame", {
Size = UDim2.fromOffset(150, 28),
Position = UDim2.new(1, -166, 0, 16),
BackgroundTransparency = 1,
Parent = box,
})
create("UIListLayout", {
FillDirection = Enum.FillDirection.Horizontal,
HorizontalAlignment = Enum.HorizontalAlignment.Right,
Padding = UDim.new(0, 6),
Parent = actionRow,
})
local selectAllBtn = create("TextButton", {
Size = UDim2.fromOffset(76, 26),
BackgroundColor3 = Theme.SurfaceHover,
BorderSizePixel = 0,
Font = Enum.Font.GothamMedium,
Text = translated("Select All"),
TextColor3 = Theme.Accent,
TextSize = 11,
AutoButtonColor = false,
Parent = actionRow,
})
create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = selectAllBtn })
bindLanguage(selectAllBtn, "Text", "Select All")
local clearAllBtn = create("TextButton", {
Size = UDim2.fromOffset(60, 26),
BackgroundColor3 = Theme.SurfaceHover,
BorderSizePixel = 0,
Font = Enum.Font.GothamMedium,
Text = translated("Clear"),
TextColor3 = Color3.fromRGB(255, 130, 140),
TextSize = 11,
AutoButtonColor = false,
Parent = actionRow,
})
create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = clearAllBtn })
bindLanguage(clearAllBtn, "Text", "Clear")
local search = create("TextBox", {
Size = UDim2.new(1, -32, 0, 32),
Position = UDim2.fromOffset(16, 56),
BackgroundColor3 = Theme.Background,
BorderSizePixel = 0,
ClearTextOnFocus = false,
Font = Enum.Font.Gotham,
PlaceholderText = translated("Search..."),
PlaceholderColor3 = Theme.Muted,
Text = "",
TextColor3 = Theme.Text,
TextSize = 11,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = box,
})
bindLanguage(search, "PlaceholderText", "Search...")
create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = search })
create("UIPadding", { PaddingLeft = UDim.new(0, 12), Parent = search })
local list = create("ScrollingFrame", {
Size = UDim2.new(1, -32, 0, 140),
Position = UDim2.fromOffset(16, 96),
BackgroundTransparency = 1,
BorderSizePixel = 0,
ScrollBarThickness = 4,
ScrollBarImageColor3 = Theme.Accent,
CanvasSize = UDim2.new(),
AutomaticCanvasSize = Enum.AutomaticSize.Y,
Parent = box,
})
create("UIListLayout", {
Padding = UDim.new(0, 6),
SortOrder = Enum.SortOrder.LayoutOrder,
Parent = list,
})
local optionButtons = {}
local currentOptionsList = {}
local function updateSubtitles(visibleCount)
local selectedCount = 0
for _, enabled in pairs(selection) do
if enabled == true then
selectedCount = selectedCount + 1
end
end
if State.Language == "TH" then
subtitle.Text = string.format(decodeText64("JXMgIHwgIOC5gOC4peC4t+C4reC4gSAlZCAgfCAg4LmB4Liq4LiU4LiHICVk"), translated(detail), selectedCount, visibleCount or #currentOptionsList)
else
subtitle.Text = string.format("%s  |  selected %d  |  showing %d", translated(detail), selectedCount, visibleCount or #currentOptionsList)
end
end
local function updateButtonVisuals()
for option, btn in pairs(optionButtons) do
if btn and btn.Parent then
local selected = isSelected(selection, option)
btn.BackgroundColor3 = selected and Theme.AccentDark or Theme.Background
btn.TextColor3 = selected and Theme.Text or Theme.Muted
btn.Text = (selected and "  [✓]  " or "  [  ]  ") .. tostring(option)
end
end
updateSubtitles()
end
connect(selectAllBtn.Activated, function()
local options = optionProvider()
for _, opt in ipairs(options) do
selection[opt] = true
end
Runtime.SelectionVersion = Runtime.SelectionVersion + 1
updateButtonVisuals()
end)
connect(clearAllBtn.Activated, function()
table.clear(selection)
Runtime.SelectionVersion = Runtime.SelectionVersion + 1
updateButtonVisuals()
end)
local previousFilter = nil
local previousOptionsSignature = ""
local function render(force)
if not parent.Visible then
return
end
local options = optionProvider()
if not preserveOrder then
table.sort(options, function(a, b)
return string.lower(a) < string.lower(b)
end)
end
currentOptionsList = options
local optionsSig = table.concat(options, "\0")
local filter = string.lower(search.Text)
if not force and optionsSig == previousOptionsSignature and filter == previousFilter then
updateButtonVisuals()
return
end
previousOptionsSignature = optionsSig
previousFilter = filter
for _, child in ipairs(list:GetChildren()) do
if child:IsA("GuiButton") then
child:Destroy()
end
end
table.clear(optionButtons)
local visibleCount = 0
for _, option in ipairs(options) do
if filter == "" or string.find(string.lower(option), filter, 1, true) then
visibleCount = visibleCount + 1
local selected = isSelected(selection, option)
local choice = create("TextButton", {
Name = tostring(option),
Size = UDim2.new(1, -6, 0, 30),
LayoutOrder = visibleCount,
BackgroundColor3 = selected and Theme.AccentDark or Theme.Background,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
Text = (selected and "  [✓]  " or "  [  ]  ") .. tostring(option),
TextColor3 = selected and Theme.Text or Theme.Muted,
TextSize = 11,
TextXAlignment = Enum.TextXAlignment.Left,
AutoButtonColor = false,
Parent = list,
})
create("UICorner", { CornerRadius = UDim.new(0, 6), Parent = choice })
optionButtons[option] = choice
connect(choice.Activated, function()
Runtime.ToggleSelection(selection, option)
local nowSelected = isSelected(selection, option)
choice.BackgroundColor3 = nowSelected and Theme.AccentDark or Theme.Background
choice.TextColor3 = nowSelected and Theme.Text or Theme.Muted
choice.Text = (nowSelected and "  [✓]  " or "  [  ]  ") .. tostring(option)
updateSubtitles(visibleCount)
end)
end
end
updateSubtitles(visibleCount)
end
connect(search:GetPropertyChangedSignal("Text"), function()
render(true)
end)
table.insert(listRenderers, render)
table.insert(LanguageRefreshers, function()
previousOptionsSignature = ""
previousFilter = nil
render(false)
end)
render(false)
return box
end
Runtime.RefreshVisibleLists = function(force)
for _, render in ipairs(listRenderers) do
if type(render) == "function" then pcall(function() render(force == true) end) end
end
end
addGroupLabel(GnomesPage, "Strategy & Modes")
do
local function addStrategyPresetsControl(parent)
local row = create("Frame", {
Size = UDim2.new(1, 0, 0, 96),
BackgroundColor3 = Theme.Surface,
BorderSizePixel = 0,
Parent = parent,
})
create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = row })
local title = create("TextLabel", {
Size = UDim2.new(1, -32, 0, 22),
Position = UDim2.fromOffset(16, 12),
BackgroundTransparency = 1,
Font = Enum.Font.GothamMedium,
Text = translated("Automation Strategy"),
TextColor3 = Theme.Text,
TextSize = 13,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = row,
})
bindLanguage(title, "Text", "Automation Strategy")
local detail = create("TextLabel", {
Size = UDim2.new(1, -32, 0, 18),
Position = UDim2.fromOffset(16, 33),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
Text = translated("Choose how the automation prioritizes progression vs money vs hunting"),
TextColor3 = Theme.Muted,
TextSize = 11,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = row,
})
bindLanguage(detail, "Text", "Choose how the automation prioritizes progression vs money vs hunting")
local btnBar = create("Frame", {
Size = UDim2.new(1, -32, 0, 32),
Position = UDim2.fromOffset(16, 54),
BackgroundTransparency = 1,
Parent = row,
})
create("UIGridLayout", {
CellSize = UDim2.new(0.19, -2, 1, 0),
CellPadding = UDim2.new(0.012, 0, 0, 0),
SortOrder = Enum.SortOrder.LayoutOrder,
Parent = btnBar,
})
local strategyButtons = {}
local options = {
{ Key = "Balanced", Label = "Balanced" },
{ Key = "MaxProgression", Label = "Rebirth Rush" },
{ Key = "GnomeHunter", Label = "Gnome Hunter" },
{ Key = "MoneyMachine", Label = "Money Machine" },
{ Key = "Custom", Label = "Custom" },
}
for idx, opt in ipairs(options) do
local btn = create("TextButton", {
Name = opt.Key,
LayoutOrder = idx,
BackgroundColor3 = Theme.Background,
BorderSizePixel = 0,
Font = Enum.Font.GothamMedium,
Text = translated(opt.Label),
TextColor3 = Theme.Muted,
TextSize = 10,
AutoButtonColor = false,
Parent = btnBar,
})
create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = btn })
bindLanguage(btn, "Text", opt.Label)
strategyButtons[opt.Key] = btn
connect(btn.Activated, function()
Runtime.ApplyStrategyPreset(opt.Key)
for k, b in pairs(strategyButtons) do
local sel = State.AutomationStrategy == k
b.BackgroundColor3 = sel and Theme.AccentDark or Theme.Background
b.TextColor3 = sel and Theme.Text or Theme.Muted
end
end)
end
local function refreshStrategyUI()
for k, b in pairs(strategyButtons) do
local sel = State.AutomationStrategy == k
b.BackgroundColor3 = sel and Theme.AccentDark or Theme.Background
b.TextColor3 = sel and Theme.Text or Theme.Muted
end
end
Runtime.RefreshStrategyUI = refreshStrategyUI
table.insert(LanguageRefreshers, refreshStrategyUI)
refreshStrategyUI()
end
addStrategyPresetsControl(GnomesPage)
end
addGroupLabel(GnomesPage, "Auto Roll")
addToggle(GnomesPage, "Auto Roll", "Roll continuously and wait for every result", "AutoRoll")
addToggle(GnomesPage, "Auto Buy Rolled Gnomes", "Buy rolled gnomes that match your selected rarity, mutation, or rebirth targets", "AutoBuyTarget")
addToggle(GnomesPage, "Pause Roll Until Affordable", "Hold a wanted result until enough money is available to buy it", "PauseRollUntilAffordable")
do
local function addRollPriorityControl(parent)
local RollPriorityRow = create("Frame", {
Size = UDim2.new(1, 0, 0, 96),
BackgroundColor3 = Theme.Surface,
BorderSizePixel = 0,
Parent = parent,
})
create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = RollPriorityRow })
local RollPriorityTitle = create("TextLabel", {
Size = UDim2.new(1, -32, 0, 22),
Position = UDim2.fromOffset(16, 12),
BackgroundTransparency = 1,
Font = Enum.Font.GothamMedium,
Text = translated("Roll vs Rebirth Priority"),
TextColor3 = Theme.Text,
TextSize = 13,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = RollPriorityRow,
})
bindLanguage(RollPriorityTitle, "Text", "Roll vs Rebirth Priority")
local RollPriorityDetail = create("TextLabel", {
Size = UDim2.new(1, -32, 0, 18),
Position = UDim2.fromOffset(16, 33),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
Text = translated("Choose what wins when a wanted roll appears before rebirth"),
TextColor3 = Theme.Muted,
TextSize = 11,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = RollPriorityRow,
})
bindLanguage(RollPriorityDetail, "Text", "Choose what wins when a wanted roll appears before rebirth")
local RollPriorityBar = create("Frame", {
Size = UDim2.new(1, -32, 0, 32),
Position = UDim2.fromOffset(16, 54),
BackgroundTransparency = 1,
Parent = RollPriorityRow,
})
create("UIListLayout", {
FillDirection = Enum.FillDirection.Horizontal,
HorizontalAlignment = Enum.HorizontalAlignment.Center,
Padding = UDim.new(0, 5),
Parent = RollPriorityBar,
})
local RollPriorityButtons = {}
for _, option in ipairs({
{ Key = "TargetFirst", Label = "Target First" },
{ Key = "RebirthFirst", Label = "Rebirth First" },
}) do
local button = create("TextButton", {
Size = UDim2.new(0.5, -3, 1, 0),
BackgroundColor3 = Theme.Background,
BorderSizePixel = 0,
Font = Enum.Font.GothamMedium,
Text = translated(option.Label),
TextColor3 = Theme.Muted,
TextSize = 11,
AutoButtonColor = false,
Parent = RollPriorityBar,
})
create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = button })
bindLanguage(button, "Text", option.Label)
RollPriorityButtons[option.Key] = button
connect(button.Activated, function()
State.RollPriority = option.Key
if option.Key == "RebirthFirst" then
Runtime.PendingPurchase = nil
Runtime.WaitingForMoney = false
Runtime.PendingPurchasePrice = 0
end
for key, target in pairs(RollPriorityButtons) do
local selected = State.RollPriority == key
target.BackgroundColor3 = selected and Theme.AccentDark or Theme.Background
target.TextColor3 = selected and Theme.Text or Theme.Muted
end
end)
end
local function refreshRollPriorityUI()
for key, button in pairs(RollPriorityButtons) do
local selected = State.RollPriority == key
button.BackgroundColor3 = selected and Theme.AccentDark or Theme.Background
button.TextColor3 = selected and Theme.Text or Theme.Muted
end
end
Runtime.RefreshRollPriorityUI = refreshRollPriorityUI
table.insert(LanguageRefreshers, refreshRollPriorityUI)
refreshRollPriorityUI()
end
addRollPriorityControl(GnomesPage)
end
addGroupLabel(GnomesPage, "Auto Best Gnomes")
local BestGnomeCard = create("Frame", {
Size = UDim2.new(1, 0, 0, 64),
BackgroundColor3 = Theme.Surface,
BorderSizePixel = 0,
Parent = GnomesPage,
})
create("UICorner", { CornerRadius = UDim.new(0, 10), Parent = BestGnomeCard })
local bestTitle = create("TextLabel", {
Size = UDim2.new(1, -140, 0, 22),
Position = UDim2.fromOffset(16, 11),
BackgroundTransparency = 1,
Font = Enum.Font.GothamMedium,
Text = translated("Auto Manage Best Gnomes"),
TextColor3 = Theme.Text,
TextSize = 13,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = BestGnomeCard,
})
bindLanguage(bestTitle, "Text", "Auto Manage Best Gnomes")
local bestDesc = create("TextLabel", {
Size = UDim2.new(1, -140, 0, 18),
Position = UDim2.fromOffset(16, 34),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
Text = translated("Protect and place the strongest gnomes using the selected limit"),
TextColor3 = Theme.Muted,
TextSize = 11,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
Parent = BestGnomeCard,
})
bindLanguage(bestDesc, "Text", "Protect and place the strongest gnomes using the selected limit")
local BestLimitInput = create("TextBox", {
Size = UDim2.fromOffset(50, 28),
Position = UDim2.new(1, -124, 0.5, -14),
BackgroundColor3 = Theme.Background,
BorderSizePixel = 0,
ClearTextOnFocus = false,
Font = Enum.Font.GothamBold,
PlaceholderText = "30",
PlaceholderColor3 = Theme.Muted,
Text = tostring(math.clamp(math.floor(tonumber(State.BestGnomeLimit) or 30), 1, 100)),
TextColor3 = Theme.Text,
TextSize = 12,
TextXAlignment = Enum.TextXAlignment.Center,
Parent = BestGnomeCard,
})
create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = BestLimitInput })
create("UIStroke", { Color = Color3.fromRGB(49, 55, 68), Thickness = 1, Parent = BestLimitInput })
connect(BestLimitInput.FocusLost, function()
local value = math.clamp(math.floor(tonumber(BestLimitInput.Text) or tonumber(State.BestGnomeLimit) or 30), 1, 100)
State.BestGnomeLimit = value
BestLimitInput.Text = tostring(value)
end)
local bestSwitch = create("TextButton", {
Size = UDim2.fromOffset(48, 26),
Position = UDim2.new(1, -64, 0.5, -13),
BorderSizePixel = 0,
Text = "",
AutoButtonColor = false,
Parent = BestGnomeCard,
})
create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = bestSwitch })
local bestKnob = create("Frame", {
Size = UDim2.fromOffset(20, 20),
BorderSizePixel = 0,
BackgroundColor3 = Theme.Text,
Parent = bestSwitch,
})
create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = bestKnob })
local function refreshBestToggle()
local enabled = State.AutoBest30 == true
bestSwitch.BackgroundColor3 = enabled and Theme.Accent or Theme.Negative
bestKnob.Position = enabled and UDim2.fromOffset(25, 3) or UDim2.fromOffset(3, 3)
end
toggleRefreshers["AutoBest30"] = refreshBestToggle
refreshBestToggle()
connect(bestSwitch.Activated, function()
if Runtime.Paused and MasterAutomationKeySet["AutoBest30"] then
return
end
State.AutoBest30 = not State.AutoBest30
Runtime.NormalizeAutomation("AutoBest30")
for otherKey, otherRefresh in pairs(toggleRefreshers) do
if otherKey ~= "AutoBest30" then
if type(otherRefresh) == "function" then pcall(otherRefresh) end
end
end
refreshBestToggle()
Runtime.OnToggleChanged("AutoBest30", State.AutoBest30)
end)
addGroupLabel(FarmPage, "Auto Collect")
addToggle(FarmPage, "Auto Collect", "Teleport to every ready crop, collect it, then return", "AutoCollect")
addToggle(FarmPage, "Auto Sell Produce", "Sell only collected produce matching the selected mutations", "AutoSellProduce")
local RarityOrder = {
Common = 1,
Uncommon = 2,
Rare = 3,
Epic = 4,
Legendary = 5,
Mythic = 6,
Godly = 7,
IMPOSSIBLE = 8,
}
collectRarityOptions = function()
if Runtime.RarityOptions then
return Runtime.RarityOptions
end
local unique = {}
for _, config in pairs(FarmersConfig) do
if type(config) == "table" and type(config.real_rarity) == "string" then
unique[config.real_rarity] = true
end
end
local result = {}
for rarity in pairs(unique) do
table.insert(result, rarity)
end
table.sort(result, function(a, b)
local orderA = RarityOrder[a] or 999
local orderB = RarityOrder[b] or 999
if orderA ~= orderB then
return orderA > orderB
end
return string.lower(a) < string.lower(b)
end)
Runtime.RarityOptions = result
return result
end
collectShopOptions = function()
if Runtime.ShopOptions then
return Runtime.ShopOptions
end
local result = {}
for name, data in pairs(ItemShop.Items or {}) do
if type(data) == "table" and not data.ignore then
table.insert(result, tostring(name))
end
end
table.sort(result, function(a, b)
local dataA = ItemShop.Items[a] or {}
local dataB = ItemShop.Items[b] or {}
local orderA = tonumber(dataA.order) or tonumber(dataA.price) or 0
local orderB = tonumber(dataB.order) or tonumber(dataB.price) or 0
if orderA ~= orderB then
return orderA > orderB
end
return string.lower(a) < string.lower(b)
end)
Runtime.ShopOptions = result
return result
end
collectMutationOptions = function()
local cached = Runtime.MutationOptionsCache
if cached and cached.Until > os.clock() then
return cached.Records
end
local unique = {
Normal = true,
Golden = true,
Diamond = true,
Shiny = true,
Fire = true,
Night = true,
Toxic = true,
Charged = true,
Frozen = true,
Cursed = true,
}
local latestIndex = getConfig("Index", IndexConfig)
for key, value in pairs(latestIndex.MUTATIONS or {}) do
if type(value) == "string" and value ~= "" then
unique[value] = true
elseif type(key) == "string" and value then
unique[key] = true
end
end
local mutationLabels = ReplicatedStorage:FindFirstChild("Assets")
mutationLabels = mutationLabels and mutationLabels:FindFirstChild("Billboards")
mutationLabels = mutationLabels and mutationLabels:FindFirstChild("MutationLabels")
if mutationLabels then
for _, label in ipairs(mutationLabels:GetChildren()) do
if label:IsA("GuiObject") then
local name = string.gsub(label.Name, "Icon$", "")
if name ~= "" and name ~= "Plus" then
unique[name] = true
end
end
end
end
local plot = getPlot()
local rng = plot and plot:FindFirstChild("RNG")
local preview = rng and rng:FindFirstChild("Preview")
local workers = plot and plot:FindFirstChild("Workers")
local backpack = LocalPlayer:FindFirstChild("Backpack")
local character = LocalPlayer.Character
for _, container in ipairs({ preview, workers, backpack, character }) do
if container then
for _, item in ipairs(container:GetChildren()) do
local mutations = item:GetAttribute("Mutations") or ""
for _, mutation in ipairs(string.split(tostring(mutations), "_")) do
if mutation ~= "" then
unique[mutation] = true
end
end
end
end
end
local result = {}
for name in pairs(unique) do
table.insert(result, name)
end
local priority = {
Shiny = 3,
Diamond = 2,
Cursed = 2,
Toxic = 1.85,
Golden = 1.5,
Fire = 1.5,
Night = 1.5,
Frozen = 1.5,
Charged = 1.25,
Normal = 0,
}
table.sort(result, function(a, b)
local scoreA = priority[a] or 1
local scoreB = priority[b] or 1
if scoreA ~= scoreB then
return scoreA > scoreB
end
return string.lower(a) < string.lower(b)
end)
Runtime.MutationOptionsCache = { Until = os.clock() + 3, Records = result }
return result
end
collectPlayerOptions = function()
local result = {}
for _, player in ipairs(Players:GetPlayers()) do
if player ~= LocalPlayer then
table.insert(result, player.Name)
end
end
return result
end
addGroupLabel(GnomesPage, "Targets & Protection")
addMultiSelect(GnomesPage, "Buy Rarity Targets", "Select rarity levels to buy automatically", State.BuyRarityTargets, collectRarityOptions, true)
addMultiSelect(GnomesPage, "Buy Mutation Targets", "Select mutations to buy automatically", State.MutationTargets, collectMutationOptions, true)
addMultiSelect(GnomesPage, "Keep Rarity Targets", "Gnomes with these rarities will always be protected and kept in inventory", State.KeepRarityTargets, collectRarityOptions, true)
addMultiSelect(GnomesPage, "Keep Mutation Targets", "Gnomes with these mutations will always be protected and kept in inventory", State.KeepMutationTargets, collectMutationOptions, true)
addMultiSelect(FarmPage, "Produce Mutation Targets", "Ticked mutations will be sold; choose Normal for produce without a mutation", State.SellProduceMutationTargets, function()
local options = table.clone(collectMutationOptions())
table.insert(options, "Normal")
return options
end, true)
addGroupLabel(FarmPage, "Farm Care & Buffs")
addToggle(FarmPage, "Auto Use Items", "Use selected sprinklers, fertilizers, watering cans, and gnome items", "AutoUseItems")
addMultiSelect(FarmPage, "Use Item Targets", "Only selected item types will be used automatically", State.UseItemTargets, function()
local options = {}
for name, data in pairs(ItemShop.Items or {}) do
if type(data) == "table"
and (data.type == "Sprinkler" or data.type == "Fertilizer"
or data.type == "WateringCan" or data.type == "GnomeItem")
then
table.insert(options, name)
end
end
table.sort(options, function(a, b)
return (tonumber(((ItemShop.Items or {})[a] or {}).order) or 0)
> (tonumber(((ItemShop.Items or {})[b] or {}).order) or 0)
end)
return options
end, true)
Runtime.UseItemStatusLabel = create("TextLabel", {
Size = UDim2.new(1, -4, 0, 38),
BackgroundColor3 = Theme.Surface,
BorderSizePixel = 0,
Font = Enum.Font.GothamMedium,
Text = "ITEM | IDLE",
TextColor3 = Theme.Muted,
TextSize = 10,
TextWrapped = true,
Parent = FarmPage,
})
create("UICorner", { CornerRadius = UDim.new(0, 9), Parent = Runtime.UseItemStatusLabel })
Runtime.SetUseItemStatus = function(message, positive)
Runtime.LastUseItemResult = tostring(message or "IDLE")
if Runtime.UseItemStatusLabel and Runtime.UseItemStatusLabel.Parent then
Runtime.UseItemStatusLabel.Text = "ITEM | " .. Runtime.LastUseItemResult
Runtime.UseItemStatusLabel.TextColor3 = positive == true and Theme.Positive
or positive == false and Color3.fromRGB(255, 170, 95)
or Theme.Muted
end
end
local UseItemInfo = create("TextLabel", {
Size = UDim2.new(1, -4, 0, 82),
BackgroundColor3 = Theme.Surface,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
Text = translated("Area items cover valuable crops, watering cans target growing crops, and coffee targets the strongest unboosted gnome."),
TextColor3 = Theme.Muted,
TextSize = 11,
TextWrapped = true,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = FarmPage,
})
create("UICorner", { CornerRadius = UDim.new(0, 9), Parent = UseItemInfo })
create("UIPadding", {
PaddingLeft = UDim.new(0, 13),
PaddingRight = UDim.new(0, 13),
Parent = UseItemInfo,
})
bindLanguage(UseItemInfo, "Text", "Area items cover valuable crops, watering cans target growing crops, and coffee targets the strongest unboosted gnome.")
addGroupLabel(FarmPage, "Item Shop Automation")
addToggle(FarmPage, "Auto Buy Item Shop", "Buy selected items whenever they are in stock", "AutoBuyShop")
addMultiSelect(FarmPage, "Shop Targets", "Items allowed for Auto Buy Item Shop", State.ShopTargets, collectShopOptions, true)
Runtime.ShopStatusLabel = create("TextLabel", {
Size = UDim2.new(1, -4, 0, 38),
BackgroundColor3 = Theme.Surface,
BorderSizePixel = 0,
Font = Enum.Font.GothamMedium,
Text = "SHOP | IDLE",
TextColor3 = Theme.Muted,
TextSize = 10,
TextWrapped = true,
Parent = FarmPage,
})
create("UICorner", { CornerRadius = UDim.new(0, 9), Parent = Runtime.ShopStatusLabel })
Runtime.SetShopStatus = function(message, positive)
Runtime.LastShopResult = tostring(message or "IDLE")
if Runtime.ShopStatusLabel and Runtime.ShopStatusLabel.Parent then
Runtime.ShopStatusLabel.Text = "SHOP | " .. Runtime.LastShopResult
Runtime.ShopStatusLabel.TextColor3 = positive == true and Theme.Positive
or positive == false and Color3.fromRGB(255, 170, 95)
or Theme.Muted
end
end
addGroupLabel(SocialPage, "Social")
addToggle(SocialPage, "Auto Give Held Item", "Give the currently held crop or gnome to the first selected online player", "AutoGive")
addToggle(SocialPage, "Auto Accept Gifts", "Automatically accept item gifts only from selected players", "AutoReceiveGift")
addMultiSelect(SocialPage, "Give To Players", "Selected online recipient; the first available name is used", State.GivePlayers, collectPlayerOptions)
addMultiSelect(SocialPage, "Accept From Players", "Only these senders are trusted for automatic acceptance", State.ReceivePlayers, collectPlayerOptions)
addGroupLabel(UpgradePage, "Upgrade")
addToggle(UpgradePage, "Auto Upgrade", "Buy eligible plot upgrades and Upgrade Tree nodes", "AutoUpgrade")
addToggle(UpgradePage, "Auto Buy Expansion", "Buy the cheapest available plot expansion", "AutoBuyExpansion")
addToggle(UpgradePage, "Auto Rebirth", "Rebirth when money and discovered gnomes meet requirements", "AutoRebirth")
local UpgradeInfo = create("TextLabel", {
Size = UDim2.new(1, -4, 0, 88),
BackgroundColor3 = Theme.Surface,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
Text = "Upgrade order\n1. Affordable plot upgrades\n2. Eligible Upgrade Tree nodes\nServer validation prevents invalid or maxed purchases.",
TextColor3 = Theme.Muted,
TextSize = 11,
TextWrapped = true,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = UpgradePage,
})
bindLanguage(UpgradeInfo, "Text", "Upgrade order\n1. Affordable plot upgrades\n2. Eligible Upgrade Tree nodes\nServer validation prevents invalid or maxed purchases.")
create("UICorner", { CornerRadius = UDim.new(0, 9), Parent = UpgradeInfo })
create("UIPadding", {
PaddingLeft = UDim.new(0, 13),
PaddingRight = UDim.new(0, 13),
Parent = UpgradeInfo,
})
addGroupLabel(SystemPage, "System")
addToggle(SystemPage, "Anti AFK", "Simulate input when Roblox reports the player idle", "AntiAFK")
addToggle(SystemPage, "Auto Rejoin", "Rejoin this place after a disconnect/error prompt", "AutoRejoin")
addToggle(SystemPage, "Low Ping Mode", "Reduce remote bursts; server distance still determines real ping", "LowPingMode")
addToggle(SystemPage, "Potato Graphics", "Disable expensive local effects and use the lowest graphics quality", "PotatoGraphics")
Runtime.SleepRow = create("Frame", {
Size = UDim2.new(1, -4, 0, 88),
BackgroundColor3 = Theme.Surface,
BorderSizePixel = 0,
Parent = SystemPage,
})
create("UICorner", { CornerRadius = UDim.new(0, 9), Parent = Runtime.SleepRow })
Runtime.SleepTitle = create("TextLabel", {
Size = UDim2.new(1, -24, 0, 20), Position = UDim2.fromOffset(12, 7),
BackgroundTransparency = 1, Font = Enum.Font.GothamMedium,
Text = translated("Screen Sleep"), TextColor3 = Theme.Text, TextSize = 13,
TextXAlignment = Enum.TextXAlignment.Left, Parent = Runtime.SleepRow,
})
bindLanguage(Runtime.SleepTitle, "Text", "Screen Sleep")
Runtime.SleepDescription = create("TextLabel", {
Size = UDim2.new(1, -24, 0, 16), Position = UDim2.fromOffset(12, 27),
BackgroundTransparency = 1, Font = Enum.Font.Gotham,
Text = translated("Keep automation running with 3D rendering disabled and a 10 FPS cap"),
TextColor3 = Theme.Muted, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd, Parent = Runtime.SleepRow,
})
bindLanguage(Runtime.SleepDescription, "Text", "Keep automation running with 3D rendering disabled and a 10 FPS cap")
Runtime.SleepButton = create("TextButton", {
Size = UDim2.new(1, -24, 0, 32), Position = UDim2.fromOffset(12, 48),
BackgroundColor3 = Theme.AccentDark, BorderSizePixel = 0, Font = Enum.Font.GothamBold,
Text = translated("SLEEP SCREEN"), TextColor3 = Theme.Text, TextSize = 11,
AutoButtonColor = false, Parent = Runtime.SleepRow,
})
bindLanguage(Runtime.SleepButton, "Text", "SLEEP SCREEN")
create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = Runtime.SleepButton })
Runtime.TextScaleRow = create("Frame", {
Size = UDim2.new(1, -4, 0, 92), BackgroundColor3 = Theme.Surface,
BorderSizePixel = 0, Parent = SystemPage,
})
create("UICorner", { CornerRadius = UDim.new(0, 9), Parent = Runtime.TextScaleRow })
Runtime.TextScaleTitle = create("TextLabel", {
Size = UDim2.new(1, -24, 0, 20), Position = UDim2.fromOffset(12, 7),
BackgroundTransparency = 1, Font = Enum.Font.GothamMedium,
Text = translated("Text Size"), TextColor3 = Theme.Text, TextSize = 13,
TextXAlignment = Enum.TextXAlignment.Left, Parent = Runtime.TextScaleRow,
})
bindLanguage(Runtime.TextScaleTitle, "Text", "Text Size")
Runtime.TextScaleDescription = create("TextLabel", {
Size = UDim2.new(1, -24, 0, 16), Position = UDim2.fromOffset(12, 27),
BackgroundTransparency = 1, Font = Enum.Font.Gotham,
Text = translated("Adjust all interface text from 70% to 160%"), TextColor3 = Theme.Muted,
TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left, Parent = Runtime.TextScaleRow,
})
bindLanguage(Runtime.TextScaleDescription, "Text", "Adjust all interface text from 70% to 160%")
Runtime.TextScaleMinus = create("TextButton", {
Size = UDim2.fromOffset(36, 32), Position = UDim2.fromOffset(12, 51),
BackgroundColor3 = Theme.Background, BorderSizePixel = 0, Font = Enum.Font.GothamBold,
Text = "-", TextColor3 = Theme.Text, TextSize = 16, AutoButtonColor = false,
Parent = Runtime.TextScaleRow,
})
Runtime.TextScaleInput = create("TextBox", {
Size = UDim2.fromOffset(68, 32), Position = UDim2.fromOffset(54, 51),
BackgroundColor3 = Theme.Background, BorderSizePixel = 0, ClearTextOnFocus = false,
Font = Enum.Font.GothamMedium, Text = "100%", TextColor3 = Theme.Text, TextSize = 11,
Parent = Runtime.TextScaleRow,
})
Runtime.TextScalePlus = create("TextButton", {
Size = UDim2.fromOffset(36, 32), Position = UDim2.fromOffset(128, 51),
BackgroundColor3 = Theme.Background, BorderSizePixel = 0, Font = Enum.Font.GothamBold,
Text = "+", TextColor3 = Theme.Text, TextSize = 16, AutoButtonColor = false,
Parent = Runtime.TextScaleRow,
})
create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = Runtime.TextScaleMinus })
create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = Runtime.TextScaleInput })
create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = Runtime.TextScalePlus })
local KeyInfo = create("TextLabel", {
Size = UDim2.new(1, -4, 0, 76),
BackgroundColor3 = Theme.Surface,
BorderSizePixel = 0,
Font = Enum.Font.Gotham,
Text = "Ctrl + Alt  |  Show / hide UI\nPAUSE stops all automation. RESUME restores the previous toggles.\nSettings stay active when the UI is minimized.",
TextColor3 = Theme.Muted,
TextSize = 11,
TextWrapped = true,
Parent = SystemPage,
})
bindLanguage(KeyInfo, "Text", "Ctrl + Alt  |  Show / hide UI\nPAUSE stops all automation. RESUME restores the previous toggles.\nSettings stay active when the UI is minimized.")
create("UICorner", { CornerRadius = UDim.new(0, 9), Parent = KeyInfo })
Runtime.SetTextScale = function(value)
State.TextScale = math.clamp(tonumber(value) or State.TextScale or 1, 0.7, 1.6)
Runtime.ApplyTextScale()
end
connect(Runtime.TextScaleMinus.Activated, function()
Runtime.SetTextScale(State.TextScale - 0.1)
end)
connect(Runtime.TextScalePlus.Activated, function()
Runtime.SetTextScale(State.TextScale + 0.1)
end)
connect(Runtime.TextScaleInput.FocusLost, function()
Runtime.SetTextScale((tonumber(string.match(Runtime.TextScaleInput.Text, "%d+")) or 100) / 100)
end)
connect(Runtime.SleepButton.Activated, function()
Runtime.SetScreenSleep(true)
end)
connect(Runtime.SleepOverlay.Activated, function()
Runtime.SetScreenSleep(false)
end)
connect(workspace.DescendantAdded, function(object)
if State.PotatoGraphics then
Runtime.ApplyPotatoInstance(object)
end
end)
connect(game:GetService("Lighting").DescendantAdded, function(object)
if State.PotatoGraphics then
Runtime.ApplyPotatoInstance(object)
end
end)
Runtime.ApplyTextScale()
Runtime.ApplyPotatoGraphics(State.PotatoGraphics)
addGroupLabel(ConfigPage, "Config")
addToggle(ConfigPage, "Auto Load Profile", "Load this profile automatically on the next execution", "AutoLoadConfig")
local ConfigBox = create("Frame", {
Size = UDim2.new(1, -4, 0, 174),
BackgroundColor3 = Theme.Surface,
BorderSizePixel = 0,
Parent = ConfigPage,
})
create("UICorner", { CornerRadius = UDim.new(0, 9), Parent = ConfigBox })
local ProfileTitle = create("TextLabel", {
Size = UDim2.new(1, -24, 0, 20),
Position = UDim2.fromOffset(12, 10),
BackgroundTransparency = 1,
Font = Enum.Font.GothamMedium,
Text = translated("Profile Name"),
TextColor3 = Theme.Text,
TextSize = 13,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = ConfigBox,
})
bindLanguage(ProfileTitle, "Text", "Profile Name")
local ProfileInput = create("TextBox", {
Size = UDim2.new(1, -24, 0, 34),
Position = UDim2.fromOffset(12, 36),
BackgroundColor3 = Theme.Background,
BorderSizePixel = 0,
ClearTextOnFocus = false,
Font = Enum.Font.Gotham,
PlaceholderText = "default",
PlaceholderColor3 = Theme.Muted,
Text = sanitizeProfileName(State.ConfigProfile),
TextColor3 = Theme.Text,
TextSize = 12,
TextXAlignment = Enum.TextXAlignment.Left,
Parent = ConfigBox,
})
create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = ProfileInput })
create("UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), Parent = ProfileInput })
local SaveProfileButton = create("TextButton", {
Size = UDim2.new(0.5, -18, 0, 34),
Position = UDim2.fromOffset(12, 80),
BackgroundColor3 = Theme.AccentDark,
BorderSizePixel = 0,
Font = Enum.Font.GothamMedium,
Text = translated("Save Profile"),
TextColor3 = Theme.Text,
TextSize = 12,
AutoButtonColor = false,
Parent = ConfigBox,
})
bindLanguage(SaveProfileButton, "Text", "Save Profile")
create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = SaveProfileButton })
local LoadProfileButton = create("TextButton", {
Size = UDim2.new(0.5, -18, 0, 34),
Position = UDim2.new(0.5, 6, 0, 80),
BackgroundColor3 = Theme.Background,
BorderSizePixel = 0,
Font = Enum.Font.GothamMedium,
Text = translated("Load Profile"),
TextColor3 = Theme.Text,
TextSize = 12,
AutoButtonColor = false,
Parent = ConfigBox,
})
bindLanguage(LoadProfileButton, "Text", "Load Profile")
create("UICorner", { CornerRadius = UDim.new(0, 7), Parent = LoadProfileButton })
local ConfigStatus = create("TextLabel", {
Size = UDim2.new(1, -24, 0, 38),
Position = UDim2.fromOffset(12, 124),
BackgroundTransparency = 1,
Font = Enum.Font.Gotham,
Text = translated(type(writefile) == "function" and "Ready to save profiles" or "Executor file API unavailable"),
TextColor3 = type(writefile) == "function" and Theme.Muted or Color3.fromRGB(255, 130, 140),
TextSize = 10,
TextWrapped = true,
Parent = ConfigBox,
})
table.insert(LanguageRefreshers, function()
ConfigStatus.Text = translated(type(writefile) == "function" and "Ready to save profiles" or "Executor file API unavailable")
end)
local function refreshConfigUI()
for _, refresh in pairs(toggleRefreshers) do
pcall(refresh)
end
BestLimitInput.Text = tostring(math.clamp(math.floor(tonumber(State.BestGnomeLimit) or 30), 1, 100))
Runtime.Viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Runtime.Viewport
Window.S = Vector2.new(
math.clamp(tonumber(State.UIWidth) or Window.D.X, Window.N.X, math.max(Window.N.X, Runtime.Viewport.X - 8)),
math.clamp(tonumber(State.UIHeight) or Window.D.Y, Window.N.Y, math.max(Window.N.Y, Runtime.Viewport.Y - 8))
)
State.UIWidth = Window.S.X
State.UIHeight = Window.S.Y
Window.L.Text = string.format("%d x %d", Window.S.X, Window.S.Y)
if Main.Size.X.Offset ~= Window.C.X or Main.Size.Y.Offset ~= Window.C.Y then
Main.Size = UDim2.fromOffset(Window.S.X, Window.S.Y)
end
Runtime.ApplyTextScale()
Runtime.ApplyResponsiveLayout()
Runtime.ApplyPotatoGraphics(State.PotatoGraphics)
for _, render in ipairs(listRenderers) do
if type(render) == "function" then pcall(function() render(true) end) end
end
end
local function refreshMasterControl()
if Runtime.Paused then
MasterControl.Text = State.Language == "TH" and decodeText64("4LiX4Liz4LiV4LmI4Lit") or "RESUME"
MasterControl.BackgroundColor3 = Color3.fromRGB(45, 117, 79)
MasterControlStroke.Color = Theme.Positive
else
MasterControl.Text = State.Language == "TH" and decodeText64("4Lir4Lii4Li44LiU") or "PAUSE"
MasterControl.BackgroundColor3 = Theme.AccentDark
MasterControlStroke.Color = Theme.Accent
end
end
Runtime.ToggleLanguage = function()
State.Language = State.Language == "TH" and "EN" or "TH"
LanguageControl.Text = State.Language
refreshLanguage()
if type(refreshMasterControl) == "function" then refreshMasterControl() end
if type(refreshConfigUI) == "function" then refreshConfigUI() end
end
connect(LanguageControl.Activated, Runtime.ToggleLanguage)
connect(LanguageControl.MouseEnter, function()
LanguageControl.BackgroundColor3 = Theme.SurfaceHover
end)
connect(LanguageControl.MouseLeave, function()
LanguageControl.BackgroundColor3 = Theme.Surface
end)
connect(MasterControl.MouseEnter, function()
MasterControl.BackgroundColor3 = Runtime.Paused and Color3.fromRGB(53, 137, 92) or Theme.Accent
end)
connect(MasterControl.MouseLeave, refreshMasterControl)
connect(MasterControl.Activated, function()
if Runtime.Paused then
Runtime.Paused = false
for _, key in ipairs(MasterAutomationKeys) do
State[key] = Runtime.PauseSnapshot[key] == true
end
table.clear(Runtime.PauseSnapshot)
else
Runtime.Paused = true
table.clear(Runtime.PauseSnapshot)
for _, key in ipairs(MasterAutomationKeys) do
Runtime.PauseSnapshot[key] = State[key] == true
State[key] = false
end
end
refreshMasterControl()
refreshConfigUI()
end)
refreshMasterControl()
connect(SaveProfileButton.Activated, function()
if Runtime.Paused then
ConfigStatus.Text = State.Language == "TH" and decodeText64("4LiB4Lij4Li44LiT4Liy4LiB4LiU4LiX4Liz4LiV4LmI4Lit4LiB4LmI4Lit4LiZ4Lia4Lix4LiZ4LiX4Li24LiB4LmC4Lib4Lij4LmE4Lif4Lil4LmM") or "Resume automation before saving a profile"
ConfigStatus.TextColor3 = Color3.fromRGB(255, 170, 95)
return
end
local ok, message = saveProfile(ProfileInput.Text)
ProfileInput.Text = sanitizeProfileName(ProfileInput.Text)
if State.Language == "TH" then
ConfigStatus.Text = ok and (decodeText64("4Lia4Lix4LiZ4LiX4Li24LiB4LmC4Lib4Lij4LmE4Lif4Lil4LmM4LmB4Lil4LmJ4LinOiA=") .. message) or (decodeText64("4Lia4Lix4LiZ4LiX4Li24LiB4LmE4Lih4LmI4Liq4Liz4LmA4Lij4LmH4LiIOiA=") .. tostring(message))
else
ConfigStatus.Text = ok and ("Saved profile: " .. message) or ("Save failed: " .. tostring(message))
end
ConfigStatus.TextColor3 = ok and Theme.Positive or Color3.fromRGB(255, 130, 140)
end)
connect(LoadProfileButton.Activated, function()
if Runtime.Paused then
ConfigStatus.Text = State.Language == "TH" and decodeText64("4LiB4Lij4Li44LiT4Liy4LiB4LiU4LiX4Liz4LiV4LmI4Lit4LiB4LmI4Lit4LiZ4LmC4Lir4Lil4LiU4LmC4Lib4Lij4LmE4Lif4Lil4LmM") or "Resume automation before loading a profile"
ConfigStatus.TextColor3 = Color3.fromRGB(255, 170, 95)
return
end
local ok, message = loadProfile(ProfileInput.Text)
ProfileInput.Text = sanitizeProfileName(ProfileInput.Text)
if ok then
State.Language = string.upper(tostring(State.Language or "EN")) == "TH" and "TH" or "EN"
LanguageControl.Text = State.Language
refreshLanguage()
refreshMasterControl()
refreshConfigUI()
end
if State.Language == "TH" then
ConfigStatus.Text = ok and (decodeText64("4LmC4Lir4Lil4LiU4LmC4Lib4Lij4LmE4Lif4Lil4LmM4LmB4Lil4LmJ4LinOiA=") .. message) or (decodeText64("4LmC4Lir4Lil4LiU4LmE4Lih4LmI4Liq4Liz4LmA4Lij4LmH4LiIOiA=") .. tostring(message))
else
ConfigStatus.Text = ok and ("Loaded profile: " .. message) or ("Load failed: " .. tostring(message))
end
ConfigStatus.TextColor3 = ok and Theme.Positive or Color3.fromRGB(255, 130, 140)
end)
showPage("Gnomes")
pcall(function()
game:GetService("StarterGui"):SetCore("SendNotification", {
Title = "Roll A Gnome Hub",
Text = "Loaded! Toggle: Ctrl + Alt",
Duration = 5,
})
end)
print("[Roll A Gnome Hub]: Successfully loaded! Press Ctrl + Alt to Toggle UI.")
local dragging = false
local dragInput
local dragOrigin
local dragStartWindow
local dragMoved = false
local suppressMinimizeUntil = 0
local minimized = false
local expandedPosition
local compactPosition
local function mainPixelPosition()
local camera = workspace.CurrentCamera
local viewport = camera and camera.ViewportSize or Vector2.new(1920, 1080)
return Vector2.new(
viewport.X * Main.Position.X.Scale + Main.Position.X.Offset,
viewport.Y * Main.Position.Y.Scale + Main.Position.Y.Offset
)
end
local function keepMainOnScreen(position)
local camera = workspace.CurrentCamera
local viewport = camera and camera.ViewportSize or Vector2.new(1920, 1080)
local size = Main.AbsoluteSize
local maximumX = math.max(6, viewport.X - size.X - 6)
local maximumY = math.max(6, viewport.Y - size.Y - 6)
local target = position or mainPixelPosition()
local clamped = Vector2.new(
math.clamp(target.X, 6, maximumX),
math.clamp(target.Y, 6, maximumY)
)
Main.Position = UDim2.fromOffset(clamped.X, clamped.Y)
if minimized then
compactPosition = clamped
else
expandedPosition = clamped
end
return clamped
end
local function pointerPosition(input)
if input and input.UserInputType == Enum.UserInputType.Touch then
return Vector2.new(input.Position.X, input.Position.Y)
end
local point = UserInputService:GetMouseLocation()
return Vector2.new(point.X, point.Y)
end
local function updateResize(pointer)
local delta = pointer - Window.O
local camera = workspace.CurrentCamera
local viewport = camera and camera.ViewportSize or Vector2.new(1920, 1080)
local position = mainPixelPosition()
local maximum = Vector2.new(
math.max(Window.N.X, viewport.X - position.X - 6),
math.max(Window.N.Y, viewport.Y - position.Y - 6)
)
Window.S = Vector2.new(
math.clamp(math.floor(Window.Z.X + delta.X + 0.5), Window.N.X, maximum.X),
math.clamp(math.floor(Window.Z.Y + delta.Y + 0.5), Window.N.Y, maximum.Y)
)
State.UIWidth = Window.S.X
State.UIHeight = Window.S.Y
Main.Size = UDim2.fromOffset(Window.S.X, Window.S.Y)
Window.L.Text = string.format("%d x %d", Window.S.X, Window.S.Y)
Runtime.ApplyResponsiveLayout()
end
local function beginResize(input)
if minimized or Window.A then
return
end
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
Window.A = true
Window.I = input.UserInputType == Enum.UserInputType.Touch and input or nil
Window.O = pointerPosition(input)
Window.Z = Window.S
Window.L.Visible = true
if not Window.I and Runtime.StartPointerRender then
Runtime.StartPointerRender()
end
end
end
connect(Window.R.InputBegan, beginResize)
connect(Window.R.MouseEnter, function()
Window.V = true
if not minimized then
Window.L.Visible = true
end
end)
connect(Window.R.MouseLeave, function()
Window.V = false
if not Window.A then
Window.L.Visible = false
end
end)
local function updateDrag(pointer)
local delta = pointer - dragOrigin
if not dragMoved and delta.Magnitude < 4 then
return
end
if not dragMoved then
dragMoved = true
end
local wanted = dragStartWindow + delta
local actual = keepMainOnScreen(wanted)
if actual ~= wanted then
dragOrigin = pointer
dragStartWindow = actual
end
end
local function beginDrag(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
if dragging then
return
end
dragging = true
dragMoved = false
dragInput = input.UserInputType == Enum.UserInputType.Touch and input or nil
dragOrigin = pointerPosition(input)
dragStartWindow = mainPixelPosition()
if not dragInput and Runtime.StartPointerRender then
Runtime.StartPointerRender()
end
end
end
connect(Header.InputBegan, beginDrag)
connect(Minimize.InputBegan, beginDrag)
local function endDragging(input)
if dragging and (not input or input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch or input == dragInput) then
if dragMoved then
suppressMinimizeUntil = os.clock() + 0.2
end
dragging = false
dragInput = nil
end
if Window.A and (not input or input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch or input == Window.I) then
Window.A = false
Window.I = nil
Window.L.Visible = Window.V and not minimized
end
if not dragging and not Window.A and Runtime.StopPointerRender then
Runtime.StopPointerRender()
end
end
connect(UserInputService.InputEnded, function(input)
local key = input.KeyCode
if key == Enum.KeyCode.LeftAlt or key == Enum.KeyCode.RightAlt
or key == Enum.KeyCode.LeftControl or key == Enum.KeyCode.RightControl then
Window.K = false
end
endDragging(input)
end)
connect(UserInputService.TouchEnded, function(touch)
endDragging(touch)
end)
connect(UserInputService.InputChanged, function(input)
if dragging and (input.UserInputType == Enum.UserInputType.Touch or input == dragInput) then
updateDrag(Vector2.new(input.Position.X, input.Position.Y))
end
if Window.A and (input.UserInputType == Enum.UserInputType.Touch or input == Window.I) then
updateResize(Vector2.new(input.Position.X, input.Position.Y))
end
end)
connect(UserInputService.TouchMoved, function(touch)
if dragging then
updateDrag(Vector2.new(touch.Position.X, touch.Position.Y))
end
if Window.A then
updateResize(Vector2.new(touch.Position.X, touch.Position.Y))
end
end)
Runtime.StartPointerRender = function()
if Runtime.PointerRenderConnection then
return
end
local ok, connection = pcall(function()
return game:GetService("RunService").RenderStepped:Connect(function()
if dragging then
updateDrag(pointerPosition(dragInput))
end
if Window.A then
updateResize(pointerPosition(Window.I))
end
end)
end)
if ok then
Runtime.PointerRenderConnection = connection
end
end
Runtime.StopPointerRender = function()
if Runtime.PointerRenderConnection then
Runtime.PointerRenderConnection:Disconnect()
Runtime.PointerRenderConnection = nil
end
end
local function setMinimized(value)
local current = mainPixelPosition()
local position
if value then
expandedPosition = current
compactPosition = compactPosition or current
position = compactPosition
else
compactPosition = current
expandedPosition = expandedPosition or current
position = expandedPosition
end
minimized = value
Runtime.LayoutSignature = nil
Sidebar.Visible = not value
Content.Visible = not value
TitleLabel.Visible = not value
LiveLabel.Visible = not value and not (Runtime.Mobile or Window.S.X < 620)
Close.Visible = not value
MasterControl.Visible = not value
LanguageControl.Visible = not value
CompactAccent.Visible = value
CompactTitle.Visible = value
CompactSubtitle.Visible = value
CompactArrow.Visible = value
MinimizeIcon.Visible = not value
Window.R.Visible = not value
Window.L.Visible = false
Main.Size = value
and UDim2.fromOffset(Window.C.X, Window.C.Y)
or UDim2.fromOffset(Window.S.X, Window.S.Y)
Main.Position = UDim2.fromOffset(position.X, position.Y)
MainCorner.CornerRadius = UDim.new(0, value and 15 or 12)
MainStroke.Color = value and Theme.AccentDark or Color3.fromRGB(49, 55, 68)
MainStroke.Thickness = value and 1.5 or 1
Header.Size = value and UDim2.fromScale(1, 1) or UDim2.new(1, 0, 0, Window.H)
Header.BackgroundColor3 = value and Theme.Surface or Theme.Sidebar
Minimize.Size = value and UDim2.fromScale(1, 1) or UDim2.fromOffset(34, 30)
Minimize.Position = value and UDim2.fromScale(0, 0) or UDim2.new(1, -90, 0, 17)
Minimize.BackgroundTransparency = value and 1 or 0
MinimizeStroke.Enabled = not value
MinimizeCorner.CornerRadius = UDim.new(0, value and 15 or 7)
if not value then
Runtime.ApplyResponsiveLayout()
end
task.defer(keepMainOnScreen)
end
Runtime.UpdateViewport = function()
Runtime.Viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Runtime.Viewport
Window.S = Vector2.new(
math.clamp(Window.S.X, Window.N.X, math.max(Window.N.X, Runtime.Viewport.X - 8)),
math.clamp(Window.S.Y, Window.N.Y, math.max(Window.N.Y, Runtime.Viewport.Y - 8))
)
State.UIWidth, State.UIHeight = Window.S.X, Window.S.Y
if not minimized then
Main.Size = UDim2.fromOffset(Window.S.X, Window.S.Y)
end
Window.L.Text = string.format("%d x %d", Window.S.X, Window.S.Y)
Runtime.ApplyResponsiveLayout()
task.defer(keepMainOnScreen)
end
Runtime.BindViewportCamera = function(camera)
if Runtime.ViewportConnection then
Runtime.ViewportConnection:Disconnect()
Runtime.ViewportConnection = nil
end
if camera then
local ok, connection = pcall(function()
return camera:GetPropertyChangedSignal("ViewportSize"):Connect(Runtime.UpdateViewport)
end)
if ok then
Runtime.ViewportConnection = connection
end
end
end
Runtime.BindViewportCamera(workspace.CurrentCamera)
connect(workspace:GetPropertyChangedSignal("CurrentCamera"), function()
Runtime.BindViewportCamera(workspace.CurrentCamera)
Runtime.UpdateViewport()
end)
connect(Minimize.MouseEnter, function()
if not minimized then
Minimize.BackgroundColor3 = Theme.SurfaceHover
MinimizeStroke.Color = Theme.AccentDark
end
end)
connect(Minimize.MouseLeave, function()
if not minimized then
Minimize.BackgroundColor3 = Theme.Surface
MinimizeStroke.Color = Color3.fromRGB(49, 55, 68)
end
end)
connect(Close.MouseEnter, function()
Close.BackgroundColor3 = Color3.fromRGB(67, 35, 43)
CloseStroke.Color = Color3.fromRGB(130, 62, 76)
end)
connect(Close.MouseLeave, function()
Close.BackgroundColor3 = Theme.Surface
CloseStroke.Color = Color3.fromRGB(67, 53, 60)
end)
connect(Minimize.Activated, function()
if dragMoved or os.clock() < suppressMinimizeUntil then
return
end
setMinimized(not minimized)
end)
connect(UserInputService.InputBegan, function(input, processed)
local alt = UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt)
or UserInputService:IsKeyDown(Enum.KeyCode.RightAlt)
local control = UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)
or UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
if alt and control and not Window.K then
Window.K = true
if Runtime.ScreenSleeping then
Runtime.SetScreenSleep(false)
else
ScreenGui.Enabled = not ScreenGui.Enabled
end
end
end)
function Runtime.Destroy()
if not Runtime.Alive then
return
end
Runtime.Alive = false
State.AutoRoll = false
Runtime.StopPointerRender()
if Runtime.ViewportConnection then
Runtime.ViewportConnection:Disconnect()
Runtime.ViewportConnection = nil
end
Runtime.SetScreenSleep(false)
Runtime.ForceGraphicsRestore = true
Runtime.ApplyPotatoGraphics(false)
Runtime.ForceGraphicsRestore = nil
for _, connection in ipairs(Runtime.Connections) do
pcall(function()
connection:Disconnect()
end)
end
table.clear(Runtime.Connections)
if Runtime.GiftPromptWrapper and _G.AreYouSure == Runtime.GiftPromptWrapper then
_G.AreYouSure = Runtime.OriginalGiftPrompt
end
if ScreenGui and ScreenGui.Parent then
ScreenGui:Destroy()
end
end
connect(Close.Activated, Runtime.Destroy)
Runtime.IsMinimized = function() return minimized end
end
local function getInstancePivot(instance)
if instance:IsA("Model") then
return instance:GetPivot()
elseif instance:IsA("BasePart") then
return instance.CFrame
end
end
local function getFloorId(hitInstance, ground)
local current = hitInstance
while current and current ~= ground do
local floorId = string.match(current.Name, "^Floor(%d+)$")
if floorId then
return floorId
end
current = current.Parent
end
return "1"
end
local function findGnomePlacement()
local plot = getPlot()
local ground = plot and plot:FindFirstChild("Ground")
if not ground then
return nil
end
local cached = Runtime.GroundPartsCache
local groundParts
if cached and cached.Ground == ground and cached.Until > os.clock() then
groundParts = cached.Parts
else
groundParts = {}
if ground:IsA("BasePart") then
table.insert(groundParts, ground)
end
for _, descendant in ipairs(ground:GetDescendants()) do
if descendant:IsA("BasePart") and descendant.CanQuery then
table.insert(groundParts, descendant)
end
end
table.sort(groundParts, function(a, b)
return a.Size.X * a.Size.Z > b.Size.X * b.Size.Z
end)
Runtime.GroundPartsCache = { Ground = ground, Until = os.clock() + 2, Parts = groundParts }
end
if #groundParts == 0 then
return nil
end
local occupied = {}
local workers = plot:FindFirstChild("Workers")
if workers then
for _, worker in ipairs(workers:GetChildren()) do
local ok, pivot = pcall(getInstancePivot, worker)
if ok and pivot then
table.insert(occupied, pivot.Position)
end
end
end
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Include
raycastParams.FilterDescendantsInstances = { ground }
raycastParams.IgnoreWater = true
local spacing = 4
for _, groundPart in ipairs(groundParts) do
local halfX = math.max(0, math.floor((groundPart.Size.X - 3) / (spacing * 2)))
local halfZ = math.max(0, math.floor((groundPart.Size.Z - 3) / (spacing * 2)))
halfX = math.min(halfX, 12)
halfZ = math.min(halfZ, 12)
local candidates = {}
for gridZ = -halfZ, halfZ do
for gridX = -halfX, halfX do
table.insert(candidates, {
X = gridX * spacing,
Z = gridZ * spacing,
Distance = math.abs(gridX) + math.abs(gridZ),
})
end
end
table.sort(candidates, function(a, b)
return a.Distance < b.Distance
end)
for _, candidate in ipairs(candidates) do
local rayOrigin = groundPart.CFrame:PointToWorldSpace(Vector3.new(candidate.X, groundPart.Size.Y / 2 + 30, candidate.Z))
local result = workspace:Raycast(rayOrigin, Vector3.new(0, -80, 0), raycastParams)
if result then
local free = true
for _, position in ipairs(occupied) do
local difference = Vector2.new(position.X - result.Position.X, position.Z - result.Position.Z)
if difference.Magnitude < spacing * 0.8 then
free = false
break
end
end
if free then
local direction = Vector3.new(groundPart.CFrame.LookVector.X, 0, groundPart.CFrame.LookVector.Z)
if direction.Magnitude <= 0.01 then
direction = Vector3.new(0, 0, -1)
end
return CFrame.lookAt(result.Position, result.Position + direction.Unit), getFloorId(result.Instance, ground)
end
end
end
end
local fallback = groundParts[1]
return fallback.CFrame * CFrame.new(0, fallback.Size.Y / 2, 0), getFloorId(fallback, ground)
end
local function getBackpack()
return LocalPlayer:FindFirstChildOfClass("Backpack") or LocalPlayer:FindFirstChild("Backpack")
end
Runtime.GetSellPointCFrame = function()
local plot = getPlot()
local points = plot and plot:FindFirstChild("Points")
local sell = points and points:FindFirstChild("Sell")
if not sell then
return nil
end
if sell:IsA("BasePart") then
return sell.CFrame
elseif sell:IsA("Model") then
return sell:GetPivot()
end
local part = sell:FindFirstChildWhichIsA("BasePart", true)
return part and part.CFrame or nil
end
Runtime.EquipToolConfirmed = function(tool, force)
local character = LocalPlayer.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
if not character or not humanoid or not tool or not tool.Parent then
return false
end
local changed = force or tool.Parent ~= character
if changed then
pcall(function()
humanoid:UnequipTools()
end)
task.wait()
pcall(function()
humanoid:EquipTool(tool)
end)
end
local deadline = os.clock() + 0.3
local confirmed = false
repeat
if tool.Parent == character then
confirmed = true
break
end
task.wait()
until not tool.Parent or os.clock() >= deadline or not Runtime.Alive
if tool.Parent and tool.Parent ~= character then
pcall(function()
tool.Parent = character
end)
confirmed = tool.Parent == character
end
return confirmed and tool.Parent == character
end
Runtime.ProduceSellRetry = setmetatable({}, { __mode = "k" })
Runtime.FindSelectedProduceBatch = function(limit)
local result = {}
for _, container in ipairs({ getBackpack(), LocalPlayer.Character }) do
if container then
for _, tool in ipairs(container:GetChildren()) do
if (Runtime.ProduceSellRetry[tool] or 0) <= os.clock()
and Runtime.IsProduceTool(tool)
and Runtime.IsSelectedProduceMutation(tool)
then
table.insert(result, tool)
if #result >= (limit or 8) then
return result
end
end
end
end
end
return result
end
local autoPlacePending = setmetatable({}, { __mode = "k" })
local autoPlaceRetryAt = setmetatable({}, { __mode = "k" })
local best30Selling = setmetatable({}, { __mode = "k" })
local gnomeRemoveRetryAt = setmetatable({}, { __mode = "k" })
local gnomeSellRetryAt = setmetatable({}, { __mode = "k" })
Runtime.GnomePlaceBlockedUntil = setmetatable({}, { __mode = "k" })
local function isGnomeTool(tool)
if not tool or not tool:IsA("Tool") then
return false
end
local itemType = string.lower(tostring(tool:GetAttribute("type") or tool:GetAttribute("Type") or ""))
return tool:GetAttribute("FarmerName") ~= nil or itemType == "farmer" or itemType == "gnome"
end
local function tryAutoPlace(tool)
local function placementEnabled()
return State.AutoBest30
end
if not Runtime.Alive
or not placementEnabled()
or not tool
or not tool:IsA("Tool")
or Runtime.IsGiftReserved(tool)
or autoPlacePending[tool]
or best30Selling[tool]
or (autoPlaceRetryAt[tool] or 0) > os.clock()
then
return false
end
autoPlacePending[tool] = true
task.spawn(function()
local attributeDeadline = os.clock() + 1
repeat
task.wait(0.05)
until isGnomeTool(tool) or not tool.Parent or os.clock() >= attributeDeadline
if not isGnomeTool(tool) or Runtime.IsGiftReserved(tool) then
autoPlacePending[tool] = nil
return
end
local attemptedPlacement = false
local actionOk, placed = Runtime.WithAction("PlaceGnome", { "Equipment", "Gnome" }, function()
for _ = 1, 3 do
if not Runtime.Alive or not placementEnabled() or not tool.Parent then
break
end
local placeCFrame, floorId = findGnomePlacement()
if placeCFrame then
local character = LocalPlayer.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
local previouslyEquipped
if character then
for _, child in ipairs(character:GetChildren()) do
if child:IsA("Tool") and child ~= tool then
previouslyEquipped = child
break
end
end
end
if humanoid and character and tool.Parent ~= character then
pcall(function()
humanoid:EquipTool(tool)
end)
task.wait(0.2)
end
if character and tool.Parent == character then
local farmerName = tool:GetAttribute("FarmerName") or tool.Name
local remoteOk = fire("Place", "Farmer", farmerName, placeCFrame, floorId or "1")
attemptedPlacement = attemptedPlacement or remoteOk == true
task.wait(0.65)
if not tool.Parent then
Runtime.Stats.Placed = Runtime.Stats.Placed + 1
end
end
if humanoid and humanoid.Parent then
if tool.Parent == character then
pcall(function()
humanoid:UnequipTools()
end)
end
if previouslyEquipped and previouslyEquipped.Parent == getBackpack() then
pcall(function()
humanoid:EquipTool(previouslyEquipped)
end)
end
end
if not tool.Parent then
break
end
else
task.wait(0.5)
end
end
return not tool.Parent
end)
autoPlacePending[tool] = nil
if placed == true or not tool.Parent then
Runtime.GnomePlaceBlockedUntil[tool] = nil
autoPlaceRetryAt[tool] = nil
elseif actionOk and attemptedPlacement then
Runtime.GnomePlaceBlockedUntil[tool] = os.clock() + 6
autoPlaceRetryAt[tool] = os.clock() + 0.5
else
autoPlaceRetryAt[tool] = os.clock() + 0.25
end
end)
return true
end
local MutationMultipliers = {
Golden = 1.5,
Diamond = 2,
Shiny = 3,
Fire = 1.5,
Night = 1.5,
Toxic = 1.85,
Charged = 1.25,
Frozen = 1.5,
Cursed = 2,
}
local function getBestGnomeLimit()
local limit = math.clamp(math.floor(tonumber(State.BestGnomeLimit) or 30), 1, 100)
State.BestGnomeLimit = limit
return limit
end
local function getGnomePower(instance)
local farmerName = getFarmerName(instance)
local config = FarmersConfig[farmerName]
if type(config) ~= "table" then
return math.huge, math.huge, 0, 1, farmerName
end
local plantName = tostring(config.plant or "")
local plantConfig = PlantsConfig[plantName] or {}
local cropName = type(plantConfig.fruit) == "table" and tostring(plantConfig.fruit.name or plantName) or plantName
local mutations = tostring(instance:GetAttribute("Mutations") or instance:GetAttribute("Mutation") or "")
local hugeMultiplier = instance:GetAttribute("Huge") == true and 1.5 or 1
local level = math.max(1, tonumber(instance:GetAttribute("Level")) or 1)
local baseValue
local usedExactCropPrice = false
if type(CropsUtil.getPrice) == "function" then
local ok, value = pcall(function() return CropsUtil and type(CropsUtil.getPrice) == "function" and CropsUtil.getPrice(cropName, hugeMultiplier, mutations) end)
baseValue = ok and tonumber(value) or nil
usedExactCropPrice = baseValue ~= nil
end
local cropConfig = type(plantConfig.fruit) == "table" and plantConfig.fruit or plantConfig
baseValue = baseValue or (tonumber(cropConfig.sell_price) or tonumber(plantConfig.sell_price)
or tonumber(config.order) or 0) * hugeMultiplier
local mutationMultiplier = 1
for mutation in string.gmatch(mutations, "[^_]+") do
mutationMultiplier = mutationMultiplier * (MutationMultipliers[mutation] or 1)
end
if not usedExactCropPrice then
baseValue = baseValue * mutationMultiplier
end
local leveledValue
if type(LevelsUtil.getValue) == "function" then
local ok, value = pcall(function() return LevelsUtil and type(LevelsUtil.getValue) == "function" and LevelsUtil.getValue(baseValue, math.max(0, level - 1)) end)
leveledValue = ok and tonumber(value) or nil
end
leveledValue = leveledValue or baseValue * (1 + math.max(0, level - 1) * 0.1)
local duration = config.plant_duration
local averageDuration = type(duration) == "table"
and ((tonumber(duration[1]) or 1) + (tonumber(duration[2]) or tonumber(duration[1]) or 1)) / 2
or tonumber(duration) or 1
local progression = math.max(1, tonumber(config.order) or 1)
local productionRate = leveledValue / math.max(averageDuration, 0.1)
return productionRate, progression,
tonumber(instance:GetAttribute("RolledRarity")) or 0,
level,
farmerName
end
Runtime.RankedGnomeCache = nil
local function getRankedGnomes()
local cached = Runtime.RankedGnomeCache
if cached and cached.Until > os.clock() then
return cached.Records
end
local records = {}
local seen = {}
local function add(instance, kind)
if not instance or seen[instance] or Runtime.IsGiftReserved(instance) then
return
end
seen[instance] = true
local power, progression, rolledRarity, level, farmerName = getGnomePower(instance)
table.insert(records, {
Instance = instance,
Kind = kind,
Power = power,
Progression = progression,
RolledRarity = rolledRarity,
Level = level,
FarmerName = farmerName,
})
end
local plot = getPlot()
local workers = plot and plot:FindFirstChild("Workers")
if workers then
for _, worker in ipairs(workers:GetChildren()) do
add(worker, "Worker")
end
end
for _, container in ipairs({ getBackpack(), LocalPlayer.Character }) do
if container then
for _, tool in ipairs(container:GetChildren()) do
if isGnomeTool(tool) then
add(tool, "Tool")
end
end
end
end
table.sort(records, function(a, b)
if a.Power ~= b.Power then
return a.Power > b.Power
end
if a.Progression ~= b.Progression then
return a.Progression > b.Progression
end
if a.RolledRarity ~= b.RolledRarity then
return a.RolledRarity > b.RolledRarity
end
if a.Level ~= b.Level then
return a.Level > b.Level
end
return a.Instance.Name < b.Instance.Name
end)
Runtime.RankedGnomeCache = { Until = os.clock() + 0.35, Records = records }
return records
end
local function hasKeepRarity(instance)
if not instance then
return false
end
if not Runtime.HasAnySelection(State.KeepRarityTargets) then
return false
end
return isSelected(State.KeepRarityTargets, getFarmerRarity(instance))
end
local function hasKeepMutation(instance)
if not instance then
return false
end
if not Runtime.HasAnySelection(State.KeepMutationTargets) then
return false
end
local mutations = tostring(instance:GetAttribute("Mutations") or instance:GetAttribute("Mutation") or "")
local cleaned = string.gsub(mutations, "%s*[,|+]%s*", "_")
if cleaned == "" or string.lower(cleaned) == "none" or string.lower(cleaned) == "normal" then
return isSelected(State.KeepMutationTargets, "Normal")
end
for mutation in string.gmatch(cleaned, "[^_]+") do
mutation = string.match(mutation, "^%s*(.-)%s*$")
if mutation and mutation ~= "" and isSelected(State.KeepMutationTargets, mutation) then
return true
end
end
return false
end
local function matchesKeepTargets(instance)
if not instance then
return false
end
local hasKeepRarityFilter = Runtime.HasAnySelection(State.KeepRarityTargets)
local hasKeepMutationFilter = Runtime.HasAnySelection(State.KeepMutationTargets)
if hasKeepRarityFilter and hasKeepMutationFilter then
return hasKeepRarity(instance) and hasKeepMutation(instance)
elseif hasKeepRarityFilter then
return hasKeepRarity(instance)
elseif hasKeepMutationFilter then
return hasKeepMutation(instance)
end
return false
end
Runtime.MatchesKeepTargets = matchesKeepTargets
local function isProtectedGnome(tool)
if not tool or not isGnomeTool(tool) then
return false
end
if Runtime.NeedsRebirthGnome and Runtime.NeedsRebirthGnome(tool) then
return true
end
if matchesKeepTargets(tool) then
return true
end
local ranked = getRankedGnomes()
local protectedCount = math.min(getBestGnomeLimit(), #ranked)
for index, record in ipairs(ranked) do
if index > protectedCount then
break
end
if record.Instance == tool then
return true
end
end
return false
end
local function sellInventoryGnomeBatch(tools)
if type(tools) ~= "table" or #tools == 0 then
return 0
end
local eligible = {}
for _, tool in ipairs(tools) do
if tool and tool.Parent and not Runtime.IsGiftReserved(tool) and not best30Selling[tool]
and not autoPlacePending[tool] and (gnomeSellRetryAt[tool] or 0) <= os.clock()
then
table.insert(eligible, tool)
end
end
if #eligible == 0 then
return 0
end
for _, tool in ipairs(eligible) do
best30Selling[tool] = true
end
local soldCount = 0
local actionOk = Runtime.WithAction("SellInventoryGnome", { "Movement", "Equipment", "Gnome" }, function()
local character = LocalPlayer.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
local rootPart = character and character:FindFirstChild("HumanoidRootPart")
local returnPivot = character and character:GetPivot()
local previouslyEquipped
if character then
for _, child in ipairs(character:GetChildren()) do
if child:IsA("Tool") and not table.find(eligible, child) then
previouslyEquipped = child
break
end
end
end
local sellCFrame = Runtime.GetSellPointCFrame()
local moved = false
if character and rootPart and sellCFrame and (rootPart.Position - sellCFrame.Position).Magnitude > 8 then
moved = pcall(function()
character:PivotTo(sellCFrame * CFrame.new(0, 3, 5))
rootPart.AssemblyLinearVelocity = Vector3.zero
rootPart.AssemblyAngularVelocity = Vector3.zero
end)
task.wait(UserInputService.TouchEnabled and 0.45 or 0.25)
end
for _, tool in ipairs(eligible) do
if not Runtime.Alive or not State.AutoBest30 or not tool.Parent then
break
end
if not Runtime.IsGiftReserved(tool) then
if Runtime.EquipToolConfirmed(tool) and State.AutoBest30 then
local ok, result = invoke("SellGnome")
local deadline = os.clock() + 0.85
repeat
task.wait(0.04)
until not tool.Parent or os.clock() >= deadline or not Runtime.Alive
if not tool.Parent or (ok and type(result) == "number") then
soldCount = soldCount + 1
gnomeSellRetryAt[tool] = nil
else
gnomeSellRetryAt[tool] = os.clock() + 1.5
end
else
gnomeSellRetryAt[tool] = os.clock() + 1.5
end
end
end
if humanoid and humanoid.Parent then
pcall(function()
humanoid:UnequipTools()
end)
if previouslyEquipped and previouslyEquipped.Parent == getBackpack() then
pcall(function()
humanoid:EquipTool(previouslyEquipped)
end)
end
end
if moved and returnPivot and character == LocalPlayer.Character and character.Parent then
pcall(function()
character:PivotTo(returnPivot)
if rootPart and rootPart.Parent then
rootPart.AssemblyLinearVelocity = Vector3.zero
rootPart.AssemblyAngularVelocity = Vector3.zero
end
end)
end
return soldCount > 0
end)
for _, tool in ipairs(eligible) do
best30Selling[tool] = nil
end
if soldCount > 0 then
Runtime.RankedGnomeCache = nil
end
return soldCount
end
local function sellInventoryGnome(tool)
if not tool then
return false
end
return sellInventoryGnomeBatch({ tool }) > 0
end
local function policySellsGnome(record)
if not record or not record.Instance or type(FarmersConfig[record.FarmerName]) ~= "table" then
return false
end
if Runtime.NeedsRebirthGnome and Runtime.NeedsRebirthGnome(record.Instance) then
return false
end
if matchesKeepTargets(record.Instance) then
return false
end
return true
end
Runtime.PurgeInventoryOverflow = function()
if not Runtime.Alive then
return false
end
local currentCount = Runtime.GetBackpackItemCount()
if currentCount < 35 then
return true
end
local actionOk = Runtime.WithAction("EmergencyInventoryPurge", { "Movement", "Farm", "Equipment", "Gnome" }, function()
local character = LocalPlayer.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
local rootPart = character and character:FindFirstChild("HumanoidRootPart")
local returnPivot = character and character:GetPivot()
local sellCFrame = Runtime.GetSellPointCFrame()
if character and rootPart and sellCFrame and (rootPart.Position - sellCFrame.Position).Magnitude > 8 then
pcall(function()
character:PivotTo(sellCFrame * CFrame.new(0, 3, 5))
rootPart.AssemblyLinearVelocity = Vector3.zero
rootPart.AssemblyAngularVelocity = Vector3.zero
end)
task.wait(0.2)
end
local okAll = invoke("SellAll")
local produceBatch = Runtime.FindSelectedProduceBatch(20)
for _, produce in ipairs(produceBatch) do
if produce.Parent and Runtime.IsProduceTool(produce) and Runtime.IsSelectedProduceMutation(produce) then
if Runtime.EquipToolConfirmed(produce) then
local ok, res = invoke("SellThis")
if ok and type(res) == "number" then
Runtime.Stats.Sold = Runtime.Stats.Sold + 1
end
end
end
end
if Runtime.GetBackpackItemCount() >= 35 then
local ranked = getRankedGnomes()
local keepLimit = getBestGnomeLimit()
local protectedCount = math.min(keepLimit, #ranked)
local junkGnomes = {}
for index = #ranked, protectedCount + 1, -1 do
local record = ranked[index]
if record.Kind == "Tool" and record.Instance and record.Instance.Parent and policySellsGnome(record) then
table.insert(junkGnomes, record.Instance)
if #junkGnomes >= 12 then
break
end
end
end
for _, gnomeTool in ipairs(junkGnomes) do
if gnomeTool.Parent and not Runtime.IsGiftReserved(gnomeTool) then
if Runtime.EquipToolConfirmed(gnomeTool) then
local ok, res = invoke("SellGnome")
if ok and type(res) == "number" then
Runtime.Stats.Sold = Runtime.Stats.Sold + 1
end
end
end
end
end
if humanoid and humanoid.Parent then
pcall(function()
humanoid:UnequipTools()
end)
end
if returnPivot and character == LocalPlayer.Character and character.Parent and rootPart and rootPart.Parent then
pcall(function()
character:PivotTo(returnPivot)
rootPart.AssemblyLinearVelocity = Vector3.zero
rootPart.AssemblyAngularVelocity = Vector3.zero
end)
end
return true
end)
return actionOk == true
end
local function removePlacedGnome(record, sell)
local instance = record and record.Instance
if not instance or not instance.Parent or (gnomeRemoveRetryAt[instance] or 0) > os.clock() then
return false
end
local originalParent = instance.Parent
local owner = sell and "SellPlacedGnome" or "PickupPlacedGnome"
local actionOk, removed = Runtime.WithAction(owner, { "Gnome" }, function()
if not State.AutoBest30 or not instance.Parent then
return false
end
local ok = fire(sell and "SellFarmer" or "PickupFarmer", instance.Name)
local deadline = os.clock() + 1.5
repeat
task.wait(0.05)
until instance.Parent ~= originalParent or os.clock() >= deadline or not Runtime.Alive
if instance.Parent ~= originalParent then
Runtime.RankedGnomeCache = nil
return ok
end
return false
end)
if actionOk and removed and sell then
Runtime.Stats.Sold = Runtime.Stats.Sold + 1
end
if actionOk and removed then
gnomeRemoveRetryAt[instance] = nil
elseif instance.Parent then
gnomeRemoveRetryAt[instance] = os.clock() + 1.5
end
return actionOk and removed == true
end
task.spawn(function()
while Runtime.Alive do
if State.AutoBest30 or Runtime.IsBackpackNearFull() then
local ranked = getRankedGnomes()
local keepLimit = getBestGnomeLimit()
local protectedCount = math.min(keepLimit, #ranked)
local activeLimit = keepLimit
local bestInventory, bestInventoryIndex
local placedCount = 0
for index, record in ipairs(ranked) do
if record.Kind == "Worker" then
placedCount = placedCount + 1
elseif index <= activeLimit and not bestInventory then
bestInventory = record
bestInventoryIndex = index
end
end
local acted = false
local weakestPlaced, weakestPlacedIndex
for index = #ranked, 1, -1 do
if ranked[index].Kind == "Worker" then
weakestPlaced, weakestPlacedIndex = ranked[index], index
break
end
end
if placedCount > activeLimit and weakestPlaced then
local sell = weakestPlacedIndex > protectedCount and policySellsGnome(weakestPlaced)
acted = removePlacedGnome(weakestPlaced, sell)
elseif bestInventory then
local tool = bestInventory.Instance
local hasWeakerPlaced = weakestPlacedIndex and weakestPlacedIndex > bestInventoryIndex
local placementBlocked = (Runtime.GnomePlaceBlockedUntil[tool] or 0) > os.clock()
if placedCount >= activeLimit or placementBlocked then
if hasWeakerPlaced then
local sell = weakestPlacedIndex > protectedCount and policySellsGnome(weakestPlaced)
acted = removePlacedGnome(weakestPlaced, sell)
if acted then
Runtime.GnomePlaceBlockedUntil[tool] = nil
autoPlaceRetryAt[tool] = nil
end
end
elseif autoPlacePending[tool] then
acted = true
else
acted = tryAutoPlace(tool)
end
end
if not acted then
local victims = {}
for index = #ranked, protectedCount + 1, -1 do
local record = ranked[index]
if policySellsGnome(record) then
if record.Kind == "Worker" then
removePlacedGnome(record, true)
break
elseif record.Kind == "Tool" and record.Instance and record.Instance.Parent then
table.insert(victims, record.Instance)
if #victims >= 8 then
break
end
end
end
end
if #victims > 0 then
local soldCount = sellInventoryGnomeBatch(victims)
if soldCount > 0 then
Runtime.Stats.Sold = Runtime.Stats.Sold + soldCount
end
end
end
end
task.wait(State.AutoBest30 and 0.55 or 1.5)
end
end)
local itemPending = setmetatable({}, { __mode = "k" })
local itemRetryAt = setmetatable({}, { __mode = "k" })
Runtime.ItemTargetRetry = setmetatable({}, { __mode = "k" })
Runtime.UseItemInfoCache = setmetatable({}, { __mode = "k" })
Runtime.ItemFailureCount = setmetatable({}, { __mode = "k" })
Runtime.ItemPlacementRejected = setmetatable({}, { __mode = "k" })
local function getUseItemInfo(tool)
if not tool then
return "", "", {}
end
local cached = Runtime.UseItemInfoCache[tool]
if cached then
return cached.Name, cached.Type, cached.Config
end
local name = tostring(tool:GetAttribute("ItemName") or tool:GetAttribute("SprinklerName")
or tool:GetAttribute("FertilizerName") or tool:GetAttribute("WateringCanName")
or tool:GetAttribute("GnomeItemName") or tool.Name)
local shopData = (ItemShop.Items or {})[name] or {}
if next(shopData) == nil then
local loweredName = string.lower(name)
local matchedName = ""
for configuredName in pairs(ItemShop.Items or {}) do
local loweredConfigured = string.lower(tostring(configuredName))
if (loweredName == loweredConfigured or string.find(loweredName, loweredConfigured, 1, true))
and #loweredConfigured > #matchedName
then
name = tostring(configuredName)
matchedName = loweredConfigured
end
end
shopData = (ItemShop.Items or {})[name] or {}
end
local lowered = string.lower(tostring(tool:GetAttribute("type") or tool:GetAttribute("Type")
or shopData.type or ""))
local compactType = string.gsub(lowered, "[%s_%-]", "")
local itemType = ""
if compactType == "sprinkler" or compactType == "sprikler" then
itemType = "Sprinkler"
elseif compactType == "fertilizer" or compactType == "fertiliser" then
itemType = "Fertilizer"
elseif compactType == "wateringcan" or compactType == "watercan" then
itemType = "WateringCan"
elseif compactType == "gnomeitem" then
itemType = "GnomeItem"
else
itemType = tostring(shopData.type or "")
end
local config = itemType == "Sprinkler" and SprinklersConfig[name]
or itemType == "Fertilizer" and Runtime.FertilizersConfig[name]
or itemType == "WateringCan" and Runtime.WateringCansConfig[name]
or itemType == "GnomeItem" and Runtime.GnomeItemsConfig[name]
or {}
if itemType ~= "" then
Runtime.UseItemInfoCache[tool] = { Name = name, Type = itemType, Config = config or {} }
end
return name, itemType, config or {}
end
local function isUseItemTool(tool)
if not tool or not tool:IsA("Tool") then
return false
end
local _, itemType = getUseItemInfo(tool)
return itemType == "Sprinkler" or itemType == "Fertilizer"
or itemType == "WateringCan" or itemType == "GnomeItem"
end
local function getPlantRecord(plant)
local plantName = tostring(plant:GetAttribute("PlantName") or plant:GetAttribute("FruitName") or plant.Name)
local config = PlantsConfig[plantName] or {}
local score = tonumber(config.sell_price) or tonumber(config.order) or 0
local mutations = tostring(plant:GetAttribute("Mutations") or "")
for mutation in string.gmatch(mutations, "[^_]+") do
score = score * (MutationMultipliers[mutation] or 1)
end
local ok, pivot = pcall(getInstancePivot, plant)
if not ok or not pivot then
return nil
end
return {
Instance = plant,
Position = pivot.Position,
Score = score,
Radius = tonumber(plant:GetAttribute("PlantRadius")) or tonumber(config.plant_radius) or 1,
}
end
Runtime.PlantRecordCache = nil
local function collectPlantRecords(plot)
local cached = Runtime.PlantRecordCache
if cached and cached.Plot == plot and cached.Until > os.clock() then
return cached.Records
end
local records = {}
local seen = {}
for _, container in ipairs({ plot:FindFirstChild("Plants"), plot:FindFirstChild("ReadyToCollect") }) do
if container then
for _, plant in ipairs(container:GetChildren()) do
if not seen[plant] then
seen[plant] = true
local record = getPlantRecord(plant)
if record then
table.insert(records, record)
end
end
end
end
end
table.sort(records, function(a, b)
return a.Score > b.Score
end)
Runtime.PlantRecordCache = { Plot = plot, Until = os.clock() + 0.5, Records = records }
return records
end
Runtime.AreaItemCache = nil
local function collectPlacedAreaItems(plot)
local cached = Runtime.AreaItemCache
if cached and cached.Plot == plot and cached.Until > os.clock() then
return cached.Records
end
local records = {}
for _, containerName in ipairs({ "Sprinklers", "Fertilizer" }) do
local container = plot:FindFirstChild(containerName)
if container then
for _, item in ipairs(container:GetChildren()) do
local _, itemType, config = getUseItemInfo(item)
local ok, pivot = pcall(getInstancePivot, item)
if ok and pivot then
table.insert(records, {
Effect = tostring(config.type or itemType),
Position = pivot.Position,
Range = tonumber(config.range) or tonumber(item:GetAttribute("Range")) or 8,
Order = tonumber(config.order) or 0,
})
end
end
end
end
Runtime.AreaItemCache = { Plot = plot, Until = os.clock() + 0.5, Records = records }
return records
end
Runtime.SmartPlacementOffsets = {
Vector3.new(4, 0, 0),
Vector3.new(-4, 0, 0),
Vector3.new(0, 0, 4),
Vector3.new(0, 0, -4),
Vector3.new(3, 0, 3),
Vector3.new(-3, 0, 3),
Vector3.new(3, 0, -3),
Vector3.new(-3, 0, -3),
}
local function findSmartAreaPlacement(tool)
local plot = getPlot()
local ground = plot and plot:FindFirstChild("Ground")
if not plot or not ground then
return nil
end
local plants = collectPlantRecords(plot)
if #plants == 0 then
return nil
end
local _, itemType, config = getUseItemInfo(tool)
if itemType ~= "Sprinkler" and itemType ~= "Fertilizer" then
return nil
end
local currentRange = tonumber(config.range) or 8
local currentOrder = tonumber(config.order) or 0
local currentEffect = tostring(config.type or itemType)
local existing = collectPlacedAreaItems(plot)
local rejected = Runtime.ItemPlacementRejected[tool] or {}
local blockedPositions = {}
local workers = plot:FindFirstChild("Workers")
if workers then
for _, worker in ipairs(workers:GetChildren()) do
local ok, pivot = pcall(getInstancePivot, worker)
if ok and pivot then
table.insert(blockedPositions, pivot.Position)
end
end
end
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Include
raycastParams.FilterDescendantsInstances = { ground }
raycastParams.IgnoreWater = true
if itemType == "Fertilizer" then
for _, targetPlant in ipairs(plants) do
local covered = false
for _, placed in ipairs(existing) do
local dx = targetPlant.Position.X - placed.Position.X
local dz = targetPlant.Position.Z - placed.Position.Z
if placed.Effect == currentEffect and placed.Order >= currentOrder
and dx * dx + dz * dz <= placed.Range * placed.Range
then
covered = true
break
end
end
if not covered then
local hit = workspace:Raycast(
targetPlant.Position + Vector3.new(0, 30, 0),
Vector3.new(0, -80, 0),
raycastParams
)
if hit then
return CFrame.lookAt(hit.Position, hit.Position + Vector3.new(0, 0, -1)),
getFloorId(hit.Instance, ground)
end
end
end
end
local best
local evaluated = 0
for plantIndex = 1, math.min(#plants, 6) do
local targetPlant = plants[plantIndex]
for _, offset in ipairs(Runtime.SmartPlacementOffsets) do
local offsetScale = math.max(1, (targetPlant.Radius + 1.5) / math.max(offset.Magnitude, 0.01))
local wantedPosition = targetPlant.Position + offset * offsetScale
local hit = workspace:Raycast(wantedPosition + Vector3.new(0, 30, 0), Vector3.new(0, -80, 0), raycastParams)
if hit then
local valid = true
for _, plant in ipairs(plants) do
local dx = hit.Position.X - plant.Position.X
local dz = hit.Position.Z - plant.Position.Z
local minimum = plant.Radius + 1.35
if dx * dx + dz * dz < minimum * minimum then
valid = false
break
end
end
if valid then
for _, position in ipairs(blockedPositions) do
local dx = hit.Position.X - position.X
local dz = hit.Position.Z - position.Z
if dx * dx + dz * dz < 6.25 then
valid = false
break
end
end
end
if valid then
for _, placed in ipairs(existing) do
local dx = hit.Position.X - placed.Position.X
local dz = hit.Position.Z - placed.Position.Z
local minimumSpacing = (currentRange + placed.Range) * 0.6
if placed.Effect == currentEffect and placed.Order >= currentOrder
and dx * dx + dz * dz < minimumSpacing * minimumSpacing
then
valid = false
break
end
end
end
if valid then
for rejectedIndex = #rejected, 1, -1 do
local failed = rejected[rejectedIndex]
if failed.Until <= os.clock() then
table.remove(rejected, rejectedIndex)
else
local dx = hit.Position.X - failed.Position.X
local dz = hit.Position.Z - failed.Position.Z
if dx * dx + dz * dz < 9 then
valid = false
break
end
end
end
end
if valid then
local coverageScore = 0
for _, plant in ipairs(plants) do
local dx = hit.Position.X - plant.Position.X
local dz = hit.Position.Z - plant.Position.Z
if dx * dx + dz * dz <= currentRange * currentRange then
coverageScore = coverageScore + plant.Score
end
end
local score = coverageScore + targetPlant.Score * 2 - plantIndex * 0.001
if not best or score > best.Score then
best = {
Score = score,
CFrame = CFrame.lookAt(hit.Position, hit.Position + Vector3.new(0, 0, -1)),
FloorId = getFloorId(hit.Instance, ground),
}
end
end
end
evaluated = evaluated + 1
if evaluated % 4 == 0 then
task.wait()
end
end
end
return best and best.CFrame, best and best.FloorId
end
local function findWaterTarget()
local plot = getPlot()
if not plot then
return nil
end
for _, record in ipairs(collectPlantRecords(plot)) do
local ready = record.Instance:GetAttribute("READY") == true
and record.Instance:GetAttribute("FruitReady") ~= false
if not ready
and (Runtime.ItemTargetRetry[record.Instance] or 0) <= os.clock()
then
return record.Instance
end
end
end
local function findCoffeeTarget()
local ranked = getRankedGnomes()
local protectedCount = State.AutoBest30 and math.min(getBestGnomeLimit(), #ranked) or #ranked
for index, record in ipairs(ranked) do
if index <= protectedCount and record.Kind == "Worker"
and (Runtime.ItemTargetRetry[record.Instance] or 0) <= os.clock()
then
local worker = record.Instance
local hasCoffee = worker:GetAttribute("HasCoffee") == true
or worker:FindFirstChild("CoffeeTrail") ~= nil
local gnomeSpeed = tonumber(worker:GetAttribute("GnomeSpeed"))
local isBoosted = hasCoffee or (gnomeSpeed and gnomeSpeed > 1)
if not isBoosted then
return worker
end
end
end
end
Runtime.GetUseTargetSignature = function(instance)
if not instance then
return ""
end
local values = {}
for _, attribute in ipairs({
"READY", "FruitReady", "GrowthSpeedMulti", "GrowthSpeedStartTime",
"GrowthStartTime", "GrowthElapsedOffset", "SecondsUntilReady", "TotalGrowTime",
"NextHarvest", "NextPlant", "FinishTime", "GrowTime", "TimeLeft", "GnomeSpeed",
}) do
table.insert(values, tostring(instance:GetAttribute(attribute)))
end
return table.concat(values, "|")
end
Runtime.GetToolItemId = function(tool)
local id = tool and (tool:GetAttribute("Id") or tool:GetAttribute("ID") or tool:GetAttribute("id"))
if id ~= nil then
return id
end
local value = tool and (tool:FindFirstChild("Id") or tool:FindFirstChild("ID"))
return value and value:IsA("ValueBase") and value.Value or nil
end
Runtime.CountPlacedUseItems = function(itemType)
local plot = getPlot()
local folderName = itemType == "Sprinkler" and "Sprinklers"
or itemType == "Fertilizer" and "Fertilizer"
local folder = folderName and plot and plot:FindFirstChild(folderName)
return folder and #folder:GetChildren() or 0
end
local function tryUseItem(tool)
if not Runtime.Alive or not State.AutoUseItems or not isUseItemTool(tool)
or Runtime.ItemActionActive or itemPending[tool] or (itemRetryAt[tool] or 0) > os.clock()
then
return false
end
local itemName, itemType = getUseItemInfo(tool)
if not isSelected(State.UseItemTargets, itemName) then
return false
end
local target, placeCFrame, floorId
if itemType == "WateringCan" then
target = findWaterTarget()
elseif itemType == "GnomeItem" then
target = findCoffeeTarget()
else
placeCFrame, floorId = findSmartAreaPlacement(tool)
end
if (itemType == "WateringCan" or itemType == "GnomeItem") and not target then
itemRetryAt[tool] = os.clock() + 0.5
Runtime.SetUseItemStatus(itemName .. " | NO TARGET")
return false
elseif (itemType == "Sprinkler" or itemType == "Fertilizer") and not placeCFrame then
itemRetryAt[tool] = os.clock() + 1
Runtime.SetUseItemStatus(itemName .. " | NO VALID AREA")
return false
end
local groups = itemType == "WateringCan" and { "Equipment", "Movement", "Farm" }
or itemType == "GnomeItem" and { "Equipment", "Movement", "Gnome" }
or { "Equipment", "Movement", "Farm" }
if not Runtime.ReserveAction("UseItem", groups, 3, 20) then
return false
end
itemPending[tool] = true
Runtime.ItemActionActive = true
Runtime.ItemActionActiveAt = os.clock()
task.spawn(function()
local actionOk, confirmed, attempted = Runtime.WithAction("UseItem", groups, function()
if not State.AutoUseItems or not tool.Parent or not isSelected(State.UseItemTargets, itemName) then
return false, false
end
local character = LocalPlayer.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
local rootPart = character and character:FindFirstChild("HumanoidRootPart")
local returnPivot = character and character:GetPivot()
local previouslyEquipped = character and character:FindFirstChildWhichIsA("Tool")
local equipped = Runtime.EquipToolConfirmed(tool)
if equipped then
task.wait(Runtime.Mobile and 0.25 or 0.1)
end
local actionCFrame = placeCFrame
if target and target.Parent then
local pivotOk, pivot = pcall(getInstancePivot, target)
actionCFrame = pivotOk and pivot or actionCFrame
end
local targetSignature = Runtime.GetUseTargetSignature(target)
local placedBefore = Runtime.CountPlacedUseItems(itemType)
local toolUsesBefore = tostring(tool:GetAttribute("Uses") or tool:GetAttribute("Charges")
or tool:GetAttribute("Amount"))
local function useWasConfirmed()
local toolUsesNow = tostring(tool:GetAttribute("Uses") or tool:GetAttribute("Charges")
or tool:GetAttribute("Amount"))
return not tool.Parent
or toolUsesNow ~= toolUsesBefore
or (target and target.Parent
and Runtime.GetUseTargetSignature(target) ~= targetSignature)
or Runtime.CountPlacedUseItems(itemType) > placedBefore
end
local moved = false
if actionCFrame and character and rootPart
and (rootPart.Position - actionCFrame.Position).Magnitude > 4
then
moved = pcall(function()
character:PivotTo(actionCFrame * CFrame.new(0, 2, 1))
rootPart.AssemblyLinearVelocity = Vector3.zero
rootPart.AssemblyAngularVelocity = Vector3.zero
end)
task.wait(Runtime.Mobile and 0.25 or 0.12)
end
local didAttempt = false
local wasConfirmed = false
if equipped and character and tool.Parent == character and State.AutoUseItems then
if itemType == "WateringCan" and target and target.Parent then
didAttempt = fire("WaterPlant", target)
elseif itemType == "GnomeItem" and target and target.Parent then
local itemId = Runtime.GetToolItemId(tool)
local identifiers, seenIdentifiers = {}, {}
local function addIdentifier(identifier)
if identifier == nil then
return
end
local key = typeof(identifier) == "Instance" and identifier or tostring(identifier)
if key ~= "" and not seenIdentifiers[key] then
seenIdentifiers[key] = true
table.insert(identifiers, identifier)
end
end
addIdentifier(itemId)
addIdentifier(tool:GetAttribute("ItemName"))
addIdentifier(tool:GetAttribute("GnomeItemName"))
addIdentifier(itemName)
addIdentifier(tool.Name)
addIdentifier(tool)
for _, identifier in ipairs(identifiers) do
local sent = fire("GiveFarmerItem", target, identifier)
didAttempt = sent or didAttempt
if sent then
local attemptDeadline = os.clock() + 0.75
repeat
task.wait(0.1)
wasConfirmed = useWasConfirmed()
until wasConfirmed or os.clock() >= attemptDeadline
or not Runtime.Alive or not tool.Parent
end
if wasConfirmed or not tool.Parent then
break
end
end
elseif placeCFrame then
didAttempt = fire("Place", itemType, itemName, placeCFrame, floorId or "1")
end
end
if didAttempt and not wasConfirmed then
local deadline = os.clock() + (Runtime.Mobile and 1.8 or 1.3)
repeat
task.wait(0.1)
wasConfirmed = useWasConfirmed()
until wasConfirmed or os.clock() >= deadline or not Runtime.Alive
if target then
Runtime.ItemTargetRetry[target] = os.clock() + (wasConfirmed and 5 or 2)
end
if wasConfirmed and (itemType == "Sprinkler" or itemType == "Fertilizer") then
Runtime.Stats.Placed = Runtime.Stats.Placed + 1
end
end
if returnPivot and moved and character == LocalPlayer.Character and character.Parent then
character:PivotTo(returnPivot)
if rootPart and rootPart.Parent then
rootPart.AssemblyLinearVelocity = Vector3.zero
rootPart.AssemblyAngularVelocity = Vector3.zero
end
end
if humanoid and humanoid.Parent then
if tool.Parent == character then
pcall(function()
humanoid:UnequipTools()
end)
end
if previouslyEquipped and previouslyEquipped ~= tool and previouslyEquipped.Parent == getBackpack() then
pcall(function()
humanoid:EquipTool(previouslyEquipped)
end)
end
end
return wasConfirmed, didAttempt == true
end)
itemPending[tool] = nil
Runtime.ItemActionActive = false
Runtime.ItemActionActiveAt = nil
local waitingForTurn = not actionOk and confirmed == "busy"
if not waitingForTurn then
Runtime.ClearActionReservation("UseItem")
end
if actionOk and confirmed == true then
Runtime.ItemFailureCount[tool] = nil
Runtime.ItemPlacementRejected[tool] = nil
itemRetryAt[tool] = nil
Runtime.SetUseItemStatus("USED " .. itemName, true)
elseif waitingForTurn and tool.Parent then
itemRetryAt[tool] = os.clock() + 0.15
Runtime.SetUseItemStatus(itemName .. " | WAITING FOR TURN")
elseif tool.Parent then
local failures = (Runtime.ItemFailureCount[tool] or 0) + 1
Runtime.ItemFailureCount[tool] = failures
if actionOk and attempted and placeCFrame
and (itemType == "Sprinkler" or itemType == "Fertilizer")
then
local rejected = Runtime.ItemPlacementRejected[tool] or {}
table.insert(rejected, { Position = placeCFrame.Position, Until = os.clock() + 20 })
while #rejected > 4 do
table.remove(rejected, 1)
end
Runtime.ItemPlacementRejected[tool] = rejected
end
itemRetryAt[tool] = os.clock() + math.min(1 + failures * 0.5, 4)
Runtime.SetUseItemStatus(
itemName .. " | " .. (not actionOk and tostring(confirmed):upper()
or attempted and "SERVER REJECTED"
or "EQUIP/ID FAILED"),
false
)
end
end)
return true
end
task.spawn(function()
while Runtime.Alive do
if not State.AutoUseItems then
if Runtime.LastUseItemResult ~= "IDLE" then
Runtime.SetUseItemStatus("IDLE")
end
elseif not Runtime.HasAnySelection(State.UseItemTargets) then
Runtime.SetUseItemStatus("SELECT AN ITEM", false)
elseif not Runtime.ItemActionActive
or (Runtime.ItemActionActiveAt and os.clock() - Runtime.ItemActionActiveAt > 8)
then
if Runtime.ItemActionActiveAt and os.clock() - Runtime.ItemActionActiveAt > 8 then
Runtime.ItemActionActive = false
Runtime.ItemActionActiveAt = nil
end
local candidates = {}
local now = os.clock()
for _, container in ipairs({ getBackpack(), LocalPlayer.Character }) do
if container then
for _, tool in ipairs(container:GetChildren()) do
local itemName, itemType = getUseItemInfo(tool)
if (itemType == "Sprinkler" or itemType == "Fertilizer"
or itemType == "WateringCan" or itemType == "GnomeItem")
and isSelected(State.UseItemTargets, itemName)
and not itemPending[tool] and (itemRetryAt[tool] or 0) <= now
then
table.insert(candidates, tool)
end
end
end
end
table.sort(candidates, function(a, b)
local nameA = getUseItemInfo(a)
local nameB = getUseItemInfo(b)
return (tonumber(((ItemShop.Items or {})[nameA] or {}).order) or 0)
> (tonumber(((ItemShop.Items or {})[nameB] or {}).order) or 0)
end)
for _, tool in ipairs(candidates) do
if tryUseItem(tool) then
break
end
end
end
task.wait(State.AutoUseItems and 0.4 or 1.5)
end
end)
local function isGiftableTool(tool)
if not tool or not tool:IsA("Tool") or type(tool:GetAttribute("Id")) ~= "string" then
return false
end
local itemType = string.lower(tostring(tool:GetAttribute("type") or ""))
return itemType == "plant" or itemType == "fruit" or itemType == "farmer" or itemType == "gnome"
end
Runtime.IsTrustedGiftMessage = function(message)
if not State.AutoReceiveGift or type(message) ~= "string" then
return false
end
local clean = string.lower(message):gsub("<.->", ""):gsub("@", ""):gsub("%s+", " ")
local sender = clean:match("^%s*(.-)%s+wants%s+to%s+gift%s+you[%s%p]")
or clean:match("^%s*(.-)%s+wants%s+to%s+gift%s+you$")
if not sender then
return false
end
sender = sender:gsub("^%s+", ""):gsub("%s+$", "")
for _, player in ipairs(Players:GetPlayers()) do
if player ~= LocalPlayer and isSelected(State.ReceivePlayers, player.Name) then
local name = string.lower(player.Name)
local displayName = string.lower(player.DisplayName)
if sender == name or sender == displayName
or sender == displayName .. " (" .. name .. ")"
or sender == name .. " (" .. displayName .. ")"
then
Runtime.LastGiftSender = player.Name
return true
end
end
end
return false
end
local function installGiftPromptWrapper()
if _G.AreYouSure == Runtime.GiftPromptWrapper then
return true
end
if type(_G.AreYouSure) ~= "function" then
return false
end
local original = _G.AreYouSure
local wrapper
wrapper = function(options, ...)
if type(options) == "table" and Runtime.IsTrustedGiftMessage(options.Message)
and type(options.Callback) == "function"
then
local accepted = pcall(options.Callback, true)
if accepted then
Runtime.LastGiftReceive = "accepted callback"
return
end
end
return original(options, ...)
end
Runtime.OriginalGiftPrompt = original
Runtime.GiftPromptWrapper = wrapper
local assigned = pcall(function()
_G.AreYouSure = wrapper
end)
Runtime.GiftPromptInstalled = assigned and _G.AreYouSure == wrapper
return Runtime.GiftPromptInstalled
end
Runtime.TryAcceptVisibleGift = function()
local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
local tabs = playerGui and playerGui:FindFirstChild("Tabs")
local prompt = tabs and tabs:FindFirstChild("Are You Sure")
or playerGui and playerGui:FindFirstChild("Are You Sure", true)
if not prompt or not prompt.Enabled then
return false
end
local menu = prompt:FindFirstChild("Menu")
local frame = menu and menu:FindFirstChild("Frame")
local desc = frame and frame:FindFirstChild("Desc")
local buttons = frame and frame:FindFirstChild("Buttons")
local yesFrame = buttons and buttons:FindFirstChild("Yes")
local button = yesFrame and yesFrame:FindFirstChild("Button")
local textOk, message = pcall(function()
return desc and desc.Text
end)
if not textOk or type(message) ~= "string" or not button or not button:IsA("GuiButton")
or not Runtime.IsTrustedGiftMessage(message) then
return false
end
local now = os.clock()
if Runtime.LastGiftButton == button and now - (Runtime.LastGiftClickAt or 0) < 1 then
return false
end
Runtime.LastGiftButton = button
Runtime.LastGiftClickAt = now
local accepted = false
if type(firesignal) == "function" then
accepted = pcall(firesignal, button.MouseButton1Click)
elseif type(getconnections) == "function" then
local ok, connections = pcall(function() return getconnections(button.MouseButton1Click) end)
if ok then
for _, connection in ipairs(connections) do
if type(connection.Fire) == "function" then
accepted = pcall(function() if type(connection.Fire) == "function" then connection:Fire() end end) or accepted
end
end
end
end
if not accepted then
accepted = pcall(function()
button:Activate()
end)
end
Runtime.LastGiftReceive = accepted and "accepted visible prompt" or "accept API unavailable"
return accepted
end
task.spawn(function()
while Runtime.Alive do
installGiftPromptWrapper()
if State.AutoReceiveGift then
Runtime.TryAcceptVisibleGift()
end
task.wait(State.AutoReceiveGift and 0.15 or 1.5)
end
end)
local lastGiftAttempt = setmetatable({}, { __mode = "k" })
task.spawn(function()
while Runtime.Alive do
if State.AutoGive and not Runtime.Gifting then
local character = LocalPlayer.Character
local heldTool = character and character:FindFirstChildWhichIsA("Tool")
local recipient = Runtime.GetGiftRecipient()
if isGiftableTool(heldTool)
and recipient
and not (State.AutoSellProduce
and Runtime.IsProduceTool(heldTool)
and Runtime.IsSelectedProduceMutation(heldTool))
and not autoPlacePending[heldTool]
and not best30Selling[heldTool]
and not itemPending[heldTool]
and heldTool ~= Runtime.SellingProduceTool
and not (State.AutoBest30 and isProtectedGnome(heldTool))
then
local lastAttempt = lastGiftAttempt[heldTool] or 0
if os.clock() - lastAttempt >= 2 then
local actionToken = Runtime.BeginAction("Give", { "Movement", "Equipment" })
if actionToken then
lastGiftAttempt[heldTool] = os.clock()
Runtime.Gifting = true
task.spawn(function()
pcall(function()
local giverCharacter = LocalPlayer.Character
local giverRoot = giverCharacter and giverCharacter:FindFirstChild("HumanoidRootPart")
local recipientCharacter = recipient.Character
local recipientRoot = recipientCharacter and recipientCharacter:FindFirstChild("HumanoidRootPart")
local returnPivot = giverCharacter and giverCharacter:GetPivot()
if giverCharacter and giverRoot and recipientRoot then
giverCharacter:PivotTo(recipientRoot.CFrame * CFrame.new(0, 0, 3))
giverRoot.AssemblyLinearVelocity = Vector3.zero
giverRoot.AssemblyAngularVelocity = Vector3.zero
task.wait(0.2)
end
if heldTool.Parent and State.AutoGive then
fire("RequestGiftItem", recipient, heldTool:GetAttribute("Id"))
local deadline = os.clock() + 1.5
repeat
task.wait(0.1)
until not heldTool.Parent or os.clock() >= deadline or not Runtime.Alive
end
if returnPivot and giverCharacter == LocalPlayer.Character and giverCharacter.Parent then
giverCharacter:PivotTo(returnPivot)
if giverRoot and giverRoot.Parent then
giverRoot.AssemblyLinearVelocity = Vector3.zero
giverRoot.AssemblyAngularVelocity = Vector3.zero
end
end
end)
Runtime.EndAction(actionToken)
Runtime.Gifting = false
end)
end
end
end
end
task.wait(State.AutoGive and 0.3 or 1.2)
end
end)
local boughtPreview = setmetatable({}, { __mode = "k" })
Runtime.PreviewMutationCache = setmetatable({}, { __mode = "k" })
local function hasSelectedMutation(instance)
local mutations = tostring(instance:GetAttribute("Mutations") or instance:GetAttribute("Mutation") or "")
local cached = Runtime.PreviewMutationCache[instance]
if cached and cached.Raw == mutations and cached.Version == Runtime.SelectionVersion then
return cached.Result
end
local result = false
local cleaned = string.gsub(mutations, "%s*[,|+]%s*", "_")
if cleaned == "" or string.lower(cleaned) == "none" or string.lower(cleaned) == "normal" then
result = isSelected(State.MutationTargets, "Normal")
else
for mutation in string.gmatch(cleaned, "[^_]+") do
mutation = string.match(mutation, "^%s*(.-)%s*$")
if mutation and mutation ~= "" and isSelected(State.MutationTargets, mutation) then
result = true
break
end
end
end
Runtime.PreviewMutationCache[instance] = {
Raw = mutations,
Version = Runtime.SelectionVersion,
Result = result,
}
return result
end
Runtime.NeedsRebirthGnome = function(instance)
if not State.AutoBuyRebirthGnomes and not State.AutoRebirth then
return false
end
local stats = type(Replication.Data) == "table" and Replication.Data.stats or {}
local rebirth = Runtime.GetRebirthCount and Runtime.GetRebirthCount()
or tonumber(LocalPlayer:GetAttribute("rebirth") or LocalPlayer:GetAttribute("rebirths")
or stats.rebirth or stats.rebirths) or 0
local config = RebirthConfig["Rebirth" .. tostring(rebirth + 1)]
local required = type(config) == "table" and config.requirements and config.requirements.gnomes or {}
local discovered = type(Replication.Data) == "table" and Replication.Data.discovered or {}
local farmerName = getFarmerName(instance)
for _, name in ipairs(required or {}) do
if name == farmerName and discovered[name] ~= true and table.find(discovered, name) == nil then
return true
end
end
return false
end
local function isWantedPreview(instance)
if not instance then
return false
end
if Runtime.NeedsRebirthGnome and Runtime.NeedsRebirthGnome(instance) then
return true
end
local hasRarityFilter = State.AutoBuyTarget and Runtime.HasAnySelection(State.BuyRarityTargets)
local hasMutationFilter = State.AutoBuyMutation and Runtime.HasAnySelection(State.MutationTargets)
if hasRarityFilter and hasMutationFilter then
local rarityMatch = isSelected(State.BuyRarityTargets, getFarmerRarity(instance))
local mutationMatch = hasSelectedMutation(instance)
return rarityMatch and mutationMatch
elseif hasRarityFilter then
return isSelected(State.BuyRarityTargets, getFarmerRarity(instance))
elseif hasMutationFilter then
return hasSelectedMutation(instance)
end
return false
end
Runtime.IsWantedPreview = isWantedPreview
Runtime.GetRebirthCount = function()
local stats = type(Replication.Data) == "table" and Replication.Data.stats or {}
return tonumber(LocalPlayer:GetAttribute("rebirth") or LocalPlayer:GetAttribute("rebirths")
or stats.rebirth or stats.rebirths) or 0
end
Runtime.GetNextRebirthData = function()
return RebirthConfig["Rebirth" .. tostring(Runtime.GetRebirthCount() + 1)]
end
Runtime.CanSpendAfterRebirthReserve = function(price)
local pending = Runtime.PendingPurchase
if State.RollPriority == "TargetFirst" and pending and pending.Parent then
return false
end
if not State.AutoRebirth then
return true
end
local data = Runtime.GetNextRebirthData()
local requiredMoney = type(data) == "table" and type(data.requirements) == "table"
and tonumber(data.requirements.money) or 0
return getPlayerMoney() - math.max(0, tonumber(price) or 0) >= requiredMoney
end
local function getPreviewPrice(instance)
Runtime.PreviewPriceCache = Runtime.PreviewPriceCache or setmetatable({}, { __mode = "k" })
local farmerName = getFarmerName(instance)
local mutations = tostring(instance:GetAttribute("Mutations") or instance:GetAttribute("Mutation") or "")
local huge = instance:GetAttribute("Huge") == true
local cached = Runtime.PreviewPriceCache[instance]
if cached and cached.Name == farmerName and cached.Mutations == mutations and cached.Huge == huge then
return cached.Price
end
local config = FarmersConfig[farmerName]
local price = type(config) == "table" and tonumber(config.price) or nil
if not price then
return nil
end
for mutation in string.gmatch(mutations, "[^_]+") do
price = price * (MutationMultipliers[mutation] or 1)
end
if huge then
price = price * 1.5
end
price = math.floor(price)
Runtime.PreviewPriceCache[instance] = {
Name = farmerName,
Mutations = mutations,
Huge = huge,
Price = price,
}
return price
end
local function clearPendingPurchase()
Runtime.PendingPurchase = nil
Runtime.WaitingForMoney = false
Runtime.PendingPurchasePrice = 0
end
local function tryBuyPreview(instance)
if not Runtime.Alive or not instance or not instance.Parent then
return
end
if not isWantedPreview(instance) then
return
end
local price = getPreviewPrice(instance)
local neededForRebirth = Runtime.NeedsRebirthGnome(instance)
local targetFirst = State.RollPriority == "TargetFirst"
if not neededForRebirth and not targetFirst and not Runtime.CanSpendAfterRebirthReserve(price) then
if Runtime.PendingPurchase == instance then
clearPendingPurchase()
end
return
end
if price and getPlayerMoney() < price then
if State.PauseRollUntilAffordable then
Runtime.PendingPurchase = instance
Runtime.PendingPurchasePrice = price
Runtime.WaitingForMoney = true
elseif Runtime.PendingPurchase == instance then
clearPendingPurchase()
end
return
end
if targetFirst or State.PauseRollUntilAffordable then
Runtime.PendingPurchase = instance
Runtime.PendingPurchasePrice = price or 0
Runtime.WaitingForMoney = false
elseif Runtime.PendingPurchase == instance then
clearPendingPurchase()
end
local lastAttempt = boughtPreview[instance] or 0
if os.clock() - lastAttempt < 0.8 then
return
end
if Runtime.RebirthReady and Runtime.RebirthReady() then
return
end
local actionToken = Runtime.BeginAction("BuyGnome", { "Economy" })
if not actionToken then
return
end
price = getPreviewPrice(instance)
neededForRebirth = Runtime.NeedsRebirthGnome(instance)
targetFirst = State.RollPriority == "TargetFirst"
if (not neededForRebirth and not targetFirst and not Runtime.CanSpendAfterRebirthReserve(price))
or (price and getPlayerMoney() < price)
then
Runtime.EndAction(actionToken)
if price and getPlayerMoney() < price and State.PauseRollUntilAffordable then
Runtime.PendingPurchase = instance
Runtime.PendingPurchasePrice = price
Runtime.WaitingForMoney = true
elseif Runtime.PendingPurchase == instance then
clearPendingPurchase()
end
return
end
boughtPreview[instance] = os.clock()
if Runtime.IsBackpackNearFull() then
Runtime.EnsureBackpackSpace(1)
end
local ok = fire("BuyFarmer", instance)
if ok then
local deadline = os.clock() + 0.6
repeat
task.wait()
until not instance.Parent or os.clock() >= deadline or not Runtime.Alive
end
Runtime.EndAction(actionToken)
if ok and not instance.Parent then
Runtime.Stats.Bought = Runtime.Stats.Bought + 1
if Runtime.PendingPurchase == instance then
clearPendingPurchase()
end
end
end
local watchedPreview
local previewConnection
local function watchPreview()
local plot = getPlot()
local rng = plot and plot:FindFirstChild("RNG")
local preview = rng and rng:FindFirstChild("Preview")
if preview == watchedPreview then
return
end
if previewConnection then
previewConnection:Disconnect()
previewConnection = nil
end
watchedPreview = preview
if preview then
previewConnection = connect(preview.ChildAdded, function(child)
task.delay(0.05, tryBuyPreview, child)
end)
for _, child in ipairs(preview:GetChildren()) do
task.defer(tryBuyPreview, child)
end
end
end
task.spawn(function()
while Runtime.Alive do
watchPreview()
local plot = getPlot()
local rng = plot and plot:FindFirstChild("RNG")
local preview = rng and rng:FindFirstChild("Preview")
local pending = Runtime.PendingPurchase
if pending and (not pending.Parent or not isWantedPreview(pending)) then
clearPendingPurchase()
end
if preview and (State.AutoBuyTarget or State.AutoBuyMutation or State.AutoBuyRebirthGnomes or State.AutoRebirth) then
for _, child in ipairs(preview:GetChildren()) do
tryBuyPreview(child)
end
end
task.wait((State.AutoBuyTarget or State.AutoBuyMutation or State.AutoBuyRebirthGnomes or State.AutoRebirth
or Runtime.PendingPurchase ~= nil) and 0.5 or 1)
end
end)
task.spawn(function()
while Runtime.Alive do
local pending = Runtime.PendingPurchase
local waitingForTarget = pending and pending.Parent and isWantedPreview(pending)
local rebirthReady = Runtime.RebirthReady and Runtime.RebirthReady()
if State.AutoRoll and not waitingForTarget and not rebirthReady then
while Runtime.Alive and State.AutoRoll and LocalPlayer:GetAttribute("Rolling") do
task.wait(0.08)
end
if Runtime.Alive and State.AutoRoll then
local actionOk, ok, result = Runtime.WithAction("Roll", { "Roll" }, function()
return invoke("Roll")
end)
if actionOk and ok and result ~= false then
Runtime.Stats.Rolls = Runtime.Stats.Rolls + 1
end
end
task.wait(0.18)
else
task.wait(0.75)
end
end
end)
task.spawn(function()
local collecting = setmetatable({}, { __mode = "k" })
while Runtime.Alive do
local yieldForSale = false
if State.AutoSellProduce then
yieldForSale = Runtime.FindSelectedProduceBatch(1)[1] ~= nil or Runtime.IsBackpackNearFull()
if yieldForSale then
Runtime.ProduceSellPending = true
Runtime.ReserveAction("SellSelectedProduce", { "Movement", "Farm", "Equipment" }, 2)
end
end
local lease = Runtime.MovementLease
local leaseActive = lease and lease.Owner ~= "Collect" and os.clock() < lease.Until
if Runtime.IsBackpackNearFull() then
Runtime.PurgeInventoryOverflow()
end
if State.AutoCollect and not yieldForSale and not leaseActive then
Runtime.WithAction("Collect", { "Movement", "Farm" }, function()
local plot = getPlot()
local plants = plot and plot:FindFirstChild("Plants")
local readyToCollect = plot and plot:FindFirstChild("ReadyToCollect")
if plants or readyToCollect then
local character = LocalPlayer.Character
local rootPart = character and character:FindFirstChild("HumanoidRootPart")
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
local returnPivot = character and character:GetPivot() or nil
local didTeleport = false
local collectedThisPass = 0
local readyPlants = {}
local seenPlants = {}
for _, container in pairs({ plants, readyToCollect }) do
if container then
for _, plant in ipairs(container:GetChildren()) do
if not seenPlants[plant] then
seenPlants[plant] = true
table.insert(readyPlants, plant)
end
end
end
end
for _, plant in ipairs(readyPlants) do
local reserved = Runtime.PriorityAction
if not Runtime.Alive or not State.AutoCollect or collectedThisPass >= 4
or (reserved and reserved.Owner == "SellSelectedProduce")
then
break
end
local fruitReady = plant:GetAttribute("FruitReady") ~= false
if plant:GetAttribute("READY") == true and fruitReady and not collecting[plant] then
collecting[plant] = true
if character and rootPart and rootPart.Parent then
local center = plant:FindFirstChild("CenterPart", true)
local targetCFrame
if center and center:IsA("BasePart") then
targetCFrame = center.CFrame
else
local pivotOk, pivot = pcall(getInstancePivot, plant)
targetCFrame = pivotOk and pivot or nil
end
if targetCFrame then
if humanoid then
humanoid.Sit = false
end
character:PivotTo(targetCFrame * CFrame.new(0, 3, 0))
rootPart.AssemblyLinearVelocity = Vector3.zero
rootPart.AssemblyAngularVelocity = Vector3.zero
didTeleport = true
task.wait(0.1)
local deadline = os.clock() + 0.4
repeat
task.wait()
until LocalPlayer:GetAttribute("CanCollect") == true
or os.clock() >= deadline
or not Runtime.Alive
end
end
local ok, result = invoke("CollectPlant", plant)
collectedThisPass = collectedThisPass + 1
if ok and result ~= false then
Runtime.Stats.Collected = Runtime.Stats.Collected + 1
end
task.delay(0.6, function()
collecting[plant] = nil
end)
task.wait(0.08)
if State.AutoSellProduce and (Runtime.FindSelectedProduceBatch(1)[1] ~= nil or Runtime.IsBackpackNearFull()) then
Runtime.ProduceSellPending = true
Runtime.ReserveAction("SellSelectedProduce", { "Movement", "Farm", "Equipment" }, 2)
break
end
end
end
if didTeleport
and returnPivot
and character == LocalPlayer.Character
and character.Parent
and rootPart
and rootPart.Parent
then
character:PivotTo(returnPivot)
rootPart.AssemblyLinearVelocity = Vector3.zero
rootPart.AssemblyAngularVelocity = Vector3.zero
end
end
end)
end
task.wait(yieldForSale and 0.1 or State.AutoCollect and 0.25 or 1)
end
end)
task.spawn(function()
while Runtime.Alive do
local batch = {}
if State.AutoSellProduce or Runtime.IsBackpackNearFull() then
batch = Runtime.FindSelectedProduceBatch(15)
end
if batch[1] then
Runtime.ProduceSellPending = true
Runtime.ReserveAction("SellSelectedProduce", { "Movement", "Farm", "Equipment" }, 5, 50)
local actionOk, soldCount, result = Runtime.WithAction("SellSelectedProduce", { "Movement", "Farm", "Equipment" }, function()
local character = LocalPlayer.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
local rootPart = character and character:FindFirstChild("HumanoidRootPart")
local previous = character and character:FindFirstChildWhichIsA("Tool")
local returnPivot = character and character:GetPivot()
local sellCFrame = Runtime.GetSellPointCFrame()
local moved = false
local count = 0
local lastResponse = "no match"
if character and rootPart and sellCFrame
and (rootPart.Position - sellCFrame.Position).Magnitude > 8
then
moved = pcall(function()
character:PivotTo(sellCFrame * CFrame.new(0, 3, 5))
rootPart.AssemblyLinearVelocity = Vector3.zero
rootPart.AssemblyAngularVelocity = Vector3.zero
end)
task.wait(0.1)
end
local okAll, resAll = invoke("SellAll")
if okAll and type(resAll) == "number" and resAll > 0 then
count = #batch
Runtime.Stats.Sold = Runtime.Stats.Sold + count
lastResponse = "SellAll " .. tostring(resAll) .. "$"
else
for _, produce in ipairs(batch) do
if not Runtime.Alive or not (State.AutoSellProduce or Runtime.IsBackpackNearFull()) then
break
end
if produce.Parent and Runtime.IsProduceTool(produce)
and Runtime.IsSelectedProduceMutation(produce)
then
Runtime.SellingProduceTool = produce
local ok, response
local success = false
for attempt = 1, 4 do
local equipped = Runtime.EquipToolConfirmed(produce, attempt > 1)
if equipped then
ok, response = invoke("SellThis")
success = ok and type(response) == "number"
else
response = "equip failed"
end
if success or not produce.Parent then
break
end
task.wait(0.04)
end
if success then
count = count + 1
Runtime.Stats.Sold = Runtime.Stats.Sold + 1
elseif produce.Parent then
Runtime.ProduceSellRetry[produce] = os.clock() + 0.5
end
lastResponse = response
Runtime.SellingProduceTool = nil
end
end
end
if humanoid and humanoid.Parent then
pcall(function()
humanoid:UnequipTools()
end)
if previous and previous.Parent == getBackpack() then
pcall(function()
humanoid:EquipTool(previous)
end)
end
end
if moved and returnPivot and character == LocalPlayer.Character and character.Parent then
pcall(function()
character:PivotTo(returnPivot)
if rootPart and rootPart.Parent then
rootPart.AssemblyLinearVelocity = Vector3.zero
rootPart.AssemblyAngularVelocity = Vector3.zero
end
end)
end
Runtime.SellingProduceTool = nil
return count, lastResponse
end)
Runtime.SellingProduceTool = nil
Runtime.LastProduceSellResult = actionOk
and string.format("batch %d | %s", soldCount or 0, tostring(result))
or tostring(soldCount)
if actionOk then
Runtime.ProduceSellPending = false
Runtime.ClearActionReservation("SellSelectedProduce")
elseif soldCount ~= "busy" then
for _, produce in ipairs(batch) do
if produce.Parent then
Runtime.ProduceSellRetry[produce] = os.clock() + 1
end
end
Runtime.ProduceSellPending = false
Runtime.ClearActionReservation("SellSelectedProduce")
end
else
Runtime.ProduceSellPending = false
Runtime.ClearActionReservation("SellSelectedProduce")
end
task.wait(Runtime.ProduceSellPending and 0.1
or State.AutoSellProduce and 0.25
or 1.5)
end
end)
Runtime.TriggerGuiButton = function(button)
if not button or not button:IsA("GuiButton") then
return false
end
if type(firesignal) == "function" then
local ok = pcall(function() firesignal(button.MouseButton1Click) end)
if ok then
return true
end
end
if type(getconnections) == "function" then
local ok, connections = pcall(function() return getconnections(button.MouseButton1Click) end)
if ok then
local fired = false
for _, connection in ipairs(connections) do
if type(connection.Fire) == "function" then
fired = pcall(function() if type(connection.Fire) == "function" then connection:Fire() end end) or fired
elseif type(connection.Function) == "function" then
fired = pcall(function() if type(connection.Function) == "function" then connection.Function() end end) or fired
end
end
if fired then
return true
end
end
end
return pcall(function()
button:Activate()
end)
end
Runtime.OpenItemShopUI = function(shopFolder)
if not Runtime.ClientSignal then
local ok, signal = pcall(function() return Library and type(Library.get) == "function" and Library.get("Signal") end)
Runtime.ClientSignal = ok and signal or false
end
local prompt = shopFolder and shopFolder:FindFirstChildWhichIsA("ProximityPrompt", true)
if prompt and type(fireproximityprompt) == "function" then
pcall(function() fireproximityprompt(prompt, 0) end)
end
local signal = Runtime.ClientSignal
if signal and type(signal.Fire) == "function" then
pcall(function() signal:Fire("OpenTab", "ItemShop") end)
end
local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
local shopGui = playerGui and playerGui:FindFirstChild("ItemShop")
if (not shopGui or not shopGui:IsA("ScreenGui")) and playerGui then
shopGui = nil
for _, descendant in ipairs(playerGui:GetDescendants()) do
if descendant:IsA("ScreenGui") and descendant.Name == "ItemShop" then
shopGui = descendant
break
end
end
end
local deadline = os.clock() + 1
while shopGui and not shopGui.Enabled and os.clock() < deadline and Runtime.Alive do
task.wait(0.05)
end
return shopGui
end
Runtime.CountOwnedShopItem = function(itemName)
local count = 0
local wanted = string.lower(tostring(itemName))
for _, container in ipairs({ getBackpack(), LocalPlayer.Character }) do
if container then
for _, tool in ipairs(container:GetChildren()) do
if tool:IsA("Tool") then
local name = getUseItemInfo(tool)
if string.lower(tostring(name)) == wanted then
count = count + 1
end
end
end
end
end
return count
end
Runtime.TryDirectShopPurchase = function(itemName, moneyBefore, ownedBefore)
local transportOk, result, detail = invoke("Purchase", itemName)
if transportOk and result ~= false and result ~= nil then
return true, tostring(detail or result)
end
local verifyDeadline = os.clock() + 1.5
repeat
task.wait(0.1)
if getPlayerMoney() < moneyBefore or Runtime.CountOwnedShopItem(itemName) > ownedBefore then
return true, "REPLICATED"
end
until os.clock() >= verifyDeadline or not Runtime.Alive
return false, tostring(detail or result or "REJECTED")
end
Runtime.TryShopUIPurchase = function(shopGui, itemName, moneyBefore, ownedBefore)
if not shopGui then
return false, "SHOP UI NOT FOUND"
end
local list = shopGui:FindFirstChild("List", true)
local itemFrame = list and list:FindFirstChild(itemName)
local deadline = os.clock() + 1.5
while not itemFrame and os.clock() < deadline and Runtime.Alive do
task.wait(0.05)
list = shopGui:FindFirstChild("List", true)
itemFrame = list and list:FindFirstChild(itemName)
end
local itemButton = itemFrame and itemFrame:FindFirstChild("Button")
if not Runtime.TriggerGuiButton(itemButton) then
return false, "ITEM BUTTON FAILED"
end
task.wait(Runtime.Mobile and 0.3 or 0.15)
local buyOptions = list and list:FindFirstChild("BuyOptions")
local buttons = buyOptions and buyOptions:FindFirstChild("Buttons")
local buyFrame = buttons and buttons:FindFirstChild("Buy")
local buyButton = buyFrame and buyFrame:FindFirstChild("Button")
if not Runtime.TriggerGuiButton(buyButton) then
return false, "BUY BUTTON FAILED"
end
local verifyDeadline = os.clock() + 1.2
repeat
task.wait(0.1)
if getPlayerMoney() < moneyBefore or Runtime.CountOwnedShopItem(itemName) > ownedBefore then
return true, "UI BOUGHT " .. itemName
end
until os.clock() >= verifyDeadline or not Runtime.Alive
return false, "UI NOT CONFIRMED"
end
Runtime.GetShopStockAmount = function(stock, itemName, shopData)
if shopData.AlwaysAvailable then
return 1
end
local value = stock[itemName]
if value == nil then
local wanted = string.lower(tostring(itemName))
for stockName, stockValue in pairs(stock) do
if string.lower(tostring(stockName)) == wanted then
value = stockValue
break
end
end
end
if type(value) == "table" then
value = value.amount or value.Amount or value.stock or value.Stock or value[1]
end
return math.max(0, tonumber(value) or 0)
end
Runtime.CanBuyShopItem = function(price)
price = math.max(0, tonumber(price) or 0)
local pending = Runtime.PendingPurchase
if State.RollPriority == "TargetFirst" and pending and pending.Parent and isWantedPreview(pending) then
return false, "TARGET FIRST"
end
local money = getPlayerMoney()
if money < price then
return false, string.format("NEED $%d | HAVE $%d", math.floor(price), math.floor(money))
end
local dynamicAllowed, dynamicReason = Runtime.CanSpendDynamic(price, "Shop")
if not dynamicAllowed then
return false, dynamicReason
end
return true
end
task.spawn(function()
while Runtime.Alive do
if State.AutoBuyShop then
if not Runtime.HasAnySelection(State.ShopTargets) then
Runtime.ClearActionReservation("BuyShopItems")
Runtime.SetShopStatus("SELECT AN ITEM", false)
elseif Runtime.RebirthReady and Runtime.RebirthReady() then
Runtime.ClearActionReservation("BuyShopItems")
Runtime.SetShopStatus("REBIRTH READY", false)
else
local ok, stock = invoke("GetStock")
if ok and type(stock) == "table" then
local candidates = {}
local selectedInStock = 0
local blockedReason
for _, itemName in ipairs(collectShopOptions()) do
if isSelected(State.ShopTargets, itemName) then
local shopData = (ItemShop.Items or {})[itemName] or {}
local amount = Runtime.GetShopStockAmount(stock, itemName, shopData)
if amount > 0 then
selectedInStock = selectedInStock + 1
local allowed, reason = Runtime.CanBuyShopItem(shopData.price)
if allowed then
table.insert(candidates, itemName)
else
blockedReason = blockedReason or reason
end
end
end
end
if candidates[1] then
Runtime.AcquireMovementLease("BuyShopItems", 2.5)
Runtime.ReserveAction("BuyShopItems", { "Movement", "Economy" }, 3, 30)
local actionOk, boughtCount, lastResult = Runtime.WithAction(
"BuyShopItems",
{ "Movement", "Economy" },
function()
if not State.AutoBuyShop or (Runtime.RebirthReady and Runtime.RebirthReady()) then
return 0, "STOPPED"
end
local character = LocalPlayer.Character
local rootPart = character and character:FindFirstChild("HumanoidRootPart")
local returnPivot = character and character:GetPivot()
local plot = getPlot()
local points = plot and plot:FindFirstChild("Points")
local shopFolder = points and points:FindFirstChild("ItemShop")
local shopPoint = shopFolder and (shopFolder:FindFirstChild("ItemShop")
or shopFolder:FindFirstChildWhichIsA("BasePart", true))
local shopCFrame = shopPoint and getInstancePivot(shopPoint)
local moved = false
if character and rootPart and shopCFrame
and (rootPart.Position - shopCFrame.Position).Magnitude > 4
then
moved = pcall(function()
character:PivotTo(shopCFrame * CFrame.new(0, 2, 0))
rootPart.AssemblyLinearVelocity = Vector3.zero
rootPart.AssemblyAngularVelocity = Vector3.zero
end)
task.wait(Runtime.Mobile and 0.5 or 0.35)
if not moved or not rootPart.Parent
or (rootPart.Position - shopCFrame.Position).Magnitude > 4
then
moved = false
end
end
local nearShop = rootPart and shopCFrame
and (rootPart.Position - shopCFrame.Position).Magnitude < 15
local shopGui = nearShop and Runtime.OpenItemShopUI(shopFolder) or nil
if shopGui then
task.wait(Runtime.Mobile and 0.3 or 0.15)
end
local count = 0
local response = not character and "WAITING FOR CHARACTER"
or not shopCFrame and "SHOP POINT NOT FOUND | DIRECT"
or not nearShop and "MOVE TO SHOP FAILED | DIRECT"
or "SERVER REJECTED"
for _, itemName in ipairs(candidates) do
if not Runtime.Alive or not State.AutoBuyShop
or (Runtime.RebirthReady and Runtime.RebirthReady())
then
break
end
local shopData = (ItemShop.Items or {})[itemName] or {}
local allowed, reason = Runtime.CanBuyShopItem(shopData.price)
if not allowed then
response = reason
break
end
local moneyBefore = getPlayerMoney()
local ownedBefore = Runtime.CountOwnedShopItem(itemName)
local purchased, directDetail = Runtime.TryDirectShopPurchase(
itemName,
moneyBefore,
ownedBefore
)
if not purchased and nearShop then
task.wait(0.25)
purchased, directDetail = Runtime.TryDirectShopPurchase(
itemName,
moneyBefore,
ownedBefore
)
end
if not purchased and shopGui then
local uiBought, uiResult = Runtime.TryShopUIPurchase(
shopGui,
itemName,
moneyBefore,
ownedBefore
)
purchased = uiBought
response = directDetail .. " | " .. tostring(uiResult)
end
if purchased then
count = count + 1
Runtime.Stats.Shop = Runtime.Stats.Shop + 1
response = "BOUGHT " .. itemName
elseif response == "SERVER REJECTED" then
response = directDetail
end
task.wait(0.2)
end
if Runtime.ClientSignal and type(Runtime.ClientSignal.Fire) == "function" then
pcall(function() if Runtime.ClientSignal and type(Runtime.ClientSignal.Fire) == "function" then Runtime.ClientSignal:Fire("CloseTab", "ItemShop") end end)
end
if moved and returnPivot and character == LocalPlayer.Character and character.Parent then
pcall(function()
character:PivotTo(returnPivot)
if rootPart.Parent then
rootPart.AssemblyLinearVelocity = Vector3.zero
rootPart.AssemblyAngularVelocity = Vector3.zero
end
end)
end
return count, response
end
)
if actionOk then
Runtime.ClearActionReservation("BuyShopItems")
Runtime.SetShopStatus(
string.format("%d/%d | %s", boughtCount, #candidates, tostring(lastResult)),
boughtCount > 0
)
else
Runtime.SetShopStatus(tostring(boughtCount):upper(), false)
end
elseif selectedInStock > 0 then
Runtime.ClearActionReservation("BuyShopItems")
Runtime.SetShopStatus(blockedReason or "BLOCKED", false)
else
Runtime.ClearActionReservation("BuyShopItems")
Runtime.SetShopStatus("OUT OF STOCK")
end
else
Runtime.ClearActionReservation("BuyShopItems")
Runtime.SetShopStatus(ok and "INVALID STOCK" or ("GET STOCK | " .. tostring(stock)), false)
end
end
else
Runtime.ClearActionReservation("BuyShopItems")
if Runtime.LastShopResult ~= "IDLE" then
Runtime.SetShopStatus("IDLE")
end
end
task.wait(State.AutoBuyShop and 1 or 1.75)
end
end)
do
local function normalizedUpgradeKey(name)
Runtime.NormalizedUpgradeKeys = Runtime.NormalizedUpgradeKeys or {}
local cached = Runtime.NormalizedUpgradeKeys[name]
if not cached then
cached = string.lower(tostring(name)):gsub("%s+", "_")
Runtime.NormalizedUpgradeKeys[name] = cached
end
return cached
end
local function getMoney()
return getPlayerMoney()
end
local function hasDiscoveredGnome(name)
local discovered = (Replication.Data or {}).discovered or {}
if discovered[name] == true then
return true
end
for _, value in pairs(discovered) do
if value == name then
return true
end
end
return false
end
local function canRebirthNow()
local now = os.clock()
local cached = Runtime.CanRebirthCache
if cached and cached.Until > now then
return cached.Result
end
local rebirthData = Runtime.GetNextRebirthData()
local result = type(rebirthData) == "table"
if type(rebirthData) ~= "table" then
result = false
else
local requirements = rebirthData.requirements or {}
if getPlayerMoney() < (tonumber(requirements.money) or 0) then
result = false
else
for _, gnomeName in pairs(requirements.gnomes or {}) do
if not hasDiscoveredGnome(gnomeName) then
result = false
break
end
end
end
end
Runtime.CanRebirthCache = { Until = now + 0.2, Result = result }
return result
end
Runtime.RebirthReady = function()
local pending = Runtime.PendingPurchase
local priorityTarget = State.RollPriority == "TargetFirst"
and pending and pending.Parent and isWantedPreview(pending)
return State.AutoRebirth and not priorityTarget and canRebirthNow()
end
local expansionAttempts = setmetatable({}, { __mode = "k" })
local function tryBuyExpansion()
local plot = getPlot()
local expandFolder = plot and plot:FindFirstChild("ExpandPlot")
if not expandFolder then
return false
end
local cached = Runtime.ExpansionCandidateCache
local candidates
if cached and cached.Folder == expandFolder and cached.Until > os.clock() then
candidates = cached.Records
else
candidates = {}
for _, descendant in ipairs(expandFolder:GetDescendants()) do
if descendant.Name == "BoundaryPart" and descendant:IsA("BasePart") then
local expansion = descendant.Parent
local price = expansion and ExpandPrices[expansion.Name]
if expansion and type(price) == "number" then
table.insert(candidates, {
Instance = expansion,
Boundary = descendant,
Price = price,
})
end
end
end
table.sort(candidates, function(a, b)
return a.Price < b.Price
end)
Runtime.ExpansionCandidateCache = {
Folder = expandFolder,
Until = os.clock() + 3,
Records = candidates,
}
end
local money = getMoney()
for _, candidate in ipairs(candidates) do
if candidate.Price <= money and not expansionAttempts[candidate.Instance]
and candidate.Instance.Parent and candidate.Boundary.Parent
and Runtime.CanSpendAfterRebirthReserve(candidate.Price)
then
local actionOk, purchased = Runtime.WithAction("BuyExpansion", { "Economy" }, function()
if not State.AutoBuyExpansion
or (Runtime.RebirthReady and Runtime.RebirthReady())
or getMoney() < candidate.Price
or not Runtime.CanSpendAfterRebirthReserve(candidate.Price)
then
return false
end
local expansion = candidate.Instance
local boundary = candidate.Boundary
expansionAttempts[expansion] = true
local ok = fire("ExpandPlot", expansion)
task.wait(0.65)
local boundaryConsumed = not boundary.Parent or not boundary:IsDescendantOf(expandFolder)
if ok and (boundaryConsumed or not expansion:IsDescendantOf(expandFolder)) then
Runtime.ExpansionCandidateCache = nil
Runtime.Stats.Expansions = Runtime.Stats.Expansions + 1
return true
end
task.delay(1.5, function()
expansionAttempts[expansion] = nil
end)
return false
end)
return actionOk and purchased == true
end
end
return false
end
local function tryPlotUpgrade()
local current = (Replication.Data and Replication.Data.upgrades) or {}
for name, data in pairs(PlotUpgrades) do
if type(data) == "table" and type(data.prices) == "table" then
local tier = current[normalizedUpgradeKey(name)] or 1
local decimalPower = 10 ^ (data.decimals or 0)
local nextTier = math.round((tier + (data.increment or 1)) * decimalPower) / decimalPower
local price = data.prices[nextTier]
if price ~= nil and getMoney() >= price and Runtime.CanSpendAfterRebirthReserve(price) then
local actionOk, ok, result = Runtime.WithAction("PlotUpgrade", { "Economy" }, function()
if not State.AutoUpgrade
or (Runtime.RebirthReady and Runtime.RebirthReady())
or getMoney() < price
or not Runtime.CanSpendAfterRebirthReserve(price)
then
return false
end
return invoke("Upgrade", name)
end)
if actionOk and ok and result ~= false and result ~= "Not Enough" and result ~= "Maxed" and result ~= "Invalid" then
Runtime.Stats.Upgrades = Runtime.Stats.Upgrades + 1
return true
end
end
end
end
return false
end
local function findTreeNode(nodeId)
Runtime.UpgradeTreeNodes = Runtime.UpgradeTreeNodes or {}
local cached = Runtime.UpgradeTreeNodes[nodeId]
if cached then
return cached
end
for _, page in pairs(UpgradeTree) do
if type(page) == "table" then
if page.Position and page == UpgradeTree[nodeId] then
Runtime.UpgradeTreeNodes[nodeId] = page
return page
elseif type(page[nodeId]) == "table" then
Runtime.UpgradeTreeNodes[nodeId] = page[nodeId]
return page[nodeId]
end
end
end
end
local function getRebirths()
return Runtime.GetRebirthCount()
end
local function requirementsMet(data, owned, visited)
visited = visited or {}
if visited[data] then
return false
end
visited[data] = true
if data.RequiredRebirth and getRebirths() < data.RequiredRebirth then
visited[data] = nil
return false
end
for _, requirement in ipairs(data.Requires or {}) do
local requiredData = findTreeNode(requirement)
if requiredData and requiredData.RequiredRebirth then
if not requirementsMet(requiredData, owned, visited) then
visited[data] = nil
return false
end
elseif owned[requirement] ~= true then
visited[data] = nil
return false
end
end
visited[data] = nil
return true
end
local function tryTreeUpgrade()
local owned = (Replication.Data and Replication.Data.upgrade_tree) or {}
for pageName, nodes in pairs(UpgradeTree) do
if type(nodes) == "table" and not nodes.Position then
for nodeId, data in pairs(nodes) do
if type(data) == "table"
and data.Price ~= nil
and not data.OpensPage
and not data.RequiredRebirth
and owned[nodeId] ~= true
and getMoney() >= (tonumber(data.Price) or math.huge)
and Runtime.CanSpendAfterRebirthReserve(data.Price)
and requirementsMet(data, owned)
then
local actionOk, ok, result = Runtime.WithAction("TreeUpgrade", { "Economy" }, function()
if not State.AutoUpgrade
or (Runtime.RebirthReady and Runtime.RebirthReady())
or getMoney() < (tonumber(data.Price) or math.huge)
or not Runtime.CanSpendAfterRebirthReserve(data.Price)
then
return false
end
return invoke("Upgrade", pageName, nodeId)
end)
if actionOk and ok and result then
Runtime.Stats.Upgrades = Runtime.Stats.Upgrades + 1
return true
end
end
end
end
end
return false
end
task.spawn(function()
while Runtime.Alive do
if State.AutoUpgrade
and not (Runtime.RebirthReady and Runtime.RebirthReady())
then
if not tryPlotUpgrade() then
tryTreeUpgrade()
end
end
task.wait(State.AutoUpgrade and 1.25 or 1.75)
end
end)
task.spawn(function()
while Runtime.Alive do
if State.AutoBuyExpansion
and not (Runtime.RebirthReady and Runtime.RebirthReady())
then
tryBuyExpansion()
end
task.wait(State.AutoBuyExpansion and 1 or 1.75)
end
end)
task.spawn(function()
local lastAttempt = 0
while Runtime.Alive do
local ready = Runtime.RebirthReady()
if ready then
Runtime.ReserveAction("Rebirth", { "Movement", "Equipment", "Farm", "Gnome", "Economy", "Roll" }, 2.5, 100)
else
Runtime.ClearActionReservation("Rebirth")
end
if ready and os.clock() - lastAttempt >= 3 then
local actionOk, ok, result = Runtime.WithAction("Rebirth", { "*" }, function()
if not Runtime.RebirthReady() then
return false
end
lastAttempt = os.clock()
local ok, result = invoke("Rebirth")
if ok and result then
clearPendingPurchase()
Runtime.ClearActionReservation("Rebirth")
task.wait(1.25)
end
return ok, result
end)
if actionOk and ok and result then
Runtime.Stats.Rebirths = Runtime.Stats.Rebirths + 1
end
end
task.wait(State.AutoRebirth and 1 or 1.75)
end
end)
end
connect(LocalPlayer.Idled, function()
if not State.AntiAFK then
return
end
pcall(function()
VirtualUser:CaptureController()
VirtualUser:Button2Down(Vector2.zero, workspace.CurrentCamera.CFrame)
task.wait(0.1)
VirtualUser:Button2Up(Vector2.zero, workspace.CurrentCamera.CFrame)
end)
end)
do
local rejoining = false
local function requestRejoin()
if not Runtime.Alive or not State.AutoRejoin or rejoining then
return
end
rejoining = true
task.delay(2, function()
if not Runtime.Alive or not State.AutoRejoin then
rejoining = false
return
end
pcall(function()
TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)
task.delay(8, function()
rejoining = false
end)
end)
end
local function watchErrorPrompt(prompt)
if not prompt:IsA("GuiObject") then
return
end
task.delay(0.5, function()
if not Runtime.Alive or not State.AutoRejoin or rejoining or not prompt.Parent then
return
end
local isError = prompt.Name == "ErrorPrompt" or prompt:FindFirstChild("ErrorMessage", true) ~= nil
if isError then
requestRejoin()
end
end)
end
local hasErrorSignal, errorSignal = pcall(function()
return GuiService.ErrorMessageChanged
end)
if hasErrorSignal and errorSignal then
connect(errorSignal, function(message)
if type(message) == "string" and message ~= "" then
requestRejoin()
end
end)
end
local canReadPrompt, promptOverlay = pcall(function()
local coreGui = game:GetService("CoreGui")
local promptGui = coreGui:FindFirstChild("RobloxPromptGui", true)
return promptGui and promptGui:FindFirstChild("promptOverlay", true)
end)
if canReadPrompt and promptOverlay then
connect(promptOverlay.ChildAdded, watchErrorPrompt)
end
end
Runtime.SetIfChanged = function(object, property, value)
if object[property] ~= value then
object[property] = value
end
end
task.spawn(function()
local lastListRefresh = 0
while Runtime.Alive do
local screenGui = Runtime.ScreenGui
local main = Runtime.Main
local uiActive = not Runtime.ScreenSleeping and screenGui and screenGui.Enabled and main and main.Visible
if uiActive then
local active = 0
for key in pairs(Runtime.ToggleRefreshers or {}) do
if State[key] then
active = active + 1
end
end
local ping = 0
pcall(function()
ping = math.floor(LocalPlayer:GetNetworkPing() * 1000 + 0.5)
end)
local elapsed = math.floor(os.clock() - Runtime.StartedAt)
if Runtime.Paused then
Runtime.SetIfChanged(Runtime.CompactSubtitle, "Text", State.Language == "TH" and decodeText64("4Lie4Lix4LiB4Lit4Lii4Li54LmI") or "PAUSED")
Runtime.SetIfChanged(Runtime.CompactSubtitle, "TextColor3", Color3.fromRGB(255, 170, 95))
Runtime.SetIfChanged(Runtime.CompactArrow, "BackgroundColor3", Color3.fromRGB(255, 170, 95))
elseif Runtime.WaitingForMoney and Runtime.PendingPurchase and Runtime.PendingPurchase.Parent then
Runtime.SetIfChanged(Runtime.CompactSubtitle, "Text", State.Language == "TH" and decodeText64("4Lij4Lit4LmA4LiH4Li04LiZ") or "WAITING")
Runtime.SetIfChanged(Runtime.CompactSubtitle, "TextColor3", Color3.fromRGB(255, 201, 92))
Runtime.SetIfChanged(Runtime.CompactArrow, "BackgroundColor3", Color3.fromRGB(255, 201, 92))
elseif State.AutoBest30 then
local plot = getPlot()
local workers = plot and plot:FindFirstChild("Workers")
local placed = workers and #workers:GetChildren() or 0
local limit = getBestGnomeLimit()
Runtime.SetIfChanged(Runtime.CompactSubtitle, "Text", string.format("BEST %d/%d", math.min(placed, limit), limit))
Runtime.SetIfChanged(Runtime.CompactSubtitle, "TextColor3", Runtime.Theme.Positive)
Runtime.SetIfChanged(Runtime.CompactArrow, "BackgroundColor3", Runtime.Theme.Positive)
else
Runtime.SetIfChanged(Runtime.CompactSubtitle, "Text", "HUB")
Runtime.SetIfChanged(Runtime.CompactSubtitle, "TextColor3", Runtime.Theme.Muted)
Runtime.SetIfChanged(Runtime.CompactArrow, "BackgroundColor3", Runtime.Theme.Positive)
end
if Runtime.Paused then
Runtime.SetIfChanged(Runtime.LiveLabel, "Text", State.Language == "TH"
and decodeText64("4Lie4Lix4LiB4Lij4Liw4Lia4LiaIHwg4LiB4LiUIOC4l+C4s+C4leC5iOC4rSDguYDguJ7guLfguYjguK3guITguLfguJnguITguYjguLLguKPguLDguJrguJrguYDguJTguLTguKE=")
or "PAUSED | press RESUME to restore previous automation")
Runtime.SetIfChanged(Runtime.LiveLabel, "TextColor3", Color3.fromRGB(255, 170, 95))
elseif Runtime.WaitingForMoney and Runtime.PendingPurchase and Runtime.PendingPurchase.Parent then
local currentMoney = math.floor(getPlayerMoney())
local neededMoney = math.floor(Runtime.PendingPurchasePrice or 0)
Runtime.SetIfChanged(Runtime.LiveLabel, "Text", State.Language == "TH"
and string.format(decodeText64("4Lij4Lit4LmA4LiH4Li04LiZ4LiL4Li34LmJ4LitICVzIHwgJWQgLyAlZA=="), getFarmerName(Runtime.PendingPurchase), currentMoney, neededMoney)
or string.format("WAITING FOR MONEY | %s | %d / %d", getFarmerName(Runtime.PendingPurchase), currentMoney, neededMoney))
Runtime.SetIfChanged(Runtime.LiveLabel, "TextColor3", Color3.fromRGB(255, 201, 92))
else
local liveFormat = State.Language == "TH"
and decodeText64("4LiX4Liz4LiH4Liy4LiZIHwgJWRtcyB8ICUwMmQ6JTAyZCB8IOC5gOC4m+C4tOC4lCAlZCB8IFI6JWQgQjolZCBQOiVkIEU6JWQgUkI6JWQgQzolZCBTOiVk")
or "LIVE | %dms | %02d:%02d | %d active | R:%d B:%d P:%d E:%d RB:%d C:%d S:%d"
Runtime.SetIfChanged(Runtime.LiveLabel, "Text", string.format(
liveFormat,
ping,
math.floor(elapsed / 60),
elapsed % 60,
active,
Runtime.Stats.Rolls,
Runtime.Stats.Bought + Runtime.Stats.Shop,
Runtime.Stats.Placed,
Runtime.Stats.Expansions,
Runtime.Stats.Rebirths,
Runtime.Stats.Collected,
Runtime.Stats.Sold
))
Runtime.SetIfChanged(Runtime.LiveLabel, "TextColor3", Runtime.Theme.Positive)
end
local isMinimized = Runtime.IsMinimized and Runtime.IsMinimized()
if screenGui and screenGui.Enabled and main and main.Visible and not isMinimized and not Runtime.ScreenSleeping
and os.clock() - lastListRefresh >= 5
then
lastListRefresh = os.clock()
Runtime.RefreshVisibleLists(false)
end
end
task.wait(uiActive and 0.5 or Runtime.ScreenSleeping and 2 or 1.5)
end
end)