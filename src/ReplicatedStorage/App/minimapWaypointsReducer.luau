return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    addWaypoint = function(arg1, arg2) -- Line 7, Named "addWaypoint"
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local var2 = true
        if arg2.position == nil then
            if arg2.part == nil then
                var2 = false
            else
                var2 = true
            end
        end
        assert(var2, "missing position or part")
        if arg2.priority == nil then
            var2 = false
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        var2 = true
        assert(var2, "missing priority")
        if arg2.name == nil then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "missing name")
        var2 = arg1
        var2 = 1
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end;
    removeWaypointByName = function(arg1, arg2) -- Line 38, Named "removeWaypointByName"
        local var5
        if arg2.name == nil then
            var5 = false
        else
            var5 = true
        end
        assert(var5, "missing name")
        var5 = arg1
        local clone = table.clone(var5)
        var5 = 1
        for i = #clone, var5, -1 do
            if clone[i].name == arg2.name then
                table.remove(clone, i)
                return clone
            end
        end
        return clone
    end;
    removeWaypointCurrent = function(arg1) -- Line 50, Named "removeWaypointCurrent"
        local clone_2 = table.clone(arg1)
        if 0 < #clone_2 then
            table.remove(clone_2, #clone_2)
        end
        return clone_2
    end;
})