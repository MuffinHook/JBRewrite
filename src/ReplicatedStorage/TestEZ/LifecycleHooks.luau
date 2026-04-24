-- Reviewed by Claude
local TestEnum = require(script.Parent.TestEnum)
local t = {}
t.__index = t
function t.new()
	return setmetatable({
		_stack = {}
	}, t)
end
function t.getBeforeEachHooks(p1)
	local BeforeEach = TestEnum.NodeType.BeforeEach
	local t = {}
	for i, v in ipairs(p1._stack) do
		for i2, v2 in ipairs(v[BeforeEach]) do
			table.insert(t, v2)
		end
	end
	return t
end
function t.getAfterEachHooks(p1)
	local AfterEach = TestEnum.NodeType.AfterEach
	local t = {}
	for i, v in ipairs(p1._stack) do
		for i2, v2 in ipairs(v[AfterEach]) do
			table.insert(t, 1, v2)
		end
	end
	return t
end
function t.popHooks(p1)
	table.remove(p1._stack, #p1._stack)
end
function t.pushHooksFrom(p1, p2)
	assert(p2 ~= nil)
	table.insert(p1._stack, {
		[TestEnum.NodeType.BeforeAll] = p1:_getHooksOfType(p2.children, TestEnum.NodeType.BeforeAll),
		[TestEnum.NodeType.AfterAll] = p1:_getHooksOfType(p2.children, TestEnum.NodeType.AfterAll),
		[TestEnum.NodeType.BeforeEach] = p1:_getHooksOfType(p2.children, TestEnum.NodeType.BeforeEach),
		[TestEnum.NodeType.AfterEach] = p1:_getHooksOfType(p2.children, TestEnum.NodeType.AfterEach)
	})
end
function t.getBeforeAllHooks(p1)
	return p1._stack[#p1._stack][TestEnum.NodeType.BeforeAll]
end
function t.getAfterAllHooks(p1)
	return p1._stack[#p1._stack][TestEnum.NodeType.AfterAll]
end
function t._getHooksOfType(p1, p2, p3)
	local t = {}
	for i, v in ipairs(p2) do
		if v.type == p3 then
			table.insert(t, v.callback)
		end
	end
	return t
end
return t
