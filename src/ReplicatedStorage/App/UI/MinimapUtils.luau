local module_upvr = {
    computeOffsetXY = function(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9) -- Line 3, Named "computeOffsetXY"
        if not arg2 then
            local vector2_3 = Vector2.new(512, 512)
        end
        local var21 = arg9 * vector2_3.Y / arg7
        local var22 = vector2_3.X * var21
        local var23 = vector2_3.Y * var21
        local var24 = arg7 * var21 - var22 - (1 - var21) * vector2_3.X
        local var25 = arg8 * var21 - var23 - (1 - var21) * vector2_3.Y
        local var26 = arg7 * var21 * (0.5 + (arg1.X - arg5) / arg3) - var22 * 0.5 - 0.5 * (1 - var21) * vector2_3.X
        if var24 < var26 then
            var26 = var24
        end
        if var26 < 0 then
        end
        if var25 < arg8 * var21 * (0.5 + (arg1.Z - arg6) / arg4) - var23 * 0.5 - 0.5 * (1 - var21) * vector2_3.Y then
        end
        if var25 < 0 then
            local const_number = 0
        end
        local var28 = true
        if 0 >= 0 then
            var28 = true
            if const_number >= 0 then
                var28 = true
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                if var24 >= 0 then
                    if var25 >= const_number then
                        var28 = false
                    else
                        var28 = true
                    end
                end
            end
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        return var28, 0, const_number, var21
    end;
}
function module_upvr.computeWorldXY(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11) -- Line 56
    local any_computeOffsetXY_result1, any_computeOffsetXY_result2, any_computeOffsetXY_result3, any_computeOffsetXY_result4 = module_upvr.computeOffsetXY(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    return ((arg1 + any_computeOffsetXY_result2) / arg9 / any_computeOffsetXY_result4 - 0.5) * arg5 + arg7, ((arg2 + any_computeOffsetXY_result3) / arg10 / any_computeOffsetXY_result4 - 0.5) * arg6 + arg8
end
function module_upvr.worldToScale(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 84
    return UDim2.fromScale(0.5 + (arg1 - arg3) / arg5, 0.5 + (arg2 - arg4) / arg6)
end
function module_upvr.relativeWorldToScale(arg1, arg2, arg3, arg4) -- Line 87
    return UDim2.fromScale(arg1 / arg3, arg2 / arg4)
end
return module_upvr