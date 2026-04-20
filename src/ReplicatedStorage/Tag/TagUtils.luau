local module = {}
local CollectionService_upvr = game:GetService("CollectionService")
local RegionUtils_upvr = require(game:GetService("ReplicatedStorage").Std.Region.RegionUtils)
function module.isPointInTag(arg1, arg2) -- Line 6
    for _, v in ipairs(CollectionService_upvr:GetTagged(arg2)) do
        assert(v:IsA("BasePart"))
        if RegionUtils_upvr.CastPoint({
            c = v.CFrame;
            s = v.Size;
        }, arg1) then
            return true
        end
    end
    return false
end
return module