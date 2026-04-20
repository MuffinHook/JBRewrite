local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local GeomUtils_upvr = require(ReplicatedStorage.Std.GeomUtils)
local VehicleLinkUtils_upvr = require(ReplicatedStorage.VehicleLink.VehicleLinkUtils)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
function module_upvr.new(arg1, arg2) -- Line 18
    local any_new_result1_3_upvr = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1_3_upvr, module_upvr)
    any_new_result1_3_upvr.manifest = arg2
    any_new_result1_3_upvr:_updateSeeking()
    any_new_result1_3_upvr.maid:GiveTask(any_new_result1_3_upvr.manifest.networkOwnerIdObj.Changed:Connect(function() -- Line 24, Named "checkOwner"
        any_new_result1_3_upvr:_updateSeeking()
    end))
    return any_new_result1_3_upvr
end
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function module_upvr._updateSeeking(arg1) -- Line 32
    if arg1:GetOwner() == Players_upvr.LocalPlayer then
        arg1.maid.seeking = Interval_upvr.every(0.25):Connect(function() -- Line 35
            if VehicleLinkUtils_upvr.getDisabled(arg1.obj) then
            elseif not VehicleLinkUtils_upvr.getIsLinked(arg1.obj) then
                local any__getNearestObj_result1 = arg1:_getNearestObj(8)
                if any__getNearestObj_result1 ~= arg1.nearestObj then
                    arg1.nearestObj = any__getNearestObj_result1
                    if any__getNearestObj_result1 then
                        local any_new_result1 = Maid_upvr.new()
                        arg1.maid.nearestMaid = any_new_result1
                        arg1:_hookNearest(any_new_result1)
                        return
                    end
                    arg1.maid.nearestMaid = nil
                end
            end
        end)
    else
        arg1.maid.seeking = nil
        arg1.maid.nearestMaid = nil
    end
end
local LoadingBar_upvr = require(ReplicatedStorage.Game.LoadingBar)
local RunService_upvr = game:GetService("RunService")
function module_upvr._hookNearest(arg1, arg2) -- Line 59
    local nearestObj_upvr = arg1.nearestObj
    local any__makePartVisualBall_result1_upvr = arg1:_makePartVisualBall()
    any__makePartVisualBall_result1_upvr.Parent = workspace
    arg2:GiveTask(any__makePartVisualBall_result1_upvr)
    local any__makePartVisualBlock_result1_upvr = arg1:_makePartVisualBlock()
    any__makePartVisualBlock_result1_upvr.Parent = workspace
    arg2:GiveTask(any__makePartVisualBlock_result1_upvr)
    local any_new_result1_2_upvr = LoadingBar_upvr.new()
    arg2:GiveTask(any_new_result1_2_upvr)
    any_new_result1_2_upvr:SetPosition(UDim2.new(0.5, 0, 0.6666666666666666, 0))
    local any_getPrimaryPart_result1_2_upvr = VehicleLinkUtils_upvr.getPrimaryPart(nearestObj_upvr)
    local os_clock_result1_upvr = os.clock()
    local var23_upvw = 0
    local function update() -- Line 74
        local var24
        if nearestObj_upvr:GetAttribute("VehicleHasDriver") == true then
            var24 = 5
        else
            var24 = 1
        end
        local any_closestPointInPart_result1 = GeomUtils_upvr.closestPointInPart(any_getPrimaryPart_result1_2_upvr, arg1.obj.Position)
        any__makePartVisualBall_result1_upvr.CFrame = CFrame.new(any_closestPointInPart_result1)
        any__makePartVisualBlock_result1_upvr.Size = any_getPrimaryPart_result1_2_upvr.Size * 1.02
        any__makePartVisualBlock_result1_upvr.CFrame = any_getPrimaryPart_result1_2_upvr.CFrame
        local os_clock_result1 = os.clock()
        local var27 = os_clock_result1 - os_clock_result1_upvr
        any_new_result1_2_upvr:SetValue(math.min(1, var27 / var24))
        if var24 < var27 and 1 < os_clock_result1 - var23_upvw then
            var23_upvw = os_clock_result1
            arg1.manifest.reqLinkRemote:FireServer(nearestObj_upvr, any_getPrimaryPart_result1_2_upvr.CFrame:PointToObjectSpace(any_closestPointInPart_result1))
        end
    end
    arg2:GiveTask(RunService_upvr.Heartbeat:Connect(update))
    update()
    arg2:GiveTask(VehicleLinkUtils_upvr.getIsLinkedChangedSignal(arg1.obj):Connect(function() -- Line 99
        if VehicleLinkUtils_upvr.getIsLinked(arg1.obj) then
            arg2:DoCleaning()
        end
    end))
    arg2:GiveTask(VehicleLinkUtils_upvr.getDisabledChangedSignal(arg1.obj):Connect(function() -- Line 105
        if VehicleLinkUtils_upvr.getDisabled(arg1.obj) then
            arg2:DoCleaning()
        end
    end))
end
function module_upvr._makePartVisualBall(arg1) -- Line 111
    local Part_2 = Instance.new("Part")
    Part_2.Size = Vector3.new(1, 1, 1)
    Part_2.CanCollide = false
    Part_2.Color = Color3.new(1, 0, 0)
    Part_2.Shape = Enum.PartType.Ball
    Part_2.Transparency = 0.3
    Part_2.TopSurface = 0
    Part_2.BottomSurface = 0
    Part_2.Anchored = true
    return Part_2
end
function module_upvr._makePartVisualBlock(arg1) -- Line 122
    local Part = Instance.new("Part")
    Part.CanCollide = false
    Part.Color = Color3.new(0, 1, 0)
    Part.Transparency = 0.8
    Part.TopSurface = 0
    Part.BottomSurface = 0
    Part.Anchored = true
    return Part
end
function module_upvr._getPrimaryPart(arg1, arg2) -- Line 131
    local BoundingBox = arg2:FindFirstChild("BoundingBox")
    if not BoundingBox then
        BoundingBox = arg2.PrimaryPart
    end
    return BoundingBox
end
local CollectionService_upvr = game:GetService("CollectionService")
function module_upvr._getNearestObj(arg1, arg2) -- Line 134
    local var60
    for _, v in ipairs(CollectionService_upvr:GetTagged("HeliPickup")) do
        if not arg1.obj:IsDescendantOf(v) then
            local any_getPrimaryPart_result1_4 = VehicleLinkUtils_upvr.getPrimaryPart(v)
            if any_getPrimaryPart_result1_4 then
                if (arg1.obj.Position - GeomUtils_upvr.closestPointInPart(any_getPrimaryPart_result1_4, arg1.obj.Position)).Magnitude < arg2 then
                end
            end
        end
    end
    return nil
end
function module_upvr.GetOwner(arg1) -- Line 157
    return Players_upvr:GetPlayerByUserId(arg1.manifest.networkOwnerIdObj.Value)
end
function module_upvr.Unattach(arg1) -- Line 162
    arg1.manifest.reqUnlinkRemote:FireServer()
end
return require(ReplicatedStorage.ManifestBinder).new("VehicleLink", {
    reqLinkRemote = "ReqLink";
    reqUnlinkRemote = "ReqUnlink";
    networkOwnerIdObj = "NetworkOwnerId";
}, module_upvr)