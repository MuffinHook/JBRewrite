-- Reviewed by Claude
-- variables reassigned
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
local t = {}
t.__index = t
t.__ClassName = "Cart"
function t.new(p1)
	local instance = {}
	setmetatable(instance, t)
	RxInstanceUtils.yieldForProperty(p1, "PrimaryPart")
	instance._maid = Maid.new()
	instance._obj = p1
	instance._firstSegmentValue = p1:WaitForChild(CartConsts.FIRST_SEGMENT_VALUE_NAME)
	instance._secondSegmentValue = p1:WaitForChild(CartConsts.SECOND_SEGMENT_VALUE_NAME)
	instance._graphValue = p1:WaitForChild(CartConsts.GRAPH_VALUE_NAME)
	instance._offsetValue = p1:WaitForChild(CartConsts.OFFSET_VALUE_NAME)
	instance._updatedAtValue = p1:WaitForChild(CartConsts.UPDATED_AT_VALUE_NAME)
	instance._seatOwnedPartValue = p1:WaitForChild(CartConsts.SEAT_OWNED_PART_VALUE_NAME)
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
	local function onOwnedPart(p1)
		if seatPromise then
			seatPromise:cancel()
			seatPromise = nil
		end
		instance._ownedPartSeat = nil
		if p1 then
			instance._maid._onSeated = RxInstanceUtils.observeOneChildNamed(p1, "SeatWeld", function(weld, maid)
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
			seatPromise = BinderUtils.promiseBoundClass(OwnedPartBinder, p1):andThen(function(p1)
				instance._ownedPartSeat = p1
			end)
		else
			instance._maid._onSeated = nil
		end
	end
	onOwnedPart(instance._seatOwnedPartValue.Value)
	instance._maid:GiveTask(instance._seatOwnedPartValue.Changed:Connect(onOwnedPart))
	return instance
end
function t.GetOnSeatedSignal(p1)
	if not p1._onSeatedSignal then
		p1._onSeatedSignal = Signal.new()
		p1._maid:GiveTask(p1._onSeatedSignal)
	end
	return p1._onSeatedSignal
end
function t._onSeated(p1, p2, p3)
	if p2 then
		local Humanoid = p2:FindFirstChild("Humanoid")
		CharacterUtil.stopAnims(Humanoid)
		Humanoid.Sit = true
		local animation = Humanoid:FindFirstChildOfClass("Animator"):LoadAnimation(ReplicatedStorage.Resource.CartSitAnimation)
		CharacterUtil.setHumanoidEnabled(Humanoid, false)
		animation:AdjustSpeed(0)
		animation:Play()
		p3:GiveTask(function()
			Humanoid.Sit = false
		end)
		p3:GiveTask(function()
			animation:Stop()
		end)
		p3:GiveTask(animation)
		p3:GiveTask(function()
			CharacterUtil.setHumanoidEnabled(Humanoid, true)
		end)
	end
	p1._occupant = p2
	if p1._onSeatedSignal then
		p1._onSeatedSignal:Fire(p2, p3)
	end
end
function t.GetOccupant(p1)
	return p1._occupant
end
function t.GetFirstSegment(p1)
	return p1._firstSegmentValue.Value
end
function t.GetSecondSegment(p1)
	return p1._secondSegmentValue.Value
end
function t._startUpdate(p1)
	p1._maid._updateLoop = RunService.Heartbeat:Connect(function()
		local elapsedTime = Time.GetNowSync() - p1:GetUpdatedAt()
		local distance = GraphUtils.calculateDist(p1._graph, elapsedTime) + p1:GetOffset()
		local segment1Index, segment1Progress = CartUtils.calculateSegment(p1._rail, distance - 1.5)
		local backPos = CartUtils.calculatePosition(p1._rail, segment1Index, segment1Progress)
		local segment2Index, segment2Progress = CartUtils.calculateSegment(p1._rail, distance + 1.5)
		local frontPos = CartUtils.calculatePosition(p1._rail, segment2Index, segment2Progress)
		p1._obj.PrimaryPart.CFrame = CFrame.lookAt(Vector3.new(), frontPos - backPos) * CFrame.new(0, p1._yOffset, 0) + (backPos + frontPos) * 0.5
		if p1._ownedPartSeat then
			p1._ownedPartSeat._obj.CFrame = p1._obj:FindFirstChild("Seat").CFrame
			p1._ownedPartSeat._obj.AssemblyLinearVelocity = Vector3.new()
		end
	end)
end
function t._onSegmentUpdate(p1)
	local firstSegment = p1:GetFirstSegment()
	if firstSegment then
		local secondSegment = p1:GetSecondSegment()
		if secondSegment then
			p1._rail = CartUtils.computeRail(firstSegment, secondSegment)
			p1:_startUpdate()
			p1._maid.railUpdateMaid = Maid.new()
			for i, segment in ipairs(p1._rail.listSegment) do
				p1._maid.railUpdateMaid:GiveTask(segment._front.Changed:Connect(function()
					p1:_onSegmentUpdate()
				end))
				p1._maid.railUpdateMaid:GiveTask(segment._back.Changed:Connect(function()
					p1:_onSegmentUpdate()
				end))
			end
		end
	end
end
function t.GetUpdatedAt(p1)
	return p1._updatedAtValue.Value
end
function t.GetGraph(p1)
	return p1._graphValue.Value
end
function t.GetOffset(p1)
	return p1._offsetValue.Value
end
function t.Destroy(p1)
	local _maid = p1._maid
	p1._maid = nil
	setmetatable(p1, nil)
	_maid:Destroy()
end
return t
