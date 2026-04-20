return function(arg1) -- Line 1
    local Model_5 = arg1.Model
    if not Model_5 then return end
    local SecondBody = Model_5:FindFirstChild("SecondBody", true)
    if not SecondBody then
        SecondBody = true
        if arg1.Make ~= "Tank" then
            SecondBody = true
            if arg1.Make ~= "TheRattler" then
                SecondBody = true
                if arg1.Make ~= "MCL36" then
                    SecondBody = true
                    if arg1.Make ~= "MCL36FREE" then
                        if arg1.Make ~= "Sloop" then
                            SecondBody = false
                        else
                            SecondBody = true
                        end
                    end
                end
            end
        end
    end
    return SecondBody
end