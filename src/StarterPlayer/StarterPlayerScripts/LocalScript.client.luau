local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local isStudio = RunUtils.isStudio()
local UserInputService = game:GetService("UserInputService")
game:GetService("GuiService")
local SoundService = game:GetService("SoundService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local R15IKv2 = require(ReplicatedStorage.Module.R15IKv2)
local UI = require(ReplicatedStorage.Module.UI)
local CollectionService = game:GetService("CollectionService")
local Joint = require(ReplicatedStorage.Std.Joint)
local Math = require(ReplicatedStorage.Module.Math)
local AlexParticles = require(ReplicatedStorage.Module.AlexParticles)
local AlexWM = require(ReplicatedStorage.Module.AlexWM)
local Settings = require(ReplicatedStorage.Resource.Settings)
local StarterGui = game:GetService("StarterGui")
local Localization = require(ReplicatedStorage.Module.Localization)
local Raycast = require(ReplicatedStorage.Std.Raycast)
local Audio = require(ReplicatedStorage.Std.Audio)
local GameUtil = require(ReplicatedStorage.Game.GameUtil)
local RunConsts = require(ReplicatedStorage.App.RunConsts)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local Binder = require(ReplicatedStorage.Std.Binder)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local PartUtils = require(ReplicatedStorage.Std.PartUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local GameSettingsService = require(ReplicatedStorage.GameSettings.GameSettingsService)
local gameSettingType = require(ReplicatedStorage.GameSettings.gameSettingType)
local TradeService = require(ReplicatedStorage.Trade.TradeService)
local Handcuffs = require(ReplicatedStorage.Game.ItemConfig.Handcuffs)
local TradeUtils = require(ReplicatedStorage.Trade.TradeUtils)
local MovementConsts = require(ReplicatedStorage.Movement.MovementConsts)
require(ReplicatedStorage.HumanoidUnload.HumanoidUnloadUtils)
require(ReplicatedStorage.Game.Destructible.DestructibleUtils)
local StreamingHelperUtils = require(ReplicatedStorage.App.StreamingHelperUtils)
local ItemUtils = require(ReplicatedStorage.App.ItemUtils)
local TextChatService = game:GetService("TextChatService")
local RichTextUtils = require(ReplicatedStorage.Std.RichTextUtils)
local PlayerModuleService = require(ReplicatedStorage.PlayerModule.PlayerModuleService)
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local EnvironmentConsts = require(ReplicatedStorage.Environment.EnvironmentConsts)
local EnvironmentUtils = require(ReplicatedStorage.Environment.EnvironmentUtils)
require(ReplicatedStorage.Std.RateLimiter)
local HapticEffect = require(ReplicatedStorage.App.HapticEffect)
local RegionUtils = require(ReplicatedStorage.Std.Region.RegionUtils)
local ConstraintUtils = require(ReplicatedStorage.Std.ConstraintUtils)
local CFrameNew = CFrame.new
local Angles = CFrame.Angles
local Vector3New = Vector3.new
local zeroOriginCFrame = CFrameNew(0, 0, 0)
local sin = math.sin
local floor = math.floor
local abs = math.abs
local log = math.log
local max = math.max
if not RunUtils.isStudio() then
	print("Build:", "22 Apr @ 08:27 PM EDT @0ec1e2e")
end
local vector = waitForChild(ReplicatedStorage, "GenericRemoteEvent", 30):catch(warn)
local eventMap, eventBridge, EventFireServer, ConnectEvents
do
	local remoteEvent = nil
	eventMap = {}
	for i = 1, 10 do
		local RemoteEvent = Instance.new("RemoteEvent")
		RemoteEvent.Name = Math.GUID()
		RemoteEvent.Parent = ReplicatedStorage.Resource
	end
	local remoteEventCache = nil
	eventBridge = {}
	local FireServer = Instance.new("RemoteEvent").FireServer
	EventFireServer = function(p1, ...)
		FireServer(remoteEvent, remoteEventCache and remoteEventCache[p1] or p1, ...)
	end
	function eventBridge.FireServer(p1, p2, ...)
		return EventFireServer(p2, ...)
	end
	function eventMap.yeo69ls9(p1)
		eventMap.hems = true
		remoteEventCache = p1
	end
	local function OnClientEvent(p1, ...)
		assert(eventMap[p1], p1)(...)
	end
	ConnectEvents = function()
		local result, isInitialized = remoteEventCache:await()
		if not isInitialized then
			error("Bad error... could not find `GenericGameEvent`")
		end
		isInitialized.Name = Math.GUID()
		remoteEvent = isInitialized
		isInitialized.OnClientEvent:Connect(OnClientEvent)
	end
end
StarterGui.ResetPlayerGuiOnSpawn = false
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TeamValue = LocalPlayer:WaitForChild("TeamValue")
local isEnabled, cframe, cframe, cframe, PlayerUtils, InventoryItemUtils, InventoryItemSystem, ItemSystem, ThreadLoopAdd
do
	local function GetScreenGui(p1)
		local isEnabled = PlayerGui:FindFirstChild(p1)
		if not isEnabled then
			local isEnabled = ReplicatedStorage.StarterGui:FindFirstChild(p1):Clone()
			isEnabled.Parent = PlayerGui
			isEnabled = isEnabled
		end
		return isEnabled
	end
	local MainGui = PlayerGui:FindFirstChild("MainGui")
	if not MainGui then
		MainGui = ReplicatedStorage.StarterGui:FindFirstChild("MainGui"):Clone()
		MainGui.Parent = PlayerGui
	end
	isEnabled = MainGui
	local ProductGui = PlayerGui:FindFirstChild("ProductGui")
	if not ProductGui then
		ProductGui = ReplicatedStorage.StarterGui:FindFirstChild("ProductGui"):Clone()
		ProductGui.Parent = PlayerGui
	end
	cframe = ProductGui
	local Particles = PlayerGui:FindFirstChild("Particles")
	if not Particles then
		Particles = ReplicatedStorage.StarterGui:FindFirstChild("Particles"):Clone()
		Particles.Parent = PlayerGui
	end
	cframe = Particles
	local DeathGui = PlayerGui:FindFirstChild("DeathGui")
	if not DeathGui then
		DeathGui = ReplicatedStorage.StarterGui:FindFirstChild("DeathGui"):Clone()
		DeathGui.Parent = PlayerGui
	end
	cframe = DeathGui
	UI.CircleAction.Frame = isEnabled.CircleAction
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
	PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
	PlayerUtils.init()
	InventoryItemUtils = require(ReplicatedStorage.Inventory.InventoryItemUtils)
	InventoryItemSystem = require(ReplicatedStorage.Inventory.InventoryItemSystem)
	ItemSystem = require(ReplicatedStorage.Game.ItemSystem.ItemSystem)
	ItemSystem.Init({
		em = configTable,
		Event = eventBridge
	})
	require(ReplicatedStorage.Game.AmmoGui).Init({
		GetScreenGui = GetScreenGui
	})
	local function childAdded(p1)
		if not p1:GetAttribute("Required") then
			p1:SetAttribute("Required", true)
			local isEnabled = require(p1)
			if rawget(isEnabled, "Init") then
				isEnabled.Init({
					Event = eventBridge,
					em = configTable,
					ScreenGui = isEnabled
				})
			end
			ItemSystem.Register(isEnabled)
		end
	end
	for v13, targetPlayer in ReplicatedStorage.Game.Item:GetChildren() do
		childAdded(v14)
	end
	ReplicatedStorage.Game.Item.ChildAdded:Connect(childAdded)
	require(ReplicatedStorage.Game.ItemSystem.ItemCamera).Init()
	require(ReplicatedStorage.Game.ItemSkin.ItemSkin).Init({
		Event = eventBridge,
		em = configTable
	})
	require(ReplicatedStorage.Game.ItemSkin.UI.UI).Init()
	local PoliceReportUI = require(ReplicatedStorage.Game.PoliceReportUI.PoliceReportUI)
	PoliceReportUI.Init()
	function configTable.b1wty5u4(p1)
		PoliceReportUI.Display(p1)
	end
	local configTable = {}
	ThreadLoopAdd = function(p1, p2)
		table.insert(configTable, {
			configTable = 0,
			i = p1,
			c = p2
		})
	end
	local cframe = os.clock()
	local function Stepped()
		local isEnabled = os.clock()
		local isEnabled = isEnabled - cframe
		cframe = isEnabled
		debug.profilebegin("Thread Loop")
		for i = 1, #configTable do
			local func = configTable[i]
			if isEnabled - func.configTable > func.i then
				func.configTable = isEnabled
				func.c(isEnabled, isEnabled)
			end
		end
		debug.profileend()
	end
	RunService.Heartbeat:Connect(Stepped)
end
local windowGroup, CharacterBinder, CharacterUtil, eventMap, currentVehiclePacket, nitroState, cameraTargetOffset, isSprinting, isCrawling, isStunned, EzUtils, gameContext, VehicleUtils, VehicleStateBinder, Classes, PromptPurchase
do
	local function HasPerm(p1)
		local isEnabled = false
		local isEnabled, func = pcall(function()
			if p1.Group then
				isEnabled = true
				isEnabled = isEnabled and LocalPlayer:IsInGroup(p1.Group)
				if p1.Rank then
					isEnabled = isEnabled and LocalPlayer:GetRankInGroup(p1.Group) >= p1.Rank
				end
			end
			if not isEnabled and p1.Id then
				isEnabled = true
				local func = isEnabled
				if func then
					func = p1.Id[tostring(LocalPlayer.UserId)]
				end
				isEnabled = func
			end
		end)
		if not isEnabled then
			print(func)
		end
		return isEnabled and isEnabled
	end
	windowGroup = AlexWM.MakeWindowGroup()
	CharacterBinder = require(ReplicatedStorage.App.CharacterBinder)
	CharacterBinder:Start()
	CharacterUtil = require(ReplicatedStorage.Game.CharacterUtil)
	require(ReplicatedStorage.Inventory.InventorySystem).init()
	local HotbarSystem = require(ReplicatedStorage.Hotbar.HotbarSystem)
	HotbarSystem.init()
	GameUtil.OnTeamChanged:Connect(function(p1)
		HotbarSystem.setColor(Settings.TeamColor[p1])
	end)
	require(ReplicatedStorage.Hotbar.HotbarItemBinder):GetClassAddedSignal():Connect(function()
		HotbarSystem.setColor(Settings.TeamColor[GameUtil.Team])
	end)
	Binder.new("BarbedWireClient", function(p1)
		local maidInstance = Maid.new()
		local lastTouchTime = 0
		maidInstance:GiveTask(p1.Touched:Connect(function(p12)
			local Character = LocalPlayer.Character
			if Character and p12.Parent == Character then
				local Humanoid = Character:FindFirstChild("Humanoid")
				if Humanoid then
					if Humanoid:GetLimb(p12) == Enum.Limb.Unknown then
						return
					end
					local currentTime = os.clock()
					if not (currentTime - lastTouchTime < 0.3) then
						lastTouchTime = currentTime
						local damageAmount = p1:GetAttribute("BarbedWireDamage")
						local damageValue
						if damageAmount then
							assert(typeof(damageAmount) == "number")
							damageValue = damageAmount
						else
							damageValue = 30
						end
						eventBridge:FireServer("xe6v1us6", damageValue, "Wire")
					end
				end
			end
		end))
		return maidInstance
	end):Start()
	eventMap = {}
	currentVehiclePacket = nil
	nitroState = {
		VehiclesOwned = {},
		VehiclesRented = {},
		Nitro = 50,
		NitroLastMax = 50
	}
	cameraTargetOffset = Vector3.new(0, 0, 0)
	isSprinting = false
	isCrawling = false
	GameUtil.Schedule = "Yard"
	isStunned = false
	EzUtils = require(ReplicatedStorage.EzUi.EzUtils)
	gameContext = {
		MainWindowGroup = windowGroup,
		ScreenGui = isEnabled,
		ProductGui = cframe,
		Event = eventBridge,
		em = configTable,
		UI = UI,
		SelectIfGamepad = function(p1)
			EzUtils.selectIfGamepad(p1)
		end,
		GetVehiclePacket = function()
			return currentVehiclePacket
		end
	}
	VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
	VehicleUtils.Init({
		GetVehiclePacket = gameContext.GetVehiclePacket,
		em = eventMap,
		Event = eventBridge,
		nitroState = nitroState
	})
	VehicleStateBinder = require(ReplicatedStorage.Game.VehicleStateBinder)
	VehicleStateBinder:Start()
	Classes = VehicleUtils.Classes
	Classes.Chassis = require(ReplicatedStorage.Module.AlexChassis)
	Classes.Chassis.init({
		ScreenGui = isEnabled
	})
	Classes.Chassis.SetEvent(eventBridge)
	Classes.Chassis2 = require(ReplicatedStorage.Module.AlexChassis2)
	Classes.Chassis2.SetEvent(eventBridge)
	Classes.Volt = require(ReplicatedStorage.Game.Vehicle.Volt)
	Classes.Volt.Init({
		Event = eventBridge,
		em = configTable
	})
	Classes.Tank = require(ReplicatedStorage.Tank.TankService)
	Classes.Tank.init()
	local passPromptCounter = 0
	PromptPurchase = function(p1)
		local PassId = p1.PassId
		local nextCounter = passPromptCounter + 1
		passPromptCounter = nextCounter
		if p1.OldPassId then
			MarketplaceService:PromptPurchase(LocalPlayer, p1.OldPassId)
		else
			MarketplaceService:PromptGamePassPurchase(LocalPlayer, PassId)
		end
		cframe.Gamepass.ContainerFrame.TextLabel.Text = p1.Text
		task.delay(0.4, function()
			if passPromptCounter == nextCounter then
				cframe.Gamepass.Visible = true
			end
		end)
	end
	local function PromptGamePassPurchaseFinished(p1, p2, p3)
		passPromptCounter = passPromptCounter + 1
		cframe.Gamepass.Visible = false
	end
	MarketplaceService.PromptGamePassPurchaseFinished:Connect(PromptGamePassPurchaseFinished)
	MarketplaceService.PromptPurchaseFinished:Connect(PromptGamePassPurchaseFinished)
end
function configTable.n4fjwklv(p1)
	PromptPurchase(p1)
end
local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
GamepassSystem.Init()
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
GamepassUtils.Init({
	PromptPurchase = PromptPurchase
})
gameContext.PromptPurchase = PromptPurchase
local Notification = require(ReplicatedStorage.Game.Notification)
Notification.Init({
	Event = eventBridge,
	em = configTable
})
local SidebarUI = require(ReplicatedStorage.Game.SidebarUI)
SidebarUI.Init({
	Event = eventBridge,
	em = configTable
})
require(ReplicatedStorage.GameAnalytics).initClient()
local DefaultActions = require(ReplicatedStorage.Game.DefaultActions)
require(ReplicatedStorage.CmdrExt.CmdrExtSystem).init()
local Time = require(ReplicatedStorage.Module.Time)
Time.Init()
require(ReplicatedStorage.Module.Confirmation).Init({
	Event = eventBridge,
	em = configTable
})
require(ReplicatedStorage.Game.DisplayDamage).init()
require(ReplicatedStorage.Game.CharacterAnim).init()
require(ReplicatedStorage.Module.NetSync).Init({
	Event = eventBridge,
	em = configTable
})
require(ReplicatedStorage.Game.OwnedPart.OwnedPartSystem).init()
require(ReplicatedStorage.Game.TrainSystem).Init({
	Event = eventBridge,
	em = configTable
})
require(ReplicatedStorage.Game.TrackSwitch).Init({
	Event = eventBridge,
	em = configTable
})
Classes.Heli = require(ReplicatedStorage.Game.Vehicle.Heli)(gameContext)
require(ReplicatedStorage.Game.Museum)(gameContext, ItemSystem)
require(ReplicatedStorage.Game.L18n)({
	ScreenGui = isEnabled
})
require(ReplicatedStorage.Game.Level2.LevelSystem).init()
require(ReplicatedStorage.Game.TurbineSystem).init()
require(ReplicatedStorage.AirDrop.BriefcaseBinder):Start()
require(ReplicatedStorage.Plane.PlaneBinder):Start()
require(ReplicatedStorage.Game.Hologram).Init()
require(ReplicatedStorage.Game.Codes).Init({
	MainWindowGroup = v16,
	Event = eventBridge
})
require(ReplicatedStorage.Game.SecretBases).Init({
	Event = eventBridge,
	em = configTable
})
require(ReplicatedStorage.Game.Robbery.RobberyBank.RobberyBank).Init({
	Event = eventBridge,
	em = configTable
})
require(ReplicatedStorage.Jewelry.RobberyJewelry).Init({
	Event = eventBridge,
	em = configTable
})
require(ReplicatedStorage.Game.Robbery.RobberyCargoTrain).Init({
	Event = eventBridge,
	em = configTable
})
require(ReplicatedStorage.Game.Robbery.RobberyPassengerTrain).Init({
	Event = eventBridge,
	em = configTable,
	ScreenGui = isEnabled
})
require(ReplicatedStorage.Game.Robbery.RobberyCargoPlane).Init({
	Event = eventBridge,
	em = configTable,
	Team = TeamValue,
	ScreenGui = isEnabled
})
require(ReplicatedStorage.Game.Cell).Init({
	Event = eventBridge,
	em = configTable,
	ScreenGui = isEnabled
})
require(ReplicatedStorage.Game.MilitaryIsland).Init()
local VehicleSystem
do
	local JetSki = require(ReplicatedStorage.Game.VehicleSystem.JetSki)
	require(ReplicatedStorage.Game.Plane.BaseUserControlledPlane).Init()
	local Jet = require(ReplicatedStorage.Game.Plane.Jet)
	Jet.Init({
		Event = eventBridge,
		em = configTable
	})
	local Stunt = require(ReplicatedStorage.Game.Plane.Stunt)
	VehicleSystem = require(ReplicatedStorage.Game.VehicleSystem)
	VehicleSystem.Init({
		Event = eventBridge,
		em = configTable
	})
	VehicleSystem.RegisterModule(JetSki)
	VehicleSystem.RegisterModule(Jet)
	VehicleSystem.RegisterModule(Stunt)
	function configTable.orasjip0(p1, p2)
		local isEnabled, _ = VehicleSystem.WaitForVehiclePacket(LocalPlayer)
		if isEnabled == nil then
			error("No vehicle exists for LocalPlayer")
		end
		isEnabled:UpdateMissileUI(p1, p2)
	end
	local Missile = require(ReplicatedStorage.Game.Missile)
	function configTable.usqlew42(p1, p2, p3, p4)
		Missile.LaunchMissile(p1, p2, p3, p4)
	end
	require(ReplicatedStorage.Game.Robbery.PuzzleFlow).Init({
		Event = eventBridge,
		em = configTable
	})
	require(ReplicatedStorage.Game.Robbery.PowerPlant.PowerPlant).Init({
		Event = eventBridge,
		em = configTable
	})
	local JetPack = require(ReplicatedStorage.Game.JetPack.JetPack)
	JetPack.Init({
		Event = eventBridge,
		em = configTable
	})
	JetPack.Signal.OnEquipped:Connect(function()
		InventoryItemSystem.unequipAll()
	end)
	local Streetlights = require(ReplicatedStorage.Game.Streetlights)
	Streetlights.init()
	function configTable.uudh9xbm()
		Streetlights.Flicker()
	end
	function configTable.m26e2x2p(p1)
		Streetlights.SetEnabled(p1)
	end
	require(ReplicatedStorage.App.MinimapService).init()
	require(ReplicatedStorage.Game.RoadSpikeSystem).Init({
		Event = eventBridge
	})
	require(ReplicatedStorage.Game.WorldMarker.WorldMarkerSystem).init()
	require(ReplicatedStorage.Game.RobberyMarkerSystem).init()
	require(ReplicatedStorage.Game.LightningSystem).Init({
		em = configTable
	})
	require(ReplicatedStorage.Game.April2020LiveEventLoader).Init({
		Event = eventBridge,
		em = configTable
	})
	require(ReplicatedStorage.Game.Boat.Boat).Init()
	local Sloop = require(ReplicatedStorage.Game.Boat.Sloop)
	VehicleSystem.RegisterModule(Sloop)
	local Cruiser = require(ReplicatedStorage.Game.Boat.Cruiser)
	VehicleSystem.RegisterModule(Cruiser)
	if RunUtils.isMainWorld() then
		require(ReplicatedStorage.Game.BoatScenery).Init()
	end
	require(ReplicatedStorage.Game.Lighthouse).Init()
	require(ReplicatedStorage.Game.Drawbridge).Init({
		em = configTable
	})
	require(ReplicatedStorage.Game.NukeControl).Init({
		Event = eventBridge,
		em = configTable
	})
	require(ReplicatedStorage.Game.Robbery.CargoShip.CargoShipCoordinator).Init({
		Event = eventBridge,
		em = configTable
	})
	require(ReplicatedStorage.Game.Radio.RadioPlayer).Init({
		Event = eventBridge,
		em = configTable
	})
	require(ReplicatedStorage.Game.RobberyMoneyUI.RobberyMoneyUI).Init()
	require(ReplicatedStorage.Game.DuffelBag.DuffelBagBinder):Start()
	require(ReplicatedStorage.Game.GunShop.GunShopSystem).init()
	require(ReplicatedStorage.Game.GunShop.GunShopUI).init({
		Event = eventBridge,
		em = configTable
	})
	require(ReplicatedStorage.Game.ContextMessage.ContextMessageUI).init()
	require(ReplicatedStorage.Game.C4.C4System).init({
		em = configTable
	})
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
	require(ReplicatedStorage.Home.HomeItem.Fabricate.Turret).init({
		Event = eventBridge
	})
	require(ReplicatedStorage.Home.HomeItem.Fabricate["Trapped Bookshelf"]).init({
		Event = eventBridge
	})
	require(ReplicatedStorage.Home.HomeItem.Fabricate["Trapped Spikes"]).init({
		Event = eventBridge
	})
	require(ReplicatedStorage.Game.Robbery.TombRobbery.TombRobberySystem).init({
		Event = eventBridge
	})
	require(ReplicatedStorage.Game.Cart.CartSystem).init()
	require(ReplicatedStorage.Game.ProximityCamShake.ProximityCamShakeSystem).init()
	require(ReplicatedStorage.Game.ProximitySound.ProximitySoundSystem).init()
	require(ReplicatedStorage.Game.DartDispenser.DartDispenserSystem).init()
	require(ReplicatedStorage.Game.Plank.PlankSystem).init()
	require(ReplicatedStorage.Game.MilitaryTurret.MilitaryTurretSystem).init({
		Event = eventBridge
	})
	require(ReplicatedStorage.Game.Destructible.DestructibleSystem).init()
	require(ReplicatedStorage.Game.PlayerMarkerSystem).init()
	require(ReplicatedStorage.Game.TopExpBoard.TopExpBoardSystem).init()
	require(ReplicatedStorage.Game.CatalogPurchaseSystem).init()
	require(ReplicatedStorage.CCTV.CCTVService).init()
	local configTable = {}
	local configTable = {}
	local configTable = {}
	function configTable.c12ouosh(p1)
		configTable = p1
		for k, v in pairs(p1) do
			local isEnabled = GameSettingsService.getSettingByName(k)
			if isEnabled then
				if not isEnabled.noSave then
					GameSettingsService.setValue(isEnabled, v)
				end
			else
				configTable[k] = v
			end
		end
	end
	local function handleSetting(p1)
		local isEnabled = configTable[p1.name]
		if isEnabled ~= nil then
			configTable[p1.name] = nil
			if not p1.noSave then
				GameSettingsService.setValue(p1, isEnabled)
			end
		end
		p1.onChanged:Connect(function(p12)
			local isEnabled = (configTable[p1.name] or 0) + 1
			configTable[p1.name] = isEnabled
			if configTable[p1.name] ~= p12 then
				configTable[p1.name] = p12
				task.delay(0.25, function()
					if configTable[p1.name] == isEnabled then
						eventBridge:FireServer("ad9yrgu1", p1.name, p12)
					end
				end)
			end
		end)
	end
	GameSettingsService.onAdded:Connect(handleSetting)
	for i, v in ipairs(GameSettingsService.getAll()) do
		handleSetting(v)
	end
	require(ReplicatedStorage.VehicleLink.VehicleLinkBinder):Start()
	require(ReplicatedStorage.Elevator.ElevatorBinder):Start()
	require(ReplicatedStorage.Casino.CasinoService).init()
	require(ReplicatedStorage.TransportJet.TransportJetService).init()
	require(ReplicatedStorage.DamageIndicator.DamageIndicatorService).init()
	require(ReplicatedStorage.Trade.TradeService).init({
		em = configTable
	})
	if RunUtils.isTradeWorld() then
		require(ReplicatedStorage.Trade.TradeDesireService).init()
	end
	require(ReplicatedStorage.RewardSpinner.RewardSpinnerService).init()
	require(ReplicatedStorage.HyperChrome.HyperChromeService).init()
	require(ReplicatedStorage.RobberyBonus.RobberyBonusService).init({
		em = configTable
	})
	require(ReplicatedStorage.Safes.SafesService).init({
		em = configTable
	})
	require(ReplicatedStorage.GuardNPC.GuardNPCBinder):Start()
	require(ReplicatedStorage.AirDrop.AirDropService).init({
		em = configTable
	})
	require(ReplicatedStorage.App.HoldEService).init()
	require(ReplicatedStorage.TargetingIndicator.TargetingIndicatorService).init()
	require(ReplicatedStorage.Forcefield.ForcefieldService).init()
	require(ReplicatedStorage.SpawnSelection.SpawnSelectionService).init()
	require(ReplicatedStorage.Consumables.ConsumablesService).init()
	require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleService).init()
	require(ReplicatedStorage.TrackingSpotlight.TrackingSpotlightService).init()
	require(ReplicatedStorage.GameMode.GameModeService).init({
		em = configTable
	})
	require(ReplicatedStorage.DragStrip.DragStripService).init()
	require(ReplicatedStorage.App.CircleActionBinder):Start()
	require(ReplicatedStorage.Turret2.TurretService).init()
	require(ReplicatedStorage.App.OnboardTutorialService).init()
	require(ReplicatedStorage.Commerce.CommerceService).init()
	if RunUtils.isMainWorld() then
		require(ReplicatedStorage.Walmart.WalmartService).init()
	end
end
local CashBuyUI = require(ReplicatedStorage.Game.CashBuyUI)
CashBuyUI.Init({
	Event = eventBridge,
	em = configTable
})
require(ReplicatedStorage.Game.Radio.Radio).Init()
Settings.FetchProducts()
local Falling = require(ReplicatedStorage.Game.Falling)
Falling.Init({
	Event = eventBridge,
	em = configTable
})
local Paraglide = require(ReplicatedStorage.Game.Paraglide)
Paraglide.Init({
	Event = eventBridge,
	em = configTable
})
local LerpTable, PlaySound, StopSound
do
	local function comma(p1)
		local isEnabled, isEnabled, func = string.match(p1, "^([^%d]*%d)(%d*)(.-)$")
		return isEnabled .. isEnabled:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. func
	end
	local function FormatMoney(p1)
		local configTable = {}
		local cframe, vector, cframe = string.match(abs(p1), "^([^%d]*%d)(%d*)(.-)$")
		configTable[1] = cframe .. vector:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. cframe
		return if p1 >= 0 then "" else "-" .. Localization:FormatByKey("General.Cash", configTable)
	end
	LerpTable = function(p1, p2, p3)
		local configTable = {}
		for isEnabled, func in next, p2 do
			local isEnabled
			local cframe = p1[isEnabled]
			isEnabled = if type(func) == "number" then (1 - p3) * cframe + p3 * func else cframe:lerp(func, p3)
			configTable[isEnabled] = isEnabled
		end
		return configTable
	end
	local configTable = {}
	PlaySound = function(p1, p2, p3)
		if p2.Source then
			p2.Play = true
			if not p3 then
				eventBridge:FireServer("xk8pf94p", p1, p2)
			end
			configTable.xk8pf94p(LocalPlayer.Name, p1, p2)
		end
	end
	StopSound = function(p1, p2)
		local configTable = {}
		if not p2 then
			eventBridge:FireServer("xk8pf94p", p1, configTable)
		end
		configTable.xk8pf94p(LocalPlayer.Name, p1, configTable)
	end
	local questionCounter = 0
	function configTable.xk8pf94p(p1, p2, p3)
		local Source = p3.Source
		local isEnabled = p3.Volume or 0.5
		if isEnabled > 2 then
			isEnabled = 2
		end
		if isEnabled ~= isEnabled then
			isEnabled = 0.5
		end
		local isEnabled = p3.Pitch or 1
		local func = p3.MaxTime or 1
		local Looped = p3.Looped
		local TimeStart = p3.TimeStart
		local Delay = p3.Delay
		local cframe = p3.EmitterSize or 10
		if p3.TimeStop then
			func = TimeStart + p3.TimeStop
		end
		local vector = v23 + 1
		v23 = vector
		local cframe = p3.Multi and ("%s_%s_%d"):format(p1, p2, vector) or ("%s_%s"):format(p1, p2)
		local RemoteEvent = configTable[cframe]
		if RemoteEvent then
			RemoteEvent.Object:Stop()
			RemoteEvent.Object:Destroy()
			configTable[cframe] = nil
		end
		if p3.Play and Source then
			local vector = Settings.Sounds[p2]
			if vector then
				local Sound = Instance.new("Sound")
				Sound.SoundId = "rbxassetid://" .. vector
				if TimeStart then
					Sound.TimePosition = TimeStart
				end
				if p3.SoundGroup then
					Sound.SoundGroup = p3.SoundGroup
				end
				Sound.Name = cframe
				Sound.Looped = Looped
				Sound.Volume = isEnabled
				Sound.PlaybackSpeed = isEnabled
				Sound.EmitterSize = cframe
				Sound.MaxDistance = 400
				Sound.Parent = Source
				if Delay then
					delay(Delay, function()
						Sound:Play()
					end)
				else
					Sound:Play()
				end
				configTable[cframe] = {
					Object = Sound,
					Proxy = vector
				}
				local function Expire()
					local isEnabled = configTable[cframe]
					if isEnabled then
						if not (vector < isEnabled.Proxy) then
							isEnabled.Object:Stop()
							isEnabled.Object:Destroy()
							configTable[cframe] = nil
						end
					end
				end
				delay(func, Expire)
			end
		end
	end
end
local function Fireworks(p1)
	local isEnabled = AlexParticles.MakeState()
	isEnabled.Frame = cframe.Particles
	AlexParticles.EasySimulate(isEnabled, 4)
	local AbsoluteSize = isEnabled.Frame.AbsoluteSize
	local X = AbsoluteSize.X
	local Y = AbsoluteSize.Y
	local function OnDestroy(p12)
		if p1 <= 4 or math.random() > 0.2 then
			PlaySound("FireworkBang", {
				Source = isEnabled,
				Volume = 0.2 + math.random() * 0.3,
				Multi = true
			}, true)
		end
	end
	for i = 1, p1 do
		local isEnabled = Y * 0.3 + Y * 0.6 * math.random()
		local vector = Vector3.new(0, -400, 0) + Math.Uniform2D(150)
		local vector = AlexParticles.Firework(isEnabled, func(math.random() * X, Y, 0), vector, Vector3.new(0, 0, 0))
		vector.ttl = (Y - isEnabled) / vector.magnitude
		vector.OnDestroy = OnDestroy
		wait(0.1 + math.random() * 0.1 * 0.5)
	end
end
function configTable.l2atqdos(p1)
	assert(p1 <= 50)
	Fireworks(p1)
end
gameContext.Fireworks = Fireworks
require(ReplicatedStorage.Game.Party).Init({
	Fireworks = Fireworks
})
local AttemptPickPocket, AttemptBreakout, AttemptTrade, AttemptVehicleEject, AttemptVehicleHotwire, v24, StartNitro, StopNitro
do
	local function AttemptArrest(p1)
		eventBridge:FireServer("w5ln1uc8", p1)
	end
	function configTable.ghtu2z6w(p1)
		if p1.Bribed then
			configTable.mq92d5a8({
				Title = "Arrest",
				Text = ("You are bribed! Wait %d seconds."):format(p1.Bribed)
			})
		end
	end
	AttemptPickPocket = function(p1)
		eventBridge:FireServer("wld6u5vm", p1.Name)
	end
	AttemptBreakout = function(p1)
		eventBridge:FireServer("zbmdvqfs", p1.Name)
	end
	function configTable.bkiczp52(p1)
		if p1.Cooldown then
			configTable.mq92d5a8({
				Title = "Breakout",
				Text = ("Wait %d seconds."):format(p1.Cooldown)
			})
		end
	end
	AttemptTrade = function(p1)
		if TradeService.checkAlreadyInitiated(p1, LocalPlayer) then
			TradeService.acceptInitiation(p1.UserId)
		else
			TradeService.sendInitiation(p1.UserId)
		end
	end
	AttemptVehicleEject = function(p1)
		eventBridge:FireServer("hwo8k1vm", p1)
	end
	AttemptVehicleHotwire = function(p1, p2)
		eventBridge:FireServer("zw05zv1l", p1, p2)
	end
	timeOfDayState = nil
	local lastDeltaCalcTime = tick()
	local isEnabled = false
	local function CalculateDelta()
		if isEnabled and RunUtils.isMainWorld() then
			isEnabled = false
			local isEnabled = tick() - lastDeltaCalcTime
			eventBridge:FireServer("vbf3ia8t", isEnabled)
		end
	end
	local lastNitroStartTime = tick()
	local nitroConnection = nil
	StartNitro = function()
		if not (tick() - lastNitroStartTime < 0.1) then
			lastNitroStartTime = tick()
			if isEnabled then
				CalculateDelta()
			end
			isEnabled = true
			lastDeltaCalcTime = tick()
			if currentVehiclePacket and (not currentVehiclePacket.Passenger and #currentVehiclePacket.Nitrous > 0) then
				currentVehiclePacket.Nitro = true
				PlaySound("Nitro1", {
					Source = currentVehiclePacket.Nitrous[1].Parent,
					TimeStart = 0.5,
					Volume = 0.7
				})
				PlaySound("NitroLoop", {
					Source = currentVehiclePacket.Nitrous[1].Parent,
					Looped = true,
					MaxTime = 30,
					Volume = 0.7,
					Delay = 0.3
				})
				for isEnabled, isEnabled in next, currentVehiclePacket.Nitrous do
					isEnabled.Enabled = true
				end
				eventBridge:FireServer("brcx9whl")
				if nitroConnection then
					nitroConnection:Destroy()
				end
				nitroConnection = HapticEffect.basic(1, (1 / 0))
			end
			if v17.Nitro / nitroState.NitroLastMax <= 0.01 then
				configTable.n8cinotq(true, true)
			end
		end
	end
	StopNitro = function()
		StopSound("NitroLoop")
		if nitroConnection then
			nitroConnection:Destroy()
			nitroConnection = nil
		end
		if currentVehiclePacket and not currentVehiclePacket.Passenger then
			currentVehiclePacket.Nitro = false
			if currentVehiclePacket.Nitrous then
				for isEnabled, isEnabled in next, currentVehiclePacket.Nitrous do
					isEnabled.Enabled = false
				end
			end
		end
		CalculateDelta()
		eventBridge:FireServer("jiz6pq4h")
	end
	function configTable.dwv05uez(p1, p2)
		if RunUtils.isTradeWorld() then
			p1 = Settings.Scalar.NitroMax
		end
		nitroState.Nitro = p1
		nitroState.NitroLastMax = p2
		nitroState.NitroForceUIUpdate = true
		local isEnabled = v24
		isEnabled.Container.Container.ContainerBar.Value.Size = UDim2.new(p1 / Settings.Scalar.NitroMax, 0, 1, 0)
		isEnabled.Container.Container.ContainerFuel.Amount.Text = ("%d/%d"):format(p1, Settings.Scalar.NitroMax)
	end
end
local UpdateAllLowQuality, UpdateChassisLowQuality, UpdateChassisStepped, UpdateHeliLowQuality, HornStart, HornStop
do
	local eventCounter_v29 = 0
	local vector = Vector3.new(0, 0, 0)
	RunService.Heartbeat:Connect(function(p1)
		debug.profilebegin("CircleAction (logic, heartbeat)")
		UI.CircleAction.UpdateLogic(p1)
		debug.profileend()
	end)
	RunService.RenderStepped:Connect(function(p1)
		debug.profilebegin("CircleAction (position, renderstepped)")
		UI.CircleAction.UpdateVisual(p1)
		debug.profileend()
	end)
	RunService.Stepped:Connect(function()
		if currentVehiclePacket and not currentVehiclePacket.Passenger then
			if currentVehiclePacket.Type == "Chassis" then
				Classes.Chassis.UpdateStepped(v17)
			elseif currentVehiclePacket.Type == "Motorcycle" or currentVehiclePacket.Type == "DuneBuggy" then
				Classes.Chassis2.UpdateStepped(v17)
			end
		end
	end)
	local isEnabled = false
	RunService.Heartbeat:Connect(function(p1)
		debug.profilebegin("Vehicle Heartbeat")
		if currentVehiclePacket and not currentVehiclePacket.Passenger then
			if currentVehiclePacket.Type == "Chassis" then
				Classes.Chassis.Update(v17, p1)
			elseif currentVehiclePacket.Type == "Heli" then
				Classes.Heli.Update(v17, p1)
			elseif currentVehiclePacket.Type == "Custom" then
				if v17.Make == "Volt" then
					Classes.Volt.Update(v17, p1)
				end
			elseif currentVehiclePacket.Type == "Motorcycle" or currentVehiclePacket.Type == "DuneBuggy" then
				Classes.Chassis2.UpdateHQ(v17, p1)
			end
		end
		debug.profileend()
		if currentVehiclePacket and (not currentVehiclePacket.Passenger and (currentVehiclePacket.Type ~= "Heli" and currentVehiclePacket.Type ~= "Chassis3")) then
			local AreTiresPopped = v17.AreTiresPopped
			local isEnabled
			if nitroState.NitroForceUIUpdate then
				nitroState.NitroForceUIUpdate = false
				isEnabled = true
			else
				isEnabled = false
			end
			if VehicleUtils._forceUpdateNitroBar then
				VehicleUtils._forceUpdateNitroBar = false
				isEnabled = true
			end
			if currentVehiclePacket.Nitro and RunUtils.isMainWorld() then
				nitroState.Nitro = v17.Nitro - p1 * 5
				isEnabled = true
			end
			if v17.Nitro < 0 then
				nitroState.Nitro = 0
				StopNitro()
				isEnabled = true
			end
			if AreTiresPopped then
				StopNitro()
				isEnabled = true
			elseif AreTiresPopped ~= isEnabled and v17._isNitroPressed then
				StartNitro()
				isEnabled = true
			end
			if AreTiresPopped ~= isEnabled then
				isEnabled = AreTiresPopped
			end
			if isEnabled then
				local isEnabled = v17.Nitro / Settings.Scalar.NitroMax
				if currentVehiclePacket.Model and currentVehiclePacket.Model:GetAttribute("DisableNitro") then
					isEnabled = 0
				end
				VehicleUtils.updateSpdBarRatio(isEnabled)
			end
		end
	end)
	local configTable = {
		Waist = CFrame.new(),
		Neck = CFrame.new()
	}
	RunService.Stepped:Connect(function()
		debug.profilebegin("Camera Looking")
		local isEnabled = tick()
		vector = vector + (CurrentCamera.CFrame.Position + CurrentCamera.CFrame.LookVector * 30 - vector) * 0.2
		local Character = LocalPlayer.Character
		if Character then
			local Humanoid = Character:FindFirstChild("Humanoid")
			if Humanoid and (Humanoid.Health > 0 and not v17) then
				local RootPart = Humanoid.RootPart
				if RootPart then
					local Head = Character:FindFirstChild("Head")
					local UpperTorso = Character:FindFirstChild("UpperTorso")
					if Head and UpperTorso then
						local Waist = UpperTorso:FindFirstChild("Waist")
						local Neck = Head:FindFirstChild("Neck")
						if Waist and Neck then
							local isEnabled = 0
							local func = 0
							debug.profilebegin("Calculate looking")
							local cameraRotationFrame, neckRotationFrame
							if isCrawling then
								v42 = CFrame.identity
								vector = CFrame.identity
							else
								local LookVector = (CurrentCamera.CFrame * Angles(0.2, 0, 0)).LookVector
								if Math.IsNaNv3(LookVector) then
									LookVector = Vector3.new(0, 0, -1)
								end
								local cframe = RootPart.CFrame.lookVector:Dot(LookVector:Cross(Vector3.new(0, 1, 0)))
								local RemoteEvent = math.asin(LookVector.Y)
								if currentVehiclePacket and (not currentVehiclePacket.Passenger or v17.NoLook) or ItemSystem.GetLocalEquipped() then
									isEnabled = 0
									func = 0
								else
									isEnabled = cframe
									func = RemoteEvent
								end
								if Math.IsNaN(isEnabled) then
									isEnabled = 0
								end
								if Math.IsNaN(func) then
									func = 0
								end
								v42 = Angles(0, -isEnabled * 0.5 * 1, 0) * Angles(-func * 0.2 * 1, 0, 0)
								vector = Angles(-func * 0.5 * 1, 0, 0) * Angles(0, -isEnabled * 0.5 * 1, 0)
							end
							if Math.IsNaNcf(v42) then
								v42 = CFrame.identity
							end
							if Math.IsNaNcf(vector) then
								vector = CFrame.identity
							end
							if Waist.Transform ~= configTable.Waist then
								Waist.Transform = Waist.Transform * v42:Inverse()
								configTable.Waist = Waist.Transform
							end
							if Neck.Transform ~= configTable.Neck then
								Neck.Transform = Neck.Transform * vector:Inverse()
								configTable.Neck = Neck.Transform
							end
							if isEnabled - v29 >= 0.4 then
								v29 = isEnabled
								if Math.IsNaN(isEnabled) then
									isEnabled = 0
								end
								if Math.IsNaN(func) then
									func = 0
								end
								if configTable.hems then
									eventBridge:FireServer("gzo1hwwh", isEnabled, func)
								end
							end
							debug.profileend()
						end
					end
				end
			end
		end
		for k, v in pairs(configTable) do
			local vector, isEnabled
			if not ItemSystem.GetEquipped((Players:FindFirstChild(k))) then
				local cframe, _ = Math.Spring(v.HeadingSpring)
				local cframe, _2 = Math.Spring(v.PitchSpring)
				local Waist = v.Waist
				if Waist then
					local waistRotation = Angles(-cframe * 0.2, -cframe * 0.5, 0)
					vector = if Math.IsNaNcf(waistRotation) then cframe else waistRotation
					if Waist.Transform == v.LastWaistTransform then
						Waist.Transform = vector
					else
						Waist.Transform = Waist.Transform * vector:Inverse()
					end
					v.LastWaistTransform = Waist.Transform
				end
				local Neck = v.Neck
				if Neck then
					local neckRotation = Angles(-cframe * 0.5, -cframe * 0.5, 0)
					isEnabled = if Math.IsNaNcf(neckRotation) then cframe else neckRotation
					if Neck.Transform == v.LastNeckTransform then
						Neck.Transform = isEnabled
					else
						Neck.Transform = Neck.Transform * isEnabled:Inverse()
					end
					v.LastNeckTransform = Neck.Transform
				end
			end
		end
		debug.profileend()
	end)
	local configTable = {
		tire_pop = 4534995816,
		tire_leak = 4534995685
	}
	local vector = RaycastParams.new()
	vector.IgnoreWater = true
	UpdateAllLowQuality = function(p1, p2, p3)
		local Model = p1.Model
		if Model then
			local Engine = Model:FindFirstChild("Engine")
			if Engine then
				local isEnabled = Engine.CFrame:vectorToObjectSpace(Engine.Velocity)
				local isEnabled = Model:GetAttribute("VehicleIsDrifting")
				if p1.Sounds and p1.Sounds.DriftSqueal then
					local func = if p1.Type == "Motorcycle" then 2 else 10
					local cframe = abs(isEnabled.X)
					if func < cframe then
						p1.Sounds.DriftSqueal.Volume = math.min((cframe - func) / 6, 1) * 0.3
					else
						p1.Sounds.DriftSqueal.Volume = 0
					end
				end
				vector.FilterDescendantsInstances = { Model }
				local vector = vector
				local Preset = Model:FindFirstChild("Preset")
				if Preset then
					for cframe, RemoteEvent in Preset:GetChildren() do
						if RemoteEvent.Name == "Drift" and (Raycast.collidable(RemoteEvent.Position + Vector3.new(0, 4, 0), Vector3.new(-0, -1, -0), 8, vector) and isEnabled) then
							for vector, isEnabled in RemoteEvent:GetChildren() do
								if isEnabled:IsA("ParticleEmitter") then
									local cframe = (isEnabled:GetAttribute("DriftAccum") or 0) + isEnabled.Rate * p2
									local cframe = math.floor(cframe)
									if cframe > 0 then
										isEnabled:Emit(cframe)
									end
									isEnabled:SetAttribute("DriftAccum", cframe - cframe)
								end
							end
						end
					end
				end
				if p1.Make == "JBX0031" then
					local Y = Engine.AssemblyAngularVelocity.Y
					Classes.Chassis.UpdateThrusterFlames(Model, if -isEnabled.Z > 2 then 1 else 0, if Y > 0.3 then 1 elseif Y < -0.3 then -1 else 0, isEnabled.Z)
				end
				if p1.Type == "Chassis" or (p1.Type == "Chassis2" or p1.Type == "Heli") then
					if p3.Brakelight == nil then
						function p3.Brakelight()
							VehicleUtils.setBrakelightsEnabled(Model, false)
						end
					end
					local cframe = (isEnabled or Engine.AssemblyLinearVelocity:Dot(Engine.CFrame.LookVector) < 20) and true or false
					if VehicleUtils.getBrakelightsEnabled(Model) ~= cframe then
						VehicleUtils.setBrakelightsEnabled(Model, cframe)
					end
				end
			else
				warn("No engine exists to update LowQuality")
			end
		else
			warn("No model exists to update LowQuality")
		end
	end
	UpdateChassisLowQuality = function(p1, p2)
		local Model = p1.Model
		local Height = p1.Height
		if Model then
			local Engine = Model:FindFirstChild("Engine")
			if Engine then
				local isEnabled = Engine.CFrame:vectorToObjectSpace(Engine.Velocity)
				local _cachedWheelRadius = p1._cachedWheelRadius
				if not _cachedWheelRadius then
					_cachedWheelRadius = p1.Wheels[1].Model.PrimaryPart.Size.Y / 2
					p1._cachedWheelRadius = _cachedWheelRadius
				end
				local func = (p1.WheelRotation + isEnabled.Z * p2 / _cachedWheelRadius) % math.tau
				p1.WheelRotation = func
				local cframe = Model:GetAttribute("GarageSuspensionHeight")
				if cframe then
					Height = Height + cframe
				end
				for k, v in pairs(p1.Wheels) do
					Classes.Chassis.UpdateWheelLowQuality(Model, Height, v, func)
				end
				Classes.Chassis.UpdateSoundLowQuality(p1, p1.Gears, isEnabled)
				local vector = Model:GetAttribute("VehicleTiresLastPop")
				local RemoteEvent = math.min((Time.GetNowSync() - vector) / p1.DisableDuration, 1) < 0.999
				if p1.AreTiresPopped ~= RemoteEvent then
					if RemoteEvent then
						local configTable = {
							Volume = 1
						}
						Audio.ObjectLocal(Engine, configTable.tire_pop, configTable)
						Audio.ObjectLocal(Engine, configTable.tire_leak, configTable)
					end
					p1.AreTiresPopped = RemoteEvent
				end
			else
				warn("No engine exists to update LowQuality")
			end
		else
			warn("No model exists to update LowQuality")
		end
	end
	UpdateChassisStepped = function(p1)
		local IKP = p1.IKP
		local Model = p1.Model
		local Engine = Model:FindFirstChild("Engine")
		if Engine then
			if not IKP then
				local isEnabled = Players:FindFirstChild(p1.PlayerName)
				if isEnabled then
					local Character = isEnabled.Character
					if Character then
						local Humanoid = Character:FindFirstChild("Humanoid")
						if Humanoid and Humanoid.RootPart then
							local isEnabled = R15IKv2.BuildPacketArms(Character)
							p1.IKP = isEnabled
							IKP = isEnabled
						else
							return false
						end
					else
						return
					end
				else
					return
				end
			end
			local vector = 0.5 * Engine.RotVelocity.Y
			if p1.WeldSteer and IKP then
				p1.WeldSteer.C0 = Angles(0, vector, 0)
				local cframe = Model.Steer.Size.X * 0.5 - 0.2
				local vector = Model.Steer.CFrame
				IKP.RightArm = vector * func(cframe, 0.1, 0)
				IKP.RightAngle = -vector - 0.6
				IKP.LeftArm = vector * func(-cframe, 0.1, 0)
				IKP.LeftAngle = -vector + 0.6
				R15IKv2.Arms(IKP)
			end
		end
	end
	UpdateHeliLowQuality = function(p1, p2)
		if p1.Model then
			if p1.HasProp then
				Classes.Heli.SpinProp(p1, p2)
			elseif p1.IsUFO then
				Classes.Heli.SpinUFO(p1, p2)
			elseif p1.IsCrewCapsule then
				Classes.Heli.SpinCrewCapsule(p1, p2)
			elseif p1.IsDrone then
				Classes.Heli.SpinDrone(p1, p2)
			end
		end
	end
	local eventCounter_v33 = 0
	local function playHorn(p1, p2, p3, p4, p5, p6)
		local isEnabled = p5 or 16
		local _HornSound = p1:FindFirstChild("_HornSound")
		if _HornSound then
			_HornSound:Destroy()
		end
		if p2 then
			local _HornSound_2 = Audio.ObjectLocal(p1, p3, {
				Looped = p4
			})
			_HornSound_2.Name = "_HornSound"
			if p6 then
				_HornSound_2.Volume = p6
			end
			_HornSound_2.Parent = p1
			task.delay(isEnabled, function()
				if _HornSound_2.Parent == p1 then
					_HornSound_2:Destroy()
				end
			end)
		end
	end
	HornStart = function()
		local isEnabled = os.clock()
		if not (isEnabled - v33 < 0.05) then
			v33 = isEnabled
			if currentVehiclePacket and not currentVehiclePacket.Passenger then
				local Model = currentVehiclePacket.Model
				playHorn(Model:FindFirstChild("BoundingBox"), true, Model:GetAttribute("VehicleHornId"), Model:GetAttribute("VehicleHornLoopable"), nil, (Model:GetAttribute("VehicleHornVolume")))
				eventBridge:FireServer("ydmnlyuf", true)
			end
		end
	end
	HornStop = function()
		if currentVehiclePacket and not currentVehiclePacket.Passenger then
			local _HornSound = currentVehiclePacket.Model:FindFirstChild("BoundingBox"):FindFirstChild("_HornSound")
			if _HornSound then
				_HornSound:Destroy()
			end
			eventBridge:FireServer("ydmnlyuf", false)
		end
	end
	function configTable.ydmnlyuf(p1, p2, p3, p4, p5, p6)
		playHorn(p2, p3, p4, p5, 10, p6)
	end
end
local crawlAnimationTrack, toggleCrawling, OnJump
do
	local Animation = Instance.new("Animation")
	if RunUtils.getEnv() == RunConsts.QA_NAME then
		Animation.AnimationId = "rbxassetid://10866609111"
	else
		Animation.AnimationId = "rbxassetid://685258011"
	end
	crawlAnimationTrack = nil
	local configTable = {}
	local Animation_2 = Instance.new("Animation")
	Animation_2.AnimationId = "rbxassetid://758003506"
	table.insert(configTable, Animation_2)
	local Animation_3 = Instance.new("Animation")
	Animation_3.AnimationId = "rbxassetid://758005053"
	table.insert(configTable, Animation_3)
	local unequipDelayConnection = nil
	local deathSequenceStartTime = tick()
	local deathScreenShowTime = tick()
	local configTable = { 0, 0, 0 }
	toggleCrawling = function()
		local Character = LocalPlayer.Character
		local Humanoid = Character:FindFirstChild("Humanoid")
		local PrimaryPart = Character.PrimaryPart
		isCrawling = not crawlAnimation
		CharacterUtil.IsCrawling = isCrawling
		CharacterUtil.IsCrawlingChanged:Fire(CharacterUtil.IsCrawling)
		local UpperTorso = Character:FindFirstChild("UpperTorso")
		local LowerTorso = Character:FindFirstChild("LowerTorso")
		local list = {}
		local function isEnabled(p1)
			local cframe = next
			local isEnabled, func = p1:GetChildren()
			for cframe, vector in cframe, isEnabled, func do
				if vector:IsA("JointInstance") and (vector.Part1 == UpperTorso or (vector.Part1 == LowerTorso or (vector.Part0 == UpperTorso or vector.Part0 == LowerTorso))) then
					table.insert(list, {
						Motor = vector,
						Part0 = vector.Part0,
						Part1 = vector.Part1
					})
					vector.Part0 = nil
					vector.Part1 = nil
				end
				isEnabled(vector)
			end
		end
		isEnabled(Character)
		if isCrawling then
			local Ball = Instance.new("Part")
			Ball.Shape = Enum.PartType.Ball
			Ball.Size = Vector3.new(2, 1, 4)
			Ball.Name = "Ball"
			Ball.CanCollide = true
			Ball.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 1, 1)
			Ball.CFrame = PrimaryPart.CFrame * CFrame.new(0, 0, 1)
			Ball.Transparency = 1
			Ball.Parent = Character
			Joint.CustomWeld(Ball, PrimaryPart, CFrame.new(0, 1, 0), cframe)
		else
			local Ball = Character:FindFirstChild("Ball")
			if Ball then
				Ball:Destroy()
			end
		end
		for i, v in ipairs(list) do
			v.Motor.Part0 = v.Part0
			v.Motor.Part1 = v.Part1
		end
		Character.HumanoidRootPart.CanCollide = not v20
		if crawlAnimationTrack then
			crawlAnimationTrack:Stop()
			crawlAnimationTrack = nil
		else
			crawlAnimationTrack = Humanoid:LoadAnimation(Animation)
			crawlAnimationTrack:Play()
		end
	end
	local function _setSprinting(p1)
		isSprinting = p1
	end
	local function setSprinting(p1)
		isSprinting = p1
		if (p1 and true or false) ~= (DefaultActions.sprintButton._pressed and true or false) and DefaultActions.sprintButton._pressState then
			DefaultActions.sprintButton._pressState()
		end
	end
	local function attemptToggleCrawling()
		local Character = LocalPlayer.Character
		if Character then
			local Humanoid = Character:FindFirstChild("Humanoid")
			if Humanoid and ((crawlAnimationTrack or not Humanoid.Sit) and ((crawlAnimationTrack or not Humanoid.PlatformStand) and Character.PrimaryPart)) then
				if Classes.Heli.Roped or Falling.IsRagdolling() then
				elseif Paraglide.IsFlying() then
					return false
				elseif InventoryItemSystem.unequipAll() then
					local isEnabled = ItemSystem.GetLocalEquipped()
					if isEnabled and isEnabled.ItemData.Locked or tick() - v39 < 0.1 then
					elseif not (tick() - configTable[#configTable] < 2) then
						v39 = tick()
						if crawlAnimationTrack then
							table.remove(configTable)
							table.insert(configTable, 1, v39)
						end
						toggleCrawling()
					end
				end
			end
		end
	end
	local function attemptPunch()
		if tick() - v38 < 0.5 then
			return
		end
		local Character = LocalPlayer.Character
		if Character then
			local Humanoid = Character:FindFirstChild("Humanoid")
			if Humanoid then
				if not ItemSystem.GetLocalEquipped() then
					if v37 then
						v37:Stop()
					end
					local isEnabled = table.remove(configTable, 1)
					table.insert(configTable, isEnabled)
					v37 = Humanoid:LoadAnimation(isEnabled)
					v37:Play()
					v38 = tick()
					eventBridge:FireServer("sf5hgxqm")
				end
			end
		end
	end
	require(ReplicatedStorage.Game.DefaultActions).init({
		setSprinting = _setSprinting,
		attemptToggleCrawling = attemptToggleCrawling,
		attemptPunch = attemptPunch
	})
	function configTable.mkrp0wlk(p1, p2)
		GameUtil.Schedule = p1
		if GameUtil.Team == Settings.EnumTeam.Prisoner and RunUtils.isMainWorld() then
			configTable.mq92d5a8({
				Text = Localization:FormatByKey("Schedule." .. p1)
			})
		end
	end
	function configTable.gzo1hwwh(p1, p2, p3)
		local isEnabled = configTable[p1]
		if not isEnabled then
			isEnabled = {
				HeadingSpring = Math.MakeSpring(0, 10, 0.8),
				PitchSpring = Math.MakeSpring(0, 10, 0.8)
			}
			configTable[p1] = isEnabled
		end
		local isEnabled = Players:FindFirstChild(p1)
		if isEnabled then
			local Character = isEnabled.Character
			if Character then
				local UpperTorso = Character:FindFirstChild("UpperTorso")
				if UpperTorso then
					local Waist = UpperTorso:FindFirstChild("Waist")
					local Neck = Character.Head:FindFirstChild("Neck")
					isEnabled.Waist = Waist
					isEnabled.Neck = Neck
					Math.SpringSetTarget(isEnabled.HeadingSpring, p2)
					Math.SpringSetTarget(isEnabled.PitchSpring, p3)
				else
					configTable[p1] = nil
				end
			else
				configTable[p1] = nil
			end
		else
			configTable[p1] = nil
		end
	end
	local CartBinder = require(ReplicatedStorage.Game.Cart.CartBinder)
	OnJump = function()
		if v17 then
			if LocalPlayer.Character and LocalPlayer.Character:GetAttribute("TankRoyaleAlive") then
				configTable.mq92d5a8({
					Text = "You cannot exit Tanks in this gamemode."
				})
				return
			end
			VehicleUtils.OnVehicleJumpExited:Fire(v17)
			eventBridge:FireServer("ja0b58yb")
			VehicleUtils.LastVehicleExit = tick()
		else
			for i, v in ipairs(CartBinder:GetAll()) do
				if LocalPlayer.Character ~= nil and v:GetOccupant() == LocalPlayer.Character then
					eventBridge:FireServer("ja0b58yb")
					break
				end
			end
		end
		if Classes.Heli.Roped then
			Classes.Heli.AttemptRopeDetach()
		end
	end
	CharacterUtil.OnJump = OnJump
	local Lighting = game:GetService("Lighting")
	local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
	ColorCorrectionEffect.Enabled = false
	ColorCorrectionEffect.Parent = Lighting
	local BlurEffect = Instance.new("BlurEffect")
	BlurEffect.Size = 0
	BlurEffect.Enabled = false
	BlurEffect.Parent = Lighting
	local startLightingConfig = nil
	local endLightingConfig = nil
	local lightingFadeConnection = nil
	local function removeDeathLighting()
		if endLightingConfig then
			local isEnabled = 0
			local isEnabled = nil
			local function Finish()
				if isEnabled then
					isEnabled:Disconnect()
				end
				local isEnabled = LerpTable(endLightingConfig, startLightingConfig, 1)
				ColorCorrectionEffect.Saturation = isEnabled.Saturation
				BlurEffect.Size = isEnabled.Blur
				BlurEffect.Enabled = false
				ColorCorrectionEffect.Enabled = false
			end
			local function Stepped(p1)
				isEnabled = isEnabled + p1 * 2
				if isEnabled >= 1 then
					if isEnabled then
						isEnabled:Disconnect()
					end
					local cframe = LerpTable(endLightingConfig, startLightingConfig, 1)
					ColorCorrectionEffect.Saturation = cframe.Saturation
					BlurEffect.Size = cframe.Blur
					BlurEffect.Enabled = false
					ColorCorrectionEffect.Enabled = false
				else
					local effectLerpResult = LerpTable(endLightingConfig, startLightingConfig, 1)
					ColorCorrectionEffect.Saturation = effectLerpResult.Saturation
					BlurEffect.Size = effectLerpResult.Blur
				end
			end
			isEnabled = RunService.RenderStepped:connect(Stepped)
		end
	end
	local function removeDeathGui()
		cframe.Frame:TweenSizeAndPosition(UDim2.new(1, 40, 0, 0), UDim2.new(0, -20, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true, function()
			cframe.Frame.Visible = false
		end)
	end
	GameUtil.removeDeathGui = removeDeathGui
	GameUtil.removeDeathLighting = removeDeathLighting
	function configTable.f49gnwdv()
		wait()
		local Character = LocalPlayer.Character
		if Character then
			local Humanoid = Character:FindFirstChild("Humanoid")
			if Humanoid then
				Humanoid.Seated:connect(function(p1)
					if p1 and CharacterUtil.IsCrawling then
						toggleCrawling()
					end
				end)
				Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
				removeDeathGui()
				if endLightingConfig then
					local isEnabled = 0
					local isEnabled = nil
					local function Finish()
						if isEnabled then
							isEnabled:Disconnect()
						end
						local isEnabled = LerpTable(endLightingConfig, startLightingConfig, 1)
						ColorCorrectionEffect.Saturation = isEnabled.Saturation
						BlurEffect.Size = isEnabled.Blur
						BlurEffect.Enabled = false
						ColorCorrectionEffect.Enabled = false
					end
					local function Stepped(p1)
						isEnabled = isEnabled + p1 * 2
						if isEnabled >= 1 then
							if isEnabled then
								isEnabled:Disconnect()
							end
							local cframe = LerpTable(endLightingConfig, startLightingConfig, 1)
							ColorCorrectionEffect.Saturation = cframe.Saturation
							BlurEffect.Size = cframe.Blur
							BlurEffect.Enabled = false
							ColorCorrectionEffect.Enabled = false
						else
							local effectLerpResult = LerpTable(endLightingConfig, startLightingConfig, 1)
							ColorCorrectionEffect.Saturation = effectLerpResult.Saturation
							BlurEffect.Size = effectLerpResult.Blur
						end
					end
					isEnabled = RunService.RenderStepped:connect(Stepped)
				end
				if InputUtils.isTouch() then
					v19 = true
					if (DefaultActions.sprintButton._pressed and true or false) ~= true and DefaultActions.sprintButton._pressState then
						DefaultActions.sprintButton._pressState()
					end
				end
				v42 = nil
			end
		end
	end
	local store = require(ReplicatedStorage.App.store)
	function configTable.dmg39zpa(p1)
		v20 = false
		CharacterUtil.IsCrawling = false
		CharacterUtil.IsCrawlingChanged:Fire(CharacterUtil.IsCrawling)
		v19 = false
		if (DefaultActions.sprintButton._pressed and true or false) ~= false and DefaultActions.sprintButton._pressState then
			DefaultActions.sprintButton._pressState()
		end
		isStunned = false
		OnJump()
		store:dispatch({
			type = "setLastDiedAt",
			lastDiedAt = workspace:GetServerTimeNow()
		})
		if not p1 then
			cframe.Frame.TextLabel.Text = v42 or Localization:FormatByKey("DeathMessage." .. math.random(0, 13))
			BlurEffect.Enabled = true
			ColorCorrectionEffect.Enabled = true
			v40 = {
				Blur = 0,
				Saturation = 0
			}
			v41 = {
				Blur = 8,
				Saturation = -1
			}
			local func = 0
			local cframe = nil
			local function Finish()
				if cframe then
					cframe:Disconnect()
				end
				local isEnabled = LerpTable(v40, v41, 1)
				ColorCorrectionEffect.Saturation = isEnabled.Saturation
				BlurEffect.Size = isEnabled.Blur
			end
			local function Stepped(p1)
				func = func + p1 * 1
				if func >= 1 then
					return Finish()
				end
				local isEnabled = LerpTable(v40, v41, func)
				ColorCorrectionEffect.Saturation = isEnabled.Saturation
				BlurEffect.Size = isEnabled.Blur
			end
			cframe = RunService.RenderStepped:connect(Stepped)
			delay(0.5, function()
				cframe.Frame.Size = UDim2.new(1, 40, 0, 0)
				cframe.Frame.Position = UDim2.new(0, -20, 0.5, 0)
				cframe.Frame:TweenSizeAndPosition(UDim2.new(1, 40, 0, 150), UDim2.new(0, -20, 0.5, -75), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
				cframe.Frame.Visible = true
			end)
		end
	end
	waitForChild(ReplicatedStorage, "UpdateDeathMessage"):andThen(function(p1)
		p1.OnClientEvent:Connect(function(p1)
			v42 = p1
			cframe.Frame.TextLabel.Text = p1
		end)
	end)
end
do
	local JetPack_2 = require(ReplicatedStorage.Game.JetPack.JetPack)
	function configTable.e9kobedq(p1)
		p1 = p1 or Settings.Time.Stunned
		HapticEffect.basic(1, 1)
		isStunned = true
		Falling.StartRagdolling(p1)
		JetPack_2.Stunned()
		task.wait(p1)
		isStunned = false
	end
	function configTable.mq92d5a8(p1)
		assert(p1 ~= nil)
		assert(p1.Text ~= nil)
		Notification.new({
			Text = p1.Text,
			Duration = p1.Duration,
			Style = p1.Style
		})
	end
	function configTable.pehxjhoy(p1, p2)
		assert(p1 ~= nil)
		Notification.notifyBoss(p1, p2)
	end
	gameContext.Notification = configTable.mq92d5a8
	function configTable.ekwtxejw(p1, p2)
		if p2 then
			p1 = RichTextUtils.addColorToText(p1, p2)
		end
		pcall(function()
			TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(p1, "BadimoSystemMessage")
		end)
	end
	local store_2 = require(ReplicatedStorage.App.store)
	local homeStore = require(ReplicatedStorage.Home.homeStore)
	local vehicleBuyUI = require(ReplicatedStorage.App.VehicleBuyUI)()
	local MilestoneEffects = require(ReplicatedStorage.App.MilestoneEffects)
	MilestoneEffects.init(Fireworks)
	function configTable.akp6xj5f(p1)
		assert(p1 ~= nil)
		vehicleBuyUI.setCash(p1.Cash)
		MilestoneEffects.cashUpdate(p1.Cash)
		CashBuyUI.SetCash(p1.Cash)
		store_2:dispatch({
			type = "setCash",
			cash = p1.Cash
		})
		homeStore:dispatch({
			type = "setCash",
			cash = p1.Cash
		})
	end
	local cashPopupCounter = 0
	function configTable.bpp8cyi1(p1, p2)
		local isEnabled = cashPopupCounter + 1
		cashPopupCounter = isEnabled
		if p1 > 0 then
			task.spawn(Fireworks, 2)
			isEnabled.PlusCash.TextColor3 = Color3.fromRGB(68, 194, 93)
			isEnabled.PlusCash.TextStrokeColor3 = Color3.fromRGB(33, 97, 44)
		else
			isEnabled.PlusCash.TextColor3 = Color3.fromRGB(240, 30, 30)
			isEnabled.PlusCash.TextStrokeColor3 = Color3.fromRGB(180, 0, 0)
		end
		if not isEnabled.PlusCash.Visible then
			isEnabled.PlusCash.Text = ""
		end
		isEnabled.PlusCash.Visible = true
		isEnabled.PlusCash.TextSize = 28
		isEnabled.PlusCash.Font = Enum.Font.SourceSansBold
		isEnabled.PlusCash.RichText = true
		if p2 then
			local configTable = {}
			local cframe, RemoteEvent, vector = string.match(abs(p1), "^([^%d]*%d)(%d*)(.-)$")
			configTable[1] = cframe .. RemoteEvent:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. vector
			isEnabled.PlusCash.Text = isEnabled.PlusCash.Text .. ("<font color=\"#FFFFFF\"><stroke color=\"#111111\" thickness=\"0.75\">%s: </stroke></font><b>%s</b>\n"):format(p2, if p1 >= 0 then "" else "-" .. Localization:FormatByKey("General.Cash", configTable))
		else
			local configTable = {}
			local prefix, numericPart, suffix = string.match(abs(p1), "^([^%d]*%d)(%d*)(.-)$")
			configTable[1] = prefix ..  numericPart:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. cframe
			isEnabled.PlusCash.Text = isEnabled.PlusCash.Text .. ("<b>%s</b>\n"):format(if p1 >= 0 then "" else "-" .. Localization:FormatByKey("General.Cash", configTable))
		end
		task.delay(3, function()
			if cashPopupCounter == isEnabled then
				isEnabled.PlusCash.Visible = false
			end
		end)
	end
	local function _added(p1)
		p1.maid:GiveTask(function()
			local packet = p1.packet
			if packet and packet.Sounds then
				for isEnabled, isEnabled in next, packet.Sounds do
					isEnabled.Volume = 0
				end
			end
			if packet and packet.Type == "Heli" then
				packet.PropAlpha = 0
				UpdateHeliLowQuality(packet, 0)
			end
		end)
	end
	for v45, v46 in VehicleStateBinder:GetAll() do
		_added(v46)
	end
	VehicleStateBinder:GetClassAddedSignal():Connect(_added)
	function configTable.q53280n2(p1)
		configTable[p1] = nil
	end
	local connectionVariable_v47 = nil
	pcall(function()
		v47 = require(LocalPlayer.PlayerScripts.PlayerModule.CameraModule:WaitForChild("ZoomController"))
	end)
	local CinematicCamera = require(ReplicatedStorage.Module.CinematicCamera)
	local function TransitionCamera(p1, p2, p3, p4, p5, p6, p7)
		local isEnabled = Maid.new()
		local isEnabled = CinematicCamera.MakeCinematicCamera()
		isEnabled.Position = CurrentCamera.CFrame.Position
		isEnabled.LookVector = CurrentCamera.CFrame.LookVector
		CurrentCamera.CameraType = Enum.CameraType.Scriptable
		isEnabled:GiveTask(function()
			CurrentCamera.CameraType = Enum.CameraType.Custom
		end)
		local func = 0
		local function Finish()
			isEnabled:Destroy()
			PlayerModuleService.setCameraToSubjectDistance(p5)
			if v47 then
				v47.ReleaseSpring()
			end
		end
		local cframe = p7 or p1.CFrame - p1.CFrame.p
		local function Update(p12)
			func = func + p12 * (1 / p2)
			local cframe = if p6 then cframe + p1.CFrame.p else p1.CFrame
			isEnabled.TargetPosition = cframe * p3
			isEnabled.TargetFocus = cframe * p4
			CinematicCamera.StepCinematicCamera(p12, isEnabled, func * 50 * func + 10, func * 50 * func + 6)
			if func >= 1 then
				isEnabled:Destroy()
				PlayerModuleService.setCameraToSubjectDistance(p5)
				if v47 then
					v47.ReleaseSpring()
				end
			end
		end
		isEnabled:GiveTask(RunService.RenderStepped:Connect(Update))
		return isEnabled
	end
	local connectionVariable_v48 = nil
	v43.Frame.Parent = isEnabled
	local function Cancel()
		v43.setEnabled(false)
		OnJump()
	end
	local function Buy()
		if v48 then
			eventBridge:FireServer("ow215fmr", v48)
		else
			v43.setEnabled(false)
			OnJump()
		end
	end
	local function Rent()
		if v48 then
			MarketplaceService:PromptProductPurchase(LocalPlayer, 437705749)
			eventBridge:FireServer("np8snxb4", v48)
		else
			v43.setEnabled(false)
			OnJump()
		end
	end
	local function BuyCash()
		v43.setEnabled(false)
		OnJump()
		CashBuyUI.Open()
	end
	v43.onAction:Connect(function(p1)
		if p1 == "Buy" then
			Buy()
		elseif p1 == "Cancel" then
			v43.setEnabled(false)
			OnJump()
		elseif p1 == "Cash" then
			v43.setEnabled(false)
			OnJump()
			CashBuyUI.Open()
		elseif p1 == "Rent" then
			Rent()
		end
	end)
	function configTable.ow215fmr(p1)
		if p1.Success then
			v43.setEnabled(false)
			Fireworks(5)
		elseif p1.NotEnoughMoney then
			v43.setEnabled(false)
			OnJump()
			CashBuyUI.Open()
		elseif p1.LowLevel then
			configTable.mq92d5a8({
				Title = "Vehicle",
				Text = ("This requires level %d."):format(p1.LowLevel)
			})
		else
			v43.setEnabled(false)
			OnJump()
		end
	end
	waitForChild(ReplicatedStorage, "UpdateOwnedCashBillboard"):andThen(function(p1)
		p1.OnClientEvent:Connect(function(p1)
			nitroState.VehiclesOwned = p1
		end)
	end)
	function configTable.ef31t4k2(p1)
		nitroState.VehiclesRented = p1
	end
	function configTable.ykwtg5cz(p1, p2, p3)
		v48 = p1
		local isEnabled = Settings.Price[p1]
		if p2 then
			PromptPurchase(p2)
		elseif isEnabled then
			v43.setVehicle(ItemUtils.getTranslatedTitleFromItemTable((ItemUtils.createVehicleItemTable(p1))), Settings.Price[p1], p3)
			v43.setEnabled(true)
			EzUtils.selectIfGamepad(v43.BuyButton)
		elseif p1 == "EscapeBot" then
			configTable.mq92d5a8({
				Text = "Roll the Legendary EscapeBot from a CEO Battle to fly"
			})
		else
			configTable.mq92d5a8({
				Text = "This vehicle cannot be purchased!"
			})
		end
	end
	function configTable.jj4fw9mg()
		local SimpleMessage = isEnabled.SimpleMessage
		SimpleMessage.Visible = true
		SimpleMessage.Text = Localization:FormatByKey("Vehicle.Locked")
		local function Finished()
			SimpleMessage.Visible = false
		end
		delay(1, Finished)
	end
	local configTable = {
		name = "useVehicleFollowCamera",
		title = "Vehicle Follow Camera",
		type = gameSettingType.Checkbox
	}
	configTable.defaultValue = not isEnabled
	configTable.order = 50
	GameSettingsService.add(configTable)
	local function handleSetting_2(p1)
		if v17 then
			local isEnabled = VehicleUtils.prepareCameraSubject(v17, p1)
			if CurrentCamera.CameraType == Enum.CameraType.Custom then
				CurrentCamera.CameraType = Enum.CameraType.Scriptable
				CurrentCamera.CameraType = Enum.CameraType.Custom
			end
			if isEnabled then
				CurrentCamera.CameraSubject = isEnabled
			end
		end
	end
	handleSetting_2(configTable:getValue())
	configTable.onChanged:Connect(handleSetting_2)
	GameSettingsService.add({
		name = "autoLockVehicle",
		title = "Lock/Unlock Vehicle On Enter/Exit",
		type = gameSettingType.Checkbox,
		defaultValue = false,
		order = 51
	})
	local maxSpawnWaitTime = if RunUtils.isStudio() then 0.1 else 15
	local eventCounter_v51 = 0
	local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
	local VehicleLinkBinder = require(ReplicatedStorage.VehicleLink.VehicleLinkBinder)
	local Promise = require(ReplicatedStorage.Std.Promise)
	local function predicateWaitForMe(p1)
		return p1 == LocalPlayer.Name
	end
	function configTable.mh8gxu5l(p1, p2, p3)
		StreamingHelperUtils.yieldForObjValuePopulated(p1)
		local _Packet = p1.Value:WaitForChild("_Packet")
		StreamingHelperUtils.yieldForAllValuesPopulated(_Packet)
		TableUtils.mergeDeepInPlace(TableUtils.createTableFromObjectValues(_Packet), p2)
		configTable.vwyylbie(p2)
	end
	local seatPromise = nil
	function configTable.vwyylbie(p1)
		local configTable = {}
		for isEnabled, isEnabled in p1.Model:GetChildren() do
			if isEnabled:IsA("BasePart") and (isEnabled.Name == "Seat" or isEnabled.Name == "Passenger") then
				local PlayerName = isEnabled:FindFirstChild("PlayerName")
				if PlayerName then
					table.insert(configTable, RxInstanceUtils.waitForProperty(PlayerName, "Value", predicateWaitForMe):andThen(function()
						return isEnabled
					end))
				end
			end
		end
		seatPromise = Promise.race(configTable):timeout(5)
		local cframe, vector = seatPromise:await()
		if cframe then
			p1.Seat = vector
			if CharacterUtil.IsCrawling then
				toggleCrawling()
			end
			local Make = p1.Make
			if not (p1.Passenger and p1.Seat:FindFirstChild("Items")) then
				InventoryItemSystem.unequipAll()
			end
			local Character = LocalPlayer.Character
			if Character then
				local Humanoid = Character:FindFirstChild("Humanoid")
				if Humanoid then
					assert(not p1.seatMaid, "packet already has seat maid")
					local vector = Maid.new()
					p1.seatMaid = vector
					p1.wasSprintingBeforeEnteringVehicle = v19 and not UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
					ActionButtonService.setButtonEnabled(DefaultActions.crawlButton, false)
					ActionButtonService.setButtonEnabled(DefaultActions.sprintButton, false)
					vector:GiveTask(function()
						ActionButtonService.setButtonEnabled(DefaultActions.crawlButton, true)
						ActionButtonService.setButtonEnabled(DefaultActions.sprintButton, true)
						if p1.wasSprintingBeforeEnteringVehicle then
							v19 = true
							if (DefaultActions.sprintButton._pressed and true or false) ~= true and DefaultActions.sprintButton._pressState then
								DefaultActions.sprintButton._pressState()
							end
						end
					end)
					local cframe, cframe, cframe = VehicleUtils.prepareCameraSubject(p1, configTable:getValue(), true)
					if cframe then
						vector:GiveTask(TransitionCamera(cframe, 0.5, cframe, Vector3.new(0, 0, 0), cframe))
						CurrentCamera.CameraSubject = cframe
						vector:GiveTask(function()
							local isEnabled = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
							if isEnabled then
								CurrentCamera.CameraSubject = isEnabled
							else
								CurrentCamera.CameraSubject = nil
							end
						end)
					end
					vector:GiveTask(function()
						PlayerModuleService.setCameraToSubjectDistance(15)
					end)
					if not p1.Passenger then
						if p1.Type == "Chassis" or (p1.Type == "Motorcycle" or (p1.Type == "DuneBuggy" or p1.Make == "Volt")) then
							vector:GiveTask(ActionButtonService.add({
								primary = true,
								priority = 1000,
								saturateTo = 0,
								image = "rbxassetid://7858765663",
								keyCodes = { Enum.KeyCode.W, Enum.KeyCode.Up, Enum.KeyCode.ButtonR2 },
								onPressed = function(p12)
									if p12 ~= Enum.UserInputType.Gamepad1 then
										p1.setForward(true)
									end
								end,
								onReleased = function(p12)
									if p12 ~= Enum.UserInputType.Gamepad1 then
										p1.setForward(false)
									end
								end
							}))
							vector:GiveTask(ActionButtonService.add({
								primary = true,
								priority = 700,
								saturateTo = 0,
								image = "rbxassetid://7858764373",
								keyCodes = { Enum.KeyCode.S, Enum.KeyCode.Down, Enum.KeyCode.ButtonL2 },
								onPressed = function(p12)
									if p12 ~= Enum.UserInputType.Gamepad1 then
										p1.setBackward(true)
									end
								end,
								onReleased = function(p12)
									if p12 ~= Enum.UserInputType.Gamepad1 then
										p1.setBackward(false)
									end
								end
							}))
							if p1.Make ~= "Volt" then
								vector:GiveTask(ActionButtonService.add({
									priority = 600,
									allowTouchSlide = true,
									image = "rbxassetid://4939737110",
									keyCodes = { Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift, Enum.KeyCode.ButtonX },
									onPressed = function()
										Classes.Chassis.setHandbrakeEnabled(true)
									end,
									onReleased = function()
										Classes.Chassis.setHandbrakeEnabled(false)
									end
								}))
							end
							vector:GiveTask(ActionButtonService.add({
								priority = 850,
								image = "rbxassetid://4939737424",
								keyCodes = { Enum.KeyCode.V, Enum.KeyCode.ButtonR1 },
								onPressed = function()
									local isEnabled = RunUtils.isTradeWorld() and workspace:FindFirstChild("DragStripAlignZone")
									local Position = p1.Model:GetPivot().Position
									if isEnabled and RegionUtils.isPointInPart(isEnabled, Position) then
										p1.Model:PivotTo(CFrame.new(Position) * isEnabled.CFrame.Rotation)
									else
										eventBridge:FireServer("llwb2iv8")
									end
								end
							}))
							if not p1.Model:GetAttribute("DisableNitro") then
								vector:GiveTask(ActionButtonService.add({
									priority = 500,
									allowTouchSlide = true,
									image = "rbxassetid://4939740976",
									keyCodes = { Enum.KeyCode.Q, Enum.KeyCode.ButtonL1 },
									onPressed = function()
										StartNitro()
										if v17 then
											v17._isNitroPressed = true
										end
									end,
									onReleased = function()
										StopNitro()
										if v17 then
											v17._isNitroPressed = false
										end
									end
								}))
							end
						elseif p1.Type == "Heli" then
							vector:GiveTask(ActionButtonService.add({
								primary = true,
								priority = 1000,
								saturateTo = 0,
								image = "rbxassetid://4939737716",
								keyCodes = { Enum.KeyCode.E, Enum.KeyCode.ButtonR2 },
								onPressed = function()
									Classes.Heli.setUp(true)
								end,
								onReleased = function()
									Classes.Heli.setUp(false)
								end
							}))
							vector:GiveTask(ActionButtonService.add({
								primary = true,
								priority = 950,
								saturateTo = 0,
								image = "rbxassetid://4939738083",
								keyCodes = { Enum.KeyCode.Q, Enum.KeyCode.ButtonL2 },
								onPressed = function()
									Classes.Heli.setDown(true)
								end,
								onReleased = function()
									Classes.Heli.setDown(false)
								end
							}))
							if p1.Make ~= "UFO" and p1.Make ~= "CrewCapsule" then
								vector:GiveTask(ActionButtonService.add({
									priority = 700,
									image = "rbxassetid://4939738413",
									keyCodes = { Enum.KeyCode.L, Enum.KeyCode.ButtonL1 },
									onPressed = function()
										Classes.Heli.toggleHeadlights(p1)
									end
								}))
							end
						end
						if p1.Model and (p1.Model:FindFirstChild("Model") and (p1.Model.Model:FindFirstChild("Headlights") and p1.Type ~= "Heli")) then
							vector:GiveTask(ActionButtonService.add({
								priority = 450,
								image = "rbxassetid://4939738413",
								keyCodes = { Enum.KeyCode.L, Enum.KeyCode.ButtonY },
								onPressed = function()
									Classes.Chassis.toggleHeadlights()
								end
							}))
						end
						if p1.Model and p1.Model:FindFirstChild("BoundingBox") then
							vector:GiveTask(ActionButtonService.add({
								priority = 800,
								image = "rbxassetid://4939742186",
								keyCodes = { Enum.KeyCode.H, Enum.KeyCode.ButtonL3 },
								onPressed = function()
									HornStart()
								end,
								onReleased = function()
									HornStop()
								end
							}))
						end
						if Make == "Ambulance" or (Make == "Firetruck" or (Make == "Jeep" or (Make == "Boxer" or (Make == "PrisonBus" or (Make == "Longhorn" or (Make == "Laviolette" or (Make == "SWATVan" or (Make == "Tanker" or Make == "AdminNuke")))))))) then
							vector:GiveTask(ActionButtonService.add({
								priority = 400,
								image = "rbxassetid://4939741296",
								keyCodes = { Enum.KeyCode.G, Enum.KeyCode.DPadDown },
								onPressed = function()
									Classes.Chassis.runAction(true)
								end,
								onReleased = function()
									Classes.Chassis.runAction(false)
								end
							}))
						end
						if p1.CanJump then
							local configTable = {
								priority = 400,
								useEvery = v50,
								image = "rbxassetid://4939741296",
								keyCodes = { Enum.KeyCode.G, Enum.KeyCode.DPadDown },
								onPressed = function()
									if Classes.Chassis.runAction("Jump") == true then
										v51 = os.clock()
										return true
									else
										return false
									end
								end
							}
							vector:GiveTask(ActionButtonService.add(configTable))
							if os.clock() - v51 < v50 then
								configTable._lastUsed = v51
								configTable._maid.progress = RunService.Heartbeat:Connect(function()
									local isEnabled = (os.clock() - configTable._lastUsed) / configTable.useEvery
									if isEnabled >= 1 then
										configTable._maid.progress = nil
										configTable.updateProgressBinding(0)
									else
										configTable.updateProgressBinding(isEnabled)
									end
								end)
								vector:GiveTask(configTable._maid.progress)
							end
						end
						if p1.Type == "Chassis" or p1.Type == "Heli" then
							if p1.Missiles and p1.Rockets then
								local configTable = {
									priority = 350,
									image = "rbxassetid://4939740665"
								}
								local configTable = {}
								configTable[1] = p1.Type == "Chassis" and Enum.KeyCode.G or Enum.KeyCode.F
								configTable[2] = Enum.KeyCode.ButtonX
								configTable.keyCodes = configTable
								function configTable.onPressed()
									if p1.Type == "Chassis" then
										Classes.Chassis.AttemptFireMissile(v17)
									else
										Classes.Heli.attemptFireMissile()
									end
								end
								vector:GiveTask(ActionButtonService.add(configTable))
							end
							if p1.Missiles and p1.Bombs then
								vector:GiveTask(ActionButtonService.add({
									priority = 300,
									image = "rbxassetid://7893992893",
									keyCodes = { Enum.KeyCode.B, Enum.KeyCode.ButtonB },
									onPressed = function()
										Classes.Heli.attemptDropBomb()
									end
								}))
							end
						end
						if p1.Make == "TowTruck" or p1.Make == "FrostCrawler" then
							vector:GiveTask(ActionButtonService.add({
								priority = 250,
								image = "rbxassetid://4939739616",
								keyCodes = { Enum.KeyCode.G, Enum.KeyCode.DPadDown },
								onPressed = function()
									VehicleLinkBinder:Get((p1.Model:FindFirstChild("Preset"):FindFirstChild("Crane"):FindFirstChild("MetalHook"))):Unattach()
								end
							}))
						end
					end
					if p1.Model and p1.Model:FindFirstChild("Winch") then
						vector:GiveTask(ActionButtonService.add({
							priority = 750,
							image = "rbxassetid://4939739616",
							keyCodes = { Enum.KeyCode.G, Enum.KeyCode.ButtonY },
							onPressed = function()
								Classes.Heli.attemptDropRope()
							end
						}))
					end
					Humanoid.Sit = true
					vector:GiveTask(Humanoid:GetPropertyChangedSignal("Sit"):Connect(function()
						if not Humanoid.Sit and Humanoid.Health > 0 then
							Humanoid.Sit = true
						end
					end))
					vector:GiveTask(function()
						Humanoid.Sit = false
					end)
					Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
					vector:GiveTask(function()
						Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
					end)
					vector:GiveTask(task.delay(0, function()
						local configTable = {}
						for isEnabled, isEnabled in Character:GetChildren() do
							if isEnabled:IsA("BasePart") and (isEnabled.CanCollide and (isEnabled.Name == "LowerTorso" or (isEnabled.Name == "UpperTorso" or isEnabled.Name == "HumanoidRootPart"))) then
								table.insert(configTable, isEnabled)
								isEnabled.CanCollide = false
							end
						end
						vector:GiveTask(function()
							for isEnabled, isEnabled in configTable do
								isEnabled.CanCollide = true
							end
						end)
					end))
					if not p1.Passenger then
						for i, v in ipairs(p1.Model:GetChildren()) do
							local PlayerName = v:FindFirstChild("PlayerName")
							if PlayerName then
								local function handleSeat(p12)
									local isEnabled = Players:FindFirstChild(p12)
									if isEnabled and isEnabled ~= LocalPlayer then
										local isEnabled = Maid.new()
										vector[v] = isEnabled
										local Humanoid = isEnabled.Character:FindFirstChild("Humanoid")
										Humanoid.Sit = true
										isEnabled:GiveTask(Humanoid:GetPropertyChangedSignal("Sit"):Connect(function()
											if not Humanoid.Sit and Humanoid.Health > 0 then
												Humanoid.Sit = true
											end
										end))
										if p1.Make == "Hammerhead" then
											isEnabled:GiveTask(PartUtils.setPropertyWithRollback(isEnabled.Character, "CollisionGroup", "NoOtherVehicles"))
										end
									else
										vector[v] = nil
									end
								end
								handleSeat(PlayerName.Value)
								vector:GiveTask(PlayerName.Changed:Connect(handleSeat))
							end
						end
						if p1.Make == "Hammerhead" then
							vector:GiveTask(PartUtils.setPropertyWithRollback(p1.Model, "CollisionGroup", "NoOtherVehicles"))
							vector:GiveTask(PartUtils.setPropertyWithRollback(Character, "CollisionGroup", "NoOtherVehicles"))
						end
					end
					local vehicleClass = Classes[Make]
					if targetPlayer and vehicleClass.vehicleEnter then
						vehicleClass.vehicleEnter(p1)
					elseif p1.Type == "Chassis" then
						Classes.Chassis.VehicleEnter(p1)
					elseif p1.Type == "Heli" then
						Classes.Heli.VehicleEnter(p1)
					elseif p1.Type == "Motorcycle" or p1.Type == "DuneBuggy" then
						Classes.Chassis2.VehicleEnter(p1)
					elseif p1.Type == "Custom" and p1.Make == "Volt" then
						Classes.Volt.VehicleEnter(p1)
					end
					if p1.Passenger then
						p1.Nitro = false
					end
					v17 = p1
					if v17.Seats ~= nil then
						local cframe = VehicleSystem.GetPlayerSeat(v17, LocalPlayer)
						if cframe then
							currentVehiclePacket.Passenger = cframe.Driver ~= true
						end
					end
					VehicleUtils.OnVehicleEntered:Fire(p1, p1.Passenger)
				end
			end
		else
			warn("failed to find vehicle seat. aborting.")
		end
	end
	VehicleUtils.OnVehicleEntered:Connect(function(p1)
		local seatMaid = p1.seatMaid
		if not p1.Passenger then
			local function handleLights(p1)
				if p1 then
					seatMaid.sirensButton = ActionButtonService.add({
						priority = 450,
						image = "rbxassetid://4939739355",
						keyCodes = { Enum.KeyCode.F, Enum.KeyCode.ButtonB },
						onPressed = function()
							Classes.Chassis.toggleSirens()
						end
					})
				else
					seatMaid.sirensButton = nil
				end
			end
			seatMaid.sirensButton = nil
			if p1.Model and (p1.Model:FindFirstChild("Model") and p1.Type ~= "Heli") then
				seatMaid:GiveTask(RxInstanceUtils.observeOneChildNamed(p1.Model.Model, "Lights", handleLights))
			end
		end
		if not p1.Passenger then
			local function handleCamToggle(p1)
				if p1 then
					seatMaid.camToggleButton = ActionButtonService.add({
						priority = 550,
						image = "rbxassetid://4939741662",
						keyCodes = { Enum.KeyCode.C, Enum.KeyCode.ButtonR3 },
						onPressed = function()
							Classes.Chassis.toggleInsideCamera()
						end
					})
				else
					seatMaid.camToggleButton = nil
				end
			end
			seatMaid.camToggleButton = nil
			seatMaid:GiveTask(RxInstanceUtils.observeOneChildNamed(p1.Model, "InsideCamera", handleCamToggle))
		end
	end)
	function configTable.iokrerkc()
		if v52 then
			v52:cancel()
		end
		if v17 then
			VehicleUtils.OnVehicleJumpExited:Fire(v17)
			local isEnabled = v17
			local Type = isEnabled.Type
			local Make = isEnabled.Make
			v17 = nil
			if isEnabled.Nitro then
				StopNitro()
			end
			isEnabled.Nitro = false
			if isEnabled.Nitrous then
				for isEnabled, func in next, isEnabled.Nitrous do
					func.Enabled = false
				end
			end
			if isEnabled.IsCameraLocked then
				Classes.Chassis.toggleInsideCamera(isEnabled)
			end
			local cframe = Classes[Make]
			if cframe and cframe.vehicleLeave then
				cframe.vehicleLeave(isEnabled)
			elseif Type == "Chassis" then
				Classes.Chassis.VehicleLeave(isEnabled)
			elseif Type == "Heli" then
				Classes.Heli.VehicleLeave(isEnabled)
			elseif Type == "Motorcycle" or Type == "DuneBuggy" then
				Classes.Chassis2.VehicleLeave(isEnabled)
			elseif Type == "Custom" and Make == "Volt" then
				Classes.Volt.VehicleLeave(isEnabled)
			end
			isEnabled.seatMaid:Destroy()
			isEnabled.seatMaid = nil
			local vector = ItemSystem.GetLocalEquipped()
			if vector and vector.IsLeaning then
				vector:SetLeaning(false)
			end
			VehicleUtils.OnVehicleExited:Fire(isEnabled, isEnabled.Passenger)
			if InputUtils.isTouch() then
				v19 = true
				if (DefaultActions.sprintButton._pressed and true or false) ~= true and DefaultActions.sprintButton._pressState then
					DefaultActions.sprintButton._pressState()
				end
			end
			VehicleUtils.fixNetworkingCharacters()
		end
	end
	VehicleUtils.OnVehicleJumpExited:Connect(function(p1)
		local Character = LocalPlayer.Character
		if Character then
			for isEnabled, isEnabled in Character:GetDescendants() do
				if isEnabled:IsA("JointInstance") or isEnabled:IsA("AnimationConstraint") then
					local JointC0 = isEnabled:FindFirstChild("JointC0")
					if JointC0 then
						ConstraintUtils.setJointC0(isEnabled, JointC0.Value)
					end
					local JointC1 = isEnabled:FindFirstChild("JointC1")
					if JointC1 then
						ConstraintUtils.setJointC1(isEnabled, JointC1.Value)
					end
				end
			end
		end
		local seatMaid = p1.seatMaid
		if seatMaid then
			task.defer(seatMaid.DoCleaning, seatMaid)
		end
		if not seatMaid or (not seatMaid._tasks or #seatMaid._tasks ~= 0) then
			if Character then
				local Humanoid = Character:FindFirstChild("Humanoid")
				if Humanoid and Character.PrimaryPart then
					local func = Humanoid:GetPropertyChangedSignal("Sit"):Connect(function()
						if not Humanoid.Sit then
							Humanoid.Sit = true
						end
					end)
					Humanoid.Sit = true
					task.delay(0.3, function()
						func:Disconnect()
						Humanoid.Sit = false
						Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
					end)
				end
			end
			if p1.SeatWeld then
				p1.SeatWeld:Destroy()
				p1.SeatWeld = nil
			end
			local BoundingBox = p1.Model:FindFirstChild("BoundingBox")
			if Character and Character.PrimaryPart then
				local cframe = if p1.Model and BoundingBox then Character.PrimaryPart.CFrame:ToObjectSpace(BoundingBox.CFrame * CFrame.new(0, BoundingBox.Size.Y * 0.5, 0)).Y else 0
				local vector = RaycastParams.new()
				local configTable = { workspace:FindFirstChild("Vehicles") }
				for cframe, RemoteEvent in Players:GetPlayers() do
					table.insert(configTable, RemoteEvent.Character)
				end
				vector.FilterDescendantsInstances = configTable
				local vector = workspace:Raycast(Character.PrimaryPart.Position, Vector3.new(0, cframe + 6, 0), vector)
				Character:SetPrimaryPartCFrame(Character.PrimaryPart.CFrame + Vector3.new(0, if vector then math.max(0, vector.Distance - 2) else cframe + 6, 0))
			end
		end
	end)
	function configTable.bmel6swz(p1)
		if v17 then
			for isEnabled, isEnabled in next, p1 do
				v17[isEnabled] = isEnabled
			end
		end
	end
	function configTable.d41xtwyc()
		if v17 then
			if currentVehiclePacket.Type == "Heli" then
				Classes.Heli.FallOutOfSky(v17)
			end
		end
	end
	function configTable.plgep10a(p1)
		if v17 then
			if currentVehiclePacket.Type == "Chassis" then
				Classes.Chassis.SpinOut(v17, p1)
			else
				error(("Cannot spin-out vehicle type: %s"):format(currentVehiclePacket.Type))
			end
		else
			error("no vehicle packet")
		end
	end
	function configTable.rptw1jn9(p1)
		local CrashParticles = Instance.new("Part")
		CrashParticles.Name = "CrashParticles"
		CrashParticles.Transparency = 1
		CrashParticles.Anchored = true
		CrashParticles.CanCollide = false
		CrashParticles.CFrame = p1.CFrame + p1.Parent.Engine.CFrame.LookVector * 5
		CrashParticles.Size = p1.Size
		CrashParticles.Parent = workspace
		local isEnabled = ReplicatedStorage.Resource.CrashParticle:Clone()
		isEnabled.Parent = CrashParticles
		isEnabled:Emit(8)
		wait()
		isEnabled:Emit(8)
		wait()
		isEnabled:Emit(8)
		wait()
		game.Debris:AddItem(CrashParticles, 5)
	end
	function configTable.g98unpiy()
		local Character = LocalPlayer.Character
		if Character then
			local PrimaryPart = Character.PrimaryPart
			if PrimaryPart then
				if v17 then
					PrimaryPart.Velocity = PrimaryPart.Velocity * 0.5
					PrimaryPart.RotVelocity = PrimaryPart.RotVelocity * 0.5
				else
					PrimaryPart.Velocity = Vector3.new()
					PrimaryPart.RotVelocity = Vector3.new()
				end
			end
		end
	end
end
function configTable.y3fq4f5f()
	isEnabled.FaultyAction.Visible = true
	wait(4)
	isEnabled.FaultyAction.Visible = false
end
local proximityQueue
do
	local function Ease_inOutQuad(p1, p2, p3, p4)
		local isEnabled = p1 / p4 * 2
		if isEnabled < 1 then
			return p3 * 0.5 * isEnabled * isEnabled + p2
		else
			return -p3 * 0.5 * ((isEnabled - 1) * (isEnabled - 3) - 1) + p2
		end
	end
	proximityQueue = {}
	local insert = table.insert
	local remove = table.remove
	local configTable = {}
	function proximityQueue.AddPart(p1, p2, p3, p4)
		local configTable = {
			Part = p1,
			Distance = p2,
			f = p3,
			Meta = p4
		}
		table.insert(configTable, configTable)
		return configTable
	end
	function proximityQueue.RemoveTag(p1)
		for i = #configTable, 1, -1 do
			if configTable[i].Meta.Tag == p1 then
				table.remove(configTable, i)
				return true
			end
		end
		return false
	end
	local configTable = {}
	local configTable = {}
	local function UpdateInterest()
		local Character = LocalPlayer.Character
		if Character then
			local PrimaryPart = Character.PrimaryPart
			if PrimaryPart then
				local Humanoid = Character:FindFirstChild("Humanoid")
				if Humanoid then
					if not (Humanoid.Health <= 0) then
						proximityQueue.UpdateInterest(PrimaryPart.Position)
					end
				end
			end
		end
	end
	function proximityQueue.UpdateInterest(p1)
		local Character = LocalPlayer.Character
		if Character then
			local PrimaryPart = Character.PrimaryPart
			if PrimaryPart then
				local Humanoid = Character:FindFirstChild("Humanoid")
				if Humanoid and not (Humanoid.Health <= 0) then
					proximityQueue.UpdateInterest(PrimaryPart.Position)
				end
			end
		end
		configTable = {}
		configTable = {}
		for i = #configTable, 1, -1 do
			if not configTable[i].Part then
				table.remove(configTable, i)
			end
		end
		for isEnabled, isEnabled in next, configTable do
			isEnabled.Center = isEnabled.Part.Position
			local magnitude = (isEnabled.Center - p1).magnitude
			isEnabled.Sort = magnitude
			local func = magnitude < isEnabled.Distance
			if isEnabled.Locked then
				func = true
			end
			local Loaded = isEnabled.Loaded
			if func and not Loaded then
				insert(configTable, isEnabled)
			elseif not func and Loaded then
				insert(configTable, isEnabled)
			end
		end
	end
	local function ProcessQueue()
		while #configTable > 0 do
			local isEnabled = remove(configTable, 1)
			isEnabled.Loaded = true
			isEnabled:f(isEnabled.Loaded)
		end
		while #configTable > 0 do
			local isEnabled = remove(configTable)
			isEnabled.Loaded = false
			isEnabled:f(isEnabled.Loaded)
		end
	end
	function proximityQueue.Run(p1)
		ThreadLoopAdd(p1, ProcessQueue, "Proximity Queue")
	end
	proximityQueue.Run(0.1)
end
do
	local buttonYClone = ReplicatedStorage.Resource.ButtonY:Clone()
	local configTable = {}
	local function ProximityUpdate(p1, p2)
		if p2 then
			table.insert(configTable, Math.BinaryFind(configTable, p1.Sort), p1)
		else
			for i = #configTable, 1, -1 do
				if configTable[i] == p1 then
					table.remove(configTable, i)
					break
				end
			end
		end
		local func = configTable[1]
		if func and Enum.UserInputType.Gamepad1 == nil then
			v53.Parent = func.Meta.Button
		else
			v53.Parent = nil
		end
	end
	local function AddContextButton(p1, p2, p3, p4)
		return proximityQueue.AddPart(p1, p2, ProximityUpdate, {
			Callback = p3,
			Tag = p4
		})
	end
	local function RemoveContextButtonByTag(p1)
		return proximityQueue.RemoveTag(p1)
	end
	local function ContextProcessInput(p1)
		local isEnabled = false
		if p1.UserInputType == Enum.UserInputType.Gamepad1 then
			if p1.KeyCode == Enum.KeyCode.ButtonY then
				isEnabled = true
			end
		elseif p1.UserInputType == Enum.UserInputType.Keyboard and p1.KeyCode == Enum.KeyCode.Y then
			isEnabled = true
		end
		if isEnabled then
			local isEnabled = configTable[1]
			if isEnabled then
				for func, cframe in next, configTable do
					if cframe.Meta.Button == isEnabled.Meta.Button then
						coroutine.resume(coroutine.create(function()
							cframe.Meta.Callback(LocalPlayer)
						end))
					end
				end
			end
		end
	end
	local function InputBegan(p1, p2)
		if not p2 then
			ContextProcessInput(p1)
		end
	end
	UserInputService.InputBegan:connect(InputBegan)
	local function FindDoorLight(p1)
		local Model = p1:FindFirstChild("Model")
		local Light = p1:FindFirstChild("Light")
		if Light and (Light:IsA("ObjectValue") and (Light.Value and Light.Value:IsA("BasePart"))) then
			return Light.Value
		end
		if Model and Model:FindFirstChild("Light") then
			return Model.Light
		end
	end
	local function FunSlide(p1)
		local Open = p1.State.Open
		local Model = p1.Model
		RxInstanceUtils.yieldForProperty(Model.Model, "PrimaryPart")
		local isEnabled = FindDoorLight(Model)
		local OpenCFrame = p1.OpenCFrame
		local ClosedCFrame = p1.ClosedCFrame
		local function Finished()
			if Open then
				Model.Model:SetPrimaryPartCFrame(OpenCFrame)
			else
				Model.Model:SetPrimaryPartCFrame(ClosedCFrame)
				if isEnabled then
					isEnabled.Color = Color3.fromRGB(163, 75, 75)
				end
			end
		end
		if p1.State.NoAnimate then
			p1.State.NoAnimate = false
			return Finished()
		end
		if Open and isEnabled then
			isEnabled.Color = Color3.fromRGB(102, 137, 172)
		end
		local doorMaid = p1.doorMaid
		local isEnabled = 0
		local Duration = p1.Settings.Duration
		local function onHeartbeat(p1)
			isEnabled = isEnabled + p1 * 1 / Duration
			local cframe = isEnabled / 1 * 2
			local count = if cframe < 1 then 0.5 * cframe * cframe + 0 else -0.5 * ((cframe - 1) * (cframe - 3) - 1) + 0
			if not Open then
				count = 1 - count
			end
			Model.Model:SetPrimaryPartCFrame(ClosedCFrame:lerp(OpenCFrame, count))
			if isEnabled >= 1 then
				doorMaid.Stepped = nil
				if Open then
					Model.Model:SetPrimaryPartCFrame(OpenCFrame)
					return
				end
				Model.Model:SetPrimaryPartCFrame(ClosedCFrame)
				if isEnabled then
					isEnabled.Color = Color3.fromRGB(163, 75, 75)
				end
			end
		end
		doorMaid.Stepped = RunService.Heartbeat:connect(onHeartbeat)
	end
	local function FunSwing(p1)
		local Open = p1.State.Open
		local Model = p1.Model
		RxInstanceUtils.yieldForProperty(Model.Model, "PrimaryPart")
		local isEnabled = FindDoorLight(Model)
		local ClosedCFrame = p1.ClosedCFrame
		local HingeRelativeCFrame = p1.HingeRelativeCFrame
		local vector = func(0, 1.7278759594743864 * (p1.State.Direction * p1.Direction), 0)
		local function Finished()
			if Open then
				Model.Model:SetPrimaryPartCFrame(ClosedCFrame * HingeRelativeCFrame * Math.CFrameFromAxisAngle(vector) * HingeRelativeCFrame:inverse())
			else
				Model.Model:SetPrimaryPartCFrame(ClosedCFrame)
				if isEnabled then
					isEnabled.Color = Color3.fromRGB(163, 75, 75)
				end
			end
		end
		if p1.State.NoAnimate then
			p1.State.NoAnimate = false
			return Finished()
		end
		if Open and isEnabled then
			isEnabled.Color = Color3.fromRGB(102, 137, 172)
		end
		local doorMaid = p1.doorMaid
		local cframe = 0
		local Duration = p1.Settings.Duration
		local function onHeartbeat(p1)
			cframe = cframe + p1 * 1 / Duration
			local isEnabled = cframe / 1 * 2
			local count = if isEnabled < 1 then 0.5 * isEnabled * isEnabled + 0 else -0.5 * ((isEnabled - 1) * (isEnabled - 3) - 1) + 0
			if not Open then
				count = 1 - count
			end
			Model.Model:SetPrimaryPartCFrame(ClosedCFrame * HingeRelativeCFrame * Math.CFrameFromAxisAngle((Vector3.new(0, 0, 0)):lerp(vector, count)) * HingeRelativeCFrame:inverse())
			if cframe >= 1 then
				doorMaid.Stepped = nil
				return Finished()
			end
		end
		doorMaid.Stepped = RunService.Heartbeat:connect(onHeartbeat)
	end
	local function OpenDoor(p1, p2)
		if p1.Resolved then
			if p2 then
				p1.State.NoAnimate = true
			end
			p1.State.Open = true
			if p1.OpenFun then
				p1:OpenFun()
			end
		else
			p1.AwaitingDoorOpen = true
			p1.AwaitingDoorClose = false
		end
	end
	local function CloseDoor(p1, p2)
		if p1.Resolved then
			if p2 then
				p1.State.NoAnimate = true
			end
			p1.State.Open = false
			p1.State.CloseTime = os.time()
			if p1.CloseFun then
				p1:CloseFun()
			end
		else
			p1.AwaitingDoorOpen = false
			p1.AwaitingDoorClose = true
		end
	end
	local configTable = {}
	local function DoorSequence(p1)
		if not (p1.Settings.SequenceRequireState and p1.State.Open) then
			if p1.Resolved then
				p1.State.Open = true
				if p1.OpenFun then
					p1:OpenFun()
				end
			else
				p1.AwaitingDoorOpen = true
				p1.AwaitingDoorClose = false
			end
			eventBridge:FireServer("jvsapna5", p1)
		end
	end
	local function HasPerm_2(p1, p2, p3, p4)
		if p1.Settings.ServerOnly or p1.Settings.Locked then
			return false
		else
			local isEnabled = (p3:FindFirstChild("Humanoid").Sit or p3:GetAttribute("InVehicle")) and true or false
			local isEnabled = false
			if p1.Settings.Vehicle and not p1.Settings.Character then
				isEnabled = isEnabled
			elseif p1.Settings.Character and not p1.Settings.Vehicle then
				isEnabled = not isEnabled
			elseif p1.Settings.Character and p1.Settings.Vehicle then
				isEnabled = true
			end
			if p4 then
				isEnabled = true
			end
			local func = PlayerUtils.hasKey()
			if p1.Settings.Key then
				isEnabled = isEnabled and func
			end
			if p1.Settings.Team and p1.Settings.Team == "Prisoner" then
				isEnabled = isEnabled and if p2.TeamValue.Value == p1.Settings.Team then true else InventoryItemSystem.playerHasItem(p2, "CrimeKey")
			elseif p1.Settings.Team then
				isEnabled = isEnabled and p2.TeamValue.Value == p1.Settings.Team
			end
			if p1.Settings.TeamBlacklist then
				isEnabled = isEnabled and p2.TeamValue.Value ~= p1.Settings.TeamBlacklist
			end
			return isEnabled
		end
	end
	local function RegisterDoor(p1)
		assert(p1.Resolved)
		local Model = p1.Model
		local isEnabled = tick()
		local isEnabled = tick()
		local function DoorPlayer(p12)
			local isEnabled = tick()
			local Character = LocalPlayer.Character
			if Character and Character.PrimaryPart then
				if isEnabled - isEnabled < 0.1 then
					return
				end
				isEnabled = isEnabled
				if p1.State.Open or os.time() - p1.State.CloseTime < p1.Settings.Duration then
					return
				end
				local hasPermission = HasPerm_2(p1, LocalPlayer, Character, p12)
				if p1.Settings.Character then
					if hasPermission then
						PlaySound("Door", {
							Source = Model.Closed,
							TimeStart = 1,
							Volume = 0.2
						})
					else
						PlaySound("Door", {
							Source = Model.Closed,
							TimeStart = 0,
							MaxTime = 0.6,
							Volume = 0.2
						})
					end
				end
				if hasPermission then
					if p1.Settings.Type == "Swing" then
						p1.State.Direction = if (p1.Model.Closed.Position - Character.HumanoidRootPart.Position).unit:Dot(p1.Model.Closed.CFrame.lookVector) > 0 then 1 else -1
					end
					DoorSequence(p1)
				end
			end
		end
		local function Touched(p1)
			local cframe = tick()
			if not (cframe - isEnabled < 1/30) then
				isEnabled = cframe
				DoorPlayer()
			end
		end
		local function MouseClick(p1)
			if p1 == LocalPlayer then
				DoorPlayer(true)
			end
		end
		if p1.doorMaid ~= nil then
			print(Model:GetFullName())
			error("Door already has a door maid.. what happened?")
		end
		local func = Maid.new()
		p1.doorMaid = func
		for cframe, vector in Model:GetChildren() do
			if vector:IsA("BasePart") and vector.Name == "Touch" then
				table.insert(configTable, {
					Tag = p1.Tag,
					Part = vector,
					Fun = Touched,
					_DEBUG = "DoorTouchPart"
				})
			elseif vector:IsA("ObjectValue") and vector.Name == "Touch" then
				local configTable = {
					Tag = p1.Tag,
					Part = vector.Value,
					Fun = Touched,
					_DEBUG = "DoorTouchObjValue"
				}
				func:GiveTask(vector.Changed:Connect(function(p1)
					configTable.Part = p1
				end))
				table.insert(configTable, configTable)
			elseif vector:IsA("ObjectValue") and vector.Name == "Button" then
				local vector = Maid.new()
				func:GiveTask(vector)
				local function processButton()
					vector:DoCleaning()
					if vector.Value then
						local isEnabled = vector.Value
						assert(isEnabled:IsA("BasePart"), "missing button part")
						local ClickDetector = isEnabled:WaitForChild("ClickDetector", 5)
						assert(ClickDetector, "missing button click detector")
						AddContextButton(isEnabled, ClickDetector.MaxActivationDistance, MouseClick, p1.Tag).Meta.Button = isEnabled
						func:GiveTask(ClickDetector.MouseClick:Connect(MouseClick))
						func:GiveTask(function()
							RemoveContextButtonByTag(p1.Tag)
						end)
					end
				end
				task.spawn(processButton)
				func:GiveTask(vector.Changed:Connect(processButton))
			end
		end
	end
	local function UnregisterDoor(p1)
		assert(not p1.Resolved)
		local Tag = p1.Tag
		for i = #configTable, 1, -1 do
			if configTable[i].Tag == Tag then
				table.remove(configTable, i)
			end
		end
		proximityQueue.RemoveTag(Tag)
		if p1.doorMaid then
			p1.doorMaid:DoCleaning()
			p1.doorMaid = nil
		end
	end
	local function AddedFun(p1)
		local isEnabled = 0
		table.insert(configTable, {
			Part = p1,
			Fun = function(p12)
				if not (tick() - isEnabled < 1) then
					isEnabled = tick()
					eventBridge:FireServer("ikz2ki8m", p1)
				end
			end,
			_DEBUG = "OtherTrigger"
		})
	end
	local function RemovedFun(p1)
		for i = #configTable, 1, -1 do
			if configTable[i].Part == p1 then
				table.remove(configTable, i)
				break
			end
		end
		return true
	end
	local touchTriggerIterator = next
	local touchTriggers, _ = CollectionService:GetTagged("TouchTrigger")
	local configTable = {}
	for v57, v58 in touchTriggerIterator, v55, for _, door in touchTriggers do
		AddedFun(v58)
	end
	CollectionService:GetInstanceAddedSignal("TouchTrigger"):Connect(AddedFun)
	CollectionService:GetInstanceRemovedSignal("TouchTrigger"):Connect(RemovedFun)
	local CircleAction = UI.CircleAction
	local function AddHatch(p1)
		local SewerHatch = p1:FindFirstChild("SewerHatch")
		local isEnabled = assert(SewerHatch, "missing SewerHatch")
		local function Action(p1, p2)
			if p2 then
				eventBridge:FireServer("configTabletisol66", "SewerHatch", isEnabled)
			end
			return true
		end
		if p1:FindFirstChild("FromTop").Value then
			CircleAction.Add({
				Part = isEnabled,
				Name = "Pull Open",
				Timed = true,
				Duration = 3,
				Dist = 10,
				Callback = Action
			}, p1)
		end
		table.insert(configTable, {
			Tag = p1,
			Part = p1:FindFirstChild("Touch"),
			Fun = function()
				return Action(nil, true)
			end,
			_DEBUG = "SewerHatch"
		})
	end
	local function RemoveHatch(p1)
		CircleAction.Remove(p1)
		for i = #configTable, 1, -1 do
			if configTable[i].Tag == p1 then
				table.remove(configTable, i)
				return
			end
		end
	end
	local sewerHatchIterator = next
	local sewerHatches, _ = CollectionService:GetTagged("SewerHatch")
	for v62, v63 in sewerHatchIterator, v60, for _, hatch in sewerHatches do
		AddHatch(v63)
	end
	CollectionService:GetInstanceAddedSignal("SewerHatch"):Connect(AddHatch)
	CollectionService:GetInstanceRemovedSignal("SewerHatch"):Connect(RemoveHatch)
	ThreadLoopAdd(1/6, function()
		local Character = LocalPlayer.Character
		if Character then
			local PrimaryPart = Character.PrimaryPart
			if PrimaryPart then
				local Position = PrimaryPart.Position
				for isEnabled, isEnabled in next, configTable do
					if isEnabled.Part and isEnabled.Part:IsDescendantOf(workspace) then
						if Math.IsPointInPrism(Position, isEnabled.Part.CFrame, isEnabled.Part.Size + Vector3.new(4, 6, 4)) then
							isEnabled.Fun(PrimaryPart)
						end
					else
						warn("TouchQueue has invalid part", isEnabled._DEBUG)
					end
				end
			end
		end
	end)
	local function AddedFun_2(p1)
		local isEnabled = p1:WaitForChild("Tag", 5).Value
		for isEnabled, func in next, configTable do
			if func.Tag == isEnabled and func.Model ~= p1 then
				assert(func.Resolved ~= true, "Door was already resolved:" .. p1:GetFullName())
				func.Resolved = true
				func.Model = p1
				if func.AwaitingDoorOpen or func.State.Open then
					if func.Resolved then
						func.State.NoAnimate = true
						func.State.Open = true
						if func.OpenFun then
							func:OpenFun()
						end
					else
						func.AwaitingDoorOpen = true
						func.AwaitingDoorClose = false
					end
				elseif func.AwaitingDoorClose or not func.State.Open then
					if func.Resolved then
						func.State.NoAnimate = true
						func.State.Open = false
						func.State.CloseTime = os.time()
						if func.CloseFun then
							func:CloseFun()
						end
					else
						func.AwaitingDoorOpen = false
						func.AwaitingDoorClose = true
					end
				end
				RegisterDoor(func)
				return true
			end
		end
		return false
	end
	local function RemovedFun_2(p1)
		for isEnabled, isEnabled in next, configTable do
			if isEnabled.Model == p1 then
				assert(isEnabled.Resolved == true, "Door was not resolved:" .. p1:GetFullName())
				isEnabled.Resolved = false
				isEnabled.Model = nil
				UnregisterDoor(isEnabled)
				return true
			end
		end
		return false
	end
	local doorIterator = next
	local doors, _ = CollectionService:GetTagged("Door")
	for v67, v68 in doorIterator, v65, for _, door in doors do
		task.spawn(AddedFun_2, v68)
	end
	CollectionService:GetInstanceAddedSignal("Door"):Connect(AddedFun_2)
	CollectionService:GetInstanceRemovedSignal("Door"):Connect(RemovedFun_2)
	local configTable = {}
	local function ResolveRealDoor(p1)
		for isEnabled, isEnabled in next, configTable do
			if isEnabled.Tag == p1 then
				return isEnabled
			end
		end
		return false
	end
	local function ReceiveDoor(p1, p2)
		assert(p1.Tag)
		local Tag_2 = p1.Tag
		local isEnabled = false
		for isEnabled, func in next, configTable do
			if func.Tag == Tag_2 then
				isEnabled = func
				break
			end
		end
		if isEnabled then
			isEnabled.Settings = p1.Settings
			isEnabled.AwaitingDoorOpen = p1.AwaitingDoorOpen
			isEnabled.AwaitingDoorClose = p1.AwaitingDoorClose
			p1 = isEnabled
		else
			if p1.Settings.Type == "Swing" then
				p1.OpenFun = FunSwing
				p1.CloseFun = FunSwing
			elseif p1.Settings.Type == "Slide" then
				p1.OpenFun = FunSlide
				p1.CloseFun = FunSlide
			end
			if p1.State.Open then
				p1.AwaitingDoorOpen = true
			else
				p1.AwaitingDoorClose = true
			end
			table.insert(configTable, p1)
		end
		local vector = configTable[p1.Tag]
		configTable[p1.Tag] = nil
		if vector then
			p1.State = vector.State
			p1.Settings = vector.Settings
			p1.AwaitingDoorOpen = vector.AwaitingDoorOpen
			p1.AwaitingDoorClose = vector.AwaitingDoorClose
		end
		if not p2 then
			local cframe = next
			local RemoteEvent, vector = CollectionService:GetTagged("Door")
			for isEnabled, cframe in cframe, RemoteEvent, vector do
				AddedFun_2(cframe)
			end
		end
	end
	local function ReceiveDoors(p1)
		for isEnabled, isEnabled in next, p1 do
			ReceiveDoor(isEnabled, true)
		end
		local func = next
		local cframe, vector = CollectionService:GetTagged("Door")
		for cframe, RemoteEvent in func, cframe, vector do
			AddedFun_2(RemoteEvent)
		end
	end
	function configTable.x21krqbh(p1)
		local Tag = p1.Tag
		local isEnabled = false
		for isEnabled, func in next, configTable do
			if func.Tag == Tag then
				isEnabled = func
				break
			end
		end
		if isEnabled then
			isEnabled.State = p1.State
			isEnabled.Settings = p1.Settings
			if isEnabled.Resolved then
				isEnabled.State.Open = true
				if isEnabled.OpenFun then
					isEnabled:OpenFun()
				end
			else
				isEnabled.AwaitingDoorOpen = true
				isEnabled.AwaitingDoorClose = false
			end
		else
			p1.AwaitingDoorOpen = true
			p1.AwaitingDoorClose = false
			configTable[Tag] = p1
		end
	end
	function configTable.nhdevbul(p1)
		local Tag = p1.Tag
		local isEnabled = false
		for isEnabled, func in next, configTable do
			if func.Tag == Tag then
				isEnabled = func
				break
			end
		end
		if isEnabled then
			isEnabled.State = p1.State
			isEnabled.Settings = p1.Settings
			if isEnabled.Resolved then
				isEnabled.State.Open = false
				isEnabled.State.CloseTime = os.time()
				if isEnabled.CloseFun then
					isEnabled:CloseFun()
				end
			else
				isEnabled.AwaitingDoorOpen = false
				isEnabled.AwaitingDoorClose = true
			end
		else
			p1.AwaitingDoorOpen = false
			p1.AwaitingDoorClose = true
			configTable[Tag] = p1
		end
	end
	function configTable.t3cnaqbl(p1)
		ReceiveDoor(p1)
	end
	function configTable.heexoe0u(p1)
		ReceiveDoors(p1)
	end
end
do
	local configTable = {
		name = "robberyMusic",
		title = "Robbery Music",
		type = gameSettingType.Slider,
		defaultValue = 100,
		order = 10,
		min = 0,
		max = 100,
		step = 1,
		textMap = function(p1)
			return ("%d%%"):format(p1)
		end
	}
	GameSettingsService.add(configTable)
	local function handleSetting_3(p1)
		SoundService.RobberyMusic.Volume = math.clamp(p1 / 100, 0, 1)
	end
	handleSetting_3(configTable:getValue())
	configTable.onChanged:Connect(handleSetting_3)
	local configTable = {
		name = "otherRadios",
		title = "Other Radios",
		type = gameSettingType.Slider,
		defaultValue = 100,
		order = 11,
		min = 0,
		max = 100,
		step = 1,
		textMap = function(p1)
			return ("%d%%"):format(p1)
		end
	}
	GameSettingsService.add(configTable)
	local function handleSetting_4(p1)
		SoundService.OtherRadios.Volume = math.clamp(p1 / 100, 0, 1)
	end
	handleSetting_4(configTable:getValue())
	configTable.onChanged:Connect(handleSetting_4)
	local configTable = {
		name = "lightShadows",
		title = "Light Shadows",
		type = gameSettingType.Checkbox,
		defaultValue = true,
		order = 500
	}
	GameSettingsService.add(configTable)
	local isEnabled = true
	local function handleSetting_5(p1)
		isEnabled = p1
		for isEnabled, isEnabled in CollectionService:GetTagged("ShadowLight") do
			isEnabled.Shadows = p1
		end
	end
	configTable.onChanged:Connect(handleSetting_5)
	CollectionService:GetInstanceAddedSignal("ShadowLight"):Connect(function(p1)
		p1.Shadows = isEnabled
	end)
end
do
	local configTable = {
		name = "sunShadows",
		title = "Sun Shadows",
		type = gameSettingType.Checkbox,
		defaultValue = true,
		noSave = true,
		order = 510
	}
	GameSettingsService.add(configTable)
	local function handleSetting_6(p1)
		game:GetService("Lighting").GlobalShadows = p1
	end
	handleSetting_6(configTable:getValue())
	configTable.onChanged:Connect(handleSetting_6);
	(function()
		return (""):sub(-1, 1)
	end)()
	local configTable = {}
	if not isEnabled or isEnabled and Settings.Test.Ambient then
		for v70, v71 in next, Settings.AmbientIds do
			local Sound = Instance.new("Sound")
			Sound.SoundId = "rbxassetid://" .. v71
			Sound.Name = v70
			Sound.Looped = true
			Sound.SoundGroup = SoundService.Ambient
			Sound.Parent = SoundService.Ambient
			configTable[v70] = Sound
		end
	end
	local function SetVolume(p1)
		for isEnabled, isEnabled in next, configTable do
			local func = p1[isEnabled] or 0
			if isEnabled.IsPlaying or not (func > 0.01) then
				if isEnabled.IsPlaying and func <= 0.01 then
					isEnabled:Stop()
				end
			else
				isEnabled:Play()
			end
			isEnabled.Volume = func
		end
	end
	local MinimapService = require(ReplicatedStorage.App.MinimapService)
	if EnvironmentUtils.getTimeOfDay() == EnvironmentConsts.TIME_OF_DAY_ENUM.Day then
		SetVolume((LerpTable(Settings.Ambient.Day, Settings.Ambient.Day, 1)))
	else
		SetVolume((LerpTable(Settings.Ambient.Night, Settings.Ambient.Night, 1)))
		MinimapService.updateMapImageColor3(Settings.Ambient.Night.Minimap)
	end
	local function SetSettings(p1, p2)
		local Main = PlayerGui:FindFirstChild("Main")
		local isEnabled = if Main then Main.Frame.Vig else nil
		local isEnabled = 0
		local func = nil
		local cframe = os.clock()
		local function Heartbeat()
			local cframe = os.clock()
			local rainfallOffset = cframe - cframe
			cframe = cframe
			isEnabled = isEnabled + rainfallOffset * 1 / 4
			if isEnabled >= 1 then
				isEnabled = 1
				func:disconnect()
			end
			local vector = LerpTable(p1, p2, isEnabled)
			SetVolume(vector)
			if isEnabled then
				isEnabled.ImageColor3 = vector.Vig
			end
			MinimapService.updateMapImageColor3(vector.Minimap)
		end
		func = RunService.Heartbeat:Connect(Heartbeat)
	end
	local SNOW = EnvironmentConsts.SNOW
	local isSnowing = not SNOW
	local Rain = SNOW and ReplicatedStorage.Resource.RainSnow or ReplicatedStorage.Resource.Rain
	Rain.Name = "Rain"
	local rainThread = nil
	local rainIterationCounter = 0
	local isEnabled = false
	local function StartRainThread()
		local isEnabled = Vector3.new()
		local isEnabled = Vector3.new()
		v74 = v74 + 1
		for func, cframe in Rain:GetChildren() do
			if cframe:IsA("BasePart") then
				cframe.CanCollide = false
				cframe.CanTouch = false
				cframe.CanQuery = false
				cframe.Transparency = 1
			end
		end
		Rain.Parent = workspace
		if v73 then
			v73:Disconnect()
		end
		isEnabled = false
		v73 = RunService.Heartbeat:Connect(function(p1)
			debug.profilebegin("Rain Update")
			if LocalPlayer.Character then
				local PrimaryPart = LocalPlayer.Character.PrimaryPart
				if PrimaryPart then
					isEnabled = PrimaryPart.Position
					isEnabled = if SNOW then isEnabled + PrimaryPart.Velocity * Vector3.new(1, 0, 1) else isEnabled + PrimaryPart.Velocity * Vector3.new(1, 0, 1) * 0.3
				end
				local Humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
				if Humanoid then
					local _ = Humanoid.Sit or Humanoid.PlatformStand
				end
			end
			local Rain_2 = Rain.RainFall:FindFirstChild("Rain")
			local FogFall = Rain:FindFirstChild("FogFall")
			local Rain_3 = Rain.RainDroplets:FindFirstChild("Rain")
			Rain.RainFall.CFrame = CFrame.new(isEnabled) + Vector3.new(0, 37, 0)
			if FogFall then
				FogFall.CFrame = CFrame.new(isEnabled) + Vector3.new(0, 37, 0)
			end
			local rayHitPosition, rayHitPart = workspace:FindPartOnRayWithIgnoreList(Ray.new(isEnabled, Vector3.new(0, -10, 0)), { workspace.Vehicles, LocalPlayer.Character, Rain })
			Rain.RainDroplets.CFrame = CFrame.new(rayHitPart) + Vector3.new(0, 1.5, 0)
			local func = RaycastParams.new()
			func.FilterDescendantsInstances = {
				workspace.Vehicles,
				LocalPlayer.Character,
				Rain,
				workspace:FindFirstChild("Clouds")
			}
			local cframe = Raycast.collidable(isEnabled, Vector3.new(0, 1, 0), 100, func) ~= nil
			if Rain_2 then
				Rain_2.Enabled = not cframe and not isEnabled
			end
			if FogFall then
				FogFall.RainFog.Enabled = not cframe and not isEnabled
			end
			SoundService.Ambient.CompressorSoundEffect.Enabled = cframe and true or false
			if (not SNOW or v72) and Rain_3 then
				Rain_3.Enabled = (cframe and true or false) and not cframe
			end
			debug.profileend()
		end)
	end
	local function StopRainThread()
		if EnvironmentConsts.SNOW then
			isEnabled = true
			local isEnabled = v74
			task.delay(7, function()
				if v73 and isEnabled == v74 then
					Rain.Parent = ReplicatedStorage.Resource
					v73:Disconnect()
					v73 = nil
				end
			end)
		else
			if v73 then
				v73:Disconnect()
			end
			Rain.Parent = ReplicatedStorage.Resource
			v73 = nil
		end
	end
	local currentTimeOfDay = "Day"
	function configTable.gf5qw0na(p1)
		if p1 ~= currentTimeOfDay then
			if p1 == "Day" then
				SetSettings(Settings.Ambient[currentTimeOfDay], Settings.Ambient.Day)
			elseif p1 == "Night" then
				SetSettings(Settings.Ambient[currentTimeOfDay], Settings.Ambient.Night)
			end
			currentTimeOfDay = p1
		end
	end
	local function UpdateStorm()
		if EnvironmentUtils.getPrecipitation() == EnvironmentConsts.PRECIPITATION_ENUM.Rain then
			StartRainThread()
			SetSettings(Settings.Ambient[currentTimeOfDay], Settings.Ambient.Storm)
			v76 = "Storm"
		else
			StopRainThread()
		end
	end
	task.spawn(UpdateStorm)
	EnvironmentUtils.getPrecipitationChangedSignal():Connect(UpdateStorm)
end
v24 = ReplicatedStorage.StarterGui.NitroShopGui
do
	local ambienceValue = v24
	v77.Parent = LocalPlayer.PlayerGui
	local function OpenNitroProd()
		v77.Enabled = true
		EzUtils.selectIfGamepad(v77.Container.Container.ContainerButtons.Tier1.Button)
	end
	local function CloseNitroProd()
		v77.Enabled = false
	end
	local settingsWindow = AlexWM.MakeWindow()
	v78.OpenFun = OpenNitroProd
	v78.CloseFun = CloseNitroProd
	AlexWM.WindowGroupAdd(v16, v78)
	v77.Container.Close.MouseButton1Down:connect(function()
		AlexWM.WindowClose(v78)
	end)
	v17.AtGasStation = false
	function configTable.n8cinotq(p1, p2)
		if RunUtils.isTradeWorld() then
		elseif p1 then
			if not p2 then
				v17.AtGasStation = true
			end
			AlexWM.WindowOpen(v78)
		else
			v17.AtGasStation = false
			AlexWM.WindowClose(v78)
		end
	end
	VehicleUtils.NitroShopVisible = configTable.n8cinotq
	local function AttemptUpdateGui()
		if Settings.FetchedMarketplace then
			for isEnabled, isEnabled in next, Settings.DevProduct do
				if isEnabled.Type == "Nitro" then
					local cframe = v77.Container.Container.ContainerButtons:FindFirstChild(isEnabled.Name)
					if cframe then
						cframe.Button.Title.Text = ("+%d"):format(isEnabled.Fuel)
						cframe.Button.MouseButton1Down:connect(function()
							if v17.Nitro >= Settings.Scalar.NitroMax - 25 then
								configTable.mq92d5a8({
									Title = "Rocket Fuel",
									Text = "You have a lot of fuel, go use it!"
								})
							else
								local isEnabled
								if v17.AtGasStation or GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.PremiumGarage) then
									isEnabled = true
								else
									PromptPurchase(Settings.Gamepass.PremiumGarage)
									isEnabled = false
								end
								if isEnabled then
									MarketplaceService:PromptProductPurchase(LocalPlayer, isEnabled.Id)
								end
							end
						end)
					end
				end
			end
			return true
		else
			return false
		end
	end
	task.spawn(function()
		if not Settings.FetchedMarketplace then
			Settings.OnProductsFetched:Wait()
		end
		AttemptUpdateGui()
	end)
	if RunUtils.isMainWorld() then
		local function updateHasEscaped()
			t6.HasEscaped = Players.LocalPlayer:GetAttribute("HasEscaped") == true
			if t6.HasEscaped then
				configTable.mq92d5a8({
					Text = ("%s"):format(Localization:FormatByKey("Banner.EscapedDesc")),
					Duration = 6
				})
				configTable.mq92d5a8({
					Text = ("%s"):format(Localization:FormatByKey("Banner.Escaped")),
					Style = "Alert",
					Duration = 6
				})
			end
		end
		updateHasEscaped()
		Players.LocalPlayer:GetAttributeChangedSignal("HasEscaped"):connect(updateHasEscaped)
	end
	function configTable.ecg6j4mm()
		if v17 then
			VehicleUtils.setTireHealth(currentVehiclePacket.Model, 0)
		end
	end
	local opacityOrScale_v79 = 1
	local function CycleMessage()
		local isEnabled = nil
		local isEnabled = nil
		if TeamValue.Value == Settings.Team.Prisoner then
			isEnabled = "Prisoner"
			isEnabled = 3
		elseif TeamValue.Value == Settings.Team.Police then
			isEnabled = "Police"
			isEnabled = 5
		end
		if isEnabled then
			local Help = isEnabled.Inventory.Help
			v79 = v79 % isEnabled + 1
			Help.Text = Localization:FormatByKey("Help." .. isEnabled .. v79 - 1)
			Help.Visible = true
		end
	end
end
function configTable.n8yqy49q(p1, ...)
	if p1 == "ems" then
		delay(0.5, function()
			eventBridge:FireServer("n8yqy49q", p1)
		end)
	else
		eventBridge:FireServer("n8yqy49q", p1)
	end
	assert(configTable[p1], p1)(...)
end
require(ReplicatedStorage.TeamSelect.TeamChooseUI).Init({
	Event = eventBridge,
	em = configTable,
	OnJump = OnJump
})
ConnectEvents()
local AttemptVehicleEnter
do
	local function GetSeats(p1)
		local Character = LocalPlayer.Character
		if Character and Character.PrimaryPart then
			local isEnabled = next
			local isEnabled, func = p1.Model:GetChildren()
			local configTable = {}
			for cframe, vector in isEnabled, isEnabled, func do
				if vector.Name == "Seat" or vector.Name == "Passenger" then
					local Player = vector:FindFirstChild("Player")
					local PlayerName = vector:FindFirstChild("PlayerName")
					if Player and (Player.Value and PlayerName) then
						table.insert(configTable, {
							Part = vector,
							PlayerName = PlayerName.Value
						})
					end
				end
			end
			table.sort(configTable, function(p1, p2)
				return p1.PlayerName < p2.PlayerName
			end)
			return configTable
		end
	end
	ThreadLoopAdd(0.1, function()
		local Character = LocalPlayer.Character
		if Character then
			local PrimaryPart = Character.PrimaryPart
			if PrimaryPart then
				local isEnabled = LocalPlayer:GetAttribute("TutorialCanEnterAnyCarForFree") == true
				local isEnabled = next
				local func, cframe = workspace.Vehicles:GetChildren()
				for cframe, RemoteEvent in isEnabled, func, cframe do
					local vector
					local Seat = RemoteEvent:FindFirstChild("Seat")
					local BoundingBox = RemoteEvent:FindFirstChild("BoundingBox")
					local Make = RemoteEvent:FindFirstChild("Make")
					local vector = RemoteEvent:GetAttribute("GamepassRestrict")
					if BoundingBox and Seat then
						local Player = Seat:FindFirstChild("Player")
						local magnitude = (PrimaryPart.Position - BoundingBox.Position).magnitude
						local MoneyBillboard = BoundingBox:FindFirstChild("MoneyBillboard")
						if MoneyBillboard and (Make and Player) then
							if magnitude < 50 then
								vector = not Player.Value
								if vector then
									local isEnabled = nitroState.VehiclesOwned[Make.Value]
									if not isEnabled then
										isEnabled = nitroState.VehiclesRented[Make.Value]
										if not isEnabled then
											isEnabled = vector and GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass[vector])
										end
									end
									vector = not isEnabled and not isEnabled
								end
							else
								vector = false
							end
							MoneyBillboard.Enabled = vector
						end
					end
				end
			end
		end
	end)
	AttemptVehicleEnter = function(p1)
		if not v17 then
			eventBridge:FireServer("alpbm6bx", p1.Parent, p1)
		end
	end
	function configTable.rtxoql4k()
		wait()
		UI.CircleAction.NotAllowed()
	end
	local function WalkSpeedFun()
		local Character = LocalPlayer.Character
		if Character then
			local Humanoid = Character:FindFirstChild("Humanoid")
			if Humanoid then
				local isEnabled = max(log(Humanoid.Health + 1) / 4.61512051684126, 0.5)
				local isEnabled = ItemSystem.GetLocalEquipped()
				if isEnabled then
					local func = InventoryItemUtils.getName(isEnabled.inventoryItemValue)
					if func == "Cuffed" then
						isEnabled = 0
					elseif func == "ShieldSWAT" then
						isEnabled = isEnabled * 0.75
					end
				end
				if v21 then
					isEnabled = 0
				end
				local sum = isEnabled * 16
				if isCrawling then
					sum = sum * 0.4
				end
				if Falling.IsSkydiving() then
					sum = sum * 4
				elseif v19 then
					sum = sum * 1.5
				end
				if CharacterUtil.IsJuiced then
					sum = sum + 20
				end
				if LocalPlayer.TeamValue.Value == Settings.Team.Prisoner then
					for k, v in pairs(Classes.Heli.SpotlightBinder:GetAllSet()) do
						if k.IsLocalInSpotlight then
							sum = sum * 0.75
						end
					end
				end
				if Character:FindFirstChild("IsInFloorCircle") ~= nil then
					sum = sum * 0.5
				end
				if Humanoid:GetAttribute("IsInTrackingSpotlight") == true then
					sum = sum * 0.8
				end
				if Humanoid:GetAttribute(MovementConsts.NO_MOVEMENT_ATTR_NAME) then
					sum = sum * 0
				end
				local cframe = CharacterUtil.WalkSpeedSpring:Update()
				if cframe < 0 then
					cframe = 0
				end
				if cframe > 10 then
					cframe = 10
				end
				local vector = sum * cframe
				if abs(vector - Humanoid.WalkSpeed) > 0.1 then
					Humanoid.WalkSpeed = vector
				end
				if crawlAnimationTrack then
					local PrimaryPart = Character.PrimaryPart
					if PrimaryPart then
						crawlAnimationTrack:AdjustSpeed(-Character.HumanoidRootPart.CFrame:vectorToObjectSpace(PrimaryPart.Velocity).Z / 6)
					end
				end
			end
		end
	end
	local function getUpdateRate(p1, p2, p3)
		if p1 < p2 then
			return 0
		else
			return (p1 - p2) / (p3 - p2)
		end
	end
	local function UpdateVehicle(p1)
		local isEnabled = not v17
		local Part = p1.Part
		if Part and Part.Parent then
			local isEnabled = nil
			local func = nil
			local cframe = nil
			if TeamValue.Value == Settings.Team.Prisoner then
				local vector = Part.Parent:GetAttribute("TeamRestrict")
				local cframe = Part.Parent:GetAttribute("GamepassRestrict")
				if vector and (Part.Name == "Seat" and vector ~= TeamValue.Value) then
					isEnabled = if cframe then GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass[cframe]) else true
				end
			elseif TeamValue.Value == Settings.Team.Police then
				local vector = ItemSystem.GetLocalEquipped()
				if vector and vector.__ClassName == "Handcuffs" then
					func = true
				end
			end
			if not (isEnabled or func) then
				cframe = true
			end
			local isEnabled = 10
			if p1.ShouldHotwire ~= isEnabled then
				p1.ShouldHotwire = isEnabled
				if isEnabled then
					p1.Name = Localization:FormatByKey("Action.Hijack")
					p1.Timed = true
					p1.Duration = 5.6
				end
			end
			if p1.ShouldEject ~= func then
				p1.ShouldEject = func
				if func then
					p1.Name = Localization:FormatByKey("Action.Eject")
					p1.Timed = false
					p1.Duration = 1
					isEnabled = 12
				end
			end
			if p1.ShouldAllowEntry ~= cframe then
				p1.ShouldAllowEntry = cframe
				if cframe then
					p1.Timed = false
					p1.Name = if Part.Name == "Seat" then Localization:FormatByKey("Action.EnterDriver") elseif Part:FindFirstChild("Turret") then "Enter Turret" else Localization:FormatByKey("Action.EnterPassenger")
				end
			end
			if p1.ShouldAllowEntry or p1.ShouldHotwire then
				local Player = Part:FindFirstChild("Player")
				if Player and Player.Value then
					isEnabled = false
				end
			end
			p1.Dist = isEnabled
		end
		if isEnabled ~= p1.Enabled then
			p1.Enabled = isEnabled
		end
	end
	local function UpdatePlayer(p1)
		local isEnabled = nil
		local isEnabled = nil
		local func = nil
		local cframe = nil
		local vector = nil
		local cframe = ItemSystem.GetLocalEquipped()
		if RunUtils.isTradingEnabled() then
			local RemoteEvent = Players:FindFirstChild(p1.PlayerName)
			if RemoteEvent and (RemoteEvent ~= LocalPlayer and (TradeUtils.getPlayerTradeRequestsEnabled(RemoteEvent) and (TradeUtils.getPlayerTradeRequestsEnabled(LocalPlayer) and (not TradeService.checkAlreadyInitiated(LocalPlayer, RemoteEvent) and (RemoteEvent.Character and RemoteEvent.Character:FindFirstChild("Humanoid")))))) then
				cframe = true
			end
		end
		local vector = Players:FindFirstChild(p1.PlayerName)
		if vector and (vector.Character and LocalPlayer.Character) then
			local isEnabled = if PlayerUtils.getTeamId(vector) == Settings.EnumTeam.Criminal then vector.Character:GetAttribute("HasHandcuffs") else false
			if vector.TeamValue.Value == Settings.Team.Police and TeamValue.Value == Settings.Team.Prisoner then
				local Humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
				local PrimaryPart = LocalPlayer.Character.PrimaryPart
				local PrimaryPart_2 = vector.Character.PrimaryPart
				if PrimaryPart and (PrimaryPart_2 and (Humanoid and not (Humanoid.Sit or Humanoid.PlatformStand))) then
					local cframe = PrimaryPart.CFrame
					local cframe = PrimaryPart_2.CFrame
					local cframe = cframe.lookVector:Dot(cframe.lookVector) >= 1/3
					if cframe and cframe.lookVector:Dot((cframe.p - cframe.p).unit) >= 1/3 then
						isEnabled = true
					end
				end
			elseif TeamValue.Value == Settings.Team.Police and isEnabled then
				vector = true
			elseif TeamValue.Value == Settings.Team.Prisoner and (vector.TeamValue.Value == Settings.Team.Prisoner and (vector.Character and LocalPlayer.Character)) and (vector.Character:GetAttribute("HasHandcuffs") and not LocalPlayer.Character:GetAttribute("HasHandcuffs")) then
				func = true
			end
		end
		if not vector and (not func and (cframe and (cframe.__ClassName == "Handcuffs" and TeamValue.Value == Settings.Team.Police))) then
			local targetPlayer = Players:FindFirstChild(p1.PlayerName)
			if targetPlayer and (vehicleClass.TeamValue.Value == Settings.Team.Prisoner and (vehicleClass.Character and (not vehicleClass.Character:GetAttribute("HasHandcuffs") and (not vehicleClass.Character:GetAttribute("InVehicle") and vehicleClass.Character:FindFirstChild("Humanoid"))))) then
				isEnabled = true
			end
		end
		local cframe
		if isEnabled == p1.ShouldArrest then
			cframe = false
		else
			p1.ShouldArrest = isEnabled
			cframe = true
		end
		if isEnabled ~= p1.ShouldPickpocket then
			p1.ShouldPickpocket = isEnabled
			cframe = true
		end
		if vector ~= p1.ShouldCrimSearch then
			p1.ShouldCrimSearch = vector
			cframe = true
		end
		if func ~= p1.ShouldBreakout then
			p1.ShouldBreakout = func
			cframe = true
		end
		if cframe ~= p1.ShouldTrade then
			p1.ShouldTrade = cframe
			cframe = true
		end
		if cframe and func then
			p1.Duration = 2
			p1.Timed = true
			p1.Dist = 10
			p1.Name = Localization:FormatByKey("Action.Breakout")
		elseif cframe and (isEnabled or vector) then
			p1.Duration = 2
			p1.Timed = true
			p1.Dist = 10
			if vector then
				p1.Name = Localization:FormatByKey("Action.CrimSearch")
			else
				p1.Name = Localization:FormatByKey("Action.Pickpocket")
			end
		elseif cframe and isEnabled then
			p1.Duration = 0.5
			p1.Timed = true
			p1.Dist = nil
			p1.HorizontalDist = Handcuffs.ArrestDistance
			p1.VerticalDist = Handcuffs.ArrestDistance * 1.4
			p1.Name = Localization:FormatByKey("Action.Arrest")
		elseif cframe and cframe then
			p1.Timed = false
			p1.Dist = 10
			p1.Name = Localization:FormatByKey("Action.Trade")
		end
		local conditionResult = isEnabled or (isEnabled or (func or (cframe or vector)))
		if v16 ~= p1.Enabled then
			p1.Enabled = v16
		end
	end
	local function UpdateRob(p1)
		local isEnabled = TeamValue.Value == Settings.Team.Prisoner
		if p1.Enabled ~= isEnabled then
			p1.Enabled = isEnabled
		end
	end
	local function UpdateCircleActions()
		debug.profilebegin("UpdateCircleActions (game)")
		local Character = LocalPlayer.Character
		if Character then
			local PrimaryPart = Character.PrimaryPart
			if PrimaryPart then
				local Position = PrimaryPart.Position
				local isEnabled = os.clock()
				for i, v in ipairs((UI.CircleAction.SpecOctree:QueryRadius(Position, 64))) do
					local func
					if not v.Kill then
						local Part = v.Part
						local WorldPosition = v.WorldPosition
						if not WorldPosition then
							WorldPosition = Part and Part.Position or Vector3.new(0, 0, 0)
						end
						local Magnitude = (WorldPosition - Position).Magnitude
						func = if Magnitude < 16 then 0 else (Magnitude - 16) / 48
						if func < isEnabled - (v._lastUpdateCheck or 0) then
							v._lastUpdateCheck = isEnabled
							if v.IsVehicle then
								UpdateVehicle(v)
							elseif v.IsPlayer then
								UpdatePlayer(v)
							elseif v.IsRob then
								local isPrisoner = TeamValue.Value == Settings.Team.Prisoner
								if v.Enabled ~= isPrisoner then
									v.Enabled = isPrisoner
								end
							end
						end
					end
				end
				debug.profileend()
			end
		end
	end
	RunService.Stepped:Connect(function()
		debug.profilebegin("LQVehicle Stepped")
		local isEnabled = os.clock()
		local p = CurrentCamera.CFrame.p
		if LocalPlayer.Character then
			for func in VehicleStateBinder:GetAllSet() do
				local isEnabled
				local packet = func.packet
				if packet then
					local cframe = Players:GetPlayerByUserId(func.obj:GetAttribute("VehicleStateUserId"))
					if cframe ~= LocalPlayer then
						local vector = false
						local Model = packet.Model
						if Model then
							local BoundingBox = Model:FindFirstChild("BoundingBox")
							if BoundingBox then
								local Magnitude = (BoundingBox.Position - p).Magnitude
								isEnabled = if Magnitude < 256 then 0 else (Magnitude - 256) / 3840
								if isEnabled < isEnabled - (packet._lastUpdateStepped or 0) then
									packet._lastUpdateStepped = isEnabled
									vector = true
								end
							end
						end
						if vector and packet.Type == "Chassis" then
							UpdateChassisStepped(packet)
						elseif vector and (packet.Type == "Motorcycle" or packet.Type == "DuneBuggy") then
							if not packet.IKP then
								if cframe then
									local Character = cframe.Character
									if Character then
										local Humanoid = Character:FindFirstChild("Humanoid")
										if Humanoid and Humanoid.RootPart then
											packet.IKP = R15IKv2.BuildPacketArms(Character)
										else
											return
										end
									else
										return
									end
								else
									return
								end
							end
							Classes.Chassis2.UpdateStepped(packet)
						end
					end
				end
			end
		end
		debug.profileend()
	end)
	RunService.Heartbeat:Connect(function(p1)
		debug.profilebegin("LQVehicle Heartbeat")
		local isEnabled = os.clock()
		local p = CurrentCamera.CFrame.p
		if LocalPlayer.Character then
			for func in VehicleStateBinder:GetAllSet() do
				local isEnabled
				local packet = func.packet
				if packet and Players:GetPlayerByUserId(func.obj:GetAttribute("VehicleStateUserId")) ~= LocalPlayer then
					local cframe = false
					local Model = packet.Model
					if Model then
						local BoundingBox = Model:FindFirstChild("BoundingBox")
						if BoundingBox then
							local Magnitude = (BoundingBox.Position - p).Magnitude
							isEnabled = if Magnitude < 768 then 0 else (Magnitude - 768) / 3328
							if isEnabled < isEnabled - (packet._lastUpdateHeartbeat or 0) then
								packet._lastUpdateHeartbeat = isEnabled
								cframe = true
							end
						end
					end
					if cframe then
						if packet.Type == "Heli" then
							UpdateHeliLowQuality(packet, p1)
						elseif packet.Type == "Chassis" then
							UpdateChassisLowQuality(packet, p1)
						elseif packet.Type == "Motorcycle" or packet.Type == "DuneBuggy" then
							Classes.Chassis2.UpdateLQ(packet, p1)
						end
						UpdateAllLowQuality(packet, p1, func.maid)
					end
				end
			end
		end
		debug.profileend()
	end)
	local loopCounter_v80 = 0
	local loopCounter_v81 = 0
	RunService.Heartbeat:Connect(function(p1)
		UpdateCircleActions()
		local isEnabled = TeamValue.Value
		local isEnabled = nil
		if isEnabled == Settings.Team.Prisoner then
			isEnabled = if t6.HasEscaped then Settings.EnumTeam.Criminal else Settings.EnumTeam.Prisoner
		elseif isEnabled == Settings.Team.Police then
			isEnabled = Settings.EnumTeam.Police
		end
		if GameUtil.Team ~= isEnabled then
			GameUtil.Team = isEnabled
			GameUtil.OnTeamChanged:Fire(isEnabled)
		end
		WalkSpeedFun()
		debug.profilebegin("Time/UI")
		local Time = workspace:FindFirstChild("Time")
		if Time then
			local func = Time.Value
			local cframe = func >= 12
			local vector = func % 1
			local sum = func - vector
			local sum_2 = floor(floor(vector * 60 + 0.5) / 15) * 15
			if sum_2 >= 60 then
				sum = sum + 1
				sum_2 = sum_2 - 60
			end
			if sum > 12 then
				sum = sum - 12
			end
			if sum == 0 then
				sum = 12
			end
			if sum ~= v80 or sum_2 ~= v81 then
				v80 = sum
				v81 = sum_2
				SidebarUI.SetTime((("%d:%02d %s"):format(sum, sum_2, if cframe then "PM" else "AM")))
			end
		end
		debug.profileend()
	end)
end
do
	local function InputChanged(p1)
		if currentVehiclePacket and currentVehiclePacket.Type == "Chassis" then
			Classes.Chassis.InputChanged(p1, nil)
		elseif currentVehiclePacket and currentVehiclePacket.Type == "Heli" then
			Classes.Heli.InputChanged(p1, nil)
		elseif currentVehiclePacket and (currentVehiclePacket.Type == "Custom" and v17.Make == "Volt") then
			Classes.Volt.InputChanged(p1, nil)
		end
		if p1.UserInputType == Enum.UserInputType.MouseMovement then
			v18 = p1.Position
		end
	end
	local function InputBegan_2(p1, p2)
		if p2 and (p1.UserInputType ~= Enum.UserInputType.Gamepad1 or p1.KeyCode ~= Enum.KeyCode.ButtonA) then
			if p1.KeyCode == Enum.KeyCode.Left or p1.KeyCode == Enum.KeyCode.Right then
				if currentVehiclePacket and currentVehiclePacket.Type == "Chassis" then
					Classes.Chassis.InputBegan(p1)
				elseif currentVehiclePacket and currentVehiclePacket.Type == "Heli" then
					Classes.Heli.InputBegan(p1)
				elseif currentVehiclePacket and (currentVehiclePacket.Type == "Custom" and v17.Make == "Volt") then
					Classes.Volt.InputBegan(p1)
				end
				if p1.UserInputType == Enum.UserInputType.Keyboard and (p1.KeyCode == Enum.KeyCode.E and (v17 and currentVehiclePacket.Type ~= "Heli")) then
					OnJump()
				end
			end
		else
			if currentVehiclePacket and currentVehiclePacket.Type == "Chassis" then
				Classes.Chassis.InputBegan(p1)
			elseif currentVehiclePacket and currentVehiclePacket.Type == "Heli" then
				Classes.Heli.InputBegan(p1)
			elseif currentVehiclePacket and (currentVehiclePacket.Type == "Custom" and v17.Make == "Volt") then
				Classes.Volt.InputBegan(p1)
			end
			if p1.UserInputType == Enum.UserInputType.Keyboard and (p1.KeyCode == Enum.KeyCode.E and (v17 and currentVehiclePacket.Type ~= "Heli")) then
				OnJump()
			end
		end
	end
	local function InputEnded(p1, p2)
		if p2 and (p1.UserInputType ~= Enum.UserInputType.Gamepad1 or p1.KeyCode ~= Enum.KeyCode.ButtonA) then
			if p1.KeyCode == Enum.KeyCode.Left or p1.KeyCode == Enum.KeyCode.Right then
				if currentVehiclePacket and currentVehiclePacket.Type == "Chassis" then
					Classes.Chassis.InputEnded(p1)
				elseif currentVehiclePacket and currentVehiclePacket.Type == "Heli" then
					Classes.Heli.InputEnded(p1)
				elseif currentVehiclePacket and (currentVehiclePacket.Type == "Custom" and v17.Make == "Volt") then
					Classes.Volt.InputEnded(p1)
				end
			end
		elseif currentVehiclePacket and currentVehiclePacket.Type == "Chassis" then
			Classes.Chassis.InputEnded(p1)
		elseif currentVehiclePacket and currentVehiclePacket.Type == "Heli" then
			Classes.Heli.InputEnded(p1)
		elseif currentVehiclePacket and (currentVehiclePacket.Type == "Custom" and v17.Make == "Volt") then
			Classes.Volt.InputEnded(p1)
		end
	end
	UserInputService.InputBegan:connect(InputBegan_2)
	UserInputService.InputEnded:connect(InputEnded)
	UserInputService.InputChanged:connect(InputChanged)
	local CircleAction_2 = UI.CircleAction
	local function Action(p1, p2)
		if p2 then
			if p1.ShouldHotwire then
				AttemptVehicleHotwire(p1.Part.Parent, true)
			elseif p1.ShouldEject then
				AttemptVehicleEject(p1.Part.Parent)
			else
				AttemptVehicleEnter(p1.Part)
			end
			return true
		end
		if p1.ShouldHotwire then
			AttemptVehicleHotwire(p1.Part.Parent)
			configTable.mq92d5a8({
				Title = "Vehicle",
				Text = "Vehicle protected. Hold to hijack."
			})
		end
	end
	local function AddedFun_3(p1)
		CircleAction_2.Add({
			Part = p1,
			ValidRoot = p1.Parent,
			Name = "Enter",
			Timed = false,
			Duration = 1,
			Dist = 10,
			Callback = Action,
			IsVehicle = true
		}, p1)
	end
	local function RemovedFun_3(p1)
		CircleAction_2.Remove(p1)
	end
	local vehicleSeatIterator = next
	local vehicleSeats, _ = CollectionService:GetTagged("VehicleSeat")
	for v85, v86 in vehicleSeatIterator, v83, for _, seat in vehicleSeats do
		AddedFun_3(v86)
	end
	CollectionService:GetInstanceAddedSignal("VehicleSeat"):Connect(AddedFun_3)
	CollectionService:GetInstanceRemovedSignal("VehicleSeat"):Connect(RemovedFun_3)
	local CircleAction_3 = UI.CircleAction
	local function UseHandcuffs(p1)
		local isEnabled = ItemSystem.GetLocalEquipped()
		if isEnabled and isEnabled.__ClassName == "Handcuffs" then
			if isEnabled.Reloading then
			elseif TeamValue.Value == Settings.Team.Police then
				local isEnabled = Players:FindFirstChild(p1.PlayerName)
				if isEnabled then
					local TeamValue_2 = isEnabled.TeamValue.Value
					if v17 then
					elseif TeamValue_2 == Settings.Team.Prisoner then
						local Character = LocalPlayer.Character
						if Character then
							local Humanoid = Character:FindFirstChild("Humanoid")
							if Humanoid and not (Humanoid.Health <= 0) then
								eventBridge:FireServer("w5ln1uc8", isEnabled)
								return true
							end
						end
					end
				end
			end
		end
	end
	local function UsePickpocket(p1)
		local isEnabled = Players:FindFirstChild(p1.PlayerName)
		if isEnabled then
			AttemptPickPocket(isEnabled)
			return true
		end
	end
	local function UseBreakout(p1)
		local isEnabled = Players:FindFirstChild(p1.PlayerName)
		if isEnabled then
			AttemptBreakout(isEnabled)
			return true
		end
	end
	local function UseTrade(p1)
		local isEnabled = Players:FindFirstChild(p1.PlayerName)
		if isEnabled then
			AttemptTrade(isEnabled)
			return true
		end
	end
	local function Action_2(p1, p2)
		if p1.ShouldBreakout and not p2 then
			local isEnabled = Players:FindFirstChild(p1.PlayerName)
			if isEnabled and not isEnabled:GetAttribute("SentBreakoutRequest") then
				isEnabled:SetAttribute("SentBreakoutRequest", true)
				eventBridge:FireServer("configTablecmegrbe", isEnabled.Name)
				task.delay(10, function()
					isEnabled:SetAttribute("SentBreakoutRequest", nil)
				end)
			end
		end
		if p2 then
			local isEnabled = nil
			if p1.ShouldArrest then
				isEnabled = UseHandcuffs(p1)
			elseif p1.ShouldPickpocket or p1.ShouldCrimSearch then
				local func = Players:FindFirstChild(p1.PlayerName)
				if func then
					AttemptPickPocket(func)
					isEnabled = true
				else
					isEnabled = nil
				end
			elseif p1.ShouldBreakout then
				local cframe = Players:FindFirstChild(p1.PlayerName)
				if cframe then
					AttemptBreakout(cframe)
					isEnabled = true
				else
					isEnabled = nil
				end
			end
			if p1.ShouldTrade and (RunUtils.isTradeWorld() or not isEnabled) then
				local vector = Players:FindFirstChild(p1.PlayerName)
				if vector then
					AttemptTrade(vector)
					isEnabled = true
				else
					return nil
				end
			end
			return isEnabled
		else
			return true
		end
	end
	local function AddedFun_4(p1)
		if p1 ~= LocalPlayer.Character then
			CircleAction_3.Add({
				Part = p1:WaitForChild("UpperTorso", 3),
				ValidRoot = p1,
				Name = "Player",
				Timed = true,
				Duration = 0.5,
				Dist = 15,
				Priority = 2,
				Callback = Action_2,
				PlayerName = p1.Name,
				IsPlayer = true
			}, p1)
		end
	end
	local function RemovedFun_4(p1)
		if p1 ~= LocalPlayer.Character then
			CircleAction_3.Remove(p1)
		end
	end
	local function onCharacterAdded(p1)
		AddedFun_4(p1.obj)
		p1.maid:GiveTask(function()
			local obj = p1.obj
			if obj ~= LocalPlayer.Character then
				CircleAction_3.Remove(obj)
			end
		end)
	end
	for v87, v88 in CharacterBinder:GetAll() do
		onCharacterAdded(v88)
	end
	CharacterBinder:GetClassAddedSignal():Connect(onCharacterAdded)
	local CircleAction_4 = UI.CircleAction
	local function Action_3(p1, p2)
		if p2 then
			eventBridge:FireServer("womiwx4r", p1.Part)
		else
			eventBridge:FireServer("fwl2dtym", p1.Part)
		end
		return true
	end
	local function AddedFun_5(p1)
		CircleAction_4.Add({
			Part = p1,
			Name = "Rob",
			Timed = true,
			Duration = 10,
			Dist = 8,
			Callback = Action_3,
			IsRob = true
		}, p1)
	end
	local function RemovedFun_5(p1)
		CircleAction_4.Remove(p1)
	end
	local iterator_v89 = next
	local smallStores, _ = CollectionService:GetTagged("SmallStore")
	for v92, v93 in v89, v90, for _, store in smallStores do
		AddedFun_5(v93)
	end
	CollectionService:GetInstanceAddedSignal("SmallStore"):Connect(AddedFun_5)
	CollectionService:GetInstanceRemovedSignal("SmallStore"):Connect(RemovedFun_5)
	local CircleAction_5 = UI.CircleAction
	local function Action_4(p1, p2)
		local isEnabled = p1.Part.Parent
		if p2 then
			eventBridge:FireServer("z5c18gcj", isEnabled)
			return true
		end
	end
	local GunShopUtils = require(ReplicatedStorage.Game.GunShop.GunShopUtils)
	local function AddedFun_6(p1)
		local isEnabled = p1.Parent
		CircleAction_5.Add({
			Part = p1,
			ValidRoot = isEnabled,
			Name = ("Pick up %s"):format(GunShopUtils.getTranslatedTitleFromName(isEnabled.Name)),
			Timed = true,
			Duration = 0.5,
			Dist = 5,
			Callback = Action_4
		}, p1)
	end
	local ItemDropConsts = require(ReplicatedStorage.Game.ItemSystem.ItemDropConsts)
	local iterator_v94 = next
	local droppedItems, _ = CollectionService:GetTagged(ItemDropConsts.DROPPED_ITEM_TAG)
	for v97, v98 in v94, v95, for _, item in droppedItems do
		AddedFun_6(v98)
	end
	CollectionService:GetInstanceAddedSignal(ItemDropConsts.DROPPED_ITEM_TAG):Connect(AddedFun_6)
	CollectionService:GetInstanceRemovedSignal(ItemDropConsts.DROPPED_ITEM_TAG):Connect(CircleAction_5.Remove)
	local startTime = tick()
	local function onJumpDebounce()
		local isEnabled = tick()
		if isEnabled - v99 < 0.1 then
			return false
		end
		v99 = isEnabled
		OnJump()
	end
	require(ReplicatedStorage.Game.DefaultActions).onJumpPressed:Connect(onJumpDebounce)
end
do
	local function CharacterDied()
		Falling.StartRagdolling(10)
	end
	local function CharacterAdded(p1)
		local Humanoid = p1:WaitForChild("Humanoid")
		local isEnabled = nil
		isEnabled = Humanoid.Died:Connect(function()
			isEnabled:Disconnect()
			Falling.StartRagdolling(10)
		end)
	end
	LocalPlayer.CharacterAdded:Connect(CharacterAdded)
	local BindableEvent = Instance.new("BindableEvent")
	BindableEvent.Event:connect(function()
		eventBridge:FireServer("nslfymcz")
	end)
	delay(2, function()
		local isEnabled, isEnabled = pcall(function()
			StarterGui:SetCore("ResetButtonCallback", BindableEvent)
		end)
		if not isEnabled then
			print("MANUAL RESET ERROR")
			print(isEnabled)
		end
	end)
	local Part = Instance.new("Part")
	Part.Anchored = true
	Part.Transparency = 1
	Part.CanCollide = false
	Part.Size = Vector3.new(1, 1, 1)
	Part.Archivable = false
	Part.Parent = workspace
	local function c()
		while true do

		end
	end
	Part:GetPropertyChangedSignal("Archivable"):connect(c)
	delay(10, function()
		local KreeksTimeMachine = workspace:FindFirstChild("KreeksTimeMachine")
		if KreeksTimeMachine and LocalPlayer.UserId == 140258990 then
			KreeksTimeMachine:Destroy()
		end
	end)
	local isEnabled = false
	local pcallResult = nil
	local pcallCounter = 0
	local pcallCounter2 = 0
	local isEnabled = false
	local function CharacterAdded_2(p1)
		local Humanoid = p1:WaitForChild("Humanoid", 1)
		if Humanoid then
			if p1:WaitForChild("HumanoidRootPart", 1) then
				isEnabled = false
				v104 = Math.TimeAccumAdd(v104, 2)
				if v102 then
					v102:Disconnect()
					v102 = nil
				end
				v102 = Humanoid.StateChanged:Connect(function(p1, p2)
					if p2 == Enum.HumanoidStateType.StrafingNoPhysics then
						v103 = Math.TimeAccumAdd(v103, 1)
						if Math.TimeAccumDiff(v103) > 10 then
							v103 = 0
							if not isEnabled then
								isEnabled = true
								EventFireServer("kului5os", "NoClip StrafingNoPhysics", false)
							end
						end
					end
				end)
			end
		end
	end
	if LocalPlayer.Character then
		CharacterAdded_2(LocalPlayer.Character)
	end
	LocalPlayer.CharacterAdded:Connect(CharacterAdded_2)
	spawn(function()
		local isEnabled, isEnabled = pcall(function()
			LocalPlayer:WaitForChild("Backpack", 20).ChildAdded:Connect(function(p1)
				if p1:IsA("BackpackItem") and not isEnabled then
					isEnabled = true
					EventFireServer("kului5os", "BackpackTool", false)
				end
			end)
		end)
		if not isEnabled then
			warn("BACKPACK FAIL", isEnabled)
		end
	end)
	local FindFirstChildWhichIsA = Instance.new("Model").FindFirstChildWhichIsA
	local xpcallFunction = xpcall
	local configTable = {}
	local function CheatCheck()
		if not isEnabled then
			local Character = LocalPlayer.Character
			if Character then
				local Humanoid = Character:FindFirstChild("Humanoid")
				if Humanoid then
					if Humanoid.Health <= 0.001 then
						if not isEnabled then
							v104 = Math.TimeAccumAdd(v104, 3)
						end
						isEnabled = true
						return
					end
					local isEnabled, isEnabled
					if Humanoid.JumpPower > 60 then
						isEnabled = true
						isEnabled = "JumpPower"
					else
						isEnabled = false
						isEnabled = nil
					end
					for func, cframe in next, {
						{ "MainNitro", PlayerGui:FindFirstChild("Nitro"), "Inf Nitro" },
						{ "ProductNitro", cframe:FindFirstChild("Nitro"), "Inf Nitro" }
					} do
						local vector = cframe[1]
						local RemoteEvent = cframe[3]
						if cframe[2] then
							configTable[vector] = true
						elseif configTable[vector] then
							isEnabled = true
							isEnabled = RemoteEvent
						end
					end
					for vector, isEnabled in next, { "Workspace", "Players", "ReplicatedStorage" } do
						if game:GetService(isEnabled).Name == isEnabled then
							if configTable[isEnabled] then
								isEnabled = true
								isEnabled = "Renamed Service"
							end
						else
							configTable[isEnabled] = true
						end
					end
					local pcallSuccess, _ = pcall(function()
						local GetObjects = game.GetObjects
					end)
					if not RunService:IsStudio() and pcallSuccess then
						isEnabled = true
						isEnabled = "game.GetObjects"
					end
					if _G.antiarrest ~= nil then
						isEnabled = true
						isEnabled = "_G.antiarrest"
					end
					if xpcall ~= v106 then
						isEnabled = true
						isEnabled = "Xpcall pointer changed"
					end
					local cframe = false
					xpcall(function()
						return game[{}]
					end, function()
						cframe = true
					end)
					if not cframe then
						isEnabled = true
						isEnabled = "VisDetect"
					end
					if debug.getupvalues then
						isEnabled = true
						isEnabled = "Getupvalues"
					end
					if isEnabled then
						isEnabled = true
						EventFireServer("kului5os", isEnabled, false)
					end
				end
			end
		end
	end
	ThreadLoopAdd(1, function()
		local isEnabled, _ = pcall(CheatCheck)
		if not isEnabled then
			isEnabled = true
			EventFireServer("kului5os", "FailedPcall", false)
		end
	end)
end
require(ReplicatedStorage.App.ImportantLocationMarkerSystem).init()
