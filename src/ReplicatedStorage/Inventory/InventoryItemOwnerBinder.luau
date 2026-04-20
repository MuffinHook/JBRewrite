local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
function module_upvr.new(arg1) -- Line 12
    local any_new_result1_upvr = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1_upvr, module_upvr)
    any_new_result1_upvr.Name = arg1.Name
    any_new_result1_upvr._onCharacterChanged = Signal_upvr.new()
    if not arg1.Value then
    else
        any_new_result1_upvr.maid.observeChar = RxInstanceUtils_upvr.observeProperty(arg1.Value, "PrimaryPart", function(arg1_3) -- Line 23
            task.wait()
            if arg1_3 then
                any_new_result1_upvr.Character = arg1.Value
            else
                any_new_result1_upvr.Character = nil
            end
            any_new_result1_upvr._onCharacterChanged:Fire(any_new_result1_upvr.Character)
        end)
    end
    any_new_result1_upvr.maid:GiveTask(arg1.Changed:Connect(function() -- Line 19, Named "update"
        if not arg1.Value then
        else
            any_new_result1_upvr.maid.observeChar = RxInstanceUtils_upvr.observeProperty(arg1.Value, "PrimaryPart", function(arg1_2) -- Line 23
                task.wait()
                if arg1_2 then
                    any_new_result1_upvr.Character = arg1.Value
                else
                    any_new_result1_upvr.Character = nil
                end
                any_new_result1_upvr._onCharacterChanged:Fire(any_new_result1_upvr.Character)
            end)
        end
    end))
    return any_new_result1_upvr
end
function module_upvr.GetAttribute(arg1, arg2) -- Line 38
    return arg1["attr"..tostring(arg2)]
end
function module_upvr.SetAttribute(arg1, arg2, arg3) -- Line 41
    arg1["attr"..tostring(arg2)] = arg3
end
return require(ReplicatedStorage.Std.Binder).new("InventoryItemOwner", module_upvr)