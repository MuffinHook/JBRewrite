local module = {}
local function _(arg1) -- Line 7, Named "teamCityEscape"
    return string.gsub(string.gsub(string.gsub(arg1, "([]|'[])", "|%1"), '\r', "|r"), '\n', "|n")
end
local function teamCityEnterSuite_upvr(arg1) -- Line 14, Named "teamCityEnterSuite"
    return string.format("##teamcity[testSuiteStarted name='%s']", string.gsub(string.gsub(string.gsub(arg1, "([]|'[])", "|%1"), '\r', "|r"), '\n', "|n"))
end
local function teamCityLeaveSuite_upvr(arg1) -- Line 18, Named "teamCityLeaveSuite"
    return string.format("##teamcity[testSuiteFinished name='%s']", string.gsub(string.gsub(string.gsub(arg1, "([]|'[])", "|%1"), '\r', "|r"), '\n', "|n"))
end
local function teamCityEnterCase_upvr(arg1) -- Line 22, Named "teamCityEnterCase"
    return string.format("##teamcity[testStarted name='%s']", string.gsub(string.gsub(string.gsub(arg1, "([]|'[])", "|%1"), '\r', "|r"), '\n', "|n"))
end
local function teamCityLeaveCase_upvr(arg1) -- Line 26, Named "teamCityLeaveCase"
    return string.format("##teamcity[testFinished name='%s']", string.gsub(string.gsub(string.gsub(arg1, "([]|'[])", "|%1"), '\r', "|r"), '\n', "|n"))
end
local function teamCityFailCase_upvr(arg1, arg2) -- Line 30, Named "teamCityFailCase"
    return string.format("##teamcity[testFailed name='%s' message='%s']", string.gsub(string.gsub(string.gsub(arg1, "([]|'[])", "|%1"), '\r', "|r"), '\n', "|n"), string.gsub(string.gsub(string.gsub(arg2, "([]|'[])", "|%1"), '\r', "|r"), '\n', "|n"))
end
local TestEnum_upvr = require(script.Parent.Parent.TestEnum)
local function reportNode_upvr(arg1, arg2, arg3) -- Line 35, Named "reportNode"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var11 = arg2
    if not var11 then
        var11 = {}
    end
    local var12 = var11
    if arg1.status == TestEnum_upvr.TestStatus.Skipped then
        return var12
    end
    if arg1.planNode.type == TestEnum_upvr.NodeType.Describe then
        table.insert(var12, teamCityEnterSuite_upvr(arg1.planNode.phrase))
        for _, v in ipairs(arg1.children) do
            reportNode_upvr(v, var12, (arg3 or 0) + 1)
            local var16
        end
        table.insert(var16, teamCityLeaveSuite_upvr(arg1.planNode.phrase))
    else
        table.insert(var16, teamCityEnterCase_upvr(arg1.planNode.phrase))
        if arg1.status == TestEnum_upvr.TestStatus.Failure then
            table.insert(var16, teamCityFailCase_upvr(arg1.planNode.phrase, table.concat(arg1.errors, '\n')))
        end
        table.insert(var16, teamCityLeaveCase_upvr(arg1.planNode.phrase))
    end
end
local function reportRoot_upvr(arg1) -- Line 56, Named "reportRoot"
    local module_2 = {}
    for _, v_2 in ipairs(arg1.children) do
        reportNode_upvr(v_2, module_2, 0)
    end
    return module_2
end
local function report(arg1) -- Line 66
    return table.concat(reportRoot_upvr(arg1), '\n')
end
local TestService_upvr = game:GetService("TestService")
function module.report(arg1) -- Line 72
    print(table.concat({"Test results:", table.concat(reportRoot_upvr(arg1), '\n'), string.format("%d passed, %d failed, %d skipped", arg1.successCount, arg1.failureCount, arg1.skippedCount)}, '\n'))
    if 0 < arg1.failureCount then
        print(string.format("%d test nodes reported failures.", arg1.failureCount))
    end
    if 0 < #arg1.errors then
        print("Errors reported by tests:")
        print("")
        for _, v_3 in ipairs(arg1.errors) do
            TestService_upvr:Error(v_3)
            print("")
        end
    end
end
return module