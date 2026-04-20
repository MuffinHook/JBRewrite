local new_upvr = CFrame.new
local zero_vector3_upvr = Vector3.new()
local CurrentCamera_upvr = workspace.CurrentCamera
return {
    MakeCinematicCamera = function() -- Line 7, Named "MakeCinematicCamera"
        return {
            StartPosition = nil;
            Position = zero_vector3_upvr;
            TargetPosition = nil;
            LookVector = zero_vector3_upvr;
            TargetFocus = nil;
        }
    end;
    StepCinematicCamera = function(arg1, arg2, arg3, arg4) -- Line 16, Named "StepCinematicCamera"
        if arg2.TargetPosition then
            if arg2.StartPosition then
                arg2.Position = arg2.StartPosition * (1 - arg4) + arg2.TargetPosition * arg4
            else
                arg2.Position += (arg2.TargetPosition - arg2.Position) * arg1 * arg4
            end
        end
        if arg2.TargetFocus then
            arg2.LookVector += ((arg2.TargetFocus - arg2.Position).unit - arg2.LookVector) * arg1 * arg3
        end
        CurrentCamera_upvr.CoordinateFrame = new_upvr(zero_vector3_upvr, arg2.LookVector) + arg2.Position
    end;
}