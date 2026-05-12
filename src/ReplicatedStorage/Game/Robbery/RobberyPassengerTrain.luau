local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TrainSystem = require(ReplicatedStorage.Game.TrainSystem)
local Joint = require(ReplicatedStorage.Std.Joint)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local RemoteEvent = nil
local EventManager = nil
local ScreenGui = nil
local function comma(numberString)
	local leadingDigits, middleDigits, suffix = string.match(numberString, "^([^%d]*%d)(%d*)(.-)$")
	return leadingDigits .. middleDigits:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. suffix
end
local function FormatMoney(amount)
	local leadingDigits, middleDigits, suffix = string.match(math.abs(amount), "^([^%d]*%d)(%d*)(.-)$")
	return ("%s$%s"):format(if amount >= 0 then "" else "-", leadingDigits .. middleDigits:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. suffix)
end
local function PlaySound(parent, soundId)
	local Sound = Instance.new("Sound")
	Sound.SoundId = ("rbxassetid://%d"):format(soundId)
	Sound.Volume = 0.75
	Sound.RollOffMode = Enum.RollOffMode.InverseTapered
	Sound.Parent = parent
	Sound:Play()
	task.delay(1, function()
		game.Debris:AddItem(Sound, Sound.TimeLength)
	end)
end
local function OpenRoofDoorRaw(carData, glassIndex)
	local glassPart = assert(carData.Model.Model:FindFirstChild("Glass" .. tostring(glassIndex)), "missing glassPart")
	if not carData.GlassIndexOpen[glassIndex] then
		carData.GlassIndexOpen[glassIndex] = true
		glassPart.CanCollide = false
		glassPart.Transparency = 1
		PlaySound(glassPart, 848150421)
		CircleAction.Remove(glassPart)
		return true
	end
end
local function OpenSideDoorRaw(carData, doorIndex)
	local doorModel = assert(carData.Model.Skeleton:FindFirstChild("Door" .. tostring(doorIndex)), "missing doorModel")
	if not carData.DoorIndexOpen[doorIndex] then
		carData.DoorIndexOpen[doorIndex] = true
		carData.DoorOpenFuncs[doorIndex]()
		CircleAction.Remove(doorModel)
		return true
	end
end
local DefaultCFrame = CFrame.new()
local function SetupPassengerCar(carData)
	local actionSpecs = {}
	local function GrabAction(actionSpec, isLocalPlayer)
		if isLocalPlayer then
			actionSpec.IsMine = true
			RemoteEvent:FireServer("grabPassengerTrainCash", carData.SystemId, carData.Id, actionSpec.SpawnName, actionSpec.ItemName)
		end
		return true
	end
	carData.Items = {}
	local Model = carData.Model
	if carData.Name == "PassengerArmor" then
		for index, cashPart in Model.Model.Cash:GetChildren() do
			local actionSpec = {
				Part = cashPart,
				Name = "Grab Cash",
				Timed = true,
				Duration = 0.65,
				Dist = 6,
				Callback = GrabAction,
				SpawnName = cashPart.Name,
				ItemName = "RackOfCash"
			}
			CircleAction.Add(actionSpec, cashPart)
			table.insert(actionSpecs, actionSpec)
			carData.Items[cashPart.Name] = cashPart
		end
	else
		local nextFunction = next
		local childrenArray, iterationState = Model.Model.Spawns:GetChildren()
		for enumIndex, spawnPart in nextFunction, childrenArray, iterationState do
			local selectedItem = carData.ChosenItems[spawnPart.Name]
			if selectedItem then
				local grabbableItem = ReplicatedStorage.Resource.TrainGrabItems[selectedItem]:Clone()
				grabbableItem.CanCollide = false
				Joint.CustomWeld(grabbableItem, carData.Base, (spawnPart.CFrame * CFrame.new(0, grabbableItem.Size.Y * 0.5, 0) * CFrame.Angles(0, (math.random() - 0.5) * 2 * 0.1, 0)):toObjectSpace(carData.Base.CFrame), DefaultCFrame)
				grabbableItem.Anchored = false
				grabbableItem.Parent = Model
				carData.Items[spawnPart.Name] = grabbableItem
				local actionSpec = {
					Part = grabbableItem,
					Name = ("Grab %s"):format(selectedItem:lower()),
					Timed = true,
					Duration = 0.65,
					Dist = 6,
					Callback = GrabAction,
					SpawnName = spawnPart.Name,
					ItemName = selectedItem
				}
				CircleAction.Add(actionSpec, grabbableItem)
				table.insert(actionSpecs, actionSpec)
			end
			spawnPart:Destroy()
		end
	end
	if carData.Name ~= "PassengerArmor" then
		local function Action(actionSpec, isLocalPlayer)
			if isLocalPlayer and OpenRoofDoorRaw(carData, actionSpec.GlassIndex) then
				RemoteEvent:FireServer("breakPassengerGlass", carData.SystemId, carData.Id, actionSpec.GlassIndex)
			elseif isLocalPlayer then
				return false
			end
			return true
		end
		for i = 1, 2 do
			local glassWindow = Model.Model:FindFirstChild("Glass" .. tostring(i))
			local actionSpec = {
				Part = glassWindow,
				Name = "Break Glass",
				ValidRoot = carData.Model,
				Timed = true,
				NoRay = true,
				Duration = 1.5,
				Dist = 10,
				Callback = Action,
				GlassIndex = i
			}
			CircleAction.Add(actionSpec, glassWindow)
			table.insert(actionSpecs, actionSpec)
		end
	end
	local function SideDoorAction(actionSpec, isLocalPlayer)
		if isLocalPlayer then
			local carDataRef = carData
			local DoorIndex = actionSpec.DoorIndex
			local doorModelRef = assert(carDataRef.Model.Skeleton:FindFirstChild("Door" .. tostring(DoorIndex)), "missing doorModel")
			local doorOpened
			if carDataRef.DoorIndexOpen[DoorIndex] then
				doorOpened = nil
			else
				carDataRef.DoorIndexOpen[DoorIndex] = true
				carDataRef.DoorOpenFuncs[DoorIndex]()
				CircleAction.Remove(doorModelRef)
				doorOpened = true
			end
			if doorOpened then
				RemoteEvent:FireServer("openPassengerDoor", carData.SystemId, carData.Id, actionSpec.DoorIndex)
			else
				return false
			end
		end
		return true
	end
	for j = 1, 2 do
		local doorGroup = Model.Skeleton:FindFirstChild("Door" .. tostring(j))
		if doorGroup then
			local actionSpec = {
				Part = doorGroup.PrimaryPart,
				Name = "Open Door",
				ValidRoot = carData.Model,
				Timed = false,
				NoRay = true,
				Dist = 10,
				Callback = SideDoorAction,
				DoorIndex = j
			}
			CircleAction.Add(actionSpec, doorGroup)
			table.insert(actionSpecs, actionSpec)
		end
	end
	carData.CircleActionSpecs = actionSpecs
	carData.GlassIndexOpen = {}
	carData.DoorIndexOpen = {}
end
local function OnCarCreated(carData)
	if carData.Name:sub(1, 9) == "Passenger" then
		SetupPassengerCar(carData)
	end
end
local function OnCarDestroyed(carData)
	if carData.Name:sub(1, 9) == "Passenger" then
		if carData.CircleActionSpecs then
			for index, actionSpec in next, carData.CircleActionSpecs do
				if not actionSpec.Kill then
					actionSpec.Kill = true
				end
			end
		else
			warn("Car.CircleActionSpecs is nil")
			print(carData)
		end
	end
end
return {
	Init = function(config)
		local em = config.em
		RemoteEvent = config.Event
		EventManager = em
		ScreenGui = config.ScreenGui
		TrainSystem.Signals.OnCarCreated:Connect(OnCarCreated)
		TrainSystem.Signals.OnCarDestroyed:Connect(OnCarDestroyed)
		function em.grabPassengerTrainCash(systemId, carId, spawnName)
			local systemData = TrainSystem.GetSystemById(systemId)
			if systemData then
				local carData = TrainSystem.GetCarById(systemData, carId)
				if carData and carData.Items[spawnName] then
					carData.Items[spawnName]:Destroy()
					if carData.CircleActionSpecs then
						for index, actionSpec in carData.CircleActionSpecs do
							if actionSpec.SpawnName == spawnName then
								actionSpec.Kill = true
								if actionSpec.IsMine then
									PlaySound(LocalPlayer, 1988477690)
								end
								break
							end
						end
					end
					return true
				else
					return nil
				end
			else
				return nil
			end
		end
		function em.breakPassengerGlass(systemId, carId, glassIndex)
			local systemData = TrainSystem.GetSystemById(systemId)
			if systemData then
				local carData = TrainSystem.GetCarById(systemData, carId)
				if carData then
					OpenRoofDoorRaw(carData, glassIndex)
					return true
				else
					return nil
				end
			else
				return nil
			end
		end
	end
}
