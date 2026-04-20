local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module_upvr = {
    list = {};
    onForceUpdate = require(ReplicatedStorage_upvr.Std.Signal).new();
}
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local AccelTween_upvr = require(ReplicatedStorage_upvr.Std.AccelTween)
local CurrentCamera_upvr = workspace.CurrentCamera
local GeomUtils_upvr = require(ReplicatedStorage_upvr.Std.GeomUtils)
local RunService_upvr = game:GetService("RunService")
local MinimapService_upvr = require(ReplicatedStorage_upvr.App.MinimapService)
function module_upvr.add(arg1) -- Line 15
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local key = arg1.key
    if not key then
        key = tostring(math.random() * 10000)
    end
    arg1.key = key
    arg1.key = "damageIndicator_"..arg1.key
    arg1.bornAt = os.clock()
    arg1.strength = arg1.strength or 1
    local var10 = false
    if 0 < arg1.strength then
        if arg1.strength > 1 then
            var10 = false
        else
            var10 = true
        end
    end
    assert(var10, "strength must be (0, 1]")
    arg1.lifetime = arg1.lifetime or 1
    local color = arg1.color
    if not color then
        color = Color3.new(1, 0, 0)
    end
    arg1.color = color
    local const_number = 1
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [84.6]
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [84.1114382]
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local waitForChild_upvr = require(ReplicatedStorage_upvr.Std.waitForChild)
function module_upvr.init() -- Line 125
    waitForChild_upvr(ReplicatedStorage_upvr, "DamageIndicatorRemote"):andThen(function(arg1) -- Line 126
        arg1.OnClientEvent:Connect(function(arg1_2) -- Line 127
            module_upvr.add(arg1_2)
        end)
    end)
end
return module_upvr