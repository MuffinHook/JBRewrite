return function(arg1) -- Line 1
    local var3 = true
    if arg1.Type ~= "Chassis" then
        var3 = true
        if arg1.Type ~= "DuneBuggy" then
            if arg1.Type ~= "Motorcycle" then
                var3 = false
            else
                var3 = true
            end
        end
    end
    return var3
end