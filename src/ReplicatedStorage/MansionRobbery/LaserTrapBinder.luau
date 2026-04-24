-- Reviewed by Claude
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local DoorUtils = require(ReplicatedStorage.Door2.DoorUtils)
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1, p2)
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	v1._flashing = false
	v1.buttonsModel = nil
	v1.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(p1, "Buttons", function(p12, p22)
		v1.buttonsModel = p12
		p22:GiveTask(RxInstanceUtils.observeChildren(p12, function(p12, p22)
			p22:GivePromise(DoorUtils.promiseInnerModel(p12):andThen(function(p1)
				return RxInstanceUtils.waitForChild(p1, "Touch")
			end):andThen(function(p12)
				local v12 = os.clock()
				p22:GiveTask(p12.Touched:Connect(function(p12)
					local v13 = CharacterUtils.getAncestorPartHumanoid(p12)
					if v13 and (v13.Parent == Players.LocalPlayer.Character and v13:GetLimb(p12) ~= Enum.Limb.Unknown) then
						local v2 = os.clock()
						if not (v2 - v12 < 1 or v1._flashing) then
							v12 = v2
							v13:TakeDamage((assert(p1:GetAttribute("LaserTrapDamage"), "missing LaserTrapDamage")))
							p2.replicateRemote:FireServer()
							v1:_flicker()
						end
					end
				end))
			end))
		end))
	end))
	v1.maid:GiveTask(p2.replicateRemote.OnClientEvent:Connect(function()
		v1:_flicker()
	end))
	return v1
end
function t._setPartsVisible(p1, p2)
	local Lasers = p1.obj:FindFirstChild("Lasers")
	for v1, v2 in assert(Lasers, "no lasersModel exists"):GetChildren() do
		if p2 then
			v2.CanTouch = true
			v2.Transparency = 0.2
		else
			v2.CanTouch = false
			v2.Transparency = 1
		end
	end
end
function t._setTouchPartsTriggered(p1)
	local t = {}
	local t2 = {}
	for v1, v2 in p1.buttonsModel:GetChildren() do
		local Touch = DoorUtils.getInnerModel(v2):FindFirstChild("Touch")
		t[Touch] = Touch.Transparency
		t2[Touch] = Touch.Color
		Touch.Transparency = 0
		Touch.Color = Color3.new(0.9, 0, 0)
	end
	return function()
		for v1, v2 in t do
			v1.Transparency = v2
		end
		for v3, v4 in t2 do
			v3.Color = v4
		end
	end
end
function t._flicker(p1)
	if not p1._flashing then
		p1._flashing = true
		Audio.ObjectLocal(p1.obj:FindFirstChild("SoundPart"), 11793588989, {
			Volume = 1
		})
		local v1 = p1:_setTouchPartsTriggered()
		for i = 0, 6 do
			local v2
			v2 = i % 2 == 0
			p1:_setPartsVisible(v2)
			local v3 = os.clock()
			repeat
				RunService.Heartbeat:Wait()
			until 0.7777777777777778 ^ (6 - i) * 0.06666666666666667 <= os.clock() - v3
		end
		p1:_setPartsVisible(true)
		task.wait(2)
		p1:_setPartsVisible(false)
		v1()
		p1._flashing = false
	end
end
return ManifestBinder.new("LaserTrap", {
	replicateRemote = "ReplicateRemote"
}, t)
