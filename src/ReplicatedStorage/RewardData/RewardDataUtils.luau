-- Reviewed by Claude
local t = {}
function t.addAbsoluteProbsToRewardDataFromRarityProbs(p1, p2)
	t.validateRewardData(p1, p2)
	local t2 = {}
	for v1, v2 in p1 do
		if not t2[v2.RarityId] then
			t2[v2.RarityId] = 0
		end
		local RarityId = v2.RarityId
		t2[RarityId] = t2[RarityId] + 1
	end
	local t3 = {}
	for v3, v4 in p2 do
		if t2[v3] then
			t3[v3] = v4 / t2[v3]
		end
	end
	for v5, v6 in p1 do
		v6.AbsoluteProbability = t3[v6.RarityId]
	end
end
function t.validateRewardData(p1, p2)
	local t = {}
	for v1, v2 in p1 do
		if not t[v2.RarityId] then
			t[v2.RarityId] = 0
		end
		local RarityId = v2.RarityId
		t[RarityId] = t[RarityId] + 1
	end
	local t2 = {}
	local sum = 0
	for v4, v5 in p2 do
		local v3
		v3 = if v5 >= 0 then v5 <= 100 else false
		assert(v3, "Invalid rarity probability")
		if v5 ~= 0 and not t[v4] then
			error("No items of rarity exist: " .. v4)
		end
		if t[v4] and v5 == 0 then
			warn("Items of rarity " .. v4 .. " exist but that rarity has 0 probability")
		end
		if t[v4] then
			t2[v4] = v5 / t[v4]
			sum = sum + v5
		end
	end
	if math.abs(sum - 100) > 0.0001 then
		error("Invalid total rarity probabilities: " .. sum)
	end
	for v6, v7 in p1 do
		local v8 = t2[v7.RarityId]
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
return t
