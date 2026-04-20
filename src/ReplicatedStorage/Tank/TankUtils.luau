local Players_upvr = game:GetService("Players")
local module_3_upvr = {}
function module_3_upvr.getGunner(arg1) -- Line 3
    local module_2 = {}
    for _, v in arg1:GetChildren() do
        if v.Name == "Seat" or v.Name == "Passenger" then
            local ControlGunPriority_3 = v:FindFirstChild("ControlGunPriority")
            if ControlGunPriority_3 and ControlGunPriority_3:IsA("IntValue") then
                local PlayerName = v:FindFirstChild("PlayerName")
                if PlayerName then
                    local SOME = Players_upvr:FindFirstChild(PlayerName.Value)
                    if SOME then
                        table.insert(module_2, {
                            player = SOME;
                            priority = ControlGunPriority_3.Value;
                        })
                    end
                end
            end
        end
    end
    table.sort(module_2, function(arg1_4, arg2) -- Line 27
        local var37
        if arg2.priority >= arg1_4.priority then
            var37 = false
        else
            var37 = true
        end
        return var37
    end)
    if 0 < #module_2 then
        return module_2[1].player
    end
    return module_3_upvr.getDriver(arg1)
end
function module_3_upvr.getDriver(arg1) -- Line 36
    for _, v_2 in arg1:GetChildren() do
        if v_2.Name == "Seat" then
            local PlayerName_3 = v_2:FindFirstChild("PlayerName")
            if PlayerName_3 then
                local SOME_3 = Players_upvr:FindFirstChild(PlayerName_3.Value)
                if SOME_3 then
                    return SOME_3
                end
            end
        end
    end
    return nil
end
return module_3_upvr