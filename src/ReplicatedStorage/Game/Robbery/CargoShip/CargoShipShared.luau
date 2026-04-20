local module = {
    Speed = 50;
}
local BezierPath_upvr = require(game:GetService("ReplicatedStorage").Game.BezierPath)
function module.GetPath() -- Line 6
    local PathCargoShip = workspace:WaitForChild("PathCargoShip")
    local tbl = {}
    local var7
    for i = 1, #PathCargoShip:GetChildren() do
        local assert_result1 = assert(PathCargoShip:FindFirstChild("Node%d":format(i)))
        assert_result1.CanCollide = false
        assert_result1.Transparency = 1
        table.insert(tbl, assert_result1.Position)
        if assert_result1:FindFirstChild("CloseRobbery") then
        end
    end
    local any_new_result1 = BezierPath_upvr.new()
    any_new_result1:SetPoints(tbl)
    any_new_result1:SetNodeOffset(0, 1)
    any_new_result1.ApproxLength = any_new_result1:ApproximateLength(1000)
    any_new_result1.ApproxLengthTraveled = 0
    any_new_result1.CloseRobberyIndex = nil
    return any_new_result1
end
return module