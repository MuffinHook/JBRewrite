local ReplicatedStorage = game:GetService("ReplicatedStorage")
local tbl_upvr = {}
tbl_upvr.__index = tbl_upvr
local RunService_upvr = game:GetService("RunService")
function tbl_upvr.new(arg1, arg2) -- Line 10
    local setmetatable_result1_upvr = setmetatable({}, tbl_upvr)
    local tick_result1_upvr = tick()
    setmetatable_result1_upvr.Event = RunService_upvr.Heartbeat:Connect(function(arg1_2) -- Line 13, Named "Heartbeat"
        local var6 = tick() - tick_result1_upvr
        if 1 <= var6 then
            var6 = 1
            setmetatable_result1_upvr.Event:Disconnect()
            setmetatable_result1_upvr.Done = true
        end
        arg2(var6, arg1_2)
    end)
    setmetatable_result1_upvr.Done = false
    return setmetatable_result1_upvr
end
function tbl_upvr.Destroy(arg1) -- Line 27
    arg1.Event:Disconnect()
    arg1.Event = nil
    arg1.Done = true
end
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local NetSync_upvr = require(ReplicatedStorage.Module.NetSync)
return {
    Init = function(arg1) -- Line 33, Named "Init"
        local var9_upvw
        local function Update(arg1_3) -- Line 59
            -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
            if not arg1_3.Tagged then
                return false
            end
            if arg1_3.Type ~= "TrackSwitch" then
                return false
            end
            local var10
            if var9_upvw and not var9_upvw.Done then
                var9_upvw:Destroy()
            end
            local Inst = arg1_3.Inst
            local Rail = Inst.Parent.Parent.Rail
            if arg1_3.Flipped then
                var10 = 0
            else
                var10 = 1
            end
            if not Rail:FindFirstChild("Invert") or not (1 - var10) then
            end
            var10 = var10
            Rail.Transparency = var10
            local Parent_upvr = Inst.Parent
            Parent_upvr.PrimaryPart = Parent_upvr.Root
            local Root_upvr = Parent_upvr.Parent.Model.Root
            var9_upvw = tbl_upvr.new(0.5, function(arg1_4, arg2) -- Line 81
                local Rot = arg1_3.Rot
                if arg1_3.Flipped then
                    Rot = -0.9424777960769379
                else
                    Rot = 0
                end
                arg1_3.Rot = Rot * arg1_4 + (Rot or 0) * (1 - arg1_4)
                Parent_upvr:SetPrimaryPartCFrame(Root_upvr.CFrame * CFrame.Angles(0, 0, arg1_3.Rot))
            end)
            Audio_upvr.ObjectLocal(Inst, 2803301098)
        end
        NetSync_upvr.Signals.InstAddedSignal:Connect(Update)
        NetSync_upvr.Signals.UpdatedSignal:Connect(Update)
    end;
}