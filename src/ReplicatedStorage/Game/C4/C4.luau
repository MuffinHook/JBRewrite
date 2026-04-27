local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(script.Parent.C4Utils)
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
require(ReplicatedStorage.Game.CamShaker.CamShaker)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Promise = require(ReplicatedStorage.Std.Promise)
local C4Consts = require(script.Parent.C4Consts)
local function closestPointToPart(pointPosition, targetPart)
	local partCFrame = targetPart.CFrame
	local objectSpacePoint = partCFrame:PointToObjectSpace(pointPosition)
	return partCFrame * Vector3.new(math.clamp(objectSpacePoint.X, -targetPart.Size.X * 0.5, targetPart.Size.X * 0.5), math.clamp(objectSpacePoint.Y, -targetPart.Size.Y * 0.5, targetPart.Size.Y * 0.5), (math.clamp(objectSpacePoint.Z, -targetPart.Size.Z * 0.5, targetPart.Size.Z * 0.5)))
end
local C4Class = {}
C4Class.__index = C4Class
C4Class.__ClassName = "C4"
setmetatable(C4Class, BaseObject)
function C4Class.new(c4Instance)
	local self = BaseObject.new(c4Instance)
	setmetatable(self, C4Class)
	self._maid = Maid.new()
	self.maid = self._maid
	self._obj = c4Instance
	self.obj = c4Instance
	self._stickRemote = c4Instance:WaitForChild(C4Consts.STICK_REMOTE_NAME)
	self._detonateRemote = c4Instance:WaitForChild(C4Consts.DETONATE_REMOTE_NAME)
	self._stuckValue = c4Instance:WaitForChild(C4Consts.STUCK_VALUE_NAME)
	self._maid:GiveTask(self._stuckValue:GetPropertyChangedSignal("Value"):Connect(function()
		if self._stuckValue.Value then
			Audio.ObjectLocal(self._obj.PrimaryPart, 6036721389, {
				TimePosition = 0.1
			})
			Audio.ObjectLocal(self._obj.PrimaryPart, 6036730402, {
				RollOffMaxDistance = 24,
				RollOffMinDistance = 8,
				Volume = 0.3,
				Looped = true
			})
		end
	end))
	self._creatorIdValue = c4Instance:WaitForChild(C4Consts.CREATOR_ID_VALUE_NAME)
	self._detonatedValue = c4Instance:WaitForChild(C4Consts.DETONATED_VALUE_NAME)
	self._locallyDetonated = false
	return self
end
function C4Class.GetStuck(self)
	return self._locallyStuck or self._stuckValue.Value
end
function C4Class.GetCreator(self)
	return Players:GetPlayerByUserId(self._creatorIdValue.Value)
end
function C4Class.Detonate(self, detonationData)
	self._detonateRemote:FireServer(detonationData)
	self._locallyDetonated = true
	Promise.delay(1):andThen(function()
		self._locallyDetonated = self._detonatedValue.Value
	end)
end
function C4Class.GetDetonated(self)
	return self._locallyDetonated or self._detonatedValue.Value
end
function C4Class.SetVelocity(self, velocity)
	assert(velocity ~= nil)
	self._obj.PrimaryPart.Velocity = velocity
end
function C4Class.SetRotVelocity(self, rotationalVelocity)
	assert(rotationalVelocity ~= nil)
	self._obj.PrimaryPart.RotVelocity = rotationalVelocity
end
function C4Class.IsListening(self)
	return self._maid.attach ~= nil
end
function C4Class.ListenForAttach(self)
	if not self:GetStuck() then
		self._maid.attach = self._obj.PrimaryPart.Touched:Connect(function(touchedPart)
			if touchedPart:IsDescendantOf(self._obj) or LocalPlayer.Character and touchedPart:IsDescendantOf(LocalPlayer.Character) then
			elseif touchedPart.CanCollide then
				self._locallyStuck = true
				self._maid.attach = nil
				Promise.delay(1):andThen(function()
					self._locallyStuck = self._stuckValue.Value
				end)
				local raycastParams = RaycastParams.new()
				raycastParams.FilterDescendantsInstances = { touchedPart }
				raycastParams.FilterType = Enum.RaycastFilterType.Whitelist
				local PrimaryPart = self._obj.PrimaryPart
				local raycastOffset = closestPointToPart(PrimaryPart.Position, touchedPart) - PrimaryPart.Position
				local raycastResult = workspace:Raycast(PrimaryPart.Position - raycastOffset.Unit * 5, raycastOffset.Unit * 10, raycastParams)
				local objectCFrameOffset
				if raycastResult then
					PrimaryPart.CFrame = CFrame.new(Vector3.new(), raycastResult.Normal) * CFrame.Angles(0, 0, math.random() * 2 * math.pi) + raycastResult.Position
					objectCFrameOffset = PrimaryPart.CFrame:ToObjectSpace(touchedPart.CFrame)
				else
					objectCFrameOffset = PrimaryPart.CFrame:ToObjectSpace(touchedPart.CFrame)
				end
				local Anchored = touchedPart.Anchored
				if Anchored then
					for i, v in ipairs(Players:GetPlayers()) do
						if touchedPart:IsDescendantOf(v.Character) then
							Anchored = false
							break
						end
					end
				end
				if Anchored then
					PrimaryPart.Anchored = true
				else
					assert(not self._tempJoint)
					local WeldConstraint = Instance.new("WeldConstraint")
					WeldConstraint.Name = C4Consts.TEMP_WELD_NAME
					WeldConstraint.Part0 = PrimaryPart
					WeldConstraint.Part1 = touchedPart
					WeldConstraint.Parent = PrimaryPart
					Promise.delay(0.1):andThen(function()
						WeldConstraint:Destroy()
					end)
				end
				self._stickRemote:FireServer(touchedPart, objectCFrameOffset)
			end
		end)
	end
end
return C4Class
