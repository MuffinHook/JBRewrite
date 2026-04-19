-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:50
-- Luau version 6, Types version 3
-- Time taken: 0.006974 seconds

local module_upvr = {}
module_upvr.__index = module_upvr
function module_upvr.new() -- Line 3
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    local module = {}
    setmetatable(module, module_upvr)
    module.MapNodeNode = {}
    module.ListNode = {}
    return module
end
function module_upvr.GetNeighbors(arg1, arg2) -- Line 12
    -- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
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
    -- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
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
        error("Edge already exists from `%s` to `%s`":format(arg2, arg3))
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