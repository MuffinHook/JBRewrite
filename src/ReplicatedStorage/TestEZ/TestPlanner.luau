local module = {}
local TestPlan_upvr = require(script.Parent.TestPlan)
function module.createPlan(arg1, arg2, arg3) -- Line 26
    local any_new_result1 = TestPlan_upvr.new(arg2, arg3)
    table.sort(arg1, function(arg1_2, arg2_2) -- Line 29
        local var9
        if arg1_2.pathStringForSorting >= arg2_2.pathStringForSorting then
            var9 = false
        else
            var9 = true
        end
        return var9
    end)
    for _, v in ipairs(arg1) do
        any_new_result1:addRoot(v.path, v.method)
    end
    return any_new_result1
end
return module