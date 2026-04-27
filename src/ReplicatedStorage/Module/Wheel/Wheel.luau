local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RayCast = require(ReplicatedStorage.Module.RayCast)
local vector = Vector3.new
local zeroVector = vector()
local Dot = vector().Dot
local clamp = math.clamp
local abs = math.abs
local Angles = CFrame.Angles
local WheelModule = {}
WheelModule.__index = WheelModule
function WheelModule.new(partNode, skipAttachments)
	assert(partNode, "missing PartNode")
	local wheel = setmetatable({}, WheelModule)
	if not skipAttachments then
		local Attachment = Instance.new("Attachment")
		Attachment.Parent = partNode
		wheel.Attachment = Attachment
		local VectorForce = Instance.new("VectorForce")
		VectorForce.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
		VectorForce.Attachment0 = Attachment
		VectorForce.Force = Vector3.new()
		VectorForce.Parent = partNode
		wheel.VectorForce = VectorForce
		local Torque = Instance.new("Torque")
		Torque.RelativeTo = Enum.ActuatorRelativeTo.World
		Torque.Attachment0 = Attachment
		Torque.Torque = Vector3.new()
		Torque.Parent = partNode
		wheel.Torque = Torque
	end
	wheel.PartNode = partNode
	wheel.dx = 0
	wheel.d2x = 0
	wheel.RotationVisual = 0
	wheel.VisualHeightFloat = 0
	wheel.EffectiveMass = 0
	wheel.IgnoreModel = nil
	wheel.HeightSuspension = 0
	wheel.RadiusVisual = 0
	wheel.Springk = 1.5
	wheel.SpringB = 3.5
	wheel.BHFric0 = 7
	wheel.BFFric0 = 0.02
	wheel.BFFric1 = 0.005
	wheel._version = 1
	wheel._applyForces = not skipAttachments
	return wheel
end
function WheelModule.SetSuspensionHeight(wheel, height)
	assert(height)
	wheel.HeightSuspension = height
end
function WheelModule.SetVisualRadius(wheel, radius)
	assert(radius)
	wheel.RadiusVisual = radius
end
function WheelModule.SetSpringConstants(wheel, springK, springB)
	wheel.Springk = springK
	wheel.SpringB = springB
end
function WheelModule.SetHorizontalFriction(wheel, friction)
	wheel.BHFric0 = friction
end
function WheelModule.SetForwardFriction(wheel, friction)
	wheel.BFFric0 = friction
end
function WheelModule.SetForwardFriction2(wheel, friction)
	wheel.BFFric1 = friction
end
function WheelModule.SetVersion(wheel, version)
	wheel._version = version
end
function WheelModule.SetApplyForces(wheel, shouldApply)
	wheel._applyForces = shouldApply
end
function WheelModule.SetExternalGroundAccel(wheel, acceleration)
	wheel._extGroundAccel = acceleration
end
function WheelModule.Update(wheel, deltaTime, rotationDelta)
	local PartNode = wheel.PartNode
	local VectorForce = wheel.VectorForce
	local Torque = wheel.Torque
	local HeightSuspension = wheel.HeightSuspension
	local adjustedCFrame = PartNode.CFrame
	local EffectiveMass = wheel.EffectiveMass
	local SpringB = wheel.SpringB
	local dx = wheel.dx
	local BHFric0 = wheel.BHFric0
	local BFFric0 = wheel.BFFric0
	if rotationDelta then
		adjustedCFrame = adjustedCFrame * Angles(0, rotationDelta, 0)
	end
	local rayOrigin = adjustedCFrame.p
	local downDirection = -adjustedCFrame.UpVector
	if wheel._version <= 1 then
		rayOrigin = rayOrigin - downDirection * HeightSuspension * 0.5
	end
	local _, hitPoint, rayNormal = RayCast.RayIgnoreNonCollide(rayOrigin, downDirection, HeightSuspension, wheel.IgnoreModel)
	local groundDistance = Dot(hitPoint - rayOrigin, downDirection)
	local suspensionCompression = HeightSuspension - groundDistance
	local objectVelocity = adjustedCFrame:vectorToObjectSpace(PartNode.Velocity)
	local x = objectVelocity.x
	local z = objectVelocity.z
	local forwardFrictionForce, lateralFrictionForce
	if suspensionCompression > 0.01 then
		local clampedXVelocity = clamp(x, -1000, 1000)
		local clampedZVelocity = clamp(z, -1000, 1000)
		forwardFrictionForce = -clampedZVelocity / 60 * BFFric0 - clampedZVelocity * abs(clampedZVelocity) * wheel.BFFric1 / 60
		lateralFrictionForce = -clampedXVelocity / 60 * BHFric0
		z = clampedZVelocity
	else
		lateralFrictionForce = 0
		forwardFrictionForce = 0
	end
	local suspensionForce = math.clamp(-wheel.Springk * suspensionCompression - SpringB * (suspensionCompression - dx) - SpringB * 0.5 * (suspensionCompression - 2 * dx + wheel.d2x), -2, 2)
	local adjustedForce, torqueForce
	if wheel._applyForces then
		local rayNormalObjectSpace = PartNode.CFrame:VectorToObjectSpace(rayNormal)
		local sum = vector(0, -suspensionForce, 0):Dot(rayNormalObjectSpace) * rayNormalObjectSpace + vector(lateralFrictionForce, 0, 0) + vector(0, 0, forwardFrictionForce)
		if wheel._extGroundAccel and suspensionCompression > 0.01 then
			sum = sum + wheel._extGroundAccel
		end
		adjustedForce = EffectiveMass * workspace.Gravity * sum
		torqueForce = PartNode.CFrame:VectorToWorldSpace(adjustedForce):Cross(wheel.Attachment.WorldPosition - PartNode.Position)
	else
		adjustedForce = nil
		torqueForce = nil
	end
	if VectorForce then
		VectorForce.Force = adjustedForce or Vector3.new()
	end
	if Torque then
		Torque.Torque = torqueForce or Vector3.new()
	end
	local newRotationVisual = wheel.RotationVisual + z * deltaTime / wheel.RadiusVisual
	wheel.RotationVisual = newRotationVisual
	local visualHeightTarget, visualHeightMin
	if wheel._version <= 1 then
		visualHeightTarget = (wheel.RadiusVisual * 2 + HeightSuspension) * 0.5 - groundDistance
		visualHeightMin = 0.2
	else
		visualHeightTarget = wheel.RadiusVisual - groundDistance
		visualHeightMin = -wheel.RadiusVisual
	end
	if visualHeightMin < visualHeightTarget then
		visualHeightTarget = visualHeightMin
	end
	local VisualHeightFloat = wheel.VisualHeightFloat
	local lerpedVisualHeight = if VisualHeightFloat < visualHeightTarget then visualHeightTarget else VisualHeightFloat + (visualHeightTarget - VisualHeightFloat) * 0.4
	wheel.VisualHeightFloat = lerpedVisualHeight
	wheel.d2x = dx
	wheel.dx = suspensionCompression
	return lerpedVisualHeight, newRotationVisual, z * deltaTime
end
function WheelModule.Clear(wheel)
	if wheel.VectorForce then
		wheel.VectorForce.Force = zeroVector
	end
	if wheel.Torque then
		wheel.Torque.Torque = zeroVector
	end
end
function WheelModule.Destroy(wheel)
	if wheel.VectorForce then
		wheel.VectorForce:Destroy()
		wheel.VectorForce = nil
	end
	if wheel.Torque then
		wheel.Torque:Destroy()
		wheel.Torque = nil
	end
	if wheel.Attachment then
		wheel.Attachment:Destroy()
		wheel.Attachment = nil
	end
end
return WheelModule
