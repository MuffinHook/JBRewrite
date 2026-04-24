-- Reviewed by Claude
return {
	getPlacementPrism = function(p1, p2)
		return p1 * CFrame.new(0, p2.Y * 0.5 + 0.05 - 0.05, 0), Vector3.new(p2.X, 0.2, p2.Z)
	end,
	getStandingPrism = function(p1, p2)
		return p1 * CFrame.new(0, p2.Y * 0.5 + 7.5 - 0.05, 0), Vector3.new(p2.X, 15.1, p2.Z)
	end
}
