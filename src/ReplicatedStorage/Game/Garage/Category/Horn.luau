return function(arg1) -- Line 1
    local var2 = false
    if arg1.Model:GetAttribute("VehicleHornId") ~= nil then
        var2 = not arg1.Model:GetAttribute("VehicleHornCustom")
    end
    return var2
end