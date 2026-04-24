-- Reviewed by Claude
local tbl = {}
function tbl.addAbsoluteProbsToRewardDataFromRarityProbs(p1, p2)
	tbl.validateRewardData(p1, p2)
	local tbl2 = {}
	for v1, v2 in p1 do
		if not tbl2[v2.RarityId] then
			tbl2[v2.RarityId] = 0
		end
		local RarityId = v2.RarityId
		tbl2[RarityId] = tbl2[RarityId] + 1
	end
	local tbl3 = {}
	for v3, v4 in p2 do
		if tbl2[v3] then
			tbl3[v3] = v4 / tbl2[v3]
		end
	end
	for v5, v6 in p1 do
		v6.AbsoluteProbability = tbl3[v6.RarityId]
	end
end
function tbl.validateRewardData(p1, p2)
	local tbl = {}
	for v1, v2 in p1 do
		if not tbl[v2.RarityId] then
			tbl[v2.RarityId] = 0
		end
		local RarityId = v2.RarityId
		tbl[RarityId] = tbl[RarityId] + 1
	end
	local tbl2 = {}
	local sum = 0
	for v4, v5 in p2 do
		local v3
		v3 = if v5 >= 0 then v5 <= 100 else false
		assert(v3, "Invalid rarity probability")
		if v5 ~= 0 and not tbl[v4] then
			error("No items of rarity exist: " .. v4)
		end
		if tbl[v4] and v5 == 0 then
			warn("Items of rarity " .. v4 .. " exist but that rarity has 0 probability")
		end
		if tbl[v4] then
			tbl2[v4] = v5 / tbl[v4]
			sum = sum + v5
		end
	end
	if math.abs(sum - 100) > 0.0001 then
		error("Invalid total rarity probabilities: " .. sum)
	end
	for v6, v7 in p1 do
		local v8 = tbl2[v7.RarityId]
		local RarityId = v7.RarityId
		if v8 then
			if v8 == 0 then
				warn("Rarity has 0 probability but a reward with given rarity exists: " .. RarityId)
			end
		else
			error("No probability for rarity: " .. RarityId)
		end
	end
end
return tbl
