return {
    computeRail = function(arg1, arg2) -- Line 5, Named "computeRail"
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
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
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if Z == var12 then
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        else
        end
        table.insert({}, Vector3.new(0, 1, 0))
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [117.1247202]
        if Z == table.insert(var12, Z) then
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
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