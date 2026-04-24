-- Reviewed by Claude
-- variables reassigned
local Expectation = require(script.Parent.Expectation)
local checkMatcherNameCollisions = Expectation.checkMatcherNameCollisions
local function copy(table)
	local newTable = {}
	for k, v in pairs(table) do
		newTable[k] = v
	end
	return newTable
end
local expectationContextClass = {}
expectationContextClass.__index = expectationContextClass
function expectationContextClass.new(parentContext)
	local context = {}
	local extensions
	if parentContext then
		local copiedExtensions = {}
		for k, v in pairs(parentContext._extensions) do
			copiedExtensions[k] = v
		end
		extensions = copiedExtensions or {}
	else
		extensions = {}
	end
	context._extensions = extensions
	return setmetatable(context, expectationContextClass)
end
function expectationContextClass.startExpectationChain(self, ...)
	return Expectation.new(...):extend(self._extensions)
end
function expectationContextClass.extend(self, matchers)
	for k, v in pairs(matchers) do
		assert(self._extensions[k] == nil, string.format("Cannot reassign %q in expect.extend", k))
		assert(checkMatcherNameCollisions(k), string.format("Cannot overwrite matcher %q; it already exists", k))
		self._extensions[k] = v
	end
end
return expectationContextClass
