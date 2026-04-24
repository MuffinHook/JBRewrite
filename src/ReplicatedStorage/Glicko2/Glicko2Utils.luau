-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Glicko2Consts = require(ReplicatedStorage.Glicko2.Glicko2Consts)
local MathUtils = require(ReplicatedStorage.Std.MathUtils)
local t = {
	g = function(p1)
		return 1 / math.sqrt(1 + 3 * p1 ^ 2 / 9.869604401089358)
	end
}
function t.E(p1, p2, p3)
	return 1 / (math.exp(-t.g(p3) * (p1 - p2)) + 1)
end
function t.v(p1, p2, p3)
	local sum = 0
	for i = 1, #p2 do
		local v2 = p3[i]
		local v3 = t.E(p1, p2[i], v2)
		sum = sum + t.g(v2) ^ 2 * v3 * (1 - v3)
	end
	return 1 / sum
end
function t.delta(p1, p2, p3, p4, p5)
	local sum = 0
	for i = 1, #p3 do
		local v2 = p4[i]
		sum = sum + t.g(v2) * (p5[i] - t.E(p2, p3[i], v2))
	end
	return p1 * sum
end
function t.f(p1, p2, p3, p4, p5, p6)
	return 0.5 * (math.exp(p1) * (p2 ^ 2 - p4 ^ 2 - p3 - math.exp(p1))) / (p4 ^ 2 + p3 + math.exp(p1)) ^ 2 - (p1 - math.log(p5 ^ 2)) / p6 ^ 2
end
function t.convertToGlicko2Rating(p1, p2)
	return (p1 - 1500) / Glicko2Consts.CONVERSION_FACTOR, p2 / Glicko2Consts.CONVERSION_FACTOR
end
function t.convertFromGlicko2Rating(p1, p2)
	return Glicko2Consts.CONVERSION_FACTOR * p1 + 1500, Glicko2Consts.CONVERSION_FACTOR * p2
end
function t.calculateNewRatingData(p1, p2, p3, p4, p5, p6, p7)
	assert(typeof(p4) == "table", "Invalid ratingList")
	assert(typeof(p5) == "table", "Invalid ratingDeviationList")
	assert(typeof(p6) == "table", "Invalid scoreList")
	assert(#p4 == #p5, "Lengths of lists must be the same")
	assert(#p4 == #p6, "Lengths of lists must be the same")
	assert(if typeof(p1) == "number" then p1 > 0 else false, "Invalid rating")
	assert(if typeof(p2) == "number" then p2 > 0 else false, "Invalid ratingDeviation")
	assert(if typeof(p3) == "number" then p3 > 0 else false, "Invalid sigma")
	local v9, v10 = t.convertToGlicko2Rating(p1, p2)
	if #p4 == 0 then
		local _, v12 = t.convertFromGlicko2Rating(v9, (math.sqrt(v10 ^ 2 + p3 ^ 2)))
		return p1, v12, p3
	else
		local t2 = {}
		local t3 = {}
		for i = 1, #p4 do
			local v15, v16 = t.convertToGlicko2Rating(p4[i], p5[i])
			table.insert(t2, v15)
			table.insert(t3, v16)
		end
		local v18 = p7 or Glicko2Consts.DEFAULT_TAU
		local v19 = t.v(v9, t2, t3)
		local v20 = t.delta(v19, v9, t2, t3, p6)
		local function f21(p1)
			return t.f(p1, v20, v19, v10, p3, v18)
		end
		local v23 = math.exp(MathUtils.regulaFalsi(f21) / 2)
		local v24 = 1 / math.sqrt(1 / (v10 ^ 2 + v23 ^ 2) + 1 / v19)
		local sum = 0
		for j = 1, #t2 do
			local v26 = t3[j]
			sum = sum + t.g(v26) * (p6[j] - t.E(v9, t2[j], v26))
		end
		local v28, v29 = t.convertFromGlicko2Rating(v9 + v24 ^ 2 * sum, v24)
		return v28, v29, v23
	end
end
return t
