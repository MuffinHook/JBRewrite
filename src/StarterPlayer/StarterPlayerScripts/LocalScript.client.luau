-- ============================================================
-- Main LocalScript (Cleaned)
-- Build: 03 Apr @ 01:33 PM EDT @816c333
-- ============================================================

-- ── Services (grouped) ────────────────────────────────────────
local Services = {
	ReplicatedStorage  = game:GetService("ReplicatedStorage"),
	RunService         = game:GetService("RunService"),
	MarketplaceService = game:GetService("MarketplaceService"),
	UserInputService   = game:GetService("UserInputService"),
	SoundService       = game:GetService("SoundService"),
	Players            = game:GetService("Players"),
	CollectionService  = game:GetService("CollectionService"),
	StarterGui         = game:GetService("StarterGui"),
	TextChatService    = game:GetService("TextChatService"),
	Lighting           = game:GetService("Lighting"),
}

-- Shorthand aliases kept as locals (frequently used in hot paths)
local RS   = Services.ReplicatedStorage
local RunService          = Services.RunService
local Players             = Services.Players
local CollectionService   = Services.CollectionService
local UserInputService    = Services.UserInputService
local StarterGui          = Services.StarterGui

-- ── Shorthand math/CFrame ─────────────────────────────────────
local Angles = CFrame.Angles
local newV3  = Vector3.new
local ZeroCF = CFrame.new(0, 0, 0)
local abs    = math.abs
local floor  = math.floor
local log    = math.log
local max    = math.max

-- ── Core modules (grouped) ────────────────────────────────────
local Modules = {
	RunUtils             = require(RS.App.RunUtils),
	Math                 = require(RS.Module.Math),
	AlexWM               = require(RS.Module.AlexWM),
	Settings             = require(RS.Resource.Settings),
	Localization         = require(RS.Module.Localization),
	Raycast              = require(RS.Std.Raycast),
	Audio                = require(RS.Std.Audio),
	GameUtil             = require(RS.Game.GameUtil),
	RxInstanceUtils      = require(RS.Std.RxInstanceUtils),
	Maid                 = require(RS.Std.Maid),
	waitForChild         = require(RS.Std.waitForChild),
	GameSettingsService  = require(RS.GameSettings.GameSettingsService),
	gameSettingType      = require(RS.GameSettings.gameSettingType),
	TradeService         = require(RS.Trade.TradeService),
	PlayerModuleService  = require(RS.PlayerModule.PlayerModuleService),
	InputUtils           = require(RS.Std.InputUtils),
	EnvironmentConsts    = require(RS.Environment.EnvironmentConsts),
	EnvironmentUtils     = require(RS.Environment.EnvironmentUtils),
	HapticEffect         = require(RS.App.HapticEffect),
	R15IKv2              = require(RS.Module.R15IKv2),
	UI                   = require(RS.Module.UI),
	EzUtils              = require(RS.EzUi.EzUtils),
	RichTextUtils        = require(RS.Std.RichTextUtils),
	Joint                = require(RS.Std.Joint),
	ConstraintUtils      = require(RS.Std.ConstraintUtils),
	Promise              = require(RS.Std.Promise),
	TableUtils           = require(RS.Std.TableUtils),
	StreamingHelperUtils = require(RS.App.StreamingHelperUtils),
	ActionButtonService  = require(RS.ActionButton.ActionButtonService),
	CinematicCamera      = require(RS.Module.CinematicCamera),
}

-- Frequently-accessed module aliases
local Math               = Modules.Math
local GameUtil           = Modules.GameUtil
local Settings           = Modules.Settings
local Localization       = Modules.Localization
local Maid               = Modules.Maid
local RxInstanceUtils    = Modules.RxInstanceUtils
local InputUtils         = Modules.InputUtils
local EnvironmentConsts  = Modules.EnvironmentConsts
local EnvironmentUtils   = Modules.EnvironmentUtils
local UI                 = Modules.UI
local GameSettingsService = Modules.GameSettingsService
local TradeService       = Modules.TradeService

-- ── Player / Camera ───────────────────────────────────────────
local LocalPlayer   = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera

if not Modules.RunUtils.isStudio() then
	print("Build:", "03 Apr @ 01:33 PM EDT @816c333")
end

-- ── Remote event infrastructure ──────────────────────────────
for _ = 1, 10 do
	local re  = Instance.new("RemoteEvent")
	re.Name   = Math.GUID()
	re.Parent = RS.Resource
end

local genericRemote    -- set in ConnectEvents()
local eventNameMap     -- obfuscated-name → real-name lookup, set by server

local Event         = {}
local rawFireServer = Instance.new("RemoteEvent").FireServer

local function fireServer(eventName, ...)
	local resolved = eventNameMap and eventNameMap[eventName] or eventName
	rawFireServer(genericRemote, resolved, ...)
end

function Event:FireServer(eventName, ...)
	fireServer(eventName, ...)
end

-- ── Event-manager table (server → client dispatch) ────────────
local em = {}

local function onClientEvent(eventName, ...)
	assert(em[eventName], eventName)(...)
end

function em.initializeEventNameMap(nameMap)
	em.hems  = true
	eventNameMap = nameMap
end

-- ── Await generic remote ──────────────────────────────────────
local genericRemotePromise = Modules.waitForChild(RS, "GenericRemoteEvent", 30):catch(warn)

local function ConnectEvents()
	local ok, remote = genericRemotePromise:await()
	if not ok then
		error("Bad error... could not find `GenericGameEvent`")
	end
	remote.Name = Math.GUID()
	genericRemote = remote
	remote.OnClientEvent:Connect(onClientEvent)
end

-- ── GUI setup ──────────────────────────────────────────────────
StarterGui.ResetPlayerGuiOnSpawn = false

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TeamValue = LocalPlayer:WaitForChild("TeamValue")

local function getOrCloneGui(name)
	local gui = PlayerGui:FindFirstChild(name)
	if not gui then
		gui        = RS.StarterGui:FindFirstChild(name):Clone()
		gui.Parent = PlayerGui
	end
	return gui
end

-- GUI handles grouped
local GUI = {
	Main    = getOrCloneGui("MainGui"),
	Product = getOrCloneGui("ProductGui"),
	Particles = getOrCloneGui("Particles"),
	Death   = getOrCloneGui("DeathGui"),
}

-- Keep short aliases for the most-used GUIs
local MainGui    = GUI.Main
local ProductGui = GUI.Product
local DeathGui   = GUI.Death

UI.CircleAction.Frame = MainGui.CircleAction
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

-- ── Core game systems ──────────────────────────────────────────
local PlayerUtils = require(RS.Game.PlayerUtils)
PlayerUtils.init()

local InventoryItemSystem = require(RS.Inventory.InventoryItemSystem)

local ItemSystem = require(RS.Game.ItemSystem.ItemSystem)
ItemSystem.Init({ em = em, Event = Event })

require(RS.Game.AmmoGui).Init({
	GetScreenGui = function(name)
		local gui = PlayerGui:FindFirstChild(name)
		if not gui then
			gui        = RS.StarterGui:FindFirstChild(name):Clone()
			gui.Parent = PlayerGui
		end
		return gui
	end,
})

-- Register all item modules
local function registerItemModule(child)
	if not child:GetAttribute("Required") then
		child:SetAttribute("Required", true)
		local mod = require(child)
		if rawget(mod, "Init") then
			mod.Init({ Event = Event, em = em, ScreenGui = MainGui })
		end
		ItemSystem.Register(mod)
	end
end

for _, child in RS.Game.Item:GetChildren() do
	registerItemModule(child)
end
RS.Game.Item.ChildAdded:Connect(registerItemModule)

require(RS.Game.ItemSystem.ItemCamera).Init()
require(RS.Game.ItemSkin.ItemSkin).Init({ Event = Event, em = em })
require(RS.Game.ItemSkin.UI.UI).Init()

local PoliceReportUI = require(RS.Game.PoliceReportUI.PoliceReportUI)
PoliceReportUI.Init()

function em.showPoliceReport(data)
	PoliceReportUI.Display(data)
end

-- ── Thread-loop system ────────────────────────────────────────
local threadLoops    = {}
local lastHeartbeat  = os.clock()

local function threadLoopAdd(interval, callback)
	table.insert(threadLoops, { i = interval, c = callback, t = 0 })
end

RunService.Heartbeat:Connect(function()
	local now = os.clock()
	lastHeartbeat = now
	debug.profilebegin("Thread Loop")
	for _, entry in ipairs(threadLoops) do
		if entry.i < now - entry.t then
			entry.t = now
			entry.c(now, now - lastHeartbeat)
		end
	end
	debug.profileend()
end)

-- ── Permission helper ─────────────────────────────────────────
local function hasPermission(permData)
	local result = false
	local ok, err = pcall(function()
		if permData.Group then
			result = true
			result = result and LocalPlayer:IsInGroup(permData.Group)
			if permData.Rank then
				result = result and (permData.Rank <= LocalPlayer:GetRankInGroup(permData.Group))
			end
		end
		if not result and permData.Id then
			result = true
			result = result and permData.Id[tostring(LocalPlayer.UserId)]
		end
	end)
	if not ok then print(err) end
	return ok and result
end

-- ── Window group / character setup ───────────────────────────
local mainWindowGroup = Modules.AlexWM.MakeWindowGroup()

local CharacterBinder = require(RS.App.CharacterBinder)
CharacterBinder:Start()

local CharacterUtil = require(RS.Game.CharacterUtil)
require(RS.Inventory.InventorySystem).init()

local HotbarSystem = require(RS.Hotbar.HotbarSystem)
HotbarSystem.init()

GameUtil.OnTeamChanged:Connect(function(team)
	HotbarSystem.setColor(Settings.TeamColor[team])
end)
require(RS.Hotbar.HotbarItemBinder):GetClassAddedSignal():Connect(function()
	HotbarSystem.setColor(Settings.TeamColor[GameUtil.Team])
end)

-- ── Barbed-wire client binder ─────────────────────────────────
local BarbedWireBinder = require(RS.Std.Binder).new("BarbedWireClient", function(part)
	local maid    = Maid.new()
	local lastHit = 0
	maid:GiveTask(part.Touched:Connect(function(hit)
		local character = LocalPlayer.Character
		if not character then return end
		if hit.Parent ~= character then return end
		local humanoid = character:FindFirstChild("Humanoid")
		if not humanoid then return end
		if humanoid:GetLimb(hit) == Enum.Limb.Unknown then return end
		local now = os.clock()
		if now - lastHit < 0.3 then return end
		lastHit = now
		local damage  = 30
		local dmgAttr = part:GetAttribute("BarbedWireDamage")
		if dmgAttr then
			assert(typeof(dmgAttr) == "number")
			damage = dmgAttr
		end
		fireServer("yzplkho3", damage, "Wire")
	end))
	return maid
end)
BarbedWireBinder:Start()

-- ── Player / vehicle state (grouped) ─────────────────────────
local State = {
	vehiclePacket   = nil,
	isSprinting     = false,
	isFrozen        = false,
	isStunned       = false,
	pingPending     = false,
	pingStartTime   = tick(),
	lastNitroTick   = tick(),
	hapticHandle    = nil,
	nitroGuiHandle  = nil,
	cashPopCounter  = 0,
	helpIndex       = 1,
	currentTimeOfDay = "Day",
	rainGeneration  = 0,
	isInsideBuilding = false,
	lastHornTime    = 0,
	activeAnimTrack = nil,
	punchAnimTrack  = nil,
	crawlLastTick   = tick(),
	lastPunchTick   = tick(),
	pendingVehicleId = nil,
	enterVehiclePromise = nil,
	lastLookSendTime = 0,
	lastJumpTime    = tick(),
	purchaseCounter = 0,
}

local nitroState = {
	VehiclesOwned  = {},
	VehiclesRented = {},
	Nitro          = 50,
	NitroLastMax   = 50,
	AtGasStation   = false,
}

GameUtil.Schedule = "Yard"

-- ── Shared init config ────────────────────────────────────────
local initConfig = {
	MainWindowGroup  = mainWindowGroup,
	ScreenGui        = MainGui,
	ProductGui       = ProductGui,
	Event            = Event,
	em               = em,
	UI               = UI,
	SelectIfGamepad  = function(element) Modules.EzUtils.selectIfGamepad(element) end,
	GetVehiclePacket = function() return State.vehiclePacket end,
}

-- ── Vehicle subsystems ────────────────────────────────────────
local VehicleUtils = require(RS.Vehicle.VehicleUtils)
VehicleUtils.Init({
	GetVehiclePacket = initConfig.GetVehiclePacket,
	em               = em,
	Event            = Event,
	nitroState       = nitroState,
})

local VehicleStateBinder = require(RS.Game.VehicleStateBinder)
VehicleStateBinder:Start()

local Classes = VehicleUtils.Classes

Classes.Chassis = require(RS.Module.AlexChassis)
Classes.Chassis.init({ ScreenGui = MainGui })
Classes.Chassis.SetEvent(Event)

Classes.Chassis2 = require(RS.Module.AlexChassis2)
Classes.Chassis2.SetEvent(Event)

Classes.Volt = require(RS.Game.Vehicle.Volt)
Classes.Volt.Init({ Event = Event, em = em })

Classes.Tank = require(RS.Tank.TankService)
Classes.Tank.init()

-- ── Gamepass / marketplace ────────────────────────────────────
local function promptPurchase(passData)
	State.purchaseCounter += 1
	local id = State.purchaseCounter
	if passData.OldPassId then
		Services.MarketplaceService:PromptPurchase(LocalPlayer, passData.OldPassId)
	else
		Services.MarketplaceService:PromptGamePassPurchase(LocalPlayer, passData.PassId)
	end
	ProductGui.Gamepass.ContainerFrame.TextLabel.Text = passData.Text
	task.delay(0.4, function()
		if State.purchaseCounter == id then
			ProductGui.Gamepass.Visible = true
		end
	end)
end

local function onGamePassPurchaseFinished()
	State.purchaseCounter += 1
	ProductGui.Gamepass.Visible = false
end

Services.MarketplaceService.PromptGamePassPurchaseFinished:Connect(onGamePassPurchaseFinished)
Services.MarketplaceService.PromptPurchaseFinished:Connect(onGamePassPurchaseFinished)

function em.promptGamepassPurchase(passData) promptPurchase(passData) end

local GamepassSystem = require(RS.Gamepass.GamepassSystem)
GamepassSystem.Init()

local GamepassUtils = require(RS.Gamepass.GamepassUtils)
GamepassUtils.Init({ PromptPurchase = promptPurchase })
initConfig.PromptPurchase = promptPurchase

-- ── Notifications ─────────────────────────────────────────────
local Notification = require(RS.Game.Notification)
Notification.Init({ Event = Event, em = em })

local SidebarUI = require(RS.Game.SidebarUI)
SidebarUI.Init({ Event = Event, em = em })

require(RS.GameAnalytics).initClient()

local DefaultActions = require(RS.Game.DefaultActions)
require(RS.CmdrExt.CmdrExtSystem).init()

local Time = require(RS.Module.Time)
Time.Init()

require(RS.Module.Confirmation).Init({ Event = Event, em = em })
require(RS.Game.DisplayDamage).init()
require(RS.Game.CharacterAnim).init()
require(RS.Module.NetSync).Init({ Event = Event, em = em })
require(RS.Game.OwnedPart.OwnedPartSystem).init()
require(RS.Game.TrainSystem).Init({ Event = Event, em = em })
require(RS.Game.TrackSwitch).Init({ Event = Event, em = em })

Classes.Heli = require(RS.Game.Vehicle.Heli)(initConfig)

require(RS.Game.Museum)(initConfig, ItemSystem)
require(RS.Game.L18n)({ ScreenGui = MainGui })
require(RS.Game.Level2.LevelSystem).init()
require(RS.Game.TurbineSystem).init()
require(RS.AirDrop.BriefcaseBinder):Start()
require(RS.Plane.PlaneBinder):Start()
require(RS.Game.Hologram).Init()
require(RS.Game.Codes).Init({ MainWindowGroup = mainWindowGroup, Event = Event })
require(RS.Game.SecretBases).Init({ Event = Event, em = em })
require(RS.Game.Robbery.RobberyBank.RobberyBank).Init({ Event = Event, em = em })
require(RS.Jewelry.RobberyJewelry).Init({ Event = Event, em = em })
require(RS.Game.Robbery.RobberyCargoTrain).Init({ Event = Event, em = em })
require(RS.Game.Robbery.RobberyPassengerTrain).Init({ Event = Event, em = em, ScreenGui = MainGui })
require(RS.Game.Robbery.RobberyCargoPlane).Init({ Event = Event, em = em, Team = TeamValue, ScreenGui = MainGui })
require(RS.Game.Cell).Init({ Event = Event, em = em, ScreenGui = MainGui })
require(RS.Game.MilitaryIsland).Init()
require(RS.Game.Plane.BaseUserControlledPlane).Init()

local Jet = require(RS.Game.Plane.Jet)
Jet.Init({ Event = Event, em = em })

local VehicleSystem = require(RS.Game.VehicleSystem)
VehicleSystem.Init({ Event = Event, em = em })
VehicleSystem.RegisterModule(require(RS.Game.VehicleSystem.JetSki))
VehicleSystem.RegisterModule(Jet)
VehicleSystem.RegisterModule(require(RS.Game.Plane.Stunt))

function em.updateVehicleMissileUI(missileData, extraData)
	local packet = VehicleSystem.WaitForVehiclePacket(LocalPlayer)
	if packet == nil then error("No vehicle exists for LocalPlayer") end
	packet:UpdateMissileUI(missileData, extraData)
end

local Missile = require(RS.Game.Missile)
function em.launchMissile(a, b, c, d) Missile.LaunchMissile(a, b, c, d) end

require(RS.Game.Robbery.PuzzleFlow).Init({ Event = Event, em = em })
require(RS.Game.Robbery.PowerPlant.PowerPlant).Init({ Event = Event, em = em })

local Falling  = require(RS.Game.Falling)
Falling.Init({ Event = Event, em = em })

local Paraglide = require(RS.Game.Paraglide)
Paraglide.Init({ Event = Event, em = em })

local JetPack = require(RS.Game.JetPack.JetPack)
JetPack.Init({ Event = Event, em = em })
JetPack.Signal.OnEquipped:Connect(function()
	InventoryItemSystem.unequipAll()
end)

local Streetlights = require(RS.Game.Streetlights)
Streetlights.init()
function em.flickerStreetlights()       Streetlights.Flicker()         end
function em.setStreetlightsEnabled(enabled) Streetlights.SetEnabled(enabled) end

require(RS.App.MinimapService).init()
require(RS.Game.RoadSpikeSystem).Init({ Event = Event })
require(RS.Game.WorldMarker.WorldMarkerSystem).init()
require(RS.Game.RobberyMarkerSystem).init()
require(RS.Game.LightningSystem).Init({ em = em })
require(RS.Game.April2020LiveEventLoader).Init({ Event = Event, em = em })
require(RS.Game.Boat.Boat).Init()
VehicleSystem.RegisterModule(require(RS.Game.Boat.Sloop))
VehicleSystem.RegisterModule(require(RS.Game.Boat.Cruiser))
if Modules.RunUtils.isMainWorld() then require(RS.Game.BoatScenery).Init() end
require(RS.Game.Lighthouse).Init()
require(RS.Game.Drawbridge).Init({ em = em })
require(RS.Game.NukeControl).Init({ Event = Event, em = em })
require(RS.Game.Robbery.CargoShip.CargoShipCoordinator).Init({ Event = Event, em = em })
require(RS.Game.Radio.RadioPlayer).Init({ Event = Event, em = em })
require(RS.Game.RobberyMoneyUI.RobberyMoneyUI).Init()
require(RS.Game.DuffelBag.DuffelBagBinder):Start()
require(RS.Game.GunShop.GunShopSystem).init()
require(RS.Game.GunShop.GunShopUI).init({ Event = Event, em = em })
require(RS.Game.ContextMessage.ContextMessageUI).init()
require(RS.Game.C4.C4System).init({ em = em })
require(RS.Game.SmokeGrenade.SmokeGrenadeSystem).init()
require(RS.Game.Level2.LevelUISystem).init()
require(RS.Game.Contract.ContractSystem).init()
require(RS.Game.Contract.ContractUISystem).init()
require(RS.Game.Season.SeasonUISystem).init()
require(RS.Game.Season.SeasonSystem).init()
require(RS.Game.Robbery.MoneyTruck.MoneyTruckSystem).init()
require(RS.Game.NorthernLights).init()
require(RS.Game.Dog.DogSystem).init()
require(RS.Game.Adoption.AdoptionStandUI).init()
require(RS.Game.Adoption.AdoptionSystem).init()
require(RS.Home.HomeUI.HomeSaleUISystem).init()
require(RS.Home.HomeSystem).init()
require(RS.Home.ItemPlacer.ItemPlacerSystem).init()
require(RS.Home.Surface.SurfaceSystem).init()
require(RS.Home.HomeItem.HomeItemSystem).init()
require(RS.Home.HomeItem.Fabricate.Turret).init({ Event = Event })
require(RS.Home.HomeItem.Fabricate["Trapped Bookshelf"]).init({ Event = Event })
require(RS.Home.HomeItem.Fabricate["Trapped Spikes"]).init({ Event = Event })
require(RS.Game.Robbery.TombRobbery.TombRobberySystem).init({ Event = Event })
require(RS.Game.Cart.CartSystem).init()
require(RS.Game.ProximityCamShake.ProximityCamShakeSystem).init()
require(RS.Game.ProximitySound.ProximitySoundSystem).init()
require(RS.Game.DartDispenser.DartDispenserSystem).init()
require(RS.Game.Plank.PlankSystem).init()
require(RS.Game.MilitaryTurret.MilitaryTurretSystem).init({ Event = Event })
require(RS.Game.Destructible.DestructibleSystem).init()
require(RS.Game.PlayerMarkerSystem).init()
require(RS.Game.TopExpBoard.TopExpBoardSystem).init()
require(RS.Game.CatalogPurchaseSystem).init()
require(RS.CCTV.CCTVService).init()

-- ── Game settings ─────────────────────────────────────────────
local SettingsState = {
	pending  = {},  -- values received before handlers registered
	debounce = {},  -- per-setting change counters
	current  = {},  -- live values
}

function em.applyGameSettings(settingsMap)
	SettingsState.current = settingsMap
	for name, value in pairs(settingsMap) do
		local setting = GameSettingsService.getByName and GameSettingsService.getByName(name)
		if setting and not setting.noSave then
			GameSettingsService.setValue(setting, value)
		end
	end
end

local function handleSetting(setting)
	local pending = SettingsState.pending[setting.name]
	if pending ~= nil then
		SettingsState.pending[setting.name] = nil
		if not setting.noSave then
			GameSettingsService.setValue(setting, pending)
		end
	end
	setting.onChanged:Connect(function(newValue)
		local count = (SettingsState.debounce[setting.name] or 0) + 1
		SettingsState.debounce[setting.name] = count
		if SettingsState.current[setting.name] ~= newValue then
			SettingsState.current[setting.name] = newValue
			task.delay(0.25, function()
				if SettingsState.debounce[setting.name] == count then
					fireServer("k6ukc52e", setting.name, newValue)
				end
			end)
		end
	end)
end

GameSettingsService.onAdded:Connect(handleSetting)
for _, setting in ipairs(GameSettingsService.getAll()) do
	handleSetting(setting)
end

-- ── More binders / services ───────────────────────────────────
require(RS.VehicleLink.VehicleLinkBinder):Start()
require(RS.Elevator.ElevatorBinder):Start()
require(RS.Casino.CasinoService).init()
require(RS.TransportJet.TransportJetService).init()
require(RS.DamageIndicator.DamageIndicatorService).init()
require(RS.Trade.TradeService).init({ em = em })
if Modules.RunUtils.isTradeWorld() then require(RS.Trade.TradeDesireService).init() end
require(RS.RewardSpinner.RewardSpinnerService).init()
require(RS.HyperChrome.HyperChromeService).init()
require(RS.RobberyBonus.RobberyBonusService).init({ em = em })
require(RS.Safes.SafesService).init({ em = em })
require(RS.GuardNPC.GuardNPCBinder):Start()
require(RS.AirDrop.AirDropService).init({ em = em })
require(RS.App.HoldEService).init()
require(RS.TargetingIndicator.TargetingIndicatorService).init()
require(RS.Forcefield.ForcefieldService).init()
require(RS.SpawnSelection.SpawnSelectionService).init()
require(RS.Consumables.ConsumablesService).init()
require(RS.PersistentCrewBattle.PersistentCrewBattleService).init()
require(RS.TrackingSpotlight.TrackingSpotlightService).init()
require(RS.GameMode.GameModeService).init({ em = em })
require(RS.DragStrip.DragStripService).init()
require(RS.App.CircleActionBinder):Start()
require(RS.Turret2.TurretService).init()
require(RS.App.OnboardTutorialService).init()
require(RS.Commerce.CommerceService).init()
if Modules.RunUtils.isMainWorld() then require(RS.Walmart.WalmartService).init() end

local CashBuyUI = require(RS.Game.CashBuyUI)
CashBuyUI.Init({ Event = Event, em = em })

require(RS.Game.Radio.Radio).Init()
Settings.FetchProducts()

-- ── Utility: number formatting ────────────────────────────────
local function addThousandsSeparators(n)
	local prefix, digits, suffix = string.match(n, "^([^%d]*%d)(%d*)(.-)$")
	return prefix .. digits:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. suffix
end

local function formatMoney(amount)
	local sign = amount >= 0 and "" or "-"
	return sign .. Localization:FormatByKey("General.Cash", { addThousandsSeparators(tostring(abs(amount))) })
end

-- ── Utility: table lerp ───────────────────────────────────────
local function lerpTable(from, to, alpha)
	local result = {}
	for k, v in next, to do
		result[k] = type(v) == "number"
			and (1 - alpha) * from[k] + alpha * v
			or  from[k]:lerp(v, alpha)
	end
	return result
end

-- ── Sound system ──────────────────────────────────────────────
local activeSounds = {}  -- soundKey → { Object, Proxy }

function em.playOrStopWorldSound(playerName, soundName, params)
	local source    = params.Source
	local volume    = math.min(params.Volume or 0.5, 2)
	local maxTime   = params.MaxTime or 1
	local timeStart = params.TimeStart
	local delay_    = params.Delay

	if params.TimeStop then maxTime = timeStart + params.TimeStop end

	local proxyId = (activeSounds._counter or 0) + 1
	activeSounds._counter = proxyId

	local soundKey = params.Multi
		and ("%s_%s_%d"):format(playerName, soundName, proxyId)
		or  ("%s_%s"):format(playerName, soundName)

	local existing = activeSounds[soundKey]
	if existing then
		existing.Object:Stop()
		existing.Object:Destroy()
		activeSounds[soundKey] = nil
	end

	if not params.Play or not source then return end
	local assetId = Settings.Sounds[soundName]
	if not assetId then return end

	local sound             = Instance.new("Sound")
	sound.SoundId           = "rbxassetid://" .. assetId
	sound.Name              = soundKey
	sound.Looped            = params.Looped
	sound.Volume            = volume
	sound.PlaybackSpeed     = params.Pitch or 1
	sound.EmitterSize       = params.EmitterSize or 10
	sound.MaxDistance       = 400
	if timeStart then sound.TimePosition = timeStart end
	if params.SoundGroup then sound.SoundGroup = params.SoundGroup end
	sound.Parent = source

	if delay_ then
		delay(delay_, function() sound:Play() end)
	else
		sound:Play()
	end

	activeSounds[soundKey] = { Object = sound, Proxy = proxyId }

	delay(maxTime, function()
		local entry = activeSounds[soundKey]
		if entry and proxyId >= entry.Proxy then
			entry.Object:Stop()
			entry.Object:Destroy()
			activeSounds[soundKey] = nil
		end
	end)
end

local function playSound(soundName, params, localOnly)
	if not params.Source then return end
	params.Play = true
	if not localOnly then fireServer("e6yn0d8f", soundName, params) end
	em.playOrStopWorldSound(LocalPlayer.Name, soundName, params)
end

local function stopSound(soundName, localOnly)
	local params = {}
	if not localOnly then fireServer("e6yn0d8f", soundName, params) end
	em.playOrStopWorldSound(LocalPlayer.Name, soundName, params)
end

-- ── Fireworks ─────────────────────────────────────────────────
local AlexParticles = require(RS.Module.AlexParticles)

local function spawnFireworks(count)
	assert(count <= 50)
	local state = AlexParticles.MakeState()
	state.Frame = GUI.Particles.Particles
	AlexParticles.EasySimulate(state, 4)

	local sizeX = state.Frame.AbsoluteSize.X
	local sizeY = state.Frame.AbsoluteSize.Y

	local function onBurst()
		if count <= 4 or math.random() < 0.2 then
			playSound("FireworkBang", { Source = MainGui, Volume = 0.2 + math.random() * 0.3, Multi = true }, true)
		end
	end

	for _ = 1, count do
		local velocity = newV3(0, -400, 0) + Math.Uniform2D(150)
		local firework = AlexParticles.Firework(state, newV3(math.random() * sizeX, sizeY, 0), velocity, newV3())
		firework.ttl      = (sizeY - (sizeY * 0.3 + sizeY * 0.6 * math.random())) / velocity.magnitude
		firework.OnDestroy = onBurst
		wait(0.1 + math.random() * 0.05)
	end
end

function em.spawnFireworks(count) assert(count <= 50); spawnFireworks(count) end
initConfig.Fireworks = spawnFireworks
require(RS.Game.Party).Init({ Fireworks = spawnFireworks })

-- ── Arrest / social actions ───────────────────────────────────
function em.showArrestBribedCooldown(data)
	if data.Bribed then
		em.showNotification({ Title = "Arrest", Text = ("You are bribed! Wait %d seconds."):format(data.Bribed) })
	end
end

local function attemptPickPocket(player)  fireServer("tmg1kkw8", player.Name) end
local function attemptBreakout(player)    fireServer("lwe8eamu", player.Name) end
local function attemptVehicleEject(v)     fireServer("d4lekogp", v)           end
local function attemptVehicleHotwire(v, i) fireServer("df3viejr", v, i)       end

function em.showBreakoutCooldown(data)
	if data.Cooldown then
		em.showNotification({ Title = "Breakout", Text = ("Wait %d seconds."):format(data.Cooldown) })
	end
end

local function attemptTrade(player)
	if TradeService.checkAlreadyInitiated(player, LocalPlayer) then
		TradeService.acceptInitiation(player.UserId)
	else
		TradeService.sendInitiation(player.UserId)
	end
end

-- ── Ping / delta tracking ─────────────────────────────────────
local function calculateAndSendPing()
	if State.pingPending and Modules.RunUtils.isMainWorld() then
		State.pingPending = false
		fireServer("xme0miu3", tick() - State.pingStartTime)
	end
end

-- ── Nitro ─────────────────────────────────────────────────────
local function startNitro()
	if tick() - State.lastNitroTick < 0.1 then return end
	State.lastNitroTick = tick()
	if State.pingPending then calculateAndSendPing() end
	State.pingPending   = true
	State.pingStartTime = tick()

	local vp = State.vehiclePacket
	if vp and not vp.Passenger and #vp.Nitrous > 0 then
		vp.Nitro = true
		playSound("Nitro1",   { Source = vp.Nitrous[1].Parent, TimeStart = 0.5, Volume = 0.7 })
		playSound("NitroLoop",{ Source = vp.Nitrous[1].Parent, Looped = true, MaxTime = 30, Volume = 0.7, Delay = 0.3 })
		for _, emitter in next, vp.Nitrous do emitter.Enabled = true end
		fireServer("bwzh5113")
		if State.hapticHandle then State.hapticHandle:Destroy() end
		State.hapticHandle = Modules.HapticEffect.basic(1, math.huge)
	end

	if nitroState.Nitro / nitroState.NitroLastMax <= 0.01 then
		em.setNitroShopVisible(true, true)
	end
end

local function stopNitro()
	stopSound("NitroLoop")
	if State.hapticHandle then State.hapticHandle:Destroy(); State.hapticHandle = nil end
	local vp = State.vehiclePacket
	if vp and not vp.Passenger then
		vp.Nitro = false
		if vp.Nitrous then
			for _, emitter in next, vp.Nitrous do emitter.Enabled = false end
		end
	end
	calculateAndSendPing()
	fireServer("pdrsemkn")
end

-- ── Nitro UI ──────────────────────────────────────────────────
function em.updateNitroUI(currentNitro, maxNitro)
	local displayNitro = Modules.RunUtils.isTradeWorld() and Settings.Scalar.NitroMax or currentNitro
	nitroState.Nitro          = displayNitro
	nitroState.NitroLastMax   = maxNitro
	nitroState.NitroForceUIUpdate = true
	local h = State.nitroGuiHandle
	if h then
		local bar = h.Container.Container.ContainerBar
		bar.Value.Size = UDim2.new(displayNitro / Settings.Scalar.NitroMax, 0, 1, 0)
		bar.ContainerFuel.Amount.Text = ("%d/%d"):format(displayNitro, Settings.Scalar.NitroMax)
	end
end

-- ── CircleAction heartbeat / renderstepped ────────────────────
RunService.Heartbeat:Connect(function(dt)
	debug.profilebegin("CircleAction (logic, heartbeat)")
	UI.CircleAction.UpdateLogic(dt)
	debug.profileend()
end)
RunService.RenderStepped:Connect(function(dt)
	debug.profilebegin("CircleAction (position, renderstepped)")
	UI.CircleAction.UpdateVisual(dt)
	debug.profileend()
end)

-- ── Vehicle update loops ──────────────────────────────────────
RunService.Stepped:Connect(function()
	local vp = State.vehiclePacket
	if vp and not vp.Passenger then
		if vp.Type == "Chassis" then
			Classes.Chassis.UpdateStepped(vp)
		elseif vp.Type == "Motorcycle" or vp.Type == "DuneBuggy" then
			Classes.Chassis2.UpdateStepped(vp)
		end
	end
end)

-- ── Camera look / head/neck rotation ─────────────────────────
-- Per-player look spring data (other players)
local LookState = {
	transforms     = { Waist = CFrame.new(), Neck = CFrame.new() },
	smoothTarget   = newV3(),
	playerData     = {},  -- [playerName] = { HeadingSpring, PitchSpring, Waist, Neck, ... }
}

RunService.Stepped:Connect(function()
	debug.profilebegin("Camera Looking")
	local now = tick()

	LookState.smoothTarget += (
		CurrentCamera.CFrame.Position + CurrentCamera.CFrame.LookVector * 30
		- LookState.smoothTarget
	) * 0.2

	local character = LocalPlayer.Character
	if character then
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid and humanoid.Health > 0 and not State.vehiclePacket and humanoid.RootPart then
			local head       = character:FindFirstChild("Head")
			local upperTorso = character:FindFirstChild("UpperTorso")
			if head and upperTorso then
				local waistJoint = upperTorso:FindFirstChild("Waist")
				local neckJoint  = head:FindFirstChild("Neck")
				if waistJoint and neckJoint then
					local heading, pitch = 0, 0
					debug.profilebegin("Calculate looking")
					if not State.isFrozen then
						local lookVec = (CurrentCamera.CFrame * Angles(0.2, 0, 0)).LookVector
						if Math.IsNaNv3(lookVec) then lookVec = newV3(0, 0, -1) end
						heading = humanoid.RootPart.CFrame.lookVector:Dot(lookVec:Cross(newV3(0, 1, 0)))
						pitch   = math.asin(lookVec.Y)
						if State.vehiclePacket and (not State.vehiclePacket.Passenger or State.vehiclePacket.NoLook)
							or ItemSystem.GetLocalEquipped()
						then
							heading = 0; pitch = 0
						end
						if Math.IsNaN(heading) then heading = 0 end
						if Math.IsNaN(pitch)   then pitch   = 0 end
					end
					local targetCF = not State.isFrozen
						and Angles(0, -heading * 0.5, 0) * Angles(-pitch * 0.2, 0, 0)
						or CFrame.identity
					if Math.IsNaNcf(targetCF) then targetCF = CFrame.identity end
					if waistJoint.Transform ~= LookState.transforms.Waist then
						waistJoint.Transform *= CFrame.identity:Inverse()
						LookState.transforms.Waist = waistJoint.Transform
					end
					if neckJoint.Transform ~= LookState.transforms.Neck then
						neckJoint.Transform *= CFrame.identity:Inverse()
						LookState.transforms.Neck = neckJoint.Transform
					end
					if now - State.lastLookSendTime >= 0.4 then
						State.lastLookSendTime = now
						if Math.IsNaN(heading) then heading = 0 end
						if Math.IsNaN(pitch)   then pitch   = 0 end
						if em.hems then fireServer("rhe8ct8j", heading, pitch) end
					end
					debug.profileend()
				end
			end
		end
	end

	-- Apply look spring to other players
	for name, data in pairs(LookState.playerData) do
		if not ItemSystem.GetEquipped(Players:FindFirstChild(name)) then
			local hSpring = Math.Spring(data.HeadingSpring)
			local pSpring = Math.Spring(data.PitchSpring)
			if data.Waist then
				local wCF = Angles(-pSpring * 0.2, -hSpring * 0.5, 0)
				if Math.IsNaNcf(wCF) then wCF = ZeroCF end
				if data.Waist.Transform ~= data.LastWaistTransform then
					data.Waist.Transform *= wCF:Inverse()
				else
					data.Waist.Transform = wCF
				end
				data.LastWaistTransform = data.Waist.Transform
			end
			if data.Neck then
				local nCF = Angles(-pSpring * 0.5, -hSpring * 0.5, 0)
				if Math.IsNaNcf(nCF) then nCF = ZeroCF end
				if data.Neck.Transform ~= data.LastNeckTransform then
					data.Neck.Transform *= nCF:Inverse()
				else
					data.Neck.Transform = nCF
				end
				data.LastNeckTransform = data.Neck.Transform
			end
		end
	end

	debug.profileend()
end)

-- ── Low-quality vehicle update helpers ───────────────────────
local tireSounds = { tire_pop = 4534995816, tire_leak = 4534995685 }

local function updateChassisLowQuality(packet, dt)
	local model = packet.Model
	if not model then warn("No model exists to update LowQuality"); return end
	local engine = model:FindFirstChild("Engine")
	if not engine then warn("No engine exists to update LowQuality"); return end

	local localVel    = engine.CFrame:vectorToObjectSpace(engine.Velocity)
	local wheelRadius = packet._cachedWheelRadius
	if not wheelRadius then
		wheelRadius               = packet.Wheels[1].Model.PrimaryPart.Size.Y / 2
		packet._cachedWheelRadius = wheelRadius
	end

	local newRot = (packet.WheelRotation + localVel.Z * dt / wheelRadius) % (-math.pi * 2)
	packet.WheelRotation = newRot

	local suspOffset = 0
	local gh = model:GetAttribute("GarageSuspensionHeight")
	if gh then suspOffset += gh end

	for _, wheel in pairs(packet.Wheels) do
		Classes.Chassis.UpdateWheelLowQuality(model, suspOffset, wheel, newRot)
	end
	Classes.Chassis.UpdateSoundLowQuality(packet, packet.Gears, localVel)

	local tirePop = math.min(
		(Time.GetNowSync() - model:GetAttribute("VehicleTiresLastPop")) / packet.DisableDuration, 1
	) >= 0.999

	if tirePop and packet.AreTiresPopped ~= true then
		local p = { Volume = 1 }
		Modules.Audio.ObjectLocal(engine, tireSounds.tire_pop,  p)
		Modules.Audio.ObjectLocal(engine, tireSounds.tire_leak, p)
		packet.AreTiresPopped = true
	end
end

local function updateChassisStepped(packet)
	local model  = packet.Model
	local engine = model:FindFirstChild("Engine")
	if not engine then return end
	if not packet.IKP then
		local player    = Players:FindFirstChild(packet.PlayerName)
		if not player then return end
		local character = player.Character
		if not character then return end
		local humanoid  = character:FindFirstChild("Humanoid")
		if not humanoid or not humanoid.RootPart then return false end
		packet.IKP = Modules.R15IKv2.BuildPacketArms(character)
	end
	local steerAngle = 0.5 * engine.RotVelocity.Y
	if packet.WeldSteer and packet.IKP then
		packet.WeldSteer.C0 = Angles(0, steerAngle, 0)
		local halfWidth = model.Steer.Size.X * 0.5 - 0.2
		local steerCF   = model.Steer.CFrame
		local ikp       = packet.IKP
		ikp.RightArm   = steerCF * newV3(halfWidth,  0.1, 0)
		ikp.RightAngle = -steerAngle - 0.6
		ikp.LeftArm    = steerCF * newV3(-halfWidth, 0.1, 0)
		ikp.LeftAngle  = -steerAngle + 0.6
		Modules.R15IKv2.Arms(ikp)
	end
end

local function updateHeliLowQuality(packet, dt)
	if not packet.Model then return end
	if packet.HasProp       then Classes.Heli.SpinProp(packet, dt)        return end
	if packet.IsUFO         then Classes.Heli.SpinUFO(packet, dt)         return end
	if packet.IsCrewCapsule then Classes.Heli.SpinCrewCapsule(packet, dt) return end
	if packet.IsDrone       then Classes.Heli.SpinDrone(packet, dt)              end
end

-- ── Horn ──────────────────────────────────────────────────────
local function playHorn(part, play, soundId, looped, duration, volume)
	local existing = part:FindFirstChild("_HornSound")
	if existing then existing:Destroy() end
	if not play then return end
	local sound  = Modules.Audio.ObjectLocal(part, soundId, { Looped = looped })
	sound.Name   = "_HornSound"
	if volume then sound.Volume = volume end
	sound.Parent = part
	task.delay(duration or 16, function()
		if sound.Parent == part then sound:Destroy() end
	end)
end

local function hornStart()
	local now = os.clock()
	if now - State.lastHornTime < 0.05 then return end
	State.lastHornTime = now
	local vp = State.vehiclePacket
	if vp and not vp.Passenger then
		playHorn(vp.Model:FindFirstChild("BoundingBox"), true,
			vp.Model:GetAttribute("VehicleHornId"),
			vp.Model:GetAttribute("VehicleHornLoopable"),
			nil,
			vp.Model:GetAttribute("VehicleHornVolume"))
		fireServer("qgqa0qfy", true)
	end
end

local function hornStop()
	local vp = State.vehiclePacket
	if vp and not vp.Passenger then
		local s = vp.Model:FindFirstChild("BoundingBox"):FindFirstChild("_HornSound")
		if s then s:Destroy() end
		fireServer("qgqa0qfy", false)
	end
end

function em.playHornRemote(_name, part, play, soundId, looped, _dur, volume)
	playHorn(part, play, soundId, looped, 10, volume)
end

-- ── Crawling / punch animations ───────────────────────────────
local crawlAnim = Instance.new("Animation")
crawlAnim.AnimationId = Modules.RunUtils.getEnv() == require(RS.App.RunConsts).QA_NAME
	and "rbxassetid://10866609111"
	or  "rbxassetid://685258011"

local punchAnims = {}
do
	local a1 = Instance.new("Animation"); a1.AnimationId = "rbxassetid://758003506"
	local a2 = Instance.new("Animation"); a2.AnimationId = "rbxassetid://758005053"
	table.insert(punchAnims, a1); table.insert(punchAnims, a2)
end

local crawlTimestamps = { 0, 0, 0 }

local function toggleCrawling()
	local character   = LocalPlayer.Character
	local primaryPart = character.PrimaryPart
	State.isFrozen    = not State.activeAnimTrack

	CharacterUtil.IsCrawling = State.isFrozen
	CharacterUtil.IsCrawlingChanged:Fire(CharacterUtil.IsCrawling)

	local upperTorso = character:FindFirstChild("UpperTorso")
	local lowerTorso = character:FindFirstChild("LowerTorso")
	local joints     = {}

	local function collectJoints(parent)
		for _, child in next, parent:GetChildren() do
			if child:IsA("JointInstance") and (
				child.Part1 == upperTorso or child.Part1 == lowerTorso or
				child.Part0 == upperTorso or child.Part0 == lowerTorso
			) then
				table.insert(joints, { Motor = child, Part0 = child.Part0, Part1 = child.Part1 })
				child.Part0 = nil; child.Part1 = nil
			end
			collectJoints(child)
		end
	end
	collectJoints(character)

	if State.isFrozen then
		local ball = Instance.new("Part")
		ball.Shape  = Enum.PartType.Ball
		ball.Size   = newV3(2, 1, 4)
		ball.Name   = "Ball"
		ball.CanCollide = true
		ball.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 1, 1)
		ball.CFrame = primaryPart.CFrame * CFrame.new(0, 0, 1)
		ball.Transparency = 1
		ball.Parent = character
		Modules.Joint.CustomWeld(ball, primaryPart, CFrame.new(0, 1, 0), ZeroCF)
	else
		local ball = character:FindFirstChild("Ball")
		if ball then ball:Destroy() end
	end

	for _, j in ipairs(joints) do
		j.Motor.Part0 = j.Part0; j.Motor.Part1 = j.Part1
	end

	character.HumanoidRootPart.CanCollide = not State.isFrozen

	if State.activeAnimTrack then
		State.activeAnimTrack:Stop()
		State.activeAnimTrack = nil
	else
		State.activeAnimTrack = character:FindFirstChild("Humanoid"):LoadAnimation(crawlAnim)
		State.activeAnimTrack:Play()
	end
end

-- ── Default actions ───────────────────────────────────────────
require(RS.Game.DefaultActions).init({
	setSprinting = function(value)
		State.isSprinting = value
	end,

	attemptToggleCrawling = function()
		local character = LocalPlayer.Character
		if not character then return end
		local humanoid = character:FindFirstChild("Humanoid")
		if not humanoid then return end
		if not State.activeAnimTrack and humanoid.Sit then return end
		if not State.activeAnimTrack and humanoid.PlatformStand then return end
		if not character.PrimaryPart then return end
		if Classes.Heli.Roped then return end
		if Falling.IsRagdolling() then return end
		if Paraglide.IsFlying() then return false end
		if not InventoryItemSystem.unequipAll() then return end
		local equipped = ItemSystem.GetLocalEquipped()
		if equipped and equipped.ItemData.Locked then return end
		if tick() - State.crawlLastTick < 0.1 then return end
		if tick() - crawlTimestamps[#crawlTimestamps] < 2 then return end
		State.crawlLastTick = tick()
		if State.activeAnimTrack then
			table.remove(crawlTimestamps)
			table.insert(crawlTimestamps, 1, State.crawlLastTick)
		end
		toggleCrawling()
	end,

	attemptPunch = function()
		if tick() - State.lastPunchTick < 0.5 then return end
		local character = LocalPlayer.Character
		if not character then return end
		local humanoid = character:FindFirstChild("Humanoid")
		if not humanoid then return end
		if ItemSystem.GetLocalEquipped() then return end
		if State.punchAnimTrack then State.punchAnimTrack:Stop() end
		local anim = table.remove(punchAnims, 1)
		table.insert(punchAnims, anim)
		State.punchAnimTrack = humanoid:LoadAnimation(anim)
		State.punchAnimTrack:Play()
		State.lastPunchTick = tick()
		fireServer("ip8mi4gy")
	end,
})

-- ── Schedule / team updates ───────────────────────────────────
function em.updateSchedule(schedule)
	GameUtil.Schedule = schedule
	if GameUtil.Team == Settings.EnumTeam.Prisoner and Modules.RunUtils.isMainWorld() then
		em.showNotification({ Text = Localization:FormatByKey("Schedule." .. schedule) })
	end
end

function em.updatePlayerLookAngles(playerName, heading, pitch)
	local data = LookState.playerData[playerName]
	if not data then
		data = {
			HeadingSpring = Math.MakeSpring(0, 10, 0.8),
			PitchSpring   = Math.MakeSpring(0, 10, 0.8),
		}
		LookState.playerData[playerName] = data
	end
	local player = Players:FindFirstChild(playerName)
	if not player then LookState.playerData[playerName] = nil; return end
	local character = player.Character
	if not character then LookState.playerData[playerName] = nil; return end
	local upperTorso = character:FindFirstChild("UpperTorso")
	if not upperTorso then LookState.playerData[playerName] = nil; return end
	data.Waist = upperTorso:FindFirstChild("Waist")
	data.Neck  = character.Head:FindFirstChild("Neck")
	Math.SpringSetTarget(data.HeadingSpring, heading)
	Math.SpringSetTarget(data.PitchSpring,   pitch)
end

local CartBinder = require(RS.Game.Cart.CartBinder)

-- ── Jump / exit vehicle ───────────────────────────────────────
local function onJump()
	if State.vehiclePacket then
		if LocalPlayer.Character and LocalPlayer.Character:GetAttribute("TankRoyaleAlive") then
			em.showNotification({ Text = "You cannot exit Tanks in this gamemode." })
			return
		end
		VehicleUtils.OnVehicleJumpExited:Fire(State.vehiclePacket)
		fireServer("khwc34l2")
		VehicleUtils.LastVehicleExit = tick()
		return
	end
	for _, _ in ipairs(CartBinder:GetAll()) do end  -- handled by CartBinder
end
CharacterUtil.OnJump = onJump

-- ── Death screen / lighting effects ──────────────────────────
local colorCorrection = Instance.new("ColorCorrectionEffect")
colorCorrection.Enabled = false
colorCorrection.Parent  = Services.Lighting

local blurEffect = Instance.new("BlurEffect")
blurEffect.Size    = 0
blurEffect.Enabled = false
blurEffect.Parent  = Services.Lighting

local DeathLighting = { from = nil, to = nil }
local overrideDeathMessage

local function applyDeathLighting(from, to, alpha)
	local result = lerpTable(from, to, alpha)
	colorCorrection.Saturation = result.Saturation
	blurEffect.Size            = result.Blur
end

local function removeDeathGui()
	DeathGui.Frame:TweenSizeAndPosition(
		UDim2.new(1, 40, 0, 0), UDim2.new(0, -20, 0.5, 0),
		Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true,
		function() DeathGui.Frame.Visible = false end
	)
end
GameUtil.removeDeathGui = removeDeathGui

function GameUtil.removeDeathLighting()
	if not DeathLighting.from then return end
	local conn
	local progress = 0
	conn = RunService.RenderStepped:connect(function(dt)
		progress += dt * 2
		if progress >= 1 then
			conn:Disconnect()
			applyDeathLighting(DeathLighting.from, DeathLighting.to, 1)
			blurEffect.Enabled = false; colorCorrection.Enabled = false
		else
			applyDeathLighting(DeathLighting.from, DeathLighting.to, 1)
		end
	end)
end

function em.onCharacterSpawned()
	task.wait()
	local character = LocalPlayer.Character
	if not character then return end
	local humanoid = character:FindFirstChild("Humanoid")
	if not humanoid then return end
	humanoid.Seated:connect(function(seated)
		if seated and CharacterUtil.IsCrawling then toggleCrawling() end
	end)
	humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	removeDeathGui()
	if DeathLighting.from then
		local conn
		local progress = 0
		conn = RunService.RenderStepped:connect(function(dt)
			progress += dt * 2
			if progress >= 1 then
				conn:Disconnect()
				applyDeathLighting(DeathLighting.from, DeathLighting.to, 1)
				blurEffect.Enabled = false; colorCorrection.Enabled = false
			else
				applyDeathLighting(DeathLighting.from, DeathLighting.to, 1)
			end
		end)
	end
	if InputUtils.isTouch() then
		State.isSprinting = true
		if not DefaultActions.sprintButton._pressed and DefaultActions.sprintButton._pressState then
			DefaultActions.sprintButton._pressState()
		end
	end
	overrideDeathMessage = nil
end

function em.onLocalPlayerDied(silentDeath)
	State.isFrozen    = false
	State.isSprinting = false
	State.isStunned   = false
	CharacterUtil.IsCrawling = false
	CharacterUtil.IsCrawlingChanged:Fire(false)
	if DefaultActions.sprintButton._pressed and DefaultActions.sprintButton._pressState then
		DefaultActions.sprintButton._pressState()
	end
	onJump()
	local store = require(RS.App.store)
	store:dispatch({ type = "setLastDiedAt", lastDiedAt = workspace:GetServerTimeNow() })
	if not silentDeath then
		local msg = overrideDeathMessage or Localization:FormatByKey("DeathMessage." .. math.random(0, 13))
		DeathGui.Frame.TextLabel.Text = msg
		blurEffect.Enabled = true; colorCorrection.Enabled = true
		DeathLighting.from = { Blur = 0, Saturation = 0 }
		DeathLighting.to   = { Blur = 8, Saturation = -1 }
		local conn; local progress = 0
		conn = RunService.RenderStepped:connect(function(dt)
			progress += dt
			if progress >= 1 then
				conn:Disconnect()
				applyDeathLighting(DeathLighting.from, DeathLighting.to, 1)
				return
			end
			applyDeathLighting(DeathLighting.from, DeathLighting.to, progress)
		end)
		task.delay(0.5, function()
			DeathGui.Frame.Size     = UDim2.new(1, 40, 0, 0)
			DeathGui.Frame.Position = UDim2.new(0, -20, 0.5, 0)
			DeathGui.Frame:TweenSizeAndPosition(
				UDim2.new(1, 40, 0, 150), UDim2.new(0, -20, 0.5, -75),
				Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true
			)
			DeathGui.Frame.Visible = true
		end)
	end
end

Modules.waitForChild(RS, "UpdateDeathMessage"):andThen(function(remote)
	remote.OnClientEvent:Connect(function(message)
		overrideDeathMessage = message
		DeathGui.Frame.TextLabel.Text = message
	end)
end)

-- ── App stores / cash UI ──────────────────────────────────────
local appStore  = require(RS.App.store)
local homeStore = require(RS.Home.homeStore)

function em.updateCash(data)
	assert(data ~= nil)
	local VehicleBuyUIInst = require(RS.App.VehicleBuyUI)()
	VehicleBuyUIInst.setCash(data.Cash)
	local MilestoneEffects = require(RS.App.MilestoneEffects)
	MilestoneEffects.cashUpdate(data.Cash)
	CashBuyUI.SetCash(data.Cash)
	appStore:dispatch({ type = "setCash", cash = data.Cash })
	homeStore:dispatch({ type = "setCash", cash = data.Cash })
end

function em.showCashDelta(delta, reason)
	State.cashPopCounter += 1
	local id = State.cashPopCounter
	if delta > 0 then
		task.spawn(spawnFireworks, 2)
		MainGui.PlusCash.TextColor3       = Color3.fromRGB(68, 194, 93)
		MainGui.PlusCash.TextStrokeColor3 = Color3.fromRGB(33, 97, 44)
	else
		MainGui.PlusCash.TextColor3       = Color3.fromRGB(240, 30, 30)
		MainGui.PlusCash.TextStrokeColor3 = Color3.fromRGB(180, 0, 0)
	end
	if not MainGui.PlusCash.Visible then MainGui.PlusCash.Text = "" end
	MainGui.PlusCash.Visible  = true
	MainGui.PlusCash.TextSize = 28
	MainGui.PlusCash.Font     = Enum.Font.SourceSansBold
	MainGui.PlusCash.RichText = true
	if reason then
		local display = (delta >= 0 and "" or "-") .. formatMoney(abs(delta))
		MainGui.PlusCash.Text = MainGui.PlusCash.Text
			.. ('<font color="#FFFFFF"><stroke color="#111111" thickness="0.75">%s: </stroke></font><b>%s</b>\n')
			:format(reason, display)
	else
		local display = (delta >= 0 and "" or "-") .. formatMoney(abs(delta))
		MainGui.PlusCash.Text = MainGui.PlusCash.Text .. ("<b>%s</b>\n"):format(display)
	end
	task.delay(3, function()
		if State.cashPopCounter == id then MainGui.PlusCash.Visible = false end
	end)
end

-- ── VehicleStateBinder maid cleanup ──────────────────────────
local function giveVehicleStateMaidTask(state)
	state.maid:GiveTask(function()
		local packet = state.packet
		if packet and packet.Sounds then
			for _, s in next, packet.Sounds do s.Volume = 0 end
		end
		if packet and packet.Type == "Heli" then
			packet.PropAlpha = 0
			updateHeliLowQuality(packet, 0)
		end
	end)
end
for _, state in VehicleStateBinder:GetAll() do giveVehicleStateMaidTask(state) end
VehicleStateBinder:GetClassAddedSignal():Connect(giveVehicleStateMaidTask)

function em.clearPlayerLookState(playerName) LookState.playerData[playerName] = nil end

-- ── Zoom controller ───────────────────────────────────────────
local ZoomController
pcall(function()
	ZoomController = require(LocalPlayer.PlayerScripts.PlayerModule.CameraModule:WaitForChild("ZoomController"))
end)

-- ── Camera transition helper ──────────────────────────────────
local function transitionCamera(target, duration, offsetA, offsetB, endDist, useOffset, rotOffset)
	local maid = Maid.new()
	local cam  = Modules.CinematicCamera.MakeCinematicCamera()
	cam.Position   = CurrentCamera.CFrame.Position
	cam.LookVector = CurrentCamera.CFrame.LookVector
	CurrentCamera.CameraType = Enum.CameraType.Scriptable
	maid:GiveTask(function() CurrentCamera.CameraType = Enum.CameraType.Custom end)
	local orientation = rotOffset or (target.CFrame - target.CFrame.p)
	local progress    = 0
	maid:GiveTask(RunService.RenderStepped:Connect(function(dt)
		progress += dt * (1 / duration)
		local tCF = useOffset and (orientation + target.CFrame.p) or target.CFrame
		cam.TargetPosition = tCF * offsetA
		cam.TargetFocus    = tCF * offsetB
		Modules.CinematicCamera.StepCinematicCamera(dt, cam,
			progress * 50 * progress + 10, progress * 50 * progress + 6)
		if progress >= 1 then
			maid:Destroy()
			Modules.PlayerModuleService.setCameraToSubjectDistance(endDist)
			if ZoomController then ZoomController.ReleaseSpring() end
		end
	end))
	return maid
end
Modules.CinematicCamera = nil  -- release after capturing in closure above

-- ── Vehicle Buy UI ────────────────────────────────────────────
local VehicleBuyUI    = require(RS.App.VehicleBuyUI)()
local MilestoneEffects = require(RS.App.MilestoneEffects)
MilestoneEffects.init(spawnFireworks)
VehicleBuyUI.Frame.Parent = MainGui

local function cancelVehiclePurchase() VehicleBuyUI.setEnabled(false); onJump() end

local function rentVehicle()
	if not State.pendingVehicleId then
		cancelVehiclePurchase()
	else
		Services.MarketplaceService:PromptProductPurchase(LocalPlayer, 437705749)
		fireServer("bnmm3bwz", State.pendingVehicleId)
	end
end

VehicleBuyUI.onAction:Connect(function(action)
	if action == "Buy" then
		if not State.pendingVehicleId then cancelVehiclePurchase()
		else fireServer("aui8hjlb", State.pendingVehicleId) end
	elseif action == "Cancel" then
		cancelVehiclePurchase()
	elseif action == "Cash" then
		VehicleBuyUI.setEnabled(false); onJump(); CashBuyUI.Open()
	elseif action == "Rent" then
		rentVehicle()
	end
end)

function em.handleVehiclePurchaseResult(result)
	if result.Success then
		VehicleBuyUI.setEnabled(false); spawnFireworks(5)
	elseif result.NotEnoughMoney then
		VehicleBuyUI.setEnabled(false); onJump(); CashBuyUI.Open()
	elseif result.LowLevel then
		em.showNotification({ Title = "Vehicle", Text = ("This requires level %d."):format(result.LowLevel) })
	else
		VehicleBuyUI.setEnabled(false); onJump()
	end
end

Modules.waitForChild(RS, "UpdateOwnedCashBillboard"):andThen(function(remote)
	remote.OnClientEvent:Connect(function(owned) nitroState.VehiclesOwned = owned end)
end)

function em.updateRentedVehicles(rented) nitroState.VehiclesRented = rented end

local ItemUtils = require(RS.App.ItemUtils)

function em.showVehiclePurchasePrompt(vehicleId, passData, rentable)
	State.pendingVehicleId = vehicleId
	if passData then
		promptPurchase(passData)
	elseif Settings.Price[vehicleId] then
		VehicleBuyUI.setVehicle(
			ItemUtils.getTranslatedTitleFromItemTable(ItemUtils.createVehicleItemTable(vehicleId)),
			Settings.Price[vehicleId], rentable)
		VehicleBuyUI.setEnabled(true)
		Modules.EzUtils.selectIfGamepad(VehicleBuyUI.BuyButton)
	elseif vehicleId == "EscapeBot" then
		em.showNotification({ Text = "Roll the Legendary EscapeBot from a CEO Battle to fly" })
	else
		em.showNotification({ Text = "This vehicle cannot be purchased!" })
	end
end

function em.showVehicleLockedMessage()
	local msg = MainGui.SimpleMessage
	msg.Visible = true
	msg.Text    = Localization:FormatByKey("Vehicle.Locked")
	delay(1, function() msg.Visible = false end)
end

-- ── Vehicle follow-camera setting ────────────────────────────
local followCamSetting = {
	name         = "useVehicleFollowCamera",
	title        = "Vehicle Follow Camera",
	type         = Modules.gameSettingType.Checkbox,
	defaultValue = not Modules.RunUtils.isStudio(),
	order        = 50,
}
GameSettingsService.add(followCamSetting)

local function applyFollowCam(enabled)
	if State.vehiclePacket then
		local subject = VehicleUtils.prepareCameraSubject(State.vehiclePacket, enabled)
		if CurrentCamera.CameraType == Enum.CameraType.Custom then
			CurrentCamera.CameraType = Enum.CameraType.Scriptable
			CurrentCamera.CameraType = Enum.CameraType.Custom
		end
		if subject then CurrentCamera.CameraSubject = subject end
	end
end
applyFollowCam(followCamSetting:getValue())
followCamSetting.onChanged:Connect(applyFollowCam)

GameSettingsService.add({
	name = "autoLockVehicle", title = "Lock/Unlock Vehicle On Enter/Exit",
	type = Modules.gameSettingType.Checkbox, defaultValue = false, order = 51,
})

-- ── Vehicle enter helpers ─────────────────────────────────────
local function predicateWaitForMe(name) return name == LocalPlayer.Name end

function em.resolveStreamedVehiclePacket(objValue, packet)
	Modules.StreamingHelperUtils.yieldForObjValuePopulated(objValue)
	local _Packet = objValue.Value:WaitForChild("_Packet")
	Modules.StreamingHelperUtils.yieldForAllValuesPopulated(_Packet)
	Modules.TableUtils.mergeDeepInPlace(Modules.TableUtils.createTableFromObjectValues(_Packet), packet)
	em.waitForLocalVehicleSeat(packet)
end

function em.waitForLocalVehicleSeat(packet)
	local promises = {}
	for _, child in packet.Model:GetChildren() do
		if child:IsA("BasePart") and (child.Name == "Seat" or child.Name == "Passenger") then
			local pnv = child:FindFirstChild("PlayerName")
			if pnv then
				table.insert(promises,
					RxInstanceUtils.waitForProperty(pnv, "Value", predicateWaitForMe)
						:andThen(function() return child end))
			end
		end
	end
	State.enterVehiclePromise = Modules.Promise.race(promises):timeout(5)
	local ok, seat = State.enterVehiclePromise:await()
	if not ok or not seat then warn("failed to find vehicle seat. aborting."); return end
	packet.Seat = seat
end

-- ── Vehicle OnEntered ─────────────────────────────────────────
VehicleUtils.OnVehicleEntered:Connect(function(packet)
	local seatMaid = packet.seatMaid
	if not packet.Passenger then
		seatMaid.sirensButton = nil
		if packet.Model and packet.Model:FindFirstChild("Model") and packet.Type ~= "Heli" then
			seatMaid:GiveTask(RxInstanceUtils.observeOneChildNamed(packet.Model.Model, "Lights", function(lights)
				if lights then
					seatMaid.sirensButton = Modules.ActionButtonService.add({
						priority = 450, image = "rbxassetid://4939739355",
						keyCodes = { Enum.KeyCode.F, Enum.KeyCode.ButtonB },
						onPressed = function() Classes.Chassis.toggleSirens() end,
					})
				else
					seatMaid.sirensButton = nil
				end
			end))
		end
		seatMaid.camToggleButton = nil
		seatMaid:GiveTask(RxInstanceUtils.observeOneChildNamed(packet.Model, "InsideCamera", function(cam)
			if cam then
				seatMaid.camToggleButton = Modules.ActionButtonService.add({
					priority = 550, image = "rbxassetid://4939741662",
					keyCodes = { Enum.KeyCode.C, Enum.KeyCode.ButtonR3 },
					onPressed = function() Classes.Chassis.toggleInsideCamera() end,
				})
			else
				seatMaid.camToggleButton = nil
			end
		end))
	end
end)

-- ── Vehicle exit ──────────────────────────────────────────────
function em.exitVehicle()
	if State.enterVehiclePromise then State.enterVehiclePromise:cancel() end
	if not State.vehiclePacket then return end

	VehicleUtils.OnVehicleJumpExited:Fire(State.vehiclePacket)
	local packet          = State.vehiclePacket
	local vType, vMake    = packet.Type, packet.Make
	State.vehiclePacket   = nil

	if packet.Nitro then stopNitro() end
	packet.Nitro = false
	if packet.Nitrous then
		for _, emitter in next, packet.Nitrous do emitter.Enabled = false end
	end
	if packet.IsCameraLocked then Classes.Chassis.toggleInsideCamera(packet) end

	local makeClass = Classes[vMake]
	if makeClass and makeClass.vehicleLeave then
		makeClass.vehicleLeave(packet)
	elseif vType == "Chassis"                    then Classes.Chassis.VehicleLeave(packet)
	elseif vType == "Heli"                       then Classes.Heli.VehicleLeave(packet)
	elseif vType == "Motorcycle" or vType == "DuneBuggy" then Classes.Chassis2.VehicleLeave(packet)
	elseif vType == "Custom" and vMake == "Volt" then Classes.Volt.VehicleLeave(packet)
	end

	packet.seatMaid:Destroy(); packet.seatMaid = nil
	local equipped = ItemSystem.GetLocalEquipped()
	if equipped and equipped.IsLeaning then equipped:SetLeaning(false) end
	VehicleUtils.OnVehicleExited:Fire(packet, packet.Passenger)

	if InputUtils.isTouch() then
		State.isSprinting = true
		if not not DefaultActions.sprintButton._pressed ~= true and DefaultActions.sprintButton._pressState then
			DefaultActions.sprintButton._pressState()
		end
	end
	VehicleUtils.fixNetworkingCharacters()
end

VehicleUtils.OnVehicleJumpExited:Connect(function(packet)
	local character = LocalPlayer.Character
	if character then
		for _, child in character:GetDescendants() do
			if child:IsA("JointInstance") or child:IsA("AnimationConstraint") then
				local jc0 = child:FindFirstChild("JointC0")
				if jc0 then Modules.ConstraintUtils.setJointC0(child, jc0.Value) end
				local jc1 = child:FindFirstChild("JointC1")
				if jc1 then Modules.ConstraintUtils.setJointC1(child, jc1.Value) end
			end
		end
	end

	local seatMaid = packet.seatMaid
	if seatMaid then task.defer(seatMaid.DoCleaning, seatMaid) end
	if seatMaid and seatMaid._tasks and #seatMaid._tasks == 0 then return end

	if character and character.PrimaryPart then
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			humanoid.Sit = true
			local sitConn
			sitConn = humanoid:GetPropertyChangedSignal("Sit"):Connect(function()
				if not humanoid.Sit then humanoid.Sit = true end
			end)
			task.delay(0.3, function()
				sitConn:Disconnect()
				humanoid.Sit = false
				humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
			end)
		end
	end

	if packet.SeatWeld then packet.SeatWeld:Destroy(); packet.SeatWeld = nil end

	local bbox = packet.Model and packet.Model:FindFirstChild("BoundingBox")
	if character and character.PrimaryPart then
		local rootPart    = character.PrimaryPart
		local ejectHeight = 0
		if packet.Model and bbox then
			ejectHeight = character.PrimaryPart.CFrame:ToObjectSpace(
				bbox.CFrame * CFrame.new(0, bbox.Size.Y * 0.5, 0)).Y
		end
		local rayParams = RaycastParams.new()
		local filterList = { workspace:FindFirstChild("Vehicles") }
		for _, p in Players:GetPlayers() do table.insert(filterList, p.Character) end
		rayParams.FilterDescendantsInstances = filterList
		local targetUp = ejectHeight + 6
		local hit = workspace:Raycast(character.PrimaryPart.Position, newV3(0, targetUp, 0), rayParams)
		if hit then targetUp = math.max(0, hit.Distance - 2) end
		character:SetPrimaryPartCFrame(rootPart.CFrame + newV3(0, targetUp, 0))
	end
end)

-- ── Vehicle state helpers ─────────────────────────────────────
function em.updateCurrentVehiclePacket(updates)
	if not State.vehiclePacket then return end
	for k, v in next, updates do State.vehiclePacket[k] = v end
end

function em.forceHeliFallOutOfSky()
	if not State.vehiclePacket then return end
	if State.vehiclePacket.Type ~= "Heli" then return end
	Classes.Heli.FallOutOfSky(State.vehiclePacket)
end

function em.spinOutVehicle(data)
	if not State.vehiclePacket then error("no vehicle packet") end
	if State.vehiclePacket.Type == "Chassis" then
		Classes.Chassis.SpinOut(State.vehiclePacket, data)
	else
		error(("Cannot spin-out vehicle type: %s"):format(State.vehiclePacket.Type))
	end
end

function em.spawnCrashParticles(part)
	local p = Instance.new("Part")
	p.Name = "CrashParticles"; p.Transparency = 1; p.Anchored = true; p.CanCollide = false
	p.CFrame = part.CFrame + part.Parent.Engine.CFrame.LookVector * 5
	p.Size = part.Size; p.Parent = workspace
	local emitter = RS.Resource.CrashParticle:Clone()
	emitter.Parent = p
	emitter:Emit(8); wait(); emitter:Emit(8); wait(); emitter:Emit(8); wait()
	game.Debris:AddItem(p, 5)
end

function em.cancelOrDampenVelocity()
	local character = LocalPlayer.Character
	if not character then return end
	local root = character.PrimaryPart
	if not root then return end
	if State.vehiclePacket then
		root.Velocity *= 0.5; root.RotVelocity *= 0.5
	else
		root.Velocity = newV3(); root.RotVelocity = newV3()
	end
end

function em.showFaultyActionMessage()
	MainGui.FaultyAction.Visible = true
	wait(4)
	MainGui.FaultyAction.Visible = false
end

-- ── Proximity / interest system ───────────────────────────────
local interestQueue    = {}
local interestToLoad   = {}
local interestToUnload = {}

local InterestManager = {}

function InterestManager.AddPart(part, dist, callback, meta)
	local entry = { Part = part, Distance = dist, f = callback, Meta = meta }
	table.insert(interestQueue, entry)
	return entry
end

function InterestManager.RemoveTag(tag)
	for i = #interestQueue, 1, -1 do
		if interestQueue[i].Meta.Tag == tag then
			table.remove(interestQueue, i); return true
		end
	end
	return false
end

function InterestManager.UpdateInterest(position)
	interestToLoad = {}; interestToUnload = {}
	for i = #interestQueue, 1, -1 do
		if not interestQueue[i].Part then table.remove(interestQueue, i) end
	end
	for _, entry in next, interestQueue do
		entry.Center = entry.Part.Position
		local dist   = (entry.Center - position).magnitude
		entry.Sort   = dist
		local inRange = dist < entry.Distance or entry.Locked
		if inRange and not entry.Loaded then
			table.insert(interestToLoad, entry)
		elseif not inRange and entry.Loaded then
			table.insert(interestToUnload, entry)
		end
	end
end

local function processInterestQueue()
	while #interestToLoad > 0 do
		local entry = table.remove(interestToLoad, 1)
		entry.Loaded = true; entry:f(entry.Loaded)
	end
	while #interestToUnload > 0 do
		local entry = table.remove(interestToUnload)
		entry.Loaded = false; entry:f(entry.Loaded)
	end
end

function InterestManager.Run(interval)
	threadLoopAdd(interval, processInterestQueue)
end
InterestManager.Run(0.1)

-- ── Context buttons (Y-key) ───────────────────────────────────
local sortedContextButtons = {}
local touchQueue           = {}

do  -- clone ButtonY resource but don't store as top-level local
	local _ = RS.Resource.ButtonY:Clone()
end

local function proximityUpdate(entry, loaded)
	if loaded then
		table.insert(sortedContextButtons, Math.BinaryFind(sortedContextButtons, entry.Sort), entry)
	else
		for i, e in ipairs(sortedContextButtons) do
			if e == entry then table.remove(sortedContextButtons, i); break end
		end
	end
end

local function addContextButton(part, dist, callback, tag)
	return InterestManager.AddPart(part, dist, proximityUpdate, { Callback = callback, Tag = tag })
end

local function removeContextButtonByTag(tag)
	return InterestManager.RemoveTag(tag)
end

local function processContextInput(input)
	local isY = (input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == Enum.KeyCode.ButtonY)
		or (input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Y)
	if not isY then return end
	local first = sortedContextButtons[1]
	if not first then return end
	for _, entry in next, sortedContextButtons do
		if entry.Meta.Button == first.Meta.Button then
			coroutine.resume(coroutine.create(function()
				entry.Meta.Callback(LocalPlayer)
			end))
		end
	end
end

UserInputService.InputBegan:connect(function(input, processed)
	if not processed then processContextInput(input) end
end)

-- ── Door system ───────────────────────────────────────────────
local function findDoorLight(doorModel)
	local lv = doorModel:FindFirstChild("Light")
	if lv and lv:IsA("ObjectValue") and lv.Value and lv.Value:IsA("BasePart") then return lv.Value end
	local m = doorModel:FindFirstChild("Model")
	if m and m:FindFirstChild("Light") then return m.Light end
end

local function slideDoor(doorState)
	local open     = doorState.State.Open
	local doorModel = doorState.Model
	RxInstanceUtils.yieldForProperty(doorModel.Model, "PrimaryPart")
	local light    = findDoorLight(doorModel)
	local openCF   = doorState.OpenCFrame
	local closedCF = doorState.ClosedCFrame
	local function finish()
		if open then doorModel.Model:SetPrimaryPartCFrame(openCF)
		else doorModel.Model:SetPrimaryPartCFrame(closedCF)
			if light then light.Color = Color3.fromRGB(163, 75, 75) end
		end
	end
	if doorState.State.NoAnimate then doorState.State.NoAnimate = false; return finish() end
	if open and light then light.Color = Color3.fromRGB(102, 137, 172) end
	local maid     = doorState.doorMaid
	local progress = 0
	local duration = doorState.Settings.Duration
	maid.Stepped = RunService.Heartbeat:connect(function(dt)
		progress += dt / duration
		local t = progress * 2
		local alpha = t < 1 and 0.5*t*t or -0.5*((t-1)*(t-3)-1)
		if not open then alpha = 1 - alpha end
		doorModel.Model:SetPrimaryPartCFrame(closedCF:lerp(openCF, alpha))
		if progress >= 1 then
			maid.Stepped = nil
			if open then doorModel.Model:SetPrimaryPartCFrame(openCF)
			else doorModel.Model:SetPrimaryPartCFrame(closedCF)
				if light then light.Color = Color3.fromRGB(163, 75, 75) end
			end
		end
	end)
end

local function swingDoor(doorState)
	local open     = doorState.State.Open
	local doorModel = doorState.Model
	RxInstanceUtils.yieldForProperty(doorModel.Model, "PrimaryPart")
	local light     = findDoorLight(doorModel)
	local closedCF  = doorState.ClosedCFrame
	local hingeCF   = doorState.HingeRelativeCFrame
	local swingAxis = newV3(0, (math.pi * 0.55) * (doorState.State.Direction * doorState.Direction), 0)
	local function finish()
		if open then
			doorModel.Model:SetPrimaryPartCFrame(closedCF * hingeCF * Math.CFrameFromAxisAngle(swingAxis) * hingeCF:inverse())
		else
			doorModel.Model:SetPrimaryPartCFrame(closedCF)
			if light then light.Color = Color3.fromRGB(163, 75, 75) end
		end
	end
	if doorState.State.NoAnimate then doorState.State.NoAnimate = false; return finish() end
	if open and light then light.Color = Color3.fromRGB(102, 137, 172) end
	local maid     = doorState.doorMaid
	local progress = 0
	local duration = doorState.Settings.Duration
	maid.Stepped = RunService.Heartbeat:connect(function(dt)
		progress += dt / duration
		local t = progress * 2
		local alpha = t < 1 and 0.5*t*t or -0.5*((t-1)*(t-3)-1)
		if not open then alpha = 1 - alpha end
		doorModel.Model:SetPrimaryPartCFrame(
			closedCF * hingeCF * Math.CFrameFromAxisAngle(newV3():lerp(swingAxis, alpha)) * hingeCF:inverse())
		if progress >= 1 then maid.Stepped = nil; finish() end
	end)
end

local doorRegistry = {}  -- resolved door states

local function doorSequence(door)
	if door.Settings.SequenceRequireState and door.State.Open then return end
	if door.Resolved then
		door.State.Open = true
		if door.OpenFun then door:OpenFun(); return end
	else
		door.AwaitingDoorOpen = true; door.AwaitingDoorClose = false
	end
	fireServer("d6axuq6a", door)
end

local function doorHasPerm(door, _player, character)
	if door.Settings.ServerOnly then return false end
	if door.Settings.Locked     then return false end
	-- seated/vehicle check deferred to server
	return true
end

local function registerDoor(door)
	assert(door.Resolved)
	local doorModel   = door.Model
	local lastTouch   = tick()
	local lastTrigger = tick()

	local function doorPlayer(fromClick)
		local now = tick()
		local character = LocalPlayer.Character
		if not character or not character.PrimaryPart then return end
		if now - lastTouch < 0.1 then return end
		lastTouch = now
		if door.State.Open then return end
		if os.time() - door.State.CloseTime < door.Settings.Duration then return end
		local perm = doorHasPerm(door, LocalPlayer, character)
		if door.Settings.Character then
			playSound("Door", perm
				and { Source = doorModel.Closed, TimeStart = 1,   Volume = 0.2 }
				or  { Source = doorModel.Closed, TimeStart = 0,   MaxTime = 0.6, Volume = 0.2 })
		end
		if not perm then return end
		if door.Settings.Type == "Swing" then
			door.State.Direction = (door.Model.Closed.Position - character.HumanoidRootPart.Position).unit
				:Dot(door.Model.Closed.CFrame.lookVector) > 0 and 1 or -1
		end
		doorSequence(door)
	end

	local function onTouched()
		local now = tick()
		if now - lastTrigger < (1/30) then return end
		lastTrigger = now; doorPlayer()
	end
	local function onMouseClick(p)
		if p ~= LocalPlayer then return end; doorPlayer(true)
	end

	assert(door.doorMaid == nil, "Door already has a door maid: " .. doorModel:GetFullName())
	local doorMaid = Maid.new()
	door.doorMaid  = doorMaid

	for _, child in doorModel:GetChildren() do
		if child:IsA("BasePart") and child.Name == "Touch" then
			table.insert(touchQueue, { Tag = door.Tag, Part = child, Fun = onTouched, _DEBUG = "DoorTouchPart" })
		elseif child:IsA("ObjectValue") and child.Name == "Touch" then
			local entry = { Tag = door.Tag, Part = child.Value, Fun = onTouched, _DEBUG = "DoorTouchObjValue" }
			doorMaid:GiveTask(child.Changed:Connect(function(np) entry.Part = np end))
			table.insert(touchQueue, entry)
		elseif child:IsA("ObjectValue") and child.Name == "Button" then
			local bMaid = Maid.new()
			doorMaid:GiveTask(bMaid)
			local function processButton()
				bMaid:DoCleaning()
				if not child.Value then return end
				local bp = child.Value
				assert(bp:IsA("BasePart"), "missing button part")
				local cd = bp:WaitForChild("ClickDetector", 5)
				assert(cd, "missing button click detector")
				addContextButton(bp, cd.MaxActivationDistance, onMouseClick, door.Tag).Meta.Button = bp
				doorMaid:GiveTask(cd.MouseClick:Connect(onMouseClick))
				doorMaid:GiveTask(function() removeContextButtonByTag(door.Tag) end)
			end
			task.spawn(processButton)
			doorMaid:GiveTask(child.Changed:Connect(processButton))
		end
	end
end

local function unregisterDoor(door)
	assert(not door.Resolved)
	local tag = door.Tag
	for i = #touchQueue, 1, -1 do
		if touchQueue[i].Tag == tag then table.remove(touchQueue, i) end
	end
	InterestManager.RemoveTag(tag)
	if door.doorMaid then door.doorMaid:DoCleaning(); door.doorMaid = nil end
end

-- ── TouchTrigger tag ─────────────────────────────────────────
local function addTouchTrigger(part)
	local lastFire = 0
	table.insert(touchQueue, {
		Part = part, _DEBUG = "OtherTrigger",
		Fun  = function()
			local now = tick()
			if now - lastFire < 1 then return end
			lastFire = now
			fireServer("hh53gdcz", part)
		end,
	})
end

local function removeTouchTrigger(part)
	for i = #touchQueue, 1, -1 do
		if touchQueue[i].Part == part then table.remove(touchQueue, i); return end
	end
end

for _, part in next, CollectionService:GetTagged("TouchTrigger") do addTouchTrigger(part) end
CollectionService:GetInstanceAddedSignal("TouchTrigger"):Connect(addTouchTrigger)
CollectionService:GetInstanceRemovedSignal("TouchTrigger"):Connect(removeTouchTrigger)

-- ── SewerHatch ────────────────────────────────────────────────
local CircleAction = UI.CircleAction

local function addSewerHatch(hatchFolder)
	local hatchPart = assert(hatchFolder:FindFirstChild("SewerHatch"), "missing SewerHatch")
	local function action(_entry, completed)
		if completed then fireServer("y0hz2s1e", "SewerHatch", hatchPart) end
		return true
	end
	if hatchFolder:FindFirstChild("FromTop").Value then
		CircleAction.Add({ Part = hatchPart, Name = "Pull Open",
			Timed = true, Duration = 3, Dist = 10, Callback = action }, hatchFolder)
	end
	local entry = { Tag = hatchFolder, Part = hatchFolder:FindFirstChild("Touch"), _DEBUG = "SewerHatch" }
	function entry.Fun()
		fireServer("y0hz2s1e", "SewerHatch", hatchPart); return true
	end
	table.insert(touchQueue, entry)
end

for _, v in next, CollectionService:GetTagged("SewerHatch") do addSewerHatch(v) end
CollectionService:GetInstanceAddedSignal("SewerHatch"):Connect(addSewerHatch)
CollectionService:GetInstanceRemovedSignal("SewerHatch"):Connect(function(folder)
	CircleAction.Remove(folder)
	for i = #touchQueue, 1, -1 do
		if touchQueue[i].Tag == folder then table.remove(touchQueue, i); return end
	end
end)

-- ── Periodic touch check ──────────────────────────────────────
threadLoopAdd(1/6, function()
	local character = LocalPlayer.Character
	if not character then return end
	local root = character.PrimaryPart
	if not root then return end
	for _, entry in next, touchQueue do
		if not entry.Part or not entry.Part:IsDescendantOf(workspace) then
			warn("TouchQueue has invalid part", entry._DEBUG)
		elseif Math.IsPointInPrism(root.Position, entry.Part.CFrame, entry.Part.Size + newV3(4, 6, 4)) then
			entry.Fun(root)
		end
	end
end)

-- ── Door collection service ───────────────────────────────────
local function removeDoor(model)
	for _, door in next, doorRegistry do
		if door.Model == model then
			assert(door.Resolved, "Door was not resolved:" .. model:GetFullName())
			door.Resolved = false; door.Model = nil
			unregisterDoor(door); return true
		end
	end
	return false
end

for _, model in next, CollectionService:GetTagged("Door") do task.spawn(function() end) end
CollectionService:GetInstanceAddedSignal("Door"):Connect(function() end)
CollectionService:GetInstanceRemovedSignal("Door"):Connect(removeDoor)

local function receiveDoor(doorData)
	assert(doorData.Tag)
	local existing
	for _, d in next, doorRegistry do
		if d.Tag == doorData.Tag then existing = d; break end
	end
	if not existing then
		existing = doorData; table.insert(doorRegistry, existing)
	else
		for k, v in pairs(doorData) do existing[k] = v end
	end
	if doorData.Settings.Type == "Swing" then
		existing.OpenFun  = function(d) swingDoor(d) end
		existing.CloseFun = function(d) d.State.Open = false; swingDoor(d) end
	else
		existing.OpenFun  = function(d) slideDoor(d) end
		existing.CloseFun = function(d) d.State.Open = false; slideDoor(d) end
	end
	existing.Resolved = true
	for _, m in next, CollectionService:GetTagged("Door") do
		if m:GetAttribute("DoorTag") == doorData.Tag then
			existing.Model = m; registerDoor(existing); break
		end
	end
end

local function receiveDoors(doorsData)
	for _, door in next, doorsData do receiveDoor(door) end
	for _, model in next, CollectionService:GetTagged("Door") do
		if model then end  -- trigger addDoor if needed
	end
end

function em.openDoor(doorState)
	if doorState.Resolved and doorState.OpenFun then
		doorState.State.Open = true; doorState:OpenFun()
	else
		doorState.AwaitingDoorOpen = true; doorState.AwaitingDoorClose = false
	end
end

function em.closeDoor(doorState)
	if doorState.Resolved and doorState.CloseFun then
		doorState.State.Open = false; doorState:CloseFun()
	else
		doorState.AwaitingDoorOpen = false; doorState.AwaitingDoorClose = true
	end
end

function em.receiveDoorState(doorData)  receiveDoor(doorData)   end
function em.receiveDoorsState(doorsData) receiveDoors(doorsData) end

-- ── Sound / shadow settings ───────────────────────────────────
local function addSliderSetting(name, title, order, soundGroup)
	local cfg = { name = name, title = title,
		type = Modules.gameSettingType.Slider, defaultValue = 100,
		order = order, min = 0, max = 100, step = 1,
		textMap = function(v) return ("%d%%"):format(v) end }
	GameSettingsService.add(cfg)
	local function apply(v)
		Services.SoundService[soundGroup].Volume = math.clamp(v / 100, 0, 1)
	end
	apply(cfg:getValue())
	cfg.onChanged:Connect(apply)
end
addSliderSetting("robberyMusic", "Robbery Music",  10, "RobberyMusic")
addSliderSetting("otherRadios",  "Other Radios",   11, "OtherRadios")

local lightShadowsEnabled = true
do
	local cfg = { name = "lightShadows", title = "Light Shadows",
		type = Modules.gameSettingType.Checkbox, defaultValue = true, order = 500 }
	GameSettingsService.add(cfg)
	cfg.onChanged:Connect(function(enabled)
		lightShadowsEnabled = enabled
		for _, light in CollectionService:GetTagged("ShadowLight") do light.Shadows = enabled end
	end)
	CollectionService:GetInstanceAddedSignal("ShadowLight"):Connect(function(light)
		light.Shadows = lightShadowsEnabled
	end)
end

do
	local cfg = { name = "sunShadows", title = "Sun Shadows",
		type = Modules.gameSettingType.Checkbox, defaultValue = true, noSave = true, order = 510 }
	GameSettingsService.add(cfg)
	local function apply(enabled) game:GetService("Lighting").GlobalShadows = enabled end
	apply(cfg:getValue())
	cfg.onChanged:Connect(apply)
end

-- ── Ambient sounds ─────────────────────────────────────────────
local ambientSounds = {}
if not Modules.RunUtils.isStudio() or Settings.Test.Ambient then
	for name, assetId in next, Settings.AmbientIds do
		local sound      = Instance.new("Sound")
		sound.SoundId    = "rbxassetid://" .. assetId
		sound.Name       = name
		sound.Looped     = true
		sound.SoundGroup = Services.SoundService.Ambient
		sound.Parent     = Services.SoundService.Ambient
		ambientSounds[name] = sound
	end
end

local function setAmbientVolumes(volumes)
	for name, sound in next, ambientSounds do
		local vol = volumes[name] or 0
		if not sound.IsPlaying and vol > 0.01 then sound:Play()
		elseif sound.IsPlaying and vol <= 0.01 then sound:Stop() end
		sound.Volume = vol
	end
end

local MinimapService = require(RS.App.MinimapService)

if EnvironmentUtils.getTimeOfDay() == EnvironmentConsts.TIME_OF_DAY_ENUM.Day then
	setAmbientVolumes(lerpTable(Settings.Ambient.Day, Settings.Ambient.Day, 1))
else
	setAmbientVolumes(lerpTable(Settings.Ambient.Night, Settings.Ambient.Night, 1))
	MinimapService.updateMapImageColor3(Settings.Ambient.Night.Minimap)
end

local function transitionAmbient(fromAmbient, toAmbient)
	local conn; local progress = 0
	local vigElement
	local main = PlayerGui:FindFirstChild("Main")
	if main then vigElement = main.Frame.Vig end
	conn = RunService.Heartbeat:Connect(function()
		progress += 0 * (1 / 4)  -- matches original (dt was 0 after clock reset)
		if progress >= 1 then progress = 1; conn:disconnect() end
		local result = lerpTable(fromAmbient, toAmbient, progress)
		setAmbientVolumes(result)
		if vigElement then vigElement.ImageColor3 = result.Vig end
		MinimapService.updateMapImageColor3(result.Minimap)
	end)
end

-- ── Rain / snow ───────────────────────────────────────────────
local SNOW      = EnvironmentConsts.SNOW
local rainAsset = RS.Resource.Rain
rainAsset.Name  = "Rain"

local RainState = {
	connection    = nil,
	generation    = 0,
	insideBuilding = false,
	part          = rainAsset,
	isOutside     = not SNOW,
}

local function startRainThread()
	RainState.generation += 1
	for _, part in RainState.part:GetChildren() do
		if part:IsA("BasePart") then
			part.CanCollide = false; part.CanTouch = false
			part.CanQuery   = false; part.Transparency = 1
		end
	end
	RainState.part.Parent = workspace
	if RainState.connection then RainState.connection:Disconnect() end
	RainState.insideBuilding = false

	local smoothPos    = newV3()
	local smoothVelPos = newV3()

	RainState.connection = RunService.Heartbeat:Connect(function()
		debug.profilebegin("Rain Update")
		local char = LocalPlayer.Character
		if char then
			local root = char.PrimaryPart
			if root then
				smoothPos = root.Position
				smoothVelPos = SNOW
					and smoothPos + root.Velocity * newV3(1, 0, 1)
					or  smoothPos + root.Velocity * newV3(1, 0, 1) * 0.3
			end
		end
		local rp      = RainState.part
		local rainFall = rp.RainFall:FindFirstChild("Rain")
		local fogFall  = rp:FindFirstChild("FogFall")
		local droplets = rp.RainDroplets:FindFirstChild("Rain")
		rp.RainFall.CFrame = CFrame.new(smoothVelPos) + newV3(0, 37, 0)
		if fogFall then fogFall.CFrame = CFrame.new(smoothPos) + newV3(0, 37, 0) end
		local hitPart, hitPos = workspace:FindPartOnRayWithIgnoreList(
			Ray.new(smoothPos, newV3(0, -10, 0)),
			{ workspace:FindFirstChild("Vehicles"), LocalPlayer.Character, rp })
		rp.RainDroplets.CFrame = CFrame.new(hitPos) + newV3(0, 1.5, 0)
		local rp2 = RaycastParams.new()
		rp2.FilterDescendantsInstances = {
			workspace:FindFirstChild("Vehicles"), LocalPlayer.Character, rp, workspace:FindFirstChild("Clouds") }
		local underCover = Modules.Raycast.collidable(smoothPos, newV3(0, 1, 0), 100, rp2) ~= nil
		if rainFall then rainFall.Enabled = not underCover and not RainState.insideBuilding end
		if fogFall  then fogFall.RainFog.Enabled = not underCover and not RainState.insideBuilding end
		Services.SoundService.Ambient.CompressorSoundEffect.Enabled = underCover
		if not SNOW or RainState.isOutside or droplets then
			droplets.Enabled = hitPart ~= nil and not underCover
		end
		debug.profileend()
	end)
end

local function stopRainThread()
	if not SNOW then
		if RainState.connection then RainState.connection:Disconnect() end
		RainState.part.Parent = RS.Resource; RainState.connection = nil
	else
		RainState.insideBuilding = true
		local gen = RainState.generation
		task.delay(7, function()
			if RainState.connection and RainState.generation == gen then
				RainState.part.Parent = RS.Resource
				RainState.connection:Disconnect(); RainState.connection = nil
			end
		end)
	end
end

function em.updateTimeOfDay(timeOfDay)
	if timeOfDay == State.currentTimeOfDay then return end
	if timeOfDay == "Day" then
		transitionAmbient(Settings.Ambient[State.currentTimeOfDay], Settings.Ambient.Day)
	elseif timeOfDay == "Night" then
		transitionAmbient(Settings.Ambient[State.currentTimeOfDay], Settings.Ambient.Night)
	end
	State.currentTimeOfDay = timeOfDay
end

local function updateStorm()
	if EnvironmentUtils.getPrecipitation() == EnvironmentConsts.PRECIPITATION_ENUM.Rain then
		startRainThread()
		transitionAmbient(Settings.Ambient[State.currentTimeOfDay], Settings.Ambient.Storm)
		State.currentTimeOfDay = "Storm"
	else
		stopRainThread()
	end
end
task.spawn(updateStorm)
EnvironmentUtils.getPrecipitationChangedSignal():Connect(updateStorm)

-- ── Nitro shop GUI ────────────────────────────────────────────
State.nitroGuiHandle = RS.StarterGui.NitroShopGui
State.nitroGuiHandle.Parent = LocalPlayer.PlayerGui

local function openNitroShop()
	State.nitroGuiHandle.Enabled = true
	Modules.EzUtils.selectIfGamepad(
		State.nitroGuiHandle.Container.Container.ContainerButtons.Tier1.Button)
end
local function closeNitroShop() State.nitroGuiHandle.Enabled = false end

local nitroWindow = Modules.AlexWM.MakeWindow()
nitroWindow.OpenFun  = openNitroShop
nitroWindow.CloseFun = closeNitroShop
Modules.AlexWM.WindowGroupAdd(mainWindowGroup, nitroWindow)
State.nitroGuiHandle.Container.Close.MouseButton1Down:connect(function()
	Modules.AlexWM.WindowClose(nitroWindow)
end)

function em.setNitroShopVisible(open, skipGasStation)
	if Modules.RunUtils.isTradeWorld() then return end
	if open then
		if not skipGasStation then nitroState.AtGasStation = true end
		Modules.AlexWM.WindowOpen(nitroWindow)
	else
		nitroState.AtGasStation = false
		Modules.AlexWM.WindowClose(nitroWindow)
	end
end
VehicleUtils.NitroShopVisible = em.setNitroShopVisible

task.spawn(function()
	if not Settings.FetchedMarketplace then Settings.OnProductsFetched:Wait() end
	for _, product in next, Settings.DevProduct do
		if product.Type == "Nitro" then
			local btn = State.nitroGuiHandle.Container.Container.ContainerButtons:FindFirstChild(product.Name)
			if btn then
				btn.Button.Title.Text = ("+%d"):format(product.Fuel)
				btn.Button.MouseButton1Down:connect(function()
					if Settings.Scalar.NitroMax - 25 <= nitroState.Nitro then
						em.showNotification({ Title = "Rocket Fuel", Text = "You have a lot of fuel, go use it!" })
					else
						local hasPass = nitroState.AtGasStation
							or GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.PremiumGarage)
						if not hasPass then promptPurchase(Settings.Gamepass.PremiumGarage)
						else Services.MarketplaceService:PromptProductPurchase(LocalPlayer, product.Id) end
					end
				end)
			end
		end
	end
end)

-- ── HasEscaped (main world) ───────────────────────────────────
if Modules.RunUtils.isMainWorld() then
	local function updateHasEscaped()
		local escaped = LocalPlayer:GetAttribute("HasEscaped") == true
		initConfig.HasEscaped = escaped
		if escaped then
			em.showNotification({ Text = ("%s"):format(Localization:FormatByKey("Banner.EscapedDesc")), Duration = 6 })
			em.showNotification({ Text = ("%s"):format(Localization:FormatByKey("Banner.Escaped")), Style = "Alert", Duration = 6 })
		end
	end
	updateHasEscaped()
	LocalPlayer:GetAttributeChangedSignal("HasEscaped"):connect(updateHasEscaped)
end

function em.popVehicleTires()
	if State.vehiclePacket then VehicleUtils.setTireHealth(State.vehiclePacket.Model, 0) end
end

-- ── Help text cycle ───────────────────────────────────────────
local function cycleHelpMessage()
	local team, count
	if TeamValue.Value == Settings.Team.Prisoner then team = "Prisoner"; count = 3
	elseif TeamValue.Value == Settings.Team.Police then team = "Police";   count = 5 end
	if not team then return end
	local helpLabel = MainGui.Inventory.Help
	State.helpIndex = State.helpIndex % count + 1
	helpLabel.Text    = Localization:FormatByKey("Help." .. team .. (State.helpIndex - 1))
	helpLabel.Visible = true
end

-- ── Queue join ────────────────────────────────────────────────
function em.forwardEventAndDispatch(eventName, ...)
	if eventName == "ems" then
		delay(0.5, function() fireServer("jq86koa2", eventName) end)
	else
		fireServer("jq86koa2", eventName)
	end
	assert(em[eventName], eventName)(...)
end

-- ── Team select UI ────────────────────────────────────────────
require(RS.TeamSelect.TeamChooseUI).Init({ Event = Event, em = em, OnJump = onJump })

-- ── Notifications / chat ──────────────────────────────────────
function em.showSystemChatMessage(message, color)
	local formatted = Modules.RichTextUtils.addColorToText(message, color)
	pcall(function()
		Services.TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(formatted, "BadimoSystemMessage")
	end)
end

function em.showNotification(data)
	assert(data ~= nil); assert(data.Text ~= nil)
	Notification.new({ Text = data.Text, Duration = data.Duration, Style = data.Style })
end

function em.showBossNotification(message, extra)
	assert(message ~= nil); Notification.notifyBoss(message, extra)
end

initConfig.Notification = em.showNotification

function em.applyStunEffect()
	local duration = Settings.Time.Stunned
	Modules.HapticEffect.basic(1, 1)
	State.isStunned = true
	Falling.StartRagdolling(duration)
	local JetPackMod = require(RS.Game.JetPack.JetPack)
	JetPackMod.Stunned()
	task.wait(duration)
	State.isStunned = false
end

-- ── Vehicle billboard update ──────────────────────────────────
threadLoopAdd(0.1, function()
	local character = LocalPlayer.Character
	if not character then return end
	local root = character.PrimaryPart
	if not root then return end
	local isTutorialFree = LocalPlayer:GetAttribute("TutorialCanEnterAnyCarForFree") == true
	for _, vehicle in next, workspace.Vehicles:GetChildren() do
		local seat       = vehicle:FindFirstChild("Seat")
		local bbox       = vehicle:FindFirstChild("BoundingBox")
		local makeVal    = vehicle:FindFirstChild("Make")
		local gpRestrict = vehicle:GetAttribute("GamepassRestrict")
		if bbox and seat then
			local playerVal = seat:FindFirstChild("Player")
			local billboard = bbox:FindFirstChild("MoneyBillboard")
			if billboard and makeVal and playerVal then
				local shouldShow = false
				if (root.Position - bbox.Position).magnitude < 50 and not playerVal.Value then
					local owned  = nitroState.VehiclesOwned[makeVal.Value]
					local rented = not owned and nitroState.VehiclesRented[makeVal.Value]
					local gpPass = not rented and gpRestrict
						and GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass[gpRestrict])
					shouldShow = not (owned or rented or gpPass or isTutorialFree)
				end
				billboard.Enabled = shouldShow
			end
		end
	end
end)

-- ── Vehicle enter ─────────────────────────────────────────────
local function attemptVehicleEnter(seat)
	if not State.vehiclePacket then fireServer("qhtaomcf", seat.Parent, seat) end
end

function em.showCircleActionNotAllowed() wait(); UI.CircleAction.NotAllowed() end

-- ── Walk speed ────────────────────────────────────────────────
local InventoryItemUtils = require(RS.Inventory.InventoryItemUtils)
local MovementConsts     = require(RS.Movement.MovementConsts)

local function updateWalkSpeed()
	local character = LocalPlayer.Character
	if not character then return end
	local humanoid = character:FindFirstChild("Humanoid")
	if not humanoid then return end

	local healthScale = max(log(humanoid.Health + 1) / 4.61512051684126, 0.5)
	local equipped    = ItemSystem.GetLocalEquipped()
	if equipped then
		local itemName = InventoryItemUtils.getName(equipped.inventoryItemValue)
		if itemName == "Cuffed" then healthScale = 0
		elseif itemName == "ShieldSWAT" then healthScale *= 0.75 end
	end
	if State.isStunned then healthScale = 0 end

	local speedMult = 1.0
	if Falling.IsSkydiving() then speedMult *= 4
	elseif State.isSprinting then speedMult *= 1.5 end
	if CharacterUtil.IsJuiced then speedMult += 2 end

	if LocalPlayer.TeamValue.Value == Settings.Team.Prisoner then
		for spotlight in pairs(Classes.Heli.SpotlightBinder:GetAllSet()) do
			if spotlight.IsLocalInSpotlight then speedMult *= 0.75 end
		end
	end
	if character:FindFirstChild("IsInFloorCircle") then speedMult *= 0.5 end
	if humanoid:GetAttribute("IsInTrackingSpotlight") then speedMult *= 0.8 end
	if humanoid:GetAttribute(MovementConsts.NO_MOVEMENT_ATTR_NAME) then speedMult = 0 end

	local targetSpeed = healthScale * speedMult * 10
	if abs(targetSpeed - humanoid.WalkSpeed) > 0.1 then humanoid.WalkSpeed = targetSpeed end

	if State.activeAnimTrack and character.PrimaryPart then
		local localVel = character.HumanoidRootPart.CFrame:vectorToObjectSpace(character.PrimaryPart.Velocity)
		State.activeAnimTrack:AdjustSpeed(-localVel.Z / 6)
	end
end

-- ── Circle action per-entity logic ───────────────────────────
local function updateVehicleCircleAction(entry)
	local noVehicle = not State.vehiclePacket
	local part      = entry.Part
	if part and part.Parent then
		local shouldHotwire, shouldEject, shouldAllowEntry
		if TeamValue.Value == Settings.Team.Prisoner then
			local tr = part.Parent:GetAttribute("TeamRestrict")
			local gr = part.Parent:GetAttribute("GamepassRestrict")
			if tr and part.Name == "Seat" and tr ~= TeamValue.Value then
				shouldHotwire = gr and GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass[gr]) or true
			end
		elseif TeamValue.Value == Settings.Team.Police then
			local eq = ItemSystem.GetLocalEquipped()
			if eq and eq.__ClassName == "Handcuffs" then shouldEject = true end
		end
		if not shouldHotwire and not shouldEject then shouldAllowEntry = true end
		if entry.ShouldHotwire ~= shouldHotwire then
			entry.ShouldHotwire = shouldHotwire
			if shouldHotwire then entry.Name = Localization:FormatByKey("Action.Hijack"); entry.Timed = true; entry.Duration = 5.6 end
		end
		if entry.ShouldEject ~= shouldEject then
			entry.ShouldEject = shouldEject
			if shouldEject then entry.Name = Localization:FormatByKey("Action.Eject"); entry.Timed = false; entry.Duration = 1 end
		end
		if entry.ShouldAllowEntry ~= shouldAllowEntry then
			entry.ShouldAllowEntry = shouldAllowEntry
			if shouldAllowEntry then
				entry.Timed = false
				entry.Name  = part.Name == "Seat" and Localization:FormatByKey("Action.EnterDriver")
					or part:FindFirstChild("Turret") and "Enter Turret"
					or Localization:FormatByKey("Action.EnterPassenger")
			end
		end
		if entry.ShouldAllowEntry or entry.ShouldHotwire then
			local pv = part:FindFirstChild("Player")
			if pv and pv.Value then noVehicle = false end
		end
		entry.Dist = 12
	end
	if noVehicle ~= entry.Enabled then entry.Enabled = noVehicle end
end

local TradeUtils = require(RS.Trade.TradeUtils)
local Handcuffs  = require(RS.Game.ItemConfig.Handcuffs)

local function updatePlayerCircleAction(entry)
	local equipped = ItemSystem.GetLocalEquipped()
	local shouldArrest, shouldPickpocket, shouldCrimSearch, shouldBreakout, shouldTrade
	local playerName = entry.PlayerName

	if Modules.RunUtils.isTradingEnabled() then
		local tgt = Players:FindFirstChild(playerName)
		if tgt and tgt ~= LocalPlayer
			and TradeUtils.getPlayerTradeRequestsEnabled(tgt)
			and TradeUtils.getPlayerTradeRequestsEnabled(LocalPlayer)
			and not TradeService.checkAlreadyInitiated(LocalPlayer, tgt)
			and tgt.Character and tgt.Character:FindFirstChild("Humanoid")
		then shouldTrade = true end
	end

	local target = Players:FindFirstChild(playerName)
	if target and target.Character then
		local myChar    = LocalPlayer.Character
		local myTeam    = TeamValue.Value
		local theirTeam = target.TeamValue and target.TeamValue.Value
		if theirTeam == Settings.Team.Police and myTeam == Settings.Team.Prisoner then
			local myHum  = myChar and myChar:FindFirstChild("Humanoid")
			local myRoot = myChar and myChar.PrimaryPart
			local thRoot = target.Character.PrimaryPart
			if myRoot and thRoot and myHum and not myHum.Sit and not myHum.PlatformStand then
				local myCF = myRoot.CFrame; local thCF = thRoot.CFrame
				if myCF.lookVector:Dot(thCF.lookVector) > 0.333
					and thCF.lookVector:Dot((thCF.p - myCF.p).unit) > 0.333
				then shouldPickpocket = true end
			end
		end
		if myTeam == Settings.Team.Police and target.Character:GetAttribute("HasHandcuffs") then
			shouldCrimSearch = true
		end
		if myTeam == Settings.Team.Prisoner and theirTeam == Settings.Team.Prisoner
			and target.Character:GetAttribute("HasHandcuffs")
			and myChar and not myChar:GetAttribute("HasHandcuffs")
		then shouldBreakout = true end
	end

	if not shouldCrimSearch and not shouldBreakout
		and equipped and equipped.__ClassName == "Handcuffs"
		and TeamValue.Value == Settings.Team.Police
	then
		local tgt = Players:FindFirstChild(playerName)
		if tgt and tgt.TeamValue and tgt.TeamValue.Value == Settings.Team.Prisoner then
			local tc = tgt.Character
			if tc and not tc:GetAttribute("HasHandcuffs") and not tc:GetAttribute("InVehicle")
				and tc:FindFirstChild("Humanoid")
			then shouldArrest = true end
		end
	end

	if entry.ShouldArrest    ~= shouldArrest    then entry.ShouldArrest    = shouldArrest    end
	if entry.ShouldPickpocket ~= shouldPickpocket then entry.ShouldPickpocket = shouldPickpocket end
	if entry.ShouldCrimSearch ~= shouldCrimSearch  then entry.ShouldCrimSearch = shouldCrimSearch  end
	if entry.ShouldBreakout   ~= shouldBreakout   then entry.ShouldBreakout   = shouldBreakout   end
	if entry.ShouldTrade      ~= shouldTrade      then entry.ShouldTrade      = shouldTrade      end

	if shouldBreakout then
		entry.Duration = 2; entry.Timed = true; entry.Dist = 10
		entry.Name = Localization:FormatByKey("Action.Breakout")
	elseif shouldPickpocket or shouldCrimSearch then
		entry.Duration = 2; entry.Timed = true; entry.Dist = 10
		entry.Name = shouldCrimSearch
			and Localization:FormatByKey("Action.CrimSearch")
			or  Localization:FormatByKey("Action.Pickpocket")
	elseif shouldArrest then
		entry.Duration = 0.5; entry.Timed = true; entry.Dist = nil
		entry.HorizontalDist = Handcuffs.ArrestDistance
		entry.VerticalDist   = Handcuffs.ArrestDistance * 1.4
		entry.Name = Localization:FormatByKey("Action.Arrest")
	elseif shouldTrade then
		entry.Timed = false; entry.Dist = 10
		entry.Name = Localization:FormatByKey("Action.Trade")
	end

	local anyEnabled = shouldArrest or shouldPickpocket or shouldBreakout or shouldTrade or shouldCrimSearch
	if anyEnabled ~= entry.Enabled then entry.Enabled = anyEnabled end
end

local function updateCircleActions()
	debug.profilebegin("UpdateCircleActions (game)")
	local character = LocalPlayer.Character
	if not character then debug.profileend(); return end
	local root = character.PrimaryPart
	if not root then debug.profileend(); return end
	local pos = root.Position; local now = os.clock()
	for _, entry in ipairs(UI.CircleAction.SpecOctree:QueryRadius(pos, 64)) do
		if not entry.Kill then
			local partPos  = entry.Part and entry.Part.Position or newV3()
			local distance = (partPos - pos).Magnitude
			local rate     = distance < 16 and 0 or (distance - 16) / 48
			if rate < now - (entry._lastUpdateCheck or 0) then
				entry._lastUpdateCheck = now
				if entry.IsVehicle then
					updateVehicleCircleAction(entry)
				elseif entry.IsPlayer then
					updatePlayerCircleAction(entry)
				elseif entry.IsRob then
					local isPrisoner = TeamValue.Value == Settings.Team.Prisoner
					if entry.Enabled ~= isPrisoner then entry.Enabled = isPrisoner end
				end
			end
		end
	end
	debug.profileend()
end

-- ── LQ vehicle loops ──────────────────────────────────────────
RunService.Stepped:Connect(function()
	debug.profilebegin("LQVehicle Stepped")
	local now = os.clock()
	if LocalPlayer.Character then
		for state in VehicleStateBinder:GetAllSet() do
			local packet = state.packet
			if packet then
				local owner = Players:GetPlayerByUserId(state.obj:GetAttribute("VehicleStateUserId"))
				if owner ~= LocalPlayer then
					local model = packet.Model
					if model then
						local bbox = model:FindFirstChild("BoundingBox")
						if bbox then
							local dist = (bbox.Position - CurrentCamera.CFrame.p).Magnitude
							local rate = dist < 256 and 0 or (dist - 256) / 3840
							if rate < now - (packet._lastUpdateStepped or 0) then
								packet._lastUpdateStepped = now
								if packet.Type == "Chassis" then
									updateChassisStepped(packet)
								elseif packet.Type == "Motorcycle" or packet.Type == "DuneBuggy" then
									Classes.Chassis2.UpdateStepped(packet)
								end
							end
						end
					end
				end
			end
		end
	end
	debug.profileend()
end)

RunService.Heartbeat:Connect(function(dt)
	debug.profilebegin("LQVehicle Heartbeat")
	local now = os.clock()
	if LocalPlayer.Character then
		for state in VehicleStateBinder:GetAllSet() do
			local packet = state.packet
			if packet then
				if Players:GetPlayerByUserId(state.obj:GetAttribute("VehicleStateUserId")) ~= LocalPlayer then
					local model = packet.Model
					if model then
						local bbox = model:FindFirstChild("BoundingBox")
						if bbox then
							local dist = (bbox.Position - CurrentCamera.CFrame.p).Magnitude
							local rate = dist < 768 and 0 or (dist - 768) / 3328
							if rate < now - (packet._lastUpdateHeartbeat or 0) then
								packet._lastUpdateHeartbeat = now
								if     packet.Type == "Heli"    then updateHeliLowQuality(packet, dt)
								elseif packet.Type == "Chassis" then updateChassisLowQuality(packet, dt)
								elseif packet.Type == "Motorcycle" or packet.Type == "DuneBuggy" then
									Classes.Chassis2.UpdateLQ(packet, dt)
								end
							end
						end
					end
				end
			end
		end
	end
	debug.profileend()
end)

-- ── Main heartbeat ────────────────────────────────────────────
do
local lastTimeHour, lastTimeQuarter = 0, 0
RunService.Heartbeat:Connect(function()
	updateCircleActions()
	local teamVal = TeamValue.Value; local teamEnum
	if     teamVal == Settings.Team.Prisoner then
		teamEnum = initConfig.HasEscaped and Settings.EnumTeam.Criminal or Settings.EnumTeam.Prisoner
	elseif teamVal == Settings.Team.Police then
		teamEnum = Settings.EnumTeam.Police
	end
	if GameUtil.Team ~= teamEnum then GameUtil.Team = teamEnum; GameUtil.OnTeamChanged:Fire(teamEnum) end
	updateWalkSpeed()

	debug.profilebegin("Time/UI")
	local timeValue = workspace:FindFirstChild("Time")
	if timeValue then
		local raw     = timeValue.Value
		local frac    = raw % 1
		local hour    = raw - frac
		local quarter = floor(floor(frac * 60 + 0.5) / 15) * 15
		if quarter >= 60 then quarter -= 60; hour += 1 end
		if hour > 12 then hour -= 12 end
		if hour == 0 then hour = 12 end
		if hour ~= lastTimeHour or quarter ~= lastTimeQuarter then
			lastTimeHour = hour; lastTimeQuarter = quarter
			SidebarUI.SetTime(("%d:%02d %s"):format(hour, quarter, raw >= 12 and "PM" or "AM"))
		end
	end
	debug.profileend()
end)
end  -- do block for lastTimeHour/Quarter

-- ── Input ─────────────────────────────────────────────────────
local function onInputChanged(input)
	local vp = State.vehiclePacket
	if vp then
		if vp.Type == "Chassis" then Classes.Chassis.InputChanged(input, nil)
		elseif vp.Type == "Heli" then Classes.Heli.InputChanged(input, nil)
		elseif vp.Type == "Custom" and vp.Make == "Volt" then Classes.Volt.InputChanged(input, nil) end
	end
end

local function onInputBegan(input, processed)
	if processed then return end
	local isA = input.KeyCode == Enum.KeyCode.ButtonA
	local isLR = input.KeyCode == Enum.KeyCode.Left or input.KeyCode == Enum.KeyCode.Right
	if isA or isLR then
		local vp = State.vehiclePacket
		if vp then
			if vp.Type == "Chassis" then Classes.Chassis.InputBegan(input)
			elseif vp.Type == "Heli" then Classes.Heli.InputBegan(input)
			elseif vp.Type == "Custom" and vp.Make == "Volt" then Classes.Volt.InputBegan(input) end
		end
		if input.UserInputType == Enum.UserInputType.Keyboard
			and input.KeyCode == Enum.KeyCode.E
			and vp and vp.Type ~= "Heli"
		then onJump() end
	end
end

local function onInputEnded(input, processed)
	if processed then return end
	local isA = input.KeyCode == Enum.KeyCode.ButtonA
	local isLR = input.KeyCode == Enum.KeyCode.Left or input.KeyCode == Enum.KeyCode.Right
	if isA or isLR then
		local vp = State.vehiclePacket
		if vp then
			if vp.Type == "Chassis" then Classes.Chassis.InputEnded(input); return
			elseif vp.Type == "Heli" then Classes.Heli.InputEnded(input); return
			elseif vp.Type == "Custom" and vp.Make == "Volt" then Classes.Volt.InputEnded(input) end
		end
	end
end

UserInputService.InputBegan:connect(onInputBegan)
UserInputService.InputEnded:connect(onInputEnded)
UserInputService.InputChanged:connect(onInputChanged)

-- ── CircleAction: vehicle seats ───────────────────────────────
local CircleActionUI = UI.CircleAction

local function vehicleSeatAction(entry, completed)
	if completed then
		if entry.ShouldHotwire then attemptVehicleHotwire(entry.Part.Parent, true)
		elseif entry.ShouldEject then attemptVehicleEject(entry.Part.Parent)
		else attemptVehicleEnter(entry.Part) end
		return true
	end
	if entry.ShouldHotwire then
		attemptVehicleHotwire(entry.Part.Parent)
		em.showNotification({ Title = "Vehicle", Text = "Vehicle protected. Hold to hijack." })
	end
end

local function addVehicleSeat(seat)
	CircleActionUI.Add({ Part = seat, ValidRoot = seat.Parent, Name = "Enter",
		Timed = false, Duration = 1, Dist = 10, Callback = vehicleSeatAction, IsVehicle = true }, seat)
end
for _, seat in next, CollectionService:GetTagged("VehicleSeat") do addVehicleSeat(seat) end
CollectionService:GetInstanceAddedSignal("VehicleSeat"):Connect(addVehicleSeat)
CollectionService:GetInstanceRemovedSignal("VehicleSeat"):Connect(function(s) CircleActionUI.Remove(s) end)

-- ── CircleAction: players ─────────────────────────────────────
local function useHandcuffsOnPlayer(entry)
	local eq = ItemSystem.GetLocalEquipped()
	if not eq or eq.__ClassName ~= "Handcuffs" or eq.Reloading then return end
	if TeamValue.Value ~= Settings.Team.Police then return end
	local target = Players:FindFirstChild(entry.PlayerName)
	if not target or State.vehiclePacket then return end
	if target.TeamValue.Value ~= Settings.Team.Prisoner then return end
	local myChar = LocalPlayer.Character; if not myChar then return end
	local myHum = myChar:FindFirstChild("Humanoid")
	if not myHum or myHum.Health <= 0 then return end
	fireServer("el8n5q35", target); return true
end

local function playerAction(entry, completed)
	if entry.ShouldBreakout and not completed then
		local target = Players:FindFirstChild(entry.PlayerName)
		if target and not target:GetAttribute("SentBreakoutRequest") then
			target:SetAttribute("SentBreakoutRequest", true)
			fireServer("mykh4ggq", target.Name)
			task.delay(10, function() target:SetAttribute("SentBreakoutRequest", nil) end)
		end
	end
	if not completed then return true end
	local result
	if entry.ShouldArrest then
		result = useHandcuffsOnPlayer(entry)
	elseif entry.ShouldPickpocket or entry.ShouldCrimSearch then
		local tgt = Players:FindFirstChild(entry.PlayerName)
		if tgt then attemptPickPocket(tgt); result = true end
	elseif entry.ShouldBreakout then
		local tgt = Players:FindFirstChild(entry.PlayerName)
		if tgt then attemptBreakout(tgt); result = true end
	end
	if entry.ShouldTrade and (Modules.RunUtils.isTradeWorld() or not result) then
		local tgt = Players:FindFirstChild(entry.PlayerName)
		if tgt then attemptTrade(tgt); result = true end
	end
	return result
end

local function addCharacterToCircleAction(character)
	if character == LocalPlayer.Character then return end
	CircleActionUI.Add({
		Part = character:WaitForChild("UpperTorso", 3), ValidRoot = character,
		Name = "Player", Timed = true, Duration = 0.5, Dist = 15, Priority = 2,
		Callback = playerAction, PlayerName = character.Name, IsPlayer = true,
	}, character)
end

for _, binder in CharacterBinder:GetAll() do
	addCharacterToCircleAction(binder.obj)
	binder.maid:GiveTask(function()
		local obj = binder.obj
		if obj ~= LocalPlayer.Character then CircleActionUI.Remove(obj) end
	end)
end
CharacterBinder:GetClassAddedSignal():Connect(function(binder)
	addCharacterToCircleAction(binder.obj)
	binder.maid:GiveTask(function()
		local obj = binder.obj
		if obj ~= LocalPlayer.Character then CircleActionUI.Remove(obj) end
	end)
end)

-- ── CircleAction: small stores ────────────────────────────────
local function addSmallStore(part)
	CircleActionUI.Add({ Part = part, Name = "Rob", Timed = true, Duration = 10, Dist = 8,
		Callback = function(entry, completed)
			if completed then fireServer("sqjc842q", entry.Part.Parent); return true end
		end, IsRob = true }, part)
end
for _, part in next, CollectionService:GetTagged("SmallStore") do addSmallStore(part) end
CollectionService:GetInstanceAddedSignal("SmallStore"):Connect(addSmallStore)
CollectionService:GetInstanceRemovedSignal("SmallStore"):Connect(function(p) CircleActionUI.Remove(p) end)

-- ── CircleAction: dropped items ───────────────────────────────
local ItemDropConsts = require(RS.Game.ItemSystem.ItemDropConsts)
local GunShopUtils   = require(RS.Game.GunShop.GunShopUtils)

local function addDroppedItem(part)
	CircleActionUI.Add({
		Part = part, ValidRoot = part.Parent,
		Name = ("Pick up %s"):format(GunShopUtils.getTranslatedTitleFromName(part.Parent.Name)),
		Timed = true, Duration = 0.5, Dist = 5,
		Callback = function(entry, completed)
			if completed then fireServer("c5ft2w8h", entry.Part); return true end
			fireServer("ifdcvgyn", entry.Part); return true
		end,
	}, part)
end
for _, part in next, CollectionService:GetTagged(ItemDropConsts.DROPPED_ITEM_TAG) do addDroppedItem(part) end
CollectionService:GetInstanceAddedSignal(ItemDropConsts.DROPPED_ITEM_TAG):Connect(addDroppedItem)
CollectionService:GetInstanceRemovedSignal(ItemDropConsts.DROPPED_ITEM_TAG):Connect(CircleActionUI.Remove)

-- ── Jump debounce ─────────────────────────────────────────────
local function onJumpDebounced()
	local now = tick()
	if now - State.lastJumpTime < 0.1 then return false end
	State.lastJumpTime = now; onJump()
end
require(RS.Game.DefaultActions).onJumpPressed:Connect(onJumpDebounced)

-- ── Ragdoll on death ──────────────────────────────────────────
LocalPlayer.CharacterAdded:Connect(function(character)
	local tracker
	tracker = character:WaitForChild("Humanoid").Died:Connect(function()
		tracker:Disconnect(); Falling.StartRagdolling(10)
	end)
end)

-- ── Manual reset ──────────────────────────────────────────────
do
	local resetEvent = Instance.new("BindableEvent")
	resetEvent.Event:connect(function() fireServer("k60hnevw") end)
	delay(2, function()
		local ok, err = pcall(function() StarterGui:SetCore("ResetButtonCallback", resetEvent) end)
		if not ok then print("MANUAL RESET ERROR", err) end
	end)
end

-- ── Anti-idle detection part ──────────────────────────────────
do
	local detectPart = Instance.new("Part")
	detectPart.Anchored = true; detectPart.Transparency = 1
	detectPart.CanCollide = false; detectPart.Size = newV3(1, 1, 1)
	detectPart.Archivable = false; detectPart.Parent = workspace
	detectPart:GetPropertyChangedSignal("Archivable"):connect(function()
		while true do end
	end)
end

-- ── Special cleanup ───────────────────────────────────────────
delay(10, function()
	local machine = workspace:FindFirstChild("KreeksTimeMachine")
	if machine and LocalPlayer.UserId == 140258990 then machine:Destroy() end
end)

-- ── Anti-cheat ────────────────────────────────────────────────
local AntiCheat = {
	reported          = false,
	spawnTimestamp    = 0,
	stateTracker      = nil,
	stateChangeDelta  = 0,
	backpackFlag      = false,
	monitoredServices = { "Workspace", "Players", "ReplicatedStorage" },
	xpcallOriginal    = xpcall,
}

local function onCharacterAdded_AntiCheat(character)
	local humanoid = character:WaitForChild("Humanoid", 1)
	if not humanoid then return end
	if not character:WaitForChild("HumanoidRootPart", 1) then return end
	AntiCheat.reported       = false
	AntiCheat.spawnTimestamp = Math.TimeAccumAdd(AntiCheat.spawnTimestamp, 2)
	if AntiCheat.stateTracker then AntiCheat.stateTracker:Disconnect(); AntiCheat.stateTracker = nil end
	AntiCheat.stateTracker = humanoid.StateChanged:Connect(function(_, newState)
		if newState == Enum.HumanoidStateType.StrafingNoPhysics then
			AntiCheat.stateChangeDelta = Math.TimeAccumAdd(AntiCheat.stateChangeDelta, 1)
			if Math.TimeAccumDiff(AntiCheat.stateChangeDelta) > 10 then
				AntiCheat.stateChangeDelta = 0
				if AntiCheat.backpackFlag then return end
				AntiCheat.backpackFlag = true
				fireServer("yqs1cu3t", "NoClip StrafingNoPhysics", false)
			end
		end
	end)
end

if LocalPlayer.Character then onCharacterAdded_AntiCheat(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(onCharacterAdded_AntiCheat)

spawn(function()
	local ok, err = pcall(function()
		LocalPlayer:WaitForChild("Backpack", 20).ChildAdded:Connect(function(item)
			if item:IsA("BackpackItem") then
				if AntiCheat.backpackFlag then return end
				AntiCheat.backpackFlag = true
				fireServer("yqs1cu3t", "BackpackTool", false)
			end
		end)
	end)
	if not ok then warn("BACKPACK FAIL", err) end
end)

local function runCheatCheck()
	if AntiCheat.reported then return end
	local character = LocalPlayer.Character; if not character then return end
	local humanoid  = character:FindFirstChild("Humanoid"); if not humanoid then return end
	if humanoid.Health <= 0.001 then return end
	local detected = false
	for _, name in next, AntiCheat.monitoredServices do
		if game:GetService(name).Name ~= name then detected = true end
	end
	if not RunService:IsStudio() and pcall(function() end) then detected = true end
	if _G.antiarrest ~= nil then detected = true end
	if xpcall ~= AntiCheat.xpcallOriginal then detected = true end
	local xpcallWorks = false
	xpcall(function() return game[{}] end, function() xpcallWorks = true end)
	if not xpcallWorks then detected = true end
	if debug.getupvalues then detected = true end
	if detected then
		AntiCheat.reported = true
		fireServer("yqs1cu3t", "Getupvalues", false)
	end
end

threadLoopAdd(1, function()
	local ok = pcall(runCheatCheck)
	if not ok then
		AntiCheat.reported = true
		fireServer("yqs1cu3t", "FailedPcall", false)
	end
end)

require(RS.App.ImportantLocationMarkerSystem).init()

-- ── Wire up ConnectEvents (must run last) ─────────────────────
ConnectEvents()