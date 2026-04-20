local module_upvr = {}
module_upvr.__index = module_upvr
local RunService_upvr = game:GetService("RunService")
function module_upvr.new(arg1) -- Line 5
    local setmetatable_result1_upvr = setmetatable({}, module_upvr)
    assert(arg1.Duration)
    setmetatable_result1_upvr.OnUpdate = arg1.OnUpdate
    setmetatable_result1_upvr.OnComplete = arg1.OnComplete
    setmetatable_result1_upvr.OnCancel = arg1.OnCancel
    local tick_result1_upvr = tick()
    local Duration_upvr = arg1.Duration
    setmetatable_result1_upvr.Event = RunService_upvr.Heartbeat:Connect(function(arg1_2) -- Line 16
        local var10 = tick_result1_upvr
        local var11
        if Duration_upvr > var11 then
            var10 = false
        else
            var10 = true
        end
        if var10 then
            var11 = Duration_upvr
        end
        if setmetatable_result1_upvr.OnUpdate then
            local var12 = var11 / Duration_upvr
            if var12 ~= var12 then
                var12 = 1
            end
            setmetatable_result1_upvr.OnUpdate(arg1_2, var11, var12)
        end
        if var10 then
            setmetatable_result1_upvr.Event:Disconnect()
            setmetatable_result1_upvr.Event = nil
            if setmetatable_result1_upvr.OnComplete then
                setmetatable_result1_upvr.OnComplete()
            end
        end
    end)
    return setmetatable_result1_upvr
end
function module_upvr.Destroy(arg1) -- Line 40
    if not arg1.Event then
        return false
    end
    arg1.Event:Disconnect()
    arg1.Event = nil
    if arg1.OnCancel then
        arg1.OnCancel()
    end
    return true
end
return module_upvr