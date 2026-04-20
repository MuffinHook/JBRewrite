local module_2_upvr = {}
module_2_upvr.__index = module_2_upvr
module_2_upvr.__ClassName = "WorldMarkerGroup"
function module_2_upvr.new() -- Line 4
    local module = {}
    setmetatable(module, module_2_upvr)
    module._listWorldMarker = {}
    module._enabled = true
    return module
end
function module_2_upvr.Add(arg1, arg2) -- Line 13
    arg2:SetEnabled(arg1._enabled)
    table.insert(arg1._listWorldMarker, arg2)
end
function module_2_upvr.Remove(arg1, arg2) -- Line 17
    local table_find_result1 = table.find(arg1._listWorldMarker, arg2)
    assert(table_find_result1, "Removing worldMarker that doesn't exist in _listWorldMarker")
    table.remove(arg1._listWorldMarker, table_find_result1)
end
function module_2_upvr.Update(arg1) -- Line 22
    if not arg1._enabled then
    else
        for var4 = #arg1._listWorldMarker, 1, -1 do
            local var5 = arg1._listWorldMarker[var4]
            assert(var5.Update, "destroyed/nil worldMarker is being Updated")
            var5:Update()
        end
    end
end
function module_2_upvr.SetEnabled(arg1, arg2) -- Line 32
    arg1._enabled = arg2
    for _, v in ipairs(arg1._listWorldMarker) do
        v:SetEnabled(arg2)
    end
end
function module_2_upvr.GetAll(arg1) -- Line 38
    return arg1._listWorldMarker
end
return module_2_upvr