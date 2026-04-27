local TestEnum = require(script.Parent.TestEnum)
local lifecycleHooksClass = {}
lifecycleHooksClass.__index = lifecycleHooksClass
function lifecycleHooksClass.new()
	return setmetatable({
		_stack = {}
	}, lifecycleHooksClass)
end
function lifecycleHooksClass.getBeforeEachHooks(self)
	local BeforeEach = TestEnum.NodeType.BeforeEach
	local hooks = {}
	for i, hookLevel in ipairs(self._stack) do
		for i2, hook in ipairs(hookLevel[BeforeEach]) do
			table.insert(hooks, hook)
		end
	end
	return hooks
end
function lifecycleHooksClass.getAfterEachHooks(self)
	local AfterEach = TestEnum.NodeType.AfterEach
	local hooks = {}
	for i, hookLevel in ipairs(self._stack) do
		for i2, hook in ipairs(hookLevel[AfterEach]) do
			table.insert(hooks, 1, hook)
		end
	end
	return hooks
end
function lifecycleHooksClass.popHooks(self)
	table.remove(self._stack, #self._stack)
end
function lifecycleHooksClass.pushHooksFrom(self, node)
	assert(node ~= nil)
	table.insert(self._stack, {
		[TestEnum.NodeType.BeforeAll] = self:_getHooksOfType(node.children, TestEnum.NodeType.BeforeAll),
		[TestEnum.NodeType.AfterAll] = self:_getHooksOfType(node.children, TestEnum.NodeType.AfterAll),
		[TestEnum.NodeType.BeforeEach] = self:_getHooksOfType(node.children, TestEnum.NodeType.BeforeEach),
		[TestEnum.NodeType.AfterEach] = self:_getHooksOfType(node.children, TestEnum.NodeType.AfterEach)
	})
end
function lifecycleHooksClass.getBeforeAllHooks(self)
	return self._stack[#self._stack][TestEnum.NodeType.BeforeAll]
end
function lifecycleHooksClass.getAfterAllHooks(self)
	return self._stack[#self._stack][TestEnum.NodeType.AfterAll]
end
function lifecycleHooksClass._getHooksOfType(self, children, nodeType)
	local hooks = {}
	for i, child in ipairs(children) do
		if child.type == nodeType then
			table.insert(hooks, child.callback)
		end
	end
	return hooks
end
return lifecycleHooksClass
