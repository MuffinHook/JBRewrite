-- Reviewed by Claude
-- variables reassigned
local t = {}
t.__index = t
t.__ClassName = "RateLimiter"
function t.new(p1, p2)
	assert(p1 ~= nil, "missing budgetPerWindow limit")
	local t2 = {}
	setmetatable(t2, t)
	t2._lastUpdate = os.clock()
	t2._budgetPerWindow = p1
	t2._budgetWindowDuration = p2 or 1
	t2._data = {}
	return t2
end
function t.CanUseBudget(p1, p2, p3)
	assert(p2 ~= nil, "missing key")
	p1:Update()
	return if p1._data[p2] then p1._data[p2].amount else 0 + (p3 or 1) <= p1._budgetPerWindow
end
function t.UseBudget(p1, p2, p3, p4)
	local v1 = p3 or 1
	assert(v1)
	assert(p2 ~= nil, "missing key")
	if p4 or p1:CanUseBudget(p2, v1) then
		local v3 = p1._data[p2]
		if not v3 then
			local t = {
				amount = 0,
				lastUpdate = os.clock()
			}
			p1._data[p2] = t
			v3 = t
		end
		v3.amount = v3.amount + v1
		return true
	else
		return false
	end
end
t.Increment = t.UseBudget
function t.Update(p1)
	local v1 = os.clock()
	for v2, v3 in p1._data do
		if v1 - v3.lastUpdate >= p1._budgetWindowDuration then
			v3.amount = v3.amount - p1._budgetPerWindow
			if v3.amount <= 0 then
				p1._data[v2] = nil
			end
			v3.lastUpdate = v1
		end
	end
end
function t.Destroy(p1)
	table.clear(p1._data)
	setmetatable(p1, nil)
end
return t
