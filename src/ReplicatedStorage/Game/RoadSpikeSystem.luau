local var2_upvw
local tbl_upvr = {}
local function _(arg1) -- Line 10, Named "FromPart"
    local module = {}
    module.Part = arg1
    return module
end
local VehicleUtils_upvr = require(game:GetService("ReplicatedStorage").Vehicle.VehicleUtils)
local var6_upvw
local function Check_upvr() -- Line 17, Named "Check"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local any_GetLocalVehiclePacket_result1 = VehicleUtils_upvr.GetLocalVehiclePacket()
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local Position = any_GetLocalVehiclePacket_result1.Model.PrimaryPart.Position
    if var6_upvw ~= nil then
        for _, v in ipairs(tbl_upvr) do
            local Part = v.Part
            local CFrame = Part.CFrame
            local p = CFrame.p
            if math.sign((var6_upvw - p).Unit:Dot(CFrame.LookVector)) ~= math.sign((Position - p).Unit:Dot(CFrame.LookVector)) and math.abs(Position - p:Dot(CFrame.RightVector)) <= Part.Size.X * 0.5 and math.abs(Position - p:Dot(CFrame.UpVector)) < 16 then
                var2_upvw:FireServer('h'.."".."xjib4ww":sub(5, 5):reverse().."".."".."u2qsqu":sub(5, 5):reverse():reverse():reverse().."".."".."xinpz4":sub(3, 4):reverse():reverse():reverse().."".."puj", Part)
            end
        end
    end
    var6_upvw = Position
    do
        return
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if var6_upvw then
        var6_upvw = nil
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local var17_upvw = 0
local function Stepped_upvr() -- Line 51, Named "Stepped"
    local tick_result1 = tick()
    if 0.1 < tick_result1 - var17_upvw then
        var17_upvw = tick_result1
        Check_upvr()
    end
end
local RunService_upvr = game:GetService("RunService")
local CollectionService_upvr = game:GetService("CollectionService")
return {
    Init = function(arg1) -- Line 58, Named "Init"
        var2_upvw = arg1.Event
        RunService_upvr.Heartbeat:Connect(Stepped_upvr)
        for _, v_2 in ipairs(CollectionService_upvr:GetTagged("RoadSpike")) do
            table.insert(tbl_upvr, {
                Part = v_2;
            })
        end
        CollectionService_upvr:GetInstanceAddedSignal("RoadSpike"):Connect(function(arg1_2) -- Line 62, Named "AddedFun"
            local tbl = {}
            tbl.Part = arg1_2
            table.insert(tbl_upvr, tbl)
        end)
        CollectionService_upvr:GetInstanceRemovedSignal("RoadSpike"):Connect(function(arg1_3) -- Line 66, Named "RemovedFun"
            for i_2 = #tbl_upvr, 1, -1 do
                if tbl_upvr[i_2].Part == arg1_3 then
                    table.remove(tbl_upvr, i_2)
                    return
                end
            end
        end)
    end;
}