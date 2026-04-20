return function(arg1) -- Line 1
    local var4 = true
    if arg1.Type ~= "Chassis" then
        var4 = true
        if arg1.Type ~= "DuneBuggy" then
            var4 = true
            if arg1.Type ~= "Motorcycle" then
                if arg1.Make ~= "Tank" then
                    var4 = false
                else
                    var4 = true
                end
            end
        end
    end
    return var4
end