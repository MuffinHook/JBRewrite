-- Reviewed by Claude
-- variables reassigned
local ServerStorage = game:GetService("ServerStorage")
local confidenceToZMap = require(ServerStorage.Trade.confidenceToZMap)
local t = {}
local function isNaN(p1)
	return p1 ~= p1
end
function t.getZSstarFromConfidence(p1)
	if confidenceToZMap[p1] then
		return confidenceToZMap[p1]
	else
		warn("No z value for confidence", p1)
		local v1 = (1 / 0)
		local v2 = nil
		for k, v in pairs(confidenceToZMap) do
			local v3 = math.abs(p1 - k)
			if v3 < v1 then
				v1 = v3
				v2 = v
			end
		end
		return v2
	end
end
function t.getMeanStdDevFromConfidenceInterval(p1, p2, p3)
	assert(p1 <= p2, "Invalid bounds given")
	if p1 == p2 then
		return p1, 0
	else
		assert(p3 and if p3 >= 0 then p3 <= 1 else false, "Invalid confidence, must be 0 to 1")
		local v3 = (p1 + p2) / 2
		local v4 = t.getZSstarFromConfidence(p3)
		local v5 = (p2 - v3) / v4
		local v6 = (v3 - p1) / v4
		assert(v5 == v6, "Inequal stdDevs " .. v5 .. " " .. v6)
		return v3, v5
	end
end
function t.factorial(p1)
	local v1 = 1
	for i = 2, p1 do
		v1 = v1 * i
	end
	return v1
end
function t.normalCDFTaylorApprox(p1, p2, p3)
	assert(p2 > 0, "Invalid stdDev")
	local v2 = (p3 - p1) / p2
	if v2 > 5 then
		return 1
	end
	if v2 < -5 then
		return 0
	end
	local sum = 0
	for i = 0, 100 do
		local v3, v4
		local v5 = (-1) ^ i * v2 ^ (i * 2 + 1)
		local v6 = 2 ^ i * t.factorial(i) * (i * 2 + 1)
		local v7 = v5 / v6
		if v5 ~= v5 then
			break
		end
		v3 = v6 ~= v6
		if v3 then
			break
		end
		v4 = v7 ~= v7
		if v4 or v7 == (1 / 0) then
			break
		end
		sum = sum + v7
	end
	local v9 = sum * 0.3989422804014327 + 0.5
	assert(if v9 >= 0 then v9 <= 1 else false, "Invalid normalCDF result, check normalCDFTaylorApprox function " .. v9)
	return v9
end
function t.sampleNormalDistribution(p1, p2)
	local v1 = math.random()
	local v2 = math.random()
	local v3 = math.log(v1) * -2
	return p1 + p2 * (math.sqrt(v3) * math.cos(6.283185307179586 * v2))
end
function t.sampleExponentialDistribution(p1)
	assert(p1 >= 0, "Invalid mean given")
	return -1 / (1 / p1) * math.log((math.random()))
end
return t
