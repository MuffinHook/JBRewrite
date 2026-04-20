local RunService_upvr = game:GetService("RunService")
return function(arg1, arg2, arg3) -- Line 3
    local utf8_len_result1_upvr = utf8.len(arg1)
    arg2("")
    local tick_result1_upvr = tick()
    local var6_upvr = utf8_len_result1_upvr / (arg3 or 25)
    local var7_upvw
    var7_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 10
        local var8 = (tick() - tick_result1_upvr) / var6_upvr
        if 1 < var8 then
            var8 = 1
            var7_upvw:Disconnect()
        end
        arg2(utf8.char(utf8.codepoint(arg1, 1, var8 * utf8_len_result1_upvr)))
    end)
    return var7_upvw
end