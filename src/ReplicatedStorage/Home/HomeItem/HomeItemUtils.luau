local module = {}
local function _(arg1, arg2, arg3) -- Line 3, Named "isPointInPrism"
    local var10 = arg2:pointToObjectSpace(arg1) + arg3 * 0.5
    local var11 = false
    if 0 <= var10.x then
        var11 = false
        if var10.x <= arg3.x then
            var11 = false
            if 0 <= var10.y then
                var11 = false
                if var10.y <= arg3.y then
                    var11 = false
                    if 0 <= var10.z then
                        if var10.z > arg3.z then
                            var11 = false
                        else
                            var11 = true
                        end
                    end
                end
            end
        end
    end
    return var11
end
function module.isWithinBounds(arg1, arg2, arg3) -- Line 9
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
return module