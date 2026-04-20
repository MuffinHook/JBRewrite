local var1_upvw
local module = {
    init = function(arg1) -- Line 6, Named "init"
        var1_upvw = arg1.Event
    end;
}
local TrappedTrapUtils_upvr = require(script.Parent.TrappedTrapUtils)
function module.setup(arg1) -- Line 9
    TrappedTrapUtils_upvr.setup(arg1, {
        doorName = "FakeDoor";
        spikesName = "Spikes";
        referenceName = "Metal";
        regionName = "Region";
        offsetCf = CFrame.new(-0.00280761719, -1.17230225, 0.356445312, 1, 0, 0, 0, 1, 0, 0, 0, 1);
        spikeSizeMin = 1.31;
        spikeSizeMax = 5;
        damageAmount = 36;
        audioId = 6909242121;
        doorCloseDelay = 1;
    }, var1_upvw)
end
return module