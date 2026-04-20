return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    addReceiptItem = function(arg1, arg2) -- Line 5, Named "addReceiptItem"
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local var2
        if arg2.name == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing receipt item Name")
        if arg2.title == nil then
            var2 = false
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        var2 = true
        assert(var2, "missing receipt item Title")
        if arg2.category == nil then
            var2 = false
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end;
    removeReceiptItem = function(arg1, arg2) -- Line 26, Named "removeReceiptItem"
        local var5
        if arg2.name == nil then
            var5 = false
        else
            var5 = true
        end
        assert(var5, "missing receipt item Name")
        if arg2.category == nil then
            var5 = false
        else
            var5 = true
        end
        assert(var5, "missing receipt item Category")
        var5 = #arg1
        for i = 1, var5 do
            local var6 = arg1[i]
            if var6.name ~= arg2.name or var6.category ~= arg2.category then
                table.insert({}, var6)
            end
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        return {}
    end;
    removeReceiptCategory = function(arg1, arg2) -- Line 38, Named "removeReceiptCategory"
        local var9
        if arg2.category == nil then
            var9 = false
        else
            var9 = true
        end
        assert(var9, "missing receipt item Category")
        var9 = #arg1
        for i_2 = 1, var9 do
            local var10 = arg1[i_2]
            if var10.category ~= arg2.category then
                table.insert({}, var10)
            end
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        return {}
    end;
    clearReceipt = function() -- Line 49, Named "clearReceipt"
        return {}
    end;
    setPage = function() -- Line 53, Named "setPage"
        return {}
    end;
})