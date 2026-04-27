local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunConsts = require(ReplicatedStorage.App.RunConsts)
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local requireValidIndexAndFreeze = require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze
local t = {}
t.MAX_RAND_DECIMAL_TO_DO_TASK = if RunUtils.getEnv() == RunConsts.PROD_NAME then 0.1 else 1
t.MAX_JITTER_TIME = 600
return requireValidIndexAndFreeze(t)
