local ServerStorage = game:GetService("ServerStorage")
local confidenceToZMap = require(ServerStorage.Trade.confidenceToZMap)
local t = {}
local function isNaN(value)
	return value ~= value
end
function t.getZSstarFromConfidence(confidence)
	if confidenceToZMap[confidence] then
		return confidenceToZMap[confidence]
	else
		warn("No z value for confidence", confidence)
		local minDistance = (1 / 0)
		local closestZValue = nil
		for k, v in pairs(confidenceToZMap) do
			local distance = math.abs(confidence - k)
			if distance < minDistance then
				minDistance = distance
				closestZValue = v
			end
		end
		return closestZValue
	end
end
function t.getMeanStdDevFromConfidenceInterval(lowerBound, upperBound, confidence)
	assert(lowerBound <= upperBound, "Invalid bounds given")
	if lowerBound == upperBound then
		return lowerBound, 0
	else
		assert(confidence and if confidence >= 0 then confidence <= 1 else false, "Invalid confidence, must be 0 to 1")
		local mean = (lowerBound + upperBound) / 2
		local zStar = t.getZSstarFromConfidence(confidence)
		local stdDevUpper = (upperBound - mean) / zStar
		local stdDevLower = (mean - lowerBound) / zStar
		assert(stdDevUpper == stdDevLower, "Inequal stdDevs " .. stdDevUpper .. " " .. stdDevLower)
		return mean, stdDevUpper
	end
end
function t.factorial(input)
	local result = 1
	for i = 2, input do
		result = result * i
	end
	return result
end
function t.normalCDFTaylorApprox(mean, stdDev, valueToEvaluate)
	assert(stdDev > 0, "Invalid stdDev")
	local standardizedValue = (valueToEvaluate - mean) / stdDev
	if standardizedValue > 5 then
		return 1
	end
	if standardizedValue < -5 then
		return 0
	end
	local sum = 0
	for i = 0, 100 do
		local isDenominatorNaN, isTermNaN
		local numerator = (-1) ^ i * standardizedValue ^ (i * 2 + 1)
		local denominator = 2 ^ i * t.factorial(i) * (i * 2 + 1)
		local term = numerator / denominator
		if numerator ~= numerator then
			break
		end
		isDenominatorNaN = denominator ~= denominator
		if isDenominatorNaN then
			break
		end
		isTermNaN = term ~= term
		if isTermNaN or term == (1 / 0) then
			break
		end
		sum = sum + term
	end
	local cdfResult = sum * 0.3989422804014327 + 0.5
	assert(if cdfResult >= 0 then cdfResult <= 1 else false, "Invalid normalCDF result, check normalCDFTaylorApprox function " .. cdfResult)
	return cdfResult
end
function t.sampleNormalDistribution(mean, stdDev)
	local uniformRandom1 = math.random()
	local uniformRandom2 = math.random()
	local logTransform = math.log(uniformRandom1) * -2
	return mean + stdDev * (math.sqrt(logTransform) * math.cos(math.tau * uniformRandom2))
end
function t.sampleExponentialDistribution(mean)
	assert(mean >= 0, "Invalid mean given")
	return -1 / (1 / mean) * math.log((math.random()))
end
return t
