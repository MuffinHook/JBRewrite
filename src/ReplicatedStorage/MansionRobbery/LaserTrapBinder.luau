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
function t.new(self, p2)
	local instance = BaseObject.new(self)
	setmetatable(instance, t)
	instance._flashing = false
	instance.buttonsModel = nil
	instance.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(self, "Buttons", function(p12, p22)
		instance.buttonsModel = p12
		p22:GiveTask(RxInstanceUtils.observeChildren(p12, function(p12, p22)
			p22:GivePromise(DoorUtils.promiseInnerModel(p12):andThen(function(self)
				return RxInstanceUtils.waitForChild(self, "Touch")
			end):andThen(function(p12)
				local var12 = os.clock()
				p22:GiveTask(p12.Touched:Connect(function(p12)
					local var13 = CharacterUtils.getAncestorPartHumanoid(p12)
					if var13 and (var13.Parent == Players.LocalPlayer.Character and var13:GetLimb(p12) ~= Enum.Limb.Unknown) then
						local v2 = os.clock()
						if not (v2 - var12 < 1 or instance._flashing) then
							var12 = v2
							var13:TakeDamage((assert(self:GetAttribute("LaserTrapDamage"), "missing LaserTrapDamage")))
							p2.replicateRemote:FireServer()
							instance:_flicker()
						end
					end
				end))
			end))
		end))
	end))
	instance.maid:GiveTask(p2.replicateRemote.OnClientEvent:Connect(function()
		instance:_flicker()
	end))
	return instance
end
function t._setPartsVisible(self, p2)
	local Lasers = self.obj:FindFirstChild("Lasers")
	for instance, v2 in assert(Lasers, "no lasersModel exists"):GetChildren() do
		if p2 then
			v2.CanTouch = true
			v2.Transparency = 0.2
		else
			v2.CanTouch = false
			v2.Transparency = 1
		end
	end
end
function t._setTouchPartsTriggered(self)
	local t = {}
	local t2 = {}
	for instance, v2 in self.buttonsModel:GetChildren() do
		local Touch = DoorUtils.getInnerModel(v2):FindFirstChild("Touch")
		t[Touch] = Touch.Transparency
		t2[Touch] = Touch.Color
		Touch.Transparency = 0
		Touch.Color = Color3.new(0.9, 0, 0)
	end
	return function()
		for instance, v2 in t do
			instance.Transparency = v2
		end
		for var3, v4 in t2 do
			var3.Color = v4
		end
	end
end
function t._flicker(self)
	if not self._flashing then
		self._flashing = true
		Audio.ObjectLocal(self.obj:FindFirstChild("SoundPart"), 11793588989, {
			Volume = 1
		})
		local instance = self:_setTouchPartsTriggered()
		for i = 0, 6 do
			local v2
			v2 = i % 2 == 0
			self:_setPartsVisible(v2)
			local var3 = os.clock()
			repeat
				RunService.Heartbeat:Wait()
			until 0.7777777777777778 ^ (6 - i) * 0.06666666666666667 <= os.clock() - var3
		end
		self:_setPartsVisible(true)
		task.wait(2)
		self:_setPartsVisible(false)
		instance()
		self._flashing = false
	end
end
return ManifestBinder.new("LaserTrap", {
	replicateRemote = "ReplicateRemote"
}, t)
