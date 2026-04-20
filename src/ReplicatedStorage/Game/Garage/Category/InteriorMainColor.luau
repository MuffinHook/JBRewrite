return function(arg1) -- Line 1
    local Model = arg1.Model
    if not Model then return end
    local Interior = Model:FindFirstChild("Interior", true)
    if not Interior then
        if arg1.Make ~= "Sloop" then
            Interior = false
        else
            Interior = true
        end
    end
    return Interior
end