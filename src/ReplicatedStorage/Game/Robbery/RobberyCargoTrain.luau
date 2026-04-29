local LocalPlayer = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local TrainSystem = require(ReplicatedStorage.Game.TrainSystem)
local serverEvent = nil
local eventManager = nil
local function Ease_InOutQuad(progress)
	return progress < 0.5 and 2 * progress * progress or -1 - 2 * (progress - 2) * progress
end
local function OpenRoofDoorRaw(trainCar)
	if not trainCar.RoofDoorOpen then
		trainCar.RoofDoorOpen = true
		local startTime = tick()
		local heartbeatConnection = nil
		local function Heartbeat()
			local easingProgress = (tick() - startTime) * 0.5
			if easingProgress >= 1 then
				heartbeatConnection:Disconnect()
				easingProgress = 1
			end
			local easedValue, fallbackEasingProgress
			if easingProgress < 0.5 then
				easedValue = 2 * easingProgress * easingProgress
				if not easedValue then
					fallbackEasingProgress = easingProgress
					easedValue = -1 - 2 * (easingProgress - 2) * easingProgress
				end
			else
				fallbackEasingProgress = easingProgress
				easedValue = -1 - 2 * (easingProgress - 2) * easingProgress
			end
			trainCar.RoofDoorMotor.C1 = CFrame.new():lerp(trainCar.RoofDoorOpenC1, easedValue)
		end
		heartbeatConnection = RunService.Heartbeat:Connect(Heartbeat)
		trainCar.RoofDoorSpec.Kill = true
		return true
	end
end
local function OpenSideDoorRaw(trainCar)
	if not trainCar.DoorOpen then
		trainCar.DoorOpen = true
		local startTime = tick()
		local heartbeatConnection = nil
		local function Heartbeat()
			local easingProgress = (tick() - startTime) * 0.5
			if easingProgress >= 1 then
				heartbeatConnection:Disconnect()
				easingProgress = 1
			end
			local easedValue, fallbackEasingProgress
			if easingProgress < 0.5 then
				easedValue = 2 * easingProgress * easingProgress
				if not easedValue then
					fallbackEasingProgress = easingProgress
					easedValue = -1 - 2 * (easingProgress - 2) * easingProgress
				end
			else
				fallbackEasingProgress = easingProgress
				easedValue = -1 - 2 * (easingProgress - 2) * easingProgress
			end
			trainCar.DoorMotor.C1 = CFrame.new():Lerp(trainCar.DoorOpenC1, easedValue)
		end
		heartbeatConnection = RunService.Heartbeat:Connect(Heartbeat)
		trainCar.SideDoorSpec.Kill = true
		return true
	end
end
local function OpenVaultDoorRaw(trainCar)
	if trainCar.VaultOpenC1 then
		if not trainCar.VaultOpened and trainCar.RoofDoorOpen then
			trainCar.VaultOpened = true
			local Root = trainCar.Model.Skeleton.Vault.Root
			local Sound = Instance.new("Sound")
			Sound.SoundId = "rbxassetid://55224766"
			Sound.Parent = Root
			Sound.Volume = 0.6
			Sound.RollOffMode = Enum.RollOffMode.InverseTapered
			Sound:Play()
			game.Debris:AddItem(Sound, 5)
			local Explosion = Instance.new("Explosion")
			Explosion.Position = Root.Position
			Explosion.DestroyJointRadiusPercent = 0
			Explosion.BlastPressure = 5000
			Explosion.Parent = Root
			game.Debris:AddItem(Explosion, 5)
			task.wait(0.1)
			local startTime = tick()
			local heartbeatConnection = nil
			local function Heartbeat()
				local easingProgress = (tick() - startTime) * 0.5
				if easingProgress >= 1 then
					heartbeatConnection:Disconnect()
					easingProgress = 1
				end
				local easedValue, fallbackEasingProgress
				if easingProgress < 0.5 then
					easedValue = 2 * easingProgress * easingProgress
					if not easedValue then
						fallbackEasingProgress = easingProgress
						easedValue = -1 - 2 * (easingProgress - 2) * easingProgress
					end
				else
					fallbackEasingProgress = easingProgress
					easedValue = -1 - 2 * (easingProgress - 2) * easingProgress
				end
				trainCar.VaultMotor.C1 = CFrame.new():Lerp(trainCar.VaultOpenC1, easedValue)
			end
			heartbeatConnection = RunService.Heartbeat:Connect(Heartbeat)
			trainCar.VaultDoorSpec.Kill = true
			return true
		end
	end
end
local function SetupBoxCar(trainCar)
	local circleActionSpecs = {}
	local Model = trainCar.Model
	local function Action(isActive, isCompleted)
		if isCompleted then
			local car = trainCar
			local actionSuccess
			if car.RoofDoorOpen then
				actionSuccess = nil
			else
				car.RoofDoorOpen = true
				local startTime = tick()
				local animationHeartbeat = nil
				local function Heartbeat()
					local easingProgress = (tick() - startTime) * 0.5
					if easingProgress >= 1 then
						animationHeartbeat:Disconnect()
						easingProgress = 1
					end
					local easedValue, fallbackEasingProgress
					if easingProgress < 0.5 then
						easedValue = 2 * easingProgress * easingProgress
						if not easedValue then
							fallbackEasingProgress = easingProgress
							easedValue = -1 - 2 * (easingProgress - 2) * easingProgress
						end
					else
						fallbackEasingProgress = easingProgress
						easedValue = -1 - 2 * (easingProgress - 2) * easingProgress
					end
					car.RoofDoorMotor.C1 = CFrame.new():lerp(car.RoofDoorOpenC1, easedValue)
				end
				animationHeartbeat = RunService.Heartbeat:Connect(Heartbeat)
				car.RoofDoorSpec.Kill = true
				actionSuccess = true
			end
			if actionSuccess then
				serverEvent:FireServer("birq5v2d", trainCar.SystemId, trainCar.Id)
			else
				return false
			end
		end
		return true
	end
	local RoofDoorClosed = Model.Skeleton.RoofDoorClosed
	local roofDoorSpec = {
		Part = RoofDoorClosed,
		Name = "Open Door",
		ValidRoot = trainCar.Model,
		Timed = true,
		NoRay = true,
		Duration = 2,
		Dist = 10,
		Callback = Action
	}
	CircleAction.Add(roofDoorSpec, RoofDoorClosed)
	trainCar.RoofDoorSpec = roofDoorSpec
	table.insert(circleActionSpecs, roofDoorSpec)
	local function Action_2(isActive, isCompleted)
		if isCompleted then
			local car = trainCar
			local actionSuccess
			if car.DoorOpen then
				actionSuccess = nil
			else
				car.DoorOpen = true
				local startTime = tick()
				local animationHeartbeat = nil
				local function Heartbeat()
					local easingProgress = (tick() - startTime) * 0.5
					if easingProgress >= 1 then
						animationHeartbeat:Disconnect()
						easingProgress = 1
					end
					local easedValue, fallbackEasingProgress
					if easingProgress < 0.5 then
						easedValue = 2 * easingProgress * easingProgress
						if not easedValue then
							fallbackEasingProgress = easingProgress
							easedValue = -1 - 2 * (easingProgress - 2) * easingProgress
						end
					else
						fallbackEasingProgress = easingProgress
						easedValue = -1 - 2 * (easingProgress - 2) * easingProgress
					end
					car.DoorMotor.C1 = CFrame.new():Lerp(car.DoorOpenC1, easedValue)
				end
				animationHeartbeat = RunService.Heartbeat:Connect(Heartbeat)
				car.SideDoorSpec.Kill = true
				actionSuccess = true
			end
			if actionSuccess then
				serverEvent:FireServer("wvsrc40j", trainCar.SystemId, trainCar.Id)
			else
				return false
			end
		end
		return true
	end
	local LeftDoorClosed = Model.Skeleton.LeftDoorClosed
	local sideDoorSpec = {
		Part = LeftDoorClosed,
		Name = "Open Door",
		ValidRoot = trainCar.Model,
		Timed = true,
		NoRay = true,
		Duration = 2,
		Dist = 10,
		Callback = Action_2
	}
	CircleAction.Add(sideDoorSpec, LeftDoorClosed)
	trainCar.SideDoorSpec = sideDoorSpec
	table.insert(circleActionSpecs, sideDoorSpec)
	local function Action_3(isActive, isCompleted)
		if isCompleted and OpenVaultDoorRaw(trainCar) then
			serverEvent:FireServer("udhdjqcd", trainCar.SystemId, trainCar.Id)
		elseif isCompleted then
			return false
		end
		return true
	end
	local Root = Model.Skeleton.Vault.Root
	local vaultDoorSpec = {
		Part = Root,
		Name = "Breach Vault",
		Timed = true,
		NoRay = true,
		Duration = 3,
		Dist = 20,
		Callback = Action_3
	}
	CircleAction.Add(vaultDoorSpec, Root)
	trainCar.VaultDoorSpec = vaultDoorSpec
	table.insert(circleActionSpecs, vaultDoorSpec)
	trainCar.CircleActionSpecs = circleActionSpecs
end
local function OnCarCreated(trainCar)
	if trainCar.Name:find("BoxCar") then
		SetupBoxCar(trainCar)
	end
end
local function OnCarDestroyed(trainCar)
	if trainCar.Name:find("BoxCar") then
		for index, spec in next, trainCar.CircleActionSpecs do
			if not spec.Kill then
				spec.Kill = true
			end
		end
	end
end
local goldCollectionHeartbeat = nil
local function OnCarEntered(trainCar)
	if trainCar.Name:find("BoxCar") then
		local lastCheckTime = 0
		goldCollectionHeartbeat = RunService.Heartbeat:Connect(function()
			local currentTime = tick()
			if currentTime - lastCheckTime > 1 then
				lastCheckTime = currentTime
				if trainCar.VaultOpened and (trainCar.Model.Model.Rob.Gold.Position - LocalPlayer.Character.Humanoid.RootPart.Position).Magnitude < 6 then
					serverEvent:FireServer("qzgb69hv", trainCar.SystemId, trainCar.Id)
				end
			end
		end)
	end
end
local function OnCarExited(trainCar)
	if trainCar.Name:find("BoxCar") then
		if goldCollectionHeartbeat then
			goldCollectionHeartbeat:Disconnect()
			goldCollectionHeartbeat = nil
		end
		serverEvent:FireServer("qzvcgwi5", trainCar.SystemId, trainCar.Id)
	end
end
return {
	Init = function(initConfig)
		local eventManager = initConfig.em
		serverEvent = initConfig.Event
		eventManager = eventManager
		TrainSystem.Signals.OnCarCreated:Connect(OnCarCreated)
		TrainSystem.Signals.OnCarDestroyed:Connect(OnCarDestroyed)
		TrainSystem.Signals.OnCarEntered:Connect(OnCarEntered)
		TrainSystem.Signals.OnCarExited:Connect(OnCarExited)
		function eventManager.birq5v2d(trainSystemId, carId)
			local trainSystem = TrainSystem.GetSystemById(trainSystemId)
			local car = TrainSystem.GetCarById(trainSystem, carId)
			if trainSystem and car then
				if not car.RoofDoorOpen then
					car.RoofDoorOpen = true
					local startTime = tick()
					local animationHeartbeat = nil
					local function Heartbeat()
						local easingProgress = (tick() - startTime) * 0.5
						if easingProgress >= 1 then
							animationHeartbeat:Disconnect()
							easingProgress = 1
						end
						local easedValue, fallbackEasingProgress
						if easingProgress < 0.5 then
							easedValue = 2 * easingProgress * easingProgress
							if not easedValue then
								fallbackEasingProgress = easingProgress
								easedValue = -1 - 2 * (easingProgress - 2) * easingProgress
							end
						else
							fallbackEasingProgress = easingProgress
							easedValue = -1 - 2 * (easingProgress - 2) * easingProgress
						end
						car.RoofDoorMotor.C1 = CFrame.new():lerp(car.RoofDoorOpenC1, easedValue)
					end
					animationHeartbeat = RunService.Heartbeat:Connect(Heartbeat)
					car.RoofDoorSpec.Kill = true
				end
				return true
			else
				return nil
			end
		end
		function eventManager.wvsrc40j(trainSystemId, carId)
			local trainSystem = TrainSystem.GetSystemById(trainSystemId)
			local car = TrainSystem.GetCarById(trainSystem, carId)
			if trainSystem and car then
				if not car.DoorOpen then
					car.DoorOpen = true
					local startTime = tick()
					local animationHeartbeat = nil
					local function Heartbeat()
						local easingProgress = (tick() - startTime) * 0.5
						if easingProgress >= 1 then
							animationHeartbeat:Disconnect()
							easingProgress = 1
						end
						local easedValue, fallbackEasingProgress
						if easingProgress < 0.5 then
							easedValue = 2 * easingProgress * easingProgress
							if not easedValue then
								fallbackEasingProgress = easingProgress
								easedValue = -1 - 2 * (easingProgress - 2) * easingProgress
							end
						else
							fallbackEasingProgress = easingProgress
							easedValue = -1 - 2 * (easingProgress - 2) * easingProgress
						end
						car.DoorMotor.C1 = CFrame.new():Lerp(car.DoorOpenC1, easedValue)
					end
					animationHeartbeat = RunService.Heartbeat:Connect(Heartbeat)
					car.SideDoorSpec.Kill = true
				end
				return true
			else
				return nil
			end
		end
		function eventManager.udhdjqcd(trainSystemId, carId)
			local trainSystem = TrainSystem.GetSystemById(trainSystemId)
			local car = TrainSystem.GetCarById(trainSystem, carId)
			if trainSystem and car and OpenVaultDoorRaw(car) then
				OpenVaultDoorRaw(car)
				return true
			else
				return nil
			end
		end
	end
}
