local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
module.__index = module
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
function module.new(arg1, arg2) -- Line 8
    local any_new_result1 = BaseObject_upvr.new(arg1)
    any_new_result1.manifest = arg2
    return any_new_result1
end
return require(ReplicatedStorage.ManifestBinder).new("Character", {
    HumanoidRootPart = "HumanoidRootPart";
    Head = "Head";
    UpperTorso = "UpperTorso";
    LowerTorso = "LowerTorso";
    Neck = "Head/Neck";
    Waist = "UpperTorso/Waist";
    Root = "LowerTorso/Root";
    RightUpperArm = "RightUpperArm";
    RightShoulder = "RightUpperArm/RightShoulder";
    RightLowerArm = "RightLowerArm";
    RightElbow = "RightLowerArm/RightElbow";
    RightHand = "RightHand";
    RightWrist = "RightHand/RightWrist";
    LeftUpperArm = "LeftUpperArm";
    LeftShoulder = "LeftUpperArm/LeftShoulder";
    LeftLowerArm = "LeftLowerArm";
    LeftElbow = "LeftLowerArm/LeftElbow";
    LeftHand = "LeftHand";
    LeftWrist = "LeftHand/LeftWrist";
}, module)