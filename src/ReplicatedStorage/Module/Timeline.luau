-- Reviewed by Claude
local t = {}
t.__index = t
function t.new(p1)
	assert(p1)
	local table2 = setmetatable({}, t)
	table2.Data = p1
	table2.Seqi = 1
	table2.CumulativeSeqAge = 0
	p1[1][1](0, 0)
	return table2
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
	local var3 = Data[Seqi_2]
	local var4 = var3[2]
	local var5 = CumulativeSeqAge - var4
	if var5 + var4 <= p2 then
		var3[1](1, var4)
		p1.Seqi = Seqi_2 + 1
		return true
	else
		local var6 = (p2 - var5) / var4
		if var6 ~= 0 and var6 ~= 1 then
			var3[1](var6, p2 - var5)
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
