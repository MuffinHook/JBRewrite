
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local DoorUtils = require(ReplicatedStorage.Door2.DoorUtils)
require(ReplicatedStorage.Std.Promise)

local ActiveDoors = {}

local function EphThread(duration, callback)
	local startTime = tick()
	local connection

	connection = RunService.Heartbeat:Connect(function()
		local currentTime = tick()

		if duration then
			local progress = (currentTime - startTime) / duration
			local isComplete = false

			if progress >= 1 then
				progress = 1
				isComplete = true
			end

			if callback(progress) then
				isComplete = true
			end

			if isComplete then
				connection:Disconnect()
			end
		elseif callback(currentTime - startTime) then
			connection:Disconnect()
		end
	end)

	return connection
end

local function AnimateDoor(doorModel, distance, duration)
	if ActiveDoors[doorModel] then
		return false
	end

	ActiveDoors[doorModel] = true

	local children = doorModel:GetChildren()
	local door1Part = children[1]
	local door2Part = children[2]

	local Unit = (door2Part.Position - door1Part.Position).Unit

	local door1InitCFrame = door1Part.CFrame
	local door2InitCFrame = door2Part.CFrame

	local door1OpenCFrame = door1InitCFrame - Unit * distance
	local door2OpenCFrame = door2InitCFrame + Unit * distance

	door1Part.CanCollide = false
	door2Part.CanCollide = false

	local halfDuration = duration * 0.5

	EphThread(halfDuration, function(progress)
		door1Part.CFrame = door1InitCFrame:lerp(door1OpenCFrame, progress)
		door2Part.CFrame = door2InitCFrame:lerp(door2OpenCFrame, progress)
	end)

	task.delay(halfDuration + 1, function()
		EphThread(halfDuration, function(progress)
			door1Part.CFrame = door1OpenCFrame:lerp(door1InitCFrame, progress)
			door2Part.CFrame = door2OpenCFrame:lerp(door2InitCFrame, progress)
		end)
	end)

	task.delay(duration + 1.1, function()
		door1Part.CanCollide = true
		door2Part.CanCollide = true
		ActiveDoors[doorModel] = nil
	end)
	return
end

return {
	Init = function(config)
		local eventManager = config.em

		function eventManager.AnimateDoor(doorModel, distance, duration)
			return AnimateDoor(doorModel, distance, duration)
		end

		function eventManager.OpenDoor(doorModel, open)
			DoorUtils.setOpen(doorModel, open)
		end

		local isAnimating = false

		function eventManager.AnimateModelLift(model, targetCFrame)
			if isAnimating then
				return false
			end

			isAnimating = true

			local offset = Vector3.new(0, 20, 0)

			EphThread(2, function(progress)
				model:SetPrimaryPartCFrame(targetCFrame + offset * progress)
			end)

			task.delay(4, function()
				EphThread(2, function(progress)
					model:SetPrimaryPartCFrame(targetCFrame + offset * (1 - progress))
				end)
			end)

			task.delay(6, function()
				isAnimating = false
			end)
			return
		end
	end
}
