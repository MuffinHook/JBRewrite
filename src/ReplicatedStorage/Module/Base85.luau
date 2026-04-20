local module = {}
local tbl_upvr = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '!', '#', '$', '%', '&', '(', ')', '*', '+', '-', ';', '<', '=', '>', '?', '@', '^', '_', '`', '{', '|', '}', '~'}
function module.encode(arg1) -- Line 103
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local const_number = 1
    local var12 = 1
    local table_create_result1_3 = table.create(math.floor((#arg1 + 3) / 4) * 5)
    while const_number <= #arg1 do
        local string_byte_result1, string_byte_result2, string_byte_result3, string_byte_result4 = string.byte(arg1, const_number, const_number + 3)
        local var18 = (string_byte_result1 or 0) * 16777216 + (string_byte_result2 or 0) * 65536 + (string_byte_result3 or 0) * 256 + (string_byte_result4 or 0)
        for i = 4, 0, -1 do
            table_create_result1_3[var12 + i] = tbl_upvr[math.floor(var18 % 85) + 1]
            var18 = math.floor(var18 / 85)
            local var19
        end
        var12 += 5
    end
    for i_2 = 1, const_number + 4 - #arg1 - 1 do
        table_create_result1_3[var12 - i_2] = nil
    end
    return table.concat(table_create_result1_3)
end
local tbl_upvr_2 = {-- : First try: K:0: attempt to index nil with 't'

function module.decode(arg1) -- Line 226
    local table_create_result1_2 = table.create(math.floor(#arg1 * 4 / 5))
    local var38
    for i_3 = 1, #arg1 do
        local var39 = tbl_upvr_2[string.byte(arg1, i_3)]
        if not var39 then
            return "invalid byte at "..i_3, ""
        end
        if 0 <= var39 then
            local var40 = 0 * 85 + var39
            var38 += 1
            if var38 == 5 then
                table.insert(table_create_result1_2, string.char(math.floor(var40 / 16777216 % 256), math.floor(var40 / 65536 % 256), math.floor(var40 / 256 % 256), math.floor(var40 % 256)))
                var38 = 0
            end
        end
    end
    local var41
    if 0 < var38 then
        if var38 == 1 then
            i_3 = #table_create_result1_2 - 1
            return "corrupted base85 data at byte "..i_3, ""
        end
        i_3 = var38
        for _ = i_3, 4 do
            var41 = var41 * 85 + 84
        end
        for _ = 0, var38 - 2 do
            table.insert(table_create_result1_2, string.char(math.floor(var41 / 16777216 % 256)))
            var41 *= 256
        end
    end
    return nil, table.concat(table_create_result1_2)
end
return module