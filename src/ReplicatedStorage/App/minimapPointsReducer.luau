return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    addMinimapPoint = function(arg1, arg2) -- Line 5, Named "addMinimapPoint"
        local var6
        if arg2.point.name == nil then
            var6 = false
        else
            var6 = true
        end
        assert(var6, "minimap point missing unique name")
        local module = {}
        var6 = ipairs(arg1)
        local ipairs_result1, ipairs_result2, ipairs_result3_2 = ipairs(arg1)
        for _, v in ipairs_result1, ipairs_result2, ipairs_result3_2 do
            if v.name ~= arg2.point.name then
                table.insert(module, v)
            end
        end
        ipairs_result1 = table.insert
        ipairs_result1(module, arg2.point)
        return module
    end;
    removeMinimapPoint = function(arg1, arg2) -- Line 18, Named "removeMinimapPoint"
        local var15
        if arg2.name == nil then
            var15 = false
        else
            var15 = true
        end
        assert(var15, "minimap point missing unique name")
        var15 = ipairs(arg1)
        for _, v_2 in ipairs(arg1) do
            if v_2.name ~= arg2.name then
                table.insert({}, v_2)
            end
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        return {}
    end;
})