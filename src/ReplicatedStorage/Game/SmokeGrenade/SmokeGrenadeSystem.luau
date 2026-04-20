local module = {}
local SmokeGrenadeBinder_upvr = require(script.Parent.SmokeGrenadeBinder)
local RxInstanceUtils_upvr = require(game:GetService("ReplicatedStorage").Std.RxInstanceUtils)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
function module.init() -- Line 8
    SmokeGrenadeBinder_upvr:Start()
    local function _(arg1) -- Line 11, Named "hide"
        arg1._obj.PrimaryPart.Anchored = true
        arg1._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
    end
    SmokeGrenadeBinder_upvr:GetClassAddedSignal():Connect(function(arg1) -- Line 15
        RxInstanceUtils_upvr.yieldForProperty(arg1.obj, "PrimaryPart")
        if arg1:GetCreator() == LocalPlayer_upvr then
            arg1._obj.PrimaryPart.Anchored = true
            arg1._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
        end
        arg1._maid:GiveTask(arg1._creatorIdValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line 20
            if arg1:GetCreator() == LocalPlayer_upvr then
                local var7 = arg1
                var7._obj.PrimaryPart.Anchored = true
                var7._obj:SetPrimaryPartCFrame(CFrame.new(0, -100, 0))
            end
        end))
    end)
end
return module