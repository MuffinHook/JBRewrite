return function(arg1) -- Line 1
    local Model_2 = arg1.Model
    if not Model_2 then return end
    local Model = Model_2:FindFirstChild("Model")
    if not Model then return end
    return Model:FindFirstChild("plate")
end