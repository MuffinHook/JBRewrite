local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local CharacterUtil = require(ReplicatedStorage.Game.CharacterUtil)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local Time = require(ReplicatedStorage.Module.Time)
local BinderUtils = require(ReplicatedStorage.Std.Binder.BinderUtils)
local CartConsts = require(script.Parent.CartConsts)
local CartUtils = require(script.Parent.CartUtils)
local GraphUtils = require(script.Parent.GraphUtils)
local OwnedPartBinder = require(ReplicatedStorage.Game.OwnedPart.OwnedPartBinder)
local Cart = {}
Cart.__index = Cart
Cart.__ClassName = "Cart"
function Cart.new(cartObject)
	local instance = {}
	setmetatable(instance, Cart)
	RxInstanceUtils.yieldForProperty(cartObject, "PrimaryPart")
	instance._maid = Maid.new()
	instance._obj = cartObject
	instance._firstSegmentValue = cartObject:WaitForChild(CartConsts.FIRST_SEGMENT_VALUE_NAME)
	instance._secondSegmentValue = cartObject:WaitForChild(CartConsts.SECOND_SEGMENT_VALUE_NAME)
	instance._graphValue = cartObject:WaitForChild(CartConsts.GRAPH_VALUE_NAME)
	instance._offsetValue = cartObject:WaitForChild(CartConsts.OFFSET_VALUE_NAME)
	instance._updatedAtValue = cartObject:WaitForChild(CartConsts.UPDATED_AT_VALUE_NAME)
	instance._seatOwnedPartValue = cartObject:WaitForChild(CartConsts.SEAT_OWNED_PART_VALUE_NAME)
	instance._yOffset = 1
	instance._graph = nil
	local function decodeGraphStr()
		local _graphValue = instance._graphValue.Value
		if _graphValue then
			instance._graph = HttpService:JSONDecode(_graphValue)
		else
			instance._graph = nil
		end
	end
	local _graphValue = instance._graphValue.Value
	if _graphValue then
		instance._graph = HttpService:JSONDecode(_graphValue)
	else
		instance._graph = nil
	end
	instance._maid:GiveTask(instance._graphValue.Changed:Connect(decodeGraphStr))
	instance._maid:GiveTask(instance._firstSegmentValue.Changed:Connect(function()
		instance:_onSegmentUpdate()
	end))
	instance._maid:GiveTask(instance._secondSegmentValue.Changed:Connect(function()
		instance:_onSegmentUpdate()
	end))
	instance:_onSegmentUpdate()
	instance._maid._seatMaid = Maid.new()
	local seatPromise = nil
	local function onOwnedPart(seatOwnedPart)
		if seatPromise then
			seatPromise:cancel()
			seatPromise = nil
		end
		instance._ownedPartSeat = nil
		if seatOwnedPart then
			instance._maid._onSeated = RxInstanceUtils.observeOneChildNamed(seatOwnedPart, "SeatWeld", function(weld, maid)
				local character
				if weld then
					local Part0 = weld.Part0
					assert(Part0:IsA("BasePart"))
					character = Part0.Parent
					assert(character and character:IsA("Model"), "SeatWeld.Part0.Parent was a: " .. (character and character.ClassName or "nil"))
				else
					character = nil
				end
				maid:GiveTask(function()
					instance._maid._seatMaid:DoCleaning()
					instance:_onSeated(nil, instance._maid._seatMaid)
				end)
				instance._maid._seatMaid:DoCleaning()
				instance:_onSeated(character, instance._maid._seatMaid)
			end)
			seatPromise = BinderUtils.promiseBoundClass(OwnedPartBinder, seatOwnedPart):andThen(function(boundClass)
				instance._ownedPartSeat = boundClass
			end)
		else
			instance._maid._onSeated = nil
		end
	end
	onOwnedPart(instance._seatOwnedPartValue.Value)
	instance._maid:GiveTask(instance._seatOwnedPartValue.Changed:Connect(onOwnedPart))
	return instance
end
function Cart.GetOnSeatedSignal(self)
	if not self._onSeatedSignal then
		self._onSeatedSignal = Signal.new()
		self._maid:GiveTask(self._onSeatedSignal)
	end
	return self._onSeatedSignal
end
function Cart._onSeated(self, character, maid)
	if character then
		local Humanoid = character:FindFirstChild("Humanoid")
		CharacterUtil.stopAnims(Humanoid)
		Humanoid.Sit = true
		local animation = Humanoid:FindFirstChildOfClass("Animator"):LoadAnimation(ReplicatedStorage.Resource.CartSitAnimation)
		CharacterUtil.setHumanoidEnabled(Humanoid, false)
		animation:AdjustSpeed(0)
		animation:Play()
		maid:GiveTask(function()
			Humanoid.Sit = false
		end)
		maid:GiveTask(function()
			animation:Stop()
		end)
		maid:GiveTask(animation)
		maid:GiveTask(function()
			CharacterUtil.setHumanoidEnabled(Humanoid, true)
		end)
	end
	self._occupant = character
	if self._onSeatedSignal then
		self._onSeatedSignal:Fire(character, maid)
	end
end
function Cart.GetOccupant(self)
	return self._occupant
end
function Cart.GetFirstSegment(self)
	return self._firstSegmentValue.Value
end
function Cart.GetSecondSegment(self)
	return self._secondSegmentValue.Value
end
function Cart._startUpdate(self)
	self._maid._updateLoop = RunService.Heartbeat:Connect(function()
		local elapsedTime = Time.GetNowSync() - self:GetUpdatedAt()
		local distance = GraphUtils.calculateDist(self._graph, elapsedTime) + self:GetOffset()
		local segment1Index, segment1Progress = CartUtils.calculateSegment(self._rail, distance - 1.5)
		local backPos = CartUtils.calculatePosition(self._rail, segment1Index, segment1Progress)
		local segment2Index, segment2Progress = CartUtils.calculateSegment(self._rail, distance + 1.5)
		local frontPos = CartUtils.calculatePosition(self._rail, segment2Index, segment2Progress)
		self._obj.PrimaryPart.CFrame = CFrame.lookAt(Vector3.new(), frontPos - backPos) * CFrame.new(0, self._yOffset, 0) + (backPos + frontPos) * 0.5
		if self._ownedPartSeat then
			self._ownedPartSeat._obj.CFrame = self._obj:FindFirstChild("Seat").CFrame
			self._ownedPartSeat._obj.AssemblyLinearVelocity = Vector3.new()
		end
	end)
end
function Cart._onSegmentUpdate(self)
	local firstSegment = self:GetFirstSegment()
	if firstSegment then
		local secondSegment = self:GetSecondSegment()
		if secondSegment then
			self._rail = CartUtils.computeRail(firstSegment, secondSegment)
			self:_startUpdate()
			self._maid.railUpdateMaid = Maid.new()
			for i, segment in ipairs(self._rail.listSegment) do
				self._maid.railUpdateMaid:GiveTask(segment._front.Changed:Connect(function()
					self:_onSegmentUpdate()
				end))
				self._maid.railUpdateMaid:GiveTask(segment._back.Changed:Connect(function()
					self:_onSegmentUpdate()
				end))
			end
		end
	end
end
function Cart.GetUpdatedAt(self)
	return self._updatedAtValue.Value
end
function Cart.GetGraph(self)
	return self._graphValue.Value
end
function Cart.GetOffset(self)
	return self._offsetValue.Value
end
function Cart.Destroy(self)
	local maidToDestroy = self._maid
	self._maid = nil
	setmetatable(self, nil)
	maidToDestroy:Destroy()
end
return Cart
