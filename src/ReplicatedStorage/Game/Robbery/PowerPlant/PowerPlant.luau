-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binder = require(ReplicatedStorage.Std.Binder)
local Time = require(ReplicatedStorage.Module.Time)
local Audio = require(ReplicatedStorage.Std.Audio)
local LocalPlayer = game:GetService("Players").LocalPlayer
local function Round(p1)
	return math.floor(p1 / 50 + 0.5) * 50
end
local function comma(p1)
	local v1, v2, v3 = string.match(p1, "^([^%d]*%d)(%d*)(.-)$")
	return v1 .. v2:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v3
end
return {
	Init = function(p1)
		local _ = p1.Event
		local em = p1.em
		local v1 = Audio.ObjectLocal(LocalPlayer.PlayerGui, 3280045064, {
			Looped = true,
			DoNotPlay = true
		})
		local v2 = Audio.ObjectLocal(LocalPlayer.PlayerGui, 1836781594, {
			Looped = true,
			DoNotPlay = true
		})
		v2.SoundGroup = game:GetService("SoundService").RobberyMusic
		local PowerPlantRobberyGui = ReplicatedStorage.Resource.Robbery.PowerPlant.PowerPlantRobberyGui
		local v3 = nil
		local v4 = false
		local function StartRuntime()
			while v4 do
				local v32 = math.sqrt(1 - math.clamp((Time.GetNowSync() - v3.CollectedAt) / v3.Timeout, 0, 1))
				PowerPlantRobberyGui.Price.Value.Size = UDim2.new(v32, 0, 1, 0)
				local v6, v7, v8 = string.match(math.floor(v3.BaseWorth * v32 / 50 + 0.5) * 50, "^([^%d]*%d)(%d*)(.-)$")
				PowerPlantRobberyGui.Price.TextLabel.Text = ("Uranium Value: $%s"):format(v6 .. v7:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v8)
				wait(0.1)
			end
		end
		local function Show()
			assert(v4 == false)
			v4 = true
			PowerPlantRobberyGui.Parent = LocalPlayer.PlayerGui
			spawn(StartRuntime)
		end
		local function Hide()
			assert(v4 == true)
			PowerPlantRobberyGui.Parent = nil
			v4 = false
		end
		Binder.new("PowerPlantCore", require(script.Parent.Core)):Start()
		local v5 = nil
		function em.kvcs1mf0()
			Audio.ObjectLocal(LocalPlayer, 1837831244)
			delay(1, function()
				Audio.ObjectLocal(LocalPlayer, 1843025542)
			end)
			v1.Volume = 0
			v1:Play()
			Audio.FadeTo(v1, 0.3, 2)
			if v5 ~= nil then
				v5:Disconnect()
				v5 = nil
			end
			v2.Volume = 0
			v2:Play()
			v5 = Audio.FadeTo(v2, 0.3, 2)
		end
		function em.ffymvi2b()
			if v5 ~= nil then
				v5:Disconnect()
				v5 = nil
			end
			Audio.FadeTo(v1, 0, 2, function()
				v1:Stop()
			end)
			if v4 == false then
				v5 = Audio.FadeTo(v2, 0, 2, function()
					v2:Stop()
				end)
			end
		end
		function em.i544lupv(p1)
			Audio.ObjectLocal(LocalPlayer, 3280045717)
			v3 = p1
			assert(v4 == false)
			v4 = true
			PowerPlantRobberyGui.Parent = LocalPlayer.PlayerGui
			spawn(StartRuntime)
		end
		function em.q6l39vgi()
			Audio.ObjectLocal(script, 1988476450)
		end
		function em.uz8khf2b()
			Audio.FadeTo(v2, 0, 2, function()
				v2:Stop()
			end)
			if v4 == true then
				assert(v4 == true)
				PowerPlantRobberyGui.Parent = nil
				v4 = false
			end
		end
		Binder.new("Piston", require(script.Parent.Piston)):Start()
	end
}
