local module_upvr = {
    dfs = function(arg1, arg2, arg3, arg4) -- Line 2, Named "dfs"
        if arg1 == nil then
        else
        end
        assert(true, "missing Graph G")
        if arg2 == nil then
        else
        end
        assert(true, "missing start vertex v")
        if typeof(arg3) ~= "nil" then
            if typeof(arg3) ~= "function" then
            else
            end
        end
        assert(true, "invalid condition")
        local var2_upvw = arg4
        if not var2_upvw then
            var2_upvw = arg1.GetNeighbors
        end
        local module_upvr_2 = {}
        local function _dfs_upvr(arg1_2) -- Line 10, Named "_dfs"
            module_upvr_2[arg1_2] = true
            for _, v in ipairs(var2_upvw(arg1, arg1_2)) do
                if not module_upvr_2[v] and (arg3 == nil or arg3(v)) then
                    _dfs_upvr(v)
                end
            end
        end
        _dfs_upvr(arg2)
        return module_upvr_2
    end;
    bfsSearch = function(arg1, arg2, arg3) -- Line 23, Named "bfsSearch"
        local tbl = {
            [arg2] = true;
        }
        local tbl_2 = {}
        table.insert(tbl_2, arg2)
        while 0 < #tbl_2 do
            local popped = table.remove(tbl_2)
            if arg3(popped) then
                return popped
            end
            for _, v_2 in ipairs(arg1:GetNeighbors(popped)) do
                if not tbl[v_2] then
                    tbl[v_2] = true
                    table.insert(tbl_2, v_2)
                end
            end
        end
    end;
}
function module_upvr.weaklyConnectedComponents(arg1) -- Line 41
    if arg1 == nil then
    else
    end
    assert(true, "missing Graph G")
    local tbl_3 = {}
    for _, v_3 in ipairs(arg1.ListNode) do
        if not tbl_3[v_3] then
            tbl_3[v_3] = true
            local any_dfs_result1 = module_upvr.dfs(arg1, v_3, nil, arg1.GetUndirectedNeighbors)
            local any_new_result1 = getmetatable(arg1).new()
            for i_4 in pairs(any_dfs_result1) do
                tbl_3[i_4] = true
                any_new_result1:AddNode(i_4)
                for i_5 in pairs(arg1.MapNodeNode[i_4]) do
                    if any_dfs_result1[i_5] then
                        any_new_result1:AddEdge(i_4, i_5)
                    end
                end
            end
            table.insert({}, any_new_result1)
        end
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    return {}
end
return module_upvr