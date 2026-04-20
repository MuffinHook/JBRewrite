local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InventoryConsts_upvr = require(script.Parent.InventoryConsts)
local InventoryBinder_upvr = require(script.Parent.InventoryBinder)
local module = {}
local InventoryItemSystem_upvr = require(script.Parent.InventoryItemSystem)
function module.init() -- Line 13
    InventoryBinder_upvr:Start()
    InventoryItemSystem_upvr.init()
end
function module.getFor(arg1) -- Line 17
    local SOME = arg1:FindFirstChild(InventoryConsts_upvr.CURRENT_INVENTORY_VALUE_NAME)
    if not SOME then
    elseif SOME.Value then
        return InventoryBinder_upvr:Get(SOME.Value)
    end
end
local waitForChild_upvr = require(ReplicatedStorage.Std.waitForChild)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Promise_upvr = require(ReplicatedStorage.Std.Promise)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local BinderUtils_upvr = require(ReplicatedStorage.Std.Binder.BinderUtils)
function module.promiseFor(arg1) -- Line 26
    return waitForChild_upvr(arg1, InventoryConsts_upvr.CURRENT_INVENTORY_VALUE_NAME):andThen(function(arg1_2) -- Line 27
        local any_new_result1_upvr = Maid_upvr.new()
        local any_new_result1 = Promise_upvr.new(function(arg1_3, arg2) -- Line 29
            any_new_result1_upvr:GiveTask(RxInstanceUtils_upvr.observeProperty(arg1_2, "Value", function(arg1_4) -- Line 30
                if arg1_4 then
                    arg1_3(BinderUtils_upvr.promiseBoundClass(InventoryBinder_upvr, arg1_4))
                else
                    arg2()
                end
            end))
        end)
        any_new_result1:finally(function() -- Line 38
            any_new_result1_upvr:Destroy()
        end)
        return any_new_result1
    end)
end
return module