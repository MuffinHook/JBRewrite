local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	CONVERSION_FACTOR = 173.7178,
	DEFAULT_MU = 1500,
	DEFAULT_PHI = 350,
	DEFAULT_SIGMA = 0.06,
	DEFAULT_TAU = 0.2
})
