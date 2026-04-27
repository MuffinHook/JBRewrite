local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BezierPath = require(ReplicatedStorage.Game.BezierPath)
local landingPositions = {}
local takeoffPositions = {}
local closeRobberyIndex = nil
local isInitialized = false
local function gather()
	if not isInitialized then
		isInitialized = true
		local NodesLanding = workspace:WaitForChild("NodesLanding")
		if NodesLanding then
			for i = 1, #NodesLanding:GetChildren() do
				local landingNode = assert(NodesLanding:FindFirstChild(("Node%d"):format(i)))
				landingNode.CanCollide = false
				landingNode.Transparency = 1
				table.insert(landingPositions, landingNode.Position)
			end
		end
		local NodesTakeoff = workspace:WaitForChild("NodesTakeoff")
		if NodesTakeoff then
			for j = 1, #NodesTakeoff:GetChildren() do
				local takeoffNode = assert(NodesTakeoff:FindFirstChild(("Node%d"):format(j)))
				takeoffNode.CanCollide = false
				takeoffNode.Transparency = 1
				table.insert(takeoffPositions, takeoffNode.Position)
				if takeoffNode:FindFirstChild("CloseRobbery") then
					closeRobberyIndex = j
				end
			end
		end
	end
end
return {
	GetFlightData = function()
		if not isInitialized then
			gather()
		end
		assert(#takeoffPositions > 0, "Missing PointsLeave")
		assert(#landingPositions > 0, "Missing PointsEnter")
		local flightData = {}
		local enterPath = BezierPath.new()
		enterPath:SetPoints(landingPositions)
		enterPath:SetNodeOffset(0, 2)
		flightData.PathEnter = enterPath
		local enterDuration = enterPath:ApproximateLength(1000) / 120
		local leavePath = BezierPath.new()
		leavePath:SetPoints(takeoffPositions)
		leavePath:SetNodeOffset(1, 1)
		flightData.PathLeave = leavePath
		flightData.SeqsLayout = {
			{ "SeqEnter", enterDuration },
			{ "SeqNone", 2 },
			{ "SeqCargoOpen", 3 },
			{ "SeqLoadCrates", 10 },
			{ "SeqNone", 10 },
			{ "SeqCargoClose", 3 },
			{ "SeqLeave", leavePath:ApproximateLength(1000) / 120 }
		}
		flightData.CloseRobberyIndex = closeRobberyIndex
		return flightData
	end
}
