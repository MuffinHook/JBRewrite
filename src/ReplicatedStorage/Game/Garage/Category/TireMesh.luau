return function(arg1) -- Line 1
    local var2
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var2 = true
        return arg1.Make == "Volt4x4"
    end
    local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var2 = true
        return arg1.Type ~= "DuneBuggy"
    end
    if arg1.Type ~= "Chassis" or decompInlinedCondition() or decompInlinedCondition_2() then
        if arg1.Type ~= "Motorcycle" then
            var2 = false
        else
            var2 = true
        end
    end
    return var2
end