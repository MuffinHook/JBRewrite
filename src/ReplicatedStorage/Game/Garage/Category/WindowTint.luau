return function(arg1) -- Line 1
    local Model = arg1.Model
    local var3
    if not Model then
        return false
    end
    var3 = "Model"
    if not Model:FindFirstChild(var3) then
        return false
    end
    var3 = Model:FindFirstChild("Windows", true)
    var3 = Model:FindFirstChild(var3):FindFirstChild("Interior")
    if not var3 then
        var3 = Model:FindFirstChild(var3):FindFirstChild("SecondInterior")
    end
    local var5
    if arg1.Type == "Chassis" and not var3 then
        var5 = false
    end
    return var5
end