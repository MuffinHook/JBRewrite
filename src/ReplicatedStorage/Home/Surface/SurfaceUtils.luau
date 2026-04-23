return {
	getPlacementPrism = function(p1, p2) --[[ Name: getPlacementPrism | Line: 3 ]]
		return p1 * CFrame.new(0, p2.Y * 0.5 + 0.05 - 0.05, 0), Vector3.new(p2.X, 0.2, p2.Z)
	end,
	getStandingPrism = function(p1, p2) --[[ Name: getStandingPrism | Line: 11 ]]
		return p1 * CFrame.new(0, p2.Y * 0.5 + 7.5 - 0.05, 0), Vector3.new(p2.X, 15.1, p2.Z)
	end
}