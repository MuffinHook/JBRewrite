game:GetService("GuiService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StreamingHelperUtils = require(ReplicatedStorage.App.StreamingHelperUtils)
local Notification = require(ReplicatedStorage.Game.Notification)
local HomeConsts = require(ReplicatedStorage.Home.HomeConsts)
local Maid = require(ReplicatedStorage.Std.Maid)
local Spring = require(ReplicatedStorage.Std.Spring)
local Signal = require(ReplicatedStorage.Std.Signal)
local HomeItemBinder = require(ReplicatedStorage.Home.HomeItem.HomeItemBinder)
local BinderUtils = require(ReplicatedStorage.Std.Binder.BinderUtils)
local ItemPlacerUtils = require(script.Parent.ItemPlacerUtils)
local HomeSystem = require(script.Parent.Parent.HomeSystem)
local HomeItemSystem = require(ReplicatedStorage.Home.HomeItem.HomeItemSystem)
local PlacerApp = require(ReplicatedStorage.Home.UI.PlacerApp)
local homeStore = require(ReplicatedStorage.Home.homeStore)
local Roact = require(ReplicatedStorage.Roact)
local InputUtils = require(ReplicatedStorage.Std.InputUtils)
local createElement = Roact.createElement
local function getClosestVecDual(self, targetVector)
	local instance = self[1]
	local maxDot = (-1 / 0)
	for index, vector in self do
		local signMultiplier
		local dotProduct = vector:Dot(targetVector)
		local dotAbsolute = math.abs(dotProduct)
		if maxDot < dotAbsolute then
			signMultiplier = if dotProduct > 0 then 1 else -1
			maxDot = dotAbsolute
			instance = vector * signMultiplier
		end
	end
	return instance
end
local function rotBtwnUnit(self, targetVector)
	local instance = self:Cross(targetVector)
	local instance2 = self:Dot(targetVector)
	if instance2 < -0.999 then
		return CFrame.Angles(math.pi, 0, 0)
	else
		return CFrame.new(0, 0, 0, instance.x, instance.y, instance.z, instance2 + 1)
	end
end
local function roundN(number, divisor)
	return math.floor(number / divisor + 0.5) * divisor
end
local ItemPlacerSystem = {
	_maid = nil,
	_lastDragStart = 0,
	_lastDragEnd = 0,
	_currentHomeItem = nil,
	onDragStarted = Signal.new(),
	onDragEnded = Signal.new()
}
function ItemPlacerSystem.init()
	local instance = Maid.new()
	ItemPlacerSystem._maid = instance
	local raycastData = {}
	HomeItemSystem.onCustomizeStarted:Connect(function()
		local function inputBegan(inputObject, gameProcessed)
			local isGamepadButtonA = if inputObject.UserInputType == Enum.UserInputType.Gamepad1 then inputObject.KeyCode == Enum.KeyCode.ButtonA else false
			if (not gameProcessed or isGamepadButtonA) and ((inputObject.UserInputType == Enum.UserInputType.MouseButton1 or (inputObject.UserInputType == Enum.UserInputType.Touch or isGamepadButtonA)) and (not ItemPlacerSystem.isDragging() and (not (ItemPlacerSystem.getTimeSinceLastDragEnd() < 0.1) and HomeSystem.queryCurrentStandingHome()))) then
				local raycastResult = ItemPlacerUtils.raycastMouse(raycastData, true)
				if raycastResult then
					local hitInstance = raycastResult.Instance
					for i, v in ipairs(HomeItemBinder:GetAll()) do
						if hitInstance:IsDescendantOf(v:GetObj()) then
							ItemPlacerSystem.startDrag(v)
							return
						end
					end
				end
			end
		end
		instance._listenForCustomizeTouch = UserInputService.TouchTap:Connect(inputBegan)
		instance._listenForCustomizeClick = UserInputService.InputBegan:Connect(inputBegan)
	end)
	HomeItemSystem.onCustomizeEnded:Connect(function()
		instance._listenForCustomizeClick = nil
		instance._listenForCustomizeTouch = nil
		if ItemPlacerSystem.isDragging() then
			ItemPlacerSystem.stopDrag()
		end
	end)
	HomeSystem.onExited:Connect(function()
		instance._listenForCustomizeClick = nil
		instance._listenForCustomizeTouch = nil
		if ItemPlacerSystem.isDragging() then
			ItemPlacerSystem.stopDrag()
		end
	end)
	HomeItemSystem.onAttemptPlaceItem:Connect(function(self)
		ItemPlacerSystem.createAndDrag(self.name)
	end)
	HomeItemSystem.onAttemptDeleteItem:Connect(function()
		ItemPlacerSystem.attemptDeleteCurrentHomeItem()
	end)
end
function ItemPlacerSystem.getTargetPosition(raycastData)
	local raycastResult = ItemPlacerUtils.raycastMouse(raycastData)
	if raycastResult then
		local hitInstance = raycastResult.Instance
		local localSpacePosition = hitInstance.CFrame:PointToObjectSpace(raycastResult.Position)
		return hitInstance.CFrame:PointToWorldSpace((Vector3.new(math.floor(localSpacePosition.x / 0.1 + 0.5) * 0.1, localSpacePosition.y, math.floor(localSpacePosition.z / 0.1 + 0.5) * 0.1))), raycastResult.Normal, hitInstance.CFrame
	end
end
function ItemPlacerSystem.startDrag(homeItem)
	ItemPlacerSystem._lastDragStart = os.clock()
	local PrimaryPart = homeItem:GetObj().PrimaryPart
	local initialCFrame = homeItem:UntranslateCf(PrimaryPart.CFrame)
	local dragMaid = Maid.new()
	ItemPlacerSystem._maid.placeMaid = dragMaid
	ItemPlacerSystem._currentHomeItem = homeItem
	dragMaid:GiveTask(function()
		ItemPlacerSystem._currentHomeItem = nil
	end)
	homeItem:SetBeingDragged(true)
	dragMaid:GiveTask(function()
		homeItem:SetBeingDragged(false)
	end)
	homeStore:dispatch({
		type = "setVisible",
		value = false
	})
	dragMaid:GiveTask(function()
		homeStore:dispatch({
			type = "setVisible",
			value = true
		})
	end)
	local wasPlaced = false
	dragMaid:GiveTask(function()
		if not wasPlaced then
			if homeItem._obj then
				homeItem._obj:SetPrimaryPartCFrame(homeItem:TranslateCf(initialCFrame))
			end
			if not homeItem:IsPlaced() then
				homeItem:AttemptDelete()
			end
		end
	end)
	homeItem:CacheSurfaces()
	dragMaid:GiveTask(function()
		homeItem:ClearCacheSurfaces()
	end)
	local collidablePartsToDisable = {}
	for i, v in ipairs(homeItem:GetObj():GetDescendants()) do
		if v:IsA("BasePart") and v.CanCollide then
			table.insert(collidablePartsToDisable, v)
			v.CanCollide = false
		end
	end
	dragMaid:GiveTask(function()
		for i, v in ipairs(collidablePartsToDisable) do
			v.CanCollide = true
		end
	end)
	local Humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
	dragMaid:GiveTask(Humanoid.Changed:connect(function()
		Humanoid.Jump = false
	end))
	if Humanoid.SeatPart then
		Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
	dragMaid:GiveTask(function()
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
	end)
	local Part = Instance.new("Part")
	Part.Color = Color3.new(255/255, 0/255, 0/255)
	Part.Anchored = true
	Part.CanCollide = false
	Part.TopSurface = 0
	Part.BottomSurface = 0
	Part.Size = PrimaryPart.Size + Vector3.new(0.1, 0.1, 0.1)
	Part.CFrame = PrimaryPart.CFrame
	Part.Transparency = 1
	Part.Parent = homeItem:GetObj()
	dragMaid:GiveTask(Part)
	local objectsToCheck = { homeItem:GetObj(), LocalPlayer.Character }
	local initialRotation = initialCFrame - initialCFrame.p
	local _, surfaceNormal, surfaceCFrame = ItemPlacerSystem.getTargetPosition(objectsToCheck)
	local UpVector = initialRotation.UpVector
	if surfaceNormal:Dot(UpVector) < 0.99 then
		initialRotation = rotBtwnUnit(UpVector, surfaceNormal) * initialRotation
		UpVector = surfaceNormal
	end
	local alignmentMatrix = ItemPlacerSystem._alignMat(surfaceNormal, surfaceCFrame, initialRotation)
	local _2, rotationAngle, _3 = (alignmentMatrix:Inverse() * initialCFrame):ToOrientation()
	local position = initialCFrame.p
	local positionSpring = Spring.new(position, Vector3.new(), 0.8, 50)
	local offsetSpring = Spring.new(position, Vector3.new(), 0.7, 30)
	local rightVectorSpring = Spring.new(alignmentMatrix.RightVector, Vector3.new(), 0.8, 50)
	local upVectorSpring = Spring.new(alignmentMatrix.UpVector, Vector3.new(), 0.8, 50)
	local rotationSpring = Spring.new(rotationAngle, 0, 0.8, 30)
	local lastRotationTime = 0
	local function doRotate(shouldRotatePositive, shouldRotateNegative, rotationStartTime)
		local currentTime = os.clock()
		local timeSinceRotationStart = currentTime - rotationStartTime
		local accelerationFactor = if timeSinceRotationStart > 0.1 then math.min(12, timeSinceRotationStart / 0.1 + 1) else 1
		if not (currentTime - lastRotationTime < 0.1) then
			lastRotationTime = currentTime
			if shouldRotatePositive then
				rotationAngle = rotationAngle + 0.08726646259971647 * accelerationFactor
			elseif shouldRotateNegative then
				rotationAngle = rotationAngle - 0.08726646259971647 * accelerationFactor
			end
			rotationAngle = math.floor(rotationAngle / 0.08726646259971647 + 0.5) * 0.08726646259971647
			rotationSpring:SetTarget(rotationAngle)
		end
	end
	local function attemptPlaceCurrentHomeItem()
		ItemPlacerSystem._maid.listenForFeedback = homeItem._placeRemote.OnClientEvent:Connect(function(placementSuccess)
			ItemPlacerSystem._maid.listenForFeedback = nil
			if not placementSuccess and homeItem._obj then
				homeItem._obj:SetPrimaryPartCFrame(homeItem:TranslateCf(initialCFrame))
			end
		end)
		local targetPosition, surfaceNormal, surfaceCFrame = ItemPlacerSystem.getTargetPosition(objectsToCheck)
		homeItem:SetServerCFrame((homeItem:TranslateCf(ItemPlacerSystem._alignMat(surfaceNormal, surfaceCFrame, initialRotation) * CFrame.Angles(0, rotationAngle, 0) + targetPosition)))
		wasPlaced = true
		ItemPlacerSystem.stopDrag()
	end
	local guiMountId = Roact.mount(createElement("ScreenGui", {
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		DisplayOrder = 1
	}, {
		PlacerContainer = createElement("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(0.5, 0.08),
			Position = UDim2.fromScale(0.5, 0.85),
			AnchorPoint = Vector2.new(0.5, 1)
		}, {
			UIAspectRatioConstraint = createElement("UIAspectRatioConstraint", {
				AspectRatio = 7
			}),
			PlacerApp = createElement(PlacerApp, {
				aspectRatio = 7,
				verticalPaddingRatio = 18.285714285714285,
				onClickDelete = function()
					ItemPlacerSystem.attemptDeleteCurrentHomeItem()
				end,
				onClickPlace = function()
					attemptPlaceCurrentHomeItem()
				end,
				onDownRight = function()
					local rotationStartTime = os.clock()
					dragMaid.rotateHeartbeat = RunService.Heartbeat:Connect(function()
						local currentTime = os.clock()
						local elapsedTime = currentTime - rotationStartTime
						local accelerationFactor = if elapsedTime > 0.1 then math.min(12, elapsedTime / 0.1 + 1) else 1
						if not (currentTime - lastRotationTime < 0.1) then
							lastRotationTime = currentTime
							rotationAngle = rotationAngle - 0.08726646259971647 * accelerationFactor
							rotationAngle = math.floor(rotationAngle / 0.08726646259971647 + 0.5) * 0.08726646259971647
							rotationSpring:SetTarget(rotationAngle)
						end
					end)
				end,
				onUpRight = function()
					dragMaid.rotateHeartbeat = nil
				end,
				onDownLeft = function()
					local rotationStartTime = os.clock()
					dragMaid.rotateHeartbeat = RunService.Heartbeat:Connect(function()
						local currentTime = os.clock()
						local elapsedTime = currentTime - rotationStartTime
						local accelerationFactor = if elapsedTime > 0.1 then math.min(12, elapsedTime / 0.1 + 1) else 1
						if not (currentTime - lastRotationTime < 0.1) then
							lastRotationTime = currentTime
							rotationAngle = rotationAngle + 0.08726646259971647 * accelerationFactor
							rotationAngle = math.floor(rotationAngle / 0.08726646259971647 + 0.5) * 0.08726646259971647
							rotationSpring:SetTarget(rotationAngle)
						end
					end)
				end,
				onUpLeft = function()
					dragMaid.rotateHeartbeat = nil
				end,
				showPlace = InputUtils.isTouch()
			})
		})
	}), Players.LocalPlayer.PlayerGui, "ItemPlacerGui")
	dragMaid:GiveTask(function()
		Roact.unmount(guiMountId)
	end)
	dragMaid:GiveTask(UserInputService.InputEnded:Connect(function(self, gameProcessed)
		if not gameProcessed and self.UserInputType == Enum.UserInputType.MouseButton1 then
			dragMaid.rotateHeartbeat = nil
		end
	end))
	dragMaid:GiveTask(UserInputService.InputBegan:Connect(function(self, gameProcessed)
		if not gameProcessed and (self.UserInputType == Enum.UserInputType.Keyboard or self.UserInputType == Enum.UserInputType.Gamepad1) then
			local isLeftRotation = self.KeyCode == Enum.KeyCode.Q or self.KeyCode == Enum.KeyCode.ButtonL2
			local isRightRotation = self.KeyCode == Enum.KeyCode.E or self.KeyCode == Enum.KeyCode.ButtonR2
			if isRightRotation or isLeftRotation then
				local rotationStartTime = os.clock()
				dragMaid.waitForEnd = self:GetPropertyChangedSignal("UserInputState"):Connect(function()
					if self.UserInputState == Enum.UserInputState.End then
						dragMaid.waitForEnd = nil
						dragMaid.rotateHeartbeat = nil
					end
				end)
				dragMaid.rotateHeartbeat = RunService.Heartbeat:Connect(function()
					doRotate(isLeftRotation, isRightRotation, rotationStartTime)
				end)
			end
		end
	end))
	dragMaid:GiveTask(RunService.Heartbeat:Connect(function()
		local targetPosition, surfaceNormal, surfaceCFrame = ItemPlacerSystem.getTargetPosition(objectsToCheck)
		if targetPosition then
			local springResult, _ = positionSpring:SetTarget(targetPosition)
			local _2, offsetSprings = offsetSpring:SetTarget(targetPosition)
			local currentRotationAngle = rotationSpring:Update()
			if surfaceNormal:Dot(UpVector) < 0.99 then
				initialRotation = rotBtwnUnit(UpVector, surfaceNormal) * initialRotation
				UpVector = surfaceNormal
			end
			local alignmentMatrix = ItemPlacerSystem._alignMat(surfaceNormal, surfaceCFrame, initialRotation)
			local alignedCFrame = CFrame.fromMatrix(Vector3.new(0, 0, 0), rightVectorSpring:SetTarget(alignmentMatrix.RightVector).Unit, upVectorSpring:SetTarget(alignmentMatrix.UpVector).Unit)
			local previewCFrame = homeItem:TranslateCf(alignmentMatrix * CFrame.Angles(0, rotationAngle, 0) + targetPosition)
			local isValidUpDot = homeItem:IsValidUpDot((previewCFrame.UpVector:Dot(Vector3.new(0, 1, 0))))
			Part.Transparency = if homeItem:IsWithinBoundsCached(previewCFrame) and isValidUpDot then 1 else 0.5
			homeItem:SetCFrame((homeItem:TranslateCf(alignedCFrame * CFrame.Angles(-offsetSprings.z * 0.0015, 0, offsetSprings.x * 0.0015) * CFrame.Angles(0, currentRotationAngle, 0) + springResult)))
		end
	end))
	local function inputBegan(inputObject, gameProcessed)
		local isGamepadButtonA = if inputObject.UserInputType == Enum.UserInputType.Gamepad1 then inputObject.KeyCode == Enum.KeyCode.ButtonA else false
		if (not gameProcessed or isGamepadButtonA) and (inputObject.UserInputType == Enum.UserInputType.MouseButton1 or isGamepadButtonA) then
			attemptPlaceCurrentHomeItem()
		end
	end
	dragMaid:GiveTask(UserInputService.InputBegan:Connect(inputBegan))
	ItemPlacerSystem.onDragStarted:Fire()
end
function ItemPlacerSystem._alignMat(surfaceNormal, surfaceCFrame, initialRotation)
	local vectorCandidates = { surfaceNormal.LookVector, surfaceNormal.RightVector, surfaceNormal.UpVector }
	local closestVector = getClosestVecDual(vectorCandidates, surfaceNormal)
	if table.find(vectorCandidates, closestVector) then
		table.remove(vectorCandidates, table.find(vectorCandidates, closestVector))
	end
	if table.find(vectorCandidates, -closestVector) then
		table.remove(vectorCandidates, table.find(vectorCandidates, -closestVector))
	end
	return surfaceCFrame * rotBtwnUnit(Vector3.new(1, 0, 0), surfaceCFrame:VectorToObjectSpace((getClosestVecDual(vectorCandidates, surfaceCFrame:VectorToWorldSpace(Vector3.new(1, 0, 0))))))
end
function ItemPlacerSystem.stopDrag()
	ItemPlacerSystem._maid.placeMaid = nil
	ItemPlacerSystem._lastDragEnd = os.clock()
	ItemPlacerSystem.onDragEnded:Fire()
end
function ItemPlacerSystem.isDragging()
	return ItemPlacerSystem._maid and ItemPlacerSystem._maid.placeMaid ~= nil
end
function ItemPlacerSystem.attemptDeleteCurrentHomeItem()
	assert(ItemPlacerSystem.isDragging())
	local currentHomeItem = ItemPlacerSystem._currentHomeItem
	assert(currentHomeItem ~= nil)
	ItemPlacerSystem.stopDrag()
	currentHomeItem:AttemptDelete()
end
function ItemPlacerSystem.getTimeSinceLastDragStart()
	return os.clock() - ItemPlacerSystem._lastDragStart
end
function ItemPlacerSystem.getTimeSinceLastDragEnd()
	return os.clock() - ItemPlacerSystem._lastDragEnd
end
function ItemPlacerSystem.createAndDrag(itemName)
	homeStore:dispatch({
		type = "setVisible",
		value = false
	})
	local function reopenUI()
		homeStore:dispatch({
			type = "setVisible",
			value = true
		})
	end
	local standingHome = HomeSystem.queryCurrentStandingHome()
	assert(standingHome ~= nil)
	HomeItemSystem._maid._listenNewItem = standingHome._homeItemNewRemote.OnClientEvent:Connect(function(result)
		HomeItemSystem._maid._listenNewItem = nil
		if result.id == HomeConsts.ENUM_HOME_ITEM_NEW_RESULT.SUCCESS then
			StreamingHelperUtils.yieldForObjValuePopulated(result.modelPtr)
			BinderUtils.promiseBoundClass(HomeItemBinder, result.modelPtr.Value):andThen(function(homeItem)
				ItemPlacerSystem.startDrag(homeItem)
				ItemPlacerSystem._maid.placeMaid:GiveTask(function()
					homeStore:dispatch({
						type = "setVisible",
						value = true
					})
				end)
			end):catch(warn)
		elseif result.id == HomeConsts.ENUM_HOME_ITEM_NEW_RESULT.TOO_MANY then
			Notification.new({
				Text = "Too many items placed... try deleting some."
			})
			homeStore:dispatch({
				type = "setVisible",
				value = true
			})
		elseif result.id == HomeConsts.ENUM_HOME_ITEM_NEW_RESULT.ALL_OWNED_PLACED then
			Notification.new({
				Text = "You placed all of these that you own..."
			})
			homeStore:dispatch({
				type = "setVisible",
				value = true
			})
		elseif result.id == HomeConsts.ENUM_HOME_ITEM_NEW_RESULT.MAX_PLACED then
			Notification.new({
				Text = "You reached the placement limit for this item..."
			})
			homeStore:dispatch({
				type = "setVisible",
				value = true
			})
		else
			error(("Unhandled result id: %d"):format(result.id))
		end
	end)
	standingHome:AttemptCreateHomeItem(itemName)
end
return ItemPlacerSystem
