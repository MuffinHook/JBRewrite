local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local var3_upvw
local function _(arg1) -- Line 9, Named "getMilestoneId"
    if 1000000 <= arg1 then
        return math.floor(arg1 / 1000000)
    end
    if 500000 <= arg1 then
        return 0.5
    end
    if 100000 <= arg1 then
        return 0.1
    end
    return 0
end
function module.init(arg1) -- Line 20
    var3_upvw = arg1
end
local Format_upvr = require(ReplicatedStorage.Module.Format)
local Notification_upvr = require(ReplicatedStorage.Game.Notification)
local function playEffect_upvr(arg1) -- Line 24, Named "playEffect"
    if var3_upvw then
        task.spawn(var3_upvw, 12)
    end
    Notification_upvr.new({
        Text = string.format("You reached %s\nCongratulations!", Format_upvr.Currency(arg1 * 1000000));
        Style = "Gift";
    })
end
local var7_upvw
function module.cashUpdate(arg1) -- Line 32
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if 1000000 <= arg1 then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
return module