-- Reviewed by Claude
local TestEnum = require(script.Parent.TestEnum)
local TestResults = require(script.Parent.TestResults)
local Context = require(script.Parent.Context)
local ExpectationContext = require(script.Parent.ExpectationContext)
local t = {}
t.__index = t
function t.new(p1)
	local t2 = {
		results = TestResults.new(p1),
		nodeStack = {},
		contextStack = {},
		expectationContextStack = {},
		hasFocusNodes = false
	}
	setmetatable(t2, t)
	return t2
end
function t.calculateTotals(p1)
	local results = p1.results
	results.successCount = 0
	results.failureCount = 0
	results.skippedCount = 0
	results:visitAllNodes(function(p1)
		local status = p1.status
		if p1.planNode.type == TestEnum.NodeType.It then
			if status == TestEnum.TestStatus.Success then
				results.successCount = results.successCount + 1
			elseif status == TestEnum.TestStatus.Failure then
				results.failureCount = results.failureCount + 1
			elseif status == TestEnum.TestStatus.Skipped then
				results.skippedCount = results.skippedCount + 1
			end
		end
	end)
end
function t.gatherErrors(p1)
	local results = p1.results
	results.errors = {}
	results:visitAllNodes(function(p1)
		if #p1.errors > 0 then
			for i, v in ipairs(p1.errors) do
				table.insert(results.errors, v)
			end
		end
	end)
end
function t.finalize(p1)
	if #p1.nodeStack ~= 0 then
		error("Cannot finalize TestResults with nodes still on the stack!", 2)
	end
	p1:calculateTotals()
	p1:gatherErrors()
	return p1.results
end
function t.pushNode(p1, p2)
	local v1 = TestResults.createNode(p2)
	table.insert((p1.nodeStack[#p1.nodeStack] or p1.results).children, v1)
	table.insert(p1.nodeStack, v1)
	table.insert(p1.contextStack, (Context.new(p1.contextStack[#p1.contextStack])))
	table.insert(p1.expectationContextStack, (ExpectationContext.new(p1.expectationContextStack[#p1.expectationContextStack])))
end
function t.popNode(p1)
	assert(#p1.nodeStack > 0, "Tried to pop from an empty node stack!")
	table.remove(p1.nodeStack, #p1.nodeStack)
	table.remove(p1.contextStack, #p1.contextStack)
	table.remove(p1.expectationContextStack, #p1.expectationContextStack)
end
function t.getContext(p1)
	assert(#p1.contextStack > 0, "Tried to get context from an empty stack!")
	return p1.contextStack[#p1.contextStack]
end
function t.getExpectationContext(p1)
	assert(#p1.expectationContextStack > 0, "Tried to get expectationContext from an empty stack!")
	return p1.expectationContextStack[#p1.expectationContextStack]
end
function t.shouldSkip(p1)
	if p1.hasFocusNodes then
		for i = #p1.nodeStack, 1, -1 do
			local v1 = p1.nodeStack[i]
			if v1.planNode.modifier == TestEnum.NodeModifier.Skip then
				return true
			end
			if v1.planNode.modifier == TestEnum.NodeModifier.Focus then
				return false
			end
		end
		return true
	end
	for j = #p1.nodeStack, 1, -1 do
		if p1.nodeStack[j].planNode.modifier == TestEnum.NodeModifier.Skip then
			return true
		end
	end
	return false
end
function t.setSuccess(p1)
	assert(#p1.nodeStack > 0, "Attempting to set success status on empty stack")
	p1.nodeStack[#p1.nodeStack].status = TestEnum.TestStatus.Success
end
function t.setSkipped(p1)
	assert(#p1.nodeStack > 0, "Attempting to set skipped status on empty stack")
	p1.nodeStack[#p1.nodeStack].status = TestEnum.TestStatus.Skipped
end
function t.setError(p1, p2)
	assert(#p1.nodeStack > 0, "Attempting to set error status on empty stack")
	local v2 = p1.nodeStack[#p1.nodeStack]
	v2.status = TestEnum.TestStatus.Failure
	table.insert(v2.errors, p2)
end
function t.addDummyError(p1, p2, p3)
	p1:pushNode({
		type = TestEnum.NodeType.It,
		phrase = p2
	})
	p1:setError(p3)
	p1:popNode()
	p1.nodeStack[#p1.nodeStack].status = TestEnum.TestStatus.Failure
end
function t.setStatusFromChildren(p1)
	assert(#p1.nodeStack > 0, "Attempting to set status from children on empty stack")
	local v2 = p1.nodeStack[#p1.nodeStack]
	local Success = TestEnum.TestStatus.Success
	local v3 = true
	for i, v in ipairs(v2.children) do
		if v.status ~= TestEnum.TestStatus.Skipped then
			v3 = false
			if v.status == TestEnum.TestStatus.Failure then
				Success = TestEnum.TestStatus.Failure
			end
		end
	end
	if v3 then
		Success = TestEnum.TestStatus.Skipped
	end
	v2.status = Success
end
return t
