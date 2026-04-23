-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local CameraConsts = require(script.Parent.CameraConsts)
local t = {}
t.__index = t
function t.new(p1, p2)
	local t2 = {}
	setmetatable(t2, t)
	t2.obj = p1
	t2._maid = Maid.new()
	t2._maid:GiveTask(p2.spotRemote.OnClientEvent:Connect(function(p1)
		if p1.isViewer then
			local v1 = Players:GetPlayerFromCharacter(p1.spottedCharacter)
			if v1 then
				v1:SetAttribute("CCTVSpotted", true)
				task.delay(CameraConsts.SPOT_DURATION, function()
					v1:SetAttribute("CCTVSpotted", false)
				end)
			end
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 8274149535, {
				Volume = 0.5,
				RollOffMinDistance = 16,
				RollOffMaxDistance = 128
			})
		end
	end))
	return t2
end
function t.Damage(p1)
	p1.obj:FindFirstChild("DamageRemote"):FireServer()
end
function t.Spot(p1, p2)
	p1.obj:FindFirstChild("SpotRemote"):FireServer(p2)
end
function t.Destroy(p1)
	p1._maid:Destroy()
	setmetatable(p1, nil)
end
return ManifestBinder.new("CCTVCamera", {
	spotRemote = "SpotRemote"
}, t)