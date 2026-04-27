local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local localTable = {}
localTable.__index = localTable
function localTable.new(character, manifest)
	local boundCharacter = BaseObject.new(character)
	boundCharacter.manifest = manifest
	return boundCharacter
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