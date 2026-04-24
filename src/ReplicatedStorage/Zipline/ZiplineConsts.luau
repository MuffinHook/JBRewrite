-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	TAG_NAME = "Zipline",
	TriggerDist = 10,
	OnZiplineAttrName = "OnZipline",
	EasingStyle = Enum.EasingStyle.Quad,
	EasingDirection = Enum.EasingDirection.In,
	JointData = {
		{ "LowerTorso", "Root", CFrame.new(0.29, 2.29, -1.58) * CFrame.Angles(0.4638, -0.1055, -0.1031) },
		{ "UpperTorso", "Waist", CFrame.new(-0, 0, -0) * CFrame.Angles(-0.2229, 0.0917, -0.1055) },
		{ "LeftUpperArm", "LeftShoulder", CFrame.new(-0.07, -0.33, 0.17) * CFrame.Angles(2.2884, -0.1789, 0.3074) },
		{ "LeftLowerArm", "LeftElbow", CFrame.new(-0, 0.09, 0.06) * CFrame.Angles(0.5088, -0, 0) },
		{ "LeftHand", "LeftWrist", CFrame.new(0, 0, 0) * CFrame.Angles(0.1105, -0.0005, 0.1689) }
	}
})
