-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BezierPath = require(ReplicatedStorage.Game.BezierPath)
return {
	Speed = 50,
	GetPath = function()
		local PathCargoShip = workspace:WaitForChild("PathCargoShip")
		local t = {}
		local v1 = nil
		for i = 1, #PathCargoShip:GetChildren() do
			local v2 = assert(PathCargoShip:FindFirstChild(("Node%d"):format(i)))
			v2.CanCollide = false
			v2.Transparency = 1
			table.insert(t, v2.Position)
			if v2:FindFirstChild("CloseRobbery") then
				v1 = i
			end
		end
		local v3 = BezierPath.new()
		v3:SetPoints(t)
		v3:SetNodeOffset(0, 1)
		v3.ApproxLength = v3:ApproximateLength(1000)
		v3.ApproxLengthTraveled = 0
		v3.CloseRobberyIndex = v1
		return v3
	end
}
