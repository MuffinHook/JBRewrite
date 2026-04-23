local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local t = {}
function t.init() --[[ Line: 8 | Upvalues: Players (copy), Audio (copy), t (copy) ]]
	local v1 = nil
	local v2 = nil
	Players.LocalPlayer:GetAttributeChangedSignal("NightclubMusicPlaying"):Connect(function() --[[ Line: 11 | Upvalues: v2 (ref), v1 (ref), Audio (ref), t (ref), Players (ref) ]]
		if v2 then
			v2:cancel()
			v2 = nil
		end
		if v1 then
			local v12 = v1
			v1 = nil
			Audio.promiseFadeTo(v12, 0, 3):finally(function() --[[ Line: 19 | Upvalues: v12 (copy) ]]
				v12:Destroy()
			end)
		end
		if t.isMusicPlaying() then
			v1 = Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 1839822990, {
				Looped = true,
				Volume = 0
			})
			v1.SoundGroup = game:GetService("SoundService"):FindFirstChild("RobberyMusic")
			v1.Name = "ClubMusic"
			local ReverbSoundEffect = Instance.new("ReverbSoundEffect")
			ReverbSoundEffect.Enabled = t.isMusicMuffled()
			ReverbSoundEffect.DecayTime = 5
			ReverbSoundEffect.Parent = v1
			v2 = Audio.promiseFadeTo(v1, 0.4, 3):finally(function() --[[ Line: 31 | Upvalues: v2 (ref) ]]
				v2 = nil
			end)
		end
	end)
	Players.LocalPlayer:GetAttributeChangedSignal("NightclubMusicMuffled"):Connect(function() --[[ Line: 36 | Upvalues: v2 (ref), v1 (ref), Audio (ref), t (ref) ]]
		if v2 then
			v2:cancel()
			v2 = nil
		end
		if v1 then
			v2 = Audio.promiseFadeTo(v1, if t.isMusicMuffled() then 0.04000000000000001 else 0.4, 0.1):finally(function() --[[ Line: 47 | Upvalues: v2 (ref) ]]
				v2 = nil
			end)
			v1:FindFirstChild("ReverbSoundEffect").Enabled = t.isMusicMuffled()
		end
	end)
end
function t.isMusicPlaying() --[[ Line: 56 | Upvalues: Players (copy) ]]
	return Players.LocalPlayer:GetAttribute("NightclubMusicPlaying") == true
end
function t.isMusicMuffled() --[[ Line: 59 | Upvalues: Players (copy) ]]
	return Players.LocalPlayer:GetAttribute("NightclubMusicMuffled") == true
end
return t