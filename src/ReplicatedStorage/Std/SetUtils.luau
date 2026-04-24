-- Reviewed by Claude
-- variables reassigned
local t = {
	fromArray = function(p1)
		local t = {}
		for i, v in ipairs(p1) do
			t[v] = true
		end
		return t
	end,
	subtract = function(p1, p2)
		if #p1 ~= 0 then
			error("`first` has nonzero length, is it a set?")
		end
		if #p2 ~= 0 then
			error("`second` has nonzero length, is it a set?")
		end
		local t = {}
		for k in pairs(p1) do
			if not p2[k] then
				t[k] = true
			end
		end
		return t
	end,
	intersect = function(p1, p2)
		if #p1 ~= 0 then
			error("`first` has nonzero length, is it a set?")
		end
		if #p2 ~= 0 then
			error("`second` has nonzero length, is it a set?")
		end
		local t = {}
		for k in pairs(p1) do
			if p2[k] then
				t[k] = true
			end
		end
		return t
	end,
	union = function(p1, p2)
		if #p1 ~= 0 then
			error("`first` has nonzero length, is it a set?")
		end
		if #p2 ~= 0 then
			error("`second` has nonzero length, is it a set?")
		end
		local t = {}
		for k in pairs(p1) do
			t[k] = true
		end
		for k in pairs(p2) do
			t[k] = true
		end
		return t
	end
}
function t.symmetricDiff(p1, p2)
	if #p1 ~= 0 then
		error("`first` has nonzero length, is it a set?")
	end
	if #p2 ~= 0 then
		error("`second` has nonzero length, is it a set?")
	end
	return t.union(t.subtract(p1, p2), t.subtract(p2, p1))
end
function t.toArray(p1)
	if #p1 ~= 0 then
		error("`set` has nonzero length, is it a set?")
	end
	local t = {}
	for k in pairs(p1) do
		t[#t + 1] = k
	end
	return t
end
return t
