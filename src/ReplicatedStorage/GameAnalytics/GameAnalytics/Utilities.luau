return {
    isStringNullOrEmpty = function(arg1, arg2) -- Line 3, Named "isStringNullOrEmpty"
        local var2 = not arg2
        if not var2 then
            if #arg2 ~= 0 then
                var2 = false
            else
                var2 = true
            end
        end
        return var2
    end;
    stringArrayContainsString = function(arg1, arg2, arg3) -- Line 7, Named "stringArrayContainsString"
        if #arg2 == 0 then
            return false
        end
        for _, v in ipairs(arg2) do
            if v == arg3 then
                return true
            end
        end
        return false
    end;
    copyTable = function(arg1, arg2) -- Line 21, Named "copyTable"
        for i_2, v_2 in pairs(arg2) do
            if typeof(v_2) == "table" then
                ({})[i_2] = arg1:copyTable(v_2)
            else
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                ;({})[i_2] = v_2
            end
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        return {}
    end;
}