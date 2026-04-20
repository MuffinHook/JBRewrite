local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local NetObjPoolItemConsts = require(ReplicatedStorage.NetObjPool.NetObjPoolItemConsts)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function module_upvr.new(arg1, arg2) -- Line 15
    local any_new_result1_upvr = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1_upvr, module_upvr)
    any_new_result1_upvr.manifest = arg2
    any_new_result1_upvr.runMaid = Maid_upvr.new()
    any_new_result1_upvr.maid:GiveTask(any_new_result1_upvr.runMaid)
    if any_new_result1_upvr:GetActive() then
        any_new_result1_upvr:_run()
    else
        any_new_result1_upvr.runMaid:DoCleaning()
    end
    any_new_result1_upvr.maid:GiveTask(arg2.activeObj.Changed:Connect(function() -- Line 24, Named "update"
        if any_new_result1_upvr:GetActive() then
            any_new_result1_upvr:_run()
        else
            any_new_result1_upvr.runMaid:DoCleaning()
        end
    end))
    return any_new_result1_upvr
end
function module_upvr.GetPoolObj(arg1) -- Line 37
    return arg1.manifest.poolObjPtr.Value
end
function module_upvr.GetActive(arg1) -- Line 40
    return arg1.manifest.activeObj.Value
end
function module_upvr.SetActive(arg1, arg2) -- Line 43
    arg1.manifest.activeObj.Value = arg2
end
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
function module_upvr._run(arg1) -- Line 46
    arg1.runMaid:DoCleaning()
    arg1._mapTransparency = {}
    local obj_upvr = arg1.obj
    if obj_upvr:IsA("BasePart") then
        arg1._mapTransparency[obj_upvr] = obj_upvr.Transparency
        obj_upvr.Transparency = 1
    end
    arg1.runMaid:GiveTask(RxInstanceUtils_upvr.observeDescendants(obj_upvr, function(arg1_2) -- Line 49, Named "hideObj"
        if arg1_2:IsA("BasePart") then
            arg1._mapTransparency[arg1_2] = arg1_2.Transparency
            arg1_2.Transparency = 1
        end
    end))
    if obj_upvr:IsA("BasePart") then
        obj_upvr.Anchored = true
        arg1.runMaid:GiveTask(function() -- Line 62
            obj_upvr.Anchored = false
        end)
        obj_upvr.CFrame = CFrame.new(0, -200, 0)
    elseif obj_upvr:IsA("Model") then
        arg1.runMaid:GiveTask(RxInstanceUtils_upvr.observeProperty(obj_upvr, "PrimaryPart", function(arg1_3, arg2) -- Line 67
            if arg1_3 then
                arg1_3.Anchored = true
                arg2:GiveTask(function() -- Line 70
                    arg1_3.Anchored = false
                end)
                arg1_3.CFrame = CFrame.new(0, -200, 0)
            end
        end))
    end
    arg1.runMaid:GiveTask(function() -- Line 78
        for i, v in arg1._mapTransparency do
            i.Transparency = v
        end
        arg1._mapTransparency = nil
    end)
end
return require(ReplicatedStorage.ManifestBinder).new("NetObjPoolItem", {
    poolObjPtr = NetObjPoolItemConsts.POOL_OBJ_PTR_NAME;
    activeObj = NetObjPoolItemConsts.ACTIVE_OBJ_NAME;
}, module_upvr)