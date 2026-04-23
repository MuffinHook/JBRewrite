local t = {}
t.__index = t
function t.new() --[[ Line: 4 | Upvalues: t (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2._data = {}
	t2._observe = {}
	return t2
end
function t.AcquireFor(p1, p2, p3) --[[ Line: 13 ]]
	if p1._data[p2] then
		return false
	else
		p1._data[p2] = {
			thread = task.delay(p3, function() --[[ Line: 18 | Upvalues: p1 (copy), p2 (copy) ]]
				p1._data[p2] = nil
				p1:_fireKeyChangedCallbacks(p2)
			end)
		}
		p1:_fireKeyChangedCallbacks(p2)
		return true
	end
end
function t.ReleaseFor(p1, p2) --[[ Line: 26 ]]
	local v1 = p1._data[p2]
	if v1 then
		task.cancel(v1.thread)
		p1._data[p2] = nil
		p1:_fireKeyChangedCallbacks(p2)
	end
	return v1 ~= nil
end
function t._fireKeyChangedCallbacks(p1, p2) --[[ Line: 36 ]]
	local v1 = p1._data[p2] ~= nil
	if p1._observe[p2] then
		for v2, v3 in p1._observe[p2] do
			v3(v1)
		end
	end
end
function t.AddKeyChangedCallback(p1, p2, p3) --[[ Line: 44 ]]
	if not p1._observe[p2] then
		p1._observe[p2] = {}
	end
	table.insert(p1._observe[p2], p3)
	return function() --[[ Line: 49 | Upvalues: p1 (copy), p2 (copy), p3 (copy) ]]
		if p1._observe[p2] then
			local v1 = table.find(p1._observe[p2], p3)
			if v1 then
				table.remove(p1._observe[p2], v1)
				if #p1._observe[p2] == 0 then
					p1._observe[p2] = nil
				end
				return true
			else
				return false
			end
		else
			return false
		end
	end
end
function t.ObserveKey(p1, p2, p3) --[[ Line: 64 ]]
	p3(p1._data[p2] ~= nil)
	return p1:AddKeyChangedCallback(p2, p3)
end
function t.Destroy(p1) --[[ Line: 69 ]]
	for v1 in p1._data do
		p1:ReleaseFor(v1)
	end
	setmetatable(p1, nil)
end
return t