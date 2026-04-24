-- Reviewed by Claude
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
local function getClosestVecDual(self, p2)
	local instance = self[1]
	local instance2 = (-1 / 0)
	for var4, var5 in self do
		local instance3
		local var6 = var5:Dot(p2)
		local var7 = math.abs(var6)
		if instance2 < var7 then
			instance3 = if var6 > 0 then 1 else -1
			instance2 = var7
			instance = var5 * instance3
		end
	end
	return instance
end
local function rotBtwnUnit(self, p2)
	local instance = self:Cross(p2)
	local instance2 = self:Dot(p2)
	if instance2 < -0.999 then
		return CFrame.Angles(math.pi, 0, 0)
	else
		return CFrame.new(0, 0, 0, instance.x, instance.y, instance.z, instance2 + 1)
	end
end
local function roundN(self, p2)
	return math.floor(self / p2 + 0.5) * p2
end
local t = {
	_maid = nil,
	_lastDragStart = 0,
	_lastDragEnd = 0,
	_currentHomeItem = nil,
	onDragStarted = Signal.new(),
	onDragEnded = Signal.new()
}
function t.init()
	local instance = Maid.new()
	t._maid = instance
	local t2 = {}
	HomeItemSystem.onCustomizeStarted:Connect(function()
		local function inputBegan(self, p2)
			local instance = if self.UserInputType == Enum.UserInputType.Gamepad1 then self.KeyCode == Enum.KeyCode.ButtonA else false
			if (not p2 or instance) and ((self.UserInputType == Enum.UserInputType.MouseButton1 or (self.UserInputType == Enum.UserInputType.Touch or instance)) and (not t.isDragging() and (not (t.getTimeSinceLastDragEnd() < 0.1) and HomeSystem.queryCurrentStandingHome()))) then
				local instance2 = ItemPlacerUtils.raycastMouse(t2, true)
				if instance2 then
					local instance3 = instance2.Instance
					for i, v in ipairs(HomeItemBinder:GetAll()) do
						if instance3:IsDescendantOf(v:GetObj()) then
							t.startDrag(v)
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
		if t.isDragging() then
			t.stopDrag()
		end
	end)
	HomeSystem.onExited:Connect(function()
		instance._listenForCustomizeClick = nil
		instance._listenForCustomizeTouch = nil
		if t.isDragging() then
			t.stopDrag()
		end
	end)
	HomeItemSystem.onAttemptPlaceItem:Connect(function(self)
		t.createAndDrag(self.name)
	end)
	HomeItemSystem.onAttemptDeleteItem:Connect(function()
		t.attemptDeleteCurrentHomeItem()
	end)
end
function t.getTargetPosition(self)
	local instance = ItemPlacerUtils.raycastMouse(self)
	if instance then
		local instance2 = instance.Instance
		local instance3 = instance2.CFrame:PointToObjectSpace(instance.Position)
		return instance2.CFrame:PointToWorldSpace((Vector3.new(math.floor(instance3.x / 0.1 + 0.5) * 0.1, instance3.y, math.floor(instance3.z / 0.1 + 0.5) * 0.1))), instance.Normal, instance2.CFrame
	end
end
function t.startDrag(self)
	t._lastDragStart = os.clock()
	local PrimaryPart = self:GetObj().PrimaryPart
	local instance = self:UntranslateCf(PrimaryPart.CFrame)
	local instance2 = Maid.new()
	t._maid.placeMaid = instance2
	t._currentHomeItem = self
	instance2:GiveTask(function()
		t._currentHomeItem = nil
	end)
	self:SetBeingDragged(true)
	instance2:GiveTask(function()
		self:SetBeingDragged(false)
	end)
	homeStore:dispatch({
		type = "setVisible",
		value = false
	})
	instance2:GiveTask(function()
		homeStore:dispatch({
			type = "setVisible",
			value = true
		})
	end)
	local instance3 = false
	instance2:GiveTask(function()
		if not instance3 then
			if self._obj then
				self._obj:SetPrimaryPartCFrame(self:TranslateCf(instance))
			end
			if not self:IsPlaced() then
				self:AttemptDelete()
			end
		end
	end)
	self:CacheSurfaces()
	instance2:GiveTask(function()
		self:ClearCacheSurfaces()
	end)
	local t2 = {}
	for i, v in ipairs(self:GetObj():GetDescendants()) do
		if v:IsA("BasePart") and v.CanCollide then
			table.insert(t2, v)
			v.CanCollide = false
		end
	end
	instance2:GiveTask(function()
		for i, v in ipairs(t2) do
			v.CanCollide = true
		end
	end)
	local Humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
	instance2:GiveTask(Humanoid.Changed:connect(function()
		Humanoid.Jump = false
	end))
	if Humanoid.SeatPart then
		Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
	instance2:GiveTask(function()
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
	Part.Parent = self:GetObj()
	instance2:GiveTask(Part)
	local t3 = { self:GetObj(), LocalPlayer.Character }
	local var4 = instance
	local var5 = var4 - var4.p
	local _, var6, var7 = t.getTargetPosition(t3)
	local UpVector = var5.UpVector
	if var6:Dot(UpVector) < 0.99 then
		var5 = rotBtwnUnit(UpVector, var6) * var5
		UpVector = var6
	end
	local var8 = t._alignMat(var6, var7, var5)
	local _2, v9, _3 = (var8:Inverse() * instance):ToOrientation()
	local p = instance.p
	local vector10 = Spring.new(p, Vector3.new(), 0.8, 50)
	local vector11 = Spring.new(p, Vector3.new(), 0.7, 30)
	local vector12 = Spring.new(var8.RightVector, Vector3.new(), 0.8, 50)
	local vector13 = Spring.new(var8.UpVector, Vector3.new(), 0.8, 50)
	local instance14 = Spring.new(v9, 0, 0.8, 30)
	local var15 = 0
	local function doRotate(self, p2, p3)
		local instance = os.clock()
		local instance2 = instance - p3
		local instance3 = if instance2 > 0.1 then math.min(12, instance2 / 0.1 + 1) else 1
		if not (instance - var15 < 0.1) then
			var15 = instance
			if self then
				v9 = v9 + 0.08726646259971647 * instance3
			elseif p2 then
				v9 = v9 - 0.08726646259971647 * instance3
			end
			v9 = math.floor(v9 / 0.08726646259971647 + 0.5) * 0.08726646259971647
			instance14:SetTarget(v9)
		end
	end
	local function attemptPlaceCurrentHomeItem()
		t._maid.listenForFeedback = self._placeRemote.OnClientEvent:Connect(function(p12)
			t._maid.listenForFeedback = nil
			if not p12 and self._obj then
				self._obj:SetPrimaryPartCFrame(self:TranslateCf(instance))
			end
		end)
		local vector12, instance2, v32 = t.getTargetPosition(t3)
		self:SetServerCFrame((self:TranslateCf(t._alignMat(instance2, v32, var5) * CFrame.Angles(0, v9, 0) + vector12)))
		instance3 = true
		t.stopDrag()
	end
	local var16 = Roact.mount(createElement("ScreenGui", {
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
					t.attemptDeleteCurrentHomeItem()
				end,
				onClickPlace = function()
					attemptPlaceCurrentHomeItem()
				end,
				onDownRight = function()
					local instance = os.clock()
					instance2.rotateHeartbeat = RunService.Heartbeat:Connect(function()
						local instance2 = os.clock()
						local instance3 = instance2 - instance
						local var4 = if instance3 > 0.1 then math.min(12, instance3 / 0.1 + 1) else 1
						if not (instance2 - var15 < 0.1) then
							var15 = instance2
							v9 = v9 - 0.08726646259971647 * var4
							v9 = math.floor(v9 / 0.08726646259971647 + 0.5) * 0.08726646259971647
							instance14:SetTarget(v9)
						end
					end)
				end,
				onUpRight = function()
					instance2.rotateHeartbeat = nil
				end,
				onDownLeft = function()
					local instance = os.clock()
					instance2.rotateHeartbeat = RunService.Heartbeat:Connect(function()
						local instance2 = os.clock()
						local instance3 = instance2 - instance
						local var4 = if instance3 > 0.1 then math.min(12, instance3 / 0.1 + 1) else 1
						if not (instance2 - var15 < 0.1) then
							var15 = instance2
							v9 = v9 + 0.08726646259971647 * var4
							v9 = math.floor(v9 / 0.08726646259971647 + 0.5) * 0.08726646259971647
							instance14:SetTarget(v9)
						end
					end)
				end,
				onUpLeft = function()
					instance2.rotateHeartbeat = nil
				end,
				showPlace = InputUtils.isTouch()
			})
		})
	}), Players.LocalPlayer.PlayerGui, "ItemPlacerGui")
	instance2:GiveTask(function()
		Roact.unmount(var16)
	end)
	instance2:GiveTask(UserInputService.InputEnded:Connect(function(self, p2)
		if not p2 and self.UserInputType == Enum.UserInputType.MouseButton1 then
			instance2.rotateHeartbeat = nil
		end
	end))
	instance2:GiveTask(UserInputService.InputBegan:Connect(function(self, p2)
		if not p2 and (self.UserInputType == Enum.UserInputType.Keyboard or self.UserInputType == Enum.UserInputType.Gamepad1) then
			local instance = self.KeyCode == Enum.KeyCode.Q or self.KeyCode == Enum.KeyCode.ButtonL2
			local var22 = self.KeyCode == Enum.KeyCode.E or self.KeyCode == Enum.KeyCode.ButtonR2
			if var22 or instance then
				local instance3 = os.clock()
				instance2.waitForEnd = self:GetPropertyChangedSignal("UserInputState"):Connect(function()
					if self.UserInputState == Enum.UserInputState.End then
						instance2.waitForEnd = nil
						instance2.rotateHeartbeat = nil
					end
				end)
				instance2.rotateHeartbeat = RunService.Heartbeat:Connect(function()
					doRotate(instance, var22, instance3)
				end)
			end
		end
	end))
	instance2:GiveTask(RunService.Heartbeat:Connect(function()
		local instance, instance2, instance3 = t.getTargetPosition(t3)
		if instance then
			local var4, _ = vector10:SetTarget(instance)
			local _2, v52 = vector11:SetTarget(instance)
			local var6 = instance14:Update()
			if instance2:Dot(UpVector) < 0.99 then
				var5 = rotBtwnUnit(UpVector, instance2) * var5
				UpVector = instance2
			end
			local var7 = t._alignMat(instance2, instance3, var5)
			local var8 = CFrame.fromMatrix(Vector3.new(0, 0, 0), vector12:SetTarget(var7.RightVector).Unit, vector13:SetTarget(var7.UpVector).Unit)
			local cframe92 = self:TranslateCf(var7 * CFrame.Angles(0, v9, 0) + instance)
			local vector102 = self:IsValidUpDot((cframe92.UpVector:Dot(Vector3.new(0, 1, 0))))
			Part.Transparency = if self:IsWithinBoundsCached(cframe92) and vector102 then 1 else 0.5
			self:SetCFrame((self:TranslateCf(var8 * CFrame.Angles(-v52.z * 0.0015, 0, v52.x * 0.0015) * CFrame.Angles(0, var6, 0) + var4)))
		end
	end))
	local function inputBegan(self, p2)
		local instance = if self.UserInputType == Enum.UserInputType.Gamepad1 then self.KeyCode == Enum.KeyCode.ButtonA else false
		if (not p2 or instance) and (self.UserInputType == Enum.UserInputType.MouseButton1 or instance) then
			attemptPlaceCurrentHomeItem()
		end
	end
	instance2:GiveTask(UserInputService.InputBegan:Connect(inputBegan))
	t.onDragStarted:Fire()
end
function t._alignMat(self, p2, p3)
	local t = { p2.LookVector, p2.RightVector, p2.UpVector }
	local instance = getClosestVecDual(t, self)
	if table.find(t, instance) then
		table.remove(t, table.find(t, instance))
	end
	if table.find(t, -instance) then
		table.remove(t, table.find(t, -instance))
	end
	return p3 * rotBtwnUnit(Vector3.new(1, 0, 0), p3:VectorToObjectSpace((getClosestVecDual(t, p3:VectorToWorldSpace(Vector3.new(1, 0, 0))))))
end
function t.stopDrag()
	t._maid.placeMaid = nil
	t._lastDragEnd = os.clock()
	t.onDragEnded:Fire()
end
function t.isDragging()
	return t._maid and t._maid.placeMaid ~= nil
end
function t.attemptDeleteCurrentHomeItem()
	assert(t.isDragging())
	local _currentHomeItem = t._currentHomeItem
	assert(_currentHomeItem ~= nil)
	t.stopDrag()
	_currentHomeItem:AttemptDelete()
end
function t.getTimeSinceLastDragStart()
	return os.clock() - t._lastDragStart
end
function t.getTimeSinceLastDragEnd()
	return os.clock() - t._lastDragEnd
end
function t.createAndDrag(self)
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
	local instance = HomeSystem.queryCurrentStandingHome()
	assert(instance ~= nil)
	HomeItemSystem._maid._listenNewItem = instance._homeItemNewRemote.OnClientEvent:Connect(function(self)
		HomeItemSystem._maid._listenNewItem = nil
		if self.id == HomeConsts.ENUM_HOME_ITEM_NEW_RESULT.SUCCESS then
			StreamingHelperUtils.yieldForObjValuePopulated(self.modelPtr)
			BinderUtils.promiseBoundClass(HomeItemBinder, self.modelPtr.Value):andThen(function(self)
				t.startDrag(self)
				t._maid.placeMaid:GiveTask(function()
					homeStore:dispatch({
						type = "setVisible",
						value = true
					})
				end)
			end):catch(warn)
		elseif self.id == HomeConsts.ENUM_HOME_ITEM_NEW_RESULT.TOO_MANY then
			Notification.new({
				Text = "Too many items placed... try deleting some."
			})
			homeStore:dispatch({
				type = "setVisible",
				value = true
			})
		elseif self.id == HomeConsts.ENUM_HOME_ITEM_NEW_RESULT.ALL_OWNED_PLACED then
			Notification.new({
				Text = "You placed all of these that you own..."
			})
			homeStore:dispatch({
				type = "setVisible",
				value = true
			})
		elseif self.id == HomeConsts.ENUM_HOME_ITEM_NEW_RESULT.MAX_PLACED then
			Notification.new({
				Text = "You reached the placement limit for this item..."
			})
			homeStore:dispatch({
				type = "setVisible",
				value = true
			})
		else
			error(("Unhandled result id: %d"):format(self.id))
		end
	end)
	instance:AttemptCreateHomeItem(self)
end
return t
