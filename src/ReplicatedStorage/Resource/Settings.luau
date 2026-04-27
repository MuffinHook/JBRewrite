local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local MarketplaceService = game:GetService("MarketplaceService")
local Signal = require(ReplicatedStorage.Std.Signal)
local VehicleData = require(ReplicatedStorage.Game.Garage.VehicleData)
local Enumer = require(ReplicatedStorage.Std.Enumer)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local EnvironmentConsts = require(ReplicatedStorage.Environment.EnvironmentConsts)
local fromRGB = Color3.fromRGB
local newCFrame = CFrame.new
local _ = Vector3.new
local invalidIndexMeta = {
	__index = function(tbl, key)
		local keys = {}
		for k in next, tbl do
			table.insert(keys, k)
		end
		error("Invalid field: \"" .. key .. "\" [" .. table.concat(keys, ", ") .. "]")
	end
}
local Settings = {
	EnumTeam = Enumer({ "Prisoner", "Criminal", "Police" }),
	Test = {
		NoStudioDataLoading = true,
		NoStudioDataSaving = true,
		NoStudioTestEZTests = true,
		StartStudioAsNewPlayer = false,
		NoVehicleTeamRestrict = true,
		SpotlightSeeSelf = false,
		GiveGarageItems = true,
		PopulateTestHome = true,
		GiveAllGamepasses = false,
		Give = nil,
		GiveConsumables = {},
		RegionSounds = false,
		Ambient = false,
		Cash = 1000000,
		NoVehicleLevelRequire = true,
		EnterVehicleWithoutOwning = true,
		AllowManualRespawn = true,
		SpawnInOilRig = false,
		GuardItemName = nil,
		ChooseTeamInitially = false,
		RobberySystem = true
	},
	Team = setmetatable({
		Prisoner = "Prisoner",
		Police = "Police"
	}, invalidIndexMeta)
}
Settings.TeamColor = {
	[Settings.EnumTeam.Prisoner] = Color3.fromRGB(253, 123, 49),
	[Settings.EnumTeam.Criminal] = Color3.fromRGB(252, 40, 47),
	[Settings.EnumTeam.Police] = Color3.fromRGB(42, 204, 255)
}
Settings.EnableCriminalSpawnSystem = true
Settings.Perm = {
	Autopilot = {
		Group = 3059674,
		Rank = 100
	},
	Dev = {
		Group = 3059674,
		Rank = 100,
		Id = {
			["319758610"] = true,
			["25881764"] = true
		}
	},
	InjanHorn = {
		Id = {
			["77195160"] = true
		}
	}
}
Settings.Cash = TableUtils.requireValidIndex({
	IncorrectArrest = -25,
	CorrectArrest = 400,
	SmallStoreRob = 750,
	MorningPolice = 1200,
	MorningCriminal = 50,
	MorningNoPickpocketBonus = 200,
	MorningGoodArrestBonus = 100,
	FireExtinguish = 100,
	EnterLevelSeason = 2500,
	DonateDropMax = 20000,
	DonateDropMin = 200,
	DonateDropMaxDaily = 50000,
	DonatePickupMaxDaily = 20000
})
Settings.Price = {}
Settings.VehicleLevel = {}
for _, vehicleEntry in next, VehicleData do
	Settings.Price[vehicleEntry.Make] = vehicleEntry.Price
	if vehicleEntry.PoliceLevel then
		Settings.VehicleLevel[vehicleEntry.Make] = {
			Level = vehicleEntry.PoliceLevel,
			Team = Settings.Team.Police
		}
	elseif vehicleEntry.PrisonerLevel then
		Settings.VehicleLevel[vehicleEntry.Make] = {
			Level = vehicleEntry.PrisonerLevel,
			Team = Settings.Team.Prisoner
		}
	elseif vehicleEntry.Level then
		Settings.VehicleLevel[vehicleEntry.Make] = {
			Level = vehicleEntry.Level,
			Team = Settings.Team.Prisoner
		}
	end
end
local timeSettings = {
	BankRobberyGuilty = 60,
	WireBoxGuilty = 30,
	SeatGuilty = 10,
	PunchGuilty = 10,
	PickPocketGuilty = 20,
	BarbedWireGuilty = 5,
	ExplodeWallGuilty = 120,
	DamageInnocentCooldown = 1,
	Stunned = 1.875,
	BetweenSeats = 0.5,
	BetweenSeatsEjectCooldown = 4,
	Respawn = 4,
	Spotlight = 20,
	Receipt = 10,
	BetweenRobbery = 300,
	RobberyTimeout = 300,
	RobberyTimeoutFirstPlayer = 90,
	Cell = 5,
	FaultyAction = 60,
	HelpMessageCycle = 45
}
timeSettings.BetweenTeamChange = if RunUtils.isStudio() then 1 else 24
Settings.Time = timeSettings
Settings.Scalar = {
	ShieldSWATDamageMult = 0.6,
	MoneyRobberyA = 8,
	MoneyRobberyk = 4,
	PunchesToOpenDoor = 8,
	NitroMax = 250,
	MilitaryBountyMin = 3500
}
Settings.Distance = {
	Spotlight = 500
}
Settings.PatDownItems = {
	Rifle = true,
	Pistol = true,
	Shotgun = true,
	Key = true,
	AK47 = true,
	Uzi = true,
	Flashlight = true,
	Binoculars = true,
	Glider = true,
	RocketLauncher = true,
	Grenade = true,
	Sword = true,
	Baton = true,
	ForcefieldLauncher = true,
	Sniper = true,
	PlasmaPistol = true,
	Revolver = true,
	RoadSpike = true,
	Flintlock = true,
	C4 = true,
	SmokeGrenade = true,
	NerfPistol = true,
	NerfRevolver = true,
	Juice = true,
	CCTV = true,
	PlasmaShotgun = true
}
Settings.MetalDetectItems = Settings.PatDownItems
Settings.Prism = {
	City = {
		c = newCFrame(134.049, 21.484, 1115.01),
		s = Vector3.new(920.097, 11.938, 708.02)
	},
	Prison = {
		{
			c = newCFrame(-1389.14, 75.14, -1841.9),
			s = Vector3.new(413.25, 130.9, 394.9)
		},
		{
			c = newCFrame(-1309.39, 75.14, -1783.9),
			s = Vector3.new(397.55, 130.9, 267.9)
		},
		{
			c = newCFrame(-1295.84, 75.14, -1630.1),
			s = Vector3.new(567.85, 130.9, 158.1)
		},
		{
			c = newCFrame(-1255.19, 75.14, -1475.7),
			s = Vector3.new(497.35, 130.9, 183.3)
		},
		{
			c = newCFrame(-1251.39, -52.96, -1726.65),
			s = Vector3.new(648.15, 126.7, 901.4)
		}
	},
	Guilty = {
		Parking3 = {
			c = newCFrame(-1547.78, 65.2, -1692.92),
			s = Vector3.new(95.3, 99, 212.1)
		},
		Umbrella = {
			c = newCFrame(-1065.98, 65.2, -1747.67),
			s = Vector3.new(136.3, 99, 411.2)
		},
		Sewers = {
			c = newCFrame(-1018.76, -35.49, -1738.55),
			s = Vector3.new(680.8, 99, 1144.2)
		},
		Parking2 = {
			c = newCFrame(-1456.63, 65.2, -1581.82),
			s = Vector3.new(110, 99, 146.7)
		},
		Parking1 = {
			c = newCFrame(-1237.18, 65.2, -1430.92),
			s = Vector3.new(478.7, 99, 247.3)
		},
		Police = {
			c = newCFrame(-1206.38, 65.2, -1568.42),
			s = Vector3.new(153.9, 99, 52.7)
		},
		Police2 = {
			c = newCFrame(-1173.18, 65.2, -1594.47),
			s = Vector3.new(34.7, 99, 15.2)
		},
		Police3 = {
			c = newCFrame(-1251.23, 65.2, -1592.87),
			s = Vector3.new(56.4, 99, 12)
		}
	}
}
if RunService:IsServer() then
	local PRISON_REGION = game:GetService("ServerStorage"):FindFirstChild("PRISON_REGION")
	if PRISON_REGION then
		local prisonParts = {}
		for _, part in PRISON_REGION:QueryDescendants(">BasePart") do
			table.insert(prisonParts, {
				c = part.CFrame,
				s = part.Size
			})
		end
		if #prisonParts > 0 then
			Settings.Prism.Prison = prisonParts
		end
	end
end
Settings.Textures = {
	Blank = nil,
	Blade = 739216272,
	Arachnid = 739216225,
	Turbine = 739216078,
	Halo = 794959081,
	Spinner = 839445173,
	Star = 961957441,
	Money = 1077086727,
	Spike = 1258755912,
	Snowflake = 1258755719,
	Flower = 1386165807,
	Bloxy = 1470417282,
	Billion = 1470417446,
	Cyclone = 1677705870,
	Jet = 1797145872,
	Hypno = 1890793642,
	Checkered = 743049278,
	Brickset = 2420419114,
	StarBadge = 2668233100,
	SpiderLeg = 2668233326,
	Soccer = 2928333546
}
Settings.Colors = {
	Vantablack = Color3.new(0/255, 0/255, 0/255),
	Matte = Color3.fromRGB(27, 42, 53),
	Blue = Color3.fromRGB(9, 79, 172),
	Cyan = Color3.fromRGB(15, 124, 141),
	Chrome = Color3.fromRGB(248, 248, 248),
	Grey = Color3.fromRGB(75, 79, 86),
	Gold = Color3.fromRGB(188, 155, 93),
	Pink = Color3.fromRGB(255, 152, 220),
	Purple = Color3.fromRGB(79, 25, 90),
	Red = Color3.fromRGB(150, 0, 2),
	Black = Color3.fromRGB(0, 0, 0),
	Green = Color3.fromRGB(136, 190, 60),
	["Forest Green"] = Color3.fromRGB(9, 70, 7),
	Yellow = Color3.fromRGB(199, 168, 41),
	Orange = Color3.fromRGB(226, 117, 24),
	White = Color3.fromRGB(183, 184, 192),
	FallChrome = Color3.fromRGB(207, 96, 36),
	["Hot Orange"] = Color3.fromRGB(252, 66, 7),
	["Super Lime"] = Color3.fromRGB(161, 255, 40),
	["Deep Purple"] = Color3.fromRGB(146, 0, 255),
	Sand = Color3.fromRGB(190, 176, 133),
	["Pastel Green"] = Color3.fromRGB(113, 175, 114),
	["Pastel Violet"] = Color3.fromRGB(122, 120, 192),
	["Pastel Blue"] = Color3.fromRGB(138, 197, 204),
	["Pastel Gray"] = Color3.fromRGB(159, 161, 172),
	["Pastel Pink"] = Color3.fromRGB(186, 150, 192),
	["Pastel Yellow"] = Color3.fromRGB(238, 231, 154),
	["Pastel Orange"] = Color3.fromRGB(235, 123, 109),
	["Pastel Brown"] = Color3.fromRGB(107, 75, 50)
}
Settings.Images = {
	Sword = "rbxassetid://700374040",
	CirclePolice = "rbxassetid://700374050",
	CirclePrisoner = "rbxassetid://700374057",
	Handcuffs = "rbxassetid://700374045",
	Ropecuffs = "rbxassetid://4904803313",
	Key = "rbxassetid://123906721882907",
	Taser = "rbxassetid://880310770",
	ShieldSWAT = "rbxassetid://731821219",
	CirclePoliceColor = fromRGB(63, 170, 224),
	CirclePrisonerColor = fromRGB(247, 176, 70),
	Donut = "rbxassetid://871077212",
	Flashlight = "rbxassetid://880310771",
	Binoculars = "rbxassetid://1388678084",
	Glider = "rbxassetid://1679785902",
	Grenade = "rbxassetid://2189707847",
	Baton = "rbxassetid://4036192185",
	RoadSpike = "rbxassetid://4572537288",
	C4 = "rbxassetid://6098428553",
	SmokeGrenade = "rbxassetid://6475595967",
	NerfPistol = "rbxassetid://6930018123",
	NerfRevolver = "rbxassetid://6930017845",
	Juice = "rbxassetid://7204318505",
	Bag = "rbxassetid://7894717823",
	Crate = "rbxassetid://7895297455",
	CCTV = "rbxassetid://8482263448",
	Gem = "rbxassetid://11452844009",
	Megaphone = "rbxassetid://104167277579499",
	CrimeKey = "rbxassetid://104402296470232",
	AK47 = "rbxassetid://16647909271",
	Flintlock = "rbxassetid://16647911211",
	ForcefieldLauncher = "rbxassetid://16647912007",
	Pistol = "rbxassetid://16647913398",
	PlasmaPistol = "rbxassetid://16647916237",
	PlasmaShotgun = "rbxassetid://17206667283",
	Revolver = "rbxassetid://16647917031",
	Rifle = "rbxassetid://16647917663",
	RocketLauncher = "rbxassetid://16647918515",
	Shotgun = "rbxassetid://16647919326",
	Sniper = "rbxassetid://16647920120",
	Uzi = "rbxassetid://16647920802",
	Eject = "rbxassetid://704079688",
	Grab = "rbxassetid://704079682",
	Lockpick = "rbxassetid://704079686",
	Drawer = "rbxassetid://704079690",
	Safe1 = "rbxassetid://4929032013",
	Safe2 = "rbxassetid://4929032265",
	Safe3 = "rbxassetid://4929032526",
	Safe4 = "rbxassetid://4929032754",
	Safe5 = "rbxassetid://4929032995",
	Safe6 = "rbxassetid://4929033199",
	Crawl = "rbxassetid://4939759147",
	Sprint = "rbxassetid://4939735995",
	CarFlip = "rbxassetid://4939737424",
	Drift = "rbxassetid://4939737110",
	HeliUp = "rbxassetid://4939737716",
	HeliDown = "rbxassetid://4939738083",
	Headlights = "rbxassetid://4939738413",
	Mute = "rbxassetid://4939738725",
	Unmute = "rbxassetid://4939739006",
	Horn = "rbxassetid://4939742186",
	Punch = "rbxassetid://4939740172",
	HeliRope = "rbxassetid://4939739616",
	Siren = "rbxassetid://4939739355",
	Radio = "rbxassetid://4970993126",
	Nitro = "rbxassetid://4939740976",
	Action = "rbxassetid://4939741296",
	HeliMissile = "rbxassetid://4939740665",
	CamToggle = "rbxassetid://4939741662",
	Aim = "rbxassetid://4939736720",
	Shoot = "rbxassetid://4939736393",
	Paintbrush = "rbxassetid://4986819790",
	MansionInvite = "rbxassetid://11816901119"
}
Settings.TextureIcon = {
	Peach = 897602287,
	ClassicVar1 = 897602216,
	ClassicVar3 = 897602238,
	Racer = 897602255,
	Scorch = 897602292,
	TwoSided = 897602298,
	Cow = 897602237,
	Swirl = 897602285,
	Diamond = 897602276,
	Camo = 897602230,
	Taxi = 897602277,
	Checker = 897602228,
	ClassicVar2 = 897602224,
	CandyCane = 897602223,
	Rainbow = 897602281,
	Wireframe = 897602304,
	Lines = 897602247,
	Frost = 904849571,
	Volcano = 904849602,
	Zebra = 904849591,
	Ice = 904849604,
	Galaxy = 961908072,
	Pixel = 976877590,
	Paint = 1262926758,
	Police = 1262927764,
	Volt = 1262926761,
	Speed = 1262926768,
	Frit = 1262926750,
	Ladybug = 1262926741,
	Donut = 1262926769,
	GalaxyWave = 1679554197,
	Field = 2003752214,
	Ball = 2003751347,
	OrangePixel = 2938743654,
	BluePixel = 2938743709,
	GlowingYellow = 2938743656,
	Hotdog = 2938743660,
	Wavy = 2938743659,
	Tiger = 2938743661,
	Lightning = 2938743705,
	Earth = 2938743711,
	Bacon = 2938743713,
	Armor = 2938743722,
	Money = 2938743727
}
Settings.Sounds = {
	Equip = 690572276,
	Horn = 9058828003,
	InjanHorn = 739735604,
	Punch = 690530166,
	Spotlight = 9058817031,
	Button = 690537495,
	Notification = 700153902,
	Door = 700180643,
	RifleReload = 690663102,
	RifleFire = 690893748,
	ShotgunFire = 9058786633,
	ShotgunPump = 700089214,
	PistolFire = 9058791467,
	PistolReload = 690572619,
	PrisonSiren = 9058779926,
	RobberyRinger = 9058779467,
	FireworkBang = 737592495,
	Taser = 754972373,
	Glass = 848150421,
	DoorSlam = 9058743683,
	LaserCut = 849939125,
	Nitro1 = 1386598740,
	NitroLoop = 9058734199,
	HatchOpen = 1791024087,
	HatchClose = 1791025004
}
local ambientIds = {
	SummerNight = 9063413793,
	Forest = 9063410557,
	Wind = 9063412821
}
ambientIds.Rain = if EnvironmentConsts.SNOW then 90535439010163 else 9063411694
Settings.AmbientIds = ambientIds
local ambientVolumes = {}
local dayVolumes = {
	Wind = 0.1,
	Leaves = 0.4,
	SummerNight = 0,
	Fire = 0,
	Forest = 0.2,
	BrownNoise = 0.1
}
dayVolumes.Rain = if EnvironmentConsts.SNOW then 0.05 else 0
dayVolumes.Vig = fromRGB(253, 102, 8)
dayVolumes.Minimap = fromRGB(219, 238, 243)
ambientVolumes.Day = dayVolumes
local nightVolumes = {
	Wind = 0.13,
	Leaves = 0.3,
	SummerNight = 0.4,
	Fire = 0.1,
	Forest = 0
}
nightVolumes.Rain = if EnvironmentConsts.SNOW then 0.05 else 0
nightVolumes.BrownNoise = 0.02
nightVolumes.Vig = fromRGB(0, 0, 0)
nightVolumes.Minimap = fromRGB(85, 130, 176)
ambientVolumes.Night = nightVolumes
local stormVolumes = {
	Wind = 0.2,
	Leaves = 0,
	SummerNight = 0,
	Fire = 0,
	Forest = 0,
	BrownNoise = 0.1
}
stormVolumes.Rain = if EnvironmentConsts.SNOW then 0.65 else 0.5
stormVolumes.Vig = fromRGB(253, 102, 8)
stormVolumes.Minimap = fromRGB(85, 130, 176)
ambientVolumes.Storm = stormVolumes
Settings.Ambient = ambientVolumes
local GamepassData = require(ReplicatedStorage.Gamepass.GamepassData)
Settings.Gamepass = {}
for i, gamepassItem in ipairs(GamepassData) do
	Settings.Gamepass[gamepassItem.Title] = gamepassItem
end
Settings.Badge = {
	MVP = {
		i = 958186367
	},
	TopGun = {
		i = 958186842,
		Team = Settings.Team.Police
	},
	BankBust = {
		i = 958186941,
		Team = Settings.Team.Police,
		MinPlayers = 3
	},
	DrillSergeant = {
		i = 958187053,
		MinPlayers = 5,
		Team = Settings.Team.Police,
		ServerStart = tick()
	},
	MasterCriminal = {
		i = 958187226,
		Team = Settings.Team.Prisoner,
		Places = { "Jewelry", "Bank", "Donut Shop", "Gas Station" }
	},
	BonnieClyde = {
		i = 958187343,
		Team = Settings.Team.Prisoner
	},
	SmoothCriminal = {
		i = 958187470,
		Team = Settings.Team.Prisoner,
		MinPlayers = 5,
		MinBounty = 500
	},
	BeatCEO = {
		i = 2129891386
	}
}
for badgeName, badgeData in next, Settings.Badge do
	badgeData.Name = badgeName
end
Settings.DevProduct = {
	{
		Id = 1894552543,
		Type = "Cash",
		Index = 1,
		Cash = 10000
	},
	{
		Id = 1894553755,
		Type = "Cash",
		Index = 2,
		Cash = 25000
	},
	{
		Id = 1894553754,
		Type = "Cash",
		Index = 3,
		Cash = 100000
	},
	{
		Id = 1894553756,
		Type = "Cash",
		Index = 4,
		Cash = 250000
	},
	{
		Id = 1894553753,
		Type = "Cash",
		Index = 5,
		Cash = 1000000
	},
	{
		Id = 144034773,
		Type = "Nitro",
		Name = "Tier1"
	},
	{
		Id = 144035019,
		Type = "Nitro",
		Name = "Tier2"
	},
	{
		Id = 144035583,
		Type = "Nitro",
		Name = "Tier3"
	},
	{
		Id = 437705749,
		Type = "Rent",
		Make = "Lamborghini",
		Time = 86400
	},
	{
		Id = 464183005,
		Type = "ServerControl",
		Name = "Train"
	},
	{
		Id = 464183060,
		Type = "ServerControl",
		Name = "AirDrop"
	},
	{
		Id = 513037729,
		Type = "ServerControl",
		Name = "Party"
	},
	{
		Id = 580270772,
		Type = "JetPack",
		Name = "JetPackRocketFuel",
		FuelType = "Rocket"
	},
	{
		Id = 980194938,
		Type = "Nuke"
	},
	{
		Id = 1109061749,
		TestId = {
			[708709673] = 1115124952,
			[5141682374] = 1115127356
		},
		Type = "DuffelBagUpgrade",
		Tier = 2,
		AmountMult = 1.3333333333333333
	},
	{
		Id = 1109061774,
		TestId = {
			[708709673] = 1115125442,
			[5141682374] = 1115127371
		},
		Type = "DuffelBagUpgrade",
		Tier = 3,
		AmountMult = 1.6666666666666665
	},
	{
		Id = 1109061792,
		TestId = {
			[708709673] = 1115125480,
			[5141682374] = 1115127400
		},
		Type = "DuffelBagUpgrade",
		Tier = 4,
		AmountMult = 2
	},
	{
		Id = 1127648291,
		TestId = {
			[5141682374] = 3223782787
		},
		Type = "SeasonPass"
	}
}
if game.PlaceId ~= 606849621 then
	for i, devProduct in ipairs(Settings.DevProduct) do
		if devProduct.TestId and devProduct.TestId[game.PlaceId] then
			devProduct.Id = devProduct.TestId[game.PlaceId]
		end
	end
end
function Settings.getFirstProductByType(productType)
	assert(productType ~= nil)
	for i, devProduct in ipairs(Settings.DevProduct) do
		if devProduct.Type == productType then
			return devProduct
		end
	end
end
for i, gamepassItem in ipairs(GamepassData) do
	if gamepassItem.GiftProductId ~= nil then
		table.insert(Settings.DevProduct, {
			Id = gamepassItem.GiftProductId,
			Type = "GiftGamepass",
			Name = gamepassItem.Title
		})
	end
end
Settings.OnProductsFetched = Signal.new()
function Settings.FetchProducts()
	task.spawn(function()
		Settings.FetchedMarketplace = false
		local count = 0
		for k, devProduct in pairs(Settings.DevProduct) do
			count = count + 1
			task.spawn(function()
				local Type = devProduct.Type
				local Id = devProduct.Id
				if Type == "Nitro" then
					local productInfo = MarketplaceService:GetProductInfoAsync(Id, Enum.InfoType.Product)
					local fuel = tonumber((productInfo.Name:gsub("[^%d]+", "")))
					devProduct.Robux = productInfo.PriceInRobux
					devProduct.Fuel = fuel
				elseif Type == "Cash" or (Type == "Rent" or (Type == "SeasonPass" or Type == "GiftGamepass")) then
					local productInfo = MarketplaceService:GetProductInfoAsync(Id, Enum.InfoType.Product)
					devProduct.Robux = productInfo.PriceInRobux
					devProduct.ImageId = productInfo.IconImageAssetId
				end
				count = count - 1
			end)
		end
		for k, gamepassItem in pairs(GamepassData) do
			if gamepassItem.PassId then
				count = count + 1
				task.spawn(function()
					local success, passInfo = pcall(MarketplaceService.GetProductInfo, MarketplaceService, gamepassItem.PassId, Enum.InfoType.GamePass)
					if success then
						gamepassItem.ImageId = passInfo.IconImageAssetId
						gamepassItem.PriceInRobux = passInfo.PriceInRobux
					else
						warn("Failed to fetch gamepass info for " .. gamepassItem.Title .. " with id " .. gamepassItem.PassId)
					end
					count = count - 1
				end)
			end
		end
		while count > 0 do
			task.wait()
		end
		Settings.FetchedMarketplace = true
		Settings.OnProductsFetched:Fire()
	end)
end
if RunUtils.isMainWorld() then
	local lightingSettings = {
		Day = {
			Ambient = fromRGB(110, 110, 110),
			Brightness = 1.25,
			ColorShift_Top = fromRGB(255, 234, 220),
			OutdoorAmbient = fromRGB(161, 163, 163),
			AtmoDensity = 0.225,
			AtmoColor = fromRGB(0, 0, 0),
			AtmoGlare = 1,
			AtmoHaze = 2.06,
			CloudsCover = 0.612,
			CloudsDensity = 0.286,
			CloudsColor = fromRGB(204, 216, 226),
			CCTint = fromRGB(255, 255, 255),
			GlobalWind = Vector3.new(-40, -33, 100),
			EnvironmentDiffuseScale = 0.15,
			ExposureCompensation = 0.2
		},
		Night = {
			Ambient = fromRGB(110, 110, 110),
			Brightness = 1,
			ColorShift_Top = fromRGB(0, 0, 0),
			OutdoorAmbient = fromRGB(0, 136, 190),
			AtmoDensity = 0.325,
			AtmoColor = fromRGB(0, 127, 198),
			AtmoGlare = 0,
			AtmoHaze = 1.5,
			CloudsCover = 0.625,
			CloudsDensity = 0.5,
			CloudsColor = Color3.fromRGB(0, 24, 56),
			CCTint = fromRGB(255, 255, 255),
			GlobalWind = Vector3.new(-30, -33, 82),
			EnvironmentDiffuseScale = 0.25,
			ExposureCompensation = 0.2
		}
	}
	local stormLighting = {
		Ambient = fromRGB(110, 110, 110),
		Brightness = 0.4,
		ColorShift_Top = fromRGB(158, 216, 255),
		OutdoorAmbient = fromRGB(103, 120, 152)
	}
	local SNOW = EnvironmentConsts.SNOW
	stormLighting.AtmoDensity = 0.3
	stormLighting.AtmoColor = if EnvironmentConsts.SNOW then fromRGB(158, 172, 202) else fromRGB(117, 142, 174)
	stormLighting.AtmoGlare = 1
	stormLighting.AtmoHaze = 2.06
	stormLighting.CloudsCover = 0.75
	stormLighting.CloudsDensity = 1
	stormLighting.CloudsColor = fromRGB(57, 68, 87)
	stormLighting.CCTint = fromRGB(255, 255, 255)
	stormLighting.GlobalWind = Vector3.new(-550, -333, 200)
	stormLighting.EnvironmentDiffuseScale = 0.2
	stormLighting.ExposureCompensation = 0.2
	lightingSettings.Storm = stormLighting
	Settings.Lighting = lightingSettings
else
	Settings.Lighting = {
		Day = {
			Ambient = fromRGB(100, 100, 100),
			OutdoorAmbient = fromRGB(50, 50, 50),
			Brightness = 4.5,
			ColorShift_Top = fromRGB(0, 0, 0),
			AtmoDensity = 0.3,
			AtmoColor = fromRGB(199, 199, 199),
			AtmoGlare = 0,
			AtmoHaze = 0,
			CloudsCover = 0.554,
			CloudsDensity = 1,
			CloudsColor = fromRGB(125, 143, 179),
			CCTint = fromRGB(255, 255, 255)
		},
		Night = {
			Ambient = fromRGB(100, 100, 100),
			OutdoorAmbient = fromRGB(50, 50, 50),
			Brightness = 3,
			ColorShift_Top = fromRGB(55, 145, 255),
			AtmoDensity = 0.35,
			AtmoColor = fromRGB(102, 116, 140),
			AtmoGlare = 0,
			AtmoHaze = 2,
			CloudsCover = 0.554,
			CloudsDensity = 1,
			CloudsColor = fromRGB(84, 111, 159),
			CCTint = fromRGB(255, 255, 255)
		},
		Storm = {
			Ambient = fromRGB(100, 100, 100),
			OutdoorAmbient = fromRGB(50, 50, 50),
			Brightness = 2,
			ColorShift_Top = fromRGB(176, 203, 255),
			AtmoDensity = 0.4,
			AtmoColor = fromRGB(157, 148, 154),
			AtmoGlare = 0,
			AtmoHaze = 2.14,
			CloudsCover = 0.75,
			CloudsDensity = 1,
			CloudsColor = fromRGB(84, 111, 159),
			CCTint = fromRGB(255, 255, 255)
		}
	}
end
local function Round(value, step)
	return math.floor(value / step + 0.5) * step
end
local function SkewNumber(base)
	local low = -base * 0.4
	return math.floor((base + (math.random() * (base * 0.2 - low) + low)) / 50 + 0.5) * 50
end
Settings.ItemTypeToPlayerTable = {
	Texture = "Textures",
	Rim = "Rims",
	Glow = "Glows",
	BodyColor = "BodyColors",
	WindowColor = "WindowColors",
	WheelColor = "WheelColors",
	Engine = "Engine",
	SuspensionHeight = "SuspensionHeight",
	Brakes = "Brakes",
	HeadlightColor = "HeadlightColors",
	Spoiler = "Spoilers",
	SpoilerColor = "SpoilerColors",
	Color = "Colors"
}
return Settings
