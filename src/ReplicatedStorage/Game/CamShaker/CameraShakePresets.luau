local CameraShakeInstance_upvr = require(script.Parent.CameraShakeInstance)
local tbl_upvr = {
    Bump = function() -- Line 23, Named "Bump"
        local any_new_result1_7 = CameraShakeInstance_upvr.new(2.5, 4, 0.1, 0.75)
        any_new_result1_7.PositionInfluence = Vector3.new(0.15000, 0.15000, 0.15000)
        any_new_result1_7.RotationInfluence = Vector3.new(1, 1, 1)
        return any_new_result1_7
    end;
    Explosion = function() -- Line 32, Named "Explosion"
        local any_new_result1 = CameraShakeInstance_upvr.new(5, 10, 0, 1.5)
        any_new_result1.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
        any_new_result1.RotationInfluence = Vector3.new(4, 1, 1)
        return any_new_result1
    end;
    Earthquake = function() -- Line 41, Named "Earthquake"
        local any_new_result1_2 = CameraShakeInstance_upvr.new(0.6, 3.5, 2, 10)
        any_new_result1_2.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
        any_new_result1_2.RotationInfluence = Vector3.new(1, 1, 4)
        return any_new_result1_2
    end;
    BadTrip = function() -- Line 50, Named "BadTrip"
        local any_new_result1_4 = CameraShakeInstance_upvr.new(10, 0.15, 5, 10)
        any_new_result1_4.PositionInfluence = Vector3.new(0, 0, 0.15000)
        any_new_result1_4.RotationInfluence = Vector3.new(2, 1, 4)
        return any_new_result1_4
    end;
    HandheldCamera = function() -- Line 59, Named "HandheldCamera"
        local any_new_result1_5 = CameraShakeInstance_upvr.new(1, 0.25, 5, 10)
        any_new_result1_5.PositionInfluence = Vector3.new(0, 0, 0)
        any_new_result1_5.RotationInfluence = Vector3.new(1, 0.5, 0.5)
        return any_new_result1_5
    end;
    Vibration = function() -- Line 68, Named "Vibration"
        local any_new_result1_3 = CameraShakeInstance_upvr.new(0.4, 20, 2, 2)
        any_new_result1_3.PositionInfluence = Vector3.new(0, 0.15000, 0)
        any_new_result1_3.RotationInfluence = Vector3.new(1.25, 0, 4)
        return any_new_result1_3
    end;
    RoughDriving = function() -- Line 77, Named "RoughDriving"
        local any_new_result1_6 = CameraShakeInstance_upvr.new(1, 2, 1, 1)
        any_new_result1_6.PositionInfluence = Vector3.new(0, 0, 0)
        any_new_result1_6.RotationInfluence = Vector3.new(1, 1, 1)
        return any_new_result1_6
    end;
}
return setmetatable({}, {
    __index = function(arg1, arg2) -- Line 86, Named "__index"
        local var11 = tbl_upvr[arg2]
        if type(var11) == "function" then
            return var11()
        end
        error("No preset found with index \""..arg2..'"')
    end;
})