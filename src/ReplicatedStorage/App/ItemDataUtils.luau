local module = {}
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function module.getConfig(arg1) -- Line 5
    local SOME = ReplicatedStorage_upvr.Game.ItemConfig:FindFirstChild(arg1)
    if SOME == nil then
        return nil
    end
    return require(SOME)
end
return module