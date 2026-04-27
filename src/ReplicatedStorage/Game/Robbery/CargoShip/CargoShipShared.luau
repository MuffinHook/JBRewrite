local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BezierPath = require(ReplicatedStorage.Game.BezierPath)
return {
	Speed = 50,
	GetPath = function()
		local PathCargoShip = workspace:WaitForChild("PathCargoShip")
		local waypoints = {}
		local closeRobberyNodeIndex = nil
		for i = 1, #PathCargoShip:GetChildren() do
			local currentNode = assert(PathCargoShip:FindFirstChild(("Node%d"):format(i)))
			currentNode.CanCollide = false
			currentNode.Transparency = 1
			table.insert(waypoints, currentNode.Position)
			if currentNode:FindFirstChild("CloseRobbery") then
				closeRobberyNodeIndex = i
			end
		end
		local bezierPath = BezierPath.new()
		bezierPath:SetPoints(waypoints)
		bezierPath:SetNodeOffset(0, 1)
		bezierPath.ApproxLength = bezierPath:ApproximateLength(1000)
		bezierPath.ApproxLengthTraveled = 0
		bezierPath.CloseRobberyIndex = closeRobberyNodeIndex
		return bezierPath
	end
}
