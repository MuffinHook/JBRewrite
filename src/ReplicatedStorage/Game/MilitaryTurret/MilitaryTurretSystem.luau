local module = {}
local MilitaryTurretBinder_upvr = require(script.Parent.MilitaryTurretBinder)
function module.init(arg1) -- Line 4
    local Event_upvr = arg1.Event
    MilitaryTurretBinder_upvr:GetClassAddedSignal():Connect(function(arg1_2) -- Line 7
        arg1_2._maid:GiveTask(arg1_2.onBulletHit:Connect(function(arg1_3) -- Line 8
            Event_upvr:FireServer('y'.."rp4lpza":sub(4, 6):reverse():reverse():reverse().."".."kho3", arg1_3, "Shot")
        end))
    end)
    MilitaryTurretBinder_upvr:Start()
end
return module