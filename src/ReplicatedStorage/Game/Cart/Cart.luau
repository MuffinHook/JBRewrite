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
function t.new(p1) --[[ Line: 19 | Upvalues: t (copy), RxInstanceUtils (copy), Maid (copy), CartConsts (copy), HttpService (copy), BinderUtils (copy), OwnedPartBinder (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	RxInstanceUtils.yieldForProperty(p1, "PrimaryPart")
	t2._maid = Maid.new()
	t2._obj = p1
	t2._firstSegmentValue = p1:WaitForChild(CartConsts.FIRST_SEGMENT_VALUE_NAME)
	t2._secondSegmentValue = p1:WaitForChild(CartConsts.SECOND_SEGMENT_VALUE_NAME)
	t2._graphValue = p1:WaitForChild(CartConsts.GRAPH_VALUE_NAME)
	t2._offsetValue = p1:WaitForChild(CartConsts.OFFSET_VALUE_NAME)
	t2._updatedAtValue = p1:WaitForChild(CartConsts.UPDATED_AT_VALUE_NAME)
	t2._seatOwnedPartValue = p1:WaitForChild(CartConsts.SEAT_OWNED_PART_VALUE_NAME)
	t2._yOffset = 1
	t2._graph = nil
	local function decodeGraphStr() --[[ Line: 38 | Upvalues: t2 (copy), HttpService (ref) ]]
		local _graphValue = t2._graphValue.Value
		if _graphValue then
			t2._graph = HttpService:JSONDecode(_graphValue)
		else
			t2._graph = nil
		end
	end
	local _graphValue = t2._graphValue.Value
	if _graphValue then
		t2._graph = HttpService:JSONDecode(_graphValue)
	else
		t2._graph = nil
	end
	t2._maid:GiveTask(t2._graphValue.Changed:Connect(decodeGraphStr))
	t2._maid:GiveTask(t2._firstSegmentValue.Changed:Connect(function() --[[ Line: 49 | Upvalues: t2 (copy) ]]
		t2:_onSegmentUpdate()
	end))
	t2._maid:GiveTask(t2._secondSegmentValue.Changed:Connect(function() --[[ Line: 52 | Upvalues: t2 (copy) ]]
		t2:_onSegmentUpdate()
	end))
	t2:_onSegmentUpdate()
	t2._maid._seatMaid = Maid.new()
	local v2 = nil
	local function onOwnedPart(p1) --[[ Line: 59 | Upvalues: v2 (ref), t2 (copy), RxInstanceUtils (ref), BinderUtils (ref), OwnedPartBinder (ref) ]]
		if v2 then
			v2:cancel()
			v2 = nil
		end
		t2._ownedPartSeat = nil
		if p1 then
			t2._maid._onSeated = RxInstanceUtils.observeOneChildNamed(p1, "SeatWeld", function(p1, p2) --[[ Line: 69 | Upvalues: t2 (ref) ]]
				local v1
				if p1 then
					local Part0 = p1.Part0
					assert(Part0:IsA("BasePart"))
					v1 = Part0.Parent
					assert(v1 and v1:IsA("Model"), "SeatWeld.Part0.Parent was a: " .. (v1 and v1.ClassName or "nil"))
				else
					v1 = nil
				end
				p2:GiveTask(function() --[[ Line: 80 | Upvalues: t2 (ref) ]]
					t2._maid._seatMaid:DoCleaning()
					t2:_onSeated(nil, t2._maid._seatMaid)
				end)
				t2._maid._seatMaid:DoCleaning()
				t2:_onSeated(v1, t2._maid._seatMaid)
			end)
			v2 = BinderUtils.promiseBoundClass(OwnedPartBinder, p1):andThen(function(p1) --[[ Line: 88 | Upvalues: t2 (ref) ]]
				t2._ownedPartSeat = p1
			end)
		else
			t2._maid._onSeated = nil
		end
	end
	onOwnedPart(t2._seatOwnedPartValue.Value)
	t2._maid:GiveTask(t2._seatOwnedPartValue.Changed:Connect(onOwnedPart))
	return t2
end
function t.GetOnSeatedSignal(p1) --[[ Line: 103 | Upvalues: Signal (copy) ]]
	if not p1._onSeatedSignal then
		p1._onSeatedSignal = Signal.new()
		p1._maid:GiveTask(p1._onSeatedSignal)
	end
	return p1._onSeatedSignal
end
function t._onSeated(p1, p2, p3) --[[ Line: 110 | Upvalues: CharacterUtil (copy), ReplicatedStorage (copy) ]]
	if p2 then
		local Humanoid = p2:FindFirstChild("Humanoid")
		CharacterUtil.stopAnims(Humanoid)
		Humanoid.Sit = true
		local v1 = Humanoid:FindFirstChildOfClass("Animator"):LoadAnimation(ReplicatedStorage.Resource.CartSitAnimation)
		CharacterUtil.setHumanoidEnabled(Humanoid, false)
		v1:AdjustSpeed(0)
		v1:Play()
		p3:GiveTask(function() --[[ Line: 126 | Upvalues: Humanoid (copy) ]]
			Humanoid.Sit = false
		end)
		p3:GiveTask(function() --[[ Line: 129 | Upvalues: v1 (copy) ]]
			v1:Stop()
		end)
		p3:GiveTask(v1)
		p3:GiveTask(function() --[[ Line: 133 | Upvalues: CharacterUtil (ref), Humanoid (copy) ]]
			CharacterUtil.setHumanoidEnabled(Humanoid, true)
		end)
	end
	p1._occupant = p2
	if p1._onSeatedSignal then
		p1._onSeatedSignal:Fire(p2, p3)
	end
end
function t.GetOccupant(p1) --[[ Line: 142 ]]
	return p1._occupant
end
function t.GetFirstSegment(p1) --[[ Line: 145 ]]
	return p1._firstSegmentValue.Value
end
function t.GetSecondSegment(p1) --[[ Line: 148 ]]
	return p1._secondSegmentValue.Value
end
function t._startUpdate(p1) --[[ Line: 151 | Upvalues: RunService (copy), Time (copy), GraphUtils (copy), CartUtils (copy) ]]
	p1._maid._updateLoop = RunService.Heartbeat:Connect(function() --[[ Line: 152 | Upvalues: Time (ref), p1 (copy), GraphUtils (ref), CartUtils (ref) ]]
		local v1 = Time.GetNowSync() - p1:GetUpdatedAt()
		local v2 = GraphUtils.calculateDist(p1._graph, v1) + p1:GetOffset()
		local v3, v4 = CartUtils.calculateSegment(p1._rail, v2 - 1.5)
		local v5 = CartUtils.calculatePosition(p1._rail, v3, v4)
		local v6, v7 = CartUtils.calculateSegment(p1._rail, v2 + 1.5)
		local v8 = CartUtils.calculatePosition(p1._rail, v6, v7)
		p1._obj.PrimaryPart.CFrame = CFrame.lookAt(Vector3.new(), v8 - v5) * CFrame.new(0, p1._yOffset, 0) + (v5 + v8) * 0.5
		if p1._ownedPartSeat then
			p1._ownedPartSeat._obj.CFrame = p1._obj:FindFirstChild("Seat").CFrame
			p1._ownedPartSeat._obj.AssemblyLinearVelocity = Vector3.new()
		end
	end)
end
function t._onSegmentUpdate(p1) --[[ Line: 180 | Upvalues: CartUtils (copy), Maid (copy) ]]
	local v1 = p1:GetFirstSegment()
	if v1 then
		local v2 = p1:GetSecondSegment()
		if v2 then
			p1._rail = CartUtils.computeRail(v1, v2)
			p1:_startUpdate()
			p1._maid.railUpdateMaid = Maid.new()
			for i, v in ipairs(p1._rail.listSegment) do
				p1._maid.railUpdateMaid:GiveTask(v._front.Changed:Connect(function() --[[ Line: 197 | Upvalues: p1 (copy) ]]
					p1:_onSegmentUpdate()
				end))
				p1._maid.railUpdateMaid:GiveTask(v._back.Changed:Connect(function() --[[ Line: 201 | Upvalues: p1 (copy) ]]
					p1:_onSegmentUpdate()
				end))
			end
		end
	end
end
function t.GetUpdatedAt(p1) --[[ Line: 207 ]]
	return p1._updatedAtValue.Value
end
function t.GetGraph(p1) --[[ Line: 210 ]]
	return p1._graphValue.Value
end
function t.GetOffset(p1) --[[ Line: 213 ]]
	return p1._offsetValue.Value
end
function t.Destroy(p1) --[[ Line: 216 ]]
	local _maid = p1._maid
	p1._maid = nil
	setmetatable(p1, nil)
	_maid:Destroy()
end
return t