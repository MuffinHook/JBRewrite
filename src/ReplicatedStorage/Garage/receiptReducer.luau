-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:25
-- Luau version 6, Types version 3
-- Time taken: 0.003273 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    addReceiptItem = function(arg1, arg2) -- Line 5, Named "addReceiptItem"
        -- KONSTANTERROR: [0] 1. Error Block 42 start (CF ANALYSIS FAILED)
        local var2
        if arg2.name == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing receipt item Name")
        if arg2.title == nil then
            var2 = false
            -- KONSTANTWARNING: GOTO [18] #13
        end
        -- KONSTANTERROR: [0] 1. Error Block 42 end (CF ANALYSIS FAILED)
        -- KONSTANTERROR: [17] 12. Error Block 45 start (CF ANALYSIS FAILED)
        var2 = true
        assert(var2, "missing receipt item Title")
        if arg2.category == nil then
            var2 = false
            -- KONSTANTWARNING: GOTO [30] #21
        end
        -- KONSTANTERROR: [17] 12. Error Block 45 end (CF ANALYSIS FAILED)
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
        -- KONSTANTERROR: Expression was reused, decompilation is incorrect
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
        -- KONSTANTERROR: Expression was reused, decompilation is incorrect
        return {}
    end;
    clearReceipt = function() -- Line 49, Named "clearReceipt"
        return {}
    end;
    setPage = function() -- Line 53, Named "setPage"
        return {}
    end;
})