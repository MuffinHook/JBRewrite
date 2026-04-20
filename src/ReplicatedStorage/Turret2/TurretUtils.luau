return {
    computeHorizontalAngle = function(arg1, arg2, arg3) -- Line 2, Named "computeHorizontalAngle"
        assert(arg3)
        assert(arg2)
        assert(arg2.Part1)
        local Base = arg1:FindFirstChild("Base")
        assert(Base)
        local Arm = arg1:FindFirstChild("Arm")
        assert(Arm)
        local any_PointToObjectSpace_result1_2 = arg2.Part1.CFrame * arg2.C0:Inverse():PointToObjectSpace(arg3)
        local any_PointToObjectSpace_result1_3 = Base.Root.CFrame:PointToObjectSpace(Arm.Tip.Position)
        local squareroot = math.sqrt(any_PointToObjectSpace_result1_2.x * any_PointToObjectSpace_result1_2.x + any_PointToObjectSpace_result1_2.z * any_PointToObjectSpace_result1_2.z)
        local var7
        local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var7 = math.asin(any_PointToObjectSpace_result1_3.x / squareroot)
            return var7
        end
        if any_PointToObjectSpace_result1_3.x >= squareroot or not decompInlinedCondition() then
            var7 = math.asin(squareroot / any_PointToObjectSpace_result1_3.x)
        end
        return math.atan2(-any_PointToObjectSpace_result1_2.z, any_PointToObjectSpace_result1_2.x) + var7
    end;
    computeVerticalAngle = function(arg1, arg2, arg3) -- Line 17, Named "computeVerticalAngle"
        assert(arg3)
        assert(arg1:FindFirstChild("Arm"))
        assert(arg2.Part1)
        local any_PointToObjectSpace_result1 = arg2.Part1.CFrame * arg2.C0:Inverse():PointToObjectSpace(arg3)
        return math.atan2(any_PointToObjectSpace_result1.y, -any_PointToObjectSpace_result1.z)
    end;
    updateModel = function(arg1, arg2, arg3, arg4) -- Line 26, Named "updateModel"
        arg1.C1 = arg1.C0:Inverse() * CFrame.Angles(0, arg3 - (math.pi/2), 0) * arg1.C0
        arg2.C1 = arg2.C0:Inverse() * CFrame.Angles(arg4, 0, 0) * arg2.C0
    end;
}