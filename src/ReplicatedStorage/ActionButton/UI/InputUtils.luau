local module_upvr = {
    isGamepadKeyCode = function(arg1) -- Line 2, Named "isGamepadKeyCode"
        local Name = arg1.Name
        if Name:find("Button") or Name:find("Thumbstick") or Name:find("DPad") then
            return true
        end
        return false
    end;
}
function module_upvr.getBestKeyCode(arg1, arg2) -- Line 9
    if not arg1 then
    else
        if not arg2 then return end
        if arg2 == Enum.UserInputType.Touch then return end
        for _, v in ipairs(arg1) do
            if arg2 == Enum.UserInputType.Gamepad1 and module_upvr.isGamepadKeyCode(v) then
                return v
            end
            if arg2 == Enum.UserInputType.Keyboard then
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                if not module_upvr.isGamepadKeyCode(v) then
                    return v
                end
            end
        end
    end
end
return module_upvr