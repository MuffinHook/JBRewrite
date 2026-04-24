-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RayCast = require(ReplicatedStorage.Module.RayCast)
local vector = Vector3.new
local table2 = vector()
local Dot = vector().Dot
local clamp = math.clamp
local abs = math.abs
local Angles = CFrame.Angles
local t = {}
t.__index = t
function t.new(p1, p2)
	assert(p1, "missing PartNode")
	local table2 = setmetatable({}, t)
	if not p2 then
		local Attachment = Instance.new("Attachment")
		Attachment.Parent = p1
		table2.Attachment = Attachment
		local VectorForce = Instance.new("VectorForce")
		VectorForce.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
		VectorForce.Attachment0 = Attachment
		VectorForce.Force = Vector3.new()
		VectorForce.Parent = p1
		table2.VectorForce = VectorForce
		local Torque = Instance.new("Torque")
		Torque.RelativeTo = Enum.ActuatorRelativeTo.World
		Torque.Attachment0 = Attachment
		Torque.Torque = Vector3.new()
		Torque.Parent = p1
		table2.Torque = Torque
	end
	table2.PartNode = p1
	table2.dx = 0
	table2.d2x = 0
	table2.RotationVisual = 0
	table2.VisualHeightFloat = 0
	table2.EffectiveMass = 0
	table2.IgnoreModel = nil
	table2.HeightSuspension = 0
	table2.RadiusVisual = 0
	table2.Springk = 1.5
	table2.SpringB = 3.5
	table2.BHFric0 = 7
	table2.BFFric0 = 0.02
	table2.BFFric1 = 0.005
	table2._version = 1
	table2._applyForces = not p2
	return table2
end
function t.SetSuspensionHeight(p1, p2)
	assert(p2)
	p1.HeightSuspension = p2
end
function t.SetVisualRadius(p1, p2)
	assert(p2)
	p1.RadiusVisual = p2
end
function t.SetSpringConstants(p1, p2, p3)
	p1.Springk = p2
	p1.SpringB = p3
end
function t.SetHorizontalFriction(p1, p2)
	p1.BHFric0 = p2
end
function t.SetForwardFriction(p1, p2)
	p1.BFFric0 = p2
end
function t.SetForwardFriction2(p1, p2)
	p1.BFFric1 = p2
end
function t.SetVersion(p1, p2)
	p1._version = p2
end
function t.SetApplyForces(p1, p2)
	p1._applyForces = p2
end
function t.SetExternalGroundAccel(p1, p2)
	p1._extGroundAccel = p2
end
function t.Update(p1, p2, p3)
	local PartNode = p1.PartNode
	local VectorForce = p1.VectorForce
	local Torque = p1.Torque
	local HeightSuspension = p1.HeightSuspension
	local cframe12 = PartNode.CFrame
	local EffectiveMass = p1.EffectiveMass
	local SpringB = p1.SpringB
	local dx = p1.dx
	local BHFric0 = p1.BHFric0
	local BFFric0 = p1.BFFric0
	if p3 then
		cframe12 = cframe12 * Angles(0, p3, 0)
	end
	local p = cframe12.p
	local table2 = -cframe12.UpVector
	if p1._version <= 1 then
		p = p - table2 * HeightSuspension * 0.5
	end
	local _, v3, v4 = RayCast.RayIgnoreNonCollide(p, table2, HeightSuspension, p1.IgnoreModel)
	local var5 = Dot(v3 - p, table2)
	local var6 = HeightSuspension - var5
	local var8 = cframe12:vectorToObjectSpace(PartNode.Velocity)
	local x = var8.x
	local z = var8.z
	local v9, v10
	if var6 > 0.01 then
		local var11 = clamp(x, -1000, 1000)
		local var122 = clamp(z, -1000, 1000)
		v9 = -var122 / 60 * BFFric0 - var122 * abs(var122) * p1.BFFric1 / 60
		v10 = -var11 / 60 * BHFric0
		z = var122
	else
		v10 = 0
		v9 = 0
	end
	local var13 = math.clamp(-p1.Springk * var6 - SpringB * (var6 - dx) - SpringB * 0.5 * (var6 - 2 * dx + p1.d2x), -2, 2)
	local v14, v15
	if p1._applyForces then
		local cframe16 = PartNode.CFrame:VectorToObjectSpace(v4)
		local sum = vector(0, -var13, 0):Dot(cframe16) * cframe16 + vector(v10, 0, 0) + vector(0, 0, v9)
		if p1._extGroundAccel and var6 > 0.01 then
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
	local var21 = p1.RotationVisual + z * p2 / p1.RadiusVisual
	p1.RotationVisual = var21
	local v22, v23
	if p1._version <= 1 then
		v22 = (p1.RadiusVisual * 2 + HeightSuspension) * 0.5 - var5
		v23 = 0.2
	else
		v22 = p1.RadiusVisual - var5
		v23 = -p1.RadiusVisual
	end
	if v23 < v22 then
		v22 = v23
	end
	local VisualHeightFloat = p1.VisualHeightFloat
	local var24 = if VisualHeightFloat < v22 then v22 else VisualHeightFloat + (v22 - VisualHeightFloat) * 0.4
	p1.VisualHeightFloat = var24
	p1.d2x = dx
	p1.dx = var6
	return var24, var21, z * p2
end
function t.Clear(p1)
	if p1.VectorForce then
		p1.VectorForce.Force = table2
	end
	if p1.Torque then
		p1.Torque.Torque = table2
	end
end
function t.Destroy(p1)
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
