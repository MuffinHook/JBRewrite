local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local module = {}
local var4
if RunUtils.isMainWorld() then
    var4 = 90
else
    var4 = 30
end
module.SPAWN_DEBOUNCE_NON_PREMIUM = var4
if RunUtils.isMainWorld() then
    var4 = 60
else
    var4 = 10
end
module.SPAWN_DEBOUNCE_PREMIUM = var4
var4 = 5
module.SPAWN_DEBOUNCE_PHYSICAL = var4
var4 = 20
module.NUM_SAVE_SLOTS = var4
var4 = 10
module.NUM_FREE_SAVE_SLOTS = var4
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze(module)