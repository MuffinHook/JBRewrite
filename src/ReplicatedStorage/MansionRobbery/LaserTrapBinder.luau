local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local DoorUtils_upvr = require(ReplicatedStorage.Door2.DoorUtils)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local CharacterUtils_upvr = require(ReplicatedStorage.Std.CharacterUtils)
local Players_upvr = game:GetService("Players")
function module_upvr.new(arg1, arg2) -- Line 15
    local any_new_result1_upvr = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1_upvr, module_upvr)
    any_new_result1_upvr._flashing = false
    any_new_result1_upvr.buttonsModel = nil
    any_new_result1_upvr.maid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg1, "Buttons", function(arg1_2, arg2_2) -- Line 22
        any_new_result1_upvr.buttonsModel = arg1_2
        arg2_2:GiveTask(RxInstanceUtils_upvr.observeChildren(arg1_2, function(arg1_3, arg2_3) -- Line 24
            arg2_3:GivePromise(DoorUtils_upvr.promiseInnerModel(arg1_3):andThen(function(arg1_4) -- Line 26
                return RxInstanceUtils_upvr.waitForChild(arg1_4, "Touch")
            end):andThen(function(arg1_5) -- Line 29
                local os_clock_result1_2_upvw = os.clock()
                arg2_3:GiveTask(arg1_5.Touched:Connect(function(arg1_6) -- Line 31
                    local any_getAncestorPartHumanoid_result1 = CharacterUtils_upvr.getAncestorPartHumanoid(arg1_6)
                    if not any_getAncestorPartHumanoid_result1 then
                    else
                        if any_getAncestorPartHumanoid_result1.Parent ~= Players_upvr.LocalPlayer.Character then return end
                        if any_getAncestorPartHumanoid_result1:GetLimb(arg1_6) == Enum.Limb.Unknown then return end
                        local os_clock_result1 = os.clock()
                        if os_clock_result1 - os_clock_result1_2_upvw < 1 then return end
                        if not any_new_result1_upvr._flashing then
                            os_clock_result1_2_upvw = os_clock_result1
                            any_getAncestorPartHumanoid_result1:TakeDamage(assert(arg1:GetAttribute("LaserTrapDamage"), "missing LaserTrapDamage"))
                            arg2.replicateRemote:FireServer()
                            any_new_result1_upvr:_flicker()
                        end
                    end
                end))
            end))
        end))
    end))
    any_new_result1_upvr.maid:GiveTask(arg2.replicateRemote.OnClientEvent:Connect(function() -- Line 60
        any_new_result1_upvr:_flicker()
    end))
    return any_new_result1_upvr
end
function module_upvr._setPartsVisible(arg1, arg2) -- Line 66
    for _, v in assert(arg1.obj:FindFirstChild("Lasers"), "no lasersModel exists"):GetChildren(), nil do
        if arg2 then
            v.CanTouch = true
            v.Transparency = 0.2
        else
            v.CanTouch = false
            v.Transparency = 1
        end
    end
end
function module_upvr._setTouchPartsTriggered(arg1) -- Line 79
    local tbl_upvr = {}
    local tbl_upvr_2 = {}
    for _, v_2 in arg1.buttonsModel:GetChildren() do
        local Touch = DoorUtils_upvr.getInnerModel(v_2):FindFirstChild("Touch")
        tbl_upvr[Touch] = Touch.Transparency
        tbl_upvr_2[Touch] = Touch.Color
        Touch.Transparency = 0
        Touch.Color = Color3.new(0.9, 0, 0)
    end
    return function() -- Line 90
        for i_3, v_3 in tbl_upvr do
            i_3.Transparency = v_3
        end
        for i_4, v_4 in tbl_upvr_2 do
            i_4.Color = v_4
        end
    end
end
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local RunService_upvr = game:GetService("RunService")
function module_upvr._flicker(arg1) -- Line 99
    if arg1._flashing then
    else
        arg1._flashing = true
        Audio_upvr.ObjectLocal(arg1.obj:FindFirstChild("SoundPart"), 11793588989, {
            Volume = 1;
        })
        for i_5 = 0, 6 do
            local var40
            if i_5 % 2 ~= 0 then
                var40 = false
            else
                var40 = true
            end
            arg1:_setPartsVisible(var40)
            repeat
                RunService_upvr.Heartbeat:Wait()
            until 0.7777777777777778 ^ (6 - i_5) * 0.06666666666666667 <= os.clock() - os.clock()
        end
        arg1:_setPartsVisible(true)
        task.wait(2)
        arg1:_setPartsVisible(false)
        arg1:_setTouchPartsTriggered()()
        arg1._flashing = false
    end
end
return require(ReplicatedStorage.ManifestBinder).new("LaserTrap", {
    replicateRemote = "ReplicateRemote";
}, module_upvr)