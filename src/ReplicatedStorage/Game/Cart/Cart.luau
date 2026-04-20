local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local CartUtils_upvr = require(script.Parent.CartUtils)
local module_upvr_2 = {}
module_upvr_2.__index = module_upvr_2
module_upvr_2.__ClassName = "Cart"
local RxInstanceUtils_upvr = require(ReplicatedStorage_upvr.Std.RxInstanceUtils)
local CartConsts_upvr = require(script.Parent.CartConsts)
local HttpService_upvr = game:GetService("HttpService")
local BinderUtils_upvr = require(ReplicatedStorage_upvr.Std.Binder.BinderUtils)
local OwnedPartBinder_upvr = require(ReplicatedStorage_upvr.Game.OwnedPart.OwnedPartBinder)
function module_upvr_2.new(arg1) -- Line 19
    local module_upvr = {}
    setmetatable(module_upvr, module_upvr_2)
    RxInstanceUtils_upvr.yieldForProperty(arg1, "PrimaryPart")
    module_upvr._maid = Maid_upvr.new()
    module_upvr._obj = arg1
    module_upvr._firstSegmentValue = arg1:WaitForChild(CartConsts_upvr.FIRST_SEGMENT_VALUE_NAME)
    module_upvr._secondSegmentValue = arg1:WaitForChild(CartConsts_upvr.SECOND_SEGMENT_VALUE_NAME)
    module_upvr._graphValue = arg1:WaitForChild(CartConsts_upvr.GRAPH_VALUE_NAME)
    module_upvr._offsetValue = arg1:WaitForChild(CartConsts_upvr.OFFSET_VALUE_NAME)
    module_upvr._updatedAtValue = arg1:WaitForChild(CartConsts_upvr.UPDATED_AT_VALUE_NAME)
    module_upvr._seatOwnedPartValue = arg1:WaitForChild(CartConsts_upvr.SEAT_OWNED_PART_VALUE_NAME)
    module_upvr._yOffset = 1
    module_upvr._graph = nil
    local Value_2 = module_upvr._graphValue.Value
    if Value_2 then
        module_upvr._graph = HttpService_upvr:JSONDecode(Value_2)
    else
        module_upvr._graph = nil
    end
    module_upvr._maid:GiveTask(module_upvr._graphValue.Changed:Connect(function() -- Line 38, Named "decodeGraphStr"
        local Value = module_upvr._graphValue.Value
        if Value then
            module_upvr._graph = HttpService_upvr:JSONDecode(Value)
        else
            module_upvr._graph = nil
        end
    end))
    module_upvr._maid:GiveTask(module_upvr._firstSegmentValue.Changed:Connect(function() -- Line 49
        module_upvr:_onSegmentUpdate()
    end))
    module_upvr._maid:GiveTask(module_upvr._secondSegmentValue.Changed:Connect(function() -- Line 52
        module_upvr:_onSegmentUpdate()
    end))
    module_upvr:_onSegmentUpdate()
    module_upvr._maid._seatMaid = Maid_upvr.new()
    local var15_upvw
    local function onOwnedPart(arg1_2) -- Line 59
        if var15_upvw then
            var15_upvw:cancel()
            var15_upvw = nil
        end
        module_upvr._ownedPartSeat = nil
        if arg1_2 then
            module_upvr._maid._onSeated = RxInstanceUtils_upvr.observeOneChildNamed(arg1_2, "SeatWeld", function(arg1_3, arg2) -- Line 69
                local var17
                if arg1_3 then
                    local Part0 = arg1_3.Part0
                    assert(Part0:IsA("BasePart"))
                    local Parent = Part0.Parent
                    local var20 = Parent
                    if var20 then
                        var20 = Parent:IsA("Model")
                    end
                    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                        var17 = Parent.ClassName
                        return var17
                    end
                    if not Parent or not decompInlinedCondition() then
                        var17 = "nil"
                    end
                    assert(var20, "SeatWeld.Part0.Parent was a: "..var17)
                end
                arg2:GiveTask(function() -- Line 80
                    module_upvr._maid._seatMaid:DoCleaning()
                    module_upvr:_onSeated(nil, module_upvr._maid._seatMaid)
                end)
                module_upvr._maid._seatMaid:DoCleaning()
                module_upvr:_onSeated(Parent, module_upvr._maid._seatMaid)
            end)
            var15_upvw = BinderUtils_upvr.promiseBoundClass(OwnedPartBinder_upvr, arg1_2):andThen(function(arg1_4) -- Line 88
                module_upvr._ownedPartSeat = arg1_4
            end)
        else
            module_upvr._maid._onSeated = nil
        end
    end
    onOwnedPart(module_upvr._seatOwnedPartValue.Value)
    module_upvr._maid:GiveTask(module_upvr._seatOwnedPartValue.Changed:Connect(onOwnedPart))
    return module_upvr
end
local Signal_upvr = require(ReplicatedStorage_upvr.Std.Signal)
function module_upvr_2.GetOnSeatedSignal(arg1) -- Line 103
    if not arg1._onSeatedSignal then
        arg1._onSeatedSignal = Signal_upvr.new()
        arg1._maid:GiveTask(arg1._onSeatedSignal)
    end
    return arg1._onSeatedSignal
end
local CharacterUtil_upvr = require(ReplicatedStorage_upvr.Game.CharacterUtil)
function module_upvr_2._onSeated(arg1, arg2, arg3) -- Line 110
    if arg2 then
        local Humanoid_upvr = arg2:FindFirstChild("Humanoid")
        CharacterUtil_upvr.stopAnims(Humanoid_upvr)
        Humanoid_upvr.Sit = true
        local any_LoadAnimation_result1_upvr = Humanoid_upvr:FindFirstChildOfClass("Animator"):LoadAnimation(ReplicatedStorage_upvr.Resource.CartSitAnimation)
        CharacterUtil_upvr.setHumanoidEnabled(Humanoid_upvr, false)
        any_LoadAnimation_result1_upvr:AdjustSpeed(0)
        any_LoadAnimation_result1_upvr:Play()
        arg3:GiveTask(function() -- Line 126
            Humanoid_upvr.Sit = false
        end)
        arg3:GiveTask(function() -- Line 129
            any_LoadAnimation_result1_upvr:Stop()
        end)
        arg3:GiveTask(any_LoadAnimation_result1_upvr)
        arg3:GiveTask(function() -- Line 133
            CharacterUtil_upvr.setHumanoidEnabled(Humanoid_upvr, true)
        end)
    end
    arg1._occupant = arg2
    Humanoid_upvr = arg1._onSeatedSignal
    if Humanoid_upvr then
        Humanoid_upvr = arg1._onSeatedSignal
        any_LoadAnimation_result1_upvr = arg3
        Humanoid_upvr = Humanoid_upvr:Fire
        Humanoid_upvr(arg2, any_LoadAnimation_result1_upvr)
    end
end
function module_upvr_2.GetOccupant(arg1) -- Line 142
    return arg1._occupant
end
function module_upvr_2.GetFirstSegment(arg1) -- Line 145
    return arg1._firstSegmentValue.Value
end
function module_upvr_2.GetSecondSegment(arg1) -- Line 148
    return arg1._secondSegmentValue.Value
end
local RunService_upvr = game:GetService("RunService")
local Time_upvr = require(ReplicatedStorage_upvr.Module.Time)
local GraphUtils_upvr = require(script.Parent.GraphUtils)
function module_upvr_2._startUpdate(arg1) -- Line 151
    arg1._maid._updateLoop = RunService_upvr.Heartbeat:Connect(function() -- Line 152
        local var34 = GraphUtils_upvr.calculateDist(arg1._graph, Time_upvr.GetNowSync() - arg1:GetUpdatedAt()) + arg1:GetOffset()
        local any_calculateSegment_result1, any_calculateSegment_result2 = CartUtils_upvr.calculateSegment(arg1._rail, var34 - 1.5)
        local any_calculatePosition_result1_2 = CartUtils_upvr.calculatePosition(arg1._rail, any_calculateSegment_result1, any_calculateSegment_result2)
        local any_calculateSegment_result1_2, any_calculateSegment_result2_2 = CartUtils_upvr.calculateSegment(arg1._rail, var34 + 1.5)
        local any_calculatePosition_result1 = CartUtils_upvr.calculatePosition(arg1._rail, any_calculateSegment_result1_2, any_calculateSegment_result2_2)
        arg1._obj.PrimaryPart.CFrame = CFrame.lookAt(Vector3.new(), any_calculatePosition_result1 - any_calculatePosition_result1_2) * CFrame.new(0, arg1._yOffset, 0) + (any_calculatePosition_result1_2 + any_calculatePosition_result1) * 0.5
        if arg1._ownedPartSeat then
            arg1._ownedPartSeat._obj.CFrame = arg1._obj:FindFirstChild("Seat").CFrame
            arg1._ownedPartSeat._obj.AssemblyLinearVelocity = Vector3.new()
        end
    end)
end
function module_upvr_2._onSegmentUpdate(arg1) -- Line 180
    local any_GetFirstSegment_result1 = arg1:GetFirstSegment()
    if not any_GetFirstSegment_result1 then
    else
        local any_GetSecondSegment_result1 = arg1:GetSecondSegment()
        if not any_GetSecondSegment_result1 then return end
        arg1._rail = CartUtils_upvr.computeRail(any_GetFirstSegment_result1, any_GetSecondSegment_result1)
        arg1:_startUpdate()
        arg1._maid.railUpdateMaid = Maid_upvr.new()
        for _, v in ipairs(arg1._rail.listSegment) do
            arg1._maid.railUpdateMaid:GiveTask(v._front.Changed:Connect(function() -- Line 197
                arg1:_onSegmentUpdate()
            end))
            arg1._maid.railUpdateMaid:GiveTask(v._back.Changed:Connect(function() -- Line 201
                arg1:_onSegmentUpdate()
            end))
        end
    end
end
function module_upvr_2.GetUpdatedAt(arg1) -- Line 207
    return arg1._updatedAtValue.Value
end
function module_upvr_2.GetGraph(arg1) -- Line 210
    return arg1._graphValue.Value
end
function module_upvr_2.GetOffset(arg1) -- Line 213
    return arg1._offsetValue.Value
end
function module_upvr_2.Destroy(arg1) -- Line 216
    arg1._maid = nil
    setmetatable(arg1, nil)
    arg1._maid:Destroy()
end
return module_upvr_2