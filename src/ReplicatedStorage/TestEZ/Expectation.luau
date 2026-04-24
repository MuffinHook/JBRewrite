-- Reviewed by Claude
-- variables reassigned
local expectationClass = {}
local modifierKeywords = {
	to = true,
	be = true,
	been = true,
	have = true,
	was = true,
	at = true
}
local negationKeywords = {
	never = true
}
local function assertLevel(condition, message, level)
	local errorMessage = message or "Assertion failed!"
	local errorLevel = level or 1
	if not condition then
		error(errorMessage, errorLevel + 1)
	end
end
local function bindSelf(expectedSelf, method)
	return function(actualSelf, ...)
		if actualSelf == expectedSelf then
			return method(expectedSelf, ...)
		else
			return method(expectedSelf, actualSelf, ...)
		end
	end
end
local function formatMessage(shouldPass, passMessage, failMessage)
	if shouldPass then
		return passMessage
	else
		return failMessage
	end
end
function expectationClass.new(value)
	local expectation = {
		value = value,
		successCondition = true,
		condition = false,
		matchers = {},
		_boundMatchers = {}
	}
	setmetatable(expectation, expectationClass)
	local aMethod = expectation.a
	function expectation.a(self, ...)
		if self == expectation then
			return aMethod(expectation, ...)
		else
			return aMethod(expectation, self, ...)
		end
	end
	expectation.an = expectation.a
	local okMethod = expectation.ok
	function expectation.ok(self, ...)
		if self == expectation then
			return okMethod(expectation, ...)
		else
			return okMethod(expectation, self, ...)
		end
	end
	local equalMethod = expectation.equal
	function expectation.equal(self, ...)
		if self == expectation then
			return equalMethod(expectation, ...)
		else
			return equalMethod(expectation, self, ...)
		end
	end
	local throwMethod = expectation.throw
	function expectation.throw(self, ...)
		if self == expectation then
			return throwMethod(expectation, ...)
		else
			return throwMethod(expectation, self, ...)
		end
	end
	local nearMethod = expectation.near
	function expectation.near(self, ...)
		if self == expectation then
			return nearMethod(expectation, ...)
		else
			return nearMethod(expectation, self, ...)
		end
	end
	return expectation
end
function expectationClass.checkMatcherNameCollisions(key)
	return not (modifierKeywords[key] or (negationKeywords[key] or expectationClass[key]))
end
function expectationClass.extend(expectation, matchers)
	expectation.matchers = matchers or {}
	for k, matcher in pairs(expectation.matchers) do
		local function boundMatcherFunction(self, ...)
			local matchResult = matcher(expectation.value, ...)
			local errorMessage = matchResult.message or "Assertion failed!"
			local errorLevel = 3 or 1
			if matchResult.pass ~= expectation.successCondition then
				error(errorMessage, errorLevel + 1)
			end
			expectation:_resetModifiers()
			return expectation
		end
		expectation._boundMatchers[k] = function(self, ...)
			if self == expectation then
				return boundMatcherFunction(expectation, ...)
			else
				return boundMatcherFunction(expectation, self, ...)
			end
		end
	end
	return expectation
end
function expectationClass.__index(self, key)
	if modifierKeywords[key] then
		return self
	elseif negationKeywords[key] then
		local negatedExpectation = expectationClass.new(self.value):extend(self.matchers)
		negatedExpectation.successCondition = not self.successCondition
		return negatedExpectation
	elseif self._boundMatchers[key] then
		return self._boundMatchers[key]
	else
		return expectationClass[key]
	end
end
function expectationClass._resetModifiers(self)
	self.successCondition = true
end
function expectationClass.a(self, typeStr)
	local typeMatches = type(self.value) == typeStr == self.successCondition
	local wrongTypeMessage = ("Expected value of type %q, got value %q of type %s"):format(typeStr, tostring(self.value), (type(self.value)))
	local finalMessage = if self.successCondition then wrongTypeMessage else ("Expected value not of type %q, got value %q of type %s"):format(typeStr, tostring(self.value), (type(self.value))) or "Assertion failed!"
	local errorLevel = 3 or 1
	if not typeMatches then
		error(finalMessage, errorLevel + 1)
	end
	self:_resetModifiers()
	return self
end
expectationClass.an = expectationClass.a
function expectationClass.ok(self)
	local notNilMessage = ("Expected value %q to be non-nil"):format((tostring(self.value)))
	local finalMessage = if self.successCondition then notNilMessage else ("Expected value %q to be nil"):format((tostring(self.value))) or "Assertion failed!"
	local errorLevel = 3 or 1
	if self.value ~= nil ~= self.successCondition then
		error(finalMessage, errorLevel + 1)
	end
	self:_resetModifiers()
	return self
end
function expectationClass.equal(self, otherValue)
	local notEqualMessage = ("Expected value %q (%s), got %q (%s) instead"):format(tostring(otherValue), type(otherValue), tostring(self.value), (type(self.value)))
	local finalMessage = if self.successCondition then notEqualMessage else ("Expected anything but value %q (%s)"):format(tostring(otherValue), (type(otherValue))) or "Assertion failed!"
	local errorLevel = 3 or 1
	if self.value == otherValue ~= self.successCondition then
		error(finalMessage, errorLevel + 1)
	end
	self:_resetModifiers()
	return self
end
function expectationClass.near(self, otherValue, limit)
	assert(type(self.value) == "number", "Expectation value must be a number to use \'near\'")
	assert(type(otherValue) == "number", "otherValue must be a number")
	assert(type(limit) == "number" or limit == nil, "limit must be a number or nil")
	local tolerance = limit or 1e-7
	local isNear = math.abs(self.value - otherValue) <= tolerance == self.successCondition
	local notNearMessage = ("Expected value to be near %f (within %f) but got %f instead"):format(otherValue, tolerance, self.value)
	local finalMessage = if self.successCondition then notNearMessage else ("Expected value to not be near %f (within %f) but got %f instead"):format(otherValue, tolerance, self.value) or "Assertion failed!"
	local errorLevel = 3 or 1
	if not isNear then
		error(finalMessage, errorLevel + 1)
	end
	self:_resetModifiers()
	return self
end
function expectationClass.throw(self, expectedError)
	local didThrow, errorMessage = pcall(self.value)
	local throwMatches = didThrow ~= self.successCondition
	if expectedError and not didThrow then
		throwMatches = if self.successCondition then errorMessage:find(expectedError, 1, true) ~= nil else errorMessage:find(expectedError, 1, true) == nil
	end
	local finalMessage
	if expectedError then
		local actualError, expectedStr
		if errorMessage then
			actualError = ("threw: %s"):format(errorMessage)
			if actualError then
				expectedStr = expectedError
			else
				expectedStr = expectedError
				actualError = "did not throw."
			end
		else
			expectedStr = expectedError
			actualError = "did not throw."
		end
		local throwContainsMessage = ("Expected function to throw an error containing %q, but it %s"):format(expectedStr, actualError)
		finalMessage = if self.successCondition then throwContainsMessage else ("Expected function to never throw an error containing %q, but it threw: %s"):format(expectedError, (tostring(errorMessage)))
	else
		finalMessage = if self.successCondition then "Expected function to throw an error, but it did not throw." else ("Expected function to succeed, but it threw an error: %s"):format((tostring(errorMessage)))
	end
	local displayMessage = finalMessage or "Assertion failed!"
	local errorLevel = 3 or 1
	if not throwMatches then
		error(displayMessage, errorLevel + 1)
	end
	self:_resetModifiers()
	return self
end
return expectationClass
