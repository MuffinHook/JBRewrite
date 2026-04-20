return function(arg1) -- Line 1, Named "parsePath"
    local string_split_result1 = string.split(arg1, '/')
    for i = #string_split_result1, 1, -1 do
        if string_split_result1[i] == "" then
            table.remove(string_split_result1, i)
        end
    end
    return string_split_result1
end