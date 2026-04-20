local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils_upvr = require(ReplicatedStorage.Std.TableUtils)
local module_upvr = {
    triggerUpdate = require(ReplicatedStorage.Std.Signal).new();
    active = {};
    enabled = true;
}
function module_upvr.add(arg1) -- Line 9
    table.insert(module_upvr.active, arg1)
    module_upvr.triggerUpdate:Fire()
    return function() -- Line 16
        local table_find_result1_3 = table.find(module_upvr.active, arg1)
        if not table_find_result1_3 then
            error("Could not find ActionButton, already removed?")
        end
        table.remove(module_upvr.active, table_find_result1_3)
        if arg1._pressed then
            arg1._pressed = nil
            if arg1.onReleased then
                arg1.onReleased()
            end
        end
        module_upvr.triggerUpdate:Fire()
    end
end
function module_upvr.pushHide() -- Line 31
    module_upvr.enabled = false
    module_upvr.triggerUpdate:Fire()
    return function() -- Line 34
        module_upvr.enabled = true
        module_upvr.triggerUpdate:Fire()
    end
end
function module_upvr.hide() -- Line 39
    module_upvr.enabled = false
    module_upvr.triggerUpdate:Fire()
end
function module_upvr.show() -- Line 43
    module_upvr.enabled = true
    module_upvr.triggerUpdate:Fire()
end
function module_upvr.setButtonPrimary(arg1, arg2) -- Line 47
    arg1.primary = arg2
    module_upvr.triggerUpdate:Fire()
end
function module_upvr.setButtonPriority(arg1, arg2) -- Line 51
    arg1.priority = arg2
    module_upvr.triggerUpdate:Fire()
end
function module_upvr.setButtonKeyCodes(arg1, arg2) -- Line 55
    arg1.keyCodes = arg2
    module_upvr.triggerUpdate:Fire()
end
function module_upvr.addButtonKeyCode(arg1, arg2) -- Line 59
    if not table.find(arg1.keyCodes, arg2) then
        table.insert(arg1.keyCodes, arg2)
        module_upvr.triggerUpdate:Fire()
    end
end
function module_upvr.removeButtonKeyCode(arg1, arg2) -- Line 65
    local table_find_result1_2 = table.find(arg1.keyCodes, arg2)
    if table_find_result1_2 then
        table.remove(arg1.keyCodes, table_find_result1_2)
        module_upvr.triggerUpdate:Fire()
    end
end
function module_upvr.setButtonEnabled(arg1, arg2) -- Line 72
    arg1.disabled = not arg2
    if arg1._pressed then
        arg1._pressed = nil
        if arg1.onReleased then
            arg1.onReleased()
        end
    end
    module_upvr.triggerUpdate:Fire()
end
function module_upvr.getDataInner() -- Line 82
    local any_filter_result1 = TableUtils_upvr.filter(module_upvr.active, function(arg1) -- Line 83
        local var10 = not arg1.disabled
        if var10 then
            var10 = arg1.primary
        end
        return var10
    end)
    table.sort(any_filter_result1, function(arg1, arg2) -- Line 86
        local var13
        if (arg2.priority or 1) >= (arg1.priority or 1) then
            var13 = false
        else
            var13 = true
        end
        return var13
    end)
    return any_filter_result1
end
function module_upvr.getDataOuter() -- Line 91
    local any_filter_result1_2 = TableUtils_upvr.filter(module_upvr.active, function(arg1) -- Line 92
        local var15 = not arg1.disabled
        if var15 then
            var15 = not arg1.primary
        end
        return var15
    end)
    table.sort(any_filter_result1_2, function(arg1, arg2) -- Line 95
        local var18
        if (arg2.priority or 1) >= (arg1.priority or 1) then
            var18 = false
        else
            var18 = true
        end
        return var18
    end)
    return any_filter_result1_2
end
return module_upvr