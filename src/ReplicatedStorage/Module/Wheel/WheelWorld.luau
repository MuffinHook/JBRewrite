local function GetMass_upvr(arg1) -- Line 7, Named "GetMass"
    local var7
    for _, v in next, arg1:GetChildren() do
        if v:IsA("BasePart") then
            var7 += v:GetMass()
        end
        var7 += GetMass_upvr(v)
    end
    return var7
end
local module_upvr = {}
module_upvr.__index = module_upvr
function module_upvr.new() -- Line 20
    local setmetatable_result1 = setmetatable({}, module_upvr)
    setmetatable_result1.Model = nil
    setmetatable_result1.Wheels = {}
    return setmetatable_result1
end
function module_upvr.SetModel(arg1, arg2) -- Line 26
    arg1.Model = arg2
end
function module_upvr.AddWheel(arg1, arg2) -- Line 29
    assert(arg2)
    table.insert(arg1.Wheels, arg2)
    arg1:Calculate()
end
function module_upvr.GetEffWheelCount(arg1) -- Line 34
    local var17
    for _, v_2 in ipairs(arg1.Wheels) do
        if v_2._applyForces then
            var17 += 1
        end
    end
    return var17
end
function module_upvr.Calculate(arg1) -- Line 43
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var22 = 0
    if arg1.Model ~= nil then
        var22 = GetMass_upvr(arg1.Model)
    end
    for i_3 = 1, #arg1.Wheels do
        arg1.Wheels[i_3].EffectiveMass = (var22) * (1 / arg1:GetEffWheelCount())
        arg1.Wheels[i_3].IgnoreModel = arg1.Model
        local _
    end
    arg1.Mass = var22
end
function module_upvr.Destroy(arg1) -- Line 58
    for i_4 = 1, #arg1.Wheels do
        arg1.Wheels[i_4]:Destroy()
    end
    arg1.Wheels = {}
end
return module_upvr