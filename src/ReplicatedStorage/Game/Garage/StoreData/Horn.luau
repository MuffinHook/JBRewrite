local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local function GetInstance(p1)
	local hornVisual = ReplicatedStorage.Resource:FindFirstChild("GarageHornVisual"):Clone()
	hornVisual:PivotTo(CFrame.new(0, 0, 0))
	return hornVisual
end
local function Update(hornInstance, vehicleModel)
	local elapsedTime = os.clock() / 2
	hornInstance.CFrame = CFrame.Angles(0, elapsedTime % 6.283185307179586, 0) * CFrame.Angles(math.sin(elapsedTime) * 0.1 - 0.3, 0, 0) * CFrame.new(0, 0, vehicleModel.PrimaryPart.Size.Magnitude)
end
local currentAudio = nil
return {
	Items = {
		{
			Name = "Sendoff",
			SoundId = 12616040786,
			Price = 25000
		},
		{
			Name = "Ahooga",
			SoundId = 12616042121,
			Price = 25000
		},
		{
			Name = "Airhorn",
			SoundId = 12616043274,
			Price = 35000
		},
		{
			Name = "Cruiseliner",
			SoundId = 12616044246,
			Price = 10000
		},
		{
			Name = "Bicycle",
			SoundId = 12616045116,
			Price = 2500
		},
		{
			Name = "FireBrigade",
			SoundId = 12616045912,
			Price = 5000,
			Looped = true
		},
		{
			Name = "Quack",
			SoundId = 12616046852,
			Price = 35000
		},
		{
			Name = "City",
			SoundId = 12616048429,
			Price = 2500,
			Looped = true
		},
		{
			Name = "Steamer",
			SoundId = 12616049198,
			Price = 15000,
			Looped = true
		},
		{
			Name = "MeepMeep",
			SoundId = 12616050969,
			Price = 12500
		},
		{
			Name = "ChampionTrumpets",
			SoundId = 12413440203,
			Loopable = true,
			Season = 14,
			TopPct = 2,
			SeasonIconId = 12424991433
		},
		{
			Name = "Winner",
			SoundId = 11183684353,
			Loopable = false,
			Season = 12,
			TopPct = 2,
			SeasonIconId = 11183663452
		},
		{
			Name = "Cucaracha",
			SoundId = 9316479741,
			Loopable = false,
			Season = 9,
			TopPct = 5
		},
		{
			Name = "Original",
			SoundId = 9058828003,
			Loopable = true,
			MaxPlaybackTime = 1,
			Price = 0
		},
		{
			Name = "Realistic",
			SoundId = 8990467635,
			Price = 5000,
			Loopable = true
		},
		{
			Name = "Train",
			SoundId = 8990467123,
			Price = 25000,
			Loopable = false
		},
		{
			Name = "Clown",
			SoundId = 8990466434,
			Price = 20000,
			Loopable = false
		},
		{
			Name = "DropWeapons",
			SoundId = 8990461116,
			Price = 30000,
			Loopable = false
		},
		{
			Name = "RumbleSiren",
			SoundId = 9058366741,
			Price = 10000,
			Loopable = true
		},
		{
			Name = "Countdown",
			SoundId = 8990459885,
			Price = 5000,
			Loopable = false,
			MaxPlaybackTime = 3.5
		},
		{
			Name = "Injan",
			SoundId = 739735604,
			Loopable = true,
			Hidden = true,
			NoTrade = true
		}
	},
	GetInstance = GetInstance,
	Update = Update,
	onItemSelected = function(hornItem)
		if currentAudio then
			currentAudio:Destroy()
			currentAudio = nil
		end
		if Players.LocalPlayer then
			local audioConfig = {
				Volume = 0.25
			}
			if hornItem.MaxPlaybackTime then
				audioConfig.MaxPlaybackTime = hornItem.MaxPlaybackTime
			end
			currentAudio = Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, hornItem.SoundId, audioConfig)
		end
	end
}
