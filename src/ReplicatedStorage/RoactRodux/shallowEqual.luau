return function(arg1, arg2) -- Line 1, Named "shallowEqual"
    if arg1 == nil then
        if arg2 ~= nil then
        else
        end
        do
            return true
        end
        local var9
    end
    if arg2 == nil then
        if arg1 ~= nil then
            var9 = false
        else
            var9 = true
        end
        return var9
    end
    for i, v in pairs(arg1) do
        if v ~= arg2[i] then
            return false
        end
    end
    for i_2, v_2 in pairs(arg2) do
        if v_2 ~= arg1[i_2] then
            return false
        end
    end
    return true
end