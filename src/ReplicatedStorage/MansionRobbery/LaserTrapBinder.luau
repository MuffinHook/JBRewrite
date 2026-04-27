local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local DoorUtils = require(ReplicatedStorage.Door2.DoorUtils)
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local LaserTrapClass = {}
LaserTrapClass.__index = LaserTrapClass
setmetatable(LaserTrapClass, BaseObject)
function LaserTrapClass.new(self, binderConfig)
	local instance = BaseObject.new(self)
	setmetatable(instance, LaserTrapClass)
	instance._flashing = false
	instance.buttonsModel = nil
	instance.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(self, "Buttons", function(buttonsModelChild, buttonsMaid)
		instance.buttonsModel = buttonsModelChild
		buttonsMaid:GiveTask(RxInstanceUtils.observeChildren(buttonsModelChild, function(buttonChild, buttonMaid)
			buttonMaid:GivePromise(DoorUtils.promiseInnerModel(buttonChild):andThen(function(self)
				return RxInstanceUtils.waitForChild(self, "Touch")
			end):andThen(function(touchPart)
				local lastTouchTime = os.clock()
				buttonMaid:GiveTask(touchPart.Touched:Connect(function(hit)
					local characterHumanoid = CharacterUtils.getAncestorPartHumanoid(hit)
					if characterHumanoid and (characterHumanoid.Parent == Players.LocalPlayer.Character and characterHumanoid:GetLimb(hit) ~= Enum.Limb.Unknown) then
						local currentTime = os.clock()
						if not (currentTime - lastTouchTime < 1 or instance._flashing) then
							lastTouchTime = currentTime
							characterHumanoid:TakeDamage((assert(self:GetAttribute("LaserTrapDamage"), "missing LaserTrapDamage")))
							binderConfig.replicateRemote:FireServer()
							instance:_flicker()
						end
					end
				end))
			end))
		end))
	end))
	instance.maid:GiveTask(binderConfig.replicateRemote.OnClientEvent:Connect(function()
		instance:_flicker()
	end))
	return instance
end
function LaserTrapClass._setPartsVisible(self, shouldBeVisible)
	local Lasers = self.obj:FindFirstChild("Lasers")
	for instance, laserPart in assert(Lasers, "no lasersModel exists"):GetChildren() do
		if shouldBeVisible then
			laserPart.CanTouch = true
			laserPart.Transparency = 0.2
		else
			laserPart.CanTouch = false
			laserPart.Transparency = 1
		end
	end
end
function LaserTrapClass._setTouchPartsTriggered(self)
	local originalTransparencies = {}
	local originalColors = {}
	for instance, buttonChild in self.buttonsModel:GetChildren() do
		local Touch = DoorUtils.getInnerModel(buttonChild):FindFirstChild("Touch")
		originalTransparencies[Touch] = Touch.Transparency
		originalColors[Touch] = Touch.Color
		Touch.Transparency = 0
		Touch.Color = Color3.new(0.9, 0, 0)
	end
	return function()
		for touchPart, originalTransparency in originalTransparencies do
			touchPart.Transparency = originalTransparency
		end
		for touchPart, originalColor in originalColors do
			touchPart.Color = originalColor
		end
	end
end
function LaserTrapClass._flicker(self)
	if not self._flashing then
		self._flashing = true
		Audio.ObjectLocal(self.obj:FindFirstChild("SoundPart"), 11793588989, {
			Volume = 1
		})
		local restoreFunction = self:_setTouchPartsTriggered()
		for i = 0, 6 do
			local isLaserOn
			isLaserOn = i % 2 == 0
			self:_setPartsVisible(isLaserOn)
			local flickerStartTime = os.clock()
			repeat
				RunService.Heartbeat:Wait()
			until 0.7777777777777778 ^ (6 - i) * 0.06666666666666667 <= os.clock() - flickerStartTime
		end
		self:_setPartsVisible(true)
		task.wait(2)
		self:_setPartsVisible(false)
		restoreFunction()
		self._flashing = false
	end
end
return ManifestBinder.new("LaserTrap", {
	replicateRemote = "ReplicateRemote"
}, LaserTrapClass)
