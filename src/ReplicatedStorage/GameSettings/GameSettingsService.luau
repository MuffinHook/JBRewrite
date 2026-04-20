local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
local gameSettingType_upvr = require(script.Parent.gameSettingType)
local module_upvr = {
    onUpdate = Signal_upvr.new();
    _list = {};
    onAdded = Signal_upvr.new();
}
local Roact_upvr = require(ReplicatedStorage.Roact)
function module_upvr.add(arg1) -- Line 11
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    assert(arg1.name, "missing name")
    local type = arg1.type
    assert(type, "missing gameSettingType")
    if arg1.defaultValue == nil then
        type = false
    else
        type = true
    end
    assert(type, "missing defaultValue")
    assert(arg1.order, "missing order")
    if not arg1.onChanged then
        arg1.onChanged = Signal_upvr.new()
    end
    if arg1.type == gameSettingType_upvr.Checkbox then
        if not arg1._value then
            arg1._value = arg1.defaultValue
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
    elseif arg1.type == gameSettingType_upvr.Slider and not arg1._value then
        local any_createBinding_result1, any_createBinding_result2 = Roact_upvr.createBinding(arg1.defaultValue)
        arg1._value = any_createBinding_result1
        arg1._updateValue = any_createBinding_result2
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local function getValue(arg1_2) -- Line 29
        return module_upvr.getValue(arg1_2)
    end
    arg1.getValue = getValue
    table.insert(module_upvr._list, arg1)
    module_upvr.onUpdate:Fire()
    module_upvr.onAdded:Fire(arg1)
    do
        return function() -- Line 35
            for i = #module_upvr._list, 1, -1 do
                if module_upvr._list[i] == arg1 then
                    table.remove(module_upvr._list, i)
                    module_upvr.onUpdate:Fire()
                    return true
                end
            end
            return false
        end
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.getAll() -- Line 46
    return module_upvr._list
end
function module_upvr.getSettingByName(arg1) -- Line 49
    for _, v in ipairs(module_upvr._list) do
        if v.name == arg1 then
            return v
        end
    end
end
function module_upvr.getValueByName(arg1) -- Line 56
    assert(arg1, "missing name")
    return module_upvr.getValue(module_upvr.getSettingByName(arg1))
end
function module_upvr.getValue(arg1) -- Line 61
    assert(arg1, "missing setting")
    if arg1.type == gameSettingType_upvr.Checkbox then
        return arg1._value
    end
    if arg1.type == gameSettingType_upvr.Slider then
        return arg1._value:getValue()
    end
end
function module_upvr.setValueByName(arg1, arg2) -- Line 69
    assert(arg1, "missing name")
    module_upvr.setValue(module_upvr.getSettingByName(arg1), arg2)
end
function module_upvr.setValue(arg1, arg2) -- Line 74
    assert(arg1, "missing setting")
    if arg1.type == gameSettingType_upvr.Checkbox then
        arg1._value = arg2
    elseif arg1.type == gameSettingType_upvr.Slider then
        arg1._updateValue(arg2)
    end
    arg1.onChanged:Fire(arg2)
    module_upvr.onUpdate:Fire()
end
return module_upvr