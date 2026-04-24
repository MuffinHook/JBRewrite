-- Reviewed by Claude
local CurrentCamera = workspace.CurrentCamera
local cframe = CFrame.new
local vector2 = Vector3.new
cframe()
local var3 = vector2()
return {
	MakeCinematicCamera = function()
		return {
			StartPosition = nil,
			Position = var3,
			TargetPosition = nil,
			LookVector = var3,
			TargetFocus = nil
		}
	end,
	StepCinematicCamera = function(p1, p2, p3, p4)
		if p2.TargetPosition then
			if p2.StartPosition then
				p2.Position = p2.StartPosition * (1 - p4) + p2.TargetPosition * p4
			else
				p2.Position = p2.Position + (p2.TargetPosition - p2.Position) * p1 * p4
			end
		end
		if p2.TargetFocus then
			p2.LookVector = p2.LookVector + ((p2.TargetFocus - p2.Position).unit - p2.LookVector) * p1 * p3
		end
		CurrentCamera.CoordinateFrame = cframe(var3, p2.LookVector) + p2.Position
	end
}
