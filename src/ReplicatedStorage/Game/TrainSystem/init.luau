local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Time = require(ReplicatedStorage.Module.Time)
local Signal = require(ReplicatedStorage.Std.Signal)
require(ReplicatedStorage.Module.RayCast)
local JetPack = require(ReplicatedStorage.Game.JetPack.JetPack)
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local trainFolder = nil
local eventSignal = nil
local eventManager = nil
local signals = {
	OnCarCreated = Signal.new(),
	OnCarDestroyed = Signal.new(),
	OnCarEntered = Signal.new(),
	OnCarExited = Signal.new()
}
local TrainSystemUtils = require(script.TrainSystemUtils)
local CalculateDistanceAhead = TrainSystemUtils.CalculateDistanceAhead
local MoveTrain = TrainSystemUtils.MoveTrain
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Include
raycastParams.IgnoreWater = true
local function PopulateCar(car, carScript, carModel)
	local Base = carModel.Base
	local carModule = require(carScript)
	car.Model = carModel
	car.Base = Base
	car.Length = Base.Size.Z
	car.InvertBogey = false
	carModule.MakeCar(car, eventSignal)
	signals.OnCarCreated:Fire(car)
	assert(car.BogeyMotorFront)
	assert(car.BogeyMotorBack)
	assert(car.BogeyOffsetFront)
	assert(car.BogeyOffsetBack)
	car.MoveCar = carModule.MoveCar
	car.DestroyCar = carModule.DestroyCar
	car.Loaded = true
	return car
end
local function RenderTrain(train, deltaTime)
	local distanceOffset = 0
	for i = #train.Cars, 1, -1 do
		local car = train.Cars[i]
		if car.Loaded then
			car:MoveCar(train, deltaTime, distanceOffset)
			distanceOffset = distanceOffset + car.Length + train.BufferLength
		end
	end
end
local trainSystems = {}
local function GetSystemById(systemId)
	for i = 1, #trainSystems do
		if trainSystems[i].Id == systemId then
			return trainSystems[i]
		end
	end
	return false
end
local function GetCarById(train, carId)
	for i = 1, #train.Cars do
		if train.Cars[i].Id == carId then
			return train.Cars[i]
		end
	end
	return false
end
return {
	Init = function(config)
		local eventManager = config.em
		eventSignal = config.Event
		eventManager = eventManager
		local Trains = Instance.new("Folder")
		Trains.Name = "Trains"
		Trains.Parent = workspace
		trainFolder = { Trains }
		raycastParams.FilterDescendantsInstances = { Trains }
		local UnsafePositionReplication = ReplicatedStorage:FindFirstChild("UnsafePositionReplication")
		local ChangePositionReplication = ReplicatedStorage:FindFirstChild("ChangePositionReplication")
		local function PopulateTrain(trainSystem)
			for carIndex, car in next, trainSystem.Cars do
				car.SystemId = trainSystem.Id
				local carName = car.Name
				local carModel = ReplicatedStorage.Resource.TrainCars[carName]:Clone()
				local carScript = script:FindFirstChild(carName) or script.Default
				carModel:PivotTo(CFrame.new(0, -200, 0))
				carModel.Parent = Trains
				PopulateCar(car, carScript, carModel)
				task.wait()
			end
		end
		function eventManager.b9qhzm8t(trainSystem)
			local Id = trainSystem.Id
			local existingSystem = false
			for i = 1, #trainSystems do
				if trainSystems[i].Id == Id then
					existingSystem = trainSystems[i]
					break
				end
			end
			if existingSystem then
				assert("This train already exists on client.")
			else
				table.insert(trainSystems, trainSystem)
				PopulateTrain(trainSystem)
			end
			return true
		end
		local lastReplicationTime = 0
		local function ReplicateTrain(replicationData)
			local SystemId = replicationData.SystemId
			local targetTrain = false
			for i = 1, #trainSystems do
				if trainSystems[i].Id == SystemId then
					targetTrain = trainSystems[i]
					break
				end
			end
			if targetTrain then
				local timeDelta = Time.GetNowSync() - replicationData.NowSync
				assert(replicationData.SegmentId)
				assert(targetTrain.SegmentsById)
				local SegmentId_2 = replicationData.SegmentId
				local calculatedOffset = replicationData.Offset + timeDelta * replicationData.Speed
				local distanceAhead = CalculateDistanceAhead(targetTrain, targetTrain.SegmentId, targetTrain.Offset, SegmentId_2, replicationData.Offset)
				targetTrain.ServerSpeed = replicationData.Speed
				if distanceAhead then
					targetTrain.ServerDistanceAhead = distanceAhead
				else
					print("Train force replication")
					targetTrain.ServerDistanceAhead = nil
					targetTrain.SegmentId = SegmentId_2
					targetTrain.Offset = calculatedOffset
				end
				return true
			else
				local currentTime = tick()
				if currentTime - lastReplicationTime > 0.5 then
					lastReplicationTime = currentTime
					eventSignal:FireServer("getTrainData", replicationData.SystemId)
				end
				return false
			end
		end
		function eventManager.pvopv1ja(replicationList)
			for index, replicationData in next, replicationList do
				ReplicateTrain(replicationData)
			end
		end
		function eventManager.mwxdlqx0(systemId)
			for i = 1, #trainSystems do
				local trainSystem = trainSystems[i]
				if trainSystem.Id == systemId then
					table.remove(trainSystems, i)
					for carIndex, car in next, trainSystem.Cars do
						local timeoutStart = os.clock()
						repeat
							task.wait()
						until car.DestroyCar ~= nil or timeoutStart + 5 < os.clock()
						if car.DestroyCar then
							signals.OnCarDestroyed:Fire(car)
							car:DestroyCar()
						else
							warn("Car has no DestroyCar function")
							print(car)
						end
					end
					return true
				end
			end
			return false
		end
		function eventManager.ptiew0pw(systemId, segmentId, branchIndex)
			local targetTrain = false
			for i = 1, #trainSystems do
				if trainSystems[i].Id == systemId then
					targetTrain = trainSystems[i]
					break
				end
			end
			if not targetTrain then
				return false
			end
			local segment = targetTrain.SegmentsById[segmentId]
			assert(segment)
			segment.BranchIndex = branchIndex
		end
		function eventManager.r0klh6da(systemId)
			local targetTrain = false
			for i = 1, #trainSystems do
				if trainSystems[i].Id == systemId then
					targetTrain = trainSystems[i]
					break
				end
			end
			if not targetTrain then
				return false
			end
			for carIndex, car in targetTrain.Cars do
				if car.SoundHorn then
					car.SoundHorn:Play()
					car.LastHorn = tick()
				elseif car.SoundWhistle then
					car.SoundWhistle:Play()
					car.LastHorn = tick()
				end
			end
		end
		local charactersTrain = {}
		for characterIndex, character in CollectionService:GetTagged("ReplicateCharacterTrain") do
			table.insert(charactersTrain, character)
		end
		local characterLastPositions = {}
		local characterCleanupTasks = {}
		CollectionService:GetInstanceAddedSignal("ReplicateCharacterTrain"):Connect(function(character)
			table.insert(charactersTrain, character)
			if characterCleanupTasks[character] then
				task.cancel(characterCleanupTasks[character])
				characterCleanupTasks[character] = nil
			end
		end)
		CollectionService:GetInstanceRemovedSignal("ReplicateCharacterTrain"):Connect(function(character)
			table.remove(charactersTrain, table.find(charactersTrain, character))
			if characterCleanupTasks[character] then
				task.cancel(characterCleanupTasks[character])
			end
			characterCleanupTasks[character] = task.delay(2, function()
				characterLastPositions[character] = nil
				characterCleanupTasks[character] = nil
			end)
		end)
		local currentCar = nil
		local currentTrain = nil
		local lastPositionUpdateTime = os.clock()
		local lastPositionCFrame = CFrame.new()
		local function Stepped(deltaTime)
			if #trainSystems <= 0 then
				if currentCar then
					signals.OnCarExited:Fire(currentCar)
				end
				currentCar = nil
				currentTrain = nil
			else
				debug.profilebegin("Train Update")
				local castResult = nil
				local carBaseFrame = nil
				local previousBaseFrame = nil
				local playerRootPart = nil
				local Character = LocalPlayer.Character
				if Character then
					local Humanoid = Character:FindFirstChild("Humanoid")
					if Humanoid then
						playerRootPart = Humanoid.RootPart
						if playerRootPart and not JetPack.IsFlying() then
							local raycastHit = workspace:Raycast(playerRootPart.Position, Vector3.new(0, -20, 0), raycastParams)
							castResult = if raycastHit and raycastHit.Instance then raycastHit.Instance else raycastHit
						end
					end
				end
				if not castResult then
					if currentCar then
						signals.OnCarExited:Fire(currentCar)
					end
					currentCar = nil
					currentTrain = nil
				end
				for trainIndex, train in next, trainSystems do
					local carCheckResult
					for i = #train.Cars, 1, -1 do
						local car = train.Cars[i]
						if car.Loaded and (castResult and castResult:IsDescendantOf(car.Model)) then
							carBaseFrame = car.Base
							previousBaseFrame = carBaseFrame.CFrame
							if currentCar then
								if currentCar ~= car then
									signals.OnCarExited:Fire(currentCar, true)
									signals.OnCarEntered:Fire(car)
								end
							else
								signals.OnCarEntered:Fire(car)
							end
							currentCar = car
							currentTrain = train
						end
					end
					carCheckResult = if train.ServerDistanceAhead then train.ServerSpeed + train.ServerDistanceAhead else train.ServerSpeed or train.Speed
					train.Speed = train.Speed + (carCheckResult - train.Speed) * 0.1
					MoveTrain(train, deltaTime)
					RenderTrain(train, deltaTime)
				end
				debug.profileend()
				if carBaseFrame then
					local currentBaseFrame = carBaseFrame.CFrame
					local frameDifference = currentBaseFrame * previousBaseFrame:Inverse()
					local vehiclePacket = VehicleUtils.GetLocalVehiclePacket()
					if not (vehiclePacket and vehiclePacket.Passenger) then
						playerRootPart.CFrame = frameDifference * playerRootPart.CFrame
					end
					local cameraLocalOffset = CurrentCamera.CFrame:ToObjectSpace(CurrentCamera.Focus)
					CurrentCamera.CFrame = CurrentCamera.CFrame * cameraLocalOffset * (frameDifference - frameDifference.p) * cameraLocalOffset:Inverse()
					assert(currentCar)
					if UnsafePositionReplication and os.clock() - lastPositionUpdateTime > 0.2 then
						local playerRelativePosition = currentBaseFrame:ToObjectSpace(playerRootPart.CFrame)
						if not (lastPositionCFrame and playerRelativePosition:FuzzyEq(lastPositionCFrame)) then
							lastPositionUpdateTime = os.clock()
							UnsafePositionReplication:FireServer("Train", currentCar.Id, playerRelativePosition)
							lastPositionCFrame = playerRelativePosition
						end
					end
					for characterIndex, character in charactersTrain do
						local carIdAttribute = character:GetAttribute("TrainCar")
						local offsetAttribute = character:GetAttribute("TrainOffset")
						if Character ~= character and (character.PrimaryPart and (carIdAttribute and offsetAttribute)) then
							local trainForCharacter = currentTrain
							local targetCarFound = false
							local targetCarId = carIdAttribute
							for j = 1, #trainForCharacter.Cars do
								if trainForCharacter.Cars[j].Id == targetCarId then
									targetCarFound = trainForCharacter.Cars[j]
									break
								end
							end
							if targetCarFound and targetCarFound.Base then
								local characterPositionData = characterLastPositions[character]
								if not characterPositionData then
									local newPositionData = {
										LastCarId = targetCarId,
										LastOffset = targetCarFound.Base.CFrame:ToObjectSpace(character.PrimaryPart.CFrame)
									}
									characterLastPositions[character] = newPositionData
									characterPositionData = newPositionData
								end
								local LastOffset = characterPositionData.LastOffset
								if characterPositionData.LastCarId ~= targetCarId then
									local trainForLookup = currentTrain
									local LastCarId = characterPositionData.LastCarId
									local previousCarFound = false
									for k = 1, #trainForLookup.Cars do
										if trainForLookup.Cars[k].Id == LastCarId then
											previousCarFound = trainForLookup.Cars[k]
											break
										end
									end
									LastOffset = if previousCarFound and previousCarFound.Base then targetCarFound.Base.CFrame:ToObjectSpace(previousCarFound.Base.CFrame * LastOffset) else targetCarFound.Base.CFrame:ToObjectSpace(character.PrimaryPart.CFrame)
									characterPositionData.LastCarId = targetCarId
								end
								local interpolatedOffset = LastOffset:Lerp(offsetAttribute, 1 - math.exp(-5 * deltaTime))
								characterPositionData.LastOffset = interpolatedOffset
								character.PrimaryPart.CFrame = targetCarFound.Base.CFrame * interpolatedOffset
							end
						end
					end
				end
			end
		end
		RunService.Heartbeat:Connect(Stepped)
		signals.OnCarEntered:Connect(function(enteredCar)
			if LocalPlayer.Character then
				local humanoidRootPart = nil
				local carBaseFrame = enteredCar.Base and enteredCar.Base.CFrame
				for descendantIndex, descendant in LocalPlayer.Character:GetDescendants() do
					if descendant:IsA("BasePart") then
						if humanoidRootPart == nil and descendant.Name == "HumanoidRootPart" then
							humanoidRootPart = descendant.CFrame
						end
						descendant.CollisionGroup = "PlayersInTrain"
					end
				end
				if humanoidRootPart and (carBaseFrame and ChangePositionReplication) then
					ChangePositionReplication:FireServer("Train", true, enteredCar.Id, carBaseFrame:ToObjectSpace(humanoidRootPart))
				end
			end
		end)
		signals.OnCarExited:Connect(function(exitedCar, isInstantExit)
			if LocalPlayer.Character then
				for descendantIndex, descendant in LocalPlayer.Character:GetDescendants() do
					if descendant:IsA("BasePart") then
						descendant.CollisionGroup = "Players"
					end
				end
			end
			if not isInstantExit and ChangePositionReplication then
				ChangePositionReplication:FireServer(nil, false)
			end
		end)
	end,
	Signals = signals,
	GetSystemById = GetSystemById,
	GetCarById = GetCarById,
	MoveTrain = MoveTrain
}
