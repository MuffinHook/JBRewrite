local TestEnum_upvr = require(script.Parent.TestEnum)
local tbl_upvr = {
    [TestEnum_upvr.TestStatus.Success] = '+';
    [TestEnum_upvr.TestStatus.Failure] = '-';
    [TestEnum_upvr.TestStatus.Skipped] = '~';
}
local module_3_upvr = {}
module_3_upvr.__index = module_3_upvr
function module_3_upvr.new(arg1) -- Line 25
    local module_4 = {
        successCount = 0;
        failureCount = 0;
        skippedCount = 0;
    }
    module_4.planNode = arg1
    module_4.children = {}
    module_4.errors = {}
    setmetatable(module_4, module_3_upvr)
    return module_4
end
function module_3_upvr.createNode(arg1) -- Line 43
    local module = {}
    module.planNode = arg1
    module.children = {}
    module.errors = {}
    module.status = nil
    return module
end
function module_3_upvr.visitAllNodes(arg1, arg2, arg3) -- Line 57
    for _, v in ipairs((arg3 or arg1).children) do
        arg2(v)
        arg1:visitAllNodes(arg2, v)
    end
end
function module_3_upvr.visualize(arg1, arg2, arg3) -- Line 70
    local var15 = arg3 or 0
    local module_2 = {}
    for _, v_2 in ipairs((arg2 or arg1).children) do
        if v_2.planNode.type == TestEnum_upvr.NodeType.It then
            local var20
            if v_2.messages and 0 < #v_2.messages then
                var20 = var20.."\n "..' ':rep(3 * var15)..table.concat(v_2.messages, "\n "..' ':rep(3 * var15))
            end
            table.insert(module_2, var20)
        else
            local formatted = "%s%s":format(' ':rep(3 * var15), v_2.planNode.phrase or "")
            var20 = v_2.status
            if var20 then
                var20 = formatted
                formatted = var20.." (%s)":format(v_2.status)
            end
            var20 = table.insert
            var20(module_2, formatted)
            var20 = #v_2.children
            if 0 < var20 then
                var20 = arg1:visualize(v_2, var15 + 1)
                table.insert(module_2, var20)
            end
        end
    end
    return table.concat(module_2, '\n')
end
return module_3_upvr