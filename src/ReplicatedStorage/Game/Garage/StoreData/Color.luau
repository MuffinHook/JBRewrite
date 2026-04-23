local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local HyperChromeUtils = require(ReplicatedStorage.HyperChrome.HyperChromeUtils)
local HyperChromeConsts = require(ReplicatedStorage.HyperChrome.HyperChromeConsts)
local t = {
	{
		Name = "SnowWhite",
		Hidden = true,
		HiddenAll = true,
		DoNotGive = true,
		NoTrade = true
	},
	{
		Name = "Mud",
		Price = 5000
	},
	{
		Name = "RadiantWhite",
		Hidden = true,
		Tags = { "Nuke" }
	},
	{
		Name = "RadiantPink",
		Hidden = true,
		Tags = { "Nuke" }
	},
	{
		Name = "RadiantRed",
		Hidden = true,
		Tags = { "Nuke" }
	},
	{
		Name = "RadiantPolarBlue",
		Hidden = true,
		Tags = { "Nuke" }
	},
	{
		Name = "SakuraPink",
		Price = 10000
	},
	{
		Name = "DarkestBlue",
		Price = 5000
	},
	{
		Name = "DarkestGreen",
		Price = 5000
	},
	{
		Name = "DarkestMarine",
		Price = 5000
	},
	{
		Name = "DarkestRed",
		Price = 5000
	},
	{
		Name = "DarkestBrown",
		Price = 5000
	},
	{
		Name = "DarkestPurple",
		Season = 13,
		Level = 2,
		SeasonIconId = 11811060890
	},
	{
		Name = "NavyBlue",
		Price = 5000
	},
	{
		Name = "HottestPink",
		Price = 5000
	},
	{
		Name = "Maroon",
		Price = 5000
	},
	{
		Name = "RealGreen",
		Price = 5000
	},
	{
		Name = "MilitaryGreen",
		Price = 5000
	},
	{
		Name = "RadiantPurple",
		Hidden = true,
		Tags = { "Nuke" }
	},
	{
		Name = "RadiantGreen",
		Hidden = true,
		Tags = { "Nuke" }
	},
	{
		Name = "RadiantIce",
		Hidden = true,
		Tags = { "Nuke" }
	},
	{
		Name = "RadiantOrange",
		Hidden = true,
		Tags = { "Nuke" }
	},
	{
		Name = "RadiantSun",
		Hidden = true,
		Tags = { "Nuke" }
	},
	{
		Name = "Vantablack",
		Season = 2,
		Level = 5
	},
	{
		Name = "RadiantYellow",
		Hidden = true,
		Tags = { "Nuke" }
	},
	{
		Name = "Gold",
		Hidden = true
	},
	{
		Name = "Yellow",
		Price = 1000
	},
	{
		Name = "White",
		Price = 1000
	},
	{
		Name = "Chrome",
		Price = 1000,
		VIP = true,
		NoTrade = true
	},
	{
		Name = "Blue",
		Price = 1000
	},
	{
		Name = "Green",
		Price = 1000
	},
	{
		Name = "Red",
		Price = 1000
	},
	{
		Name = "Matte",
		Price = 1000
	},
	{
		Name = "Black",
		Price = 1000
	},
	{
		Name = "Grey",
		Price = 1000
	},
	{
		Name = "Orange",
		Price = 1000
	},
	{
		Name = "Pink",
		Price = 1000
	},
	{
		Name = "Cyan",
		Price = 1000
	},
	{
		Name = "Forest Green",
		Price = 1000
	},
	{
		Name = "Purple",
		Price = 1000
	},
	{
		Name = "Pastel Green",
		Price = 2000
	},
	{
		Name = "Pastel Violet",
		Price = 2000
	},
	{
		Name = "Pastel Blue",
		Price = 2000
	},
	{
		Name = "Pastel Gray",
		Price = 2000
	},
	{
		Name = "Pastel Pink",
		Price = 2000
	},
	{
		Name = "Pastel Yellow",
		Price = 2000
	},
	{
		Name = "Pastel Orange",
		Price = 2000
	},
	{
		Name = "Pastel Brown",
		Price = 2000
	},
	{
		Name = "Sand",
		Price = 5000
	},
	{
		Name = "Hot Orange",
		Price = 10000
	},
	{
		Name = "Super Lime",
		Price = 10000
	},
	{
		Name = "Deep Purple",
		Price = 12000
	},
	{
		Name = "FallChrome",
		Price = 5000,
		Hidden = true
	}
}
for v1, v2 in HyperChromeUtils.getListOfHyperChromeNames() do
	table.insert(t, 1, {
		Name = v2,
		Hidden = true,
		HiddenAll = true
	})
end
table.insert(t, 1, {
	Name = HyperChromeConsts.COLOR_SHIFT_NAME,
	Hidden = true,
	HiddenAll = true,
	NoTrade = true
})
local function Update(p1, p2) --[[ Line: 261 ]]
	local v1 = os.clock() / 2
	p1.CFrame = CFrame.Angles(0, v1 % 6.283185307179586, 0) * CFrame.Angles(math.sin(v1) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, 8)
end
return {
	Items = t,
	GetInstance = function(p1) --[[ Name: GetInstance | Line: 268 | Upvalues: Paint (copy) ]]
		local Part = Instance.new("Part")
		Part.Shape = Enum.PartType.Ball
		Part.Size = Vector3.new(4, 4, 4)
		Part.TopSurface = 0
		Part.BottomSurface = 0
		Part.Color = Paint.GetColor(p1.Name)
		Part.Anchored = true
		Part.CFrame = CFrame.new()
		return Part
	end,
	Update = Update
}