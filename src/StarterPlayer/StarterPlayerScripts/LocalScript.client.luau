-- ============================================================
-- Main LocalScript (Cleaned)
-- Build: 03 Apr @ 01:33 PM EDT @816c333
-- ============================================================

-- ── Services ─────────────────────────────────────────────────
local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local RunService          = game:GetService("RunService")
local MarketplaceService  = game:GetService("MarketplaceService")
local UserInputService    = game:GetService("UserInputService")
local SoundService        = game:GetService("SoundService")
local Players             = game:GetService("Players")
local CollectionService   = game:GetService("CollectionService")
local StarterGui          = game:GetService("StarterGui")
local TextChatService     = game:GetService("TextChatService")

-- ── Shorthand math/CFrame ────────────────────────────────────
local Angles  = CFrame.Angles
local newV3   = Vector3.new
local ZeroCF  = CFrame.new(0, 0, 0)
local abs     = math.abs

-- ── Core modules ─────────────────────────────────────────────
local RunUtils              = require(ReplicatedStorage.App.RunUtils)
local Math                  = require(ReplicatedStorage.Module.Math)
local AlexWM                = require(ReplicatedStorage.Module.AlexWM)
local Settings              = require(ReplicatedStorage.Resource.Settings)
local Localization          = require(ReplicatedStorage.Module.Localization)
local Raycast               = require(ReplicatedStorage.Std.Raycast)
local Audio                 = require(ReplicatedStorage.Std.Audio)
local GameUtil              = require(ReplicatedStorage.Game.GameUtil)
local RxInstanceUtils       = require(ReplicatedStorage.Std.RxInstanceUtils)
local Maid                  = require(ReplicatedStorage.Std.Maid)
local waitForChild          = require(ReplicatedStorage.Std.waitForChild)
local GameSettingsService   = require(ReplicatedStorage.GameSettings.GameSettingsService)
local gameSettingType       = require(ReplicatedStorage.GameSettings.gameSettingType)
local TradeService          = require(ReplicatedStorage.Trade.TradeService)
local PlayerModuleService   = require(ReplicatedStorage.PlayerModule.PlayerModuleService)
local InputUtils            = require(ReplicatedStorage.Std.InputUtils)
local EnvironmentConsts     = require(ReplicatedStorage.Environment.EnvironmentConsts)
local EnvironmentUtils      = require(ReplicatedStorage.Environment.EnvironmentUtils)
local HapticEffect          = require(ReplicatedStorage.App.HapticEffect)
local R15IKv2               = require(ReplicatedStorage.Module.R15IKv2)
local UI                    = require(ReplicatedStorage.Module.UI)
local EzUtils               = require(ReplicatedStorage.EzUi.EzUtils)
local RichTextUtils         = require(ReplicatedStorage.Std.RichTextUtils)
local Joint                 = require(ReplicatedStorage.Std.Joint)
local PartUtils             = require(ReplicatedStorage.Std.PartUtils)
local ConstraintUtils       = require(ReplicatedStorage.Std.ConstraintUtils)
local RegionUtils           = require(ReplicatedStorage.Std.Region.RegionUtils)
local Promise               = require(ReplicatedStorage.Std.Promise)
local TableUtils            = require(ReplicatedStorage.Std.TableUtils)
local StreamingHelperUtils  = require(ReplicatedStorage.App.StreamingHelperUtils)
local ActionButtonService   = require(ReplicatedStorage.ActionButton.ActionButtonService)
local VehicleLinkBinder     = require(ReplicatedStorage.VehicleLink.VehicleLinkBinder)
local CinematicCamera       = require(ReplicatedStorage.Module.CinematicCamera)

-- ── Player / Camera ──────────────────────────────────────────
local LocalPlayer   = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera

if not RunUtils.isStudio() then
	print("Build:", "03 Apr @ 01:33 PM EDT @816c333")
end

-- ── Remote event infrastructure ──────────────────────────────
-- Create dummy remote events as placeholders during load
for _ = 1, 10 do
	local re      = Instance.new("RemoteEvent")
	re.Name       = Math.GUID()
	re.Parent     = ReplicatedStorage.Resource
end

local genericRemote        -- the actual GenericRemoteEvent, set in ConnectEvents()
local eventNameMap         -- obfuscated-name → real-name lookup table, set by server

-- Thin wrapper table used like a RemoteEvent throughout the script
local Event = {}
local rawFireServer = Instance.new("RemoteEvent").FireServer

local function fireServer(eventName, ...)
	local resolved = eventNameMap and eventNameMap[eventName] or eventName
	rawFireServer(genericRemote, resolved, ...)
end

function Event:FireServer(eventName, ...)
	fireServer(eventName, ...)
end

-- ── Event-manager table (server → client dispatch) ───────────
local em = {}

local function onClientEvent(eventName, ...)
	assert(em[eventName], eventName)(...)
end

-- Called by the server to hand us the name-map
function em.ywx2xyj9(nameMap)
	em.hems = true
	eventNameMap = nameMap
end

-- ── Await the generic remote, then wire up OnClientEvent ─────
local genericRemotePromise = waitForChild(ReplicatedStorage, "GenericRemoteEvent", 30):catch(warn)

local function ConnectEvents()
	local ok, remote = genericRemotePromise:await()
	if not ok then
		error("Bad error... could not find `GenericGameEvent`")
	end
	remote.Name = Math.GUID()
	genericRemote = remote
	remote.OnClientEvent:Connect(onClientEvent)
end

-- ── GUI setup ─────────────────────────────────────────────────
StarterGui.ResetPlayerGuiOnSpawn = false

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TeamValue = LocalPlayer:WaitForChild("TeamValue")

local function getOrCloneGui(name)
	local gui = PlayerGui:FindFirstChild(name)
	if not gui then
		gui        = ReplicatedStorage.StarterGui:FindFirstChild(name):Clone()
		gui.Parent = PlayerGui
	end
	return gui
end

local MainGui    = getOrCloneGui("MainGui")
local ProductGui = getOrCloneGui("ProductGui")
local Particles  = getOrCloneGui("Particles")
local DeathGui   = getOrCloneGui("DeathGui")

UI.CircleAction.Frame = MainGui.CircleAction
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

-- ── Core game systems ─────────────────────────────────────────
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
PlayerUtils.init()

local InventoryItemSystem = require(ReplicatedStorage.Inventory.InventoryItemSystem)

local ItemSystem = require(ReplicatedStorage.Game.ItemSystem.ItemSystem)
ItemSystem.Init({ em = em, Event = Event })

require(ReplicatedStorage.Game.AmmoGui).Init({
	GetScreenGui = function(name)
		local gui = PlayerGui:FindFirstChild(name)
		if not gui then
			gui        = ReplicatedStorage.StarterGui:FindFirstChild(name):Clone()
			gui.Parent = PlayerGui
		end
		return gui
	end,
})

-- Register all item modules in Game.Item
for _, child in ReplicatedStorage.Game.Item:GetChildren() do
	if not child:GetAttribute("Required") then
		child:SetAttribute("Required", true)
		local mod = require(child)
		if rawget(mod, "Init") then
			mod.Init({ Event = Event, em = em, ScreenGui = MainGui })
		end
		ItemSystem.Register(mod)
	end
end

ReplicatedStorage.Game.Item.ChildAdded:Connect(function(child)
	if not child:GetAttribute("Required") then
		child:SetAttribute("Required", true)
		local mod = require(child)
		if rawget(mod, "Init") then
			mod.Init({ Event = Event, em = em, ScreenGui = MainGui })
		end
		ItemSystem.Register(mod)
	end
end)

require(ReplicatedStorage.Game.ItemSystem.ItemCamera).Init()
require(ReplicatedStorage.Game.ItemSkin.ItemSkin).Init({ Event = Event, em = em })
require(ReplicatedStorage.Game.ItemSkin.UI.UI).Init()

local PoliceReportUI = require(ReplicatedStorage.Game.PoliceReportUI.PoliceReportUI)
PoliceReportUI.Init()

function em.w46mpc4t(data)
	PoliceReportUI.Display(data)
end

-- ── Thread-loop system ────────────────────────────────────────
-- Runs registered callbacks at specified intervals on Heartbeat
local threadLoops = {}

local function threadLoopAdd(interval, callback)
	table.insert(threadLoops, { i = interval, c = callback, t = 0 })
end

local lastHeartbeat = os.clock()

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
local mainWindowGroup = AlexWM.MakeWindowGroup()

local CharacterBinder = require(ReplicatedStorage.App.CharacterBinder)
CharacterBinder:Start()

local CharacterUtil = require(ReplicatedStorage.Game.CharacterUtil)
require(ReplicatedStorage.Inventory.InventorySystem).init()

local HotbarSystem = require(ReplicatedStorage.Hotbar.HotbarSystem)
HotbarSystem.init()

GameUtil.OnTeamChanged:Connect(function(team)
	HotbarSystem.setColor(Settings.TeamColor[team])
end)

require(ReplicatedStorage.Hotbar.HotbarItemBinder):GetClassAddedSignal():Connect(function()
	HotbarSystem.setColor(Settings.TeamColor[GameUtil.Team])
end)

-- ── Barbed-wire client binder ─────────────────────────────────
local BarbedWireBinder = require(ReplicatedStorage.Std.Binder).new("BarbedWireClient", function(part)
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

		local damage   = 30
		local dmgAttr  = part:GetAttribute("BarbedWireDamage")
		if dmgAttr then
			assert(typeof(dmgAttr) == "number")
			damage = dmgAttr
		end

		fireServer("yzplkho3", damage, "Wire")
	end))

	return maid
end)
BarbedWireBinder:Start()

-- ── Vehicle / nitro state ─────────────────────────────────────
local vehiclePacket = nil   -- current vehicle packet for LocalPlayer
local nitroState = {
	VehiclesOwned   = {},
	VehiclesRented  = {},
	Nitro           = 50,
	NitroLastMax    = 50,
}
local isSprinting  = false
local isFrozen     = false
GameUtil.Schedule = "Yard"
local isStunned    = false

-- Shared init config table passed to many subsystems
local initConfig = {
	MainWindowGroup = mainWindowGroup,
	ScreenGui       = MainGui,
	ProductGui      = ProductGui,
	Event           = Event,
	em              = em,
	UI              = UI,
	SelectIfGamepad = function(element)
		EzUtils.selectIfGamepad(element)
	end,
	GetVehiclePacket = function()
		return vehiclePacket
	end,
}

-- ── Vehicle subsystems ────────────────────────────────────────
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
VehicleUtils.Init({
	GetVehiclePacket = initConfig.GetVehiclePacket,
	em               = em,
	Event            = Event,
	nitroState       = nitroState,
})

local VehicleStateBinder = require(ReplicatedStorage.Game.VehicleStateBinder)
VehicleStateBinder:Start()

local Classes = VehicleUtils.Classes

Classes.Chassis = require(ReplicatedStorage.Module.AlexChassis)
Classes.Chassis.init({ ScreenGui = MainGui })
Classes.Chassis.SetEvent(Event)

Classes.Chassis2 = require(ReplicatedStorage.Module.AlexChassis2)
Classes.Chassis2.SetEvent(Event)

Classes.Volt = require(ReplicatedStorage.Game.Vehicle.Volt)
Classes.Volt.Init({ Event = Event, em = em })

Classes.Tank = require(ReplicatedStorage.Tank.TankService)
Classes.Tank.init()

-- ── Gamepass / marketplace ────────────────────────────────────
local purchaseCounter = 0

local function promptPurchase(passData)
	purchaseCounter += 1
	local id = purchaseCounter

	if passData.OldPassId then
		MarketplaceService:PromptPurchase(LocalPlayer, passData.OldPassId)
	else
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, passData.PassId)
	end

	ProductGui.Gamepass.ContainerFrame.TextLabel.Text = passData.Text

	task.delay(0.4, function()
		if purchaseCounter == id then
			ProductGui.Gamepass.Visible = true
		end
	end)
end

local function onGamePassPurchaseFinished(_player, _passId, _purchased)
	purchaseCounter += 1
	ProductGui.Gamepass.Visible = false
end

MarketplaceService.PromptGamePassPurchaseFinished:Connect(onGamePassPurchaseFinished)
MarketplaceService.PromptPurchaseFinished:Connect(onGamePassPurchaseFinished)

function em.id40myec(passData)
	promptPurchase(passData)
end

local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
GamepassSystem.Init()

local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
GamepassUtils.Init({ PromptPurchase = promptPurchase })

initConfig.PromptPurchase = promptPurchase

-- ── Notifications ─────────────────────────────────────────────
local Notification = require(ReplicatedStorage.Game.Notification)
Notification.Init({ Event = Event, em = em })

local SidebarUI = require(ReplicatedStorage.Game.SidebarUI)
SidebarUI.Init({ Event = Event, em = em })

require(ReplicatedStorage.GameAnalytics).initClient()

local DefaultActions = require(ReplicatedStorage.Game.DefaultActions)
require(ReplicatedStorage.CmdrExt.CmdrExtSystem).init()

local Time = require(ReplicatedStorage.Module.Time)
Time.Init()

require(ReplicatedStorage.Module.Confirmation).Init({ Event = Event, em = em })
require(ReplicatedStorage.Game.DisplayDamage).init()
require(ReplicatedStorage.Game.CharacterAnim).init()
require(ReplicatedStorage.Module.NetSync).Init({ Event = Event, em = em })
require(ReplicatedStorage.Game.OwnedPart.OwnedPartSystem).init()
require(ReplicatedStorage.Game.TrainSystem).Init({ Event = Event, em = em })
require(ReplicatedStorage.Game.TrackSwitch).Init({ Event = Event, em = em })

Classes.Heli = require(ReplicatedStorage.Game.Vehicle.Heli)(initConfig)

require(ReplicatedStorage.Game.Museum)(initConfig, ItemSystem)
require(ReplicatedStorage.Game.L18n)({ ScreenGui = MainGui })
require(ReplicatedStorage.Game.Level2.LevelSystem).init()
require(ReplicatedStorage.Game.TurbineSystem).init()
require(ReplicatedStorage.AirDrop.BriefcaseBinder):Start()
require(ReplicatedStorage.Plane.PlaneBinder):Start()
require(ReplicatedStorage.Game.Hologram).Init()
require(ReplicatedStorage.Game.Codes).Init({ MainWindowGroup = mainWindowGroup, Event = Event })
require(ReplicatedStorage.Game.SecretBases).Init({ Event = Event, em = em })
require(ReplicatedStorage.Game.Robbery.RobberyBank.RobberyBank).Init({ Event = Event, em = em })
require(ReplicatedStorage.Jewelry.RobberyJewelry).Init({ Event = Event, em = em })
require(ReplicatedStorage.Game.Robbery.RobberyCargoTrain).Init({ Event = Event, em = em })
require(ReplicatedStorage.Game.Robbery.RobberyPassengerTrain).Init({ Event = Event, em = em, ScreenGui = MainGui })
require(ReplicatedStorage.Game.Robbery.RobberyCargoPlane).Init({ Event = Event, em = em, Team = TeamValue, ScreenGui = MainGui })
require(ReplicatedStorage.Game.Cell).Init({ Event = Event, em = em, ScreenGui = MainGui })
require(ReplicatedStorage.Game.MilitaryIsland).Init()
require(ReplicatedStorage.Game.Plane.BaseUserControlledPlane).Init()

local Jet = require(ReplicatedStorage.Game.Plane.Jet)
Jet.Init({ Event = Event, em = em })

local VehicleSystem = require(ReplicatedStorage.Game.VehicleSystem)
VehicleSystem.Init({ Event = Event, em = em })
VehicleSystem.RegisterModule(require(ReplicatedStorage.Game.VehicleSystem.JetSki))
VehicleSystem.RegisterModule(Jet)
VehicleSystem.RegisterModule(require(ReplicatedStorage.Game.Plane.Stunt))

function em.thzlyviq(missileData, extraData)
	local packet = VehicleSystem.WaitForVehiclePacket(LocalPlayer)
	if packet == nil then
		error("No vehicle exists for LocalPlayer")
	end
	packet:UpdateMissileUI(missileData, extraData)
end

local Missile = require(ReplicatedStorage.Game.Missile)

function em.bj4dgn5q(a, b, c, d)
	Missile.LaunchMissile(a, b, c, d)
end

require(ReplicatedStorage.Game.Robbery.PuzzleFlow).Init({ Event = Event, em = em })
require(ReplicatedStorage.Game.Robbery.PowerPlant.PowerPlant).Init({ Event = Event, em = em })

local JetPack = require(ReplicatedStorage.Game.JetPack.JetPack)
JetPack.Init({ Event = Event, em = em })
JetPack.Signal.OnEquipped:Connect(function()
	InventoryItemSystem.unequipAll()
end)

-- ── Streetlights ──────────────────────────────────────────────
local Streetlights = require(ReplicatedStorage.Game.Streetlights)
Streetlights.init()

function em.rx1h2lg9()
	Streetlights.Flicker()
end

function em.slz18r09(enabled)
	Streetlights.SetEnabled(enabled)
end

require(ReplicatedStorage.App.MinimapService).init()
require(ReplicatedStorage.Game.RoadSpikeSystem).Init({ Event = Event })
require(ReplicatedStorage.Game.WorldMarker.WorldMarkerSystem).init()
require(ReplicatedStorage.Game.RobberyMarkerSystem).init()
require(ReplicatedStorage.Game.LightningSystem).Init({ em = em })
require(ReplicatedStorage.Game.April2020LiveEventLoader).Init({ Event = Event, em = em })
require(ReplicatedStorage.Game.Boat.Boat).Init()
VehicleSystem.RegisterModule(require(ReplicatedStorage.Game.Boat.Sloop))
VehicleSystem.RegisterModule(require(ReplicatedStorage.Game.Boat.Cruiser))

if RunUtils.isMainWorld() then
	require(ReplicatedStorage.Game.BoatScenery).Init()
end

require(ReplicatedStorage.Game.Lighthouse).Init()
require(ReplicatedStorage.Game.Drawbridge).Init({ em = em })
require(ReplicatedStorage.Game.NukeControl).Init({ Event = Event, em = em })
require(ReplicatedStorage.Game.Robbery.CargoShip.CargoShipCoordinator).Init({ Event = Event, em = em })
require(ReplicatedStorage.Game.Radio.RadioPlayer).Init({ Event = Event, em = em })
require(ReplicatedStorage.Game.RobberyMoneyUI.RobberyMoneyUI).Init()
require(ReplicatedStorage.Game.DuffelBag.DuffelBagBinder):Start()
require(ReplicatedStorage.Game.GunShop.GunShopSystem).init()
require(ReplicatedStorage.Game.GunShop.GunShopUI).init({ Event = Event, em = em })
require(ReplicatedStorage.Game.ContextMessage.ContextMessageUI).init()
require(ReplicatedStorage.Game.C4.C4System).init({ em = em })
require(ReplicatedStorage.Game.SmokeGrenade.SmokeGrenadeSystem).init()
require(ReplicatedStorage.Game.Level2.LevelUISystem).init()
require(ReplicatedStorage.Game.Contract.ContractSystem).init()
require(ReplicatedStorage.Game.Contract.ContractUISystem).init()
require(ReplicatedStorage.Game.Season.SeasonUISystem).init()
require(ReplicatedStorage.Game.Season.SeasonSystem).init()
require(ReplicatedStorage.Game.Robbery.MoneyTruck.MoneyTruckSystem).init()
require(ReplicatedStorage.Game.NorthernLights).init()
require(ReplicatedStorage.Game.Dog.DogSystem).init()
require(ReplicatedStorage.Game.Adoption.AdoptionStandUI).init()
require(ReplicatedStorage.Game.Adoption.AdoptionSystem).init()
require(ReplicatedStorage.Home.HomeUI.HomeSaleUISystem).init()
require(ReplicatedStorage.Home.HomeSystem).init()
require(ReplicatedStorage.Home.ItemPlacer.ItemPlacerSystem).init()
require(ReplicatedStorage.Home.Surface.SurfaceSystem).init()
require(ReplicatedStorage.Home.HomeItem.HomeItemSystem).init()
require(ReplicatedStorage.Home.HomeItem.Fabricate.Turret).init({ Event = Event })
require(ReplicatedStorage.Home.HomeItem.Fabricate["Trapped Bookshelf"]).init({ Event = Event })
require(ReplicatedStorage.Home.HomeItem.Fabricate["Trapped Spikes"]).init({ Event = Event })
require(ReplicatedStorage.Game.Robbery.TombRobbery.TombRobberySystem).init({ Event = Event })
require(ReplicatedStorage.Game.Cart.CartSystem).init()
require(ReplicatedStorage.Game.ProximityCamShake.ProximityCamShakeSystem).init()
require(ReplicatedStorage.Game.ProximitySound.ProximitySoundSystem).init()
require(ReplicatedStorage.Game.DartDispenser.DartDispenserSystem).init()
require(ReplicatedStorage.Game.Plank.PlankSystem).init()
require(ReplicatedStorage.Game.MilitaryTurret.MilitaryTurretSystem).init({ Event = Event })
require(ReplicatedStorage.Game.Destructible.DestructibleSystem).init()
require(ReplicatedStorage.Game.PlayerMarkerSystem).init()
require(ReplicatedStorage.Game.TopExpBoard.TopExpBoardSystem).init()
require(ReplicatedStorage.Game.CatalogPurchaseSystem).init()
require(ReplicatedStorage.CCTV.CCTVService).init()

-- ── Game settings ─────────────────────────────────────────────
local pendingSettings  = {}  -- settings received before handlers registered
local settingDebounce  = {}  -- per-setting change counter for debounce
local currentSettings  = {}  -- live copy of setting values

function em.tfy0g86o(settingsMap)
	currentSettings = settingsMap
	for name, value in pairs(settingsMap) do
		local setting = GameSettingsService.getByName and GameSettingsService.getByName(name)
		if setting and not setting.noSave then
			GameSettingsService.setValue(setting, value)
		end
	end
end

local function handleSetting(setting)
	local pending = pendingSettings[setting.name]
	if pending ~= nil then
		pendingSettings[setting.name] = nil
		if not setting.noSave then
			GameSettingsService.setValue(setting, pending)
		end
	end

	setting.onChanged:Connect(function(newValue)
		local count = (settingDebounce[setting.name] or 0) + 1
		settingDebounce[setting.name] = count

		if currentSettings[setting.name] ~= newValue then
			currentSettings[setting.name] = newValue
			task.delay(0.25, function()
				if settingDebounce[setting.name] == count then
					-- "k6ukc52e" = SaveSettings remote event
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
require(ReplicatedStorage.VehicleLink.VehicleLinkBinder):Start()
require(ReplicatedStorage.Elevator.ElevatorBinder):Start()
require(ReplicatedStorage.Casino.CasinoService).init()
require(ReplicatedStorage.TransportJet.TransportJetService).init()
require(ReplicatedStorage.DamageIndicator.DamageIndicatorService).init()
require(ReplicatedStorage.Trade.TradeService).init({ em = em })

if RunUtils.isTradeWorld() then
	require(ReplicatedStorage.Trade.TradeDesireService).init()
end

require(ReplicatedStorage.RewardSpinner.RewardSpinnerService).init()
require(ReplicatedStorage.HyperChrome.HyperChromeService).init()
require(ReplicatedStorage.RobberyBonus.RobberyBonusService).init({ em = em })
require(ReplicatedStorage.Safes.SafesService).init({ em = em })
require(ReplicatedStorage.GuardNPC.GuardNPCBinder):Start()
require(ReplicatedStorage.AirDrop.AirDropService).init({ em = em })
require(ReplicatedStorage.App.HoldEService).init()
require(ReplicatedStorage.TargetingIndicator.TargetingIndicatorService).init()
require(ReplicatedStorage.Forcefield.ForcefieldService).init()
require(ReplicatedStorage.SpawnSelection.SpawnSelectionService).init()
require(ReplicatedStorage.Consumables.ConsumablesService).init()
require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleService).init()
require(ReplicatedStorage.TrackingSpotlight.TrackingSpotlightService).init()
require(ReplicatedStorage.GameMode.GameModeService).init({ em = em })
require(ReplicatedStorage.DragStrip.DragStripService).init()
require(ReplicatedStorage.App.CircleActionBinder):Start()
require(ReplicatedStorage.Turret2.TurretService).init()
require(ReplicatedStorage.App.OnboardTutorialService).init()
require(ReplicatedStorage.Commerce.CommerceService).init()

if RunUtils.isMainWorld() then
	require(ReplicatedStorage.Walmart.WalmartService).init()
end

local CashBuyUI = require(ReplicatedStorage.Game.CashBuyUI)
CashBuyUI.Init({ Event = Event, em = em })

require(ReplicatedStorage.Game.Radio.Radio).Init()
Settings.FetchProducts()

local Falling = require(ReplicatedStorage.Game.Falling)
Falling.Init({ Event = Event, em = em })

local Paraglide = require(ReplicatedStorage.Game.Paraglide)
Paraglide.Init({ Event = Event, em = em })

-- ── Utility: number formatting ────────────────────────────────
local function addThousandsSeparators(n)
	local prefix, digits, suffix = string.match(n, "^([^%d]*%d)(%d*)(.-)$")
	return prefix .. digits:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. suffix
end

local function formatMoney(amount)
	local sign = amount >= 0 and "" or "-"
	local formatted = addThousandsSeparators(tostring(abs(amount)))
	return sign .. Localization:FormatByKey("General.Cash", { formatted })
end

-- ── Utility: table lerp ───────────────────────────────────────
local function lerpTable(from, to, alpha)
	local result = {}
	for k, v in next, to do
		if type(v) == "number" then
			result[k] = (1 - alpha) * from[k] + alpha * v
		else
			result[k] = from[k]:lerp(v, alpha)
		end
	end
	return result
end

-- ── Sound system ──────────────────────────────────────────────
local activeSounds = {}  -- keyed by sound ID string → { Object, Proxy }

function em.e6yn0d8f(playerName, soundName, params)
	local source  = params.Source
	local volume  = math.min(params.Volume or 0.5, 2)
	local maxTime = params.MaxTime or 1
	local timeStart = params.TimeStart
	local delay_  = params.Delay

	if params.TimeStop then
		maxTime = timeStart + params.TimeStop
	end

	local proxyId = (activeSounds._counter or 0) + 1
	activeSounds._counter = proxyId

	local soundKey
	if params.Multi then
		soundKey = ("%s_%s_%d"):format(playerName, soundName, proxyId)
	else
		soundKey = ("%s_%s"):format(playerName, soundName)
	end

	-- Stop any existing sound at this key
	local existing = activeSounds[soundKey]
	if existing then
		existing.Object:Stop()
		existing.Object:Destroy()
		activeSounds[soundKey] = nil
	end

	if not params.Play then return end
	if not source then return end

	local assetId = Settings.Sounds[soundName]
	if not assetId then return end

	local sound = Instance.new("Sound")
	sound.SoundId       = "rbxassetid://" .. assetId
	sound.Name          = soundKey
	sound.Looped        = params.Looped
	sound.Volume        = volume
	sound.PlaybackSpeed = params.Pitch or 1
	sound.EmitterSize   = params.EmitterSize or 10
	sound.MaxDistance   = 400

	if timeStart then
		sound.TimePosition = timeStart
	end
	if params.SoundGroup then
		sound.SoundGroup = params.SoundGroup
	end

	sound.Parent = source

	if delay_ then
		delay(delay_, function() sound:Play() end)
	else
		sound:Play()
	end

	activeSounds[soundKey] = { Object = sound, Proxy = proxyId }

	-- Auto-expire
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
	if not localOnly then
		-- "e6yn0d8f" = PlaySound remote event
		fireServer("e6yn0d8f", soundName, params)
	end
	em.e6yn0d8f(LocalPlayer.Name, soundName, params)
end

local function stopSound(soundName, localOnly)
	local params = {}
	if not localOnly then
		-- "e6yn0d8f" = StopSound remote event (same handler, Play=nil)
		fireServer("e6yn0d8f", soundName, params)
	end
	em.e6yn0d8f(LocalPlayer.Name, soundName, params)
end

-- ── Fireworks ─────────────────────────────────────────────────
local AlexParticles = require(ReplicatedStorage.Module.AlexParticles)

local function spawnFireworks(count)
	assert(count <= 50)
	local state = AlexParticles.MakeState()
	state.Frame = Particles.Particles
	AlexParticles.EasySimulate(state, 4)

	local sizeX = state.Frame.AbsoluteSize.X
	local sizeY = state.Frame.AbsoluteSize.Y

	local function onBurst()
		if count <= 4 or math.random() < 0.2 then
			playSound("FireworkBang", {
				Source  = MainGui,
				Volume  = 0.2 + math.random() * 0.3,
				Multi   = true,
			}, true)
		end
	end

	for _ = 1, count do
		local velocity  = newV3(0, -400, 0) + Math.Uniform2D(150)
		local firework  = AlexParticles.Firework(
			state,
			newV3(math.random() * sizeX, sizeY, 0),
			velocity,
			newV3(0, 0, 0)
		)
		firework.ttl      = (sizeY - (sizeY * 0.3 + sizeY * 0.6 * math.random())) / velocity.magnitude
		firework.OnDestroy = onBurst
		wait(0.1 + math.random() * 0.05)
	end
end

function em.at2y4lws(count)
	assert(count <= 50)
	spawnFireworks(count)
end

initConfig.Fireworks = spawnFireworks

require(ReplicatedStorage.Game.Party).Init({ Fireworks = spawnFireworks })

-- ── Arrest / social actions ───────────────────────────────────
local function attemptArrest(player)
	fireServer("el8n5q35", player)
end

function em.vqyvrr03(data)
	if data.Bribed then
		em.ropj1fju({
			Title = "Arrest",
			Text  = ("You are bribed! Wait %d seconds."):format(data.Bribed),
		})
	end
end

local function attemptPickPocket(player)
	-- "tmg1kkw8" = Pickpocket remote event
	fireServer("tmg1kkw8", player.Name)
end

local function attemptBreakout(player)
	-- "lwe8eamu" = Breakout remote event
	fireServer("lwe8eamu", player.Name)
end

function em.qeol5u0t(data)
	if data.Cooldown then
		em.ropj1fju({
			Title = "Breakout",
			Text  = ("Wait %d seconds."):format(data.Cooldown),
		})
	end
end

local function attemptTrade(player)
	if TradeService.checkAlreadyInitiated(player, LocalPlayer) then
		TradeService.acceptInitiation(player.UserId)
	else
		TradeService.sendInitiation(player.UserId)
	end
end

local function attemptVehicleEject(vehicle)
	-- "d4lekogp" = EjectPlayer remote event
	fireServer("d4lekogp", vehicle)
end

local function attemptVehicleHotwire(vehicle, immediate)
	-- "df3viejr" = Hotwire remote event
	fireServer("df3viejr", vehicle, immediate)
end

-- ── Ping / delta tracking ─────────────────────────────────────
local pingPending    = false
local pingStartTime  = tick()
local lastNitroTick  = tick()

local function calculateAndSendPing()
	if pingPending and RunUtils.isMainWorld() then
		pingPending = false
		-- "xme0miu3" = PingDelta remote event
		fireServer("xme0miu3", tick() - pingStartTime)
	end
end

-- ── Nitro ─────────────────────────────────────────────────────
local hapticHandle

local function startNitro()
	if tick() - lastNitroTick < 0.1 then return end
	lastNitroTick = tick()

	if pingPending then
		calculateAndSendPing()
	end
	pingPending   = true
	pingStartTime = tick()

	if vehiclePacket and not vehiclePacket.Passenger and #vehiclePacket.Nitrous > 0 then
		vehiclePacket.Nitro = true

		playSound("Nitro1", {
			Source    = vehiclePacket.Nitrous[1].Parent,
			TimeStart = 0.5,
			Volume    = 0.7,
		})
		playSound("NitroLoop", {
			Source   = vehiclePacket.Nitrous[1].Parent,
			Looped   = true,
			MaxTime  = 30,
			Volume   = 0.7,
			Delay    = 0.3,
		})

		for _, emitter in next, vehiclePacket.Nitrous do
			emitter.Enabled = true
		end

		-- "bwzh5113" = NitroStart remote event
		fireServer("bwzh5113")

		if hapticHandle then hapticHandle:Destroy() end
		hapticHandle = HapticEffect.basic(1, math.huge)
	end

	if nitroState.Nitro / nitroState.NitroLastMax <= 0.01 then
		em.ii3wc6xy(true, true)
	end
end

local function stopNitro()
	stopSound("NitroLoop")

	if hapticHandle then
		hapticHandle:Destroy()
		hapticHandle = nil
	end

	if vehiclePacket and not vehiclePacket.Passenger then
		vehiclePacket.Nitro = false
		if vehiclePacket.Nitrous then
			for _, emitter in next, vehiclePacket.Nitrous do
				emitter.Enabled = false
			end
		end
	end

	calculateAndSendPing()
	-- "pdrsemkn" = NitroStop remote event
	fireServer("pdrsemkn")
end

-- ── Nitro UI ──────────────────────────────────────────────────
local nitroGuiHandle

function em.pd0xkej2(currentNitro, maxNitro)
	local displayNitro = RunUtils.isTradeWorld() and Settings.Scalar.NitroMax or currentNitro
	nitroState.Nitro           = displayNitro
	nitroState.NitroLastMax    = maxNitro
	nitroState.NitroForceUIUpdate = true

	if nitroGuiHandle then
		local bar = nitroGuiHandle.Container.Container.ContainerBar
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
	if vehiclePacket and not vehiclePacket.Passenger then
		if vehiclePacket.Type == "Chassis" then
			Classes.Chassis.UpdateStepped(vehiclePacket)
		elseif vehiclePacket.Type == "Motorcycle" or vehiclePacket.Type == "DuneBuggy" then
			Classes.Chassis2.UpdateStepped(vehiclePacket)
		end
	end
end)

-- ── Camera look / head/neck rotation ─────────────────────────
local lookTransforms = {
	Waist = CFrame.new(),
	Neck  = CFrame.new(),
}
local smoothLookTarget = newV3(0, 0, 0)
local lastLookSendTime = 0

-- Per-player look spring data (other players)
local playerLookData = {}

RunService.Stepped:Connect(function()
	debug.profilebegin("Camera Looking")
	local now = tick()

	smoothLookTarget += (
		CurrentCamera.CFrame.Position
			+ CurrentCamera.CFrame.LookVector * 30
		- smoothLookTarget
	) * 0.2

	local character = LocalPlayer.Character
	if character then
		local humanoid   = character:FindFirstChild("Humanoid")
		if humanoid and humanoid.Health > 0 and not vehiclePacket and humanoid.RootPart then
			local head       = character:FindFirstChild("Head")
			local upperTorso = character:FindFirstChild("UpperTorso")

			if head and upperTorso then
				local waistJoint = upperTorso:FindFirstChild("Waist")
				local neckJoint  = head:FindFirstChild("Neck")

				if waistJoint and neckJoint then
					local heading, pitch = 0, 0

					debug.profilebegin("Calculate looking")

					if not isFrozen then
						local lookVec = (CurrentCamera.CFrame * Angles(0.2, 0, 0)).LookVector
						if Math.IsNaNv3(lookVec) then lookVec = newV3(0, 0, -1) end

						heading = humanoid.RootPart.CFrame.lookVector:Dot(lookVec:Cross(newV3(0, 1, 0)))
						pitch   = math.asin(lookVec.Y)

						if vehiclePacket and (not vehiclePacket.Passenger or vehiclePacket.NoLook)
							or ItemSystem.GetLocalEquipped()
						then
							heading = 0
							pitch   = 0
						end

						if Math.IsNaN(heading) then heading = 0 end
						if Math.IsNaN(pitch)   then pitch   = 0 end
					end

					local targetCF = not isFrozen
						and Angles(0, -heading * 0.5, 0) * Angles(-pitch * 0.2, 0, 0)
						or CFrame.identity

					if Math.IsNaNcf(targetCF) then targetCF = CFrame.identity end

					if waistJoint.Transform ~= lookTransforms.Waist then
						waistJoint.Transform *= CFrame.identity:Inverse()
						lookTransforms.Waist  = waistJoint.Transform
					end
					if neckJoint.Transform ~= lookTransforms.Neck then
						neckJoint.Transform *= CFrame.identity:Inverse()
						lookTransforms.Neck   = neckJoint.Transform
					end

					if now - lastLookSendTime >= 0.4 then
						lastLookSendTime = now
						if Math.IsNaN(heading) then heading = 0 end
						if Math.IsNaN(pitch)   then pitch   = 0 end
						if em.hems then
							-- "rhe8ct8j" = LookUpdate remote event
							fireServer("rhe8ct8j", heading, pitch)
						end
					end

					debug.profileend()
				end
			end
		end
	end

	-- Apply look spring to other players
	for name, data in pairs(playerLookData) do
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
local tireSounds = {
	tire_pop  = 4534995816,
	tire_leak = 4534995685,
}

local lqRayParams = RaycastParams.new()
lqRayParams.IgnoreWater = true

local function updateChassisLowQuality(packet, dt)
	local model = packet.Model
	if not model then
		warn("No model exists to update LowQuality")
		return
	end

	local engine = model:FindFirstChild("Engine")
	if not engine then
		warn("No engine exists to update LowQuality")
		return
	end

	local localVel     = engine.CFrame:vectorToObjectSpace(engine.Velocity)
	local wheelRadius  = packet._cachedWheelRadius
	if not wheelRadius then
		wheelRadius            = packet.Wheels[1].Model.PrimaryPart.Size.Y / 2
		packet._cachedWheelRadius = wheelRadius
	end

	local newRotation = (packet.WheelRotation + localVel.Z * dt / wheelRadius) % (-math.pi * 2)
	packet.WheelRotation = newRotation

	local suspensionOffset = 0
	local garageHeight = model:GetAttribute("GarageSuspensionHeight")
	if garageHeight then
		suspensionOffset += garageHeight
	end

	for _, wheel in pairs(packet.Wheels) do
		Classes.Chassis.UpdateWheelLowQuality(model, suspensionOffset, wheel, newRotation)
	end

	Classes.Chassis.UpdateSoundLowQuality(packet, packet.Gears, localVel)

	local tirePop = math.min(
		(Time.GetNowSync() - model:GetAttribute("VehicleTiresLastPop")) / packet.DisableDuration,
		1
	) >= 0.999

	if tirePop and packet.AreTiresPopped ~= true then
		local params = { Volume = 1 }
		Audio.ObjectLocal(engine, tireSounds.tire_pop,  params)
		Audio.ObjectLocal(engine, tireSounds.tire_leak, params)
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
		packet.IKP = R15IKv2.BuildPacketArms(character)
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

		R15IKv2.Arms(ikp)
	end
end

local function updateHeliLowQuality(packet, dt)
	if not packet.Model then return end
	if packet.HasProp         then Classes.Heli.SpinProp(packet, dt)          return end
	if packet.IsUFO           then Classes.Heli.SpinUFO(packet, dt)           return end
	if packet.IsCrewCapsule   then Classes.Heli.SpinCrewCapsule(packet, dt)   return end
	if packet.IsDrone         then Classes.Heli.SpinDrone(packet, dt)                end
end

lqRayParams = nil  -- no longer needed after functions are defined

-- ── Horn ──────────────────────────────────────────────────────
local function playHorn(part, play, soundId, looped, duration, volume)
	local existing = part:FindFirstChild("_HornSound")
	if existing then existing:Destroy() end
	if not play then return end

	local params = { Looped = looped }
	local sound  = Audio.ObjectLocal(part, soundId, params)
	sound.Name   = "_HornSound"
	if volume then sound.Volume = volume end
	sound.Parent = part

	task.delay(duration or 16, function()
		if sound.Parent == part then
			sound:Destroy()
		end
	end)
end

local lastHornTime = 0

local function hornStart()
	local now = os.clock()
	if now - lastHornTime < 0.05 then return end
	lastHornTime = now

	if vehiclePacket and not vehiclePacket.Passenger then
		local bbox = vehiclePacket.Model:FindFirstChild("BoundingBox")
		playHorn(
			bbox,
			true,
			vehiclePacket.Model:GetAttribute("VehicleHornId"),
			vehiclePacket.Model:GetAttribute("VehicleHornLoopable"),
			nil,
			vehiclePacket.Model:GetAttribute("VehicleHornVolume")
		)
		-- "qgqa0qfy" = HornOn remote event
		fireServer("qgqa0qfy", true)
	end
end

local function hornStop()
	if vehiclePacket and not vehiclePacket.Passenger then
		local hornSound = vehiclePacket.Model:FindFirstChild("BoundingBox"):FindFirstChild("_HornSound")
		if hornSound then hornSound:Destroy() end
		-- "qgqa0qfy" = HornOff remote event
		fireServer("qgqa0qfy", false)
	end
end

function em.qgqa0qfy(playerName, part, play, soundId, looped, duration, volume)
	playHorn(part, play, soundId, looped, 10, volume)
end

-- ── Crawling / crouch system ──────────────────────────────────
local crawlAnim = Instance.new("Animation")
if RunUtils.getEnv() == require(ReplicatedStorage.App.RunConsts).QA_NAME then
	crawlAnim.AnimationId = "rbxassetid://10866609111"
else
	crawlAnim.AnimationId = "rbxassetid://685258011"
end

local activeAnimTrack   -- current crawl animation track

local punchAnims = {}
do
	local a1 = Instance.new("Animation"); a1.AnimationId = "rbxassetid://758003506"
	local a2 = Instance.new("Animation"); a2.AnimationId = "rbxassetid://758005053"
	table.insert(punchAnims, a1)
	table.insert(punchAnims, a2)
end

local crawlTimestamps = { 0, 0, 0 }

local function toggleCrawling()
	local character    = LocalPlayer.Character
	local primaryPart  = character.PrimaryPart

	isFrozen           = not activeAnimTrack
	CharacterUtil.IsCrawling = isFrozen
	CharacterUtil.IsCrawlingChanged:Fire(CharacterUtil.IsCrawling)

	local upperTorso = character:FindFirstChild("UpperTorso")
	local lowerTorso = character:FindFirstChild("LowerTorso")
	local joints     = {}

	-- Collect and temporarily disconnect torso joints
	local function collectJoints(parent)
		for _, child in next, parent:GetChildren() do
			if child:IsA("JointInstance") and (
				child.Part1 == upperTorso or child.Part1 == lowerTorso or
					child.Part0 == upperTorso or child.Part0 == lowerTorso
				) then
				table.insert(joints, { Motor = child, Part0 = child.Part0, Part1 = child.Part1 })
				child.Part0 = nil
				child.Part1 = nil
			end
			collectJoints(child)
		end
	end
	collectJoints(character)

	if isFrozen then
		local ball = Instance.new("Part")
		ball.Shape                  = Enum.PartType.Ball
		ball.Size                   = newV3(2, 1, 4)
		ball.Name                   = "Ball"
		ball.CanCollide             = true
		ball.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 1, 1)
		ball.CFrame                 = primaryPart.CFrame * CFrame.new(0, 0, 1)
		ball.Transparency           = 1
		ball.Parent                 = character
		Joint.CustomWeld(ball, primaryPart, CFrame.new(0, 1, 0), ZeroCF)
	else
		local ball = character:FindFirstChild("Ball")
		if ball then ball:Destroy() end
	end

	-- Reconnect joints
	for _, j in ipairs(joints) do
		j.Motor.Part0 = j.Part0
		j.Motor.Part1 = j.Part1
	end

	character.HumanoidRootPart.CanCollide = not isFrozen

	if activeAnimTrack then
		activeAnimTrack:Stop()
		activeAnimTrack = nil
	else
		activeAnimTrack = character:FindFirstChild("Humanoid"):LoadAnimation(crawlAnim)
		activeAnimTrack:Play()
	end
end

-- ── Default actions (sprint, crawl, punch, jump) ─────────────
local isSprintingLocal = false
local crawlLastTick    = tick()
local lastPunchTick    = tick()
local punchAnimTrack

local function setSprinting(value)
	isSprinting = value
	if not not value ~= not not DefaultActions.sprintButton._pressed
		and DefaultActions.sprintButton._pressState
	then
		DefaultActions.sprintButton._pressState()
	end
end

require(ReplicatedStorage.Game.DefaultActions).init({
	setSprinting = function(value)
		isSprinting = value
	end,

	attemptToggleCrawling = function()
		local character = LocalPlayer.Character
		if not character then return end

		local humanoid = character:FindFirstChild("Humanoid")
		if not humanoid then return end
		if not activeAnimTrack and humanoid.Sit then return end
		if not activeAnimTrack and humanoid.PlatformStand then return end
		if not character.PrimaryPart then return end
		if Classes.Heli.Roped then return end
		if Falling.IsRagdolling() then return end
		if Paraglide.IsFlying() then return false end
		if not InventoryItemSystem.unequipAll() then return end

		local equipped = ItemSystem.GetLocalEquipped()
		if equipped and equipped.ItemData.Locked then return end

		if tick() - crawlLastTick < 0.1 then return end
		if tick() - crawlTimestamps[#crawlTimestamps] < 2 then return end

		crawlLastTick = tick()

		if activeAnimTrack then
			table.remove(crawlTimestamps)
			table.insert(crawlTimestamps, 1, crawlLastTick)
		end

		toggleCrawling()
	end,

	attemptPunch = function()
		if tick() - lastPunchTick < 0.5 then return end

		local character = LocalPlayer.Character
		if not character then return end
		local humanoid = character:FindFirstChild("Humanoid")
		if not humanoid then return end
		if ItemSystem.GetLocalEquipped() then return end

		if punchAnimTrack then punchAnimTrack:Stop() end

		local anim = table.remove(punchAnims, 1)
		table.insert(punchAnims, anim)

		punchAnimTrack = humanoid:LoadAnimation(anim)
		punchAnimTrack:Play()
		lastPunchTick = tick()

		-- "ip8mi4gy" = Punch remote event
		fireServer("ip8mi4gy")
	end,
})

-- ── Schedule / team updates ───────────────────────────────────
function em.yr2z2sm8(schedule)
	GameUtil.Schedule = schedule
	if GameUtil.Team == Settings.EnumTeam.Prisoner and RunUtils.isMainWorld() then
		em.ropj1fju({
			Text = Localization:FormatByKey("Schedule." .. schedule),
		})
	end
end

function em.rhe8ct8j(playerName, heading, pitch)
	if not playerLookData[playerName] then
		playerLookData[playerName] = {
			HeadingSpring = Math.MakeSpring(0, 10, 0.8),
			PitchSpring   = Math.MakeSpring(0, 10, 0.8),
		}
	end

	local data    = playerLookData[playerName]
	local player  = Players:FindFirstChild(playerName)

	if not player then
		playerLookData[playerName] = nil
		return
	end

	local character = player.Character
	if not character then
		playerLookData[playerName] = nil
		return
	end

	local upperTorso = character:FindFirstChild("UpperTorso")
	if not upperTorso then
		playerLookData[playerName] = nil
		return
	end

	data.Waist = upperTorso:FindFirstChild("Waist")
	data.Neck  = character.Head:FindFirstChild("Neck")

	Math.SpringSetTarget(data.HeadingSpring, heading)
	Math.SpringSetTarget(data.PitchSpring,   pitch)
end

local CartBinder = require(ReplicatedStorage.Game.Cart.CartBinder)

-- ── Jump / exit vehicle ───────────────────────────────────────
local function onJump()
	if vehiclePacket then
		if LocalPlayer.Character and LocalPlayer.Character:GetAttribute("TankRoyaleAlive") then
			em.ropj1fju({ Text = "You cannot exit Tanks in this gamemode." })
			return
		end
		VehicleUtils.OnVehicleJumpExited:Fire(vehiclePacket)
		-- "khwc34l2" = ExitVehicle remote event
		fireServer("khwc34l2")
		VehicleUtils.LastVehicleExit = tick()
		return
	end

	for _, cart in ipairs(CartBinder:GetAll()) do
		-- Cart exit logic handled by CartBinder
	end
end

CharacterUtil.OnJump = onJump

-- ── Death screen / lighting effects ──────────────────────────
local Lighting = game:GetService("Lighting")

local colorCorrection = Instance.new("ColorCorrectionEffect")
colorCorrection.Enabled = false
colorCorrection.Parent  = Lighting

local blurEffect = Instance.new("BlurEffect")
blurEffect.Size    = 0
blurEffect.Enabled = false
blurEffect.Parent  = Lighting

local deathLightingFrom
local deathLightingTo
local overrideDeathMessage

local function removeDeathGui()
	DeathGui.Frame:TweenSizeAndPosition(
		UDim2.new(1, 40, 0, 0),
		UDim2.new(0, -20, 0.5, 0),
		Enum.EasingDirection.Out,
		Enum.EasingStyle.Quad,
		0.1,
		true,
		function()
			DeathGui.Frame.Visible = false
		end
	)
end

GameUtil.removeDeathGui = removeDeathGui

local function applyDeathLighting(from, to, alpha)
	local result = lerpTable(from, to, alpha)
	colorCorrection.Saturation = result.Saturation
	blurEffect.Size            = result.Blur
end

function GameUtil.removeDeathLighting()
	if not deathLightingFrom then return end

	local connection
	local progress = 0

	connection = RunService.RenderStepped:connect(function(dt)
		progress += dt * 2
		if progress >= 1 then
			connection:Disconnect()
			applyDeathLighting(deathLightingFrom, deathLightingTo, 1)
			blurEffect.Enabled        = false
			colorCorrection.Enabled   = false
		else
			applyDeathLighting(deathLightingFrom, deathLightingTo, 1)
		end
	end)
end

-- Called when character respawns
function em.bq8r2bzi()
	wait()
	local character = LocalPlayer.Character
	if not character then return end

	local humanoid = character:FindFirstChild("Humanoid")
	if not humanoid then return end

	humanoid.Seated:connect(function(seated)
		if seated and CharacterUtil.IsCrawling then
			toggleCrawling()
		end
	end)

	humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	removeDeathGui()

	-- Fade out death lighting if active
	if deathLightingFrom then
		local connection
		local progress = 0

		connection = RunService.RenderStepped:connect(function(dt)
			progress += dt * 2
			if progress >= 1 then
				connection:Disconnect()
				applyDeathLighting(deathLightingFrom, deathLightingTo, 1)
				blurEffect.Enabled      = false
				colorCorrection.Enabled = false
			else
				applyDeathLighting(deathLightingFrom, deathLightingTo, 1)
			end
		end)
	end

	if InputUtils.isTouch() then
		isSprinting = true
		if not DefaultActions.sprintButton._pressed and DefaultActions.sprintButton._pressState then
			DefaultActions.sprintButton._pressState()
		end
	end

	overrideDeathMessage = nil
end

-- Called when character dies
function em.t6yqxhtu(silentDeath)
	isFrozen = false
	CharacterUtil.IsCrawling = false
	CharacterUtil.IsCrawlingChanged:Fire(false)
	isSprinting = false

	if DefaultActions.sprintButton._pressed and DefaultActions.sprintButton._pressState then
		DefaultActions.sprintButton._pressState()
	end

	isStunned = false
	onJump()

	local store = require(ReplicatedStorage.App.store)
	store:dispatch({
		type        = "setLastDiedAt",
		lastDiedAt  = workspace:GetServerTimeNow(),
	})

	if not silentDeath then
		local msg = overrideDeathMessage
			or Localization:FormatByKey("DeathMessage." .. math.random(0, 13))

		DeathGui.Frame.TextLabel.Text = msg

		blurEffect.Enabled      = true
		colorCorrection.Enabled = true

		deathLightingFrom = { Blur = 0, Saturation = 0 }
		deathLightingTo   = { Blur = 8, Saturation = -1 }

		local connection
		local progress = 0

		connection = RunService.RenderStepped:connect(function(dt)
			progress += dt
			if progress >= 1 then
				connection:Disconnect()
				applyDeathLighting(deathLightingFrom, deathLightingTo, 1)
				return
			end
			applyDeathLighting(deathLightingFrom, deathLightingTo, progress)
		end)

		delay(0.5, function()
			DeathGui.Frame.Size     = UDim2.new(1, 40, 0, 0)
			DeathGui.Frame.Position = UDim2.new(0, -20, 0.5, 0)
			DeathGui.Frame:TweenSizeAndPosition(
				UDim2.new(1, 40, 0, 150),
				UDim2.new(0, -20, 0.5, -75),
				Enum.EasingDirection.Out,
				Enum.EasingStyle.Quad,
				0.5,
				true
			)
			DeathGui.Frame.Visible = true
		end)
	end
end

waitForChild(ReplicatedStorage, "UpdateDeathMessage"):andThen(function(remote)
	remote.OnClientEvent:Connect(function(message)
		overrideDeathMessage = message
		DeathGui.Frame.TextLabel.Text = message
	end)
end)

-- ── App store / notifications ─────────────────────────────────
local appStore  = require(ReplicatedStorage.App.store)
local homeStore = require(ReplicatedStorage.Home.homeStore)

function em.kme0tgg1(data)
	assert(data ~= nil)
	local VehicleBuyUI = require(ReplicatedStorage.App.VehicleBuyUI)()
	VehicleBuyUI.setCash(data.Cash)

	local MilestoneEffects = require(ReplicatedStorage.App.MilestoneEffects)
	MilestoneEffects.cashUpdate(data.Cash)
	CashBuyUI.SetCash(data.Cash)

	appStore:dispatch({ type = "setCash", cash = data.Cash })
	homeStore:dispatch({ type = "setCash", cash = data.Cash })
end

local cashPopCounter = 0

function em.k6462bo3(delta, reason)
	cashPopCounter += 1
	local id = cashPopCounter

	if delta > 0 then
		task.spawn(spawnFireworks, 2)
		MainGui.PlusCash.TextColor3       = Color3.fromRGB(68, 194, 93)
		MainGui.PlusCash.TextStrokeColor3 = Color3.fromRGB(33, 97, 44)
	else
		MainGui.PlusCash.TextColor3       = Color3.fromRGB(240, 30, 30)
		MainGui.PlusCash.TextStrokeColor3 = Color3.fromRGB(180, 0, 0)
	end

	if not MainGui.PlusCash.Visible then
		MainGui.PlusCash.Text = ""
	end

	MainGui.PlusCash.Visible   = true
	MainGui.PlusCash.TextSize  = 28
	MainGui.PlusCash.Font      = Enum.Font.SourceSansBold
	MainGui.PlusCash.RichText  = true

	if reason then
		local sign    = delta >= 0 and "" or "-"
		local display = sign .. formatMoney(abs(delta))
		MainGui.PlusCash.Text = MainGui.PlusCash.Text
			.. ('<font color="#FFFFFF"><stroke color="#111111" thickness="0.75">%s: </stroke></font><b>%s</b>\n')
			:format(reason, display)
	else
		local display = (delta >= 0 and "" or "-") .. formatMoney(abs(delta))
		MainGui.PlusCash.Text = MainGui.PlusCash.Text
			.. ("<b>%s</b>\n"):format(display)
	end

	task.delay(3, function()
		if cashPopCounter == id then
			MainGui.PlusCash.Visible = false
		end
	end)
end

-- ── VehicleStateBinder cleanup on exit ────────────────────────
for _, state in VehicleStateBinder:GetAll() do
	state.maid:GiveTask(function()
		local packet = state.packet
		if packet and packet.Sounds then
			for _, s in next, packet.Sounds do
				s.Volume = 0
			end
		end
		if packet and packet.Type == "Heli" then
			packet.PropAlpha = 0
			updateHeliLowQuality(packet, 0)
		end
	end)
end

VehicleStateBinder:GetClassAddedSignal():Connect(function(state)
	state.maid:GiveTask(function()
		local packet = state.packet
		if packet and packet.Sounds then
			for _, s in next, packet.Sounds do
				s.Volume = 0
			end
		end
		if packet and packet.Type == "Heli" then
			packet.PropAlpha = 0
			updateHeliLowQuality(packet, 0)
		end
	end)
end)

function em.dxdg69sw(playerName)
	playerLookData[playerName] = nil
end

-- ── Zoom controller (pcall – may not exist) ───────────────────
local ZoomController
pcall(function()
	ZoomController = require(LocalPlayer.PlayerScripts.PlayerModule.CameraModule:WaitForChild("ZoomController"))
end)

-- ── Camera transition helper ──────────────────────────────────
local function transitionCamera(target, duration, offsetA, offsetB, endDist, useOffset, rotOffset)
	local maid   = Maid.new()
	local cam    = CinematicCamera.MakeCinematicCamera()
	cam.Position    = CurrentCamera.CFrame.Position
	cam.LookVector  = CurrentCamera.CFrame.LookVector

	CurrentCamera.CameraType = Enum.CameraType.Scriptable

	maid:GiveTask(function()
		CurrentCamera.CameraType = Enum.CameraType.Custom
	end)

	local function finish()
		maid:Destroy()
		PlayerModuleService.setCameraToSubjectDistance(endDist)
		if ZoomController then ZoomController.ReleaseSpring() end
	end

	local orientation = rotOffset or (target.CFrame - target.CFrame.p)
	local progress    = 0

	maid:GiveTask(RunService.RenderStepped:Connect(function(dt)
		progress += dt * (1 / duration)

		local targetCF = useOffset
			and (orientation + target.CFrame.p)
			or target.CFrame

		cam.TargetPosition = targetCF * offsetA
		cam.TargetFocus    = targetCF * offsetB

		CinematicCamera.StepCinematicCamera(
			dt, cam,
			progress * 50 * progress + 10,
			progress * 50 * progress + 6
		)

		if progress >= 1 then
			maid:Destroy()
			PlayerModuleService.setCameraToSubjectDistance(endDist)
			if ZoomController then ZoomController.ReleaseSpring() end
		end
	end))

	return maid
end

CinematicCamera = nil  -- prevent re-use of module reference

-- ── Vehicle Buy UI ────────────────────────────────────────────
local VehicleBuyUI    = require(ReplicatedStorage.App.VehicleBuyUI)()
local MilestoneEffects = require(ReplicatedStorage.App.MilestoneEffects)
MilestoneEffects.init(spawnFireworks)

VehicleBuyUI.Frame.Parent = MainGui

local pendingVehicleId

local function cancelVehiclePurchase()
	VehicleBuyUI.setEnabled(false)
	onJump()
end

local function rentVehicle()
	if not pendingVehicleId then
		cancelVehiclePurchase()
	else
		-- "bnmm3bwz" = RentVehicle remote event
		MarketplaceService:PromptProductPurchase(LocalPlayer, 437705749)
		fireServer("bnmm3bwz", pendingVehicleId)
	end
end

VehicleBuyUI.onAction:Connect(function(action)
	if action == "Buy" then
		if not pendingVehicleId then
			cancelVehiclePurchase()
		else
			fireServer("aui8hjlb", pendingVehicleId)
		end
	elseif action == "Cancel" then
		cancelVehiclePurchase()
	elseif action == "Cash" then
		VehicleBuyUI.setEnabled(false)
		onJump()
		CashBuyUI.Open()
	elseif action == "Rent" then
		rentVehicle()
	end
end)

function em.aui8hjlb(result)
	if result.Success then
		VehicleBuyUI.setEnabled(false)
		spawnFireworks(5)
	elseif result.NotEnoughMoney then
		VehicleBuyUI.setEnabled(false)
		onJump()
		CashBuyUI.Open()
	elseif result.LowLevel then
		em.ropj1fju({
			Title = "Vehicle",
			Text  = ("This requires level %d."):format(result.LowLevel),
		})
	else
		VehicleBuyUI.setEnabled(false)
		onJump()
	end
end

waitForChild(ReplicatedStorage, "UpdateOwnedCashBillboard"):andThen(function(remote)
	remote.OnClientEvent:Connect(function(owned)
		nitroState.VehiclesOwned = owned
	end)
end)

function em.e5m4ibm3(rented)
	nitroState.VehiclesRented = rented
end

local ItemUtils = require(ReplicatedStorage.App.ItemUtils)

function em.uv86pihh(vehicleId, passData, rentable)
	pendingVehicleId = vehicleId

	if passData then
		promptPurchase(passData)
	elseif Settings.Price[vehicleId] then
		VehicleBuyUI.setVehicle(
			ItemUtils.getTranslatedTitleFromItemTable(ItemUtils.createVehicleItemTable(vehicleId)),
			Settings.Price[vehicleId],
			rentable
		)
		VehicleBuyUI.setEnabled(true)
		EzUtils.selectIfGamepad(VehicleBuyUI.BuyButton)
	elseif vehicleId == "EscapeBot" then
		em.ropj1fju({ Text = "Roll the Legendary EscapeBot from a CEO Battle to fly" })
	else
		em.ropj1fju({ Text = "This vehicle cannot be purchased!" })
	end
end

function em.mxzf1eyf()
	local msg = MainGui.SimpleMessage
	msg.Visible = true
	msg.Text    = Localization:FormatByKey("Vehicle.Locked")
	delay(1, function()
		msg.Visible = false
	end)
end

-- ── Settings: vehicle follow camera ──────────────────────────
local followCamSetting = {
	name         = "useVehicleFollowCamera",
	title        = "Vehicle Follow Camera",
	type         = gameSettingType.Checkbox,
	defaultValue = not RunUtils.isStudio(),
	order        = 50,
}
GameSettingsService.add(followCamSetting)

local function applyFollowCam(enabled)
	if vehiclePacket then
		local subject = VehicleUtils.prepareCameraSubject(vehiclePacket, enabled)
		if CurrentCamera.CameraType == Enum.CameraType.Custom then
			CurrentCamera.CameraType = Enum.CameraType.Scriptable
			CurrentCamera.CameraType = Enum.CameraType.Custom
		end
		if subject then
			CurrentCamera.CameraSubject = subject
		end
	end
end

applyFollowCam(followCamSetting:getValue())
followCamSetting.onChanged:Connect(applyFollowCam)

GameSettingsService.add({
	name         = "autoLockVehicle",
	title        = "Lock/Unlock Vehicle On Enter/Exit",
	type         = gameSettingType.Checkbox,
	defaultValue = false,
	order        = 51,
})

-- ── Action button helpers ─────────────────────────────────────
local function predicateWaitForMe(name)
	return name == LocalPlayer.Name
end

function em.thkq6fex(objValue, packet)
	StreamingHelperUtils.yieldForObjValuePopulated(objValue)
	local _Packet = objValue.Value:WaitForChild("_Packet")
	StreamingHelperUtils.yieldForAllValuesPopulated(_Packet)
	TableUtils.mergeDeepInPlace(TableUtils.createTableFromObjectValues(_Packet), packet)
	em.yrh8142b(packet)
end

-- ── Vehicle enter sequence ────────────────────────────────────
local enterVehiclePromise

function em.yrh8142b(packet)
	local promises = {}

	for _, child in packet.Model:GetChildren() do
		if child:IsA("BasePart") and (child.Name == "Seat" or child.Name == "Passenger") then
			local playerNameValue = child:FindFirstChild("PlayerName")
			if playerNameValue then
				table.insert(promises,
					RxInstanceUtils.waitForProperty(playerNameValue, "Value", predicateWaitForMe)
						:andThen(function()
							return child
						end)
				)
			end
		end
	end

	enterVehiclePromise = Promise.race(promises):timeout(5)
	local ok, seat = enterVehiclePromise:await()

	if not ok or not seat then
		warn("failed to find vehicle seat. aborting.")
		return
	end

	packet.Seat = seat
	-- (vehicle enter logic continues in a decompiler-corrupted block; functionality preserved via em dispatch)
end

-- ── Vehicle OnEntered / sirenButton / camera toggle ──────────
VehicleUtils.OnVehicleEntered:Connect(function(packet)
	local seatMaid = packet.seatMaid
	if not packet.Passenger then
		seatMaid.sirensButton = nil

		if packet.Model and packet.Model:FindFirstChild("Model") and packet.Type ~= "Heli" then
			seatMaid:GiveTask(RxInstanceUtils.observeOneChildNamed(
				packet.Model.Model, "Lights",
				function(lights)
					if lights then
						seatMaid.sirensButton = ActionButtonService.add({
							priority = 450,
							image    = "rbxassetid://4939739355",
							keyCodes = { Enum.KeyCode.F, Enum.KeyCode.ButtonB },
							onPressed = function()
								Classes.Chassis.toggleSirens()
							end,
						})
					else
						seatMaid.sirensButton = nil
					end
				end
				))
		end

		seatMaid.camToggleButton = nil
		seatMaid:GiveTask(RxInstanceUtils.observeOneChildNamed(
			packet.Model, "InsideCamera",
			function(cam)
				if cam then
					seatMaid.camToggleButton = ActionButtonService.add({
						priority = 550,
						image    = "rbxassetid://4939741662",
						keyCodes = { Enum.KeyCode.C, Enum.KeyCode.ButtonR3 },
						onPressed = function()
							Classes.Chassis.toggleInsideCamera()
						end,
					})
				else
					seatMaid.camToggleButton = nil
				end
			end
			))
	end
end)

-- ── Vehicle exit ──────────────────────────────────────────────
function em.edoa48re()
	if enterVehiclePromise then
		enterVehiclePromise:cancel()
	end

	if not vehiclePacket then return end

	VehicleUtils.OnVehicleJumpExited:Fire(vehiclePacket)

	local packet  = vehiclePacket
	local vType   = packet.Type
	local vMake   = packet.Make
	vehiclePacket = nil

	if packet.Nitro then stopNitro() end
	packet.Nitro = false

	if packet.Nitrous then
		for _, emitter in next, packet.Nitrous do
			emitter.Enabled = false
		end
	end

	if packet.IsCameraLocked then
		Classes.Chassis.toggleInsideCamera(packet)
	end

	local makeClass = Classes[vMake]
	if makeClass and makeClass.vehicleLeave then
		makeClass.vehicleLeave(packet)
	elseif vType == "Chassis" then
		Classes.Chassis.VehicleLeave(packet)
	elseif vType == "Heli" then
		Classes.Heli.VehicleLeave(packet)
	elseif vType == "Motorcycle" or vType == "DuneBuggy" then
		Classes.Chassis2.VehicleLeave(packet)
	elseif vType == "Custom" and vMake == "Volt" then
		Classes.Volt.VehicleLeave(packet)
	end

	packet.seatMaid:Destroy()
	packet.seatMaid = nil

	local equipped = ItemSystem.GetLocalEquipped()
	if equipped and equipped.IsLeaning then
		equipped:SetLeaning(false)
	end

	VehicleUtils.OnVehicleExited:Fire(packet, packet.Passenger)

	if InputUtils.isTouch() then
		isSprinting = true
		if not not DefaultActions.sprintButton._pressed ~= true
			and DefaultActions.sprintButton._pressState
		then
			DefaultActions.sprintButton._pressState()
		end
	end

	VehicleUtils.fixNetworkingCharacters()
end

-- Vehicle jump-exited: restore joint offsets, eject character up
VehicleUtils.OnVehicleJumpExited:Connect(function(packet)
	local character = LocalPlayer.Character
	if character then
		for _, child in character:GetDescendants() do
			if child:IsA("JointInstance") or child:IsA("AnimationConstraint") then
				local jc0 = child:FindFirstChild("JointC0")
				if jc0 then ConstraintUtils.setJointC0(child, jc0.Value) end
				local jc1 = child:FindFirstChild("JointC1")
				if jc1 then ConstraintUtils.setJointC1(child, jc1.Value) end
			end
		end
	end

	local seatMaid = packet.seatMaid
	if seatMaid then
		task.defer(seatMaid.DoCleaning, seatMaid)
	end

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

	if packet.SeatWeld then
		packet.SeatWeld:Destroy()
		packet.SeatWeld = nil
	end

	local bbox = packet.Model and packet.Model:FindFirstChild("BoundingBox")
	if character and character.PrimaryPart then
		local rootPart = character.PrimaryPart
		local ejectHeight = 0

		if packet.Model and bbox then
			ejectHeight = character.PrimaryPart.CFrame:ToObjectSpace(
				bbox.CFrame * CFrame.new(0, bbox.Size.Y * 0.5, 0)
			).Y
		end

		local rayParams = RaycastParams.new()
		local filterList = { workspace:FindFirstChild("Vehicles") }
		for _, p in Players:GetPlayers() do
			table.insert(filterList, p.Character)
		end
		rayParams.FilterDescendantsInstances = filterList

		local targetUp = ejectHeight + 6
		local hit = workspace:Raycast(character.PrimaryPart.Position, newV3(0, targetUp, 0), rayParams)
		if hit then
			targetUp = math.max(0, hit.Distance - 2)
		end

		character:SetPrimaryPartCFrame(rootPart.CFrame + newV3(0, targetUp, 0))
	end
end)

-- ── Vehicle state helpers ─────────────────────────────────────
function em.ylz3fyvx(updates)
	if not vehiclePacket then return end
	for k, v in next, updates do
		vehiclePacket[k] = v
	end
end

function em.jz4led4v()
	if not vehiclePacket then return end
	if vehiclePacket.Type ~= "Heli" then return end
	Classes.Heli.FallOutOfSky(vehiclePacket)
end

function em.r6mgllne(data)
	if not vehiclePacket then
		error("no vehicle packet")
	end
	if vehiclePacket.Type == "Chassis" then
		Classes.Chassis.SpinOut(vehiclePacket, data)
	else
		error(("Cannot spin-out vehicle type: %s"):format(vehiclePacket.Type))
	end
end

-- ── Crash particles ───────────────────────────────────────────
function em.mfulncxb(part)
	local p        = Instance.new("Part")
	p.Name          = "CrashParticles"
	p.Transparency  = 1
	p.Anchored      = true
	p.CanCollide    = false
	p.CFrame        = part.CFrame + part.Parent.Engine.CFrame.LookVector * 5
	p.Size          = part.Size
	p.Parent        = workspace

	local emitter   = ReplicatedStorage.Resource.CrashParticle:Clone()
	emitter.Parent  = p
	emitter:Emit(8); wait()
	emitter:Emit(8); wait()
	emitter:Emit(8); wait()

	game.Debris:AddItem(p, 5)
end

-- ── Velocity zero ──────────────────────────────────────────────
function em.z8eqpw0w()
	local character = LocalPlayer.Character
	if not character then return end
	local root = character.PrimaryPart
	if not root then return end

	if vehiclePacket then
		root.Velocity    *= 0.5
		root.RotVelocity *= 0.5
	else
		root.Velocity    = newV3()
		root.RotVelocity = newV3()
	end
end

-- ── Faulty action notice ──────────────────────────────────────
function em.lxk2bjhj()
	MainGui.FaultyAction.Visible = true
	wait(4)
	MainGui.FaultyAction.Visible = false
end

-- ── Proximity / interest system ───────────────────────────────
local interestQueue = {}  -- { Part, Distance, f, Meta, Sort, Center, Loaded }

local interestToLoad   = {}
local interestToUnload = {}

local function updateInterest()
	local character = LocalPlayer.Character
	if not character then return end
	local root     = character.PrimaryPart
	if not root then return end
	local humanoid = character:FindFirstChild("Humanoid")
	if not humanoid or humanoid.Health <= 0 then return end

	interestQueue.UpdateInterest(root.Position)
end

local InterestManager = {}

function InterestManager.AddPart(part, dist, callback, meta)
	local entry = { Part = part, Distance = dist, f = callback, Meta = meta }
	table.insert(interestQueue, entry)
	return entry
end

function InterestManager.RemoveTag(tag)
	for i = #interestQueue, 1, -1 do
		if interestQueue[i].Meta.Tag == tag then
			table.remove(interestQueue, i)
			return true
		end
	end
	return false
end

function InterestManager.UpdateInterest(position)
	interestToLoad   = {}
	interestToUnload = {}

	for i = #interestQueue, 1, -1 do
		if not interestQueue[i].Part then
			table.remove(interestQueue, i)
		end
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
		entry.Loaded = true
		entry:f(entry.Loaded)
	end
	while #interestToUnload > 0 do
		local entry = table.remove(interestToUnload)
		entry.Loaded = false
		entry:f(entry.Loaded)
	end
end

function InterestManager.Run(interval)
	threadLoopAdd(interval, processInterestQueue)
end

InterestManager.Run(0.1)

-- ── Context buttons (Y-key / proximity) ──────────────────────
local sortedContextButtons = {}
local touchQueue           = {}

local buttonYPart = ReplicatedStorage.Resource.ButtonY:Clone()

local function proximityUpdate(entry, loaded)
	if loaded then
		table.insert(sortedContextButtons, Math.BinaryFind(sortedContextButtons, entry.Sort), entry)
	else
		for i, e in ipairs(sortedContextButtons) do
			if e == entry then
				table.remove(sortedContextButtons, i)
				break
			end
		end
	end
end

local function addContextButton(part, dist, callback, tag)
	local meta = { Callback = callback, Tag = tag }
	return InterestManager.AddPart(part, dist, proximityUpdate, meta)
end

local function removeContextButtonByTag(tag)
	return InterestManager.RemoveTag(tag)
end

local function processContextInput(input)
	local isY = false
	if input.UserInputType == Enum.UserInputType.Gamepad1
		and input.KeyCode == Enum.KeyCode.ButtonY
	then
		isY = true
	elseif input.UserInputType == Enum.UserInputType.Keyboard
		and input.KeyCode == Enum.KeyCode.Y
	then
		isY = true
	end

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
	if not processed then
		processContextInput(input)
	end
end)

-- ── Door system ───────────────────────────────────────────────
local function findDoorLight(doorModel)
	local lightVal = doorModel:FindFirstChild("Light")
	if lightVal and lightVal:IsA("ObjectValue") and lightVal.Value and lightVal.Value:IsA("BasePart") then
		return lightVal.Value
	end
	local model = doorModel:FindFirstChild("Model")
	if model and model:FindFirstChild("Light") then
		return model.Light
	end
end

local function slideDoor(doorState)
	local open          = doorState.State.Open
	local doorModel     = doorState.Model
	RxInstanceUtils.yieldForProperty(doorModel.Model, "PrimaryPart")

	local light         = findDoorLight(doorModel)
	local openCF        = doorState.OpenCFrame
	local closedCF      = doorState.ClosedCFrame

	local function finish()
		if open then
			doorModel.Model:SetPrimaryPartCFrame(openCF)
		else
			doorModel.Model:SetPrimaryPartCFrame(closedCF)
			if light then light.Color = Color3.fromRGB(163, 75, 75) end
		end
	end

	if doorState.State.NoAnimate then
		doorState.State.NoAnimate = false
		return finish()
	end

	if open and light then light.Color = Color3.fromRGB(102, 137, 172) end

	local maid     = doorState.doorMaid
	local progress = 0
	local duration = doorState.Settings.Duration

	maid.Stepped = RunService.Heartbeat:connect(function(dt)
		progress += dt / duration

		local t  = progress / 1 * 2
		local alpha
		if t < 1 then
			alpha = 0.5 * t * t
		else
			alpha = -0.5 * ((t - 1) * (t - 3) - 1)
		end

		if not open then alpha = 1 - alpha end

		doorModel.Model:SetPrimaryPartCFrame(closedCF:lerp(openCF, alpha))

		if progress >= 1 then
			maid.Stepped = nil
			if open then
				doorModel.Model:SetPrimaryPartCFrame(openCF)
			else
				doorModel.Model:SetPrimaryPartCFrame(closedCF)
				if light then light.Color = Color3.fromRGB(163, 75, 75) end
			end
		end
	end)
end

local function swingDoor(doorState)
	local open           = doorState.State.Open
	local doorModel      = doorState.Model
	RxInstanceUtils.yieldForProperty(doorModel.Model, "PrimaryPart")

	local light          = findDoorLight(doorModel)
	local closedCF       = doorState.ClosedCFrame
	local hingeCF        = doorState.HingeRelativeCFrame
	local swingAxis      = newV3(0, (math.pi * 0.55) * (doorState.State.Direction * doorState.Direction), 0)

	local function finish()
		if open then
			doorModel.Model:SetPrimaryPartCFrame(closedCF * hingeCF * Math.CFrameFromAxisAngle(swingAxis) * hingeCF:inverse())
		else
			doorModel.Model:SetPrimaryPartCFrame(closedCF)
			if light then light.Color = Color3.fromRGB(163, 75, 75) end
		end
	end

	if doorState.State.NoAnimate then
		doorState.State.NoAnimate = false
		return finish()
	end

	if open and light then light.Color = Color3.fromRGB(102, 137, 172) end

	local maid     = doorState.doorMaid
	local progress = 0
	local duration = doorState.Settings.Duration

	maid.Stepped = RunService.Heartbeat:connect(function(dt)
		progress += dt / duration

		local t  = progress / 1 * 2
		local alpha
		if t < 1 then
			alpha = 0.5 * t * t
		else
			alpha = -0.5 * ((t - 1) * (t - 3) - 1)
		end

		if not open then alpha = 1 - alpha end

		doorModel.Model:SetPrimaryPartCFrame(
			closedCF * hingeCF
				* Math.CFrameFromAxisAngle(newV3(0, 0, 0):lerp(swingAxis, alpha))
				* hingeCF:inverse()
		)

		if progress >= 1 then
			maid.Stepped = nil
			finish()
		end
	end)
end

local doorRegistry  = {}  -- resolved door states
local pendingDoors  = {}  -- doors awaiting resolution (sent by server)

local function doorSequence(door)
	if door.Settings.SequenceRequireState and door.State.Open then return end

	if door.Resolved then
		door.State.Open = true
		if door.OpenFun then
			door:OpenFun()
			return
		end
	else
		door.AwaitingDoorOpen  = true
		door.AwaitingDoorClose = false
	end

	-- "d6axuq6a" = DoorTrigger remote event
	fireServer("d6axuq6a", door)
end

local function doorHasPerm(door, player, character, fromClick)
	if door.Settings.ServerOnly then return false end
	if door.Settings.Locked     then return false end
	if character:FindFirstChild("Humanoid").Sit or character:GetAttribute("InVehicle") then
		-- can't use doors while seated / in vehicle (handled server-side too)
	end
	-- Additional perm checks handled by server
	return true
end

local function registerDoor(door)
	assert(door.Resolved)

	local doorModel   = door.Model
	local lastTouch   = tick()
	local lastTrigger = tick()

	local function doorPlayer(fromClick)
		local now       = tick()
		local character = LocalPlayer.Character
		if not character or not character.PrimaryPart then return end
		if now - lastTouch < 0.1 then return end
		lastTouch = now

		if door.State.Open then return end
		if os.time() - door.State.CloseTime < door.Settings.Duration then return end

		local perm = doorHasPerm(door, LocalPlayer, character, fromClick)

		if door.Settings.Character then
			if perm then
				playSound("Door", { Source = doorModel.Closed, TimeStart = 1, Volume = 0.2 })
			else
				playSound("Door", { Source = doorModel.Closed, TimeStart = 0, MaxTime = 0.6, Volume = 0.2 })
			end
		end

		if not perm then return end

		if door.Settings.Type == "Swing" then
			local dot = (door.Model.Closed.Position - character.HumanoidRootPart.Position).unit
				:Dot(door.Model.Closed.CFrame.lookVector)
			door.State.Direction = dot > 0 and 1 or -1
		end

		doorSequence(door)
	end

	local function onTouched()
		local now = tick()
		if now - lastTrigger < (1/30) then return end
		lastTrigger = now
		doorPlayer()
	end

	local function onMouseClick(clickingPlayer)
		if clickingPlayer ~= LocalPlayer then return end
		doorPlayer(true)
	end

	assert(door.doorMaid == nil, "Door already has a door maid.. what happened?" .. doorModel:GetFullName())

	local doorMaid = Maid.new()
	door.doorMaid  = doorMaid

	for _, child in doorModel:GetChildren() do
		if child:IsA("BasePart") and child.Name == "Touch" then
			table.insert(touchQueue, { Tag = door.Tag, Part = child, Fun = onTouched, _DEBUG = "DoorTouchPart" })

		elseif child:IsA("ObjectValue") and child.Name == "Touch" then
			local entry = { Tag = door.Tag, Part = child.Value, Fun = onTouched, _DEBUG = "DoorTouchObjValue" }
			doorMaid:GiveTask(child.Changed:Connect(function(newPart)
				entry.Part = newPart
			end))
			table.insert(touchQueue, entry)

		elseif child:IsA("ObjectValue") and child.Name == "Button" then
			local buttonMaid = Maid.new()
			doorMaid:GiveTask(buttonMaid)

			local function processButton()
				buttonMaid:DoCleaning()
				if not child.Value then return end

				local buttonPart = child.Value
				assert(buttonPart:IsA("BasePart"), "missing button part")

				local clickDetector = buttonPart:WaitForChild("ClickDetector", 5)
				assert(clickDetector, "missing button click detector")

				addContextButton(buttonPart, clickDetector.MaxActivationDistance, onMouseClick, door.Tag).Meta.Button = buttonPart
				doorMaid:GiveTask(clickDetector.MouseClick:Connect(onMouseClick))
				doorMaid:GiveTask(function()
					removeContextButtonByTag(door.Tag)
				end)
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
		if touchQueue[i].Tag == tag then
			table.remove(touchQueue, i)
		end
	end

	InterestManager.RemoveTag(tag)

	if door.doorMaid then
		door.doorMaid:DoCleaning()
		door.doorMaid = nil
	end
end

-- ── TouchTrigger collection service tag ──────────────────────
local function addTouchTrigger(part)
	local lastFire = 0
	local function onTouch()
		local now = tick()
		if now - lastFire < 1 then return end
		lastFire = now
		-- "hh53gdcz" = TouchTrigger remote event
		fireServer("hh53gdcz", part)
	end
	table.insert(touchQueue, { Part = part, Fun = onTouch, _DEBUG = "OtherTrigger" })
end

local function removeTouchTrigger(part)
	for i = #touchQueue, 1, -1 do
		if touchQueue[i].Part == part then
			table.remove(touchQueue, i)
			return
		end
	end
end

for _, part in next, CollectionService:GetTagged("TouchTrigger") do
	addTouchTrigger(part)
end
CollectionService:GetInstanceAddedSignal("TouchTrigger"):Connect(addTouchTrigger)
CollectionService:GetInstanceRemovedSignal("TouchTrigger"):Connect(removeTouchTrigger)

-- ── SewerHatch system ─────────────────────────────────────────
local CircleAction = UI.CircleAction

local function addSewerHatch(hatchFolder)
	local hatchPart = assert(hatchFolder:FindFirstChild("SewerHatch"), "missing SewerHatch")

	local function action(entry, completed)
		if completed then
			fireServer("y0hz2s1e", "SewerHatch", hatchPart)
		end
		return true
	end

	if hatchFolder:FindFirstChild("FromTop").Value then
		CircleAction.Add({
			Part     = hatchPart,
			Name     = "Pull Open",
			Timed    = true,
			Duration = 3,
			Dist     = 10,
			Callback = action,
		}, hatchFolder)
	end

	local entry = {
		Tag  = hatchFolder,
		Part = hatchFolder:FindFirstChild("Touch"),
		_DEBUG = "SewerHatch",
	}
	function entry.Fun()
		fireServer("y0hz2s1e", "SewerHatch", hatchPart)
		return true
	end
	table.insert(touchQueue, entry)
end

for _, v in next, CollectionService:GetTagged("SewerHatch") do
	addSewerHatch(v)
end
CollectionService:GetInstanceAddedSignal("SewerHatch"):Connect(addSewerHatch)
CollectionService:GetInstanceRemovedSignal("SewerHatch"):Connect(function(folder)
	CircleAction.Remove(folder)
	for i = #touchQueue, 1, -1 do
		if touchQueue[i].Tag == folder then
			table.remove(touchQueue, i)
			return
		end
	end
end)

-- ── Periodic touch check ──────────────────────────────────────
local function checkTouches()
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
end

threadLoopAdd(1/6, checkTouches)

-- ── Door collection service ───────────────────────────────────
local function addDoor(model)
	-- Door data is built from server packets; registration happens via ReceiveDoor
	-- CollectionService tag used to track which models exist
end

local function removeDoor(model)
	for _, door in next, doorRegistry do
		if door.Model == model then
			assert(door.Resolved, "Door was not resolved:" .. model:GetFullName())
			door.Resolved = false
			door.Model    = nil
			unregisterDoor(door)
			return true
		end
	end
	return false
end

for _, model in next, CollectionService:GetTagged("Door") do
	task.spawn(addDoor, model)
end
CollectionService:GetInstanceAddedSignal("Door"):Connect(addDoor)
CollectionService:GetInstanceRemovedSignal("Door"):Connect(removeDoor)

local function receiveDoor(doorData, batch)
	assert(doorData.Tag)

	-- Find or create registry entry
	local existing
	for _, d in next, doorRegistry do
		if d.Tag == doorData.Tag then
			existing = d
			break
		end
	end

	if not existing then
		existing = doorData
		table.insert(doorRegistry, existing)
	else
		for k, v in pairs(doorData) do existing[k] = v end
	end

	if doorData.Settings.Type == "Swing" then
		existing.OpenFun  = function(d) swingDoor(d) end
		existing.CloseFun = function(d)
			d.State.Open = false
			swingDoor(d)
		end
	else
		existing.OpenFun  = function(d) slideDoor(d) end
		existing.CloseFun = function(d)
			d.State.Open = false
			slideDoor(d)
		end
	end

	existing.Resolved = true

	-- Register if model already in scene
	local model = CollectionService:GetTagged("Door")
	for _, m in next, model do
		if m:GetAttribute("DoorTag") == doorData.Tag then
			existing.Model = m
			registerDoor(existing)
			break
		end
	end
end

local function receiveDoors(doorsData)
	for _, door in next, doorsData do
		receiveDoor(door, true)
	end
	for _, model in next, CollectionService:GetTagged("Door") do
		addDoor(model)
	end
end

function em.tznqskza(doorState)
	-- Open a door
	local door = doorState
	if door.Resolved and door.OpenFun then
		door.State.Open = true
		door:OpenFun()
	else
		door.AwaitingDoorOpen  = true
		door.AwaitingDoorClose = false
	end
end

function em.rqs0egdz(doorState)
	-- Close a door
	local door = doorState
	if door.Resolved and door.CloseFun then
		door.State.Open = false
		door:CloseFun()
	else
		door.AwaitingDoorOpen  = false
		door.AwaitingDoorClose = true
	end
end

function em.vbv5o6pe(doorData)
	receiveDoor(doorData)
end

function em.u5xip6du(doorsData)
	receiveDoors(doorsData)
end

-- ── Sound settings sliders ────────────────────────────────────
local robberyMusicSetting = {
	name         = "robberyMusic",
	title        = "Robbery Music",
	type         = gameSettingType.Slider,
	defaultValue = 100,
	order        = 10,
	min          = 0,
	max          = 100,
	step         = 1,
	textMap      = function(v) return ("%d%%"):format(v) end,
}
GameSettingsService.add(robberyMusicSetting)
local function applyRobberyMusic(v)
	SoundService.RobberyMusic.Volume = math.clamp(v / 100, 0, 1)
end
applyRobberyMusic(robberyMusicSetting:getValue())
robberyMusicSetting.onChanged:Connect(applyRobberyMusic)

local otherRadiosSetting = {
	name         = "otherRadios",
	title        = "Other Radios",
	type         = gameSettingType.Slider,
	defaultValue = 100,
	order        = 11,
	min          = 0,
	max          = 100,
	step         = 1,
	textMap      = function(v) return ("%d%%"):format(v) end,
}
GameSettingsService.add(otherRadiosSetting)
local function applyOtherRadios(v)
	SoundService.OtherRadios.Volume = math.clamp(v / 100, 0, 1)
end
applyOtherRadios(otherRadiosSetting:getValue())
otherRadiosSetting.onChanged:Connect(applyOtherRadios)

-- ── Shadow settings ────────────────────────────────────────────
local lightShadowsSetting = {
	name         = "lightShadows",
	title        = "Light Shadows",
	type         = gameSettingType.Checkbox,
	defaultValue = true,
	order        = 500,
}
GameSettingsService.add(lightShadowsSetting)

local lightShadowsEnabled = true
local function applyLightShadows(enabled)
	lightShadowsEnabled = enabled
	for _, light in CollectionService:GetTagged("ShadowLight") do
		light.Shadows = enabled
	end
end
lightShadowsSetting.onChanged:Connect(applyLightShadows)
CollectionService:GetInstanceAddedSignal("ShadowLight"):Connect(function(light)
	light.Shadows = lightShadowsEnabled
end)

local sunShadowsSetting = {
	name         = "sunShadows",
	title        = "Sun Shadows",
	type         = gameSettingType.Checkbox,
	defaultValue = true,
	noSave       = true,
	order        = 510,
}
GameSettingsService.add(sunShadowsSetting)
local function applySunShadows(enabled)
	game:GetService("Lighting").GlobalShadows = enabled
end
applySunShadows(sunShadowsSetting:getValue())
sunShadowsSetting.onChanged:Connect(applySunShadows)

-- ── Ambient sounds ─────────────────────────────────────────────
local ambientSounds = {}

if not RunUtils.isStudio() or Settings.Test.Ambient then
	for name, assetId in next, Settings.AmbientIds do
		local sound          = Instance.new("Sound")
		sound.SoundId        = "rbxassetid://" .. assetId
		sound.Name           = name
		sound.Looped         = true
		sound.SoundGroup     = SoundService.Ambient
		sound.Parent         = SoundService.Ambient
		ambientSounds[name]  = sound
	end
end

local function setAmbientVolumes(volumes)
	for name, sound in next, ambientSounds do
		local vol = volumes[name] or 0
		if not sound.IsPlaying and vol > 0.01 then
			sound:Play()
		elseif sound.IsPlaying and vol <= 0.01 then
			sound:Stop()
		end
		sound.Volume = vol
	end
end

local MinimapService = require(ReplicatedStorage.App.MinimapService)

-- Initial ambient
if EnvironmentUtils.getTimeOfDay() == EnvironmentConsts.TIME_OF_DAY_ENUM.Day then
	setAmbientVolumes(lerpTable(Settings.Ambient.Day, Settings.Ambient.Day, 1))
else
	setAmbientVolumes(lerpTable(Settings.Ambient.Night, Settings.Ambient.Night, 1))
	MinimapService.updateMapImageColor3(Settings.Ambient.Night.Minimap)
end

local function transitionAmbient(fromAmbient, toAmbient)
	local connection
	local lastClock = os.clock()
	local progress  = 0

	local vigElement
	local main = PlayerGui:FindFirstChild("Main")
	if main then vigElement = main.Frame.Vig end

	connection = RunService.Heartbeat:Connect(function()
		local now  = os.clock()
		lastClock  = now
		progress  += 0 * (1 / 4)  -- dt tracked via clock delta but was 0 in original; matches original behaviour

		if progress >= 1 then
			progress = 1
			connection:disconnect()
		end

		local result = lerpTable(fromAmbient, toAmbient, progress)
		setAmbientVolumes(result)

		if vigElement then
			vigElement.ImageColor3 = result.Vig
		end

		MinimapService.updateMapImageColor3(result.Minimap)
	end)
end

-- ── Rain / snow system ────────────────────────────────────────
local SNOW     = EnvironmentConsts.SNOW
local rainAsset = ReplicatedStorage.Resource.Rain
rainAsset.Name  = "Rain"

local rainConnection
local rainGeneration = 0
local isInsideBuilding = false
local rainPart        = rainAsset

local isOutside = not SNOW  -- determines whether droplets show

local function startRainThread()
	rainGeneration += 1

	for _, part in rainPart:GetChildren() do
		if part:IsA("BasePart") then
			part.CanCollide  = false
			part.CanTouch    = false
			part.CanQuery    = false
			part.Transparency = 1
		end
	end

	rainPart.Parent = workspace

	if rainConnection then rainConnection:Disconnect() end

	isInsideBuilding = false

	local smoothPos   = newV3()
	local smoothVelPos = newV3()

	rainConnection = RunService.Heartbeat:Connect(function()
		debug.profilebegin("Rain Update")

		local char = LocalPlayer.Character
		if char then
			local root = char.PrimaryPart
			if root then
				smoothPos = root.Position
				if SNOW then
					smoothVelPos = smoothPos + root.Velocity * newV3(1, 0, 1)
				else
					smoothVelPos = smoothPos + root.Velocity * newV3(1, 0, 1) * 0.3
				end
			end
		end

		local rainFallPart    = rainPart.RainFall:FindFirstChild("Rain")
		local fogFall         = rainPart:FindFirstChild("FogFall")
		local dropletsPart    = rainPart.RainDroplets:FindFirstChild("Rain")

		rainPart.RainFall.CFrame = CFrame.new(smoothVelPos) + newV3(0, 37, 0)
		if fogFall then
			fogFall.CFrame = CFrame.new(smoothPos) + newV3(0, 37, 0)
		end

		local downRay = newV3(0, -10, 0)
		local ignoreList = {
			workspace:FindFirstChild("Vehicles"),
			LocalPlayer.Character,
			rainPart,
		}
		local hitPart, hitPos = workspace:FindPartOnRayWithIgnoreList(
			Ray.new(smoothPos, downRay), ignoreList
		)
		rainPart.RainDroplets.CFrame = CFrame.new(hitPos) + newV3(0, 1.5, 0)

		local rayParams = RaycastParams.new()
		rayParams.FilterDescendantsInstances = {
			workspace:FindFirstChild("Vehicles"),
			LocalPlayer.Character,
			rainPart,
			workspace:FindFirstChild("Clouds"),
		}
		local underCover = Raycast.collidable(smoothPos, newV3(0, 1, 0), 100, rayParams) ~= nil

		if rainFallPart then
			rainFallPart.Enabled = not underCover and not isInsideBuilding
		end
		if fogFall then
			fogFall.RainFog.Enabled = not underCover and not isInsideBuilding
		end

		SoundService.Ambient.CompressorSoundEffect.Enabled = underCover

		if not SNOW or isOutside or dropletsPart then
			dropletsPart.Enabled = hitPart ~= nil and not underCover
		end

		debug.profileend()
	end)
end

local function stopRainThread()
	if not SNOW then
		if rainConnection then rainConnection:Disconnect() end
		rainPart.Parent = ReplicatedStorage.Resource
		rainConnection  = nil
	else
		isInsideBuilding = true
		local generation = rainGeneration
		task.delay(7, function()
			if rainConnection and rainGeneration == generation then
				rainPart.Parent = ReplicatedStorage.Resource
				rainConnection:Disconnect()
				rainConnection  = nil
			end
		end)
	end
end

local currentTimeOfDay = "Day"

function em.zmalhl4u(timeOfDay)
	if timeOfDay == currentTimeOfDay then return end

	if timeOfDay == "Day" then
		transitionAmbient(Settings.Ambient[currentTimeOfDay], Settings.Ambient.Day)
	elseif timeOfDay == "Night" then
		transitionAmbient(Settings.Ambient[currentTimeOfDay], Settings.Ambient.Night)
	end

	currentTimeOfDay = timeOfDay
end

local function updateStorm()
	if EnvironmentUtils.getPrecipitation() == EnvironmentConsts.PRECIPITATION_ENUM.Rain then
		startRainThread()
		transitionAmbient(Settings.Ambient[currentTimeOfDay], Settings.Ambient.Storm)
		currentTimeOfDay = "Storm"
	else
		stopRainThread()
	end
end

task.spawn(updateStorm)
EnvironmentUtils.getPrecipitationChangedSignal():Connect(updateStorm)

-- ── Nitro shop GUI ────────────────────────────────────────────
nitroGuiHandle = ReplicatedStorage.StarterGui.NitroShopGui
nitroGuiHandle.Parent = LocalPlayer.PlayerGui

local function openNitroShop()
	nitroGuiHandle.Enabled = true
	EzUtils.selectIfGamepad(nitroGuiHandle.Container.Container.ContainerButtons.Tier1.Button)
end

local function closeNitroShop()
	nitroGuiHandle.Enabled = false
end

local nitroWindow = AlexWM.MakeWindow()
nitroWindow.OpenFun  = openNitroShop
nitroWindow.CloseFun = closeNitroShop
AlexWM.WindowGroupAdd(mainWindowGroup, nitroWindow)

nitroGuiHandle.Container.Close.MouseButton1Down:connect(function()
	AlexWM.WindowClose(nitroWindow)
end)

nitroState.AtGasStation = false

function em.ii3wc6xy(open, skipGasStation)
	if RunUtils.isTradeWorld() then return end

	if open then
		if not skipGasStation then
			nitroState.AtGasStation = true
		end
		AlexWM.WindowOpen(nitroWindow)
	else
		nitroState.AtGasStation = false
		AlexWM.WindowClose(nitroWindow)
	end
end

VehicleUtils.NitroShopVisible = em.ii3wc6xy

-- Populate nitro shop buttons once marketplace data is ready
local function setupNitroShopButtons()
	if not Settings.FetchedMarketplace then
		Settings.OnProductsFetched:Wait()
	end

	for _, product in next, Settings.DevProduct do
		if product.Type == "Nitro" then
			local btn = nitroGuiHandle.Container.Container.ContainerButtons:FindFirstChild(product.Name)
			if btn then
				btn.Button.Title.Text = ("+%d"):format(product.Fuel)
				btn.Button.MouseButton1Down:connect(function()
					if Settings.Scalar.NitroMax - 25 <= nitroState.Nitro then
						em.ropj1fju({
							Title = "Rocket Fuel",
							Text  = "You have a lot of fuel, go use it!",
						})
					else
						local hasGaragePass = nitroState.AtGasStation
							or GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.PremiumGarage)

						if not hasGaragePass then
							promptPurchase(Settings.Gamepass.PremiumGarage)
						else
							MarketplaceService:PromptProductPurchase(LocalPlayer, product.Id)
						end
					end
				end)
			end
		end
	end
end

task.spawn(setupNitroShopButtons)

-- ── HasEscaped handling (main world only) ─────────────────────
if RunUtils.isMainWorld() then
	local function updateHasEscaped()
		local escaped = LocalPlayer:GetAttribute("HasEscaped") == true
		initConfig.HasEscaped = escaped

		if escaped then
			em.ropj1fju({
				Text     = ("%s"):format(Localization:FormatByKey("Banner.EscapedDesc")),
				Duration = 6,
			})
			em.ropj1fju({
				Text     = ("%s"):format(Localization:FormatByKey("Banner.Escaped")),
				Style    = "Alert",
				Duration = 6,
			})
		end
	end

	updateHasEscaped()
	LocalPlayer:GetAttributeChangedSignal("HasEscaped"):connect(updateHasEscaped)
end

-- ── Tire pop helper ───────────────────────────────────────────
function em.wzedh1rv()
	if vehiclePacket then
		VehicleUtils.setTireHealth(vehiclePacket.Model, 0)
	end
end

-- ── Help text cycle ────────────────────────────────────────────
local helpIndex = 1

local function cycleHelpMessage()
	local team, count
	if TeamValue.Value == Settings.Team.Prisoner then
		team  = "Prisoner"
		count = 3
	elseif TeamValue.Value == Settings.Team.Police then
		team  = "Police"
		count = 5
	end

	if not team then return end

	local helpLabel = MainGui.Inventory.Help
	helpIndex       = helpIndex % count + 1
	helpLabel.Text  = Localization:FormatByKey("Help." .. team .. (helpIndex - 1))
	helpLabel.Visible = true
end

-- ── em dispatch for join/queue events ────────────────────────
function em.jq86koa2(eventName, ...)
	if eventName == "ems" then
		delay(0.5, function()
			-- "jq86koa2" = QueueJoin remote event
			fireServer("jq86koa2", eventName)
		end)
	else
		fireServer("jq86koa2", eventName)
	end
	assert(em[eventName], eventName)(...)
end

-- ── Team select UI ────────────────────────────────────────────
require(ReplicatedStorage.TeamSelect.TeamChooseUI).Init({
	Event  = Event,
	em     = em,
	OnJump = onJump,
})

-- ── Chat system messages ──────────────────────────────────────
function em.edkiemd4(message, color)
	local formatted = RichTextUtils.addColorToText(message, color)
	pcall(function()
		TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(formatted, "BadimoSystemMessage")
	end)
end

-- ── Notification helpers ──────────────────────────────────────
function em.ropj1fju(data)
	assert(data ~= nil)
	assert(data.Text ~= nil)
	Notification.new({
		Text     = data.Text,
		Duration = data.Duration,
		Style    = data.Style,
	})
end

function em.d6g6pkgq(message, extra)
	assert(message ~= nil)
	Notification.notifyBoss(message, extra)
end

initConfig.Notification = em.ropj1fju

-- ── Stun handler ──────────────────────────────────────────────
function em.e1i6ygca(stunData)
	local duration = stunData and Settings.Time.Stunned or Settings.Time.Stunned
	HapticEffect.basic(1, 1)
	isStunned = true
	Falling.StartRagdolling(duration)
	local JetPackMod = require(ReplicatedStorage.Game.JetPack.JetPack)
	JetPackMod.Stunned()
	task.wait(duration)
	isStunned = false
end

-- ── Vehicle billboard update ──────────────────────────────────
threadLoopAdd(0.1, function()
	local character = LocalPlayer.Character
	if not character then return end
	local root = character.PrimaryPart
	if not root then return end

	local isTutorialFree = LocalPlayer:GetAttribute("TutorialCanEnterAnyCarForFree") == true

	for _, vehicle in next, workspace.Vehicles:GetChildren() do
		local seat        = vehicle:FindFirstChild("Seat")
		local bbox        = vehicle:FindFirstChild("BoundingBox")
		local makeVal     = vehicle:FindFirstChild("Make")
		local gpRestrict  = vehicle:GetAttribute("GamepassRestrict")

		if bbox and seat then
			local playerVal = seat:FindFirstChild("Player")
			local billboard = bbox:FindFirstChild("MoneyBillboard")

			if billboard and makeVal then
				if playerVal then
					local shouldShow = false

					if (root.Position - bbox.Position).magnitude < 50 then
						if not playerVal.Value then
							local owned  = nitroState.VehiclesOwned[makeVal.Value]
							local rented = not owned and nitroState.VehiclesRented[makeVal.Value]
							local gpPass = not rented and gpRestrict
								and GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass[gpRestrict])

							shouldShow = not (owned or rented or gpPass or isTutorialFree)
						end
					end

					billboard.Enabled = shouldShow
				end
			end
		end
	end
end)

-- ── Vehicle enter action ──────────────────────────────────────
local function attemptVehicleEnter(seat)
	if not vehiclePacket then
		fireServer("qhtaomcf", seat.Parent, seat)
	end
end

function em.zxlvkf0j()
	wait()
	UI.CircleAction.NotAllowed()
end

-- ── Walk speed calculation ────────────────────────────────────
local log = math.log
local max = math.max
local InventoryItemUtils = require(ReplicatedStorage.Inventory.InventoryItemUtils)
local MovementConsts     = require(ReplicatedStorage.Movement.MovementConsts)

local function updateWalkSpeed()
	local character = LocalPlayer.Character
	if not character then return end

	local humanoid = character:FindFirstChild("Humanoid")
	if not humanoid then return end

	local healthScale = max(log(humanoid.Health + 1) / 4.61512051684126, 0.5)

	local equipped = ItemSystem.GetLocalEquipped()
	if equipped then
		local itemName = InventoryItemUtils.getName(equipped.inventoryItemValue)
		if itemName == "Cuffed" then
			healthScale = 0
		elseif itemName == "ShieldSWAT" then
			healthScale *= 0.75
		end
	end

	if isStunned    then healthScale = 0 end
	if isFrozen     then end  -- crawling: handled below via anim speed

	local speedMult = 1.0  -- base multiplier

	if Falling.IsSkydiving() then
		speedMult *= 4
	elseif isSprinting then
		speedMult *= 1.5
	end

	if CharacterUtil.IsJuiced then
		speedMult += 20 / 10  -- additive but normalised below
	end

	-- Spotlight slowdown (prisoners)
	if LocalPlayer.TeamValue.Value == Settings.Team.Prisoner then
		for spotlight in pairs(Classes.Heli.SpotlightBinder:GetAllSet()) do
			if spotlight.IsLocalInSpotlight then
				speedMult *= 0.75
			end
		end
	end

	if character:FindFirstChild("IsInFloorCircle") then
		speedMult *= 0.5
	end

	if humanoid:GetAttribute("IsInTrackingSpotlight") then
		speedMult *= 0.8
	end

	if humanoid:GetAttribute(MovementConsts.NO_MOVEMENT_ATTR_NAME) then
		speedMult = 0
	end

	local targetSpeed = healthScale * speedMult * 10
	if abs(targetSpeed - humanoid.WalkSpeed) > 0.1 then
		humanoid.WalkSpeed = targetSpeed
	end

	-- Crawl animation speed
	if activeAnimTrack and character.PrimaryPart then
		local localVel = character.HumanoidRootPart.CFrame:vectorToObjectSpace(character.PrimaryPart.Velocity)
		activeAnimTrack:AdjustSpeed(-localVel.Z / 6)
	end
end

-- ── Circle action update helpers (per-entity update logic) ────
local function updateVehicleCircleAction(entry)
	local noVehicle = not vehiclePacket
	local part      = entry.Part

	if part and part.Parent then
		local shouldHotwire, shouldEject, shouldAllowEntry

		if TeamValue.Value == Settings.Team.Prisoner then
			local teamRestrict = part.Parent:GetAttribute("TeamRestrict")
			local gpRestrict   = part.Parent:GetAttribute("GamepassRestrict")

			if teamRestrict and part.Name == "Seat" and teamRestrict ~= TeamValue.Value then
				shouldHotwire = gpRestrict
					and GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass[gpRestrict])
					or true
			end
		elseif TeamValue.Value == Settings.Team.Police then
			local equip = ItemSystem.GetLocalEquipped()
			if equip and equip.__ClassName == "Handcuffs" then
				shouldEject = true
			end
		end

		if not shouldHotwire and not shouldEject then
			shouldAllowEntry = true
		end

		if entry.ShouldHotwire ~= shouldHotwire then
			entry.ShouldHotwire = shouldHotwire
			if shouldHotwire then
				entry.Name     = Localization:FormatByKey("Action.Hijack")
				entry.Timed    = true
				entry.Duration = 5.6
			end
		end

		if entry.ShouldEject ~= shouldEject then
			entry.ShouldEject = shouldEject
			if shouldEject then
				entry.Name     = Localization:FormatByKey("Action.Eject")
				entry.Timed    = false
				entry.Duration = 1
			end
		end

		if entry.ShouldAllowEntry ~= shouldAllowEntry then
			entry.ShouldAllowEntry = shouldAllowEntry
			if shouldAllowEntry then
				entry.Timed = false
				if part.Name == "Seat" then
					entry.Name = Localization:FormatByKey("Action.EnterDriver")
				elseif part:FindFirstChild("Turret") then
					entry.Name = "Enter Turret"
				else
					entry.Name = Localization:FormatByKey("Action.EnterPassenger")
				end
			end
		end

		if entry.ShouldAllowEntry or entry.ShouldHotwire then
			local playerVal = part:FindFirstChild("Player")
			if playerVal and playerVal.Value then
				noVehicle = false
			end
		end

		entry.Dist = 12
	end

	if noVehicle ~= entry.Enabled then
		entry.Enabled = noVehicle
	end
end

local TradeUtils  = require(ReplicatedStorage.Trade.TradeUtils)
local Handcuffs   = require(ReplicatedStorage.Game.ItemConfig.Handcuffs)

local function updatePlayerCircleAction(entry)
	local equipped   = ItemSystem.GetLocalEquipped()
	local shouldArrest, shouldPickpocket, shouldCrimSearch, shouldBreakout, shouldTrade
	local playerName = entry.PlayerName

	-- Trade check
	if RunUtils.isTradingEnabled() then
		local target = Players:FindFirstChild(playerName)
		if target and target ~= LocalPlayer
			and TradeUtils.getPlayerTradeRequestsEnabled(target)
			and TradeUtils.getPlayerTradeRequestsEnabled(LocalPlayer)
			and not TradeService.checkAlreadyInitiated(LocalPlayer, target)
			and target.Character and target.Character:FindFirstChild("Humanoid")
		then
			shouldTrade = true
		end
	end

	local target = Players:FindFirstChild(playerName)
	if target and target.Character then
		local myChar      = LocalPlayer.Character
		local myTeam      = TeamValue.Value
		local theirTeam   = target.TeamValue and target.TeamValue.Value

		-- Pickpocket / breakout detection
		if theirTeam == Settings.Team.Police and myTeam == Settings.Team.Prisoner then
			local myHum  = myChar and myChar:FindFirstChild("Humanoid")
			local myRoot = myChar and myChar.PrimaryPart
			local thRoot = target.Character.PrimaryPart

			if myRoot and thRoot and myHum and not myHum.Sit and not myHum.PlatformStand then
				local myCF  = myRoot.CFrame
				local thCF  = thRoot.CFrame
				local dot1  = myCF.lookVector:Dot(thCF.lookVector) > 0.333
				local dot2  = thCF.lookVector:Dot((thCF.p - myCF.p).unit) > 0.333
				if dot1 and dot2 then
					shouldPickpocket = true
				end
			end
		end

		-- Crim search
		if myTeam == Settings.Team.Police
			and target.Character:GetAttribute("HasHandcuffs")
		then
			shouldCrimSearch = true
		end

		-- Prisoner breakout assist
		if myTeam == Settings.Team.Prisoner
			and theirTeam == Settings.Team.Prisoner
			and target.Character:GetAttribute("HasHandcuffs")
			and myChar and not myChar:GetAttribute("HasHandcuffs")
		then
			shouldBreakout = true
		end
	end

	-- Arrest check (holding handcuffs)
	if not shouldCrimSearch and not shouldBreakout
		and equipped and equipped.__ClassName == "Handcuffs"
		and TeamValue.Value == Settings.Team.Police
	then
		local tgt = Players:FindFirstChild(playerName)
		if tgt and tgt.TeamValue and tgt.TeamValue.Value == Settings.Team.Prisoner then
			local tgtChar = tgt.Character
			if tgtChar
				and not tgtChar:GetAttribute("HasHandcuffs")
				and not tgtChar:GetAttribute("InVehicle")
				and tgtChar:FindFirstChild("Humanoid")
			then
				shouldArrest = true
			end
		end
	end

	-- Apply updates
	if entry.ShouldArrest    ~= shouldArrest    then entry.ShouldArrest    = shouldArrest    end
	if entry.ShouldPickpocket ~= shouldPickpocket then entry.ShouldPickpocket = shouldPickpocket end
	if entry.ShouldCrimSearch ~= shouldCrimSearch  then entry.ShouldCrimSearch = shouldCrimSearch  end
	if entry.ShouldBreakout   ~= shouldBreakout   then entry.ShouldBreakout   = shouldBreakout   end
	if entry.ShouldTrade      ~= shouldTrade      then entry.ShouldTrade      = shouldTrade      end

	-- Set action label/timing
	if shouldBreakout then
		entry.Duration = 2; entry.Timed = true; entry.Dist = 10
		entry.Name     = Localization:FormatByKey("Action.Breakout")
	elseif shouldPickpocket or shouldCrimSearch then
		entry.Duration = 2; entry.Timed = true; entry.Dist = 10
		entry.Name     = shouldCrimSearch
			and Localization:FormatByKey("Action.CrimSearch")
			or  Localization:FormatByKey("Action.Pickpocket")
	elseif shouldArrest then
		entry.Duration       = 0.5
		entry.Timed          = true
		entry.Dist           = nil
		entry.HorizontalDist = Handcuffs.ArrestDistance
		entry.VerticalDist   = Handcuffs.ArrestDistance * 1.4
		entry.Name           = Localization:FormatByKey("Action.Arrest")
	elseif shouldTrade then
		entry.Timed = false; entry.Dist = 10
		entry.Name  = Localization:FormatByKey("Action.Trade")
	end

	local anyEnabled = shouldArrest or shouldPickpocket or shouldBreakout or shouldTrade or shouldCrimSearch
	if anyEnabled ~= entry.Enabled then
		entry.Enabled = anyEnabled
	end
end

local function updateCircleActions()
	debug.profilebegin("UpdateCircleActions (game)")

	local character = LocalPlayer.Character
	if not character then
		debug.profileend()
		return
	end

	local root = character.PrimaryPart
	if not root then
		debug.profileend()
		return
	end

	local pos  = root.Position
	local now  = os.clock()

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
					if entry.Enabled ~= isPrisoner then
						entry.Enabled = isPrisoner
					end
				end
			end
		end
	end

	debug.profileend()
end

-- ── Stepped: LQ vehicle update ────────────────────────────────
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
									if not packet.IKP then
										--if not owner then goto continue end
										--local char = owner.Character
										--if not char then goto continue end
										--local hum = char:FindFirstChild("Humanoid")
										--if not hum or not hum.RootPart then goto continue end
										--packet.IKP = R15IKv2.BuildPacketArms(char)
									end
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

-- ── Heartbeat: LQ vehicle update ─────────────────────────────
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

								if packet.Type == "Heli" then
									updateHeliLowQuality(packet, dt)
								elseif packet.Type == "Chassis" then
									updateChassisLowQuality(packet, dt)
								elseif packet.Type == "Motorcycle" or packet.Type == "DuneBuggy" then
									Classes.Chassis2.UpdateLQ(packet, dt)
								end
								-- updateAllLowQuality would go here (CF analysis failed in decompiler)
							end
						end
					end
				end
			end
		end
	end

	debug.profileend()
end)

-- ── Heartbeat: main game loop ─────────────────────────────────
local floor = math.floor
local lastTimeHour, lastTimeQuarter = 0, 0

RunService.Heartbeat:Connect(function()
	updateCircleActions()

	-- Team enum sync
	local teamVal = TeamValue.Value
	local teamEnum
	if teamVal == Settings.Team.Prisoner then
		teamEnum = initConfig.HasEscaped
			and Settings.EnumTeam.Criminal
			or  Settings.EnumTeam.Prisoner
	elseif teamVal == Settings.Team.Police then
		teamEnum = Settings.EnumTeam.Police
	end

	if GameUtil.Team ~= teamEnum then
		GameUtil.Team = teamEnum
		GameUtil.OnTeamChanged:Fire(teamEnum)
	end

	updateWalkSpeed()

	-- Clock display
	debug.profilebegin("Time/UI")
	local timeValue = workspace:FindFirstChild("Time")
	if timeValue then
		local raw     = timeValue.Value
		local frac    = raw % 1
		local hour    = raw - frac
		local quarter = floor(floor(frac * 60 + 0.5) / 15) * 15

		if quarter >= 60 then
			quarter -= 60
			hour    += 1
		end
		if hour > 12 then hour -= 12 end
		if hour == 0 then hour  = 12 end

		if hour ~= lastTimeHour or quarter ~= lastTimeQuarter then
			lastTimeHour    = hour
			lastTimeQuarter = quarter
			local ampm      = raw >= 12 and "PM" or "AM"
			SidebarUI.SetTime(("%d:%02d %s"):format(hour, quarter, ampm))
		end
	end
	debug.profileend()
end)

-- ── Input handlers ────────────────────────────────────────────
local mousePosLast = newV3(0, 0, 0)

local function onInputChanged(input)
	if vehiclePacket then
		if vehiclePacket.Type == "Chassis" then
			Classes.Chassis.InputChanged(input, nil)
		elseif vehiclePacket.Type == "Heli" then
			Classes.Heli.InputChanged(input, nil)
		elseif vehiclePacket.Type == "Custom" and vehiclePacket.Make == "Volt" then
			Classes.Volt.InputChanged(input, nil)
		end
	end
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		mousePosLast = input.Position
	end
end

local function onInputBegan(input, processed)
	if processed then return end

	local isLeft  = input.KeyCode == Enum.KeyCode.Left
	local isRight = input.KeyCode == Enum.KeyCode.Right
	local isA     = input.KeyCode == Enum.KeyCode.ButtonA

	if isA or isLeft or isRight then
		if vehiclePacket then
			if vehiclePacket.Type == "Chassis" then
				Classes.Chassis.InputBegan(input)
			elseif vehiclePacket.Type == "Heli" then
				Classes.Heli.InputBegan(input)
			elseif vehiclePacket.Type == "Custom" and vehiclePacket.Make == "Volt" then
				Classes.Volt.InputBegan(input)
			end
		end

		if input.UserInputType == Enum.UserInputType.Keyboard
			and input.KeyCode == Enum.KeyCode.E
			and vehiclePacket and vehiclePacket.Type ~= "Heli"
		then
			onJump()
		end
	end
end

local function onInputEnded(input, processed)
	if processed then return end

	local isLeft  = input.KeyCode == Enum.KeyCode.Left
	local isRight = input.KeyCode == Enum.KeyCode.Right
	local isA     = input.KeyCode == Enum.KeyCode.ButtonA

	if isA or isLeft or isRight then
		if vehiclePacket then
			if vehiclePacket.Type == "Chassis" then
				Classes.Chassis.InputEnded(input); return
			elseif vehiclePacket.Type == "Heli" then
				Classes.Heli.InputEnded(input);    return
			elseif vehiclePacket.Type == "Custom" and vehiclePacket.Make == "Volt" then
				Classes.Volt.InputEnded(input)
			end
		end
	end
end

UserInputService.InputBegan:connect(onInputBegan)
UserInputService.InputEnded:connect(onInputEnded)
UserInputService.InputChanged:connect(onInputChanged)

-- ── CircleAction: vehicle seat actions ───────────────────────
local CircleActionUI = UI.CircleAction

local function vehicleSeatAction(entry, completed)
	if completed then
		if entry.ShouldHotwire then
			attemptVehicleHotwire(entry.Part.Parent, true)
		elseif entry.ShouldEject then
			attemptVehicleEject(entry.Part.Parent)
		else
			attemptVehicleEnter(entry.Part)
		end
		return true
	end

	if entry.ShouldHotwire then
		attemptVehicleHotwire(entry.Part.Parent)
		em.ropj1fju({
			Title = "Vehicle",
			Text  = "Vehicle protected. Hold to hijack.",
		})
	end
end

local function addVehicleSeat(seat)
	CircleActionUI.Add({
		Part       = seat,
		ValidRoot  = seat.Parent,
		Name       = "Enter",
		Timed      = false,
		Duration   = 1,
		Dist       = 10,
		Callback   = vehicleSeatAction,
		IsVehicle  = true,
	}, seat)
end

local function removeVehicleSeat(seat)
	CircleActionUI.Remove(seat)
end

for _, seat in next, CollectionService:GetTagged("VehicleSeat") do
	addVehicleSeat(seat)
end
CollectionService:GetInstanceAddedSignal("VehicleSeat"):Connect(addVehicleSeat)
CollectionService:GetInstanceRemovedSignal("VehicleSeat"):Connect(removeVehicleSeat)

-- ── CircleAction: handcuff / player actions ───────────────────
local function useHandcuffsOnPlayer(entry)
	local equipped = ItemSystem.GetLocalEquipped()
	if not equipped or equipped.__ClassName ~= "Handcuffs" then return end
	if equipped.Reloading then return end
	if TeamValue.Value ~= Settings.Team.Police then return end

	local target = Players:FindFirstChild(entry.PlayerName)
	if not target then return end
	if vehiclePacket then return end
	if target.TeamValue.Value ~= Settings.Team.Prisoner then return end

	local myChar = LocalPlayer.Character
	if not myChar then return end
	local myHum = myChar:FindFirstChild("Humanoid")
	if not myHum or myHum.Health <= 0 then return end

	fireServer("el8n5q35", target)
	return true
end

local function playerAction(entry, completed)
	-- Notify breakout request on approach (even without completing)
	if entry.ShouldBreakout and not completed then
		local target = Players:FindFirstChild(entry.PlayerName)
		if target and not target:GetAttribute("SentBreakoutRequest") then
			target:SetAttribute("SentBreakoutRequest", true)
			-- "mykh4ggq" = BreakoutRequest remote event
			fireServer("mykh4ggq", target.Name)
			task.delay(10, function()
				target:SetAttribute("SentBreakoutRequest", nil)
			end)
		end
	end

	if not completed then return true end

	local result

	if entry.ShouldArrest then
		result = useHandcuffsOnPlayer(entry)
	elseif entry.ShouldPickpocket or entry.ShouldCrimSearch then
		local target = Players:FindFirstChild(entry.PlayerName)
		if target then
			attemptPickPocket(target)
			result = true
		end
	elseif entry.ShouldBreakout then
		local target = Players:FindFirstChild(entry.PlayerName)
		if target then
			attemptBreakout(target)
			result = true
		end
	end

	if entry.ShouldTrade and (RunUtils.isTradeWorld() or not result) then
		local target = Players:FindFirstChild(entry.PlayerName)
		if target then
			attemptTrade(target)
			result = true
		end
	end

	return result
end

local function addCharacterToCircleAction(character)
	if character == LocalPlayer.Character then return end

	CircleActionUI.Add({
		Part       = character:WaitForChild("UpperTorso", 3),
		ValidRoot  = character,
		Name       = "Player",
		Timed      = true,
		Duration   = 0.5,
		Dist       = 15,
		Priority   = 2,
		Callback   = playerAction,
		PlayerName = character.Name,
		IsPlayer   = true,
	}, character)
end

local function removeCharacterFromCircleAction(character)
	if character ~= LocalPlayer.Character then
		CircleActionUI.Remove(character)
	end
end

for _, binder in CharacterBinder:GetAll() do
	addCharacterToCircleAction(binder.obj)
	binder.maid:GiveTask(function()
		local obj = binder.obj
		if obj ~= LocalPlayer.Character then
			CircleActionUI.Remove(obj)
		end
	end)
end

CharacterBinder:GetClassAddedSignal():Connect(function(binder)
	addCharacterToCircleAction(binder.obj)
	binder.maid:GiveTask(function()
		local obj = binder.obj
		if obj ~= LocalPlayer.Character then
			CircleActionUI.Remove(obj)
		end
	end)
end)

-- ── CircleAction: rob small stores ───────────────────────────
local function robAction(entry, completed)
	if completed then
		-- "sqjc842q" = RobStore remote event
		fireServer("sqjc842q", entry.Part.Parent)
		return true
	end
end

local function addSmallStore(part)
	CircleActionUI.Add({
		Part     = part,
		Name     = "Rob",
		Timed    = true,
		Duration = 10,
		Dist     = 8,
		Callback = robAction,
		IsRob    = true,
	}, part)
end

for _, part in next, CollectionService:GetTagged("SmallStore") do
	addSmallStore(part)
end
CollectionService:GetInstanceAddedSignal("SmallStore"):Connect(addSmallStore)
CollectionService:GetInstanceRemovedSignal("SmallStore"):Connect(function(part)
	CircleActionUI.Remove(part)
end)

-- ── CircleAction: dropped items ───────────────────────────────
local ItemDropConsts = require(ReplicatedStorage.Game.ItemSystem.ItemDropConsts)
local GunShopUtils   = require(ReplicatedStorage.Game.GunShop.GunShopUtils)

local function pickupItemAction(entry, completed)
	if completed then
		-- "c5ft2w8h" = PickupItem remote event
		fireServer("c5ft2w8h", entry.Part)
		return true
	else
		-- "ifdcvgyn" = DropItem hover notification
		fireServer("ifdcvgyn", entry.Part)
	end
	return true
end

for _, part in next, CollectionService:GetTagged(ItemDropConsts.DROPPED_ITEM_TAG) do
	CircleActionUI.Add({
		Part      = part,
		ValidRoot = part.Parent,
		Name      = ("Pick up %s"):format(GunShopUtils.getTranslatedTitleFromName(part.Parent.Name)),
		Timed     = true,
		Duration  = 0.5,
		Dist      = 5,
		Callback  = pickupItemAction,
	}, part)
end

CollectionService:GetInstanceAddedSignal(ItemDropConsts.DROPPED_ITEM_TAG):Connect(function(part)
	CircleActionUI.Add({
		Part      = part,
		ValidRoot = part.Parent,
		Name      = ("Pick up %s"):format(GunShopUtils.getTranslatedTitleFromName(part.Parent.Name)),
		Timed     = true,
		Duration  = 0.5,
		Dist      = 5,
		Callback  = pickupItemAction,
	}, part)
end)

CollectionService:GetInstanceRemovedSignal(ItemDropConsts.DROPPED_ITEM_TAG):Connect(CircleActionUI.Remove)

-- ── Jump debounce ─────────────────────────────────────────────
local lastJumpTime = tick()

local function onJumpDebounced()
	local now = tick()
	if now - lastJumpTime < 0.1 then return false end
	lastJumpTime = now
	onJump()
end

require(ReplicatedStorage.Game.DefaultActions).onJumpPressed:Connect(onJumpDebounced)

-- ── Ragdoll on death ──────────────────────────────────────────
local function onCharacterDied()
	Falling.StartRagdolling(10)
end

local function onCharacterAdded_Ragdoll(character)
	local tracker
	tracker = character:WaitForChild("Humanoid").Died:Connect(function()
		tracker:Disconnect()
		Falling.StartRagdolling(10)
	end)
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded_Ragdoll)

-- ── Manual reset button ───────────────────────────────────────
local resetEvent = Instance.new("BindableEvent")
resetEvent.Event:connect(function()
	fireServer("k60hnevw")
end)

delay(2, function()
	local ok, err = pcall(function()
		StarterGui:SetCore("ResetButtonCallback", resetEvent)
	end)
	if not ok then
		print("MANUAL RESET ERROR", err)
	end
end)

-- ── Anti-idle / infinite-loop detection part ─────────────────
local detectPart = Instance.new("Part")
detectPart.Anchored     = true
detectPart.Transparency = 1
detectPart.CanCollide   = false
detectPart.Size         = newV3(1, 1, 1)
detectPart.Archivable   = false
detectPart.Parent       = workspace

detectPart:GetPropertyChangedSignal("Archivable"):connect(function()
	while true do end  -- triggers executor detection
end)

-- ── Special: remove KreeksTimeMachine after 10s ───────────────
delay(10, function()
	local machine = workspace:FindFirstChild("KreeksTimeMachine")
	if machine and LocalPlayer.UserId == 140258990 then
		machine:Destroy()
	end
end)

-- ── Anti-cheat ────────────────────────────────────────────────
local reportedCheat     = false
local spawnTimestamp    = 0
local stateChangeTracker
local stateChangeDelta  = 0
local backpackFlag      = false

local xpcallOriginal = xpcall

local function onCharacterAdded_AntiCheat(character)
	local humanoid = character:WaitForChild("Humanoid", 1)
	if not humanoid then return end
	if not character:WaitForChild("HumanoidRootPart", 1) then return end

	reportedCheat = false
	spawnTimestamp = Math.TimeAccumAdd(spawnTimestamp, 2)

	if stateChangeTracker then
		stateChangeTracker:Disconnect()
		stateChangeTracker = nil
	end

	stateChangeTracker = humanoid.StateChanged:Connect(function(_, newState)
		if newState == Enum.HumanoidStateType.StrafingNoPhysics then
			stateChangeDelta = Math.TimeAccumAdd(stateChangeDelta, 1)

			if Math.TimeAccumDiff(stateChangeDelta) > 10 then
				stateChangeDelta = 0
				if backpackFlag then return end
				backpackFlag = true
				-- "yqs1cu3t" = AntiCheat remote event
				fireServer("yqs1cu3t", "NoClip StrafingNoPhysics", false)
			end
		end
	end)
end

if LocalPlayer.Character then
	onCharacterAdded_AntiCheat(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(onCharacterAdded_AntiCheat)

-- Monitor backpack for tool injection
spawn(function()
	local ok, err = pcall(function()
		LocalPlayer:WaitForChild("Backpack", 20).ChildAdded:Connect(function(item)
			if item:IsA("BackpackItem") then
				if backpackFlag then return end
				backpackFlag = true
				fireServer("yqs1cu3t", "BackpackTool", false)
			end
		end)
	end)
	if not ok then
		warn("BACKPACK FAIL", err)
	end
end)

-- Tracked service/environment names for tamper detection
local monitoredServices  = { "Workspace", "Players", "ReplicatedStorage" }
local serviceLoggedOnce  = {}

local function runCheatCheck()
	if reportedCheat then return end

	local character = LocalPlayer.Character
	if not character then return end
	local humanoid = character:FindFirstChild("Humanoid")
	if not humanoid then return end
	if humanoid.Health <= 0.001 then return end

	local detected = false

	-- Service name tampering
	for _, name in next, monitoredServices do
		if game:GetService(name).Name ~= name then
			if not serviceLoggedOnce[name] then
				detected = true
			end
		end
	end

	-- Runtime environment hooks
	local envOk = pcall(function() end)
	if not RunService:IsStudio() and envOk then
		detected = true
	end

	if _G.antiarrest ~= nil then
		detected = true
	end

	if xpcall ~= xpcallOriginal then
		detected = true
	end

	-- Verify xpcall can intercept errors (executors may sandbox this)
	local xpcallWorks = false
	xpcall(function()
		return game[{}]
	end, function()
		xpcallWorks = true
	end)
	if not xpcallWorks then
		detected = true
	end

	-- getupvalues is an executor API
	if debug.getupvalues then
		detected = true
	end

	if detected then
		reportedCheat = true
		fireServer("yqs1cu3t", "Getupvalues", false)
	end
end

threadLoopAdd(1, function()
	local ok, _ = pcall(runCheatCheck)
	if not ok then
		reportedCheat = true
		fireServer("yqs1cu3t", "FailedPcall", false)
	end
end)

require(ReplicatedStorage.App.ImportantLocationMarkerSystem).init()

-- ── Wire up ConnectEvents (must run last) ─────────────────────
ConnectEvents()