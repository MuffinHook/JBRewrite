local t = {
	regulaFalsiWithEndpoints = function(function_, lowerBound, upperBound, tolerance, maxIterations)
		local tolerance = tolerance or 1e-15
		local root = nil
		local lastBranchDirection = 0
		local functionValueAtLower = function_(lowerBound)
		local functionValueAtUpper = function_(upperBound)
		if functionValueAtLower == 0 then
			return lowerBound
		end
		if functionValueAtUpper == 0 then
			return upperBound
		end
		if function_(lowerBound) * function_(upperBound) > 0 then
			error("Initial guesses have the same sign, invalid a and b")
		end
		for i = 1, maxIterations or 1000 do
			root = (functionValueAtLower * upperBound - functionValueAtUpper * lowerBound) / (functionValueAtLower - functionValueAtUpper)
			if math.abs(upperBound - lowerBound) < tolerance * math.abs(upperBound + lowerBound) then
				break
			end
			local functionValueAtRoot = function_(root)
			if functionValueAtRoot * functionValueAtUpper > 0 then
				if lastBranchDirection == -1 then
					functionValueAtLower = functionValueAtLower / 2
				end
				lastBranchDirection = -1
				upperBound = root
				functionValueAtUpper = functionValueAtRoot
			else
				if not (functionValueAtLower * functionValueAtRoot > 0) then
					break
				end
				if lastBranchDirection == 1 then
					functionValueAtUpper = functionValueAtUpper / 2
				end
				lastBranchDirection = 1
				functionValueAtLower = functionValueAtRoot
				lowerBound = root
			end
		end
		return root
	end
}
function t.regulaFalsi(function_, tolerance, maxIterations)
	local testLower = 0
	local testUpper = 1
	for i = 1, 20 do
		if function_(testLower) * function_(testUpper) <= 0 then
			break
		end
		if testLower == 0 then
			testLower = -1
		else
			testLower = testLower * 2
			testUpper = testUpper * 2
		end
	end
	if function_(testLower) * function_(testUpper) > 0 then
		error("Could not find valid endpoints with opposite signs")
	end
	return t.regulaFalsiWithEndpoints(function_, testLower, testUpper, tolerance, maxIterations)
end
return t
