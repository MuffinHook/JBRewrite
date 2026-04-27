local tbl = {}
function tbl.addAbsoluteProbsToRewardDataFromRarityProbs(rewardItems, rarityProbabilities)
	tbl.validateRewardData(rewardItems, rarityProbabilities)
	local rarityCountMap = {}
	for rewardIndex, reward in rewardItems do
		if not rarityCountMap[reward.RarityId] then
			rarityCountMap[reward.RarityId] = 0
		end
		local RarityId = reward.RarityId
		rarityCountMap[RarityId] = rarityCountMap[RarityId] + 1
	end
	local rarityAbsoluteProbabilities = {}
	for rarityId, rarityProbability in rarityProbabilities do
		if rarityCountMap[rarityId] then
			rarityAbsoluteProbabilities[rarityId] = rarityProbability / rarityCountMap[rarityId]
		end
	end
	for rewardIndex, reward in rewardItems do
		reward.AbsoluteProbability = rarityAbsoluteProbabilities[reward.RarityId]
	end
end
function tbl.validateRewardData(rewardItems, rarityProbabilities)
	local rarityCountMap = {}
	for rewardIndex, reward in rewardItems do
		if not rarityCountMap[reward.RarityId] then
			rarityCountMap[reward.RarityId] = 0
		end
		local RarityId = reward.RarityId
		rarityCountMap[RarityId] = rarityCountMap[RarityId] + 1
	end
	local rarityAbsoluteProbabilities = {}
	local sum = 0
	for rarityId, rarityProbability in rarityProbabilities do
		local isValidProbability
		isValidProbability = if rarityProbability >= 0 then rarityProbability <= 100 else false
		assert(isValidProbability, "Invalid rarity probability")
		if rarityProbability ~= 0 and not rarityCountMap[rarityId] then
			error("No items of rarity exist: " .. rarityId)
		end
		if rarityCountMap[rarityId] and rarityProbability == 0 then
			warn("Items of rarity " .. rarityId .. " exist but that rarity has 0 probability")
		end
		if rarityCountMap[rarityId] then
			rarityAbsoluteProbabilities[rarityId] = rarityProbability / rarityCountMap[rarityId]
			sum = sum + rarityProbability
		end
	end
	if math.abs(sum - 100) > 0.0001 then
		error("Invalid total rarity probabilities: " .. sum)
	end
	for rewardIndex, reward in rewardItems do
		local rarityAbsoluteProbability = rarityAbsoluteProbabilities[reward.RarityId]
		local RarityId = reward.RarityId
		if rarityAbsoluteProbability then
			if rarityAbsoluteProbability == 0 then
				warn("Rarity has 0 probability but a reward with given rarity exists: " .. RarityId)
			end
		else
			error("No probability for rarity: " .. RarityId)
		end
	end
end
return tbl
