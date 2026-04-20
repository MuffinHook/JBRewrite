local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local BinderUtils_upvr = require(ReplicatedStorage.Std.Binder.BinderUtils)
local DoorBinder_upvr = require(ReplicatedStorage.Door2.DoorBinder)
local Region_upvr = require(ReplicatedStorage.Std.Region)
local RegionUtils_upvr = require(ReplicatedStorage.Std.Region.RegionUtils)
local DoorUtils_upvr = require(ReplicatedStorage.Door2.DoorUtils)
local Promise_upvr = require(ReplicatedStorage.Std.Promise)
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
function module.setup(arg1, arg2, arg3) -- Line 15
    local SOME_upvr_2 = arg1._obj:WaitForChild(arg2.doorName or "FakeDoor")
    local var14_upvr = arg2.spikesName or "Spikes"
    local var15_upvr = arg2.referenceName or "Shelving"
    local spikeSizeMin_upvr = arg2.spikeSizeMin
    local spikeSizeMax_upvr = arg2.spikeSizeMax
    local offsetCf_upvr = arg2.offsetCf
    local var24_upvw
    var24_upvw = BinderUtils_upvr.promiseBoundClass(DoorBinder_upvr, SOME_upvr_2):tap(function(arg1_2) -- Line 32
        local SOME_upvr_4 = arg1._obj:FindFirstChild(var14_upvr)
        local SOME_upvr_3 = arg1._obj:FindFirstChild(var15_upvr)
        arg1_2:SetUpdateCallback(function(arg1_3, arg2_2) -- Line 35
            local var22 = spikeSizeMin_upvr * (1 - arg2_2) + spikeSizeMax_upvr * arg2_2
            SOME_upvr_4.Size = Vector3.new(SOME_upvr_4.Size.X, SOME_upvr_4.Size.Y, var22)
            SOME_upvr_4.CFrame = SOME_upvr_3.CFrame * offsetCf_upvr * CFrame.new(0, 0, -var22 * 0.5)
        end)
    end):andThen(function() -- Line 41
        var24_upvw = nil
    end)
    arg1._maid:GiveTask(function() -- Line 44
        if var24_upvw then
            var24_upvw:cancel()
            var24_upvw = nil
        end
    end)
    local any_new_result1_upvr = Region_upvr.new(RegionUtils_upvr.ConditionPlayer)
    local SOME_upvr = arg1._obj:FindFirstChild(arg2.regionName or "Region")
    local tbl_upvr = {}
    local function _() -- Line 54, Named "updatePrism"
        tbl_upvr.c = SOME_upvr.CFrame
        tbl_upvr.s = SOME_upvr.Size
    end
    tbl_upvr.c = SOME_upvr.CFrame
    tbl_upvr.s = SOME_upvr.Size
    any_new_result1_upvr:AddPrism(tbl_upvr)
    arg1._maid:GiveTask(any_new_result1_upvr)
    local damageAmount_upvr = arg2.damageAmount
    local var31_upvr = arg2.doorCloseDelay or 1
    local audioId_upvr = arg2.audioId
    arg1._maid:GiveTask(any_new_result1_upvr.OnObjAdded:Connect(function() -- Line 61
        if not DoorUtils_upvr.getOpen(SOME_upvr_2) then
            arg3:FireServer('y'.."qf6znoh":sub(4, 4):reverse():reverse():reverse():reverse():reverse().."".."".."rpjfja":sub(2, 2):reverse().."".."".."qqhohklw84r":sub(4, 7):reverse():reverse():reverse()..""..'3', damageAmount_upvr, "Spikes")
            DoorUtils_upvr.setOpen(SOME_upvr_2, true)
            Promise_upvr.delay(var31_upvr):andThen(function() -- Line 66
                DoorUtils_upvr.setOpen(SOME_upvr_2, false)
            end)
            Audio_upvr.ObjectLocal(SOME_upvr_2.PrimaryPart, audioId_upvr, {
                Volume = 0.5;
                RollOffMaxDistance = 64;
            })
        end
    end))
    arg1._maid:GiveTask(Interval_upvr.every(0.2):Connect(function() -- Line 72
        tbl_upvr.c = SOME_upvr.CFrame
        tbl_upvr.s = SOME_upvr.Size
        any_new_result1_upvr:Update({LocalPlayer_upvr})
    end))
end
return module