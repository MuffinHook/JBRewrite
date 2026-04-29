local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local Time = require(ReplicatedStorage.Module.Time)
local Audio = require(ReplicatedStorage.Std.Audio)
local LocalPlayer = game:GetService("Players").LocalPlayer
local function Round(value)
	return math.floor(value / 50 + 0.5) * 50
end
local function comma(currencyText)
	local currencyPrefix, mainDigits, currencySuffix = string.match(currencyText, "^([^%d]*%d)(%d*)(.-)$")
	return currencyPrefix .. mainDigits:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. currencySuffix
end
return {
	Init = function(config)
		local _ = config.Event
		local eventManager = config.em
		local ambientSound = Audio.ObjectLocal(LocalPlayer.PlayerGui, 3280045064, {
			Looped = true,
			DoNotPlay = true
		})
		local musicSound = Audio.ObjectLocal(LocalPlayer.PlayerGui, 1836781594, {
			Looped = true,
			DoNotPlay = true
		})
		musicSound.SoundGroup = game:GetService("SoundService").RobberyMusic
		local PowerPlantRobberyGui = ReplicatedStorage.Resource.Robbery.PowerPlant.PowerPlantRobberyGui
		local robberyData = nil
		local isRunning = false
		local function StartRuntime()
			while isRunning do
				local progressFraction = math.sqrt(1 - math.clamp((Time.GetNowSync() - robberyData.CollectedAt) / robberyData.Timeout, 0, 1))
				PowerPlantRobberyGui.Price.Value.Size = UDim2.new(progressFraction, 0, 1, 0)
				local currencyPrefix, mainDigits, currencySuffix = string.match(math.floor(robberyData.BaseWorth * progressFraction / 50 + 0.5) * 50, "^([^%d]*%d)(%d*)(.-)$")
				PowerPlantRobberyGui.Price.TextLabel.Text = ("Uranium Value: $%s"):format(currencyPrefix .. mainDigits:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. currencySuffix)
				task.wait(0.1)
			end
		end
		local function Show()
			assert(isRunning == false)
			isRunning = true
			PowerPlantRobberyGui.Parent = LocalPlayer.PlayerGui
			task.spawn(StartRuntime)
		end
		local function Hide()
			assert(isRunning == true)
			PowerPlantRobberyGui.Parent = nil
			isRunning = false
		end
		Binder.new("PowerPlantCore", require(script.Parent.Core)):Start()
		local musicFadeConnection = nil
		function eventManager.kvcs1mf0()
			Audio.ObjectLocal(LocalPlayer, 1837831244)
			task.delay(1, function()
				Audio.ObjectLocal(LocalPlayer, 1843025542)
			end)
			ambientSound.Volume = 0
			ambientSound:Play()
			Audio.FadeTo(ambientSound, 0.3, 2)
			if musicFadeConnection ~= nil then
				musicFadeConnection:Disconnect()
				musicFadeConnection = nil
			end
			musicSound.Volume = 0
			musicSound:Play()
			musicFadeConnection = Audio.FadeTo(musicSound, 0.3, 2)
		end
		function eventManager.ffymvi2b()
			if musicFadeConnection ~= nil then
				musicFadeConnection:Disconnect()
				musicFadeConnection = nil
			end
			Audio.FadeTo(ambientSound, 0, 2, function()
				ambientSound:Stop()
			end)
			if isRunning == false then
				musicFadeConnection = Audio.FadeTo(musicSound, 0, 2, function()
					musicSound:Stop()
				end)
			end
		end
		function eventManager.i544lupv(newRobberyData)
			Audio.ObjectLocal(LocalPlayer, 3280045717)
			robberyData = newRobberyData
			assert(isRunning == false)
			isRunning = true
			PowerPlantRobberyGui.Parent = LocalPlayer.PlayerGui
			task.spawn(StartRuntime)
		end
		function eventManager.q6l39vgi()
			Audio.ObjectLocal(script, 1988476450)
		end
		function eventManager.uz8khf2b()
			Audio.FadeTo(musicSound, 0, 2, function()
				musicSound:Stop()
			end)
			if isRunning == true then
				assert(isRunning == true)
				PowerPlantRobberyGui.Parent = nil
				isRunning = false
			end
		end
		Binder.new("Piston", require(script.Parent.Piston)):Start()
	end
}
