return function(arg1) -- Line 1
    local Model = arg1.Model
    if not Model then return end
    local Body = Model:FindFirstChild("Body", true)
    if not Body then
        if arg1.Make ~= "Sloop" then
            Body = false
        else
            Body = true
        end
    end
    return Body
end