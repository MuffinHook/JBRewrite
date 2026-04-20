local function CalculateSegment_upvr(arg1, arg2) -- Line 1, Named "CalculateSegment"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [35.131922]
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [35.3]
    if arg2 < nil then
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    if nil <= arg2 then
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        if nil then
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
return {
    CalculateSegment = CalculateSegment_upvr;
    CalculatePosition = function(arg1, arg2) -- Line 61, Named "CalculatePosition"
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
        local CalculateSegment_result1_2, CalculateSegment_result2_2 = CalculateSegment_upvr(arg1, arg1.Offset + arg2 * arg1.Speed)
        arg1.SegmentId = CalculateSegment_result1_2.Id
        arg1.Offset = CalculateSegment_result2_2
    end;
}