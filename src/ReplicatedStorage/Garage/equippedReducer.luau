local function setCategoryEquipped(arg1, arg2) -- Line 6
    local var6
    if arg2.category == nil then
        var6 = false
    else
        var6 = true
    end
    assert(var6, "missing category")
    if arg2.name == nil then
        var6 = false
    else
        var6 = true
    end
    assert(var6, "missing name")
    var6 = pairs(arg1)
    local pairs_result1, pairs_result2, pairs_result3 = pairs(arg1)
    for i, v in pairs_result1, pairs_result2, pairs_result3 do
        ({})[i] = v
        local var11
    end
    pairs_result1 = arg2.category
    var11[pairs_result1] = arg2.name
    return var11
end
return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    setCategoryEquipped = setCategoryEquipped;
    setCategoryItemOwned = setCategoryEquipped;
    setEquippedRaw = function(arg1, arg2) -- Line 20, Named "setEquippedRaw"
        assert(arg2.equipped, "missing equipped")
        return arg2.equipped
    end;
})