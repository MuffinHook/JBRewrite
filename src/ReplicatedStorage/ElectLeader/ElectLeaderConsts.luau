local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local var3
if require(ReplicatedStorage.App.RunUtils).getEnv() == require(ReplicatedStorage.App.RunConsts).PROD_NAME then
    var3 = 0.1
else
    var3 = 1
end
module.MAX_RAND_DECIMAL_TO_DO_TASK = var3
var3 = 600
module.MAX_JITTER_TIME = var3
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze(module)