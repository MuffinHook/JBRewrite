local module_upvr = {
    _value = require(script.Parent.fallbackPopularSortData);
}
function module_upvr.setRaw(arg1) -- Line 3
    module_upvr._value = arg1
end
function module_upvr.getRaw() -- Line 6
    return module_upvr._value
end
return module_upvr