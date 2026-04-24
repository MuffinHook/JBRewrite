-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BezierPath = require(ReplicatedStorage.Game.BezierPath)
local t = {}
local t2 = {}
local v1 = nil
local v2 = false
local function gather()
	if not v2 then
		v2 = true
		local NodesLanding = workspace:WaitForChild("NodesLanding")
		if NodesLanding then
			for i = 1, #NodesLanding:GetChildren() do
				local v12 = assert(NodesLanding:FindFirstChild(("Node%d"):format(i)))
				v12.CanCollide = false
				v12.Transparency = 1
				table.insert(t, v12.Position)
			end
		end
		local NodesTakeoff = workspace:WaitForChild("NodesTakeoff")
		if NodesTakeoff then
			for j = 1, #NodesTakeoff:GetChildren() do
				local v3 = assert(NodesTakeoff:FindFirstChild(("Node%d"):format(j)))
				v3.CanCollide = false
				v3.Transparency = 1
				table.insert(t2, v3.Position)
				if v3:FindFirstChild("CloseRobbery") then
					v1 = j
				end
			end
		end
	end
end
return {
	GetFlightData = function()
		if not v2 then
			gather()
		end
		assert(#t2 > 0, "Missing PointsLeave")
		assert(#t > 0, "Missing PointsEnter")
		local t3 = {}
		local v3 = BezierPath.new()
		v3:SetPoints(t)
		v3:SetNodeOffset(0, 2)
		t3.PathEnter = v3
		local v4 = v3:ApproximateLength(1000) / 120
		local v5 = BezierPath.new()
		v5:SetPoints(t2)
		v5:SetNodeOffset(1, 1)
		t3.PathLeave = v5
		t3.SeqsLayout = {
			{ "SeqEnter", v4 },
			{ "SeqNone", 2 },
			{ "SeqCargoOpen", 3 },
			{ "SeqLoadCrates", 10 },
			{ "SeqNone", 10 },
			{ "SeqCargoClose", 3 },
			{ "SeqLeave", v5:ApproximateLength(1000) / 120 }
		}
		t3.CloseRobberyIndex = v1
		return t3
	end
}
