-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Glicko2Consts = require(ReplicatedStorage.Glicko2.Glicko2Consts)
local MathUtils = require(ReplicatedStorage.Std.MathUtils)
local Glicko2Utils = {
	g = function(ratingDeviation)
		return 1 / math.sqrt(1 + 3 * ratingDeviation ^ 2 / 9.869604401089358)
	end
}
function Glicko2Utils.E(playerRating, opponentRating, opponentDeviation)
	return 1 / (math.exp(-Glicko2Utils.g(opponentDeviation) * (playerRating - opponentRating)) + 1)
end
function Glicko2Utils.v(playerRating, opponentRatings, opponentDeviations)
	local sum = 0
	for i = 1, #opponentRatings do
		local opponentDeviation = opponentDeviations[i]
		local expectedScore = Glicko2Utils.E(playerRating, opponentRatings[i], opponentDeviation)
		sum = sum + Glicko2Utils.g(opponentDeviation) ^ 2 * expectedScore * (1 - expectedScore)
	end
	return 1 / sum
end
function Glicko2Utils.delta(varianceInverse, playerRating, opponentRatings, opponentDeviations, scores)
	local sum = 0
	for i = 1, #opponentRatings do
		local opponentDeviation = opponentDeviations[i]
		sum = sum + Glicko2Utils.g(opponentDeviation) * (scores[i] - Glicko2Utils.E(playerRating, opponentRatings[i], opponentDeviation))
	end
	return varianceInverse * sum
end
function Glicko2Utils.f(x, delta, variance, ratingDeviation, sigma, tau)
	return 0.5 * (math.exp(x) * (delta ^ 2 - variance ^ 2 - x - math.exp(x))) / (variance ^ 2 + x + math.exp(x)) ^ 2 - (x - math.log(sigma ^ 2)) / tau ^ 2
end
function Glicko2Utils.convertToGlicko2Rating(rating, ratingDeviation)
	return (rating - 1500) / Glicko2Consts.CONVERSION_FACTOR, ratingDeviation / Glicko2Consts.CONVERSION_FACTOR
end
function Glicko2Utils.convertFromGlicko2Rating(glicko2Rating, glicko2Deviation)
	return Glicko2Consts.CONVERSION_FACTOR * glicko2Rating + 1500, Glicko2Consts.CONVERSION_FACTOR * glicko2Deviation
end
function Glicko2Utils.calculateNewRatingData(rating, ratingDeviation, sigma, opponentRatings, opponentDeviations, scores, tau)
	assert(typeof(opponentRatings) == "table", "Invalid ratingList")
	assert(typeof(opponentDeviations) == "table", "Invalid ratingDeviationList")
	assert(typeof(scores) == "table", "Invalid scoreList")
	assert(#opponentRatings == #opponentDeviations, "Lengths of lists must be the same")
	assert(#opponentRatings == #scores, "Lengths of lists must be the same")
	assert(if typeof(rating) == "number" then rating > 0 else false, "Invalid rating")
	assert(if typeof(ratingDeviation) == "number" then ratingDeviation > 0 else false, "Invalid ratingDeviation")
	assert(if typeof(sigma) == "number" then sigma > 0 else false, "Invalid sigma")
	local glicko2Rating, glicko2Deviation = Glicko2Utils.convertToGlicko2Rating(rating, ratingDeviation)
	if #opponentRatings == 0 then
		local _, newDeviation = Glicko2Utils.convertFromGlicko2Rating(glicko2Rating, (math.sqrt(glicko2Deviation ^ 2 + sigma ^ 2)))
		return rating, newDeviation, sigma
	else
		local glicko2OpponentRatings = {}
		local glicko2OpponentDeviations = {}
		for i = 1, #opponentRatings do
			local glicko2OpponentRating, glicko2OpponentDeviation = Glicko2Utils.convertToGlicko2Rating(opponentRatings[i], opponentDeviations[i])
			table.insert(glicko2OpponentRatings, glicko2OpponentRating)
			table.insert(glicko2OpponentDeviations, glicko2OpponentDeviation)
		end
		local effectiveTau = tau or Glicko2Consts.DEFAULT_TAU
		local variance = Glicko2Utils.v(glicko2Rating, glicko2OpponentRatings, glicko2OpponentDeviations)
		local delta = Glicko2Utils.delta(variance, glicko2Rating, glicko2OpponentRatings, glicko2OpponentDeviations, scores)
		local function iterateX(x)
			return Glicko2Utils.f(x, delta, variance, glicko2Deviation, sigma, effectiveTau)
		end
		local a = math.exp(MathUtils.regulaFalsi(iterateX) / 2)
		local newDeviation = 1 / math.sqrt(1 / (glicko2Deviation ^ 2 + a ^ 2) + 1 / variance)
		local sum = 0
		for j = 1, #glicko2OpponentRatings do
			local opponentDeviation = glicko2OpponentDeviations[j]
			sum = sum + Glicko2Utils.g(opponentDeviation) * (scores[j] - Glicko2Utils.E(glicko2Rating, glicko2OpponentRatings[j], opponentDeviation))
		end
		local newRating, newSigma = Glicko2Utils.convertFromGlicko2Rating(glicko2Rating + newDeviation ^ 2 * sum, newDeviation)
		return newRating, newSigma, a
	end
end
return Glicko2Utils
