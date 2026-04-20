return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    setCategoryItemFavorited = function(arg1, arg2) -- Line 5, Named "setCategoryItemFavorited"
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local var6
        if arg2.category == nil then
            var6 = false
        else
            var6 = true
        end
        assert(var6, "missing category")
        if arg2.name == nil then
            var6 = false
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        var6 = true
        assert(var6, "missing name")
        if arg2.favorited == nil then
            var6 = false
        else
            var6 = true
        end
        assert(var6, "missing favorited")
        var6 = pairs(arg1)
        local pairs_result1, pairs_result2, pairs_result3 = pairs(arg1)
        for i, v in pairs_result1, pairs_result2, pairs_result3 do
            ({})[i] = v
            local var11
        end
        pairs_result1 = var11[arg2.category]
        if not pairs_result1 then
            pairs_result1 = arg2.category
            var11[pairs_result1] = {}
        end
        pairs_result1 = var11[arg2.category]
        pairs_result1[arg2.name] = arg2.favorited
        do
            return var11
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end;
    setFavoritedRaw = function(arg1, arg2) -- Line 20, Named "setFavoritedRaw"
        local var12
        if arg2.favorited == nil then
            var12 = false
        else
            var12 = true
        end
        assert(var12, "missing favorited table")
        return arg2.favorited
    end;
})