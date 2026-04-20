local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local tbl = {}
local var4 = "VIP"
tbl.NAME = var4
if require(ReplicatedStorage.App.RunUtils).getEnv() == require(ReplicatedStorage.App.RunConsts).PROD_NAME then
    var4 = "EXP-8575012294898090471"
else
    var4 = "EXP-2590014400584876529"
end
tbl.SUBSCRIPTION_ID = var4
tbl.SUBSCRIPTION_ATTR_NAME = "VIPSubscription"
tbl.SUBSCRIPTION_RENEWING_ATTR_NAME = "VIPSubscriptionRenewing"
tbl.LIFETIME_ATTR_NAME = "VIPLifetime"
module.VIP = tbl
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze(module)