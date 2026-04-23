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
local function getClosestVecDual(p1, p2) --[[ Line: 25 ]]
	local v1 = p1[1]
	local v2 = (-1 / 0)
	for v4, v5 in p1 do
		local v3
		local v6 = v5:Dot(p2)
		local v7 = math.abs(v6)
		if v2 < v7 then
			v3 = if v6 > 0 then 1 else -1
			v2 = v7
			v1 = v5 * v3
		end
	end
	return v1
end
local function rotBtwnUnit(p1, p2) --[[ Line: 39 ]]
	local v1 = p1:Cross(p2)
	local v2 = p1:Dot(p2)
	if v2 < -0.999 then
		return CFrame.Angles(math.pi, 0, 0)
	else
		return CFrame.new(0, 0, 0, v1.x, v1.y, v1.z, v2 + 1)
	end
end
local function roundN(p1, p2) --[[ Line: 48 ]]
	return math.floor(p1 / p2 + 0.5) * p2
end
local t = {
	_maid = nil,
	_lastDragStart = 0,
	_lastDragEnd = 0,
	_currentHomeItem = nil,
	onDragStarted = Signal.new(),
	onDragEnded = Signal.new()
}
function t.init() --[[ Line: 60 | Upvalues: Maid (copy), t (copy), HomeItemSystem (copy), HomeSystem (copy), ItemPlacerUtils (copy), HomeItemBinder (copy), UserInputService (copy) ]]
	local v1 = Maid.new()
	t._maid = v1
	local t2 = {}
	HomeItemSystem.onCustomizeStarted:Connect(function() --[[ Line: 66 | Upvalues: t (ref), HomeSystem (ref), ItemPlacerUtils (ref), t2 (copy), HomeItemBinder (ref), v1 (copy), UserInputService (ref) ]]
		local function inputBegan(p1, p2) --[[ Line: 67 | Upvalues: t (ref), HomeSystem (ref), ItemPlacerUtils (ref), t2 (ref), HomeItemBinder (ref) ]]
			local v1 = if p1.UserInputType == Enum.UserInputType.Gamepad1 then p1.KeyCode == Enum.KeyCode.ButtonA else false
			if (not p2 or v1) and ((p1.UserInputType == Enum.UserInputType.MouseButton1 or (p1.UserInputType == Enum.UserInputType.Touch or v1)) and (not t.isDragging() and (not (t.getTimeSinceLastDragEnd() < 0.1) and HomeSystem.queryCurrentStandingHome()))) then
				local v2 = ItemPlacerUtils.raycastMouse(t2, true)
				if v2 then
					local v3 = v2.Instance
					for i, v in ipairs(HomeItemBinder:GetAll()) do
						if v3:IsDescendantOf(v:GetObj()) then
							t.startDrag(v)
							return
						end
					end
				end
			end
		end
		v1._listenForCustomizeTouch = UserInputService.TouchTap:Connect(inputBegan)
		v1._listenForCustomizeClick = UserInputService.InputBegan:Connect(inputBegan)
	end)
	HomeItemSystem.onCustomizeEnded:Connect(function() --[[ Line: 115 | Upvalues: v1 (copy), t (ref) ]]
		v1._listenForCustomizeClick = nil
		v1._listenForCustomizeTouch = nil
		if t.isDragging() then
			t.stopDrag()
		end
	end)
	HomeSystem.onExited:Connect(function() --[[ Line: 123 | Upvalues: v1 (copy), t (ref) ]]
		v1._listenForCustomizeClick = nil
		v1._listenForCustomizeTouch = nil
		if t.isDragging() then
			t.stopDrag()
		end
	end)
	HomeItemSystem.onAttemptPlaceItem:Connect(function(p1) --[[ Line: 131 | Upvalues: t (ref) ]]
		t.createAndDrag(p1.name)
	end)
	HomeItemSystem.onAttemptDeleteItem:Connect(function() --[[ Line: 136 | Upvalues: t (ref) ]]
		t.attemptDeleteCurrentHomeItem()
	end)
end
function t.getTargetPosition(p1) --[[ Line: 142 | Upvalues: ItemPlacerUtils (copy) ]]
	local v1 = ItemPlacerUtils.raycastMouse(p1)
	if v1 then
		local v2 = v1.Instance
		local v3 = v2.CFrame:PointToObjectSpace(v1.Position)
		return v2.CFrame:PointToWorldSpace((Vector3.new(math.floor(v3.x / 0.1 + 0.5) * 0.1, v3.y, math.floor(v3.z / 0.1 + 0.5) * 0.1))), v1.Normal, v2.CFrame
	end
end
function t.startDrag(p1) --[[ Line: 157 | Upvalues: t (copy), Maid (copy), homeStore (copy), LocalPlayer (copy), rotBtwnUnit (copy), Spring (copy), Roact (copy), createElement (copy), PlacerApp (copy), RunService (copy), InputUtils (copy), Players (copy), UserInputService (copy) ]]
	t._lastDragStart = os.clock()
	local PrimaryPart = p1:GetObj().PrimaryPart
	local v1 = p1:UntranslateCf(PrimaryPart.CFrame)
	local v2 = Maid.new()
	t._maid.placeMaid = v2
	t._currentHomeItem = p1
	v2:GiveTask(function() --[[ Line: 167 | Upvalues: t (ref) ]]
		t._currentHomeItem = nil
	end)
	p1:SetBeingDragged(true)
	v2:GiveTask(function() --[[ Line: 171 | Upvalues: p1 (copy) ]]
		p1:SetBeingDragged(false)
	end)
	homeStore:dispatch({
		type = "setVisible",
		value = false
	})
	v2:GiveTask(function() --[[ Line: 180 | Upvalues: homeStore (ref) ]]
		homeStore:dispatch({
			type = "setVisible",
			value = true
		})
	end)
	local v3 = false
	v2:GiveTask(function() --[[ Line: 188 | Upvalues: v3 (ref), p1 (copy), v1 (copy) ]]
		if not v3 then
			if p1._obj then
				p1._obj:SetPrimaryPartCFrame(p1:TranslateCf(v1))
			end
			if not p1:IsPlaced() then
				p1:AttemptDelete()
			end
		end
	end)
	p1:CacheSurfaces()
	v2:GiveTask(function() --[[ Line: 201 | Upvalues: p1 (copy) ]]
		p1:ClearCacheSurfaces()
	end)
	local t2 = {}
	for i, v in ipairs(p1:GetObj():GetDescendants()) do
		if v:IsA("BasePart") and v.CanCollide then
			table.insert(t2, v)
			v.CanCollide = false
		end
	end
	v2:GiveTask(function() --[[ Line: 221 | Upvalues: t2 (copy) ]]
		for i, v in ipairs(t2) do
			v.CanCollide = true
		end
	end)
	local Humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
	v2:GiveTask(Humanoid.Changed:connect(function() --[[ Line: 232 | Upvalues: Humanoid (copy) ]]
		Humanoid.Jump = false
	end))
	if Humanoid.SeatPart then
		Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
	v2:GiveTask(function() --[[ Line: 239 | Upvalues: Humanoid (copy) ]]
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
	Part.Parent = p1:GetObj()
	v2:GiveTask(Part)
	local t3 = { p1:GetObj(), LocalPlayer.Character }
	local v4 = v1
	local v5 = v4 - v4.p
	local _, v6, v7 = t.getTargetPosition(t3)
	local UpVector = v5.UpVector
	if v6:Dot(UpVector) < 0.99 then
		v5 = rotBtwnUnit(UpVector, v6) * v5
		UpVector = v6
	end
	local v8 = t._alignMat(v6, v7, v5)
	local _2, v9, _3 = (v8:Inverse() * v1):ToOrientation()
	local p = v1.p
	local v10 = Spring.new(p, Vector3.new(), 0.8, 50)
	local v11 = Spring.new(p, Vector3.new(), 0.7, 30)
	local v12 = Spring.new(v8.RightVector, Vector3.new(), 0.8, 50)
	local v13 = Spring.new(v8.UpVector, Vector3.new(), 0.8, 50)
	local v14 = Spring.new(v9, 0, 0.8, 30)
	local v15 = 0
	local function doRotate(p1, p2, p3) --[[ Line: 277 | Upvalues: v15 (ref), v9 (ref), v14 (copy) ]]
		local v1 = os.clock()
		local v2 = v1 - p3
		local v3 = if v2 > 0.1 then math.min(12, v2 / 0.1 + 1) else 1
		if not (v1 - v15 < 0.1) then
			v15 = v1
			if p1 then
				v9 = v9 + 0.08726646259971647 * v3
			elseif p2 then
				v9 = v9 - 0.08726646259971647 * v3
			end
			v9 = math.floor(v9 / 0.08726646259971647 + 0.5) * 0.08726646259971647
			v14:SetTarget(v9)
		end
	end
	local function attemptPlaceCurrentHomeItem() --[[ Line: 295 | Upvalues: t (ref), p1 (copy), v1 (copy), t3 (copy), v5 (ref), v9 (ref), v3 (ref) ]]
		t._maid.listenForFeedback = p1._placeRemote.OnClientEvent:Connect(function(p12) --[[ Line: 296 | Upvalues: t (ref), p1 (ref), v1 (ref) ]]
			t._maid.listenForFeedback = nil
			if not p12 and p1._obj then
				p1._obj:SetPrimaryPartCFrame(p1:TranslateCf(v1))
			end
		end)
		local v12, v2, v32 = t.getTargetPosition(t3)
		p1:SetServerCFrame((p1:TranslateCf(t._alignMat(v2, v32, v5) * CFrame.Angles(0, v9, 0) + v12)))
		v3 = true
		t.stopDrag()
	end
	local v16 = Roact.mount(createElement("ScreenGui", {
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
				onClickDelete = function() --[[ Name: onClickDelete | Line: 333 | Upvalues: t (ref) ]]
					t.attemptDeleteCurrentHomeItem()
				end,
				onClickPlace = function() --[[ Name: onClickPlace | Line: 336 | Upvalues: attemptPlaceCurrentHomeItem (copy) ]]
					attemptPlaceCurrentHomeItem()
				end,
				onDownRight = function() --[[ Name: onDownRight | Line: 339 | Upvalues: v2 (copy), RunService (ref), v15 (ref), v9 (ref), v14 (copy) ]]
					local v1 = os.clock()
					v2.rotateHeartbeat = RunService.Heartbeat:Connect(function() --[[ Line: 341 | Upvalues: v1 (copy), v15 (ref), v9 (ref), v14 (ref) ]]
						local v2 = os.clock()
						local v3 = v2 - v1
						local v4 = if v3 > 0.1 then math.min(12, v3 / 0.1 + 1) else 1
						if not (v2 - v15 < 0.1) then
							v15 = v2
							v9 = v9 - 0.08726646259971647 * v4
							v9 = math.floor(v9 / 0.08726646259971647 + 0.5) * 0.08726646259971647
							v14:SetTarget(v9)
						end
					end)
				end,
				onUpRight = function() --[[ Name: onUpRight | Line: 345 | Upvalues: v2 (copy) ]]
					v2.rotateHeartbeat = nil
				end,
				onDownLeft = function() --[[ Name: onDownLeft | Line: 348 | Upvalues: v2 (copy), RunService (ref), v15 (ref), v9 (ref), v14 (copy) ]]
					local v1 = os.clock()
					v2.rotateHeartbeat = RunService.Heartbeat:Connect(function() --[[ Line: 350 | Upvalues: v1 (copy), v15 (ref), v9 (ref), v14 (ref) ]]
						local v2 = os.clock()
						local v3 = v2 - v1
						local v4 = if v3 > 0.1 then math.min(12, v3 / 0.1 + 1) else 1
						if not (v2 - v15 < 0.1) then
							v15 = v2
							v9 = v9 + 0.08726646259971647 * v4
							v9 = math.floor(v9 / 0.08726646259971647 + 0.5) * 0.08726646259971647
							v14:SetTarget(v9)
						end
					end)
				end,
				onUpLeft = function() --[[ Name: onUpLeft | Line: 354 | Upvalues: v2 (copy) ]]
					v2.rotateHeartbeat = nil
				end,
				showPlace = InputUtils.isTouch()
			})
		})
	}), Players.LocalPlayer.PlayerGui, "ItemPlacerGui")
	v2:GiveTask(function() --[[ Line: 364 | Upvalues: Roact (ref), v16 (copy) ]]
		Roact.unmount(v16)
	end)
	v2:GiveTask(UserInputService.InputEnded:Connect(function(p1, p2) --[[ Line: 369 | Upvalues: v2 (copy) ]]
		if not p2 and p1.UserInputType == Enum.UserInputType.MouseButton1 then
			v2.rotateHeartbeat = nil
		end
	end))
	v2:GiveTask(UserInputService.InputBegan:Connect(function(p1, p2) --[[ Line: 377 | Upvalues: v2 (copy), RunService (ref), doRotate (copy) ]]
		if not p2 and (p1.UserInputType == Enum.UserInputType.Keyboard or p1.UserInputType == Enum.UserInputType.Gamepad1) then
			local v1 = p1.KeyCode == Enum.KeyCode.Q or p1.KeyCode == Enum.KeyCode.ButtonL2
			local v22 = p1.KeyCode == Enum.KeyCode.E or p1.KeyCode == Enum.KeyCode.ButtonR2
			if v22 or v1 then
				local v3 = os.clock()
				v2.waitForEnd = p1:GetPropertyChangedSignal("UserInputState"):Connect(function() --[[ Line: 393 | Upvalues: p1 (copy), v2 (ref) ]]
					if p1.UserInputState == Enum.UserInputState.End then
						v2.waitForEnd = nil
						v2.rotateHeartbeat = nil
					end
				end)
				v2.rotateHeartbeat = RunService.Heartbeat:Connect(function() --[[ Line: 399 | Upvalues: doRotate (ref), v1 (copy), v22 (copy), v3 (copy) ]]
					doRotate(v1, v22, v3)
				end)
			end
		end
	end))
	v2:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 406 | Upvalues: t (ref), t3 (copy), v10 (copy), v11 (copy), v14 (copy), UpVector (ref), v5 (ref), rotBtwnUnit (ref), v12 (copy), v13 (copy), p1 (copy), v9 (ref), Part (copy) ]]
		local v1, v2, v3 = t.getTargetPosition(t3)
		if v1 then
			local v4, _ = v10:SetTarget(v1)
			local _2, v52 = v11:SetTarget(v1)
			local v6 = v14:Update()
			if v2:Dot(UpVector) < 0.99 then
				v5 = rotBtwnUnit(UpVector, v2) * v5
				UpVector = v2
			end
			local v7 = t._alignMat(v2, v3, v5)
			local v8 = CFrame.fromMatrix(Vector3.new(0, 0, 0), v12:SetTarget(v7.RightVector).Unit, v13:SetTarget(v7.UpVector).Unit)
			local v92 = p1:TranslateCf(v7 * CFrame.Angles(0, v9, 0) + v1)
			local v102 = p1:IsValidUpDot((v92.UpVector:Dot(Vector3.new(0, 1, 0))))
			Part.Transparency = if p1:IsWithinBoundsCached(v92) and v102 then 1 else 0.5
			p1:SetCFrame((p1:TranslateCf(v8 * CFrame.Angles(-v52.z * 0.0015, 0, v52.x * 0.0015) * CFrame.Angles(0, v6, 0) + v4)))
		end
	end))
	local function inputBegan(p1, p2) --[[ Line: 445 | Upvalues: attemptPlaceCurrentHomeItem (copy) ]]
		local v1 = if p1.UserInputType == Enum.UserInputType.Gamepad1 then p1.KeyCode == Enum.KeyCode.ButtonA else false
		if (not p2 or v1) and (p1.UserInputType == Enum.UserInputType.MouseButton1 or v1) then
			attemptPlaceCurrentHomeItem()
		end
	end
	v2:GiveTask(UserInputService.InputBegan:Connect(inputBegan))
	t.onDragStarted:Fire()
end
function t._alignMat(p1, p2, p3) --[[ Line: 465 | Upvalues: getClosestVecDual (copy), rotBtwnUnit (copy) ]]
	local t = { p2.LookVector, p2.RightVector, p2.UpVector }
	local v1 = getClosestVecDual(t, p1)
	if table.find(t, v1) then
		table.remove(t, table.find(t, v1))
	end
	if table.find(t, -v1) then
		table.remove(t, table.find(t, -v1))
	end
	return p3 * rotBtwnUnit(Vector3.new(1, 0, 0), p3:VectorToObjectSpace((getClosestVecDual(t, p3:VectorToWorldSpace(Vector3.new(1, 0, 0))))))
end
function t.stopDrag() --[[ Line: 489 | Upvalues: t (copy) ]]
	t._maid.placeMaid = nil
	t._lastDragEnd = os.clock()
	t.onDragEnded:Fire()
end
function t.isDragging() --[[ Line: 494 | Upvalues: t (copy) ]]
	return t._maid and t._maid.placeMaid ~= nil
end
function t.attemptDeleteCurrentHomeItem() --[[ Line: 497 | Upvalues: t (copy) ]]
	assert(t.isDragging())
	local _currentHomeItem = t._currentHomeItem
	assert(_currentHomeItem ~= nil)
	t.stopDrag()
	_currentHomeItem:AttemptDelete()
end
function t.getTimeSinceLastDragStart() --[[ Line: 504 | Upvalues: t (copy) ]]
	return os.clock() - t._lastDragStart
end
function t.getTimeSinceLastDragEnd() --[[ Line: 507 | Upvalues: t (copy) ]]
	return os.clock() - t._lastDragEnd
end
function t.createAndDrag(p1) --[[ Line: 510 | Upvalues: homeStore (copy), HomeSystem (copy), HomeItemSystem (copy), HomeConsts (copy), StreamingHelperUtils (copy), BinderUtils (copy), HomeItemBinder (copy), t (copy), Notification (copy) ]]
	homeStore:dispatch({
		type = "setVisible",
		value = false
	})
	local function reopenUI() --[[ Line: 515 | Upvalues: homeStore (ref) ]]
		homeStore:dispatch({
			type = "setVisible",
			value = true
		})
	end
	local v1 = HomeSystem.queryCurrentStandingHome()
	assert(v1 ~= nil)
	HomeItemSystem._maid._listenNewItem = v1._homeItemNewRemote.OnClientEvent:Connect(function(p1) --[[ Line: 523 | Upvalues: HomeItemSystem (ref), HomeConsts (ref), StreamingHelperUtils (ref), BinderUtils (ref), HomeItemBinder (ref), t (ref), homeStore (ref), Notification (ref) ]]
		HomeItemSystem._maid._listenNewItem = nil
		if p1.id == HomeConsts.ENUM_HOME_ITEM_NEW_RESULT.SUCCESS then
			StreamingHelperUtils.yieldForObjValuePopulated(p1.modelPtr)
			BinderUtils.promiseBoundClass(HomeItemBinder, p1.modelPtr.Value):andThen(function(p1) --[[ Line: 529 | Upvalues: t (ref), homeStore (ref) ]]
				t.startDrag(p1)
				t._maid.placeMaid:GiveTask(function() --[[ Line: 532 | Upvalues: homeStore (ref) ]]
					homeStore:dispatch({
						type = "setVisible",
						value = true
					})
				end)
			end):catch(warn)
		elseif p1.id == HomeConsts.ENUM_HOME_ITEM_NEW_RESULT.TOO_MANY then
			Notification.new({
				Text = "Too many items placed... try deleting some."
			})
			homeStore:dispatch({
				type = "setVisible",
				value = true
			})
		elseif p1.id == HomeConsts.ENUM_HOME_ITEM_NEW_RESULT.ALL_OWNED_PLACED then
			Notification.new({
				Text = "You placed all of these that you own..."
			})
			homeStore:dispatch({
				type = "setVisible",
				value = true
			})
		elseif p1.id == HomeConsts.ENUM_HOME_ITEM_NEW_RESULT.MAX_PLACED then
			Notification.new({
				Text = "You reached the placement limit for this item..."
			})
			homeStore:dispatch({
				type = "setVisible",
				value = true
			})
		else
			error(("Unhandled result id: %d"):format(p1.id))
		end
	end)
	v1:AttemptCreateHomeItem(p1)
end
return t