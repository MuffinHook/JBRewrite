-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMTBl9mcm9udA5GaW5kRmlyc3RDaGlsZAVWYWx1ZQVfYmFjawV0YWJsZQZpbnNlcnQGaXBhaXJzBFNpemUBWgZDRnJhbWUKTG9va1ZlY3RvcgtsaXN0U2VnbWVudAtsZW5ndGhDYWNoZQt0b3RhbExlbmd0aA5kaXJlY3Rpb25DYWNoZQtjb21wdXRlUmFpbBBjYWxjdWxhdGVTZWdtZW50CFBvc2l0aW9uEWNhbGN1bGF0ZVBvc2l0aW9uAAQSAgAAAACAAf8CAgAAAAAAqQMBAGoDAgCpAwEAagMCAf8DAAACAAAAUgQAAFIFAQDFAwQDAQAAAG8GAAC8BAEDAQAAAJ8EAwJNBATsAgAAAG8HAwC8BQEDAQAAAJ8FAwJNBQXsAgAAAPEAAgAEAAAAqQYAAakGAQAOBgIAUgcFACsHAQBSBwQAhwgCBysIDACpCAEAaggCB540AwUHAAAAUgkDAFIKBwCkCAYAABRAgJ8IAwFSAAEAUgEHAEgA3v//BAAAAAAAAIwFAACkBggAAABwQFIHAwCfBgIEUQYMAE0LCi8JAAAATQsLewoAAABDBQULnjQEBQsAAABSDQQAUg4LAKQMBgAAFECAnwwDAW4G8/8CAACA/wYAAAAAAACMCQEAHAcDAIwIAQCoBywAhwoDCXgPCQuVDg8LHA8DAM8NDg+VDA0LhwsDDG8OAAC8DAoDAQAAAJ8MAwJNDAzsAgAAAG8PAwC8DQoDAQAAAJ8NAwJNDQ3sAgAAAMYOAACaCwYADAAAAE0PCoUMAAAATQ4PaA0AAABlAAkAmgsHAA0AAABNDwqFDAAAAE0PD2gNAAAAOQ4PAGUAAQBvDg4AnjQGBQ4AAABSEAYAUhEOAKQPBgAAFECAnw8DAYsH1P/iBxMAMAMHvQ8AAAAwBAdtEAAAADAFB+YRAAAAMAYH0hIAAACCBwIAFAMBAwIDAwMEAwUDBgQAFECAAwcEAABwQAMIAwkCAAAAAAAA8D8DCgMLBwAAAAAAAIA/AAAAAAAAAAADDAMNAw4DDwUEDxAREgAFEAEYAAABAAEAAgAAAAAAAgAAAAAAAQAAAAAAAQAAAAEAAAABAAMAAQAAAAAAAAEB9RoAAQEAAAAAAQAAAAEBAAAAAAAA/QAFAAEAAAABAQAAAAAAAgAAAAAAAQAAAAAAAgEAAQAAAAABAAEAAAAAAAQCAAAAAAAA7xYBAAEAAQABAAAHAAAAAAgCAAAAABZNAgDmAAAAAM8BAQKMBAEATQUAvQEAAAAcAgUAjAMBAKgCDABNBwBtAgAAAIcGBwQmBQEGjAYAAGAFBAAGAAAAUgYEAFIHAQCCBgMAUgEFAIsC9P+CAAEAAwMOAwwDDQBLEQEYAAAAAQAAAAAAAQAAAAEAAAEAAAL7B0wAAAAADAMAAAAAEk0EAL0AAAAAhwMEAU0FAzsBAAAATQgA0gIAAACHBwgBTQsDLwQAAABNCwt7BQAAADkKCwBbCQoDQwgJAgkGBwhDBAUGggQCAAYDDAMSAw8CAAAAAAAA4D8DCAMJAFUTARgAAAABAAAAAAAAAAAAAAAAAABWAAAAAAIAAAECAA2jAAAA/wADAAAAAADAAQAAMAEA1wEAAADAAQIAMAEACgMAAADAAQQAMAEApAUAAACCAAIABgYAAxAGAQMRBgIDEwMAAQIBAAEYAAMAAQAARgAACgAABQEAAAAAAwSdBJ/JGfBQxu3P3FOj01N0hRPrNllung==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:35:13
-- Luau version 6, Types version 3
-- Time taken: 0.004190 seconds

return {
    computeRail = function(arg1, arg2) -- Line 5, Named "computeRail"
        -- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
        -- KONSTANTERROR: [0] 1. Error Block 39 start (CF ANALYSIS FAILED)
        local tbl = {
            [arg1] = true;
            [arg2] = true;
        }
        local tbl_2 = {}
        tbl_2[1] = arg1
        tbl_2[2] = arg2
        local var12
        while true do
            local Value = arg2:FindFirstChild("_front").Value
            local var14
            if arg1 ~= Value then
                var14 = false
            else
                var14 = true
            end
            if not var14 or not arg2:FindFirstChild("_back").Value then
                local var15 = Value
            end
            if tbl[var15] then break end
            tbl[var15] = true
            table.insert(tbl_2, var15)
        end
        for _, v in ipairs(tbl_2) do
            local Z = v.Size.Z
            var12 = {}
            table.insert(var12, Z)
            local _
        end
        local _ = 1
        -- KONSTANTERROR: [0] 1. Error Block 39 end (CF ANALYSIS FAILED)
        -- KONSTANTERROR: [101] 77. Error Block 36 start (CF ANALYSIS FAILED)
        if Z == var12 then
            -- KONSTANTERROR: Expression was reused, decompilation is incorrect
        else
        end
        table.insert({}, Vector3.new(0, 1, 0))
        -- KONSTANTERROR: [101] 77. Error Block 36 end (CF ANALYSIS FAILED)
        -- KONSTANTERROR: [74] 57. Error Block 33 start (CF ANALYSIS FAILED)
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [117.1247202]
        if Z == table.insert(var12, Z) then
            -- KONSTANTWARNING: GOTO [110] #83
        end
        -- KONSTANTERROR: [74] 57. Error Block 33 end (CF ANALYSIS FAILED)
    end;
    calculateSegment = function(arg1, arg2) -- Line 75, Named "calculateSegment"
        local var23 = arg2 % arg1.totalLength
        for i_2 = 1, #arg1.listSegment do
            if var23 - arg1.lengthCache[i_2] < 0 then
                return i_2, var23
            end
        end
    end;
    calculatePosition = function(arg1, arg2, arg3) -- Line 85, Named "calculatePosition"
        local var25 = arg1.listSegment[arg2]
        return var25.Position + arg1.directionCache[arg2] * (-var25.Size.Z * 0.5 + arg3)
    end;
}