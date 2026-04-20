return function(arg1) -- Line 1
    local Model = arg1.Model
    local var3
    if not Model then
        return false
    end
    local Preset = Model:FindFirstChild("Preset")
    if not Preset then
        var3 = false
        return var3
    end
    if Preset:FindFirstChild("Drift") == nil then
        var3 = false
    else
        var3 = true
    end
    return var3
end