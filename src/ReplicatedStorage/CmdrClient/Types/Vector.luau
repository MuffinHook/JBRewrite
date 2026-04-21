local Util_upvr = require(script.Parent.Parent.Shared.Util)
local function validateVector(arg1, arg2) -- Line 3
    if arg1 == nil then
        return false, string.format("Invalid or missing number at position %d in Vector type.", arg2)
    end
    return true
end
local any_MakeSequenceType_result1_upvr = Util_upvr.MakeSequenceType({
    ValidateEach = validateVector;
    TransformEach = tonumber;
    Constructor = Vector3.new;
    Length = 3;
})
local any_MakeSequenceType_result1_upvr_2 = Util_upvr.MakeSequenceType({
    ValidateEach = validateVector;
    TransformEach = tonumber;
    Constructor = Vector2.new;
    Length = 2;
})
return function(arg1) -- Line 25
    arg1:RegisterType("vector3", any_MakeSequenceType_result1_upvr)
    arg1:RegisterType("vector3s", Util_upvr.MakeListableType(any_MakeSequenceType_result1_upvr))
    arg1:RegisterType("vector2", any_MakeSequenceType_result1_upvr_2)
    arg1:RegisterType("vector2s", Util_upvr.MakeListableType(any_MakeSequenceType_result1_upvr_2))
end