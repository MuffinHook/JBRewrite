local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
require(ReplicatedStorage.App.RunConsts)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local requireValidIndexAndFreeze = require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze
local t = {
	AMOUNT_VALUE_NAME = "Amount",
	MAXIMUM_VALUE_NAME = "Maximum",
	DEADLINE_VALUE_NAME = "Deadline",
	ROBBERY_ID_VALUE_NAME = "RobberyId",
	CHOOSE_ROBBERY_REMOTE_NAME = "ChooseRobbery",
	VAULT_INTERACT_REMOTE_NAME = "VaultInteract",
	ARMING_TEAM_ID_ATTR_NAME = "ArmingTeamId"
}
t.ARM_COUNTDOWN_TIME = if RunUtils.isStudio() then 2 else 10
t.MIN_PLAYERS_TO_ARM_VAULT = 1
t.VAULT_MONEY_PER_ARREST = 200
t.VAULT_BAG_MULTIPLE = 0.3
t.VAULT_BAG_MULTIPLE_VIP = 0.05
t.TIMER_DURATION = if RunUtils.isStudio() then 45 else 600
t.CASH_PER_COLLECT = 100
t.MAX_AMOUNT_STORED = 5000
return requireValidIndexAndFreeze(t)