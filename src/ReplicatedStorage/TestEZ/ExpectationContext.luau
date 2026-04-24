-- Reviewed by Claude
local Expectation = require(script.Parent.Expectation)
local checkMatcherNameCollisions = Expectation.checkMatcherNameCollisions
local function copy(p1)
	local t = {}
	for k, v in pairs(p1) do
		t[k] = v
	end
	return t
end
local t = {}
t.__index = t
function t.new(p1)
	local t2 = {}
	local v1
	if p1 then
		local t3 = {}
		for k, v in pairs(p1._extensions) do
			t3[k] = v
		end
		v1 = t3 or {}
	else
		v1 = {}
	end
	t2._extensions = v1
	return setmetatable(t2, t)
end
function t.startExpectationChain(p1, ...)
	return Expectation.new(...):extend(p1._extensions)
end
function t.extend(p1, p2)
	for k, v in pairs(p2) do
		assert(p1._extensions[k] == nil, string.format("Cannot reassign %q in expect.extend", k))
		assert(checkMatcherNameCollisions(k), string.format("Cannot overwrite matcher %q; it already exists", k))
		p1._extensions[k] = v
	end
end
return t
