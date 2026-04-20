local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local RunUtils_upvr = require(ReplicatedStorage_upvr.App.RunUtils)
local RunConsts = require(ReplicatedStorage_upvr.App.RunConsts)
local tbl = {174178041, 5613127327, 820499, 75308445, 55124844, 2235908458, 391034465}
local module_upvr = {
    Help = true;
    UserAlias = true;
}
local tbl_3 = {
    groupId = 3059674;
    minRank = 253;
}
local tbl_2 = {
    groupId = 5770760;
    minRank = 100;
}
if RunUtils_upvr.getEnv() == RunConsts.QA_NAME or RunUtils_upvr.getEnv() == RunConsts.DEV_NAME or RunUtils_upvr.getEnv() == RunConsts.STUDIO_NAME then
    module_upvr.DefaultAdmin = tbl_2
    module_upvr.Op = {
        vipOwner = true;
        op = true;
        groupId = tbl_2.groupId;
        minRank = tbl_2.minRank;
        userIds = tbl;
    }
    module_upvr.DefaultDebug = tbl_2
    module_upvr.DefaultUtil = tbl_2
    module_upvr.VipOwner = {
        vipOwner = true;
        groupId = tbl_2.groupId;
        minRank = tbl_2.minRank;
    }
    module_upvr.Moderator = {
        groupId = tbl_2.groupId;
        minRank = tbl_2.minRank;
        userIds = tbl;
    }
else
    module_upvr.DefaultAdmin = {
        userIds = {606723718, 2837719, 2025110};
    }
    module_upvr.Op = {
        vipOwner = true;
        op = true;
        groupId = tbl_3.groupId;
        minRank = tbl_3.minRank;
        userIds = tbl;
    }
    module_upvr.DefaultDebug = tbl_3
    module_upvr.DefaultUtil = tbl_3
    module_upvr.VipOwner = {
        vipOwner = true;
        groupId = tbl_3.groupId;
        minRank = tbl_3.minRank;
    }
    module_upvr.Moderator = {
        groupId = tbl_3.groupId;
        minRank = tbl_3.minRank;
        userIds = tbl;
    }
end
function module_upvr.isOp(arg1) -- Line 104
    local var16
    if ReplicatedStorage_upvr:FindFirstChild("OpList"):FindFirstChild(arg1.UserId) == nil then
        var16 = false
    else
        var16 = true
    end
    return var16
end
function module_upvr.groupAllowed(arg1, arg2) -- Line 108
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg1 == nil then
    else
    end
    assert(true, "player missing")
    if arg1.Parent ~= game:GetService("Players") then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    assert(true, "player is not a Player")
    if arg2 == nil then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
return module_upvr