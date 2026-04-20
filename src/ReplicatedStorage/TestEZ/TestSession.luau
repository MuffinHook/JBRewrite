local TestEnum_upvr = require(script.Parent.TestEnum)
local TestResults_upvr = require(script.Parent.TestResults)
local module_upvr = {}
module_upvr.__index = module_upvr
function module_upvr.new(arg1) -- Line 24
    local module = {
        results = TestResults_upvr.new(arg1);
        nodeStack = {};
        contextStack = {};
        expectationContextStack = {};
        hasFocusNodes = false;
    }
    setmetatable(module, module_upvr)
    return module
end
function module_upvr.calculateTotals(arg1) -- Line 42
    local results_upvr_2 = arg1.results
    results_upvr_2.successCount = 0
    results_upvr_2.failureCount = 0
    results_upvr_2.skippedCount = 0
    results_upvr_2:visitAllNodes(function(arg1_2) -- Line 49
        local status = arg1_2.status
        if arg1_2.planNode.type == TestEnum_upvr.NodeType.It then
            if status == TestEnum_upvr.TestStatus.Success then
                results_upvr_2.successCount += 1
                return
            end
            if status == TestEnum_upvr.TestStatus.Failure then
                results_upvr_2.failureCount += 1
                return
            end
            if status == TestEnum_upvr.TestStatus.Skipped then
                results_upvr_2.skippedCount += 1
            end
        end
    end)
end
function module_upvr.gatherErrors(arg1) -- Line 69
    local results_upvr = arg1.results
    results_upvr.errors = {}
    results_upvr:visitAllNodes(function(arg1_3) -- Line 74
        if 0 < #arg1_3.errors then
            for _, v in ipairs(arg1_3.errors) do
                table.insert(results_upvr.errors, v)
            end
        end
    end)
end
function module_upvr.finalize(arg1) -- Line 86
    if #arg1.nodeStack ~= 0 then
        error("Cannot finalize TestResults with nodes still on the stack!", 2)
    end
    arg1:calculateTotals()
    arg1:gatherErrors()
    return arg1.results
end
local Context_upvr = require(script.Parent.Context)
local ExpectationContext_upvr = require(script.Parent.ExpectationContext)
function module_upvr.pushNode(arg1, arg2) -- Line 100
    local any_createNode_result1 = TestResults_upvr.createNode(arg2)
    local var18 = arg1.nodeStack[#arg1.nodeStack]
    if not var18 then
        var18 = arg1.results
    end
    table.insert(var18.children, any_createNode_result1)
    table.insert(arg1.nodeStack, any_createNode_result1)
    table.insert(arg1.contextStack, Context_upvr.new(arg1.contextStack[#arg1.contextStack]))
    table.insert(arg1.expectationContextStack, ExpectationContext_upvr.new(arg1.expectationContextStack[#arg1.expectationContextStack]))
end
function module_upvr.popNode(arg1) -- Line 118
    local var19
    if 0 >= #arg1.nodeStack then
        var19 = false
    else
        var19 = true
    end
    assert(var19, "Tried to pop from an empty node stack!")
    var19 = arg1.nodeStack
    table.remove(var19, #arg1.nodeStack)
    var19 = arg1.contextStack
    table.remove(var19, #arg1.contextStack)
    var19 = arg1.expectationContextStack
    table.remove(var19, #arg1.expectationContextStack)
end
function module_upvr.getContext(arg1) -- Line 128
    local var20
    if 0 >= #arg1.contextStack then
        var20 = false
    else
        var20 = true
    end
    assert(var20, "Tried to get context from an empty stack!")
    var20 = arg1.contextStack
    return var20[#arg1.contextStack]
end
function module_upvr.getExpectationContext(arg1) -- Line 134
    local var21
    if 0 >= #arg1.expectationContextStack then
        var21 = false
    else
        var21 = true
    end
    assert(var21, "Tried to get expectationContext from an empty stack!")
    var21 = arg1.expectationContextStack
    return var21[#arg1.expectationContextStack]
end
function module_upvr.shouldSkip(arg1) -- Line 142
    if arg1.hasFocusNodes then
        for i_2 = #arg1.nodeStack, 1, -1 do
            local var24 = arg1.nodeStack[i_2]
            if var24.planNode.modifier == TestEnum_upvr.NodeModifier.Skip then
                return true
            end
            if var24.planNode.modifier == TestEnum_upvr.NodeModifier.Focus then
                return false
            end
        end
        return true
    end
    for i_3 = #arg1.nodeStack, 1, -1 do
        if arg1.nodeStack[i_3].planNode.modifier == TestEnum_upvr.NodeModifier.Skip then
            return true
        end
    end
    return false
end
function module_upvr.setSuccess(arg1) -- Line 176
    local var25
    if 0 >= #arg1.nodeStack then
        var25 = false
    else
        var25 = true
    end
    assert(var25, "Attempting to set success status on empty stack")
    var25 = arg1.nodeStack
    var25 = TestEnum_upvr
    var25 = var25.TestStatus
    var25 = var25.Success
    var25[#arg1.nodeStack].status = var25
end
function module_upvr.setSkipped(arg1) -- Line 184
    local var26
    if 0 >= #arg1.nodeStack then
        var26 = false
    else
        var26 = true
    end
    assert(var26, "Attempting to set skipped status on empty stack")
    var26 = arg1.nodeStack
    var26 = TestEnum_upvr
    var26 = var26.TestStatus
    var26 = var26.Skipped
    var26[#arg1.nodeStack].status = var26
end
function module_upvr.setError(arg1, arg2) -- Line 193
    local var27
    if 0 >= #arg1.nodeStack then
        var27 = false
    else
        var27 = true
    end
    assert(var27, "Attempting to set error status on empty stack")
    var27 = arg1.nodeStack
    local var28 = var27[#arg1.nodeStack]
    var27 = TestEnum_upvr
    var27 = var27.TestStatus
    var27 = var27.Failure
    var28.status = var27
    var27 = table.insert
    var27(var28.errors, arg2)
end
function module_upvr.addDummyError(arg1, arg2, arg3) -- Line 205
    local tbl = {
        type = TestEnum_upvr.NodeType.It;
    }
    tbl.phrase = arg2
    arg1:pushNode(tbl)
    arg1:setError(arg3)
    arg1:popNode()
    arg1.nodeStack[#arg1.nodeStack].status = TestEnum_upvr.TestStatus.Failure
end
function module_upvr.setStatusFromChildren(arg1) -- Line 217
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var38
    if 0 >= #arg1.nodeStack then
        var38 = false
    else
        var38 = true
    end
    assert(var38, "Attempting to set status from children on empty stack")
    var38 = arg1.nodeStack
    local var39 = var38[#arg1.nodeStack]
    var38 = TestEnum_upvr
    var38 = var38.TestStatus
    var38 = var38.Success
    for _, v_2 in ipairs(var39.children) do
        if v_2.status ~= TestEnum_upvr.TestStatus.Skipped and v_2.status == TestEnum_upvr.TestStatus.Failure then
            var38 = TestEnum_upvr.TestStatus.Failure
        end
    end
    if false then
        var38 = TestEnum_upvr.TestStatus.Skipped
    end
    var39.status = var38
end
return module_upvr