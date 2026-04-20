local function TableDeepCopy_upvr(arg1) -- Line 1, Named "TableDeepCopy"
    if type(arg1) == "table" then
        for i, v in next, arg1 do
            ({})[TableDeepCopy_upvr(i)] = TableDeepCopy_upvr(v)
            local var6
        end
        setmetatable(var6, TableDeepCopy_upvr(getmetatable(arg1)))
        return var6
    end
    return arg1
end
return {
    DeepCopy = TableDeepCopy_upvr;
    Concat = function(arg1, arg2) -- Line 15, Named "TableConcat"
        for i_2 = 1, #arg2 do
            arg1[#arg1 + 1] = arg2[i_2]
        end
        return arg1
    end;
}