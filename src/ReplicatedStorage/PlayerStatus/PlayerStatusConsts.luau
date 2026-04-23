local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze({
	PAID_UNBAN_STATUS_NAME = "PaidUnbanned",
	BANNED_STATUS_NAME = "Banned",
	HAS_DONE_BAN_COUNT_NAME = "BanCount"
})