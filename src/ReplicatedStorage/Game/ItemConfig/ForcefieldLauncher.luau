local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
	Price = 30000,
	MaxShieldDuration = 11.25,
	MinShieldDuration = 3,
	Reload = 4,
	ImageId = require(ReplicatedStorage.Resource.Settings).Images.ForcefieldLauncher
}