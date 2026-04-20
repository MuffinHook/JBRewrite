return function(arg1) -- Line 1
    local Model = arg1.Model
    if not Model then return end
    return Model:FindFirstChild("Windows", true)
end