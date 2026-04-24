-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunConsts = require(ReplicatedStorage.App.RunConsts)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local requireValidIndexAndFreeze = require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze
local t = {}
local t2 = {
	NAME = "VIP"
}
t2.SUBSCRIPTION_ID = if RunUtils.getEnv() == RunConsts.PROD_NAME then "EXP-8575012294898090471" else "EXP-2590014400584876529"
t2.SUBSCRIPTION_ATTR_NAME = "VIPSubscription"
t2.SUBSCRIPTION_RENEWING_ATTR_NAME = "VIPSubscriptionRenewing"
t2.LIFETIME_ATTR_NAME = "VIPLifetime"
t.VIP = t2
return requireValidIndexAndFreeze(t)
