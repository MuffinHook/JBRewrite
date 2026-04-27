local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Maid = require(ReplicatedStorage.Std.Maid)
local Promise = require(ReplicatedStorage.Std.Promise)
local Joint = require(ReplicatedStorage.Std.Joint)
require(ReplicatedStorage.Std.Audio)
local PlankConsts = require(script.Parent.PlankConsts)
local DoorUtils = require(ReplicatedStorage.Door2.DoorUtils)
local Plank = {}
Plank.__index = Plank
function Plank.new(door)
	local instance = {}
	setmetatable(instance, Plank)
	instance._maid = Maid.new()
	instance._obj = door
	instance._maid:GiveTask(function()
		instance._obj = nil
	end)
	local transparencyMap = {}
	local clonedParts = nil
	local regenerationPromise = nil
	instance._maid:GiveTask(DoorUtils.getDoorOpenChangedSignal(door):Connect(function()
		if DoorUtils.getOpen(door) and not regenerationPromise then
			clonedParts = {}
			regenerationPromise = Promise.delay(DoorUtils.getDuration(door)):andThen(function()
				local Model = Instance.new("Model")
				for i, descendant in ipairs(door:GetDescendants()) do
					if descendant:IsA("BasePart") then
						local clonedPart = descendant:Clone()
						clonedPart.Parent = Model
						local heartbeatConnection = nil
						heartbeatConnection = RunService.Heartbeat:Connect(function()
							if clonedPart:IsDescendantOf(workspace) then
								if clonedPart.Position.Y < -146.542 then
									heartbeatConnection:Disconnect()
									local BodyForce = Instance.new("BodyForce")
									BodyForce.Force = Vector3.new(0, 1, 0) * clonedPart:GetMass() * workspace.Gravity * 0.9
									BodyForce.Parent = clonedPart
									clonedPart.AssemblyLinearVelocity = Vector3.new(0, 4, 0)
								end
							else
								heartbeatConnection:Disconnect()
							end
						end)
						table.insert(clonedParts, clonedPart)
						transparencyMap[descendant] = descendant.Transparency
						descendant.Transparency = 1
					end
				end
				Model.Parent = workspace
				Joint.WeldAllTo(Model, Model:GetChildren()[1])
			end):andThenCall(Promise.delay, PlankConsts.REGEN_DURATION):finally(function()
				for i, descendant in ipairs(door:GetDescendants()) do
					if transparencyMap[descendant] then
						descendant.Transparency = transparencyMap[descendant]
					end
				end
				for i, clonedPart in ipairs(clonedParts) do
					clonedPart:Destroy()
				end
				clonedParts = nil
			end):finally(function()
				regenerationPromise = nil
			end)
		end
	end))
	return instance
end
function Plank.Destroy(plankInstance)
	local _maid = plankInstance._maid
	plankInstance._maid = nil
	_maid:Destroy()
end
return Plank
