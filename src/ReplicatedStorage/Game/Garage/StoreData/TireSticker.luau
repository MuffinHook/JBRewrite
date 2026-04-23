-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local function GetInstance(p1)
	local v1 = ReplicatedStorage.Resource.TireMesh.Classic:Clone()
	v1.Color = Color3.fromRGB(27, 42, 53)
	v1.CFrame = CFrame.new(0, 0, 0)
	if p1.TextureId then
		local Decal = Instance.new("Decal")
		Decal.Color3 = Color3.new(255/255, 255/255, 255/255)
		Decal.Face = Enum.NormalId.Left
		Decal.Texture = ("rbxassetid://%d"):format(p1.TextureId)
		Decal.Parent = v1
		local v2 = Decal:Clone()
		v2.Face = Enum.NormalId.Right
		v2.Parent = v1
	end
	return v1
end
local function Update(p1, p2)
	local v1 = os.clock() / 2
	p1.CFrame = CFrame.Angles(0, v1 % 6.283185307179586, 0) * CFrame.Angles(math.sin(v1) * 0.5, 0, 0) * CFrame.new(0, 0, 3)
end
return {
	Items = {
		{
			Name = "None",
			None = true,
			Price = 0
		},
		{
			Hidden = false,
			Level = 4,
			Name = "Freestyle",
			Season = 31,
			SeasonIconId = 125717124783689,
			TextureId = 116084653276456,
			DecalColor = Color3.fromRGB(550, 550, 550)
		},
		{
			Hidden = false,
			Level = 6,
			Name = "Thing",
			Season = 30,
			SeasonIconId = 117353997941511,
			TextureId = 111670818792258,
			ParticleEmitterName = "ThingEye"
		},
		{
			Hidden = true,
			Name = "SFOTH",
			TextureId = 81179022446973
		},
		{
			Hidden = true,
			Name = "Jade Glow",
			TextureId = 132935954538704,
			DecalColor = Color3.fromRGB(400, 400, 400),
			ParticleEmitterName = "Jade Glow"
		},
		{
			Hidden = false,
			Name = "Arch9000 Glow",
			Season = 28,
			SeasonIconId = 133543455682527,
			TopPct = 2,
			TextureId = 85610868330121,
			DecalColor = Color3.fromRGB(1100, 1100, 1100)
		},
		{
			Hidden = false,
			Name = "Laughability",
			Price = 1000,
			TextureId = 96222634650634
		},
		{
			Hidden = false,
			Level = 2,
			Name = "Skull and Sails",
			Season = 27,
			SeasonIconId = 91123857834622,
			TextureId = 110455550912661
		},
		{
			Hidden = false,
			Name = "JungleMosaic",
			TextureId = 75179887470638
		},
		{
			Hidden = false,
			Name = "HungrySnake",
			Price = 10000,
			TextureId = 77077395924787
		},
		{
			Hidden = false,
			Name = "InsertCoin",
			Price = 5000,
			TextureId = 137450551525784
		},
		{
			Hidden = true,
			Name = "80sStyle",
			TextureId = 104933668638785,
			Price = 20000
		},
		{
			Hidden = false,
			Name = "USA",
			TextureId = 18123665440,
			Price = 50000
		},
		{
			Hidden = false,
			Name = "Radar",
			TextureId = 16573961533,
			Price = 30000
		},
		{
			Name = "FlatBlack",
			TextureId = 14609079831,
			Price = 1000
		},
		{
			Name = "DenisDaily",
			TextureId = 14585660769,
			Price = 20000
		},
		{
			Name = "HelloItsVG",
			TextureId = 14585662515,
			Hidden = true
		},
		{
			Name = "KraoESP",
			TextureId = 14585842568,
			Price = 20000
		},
		{
			Name = "NoobFreak",
			TextureId = 14585985422,
			Hidden = true
		},
		{
			Level = 2,
			Name = "FlagsOfEurope",
			Season = 17,
			SeasonIconId = 14279334103,
			TextureId = 14089718693
		},
		{
			Name = "Parisian",
			Price = 12500,
			TextureId = 13967076673
		},
		{
			Name = "LeapYear",
			Price = 25000,
			TextureId = 13967069021
		},
		{
			Level = 2,
			Name = "Buoy",
			Season = 16,
			SeasonIconId = 13686301553,
			TextureId = 13368710799
		},
		{
			Name = "Kanagawa",
			Season = 15,
			SeasonIconId = 12995659973,
			TextureId = 12990798822,
			TopPct = 2
		},
		{
			Level = 2,
			Name = "Tokyo",
			Season = 15,
			SeasonIconId = 12995656462,
			TextureId = 12990797334
		},
		{
			Name = "NASCAR75th",
			Hidden = true,
			Price = 10000,
			TextureId = 12716298199
		},
		{
			Level = 2,
			Name = "Champion",
			Season = 14,
			SeasonIconId = 12424992113,
			TextureId = 12445064520
		},
		{
			Level = 3,
			Name = "JailbreakArmy",
			Season = 12,
			SeasonIconId = 11183659975,
			TextureId = 11468152944
		},
		{
			Name = "Phindr",
			Price = 20000,
			TextureId = 10571050587
		},
		{
			Name = "DatBrian",
			Price = 20000,
			TextureId = 10571069842
		},
		{
			Name = "Badonuts",
			TextureId = 10504917478,
			Price = 35000
		},
		{
			Name = "Construction",
			TextureId = 10504946879,
			Price = 60000
		},
		{
			Name = "Tracer",
			TextureId = 10547219411,
			Price = 35000
		},
		{
			Name = "Japanese",
			TextureId = 11468148224,
			Hidden = true
		},
		{
			Name = "Speed",
			TextureId = 10505176338,
			Price = 50000
		},
		{
			Name = "Lightning",
			TextureId = 10301564556,
			Price = 190000,
			ParticleEmitterName = "Lightning"
		},
		{
			Name = "MCL36",
			TextureId = 8794704567,
			Hidden = true,
			Makes = {
				MCL36 = true,
				MCL36FREE = true
			},
			NoTrade = true
		},
		{
			Name = "NASCAR",
			Price = 20000,
			TextureId = 7845787897,
			Hidden = true,
			NoTrade = true
		},
		{
			Name = "JBMS",
			Price = 20000,
			TextureId = 7384277328
		},
		{
			Name = "3Billion",
			Price = 10000,
			TextureId = 3951577235,
			Hidden = true
		},
		{
			Name = "Red50",
			Price = 10000,
			TextureId = 3344146546,
			PrisonerLevel = 50,
			Hidden = true
		},
		{
			Name = "Blue50",
			Price = 10000,
			TextureId = 3344146243,
			PoliceLevel = 50,
			Hidden = true
		},
		{
			Name = "RedS3",
			Price = 10000,
			TextureId = 3344137698,
			PrisonerLevel = 10,
			Hidden = true
		},
		{
			Name = "BlueS3",
			Price = 10000,
			TextureId = 3344137974,
			PoliceLevel = 10,
			Hidden = true
		},
		{
			Name = "Line",
			Price = 20000,
			TextureId = 3180643719
		},
		{
			Name = "Police",
			Price = 20000,
			TextureId = 10570746633
		},
		{
			Name = "Criminal",
			Price = 20000,
			TextureId = 10570745610
		},
		{
			Name = "Thin",
			Price = 20000,
			TextureId = 10570744617
		},
		{
			Name = "Jailbreak",
			Price = 20000,
			TextureId = 10570746107
		},
		{
			Name = "KreekCraft",
			Price = 20000,
			TextureId = 3183200203
		},
		{
			Name = "MyUsernamesThis",
			Price = 20000,
			TextureId = 3183131434
		},
		{
			Name = "CrashNation",
			Price = 20000,
			TextureId = 3765524019
		}
	},
	GetInstance = GetInstance,
	Update = Update
}