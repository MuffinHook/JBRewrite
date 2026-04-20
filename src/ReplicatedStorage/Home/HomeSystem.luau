local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local HomeBinder_upvr = require(script.Parent.HomeBinder)
local module_upvr = {
    _currentStandingHome = nil;
    onEntered = Signal.new();
    onExited = Signal.new();
}
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function module_upvr.init() -- Line 14
    HomeBinder_upvr:Start()
    Interval_upvr.every(0.25):Connect(function() -- Line 18
        local any_queryCurrentStandingHome_result1 = module_upvr.queryCurrentStandingHome()
        if module_upvr._currentStandingHome ~= any_queryCurrentStandingHome_result1 then
            module_upvr._currentStandingHome = any_queryCurrentStandingHome_result1
            if any_queryCurrentStandingHome_result1 then
                module_upvr.onEntered:Fire(any_queryCurrentStandingHome_result1)
                return
            end
            module_upvr.onExited:Fire(module_upvr._currentStandingHome)
        end
    end)
end
local PlayerUtils_upvr = require(ReplicatedStorage.Game.PlayerUtils)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
function module_upvr.queryCurrentStandingHome() -- Line 32
    local any_getRootPart_result1 = PlayerUtils_upvr.getRootPart(LocalPlayer_upvr)
    if not any_getRootPart_result1 then
    else
        for _, v in ipairs(HomeBinder_upvr:GetAll()) do
            if v:IsPointInStandingPrism(any_getRootPart_result1.Position) then
                return v
            end
        end
    end
end
return module_upvr