local RunService_upvr = game:GetService("RunService")
local function _(arg1, arg2) -- Line 7, Named "EphThread"
    local tick_result1_upvr = tick()
    local var5_upvw
    var5_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 10
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        var5_upvw:Disconnect()
        do
            return
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if arg2(tick() - tick_result1_upvr) then
            var5_upvw:Disconnect()
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end)
end
local tbl_upvr = {}
local function AnimateDoor_upvr(arg1, arg2, arg3) -- Line 34, Named "AnimateDoor"
    if tbl_upvr[arg1] then
        return false
    end
    tbl_upvr[arg1] = true
    local children = arg1:GetChildren()
    local _1_upvr = children[1]
    local _2_upvr = children[2]
    local Unit = (_2_upvr.Position - _1_upvr.Position).Unit
    local CFrame_upvr = _1_upvr.CFrame
    local CFrame_upvr_2 = _2_upvr.CFrame
    local var13_upvr = CFrame_upvr - Unit * arg2
    local var14_upvr = CFrame_upvr_2 + Unit * arg2
    _1_upvr.CanCollide = false
    _2_upvr.CanCollide = false
    local function var15_upvr(arg1_2) -- Line 47
        _1_upvr.CFrame = CFrame_upvr:lerp(var13_upvr, arg1_2)
        _2_upvr.CFrame = CFrame_upvr_2:lerp(var14_upvr, arg1_2)
    end
    local var17_upvr = arg3 * 0.5
    local tick_result1_upvr_5 = tick()
    local var19_upvw
    var19_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 10
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        var19_upvw:Disconnect()
        do
            return
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if var15_upvr(tick() - tick_result1_upvr_5) then
            var19_upvw:Disconnect()
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end)
    var17_upvr = delay
    tick_result1_upvr_5 = arg3 * 0.5
    var15_upvr = tick_result1_upvr_5 + 1
    function tick_result1_upvr_5() -- Line 51
        local function var21_upvr(arg1_3) -- Line 52
            _1_upvr.CFrame = var13_upvr:lerp(CFrame_upvr, arg1_3)
            _2_upvr.CFrame = var14_upvr:lerp(CFrame_upvr_2, arg1_3)
        end
        local var23_upvr = arg3 * 0.5
        local tick_result1_upvr_4 = tick()
        local var25_upvw
        var25_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 10
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            var25_upvw:Disconnect()
            do
                return
            end
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            if var21_upvr(tick() - tick_result1_upvr_4) then
                var25_upvw:Disconnect()
            end
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        end)
    end
    var17_upvr(var15_upvr, tick_result1_upvr_5)
    var17_upvr = delay
    var15_upvr = arg3 + 1.1
    function tick_result1_upvr_5() -- Line 57
        _1_upvr.CanCollide = true
        _2_upvr.CanCollide = true
        tbl_upvr[arg1] = nil
    end
    var17_upvr(var15_upvr, tick_result1_upvr_5)
end
local DoorUtils_upvr = require(game:GetService("ReplicatedStorage").Door2.DoorUtils)
return {
    Init = function(arg1) -- Line 64, Named "Init"
        local em = arg1.em
        function em.i5xh5pu6(arg1_4, arg2, arg3) -- Line 67
            AnimateDoor_upvr(arg1_4, arg2, arg3)
        end
        function em.wd45fu9q(arg1_5, arg2) -- Line 70
            DoorUtils_upvr.setOpen(arg1_5, arg2)
        end
        local var29_upvw = false
        function em.jebiop9c(arg1_6, arg2) -- Line 75
            if var29_upvw then
                return false
            end
            var29_upvw = true
            delay(0, function() -- Line 80
                local function var31_upvr(arg1_7) -- Line 81
                    arg1_6:SetPrimaryPartCFrame(arg2 + Vector3.new(0, 20, 0) * arg1_7)
                end
                local const_number_upvr = 2
                local tick_result1_upvr_2 = tick()
                local var35_upvw
                var35_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 10
                    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                    var35_upvw:Disconnect()
                    do
                        return
                    end
                    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                    if var31_upvr(tick() - tick_result1_upvr_2) then
                        var35_upvw:Disconnect()
                    end
                    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                end)
            end)
            delay(4, function() -- Line 85
                local function var37_upvr(arg1_8) -- Line 86
                    arg1_6:SetPrimaryPartCFrame(arg2 + Vector3.new(0, 20, 0) * (1 - arg1_8))
                end
                local const_number_upvr_2 = 2
                local tick_result1_upvr_3 = tick()
                local var41_upvw
                var41_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 10
                    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                    var41_upvw:Disconnect()
                    do
                        return
                    end
                    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                    if var37_upvr(tick() - tick_result1_upvr_3) then
                        var41_upvw:Disconnect()
                    end
                    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                end)
            end)
            wait(6)
            var29_upvw = false
        end
    end;
}