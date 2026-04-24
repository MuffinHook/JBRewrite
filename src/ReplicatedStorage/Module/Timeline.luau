-- Reviewed by Claude
local t = {}
t.__index = t
function t.new(p1)
	assert(p1)
	local v2 = setmetatable({}, t)
	v2.Data = p1
	v2.Seqi = 1
	v2.CumulativeSeqAge = 0
	p1[1][1](0, 0)
	return v2
end
function t.Update(p1, p2)
	local CumulativeSeqAge = p1.CumulativeSeqAge
	local Data = p1.Data
	local Seqi = p1.Seqi
	if #Data < Seqi then
		return true
	end
	for i = Seqi, #Data do
		local v1 = Data[i]
		if p2 < CumulativeSeqAge then
			break
		end
		if Seqi < i then
			Data[i - 1][1](1, Data[i - 1][2])
			v1[1](0, 0)
			p1.Seqi = i
			p1.CumulativeSeqAge = CumulativeSeqAge
		end
		CumulativeSeqAge = CumulativeSeqAge + v1[2]
	end
	local Seqi_2 = p1.Seqi
	local v3 = Data[Seqi_2]
	local v4 = v3[2]
	local v5 = CumulativeSeqAge - v4
	if v5 + v4 <= p2 then
		v3[1](1, v4)
		p1.Seqi = Seqi_2 + 1
		return true
	else
		local v6 = (p2 - v5) / v4
		if v6 ~= 0 and v6 ~= 1 then
			v3[1](v6, p2 - v5)
		end
		return false
	end
end
function t.GetTotalLifespan(p1)
	local sum = 0
	for i = 1, #p1.Data do
		sum = sum + p1.Data[i][2]
	end
	return sum
end
return t
