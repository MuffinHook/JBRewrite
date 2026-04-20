return function(arg1) -- Line 1
    local Model = arg1.Model
    if not Model then return end
    local SecondInterior = Model:FindFirstChild("SecondInterior", true)
    if not SecondInterior then
        if arg1.Make ~= "Sloop" then
            SecondInterior = false
        else
            SecondInterior = true
        end
    end
    return SecondInterior
end