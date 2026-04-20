return function(arg1, arg2) -- Line 2
    local string_len_result1_2 = string.len(arg1)
    local string_len_result1 = string.len(arg2)
    local module = {}
    if string_len_result1_2 == 0 then
        return string_len_result1
    end
    if string_len_result1 == 0 then
        return string_len_result1_2
    end
    if arg1 == arg2 then
        return 0
    end
    for i = 0, string_len_result1_2 do
        module[i] = {}
        module[i][0] = i
    end
    for i_2 = 0, string_len_result1 do
        module[0][i_2] = i_2
    end
    for i_3 = 1, string_len_result1_2 do
        for i_4 = 1, string_len_result1 do
            local var13
            if arg1:byte(i_3) == arg2:byte(i_4) then
                var13 = 0
            else
                var13 = 1
            end
            module[i_3][i_4] = math.min(module[i_3 - 1][i_4] + 1, module[i_3][i_4 - 1] + 1, module[i_3 - 1][i_4 - 1] + var13)
        end
    end
    return module[string_len_result1_2][string_len_result1]
end