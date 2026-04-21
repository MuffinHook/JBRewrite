local module_upvr = {}
module_upvr.__index = module_upvr
function module_upvr.new() -- Line 3
    local module = {}
    setmetatable(module, module_upvr)
    module.MapNodeNode = {}
    module.ListNode = {}
    return module
end
function module_upvr.GetNeighbors(arg1, arg2) -- Line 12
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var7
    if arg1.MapNodeNode[arg2] == nil then
        var7 = false
    else
        var7 = true
    end
    assert(var7)
    var7 = pairs(arg1.MapNodeNode[arg2])
    for i in pairs(arg1.MapNodeNode[arg2]) do
        table.insert({}, i)
        local var12
    end
    return var12
end
function module_upvr.GetUndirectedNeighbors(arg1, arg2) -- Line 20
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var25
    if arg1.MapNodeNode[arg2] == nil then
        var25 = false
    else
        var25 = true
    end
    assert(var25)
    var25 = pairs(arg1.MapNodeNode[arg2])
    local pairs_result1, pairs_result2_3, pairs_result3_2 = pairs(arg1.MapNodeNode[arg2])
    for i_2 in pairs_result1, pairs_result2_3, pairs_result3_2 do
        table.insert({}, i_2)
        local var29
    end
    pairs_result1 = pairs(arg1.MapNodeNode)
    for i_3, v in pairs(arg1.MapNodeNode) do
        if v[arg2] then
            table.insert(var29, i_3)
        end
    end
    return var29
end
function module_upvr.AddNode(arg1, arg2) -- Line 33
    if arg1.MapNodeNode[arg2] ~= nil then
    else
        arg1.MapNodeNode[arg2] = {}
        table.insert(arg1.ListNode, arg2)
    end
end
function module_upvr.AddEdge(arg1, arg2, arg3) -- Line 40
    if arg1.MapNodeNode[arg2] == nil then
        arg1:AddNode(arg2)
    end
    if arg1.MapNodeNode[arg3] == nil then
        arg1:AddNode(arg3)
    end
    if arg1.MapNodeNode[arg2][arg3] ~= nil then
        error(string.format("Edge already exists from `%s` to `%s`", arg2, arg3));
    end
    arg1.MapNodeNode[arg2][arg3] = true
end
function module_upvr.HasEdge(arg1, arg2, arg3) -- Line 52
    local var33 = false
    if arg1.MapNodeNode[arg2] ~= nil then
        if arg1.MapNodeNode[arg2][arg3] ~= true then
            var33 = false
        else
            var33 = true
        end
    end
    return var33
end
function module_upvr.Inverse(arg1) -- Line 55
    local any_new_result1 = getmetatable(arg1).new()
    for _, v_2 in ipairs(arg1.ListNode) do
        any_new_result1:AddNode(v_2)
    end
    for i_5, v_3 in pairs(arg1.MapNodeNode) do
        for i_6 in pairs(v_3) do
            any_new_result1:AddEdge(i_6, i_5)
        end
    end
    return any_new_result1
end
return module_upvr