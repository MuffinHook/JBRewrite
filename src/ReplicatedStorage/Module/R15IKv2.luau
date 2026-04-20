local function _(arg1) -- Line 10, Named "isNanV3"
    local var2 = true
    if arg1.x == arg1.x then
        var2 = true
        if arg1.y == arg1.y then
            if arg1.z == arg1.z then
                var2 = false
            else
                var2 = true
            end
        end
    end
    return var2
end
local function _(arg1) -- Line 13, Named "isNanCf"
    local lookVector = arg1.lookVector
    local var12 = true
    if lookVector.x == lookVector.x then
        var12 = true
        if lookVector.y == lookVector.y then
            if lookVector.z == lookVector.z then
                var12 = false
            else
                var12 = true
            end
        end
    end
    if not var12 then
        local rightVector_2 = arg1.rightVector
        var12 = true
        if rightVector_2.x == rightVector_2.x then
            var12 = true
            if rightVector_2.y == rightVector_2.y then
                if rightVector_2.z == rightVector_2.z then
                    var12 = false
                else
                    var12 = true
                end
            end
        end
        if not var12 then
            local upVector_2 = arg1.upVector
            if upVector_2.x == upVector_2.x and upVector_2.y == upVector_2.y then
                if upVector_2.z == upVector_2.z then
                else
                end
            end
        end
    end
    return true
end
local SolveIK_upvr = require(game:GetService("ReplicatedStorage").Module.Logic).SolveIK
local cframe_upvr = CFrame.Angles((math.pi/2), 0, 0)
local function ComputeRawArm_upvr(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 16, Named "ComputeRawArm"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var17 = arg1.Part0.CFrame * arg1.C0 * arg1.C1:inverse()
    local var18 = var17 * arg2.C0 * arg2.C1:inverse()
    local var19 = var17 * CFrame.new(0, arg1.Part1.Size.Y * 0.5, 0) * arg6
    local var20 = (var17.p + var18.p) * 0.5
    local Magnitude = (var20 - (var18 * arg3.C0 * arg3.C1:inverse()).p).Magnitude
    local _, SolveIK_upvr_result2 = SolveIK_upvr((var19.p - var20).Magnitude, Magnitude, var19, arg4, arg5)
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    do
        return
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local cframe_upvr_3 = CFrame.new(-0.1, -0.2, -0.05)
local cframe_upvr_2 = CFrame.new(0.1, -0.2, -0.05)
local function ComputeArms_upvr(arg1) -- Line 61, Named "ComputeArms"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    arg1.RightShoulderTransform = nil
    arg1.RightElbowTransform = nil
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
return {
    BuildPacketArms = function(arg1) -- Line 49, Named "BuildPacketArms"
        return {
            RightShoulder = arg1.RightUpperArm.RightShoulder;
            RightElbow = arg1.RightLowerArm.RightElbow;
            RightWrist = arg1.RightHand.RightWrist;
            LeftShoulder = arg1.LeftUpperArm.LeftShoulder;
            LeftElbow = arg1.LeftLowerArm.LeftElbow;
            LeftWrist = arg1.LeftHand.LeftWrist;
        }
    end;
    Arms = function(arg1) -- Line 116, Named "ArmsFull"
        ComputeArms_upvr(arg1)
        if arg1.RightShoulderTransform then
            arg1.RightShoulder.Transform = arg1.RightShoulderTransform
            arg1.RightElbow.Transform = arg1.RightElbowTransform
        end
        if arg1.LeftShoulderTransform then
            arg1.LeftShoulder.Transform = arg1.LeftShoulderTransform
            arg1.LeftElbow.Transform = arg1.LeftElbowTransform
        end
    end;
    ComputeArms = ComputeArms_upvr;
    ApplyArms = function(arg1) -- Line 104, Named "ApplyArms"
        if arg1.RightShoulderTransform then
            arg1.RightShoulder.Transform = arg1.RightShoulderTransform
            arg1.RightElbow.Transform = arg1.RightElbowTransform
        end
        if arg1.LeftShoulderTransform then
            arg1.LeftShoulder.Transform = arg1.LeftShoulderTransform
            arg1.LeftElbow.Transform = arg1.LeftElbowTransform
        end
    end;
}