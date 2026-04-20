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
        referenceName = "Shelving";
        regionName = "Region";
        offsetCf = CFrame.new(0.0900421143, 0.141143799, 0.781, 1, 0, 0, 0, 1, 0, 0, 0, 1);
        spikeSizeMin = 1.562;
        spikeSizeMax = 6.534;
        damageAmount = 36;
        audioId = 6909242121;
        doorCloseDelay = 1;
    }, var1_upvw)
end
return module