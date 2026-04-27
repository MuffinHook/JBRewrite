return {
	getPlacementPrism = function(baseCFrame, dimensions)
		return baseCFrame * CFrame.new(0, dimensions.Y * 0.5 + 0.05 - 0.05, 0), Vector3.new(dimensions.X, 0.2, dimensions.Z)
	end,
	getStandingPrism = function(baseCFrame, dimensions)
		return baseCFrame * CFrame.new(0, dimensions.Y * 0.5 + 7.5 - 0.05, 0), Vector3.new(dimensions.X, 15.1, dimensions.Z)
	end
}
