local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local DoorConsts = require(script.Parent.DoorConsts)
local DoorUtils = require(script.Parent.DoorUtils)
local t = {}
t.__index = t
function t.new(p1, p2) --[[ Line: 13 | Upvalues: t (copy), Maid (copy), DoorConsts (copy), RxInstanceUtils (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2._maid = Maid.new()
	t2._updateCallback = nil
	t2._maid:GiveTask(p1:GetAttributeChangedSignal(DoorConsts.OPEN_ATTR_NAME):Connect(function() --[[ Line: 19 | Upvalues: p1 (copy), DoorConsts (ref), t2 (copy) ]]
		t2:_updateEndJ(p1, if p1:GetAttribute(DoorConsts.OPEN_ATTR_NAME) == true then 1 else 0)
	end))
	t2._maid:GiveTask(p1:GetAttributeChangedSignal(DoorConsts.MAX_ANGLE_ATTR_NAME):Connect(function() --[[ Line: 23 | Upvalues: p1 (copy), DoorConsts (ref), t2 (copy) ]]
		local v1 = p1:GetAttribute(DoorConsts.PCT_OPEN_ATTR_NAME)
		if v1 == nil then
			v1 = if p1:GetAttribute(DoorConsts.OPEN_ATTR_NAME) then 1 else 0
		end
		t2:_updateEndJ(p1, v1)
	end))
	t2._maid:GiveTask(p1:GetAttributeChangedSignal(DoorConsts.PCT_OPEN_ATTR_NAME):Connect(function() --[[ Line: 30 | Upvalues: p1 (copy), DoorConsts (ref), t2 (copy) ]]
		t2:_updateEndJ(p1, (p1:GetAttribute(DoorConsts.PCT_OPEN_ATTR_NAME)))
	end))
	t2._maid:GiveTask(RxInstanceUtils.observeProperty(p1, "PrimaryPart", function(p12, p22) --[[ Line: 35 | Upvalues: RxInstanceUtils (ref), p2 (copy), p1 (copy), DoorConsts (ref), t2 (copy) ]]
		if p12 then
			p22:GiveTask(RxInstanceUtils.observeProperty(p2.innerModel, "PrimaryPart", function(p12) --[[ Line: 38 | Upvalues: p1 (ref), DoorConsts (ref), t2 (ref) ]]
				if p12 then
					local v1 = p1:GetAttribute(DoorConsts.PCT_OPEN_ATTR_NAME)
					if v1 == nil then
						v1 = if p1:GetAttribute(DoorConsts.OPEN_ATTR_NAME) then 1 else 0
					end
					t2._lastJ = v1
					t2:_updateEndJ(p1, v1, true)
				end
			end))
		end
	end))
	return t2
end
function t.SetUpdateCallback(p1, p2) --[[ Line: 54 ]]
	p1._updateCallback = p2
	return function() --[[ Line: 56 | Upvalues: p1 (copy), p2 (copy) ]]
		if p1._updateCallback == p2 then
			p1._updateCallback = nil
			return true
		else
			return false
		end
	end
end
function t._updateEndJ(p1, p2, p3, p4) --[[ Line: 64 | Upvalues: DoorConsts (copy), RunService (copy), TweenService (copy), DoorUtils (copy) ]]
	local v1 = p2:FindFirstChild(DoorConsts.INNER_MODEL_NAME)
	local PrimaryPart = p2.PrimaryPart
	local v2 = p2:GetAttribute(DoorConsts.DURATION_ATTR_NAME)
	local v3 = p2:GetAttribute(DoorConsts.SHOULD_SWING_ATTR_NAME)
	local v4 = p2:GetAttribute(DoorConsts.MAX_ANGLE_ATTR_NAME)
	local v5 = PrimaryPart:FindFirstChild(DoorConsts.MOTOR_OBJ_NAME)
	local v6 = Enum.EasingDirection[p2:GetAttribute(DoorConsts.EASING_DIRECTION_ATTR_NAME)]
	local v7 = Enum.EasingStyle[p2:GetAttribute(DoorConsts.EASING_STYLE_ATTR_NAME)]
	local v8 = if v3 then v4 else v1.PrimaryPart.Size.X
	local v9 = p3 * v8
	if p4 then
		p1._lastValue = v9
		DoorUtils.setValue(p2, v9)
		if p1._updateCallback then
			p1._updateCallback(v9)
		end
	else
		local v10 = v9 - p1._lastValue
		local v11 = math.abs(v10) / math.abs(v8) * v2
		local v12 = os.clock()
		local v13 = 0
		p1._maid._animator = RunService.Heartbeat:Connect(function() --[[ Line: 90 | Upvalues: v12 (copy), v11 (copy), TweenService (ref), v7 (copy), v6 (copy), v13 (ref), p1 (copy), v10 (copy), v9 (copy), DoorUtils (ref), PrimaryPart (copy), v1 (copy), v5 (copy), v3 (copy) ]]
			local v14 = os.clock()
			local v2 = TweenService:GetValue((v14 - v12) / v11, v7, v6)
			local v32 = v2 - v13
			v13 = v2
			local v4 = p1._lastValue + v10 * v32
			if v11 <= v14 - v12 then
				v4 = v9
				p1._maid._animator = nil
			end
			p1._lastValue = v4
			DoorUtils.setValueRaw(PrimaryPart, v1, v5, v3, v4)
			if p1._updateCallback then
				p1._updateCallback(v4, (math.abs(v4 / v10)))
			end
		end)
	end
end
function t.Destroy(p1) --[[ Line: 120 ]]
	p1._maid:Destroy()
	p1._maid = nil
	setmetatable(p1, nil)
end
return t