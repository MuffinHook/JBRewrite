local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {
    friendsUpdated = require(ReplicatedStorage.Std.Signal).new();
    _cachedLocal = {};
}
function module_upvr.init() -- Line 12
    module_upvr.monitorPlayer(Players_upvr.LocalPlayer)
end
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
local FriendsConsts_upvr = require(ReplicatedStorage.Friends.FriendsConsts)
local StarterGui_upvr = game:GetService("StarterGui")
function module_upvr.monitorPlayer(arg1) -- Line 15
    Interval_upvr.every(FriendsConsts_upvr.FRIEND_UPDATE_INTERVAL):Connect(function() -- Line 18
        module_upvr.updateFriends(arg1)
    end)
    task.spawn(module_upvr.updateFriends, arg1)
    pcall(function() -- Line 23
        StarterGui_upvr:GetCore("PlayerFriendedEvent").Event:Connect(function(arg1_2) -- Line 24
            local var10 = module_upvr._cachedLocal[arg1.UserId]
            if var10 and not var10[arg1_2.UserId] then
                var10[arg1_2.UserId] = true
                module_upvr.friendsUpdated:Fire()
            end
        end)
        StarterGui_upvr:GetCore("PlayerUnfriendedEvent").Event:Connect(function(arg1_3) -- Line 31
            local var12 = module_upvr._cachedLocal[arg1.UserId]
            if var12 and var12[arg1_3.UserId] then
                var12[arg1_3.UserId] = nil
                module_upvr.friendsUpdated:Fire()
            end
        end)
    end)
end
function module_upvr.updateFriends(arg1) -- Line 40
    if arg1 ~= Players_upvr.LocalPlayer then
        error("Not meant to update friends for other players")
        return
    end
    local tbl = {}
    local pcall_result1, pcall_result2 = pcall(function() -- Line 46
        return Players_upvr:GetFriendsAsync(arg1.UserId)
    end)
    if not pcall_result1 and module_upvr._cachedLocal[arg1.UserId] == nil then
        module_upvr._cachedLocal[arg1.UserId] = {}
        return module_upvr._cachedLocal[arg1.UserId]
    end
    while true do
        for _, v in pcall_result2:GetCurrentPage() do
            tbl[v.Id] = true
        end
        if pcall_result2.IsFinished then break end
        pcall_result2:AdvanceToNextPageAsync()
    end
    module_upvr._cachedLocal[arg1.UserId] = tbl
    module_upvr.friendsUpdated:Fire()
    return module_upvr._cachedLocal[arg1.UserId]
end
function module_upvr.getIsFriendsWith(arg1, arg2, arg3) -- Line 66
    if not arg1 then
        warn("No player")
        return false
    end
    if not module_upvr._cachedLocal[arg1.UserId] then
        if arg3 then
            return false
        end
        module_upvr.updateFriends(arg1)
    end
    if module_upvr._cachedLocal[arg1.UserId][arg2] ~= true then
    else
    end
    return true
end
return module_upvr