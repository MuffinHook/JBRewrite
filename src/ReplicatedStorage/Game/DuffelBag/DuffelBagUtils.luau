local module = {}
local Players_upvr = game:GetService("Players")
local DuffelBagBinder_upvr = require(script.Parent.DuffelBagBinder)
function module.getBag(arg1) -- Line 6
    local var8 = arg1
    assert(var8)
    if arg1.Parent ~= Players_upvr then
        var8 = false
    else
        var8 = true
    end
    assert(var8)
    for _, v in ipairs(DuffelBagBinder_upvr:GetAll()) do
        if v:GetOwner() == arg1 then
            return v
        end
    end
end
return module