local tbl_upvr_2 = {}
local tbl_upvr = {}
local var3_upvw
local var4_upvw = false
local function gather_upvr() -- Line 10, Named "gather"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    if var4_upvw then
    else
        var4_upvw = true
        local NodesLanding = workspace:WaitForChild("NodesLanding")
        if NodesLanding then
            for i = 1, #NodesLanding:GetChildren() do
                local assert_result1 = assert(NodesLanding:FindFirstChild(string.format("Node%d", i)))
                assert_result1.CanCollide = false
                assert_result1.Transparency = 1
                table.insert(tbl_upvr_2, assert_result1.Position)
                local _
            end
        end
        local NodesTakeoff = workspace:WaitForChild("NodesTakeoff")
        if NodesTakeoff then
            for i_2 = 1, #NodesTakeoff:GetChildren() do
                local assert_result1_2 = assert(NodesTakeoff:FindFirstChild(string.format("Node%d", i_2)))
                assert_result1_2.CanCollide = false
                assert_result1_2.Transparency = 1
                table.insert(tbl_upvr, assert_result1_2.Position)
                if assert_result1_2:FindFirstChild("CloseRobbery") then
                    var3_upvw = i_2
                end
            end
        end
    end
end
local BezierPath_upvr = require(game:GetService("ReplicatedStorage").Game.BezierPath)
return {
    GetFlightData = function() -- Line 38, Named "GetFlightData"
        local var19
        if not var4_upvw then
            gather_upvr()
        end
        if 0 >= #tbl_upvr then
            var19 = false
        else
            var19 = true
        end
        assert(var19, "Missing PointsLeave")
        if 0 >= #tbl_upvr_2 then
            var19 = false
        else
            var19 = true
        end
        assert(var19, "Missing PointsEnter")
        local module = {}
        var19 = BezierPath_upvr
        var19 = var19.new()
        var19:SetPoints(tbl_upvr_2)
        var19:SetNodeOffset(0, 2)
        module.PathEnter = var19
        local any_new_result1 = BezierPath_upvr.new()
        any_new_result1:SetPoints(tbl_upvr)
        any_new_result1:SetNodeOffset(1, 1)
        module.PathLeave = any_new_result1
        module.SeqsLayout = {{"SeqEnter", var19:ApproximateLength(1000) / 120}, {"SeqNone", 2}, {"SeqCargoOpen", 3}, {"SeqLoadCrates", 10}, {"SeqNone", 10}, {"SeqCargoClose", 3}, {"SeqLeave", any_new_result1:ApproximateLength(1000) / 120}}
        module.CloseRobberyIndex = var3_upvw
        return module
    end;
}