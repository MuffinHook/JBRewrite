-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:51
-- Luau version 6, Types version 3
-- Time taken: 0.005104 seconds

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
            --[[ Upvalues[5]:
                [1]: module_upvr_2 (readonly)
                [2]: var2_upvw (read and write)
                [3]: arg1 (readonly)
                [4]: arg3 (readonly)
                [5]: _dfs_upvr (readonly)
            ]]
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
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
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
    -- KONSTANTERROR: Expression was reused, decompilation is incorrect
    return {}
end
return module_upvr