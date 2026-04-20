local module = {}
local tbl_upvr = {}
local HashMutex_upvr = require(game:GetService("ReplicatedStorage").Mutex.HashMutex)
function module.getForNamespace(arg1) -- Line 6
    if tbl_upvr[arg1] then
        return tbl_upvr[arg1]
    end
    local any_new_result1 = HashMutex_upvr.new()
    tbl_upvr[arg1] = any_new_result1
    return any_new_result1
end
return module