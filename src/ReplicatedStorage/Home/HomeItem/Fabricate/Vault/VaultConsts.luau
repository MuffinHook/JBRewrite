local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local module = {
    AMOUNT_VALUE_NAME = "Amount";
    MAXIMUM_VALUE_NAME = "Maximum";
    DEADLINE_VALUE_NAME = "Deadline";
    ROBBERY_ID_VALUE_NAME = "RobberyId";
    CHOOSE_ROBBERY_REMOTE_NAME = "ChooseRobbery";
    VAULT_INTERACT_REMOTE_NAME = "VaultInteract";
}
local var4 = "ArmingTeamId"
module.ARMING_TEAM_ID_ATTR_NAME = var4
if RunUtils.isStudio() then
    var4 = 2
else
    var4 = 10
end
module.ARM_COUNTDOWN_TIME = var4
var4 = 1
module.MIN_PLAYERS_TO_ARM_VAULT = var4
var4 = 200
module.VAULT_MONEY_PER_ARREST = var4
var4 = 0.3
module.VAULT_BAG_MULTIPLE = var4
var4 = 0.05
module.VAULT_BAG_MULTIPLE_VIP = var4
if RunUtils.isStudio() then
    var4 = 45
else
    var4 = 600
end
module.TIMER_DURATION = var4
var4 = 100
module.CASH_PER_COLLECT = var4
var4 = 5000
module.MAX_AMOUNT_STORED = var4
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze(module)