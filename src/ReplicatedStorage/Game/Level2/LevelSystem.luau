local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
local module_upvr = {}
local Players_upvr = game:GetService("Players")
function module_upvr.init() -- Line 9
    for _, v in ipairs(Players_upvr:GetPlayers()) do
        module_upvr.connectPlayer(v)
    end
    Players_upvr.PlayerAdded:Connect(module_upvr.connectPlayer)
end
local waitForChild_upvr = require(ReplicatedStorage.Std.waitForChild)
local LevelConsts_upvr = require(script.Parent.LevelConsts)
function module_upvr.connectPlayer(arg1) -- Line 15
    waitForChild_upvr(arg1, LevelConsts_upvr.LEVEL_VALUE_NAME):andThen(function(arg1_2) -- Line 17
        if module_upvr._onLevelChangedSignal then
            module_upvr._onLevelChangedSignal:Fire(arg1, arg1_2.Value)
        end
        arg1_2:GetPropertyChangedSignal("Value"):Connect(function() -- Line 21
            if module_upvr._onLevelChangedSignal then
                module_upvr._onLevelChangedSignal:Fire(arg1, arg1_2.Value)
            end
        end)
    end):catch(warn)
    waitForChild_upvr(arg1, LevelConsts_upvr.EXP_VALUE_NAME):andThen(function(arg1_3) -- Line 30
        if module_upvr._onExpChangedSignal then
            module_upvr._onExpChangedSignal:Fire(arg1, arg1_3.Value)
        end
        arg1_3:GetPropertyChangedSignal("Value"):Connect(function() -- Line 34
            if module_upvr._onExpChangedSignal then
                module_upvr._onExpChangedSignal:Fire(arg1, arg1_3.Value)
            end
        end)
    end):catch(warn)
end
function module_upvr.getOnLevelChangedSignal() -- Line 42
    if module_upvr._onLevelChangedSignal then
        return module_upvr._onLevelChangedSignal
    end
    module_upvr._onLevelChangedSignal = Signal_upvr.new()
    return module_upvr._onLevelChangedSignal
end
function module_upvr.getOnExpChangedSignal() -- Line 49
    if module_upvr._onExpChangedSignal then
        return module_upvr._onExpChangedSignal
    end
    module_upvr._onExpChangedSignal = Signal_upvr.new()
    return module_upvr._onExpChangedSignal
end
return module_upvr