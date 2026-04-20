local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local StreamingHelperUtils_upvr = require(ReplicatedStorage.App.StreamingHelperUtils)
local TableUtils_upvr = require(ReplicatedStorage.Std.TableUtils)
function module_upvr.new(arg1) -- Line 11
    local any_new_result1_upvr = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1_upvr, module_upvr)
    local var7_upvw = 0
    local var8_upvw
    local function _() -- Line 16, Named "update"
        local var9_upvr = var7_upvw + 1
        var7_upvw = var9_upvr
        if var8_upvw then
            task.cancel(var8_upvw)
            var8_upvw = nil
        end
        var8_upvw = task.delay(0.1, function() -- Line 23
            if var9_upvr ~= var7_upvw then
            else
                StreamingHelperUtils_upvr.yieldForAllValuesPopulated(arg1)
                if var9_upvr ~= var7_upvw then return end
                any_new_result1_upvr.packet = TableUtils_upvr.createTableFromObjectValues(arg1)
            end
        end)
    end
    any_new_result1_upvr.maid:GiveTask(arg1.DescendantAdded:Connect(function(arg1_2) -- Line 35
        if arg1_2:IsA("ValueBase") then
            local var12_upvr = var7_upvw + 1
            var7_upvw = var12_upvr
            if var8_upvw then
                task.cancel(var8_upvw)
                var8_upvw = nil
            end
            var8_upvw = task.delay(0.1, function() -- Line 23
                if var12_upvr ~= var7_upvw then
                else
                    StreamingHelperUtils_upvr.yieldForAllValuesPopulated(arg1)
                    if var12_upvr ~= var7_upvw then return end
                    any_new_result1_upvr.packet = TableUtils_upvr.createTableFromObjectValues(arg1)
                end
            end)
        end
    end))
    local var14_upvr = var7_upvw + 1
    var7_upvw = var14_upvr
    if var8_upvw then
        task.cancel(var8_upvw)
        var8_upvw = nil
    end
    var8_upvw = task.delay(0.1, function() -- Line 23
        if var14_upvr ~= var7_upvw then
        else
            StreamingHelperUtils_upvr.yieldForAllValuesPopulated(arg1)
            if var14_upvr ~= var7_upvw then return end
            any_new_result1_upvr.packet = TableUtils_upvr.createTableFromObjectValues(arg1)
        end
    end)
    return any_new_result1_upvr
end
return require(ReplicatedStorage.Std.Binder).new("VehicleState", module_upvr)