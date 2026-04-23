local t = {}
local t2 = {
	to = true,
	be = true,
	been = true,
	have = true,
	was = true,
	at = true
}
local t3 = {
	never = true
}
local function assertLevel(p1, p2, p3) --[[ Line: 42 ]]
	local v1 = p2 or "Assertion failed!"
	local v2 = p3 or 1
	if not p1 then
		error(v1, v2 + 1)
	end
end
local function bindSelf(p1, p2) --[[ Line: 54 ]]
	return function(p12, ...) --[[ Line: 55 | Upvalues: p1 (copy), p2 (copy) ]]
		if p12 == p1 then
			return p2(p1, ...)
		else
			return p2(p1, p12, ...)
		end
	end
end
local function formatMessage(p1, p2, p3) --[[ Line: 64 ]]
	if p1 then
		return p2
	else
		return p3
	end
end
function t.new(p1) --[[ Line: 75 | Upvalues: t (copy) ]]
	local t2 = {
		value = p1,
		successCondition = true,
		condition = false,
		matchers = {},
		_boundMatchers = {}
	}
	setmetatable(t2, t)
	local a = t2.a
	function t2.a(p1, ...) --[[ Line: 55 | Upvalues: t2 (copy), a (copy) ]]
		if p1 == t2 then
			return a(t2, ...)
		else
			return a(t2, p1, ...)
		end
	end
	t2.an = t2.a
	local ok = t2.ok
	function t2.ok(p1, ...) --[[ Line: 55 | Upvalues: t2 (copy), ok (copy) ]]
		if p1 == t2 then
			return ok(t2, ...)
		else
			return ok(t2, p1, ...)
		end
	end
	local equal = t2.equal
	function t2.equal(p1, ...) --[[ Line: 55 | Upvalues: t2 (copy), equal (copy) ]]
		if p1 == t2 then
			return equal(t2, ...)
		else
			return equal(t2, p1, ...)
		end
	end
	local throw = t2.throw
	function t2.throw(p1, ...) --[[ Line: 55 | Upvalues: t2 (copy), throw (copy) ]]
		if p1 == t2 then
			return throw(t2, ...)
		else
			return throw(t2, p1, ...)
		end
	end
	local near = t2.near
	function t2.near(p1, ...) --[[ Line: 55 | Upvalues: t2 (copy), near (copy) ]]
		if p1 == t2 then
			return near(t2, ...)
		else
			return near(t2, p1, ...)
		end
	end
	return t2
end
function t.checkMatcherNameCollisions(p1) --[[ Line: 96 | Upvalues: t2 (copy), t3 (copy), t (copy) ]]
	return not (t2[p1] or (t3[p1] or t[p1]))
end
function t.extend(p1, p2) --[[ Line: 104 ]]
	p1.matchers = p2 or {}
	for k, v in pairs(p1.matchers) do
		local function f2(p12, ...) --[[ Line: 108 | Upvalues: v (copy), p1 (copy) ]]
			local v1 = v(p1.value, ...)
			local v2 = v1.message or "Assertion failed!"
			local v3 = 3 or 1
			if v1.pass ~= p1.successCondition then
				error(v2, v3 + 1)
			end
			p1:_resetModifiers()
			return p1
		end
		p1._boundMatchers[k] = function(p12, ...) --[[ Line: 55 | Upvalues: p1 (copy), f2 (copy) ]]
			if p12 == p1 then
				return f2(p1, ...)
			else
				return f2(p1, p12, ...)
			end
		end
	end
	return p1
end
function t.__index(p1, p2) --[[ Line: 121 | Upvalues: t2 (copy), t3 (copy), t (copy) ]]
	if t2[p2] then
		return p1
	elseif t3[p2] then
		local v1 = t.new(p1.value):extend(p1.matchers)
		v1.successCondition = not p1.successCondition
		return v1
	elseif p1._boundMatchers[p2] then
		return p1._boundMatchers[p2]
	else
		return t[p2]
	end
end
function t._resetModifiers(p1) --[[ Line: 154 ]]
	p1.successCondition = true
end
function t.a(p1, p2) --[[ Line: 163 ]]
	local v2 = type(p1.value) == p2 == p1.successCondition
	local v4 = ("Expected value of type %q, got value %q of type %s"):format(p2, tostring(p1.value), (type(p1.value)))
	local v8 = if p1.successCondition then v4 else ("Expected value not of type %q, got value %q of type %s"):format(p2, tostring(p1.value), (type(p1.value))) or "Assertion failed!"
	local v9 = 3 or 1
	if not v2 then
		error(v8, v9 + 1)
	end
	p1:_resetModifiers()
	return p1
end
t.an = t.a
function t.ok(p1) --[[ Line: 191 ]]
	local v1 = ("Expected value %q to be non-nil"):format((tostring(p1.value)))
	local v4 = if p1.successCondition then v1 else ("Expected value %q to be nil"):format((tostring(p1.value))) or "Assertion failed!"
	local v5 = 3 or 1
	if p1.value ~= nil ~= p1.successCondition then
		error(v4, v5 + 1)
	end
	p1:_resetModifiers()
	return p1
end
function t.equal(p1, p2) --[[ Line: 212 ]]
	local v5 = ("Expected value %q (%s), got %q (%s) instead"):format(tostring(p2), type(p2), tostring(p1.value), (type(p1.value)))
	local v8 = if p1.successCondition then v5 else ("Expected anything but value %q (%s)"):format(tostring(p2), (type(p2))) or "Assertion failed!"
	local v9 = 3 or 1
	if p1.value == p2 ~= p1.successCondition then
		error(v8, v9 + 1)
	end
	p1:_resetModifiers()
	return p1
end
function t.near(p1, p2, p3) --[[ Line: 238 ]]
	assert(type(p1.value) == "number", "Expectation value must be a number to use \'near\'")
	assert(type(p2) == "number", "otherValue must be a number")
	assert(type(p3) == "number" or p3 == nil, "limit must be a number or nil")
	local v4 = p3 or 1e-7
	local v7 = math.abs(p1.value - p2) <= v4 == p1.successCondition
	local v8 = ("Expected value to be near %f (within %f) but got %f instead"):format(p2, v4, p1.value)
	local v11 = if p1.successCondition then v8 else ("Expected value to not be near %f (within %f) but got %f instead"):format(p2, v4, p1.value) or "Assertion failed!"
	local v12 = 3 or 1
	if not v7 then
		error(v11, v12 + 1)
	end
	p1:_resetModifiers()
	return p1
end
function t.throw(p1, p2) --[[ Line: 271 ]]
	local v1, v2 = pcall(p1.value)
	local v3 = v1 ~= p1.successCondition
	if p2 and not v1 then
		v3 = if p1.successCondition then v2:find(p2, 1, true) ~= nil else v2:find(p2, 1, true) == nil
	end
	local v4
	if p2 then
		local v6, v7
		if v2 then
			v6 = ("threw: %s"):format(v2)
			if v6 then
				v7 = p2
			else
				v7 = p2
				v6 = "did not throw."
			end
		else
			v7 = p2
			v6 = "did not throw."
		end
		local v8 = ("Expected function to throw an error containing %q, but it %s"):format(v7, v6)
		v4 = if p1.successCondition then v8 else ("Expected function to never throw an error containing %q, but it threw: %s"):format(p2, (tostring(v2)))
	else
		v4 = if p1.successCondition then "Expected function to throw an error, but it did not throw." else ("Expected function to succeed, but it threw an error: %s"):format((tostring(v2)))
	end
	local v11 = v4 or "Assertion failed!"
	local v12 = 3 or 1
	if not v3 then
		error(v11, v12 + 1)
	end
	p1:_resetModifiers()
	return p1
end
return t