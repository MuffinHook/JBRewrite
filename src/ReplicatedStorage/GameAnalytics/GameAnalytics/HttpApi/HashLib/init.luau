-- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
local band_upvr = bit32.band
local bxor_upvr = bit32.bxor
local rshift_upvr = bit32.rshift
local lrotate_upvr = bit32.lrotate
local rrotate_upvr = bit32.rrotate
local tbl_3_upvr = {}
local tbl = {}
local _ = {-- : First try: K:0: attempt to index nil with 't'

local _ = {-- : First try: K:0: attempt to index nil with 't'

local _ = {-- : First try: K:0: attempt to index nil with 't'

local _ = {1732584193, 4023233417, 2562383102, 271733878, 3285377520}
local tbl_upvr = {0, 0, 0, 0, 0, 0, 0, 0, 28, 25, 26, 27, 0, 0, 10, 9, 11, 12, 0, 15, 16, 17, 18, 0, 20, 22, 23, 21}
local tbl_upvr_3 = {}
local function _(arg1, arg2, arg3, arg4) -- Line 151, Named "sha256_feed_64"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var31 = tbl_upvr_3
    local var32 = tbl_3_upvr
    local _2 = arg1[2]
    local _3_3 = arg1[3]
    local _5 = arg1[5]
    local _6_3 = arg1[6]
    local _7_5 = arg1[7]
    local _8 = arg1[8]
    local var40
    for i = arg3, arg3 + arg4 - 1, 64 do
        local var41 = i
        local var42
        for i_2 = 1, var42 do
            var41 += 4
            local string_byte_result1_3, string_byte_result2_6, string_byte_result3_3, string_byte_result4_5 = string.byte(arg2, var41 - 3, var41)
            var31[i_2] = ((string_byte_result1_3 * 256 + string_byte_result2_6) * 256 + string_byte_result3_3) * 256 + string_byte_result4_5
        end
        var42 = 64
        for i_3 = 17, var42 do
            local var47 = var31[i_3 - 15]
            local var48 = var31[i_3 - 2]
            var31[i_3] = bxor_upvr(rrotate_upvr(var47, 7), lrotate_upvr(var47, 14), rshift_upvr(var47, 3)) + bxor_upvr(lrotate_upvr(var48, 15), lrotate_upvr(var48, 13), rshift_upvr(var48, 10)) + var31[i_3 - 7] + var31[i_3 - 16]
        end
        var42 = var40
        local var49 = _5
        local var50 = _6_3
        local var51 = _7_5
        for i_4 = 1, 64 do
            local var53 = _3_3
            local var54 = _2
            var42 = bxor_upvr(rrotate_upvr(var49, 6), rrotate_upvr(var49, 11), lrotate_upvr(var49, 7)) + band_upvr(var49, var50) + band_upvr(-1 - var49, var51) + _8 + var32[i_4] + var31[i_4] + band_upvr(var53, var54) + band_upvr(var42, bxor_upvr(var53, var54)) + bxor_upvr(rrotate_upvr(var42, 2), rrotate_upvr(var42, 13), lrotate_upvr(var42, 10))
            local var55
        end
        var40 = (var42 + var40) % 4294967296
    end
    arg1[1] = var40
    arg1[2] = (var42 + _2) % 4294967296
    arg1[3] = (var54 + _3_3) % 4294967296
    arg1[4] = (var53 + arg1[4]) % 4294967296
    arg1[5] = (var55 + _5) % 4294967296
    arg1[6] = (var49 + _6_3) % 4294967296
    arg1[7] = (var50 + _7_5) % 4294967296
    arg1[8] = (var51 + _8) % 4294967296
end
local tbl_upvr_5 = {}
local lshift_upvr = bit32.lshift
local function _(arg1, arg2, arg3, arg4, arg5) -- Line 187, Named "sha512_feed_128"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var74 = tbl_upvr_3
    local var75 = tbl_upvr_5
    local var76 = tbl_3_upvr
    local _2_5 = arg1[2]
    local _3_4 = arg1[3]
    local _4_2 = arg1[4]
    local _5_6 = arg1[5]
    local _6 = arg1[6]
    local _7 = arg1[7]
    local _8_4 = arg1[8]
    local _2_6 = arg2[2]
    local _3_5 = arg2[3]
    local _4_5 = arg2[4]
    local _5_3 = arg2[5]
    local _6_5 = arg2[6]
    local _7_3 = arg2[7]
    local _8_3 = arg2[8]
    local var92
    for i_5 = arg4, arg4 + arg5 - 1, 128 do
        local var93 = i_5
        local var94
        for i_6 = 1, var94 do
            var93 += 4
            local string_byte_result1_5, string_byte_result2_5, string_byte_result3_2, string_byte_result4_4 = string.byte(arg3, var93 - 3, var93)
            var74[i_6] = ((string_byte_result1_5 * 256 + string_byte_result2_5) * 256 + string_byte_result3_2) * 256 + string_byte_result4_4
        end
        var94 = 160
        for i_7 = 34, var94, 2 do
            local _ = var74[i_7 - 30]
            local _ = var74[i_7 - 31]
            local var101 = var74[i_7 - 4]
            local var102 = var74[i_7 - 5]
            local var103 = bxor_upvr(rshift_upvr(_, 1) + lshift_upvr(_, 31), rshift_upvr(_, 8) + lshift_upvr(_, 24), rshift_upvr(_, 7) + lshift_upvr(_, 25)) % 4294967296 + bxor_upvr(rshift_upvr(var101, 19) + lshift_upvr(var102, 13), lshift_upvr(var101, 3) + rshift_upvr(var102, 29), rshift_upvr(var101, 6) + lshift_upvr(var102, 26)) % 4294967296 + var74[i_7 - 14] + var74[i_7 - 32]
            local var104 = var103 % 4294967296
            var74[i_7 - 1] = bxor_upvr(rshift_upvr(_, 1) + lshift_upvr(_, 31), rshift_upvr(_, 8) + lshift_upvr(_, 24), rshift_upvr(_, 7)) + bxor_upvr(rshift_upvr(var102, 19) + lshift_upvr(var101, 13), lshift_upvr(var102, 3) + rshift_upvr(var101, 29), rshift_upvr(var102, 6)) + var74[i_7 - 15] + var74[i_7 - 33] + (var103 - var104) / 4294967296
            var74[i_7] = var104
        end
        var94 = var92
        local var105 = _5_6
        local var106 = _6
        local var107 = _7
        local var108 = _5_3
        local var109 = _6_5
        local var110 = _7_3
        for i_8 = 1, 80 do
            local var111 = i_8 * 2
            local var112 = bxor_upvr(rshift_upvr(var105, 14) + lshift_upvr(var108, 18), rshift_upvr(var105, 18) + lshift_upvr(var108, 14), lshift_upvr(var105, 23) + rshift_upvr(var108, 9)) % 4294967296 + (band_upvr(var105, var106) + band_upvr(-1 - var105, var107)) % 4294967296 + _8_4 + var75[i_8] + var74[var111]
            local var113 = var112 % 4294967296
            local var115 = var113 + _4_2
            local var121 = var94
            local var122 = arg2[1]
            local var123 = var113 + (band_upvr(_3_4, _2_5) + band_upvr(var121, bxor_upvr(_3_4, _2_5))) % 4294967296 + bxor_upvr(rshift_upvr(var121, 28) + lshift_upvr(var122, 4), lshift_upvr(var121, 30) + rshift_upvr(var122, 2), lshift_upvr(var121, 25) + rshift_upvr(var122, 7)) % 4294967296
            var94 = var123 % 4294967296
            local var124
        end
        var94 = var92 + var94
        var92 = var94 % 4294967296
        var94 = _2_5 + var121
        local var125 = var94 % 4294967296
        var94 = _3_4 + _2_5
        local var126 = var94 % 4294967296
        var94 = _4_2 + _3_4
        local var127 = var94 % 4294967296
        var94 = _5_6 + var124
        local var128 = var94 % 4294967296
        var94 = _6 + var105
        local var129 = var94 % 4294967296
        var94 = _7 + var106
        local var130 = var94 % 4294967296
        var94 = _8_4 + var107
        local var131 = var94 % 4294967296
    end
    arg1[1] = var92
    arg1[2] = var125
    arg1[3] = var126
    arg1[4] = var127
    arg1[5] = var128
    arg1[6] = var129
    arg1[7] = var130
    arg1[8] = var131
    arg2[1] = ((arg2[1]) + ((bxor_upvr(rshift_upvr(var108, 14) + lshift_upvr(var105, 18), rshift_upvr(var108, 18) + lshift_upvr(var105, 14), lshift_upvr(var108, 23) + rshift_upvr(var105, 9)) + band_upvr(var108, var109) + band_upvr(-1 - var108, var110) + _8_3 + var76[i_8] + var74[var111 - 1] + (var112 - var113) / 4294967296) + (band_upvr(_3_5, _2_6) + band_upvr(var122, bxor_upvr(_3_5, _2_6))) + bxor_upvr(rshift_upvr(var122, 28) + lshift_upvr(var121, 4), lshift_upvr(var122, 30) + rshift_upvr(var121, 2), lshift_upvr(var122, 25) + rshift_upvr(var121, 7)) + (var123 - var94) / 4294967296) + (var94 - var92) / 4294967296) % 4294967296
    arg2[2] = (_2_6 + var122 + (var94 - var125) / 4294967296) % 4294967296
    arg2[3] = (_3_5 + _2_6 + (var94 - var126) / 4294967296) % 4294967296
    arg2[4] = (_4_5 + _3_5 + (var94 - var127) / 4294967296) % 4294967296
    arg2[5] = ((_5_3) + (bxor_upvr(rshift_upvr(var108, 14) + lshift_upvr(var105, 18), rshift_upvr(var108, 18) + lshift_upvr(var105, 14), lshift_upvr(var108, 23) + rshift_upvr(var105, 9)) + band_upvr(var108, var109) + band_upvr(-1 - var108, var110) + _8_3 + var76[i_8] + var74[var111 - 1] + (var112 - var113) / 4294967296 + _4_5 + (var115 - var115 % 4294967296) / 4294967296) + (var94 - var128) / 4294967296) % 4294967296
    arg2[6] = (_6_5 + var108 + (var94 - var129) / 4294967296) % 4294967296
    arg2[7] = (_7_3 + var109 + (var94 - var130) / 4294967296) % 4294967296
    arg2[8] = (_8_3 + var110 + (var94 - var131) / 4294967296) % 4294967296
end
local tbl_upvr_2 = {}
local bor_upvr = bit32.bor
local function _(arg1, arg2, arg3, arg4) -- Line 278, Named "md5_feed_64"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var158 = tbl_upvr_3
    local var159 = tbl_upvr_2
    local var160 = tbl_upvr
    local _2_7 = arg1[2]
    local _3_7 = arg1[3]
    local _4_6 = arg1[4]
    local var164
    for i_9 = arg3, arg3 + arg4 - 1, 64 do
        local var165 = i_9
        local var166
        for i_10 = 1, 16 do
            var165 += 4
            var166 = string.byte(arg2, var165 - 3, var165)
            local string_byte_result1, string_byte_result2, string_byte_result3_6, string_byte_result4_2 = string.byte(arg2, var165 - 3, var165)
            var158[i_10] = ((string_byte_result4_2 * 256 + string_byte_result3_6) * 256 + string_byte_result2) * 256 + string_byte_result1
        end
        local var171 = _2_7
        local var172 = _3_7
        string_byte_result1 = _4_6
        for i_11 = 1, 16 do
            string_byte_result1 = var172
            local var174 = var171
            var171 = rrotate_upvr(band_upvr(var171, var172) + band_upvr(-1 - var171, string_byte_result1) + var164 + var159[i_11] + var158[i_11], 25) + var171
            local var175
        end
        for i_12 = 17, 32 do
            string_byte_result1 = var174
            local var177 = var175
            var175 = rrotate_upvr(band_upvr(string_byte_result1, var175) + band_upvr(-1 - string_byte_result1, var174) + string_byte_result1 + var159[i_12] + var158[(i_12 * 5 - 4) % 16 + 1], 27) + var175
            local var178
        end
        for i_13 = 33, 48 do
            string_byte_result1 = var177
            local var180 = var178
            var178 = rrotate_upvr(bxor_upvr(bxor_upvr(var178, var177), string_byte_result1) + string_byte_result1 + var159[i_13] + var158[(i_13 * 3 + 2) % 16 + 1], 28) + var178
            local var181
        end
        for i_14 = 49, 64 do
            string_byte_result1 = var180
            local var183
        end
        var164 = (string_byte_result1 + var164) % 4294967296
    end
    arg1[1] = var164
    arg1[2] = (rrotate_upvr(bxor_upvr(var180, bor_upvr(var181, -1 - string_byte_result1)) + string_byte_result1 + var159[i_14] + var158[(i_14 * 7 - 7) % 16 + 1], 26) + var181 + _2_7) % 4294967296
    arg1[3] = (var181 + _3_7) % 4294967296
    arg1[4] = (string_byte_result1 + _4_6) % 4294967296
end
local function _(arg1, arg2, arg3, arg4) -- Line 339, Named "sha1_feed_64"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var212 = tbl_upvr_3
    local _2_4 = arg1[2]
    local _3 = arg1[3]
    local _4_3 = arg1[4]
    local _5_2 = arg1[5]
    local var217
    for i_15 = arg3, arg3 + arg4 - 1, 64 do
        local var218 = i_15
        local var219
        for i_16 = 1, var219 do
            var218 += 4
            local string_byte_result1_2, string_byte_result2_3, string_byte_result3_5, string_byte_result4_6 = string.byte(arg2, var218 - 3, var218)
            var212[i_16] = ((string_byte_result1_2 * 256 + string_byte_result2_3) * 256 + string_byte_result3_5) * 256 + string_byte_result4_6
        end
        var219 = 80
        for i_17 = 17, var219 do
            var212[i_17] = lrotate_upvr(bxor_upvr(var212[i_17 - 3], var212[i_17 - 8], var212[i_17 - 14], var212[i_17 - 16]), 1)
        end
        var219 = var217
        local var224 = _2_4
        local var225 = _3
        local var226 = _4_3
        for i_18 = 1, 20 do
            local var227 = var225
            local rrotate_upvr_result1_3 = rrotate_upvr(var224, 2)
            local var229 = var219
            var219 = lrotate_upvr(var219, 5) + band_upvr(var224, var225) + band_upvr(-1 - var224, var226) + 1518500249 + var212[i_18] + _5_2
        end
        for i_19 = 21, 40 do
            local var230 = rrotate_upvr_result1_3
            local rrotate_upvr_result1 = rrotate_upvr(var229, 2)
            local var232 = var219
        end
        for i_20 = 41, 60 do
            local var233 = rrotate_upvr_result1
            local rrotate_upvr_result1_2 = rrotate_upvr(var232, 2)
            local var235 = lrotate_upvr(var219, 5) + bxor_upvr(var229, rrotate_upvr_result1_3, var227) + 1859775393 + var212[i_19] + var226
        end
        for i_21 = 61, 80 do
        end
        var217 = (lrotate_upvr(lrotate_upvr(lrotate_upvr(var219, 5) + bxor_upvr(var229, rrotate_upvr_result1_3, var227) + 1859775393 + var212[i_19] + var226, 5) + band_upvr(var230, rrotate_upvr_result1) + band_upvr(var232, bxor_upvr(var230, rrotate_upvr_result1)) + 2400959708 + var212[i_20] + var227, 5) + bxor_upvr(var235, rrotate_upvr_result1_2, var233) + 3395469782 + var212[i_21] + var230 + var217) % 4294967296
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    end
    arg1[1] = var217
    arg1[2] = (lrotate_upvr(lrotate_upvr(var219, 5) + bxor_upvr(var229, rrotate_upvr_result1_3, var227) + 1859775393 + var212[i_19] + var226, 5) + band_upvr(var230, rrotate_upvr_result1) + band_upvr(var232, bxor_upvr(var230, rrotate_upvr_result1)) + 2400959708 + var212[i_20] + var227 + _2_4) % 4294967296
    arg1[3] = (rrotate_upvr(var235, 2) + _3) % 4294967296
    arg1[4] = (rrotate_upvr_result1_2 + _4_3) % 4294967296
    arg1[5] = (var233 + _5_2) % 4294967296
end
local tbl_upvr_4 = {}
local tbl_2_upvr = {}
local function _(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 401, Named "keccak_feed"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var250 = tbl_upvr_4
    local var251 = tbl_2_upvr
    for i_22 = arg4, arg4 + arg5 - 1, arg6 do
        local var252 = i_22
        local var253
        for i_23 = 1, var253 do
            local string_byte_result1_6, string_byte_result2_2, string_byte_result3, string_byte_result4_3 = string.byte(arg3, var252 + 1, var252 + 4)
            arg1[i_23] = bxor_upvr(arg1[i_23], ((string_byte_result4_3 * 256 + string_byte_result3) * 256 + string_byte_result2_2) * 256 + string_byte_result1_6)
            var252 += 8
            local string_byte_result1_4, string_byte_result2_4, string_byte_result3_4, string_byte_result4 = string.byte(arg3, var252 - 3, var252)
            arg2[i_23] = bxor_upvr(arg2[i_23], ((string_byte_result4 * 256 + string_byte_result3_4) * 256 + string_byte_result2_4) * 256 + string_byte_result1_4)
        end
        var253 = arg1[1]
        local _1 = arg2[1]
        local _2_3 = arg1[2]
        local _2_2 = arg2[2]
        local _3_2 = arg1[3]
        local _3_6 = arg2[3]
        local _4_4 = arg1[4]
        local _4 = arg2[4]
        local _5_5 = arg1[5]
        local _5_4 = arg2[5]
        local _6_4 = arg1[6]
        local _6_2 = arg2[6]
        local _7_4 = arg1[7]
        local _7_2 = arg2[7]
        local _8_5 = arg1[8]
        local _8_2 = arg2[8]
        local _9_2 = arg1[9]
        local _9 = arg2[9]
        local _10 = arg1[10]
        local _10_2 = arg2[10]
        local _11_2 = arg1[11]
        local _11 = arg2[11]
        local _12 = arg1[12]
        local _12_2 = arg2[12]
        local _13 = arg1[13]
        local _13_2 = arg2[13]
        local _14 = arg1[14]
        local _14_2 = arg2[14]
        local _15_2 = arg1[15]
        local _15 = arg2[15]
        local _16_2 = arg1[16]
        local _16 = arg2[16]
        local _17 = arg1[17]
        local _17_2 = arg2[17]
        local _18 = arg1[18]
        local _18_2 = arg2[18]
        local _19 = arg1[19]
        local _19_2 = arg2[19]
        local _20_2 = arg1[20]
        local _20 = arg2[20]
        local _21 = arg1[21]
        local _21_2 = arg2[21]
        local _22_2 = arg1[22]
        local _22 = arg2[22]
        local _23_2 = arg1[23]
        local _23 = arg2[23]
        local _24 = arg1[24]
        local _24_2 = arg2[24]
        local _25 = arg1[25]
        local _25_2 = arg2[25]
        for i_24 = 1, 24 do
            local var2_result1_30 = bxor_upvr(var253, _6_4, _11_2, _16_2, _21)
            local var2_result1_5 = bxor_upvr(_1, _6_2, _11, _16, _21_2)
            local var2_result1_32 = bxor_upvr(_2_3, _7_4, _12, _17, _22_2)
            local var2_result1_60 = bxor_upvr(_2_2, _7_2, _12_2, _17_2, _22)
            local var2_result1_10 = bxor_upvr(_3_2, _8_5, _13, _18, _23_2)
            local var2_result1_6 = bxor_upvr(_3_6, _8_2, _13_2, _18_2, _23)
            local var2_result1_59 = bxor_upvr(_4_4, _9_2, _14, _19, _24)
            local var2_result1_44 = bxor_upvr(_4, _9, _14_2, _19_2, _24_2)
            local var2_result1_57 = bxor_upvr(_5_5, _10, _15_2, _20_2, _25)
            local var2_result1_50 = bxor_upvr(_5_4, _10_2, _15, _20, _25_2)
            local bxor_upvr_result1_8 = bxor_upvr(var2_result1_30, var2_result1_10 * 2 + (var2_result1_6 % 4294967296 - var2_result1_6 % 2147483648) / 2147483648)
            local var2_result1_54 = bxor_upvr(var2_result1_5, var2_result1_6 * 2 + (var2_result1_10 % 4294967296 - var2_result1_10 % 2147483648) / 2147483648)
            local bxor_upvr_result1_6 = bxor_upvr(bxor_upvr_result1_8, _2_3)
            local var2_result1_53 = bxor_upvr(var2_result1_54, _2_2)
            local var2_result1 = bxor_upvr(bxor_upvr_result1_8, _7_4)
            local var2_result1_52 = bxor_upvr(var2_result1_54, _7_2)
            local bxor_upvr_result1_4 = bxor_upvr(bxor_upvr_result1_8, _12)
            local var2_result1_8 = bxor_upvr(var2_result1_54, _12_2)
            local var2_result1_56 = bxor_upvr(bxor_upvr_result1_8, _17)
            local var2_result1_51 = bxor_upvr(var2_result1_54, _17_2)
            local bxor_upvr_result1 = bxor_upvr(bxor_upvr_result1_8, _22_2)
            local var2_result1_49 = bxor_upvr(var2_result1_54, _22)
            local var333 = (var2_result1 % 4294967296 - var2_result1 % 1048576) / 1048576 + var2_result1_52 * 4096
            local var334 = (var2_result1_52 % 4294967296 - var2_result1_52 % 1048576) / 1048576 + var2_result1 * 4096
            local var335 = (var2_result1_56 % 4294967296 - var2_result1_56 % 524288) / 524288 + var2_result1_51 * 8192
            local var336 = (var2_result1_51 % 4294967296 - var2_result1_51 % 524288) / 524288 + var2_result1_56 * 8192
            local var337 = bxor_upvr_result1_6 * 2 + (var2_result1_53 % 4294967296 - var2_result1_53 % 2147483648) / 2147483648
            local var338 = var2_result1_53 * 2 + (bxor_upvr_result1_6 % 4294967296 - bxor_upvr_result1_6 % 2147483648) / 2147483648
            local var339 = bxor_upvr_result1_4 * 1024 + (var2_result1_8 % 4294967296 - var2_result1_8 % 4194304) / 4194304
            local var340 = var2_result1_8 * 1024 + (bxor_upvr_result1_4 % 4294967296 - bxor_upvr_result1_4 % 4194304) / 4194304
            local var341 = bxor_upvr_result1 * 4 + (var2_result1_49 % 4294967296 - var2_result1_49 % 1073741824) / 1073741824
            local var342 = var2_result1_49 * 4 + (bxor_upvr_result1 % 4294967296 - bxor_upvr_result1 % 1073741824) / 1073741824
            local var2_result1_18 = bxor_upvr(var2_result1_32, var2_result1_59 * 2 + (var2_result1_44 % 4294967296 - var2_result1_44 % 2147483648) / 2147483648)
            local var2_result1_46 = bxor_upvr(var2_result1_60, var2_result1_44 * 2 + (var2_result1_59 % 4294967296 - var2_result1_59 % 2147483648) / 2147483648)
            local bxor_upvr_result1_3 = bxor_upvr(var2_result1_18, _3_2)
            local var2_result1_4 = bxor_upvr(var2_result1_46, _3_6)
            local var2_result1_45 = bxor_upvr(var2_result1_18, _8_5)
            local var2_result1_58 = bxor_upvr(var2_result1_46, _8_2)
            local var2_result1_9 = bxor_upvr(var2_result1_18, _13)
            local var2_result1_41 = bxor_upvr(var2_result1_46, _13_2)
            local var2_result1_43 = bxor_upvr(var2_result1_18, _18)
            local var2_result1_42 = bxor_upvr(var2_result1_46, _18_2)
            local var2_result1_48 = bxor_upvr(var2_result1_18, _23_2)
            local var2_result1_39 = bxor_upvr(var2_result1_46, _23)
            local var355 = (var2_result1_9 % 4294967296 - var2_result1_9 % 2097152) / 2097152 + var2_result1_41 * 2048
            local var356 = (var2_result1_41 % 4294967296 - var2_result1_41 % 2097152) / 2097152 + var2_result1_9 * 2048
            local var357 = (var2_result1_48 % 4294967296 - var2_result1_48 % 8) / 8 + var2_result1_39 * 536870912 % 4294967296
            local var358 = (var2_result1_39 % 4294967296 - var2_result1_39 % 8) / 8 + var2_result1_48 * 536870912 % 4294967296
            local var359 = var2_result1_45 * 64 + (var2_result1_58 % 4294967296 - var2_result1_58 % 67108864) / 67108864
            local var360 = var2_result1_58 * 64 + (var2_result1_45 % 4294967296 - var2_result1_45 % 67108864) / 67108864
            local var361 = var2_result1_43 * 32768 + (var2_result1_42 % 4294967296 - var2_result1_42 % 131072) / 131072
            local var362 = var2_result1_42 * 32768 + (var2_result1_43 % 4294967296 - var2_result1_43 % 131072) / 131072
            local var363 = (bxor_upvr_result1_3 % 4294967296 - bxor_upvr_result1_3 % 4) / 4 + var2_result1_4 * 1073741824 % 4294967296
            local var364 = (var2_result1_4 % 4294967296 - var2_result1_4 % 4) / 4 + bxor_upvr_result1_3 * 1073741824 % 4294967296
            local var2_result1_38 = bxor_upvr(var2_result1_10, var2_result1_57 * 2 + (var2_result1_50 % 4294967296 - var2_result1_50 % 2147483648) / 2147483648)
            local var2_result1_37 = bxor_upvr(var2_result1_6, var2_result1_50 * 2 + (var2_result1_57 % 4294967296 - var2_result1_57 % 2147483648) / 2147483648)
            local var2_result1_36 = bxor_upvr(var2_result1_38, _4_4)
            local var2_result1_3 = bxor_upvr(var2_result1_37, _4)
            local var2_result1_35 = bxor_upvr(var2_result1_38, _9_2)
            local var2_result1_26 = bxor_upvr(var2_result1_37, _9)
            local var2_result1_40 = bxor_upvr(var2_result1_38, _14)
            local var2_result1_13 = bxor_upvr(var2_result1_37, _14_2)
            local var2_result1_34 = bxor_upvr(var2_result1_38, _19)
            local var2_result1_22 = bxor_upvr(var2_result1_37, _19_2)
            local bxor_upvr_result1_9 = bxor_upvr(var2_result1_38, _24)
            local var2_result1_31 = bxor_upvr(var2_result1_37, _24_2)
            local var377 = var2_result1_34 * 2097152 % 4294967296 + (var2_result1_22 % 4294967296 - var2_result1_22 % 2048) / 2048
            local var378 = var2_result1_22 * 2097152 % 4294967296 + (var2_result1_34 % 4294967296 - var2_result1_34 % 2048) / 2048
            local var379 = var2_result1_36 * 268435456 % 4294967296 + (var2_result1_3 % 4294967296 - var2_result1_3 % 16) / 16
            local var380 = var2_result1_3 * 268435456 % 4294967296 + (var2_result1_36 % 4294967296 - var2_result1_36 % 16) / 16
            local var381 = var2_result1_40 * 33554432 % 4294967296 + (var2_result1_13 % 4294967296 - var2_result1_13 % 128) / 128
            local var382 = var2_result1_13 * 33554432 % 4294967296 + (var2_result1_40 % 4294967296 - var2_result1_40 % 128) / 128
            local var383 = (bxor_upvr_result1_9 % 4294967296 - bxor_upvr_result1_9 % 256) / 256 + var2_result1_31 * 16777216 % 4294967296
            local var384 = (var2_result1_31 % 4294967296 - var2_result1_31 % 256) / 256 + bxor_upvr_result1_9 * 16777216 % 4294967296
            local var385 = (var2_result1_35 % 4294967296 - var2_result1_35 % 512) / 512 + var2_result1_26 * 8388608 % 4294967296
            local var386 = (var2_result1_26 % 4294967296 - var2_result1_26 % 512) / 512 + var2_result1_35 * 8388608 % 4294967296
            local var2_result1_16 = bxor_upvr(var2_result1_59, var2_result1_30 * 2 + (var2_result1_5 % 4294967296 - var2_result1_5 % 2147483648) / 2147483648)
            local bxor_upvr_result1_7 = bxor_upvr(var2_result1_44, var2_result1_5 * 2 + (var2_result1_30 % 4294967296 - var2_result1_30 % 2147483648) / 2147483648)
            local var2_result1_28 = bxor_upvr(var2_result1_16, _5_5)
            local var2_result1_20 = bxor_upvr(bxor_upvr_result1_7, _5_4)
            local var2_result1_27 = bxor_upvr(var2_result1_16, _10)
            local bxor_upvr_result1_2 = bxor_upvr(bxor_upvr_result1_7, _10_2)
            local var2_result1_25 = bxor_upvr(var2_result1_16, _15_2)
            local var2_result1_24 = bxor_upvr(bxor_upvr_result1_7, _15)
            local var2_result1_23 = bxor_upvr(var2_result1_16, _20_2)
            local var2_result1_33 = bxor_upvr(bxor_upvr_result1_7, _20)
            local var2_result1_14 = bxor_upvr(var2_result1_16, _25)
            local var2_result1_11 = bxor_upvr(bxor_upvr_result1_7, _25_2)
            local var399 = var2_result1_14 * 16384 + (var2_result1_11 % 4294967296 - var2_result1_11 % 262144) / 262144
            local var400 = var2_result1_11 * 16384 + (var2_result1_14 % 4294967296 - var2_result1_14 % 262144) / 262144
            local var401 = var2_result1_27 * 1048576 % 4294967296 + (bxor_upvr_result1_2 % 4294967296 - bxor_upvr_result1_2 % 4096) / 4096
            local var402 = bxor_upvr_result1_2 * 1048576 % 4294967296 + (var2_result1_27 % 4294967296 - var2_result1_27 % 4096) / 4096
            local var403 = var2_result1_23 * 256 + (var2_result1_33 % 4294967296 - var2_result1_33 % 16777216) / 16777216
            local var404 = var2_result1_33 * 256 + (var2_result1_23 % 4294967296 - var2_result1_23 % 16777216) / 16777216
            local var405 = var2_result1_28 * 134217728 % 4294967296 + (var2_result1_20 % 4294967296 - var2_result1_20 % 32) / 32
            local var406 = var2_result1_20 * 134217728 % 4294967296 + (var2_result1_28 % 4294967296 - var2_result1_28 % 32) / 32
            local var407 = (var2_result1_25 % 4294967296 - var2_result1_25 % 33554432) / 33554432 + var2_result1_24 * 128
            local var408 = (var2_result1_24 % 4294967296 - var2_result1_24 % 33554432) / 33554432 + var2_result1_25 * 128
            local var2_result1_21 = bxor_upvr(var2_result1_57, var2_result1_32 * 2 + (var2_result1_60 % 4294967296 - var2_result1_60 % 2147483648) / 2147483648)
            local var2_result1_2 = bxor_upvr(var2_result1_50, var2_result1_60 * 2 + (var2_result1_32 % 4294967296 - var2_result1_32 % 2147483648) / 2147483648)
            local var2_result1_19 = bxor_upvr(var2_result1_21, _6_4)
            local var2_result1_55 = bxor_upvr(var2_result1_2, _6_2)
            local var2_result1_47 = bxor_upvr(var2_result1_21, _11_2)
            local var2_result1_7 = bxor_upvr(var2_result1_2, _11)
            local var2_result1_17 = bxor_upvr(var2_result1_21, _16_2)
            local bxor_upvr_result1_5 = bxor_upvr(var2_result1_2, _16)
            local var2_result1_29 = bxor_upvr(var2_result1_21, _21)
            local var2_result1_15 = bxor_upvr(var2_result1_2, _21_2)
            local var419 = var2_result1_47 * 8 + (var2_result1_7 % 4294967296 - var2_result1_7 % 536870912) / 536870912
            local var420 = var2_result1_7 * 8 + (var2_result1_47 % 4294967296 - var2_result1_47 % 536870912) / 536870912
            local var421 = var2_result1_29 * 262144 + (var2_result1_15 % 4294967296 - var2_result1_15 % 16384) / 16384
            local var422 = var2_result1_15 * 262144 + (var2_result1_29 % 4294967296 - var2_result1_29 % 16384) / 16384
            local var423 = (var2_result1_19 % 4294967296 - var2_result1_19 % 268435456) / 268435456 + var2_result1_55 * 16
            local var424 = (var2_result1_55 % 4294967296 - var2_result1_55 % 268435456) / 268435456 + var2_result1_19 * 16
            local var425 = (var2_result1_17 % 4294967296 - var2_result1_17 % 8388608) / 8388608 + bxor_upvr_result1_5 * 512
            local var426 = (bxor_upvr_result1_5 % 4294967296 - bxor_upvr_result1_5 % 8388608) / 8388608 + var2_result1_17 * 512
            var253 = bxor_upvr(var2_result1_21, var253)
            local var2_result1_12 = bxor_upvr(var2_result1_2, _1)
            var253 = bxor_upvr(var253, band_upvr(-1 - var333, var355))
            var253 = bxor_upvr(var253, var250[i_24])
        end
        arg1[1] = var253
        arg2[1] = bxor_upvr(var2_result1_12, band_upvr(-1 - var334, var356)) + var251[i_24]
        arg1[2] = bxor_upvr(var333, band_upvr(-1 - var355, var377))
        arg2[2] = bxor_upvr(var334, band_upvr(-1 - var356, var378))
        arg1[3] = bxor_upvr(var355, band_upvr(-1 - var377, var399))
        arg2[3] = bxor_upvr(var356, band_upvr(-1 - var378, var400))
        arg1[4] = bxor_upvr(var377, band_upvr(-1 - var399, var253))
        arg2[4] = bxor_upvr(var378, band_upvr(-1 - var400, var2_result1_12))
        arg1[5] = bxor_upvr(var399, band_upvr(-1 - var253, var333))
        arg2[5] = bxor_upvr(var400, band_upvr(-1 - var2_result1_12, var334))
        arg1[6] = bxor_upvr(var379, band_upvr(-1 - var401, var419))
        arg2[6] = bxor_upvr(var380, band_upvr(-1 - var402, var420))
        arg1[7] = bxor_upvr(var401, band_upvr(-1 - var419, var335))
        arg2[7] = bxor_upvr(var402, band_upvr(-1 - var420, var336))
        arg1[8] = bxor_upvr(var419, band_upvr(-1 - var335, var357))
        arg2[8] = bxor_upvr(var420, band_upvr(-1 - var336, var358))
        arg1[9] = bxor_upvr(var335, band_upvr(-1 - var357, var379))
        arg2[9] = bxor_upvr(var336, band_upvr(-1 - var358, var380))
        arg1[10] = bxor_upvr(var357, band_upvr(-1 - var379, var401))
        arg2[10] = bxor_upvr(var358, band_upvr(-1 - var380, var402))
        arg1[11] = bxor_upvr(var337, band_upvr(-1 - var359, var381))
        arg2[11] = bxor_upvr(var338, band_upvr(-1 - var360, var382))
        arg1[12] = bxor_upvr(var359, band_upvr(-1 - var381, var403))
        arg2[12] = bxor_upvr(var360, band_upvr(-1 - var382, var404))
        arg1[13] = bxor_upvr(var381, band_upvr(-1 - var403, var421))
        arg2[13] = bxor_upvr(var382, band_upvr(-1 - var404, var422))
        arg1[14] = bxor_upvr(var403, band_upvr(-1 - var421, var337))
        arg2[14] = bxor_upvr(var404, band_upvr(-1 - var422, var338))
        arg1[15] = bxor_upvr(var421, band_upvr(-1 - var337, var359))
        arg2[15] = bxor_upvr(var422, band_upvr(-1 - var338, var360))
        arg1[16] = bxor_upvr(var405, band_upvr(-1 - var423, var339))
        arg2[16] = bxor_upvr(var406, band_upvr(-1 - var424, var340))
        arg1[17] = bxor_upvr(var423, band_upvr(-1 - var339, var361))
        arg2[17] = bxor_upvr(var424, band_upvr(-1 - var340, var362))
        arg1[18] = bxor_upvr(var339, band_upvr(-1 - var361, var383))
        arg2[18] = bxor_upvr(var340, band_upvr(-1 - var362, var384))
        arg1[19] = bxor_upvr(var361, band_upvr(-1 - var383, var405))
        arg2[19] = bxor_upvr(var362, band_upvr(-1 - var384, var406))
        arg1[20] = bxor_upvr(var383, band_upvr(-1 - var405, var423))
        arg2[20] = bxor_upvr(var384, band_upvr(-1 - var406, var424))
        arg1[21] = bxor_upvr(var363, band_upvr(-1 - var385, var407))
        arg2[21] = bxor_upvr(var364, band_upvr(-1 - var386, var408))
        arg1[22] = bxor_upvr(var385, band_upvr(-1 - var407, var425))
        arg2[22] = bxor_upvr(var386, band_upvr(-1 - var408, var426))
        arg1[23] = bxor_upvr(var407, band_upvr(-1 - var425, var341))
        arg2[23] = bxor_upvr(var408, band_upvr(-1 - var426, var342))
        arg1[24] = bxor_upvr(var425, band_upvr(-1 - var341, var363))
        arg2[24] = bxor_upvr(var426, band_upvr(-1 - var342, var364))
        arg1[25] = bxor_upvr(var341, band_upvr(-1 - var363, var385))
        arg2[25] = bxor_upvr(var342, band_upvr(-1 - var364, var386))
    end
end
local function _(arg1, arg2, arg3, arg4) -- Line 628, Named "mul"
    local table_create_result1 = table.create(arg4)
    local var433 = 0
    local var435
    for i_25 = 1, arg4 do
        for i_26 = math.max(1, i_25 + 1 - #arg2), math.min(i_25, #arg1) do
            var433 += arg3 * arg1[i_26] * arg2[i_25 + 1 - i_26]
        end
        local var436 = var433 % 16777216
        table_create_result1[i_25] = math.floor(var436)
        var433 = (var433 - var436) / 16777216
        var435 += var436 * 1
    end
    return table_create_result1, var435
end
local _ = {4, 1, 2, -2, 2}
local _ = 4
;({})[1] = 1
-- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
-- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
if 79 < 0 then
    -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
end
-- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
-- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
-- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.