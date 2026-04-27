local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	Items = {
		{
			Hidden = true,
			Name = "Rainboom"
		},
		{
			Hidden = false,
			Level = 7,
			Name = "DarkMatter",
			Season = 31,
			SeasonIconId = 119466384682779
		},
		{
			Hidden = false,
			Level = 9,
			Name = "Nemesis",
			Season = 30,
			SeasonIconId = 106328403217323
		},
		{
			Hidden = true,
			Name = "Subspace"
		},
		{
			Hidden = false,
			Level = 7,
			Name = "Bloxxer",
			Season = 29,
			SeasonIconId = 92221239322926
		},
		{
			Hidden = false,
			Level = 7,
			Name = "Neo-Static",
			Season = 28,
			SeasonIconId = 84565197392670
		},
		{
			Hidden = false,
			Level = 7,
			Name = "Oceanwater",
			Season = 27,
			SeasonIconId = 71904712185207
		},
		{
			Hidden = false,
			Level = 5,
			Name = "JungleVine",
			Season = 26,
			SeasonIconId = 100303922899660
		},
		{
			Hidden = false,
			Name = "Bananas"
		},
		{
			Name = "PixelCoin",
			Season = 25,
			TopPct = 2,
			SeasonIconId = 89348508605786
		},
		{
			Hidden = false,
			Level = 7,
			Name = "IceSpike",
			Season = 24,
			SeasonIconId = 109523291060501
		},
		{
			Hidden = false,
			Level = 2,
			Name = "Synth",
			Season = 23,
			SeasonIconId = 101628751021692
		},
		{
			Hidden = false,
			Name = "ShootingStar",
			Season = 22,
			SeasonIconId = 18128199222,
			TopPct = 2
		},
		{
			Season = 21,
			TopPct = 2,
			Name = "OGFuel",
			SeasonIconId = 17124571638
		},
		{
			Hidden = false,
			Level = 7,
			Name = "Spark",
			Season = 20,
			SeasonIconId = 16176420491
		},
		{
			Hidden = false,
			Name = "Aurora",
			TopPct = 2,
			Season = 19,
			SeasonIconId = 15624648971
		},
		{
			Name = "Cosmic",
			Price = 120000
		},
		{
			Name = "Classic",
			Price = 0
		},
		{
			Name = "Performance",
			Price = 25000
		},
		{
			Name = "Cartoon",
			Price = 35000
		},
		{
			Name = "Pixel",
			Price = 75000
		},
		{
			Name = "Lightning",
			Price = 400000
		},
		{
			Name = "MagicPurple",
			Price = 100000
		},
		{
			Name = "Flamethrower",
			Price = 300000
		},
		{
			Name = "Melons",
			Price = 25000
		},
		{
			Name = "BubbleWand",
			Price = 45000
		},
		{
			Name = "BlueFire",
			Hidden = true
		},
		{
			Name = "GradientPixel",
			Hidden = true
		},
		{
			Name = "Brickset",
			Hidden = true
		}
	},
	GetInstance = function(driftItem)
		local particleClone = ReplicatedStorage.Resource:FindFirstChild("DriftParticles"):FindFirstChild(driftItem.Name):Clone()
		particleClone:FindFirstChildOfClass("ParticleEmitter")
		particleClone.CFrame = CFrame.new()
		particleClone.Size = particleClone.Size * (5.2 / particleClone.Size.Magnitude)
		return particleClone
	end,
	Update = function(instance, unused)
		local rotationTime = os.clock() / 2
		instance.CFrame = CFrame.Angles(0, rotationTime % 6.283185307179586, 0) * CFrame.Angles(math.sin(rotationTime) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, 5)
	end
}
