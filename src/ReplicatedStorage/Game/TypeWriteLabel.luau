local RunService_upvr = game:GetService("RunService")
return function(arg1, arg2, arg3, arg4) -- Line 3
    arg2.Text = arg1
    arg2.MaxVisibleGraphemes = 0
    local utf8_len_result1_upvr = utf8.len(arg1)
    local os_clock_result1_upvr = os.clock()
    local var6_upvr = utf8_len_result1_upvr / (arg3 or 25)
    local var7_upvw
    var7_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 19
        local var8 = (os.clock() - os_clock_result1_upvr) / var6_upvr
        if 1 < var8 then
            var8 = 1
            var7_upvw:Disconnect()
        end
        local var9 = var8 * utf8_len_result1_upvr
        arg2.MaxVisibleGraphemes = var9
        if arg4 then
            arg4(var9)
        end
    end)
    return var7_upvw
end