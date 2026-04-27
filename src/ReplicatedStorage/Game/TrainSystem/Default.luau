local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Joint = require(ReplicatedStorage.Std.Joint)
local TrainSystemUtils = require(script.Parent.TrainSystemUtils)
local function ApplyVelocityToDescendants(part, velocity, rotationalVelocity)
	local children = part:GetChildren()
	for _, child in next, children do
		if child:IsA("BasePart") then
			child.Velocity = velocity
			child.RotVelocity = rotationalVelocity
		end
		ApplyVelocityToDescendants(child, velocity, rotationalVelocity)
	end
	return true
end
return {
	MakeCar = function(carConfig)
		local Model = carConfig.Model
		local Base = carConfig.Base
		local Length = carConfig.Length
		Joint.WeldAllTo(Model.Model, Base)
		Joint.Weld(Model.FrontBogeyRoot, Base)
		Joint.Weld(Model.BackBogeyRoot, Base)
		local frontBogeyMotor = Joint.BlankMotor(Model.FrontBogey, Model.FrontBogeyRoot)
		local backBogeyMotor = Joint.BlankMotor(Model.BackBogey, Model.BackBogeyRoot)
		Model.FrontBogeyRoot.Anchored = false
		Model.BackBogeyRoot.Anchored = false
		Model.FrontBogey.Anchored = false
		Model.BackBogey.Anchored = false
		Base.Anchored = true
		local Magnitude = (Model.FrontBogeyRoot.Position - Base.CFrame * Vector3.new(0, 0, -Length * 0.5)).Magnitude
		local backBogeyDistance = (Model.BackBogeyRoot.Position - Base.CFrame * Vector3.new(0, 0, Length * 0.5)).Magnitude
		carConfig.BogeyMotorFront = frontBogeyMotor
		carConfig.BogeyMotorBack = backBogeyMotor
		carConfig.BogeyOffsetFront = Magnitude
		carConfig.BogeyOffsetBack = backBogeyDistance
		local Skeleton = Model:FindFirstChild("Skeleton")
		if Skeleton then
			carConfig.DoorOpenFuncs = {}
			local function setupDoor(doorIndex)
				local doorPart = Skeleton:FindFirstChild("Door" .. tostring(doorIndex))
				if doorPart then
					Joint.WeldAllTo(doorPart, doorPart.PrimaryPart)
					local doorMotor = Joint.Motor(doorPart.PrimaryPart, Base)
					doorPart.PrimaryPart.Anchored = false
					carConfig.DoorOpenFuncs[doorIndex] = function()
						local startTime = tick()
						local heartbeatConnection = nil
						local function Heartbeat()
							local progress = (tick() - startTime) / 1
							if progress >= 1 then
								heartbeatConnection:Disconnect()
								progress = 1
							end
							doorMotor.C1 = CFrame.new(doorPart.PrimaryPart.Size.X * TweenService:GetValue(progress, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 0, 0)
						end
						heartbeatConnection = RunService.Heartbeat:Connect(Heartbeat)
					end
				end
			end
			setupDoor(1)
			setupDoor(2)
		end
	end,
	MoveCar = function(carData, trainState, p3, railOffset)
		local _Speed = trainState.Speed
		local frontPosition, frontCFrame = TrainSystemUtils.CalculatePosition(trainState, trainState.Offset + railOffset + carData.BogeyOffsetBack)
		local backPosition, backCFrame = TrainSystemUtils.CalculatePosition(trainState, trainState.Offset + railOffset + carData.Length - carData.BogeyOffsetFront)
		local baseCFrame = CFrame.new(Vector3.new(), (backPosition - frontPosition).Unit)
		carData.Base.CFrame = baseCFrame + (frontPosition + backPosition) * 0.5
		local frontBogeyObjectSpace = backCFrame:toObjectSpace(baseCFrame)
		local backBogeyObjectSpace = frontCFrame:toObjectSpace(baseCFrame)
		if carData.InvertBogey then
			local invertedFrontBogey = frontBogeyObjectSpace:inverse()
			frontBogeyObjectSpace, backBogeyObjectSpace = invertedFrontBogey, backBogeyObjectSpace:inverse()
		end
		carData.BogeyMotorFront.C0 = carData.BogeyMotorFront.C0:lerp(frontBogeyObjectSpace, 0.1)
		carData.BogeyMotorBack.C0 = carData.BogeyMotorBack.C0:lerp(backBogeyObjectSpace, 0.1)
	end,
	DestroyCar = function(carToDestroy)
		carToDestroy.Model:Destroy()
		return true
	end
}
