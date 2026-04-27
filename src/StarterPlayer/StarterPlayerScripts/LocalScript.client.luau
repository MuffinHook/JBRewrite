-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local v1 = RunUtils.isStudio()
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
local v2 = CFrame.new
local Angles = CFrame.Angles
local v3 = Vector3.new
local v4 = v2(0, 0, 0)
local sin = math.sin
local floor = math.floor
local abs = math.abs
local log = math.log
local max = math.max
if not RunUtils.isStudio() then
	print("Build:", "27 Apr @ 12:55 PM EDT @942a23f")
end
local v5 = waitForChild(ReplicatedStorage, "GenericRemoteEvent", 30):catch(warn)
local t, t2, EventFireServer, ConnectEvents
do
	local v6 = nil
	t = {}
	for i = 1, 10 do
		local v7 = Instance.new("RemoteEvent")
		v7.Name = Math.GUID()
		v7.Parent = ReplicatedStorage.Resource
	end
	local v8 = nil
	t2 = {}
	local FireServer = Instance.new("RemoteEvent").FireServer
	EventFireServer = function(p1, ...) --[[ EventFireServer | Line: 86 | Upvalues: FireServer (copy), v6 (ref), v8 (ref) ]]
		FireServer(v6, v8 and v8[p1] or p1, ...)
	end
	function t2.FireServer(p1, p2, ...) --[[ FireServer | Line: 89 | Upvalues: EventFireServer (ref) ]]
		return EventFireServer(p2, ...)
	end
	function t.yil2co26(p1) --[[ yil2co26 | Line: 92 | Upvalues: t (copy), v8 (ref) ]]
		t.hems = true
		v8 = p1
	end
	local function OnClientEvent(p1, ...) --[[ OnClientEvent | Line: 96 | Upvalues: t (copy) ]]
		assert(t[p1], p1)(...)
	end
	ConnectEvents = function() --[[ ConnectEvents | Line: 99 | Upvalues: v5 (copy), Math (copy), v6 (ref), OnClientEvent (copy) ]]
		local v1, v2 = v5:await()
		if not v1 then
			error("Bad error... could not find `GenericGameEvent`")
		end
		v2.Name = Math.GUID()
		v6 = v2
		v2.OnClientEvent:Connect(OnClientEvent)
	end
end
StarterGui.ResetPlayerGuiOnSpawn = false
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TeamValue = LocalPlayer:WaitForChild("TeamValue")
local v9, v10, v11, v12, PlayerUtils, InventoryItemUtils, InventoryItemSystem, ItemSystem, ThreadLoopAdd
do
	local function GetScreenGui(p1) --[[ GetScreenGui | Line: 132 | Upvalues: PlayerGui (copy), ReplicatedStorage (copy) ]]
		local v1 = PlayerGui:FindFirstChild(p1)
		if not v1 then
			local v2 = ReplicatedStorage.StarterGui:FindFirstChild(p1):Clone()
			v2.Parent = PlayerGui
			v1 = v2
		end
		return v1
	end
	local MainGui = PlayerGui:FindFirstChild("MainGui")
	if not MainGui then
		MainGui = ReplicatedStorage.StarterGui:FindFirstChild("MainGui"):Clone()
		MainGui.Parent = PlayerGui
	end
	v9 = MainGui
	local ProductGui = PlayerGui:FindFirstChild("ProductGui")
	if not ProductGui then
		ProductGui = ReplicatedStorage.StarterGui:FindFirstChild("ProductGui"):Clone()
		ProductGui.Parent = PlayerGui
	end
	v10 = ProductGui
	local Particles = PlayerGui:FindFirstChild("Particles")
	if not Particles then
		Particles = ReplicatedStorage.StarterGui:FindFirstChild("Particles"):Clone()
		Particles.Parent = PlayerGui
	end
	v11 = Particles
	local DeathGui = PlayerGui:FindFirstChild("DeathGui")
	if not DeathGui then
		DeathGui = ReplicatedStorage.StarterGui:FindFirstChild("DeathGui"):Clone()
		DeathGui.Parent = PlayerGui
	end
	v12 = DeathGui
	UI.CircleAction.Frame = v9.CircleAction
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
	PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
	PlayerUtils.init()
	InventoryItemUtils = require(ReplicatedStorage.Inventory.InventoryItemUtils)
	InventoryItemSystem = require(ReplicatedStorage.Inventory.InventoryItemSystem)
	ItemSystem = require(ReplicatedStorage.Game.ItemSystem.ItemSystem)
	ItemSystem.Init({
		em = t,
		Event = t2
	})
	require(ReplicatedStorage.Game.AmmoGui).Init({
		GetScreenGui = GetScreenGui
	})
	local function childAdded(p1) --[[ childAdded | Line: 163 | Upvalues: t2 (ref), t (copy), v9 (copy), ItemSystem (ref) ]]
		if not p1:GetAttribute("Required") then
			p1:SetAttribute("Required", true)
			local v1 = require(p1)
			if rawget(v1, "Init") then
				v1.Init({
					Event = t2,
					em = t,
					ScreenGui = v9
				})
			end
			ItemSystem.Register(v1)
		end
	end
	for v13, v14 in ReplicatedStorage.Game.Item:GetChildren() do
		childAdded(v14)
	end
	ReplicatedStorage.Game.Item.ChildAdded:Connect(childAdded)
	require(ReplicatedStorage.Game.ItemSystem.ItemCamera).Init()
	require(ReplicatedStorage.Game.ItemSkin.ItemSkin).Init({
		Event = t2,
		em = t
	})
	require(ReplicatedStorage.Game.ItemSkin.UI.UI).Init()
	local PoliceReportUI = require(ReplicatedStorage.Game.PoliceReportUI.PoliceReportUI)
	PoliceReportUI.Init()
	function t.j1pilk8h(p1) --[[ j1pilk8h | Line: 190 | Upvalues: PoliceReportUI (copy) ]]
		PoliceReportUI.Display(p1)
	end
	local t3 = {}
	ThreadLoopAdd = function(p1, p2) --[[ ThreadLoopAdd | Line: 198 | Upvalues: t3 (copy) ]]
		table.insert(t3, {
			t = 0,
			i = p1,
			c = p2
		})
	end
	local v15 = os.clock()
	local function Stepped() --[[ Stepped | Line: 207 | Upvalues: v15 (ref), t3 (copy) ]]
		local v1 = os.clock()
		local v2 = v1 - v15
		v15 = v1
		debug.profilebegin("Thread Loop")
		for i = 1, #t3 do
			local v3 = t3[i]
			if v1 - v3.t > v3.i then
				v3.t = v1
				v3.c(v1, v2)
			end
		end
		debug.profileend()
	end
	RunService.Heartbeat:Connect(Stepped)
end
local v16, CharacterBinder, CharacterUtil, t4, v17, t5, v18, v19, v20, v21, EzUtils, t6, VehicleUtils, VehicleStateBinder, Classes, PromptPurchase
do
	local function HasPerm(p1) --[[ HasPerm | Line: 224 | Upvalues: LocalPlayer (copy) ]]
		local v1 = false
		local v2, v3 = pcall(function() --[[ Line: 226 | Upvalues: p1 (copy), v1 (ref), LocalPlayer (ref) ]]
			if p1.Group then
				v1 = true
				v1 = v1 and LocalPlayer:IsInGroup(p1.Group)
				if p1.Rank then
					v1 = v1 and LocalPlayer:GetRankInGroup(p1.Group) >= p1.Rank
				end
			end
			if not v1 and p1.Id then
				v1 = true
				local v3 = v1
				if v3 then
					v3 = p1.Id[tostring(LocalPlayer.UserId)]
				end
				v1 = v3
			end
		end)
		if not v2 then
			print(v3)
		end
		return v2 and v1
	end
	v16 = AlexWM.MakeWindowGroup()
	CharacterBinder = require(ReplicatedStorage.App.CharacterBinder)
	CharacterBinder:Start()
	CharacterUtil = require(ReplicatedStorage.Game.CharacterUtil)
	require(ReplicatedStorage.Inventory.InventorySystem).init()
	local HotbarSystem = require(ReplicatedStorage.Hotbar.HotbarSystem)
	HotbarSystem.init()
	GameUtil.OnTeamChanged:Connect(function(p1) --[[ Line: 261 | Upvalues: HotbarSystem (copy), Settings (copy) ]]
		HotbarSystem.setColor(Settings.TeamColor[p1])
	end)
	require(ReplicatedStorage.Hotbar.HotbarItemBinder):GetClassAddedSignal():Connect(function() --[[ Line: 267 | Upvalues: HotbarSystem (copy), Settings (copy), GameUtil (copy) ]]
		HotbarSystem.setColor(Settings.TeamColor[GameUtil.Team])
	end)
	Binder.new("BarbedWireClient", function(p1) --[[ Line: 273 | Upvalues: Maid (copy), LocalPlayer (copy), t2 (ref) ]]
		local v1 = Maid.new()
		local v2 = 0
		v1:GiveTask(p1.Touched:Connect(function(p12) --[[ Line: 276 | Upvalues: LocalPlayer (ref), v2 (ref), p1 (copy), t2 (ref) ]]
			local Character = LocalPlayer.Character
			if Character and p12.Parent == Character then
				local Humanoid = Character:FindFirstChild("Humanoid")
				if Humanoid then
					if Humanoid:GetLimb(p12) == Enum.Limb.Unknown then
						return
					end
					local v1 = os.clock()
					if not (v1 - v2 < 0.3) then
						v2 = v1
						local v22 = p1:GetAttribute("BarbedWireDamage")
						local v3
						if v22 then
							assert(typeof(v22) == "number")
							v3 = v22
						else
							v3 = 30
						end
						t2:FireServer("p" .. ("znu03kj5jp"):sub(5, 6):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("qnj"):sub(2, 2):reverse():reverse():reverse() .. "" .. "" .. ("z1vmmo6"):sub(3, 5):reverse():reverse():reverse() .. "u", v3, "Wire")
					end
				end
			end
		end))
		return v1
	end):Start()
	t4 = {}
	v17 = nil
	t5 = {
		Nitro = 50,
		NitroLastMax = 50,
		VehiclesOwned = {},
		VehiclesRented = {}
	}
	v18 = Vector3.new(0, 0, 0)
	v19 = false
	v20 = false
	GameUtil.Schedule = "Yard"
	v21 = false
	EzUtils = require(ReplicatedStorage.EzUi.EzUtils)
	t6 = {
		MainWindowGroup = v16,
		ScreenGui = v9,
		ProductGui = v10,
		Event = t2,
		em = t,
		UI = UI,
		SelectIfGamepad = function(p1) --[[ SelectIfGamepad | Line: 337 | Upvalues: EzUtils (copy) ]]
			EzUtils.selectIfGamepad(p1)
		end,
		GetVehiclePacket = function() --[[ GetVehiclePacket | Line: 352 | Upvalues: v17 (ref) ]]
			return v17
		end
	}
	VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
	VehicleUtils.Init({
		GetVehiclePacket = t6.GetVehiclePacket,
		em = t,
		Event = t2,
		nitroState = t5
	})
	VehicleStateBinder = require(ReplicatedStorage.Game.VehicleStateBinder)
	VehicleStateBinder:Start()
	Classes = VehicleUtils.Classes
	Classes.Chassis = require(ReplicatedStorage.Module.AlexChassis)
	Classes.Chassis.init({
		ScreenGui = v9
	})
	Classes.Chassis.SetEvent(t2)
	Classes.Chassis2 = require(ReplicatedStorage.Module.AlexChassis2)
	Classes.Chassis2.SetEvent(t2)
	Classes.Volt = require(ReplicatedStorage.Game.Vehicle.Volt)
	Classes.Volt.Init({
		Event = t2,
		em = t
	})
	Classes.Tank = require(ReplicatedStorage.Tank.TankService)
	Classes.Tank.init()
	local v22 = 0
	PromptPurchase = function(p1) --[[ PromptPurchase | Line: 416 | Upvalues: v22 (ref), MarketplaceService (copy), LocalPlayer (copy), v10 (copy) ]]
		local PassId = p1.PassId
		local v1 = v22 + 1
		v22 = v1
		if p1.OldPassId then
			MarketplaceService:PromptPurchase(LocalPlayer, p1.OldPassId)
		else
			MarketplaceService:PromptGamePassPurchase(LocalPlayer, PassId)
		end
		v10.Gamepass.ContainerFrame.TextLabel.Text = p1.Text
		task.delay(0.4, function() --[[ Line: 426 | Upvalues: v22 (ref), v1 (copy), v10 (ref) ]]
			if v22 == v1 then
				v10.Gamepass.Visible = true
			end
		end)
	end
	local function PromptGamePassPurchaseFinished(p1, p2, p3) --[[ PromptGamePassPurchaseFinished | Line: 433 | Upvalues: v22 (ref), v10 (copy) ]]
		v22 = v22 + 1
		v10.Gamepass.Visible = false
	end
	MarketplaceService.PromptGamePassPurchaseFinished:Connect(PromptGamePassPurchaseFinished)
	MarketplaceService.PromptPurchaseFinished:Connect(PromptGamePassPurchaseFinished)
end
function t.o8anuzn3(p1) --[[ o8anuzn3 | Line: 441 | Upvalues: PromptPurchase (ref) ]]
	PromptPurchase(p1)
end
local GamepassSystem = require(ReplicatedStorage.Gamepass.GamepassSystem)
GamepassSystem.Init()
local GamepassUtils = require(ReplicatedStorage.Gamepass.GamepassUtils)
GamepassUtils.Init({
	PromptPurchase = PromptPurchase
})
t6.PromptPurchase = PromptPurchase
local Notification = require(ReplicatedStorage.Game.Notification)
Notification.Init({
	Event = t2,
	em = t
})
local SidebarUI = require(ReplicatedStorage.Game.SidebarUI)
SidebarUI.Init({
	Event = t2,
	em = t
})
require(ReplicatedStorage.GameAnalytics).initClient()
local DefaultActions = require(ReplicatedStorage.Game.DefaultActions)
require(ReplicatedStorage.CmdrExt.CmdrExtSystem).init()
local Time = require(ReplicatedStorage.Module.Time)
Time.Init()
require(ReplicatedStorage.Module.Confirmation).Init({
	Event = t2,
	em = t
})
require(ReplicatedStorage.Game.DisplayDamage).init()
require(ReplicatedStorage.Game.CharacterAnim).init()
require(ReplicatedStorage.Module.NetSync).Init({
	Event = t2,
	em = t
})
require(ReplicatedStorage.Game.OwnedPart.OwnedPartSystem).init()
require(ReplicatedStorage.Game.TrainSystem).Init({
	Event = t2,
	em = t
})
require(ReplicatedStorage.Game.TrackSwitch).Init({
	Event = t2,
	em = t
})
Classes.Heli = require(ReplicatedStorage.Game.Vehicle.Heli)(t6)
require(ReplicatedStorage.Game.Museum)(t6, ItemSystem)
require(ReplicatedStorage.Game.L18n)({
	ScreenGui = v9
})
require(ReplicatedStorage.Game.Level2.LevelSystem).init()
require(ReplicatedStorage.Game.TurbineSystem).init()
require(ReplicatedStorage.AirDrop.BriefcaseBinder):Start()
require(ReplicatedStorage.Plane.PlaneBinder):Start()
require(ReplicatedStorage.Game.Hologram).Init()
require(ReplicatedStorage.Game.Codes).Init({
	MainWindowGroup = v16,
	Event = t2
})
require(ReplicatedStorage.Game.SecretBases).Init({
	Event = t2,
	em = t
})
require(ReplicatedStorage.Game.Robbery.RobberyBank.RobberyBank).Init({
	Event = t2,
	em = t
})
require(ReplicatedStorage.Jewelry.RobberyJewelry).Init({
	Event = t2,
	em = t
})
require(ReplicatedStorage.Game.Robbery.RobberyCargoTrain).Init({
	Event = t2,
	em = t
})
require(ReplicatedStorage.Game.Robbery.RobberyPassengerTrain).Init({
	Event = t2,
	em = t,
	ScreenGui = v9
})
require(ReplicatedStorage.Game.Robbery.RobberyCargoPlane).Init({
	Event = t2,
	em = t,
	Team = TeamValue,
	ScreenGui = v9
})
require(ReplicatedStorage.Game.Cell).Init({
	Event = t2,
	em = t,
	ScreenGui = v9
})
require(ReplicatedStorage.Game.MilitaryIsland).Init()
local VehicleSystem
do
	local JetSki = require(ReplicatedStorage.Game.VehicleSystem.JetSki)
	require(ReplicatedStorage.Game.Plane.BaseUserControlledPlane).Init()
	local Jet = require(ReplicatedStorage.Game.Plane.Jet)
	Jet.Init({
		Event = t2,
		em = t
	})
	local Stunt = require(ReplicatedStorage.Game.Plane.Stunt)
	VehicleSystem = require(ReplicatedStorage.Game.VehicleSystem)
	VehicleSystem.Init({
		Event = t2,
		em = t
	})
	VehicleSystem.RegisterModule(JetSki)
	VehicleSystem.RegisterModule(Jet)
	VehicleSystem.RegisterModule(Stunt)
	function t.emnmgnrg(p1, p2) --[[ emnmgnrg | Line: 540 | Upvalues: VehicleSystem (ref), LocalPlayer (copy) ]]
		local v1, _ = VehicleSystem.WaitForVehiclePacket(LocalPlayer)
		if v1 == nil then
			error("No vehicle exists for LocalPlayer")
		end
		v1:UpdateMissileUI(p1, p2)
	end
	local Missile = require(ReplicatedStorage.Game.Missile)
	function t.dzy6thim(p1, p2, p3, p4) --[[ dzy6thim | Line: 548 | Upvalues: Missile (copy) ]]
		Missile.LaunchMissile(p1, p2, p3, p4)
	end
	require(ReplicatedStorage.Game.Robbery.PuzzleFlow).Init({
		Event = t2,
		em = t
	})
	require(ReplicatedStorage.Game.Robbery.PowerPlant.PowerPlant).Init({
		Event = t2,
		em = t
	})
	local JetPack = require(ReplicatedStorage.Game.JetPack.JetPack)
	JetPack.Init({
		Event = t2,
		em = t
	})
	JetPack.Signal.OnEquipped:Connect(function() --[[ Line: 560 | Upvalues: InventoryItemSystem (copy) ]]
		InventoryItemSystem.unequipAll()
	end)
	local Streetlights = require(ReplicatedStorage.Game.Streetlights)
	Streetlights.init()
	function t.ogr1c6kj() --[[ ogr1c6kj | Line: 567 | Upvalues: Streetlights (copy) ]]
		Streetlights.Flicker()
	end
	function t.lzqrfdxm(p1) --[[ lzqrfdxm | Line: 570 | Upvalues: Streetlights (copy) ]]
		Streetlights.SetEnabled(p1)
	end
	require(ReplicatedStorage.App.MinimapService).init()
	require(ReplicatedStorage.Game.RoadSpikeSystem).Init({
		Event = t2
	})
	require(ReplicatedStorage.Game.WorldMarker.WorldMarkerSystem).init()
	require(ReplicatedStorage.Game.RobberyMarkerSystem).init()
	require(ReplicatedStorage.Game.LightningSystem).Init({
		em = t
	})
	require(ReplicatedStorage.Game.April2020LiveEventLoader).Init({
		Event = t2,
		em = t
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
		em = t
	})
	require(ReplicatedStorage.Game.NukeControl).Init({
		Event = t2,
		em = t
	})
	require(ReplicatedStorage.Game.Robbery.CargoShip.CargoShipCoordinator).Init({
		Event = t2,
		em = t
	})
	require(ReplicatedStorage.Game.Radio.RadioPlayer).Init({
		Event = t2,
		em = t
	})
	require(ReplicatedStorage.Game.RobberyMoneyUI.RobberyMoneyUI).Init()
	require(ReplicatedStorage.Game.DuffelBag.DuffelBagBinder):Start()
	require(ReplicatedStorage.Game.GunShop.GunShopSystem).init()
	require(ReplicatedStorage.Game.GunShop.GunShopUI).init({
		Event = t2,
		em = t
	})
	require(ReplicatedStorage.Game.ContextMessage.ContextMessageUI).init()
	require(ReplicatedStorage.Game.C4.C4System).init({
		em = t
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
		Event = t2
	})
	require(ReplicatedStorage.Home.HomeItem.Fabricate["Trapped Bookshelf"]).init({
		Event = t2
	})
	require(ReplicatedStorage.Home.HomeItem.Fabricate["Trapped Spikes"]).init({
		Event = t2
	})
	require(ReplicatedStorage.Game.Robbery.TombRobbery.TombRobberySystem).init({
		Event = t2
	})
	require(ReplicatedStorage.Game.Cart.CartSystem).init()
	require(ReplicatedStorage.Game.ProximityCamShake.ProximityCamShakeSystem).init()
	require(ReplicatedStorage.Game.ProximitySound.ProximitySoundSystem).init()
	require(ReplicatedStorage.Game.DartDispenser.DartDispenserSystem).init()
	require(ReplicatedStorage.Game.Plank.PlankSystem).init()
	require(ReplicatedStorage.Game.MilitaryTurret.MilitaryTurretSystem).init({
		Event = t2
	})
	require(ReplicatedStorage.Game.Destructible.DestructibleSystem).init()
	require(ReplicatedStorage.Game.PlayerMarkerSystem).init()
	require(ReplicatedStorage.Game.TopExpBoard.TopExpBoardSystem).init()
	require(ReplicatedStorage.Game.CatalogPurchaseSystem).init()
	require(ReplicatedStorage.CCTV.CCTVService).init()
	local t7 = {}
	local t8 = {}
	local t9 = {}
	function t.ygdwzgcv(p1) --[[ ygdwzgcv | Line: 680 | Upvalues: t8 (ref), GameSettingsService (copy), t7 (copy) ]]
		t8 = p1
		for k, v in pairs(p1) do
			local v1 = GameSettingsService.getSettingByName(k)
			if v1 then
				if not v1.noSave then
					GameSettingsService.setValue(v1, v)
				end
			else
				t7[k] = v
			end
		end
	end
	local function handleSetting(p1) --[[ handleSetting | Line: 693 | Upvalues: t7 (copy), GameSettingsService (copy), t9 (copy), t8 (ref), t2 (ref) ]]
		local v1 = t7[p1.name]
		if v1 ~= nil then
			t7[p1.name] = nil
			if not p1.noSave then
				GameSettingsService.setValue(p1, v1)
			end
		end
		p1.onChanged:Connect(function(p12) --[[ Line: 702 | Upvalues: t9 (ref), p1 (copy), t8 (ref), t2 (ref) ]]
			local v1 = (t9[p1.name] or 0) + 1
			t9[p1.name] = v1
			if t8[p1.name] ~= p12 then
				t8[p1.name] = p12
				task.delay(0.25, function() --[[ Line: 712 | Upvalues: t9 (ref), p1 (ref), v1 (ref), t2 (ref), p12 (copy) ]]
					if t9[p1.name] == v1 then
						t2:FireServer("x" .. ("j5jlyyl9"):sub(2, 6):reverse() .. "ov", p1.name, p12)
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
		em = t
	})
	if RunUtils.isTradeWorld() then
		require(ReplicatedStorage.Trade.TradeDesireService).init()
	end
	require(ReplicatedStorage.RewardSpinner.RewardSpinnerService).init()
	require(ReplicatedStorage.HyperChrome.HyperChromeService).init()
	require(ReplicatedStorage.RobberyBonus.RobberyBonusService).init({
		em = t
	})
	require(ReplicatedStorage.Safes.SafesService).init({
		em = t
	})
	require(ReplicatedStorage.GuardNPC.GuardNPCBinder):Start()
	require(ReplicatedStorage.AirDrop.AirDropService).init({
		em = t
	})
	require(ReplicatedStorage.App.HoldEService).init()
	require(ReplicatedStorage.TargetingIndicator.TargetingIndicatorService).init()
	require(ReplicatedStorage.Forcefield.ForcefieldService).init()
	require(ReplicatedStorage.SpawnSelection.SpawnSelectionService).init()
	require(ReplicatedStorage.Consumables.ConsumablesService).init()
	require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleService).init()
	require(ReplicatedStorage.TrackingSpotlight.TrackingSpotlightService).init()
	require(ReplicatedStorage.GameMode.GameModeService).init({
		em = t
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
	Event = t2,
	em = t
})
require(ReplicatedStorage.Game.Radio.Radio).Init()
Settings.FetchProducts()
local Falling = require(ReplicatedStorage.Game.Falling)
Falling.Init({
	Event = t2,
	em = t
})
local Paraglide = require(ReplicatedStorage.Game.Paraglide)
Paraglide.Init({
	Event = t2,
	em = t
})
local LerpTable, PlaySound, StopSound
do
	local function comma(p1) --[[ comma | Line: 789 ]]
		local v1, v2, v3 = string.match(p1, "^([^%d]*%d)(%d*)(.-)$")
		return v1 .. v2:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v3
	end
	local function FormatMoney(p1) --[[ FormatMoney | Line: 793 | Upvalues: Localization (copy), abs (copy) ]]
		local t = {}
		local v4, v5, v6 = string.match(abs(p1), "^([^%d]*%d)(%d*)(.-)$")
		t[1] = v4 .. v5:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v6
		return if p1 >= 0 then "" else "-" .. Localization:FormatByKey("General.Cash", t)
	end
	LerpTable = function(p1, p2, p3) --[[ LerpTable | Line: 798 ]]
		local t = {}
		for v2, v3 in next, p2 do
			local v1
			local v4 = p1[v2]
			v1 = if type(v3) == "number" then (1 - p3) * v4 + p3 * v3 else v4:lerp(v3, p3)
			t[v2] = v1
		end
		return t
	end
	local t10 = {}
	PlaySound = function(p1, p2, p3) --[[ PlaySound | Line: 818 | Upvalues: t2 (ref), t (copy), LocalPlayer (copy) ]]
		if p2.Source then
			p2.Play = true
			if not p3 then
				t2:FireServer("i531zmrk", p1, p2)
			end
			t.i531zmrk(LocalPlayer.Name, p1, p2)
		end
	end
	StopSound = function(p1, p2) --[[ StopSound | Line: 828 | Upvalues: t2 (ref), t (copy), LocalPlayer (copy) ]]
		local t3 = {}
		if not p2 then
			t2:FireServer("i" .. ("yrg5n4h3"):sub(4, 4):reverse():reverse():reverse() .. "" .. "" .. ("c13dso"):sub(2, 3):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("jzu"):sub(2, 2):reverse() .. "" .. "" .. ("khnxmkno"):sub(5, 5):reverse():reverse():reverse() .. "rk", p1, t3)
		end
		t.i531zmrk(LocalPlayer.Name, p1, t3)
	end
	local v23 = 0
	function t.i531zmrk(p1, p2, p3) --[[ i531zmrk | Line: 836 | Upvalues: v23 (ref), t10 (copy), Settings (copy) ]]
		local Source = p3.Source
		local v1 = p3.Volume or 0.5
		if v1 > 2 then
			v1 = 2
		end
		if v1 ~= v1 then
			v1 = 0.5
		end
		local v2 = p3.Pitch or 1
		local v3 = p3.MaxTime or 1
		local Looped = p3.Looped
		local TimeStart = p3.TimeStart
		local Delay = p3.Delay
		local v4 = p3.EmitterSize or 10
		if p3.TimeStop then
			v3 = TimeStart + p3.TimeStop
		end
		local v5 = v23 + 1
		v23 = v5
		local v6 = p3.Multi and ("%s_%s_%d"):format(p1, p2, v5) or ("%s_%s"):format(p1, p2)
		local v7 = t10[v6]
		if v7 then
			v7.Object:Stop()
			v7.Object:Destroy()
			t10[v6] = nil
		end
		if p3.Play and Source then
			local v8 = Settings.Sounds[p2]
			if v8 then
				local Sound = Instance.new("Sound")
				Sound.SoundId = "rbxassetid://" .. v8
				if TimeStart then
					Sound.TimePosition = TimeStart
				end
				if p3.SoundGroup then
					Sound.SoundGroup = p3.SoundGroup
				end
				Sound.Name = v6
				Sound.Looped = Looped
				Sound.Volume = v1
				Sound.PlaybackSpeed = v2
				Sound.EmitterSize = v4
				Sound.MaxDistance = 400
				Sound.Parent = Source
				if Delay then
					delay(Delay, function() --[[ Line: 892 | Upvalues: Sound (copy) ]]
						Sound:Play()
					end)
				else
					Sound:Play()
				end
				t10[v6] = {
					Object = Sound,
					Proxy = v5
				}
				local function Expire() --[[ Expire | Line: 901 | Upvalues: t10 (ref), v6 (copy), v5 (copy) ]]
					local v1 = t10[v6]
					if v1 then
						if not (v5 < v1.Proxy) then
							v1.Object:Stop()
							v1.Object:Destroy()
							t10[v6] = nil
						end
					end
				end
				delay(v3, Expire)
			end
		end
	end
end
local function Fireworks(p1) --[[ Fireworks | Line: 916 | Upvalues: AlexParticles (copy), v11 (copy), PlaySound (ref), v9 (copy), Math (copy), v3 (copy) ]]
	local v1 = AlexParticles.MakeState()
	v1.Frame = v11.Particles
	AlexParticles.EasySimulate(v1, 4)
	local AbsoluteSize = v1.Frame.AbsoluteSize
	local X = AbsoluteSize.X
	local Y = AbsoluteSize.Y
	local function OnDestroy(p12) --[[ OnDestroy | Line: 922 | Upvalues: p1 (copy), PlaySound (ref), v9 (ref) ]]
		if p1 <= 4 or math.random() > 0.2 then
			PlaySound("FireworkBang", {
				Multi = true,
				Source = v9,
				Volume = 0.2 + math.random() * 0.3
			}, true)
		end
	end
	for i = 1, p1 do
		local v2 = Y * 0.3 + Y * 0.6 * math.random()
		local v32 = Vector3.new(0, -400, 0) + Math.Uniform2D(150)
		local v5 = AlexParticles.Firework(v1, v3(math.random() * X, Y, 0), v32, Vector3.new(0, 0, 0))
		v5.ttl = (Y - v2) / v32.magnitude
		v5.OnDestroy = OnDestroy
		wait(0.1 + math.random() * 0.1 * 0.5)
	end
end
function t.hksqoez6(p1) --[[ hksqoez6 | Line: 937 | Upvalues: Fireworks (copy) ]]
	assert(p1 <= 50)
	Fireworks(p1)
end
t6.Fireworks = Fireworks
require(ReplicatedStorage.Game.Party).Init({
	Fireworks = Fireworks
})
local function AttemptArrest(p1) --[[ AttemptArrest | Line: 947 | Upvalues: t2 (ref) ]]
	t2:FireServer("i" .. "" .. ("nioceoh"):sub(5, 5):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("mbbvra"):sub(2, 3):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("kfftool"):sub(2, 4):reverse():reverse():reverse() .. "g", p1)
end
function t.g088vlii(p1) --[[ g088vlii | Line: 950 | Upvalues: t (copy) ]]
	if p1.Bribed then
		t.vbey8zy6({
			Title = "Arrest",
			Text = ("You are bribed! Wait %d seconds."):format(p1.Bribed)
		})
	end
end
local function AttemptPickPocket(p1) --[[ AttemptPickPocket | Line: 955 | Upvalues: t2 (ref) ]]
	t2:FireServer("l" .. ("eatxuv8"):sub(2, 3):reverse():reverse():reverse() .. "" .. "" .. ("zfzwida"):sub(3, 4):reverse():reverse():reverse():reverse():reverse() .. "2m1", p1.Name)
end
local function AttemptBreakout(p1) --[[ AttemptBreakout | Line: 958 | Upvalues: t2 (ref) ]]
	t2:FireServer("j" .. ("ri1pafs0"):sub(2, 6):reverse():reverse():reverse() .. "" .. "" .. ("vrmg"):sub(2, 2):reverse() .. "6", p1.Name)
end
function t.sm4jlcui(p1) --[[ sm4jlcui | Line: 961 | Upvalues: t (copy) ]]
	if p1.Cooldown then
		t.vbey8zy6({
			Title = "Breakout",
			Text = ("Wait %d seconds."):format(p1.Cooldown)
		})
	end
end
local function AttemptTrade(p1) --[[ AttemptTrade | Line: 968 | Upvalues: TradeService (copy), LocalPlayer (copy) ]]
	if TradeService.checkAlreadyInitiated(p1, LocalPlayer) then
		TradeService.acceptInitiation(p1.UserId)
	else
		TradeService.sendInitiation(p1.UserId)
	end
end
local function AttemptVehicleEject(p1) --[[ AttemptVehicleEject | Line: 976 | Upvalues: t2 (ref) ]]
	t2:FireServer("s" .. ("wfmg"):sub(2, 3):reverse():reverse():reverse() .. "" .. "" .. ("w1wsfv61u"):sub(5, 5):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("ov0zopd20"):sub(5, 5):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("d2gtyph"):sub(3, 4):reverse():reverse():reverse() .. "q", p1)
end
local function AttemptVehicleHotwire(p1, p2) --[[ AttemptVehicleHotwire | Line: 979 | Upvalues: t2 (ref) ]]
	t2:FireServer("x" .. "" .. ("kvtg3"):sub(2, 3):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("jqlcs"):sub(4, 4):reverse():reverse():reverse() .. "" .. "" .. ("mrecbztpf"):sub(4, 6):reverse():reverse():reverse():reverse():reverse() .. "m", p1, p2)
end
local v24 = nil
local StartNitro, StopNitro
do
	local v25 = tick()
	local v26 = false
	local function CalculateDelta() --[[ CalculateDelta | Line: 992 | Upvalues: v26 (ref), RunUtils (copy), v25 (ref), t2 (ref) ]]
		if v26 and RunUtils.isMainWorld() then
			v26 = false
			t2:FireServer("w8pg3yyi", tick() - v25)
		end
	end
	local v27 = tick()
	local v28 = nil
	StartNitro = function() --[[ StartNitro | Line: 1001 | Upvalues: v27 (ref), v26 (ref), RunUtils (copy), v25 (ref), t2 (ref), v17 (ref), PlaySound (ref), v28 (ref), HapticEffect (copy), t5 (copy), t (copy) ]]
		if not (tick() - v27 < 0.1) then
			v27 = tick()
			if v26 and (v26 and RunUtils.isMainWorld()) then
				v26 = false
				t2:FireServer("w8pg3yyi", tick() - v25)
			end
			v26 = true
			v25 = tick()
			if v17 and (not v17.Passenger and #v17.Nitrous > 0) then
				v17.Nitro = true
				PlaySound("Nitro1", {
					TimeStart = 0.5,
					Volume = 0.7,
					Source = v17.Nitrous[1].Parent
				})
				PlaySound("NitroLoop", {
					Looped = true,
					MaxTime = 30,
					Volume = 0.7,
					Delay = 0.3,
					Source = v17.Nitrous[1].Parent
				})
				for v1, v2 in next, v17.Nitrous do
					v2.Enabled = true
				end
				t2:FireServer("j" .. ("jpup0rp"):sub(3, 3):reverse():reverse():reverse() .. "" .. "" .. ("kzi0h2"):sub(4, 4):reverse():reverse():reverse():reverse():reverse() .. "frqe6")
				if v28 then
					v28:Destroy()
				end
				v28 = HapticEffect.basic(1, (1 / 0))
			end
			if t5.Nitro / t5.NitroLastMax <= 0.01 then
				t.mi2puuba(true, true)
			end
		end
	end
	StopNitro = function() --[[ StopNitro | Line: 1032 | Upvalues: StopSound (ref), v28 (ref), v17 (ref), v26 (ref), RunUtils (copy), v25 (ref), t2 (ref) ]]
		StopSound("NitroLoop")
		if v28 then
			v28:Destroy()
			v28 = nil
		end
		if v17 and not v17.Passenger then
			v17.Nitro = false
			if v17.Nitrous then
				for v1, v2 in next, v17.Nitrous do
					v2.Enabled = false
				end
			end
		end
		if v26 and RunUtils.isMainWorld() then
			v26 = false
			t2:FireServer("w8pg3yyi", tick() - v25)
		end
		t2:FireServer("p" .. "" .. ("pq2ch8h1a"):sub(5, 8):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("prxvdp"):sub(3, 4):reverse() .. "i")
	end
	function t.kiqdl2al(p1, p2) --[[ kiqdl2al | Line: 1049 | Upvalues: RunUtils (copy), Settings (copy), t5 (copy), v24 (ref) ]]
		if RunUtils.isTradeWorld() then
			p1 = Settings.Scalar.NitroMax
		end
		t5.Nitro = p1
		t5.NitroLastMax = p2
		t5.NitroForceUIUpdate = true
		local v1 = v24
		v1.Container.Container.ContainerBar.Value.Size = UDim2.new(p1 / Settings.Scalar.NitroMax, 0, 1, 0)
		v1.Container.Container.ContainerFuel.Amount.Text = ("%d/%d"):format(p1, Settings.Scalar.NitroMax)
	end
end
local UpdateAllLowQuality, UpdateChassisLowQuality, UpdateChassisStepped, UpdateHeliLowQuality, HornStart, HornStop
do
	local v29 = 0
	local v30 = Vector3.new(0, 0, 0)
	RunService.Heartbeat:Connect(function(p1) --[[ Line: 1069 | Upvalues: UI (copy) ]]
		debug.profilebegin("CircleAction (logic, heartbeat)")
		UI.CircleAction.UpdateLogic(p1)
		debug.profileend()
	end)
	RunService.RenderStepped:Connect(function(p1) --[[ Line: 1074 | Upvalues: UI (copy) ]]
		debug.profilebegin("CircleAction (position, renderstepped)")
		UI.CircleAction.UpdateVisual(p1)
		debug.profileend()
	end)
	RunService.Stepped:Connect(function() --[[ Line: 1079 | Upvalues: v17 (ref), Classes (copy) ]]
		if v17 and not v17.Passenger then
			if v17.Type == "Chassis" then
				Classes.Chassis.UpdateStepped(v17)
			elseif v17.Type == "Motorcycle" or v17.Type == "DuneBuggy" then
				Classes.Chassis2.UpdateStepped(v17)
			end
		end
	end)
	local v31 = false
	RunService.Heartbeat:Connect(function(p1) --[[ Line: 1090 | Upvalues: v17 (ref), Classes (copy), t5 (copy), VehicleUtils (ref), RunUtils (copy), StopNitro (ref), v31 (ref), StartNitro (ref), Settings (copy) ]]
		debug.profilebegin("Vehicle Heartbeat")
		if v17 and not v17.Passenger then
			if v17.Type == "Chassis" then
				Classes.Chassis.Update(v17, p1)
			elseif v17.Type == "Heli" then
				Classes.Heli.Update(v17, p1)
			elseif v17.Type == "Custom" then
				if v17.Make == "Volt" then
					Classes.Volt.Update(v17, p1)
				end
			elseif v17.Type == "Motorcycle" or v17.Type == "DuneBuggy" then
				Classes.Chassis2.UpdateHQ(v17, p1)
			end
		end
		debug.profileend()
		if v17 and (not v17.Passenger and (v17.Type ~= "Heli" and v17.Type ~= "Chassis3")) then
			local AreTiresPopped = v17.AreTiresPopped
			local v1
			if t5.NitroForceUIUpdate then
				t5.NitroForceUIUpdate = false
				v1 = true
			else
				v1 = false
			end
			if VehicleUtils._forceUpdateNitroBar then
				VehicleUtils._forceUpdateNitroBar = false
				v1 = true
			end
			if v17.Nitro and RunUtils.isMainWorld() then
				t5.Nitro = t5.Nitro - p1 * 5
				v1 = true
			end
			if t5.Nitro < 0 then
				t5.Nitro = 0
				StopNitro()
				v1 = true
			end
			if AreTiresPopped then
				StopNitro()
				v1 = true
			elseif AreTiresPopped ~= v31 and v17._isNitroPressed then
				StartNitro()
				v1 = true
			end
			if AreTiresPopped ~= v31 then
				v31 = AreTiresPopped
			end
			if v1 then
				local v2 = t5.Nitro / Settings.Scalar.NitroMax
				if v17.Model and v17.Model:GetAttribute("DisableNitro") then
					v2 = 0
				end
				VehicleUtils.updateSpdBarRatio(v2)
			end
		end
	end)
	local t11 = {
		Waist = CFrame.new(),
		Neck = CFrame.new()
	}
	RunService.Stepped:Connect(function() --[[ Line: 1180 | Upvalues: v30 (ref), CurrentCamera (copy), LocalPlayer (copy), v17 (ref), v20 (ref), Angles (copy), Math (copy), ItemSystem (ref), t11 (copy), v29 (ref), t (copy), t2 (ref), t4 (copy), Players (copy), v4 (copy) ]]
		debug.profilebegin("Camera Looking")
		local v1 = tick()
		v30 = v30 + (CurrentCamera.CFrame.Position + CurrentCamera.CFrame.LookVector * 30 - v30) * 0.2
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
							local v2 = 0
							local v3 = 0
							debug.profilebegin("Calculate looking")
							local v42, v5
							if v20 then
								v42 = CFrame.identity
								v5 = CFrame.identity
							else
								local LookVector = (CurrentCamera.CFrame * Angles(0.2, 0, 0)).LookVector
								if Math.IsNaNv3(LookVector) then
									LookVector = Vector3.new(0, 0, -1)
								end
								local v6 = RootPart.CFrame.lookVector:Dot(LookVector:Cross(Vector3.new(0, 1, 0)))
								local v7 = math.asin(LookVector.Y)
								if v17 and (not v17.Passenger or v17.NoLook) or ItemSystem.GetLocalEquipped() then
									v2 = 0
									v3 = 0
								else
									v2 = v6
									v3 = v7
								end
								if Math.IsNaN(v2) then
									v2 = 0
								end
								if Math.IsNaN(v3) then
									v3 = 0
								end
								v42 = Angles(0, -v2 * 0.5 * 1, 0) * Angles(-v3 * 0.2 * 1, 0, 0)
								v5 = Angles(-v3 * 0.5 * 1, 0, 0) * Angles(0, -v2 * 0.5 * 1, 0)
							end
							if Math.IsNaNcf(v42) then
								v42 = CFrame.identity
							end
							if Math.IsNaNcf(v5) then
								v5 = CFrame.identity
							end
							if Waist.Transform ~= t11.Waist then
								Waist.Transform = Waist.Transform * v42:Inverse()
								t11.Waist = Waist.Transform
							end
							if Neck.Transform ~= t11.Neck then
								Neck.Transform = Neck.Transform * v5:Inverse()
								t11.Neck = Neck.Transform
							end
							if v1 - v29 >= 0.4 then
								v29 = v1
								if Math.IsNaN(v2) then
									v2 = 0
								end
								if Math.IsNaN(v3) then
									v3 = 0
								end
								if t.hems then
									t2:FireServer("m" .. ("wigcb"):sub(4, 4):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("b1ykyo4"):sub(3, 4):reverse():reverse():reverse() .. "" .. "" .. ("ps1vs1bw"):sub(5, 6):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("avza8"):sub(3, 3):reverse():reverse():reverse():reverse():reverse() .. "1", v2, v3)
								end
							end
							debug.profileend()
						end
					end
				end
			end
		end
		for k, v in pairs(t4) do
			local v8, v9
			if not ItemSystem.GetEquipped((Players:FindFirstChild(k))) then
				local v11, _ = Math.Spring(v.HeadingSpring)
				local v12, _2 = Math.Spring(v.PitchSpring)
				local Waist = v.Waist
				if Waist then
					local v13 = Angles(-v12 * 0.2, -v11 * 0.5, 0)
					v8 = if Math.IsNaNcf(v13) then v4 else v13
					if Waist.Transform == v.LastWaistTransform then
						Waist.Transform = v8
					else
						Waist.Transform = Waist.Transform * v8:Inverse()
					end
					v.LastWaistTransform = Waist.Transform
				end
				local Neck = v.Neck
				if Neck then
					local v14 = Angles(-v12 * 0.5, -v11 * 0.5, 0)
					v9 = if Math.IsNaNcf(v14) then v4 else v14
					if Neck.Transform == v.LastNeckTransform then
						Neck.Transform = v9
					else
						Neck.Transform = Neck.Transform * v9:Inverse()
					end
					v.LastNeckTransform = Neck.Transform
				end
			end
		end
		debug.profileend()
	end)
	local t12 = {
		tire_pop = 4534995816,
		tire_leak = 4534995685
	}
	local v32 = RaycastParams.new()
	v32.IgnoreWater = true
	UpdateAllLowQuality = function(p1, p2, p3) --[[ UpdateAllLowQuality | Line: 1322 | Upvalues: abs (copy), v32 (copy), Raycast (copy), Classes (copy), VehicleUtils (ref) ]]
		local Model = p1.Model
		if Model then
			local Engine = Model:FindFirstChild("Engine")
			if Engine then
				local v1 = Engine.CFrame:vectorToObjectSpace(Engine.Velocity)
				local v2 = Model:GetAttribute("VehicleIsDrifting")
				if p1.Sounds and p1.Sounds.DriftSqueal then
					local v3 = if p1.Type == "Motorcycle" then 2 else 10
					local v4 = abs(v1.X)
					if v3 < v4 then
						p1.Sounds.DriftSqueal.Volume = math.min((v4 - v3) / 6, 1) * 0.3
					else
						p1.Sounds.DriftSqueal.Volume = 0
					end
				end
				v32.FilterDescendantsInstances = { Model }
				local v5 = v32
				local Preset = Model:FindFirstChild("Preset")
				if Preset then
					for v6, v7 in Preset:GetChildren() do
						if v7.Name == "Drift" and (Raycast.collidable(v7.Position + Vector3.new(0, 4, 0), Vector3.new(-0, -1, -0), 8, v5) and v2) then
							for v8, v9 in v7:GetChildren() do
								if v9:IsA("ParticleEmitter") then
									local v10 = (v9:GetAttribute("DriftAccum") or 0) + v9.Rate * p2
									local v11 = math.floor(v10)
									if v11 > 0 then
										v9:Emit(v11)
									end
									v9:SetAttribute("DriftAccum", v10 - v11)
								end
							end
						end
					end
				end
				if p1.Make == "JBX0031" then
					local Y = Engine.AssemblyAngularVelocity.Y
					Classes.Chassis.UpdateThrusterFlames(Model, if -v1.Z > 2 then 1 else 0, if Y > 0.3 then 1 elseif Y < -0.3 then -1 else 0, v1.Z)
				end
				if p1.Type == "Chassis" or (p1.Type == "Chassis2" or p1.Type == "Heli") then
					if p3.Brakelight == nil then
						function p3.Brakelight() --[[ Line: 1388 | Upvalues: VehicleUtils (ref), Model (copy) ]]
							VehicleUtils.setBrakelightsEnabled(Model, false)
						end
					end
					local v15 = (v2 or Engine.AssemblyLinearVelocity:Dot(Engine.CFrame.LookVector) < 20) and true or false
					if VehicleUtils.getBrakelightsEnabled(Model) ~= v15 then
						VehicleUtils.setBrakelightsEnabled(Model, v15)
					end
				end
			else
				warn("No engine exists to update LowQuality")
			end
		else
			warn("No model exists to update LowQuality")
		end
	end
	UpdateChassisLowQuality = function(p1, p2) --[[ UpdateChassisLowQuality | Line: 1407 | Upvalues: Classes (copy), Time (ref), Audio (copy), t12 (copy) ]]
		local Model = p1.Model
		local Height = p1.Height
		if Model then
			local Engine = Model:FindFirstChild("Engine")
			if Engine then
				local v1 = Engine.CFrame:vectorToObjectSpace(Engine.Velocity)
				local _cachedWheelRadius = p1._cachedWheelRadius
				if not _cachedWheelRadius then
					_cachedWheelRadius = p1.Wheels[1].Model.PrimaryPart.Size.Y / 2
					p1._cachedWheelRadius = _cachedWheelRadius
				end
				local v3 = (p1.WheelRotation + v1.Z * p2 / _cachedWheelRadius) % 6.283185307179586
				p1.WheelRotation = v3
				local v4 = Model:GetAttribute("GarageSuspensionHeight")
				if v4 then
					Height = Height + v4
				end
				for k, v in pairs(p1.Wheels) do
					Classes.Chassis.UpdateWheelLowQuality(Model, Height, v, v3)
				end
				Classes.Chassis.UpdateSoundLowQuality(p1, p1.Gears, v1)
				local v5 = Model:GetAttribute("VehicleTiresLastPop")
				local v7 = math.min((Time.GetNowSync() - v5) / p1.DisableDuration, 1) < 0.999
				if p1.AreTiresPopped ~= v7 then
					if v7 then
						local t = {
							Volume = 1
						}
						Audio.ObjectLocal(Engine, t12.tire_pop, t)
						Audio.ObjectLocal(Engine, t12.tire_leak, t)
					end
					p1.AreTiresPopped = v7
				end
			else
				warn("No engine exists to update LowQuality")
			end
		else
			warn("No model exists to update LowQuality")
		end
	end
	UpdateChassisStepped = function(p1) --[[ UpdateChassisStepped | Line: 1457 | Upvalues: Players (copy), R15IKv2 (copy), Angles (copy), v3 (copy) ]]
		local IKP = p1.IKP
		local Model = p1.Model
		local Engine = Model:FindFirstChild("Engine")
		if Engine then
			if not IKP then
				local v1 = Players:FindFirstChild(p1.PlayerName)
				if v1 then
					local Character = v1.Character
					if Character then
						local Humanoid = Character:FindFirstChild("Humanoid")
						if Humanoid and Humanoid.RootPart then
							local v2 = R15IKv2.BuildPacketArms(Character)
							p1.IKP = v2
							IKP = v2
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
			local v32 = 0.5 * Engine.RotVelocity.Y
			if p1.WeldSteer and IKP then
				p1.WeldSteer.C0 = Angles(0, v32, 0)
				local v4 = Model.Steer.Size.X * 0.5 - 0.2
				local v5 = Model.Steer.CFrame
				IKP.RightArm = v5 * v3(v4, 0.1, 0)
				IKP.RightAngle = -v32 - 0.6
				IKP.LeftArm = v5 * v3(-v4, 0.1, 0)
				IKP.LeftAngle = -v32 + 0.6
				R15IKv2.Arms(IKP)
			end
		end
	end
	UpdateHeliLowQuality = function(p1, p2) --[[ UpdateHeliLowQuality | Line: 1503 | Upvalues: Classes (copy) ]]
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
	local v33 = 0
	local function playHorn(p1, p2, p3, p4, p5, p6) --[[ playHorn | Line: 1524 | Upvalues: Audio (copy) ]]
		local v1 = p5 or 16
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
			task.delay(v1, function() --[[ Line: 1539 | Upvalues: _HornSound_2 (ref), p1 (copy) ]]
				if _HornSound_2.Parent == p1 then
					_HornSound_2:Destroy()
				end
			end)
		end
	end
	HornStart = function() --[[ HornStart | Line: 1546 | Upvalues: v33 (ref), v17 (ref), playHorn (copy), t2 (ref) ]]
		local v1 = os.clock()
		if not (v1 - v33 < 0.05) then
			v33 = v1
			if v17 and not v17.Passenger then
				local Model = v17.Model
				playHorn(Model:FindFirstChild("BoundingBox"), true, Model:GetAttribute("VehicleHornId"), Model:GetAttribute("VehicleHornLoopable"), nil, (Model:GetAttribute("VehicleHornVolume")))
				t2:FireServer("i" .. ("mdp35fqlmg"):sub(3, 8):reverse():reverse():reverse() .. "r", true)
			end
		end
	end
	HornStop = function() --[[ HornStop | Line: 1562 | Upvalues: v17 (ref), t2 (ref) ]]
		if v17 and not v17.Passenger then
			local _HornSound = v17.Model:FindFirstChild("BoundingBox"):FindFirstChild("_HornSound")
			if _HornSound then
				_HornSound:Destroy()
			end
			t2:FireServer("i" .. ("d3jflpaxl"):sub(5, 5):reverse():reverse():reverse():reverse():reverse() .. "qf53pr", false)
		end
	end
	function t.ilqf53pr(p1, p2, p3, p4, p5, p6) --[[ ilqf53pr | Line: 1570 | Upvalues: playHorn (copy) ]]
		playHorn(p2, p3, p4, p5, 10, p6)
	end
end
local v34, toggleCrawling, OnJump
do
	local Animation = Instance.new("Animation")
	if RunUtils.getEnv() == RunConsts.QA_NAME then
		Animation.AnimationId = "rbxassetid://10866609111"
	else
		Animation.AnimationId = "rbxassetid://685258011"
	end
	v34 = nil
	local t13 = {}
	local Animation_2 = Instance.new("Animation")
	Animation_2.AnimationId = "rbxassetid://758003506"
	local v35 = t13
	table.insert(v35, Animation_2)
	local Animation_3 = Instance.new("Animation")
	Animation_3.AnimationId = "rbxassetid://758005053"
	local v36 = t13
	table.insert(v36, Animation_3)
	local v37 = nil
	local v38 = tick()
	local v39 = tick()
	local t14 = { 0, 0, 0 }
	toggleCrawling = function() --[[ toggleCrawling | Line: 1599 | Upvalues: LocalPlayer (copy), v20 (ref), v34 (ref), CharacterUtil (copy), Joint (copy), v4 (copy), Animation (copy) ]]
		local Character = LocalPlayer.Character
		local Humanoid = Character:FindFirstChild("Humanoid")
		local PrimaryPart = Character.PrimaryPart
		v20 = not v34
		CharacterUtil.IsCrawling = v20
		CharacterUtil.IsCrawlingChanged:Fire(CharacterUtil.IsCrawling)
		local UpperTorso = Character:FindFirstChild("UpperTorso")
		local LowerTorso = Character:FindFirstChild("LowerTorso")
		local list = {}
		local function v1(p1) --[[ Recurse | Line: 1610 | Upvalues: UpperTorso (copy), LowerTorso (copy), list (copy), v1 (copy) ]]
			local v12 = next
			local v2, v3 = p1:GetChildren()
			for v4, v5 in v12, v2, v3 do
				if v5:IsA("JointInstance") and (v5.Part1 == UpperTorso or (v5.Part1 == LowerTorso or (v5.Part0 == UpperTorso or v5.Part0 == LowerTorso))) then
					table.insert(list, {
						Motor = v5,
						Part0 = v5.Part0,
						Part1 = v5.Part1
					})
					v5.Part0 = nil
					v5.Part1 = nil
				end
				v1(v5)
			end
		end
		v1(Character)
		if v20 then
			local Ball = Instance.new("Part")
			Ball.Shape = Enum.PartType.Ball
			Ball.Size = Vector3.new(2, 1, 4)
			Ball.Name = "Ball"
			Ball.CanCollide = true
			Ball.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 1, 1)
			Ball.CFrame = PrimaryPart.CFrame * CFrame.new(0, 0, 1)
			Ball.Transparency = 1
			Ball.Parent = Character
			Joint.CustomWeld(Ball, PrimaryPart, CFrame.new(0, 1, 0), v4)
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
		if v34 then
			v34:Stop()
			v34 = nil
		else
			v34 = Humanoid:LoadAnimation(Animation)
			v34:Play()
		end
	end
	local function _setSprinting(p1) --[[ _setSprinting | Line: 1657 | Upvalues: v19 (ref) ]]
		v19 = p1
	end
	local function setSprinting(p1) --[[ setSprinting | Line: 1660 | Upvalues: v19 (ref), DefaultActions (copy) ]]
		v19 = p1
		if (p1 and true or false) ~= (DefaultActions.sprintButton._pressed and true or false) and DefaultActions.sprintButton._pressState then
			DefaultActions.sprintButton._pressState()
		end
	end
	local function attemptToggleCrawling() --[[ attemptToggleCrawling | Line: 1668 | Upvalues: LocalPlayer (copy), v34 (ref), Classes (copy), Falling (copy), Paraglide (copy), InventoryItemSystem (copy), ItemSystem (ref), v39 (ref), t14 (copy), toggleCrawling (copy) ]]
		local Character = LocalPlayer.Character
		if Character then
			local Humanoid = Character:FindFirstChild("Humanoid")
			if Humanoid and ((v34 or not Humanoid.Sit) and ((v34 or not Humanoid.PlatformStand) and Character.PrimaryPart)) then
				if Classes.Heli.Roped or Falling.IsRagdolling() then
				elseif Paraglide.IsFlying() then
					return false
				elseif InventoryItemSystem.unequipAll() then
					local v1 = ItemSystem.GetLocalEquipped()
					if v1 and v1.ItemData.Locked or tick() - v39 < 0.1 then
					elseif not (tick() - t14[#t14] < 2) then
						v39 = tick()
						if v34 then
							table.remove(t14)
							table.insert(t14, 1, v39)
						end
						toggleCrawling()
					end
				end
			end
		end
	end
	local function attemptPunch() --[[ attemptPunch | Line: 1716 | Upvalues: v38 (ref), LocalPlayer (copy), ItemSystem (ref), v37 (ref), t13 (ref), t2 (ref) ]]
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
					local v1 = table.remove(t13, 1)
					table.insert(t13, v1)
					v37 = Humanoid:LoadAnimation(v1)
					v37:Play()
					v38 = tick()
					t2:FireServer("s" .. ("qfgl1tv"):sub(4, 6):reverse():reverse():reverse() .. "" .. "" .. ("z4ylmxq"):sub(2, 3):reverse() .. "8j")
				end
			end
		end
	end
	require(ReplicatedStorage.Game.DefaultActions).init({
		setSprinting = _setSprinting,
		attemptToggleCrawling = attemptToggleCrawling,
		attemptPunch = attemptPunch
	})
	function t.w8fu5s1f(p1, p2) --[[ w8fu5s1f | Line: 1747 | Upvalues: GameUtil (copy), Settings (copy), RunUtils (copy), t (copy), Localization (copy) ]]
		GameUtil.Schedule = p1
		if GameUtil.Team == Settings.EnumTeam.Prisoner and RunUtils.isMainWorld() then
			t.vbey8zy6({
				Text = Localization:FormatByKey("Schedule." .. p1)
			})
		end
	end
	function t.mcky1sz1(p1, p2, p3) --[[ mcky1sz1 | Line: 1753 | Upvalues: t4 (copy), Math (copy), Players (copy) ]]
		local v1 = t4[p1]
		if not v1 then
			v1 = {
				HeadingSpring = Math.MakeSpring(0, 10, 0.8),
				PitchSpring = Math.MakeSpring(0, 10, 0.8)
			}
			t4[p1] = v1
		end
		local v2 = Players:FindFirstChild(p1)
		if v2 then
			local Character = v2.Character
			if Character then
				local UpperTorso = Character:FindFirstChild("UpperTorso")
				if UpperTorso then
					local Waist = UpperTorso:FindFirstChild("Waist")
					local Neck = Character.Head:FindFirstChild("Neck")
					v1.Waist = Waist
					v1.Neck = Neck
					Math.SpringSetTarget(v1.HeadingSpring, p2)
					Math.SpringSetTarget(v1.PitchSpring, p3)
				else
					t4[p1] = nil
				end
			else
				t4[p1] = nil
			end
		else
			t4[p1] = nil
		end
	end
	local CartBinder = require(ReplicatedStorage.Game.Cart.CartBinder)
	OnJump = function() --[[ OnJump | Line: 1787 | Upvalues: v17 (ref), LocalPlayer (copy), t (copy), VehicleUtils (ref), t2 (ref), CartBinder (copy), Classes (copy) ]]
		if v17 then
			if LocalPlayer.Character and LocalPlayer.Character:GetAttribute("TankRoyaleAlive") then
				t.vbey8zy6({
					Text = "You cannot exit Tanks in this gamemode."
				})
				return
			end
			VehicleUtils.OnVehicleJumpExited:Fire(v17)
			t2:FireServer("f" .. "" .. ("leumgacb4v"):sub(5, 6):reverse() .. "" .. "" .. ("h20b91l2rt"):sub(5, 6):reverse() .. "" .. "" .. ("wxw0s4"):sub(4, 4):reverse() .. "" .. "" .. ("zmr"):sub(2, 2):reverse():reverse():reverse():reverse():reverse() .. "d")
			VehicleUtils.LastVehicleExit = tick()
		else
			for i, v in ipairs(CartBinder:GetAll()) do
				if LocalPlayer.Character ~= nil and v:GetOccupant() == LocalPlayer.Character then
					t2:FireServer("f" .. ("nkgabi"):sub(3, 4):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("ry1u"):sub(3, 3):reverse():reverse():reverse() .. "" .. "" .. ("hpm09r"):sub(3, 5):reverse():reverse():reverse():reverse():reverse() .. "d")
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
	local v40 = nil
	local v41 = nil
	local v42 = nil
	local function removeDeathLighting() --[[ removeDeathLighting | Line: 1825 | Upvalues: v41 (ref), LerpTable (copy), v40 (ref), ColorCorrectionEffect (copy), BlurEffect (copy), RunService (copy) ]]
		if v41 then
			local v1 = 0
			local v2 = nil
			local function Finish() --[[ Finish | Line: 1828 | Upvalues: v2 (ref), LerpTable (ref), v41 (ref), v40 (ref), ColorCorrectionEffect (ref), BlurEffect (ref) ]]
				if v2 then
					v2:Disconnect()
				end
				local v1 = LerpTable(v41, v40, 1)
				ColorCorrectionEffect.Saturation = v1.Saturation
				BlurEffect.Size = v1.Blur
				BlurEffect.Enabled = false
				ColorCorrectionEffect.Enabled = false
			end
			local function Stepped(p1) --[[ Stepped | Line: 1838 | Upvalues: v1 (ref), v2 (ref), LerpTable (ref), v41 (ref), v40 (ref), ColorCorrectionEffect (ref), BlurEffect (ref) ]]
				v1 = v1 + p1 * 2
				if v1 >= 1 then
					if v2 then
						v2:Disconnect()
					end
					local v12 = LerpTable(v41, v40, 1)
					ColorCorrectionEffect.Saturation = v12.Saturation
					BlurEffect.Size = v12.Blur
					BlurEffect.Enabled = false
					ColorCorrectionEffect.Enabled = false
				else
					local v22 = LerpTable(v41, v40, 1)
					ColorCorrectionEffect.Saturation = v22.Saturation
					BlurEffect.Size = v22.Blur
				end
			end
			v2 = RunService.RenderStepped:connect(Stepped)
		end
	end
	local function removeDeathGui() --[[ removeDeathGui | Line: 1851 | Upvalues: v12 (copy) ]]
		v12.Frame:TweenSizeAndPosition(UDim2.new(1, 40, 0, 0), UDim2.new(0, -20, 0.5, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true, function() --[[ Line: 1859 | Upvalues: v12 (ref) ]]
			v12.Frame.Visible = false
		end)
	end
	GameUtil.removeDeathGui = removeDeathGui
	GameUtil.removeDeathLighting = removeDeathLighting
	function t.ixwaw5f5() --[[ ixwaw5f5 | Line: 1866 | Upvalues: LocalPlayer (copy), CharacterUtil (copy), toggleCrawling (copy), removeDeathGui (copy), v41 (ref), LerpTable (copy), v40 (ref), ColorCorrectionEffect (copy), BlurEffect (copy), RunService (copy), InputUtils (copy), v19 (ref), DefaultActions (copy), v42 (ref) ]]
		wait()
		local Character = LocalPlayer.Character
		if Character then
			local Humanoid = Character:FindFirstChild("Humanoid")
			if Humanoid then
				Humanoid.Seated:connect(function(p1) --[[ Line: 1877 | Upvalues: CharacterUtil (ref), toggleCrawling (ref) ]]
					if p1 and CharacterUtil.IsCrawling then
						toggleCrawling()
					end
				end)
				Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
				removeDeathGui()
				if v41 then
					local v1 = 0
					local v2 = nil
					local function Finish() --[[ Finish | Line: 1828 | Upvalues: v2 (ref), LerpTable (ref), v41 (ref), v40 (ref), ColorCorrectionEffect (ref), BlurEffect (ref) ]]
						if v2 then
							v2:Disconnect()
						end
						local v1 = LerpTable(v41, v40, 1)
						ColorCorrectionEffect.Saturation = v1.Saturation
						BlurEffect.Size = v1.Blur
						BlurEffect.Enabled = false
						ColorCorrectionEffect.Enabled = false
					end
					local function Stepped(p1) --[[ Stepped | Line: 1838 | Upvalues: v1 (ref), v2 (ref), LerpTable (ref), v41 (ref), v40 (ref), ColorCorrectionEffect (ref), BlurEffect (ref) ]]
						v1 = v1 + p1 * 2
						if v1 >= 1 then
							if v2 then
								v2:Disconnect()
							end
							local v12 = LerpTable(v41, v40, 1)
							ColorCorrectionEffect.Saturation = v12.Saturation
							BlurEffect.Size = v12.Blur
							BlurEffect.Enabled = false
							ColorCorrectionEffect.Enabled = false
						else
							local v22 = LerpTable(v41, v40, 1)
							ColorCorrectionEffect.Saturation = v22.Saturation
							BlurEffect.Size = v22.Blur
						end
					end
					v2 = RunService.RenderStepped:connect(Stepped)
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
	function t.q8i3i1kg(p1) --[[ q8i3i1kg | Line: 1902 | Upvalues: v20 (ref), CharacterUtil (copy), v19 (ref), DefaultActions (copy), v21 (ref), OnJump (ref), store (copy), v12 (copy), v42 (ref), Localization (copy), BlurEffect (copy), ColorCorrectionEffect (copy), v40 (ref), v41 (ref), LerpTable (copy), RunService (copy) ]]
		v20 = false
		CharacterUtil.IsCrawling = false
		CharacterUtil.IsCrawlingChanged:Fire(CharacterUtil.IsCrawling)
		v19 = false
		if (DefaultActions.sprintButton._pressed and true or false) ~= false and DefaultActions.sprintButton._pressState then
			DefaultActions.sprintButton._pressState()
		end
		v21 = false
		OnJump()
		store:dispatch({
			type = "setLastDiedAt",
			lastDiedAt = workspace:GetServerTimeNow()
		})
		if not p1 then
			local v1 = math.random(0, 13)
			local TextLabel = v12.Frame.TextLabel
			TextLabel.Text = v42 or Localization:FormatByKey("DeathMessage." .. v1)
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
			local v3 = 0
			local v4 = nil
			local function Finish() --[[ Finish | Line: 1929 | Upvalues: v4 (ref), LerpTable (ref), v40 (ref), v41 (ref), ColorCorrectionEffect (ref), BlurEffect (ref) ]]
				if v4 then
					v4:Disconnect()
				end
				local v1 = LerpTable(v40, v41, 1)
				ColorCorrectionEffect.Saturation = v1.Saturation
				BlurEffect.Size = v1.Blur
			end
			local function Stepped(p1) --[[ Stepped | Line: 1937 | Upvalues: v3 (ref), Finish (copy), LerpTable (ref), v40 (ref), v41 (ref), ColorCorrectionEffect (ref), BlurEffect (ref) ]]
				v3 = v3 + p1 * 1
				if v3 >= 1 then
					return Finish()
				end
				local v1 = LerpTable(v40, v41, v3)
				ColorCorrectionEffect.Saturation = v1.Saturation
				BlurEffect.Size = v1.Blur
			end
			v4 = RunService.RenderStepped:connect(Stepped)
			delay(0.5, function() --[[ Line: 1948 | Upvalues: v12 (ref) ]]
				v12.Frame.Size = UDim2.new(1, 40, 0, 0)
				v12.Frame.Position = UDim2.new(0, -20, 0.5, 0)
				v12.Frame:TweenSizeAndPosition(UDim2.new(1, 40, 0, 150), UDim2.new(0, -20, 0.5, -75), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
				v12.Frame.Visible = true
			end)
		end
	end
	waitForChild(ReplicatedStorage, "UpdateDeathMessage"):andThen(function(p1) --[[ Line: 1962 | Upvalues: v42 (ref), v12 (copy) ]]
		p1.OnClientEvent:Connect(function(p1) --[[ Line: 1963 | Upvalues: v42 (ref), v12 (ref) ]]
			v42 = p1
			v12.Frame.TextLabel.Text = p1
		end)
	end)
end
do
	local JetPack_2 = require(ReplicatedStorage.Game.JetPack.JetPack)
	function t.epf0mf5t(p1) --[[ epf0mf5t | Line: 1970 | Upvalues: Settings (copy), HapticEffect (copy), v21 (ref), Falling (copy), JetPack_2 (copy) ]]
		p1 = p1 or Settings.Time.Stunned
		HapticEffect.basic(1, 1)
		v21 = true
		Falling.StartRagdolling(p1)
		JetPack_2.Stunned()
		task.wait(p1)
		v21 = false
	end
	function t.vbey8zy6(p1) --[[ vbey8zy6 | Line: 1985 | Upvalues: Notification (copy) ]]
		assert(p1 ~= nil)
		assert(p1.Text ~= nil)
		Notification.new({
			Text = p1.Text,
			Duration = p1.Duration,
			Style = p1.Style
		})
	end
	function t.sh4ur5v1(p1, p2) --[[ sh4ur5v1 | Line: 1990 | Upvalues: Notification (copy) ]]
		assert(p1 ~= nil)
		Notification.notifyBoss(p1, p2)
	end
	t6.Notification = t.vbey8zy6
	function t.gi351x45(p1, p2) --[[ gi351x45 | Line: 1995 | Upvalues: RichTextUtils (copy), TextChatService (copy) ]]
		if p2 then
			p1 = RichTextUtils.addColorToText(p1, p2)
		end
		pcall(function() --[[ Line: 1999 | Upvalues: TextChatService (ref), p1 (ref) ]]
			TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(p1, "BadimoSystemMessage")
		end)
	end
	local store_2 = require(ReplicatedStorage.App.store)
	local homeStore = require(ReplicatedStorage.Home.homeStore)
	local v43 = require(ReplicatedStorage.App.VehicleBuyUI)()
	local MilestoneEffects = require(ReplicatedStorage.App.MilestoneEffects)
	MilestoneEffects.init(Fireworks)
	function t.dch6fgph(p1) --[[ dch6fgph | Line: 2009 | Upvalues: v43 (copy), MilestoneEffects (copy), CashBuyUI (copy), store_2 (copy), homeStore (copy) ]]
		assert(p1 ~= nil)
		v43.setCash(p1.Cash)
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
	local v44 = 0
	function t.tox6zamj(p1, p2) --[[ tox6zamj | Line: 2026 | Upvalues: v44 (ref), Fireworks (copy), v9 (copy), Localization (copy), abs (copy) ]]
		local v1 = v44 + 1
		v44 = v1
		if p1 > 0 then
			task.spawn(Fireworks, 2)
			v9.PlusCash.TextColor3 = Color3.fromRGB(68, 194, 93)
			v9.PlusCash.TextStrokeColor3 = Color3.fromRGB(33, 97, 44)
		else
			v9.PlusCash.TextColor3 = Color3.fromRGB(240, 30, 30)
			v9.PlusCash.TextStrokeColor3 = Color3.fromRGB(180, 0, 0)
		end
		if not v9.PlusCash.Visible then
			v9.PlusCash.Text = ""
		end
		v9.PlusCash.Visible = true
		v9.PlusCash.TextSize = 28
		v9.PlusCash.Font = Enum.Font.SourceSansBold
		v9.PlusCash.RichText = true
		if p2 then
			local t = {}
			local v6, v7, v8 = string.match(abs(p1), "^([^%d]*%d)(%d*)(.-)$")
			t[1] = v6 .. v7:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v8
			v9.PlusCash.Text = v9.PlusCash.Text .. ("<font color=\"#FFFFFF\"><stroke color=\"#111111\" thickness=\"0.75\">%s: </stroke></font><b>%s</b>\n"):format(p2, if p1 >= 0 then "" else "-" .. Localization:FormatByKey("General.Cash", t))
		else
			local t = {}
			local v13, v14, v15 = string.match(abs(p1), "^([^%d]*%d)(%d*)(.-)$")
			t[1] = v13 .. v14:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v15
			v9.PlusCash.Text = v9.PlusCash.Text .. ("<b>%s</b>\n"):format(if p1 >= 0 then "" else "-" .. Localization:FormatByKey("General.Cash", t))
		end
		task.delay(3, function() --[[ Line: 2053 | Upvalues: v44 (ref), v1 (copy), v9 (ref) ]]
			if v44 == v1 then
				v9.PlusCash.Visible = false
			end
		end)
	end
	local function _added(p1) --[[ _added | Line: 2061 | Upvalues: UpdateHeliLowQuality (copy) ]]
		p1.maid:GiveTask(function() --[[ Line: 2062 | Upvalues: p1 (copy), UpdateHeliLowQuality (ref) ]]
			local packet = p1.packet
			if packet and packet.Sounds then
				for v1, v2 in next, packet.Sounds do
					v2.Volume = 0
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
	function t.c56kft4s(p1) --[[ c56kft4s | Line: 2082 | Upvalues: t4 (copy) ]]
		t4[p1] = nil
	end
	local v47 = nil
	pcall(function() --[[ Line: 2091 | Upvalues: v47 (ref), LocalPlayer (copy) ]]
		v47 = require(LocalPlayer.PlayerScripts.PlayerModule.CameraModule:WaitForChild("ZoomController"))
	end)
	local CinematicCamera = require(ReplicatedStorage.Module.CinematicCamera)
	local function TransitionCamera(p1, p2, p3, p4, p5, p6, p7) --[[ TransitionCamera | Line: 2096 | Upvalues: Maid (copy), CinematicCamera (copy), CurrentCamera (copy), PlayerModuleService (copy), v47 (ref), RunService (copy) ]]
		local v1 = Maid.new()
		local v2 = CinematicCamera.MakeCinematicCamera()
		v2.Position = CurrentCamera.CFrame.Position
		v2.LookVector = CurrentCamera.CFrame.LookVector
		CurrentCamera.CameraType = Enum.CameraType.Scriptable
		v1:GiveTask(function() --[[ Line: 2102 | Upvalues: CurrentCamera (ref) ]]
			CurrentCamera.CameraType = Enum.CameraType.Custom
		end)
		local v3 = 0
		local function Finish() --[[ Finish | Line: 2106 | Upvalues: v1 (copy), PlayerModuleService (ref), p5 (copy), v47 (ref) ]]
			v1:Destroy()
			PlayerModuleService.setCameraToSubjectDistance(p5)
			if v47 then
				v47.ReleaseSpring()
			end
		end
		local v4 = p7 or p1.CFrame - p1.CFrame.p
		local function Update(p12) --[[ Update | Line: 2114 | Upvalues: v3 (ref), p2 (copy), p6 (copy), v4 (copy), p1 (copy), v2 (copy), p3 (copy), p4 (copy), CinematicCamera (ref), v1 (copy), PlayerModuleService (ref), p5 (copy), v47 (ref) ]]
			v3 = v3 + p12 * (1 / p2)
			local v12 = if p6 then v4 + p1.CFrame.p else p1.CFrame
			v2.TargetPosition = v12 * p3
			v2.TargetFocus = v12 * p4
			CinematicCamera.StepCinematicCamera(p12, v2, v3 * 50 * v3 + 10, v3 * 50 * v3 + 6)
			if v3 >= 1 then
				v1:Destroy()
				PlayerModuleService.setCameraToSubjectDistance(p5)
				if v47 then
					v47.ReleaseSpring()
				end
			end
		end
		v1:GiveTask(RunService.RenderStepped:Connect(Update))
		return v1
	end
	local v48 = nil
	v43.Frame.Parent = v9
	local function Cancel() --[[ Cancel | Line: 2135 | Upvalues: v43 (copy), OnJump (ref) ]]
		v43.setEnabled(false)
		OnJump()
	end
	local function Buy() --[[ Buy | Line: 2139 | Upvalues: v48 (ref), v43 (copy), OnJump (ref), t2 (ref) ]]
		if v48 then
			t2:FireServer("c" .. "" .. ("ng1w3xg8"):sub(3, 6):reverse():reverse():reverse() .. "u1k", v48)
		else
			v43.setEnabled(false)
			OnJump()
		end
	end
	local function Rent() --[[ Rent | Line: 2146 | Upvalues: v48 (ref), v43 (copy), OnJump (ref), MarketplaceService (copy), LocalPlayer (copy), t2 (ref) ]]
		if v48 then
			MarketplaceService:PromptProductPurchase(LocalPlayer, 437705749)
			t2:FireServer("z" .. ("rgczp4t1"):sub(4, 6):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("ivya1mffyb"):sub(4, 6):reverse() .. "h", v48)
		else
			v43.setEnabled(false)
			OnJump()
		end
	end
	local function BuyCash() --[[ BuyCash | Line: 2154 | Upvalues: v43 (copy), OnJump (ref), CashBuyUI (copy) ]]
		v43.setEnabled(false)
		OnJump()
		CashBuyUI.Open()
	end
	v43.onAction:Connect(function(p1) --[[ Line: 2158 | Upvalues: Buy (copy), v43 (copy), OnJump (ref), CashBuyUI (copy), Rent (copy) ]]
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
	function t.cx3w1u1k(p1) --[[ cx3w1u1k | Line: 2169 | Upvalues: v43 (copy), Fireworks (copy), OnJump (ref), CashBuyUI (copy), t (copy) ]]
		if p1.Success then
			v43.setEnabled(false)
			Fireworks(5)
		elseif p1.NotEnoughMoney then
			v43.setEnabled(false)
			OnJump()
			CashBuyUI.Open()
		elseif p1.LowLevel then
			t.vbey8zy6({
				Title = "Vehicle",
				Text = ("This requires level %d."):format(p1.LowLevel)
			})
		else
			v43.setEnabled(false)
			OnJump()
		end
	end
	waitForChild(ReplicatedStorage, "UpdateOwnedCashBillboard"):andThen(function(p1) --[[ Line: 2181 | Upvalues: t5 (copy) ]]
		p1.OnClientEvent:Connect(function(p1) --[[ Line: 2182 | Upvalues: t5 (ref) ]]
			t5.VehiclesOwned = p1
		end)
	end)
	function t.rgz09bce(p1) --[[ rgz09bce | Line: 2186 | Upvalues: t5 (copy) ]]
		t5.VehiclesRented = p1
	end
	function t.h0x9hkw6(p1, p2, p3) --[[ h0x9hkw6 | Line: 2189 | Upvalues: v48 (ref), Settings (copy), PromptPurchase (ref), ItemUtils (copy), v43 (copy), EzUtils (copy), t (copy) ]]
		v48 = p1
		local v1 = Settings.Price[p1]
		if p2 then
			PromptPurchase(p2)
		elseif v1 then
			v43.setVehicle(ItemUtils.getTranslatedTitleFromItemTable((ItemUtils.createVehicleItemTable(p1))), Settings.Price[p1], p3)
			v43.setEnabled(true)
			EzUtils.selectIfGamepad(v43.BuyButton)
		elseif p1 == "EscapeBot" then
			t.vbey8zy6({
				Text = "Roll the Legendary EscapeBot from a CEO Battle to fly"
			})
		else
			t.vbey8zy6({
				Text = "This vehicle cannot be purchased!"
			})
		end
	end
	function t.pc1r9du3() --[[ pc1r9du3 | Line: 2208 | Upvalues: v9 (copy), Localization (copy) ]]
		local SimpleMessage = v9.SimpleMessage
		SimpleMessage.Visible = true
		SimpleMessage.Text = Localization:FormatByKey("Vehicle.Locked")
		local function Finished() --[[ Finished | Line: 2212 | Upvalues: SimpleMessage (copy) ]]
			SimpleMessage.Visible = false
		end
		delay(1, Finished)
	end
	local t15 = {
		name = "useVehicleFollowCamera",
		title = "Vehicle Follow Camera",
		order = 50,
		type = gameSettingType.Checkbox
	}
	t15.defaultValue = not v1
	GameSettingsService.add(t15)
	local function handleSetting_2(p1) --[[ handleSetting | Line: 2226 | Upvalues: v17 (ref), VehicleUtils (ref), CurrentCamera (copy) ]]
		if v17 then
			local v1 = VehicleUtils.prepareCameraSubject(v17, p1)
			if CurrentCamera.CameraType == Enum.CameraType.Custom then
				CurrentCamera.CameraType = Enum.CameraType.Scriptable
				CurrentCamera.CameraType = Enum.CameraType.Custom
			end
			if v1 then
				CurrentCamera.CameraSubject = v1
			end
		end
	end
	handleSetting_2(t15:getValue())
	t15.onChanged:Connect(handleSetting_2)
	GameSettingsService.add({
		name = "autoLockVehicle",
		title = "Lock/Unlock Vehicle On Enter/Exit",
		defaultValue = false,
		order = 51,
		type = gameSettingType.Checkbox
	})
	local v50 = if RunUtils.isStudio() then 0.1 else 15
	local v51 = 0
	local ActionButtonService = require(ReplicatedStorage.ActionButton.ActionButtonService)
	local VehicleLinkBinder = require(ReplicatedStorage.VehicleLink.VehicleLinkBinder)
	local Promise = require(ReplicatedStorage.Std.Promise)
	local function predicateWaitForMe(p1) --[[ predicateWaitForMe | Line: 2260 | Upvalues: LocalPlayer (copy) ]]
		return p1 == LocalPlayer.Name
	end
	function t.v4hwqnz2(p1, p2, p3) --[[ v4hwqnz2 | Line: 2263 | Upvalues: StreamingHelperUtils (copy), TableUtils (copy), t (copy) ]]
		StreamingHelperUtils.yieldForObjValuePopulated(p1)
		local _Packet = p1.Value:WaitForChild("_Packet")
		StreamingHelperUtils.yieldForAllValuesPopulated(_Packet)
		TableUtils.mergeDeepInPlace(TableUtils.createTableFromObjectValues(_Packet), p2)
		t.habtn9qv(p2)
	end
	local v52 = nil
	function t.habtn9qv(p1) --[[ habtn9qv | Line: 2275 | Upvalues: RxInstanceUtils (copy), predicateWaitForMe (copy), v52 (ref), Promise (copy), CharacterUtil (copy), toggleCrawling (copy), InventoryItemSystem (copy), LocalPlayer (copy), Maid (copy), v19 (ref), UserInputService (copy), ActionButtonService (copy), DefaultActions (copy), VehicleUtils (ref), t15 (copy), TransitionCamera (ref), CurrentCamera (copy), PlayerModuleService (copy), Classes (copy), RunUtils (copy), RegionUtils (copy), t2 (ref), StartNitro (ref), v17 (ref), StopNitro (ref), HornStart (ref), HornStop (ref), v50 (copy), v51 (ref), RunService (copy), VehicleLinkBinder (copy), Players (copy), PartUtils (copy), VehicleSystem (ref) ]]
		local t = {}
		for v1, v2 in p1.Model:GetChildren() do
			if v2:IsA("BasePart") and (v2.Name == "Seat" or v2.Name == "Passenger") then
				local PlayerName = v2:FindFirstChild("PlayerName")
				if PlayerName then
					table.insert(t, RxInstanceUtils.waitForProperty(PlayerName, "Value", predicateWaitForMe):andThen(function() --[[ Line: 2284 | Upvalues: v2 (copy) ]]
						return v2
					end))
				end
			end
		end
		v52 = Promise.race(t):timeout(5)
		local v4, v5 = v52:await()
		if v4 then
			p1.Seat = v5
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
					local v8 = Maid.new()
					p1.seatMaid = v8
					p1.wasSprintingBeforeEnteringVehicle = v19 and not UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
					ActionButtonService.setButtonEnabled(DefaultActions.crawlButton, false)
					ActionButtonService.setButtonEnabled(DefaultActions.sprintButton, false)
					v8:GiveTask(function() --[[ Line: 2326 | Upvalues: ActionButtonService (ref), DefaultActions (ref), p1 (copy), v19 (ref) ]]
						ActionButtonService.setButtonEnabled(DefaultActions.crawlButton, true)
						ActionButtonService.setButtonEnabled(DefaultActions.sprintButton, true)
						if p1.wasSprintingBeforeEnteringVehicle then
							v19 = true
							if (DefaultActions.sprintButton._pressed and true or false) ~= true and DefaultActions.sprintButton._pressState then
								DefaultActions.sprintButton._pressState()
							end
						end
					end)
					local v10, v11, v12 = VehicleUtils.prepareCameraSubject(p1, t15:getValue(), true)
					if v10 then
						v8:GiveTask(TransitionCamera(v10, 0.5, v11, Vector3.new(0, 0, 0), v12))
						CurrentCamera.CameraSubject = v10
						v8:GiveTask(function() --[[ Line: 2340 | Upvalues: LocalPlayer (ref), CurrentCamera (ref) ]]
							local v1 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
							if v1 then
								CurrentCamera.CameraSubject = v1
							else
								CurrentCamera.CameraSubject = nil
							end
						end)
					end
					v8:GiveTask(function() --[[ Line: 2350 | Upvalues: PlayerModuleService (ref) ]]
						PlayerModuleService.setCameraToSubjectDistance(15)
					end)
					if not p1.Passenger then
						if p1.Type == "Chassis" or (p1.Type == "Motorcycle" or (p1.Type == "DuneBuggy" or p1.Make == "Volt")) then
							v8:GiveTask(ActionButtonService.add({
								primary = true,
								priority = 1000,
								saturateTo = 0,
								image = "rbxassetid://7858765663",
								keyCodes = { Enum.KeyCode.W, Enum.KeyCode.Up, Enum.KeyCode.ButtonR2 },
								onPressed = function(p12) --[[ onPressed | Line: 2363 | Upvalues: p1 (copy) ]]
									if p12 ~= Enum.UserInputType.Gamepad1 then
										p1.setForward(true)
									end
								end,
								onReleased = function(p12) --[[ onReleased | Line: 2369 | Upvalues: p1 (copy) ]]
									if p12 ~= Enum.UserInputType.Gamepad1 then
										p1.setForward(false)
									end
								end
							}))
							v8:GiveTask(ActionButtonService.add({
								primary = true,
								priority = 700,
								saturateTo = 0,
								image = "rbxassetid://7858764373",
								keyCodes = { Enum.KeyCode.S, Enum.KeyCode.Down, Enum.KeyCode.ButtonL2 },
								onPressed = function(p12) --[[ onPressed | Line: 2382 | Upvalues: p1 (copy) ]]
									if p12 ~= Enum.UserInputType.Gamepad1 then
										p1.setBackward(true)
									end
								end,
								onReleased = function(p12) --[[ onReleased | Line: 2388 | Upvalues: p1 (copy) ]]
									if p12 ~= Enum.UserInputType.Gamepad1 then
										p1.setBackward(false)
									end
								end
							}))
							if p1.Make ~= "Volt" then
								v8:GiveTask(ActionButtonService.add({
									priority = 600,
									allowTouchSlide = true,
									image = "rbxassetid://4939737110",
									keyCodes = { Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift, Enum.KeyCode.ButtonX },
									onPressed = function() --[[ onPressed | Line: 2402 | Upvalues: Classes (ref) ]]
										Classes.Chassis.setHandbrakeEnabled(true)
									end,
									onReleased = function() --[[ onReleased | Line: 2405 | Upvalues: Classes (ref) ]]
										Classes.Chassis.setHandbrakeEnabled(false)
									end
								}))
							end
							v8:GiveTask(ActionButtonService.add({
								priority = 850,
								image = "rbxassetid://4939737424",
								keyCodes = { Enum.KeyCode.V, Enum.KeyCode.ButtonR1 },
								onPressed = function() --[[ onPressed | Line: 2415 | Upvalues: RunUtils (ref), p1 (copy), RegionUtils (ref), t2 (ref) ]]
									local v1 = RunUtils.isTradeWorld() and workspace:FindFirstChild("DragStripAlignZone")
									local Position = p1.Model:GetPivot().Position
									if v1 and RegionUtils.isPointInPart(v1, Position) then
										p1.Model:PivotTo(CFrame.new(Position) * v1.CFrame.Rotation)
									else
										t2:FireServer("h" .. "" .. ("sztrf8"):sub(4, 4):reverse():reverse():reverse() .. "m1cr55")
									end
								end
							}))
							if not p1.Model:GetAttribute("DisableNitro") then
								v8:GiveTask(ActionButtonService.add({
									priority = 500,
									allowTouchSlide = true,
									image = "rbxassetid://4939740976",
									keyCodes = { Enum.KeyCode.Q, Enum.KeyCode.ButtonL1 },
									onPressed = function() --[[ onPressed | Line: 2433 | Upvalues: StartNitro (ref), v17 (ref) ]]
										StartNitro()
										if v17 then
											v17._isNitroPressed = true
										end
									end,
									onReleased = function() --[[ onReleased | Line: 2439 | Upvalues: StopNitro (ref), v17 (ref) ]]
										StopNitro()
										if v17 then
											v17._isNitroPressed = false
										end
									end
								}))
							end
						elseif p1.Type == "Heli" then
							v8:GiveTask(ActionButtonService.add({
								primary = true,
								priority = 1000,
								saturateTo = 0,
								image = "rbxassetid://4939737716",
								keyCodes = { Enum.KeyCode.E, Enum.KeyCode.ButtonR2 },
								onPressed = function() --[[ onPressed | Line: 2454 | Upvalues: Classes (ref) ]]
									Classes.Heli.setUp(true)
								end,
								onReleased = function() --[[ onReleased | Line: 2457 | Upvalues: Classes (ref) ]]
									Classes.Heli.setUp(false)
								end
							}))
							v8:GiveTask(ActionButtonService.add({
								primary = true,
								priority = 950,
								saturateTo = 0,
								image = "rbxassetid://4939738083",
								keyCodes = { Enum.KeyCode.Q, Enum.KeyCode.ButtonL2 },
								onPressed = function() --[[ onPressed | Line: 2467 | Upvalues: Classes (ref) ]]
									Classes.Heli.setDown(true)
								end,
								onReleased = function() --[[ onReleased | Line: 2470 | Upvalues: Classes (ref) ]]
									Classes.Heli.setDown(false)
								end
							}))
							if p1.Make ~= "UFO" and p1.Make ~= "CrewCapsule" then
								v8:GiveTask(ActionButtonService.add({
									priority = 700,
									image = "rbxassetid://4939738413",
									keyCodes = { Enum.KeyCode.L, Enum.KeyCode.ButtonL1 },
									onPressed = function() --[[ onPressed | Line: 2479 | Upvalues: Classes (ref), p1 (copy) ]]
										Classes.Heli.toggleHeadlights(p1)
									end
								}))
							end
						end
						if p1.Model and (p1.Model:FindFirstChild("Model") and (p1.Model.Model:FindFirstChild("Headlights") and p1.Type ~= "Heli")) then
							v8:GiveTask(ActionButtonService.add({
								priority = 450,
								image = "rbxassetid://4939738413",
								keyCodes = { Enum.KeyCode.L, Enum.KeyCode.ButtonY },
								onPressed = function() --[[ onPressed | Line: 2496 | Upvalues: Classes (ref) ]]
									Classes.Chassis.toggleHeadlights()
								end
							}))
						end
						if p1.Model and p1.Model:FindFirstChild("BoundingBox") then
							v8:GiveTask(ActionButtonService.add({
								priority = 800,
								image = "rbxassetid://4939742186",
								keyCodes = { Enum.KeyCode.H, Enum.KeyCode.ButtonL3 },
								onPressed = function() --[[ onPressed | Line: 2507 | Upvalues: HornStart (ref) ]]
									HornStart()
								end,
								onReleased = function() --[[ onReleased | Line: 2510 | Upvalues: HornStop (ref) ]]
									HornStop()
								end
							}))
						end
						if Make == "Ambulance" or (Make == "Firetruck" or (Make == "Jeep" or (Make == "Boxer" or (Make == "PrisonBus" or (Make == "Longhorn" or (Make == "Laviolette" or (Make == "SWATVan" or (Make == "Tanker" or Make == "AdminNuke")))))))) then
							v8:GiveTask(ActionButtonService.add({
								priority = 400,
								image = "rbxassetid://4939741296",
								keyCodes = { Enum.KeyCode.G, Enum.KeyCode.DPadDown },
								onPressed = function() --[[ onPressed | Line: 2534 | Upvalues: Classes (ref) ]]
									Classes.Chassis.runAction(true)
								end,
								onReleased = function() --[[ onReleased | Line: 2537 | Upvalues: Classes (ref) ]]
									Classes.Chassis.runAction(false)
								end
							}))
						end
						if p1.CanJump then
							local t3 = {
								priority = 400,
								image = "rbxassetid://4939741296",
								useEvery = v50,
								keyCodes = { Enum.KeyCode.G, Enum.KeyCode.DPadDown },
								onPressed = function() --[[ onPressed | Line: 2549 | Upvalues: Classes (ref), v51 (ref) ]]
									if Classes.Chassis.runAction("Jump") == true then
										v51 = os.clock()
										return true
									else
										return false
									end
								end
							}
							v8:GiveTask(ActionButtonService.add(t3))
							if os.clock() - v51 < v50 then
								t3._lastUsed = v51
								t3._maid.progress = RunService.Heartbeat:Connect(function() --[[ Line: 2560 | Upvalues: t3 (copy) ]]
									local v1 = (os.clock() - t3._lastUsed) / t3.useEvery
									if v1 >= 1 then
										t3._maid.progress = nil
										t3.updateProgressBinding(0)
									else
										t3.updateProgressBinding(v1)
									end
								end)
								v8:GiveTask(t3._maid.progress)
							end
						end
						if p1.Type == "Chassis" or p1.Type == "Heli" then
							if p1.Missiles and p1.Rockets then
								local t3 = {
									priority = 350,
									image = "rbxassetid://4939740665"
								}
								local t4 = {}
								t4[1] = p1.Type == "Chassis" and Enum.KeyCode.G or Enum.KeyCode.F
								t4[2] = Enum.KeyCode.ButtonX
								t3.keyCodes = t4
								function t3.onPressed() --[[ onPressed | Line: 2580 | Upvalues: p1 (copy), Classes (ref), v17 (ref) ]]
									if p1.Type == "Chassis" then
										Classes.Chassis.AttemptFireMissile(v17)
									else
										Classes.Heli.attemptFireMissile()
									end
								end
								v8:GiveTask(ActionButtonService.add(t3))
							end
							if p1.Missiles and p1.Bombs then
								v8:GiveTask(ActionButtonService.add({
									priority = 300,
									image = "rbxassetid://7893992893",
									keyCodes = { Enum.KeyCode.B, Enum.KeyCode.ButtonB },
									onPressed = function() --[[ onPressed | Line: 2594 | Upvalues: Classes (ref) ]]
										Classes.Heli.attemptDropBomb()
									end
								}))
							end
						end
						if p1.Make == "TowTruck" or p1.Make == "FrostCrawler" then
							v8:GiveTask(ActionButtonService.add({
								priority = 250,
								image = "rbxassetid://4939739616",
								keyCodes = { Enum.KeyCode.G, Enum.KeyCode.DPadDown },
								onPressed = function() --[[ onPressed | Line: 2606 | Upvalues: p1 (copy), VehicleLinkBinder (ref) ]]
									VehicleLinkBinder:Get((p1.Model:FindFirstChild("Preset"):FindFirstChild("Crane"):FindFirstChild("MetalHook"))):Unattach()
								end
							}))
						end
					end
					if p1.Model and p1.Model:FindFirstChild("Winch") then
						v8:GiveTask(ActionButtonService.add({
							priority = 750,
							image = "rbxassetid://4939739616",
							keyCodes = { Enum.KeyCode.G, Enum.KeyCode.ButtonY },
							onPressed = function() --[[ onPressed | Line: 2622 | Upvalues: Classes (ref) ]]
								Classes.Heli.attemptDropRope()
							end
						}))
					end
					Humanoid.Sit = true
					v8:GiveTask(Humanoid:GetPropertyChangedSignal("Sit"):Connect(function() --[[ Line: 2629 | Upvalues: Humanoid (copy) ]]
						if not Humanoid.Sit and Humanoid.Health > 0 then
							Humanoid.Sit = true
						end
					end))
					v8:GiveTask(function() --[[ Line: 2634 | Upvalues: Humanoid (copy) ]]
						Humanoid.Sit = false
					end)
					Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
					v8:GiveTask(function() --[[ Line: 2640 | Upvalues: Humanoid (copy) ]]
						Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
					end)
					v8:GiveTask(task.delay(0, function() --[[ Line: 2645 | Upvalues: Character (copy), v8 (copy) ]]
						local t = {}
						for v1, v2 in Character:GetChildren() do
							if v2:IsA("BasePart") and (v2.CanCollide and (v2.Name == "LowerTorso" or (v2.Name == "UpperTorso" or v2.Name == "HumanoidRootPart"))) then
								table.insert(t, v2)
								v2.CanCollide = false
							end
						end
						v8:GiveTask(function() --[[ Line: 2657 | Upvalues: t (copy) ]]
							for v1, v2 in t do
								v2.CanCollide = true
							end
						end)
					end))
					if not p1.Passenger then
						for i, v in ipairs(p1.Model:GetChildren()) do
							local PlayerName = v:FindFirstChild("PlayerName")
							if PlayerName then
								local function handleSeat(p12) --[[ handleSeat | Line: 2671 | Upvalues: Players (ref), LocalPlayer (ref), Maid (ref), v8 (copy), v (copy), p1 (copy), PartUtils (ref) ]]
									local v1 = Players:FindFirstChild(p12)
									if v1 and v1 ~= LocalPlayer then
										local v2 = Maid.new()
										v8[v] = v2
										local Humanoid = v1.Character:FindFirstChild("Humanoid")
										Humanoid.Sit = true
										v2:GiveTask(Humanoid:GetPropertyChangedSignal("Sit"):Connect(function() --[[ Line: 2679 | Upvalues: Humanoid (copy) ]]
											if not Humanoid.Sit and Humanoid.Health > 0 then
												Humanoid.Sit = true
											end
										end))
										if p1.Make == "Hammerhead" then
											v2:GiveTask(PartUtils.setPropertyWithRollback(v1.Character, "CollisionGroup", "NoOtherVehicles"))
										end
									else
										v8[v] = nil
									end
								end
								handleSeat(PlayerName.Value)
								v8:GiveTask(PlayerName.Changed:Connect(handleSeat))
							end
						end
						if p1.Make == "Hammerhead" then
							v8:GiveTask(PartUtils.setPropertyWithRollback(p1.Model, "CollisionGroup", "NoOtherVehicles"))
							v8:GiveTask(PartUtils.setPropertyWithRollback(Character, "CollisionGroup", "NoOtherVehicles"))
						end
					end
					local v14 = Classes[Make]
					if v14 and v14.vehicleEnter then
						v14.vehicleEnter(p1)
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
						local v15 = VehicleSystem.GetPlayerSeat(v17, LocalPlayer)
						if v15 then
							v17.Passenger = v15.Driver ~= true
						end
					end
					VehicleUtils.OnVehicleEntered:Fire(p1, p1.Passenger)
				end
			end
		else
			warn("failed to find vehicle seat. aborting.")
		end
	end
	VehicleUtils.OnVehicleEntered:Connect(function(p1) --[[ Line: 2739 | Upvalues: ActionButtonService (copy), Classes (copy), RxInstanceUtils (copy) ]]
		local seatMaid = p1.seatMaid
		if not p1.Passenger then
			local function handleLights(p1) --[[ handleLights | Line: 2743 | Upvalues: seatMaid (copy), ActionButtonService (ref), Classes (ref) ]]
				if p1 then
					seatMaid.sirensButton = ActionButtonService.add({
						priority = 450,
						image = "rbxassetid://4939739355",
						keyCodes = { Enum.KeyCode.F, Enum.KeyCode.ButtonB },
						onPressed = function() --[[ onPressed | Line: 2749 | Upvalues: Classes (ref) ]]
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
			local function handleCamToggle(p1) --[[ handleCamToggle | Line: 2764 | Upvalues: seatMaid (copy), ActionButtonService (ref), Classes (ref) ]]
				if p1 then
					seatMaid.camToggleButton = ActionButtonService.add({
						priority = 550,
						image = "rbxassetid://4939741662",
						keyCodes = { Enum.KeyCode.C, Enum.KeyCode.ButtonR3 },
						onPressed = function() --[[ onPressed | Line: 2770 | Upvalues: Classes (ref) ]]
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
	function t.n9jysnxj() --[[ n9jysnxj | Line: 2782 | Upvalues: v52 (ref), v17 (ref), VehicleUtils (ref), StopNitro (ref), Classes (copy), ItemSystem (ref), InputUtils (copy), v19 (ref), DefaultActions (copy) ]]
		if v52 then
			v52:cancel()
		end
		if v17 then
			VehicleUtils.OnVehicleJumpExited:Fire(v17)
			local v1 = v17
			local Type = v1.Type
			local Make = v1.Make
			v17 = nil
			if v1.Nitro then
				StopNitro()
			end
			v1.Nitro = false
			if v1.Nitrous then
				for v2, v3 in next, v1.Nitrous do
					v3.Enabled = false
				end
			end
			if v1.IsCameraLocked then
				Classes.Chassis.toggleInsideCamera(v1)
			end
			local v4 = Classes[Make]
			if v4 and v4.vehicleLeave then
				v4.vehicleLeave(v1)
			elseif Type == "Chassis" then
				Classes.Chassis.VehicleLeave(v1)
			elseif Type == "Heli" then
				Classes.Heli.VehicleLeave(v1)
			elseif Type == "Motorcycle" or Type == "DuneBuggy" then
				Classes.Chassis2.VehicleLeave(v1)
			elseif Type == "Custom" and Make == "Volt" then
				Classes.Volt.VehicleLeave(v1)
			end
			v1.seatMaid:Destroy()
			v1.seatMaid = nil
			local v5 = ItemSystem.GetLocalEquipped()
			if v5 and v5.IsLeaning then
				v5:SetLeaning(false)
			end
			VehicleUtils.OnVehicleExited:Fire(v1, v1.Passenger)
			if InputUtils.isTouch() then
				v19 = true
				if (DefaultActions.sprintButton._pressed and true or false) ~= true and DefaultActions.sprintButton._pressState then
					DefaultActions.sprintButton._pressState()
				end
			end
			VehicleUtils.fixNetworkingCharacters()
		end
	end
	VehicleUtils.OnVehicleJumpExited:Connect(function(p1) --[[ Line: 2840 | Upvalues: LocalPlayer (copy), ConstraintUtils (copy), Players (copy) ]]
		local Character = LocalPlayer.Character
		if Character then
			for v1, v2 in Character:GetDescendants() do
				if v2:IsA("JointInstance") or v2:IsA("AnimationConstraint") then
					local JointC0 = v2:FindFirstChild("JointC0")
					if JointC0 then
						ConstraintUtils.setJointC0(v2, JointC0.Value)
					end
					local JointC1 = v2:FindFirstChild("JointC1")
					if JointC1 then
						ConstraintUtils.setJointC1(v2, JointC1.Value)
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
					local v3 = Humanoid:GetPropertyChangedSignal("Sit"):Connect(function() --[[ Line: 2881 | Upvalues: Humanoid (copy) ]]
						if not Humanoid.Sit then
							Humanoid.Sit = true
						end
					end)
					Humanoid.Sit = true
					task.delay(0.3, function() --[[ Line: 2887 | Upvalues: v3 (ref), Humanoid (copy) ]]
						v3:Disconnect()
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
				local v4 = if p1.Model and BoundingBox then Character.PrimaryPart.CFrame:ToObjectSpace(BoundingBox.CFrame * CFrame.new(0, BoundingBox.Size.Y * 0.5, 0)).Y else 0
				local v5 = RaycastParams.new()
				local t = { workspace:FindFirstChild("Vehicles") }
				for v6, v7 in Players:GetPlayers() do
					table.insert(t, v7.Character)
				end
				v5.FilterDescendantsInstances = t
				local v8 = workspace:Raycast(Character.PrimaryPart.Position, Vector3.new(0, v4 + 6, 0), v5)
				Character:SetPrimaryPartCFrame(Character.PrimaryPart.CFrame + Vector3.new(0, if v8 then math.max(0, v8.Distance - 2) else v4 + 6, 0))
			end
		end
	end)
	function t.l5eif40v(p1) --[[ l5eif40v | Line: 2928 | Upvalues: v17 (ref) ]]
		if v17 then
			for v1, v2 in next, p1 do
				v17[v1] = v2
			end
		end
	end
	function t.kjdkog8c() --[[ kjdkog8c | Line: 2936 | Upvalues: v17 (ref), Classes (copy) ]]
		if v17 then
			if v17.Type == "Heli" then
				Classes.Heli.FallOutOfSky(v17)
			end
		end
	end
	function t.v9hoomtb(p1) --[[ v9hoomtb | Line: 2945 | Upvalues: v17 (ref), Classes (copy) ]]
		if v17 then
			if v17.Type == "Chassis" then
				Classes.Chassis.SpinOut(v17, p1)
			else
				error(("Cannot spin-out vehicle type: %s"):format(v17.Type))
			end
		else
			error("no vehicle packet")
		end
	end
	function t.y1wd0kw8(p1) --[[ y1wd0kw8 | Line: 2957 | Upvalues: ReplicatedStorage (copy) ]]
		local CrashParticles = Instance.new("Part")
		CrashParticles.Name = "CrashParticles"
		CrashParticles.Transparency = 1
		CrashParticles.Anchored = true
		CrashParticles.CanCollide = false
		CrashParticles.CFrame = p1.CFrame + p1.Parent.Engine.CFrame.LookVector * 5
		CrashParticles.Size = p1.Size
		CrashParticles.Parent = workspace
		local v1 = ReplicatedStorage.Resource.CrashParticle:Clone()
		v1.Parent = CrashParticles
		v1:Emit(8)
		wait()
		v1:Emit(8)
		wait()
		v1:Emit(8)
		wait()
		game.Debris:AddItem(CrashParticles, 5)
	end
	function t.cper3x9v() --[[ cper3x9v | Line: 2975 | Upvalues: LocalPlayer (copy), v17 (ref) ]]
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
function t.mpmbq2g9() --[[ mpmbq2g9 | Line: 2993 | Upvalues: v9 (copy) ]]
	v9.FaultyAction.Visible = true
	wait(4)
	v9.FaultyAction.Visible = false
end
local t17
do
	local function Ease_inOutQuad(p1, p2, p3, p4) --[[ Ease_inOutQuad | Line: 3014 ]]
		local v1 = p1 / p4 * 2
		if v1 < 1 then
			return p3 * 0.5 * v1 * v1 + p2
		else
			return -p3 * 0.5 * ((v1 - 1) * (v1 - 3) - 1) + p2
		end
	end
	t17 = {}
	local insert = table.insert
	local remove = table.remove
	local t18 = {}
	function t17.AddPart(p1, p2, p3, p4) --[[ AddPart | Line: 3040 | Upvalues: t18 (copy) ]]
		local t = {
			Part = p1,
			Distance = p2,
			f = p3,
			Meta = p4
		}
		table.insert(t18, t)
		return t
	end
	function t17.RemoveTag(p1) --[[ RemoveTag | Line: 3050 | Upvalues: t18 (copy) ]]
		for i = #t18, 1, -1 do
			if t18[i].Meta.Tag == p1 then
				table.remove(t18, i)
				return true
			end
		end
		return false
	end
	local t19 = {}
	local t20 = {}
	local function UpdateInterest() --[[ UpdateInterest | Line: 3062 | Upvalues: LocalPlayer (copy), t17 (ref) ]]
		local Character = LocalPlayer.Character
		if Character then
			local PrimaryPart = Character.PrimaryPart
			if PrimaryPart then
				local Humanoid = Character:FindFirstChild("Humanoid")
				if Humanoid then
					if not (Humanoid.Health <= 0) then
						t17.UpdateInterest(PrimaryPart.Position)
					end
				end
			end
		end
	end
	function t17.UpdateInterest(p1) --[[ UpdateInterest | Line: 3081 | Upvalues: LocalPlayer (copy), t17 (ref), t19 (ref), t20 (ref), t18 (copy), insert (copy) ]]
		local Character = LocalPlayer.Character
		if Character then
			local PrimaryPart = Character.PrimaryPart
			if PrimaryPart then
				local Humanoid = Character:FindFirstChild("Humanoid")
				if Humanoid and not (Humanoid.Health <= 0) then
					t17.UpdateInterest(PrimaryPart.Position)
				end
			end
		end
		t19 = {}
		t20 = {}
		for i = #t18, 1, -1 do
			if not t18[i].Part then
				table.remove(t18, i)
			end
		end
		for v1, v2 in next, t18 do
			v2.Center = v2.Part.Position
			local magnitude = (v2.Center - p1).magnitude
			v2.Sort = magnitude
			local v3 = magnitude < v2.Distance
			if v2.Locked then
				v3 = true
			end
			local Loaded = v2.Loaded
			if v3 and not Loaded then
				insert(t19, v2)
			elseif not v3 and Loaded then
				insert(t20, v2)
			end
		end
	end
	local function ProcessQueue() --[[ ProcessQueue | Line: 3108 | Upvalues: t19 (ref), remove (copy), t20 (ref) ]]
		while #t19 > 0 do
			local v1 = remove(t19, 1)
			v1.Loaded = true
			v1:f(v1.Loaded)
		end
		while #t20 > 0 do
			local v2 = remove(t20)
			v2.Loaded = false
			v2:f(v2.Loaded)
		end
	end
	function t17.Run(p1) --[[ Run | Line: 3120 | Upvalues: ThreadLoopAdd (ref), ProcessQueue (copy) ]]
		ThreadLoopAdd(p1, ProcessQueue, "Proximity Queue")
	end
	t17.Run(0.1)
end
do
	local v53 = ReplicatedStorage.Resource.ButtonY:Clone()
	local t21 = {}
	local function ProximityUpdate(p1, p2) --[[ ProximityUpdate | Line: 3129 | Upvalues: Math (copy), t21 (copy), v53 (copy) ]]
		if p2 then
			table.insert(t21, Math.BinaryFind(t21, p1.Sort), p1)
		else
			for i = #t21, 1, -1 do
				if t21[i] == p1 then
					table.remove(t21, i)
					break
				end
			end
		end
		local v3 = t21[1]
		if v3 and Enum.UserInputType.Gamepad1 == nil then
			v53.Parent = v3.Meta.Button
		else
			v53.Parent = nil
		end
	end
	local function AddContextButton(p1, p2, p3, p4) --[[ AddContextButton | Line: 3148 | Upvalues: t17 (ref), ProximityUpdate (copy) ]]
		return t17.AddPart(p1, p2, ProximityUpdate, {
			Callback = p3,
			Tag = p4
		})
	end
	local function RemoveContextButtonByTag(p1) --[[ RemoveContextButtonByTag | Line: 3153 | Upvalues: t17 (ref) ]]
		return t17.RemoveTag(p1)
	end
	local function ContextProcessInput(p1) --[[ ContextProcessInput | Line: 3156 | Upvalues: t21 (copy), LocalPlayer (copy) ]]
		local v1 = false
		if p1.UserInputType == Enum.UserInputType.Gamepad1 then
			if p1.KeyCode == Enum.KeyCode.ButtonY then
				v1 = true
			end
		elseif p1.UserInputType == Enum.UserInputType.Keyboard and p1.KeyCode == Enum.KeyCode.Y then
			v1 = true
		end
		if v1 then
			local v2 = t21[1]
			if v2 then
				for v3, v4 in next, t21 do
					if v4.Meta.Button == v2.Meta.Button then
						coroutine.resume(coroutine.create(function() --[[ Line: 3180 | Upvalues: v4 (copy), LocalPlayer (ref) ]]
							v4.Meta.Callback(LocalPlayer)
						end))
					end
				end
			end
		end
	end
	local function InputBegan(p1, p2) --[[ InputBegan | Line: 3187 | Upvalues: ContextProcessInput (ref) ]]
		if not p2 then
			ContextProcessInput(p1)
		end
	end
	UserInputService.InputBegan:connect(InputBegan)
	local function FindDoorLight(p1) --[[ FindDoorLight | Line: 3195 ]]
		local Model = p1:FindFirstChild("Model")
		local Light = p1:FindFirstChild("Light")
		if Light and (Light:IsA("ObjectValue") and (Light.Value and Light.Value:IsA("BasePart"))) then
			return Light.Value
		end
		if Model and Model:FindFirstChild("Light") then
			return Model.Light
		end
	end
	local function FunSlide(p1) --[[ FunSlide | Line: 3206 | Upvalues: RxInstanceUtils (copy), FindDoorLight (copy), RunService (copy) ]]
		local Open = p1.State.Open
		local Model = p1.Model
		RxInstanceUtils.yieldForProperty(Model.Model, "PrimaryPart")
		local v1 = FindDoorLight(Model)
		local OpenCFrame = p1.OpenCFrame
		local ClosedCFrame = p1.ClosedCFrame
		local function Finished() --[[ Finished | Line: 3212 | Upvalues: Open (copy), Model (copy), OpenCFrame (copy), ClosedCFrame (copy), v1 (copy) ]]
			if Open then
				Model.Model:SetPrimaryPartCFrame(OpenCFrame)
			else
				Model.Model:SetPrimaryPartCFrame(ClosedCFrame)
				if v1 then
					v1.Color = Color3.fromRGB(163, 75, 75)
				end
			end
		end
		if p1.State.NoAnimate then
			p1.State.NoAnimate = false
			return Finished()
		end
		if Open and v1 then
			v1.Color = Color3.fromRGB(102, 137, 172)
		end
		local doorMaid = p1.doorMaid
		local v2 = 0
		local Duration = p1.Settings.Duration
		local function onHeartbeat(p1) --[[ onHeartbeat | Line: 3231 | Upvalues: v2 (ref), Duration (copy), Open (copy), Model (copy), ClosedCFrame (copy), OpenCFrame (copy), doorMaid (copy), v1 (copy) ]]
			v2 = v2 + p1 * 1 / Duration
			local v12 = v2 / 1 * 2
			local count = if v12 < 1 then 0.5 * v12 * v12 + 0 else -0.5 * ((v12 - 1) * (v12 - 3) - 1) + 0
			if not Open then
				count = 1 - count
			end
			Model.Model:SetPrimaryPartCFrame(ClosedCFrame:lerp(OpenCFrame, count))
			if v2 >= 1 then
				doorMaid.Stepped = nil
				if Open then
					Model.Model:SetPrimaryPartCFrame(OpenCFrame)
					return
				end
				Model.Model:SetPrimaryPartCFrame(ClosedCFrame)
				if v1 then
					v1.Color = Color3.fromRGB(163, 75, 75)
				end
			end
		end
		doorMaid.Stepped = RunService.Heartbeat:connect(onHeartbeat)
	end
	local function FunSwing(p1) --[[ FunSwing | Line: 3245 | Upvalues: RxInstanceUtils (copy), FindDoorLight (copy), v3 (copy), Math (copy), RunService (copy) ]]
		local Open = p1.State.Open
		local Model = p1.Model
		RxInstanceUtils.yieldForProperty(Model.Model, "PrimaryPart")
		local v1 = FindDoorLight(Model)
		local ClosedCFrame = p1.ClosedCFrame
		local HingeRelativeCFrame = p1.HingeRelativeCFrame
		local v32 = v3(0, 1.7278759594743864 * (p1.State.Direction * p1.Direction), 0)
		local function Finished() --[[ Finished | Line: 3253 | Upvalues: Open (copy), Model (copy), ClosedCFrame (copy), HingeRelativeCFrame (copy), Math (ref), v32 (copy), v1 (copy) ]]
			if Open then
				Model.Model:SetPrimaryPartCFrame(ClosedCFrame * HingeRelativeCFrame * Math.CFrameFromAxisAngle(v32) * HingeRelativeCFrame:inverse())
			else
				Model.Model:SetPrimaryPartCFrame(ClosedCFrame)
				if v1 then
					v1.Color = Color3.fromRGB(163, 75, 75)
				end
			end
		end
		if p1.State.NoAnimate then
			p1.State.NoAnimate = false
			return Finished()
		end
		if Open and v1 then
			v1.Color = Color3.fromRGB(102, 137, 172)
		end
		local doorMaid = p1.doorMaid
		local v4 = 0
		local Duration = p1.Settings.Duration
		local function onHeartbeat(p1) --[[ onHeartbeat | Line: 3277 | Upvalues: v4 (ref), Duration (copy), Open (copy), Model (copy), ClosedCFrame (copy), HingeRelativeCFrame (copy), Math (ref), v32 (copy), doorMaid (copy), Finished (copy) ]]
			v4 = v4 + p1 * 1 / Duration
			local v1 = v4 / 1 * 2
			local count = if v1 < 1 then 0.5 * v1 * v1 + 0 else -0.5 * ((v1 - 1) * (v1 - 3) - 1) + 0
			if not Open then
				count = 1 - count
			end
			Model.Model:SetPrimaryPartCFrame(ClosedCFrame * HingeRelativeCFrame * Math.CFrameFromAxisAngle((Vector3.new(0, 0, 0)):lerp(v32, count)) * HingeRelativeCFrame:inverse())
			if v4 >= 1 then
				doorMaid.Stepped = nil
				return Finished()
			end
		end
		doorMaid.Stepped = RunService.Heartbeat:connect(onHeartbeat)
	end
	local function OpenDoor(p1, p2) --[[ OpenDoor | Line: 3298 ]]
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
	local function CloseDoor(p1, p2) --[[ CloseDoor | Line: 3313 ]]
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
	local t22 = {}
	local function DoorSequence(p1) --[[ DoorSequence | Line: 3332 | Upvalues: t2 (ref) ]]
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
			t2:FireServer("s" .. ("q4w0v46aj9g"):sub(2, 7):reverse() .. "r", p1)
		end
	end
	local function HasPerm_2(p1, p2, p3, p4) --[[ HasPerm | Line: 3341 | Upvalues: PlayerUtils (copy), InventoryItemSystem (copy) ]]
		if p1.Settings.ServerOnly or p1.Settings.Locked then
			return false
		else
			local v1 = (p3:FindFirstChild("Humanoid").Sit or p3:GetAttribute("InVehicle")) and true or false
			local v2 = false
			if p1.Settings.Vehicle and not p1.Settings.Character then
				v2 = v1
			elseif p1.Settings.Character and not p1.Settings.Vehicle then
				v2 = not v1
			elseif p1.Settings.Character and p1.Settings.Vehicle then
				v2 = true
			end
			if p4 then
				v2 = true
			end
			local v3 = PlayerUtils.hasKey()
			if p1.Settings.Key then
				v2 = v2 and v3
			end
			if p1.Settings.Team and p1.Settings.Team == "Prisoner" then
				v2 = v2 and if p2.TeamValue.Value == p1.Settings.Team then true else InventoryItemSystem.playerHasItem(p2, "CrimeKey")
			elseif p1.Settings.Team then
				v2 = v2 and p2.TeamValue.Value == p1.Settings.Team
			end
			if p1.Settings.TeamBlacklist then
				v2 = v2 and p2.TeamValue.Value ~= p1.Settings.TeamBlacklist
			end
			return v2
		end
	end
	local function RegisterDoor(p1) --[[ RegisterDoor | Line: 3380 | Upvalues: LocalPlayer (copy), HasPerm_2 (copy), PlaySound (ref), t2 (ref), Maid (copy), t22 (copy), AddContextButton (ref), RemoveContextButtonByTag (ref) ]]
		assert(p1.Resolved)
		local Model = p1.Model
		local v1 = tick()
		local v2 = tick()
		local function DoorPlayer(p12) --[[ DoorPlayer | Line: 3384 | Upvalues: LocalPlayer (ref), v2 (ref), p1 (copy), HasPerm_2 (ref), PlaySound (ref), Model (copy), t2 (ref) ]]
			local v1 = tick()
			local Character = LocalPlayer.Character
			if Character and Character.PrimaryPart then
				if v1 - v2 < 0.1 then
					return
				end
				v2 = v1
				if p1.State.Open or os.time() - p1.State.CloseTime < p1.Settings.Duration then
					return
				end
				local v22 = HasPerm_2(p1, LocalPlayer, Character, p12)
				if p1.Settings.Character then
					if v22 then
						PlaySound("Door", {
							TimeStart = 1,
							Volume = 0.2,
							Source = Model.Closed
						})
					else
						PlaySound("Door", {
							TimeStart = 0,
							MaxTime = 0.6,
							Volume = 0.2,
							Source = Model.Closed
						})
					end
				end
				if v22 then
					if p1.Settings.Type == "Swing" then
						p1.State.Direction = if (p1.Model.Closed.Position - Character.HumanoidRootPart.Position).unit:Dot(p1.Model.Closed.CFrame.lookVector) > 0 then 1 else -1
					end
					local v4 = p1
					if not (v4.Settings.SequenceRequireState and v4.State.Open) then
						if v4.Resolved then
							v4.State.Open = true
							if v4.OpenFun then
								v4:OpenFun()
							end
						else
							v4.AwaitingDoorOpen = true
							v4.AwaitingDoorClose = false
						end
						t2:FireServer("s" .. ("q4w0v46aj9g"):sub(2, 7):reverse() .. "r", v4)
					end
				end
			end
		end
		local function Touched(p1) --[[ Touched | Line: 3424 | Upvalues: v1 (ref), DoorPlayer (copy) ]]
			local v12 = tick()
			if not (v12 - v1 < 0.03333333333333333) then
				v1 = v12
				DoorPlayer()
			end
		end
		local function MouseClick(p1) --[[ MouseClick | Line: 3432 | Upvalues: LocalPlayer (ref), DoorPlayer (copy) ]]
			if p1 == LocalPlayer then
				DoorPlayer(true)
			end
		end
		if p1.doorMaid ~= nil then
			print(Model:GetFullName())
			error("Door already has a door maid.. what happened?")
		end
		local v3 = Maid.new()
		p1.doorMaid = v3
		for v4, v5 in Model:GetChildren() do
			if v5:IsA("BasePart") and v5.Name == "Touch" then
				table.insert(t22, {
					_DEBUG = "DoorTouchPart",
					Tag = p1.Tag,
					Part = v5,
					Fun = Touched
				})
			elseif v5:IsA("ObjectValue") and v5.Name == "Touch" then
				local t = {
					_DEBUG = "DoorTouchObjValue",
					Tag = p1.Tag,
					Part = v5.Value,
					Fun = Touched
				}
				v3:GiveTask(v5.Changed:Connect(function(p1) --[[ Line: 3459 | Upvalues: t (copy) ]]
					t.Part = p1
				end))
				table.insert(t22, t)
			elseif v5:IsA("ObjectValue") and v5.Name == "Button" then
				local v8 = Maid.new()
				v3:GiveTask(v8)
				local function processButton() --[[ processButton | Line: 3466 | Upvalues: v8 (copy), v5 (copy), AddContextButton (ref), MouseClick (copy), p1 (copy), v3 (copy), RemoveContextButtonByTag (ref) ]]
					v8:DoCleaning()
					if v5.Value then
						local v1 = v5.Value
						assert(v1:IsA("BasePart"), "missing button part")
						local ClickDetector = v1:WaitForChild("ClickDetector", 5)
						assert(ClickDetector, "missing button click detector")
						AddContextButton(v1, ClickDetector.MaxActivationDistance, MouseClick, p1.Tag).Meta.Button = v1
						v3:GiveTask(ClickDetector.MouseClick:Connect(MouseClick))
						v3:GiveTask(function() --[[ Line: 3479 | Upvalues: RemoveContextButtonByTag (ref), p1 (ref) ]]
							RemoveContextButtonByTag(p1.Tag)
						end)
					end
				end
				task.spawn(processButton)
				v3:GiveTask(v5.Changed:Connect(processButton))
			end
		end
	end
	local function UnregisterDoor(p1) --[[ UnregisterDoor | Line: 3488 | Upvalues: t22 (copy), t17 (ref) ]]
		assert(not p1.Resolved)
		local Tag = p1.Tag
		for i = #t22, 1, -1 do
			if t22[i].Tag == Tag then
				table.remove(t22, i)
			end
		end
		t17.RemoveTag(Tag)
		if p1.doorMaid then
			p1.doorMaid:DoCleaning()
			p1.doorMaid = nil
		end
	end
	local function AddedFun(p1) --[[ AddedFun | Line: 3506 | Upvalues: t2 (ref), t22 (copy) ]]
		local v1 = 0
		local t = {
			_DEBUG = "OtherTrigger",
			Part = p1,
			Fun = function(p12) --[[ Touched | Line: 3510 | Upvalues: v1 (ref), t2 (ref), p1 (copy) ]]
				if not (tick() - v1 < 1) then
					v1 = tick()
					t2:FireServer("s" .. ("usefqez"):sub(3, 4):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("bnvtcmuv"):sub(3, 5):reverse():reverse():reverse():reverse():reverse() .. "xw", p1)
				end
			end
		}
		table.insert(t22, t)
	end
	local function RemovedFun(p1) --[[ RemovedFun | Line: 3519 | Upvalues: t22 (copy) ]]
		for i = #t22, 1, -1 do
			if t22[i].Part == p1 then
				table.remove(t22, i)
				break
			end
		end
		return true
	end
	local v54 = next
	local v55, v56 = CollectionService:GetTagged("TouchTrigger")
	local t23 = {}
	for v57, v58 in v54, v55, v56 do
		AddedFun(v58)
	end
	CollectionService:GetInstanceAddedSignal("TouchTrigger"):Connect(AddedFun)
	CollectionService:GetInstanceRemovedSignal("TouchTrigger"):Connect(RemovedFun)
	local CircleAction = UI.CircleAction
	local function AddHatch(p1) --[[ AddHatch | Line: 3560 | Upvalues: t2 (ref), CircleAction (copy), t22 (copy) ]]
		local SewerHatch = p1:FindFirstChild("SewerHatch")
		local v1 = assert(SewerHatch, "missing SewerHatch")
		local function Action(p1, p2) --[[ Action | Line: 3562 | Upvalues: t2 (ref), v1 (copy) ]]
			if p2 then
				t2:FireServer("p" .. ("pzlxnfmo3"):sub(4, 6):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("s6kgfo6"):sub(2, 4):reverse() .. "c", "SewerHatch", v1)
			end
			return true
		end
		if p1:FindFirstChild("FromTop").Value then
			CircleAction.Add({
				Name = "Pull Open",
				Timed = true,
				Duration = 3,
				Dist = 10,
				Part = v1,
				Callback = Action
			}, p1)
		end
		table.insert(t22, {
			_DEBUG = "SewerHatch",
			Tag = p1,
			Part = p1:FindFirstChild("Touch"),
			Fun = function() --[[ Touched | Line: 3581 | Upvalues: Action (copy) ]]
				return Action(nil, true)
			end
		})
	end
	local function RemoveHatch(p1) --[[ RemoveHatch | Line: 3586 | Upvalues: CircleAction (copy), t22 (copy) ]]
		CircleAction.Remove(p1)
		for i = #t22, 1, -1 do
			if t22[i].Tag == p1 then
				table.remove(t22, i)
				return
			end
		end
	end
	local v59 = next
	local v60, v61 = CollectionService:GetTagged("SewerHatch")
	for v62, v63 in v59, v60, v61 do
		AddHatch(v63)
	end
	CollectionService:GetInstanceAddedSignal("SewerHatch"):Connect(AddHatch)
	CollectionService:GetInstanceRemovedSignal("SewerHatch"):Connect(RemoveHatch)
	ThreadLoopAdd(0.16666666666666666, function() --[[ CheckTouch | Line: 3603 | Upvalues: LocalPlayer (copy), t22 (copy), Math (copy) ]]
		local Character = LocalPlayer.Character
		if Character then
			local PrimaryPart = Character.PrimaryPart
			if PrimaryPart then
				local Position = PrimaryPart.Position
				for v1, v2 in next, t22 do
					if v2.Part and v2.Part:IsDescendantOf(workspace) then
						if Math.IsPointInPrism(Position, v2.Part.CFrame, v2.Part.Size + Vector3.new(4, 6, 4)) then
							v2.Fun(PrimaryPart)
						end
					else
						warn("TouchQueue has invalid part", v2._DEBUG)
					end
				end
			end
		end
	end)
	local function AddedFun_2(p1) --[[ AddedFun | Line: 3627 | Upvalues: t23 (copy), RegisterDoor (copy) ]]
		local v1 = p1:WaitForChild("Tag", 5).Value
		for v2, v3 in next, t23 do
			if v3.Tag == v1 and v3.Model ~= p1 then
				assert(v3.Resolved ~= true, "Door was already resolved:" .. p1:GetFullName())
				v3.Resolved = true
				v3.Model = p1
				if v3.AwaitingDoorOpen or v3.State.Open then
					if v3.Resolved then
						v3.State.NoAnimate = true
						v3.State.Open = true
						if v3.OpenFun then
							v3:OpenFun()
						end
					else
						v3.AwaitingDoorOpen = true
						v3.AwaitingDoorClose = false
					end
				elseif v3.AwaitingDoorClose or not v3.State.Open then
					if v3.Resolved then
						v3.State.NoAnimate = true
						v3.State.Open = false
						v3.State.CloseTime = os.time()
						if v3.CloseFun then
							v3:CloseFun()
						end
					else
						v3.AwaitingDoorOpen = false
						v3.AwaitingDoorClose = true
					end
				end
				RegisterDoor(v3)
				return true
			end
		end
		return false
	end
	local function RemovedFun_2(p1) --[[ RemovedFun | Line: 3646 | Upvalues: t23 (copy), UnregisterDoor (copy) ]]
		for v1, v2 in next, t23 do
			if v2.Model == p1 then
				assert(v2.Resolved == true, "Door was not resolved:" .. p1:GetFullName())
				v2.Resolved = false
				v2.Model = nil
				UnregisterDoor(v2)
				return true
			end
		end
		return false
	end
	local v64 = next
	local v65, v66 = CollectionService:GetTagged("Door")
	for v67, v68 in v64, v65, v66 do
		task.spawn(AddedFun_2, v68)
	end
	CollectionService:GetInstanceAddedSignal("Door"):Connect(AddedFun_2)
	CollectionService:GetInstanceRemovedSignal("Door"):Connect(RemovedFun_2)
	local t24 = {}
	local function ResolveRealDoor(p1) --[[ ResolveRealDoor | Line: 3666 | Upvalues: t23 (copy) ]]
		for v1, v2 in next, t23 do
			if v2.Tag == p1 then
				return v2
			end
		end
		return false
	end
	local function ReceiveDoor(p1, p2) --[[ ReceiveDoor | Line: 3678 | Upvalues: t23 (copy), FunSwing (copy), FunSlide (copy), t24 (copy), CollectionService (copy), AddedFun_2 (copy) ]]
		assert(p1.Tag)
		local Tag_2 = p1.Tag
		local v1 = false
		for v2, v3 in next, t23 do
			if v3.Tag == Tag_2 then
				v1 = v3
				break
			end
		end
		if v1 then
			v1.Settings = p1.Settings
			v1.AwaitingDoorOpen = p1.AwaitingDoorOpen
			v1.AwaitingDoorClose = p1.AwaitingDoorClose
			p1 = v1
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
			table.insert(t23, p1)
		end
		local v5 = t24[p1.Tag]
		t24[p1.Tag] = nil
		if v5 then
			p1.State = v5.State
			p1.Settings = v5.Settings
			p1.AwaitingDoorOpen = v5.AwaitingDoorOpen
			p1.AwaitingDoorClose = v5.AwaitingDoorClose
		end
		if not p2 then
			local v6 = next
			local v7, v8 = CollectionService:GetTagged("Door")
			for v9, v10 in v6, v7, v8 do
				AddedFun_2(v10)
			end
		end
	end
	local function ReceiveDoors(p1) --[[ ReceiveDoors | Line: 3719 | Upvalues: ReceiveDoor (copy), CollectionService (copy), AddedFun_2 (copy) ]]
		for v1, v2 in next, p1 do
			ReceiveDoor(v2, true)
		end
		local v3 = next
		local v4, v5 = CollectionService:GetTagged("Door")
		for v6, v7 in v3, v4, v5 do
			AddedFun_2(v7)
		end
	end
	function t.arghaktt(p1) --[[ arghaktt | Line: 3730 | Upvalues: t23 (copy), t24 (copy) ]]
		local Tag = p1.Tag
		local v1 = false
		for v2, v3 in next, t23 do
			if v3.Tag == Tag then
				v1 = v3
				break
			end
		end
		if v1 then
			v1.State = p1.State
			v1.Settings = p1.Settings
			if v1.Resolved then
				v1.State.Open = true
				if v1.OpenFun then
					v1:OpenFun()
				end
			else
				v1.AwaitingDoorOpen = true
				v1.AwaitingDoorClose = false
			end
		else
			p1.AwaitingDoorOpen = true
			p1.AwaitingDoorClose = false
			t24[Tag] = p1
		end
	end
	function t.fzwidvdw(p1) --[[ fzwidvdw | Line: 3745 | Upvalues: t23 (copy), t24 (copy) ]]
		local Tag = p1.Tag
		local v1 = false
		for v2, v3 in next, t23 do
			if v3.Tag == Tag then
				v1 = v3
				break
			end
		end
		if v1 then
			v1.State = p1.State
			v1.Settings = p1.Settings
			if v1.Resolved then
				v1.State.Open = false
				v1.State.CloseTime = os.time()
				if v1.CloseFun then
					v1:CloseFun()
				end
			else
				v1.AwaitingDoorOpen = false
				v1.AwaitingDoorClose = true
			end
		else
			p1.AwaitingDoorOpen = false
			p1.AwaitingDoorClose = true
			t24[Tag] = p1
		end
	end
	function t.yx5b334b(p1) --[[ yx5b334b | Line: 3760 | Upvalues: ReceiveDoor (copy) ]]
		ReceiveDoor(p1)
	end
	function t.ytvg6hq1(p1) --[[ ytvg6hq1 | Line: 3763 | Upvalues: ReceiveDoors (copy) ]]
		ReceiveDoors(p1)
	end
end
do
	local t25 = {
		name = "robberyMusic",
		title = "Robbery Music",
		defaultValue = 100,
		order = 10,
		min = 0,
		max = 100,
		step = 1,
		type = gameSettingType.Slider,
		textMap = function(p1) --[[ textMap | Line: 3777 ]]
			return ("%d%%"):format(p1)
		end
	}
	GameSettingsService.add(t25)
	local function handleSetting_3(p1) --[[ handleSetting | Line: 3782 | Upvalues: SoundService (copy) ]]
		SoundService.RobberyMusic.Volume = math.clamp(p1 / 100, 0, 1)
	end
	handleSetting_3(t25:getValue())
	t25.onChanged:Connect(handleSetting_3)
	local t26 = {
		name = "otherRadios",
		title = "Other Radios",
		defaultValue = 100,
		order = 11,
		min = 0,
		max = 100,
		step = 1,
		type = gameSettingType.Slider,
		textMap = function(p1) --[[ textMap | Line: 3798 ]]
			return ("%d%%"):format(p1)
		end
	}
	GameSettingsService.add(t26)
	local function handleSetting_4(p1) --[[ handleSetting | Line: 3803 | Upvalues: SoundService (copy) ]]
		SoundService.OtherRadios.Volume = math.clamp(p1 / 100, 0, 1)
	end
	handleSetting_4(t26:getValue())
	t26.onChanged:Connect(handleSetting_4)
	local t27 = {
		name = "lightShadows",
		title = "Light Shadows",
		defaultValue = true,
		order = 500,
		type = gameSettingType.Checkbox
	}
	GameSettingsService.add(t27)
	local v69 = true
	local function handleSetting_5(p1) --[[ handleSetting | Line: 3820 | Upvalues: v69 (ref), CollectionService (copy) ]]
		v69 = p1
		for v1, v2 in CollectionService:GetTagged("ShadowLight") do
			v2.Shadows = p1
		end
	end
	t27.onChanged:Connect(handleSetting_5)
	CollectionService:GetInstanceAddedSignal("ShadowLight"):Connect(function(p1) --[[ Line: 3828 | Upvalues: v69 (ref) ]]
		p1.Shadows = v69
	end)
end
do
	local t28 = {
		name = "sunShadows",
		title = "Sun Shadows",
		defaultValue = true,
		noSave = true,
		order = 510,
		type = gameSettingType.Checkbox
	}
	GameSettingsService.add(t28)
	local function handleSetting_6(p1) --[[ handleSetting | Line: 3842 ]]
		game:GetService("Lighting").GlobalShadows = p1
	end
	handleSetting_6(t28:getValue())
	t28.onChanged:Connect(handleSetting_6);
	(function() --[[ Line: 3879 ]]
		return (""):sub(-1, 1)
	end)()
	local t29 = {}
	if not v1 or v1 and Settings.Test.Ambient then
		for v70, v71 in next, Settings.AmbientIds do
			local Sound = Instance.new("Sound")
			Sound.SoundId = "rbxassetid://" .. v71
			Sound.Name = v70
			Sound.Looped = true
			Sound.SoundGroup = SoundService.Ambient
			Sound.Parent = SoundService.Ambient
			t29[v70] = Sound
		end
	end
	local function SetVolume(p1) --[[ SetVolume | Line: 3896 | Upvalues: t29 (copy) ]]
		for v1, v2 in next, t29 do
			local v3 = p1[v1] or 0
			if v2.IsPlaying or not (v3 > 0.01) then
				if v2.IsPlaying and v3 <= 0.01 then
					v2:Stop()
				end
			else
				v2:Play()
			end
			v2.Volume = v3
		end
	end
	local MinimapService = require(ReplicatedStorage.App.MinimapService)
	if EnvironmentUtils.getTimeOfDay() == EnvironmentConsts.TIME_OF_DAY_ENUM.Day then
		SetVolume((LerpTable(Settings.Ambient.Day, Settings.Ambient.Day, 1)))
	else
		SetVolume((LerpTable(Settings.Ambient.Night, Settings.Ambient.Night, 1)))
		MinimapService.updateMapImageColor3(Settings.Ambient.Night.Minimap)
	end
	local function SetSettings(p1, p2) --[[ SetSettings | Line: 3914 | Upvalues: PlayerGui (copy), LerpTable (copy), SetVolume (copy), MinimapService (copy), RunService (copy) ]]
		local Main = PlayerGui:FindFirstChild("Main")
		local v1 = if Main then Main.Frame.Vig else nil
		local v2 = 0
		local v3 = nil
		local v4 = os.clock()
		local function Heartbeat() --[[ Heartbeat | Line: 3924 | Upvalues: v4 (ref), v2 (ref), v3 (ref), LerpTable (ref), p1 (copy), p2 (copy), SetVolume (ref), v1 (ref), MinimapService (ref) ]]
			local v12 = os.clock()
			local v22 = v12 - v4
			v4 = v12
			v2 = v2 + v22 * 1 / 4
			if v2 >= 1 then
				v2 = 1
				v3:disconnect()
			end
			local v32 = LerpTable(p1, p2, v2)
			SetVolume(v32)
			if v1 then
				v1.ImageColor3 = v32.Vig
			end
			MinimapService.updateMapImageColor3(v32.Minimap)
		end
		v3 = RunService.Heartbeat:Connect(Heartbeat)
	end
	local SNOW = EnvironmentConsts.SNOW
	local v72 = not SNOW
	local Rain = SNOW and ReplicatedStorage.Resource.RainSnow or ReplicatedStorage.Resource.Rain
	Rain.Name = "Rain"
	local v73 = nil
	local v74 = 0
	local v75 = false
	local function StartRainThread() --[[ StartRainThread | Line: 3951 | Upvalues: v74 (ref), Rain (copy), v73 (ref), v75 (ref), RunService (copy), LocalPlayer (copy), SNOW (copy), Raycast (copy), SoundService (copy), v72 (copy) ]]
		local v1 = Vector3.new()
		local v2 = Vector3.new()
		v74 = v74 + 1
		for v3, v4 in Rain:GetChildren() do
			if v4:IsA("BasePart") then
				v4.CanCollide = false
				v4.CanTouch = false
				v4.CanQuery = false
				v4.Transparency = 1
			end
		end
		Rain.Parent = workspace
		if v73 then
			v73:Disconnect()
		end
		v75 = false
		v73 = RunService.Heartbeat:Connect(function(p1) --[[ Line: 3968 | Upvalues: LocalPlayer (ref), v2 (ref), SNOW (ref), v1 (ref), Rain (ref), Raycast (ref), v75 (ref), SoundService (ref), v72 (ref) ]]
			debug.profilebegin("Rain Update")
			if LocalPlayer.Character then
				local PrimaryPart = LocalPlayer.Character.PrimaryPart
				if PrimaryPart then
					v2 = PrimaryPart.Position
					v1 = if SNOW then v2 + PrimaryPart.Velocity * Vector3.new(1, 0, 1) else v2 + PrimaryPart.Velocity * Vector3.new(1, 0, 1) * 0.3
				end
				local Humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
				if Humanoid then
					local _ = Humanoid.Sit or Humanoid.PlatformStand
				end
			end
			local Rain_2 = Rain.RainFall:FindFirstChild("Rain")
			local FogFall = Rain:FindFirstChild("FogFall")
			local Rain_3 = Rain.RainDroplets:FindFirstChild("Rain")
			Rain.RainFall.CFrame = CFrame.new(v1) + Vector3.new(0, 37, 0)
			if FogFall then
				FogFall.CFrame = CFrame.new(v2) + Vector3.new(0, 37, 0)
			end
			local v12, v22 = workspace:FindPartOnRayWithIgnoreList(Ray.new(v2, Vector3.new(0, -10, 0)), { workspace.Vehicles, LocalPlayer.Character, Rain })
			Rain.RainDroplets.CFrame = CFrame.new(v22) + Vector3.new(0, 1.5, 0)
			local v3 = RaycastParams.new()
			v3.FilterDescendantsInstances = {
				workspace.Vehicles,
				LocalPlayer.Character,
				Rain,
				workspace:FindFirstChild("Clouds")
			}
			local v4 = Raycast.collidable(v2, Vector3.new(0, 1, 0), 100, v3) ~= nil
			if Rain_2 then
				Rain_2.Enabled = not v4 and not v75
			end
			if FogFall then
				FogFall.RainFog.Enabled = not v4 and not v75
			end
			SoundService.Ambient.CompressorSoundEffect.Enabled = v4 and true or false
			if (not SNOW or v72) and Rain_3 then
				Rain_3.Enabled = (v12 and true or false) and not v4
			end
			debug.profileend()
		end)
	end
	local function StopRainThread() --[[ StopRainThread | Line: 4022 | Upvalues: EnvironmentConsts (copy), v73 (ref), Rain (copy), ReplicatedStorage (copy), v75 (ref), v74 (ref) ]]
		if EnvironmentConsts.SNOW then
			v75 = true
			local v1 = v74
			task.delay(7, function() --[[ Line: 4033 | Upvalues: v73 (ref), v1 (copy), v74 (ref), Rain (ref), ReplicatedStorage (ref) ]]
				if v73 and v1 == v74 then
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
	local v76 = "Day"
	function t.hrideoli(p1) --[[ hrideoli | Line: 4042 | Upvalues: v76 (ref), SetSettings (copy), Settings (copy) ]]
		if p1 ~= v76 then
			if p1 == "Day" then
				SetSettings(Settings.Ambient[v76], Settings.Ambient.Day)
			elseif p1 == "Night" then
				SetSettings(Settings.Ambient[v76], Settings.Ambient.Night)
			end
			v76 = p1
		end
	end
	local function UpdateStorm() --[[ UpdateStorm | Line: 4054 | Upvalues: EnvironmentUtils (copy), EnvironmentConsts (copy), StartRainThread (copy), SetSettings (copy), Settings (copy), v76 (ref), StopRainThread (copy) ]]
		if EnvironmentUtils.getPrecipitation() == EnvironmentConsts.PRECIPITATION_ENUM.Rain then
			StartRainThread()
			SetSettings(Settings.Ambient[v76], Settings.Ambient.Storm)
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
	local v77 = v24
	v77.Parent = LocalPlayer.PlayerGui
	local function OpenNitroProd() --[[ OpenNitroProd | Line: 4070 | Upvalues: v77 (copy), EzUtils (copy) ]]
		v77.Enabled = true
		EzUtils.selectIfGamepad(v77.Container.Container.ContainerButtons.Tier1.Button)
	end
	local function CloseNitroProd() --[[ CloseNitroProd | Line: 4074 | Upvalues: v77 (copy) ]]
		v77.Enabled = false
	end
	local v78 = AlexWM.MakeWindow()
	v78.OpenFun = OpenNitroProd
	v78.CloseFun = CloseNitroProd
	AlexWM.WindowGroupAdd(v16, v78)
	v77.Container.Close.MouseButton1Down:connect(function() --[[ Line: 4081 | Upvalues: AlexWM (copy), v78 (copy) ]]
		AlexWM.WindowClose(v78)
	end)
	t5.AtGasStation = false
	function t.mi2puuba(p1, p2) --[[ mi2puuba | Line: 4086 | Upvalues: RunUtils (copy), t5 (copy), AlexWM (copy), v78 (copy) ]]
		if RunUtils.isTradeWorld() then
		elseif p1 then
			if not p2 then
				t5.AtGasStation = true
			end
			AlexWM.WindowOpen(v78)
		else
			t5.AtGasStation = false
			AlexWM.WindowClose(v78)
		end
	end
	VehicleUtils.NitroShopVisible = t.mi2puuba
	local function AttemptUpdateGui() --[[ AttemptUpdateGui | Line: 4103 | Upvalues: Settings (copy), v77 (copy), t5 (copy), t (copy), GamepassSystem (copy), GamepassUtils (copy), PromptPurchase (ref), MarketplaceService (copy), LocalPlayer (copy) ]]
		if Settings.FetchedMarketplace then
			for v1, v2 in next, Settings.DevProduct do
				if v2.Type == "Nitro" then
					local v4 = v77.Container.Container.ContainerButtons:FindFirstChild(v2.Name)
					if v4 then
						v4.Button.Title.Text = ("+%d"):format(v2.Fuel)
						v4.Button.MouseButton1Down:connect(function() --[[ Line: 4113 | Upvalues: t5 (ref), Settings (ref), t (ref), GamepassSystem (ref), GamepassUtils (ref), PromptPurchase (ref), MarketplaceService (ref), LocalPlayer (ref), v2 (copy) ]]
							if t5.Nitro >= Settings.Scalar.NitroMax - 25 then
								t.vbey8zy6({
									Title = "Rocket Fuel",
									Text = "You have a lot of fuel, go use it!"
								})
							else
								local v1
								if t5.AtGasStation or GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass.PremiumGarage) then
									v1 = true
								else
									PromptPurchase(Settings.Gamepass.PremiumGarage)
									v1 = false
								end
								if v1 then
									MarketplaceService:PromptProductPurchase(LocalPlayer, v2.Id)
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
	task.spawn(function() --[[ Line: 4135 | Upvalues: Settings (copy), AttemptUpdateGui (copy) ]]
		if not Settings.FetchedMarketplace then
			Settings.OnProductsFetched:Wait()
		end
		AttemptUpdateGui()
	end)
	if RunUtils.isMainWorld() then
		local function updateHasEscaped() --[[ updateHasEscaped | Line: 4143 | Upvalues: t6 (copy), Players (copy), t (copy), Localization (copy) ]]
			t6.HasEscaped = Players.LocalPlayer:GetAttribute("HasEscaped") == true
			if t6.HasEscaped then
				t.vbey8zy6({
					Duration = 6,
					Text = ("%s"):format(Localization:FormatByKey("Banner.EscapedDesc"))
				})
				t.vbey8zy6({
					Style = "Alert",
					Duration = 6,
					Text = ("%s"):format(Localization:FormatByKey("Banner.Escaped"))
				})
			end
		end
		updateHasEscaped()
		Players.LocalPlayer:GetAttributeChangedSignal("HasEscaped"):connect(updateHasEscaped)
	end
	function t.lztmht3a() --[[ lztmht3a | Line: 4175 | Upvalues: v17 (ref), VehicleUtils (ref) ]]
		if v17 then
			VehicleUtils.setTireHealth(v17.Model, 0)
		end
	end
	local v79 = 1
	local function CycleMessage() --[[ CycleMessage | Line: 4184 | Upvalues: TeamValue (copy), Settings (copy), v9 (copy), v79 (ref), Localization (copy) ]]
		local v1 = nil
		local v2 = nil
		if TeamValue.Value == Settings.Team.Prisoner then
			v1 = "Prisoner"
			v2 = 3
		elseif TeamValue.Value == Settings.Team.Police then
			v1 = "Police"
			v2 = 5
		end
		if v1 then
			local Help = v9.Inventory.Help
			v79 = v79 % v2 + 1
			Help.Text = Localization:FormatByKey("Help." .. v1 .. v79 - 1)
			Help.Visible = true
		end
	end
end
function t.pwe6twnm(p1, ...) --[[ pwe6twnm | Line: 4209 | Upvalues: t2 (ref), t (copy) ]]
	if p1 == "ems" then
		delay(0.5, function() --[[ Line: 4212 | Upvalues: t2 (ref), p1 (copy) ]]
			t2:FireServer("p" .. "" .. ("ha1wt6ewk2hi"):sub(4, 8):reverse():reverse():reverse() .. "nm", p1)
		end)
	else
		t2:FireServer("p" .. "" .. ("evuwt6ewtft"):sub(4, 8):reverse():reverse():reverse():reverse():reverse() .. "nm", p1)
	end
	assert(t[p1], p1)(...)
end
require(ReplicatedStorage.TeamSelect.TeamChooseUI).Init({
	Event = t2,
	em = t,
	OnJump = OnJump
})
ConnectEvents()
local AttemptVehicleEnter
do
	local function GetSeats(p1) --[[ GetSeats | Line: 4227 | Upvalues: LocalPlayer (copy) ]]
		local Character = LocalPlayer.Character
		if Character and Character.PrimaryPart then
			local v1 = next
			local v2, v3 = p1.Model:GetChildren()
			local t = {}
			for v4, v5 in v1, v2, v3 do
				if v5.Name == "Seat" or v5.Name == "Passenger" then
					local Player = v5:FindFirstChild("Player")
					local PlayerName = v5:FindFirstChild("PlayerName")
					if Player and (Player.Value and PlayerName) then
						table.insert(t, {
							Part = v5,
							PlayerName = PlayerName.Value
						})
					end
				end
			end
			table.sort(t, function(p1, p2) --[[ Line: 4249 ]]
				return p1.PlayerName < p2.PlayerName
			end)
			return t
		end
	end
	ThreadLoopAdd(0.1, function() --[[ UpdateVehicleUI | Line: 4256 | Upvalues: LocalPlayer (copy), t5 (copy), GamepassSystem (copy), GamepassUtils (copy) ]]
		local Character = LocalPlayer.Character
		if Character then
			local PrimaryPart = Character.PrimaryPart
			if PrimaryPart then
				local v1 = LocalPlayer:GetAttribute("TutorialCanEnterAnyCarForFree") == true
				local v2 = next
				local v3, v4 = workspace.Vehicles:GetChildren()
				for v6, v7 in v2, v3, v4 do
					local v5
					local Seat = v7:FindFirstChild("Seat")
					local BoundingBox = v7:FindFirstChild("BoundingBox")
					local Make = v7:FindFirstChild("Make")
					local v8 = v7:GetAttribute("GamepassRestrict")
					if BoundingBox and Seat then
						local Player = Seat:FindFirstChild("Player")
						local magnitude = (PrimaryPart.Position - BoundingBox.Position).magnitude
						local MoneyBillboard = BoundingBox:FindFirstChild("MoneyBillboard")
						if MoneyBillboard and (Make and Player) then
							if magnitude < 50 then
								v5 = not Player.Value
								if v5 then
									local v9 = t5.VehiclesOwned[Make.Value]
									if not v9 then
										v9 = t5.VehiclesRented[Make.Value]
										if not v9 then
											v9 = v8 and GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass[v8])
										end
									end
									v5 = not v9 and not v1
								end
							else
								v5 = false
							end
							MoneyBillboard.Enabled = v5
						end
					end
				end
			end
		end
	end)
	AttemptVehicleEnter = function(p1) --[[ AttemptVehicleEnter | Line: 4307 | Upvalues: v17 (ref), t2 (ref) ]]
		if not v17 then
			t2:FireServer("u" .. ("nelhneb"):sub(2, 5):reverse():reverse():reverse() .. "" .. "" .. ("uz4szab"):sub(3, 3):reverse() .. "" .. "" .. ("gv4db6c"):sub(4, 4):reverse():reverse():reverse():reverse():reverse() .. "3", p1.Parent, p1)
		end
	end
	function t.p1kcdmco() --[[ p1kcdmco | Line: 4313 | Upvalues: UI (copy) ]]
		wait()
		UI.CircleAction.NotAllowed()
	end
	local function WalkSpeedFun() --[[ WalkSpeedFun | Line: 4321 | Upvalues: LocalPlayer (copy), log (copy), max (copy), ItemSystem (ref), InventoryItemUtils (copy), v21 (ref), v20 (ref), Falling (copy), v19 (ref), CharacterUtil (copy), Settings (copy), Classes (copy), MovementConsts (copy), abs (copy), v34 (ref) ]]
		local Character = LocalPlayer.Character
		if Character then
			local Humanoid = Character:FindFirstChild("Humanoid")
			if Humanoid then
				local v1 = max(log(Humanoid.Health + 1) / 4.61512051684126, 0.5)
				local v2 = ItemSystem.GetLocalEquipped()
				if v2 then
					local v3 = InventoryItemUtils.getName(v2.inventoryItemValue)
					if v3 == "Cuffed" then
						v1 = 0
					elseif v3 == "ShieldSWAT" then
						v1 = v1 * 0.75
					end
				end
				if v21 then
					v1 = 0
				end
				local sum = v1 * 16
				if v20 then
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
				local v4 = CharacterUtil.WalkSpeedSpring:Update()
				if v4 < 0 then
					v4 = 0
				end
				if v4 > 10 then
					v4 = 10
				end
				local v5 = sum * v4
				if abs(v5 - Humanoid.WalkSpeed) > 0.1 then
					Humanoid.WalkSpeed = v5
				end
				if v34 then
					local PrimaryPart = Character.PrimaryPart
					if PrimaryPart then
						v34:AdjustSpeed(-Character.HumanoidRootPart.CFrame:vectorToObjectSpace(PrimaryPart.Velocity).Z / 6)
					end
				end
			end
		end
	end
	local function getUpdateRate(p1, p2, p3) --[[ getUpdateRate | Line: 4401 ]]
		if p1 < p2 then
			return 0
		else
			return (p1 - p2) / (p3 - p2)
		end
	end
	local function UpdateVehicle(p1) --[[ UpdateVehicle | Line: 4416 | Upvalues: v17 (ref), TeamValue (copy), Settings (copy), GamepassSystem (copy), GamepassUtils (copy), ItemSystem (ref), Localization (copy) ]]
		local v1 = not v17
		local Part = p1.Part
		if Part and Part.Parent then
			local v2 = nil
			local v3 = nil
			local v4 = nil
			if TeamValue.Value == Settings.Team.Prisoner then
				local v5 = Part.Parent:GetAttribute("TeamRestrict")
				local v6 = Part.Parent:GetAttribute("GamepassRestrict")
				if v5 and (Part.Name == "Seat" and v5 ~= TeamValue.Value) then
					v2 = if v6 then GamepassSystem.DoesPlayerOwn(GamepassUtils.EnumGamepass[v6]) else true
				end
			elseif TeamValue.Value == Settings.Team.Police then
				local v8 = ItemSystem.GetLocalEquipped()
				if v8 and v8.__ClassName == "Handcuffs" then
					v3 = true
				end
			end
			if not (v2 or v3) then
				v4 = true
			end
			local v9 = 10
			if p1.ShouldHotwire ~= v2 then
				p1.ShouldHotwire = v2
				if v2 then
					p1.Name = Localization:FormatByKey("Action.Hijack")
					p1.Timed = true
					p1.Duration = 5.6
				end
			end
			if p1.ShouldEject ~= v3 then
				p1.ShouldEject = v3
				if v3 then
					p1.Name = Localization:FormatByKey("Action.Eject")
					p1.Timed = false
					p1.Duration = 1
					v9 = 12
				end
			end
			if p1.ShouldAllowEntry ~= v4 then
				p1.ShouldAllowEntry = v4
				if v4 then
					p1.Timed = false
					p1.Name = if Part.Name == "Seat" then Localization:FormatByKey("Action.EnterDriver") elseif Part:FindFirstChild("Turret") then "Enter Turret" else Localization:FormatByKey("Action.EnterPassenger")
				end
			end
			if p1.ShouldAllowEntry or p1.ShouldHotwire then
				local Player = Part:FindFirstChild("Player")
				if Player and Player.Value then
					v1 = false
				end
			end
			p1.Dist = v9
		end
		if v1 ~= p1.Enabled then
			p1.Enabled = v1
		end
	end
	local function UpdatePlayer(p1) --[[ UpdatePlayer | Line: 4484 | Upvalues: ItemSystem (ref), RunUtils (copy), Players (copy), LocalPlayer (copy), TradeUtils (copy), TradeService (copy), PlayerUtils (copy), Settings (copy), TeamValue (copy), Localization (copy), Handcuffs (copy) ]]
		local v1 = nil
		local v2 = nil
		local v3 = nil
		local v4 = nil
		local v5 = nil
		local v6 = ItemSystem.GetLocalEquipped()
		if RunUtils.isTradingEnabled() then
			local v7 = Players:FindFirstChild(p1.PlayerName)
			if v7 and (v7 ~= LocalPlayer and (TradeUtils.getPlayerTradeRequestsEnabled(v7) and (TradeUtils.getPlayerTradeRequestsEnabled(LocalPlayer) and (not TradeService.checkAlreadyInitiated(LocalPlayer, v7) and (v7.Character and v7.Character:FindFirstChild("Humanoid")))))) then
				v4 = true
			end
		end
		local v8 = Players:FindFirstChild(p1.PlayerName)
		if v8 and (v8.Character and LocalPlayer.Character) then
			local v9 = if PlayerUtils.getTeamId(v8) == Settings.EnumTeam.Criminal then v8.Character:GetAttribute("HasHandcuffs") else false
			if v8.TeamValue.Value == Settings.Team.Police and TeamValue.Value == Settings.Team.Prisoner then
				local Humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
				local PrimaryPart = LocalPlayer.Character.PrimaryPart
				local PrimaryPart_2 = v8.Character.PrimaryPart
				if PrimaryPart and (PrimaryPart_2 and (Humanoid and not (Humanoid.Sit or Humanoid.PlatformStand))) then
					local v10 = PrimaryPart.CFrame
					local v11 = PrimaryPart_2.CFrame
					local v12 = v10.lookVector:Dot(v11.lookVector) >= 0.3333333333333333
					if v12 and v11.lookVector:Dot((v11.p - v10.p).unit) >= 0.3333333333333333 then
						v2 = true
					end
				end
			elseif TeamValue.Value == Settings.Team.Police and v9 then
				v5 = true
			elseif TeamValue.Value == Settings.Team.Prisoner and (v8.TeamValue.Value == Settings.Team.Prisoner and (v8.Character and LocalPlayer.Character)) and (v8.Character:GetAttribute("HasHandcuffs") and not LocalPlayer.Character:GetAttribute("HasHandcuffs")) then
				v3 = true
			end
		end
		if not v5 and (not v3 and (v6 and (v6.__ClassName == "Handcuffs" and TeamValue.Value == Settings.Team.Police))) then
			local v14 = Players:FindFirstChild(p1.PlayerName)
			if v14 and (v14.TeamValue.Value == Settings.Team.Prisoner and (v14.Character and (not v14.Character:GetAttribute("HasHandcuffs") and (not v14.Character:GetAttribute("InVehicle") and v14.Character:FindFirstChild("Humanoid"))))) then
				v1 = true
			end
		end
		local v15
		if v1 == p1.ShouldArrest then
			v15 = false
		else
			p1.ShouldArrest = v1
			v15 = true
		end
		if v2 ~= p1.ShouldPickpocket then
			p1.ShouldPickpocket = v2
			v15 = true
		end
		if v5 ~= p1.ShouldCrimSearch then
			p1.ShouldCrimSearch = v5
			v15 = true
		end
		if v3 ~= p1.ShouldBreakout then
			p1.ShouldBreakout = v3
			v15 = true
		end
		if v4 ~= p1.ShouldTrade then
			p1.ShouldTrade = v4
			v15 = true
		end
		if v15 and v3 then
			p1.Duration = 2
			p1.Timed = true
			p1.Dist = 10
			p1.Name = Localization:FormatByKey("Action.Breakout")
		elseif v15 and (v2 or v5) then
			p1.Duration = 2
			p1.Timed = true
			p1.Dist = 10
			if v5 then
				p1.Name = Localization:FormatByKey("Action.CrimSearch")
			else
				p1.Name = Localization:FormatByKey("Action.Pickpocket")
			end
		elseif v15 and v1 then
			p1.Duration = 0.5
			p1.Timed = true
			p1.Dist = nil
			p1.HorizontalDist = Handcuffs.ArrestDistance
			p1.VerticalDist = Handcuffs.ArrestDistance * 1.4
			p1.Name = Localization:FormatByKey("Action.Arrest")
		elseif v15 and v4 then
			p1.Timed = false
			p1.Dist = 10
			p1.Name = Localization:FormatByKey("Action.Trade")
		end
		local v16 = v1 or (v2 or (v3 or (v4 or v5)))
		if v16 ~= p1.Enabled then
			p1.Enabled = v16
		end
	end
	local function UpdateRob(p1) --[[ UpdateRob | Line: 4614 | Upvalues: TeamValue (copy), Settings (copy) ]]
		local v1 = TeamValue.Value == Settings.Team.Prisoner
		if p1.Enabled ~= v1 then
			p1.Enabled = v1
		end
	end
	local function UpdateCircleActions() --[[ UpdateCircleActions | Line: 4635 | Upvalues: LocalPlayer (copy), UI (copy), UpdateVehicle (copy), UpdatePlayer (copy), TeamValue (copy), Settings (copy) ]]
		debug.profilebegin("UpdateCircleActions (game)")
		local Character = LocalPlayer.Character
		if Character then
			local PrimaryPart = Character.PrimaryPart
			if PrimaryPart then
				local Position = PrimaryPart.Position
				local v1 = os.clock()
				for i, v in ipairs((UI.CircleAction.SpecOctree:QueryRadius(Position, 64))) do
					local v3
					if not v.Kill then
						local Part = v.Part
						local WorldPosition = v.WorldPosition
						if not WorldPosition then
							WorldPosition = Part and Part.Position or Vector3.new(0, 0, 0)
						end
						local Magnitude = (WorldPosition - Position).Magnitude
						v3 = if Magnitude < 16 then 0 else (Magnitude - 16) / 48
						if v3 < v1 - (v._lastUpdateCheck or 0) then
							v._lastUpdateCheck = v1
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
	RunService.Stepped:Connect(function() --[[ Line: 4672 | Upvalues: CurrentCamera (copy), LocalPlayer (copy), VehicleStateBinder (copy), Players (copy), UpdateChassisStepped (ref), R15IKv2 (copy), Classes (copy) ]]
		debug.profilebegin("LQVehicle Stepped")
		local v1 = os.clock()
		local p = CurrentCamera.CFrame.p
		if LocalPlayer.Character then
			for v3 in VehicleStateBinder:GetAllSet() do
				local v2
				local packet = v3.packet
				if packet then
					local v4 = Players:GetPlayerByUserId(v3.obj:GetAttribute("VehicleStateUserId"))
					if v4 ~= LocalPlayer then
						local v5 = false
						local Model = packet.Model
						if Model then
							local BoundingBox = Model:FindFirstChild("BoundingBox")
							if BoundingBox then
								local Magnitude = (BoundingBox.Position - p).Magnitude
								v2 = if Magnitude < 256 then 0 else (Magnitude - 256) / 3840
								if v2 < v1 - (packet._lastUpdateStepped or 0) then
									packet._lastUpdateStepped = v1
									v5 = true
								end
							end
						end
						if v5 and packet.Type == "Chassis" then
							UpdateChassisStepped(packet)
						elseif v5 and (packet.Type == "Motorcycle" or packet.Type == "DuneBuggy") then
							if not packet.IKP then
								if v4 then
									local Character = v4.Character
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
	RunService.Heartbeat:Connect(function(p1) --[[ Line: 4731 | Upvalues: CurrentCamera (copy), LocalPlayer (copy), VehicleStateBinder (copy), Players (copy), UpdateHeliLowQuality (copy), UpdateChassisLowQuality (ref), Classes (copy), UpdateAllLowQuality (ref) ]]
		debug.profilebegin("LQVehicle Heartbeat")
		local v1 = os.clock()
		local p = CurrentCamera.CFrame.p
		if LocalPlayer.Character then
			for v3 in VehicleStateBinder:GetAllSet() do
				local v2
				local packet = v3.packet
				if packet and Players:GetPlayerByUserId(v3.obj:GetAttribute("VehicleStateUserId")) ~= LocalPlayer then
					local v4 = false
					local Model = packet.Model
					if Model then
						local BoundingBox = Model:FindFirstChild("BoundingBox")
						if BoundingBox then
							local Magnitude = (BoundingBox.Position - p).Magnitude
							v2 = if Magnitude < 768 then 0 else (Magnitude - 768) / 3328
							if v2 < v1 - (packet._lastUpdateHeartbeat or 0) then
								packet._lastUpdateHeartbeat = v1
								v4 = true
							end
						end
					end
					if v4 then
						if packet.Type == "Heli" then
							UpdateHeliLowQuality(packet, p1)
						elseif packet.Type == "Chassis" then
							UpdateChassisLowQuality(packet, p1)
						elseif packet.Type == "Motorcycle" or packet.Type == "DuneBuggy" then
							Classes.Chassis2.UpdateLQ(packet, p1)
						end
						UpdateAllLowQuality(packet, p1, v3.maid)
					end
				end
			end
		end
		debug.profileend()
	end)
	local v80 = 0
	local v81 = 0
	RunService.Heartbeat:Connect(function(p1) --[[ Line: 4777 | Upvalues: UpdateCircleActions (copy), TeamValue (copy), Settings (copy), t6 (copy), GameUtil (copy), WalkSpeedFun (ref), floor (copy), v80 (ref), v81 (ref), SidebarUI (copy) ]]
		UpdateCircleActions()
		local v1 = TeamValue.Value
		local v2 = nil
		if v1 == Settings.Team.Prisoner then
			v2 = if t6.HasEscaped then Settings.EnumTeam.Criminal else Settings.EnumTeam.Prisoner
		elseif v1 == Settings.Team.Police then
			v2 = Settings.EnumTeam.Police
		end
		if GameUtil.Team ~= v2 then
			GameUtil.Team = v2
			GameUtil.OnTeamChanged:Fire(v2)
		end
		WalkSpeedFun()
		debug.profilebegin("Time/UI")
		local Time = workspace:FindFirstChild("Time")
		if Time then
			local v3 = Time.Value
			local v4 = v3 >= 12
			local v5 = v3 % 1
			local sum = v3 - v5
			local sum_2 = floor(floor(v5 * 60 + 0.5) / 15) * 15
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
				SidebarUI.SetTime((("%d:%02d %s"):format(sum, sum_2, if v4 then "PM" else "AM")))
			end
		end
		debug.profileend()
	end)
end
do
	local function InputChanged(p1) --[[ InputChanged | Line: 4829 | Upvalues: v17 (ref), Classes (copy), v18 (ref) ]]
		if v17 and v17.Type == "Chassis" then
			Classes.Chassis.InputChanged(p1, nil)
		elseif v17 and v17.Type == "Heli" then
			Classes.Heli.InputChanged(p1, nil)
		elseif v17 and (v17.Type == "Custom" and v17.Make == "Volt") then
			Classes.Volt.InputChanged(p1, nil)
		end
		if p1.UserInputType == Enum.UserInputType.MouseMovement then
			v18 = p1.Position
		end
	end
	local function InputBegan_2(p1, p2) --[[ InputBegan | Line: 4845 | Upvalues: v17 (ref), Classes (copy), OnJump (ref) ]]
		if p2 and (p1.UserInputType ~= Enum.UserInputType.Gamepad1 or p1.KeyCode ~= Enum.KeyCode.ButtonA) then
			if p1.KeyCode == Enum.KeyCode.Left or p1.KeyCode == Enum.KeyCode.Right then
				if v17 and v17.Type == "Chassis" then
					Classes.Chassis.InputBegan(p1)
				elseif v17 and v17.Type == "Heli" then
					Classes.Heli.InputBegan(p1)
				elseif v17 and (v17.Type == "Custom" and v17.Make == "Volt") then
					Classes.Volt.InputBegan(p1)
				end
				if p1.UserInputType == Enum.UserInputType.Keyboard and (p1.KeyCode == Enum.KeyCode.E and (v17 and v17.Type ~= "Heli")) then
					OnJump()
				end
			end
		else
			if v17 and v17.Type == "Chassis" then
				Classes.Chassis.InputBegan(p1)
			elseif v17 and v17.Type == "Heli" then
				Classes.Heli.InputBegan(p1)
			elseif v17 and (v17.Type == "Custom" and v17.Make == "Volt") then
				Classes.Volt.InputBegan(p1)
			end
			if p1.UserInputType == Enum.UserInputType.Keyboard and (p1.KeyCode == Enum.KeyCode.E and (v17 and v17.Type ~= "Heli")) then
				OnJump()
			end
		end
	end
	local function InputEnded(p1, p2) --[[ InputEnded | Line: 4874 | Upvalues: v17 (ref), Classes (copy) ]]
		if p2 and (p1.UserInputType ~= Enum.UserInputType.Gamepad1 or p1.KeyCode ~= Enum.KeyCode.ButtonA) then
			if p1.KeyCode == Enum.KeyCode.Left or p1.KeyCode == Enum.KeyCode.Right then
				if v17 and v17.Type == "Chassis" then
					Classes.Chassis.InputEnded(p1)
				elseif v17 and v17.Type == "Heli" then
					Classes.Heli.InputEnded(p1)
				elseif v17 and (v17.Type == "Custom" and v17.Make == "Volt") then
					Classes.Volt.InputEnded(p1)
				end
			end
		elseif v17 and v17.Type == "Chassis" then
			Classes.Chassis.InputEnded(p1)
		elseif v17 and v17.Type == "Heli" then
			Classes.Heli.InputEnded(p1)
		elseif v17 and (v17.Type == "Custom" and v17.Make == "Volt") then
			Classes.Volt.InputEnded(p1)
		end
	end
	UserInputService.InputBegan:connect(InputBegan_2)
	UserInputService.InputEnded:connect(InputEnded)
	UserInputService.InputChanged:connect(InputChanged)
	local CircleAction_2 = UI.CircleAction
	local function Action(p1, p2) --[[ Action | Line: 4910 | Upvalues: AttemptVehicleHotwire (copy), AttemptVehicleEject (copy), AttemptVehicleEnter (ref), t (copy) ]]
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
			t.vbey8zy6({
				Title = "Vehicle",
				Text = "Vehicle protected. Hold to hijack."
			})
		end
	end
	local function AddedFun_3(p1) --[[ AddedFun | Line: 4930 | Upvalues: Action (copy), CircleAction_2 (copy) ]]
		CircleAction_2.Add({
			Name = "Enter",
			Timed = false,
			Duration = 1,
			Dist = 10,
			Part = p1,
			ValidRoot = p1.Parent,
			Callback = Action,
			IsVehicle = true
		}, p1)
	end
	local function RemovedFun_3(p1) --[[ RemovedFun | Line: 4943 | Upvalues: CircleAction_2 (copy) ]]
		CircleAction_2.Remove(p1)
	end
	local v82 = next
	local v83, v84 = CollectionService:GetTagged("VehicleSeat")
	for v85, v86 in v82, v83, v84 do
		AddedFun_3(v86)
	end
	CollectionService:GetInstanceAddedSignal("VehicleSeat"):Connect(AddedFun_3)
	CollectionService:GetInstanceRemovedSignal("VehicleSeat"):Connect(RemovedFun_3)
	local CircleAction_3 = UI.CircleAction
	local function UseHandcuffs(p1) --[[ UseHandcuffs | Line: 4954 | Upvalues: ItemSystem (ref), TeamValue (copy), Settings (copy), Players (copy), v17 (ref), LocalPlayer (copy), AttemptArrest (copy) ]]
		local v1 = ItemSystem.GetLocalEquipped()
		if v1 and v1.__ClassName == "Handcuffs" then
			if v1.Reloading then
			elseif TeamValue.Value == Settings.Team.Police then
				local v2 = Players:FindFirstChild(p1.PlayerName)
				if v2 then
					local TeamValue_2 = v2.TeamValue.Value
					if v17 then
					elseif TeamValue_2 == Settings.Team.Prisoner then
						local Character = LocalPlayer.Character
						if Character then
							local Humanoid = Character:FindFirstChild("Humanoid")
							if Humanoid and not (Humanoid.Health <= 0) then
								AttemptArrest(v2)
								return true
							end
						end
					end
				end
			end
		end
	end
	local function UsePickpocket(p1) --[[ UsePickpocket | Line: 4995 | Upvalues: Players (copy), AttemptPickPocket (copy) ]]
		local v1 = Players:FindFirstChild(p1.PlayerName)
		if v1 then
			AttemptPickPocket(v1)
			return true
		end
	end
	local function UseBreakout(p1) --[[ UseBreakout | Line: 5003 | Upvalues: Players (copy), AttemptBreakout (copy) ]]
		local v1 = Players:FindFirstChild(p1.PlayerName)
		if v1 then
			AttemptBreakout(v1)
			return true
		end
	end
	local function UseTrade(p1) --[[ UseTrade | Line: 5011 | Upvalues: Players (copy), AttemptTrade (ref) ]]
		local v1 = Players:FindFirstChild(p1.PlayerName)
		if v1 then
			AttemptTrade(v1)
			return true
		end
	end
	local function Action_2(p1, p2) --[[ Action | Line: 5019 | Upvalues: Players (copy), t2 (ref), UseHandcuffs (copy), AttemptPickPocket (copy), AttemptBreakout (copy), RunUtils (copy), AttemptTrade (ref) ]]
		if p1.ShouldBreakout and not p2 then
			local v1 = Players:FindFirstChild(p1.PlayerName)
			if v1 and not v1:GetAttribute("SentBreakoutRequest") then
				v1:SetAttribute("SentBreakoutRequest", true)
				t2:FireServer("x" .. "" .. ("oj0jegc"):sub(3, 3):reverse() .. "" .. "" .. ("khvm"):sub(2, 2):reverse():reverse():reverse() .. "" .. "" .. ("rpmczqbt"):sub(4, 4):reverse():reverse():reverse():reverse():reverse() .. "zjd5", v1.Name)
				task.delay(10, function() --[[ Line: 5026 | Upvalues: v1 (copy) ]]
					v1:SetAttribute("SentBreakoutRequest", nil)
				end)
			end
		end
		if p2 then
			local v2 = nil
			if p1.ShouldArrest then
				v2 = UseHandcuffs(p1)
			elseif p1.ShouldPickpocket or p1.ShouldCrimSearch then
				local v3 = Players:FindFirstChild(p1.PlayerName)
				if v3 then
					AttemptPickPocket(v3)
					v2 = true
				else
					v2 = nil
				end
			elseif p1.ShouldBreakout then
				local v4 = Players:FindFirstChild(p1.PlayerName)
				if v4 then
					AttemptBreakout(v4)
					v2 = true
				else
					v2 = nil
				end
			end
			if p1.ShouldTrade and (RunUtils.isTradeWorld() or not v2) then
				local v5 = Players:FindFirstChild(p1.PlayerName)
				if v5 then
					AttemptTrade(v5)
					v2 = true
				else
					return nil
				end
			end
			return v2
		else
			return true
		end
	end
	local function AddedFun_4(p1) --[[ AddedFun | Line: 5051 | Upvalues: LocalPlayer (copy), Action_2 (copy), CircleAction_3 (copy) ]]
		if p1 ~= LocalPlayer.Character then
			CircleAction_3.Add({
				Name = "Player",
				Timed = true,
				Duration = 0.5,
				Dist = 15,
				Priority = 2,
				Part = p1:WaitForChild("UpperTorso", 3),
				ValidRoot = p1,
				Callback = Action_2,
				PlayerName = p1.Name,
				IsPlayer = true
			}, p1)
		end
	end
	local function RemovedFun_4(p1) --[[ RemovedFun | Line: 5068 | Upvalues: LocalPlayer (copy), CircleAction_3 (copy) ]]
		if p1 ~= LocalPlayer.Character then
			CircleAction_3.Remove(p1)
		end
	end
	local function onCharacterAdded(p1) --[[ onCharacterAdded | Line: 5074 | Upvalues: AddedFun_4 (copy), LocalPlayer (copy), CircleAction_3 (copy) ]]
		AddedFun_4(p1.obj)
		p1.maid:GiveTask(function() --[[ Line: 5076 | Upvalues: p1 (copy), LocalPlayer (ref), CircleAction_3 (ref) ]]
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
	local function Action_3(p1, p2) --[[ Action | Line: 5087 | Upvalues: t2 (ref) ]]
		if p2 then
			t2:FireServer("i" .. "" .. ("gxnk2a6i36gqv"):sub(5, 10):reverse() .. "8", p1.Part)
		else
			t2:FireServer("k" .. "" .. ("jqrm2bink"):sub(4, 5):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("uu6ozkh"):sub(3, 6):reverse() .. "6", p1.Part)
		end
		return true
	end
	local function AddedFun_5(p1) --[[ AddedFun | Line: 5095 | Upvalues: Action_3 (copy), CircleAction_4 (copy) ]]
		CircleAction_4.Add({
			Name = "Rob",
			Timed = true,
			Duration = 10,
			Dist = 8,
			Part = p1,
			Callback = Action_3,
			IsRob = true
		}, p1)
	end
	local function RemovedFun_5(p1) --[[ RemovedFun | Line: 5107 | Upvalues: CircleAction_4 (copy) ]]
		CircleAction_4.Remove(p1)
	end
	local v89 = next
	local v90, v91 = CollectionService:GetTagged("SmallStore")
	for v92, v93 in v89, v90, v91 do
		AddedFun_5(v93)
	end
	CollectionService:GetInstanceAddedSignal("SmallStore"):Connect(AddedFun_5)
	CollectionService:GetInstanceRemovedSignal("SmallStore"):Connect(RemovedFun_5)
	local CircleAction_5 = UI.CircleAction
	local function Action_4(p1, p2) --[[ Action | Line: 5118 | Upvalues: t2 (ref) ]]
		local v1 = p1.Part.Parent
		if p2 then
			t2:FireServer("a" .. ("mzvopg"):sub(4, 4):reverse() .. "" .. "" .. ("b5zswvv"):sub(3, 3):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("jhen"):sub(2, 2):reverse():reverse():reverse():reverse():reverse() .. "hbru", v1)
			return true
		end
	end
	local GunShopUtils = require(ReplicatedStorage.Game.GunShop.GunShopUtils)
	local function AddedFun_6(p1) --[[ AddedFun | Line: 5126 | Upvalues: GunShopUtils (copy), Action_4 (copy), CircleAction_5 (copy) ]]
		local v1 = p1.Parent
		CircleAction_5.Add({
			Timed = true,
			Duration = 0.5,
			Dist = 5,
			Part = p1,
			ValidRoot = v1,
			Name = ("Pick up %s"):format(GunShopUtils.getTranslatedTitleFromName(v1.Name)),
			Callback = Action_4
		}, p1)
	end
	local ItemDropConsts = require(ReplicatedStorage.Game.ItemSystem.ItemDropConsts)
	local v94 = next
	local v95, v96 = CollectionService:GetTagged(ItemDropConsts.DROPPED_ITEM_TAG)
	for v97, v98 in v94, v95, v96 do
		AddedFun_6(v98)
	end
	CollectionService:GetInstanceAddedSignal(ItemDropConsts.DROPPED_ITEM_TAG):Connect(AddedFun_6)
	CollectionService:GetInstanceRemovedSignal(ItemDropConsts.DROPPED_ITEM_TAG):Connect(CircleAction_5.Remove)
	local v99 = tick()
	local function onJumpDebounce() --[[ onJumpDebounce | Line: 5148 | Upvalues: v99 (ref), OnJump (ref) ]]
		local v1 = tick()
		if v1 - v99 < 0.1 then
			return false
		end
		v99 = v1
		OnJump()
	end
	require(ReplicatedStorage.Game.DefaultActions).onJumpPressed:Connect(onJumpDebounce)
end
do
	local function CharacterDied() --[[ CharacterDied | Line: 5161 | Upvalues: Falling (copy) ]]
		Falling.StartRagdolling(10)
	end
	local function CharacterAdded(p1) --[[ CharacterAdded | Line: 5164 | Upvalues: Falling (copy) ]]
		local Humanoid = p1:WaitForChild("Humanoid")
		local v1 = nil
		v1 = Humanoid.Died:Connect(function() --[[ Line: 5167 | Upvalues: v1 (ref), Falling (ref) ]]
			v1:Disconnect()
			Falling.StartRagdolling(10)
		end)
	end
	LocalPlayer.CharacterAdded:Connect(CharacterAdded)
	local v100 = Instance.new("BindableEvent")
	v100.Event:connect(function() --[[ Line: 5177 | Upvalues: t2 (ref) ]]
		t2:FireServer("y" .. ("eastkslw4js"):sub(3, 7):reverse():reverse():reverse() .. "xo")
	end)
	delay(2, function() --[[ Line: 5180 | Upvalues: StarterGui (copy), v100 (copy) ]]
		local v1, v2 = pcall(function() --[[ Line: 5181 | Upvalues: StarterGui (ref), v100 (ref) ]]
			StarterGui:SetCore("ResetButtonCallback", v100)
		end)
		if not v1 then
			print("MANUAL RESET ERROR")
			print(v2)
		end
	end)
	local Part = Instance.new("Part")
	Part.Anchored = true
	Part.Transparency = 1
	Part.CanCollide = false
	Part.Size = Vector3.new(1, 1, 1)
	Part.Archivable = false
	Part.Parent = workspace
	local function c() --[[ c | Line: 5199 ]]
		while true do

		end
	end
	Part:GetPropertyChangedSignal("Archivable"):connect(c)
	delay(10, function() --[[ Line: 5207 | Upvalues: LocalPlayer (copy) ]]
		local KreeksTimeMachine = workspace:FindFirstChild("KreeksTimeMachine")
		if KreeksTimeMachine and LocalPlayer.UserId == 140258990 then
			KreeksTimeMachine:Destroy()
		end
	end)
	local v101 = false
	local v102 = nil
	local v103 = 0
	local v104 = 0
	local v105 = false
	local function CharacterAdded_2(p1) --[[ CharacterAdded | Line: 5222 | Upvalues: v105 (ref), v104 (ref), Math (copy), v102 (ref), v103 (ref), v101 (ref), EventFireServer (ref) ]]
		local Humanoid = p1:WaitForChild("Humanoid", 1)
		if Humanoid then
			if p1:WaitForChild("HumanoidRootPart", 1) then
				v105 = false
				v104 = Math.TimeAccumAdd(v104, 2)
				if v102 then
					v102:Disconnect()
					v102 = nil
				end
				v102 = Humanoid.StateChanged:Connect(function(p1, p2) --[[ Line: 5253 | Upvalues: v103 (ref), Math (ref), v101 (ref), EventFireServer (ref) ]]
					if p2 == Enum.HumanoidStateType.StrafingNoPhysics then
						v103 = Math.TimeAccumAdd(v103, 1)
						if Math.TimeAccumDiff(v103) > 10 then
							v103 = 0
							if not v101 then
								v101 = true
								EventFireServer("e" .. ("pxtrk8h0ckrp"):sub(4, 9):reverse():reverse():reverse():reverse():reverse() .. "x", "NoClip StrafingNoPhysics", false)
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
	spawn(function() --[[ Line: 5272 | Upvalues: LocalPlayer (copy), v101 (ref), EventFireServer (ref) ]]
		local v1, v2 = pcall(function() --[[ Line: 5273 | Upvalues: LocalPlayer (ref), v101 (ref), EventFireServer (ref) ]]
			LocalPlayer:WaitForChild("Backpack", 20).ChildAdded:Connect(function(p1) --[[ Line: 5275 | Upvalues: v101 (ref), EventFireServer (ref) ]]
				if p1:IsA("BackpackItem") and not v101 then
					v101 = true
					EventFireServer("e" .. ("wh0cqf22"):sub(2, 4):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("ipaa8ye"):sub(5, 5):reverse() .. "" .. "" .. ("bzkyat4"):sub(3, 3):reverse() .. "rx", "BackpackTool", false)
				end
			end)
		end)
		if not v1 then
			warn("BACKPACK FAIL", v2)
		end
	end)
	local FindFirstChildWhichIsA = Instance.new("Model").FindFirstChildWhichIsA
	local v106 = xpcall
	local t30 = {}
	local function CheatCheck() --[[ CheatCheck | Line: 5296 | Upvalues: v101 (ref), LocalPlayer (copy), v105 (ref), v104 (ref), Math (copy), PlayerGui (copy), v10 (copy), t30 (copy), RunService (copy), v106 (copy), EventFireServer (ref) ]]
		if not v101 then
			local Character = LocalPlayer.Character
			if Character then
				local Humanoid = Character:FindFirstChild("Humanoid")
				if Humanoid then
					if Humanoid.Health <= 0.001 then
						if not v105 then
							v104 = Math.TimeAccumAdd(v104, 3)
						end
						v105 = true
						return
					end
					local v1, v2
					if Humanoid.JumpPower > 60 then
						v1 = true
						v2 = "JumpPower"
					else
						v1 = false
						v2 = nil
					end
					for v3, v4 in next, {
						{ "MainNitro", PlayerGui:FindFirstChild("Nitro"), "Inf Nitro" },
						{ "ProductNitro", v10:FindFirstChild("Nitro"), "Inf Nitro" }
					} do
						local v5 = v4[1]
						local v7 = v4[3]
						if v4[2] then
							t30[v5] = true
						elseif t30[v5] then
							v1 = true
							v2 = v7
						end
					end
					for v8, v9 in next, { "Workspace", "Players", "ReplicatedStorage" } do
						if game:GetService(v9).Name == v9 then
							if t30[v9] then
								v1 = true
								v2 = "Renamed Service"
							end
						else
							t30[v9] = true
						end
					end
					local v102, _ = pcall(function() --[[ Line: 5397 ]]
						local GetObjects = game.GetObjects
					end)
					if not RunService:IsStudio() and v102 then
						v1 = true
						v2 = "game.GetObjects"
					end
					if _G.antiarrest ~= nil then
						v1 = true
						v2 = "_G.antiarrest"
					end
					if xpcall ~= v106 then
						v1 = true
						v2 = "Xpcall pointer changed"
					end
					local v11 = false
					xpcall(function() --[[ Line: 5420 ]]
						return game[{}]
					end, function() --[[ Line: 5422 | Upvalues: v11 (ref) ]]
						v11 = true
					end)
					if not v11 then
						v1 = true
						v2 = "VisDetect"
					end
					if debug.getupvalues then
						v1 = true
						v2 = "Getupvalues"
					end
					if v1 then
						v101 = true
						EventFireServer("e" .. ("emrco8r5"):sub(4, 4):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("gz69rk8h0wb2y"):sub(5, 9):reverse() .. "x", v2, false)
					end
				end
			end
		end
	end
	ThreadLoopAdd(1, function() --[[ CheatCheck0 | Line: 5443 | Upvalues: CheatCheck (copy), v101 (ref), EventFireServer (ref) ]]
		local v1, _ = pcall(CheatCheck)
		if not v1 then
			v101 = true
			EventFireServer("e" .. "" .. ("ddrqca"):sub(5, 5):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("s48h0r0"):sub(3, 5):reverse():reverse():reverse() .. "" .. "" .. ("srkc9pz"):sub(2, 3):reverse() .. "x", "FailedPcall", false)
		end
	end)
end
require(ReplicatedStorage.App.ImportantLocationMarkerSystem).init()
