return function(arg1) -- Line 1
    local Model = arg1.Model
    local var3
    if not Model then return end
    if Model:FindFirstChild("Glow", true) == nil then
        var3 = false
    else
        var3 = true
    end
    return var3
end