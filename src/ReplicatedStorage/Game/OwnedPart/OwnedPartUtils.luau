local module_upvr = {
    getAll = function(arg1, arg2) -- Line 2, Named "getAll"
        if arg1 == nil then
        else
        end
        assert(true)
        if arg2 == nil then
        else
        end
        assert(true)
        for _, v in ipairs(arg1:GetAll()) do
            if v:GetOwner() == arg2 then
                table.insert({}, v)
            end
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        return {}
    end;
    getPool = function(arg1, arg2) -- Line 13, Named "getPool"
        if arg1 == nil then
        else
        end
        assert(true)
        if arg2 == nil then
        else
        end
        assert(true)
        for _, v_2 in ipairs(arg1:GetAll()) do
            if v_2:GetOwner() == arg2 and v_2:IsInPool() then
                table.insert({}, v_2)
            end
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        return {}
    end;
}
function module_upvr.cleanPool(arg1, arg2) -- Line 24
    local any_getPool_result1 = module_upvr.getPool(arg1, arg2)
    print("removing %d items from pool %s":format(#any_getPool_result1, arg2.Name))
    for _, v_3 in ipairs(any_getPool_result1) do
        v_3._obj:Destroy()
    end
end
return module_upvr