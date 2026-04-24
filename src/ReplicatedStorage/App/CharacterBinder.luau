-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local localTable = {}
localTable.__index = localTable
function localTable.new(p1, p2)
	local v1 = BaseObject.new(p1)
	v1.manifest = p2
	return v1
end
return ManifestBinder.new("Character", {
	HumanoidRootPart = "HumanoidRootPart",
	Head = "Head",
	UpperTorso = "UpperTorso",
	LowerTorso = "LowerTorso",
	Neck = "Head/Neck",
	Waist = "UpperTorso/Waist",
	Root = "LowerTorso/Root",
	RightUpperArm = "RightUpperArm",
	RightShoulder = "RightUpperArm/RightShoulder",
	RightLowerArm = "RightLowerArm",
	RightElbow = "RightLowerArm/RightElbow",
	RightHand = "RightHand",
	RightWrist = "RightHand/RightWrist",
	LeftUpperArm = "LeftUpperArm",
	LeftShoulder = "LeftUpperArm/LeftShoulder",
	LeftLowerArm = "LeftLowerArm",
	LeftElbow = "LeftLowerArm/LeftElbow",
	LeftHand = "LeftHand",
	LeftWrist = "LeftHand/LeftWrist"
}, localTable)