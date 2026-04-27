local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local t = {}
function t.init()
	local clubMusic = nil
	local fadePromise = nil
	Players.LocalPlayer:GetAttributeChangedSignal("NightclubMusicPlaying"):Connect(function()
		if fadePromise then
			fadePromise:cancel()
			fadePromise = nil
		end
		if clubMusic then
			local oldMusic = clubMusic
			clubMusic = nil
			Audio.promiseFadeTo(oldMusic, 0, 3):finally(function()
				oldMusic:Destroy()
			end)
		end
		if t.isMusicPlaying() then
			clubMusic = Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 1839822990, {
				Looped = true,
				Volume = 0
			})
			clubMusic.SoundGroup = game:GetService("SoundService"):FindFirstChild("RobberyMusic")
			clubMusic.Name = "ClubMusic"
			local ReverbSoundEffect = Instance.new("ReverbSoundEffect")
			ReverbSoundEffect.Enabled = t.isMusicMuffled()
			ReverbSoundEffect.DecayTime = 5
			ReverbSoundEffect.Parent = clubMusic
			fadePromise = Audio.promiseFadeTo(clubMusic, 0.4, 3):finally(function()
				fadePromise = nil
			end)
		end
	end)
	Players.LocalPlayer:GetAttributeChangedSignal("NightclubMusicMuffled"):Connect(function()
		if fadePromise then
			fadePromise:cancel()
			fadePromise = nil
		end
		if clubMusic then
			fadePromise = Audio.promiseFadeTo(clubMusic, if t.isMusicMuffled() then 0.04000000000000001 else 0.4, 0.1):finally(function()
				fadePromise = nil
			end)
			clubMusic:FindFirstChild("ReverbSoundEffect").Enabled = t.isMusicMuffled()
		end
	end)
end
function t.isMusicPlaying()
	return Players.LocalPlayer:GetAttribute("NightclubMusicPlaying") == true
end
function t.isMusicMuffled()
	return Players.LocalPlayer:GetAttribute("NightclubMusicMuffled") == true
end
return t