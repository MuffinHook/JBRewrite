-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMQDFNlZ21lbnRzQnlJZAlTZWdtZW50SWQGTGVuZ3RoDFNlZ21lbnRzTmV4dAJJZAtCcmFuY2hJbmRleBBDYWxjdWxhdGVTZWdtZW50FkNhbGN1bGF0ZURpc3RhbmNlQWhlYWQCQ0YHVmVjdG9yMwNuZXcBcBFDYWxjdWxhdGVQb3NpdGlvbgVTcGVlZAZPZmZzZXQJTW92ZVRyYWluAAUGAgAAAAAnTQMA4AAAAABNBABTAQAAAIcCAwRNAwKtAgAAAGABBAADAAAAUgMCAFIEAQCCAwMATQMCrQIAAAB9AxEAAQAAAE0EAOsDAAAATQUClAQAAACHAwQFDgMOAE0EAq0CAAAAJgEBBE0FAkoFAAAAhwQDBU0FAOAAAAAAhwIFBGUAAwBSAwIAUgQBAIIDAwBIAOj/UgMCAFIEAQCCAwMABgMBAwIDAwMEAwUDBgABBwEYAAAAAAABAAAAAQAAAwAAAAEAAAAAAQMAAAEAAAEAAAACAAD2DQAAAgAAAAARBQAAAABFmgEDAAMAAAAmBQQCggUCAFIFAQBNBwDgAAAAAIcGBwVNCAatAQAAACYHCAKMCgEAjAgDAIwJAQCoCBQATQwA6wIAAACHCwwFKwsCAKkMAACCDAIATQwGSgMAAACHBQsMTQwA4AAAAACHBgwFmgUDAAMAAABDDAcEggwCAE0MBq0BAAAAQwcHDIsI7P9SCAMATQoA4AAAAACHCQoITQsJrQEAAAAmCgsEjA0BAIwLAwCMDAEAqAsVAE0PAOsCAAAAhw4PCCsOAgCpDwAAgg8CAE0PCUoDAAAAhwgOD00PAOAAAAAAhwkPCJoIBAABAAAAORAKACYPEAKCDwIATQ8JrQEAAABDCgoPiwvr/6kLAACCCwIABAMBAwMDBAMGABUIARgAAAIAAgEAAAEAAAEAAAABAAABAQACAAABAAABAAIAAgAA9Q4BAAABAAABAAAAAQAAAQEAAgAAAQAAAQACAAACAAD1DQAWAAAAAAwCAQAABwAAAQgGEQEY+wIAAFIDAABSBAEAnwIDAw4CEQBNBAJgAAAAAIwHAACMCAAATQsCrQIAAABbCgsBJgkKA0w2AAKkBgUAABAwgJ8GBAIJBQQGTQcEkQYAAAAmBgQHggUDAKkEAACCBAIABwMJAgAAAAAAAOA/AwMDCgMLBAAQMIADDAA9DQEYAAAAAAEBAAEAAAAAAAAAAAAAAAAAAAIAPgAAAAAHAgEAAAARTQIALAAAAABNBABwAQAAAAkFAQJDAwQF+wQAAFIFAABSBgMAnwQDA00GBJQCAAAAMAYAUwMAAAAwBQBwAQAAAIIAAQAEAw4DDwMFAwIARRABGAAAAQAAAAIAAAABAAAAAQAKRgAAAAAFAAABAgARowAAAMAAAADAAQEAwAICABIAAADAAwMAEgAAAOIECAAwAATqBAAAADACBIQFAAAAMAEEZgYAAAAwAwR4BwAAAIIEAgAJBgAGAQYCBgMDBwMNAwgDEAUEBAUGBwQAAQIDAQABGAAAFCgACAARAQABAAEAAQAAAQAAAAAE/WlOCyjTQeJXwBTdvTHPJ41xWX/PrSQK

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:34:49
-- Luau version 6, Types version 3
-- Time taken: 0.003644 seconds

local function CalculateSegment_upvr(arg1, arg2) -- Line 1, Named "CalculateSegment"
    -- KONSTANTERROR: [35] 25. Error Block 8 start (CF ANALYSIS FAILED)
    -- KONSTANTERROR: [35] 25. Error Block 8 end (CF ANALYSIS FAILED)
    -- KONSTANTERROR: [0] 1. Error Block 15 start (CF ANALYSIS FAILED)
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [35.131922]
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [35.3]
    if arg2 < nil then
    end
    -- KONSTANTERROR: [0] 1. Error Block 15 end (CF ANALYSIS FAILED)
    -- KONSTANTERROR: [12] 9. Error Block 14 start (CF ANALYSIS FAILED)
    -- KONSTANTERROR: Expression was reused, decompilation is incorrect
    if nil <= arg2 then
        -- KONSTANTERROR: Expression was reused, decompilation is incorrect
        if nil then
            -- KONSTANTWARNING: GOTO [35] #25
        end
        -- KONSTANTWARNING: GOTO [36] #26
    end
    -- KONSTANTERROR: [12] 9. Error Block 14 end (CF ANALYSIS FAILED)
end
return {
    CalculateSegment = CalculateSegment_upvr;
    CalculatePosition = function(arg1, arg2) -- Line 61, Named "CalculatePosition"
        --[[ Upvalues[1]:
            [1]: CalculateSegment_upvr (readonly)
        ]]
        local CalculateSegment_result1, CalculateSegment_result2 = CalculateSegment_upvr(arg1, arg2)
        if CalculateSegment_result1 then
            local CF = CalculateSegment_result1.CF
            return CF * Vector3.new(0, 0, CalculateSegment_result1.Length * 0.5 - CalculateSegment_result2), CF - CF.p
        end
        return false
    end;
    CalculateDistanceAhead = function(arg1, arg2, arg3, arg4, arg5) -- Line 21, Named "CalculateDistanceAhead"
        if arg2 == arg4 then
            return arg5 - arg3
        end
        local var3 = arg2
        local var4 = arg1.SegmentsById[var3]
        for _ = 1, 3 do
            local var6 = arg1.SegmentsNext[var3]
            if not var6 then
                return false
            end
            if var6[var4.BranchIndex] == arg4 then
                return var4.Length - arg3 + arg5
            end
        end
        local var8 = arg4
        local var9 = arg1.SegmentsById[var8]
        for _ = 1, 3 do
            local var11 = arg1.SegmentsNext[var8]
            if not var11 then
                return false
            end
            if var11[var9.BranchIndex] == arg2 then
                return -var9.Length - arg5 - arg3
            end
        end
        return false
    end;
    MoveTrain = function(arg1, arg2) -- Line 69, Named "MoveTrain"
        --[[ Upvalues[1]:
            [1]: CalculateSegment_upvr (readonly)
        ]]
        local CalculateSegment_result1_2, CalculateSegment_result2_2 = CalculateSegment_upvr(arg1, arg1.Offset + arg2 * arg1.Speed)
        arg1.SegmentId = CalculateSegment_result1_2.Id
        arg1.Offset = CalculateSegment_result2_2
    end;
}