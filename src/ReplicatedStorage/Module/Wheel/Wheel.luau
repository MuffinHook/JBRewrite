local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RayCast = require(ReplicatedStorage.Module.RayCast)
local v1 = Vector3.new
local v2 = v1()
local Dot = v1().Dot
local clamp = math.clamp
local abs = math.abs
local Angles = CFrame.Angles
local t = {}
t.__index = t
function t.new(p1, p2) --[[ Line: 18 | Upvalues: t (copy) ]]
	assert(p1, "missing PartNode")
	local v2 = setmetatable({}, t)
	if not p2 then
		local Attachment = Instance.new("Attachment")
		Attachment.Parent = p1
		v2.Attachment = Attachment
		local VectorForce = Instance.new("VectorForce")
		VectorForce.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
		VectorForce.Attachment0 = Attachment
		VectorForce.Force = Vector3.new()
		VectorForce.Parent = p1
		v2.VectorForce = VectorForce
		local Torque = Instance.new("Torque")
		Torque.RelativeTo = Enum.ActuatorRelativeTo.World
		Torque.Attachment0 = Attachment
		Torque.Torque = Vector3.new()
		Torque.Parent = p1
		v2.Torque = Torque
	end
	v2.PartNode = p1
	v2.dx = 0
	v2.d2x = 0
	v2.RotationVisual = 0
	v2.VisualHeightFloat = 0
	v2.EffectiveMass = 0
	v2.IgnoreModel = nil
	v2.HeightSuspension = 0
	v2.RadiusVisual = 0
	v2.Springk = 1.5
	v2.SpringB = 3.5
	v2.BHFric0 = 7
	v2.BFFric0 = 0.02
	v2.BFFric1 = 0.005
	v2._version = 1
	v2._applyForces = not p2
	return v2
end
function t.SetSuspensionHeight(p1, p2) --[[ Line: 64 ]]
	assert(p2)
	p1.HeightSuspension = p2
end
function t.SetVisualRadius(p1, p2) --[[ Line: 68 ]]
	assert(p2)
	p1.RadiusVisual = p2
end
function t.SetSpringConstants(p1, p2, p3) --[[ Line: 72 ]]
	p1.Springk = p2
	p1.SpringB = p3
end
function t.SetHorizontalFriction(p1, p2) --[[ Line: 75 ]]
	p1.BHFric0 = p2
end
function t.SetForwardFriction(p1, p2) --[[ Line: 78 ]]
	p1.BFFric0 = p2
end
function t.SetForwardFriction2(p1, p2) --[[ Line: 81 ]]
	p1.BFFric1 = p2
end
function t.SetVersion(p1, p2) --[[ Line: 84 ]]
	p1._version = p2
end
function t.SetApplyForces(p1, p2) --[[ Line: 87 ]]
	p1._applyForces = p2
end
function t.SetExternalGroundAccel(p1, p2) --[[ Line: 90 ]]
	p1._extGroundAccel = p2
end
function t.Update(p1, p2, p3) --[[ Line: 93 | Upvalues: Angles (copy), RayCast (copy), Dot (copy), clamp (copy), abs (copy), v1 (copy) ]]
	local PartNode = p1.PartNode
	local VectorForce = p1.VectorForce
	local Torque = p1.Torque
	local HeightSuspension = p1.HeightSuspension
	local v12 = PartNode.CFrame
	local EffectiveMass = p1.EffectiveMass
	local SpringB = p1.SpringB
	local dx = p1.dx
	local BHFric0 = p1.BHFric0
	local BFFric0 = p1.BFFric0
	if p3 then
		v12 = v12 * Angles(0, p3, 0)
	end
	local p = v12.p
	local v2 = -v12.UpVector
	if p1._version <= 1 then
		p = p - v2 * HeightSuspension * 0.5
	end
	local _, v3, v4 = RayCast.RayIgnoreNonCollide(p, v2, HeightSuspension, p1.IgnoreModel)
	local v5 = Dot(v3 - p, v2)
	local v6 = HeightSuspension - v5
	local v8 = v12:vectorToObjectSpace(PartNode.Velocity)
	local x = v8.x
	local z = v8.z
	local v9, v10
	if v6 > 0.01 then
		local v11 = clamp(x, -1000, 1000)
		local v122 = clamp(z, -1000, 1000)
		v9 = -v122 / 60 * BFFric0 - v122 * abs(v122) * p1.BFFric1 / 60
		v10 = -v11 / 60 * BHFric0
		z = v122
	else
		v10 = 0
		v9 = 0
	end
	local v13 = math.clamp(-p1.Springk * v6 - SpringB * (v6 - dx) - SpringB * 0.5 * (v6 - 2 * dx + p1.d2x), -2, 2)
	local v14, v15
	if p1._applyForces then
		local v16 = PartNode.CFrame:VectorToObjectSpace(v4)
		local sum = v1(0, -v13, 0):Dot(v16) * v16 + v1(v10, 0, 0) + v1(0, 0, v9)
		if p1._extGroundAccel and v6 > 0.01 then
			sum = sum + p1._extGroundAccel
		end
		v14 = EffectiveMass * workspace.Gravity * sum
		v15 = PartNode.CFrame:VectorToWorldSpace(v14):Cross(p1.Attachment.WorldPosition - PartNode.Position)
	else
		v14 = nil
		v15 = nil
	end
	if VectorForce then
		VectorForce.Force = v14 or Vector3.new()
	end
	if Torque then
		Torque.Torque = v15 or Vector3.new()
	end
	local v21 = p1.RotationVisual + z * p2 / p1.RadiusVisual
	p1.RotationVisual = v21
	local v22, v23
	if p1._version <= 1 then
		v22 = (p1.RadiusVisual * 2 + HeightSuspension) * 0.5 - v5
		v23 = 0.2
	else
		v22 = p1.RadiusVisual - v5
		v23 = -p1.RadiusVisual
	end
	if v23 < v22 then
		v22 = v23
	end
	local VisualHeightFloat = p1.VisualHeightFloat
	local v24 = if VisualHeightFloat < v22 then v22 else VisualHeightFloat + (v22 - VisualHeightFloat) * 0.4
	p1.VisualHeightFloat = v24
	p1.d2x = dx
	p1.dx = v6
	return v24, v21, z * p2
end
function t.Clear(p1) --[[ Line: 205 | Upvalues: v2 (copy) ]]
	if p1.VectorForce then
		p1.VectorForce.Force = v2
	end
	if p1.Torque then
		p1.Torque.Torque = v2
	end
end
function t.Destroy(p1) --[[ Line: 213 ]]
	if p1.VectorForce then
		p1.VectorForce:Destroy()
		p1.VectorForce = nil
	end
	if p1.Torque then
		p1.Torque:Destroy()
		p1.Torque = nil
	end
	if p1.Attachment then
		p1.Attachment:Destroy()
		p1.Attachment = nil
	end
end
return t