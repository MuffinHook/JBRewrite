local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	LEVEL_VALUE_NAME = "Level",
	EXP_VALUE_NAME = "Exp",
	MAX_LEVEL = 99,
	EXP_ROBBERY = 20,
	EXP_ARREST = 15,
	EXP_KILL = 10,
	DAILY_EXP_DURATION = 86400,
	DAILY_EXP_DURATION_OFFSET = 46800,
	DAILY_EXP_VALUE_NAME = "DailyExpEarned",
	MAX_DAILY_EXP = 80,
	MAX_DAILY_EXP_SEASON_PASS = 120,
	AVG_EXP_PER_CONTRACT = 43,
	TOTAL_DAYS = 60,
	CONTRACTS_PER_DAY = 0.5714285714285714,
	EFFICIENCY = 0.53,
	CURVE_K = 1.2
})