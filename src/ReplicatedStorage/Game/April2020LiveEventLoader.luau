local var1_upvw
local var2_upvw = false
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local function Check_upvr() -- Line 6, Named "Check"
    local April2020LiveEvent = ReplicatedStorage_upvr.Resource:FindFirstChild("April2020LiveEvent")
    if April2020LiveEvent ~= nil then
        var2_upvw = true
        wait(0.1)
        require(April2020LiveEvent:WaitForChild("April2020LiveEvent")).Init(var1_upvw)
        var1_upvw = nil
        print("Loaded april 2020 live event")
    end
end
local function Launch_upvr() -- Line 18, Named "Launch"
    while var2_upvw == false do
        local pcall_result1, pcall_result2 = pcall(Check_upvr)
        if not pcall_result1 then
            warn(pcall_result2)
        end
        wait(1)
    end
end
return {
    Init = function(arg1) -- Line 27, Named "Init"
        var1_upvw = arg1
        spawn(Launch_upvr)
    end;
}