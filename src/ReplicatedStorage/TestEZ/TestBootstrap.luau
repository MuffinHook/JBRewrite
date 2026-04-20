local module_3 = {}
local function _(arg1) -- Line 11, Named "stripSpecSuffix"
    return arg1:gsub("%.spec$", "")
end
local function _(arg1) -- Line 14, Named "isSpecScript"
    local children = arg1:IsA("ModuleScript")
    if children then
        children = arg1.Name:match("%.spec$")
    end
    return children
end
local function getPath_upvr(arg1, arg2) -- Line 18, Named "getPath"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var3 = arg2
    if not var3 then
        var3 = game
    end
    local var4 = var3
    local module_2 = {}
    local var6 = arg1
    if var6.Name == "init.spec" then
        local Parent = var6.Parent
    end
    while Parent ~= nil and Parent ~= var4 do
        table.insert(module_2, Parent.Name:gsub("%.spec$", ""))
    end
    table.insert(module_2, var4.Name:gsub("%.spec$", ""))
    return module_2
end
local function _(arg1) -- Line 38, Named "toStringPath"
    local var15
    for _, v in ipairs(arg1) do
        if true then
            var15 = v
        else
            var15 = v..' '..var15
        end
    end
    return var15
end
function module_3.getModulesImpl(arg1, arg2, arg3, arg4) -- Line 52
    local var20 = arg3
    if not var20 then
        var20 = {}
    end
    local var21 = arg4 or arg2
    local var22 = var21
    var20 = var22:IsA("ModuleScript")
    local var23 = var20
    if var23 then
        var23 = var22.Name:match("%.spec$")
        local var24
    end
    if var23 then
        var24 = arg2
        local getPath_upvr_result1 = getPath_upvr(var21, var24)
        var24 = ""
        for _, v_2 in ipairs(getPath_upvr_result1) do
            if true then
                var24 = v_2
            else
                var24 = v_2..' '..var24
            end
        end
        var24 = table.insert
        var24(var20, {
            method = require(var21);
            path = getPath_upvr_result1;
            pathStringForSorting = var24:lower();
        })
    end
end
function module_3.getModules(arg1, arg2) -- Line 72
    local module = {}
    arg1:getModulesImpl(arg2, module)
    for _, v_3 in ipairs(arg2:GetDescendants()) do
        arg1:getModulesImpl(arg2, module, v_3)
    end
    return module
end
local TextReporter_upvr = require(script.Parent.Reporters.TextReporter)
local TestPlanner_upvr = require(script.Parent.TestPlanner)
local TestRunner_upvr = require(script.Parent.TestRunner)
function module_3.run(arg1, arg2, arg3, arg4) -- Line 99
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var57 = arg3
    if not var57 then
        var57 = TextReporter_upvr
    end
    var57 = arg4
    local var58 = var57
    if not var58 then
        var58 = {}
    end
    local var59 = var58
    local extraEnvironment = var59.extraEnvironment
    if not extraEnvironment then
        extraEnvironment = {}
    end
    if type(arg2) ~= "table" then
        error("Bad argument #1 to TestBootstrap:run. Expected table, got %s":format(typeof(arg2)), 2)
    end
    for _, v_4 in ipairs(arg2) do
        for _, v_5 in ipairs(arg1:getModules(v_4)) do
            table.insert({}, v_5)
            local var67
        end
    end
    local tick_result1_2 = tick()
    local tick_result1_3 = tick()
    local any_runPlan_result1 = TestRunner_upvr.runPlan(TestPlanner_upvr.createPlan(var67, var59.testNamePattern, extraEnvironment))
    local tick_result1 = tick()
    var57.report(any_runPlan_result1)
    if var59.showTimingInfo or false then
        print(table.concat({"Took %f seconds to locate test modules":format(tick_result1_2 - tick()), "Took %f seconds to create test plan":format(tick_result1_3 - tick_result1_2), "Took %f seconds to run tests":format(tick_result1 - tick_result1_3), "Took %f seconds to report tests":format(tick() - tick_result1)}, '\n'))
    end
    return any_runPlan_result1
end
return module_3