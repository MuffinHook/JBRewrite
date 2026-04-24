-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Module.Table)
local t = {
	calculateDist = function(p1, p2)
		local count = 1
		local v1 = 0
		local sum = 0
		while true do
			local v2 = p1[count]
			local v3 = v2.speedStart or v2.speed
			local timeUntil = v2.timeUntil
			local v5 = math.min(timeUntil, p2) - v1
			sum = sum + (((v2.speedEnd or v2.speed) - v3) / (2 * (timeUntil - v1)) * v5 * v5 + v3 * v5)
			v1 = v2.timeUntil
			count = count + 1
			if #p1 < count or p2 < v1 then
				return sum
			end
		end
	end,
	calculateSpeed = function(p1, p2)
		local v1 = 0
		for i = 1, #p1 do
			local v2 = p1[i]
			local timeUntil = v2.timeUntil
			local v3 = math.min(timeUntil, p2) - v1
			if p2 <= timeUntil then
				local v4 = v2.speedStart or v2.speed
				return ((v2.speedEnd or v2.speed) - v4) / (timeUntil - v1) * v3 + v4
			end
			v1 = v2.timeUntil
		end
	end
}
function t.calculateTime(p1, p2)
	assert(#p1 > 0)
	if not (t.calculateDist(p1, p1[#p1].timeUntil) < p2) then
		local v2 = 0
		local function v3(p12, p22)
			local v1 = (p12 + p22) * 0.5
			local v22 = t.calculateDist(p1, v1) - p2
			if math.abs(v22) < 1e-6 then
				return v1
			else
				if math.abs(v22 - v2) < 1e-6 then
				else
					v2 = v22
					if v22 > 0 then
						return v3(p12, v1)
					else
						return v3(v1, p22)
					end
				end
			end
		end
		return v3(0, p1[#p1].timeUntil)
	end
end
function t.constrainLastTimeToReachTarget(p1, p2)
	if #p1 > 1 and p2 < t.calculateDist(p1, p1[#p1 - 1].timeUntil) then
		return nil
	else
		local v1 = 0
		local function v2(p12, p22)
			local v12 = (p12 + p22) * 0.5
			p1[#p1].timeUntil = v12
			local v22 = t.calculateDist(p1, v12) - p2
			if math.abs(v22) < 1e-6 then
				return v12
			else
				if math.abs(v22 - v1) < 1e-6 then
				else
					v1 = v22
					if v22 > 0 then
						return v2(p12, v12)
					else
						return v2(v12, p22)
					end
				end
			end
		end
		return v2(#p1 > 1 and p1[#p1 - 1].timeUntil or 0, 10000000000)
	end
end
function t.cap(p1)
	table.insert(p1, {
		timeUntil = 10000000000,
		speedStart = 0,
		speedEnd = 0
	})
end
return t
