local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local DoorConsts = require(ReplicatedStorage.Door2.DoorConsts)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local SpinnerConsts = require(script.Parent.SpinnerConsts)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(p1, p2) --[[ Line: 13 | Upvalues: BaseObject (copy), t (copy), SpinnerConsts (copy) ]]
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	v1.manifest = p2
	v1._pos = 0
	v1._vel = 0
	v1:_updateSpinning()
	v1.maid:GiveTask(p1:GetAttributeChangedSignal(SpinnerConsts.ENABLED_ATTR_NAME):Connect(function() --[[ Line: 21 | Upvalues: v1 (copy) ]]
		v1:_updateSpinning()
	end))
	v1._fadeOut = false
	return v1
end
function t._updateSpinning(p1) --[[ Line: 28 | Upvalues: SpinnerConsts (copy), RunService (copy) ]]
	if p1.obj:GetAttribute(SpinnerConsts.ENABLED_ATTR_NAME) == true then
		local v2 = p1.obj:GetAttribute(SpinnerConsts.ACCEL_ATTR_NAME) or 1
		local v3 = p1.obj:GetAttribute(SpinnerConsts.DRAG_PCT_ATTR_NAME) or 0.05
		p1._fadeOut = false
		p1.maid.spinning = RunService.Heartbeat:Connect(function(p12) --[[ Line: 36 | Upvalues: p1 (copy), v2 (copy), v3 (copy) ]]
			if not p1._fadeOut then
				local v1 = p1
				v1._vel = v1._vel + v2 * 1 * p12
			end
			local v22 = p1
			v22._vel = v22._vel * (1 - v3)
			local v32 = p1
			v32._pos = v32._pos + p1._vel * p12
			p1.manifest.innerModel:PivotTo(p1.obj:GetPivot() * CFrame.Angles(0, p1._pos, 0))
			if p1._fadeOut and math.abs(p1._vel) < 0.1 then
				p1.maid.spinning = nil
			end
		end)
	else
		p1._fadeOut = true
	end
end
return ManifestBinder.new(SpinnerConsts.TAG_NAME, {
	innerModel = DoorConsts.INNER_MODEL_NAME
}, t)