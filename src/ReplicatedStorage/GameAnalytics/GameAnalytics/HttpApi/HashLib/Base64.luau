local tbl_3_upvr = {}
local tbl_4_upvr = {}
for i = 65, 90 do
    table.insert(tbl_3_upvr, i)
end
for i_2 = 97, 122 do
    table.insert(tbl_3_upvr, i_2)
end
table.insert(tbl_3_upvr, 48)
table.insert(tbl_3_upvr, 49)
table.insert(tbl_3_upvr, 50)
table.insert(tbl_3_upvr, 51)
table.insert(tbl_3_upvr, 52)
table.insert(tbl_3_upvr, 53)
table.insert(tbl_3_upvr, 54)
table.insert(tbl_3_upvr, 55)
table.insert(tbl_3_upvr, 56)
table.insert(tbl_3_upvr, 57)
table.insert(tbl_3_upvr, 43)
table.insert(tbl_3_upvr, 47)
for i_3, v in ipairs(tbl_3_upvr) do
    tbl_4_upvr[v] = i_3
end
local module_2 = {}
local rshift_upvr = bit32.rshift
local lshift_upvr = bit32.lshift
local band_upvr = bit32.band
function module_2.Encode(arg1) -- Line 38
    local tbl_2 = {}
    local var23
    for i_4 = 1, #arg1, 3 do
        local string_byte_result1_2, string_byte_result2_2, string_byte_result3 = string.byte(arg1, i_4, i_4 + 2)
        var23 += 1
        tbl_2[var23] = tbl_3_upvr[rshift_upvr(string_byte_result1_2, 2) + 1]
        var23 += 1
        tbl_2[var23] = tbl_3_upvr[lshift_upvr(band_upvr(string_byte_result1_2, 3), 4) + rshift_upvr(string_byte_result2_2 or 0, 4) + 1]
        var23 += 1
        local var27
        local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var27 = tbl_3_upvr[lshift_upvr(band_upvr(string_byte_result2_2 or 0, 15), 2) + rshift_upvr(string_byte_result3 or 0, 6) + 1]
            return var27
        end
        if not string_byte_result2_2 or not decompInlinedCondition() then
            var27 = 61
        end
        tbl_2[var23] = var27
        var23 += 1
        local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var27 = tbl_3_upvr[band_upvr(string_byte_result3 or 0, 63) + 1]
            return var27
        end
        if not string_byte_result3 or not decompInlinedCondition_2() then
            var27 = 61
        end
        tbl_2[var23] = var27
    end
    local module_3 = {}
    for i_5 = 1, var23, 4096 do
        local var29 = i_5 + 4096 - 1
        local function decompInlinedCondition_3() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var27 = var23
            return var27
        end
        if var23 >= var29 or not decompInlinedCondition_3() then
            var27 = var29
        end
        module_3[0 + 1] = string.char(table.unpack(tbl_2, i_5, var27))
    end
    return table.concat(module_3)
end
function module_2.Decode(arg1) -- Line 86
    local tbl = {}
    local var35
    for i_6 = 1, #arg1, 4 do
        local string_byte_result1, string_byte_result2, string_byte_result3_2, string_byte_result4 = string.byte(arg1, i_6, i_6 + 3)
        local var40 = tbl_4_upvr[string_byte_result2] - 1
        local var41 = (tbl_4_upvr[string_byte_result3_2] or 1) - 1
        var35 += 1
        tbl[var35] = lshift_upvr(tbl_4_upvr[string_byte_result1] - 1, 2) + rshift_upvr(var40, 4)
        if string_byte_result3_2 ~= 61 then
            var35 += 1
            tbl[var35] = lshift_upvr(band_upvr(var40, 15), 4) + rshift_upvr(var41, 2)
        end
        if string_byte_result4 ~= 61 then
            var35 += 1
            tbl[var35] = (lshift_upvr(band_upvr(var41, 3), 6)) + ((tbl_4_upvr[string_byte_result4] or 1) - 1)
        end
    end
    local module = {}
    for i_7 = 1, var35, 4096 do
        local var43 = i_7 + 4096 - 1
        local var44
        local function decompInlinedCondition_4() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var44 = var35
            return var44
        end
        if var35 >= var43 or not decompInlinedCondition_4() then
            var44 = var43
        end
        module[0 + 1] = string.char(table.unpack(tbl, i_7, var44))
    end
    return table.concat(module)
end
return module_2