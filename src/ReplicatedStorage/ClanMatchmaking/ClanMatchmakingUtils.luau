local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local ClanMatchmakingConsts_upvr = require(ReplicatedStorage_upvr.ClanMatchmaking.ClanMatchmakingConsts)
local module = {
    setIsClanReadiedUp = function(arg1, arg2) -- Line 7, Named "setIsClanReadiedUp"
        local var4
        if typeof(arg1) ~= "string" then
            var4 = false
        else
            var4 = true
        end
        assert(var4, "Invalid clanId passed")
        var4 = ReplicatedStorage_upvr:FindFirstChild(ClanMatchmakingConsts_upvr.CLAN_IS_READIED_UP_MODEL_NAME):FindFirstChild(arg1)
        if arg2 then
            if not var4 then
                var4 = Instance.new("BoolValue")
                var4.Name = arg1
                var4.Parent = ReplicatedStorage_upvr:FindFirstChild(ClanMatchmakingConsts_upvr.CLAN_IS_READIED_UP_MODEL_NAME)
            end
        elseif var4 then
            var4:Destroy()
        end
    end;
    getIsClanReadiedUp = function(arg1) -- Line 25, Named "getIsClanReadiedUp"
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local var6
        if typeof(arg1) ~= "string" then
            var6 = false
        else
            var6 = true
        end
        assert(var6, "Invalid clanId passed")
        var6 = ReplicatedStorage_upvr:FindFirstChild(ClanMatchmakingConsts_upvr.CLAN_IS_READIED_UP_MODEL_NAME):FindFirstChild(arg1)
        if not var6 then
            return false
        end
        if var6 == nil then
        else
        end
        return true
    end;
}
local RxInstanceUtils_upvr = require(ReplicatedStorage_upvr.Std.RxInstanceUtils)
function module.observeIsClanReadiedUp(arg1, arg2) -- Line 34
    return RxInstanceUtils_upvr.observeChildrenNamed(ReplicatedStorage_upvr:FindFirstChild(ClanMatchmakingConsts_upvr.CLAN_IS_READIED_UP_MODEL_NAME), arg1, arg2)
end
return module