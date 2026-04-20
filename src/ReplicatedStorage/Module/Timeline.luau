local module_upvr = {}
module_upvr.__index = module_upvr
function module_upvr.new(arg1) -- Line 38
    assert(arg1)
    local setmetatable_result1 = setmetatable({}, module_upvr)
    setmetatable_result1.Data = arg1
    setmetatable_result1.Seqi = 1
    setmetatable_result1.CumulativeSeqAge = 0
    arg1[1][1](0, 0)
    return setmetatable_result1
end
function module_upvr.Update(arg1, arg2) -- Line 48
    local Data = arg1.Data
    local Seqi = arg1.Seqi
    local var7
    if #Data < Seqi then
        return true
    end
    for i = Seqi, #Data do
        local var8 = Data[i]
        if arg2 < var7 then break end
        if Seqi < i then
            Data[i - 1][1](1, Data[i - 1][2])
            var8[1](0, 0)
            arg1.Seqi = i
            arg1.CumulativeSeqAge = var7
        end
        var7 += var8[2]
    end
    local Seqi_2 = arg1.Seqi
    local var10 = Data[Seqi_2]
    local _2 = var10[2]
    var7 -= _2
    if var7 + _2 <= arg2 then
        var10[1](1, _2)
        arg1.Seqi = Seqi_2 + 1
        return true
    end
    local var12 = (arg2 - var7) / _2
    if var12 ~= 0 and var12 ~= 1 then
        var10[1](var12, arg2 - var7)
    end
    return false
end
function module_upvr.GetTotalLifespan(arg1) -- Line 86
    local var15 = 0
    for i_2 = 1, #arg1.Data do
        var15 += arg1.Data[i_2][2]
    end
    return var15
end
return module_upvr