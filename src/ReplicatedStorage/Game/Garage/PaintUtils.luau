local module_upvr = {
    drill = function(arg1, arg2) -- Line 6, Named "drill"
        local tbl = {}
        local var10
        for i, v in ipairs(arg2) do
            tbl[i] = v
        end
        while var10 and 0 < #tbl do
            i = tbl
            var10 = var10:FindFirstChild(table.remove(i))
        end
        return var10
    end;
    getVehiclePath = function(arg1) -- Line 16, Named "getVehiclePath"
        local var11 = arg1
        local module = {arg1.Name}
        while not var11:FindFirstChild("BoundingBox") do
            local Parent = var11.Parent
            if not Parent then
                warn(table.concat(module, '.'))
                error("getVehiclePath failed, reached nil")
            end
            table.insert(module, Parent.Name)
        end
        return module
    end;
}
local RunService_upvr = game:GetService("RunService")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function module_upvr.GetDefaultVehiclePart(arg1) -- Line 29
    local any_getVehiclePath_result1 = module_upvr.getVehiclePath(arg1)
    if RunService_upvr:IsServer() then
        local any_drill_result1_2 = module_upvr.drill(ReplicatedStorage_upvr.Resource:FindFirstChild("Vehicles"), any_getVehiclePath_result1)
        if not any_drill_result1_2 then
            any_drill_result1_2 = module_upvr
            any_drill_result1_2 = any_drill_result1_2.drill(ReplicatedStorage_upvr.Resource:FindFirstChild("Plane"), any_getVehiclePath_result1)
            if not any_drill_result1_2 then
                any_drill_result1_2 = module_upvr
                any_drill_result1_2 = any_drill_result1_2.drill(ReplicatedStorage_upvr.Resource:FindFirstChild("Boat"), any_getVehiclePath_result1)
                if not any_drill_result1_2 then
                    any_drill_result1_2 = module_upvr
                    any_drill_result1_2 = any_drill_result1_2.drill(game:GetService("ServerStorage").Resource:FindFirstChild("ServerVehicles"), any_getVehiclePath_result1)
                end
            end
        end
        return any_drill_result1_2
    end
    local any_drill_result1_4 = module_upvr.drill(ReplicatedStorage_upvr.Resource:FindFirstChild("Vehicles"), any_getVehiclePath_result1)
    if not any_drill_result1_4 then
        any_drill_result1_4 = module_upvr
        any_drill_result1_4 = any_drill_result1_4.drill(ReplicatedStorage_upvr.Resource:FindFirstChild("Plane"), any_getVehiclePath_result1)
        if not any_drill_result1_4 then
            any_drill_result1_4 = module_upvr
            any_drill_result1_4 = any_drill_result1_4.drill(ReplicatedStorage_upvr.Resource:FindFirstChild("Boat"), any_getVehiclePath_result1)
        end
    end
    return any_drill_result1_4
end
return module_upvr