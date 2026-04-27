local TestEnum = require(script.Parent.TestEnum)
local TestResults = require(script.Parent.TestResults)
local Context = require(script.Parent.Context)
local ExpectationContext = require(script.Parent.ExpectationContext)
local TestSession = {}
TestSession.__index = TestSession
function TestSession.new(nodeResults)
	local newSession = {
		results = TestResults.new(nodeResults),
		nodeStack = {},
		contextStack = {},
		expectationContextStack = {},
		hasFocusNodes = false
	}
	setmetatable(newSession, TestSession)
	return newSession
end
function TestSession.calculateTotals(self)
	local results = self.results
	results.successCount = 0
	results.failureCount = 0
	results.skippedCount = 0
	results:visitAllNodes(function(resultNode)
		local status = resultNode.status
		if resultNode.planNode.type == TestEnum.NodeType.It then
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
function TestSession.gatherErrors(self)
	local results = self.results
	results.errors = {}
	results:visitAllNodes(function(resultNode)
		if #resultNode.errors > 0 then
			for i, error in ipairs(resultNode.errors) do
				table.insert(results.errors, error)
			end
		end
	end)
end
function TestSession.finalize(self)
	if #self.nodeStack ~= 0 then
		error("Cannot finalize TestResults with nodes still on the stack!", 2)
	end
	self:calculateTotals()
	self:gatherErrors()
	return self.results
end
function TestSession.pushNode(self, nodeDefinition)
	local newNode = TestResults.createNode(nodeDefinition)
	table.insert((self.nodeStack[#self.nodeStack] or self.results).children, newNode)
	table.insert(self.nodeStack, newNode)
	table.insert(self.contextStack, (Context.new(self.contextStack[#self.contextStack])))
	table.insert(self.expectationContextStack, (ExpectationContext.new(self.expectationContextStack[#self.expectationContextStack])))
end
function TestSession.popNode(self)
	assert(#self.nodeStack > 0, "Tried to pop from an empty node stack!")
	table.remove(self.nodeStack, #self.nodeStack)
	table.remove(self.contextStack, #self.contextStack)
	table.remove(self.expectationContextStack, #self.expectationContextStack)
end
function TestSession.getContext(self)
	assert(#self.contextStack > 0, "Tried to get context from an empty stack!")
	return self.contextStack[#self.contextStack]
end
function TestSession.getExpectationContext(self)
	assert(#self.expectationContextStack > 0, "Tried to get expectationContext from an empty stack!")
	return self.expectationContextStack[#self.expectationContextStack]
end
function TestSession.shouldSkip(self)
	if self.hasFocusNodes then
		for i = #self.nodeStack, 1, -1 do
			local currentNode = self.nodeStack[i]
			if currentNode.planNode.modifier == TestEnum.NodeModifier.Skip then
				return true
			end
			if currentNode.planNode.modifier == TestEnum.NodeModifier.Focus then
				return false
			end
		end
		return true
	end
	for j = #self.nodeStack, 1, -1 do
		if self.nodeStack[j].planNode.modifier == TestEnum.NodeModifier.Skip then
			return true
		end
	end
	return false
end
function TestSession.setSuccess(self)
	assert(#self.nodeStack > 0, "Attempting to set success status on empty stack")
	self.nodeStack[#self.nodeStack].status = TestEnum.TestStatus.Success
end
function TestSession.setSkipped(self)
	assert(#self.nodeStack > 0, "Attempting to set skipped status on empty stack")
	self.nodeStack[#self.nodeStack].status = TestEnum.TestStatus.Skipped
end
function TestSession.setError(self, errorMessage)
	assert(#self.nodeStack > 0, "Attempting to set error status on empty stack")
	local currentNode = self.nodeStack[#self.nodeStack]
	currentNode.status = TestEnum.TestStatus.Failure
	table.insert(currentNode.errors, errorMessage)
end
function TestSession.addDummyError(self, errorPhrase, errorMessage)
	self:pushNode({
		type = TestEnum.NodeType.It,
		phrase = errorPhrase
	})
	self:setError(errorMessage)
	self:popNode()
	self.nodeStack[#self.nodeStack].status = TestEnum.TestStatus.Failure
end
function TestSession.setStatusFromChildren(self)
	assert(#self.nodeStack > 0, "Attempting to set status from children on empty stack")
	local currentNode = self.nodeStack[#self.nodeStack]
	local nodeStatus = TestEnum.TestStatus.Success
	local allChildrenSkipped = true
	for i, child in ipairs(currentNode.children) do
		if child.status ~= TestEnum.TestStatus.Skipped then
			allChildrenSkipped = false
			if child.status == TestEnum.TestStatus.Failure then
				nodeStatus = TestEnum.TestStatus.Failure
			end
		end
	end
	if allChildrenSkipped then
		nodeStatus = TestEnum.TestStatus.Skipped
	end
	currentNode.status = nodeStatus
end
return TestSession
