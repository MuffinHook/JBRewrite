local module = {}
local function _(arg1, arg2) -- Line 10, Named "int_from_uint"
    local var2 = 2 ^ arg1
    local var3 = arg2 % var2
    if var2 / 2 <= var3 then
        return var3 - var2
    end
    return var3
end
local function _(arg1, arg2) -- Line 19, Named "int_to_uint"
    return arg2 % 2 ^ arg1
end
local function _(arg1) -- Line 23, Named "float32_to_uint"
    return string.unpack("<I4", string.pack("<f", arg1))
end
local function _(arg1) -- Line 27, Named "float32_from_uint"
    return string.unpack("<f", string.pack("<I4", arg1))
end
local function _(arg1) -- Line 31, Named "float64_to_uint"
    return string.unpack("<I8", string.pack("<d", arg1))
end
local function _(arg1) -- Line 35, Named "float64_from_uint"
    return string.unpack("<d", string.pack("<I8", arg1))
end
local function _(arg1, arg2, arg3) -- Line 39, Named "float_to_fixed"
    local var4 = 2 ^ (arg1 + arg2)
    local var5 = math.floor(arg3 * 2 ^ arg2) % var4
    if var4 / 2 <= var5 then
        return var5 - var4
    end
    return var5
end
local function _(arg1, arg2, arg3) -- Line 43, Named "float_from_fixed"
    local var6 = 2 ^ (arg1 + arg2)
    local var7 = arg3 % var6
    local var8
    if var6 / 2 <= var7 then
        var8 = var7 - var6
    else
        var8 = var7
    end
    var8 = 2 ^ (-arg2)
    return math.floor(var8) * var8
end
local function _(arg1, arg2, arg3) -- Line 47, Named "float_to_ufixed"
    return math.floor(arg3 * 2 ^ arg2) % 2 ^ (arg1 + arg2)
end
local function _(arg1, arg2, arg3) -- Line 51, Named "float_from_ufixed"
    return math.floor(arg3 % 2 ^ (arg1 + arg2)) * 2 ^ (-arg2)
end
local tbl_upvr = {
    __index = {};
}
function module.new(arg1) -- Line 72
    local var10 = true
    if arg1 ~= nil then
        if type(arg1) ~= "number" then
            var10 = false
        else
            var10 = true
        end
    end
    assert(var10, "number expected")
    local var11 = arg1 or 0
    return setmetatable({
        buf = table.create(math.ceil(var11 / 32), 0);
        len = var11;
        i = 0;
    }, tbl_upvr)
end
function module.fromString(arg1) -- Line 87
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var21
    if type(arg1) ~= "string" then
        var21 = false
    else
        var21 = true
    end
    assert(var21, "string expected")
    var21 = #arg1 / 4
    local ceiled = math.ceil(var21)
    var21 = {}
    var21.buf = table.create(ceiled, 0)
    var21.len = #arg1 * 8
    var21.i = 0
    for i = 0, math.floor(#arg1 / 4) - 1 do
        local string_byte_result1, string_byte_result2, string_byte_result3, string_byte_result4 = string.byte(arg1, i * 4 + 1, i * 4 + 4)
        var21.buf[i + 1] = bit32.bor(string_byte_result1, string_byte_result2 * 256, string_byte_result3 * 65536, string_byte_result4 * 16777216)
    end
    for i_2 = 0, #arg1 % 4 - 1 do
        var21.buf[ceiled] = bit32.bor(var21.buf[ceiled], string.byte(arg1, (ceiled - 1) * 4 + i_2 + 1) * 256 ^ i_2)
    end
    return setmetatable(var21, tbl_upvr)
end
tbl_upvr.__index.String = function(arg1) -- Line 109, Named "String"
    local ceiled_2 = math.ceil(arg1.len / 32)
    local table_create_result1_2 = table.create(ceiled_2, "")
    for i_3 in ipairs(table_create_result1_2) do
        local var33 = arg1.buf[i_3]
        if var33 then
            table_create_result1_2[i_3] = string.pack("<I4", var33)
        else
            table_create_result1_2[i_3] = "\x00\x00\x00\x00"
        end
    end
    if 0 < arg1.len % 32 then
        i_3 = arg1.buf[ceiled_2]
        i_3 = bit32.lshift(1, arg1.len % 32) - 1
        i_3 = math.floor((arg1.len - 1) / 8) % 4
        i_3 = string.pack("<I"..(i_3 + 1), bit32.band(i_3 or 0, i_3))
        table_create_result1_2[ceiled_2] = i_3
    end
    return table.concat(table_create_result1_2)
end
tbl_upvr.__index.writeUnit = function(arg1, arg2, arg3) -- Line 137, Named "writeUnit"
    local var35 = false
    if 0 <= arg2 then
        if arg2 > 32 then
            var35 = false
        else
            var35 = true
        end
    end
    assert(var35, "size must be in range [0,32]")
    if arg2 == 0 then
    else
        local var36 = bit32.rshift(arg1.i, 5) + 1
        local var37 = arg1.i % 32
        if var37 == 0 and arg2 == 32 then
            arg1.buf[var36] = bit32.band(arg3, 4294967295)
        else
            local var38 = 32 - var37
            local var39 = arg2 - var38
            if var39 <= 0 then
                arg1.buf[var36] = bit32.replace(arg1.buf[var36] or 0, arg3, var37, arg2)
            else
                arg1.buf[var36] = bit32.replace(arg1.buf[var36] or 0, bit32.extract(arg3, 0, var38), var37, var38)
                arg1.buf[var36 + 1] = bit32.replace(arg1.buf[var36 + 1] or 0, bit32.extract(arg3, var38, var39), 0, var39)
            end
        end
        arg1.i += arg2
        if arg1.len < arg1.i then
            arg1.len = arg1.i
        end
    end
end
tbl_upvr.__index.readUnit = function(arg1, arg2) -- Line 174, Named "readUnit"
    local var40 = false
    if 0 <= arg2 then
        if arg2 > 32 then
            var40 = false
        else
            var40 = true
        end
    end
    assert(var40, "size must be in range [0,32]")
    if arg2 == 0 then
        return 0
    end
    local var41 = bit32.rshift(arg1.i, 5) + 1
    local var42 = arg1.i % 32
    arg1.i += arg2
    if arg1.len < arg1.i then
        arg1.len = arg1.i
    end
    if var42 == 0 and arg2 == 32 then
        return arg1.buf[var41] or 0
    end
    local var43 = 32 - var42
    local var44 = var43 - arg2
    if 0 <= var44 then
        return bit32.extract(arg1.buf[var41] or 0, var42, arg2)
    end
    return bit32.bor(bit32.extract(arg1.buf[var41] or 0, var42, var43), bit32.lshift(bit32.extract(arg1.buf[var41 + 1] or 0, 0, -var44), var43))
end
tbl_upvr.__index.Len = function(arg1) -- Line 199, Named "Len"
    return arg1.len
end
tbl_upvr.__index.SetLen = function(arg1, arg2) -- Line 208, Named "SetLen"
    local var47
    if var47 < 0 then
        var47 = 0
    end
    if var47 < arg1.len then
        local var48 = math.floor(var47 / 32) + 1
        if var47 % 32 == 0 then
            arg1.buf[var48] = nil
        else
            arg1.buf[var48] = bit32.band(arg1.buf[var48], 2 ^ (var47 % 32) - 1)
        end
        for i_4 = var48 + 1, math.floor((arg1.len - 1) / 32) + 1 do
            arg1.buf[i_4] = nil
        end
    end
    arg1.len = var47
    if var47 < arg1.i then
        arg1.i = var47
    end
end
tbl_upvr.__index.Index = function(arg1) -- Line 236, Named "Index"
    return arg1.i
end
tbl_upvr.__index.SetIndex = function(arg1, arg2) -- Line 244, Named "SetIndex"
    local var49
    if var49 < 0 then
        var49 = 0
    end
    arg1.i = var49
    if arg1.len < var49 then
        arg1.len = var49
    end
end
tbl_upvr.__index.Fits = function(arg1, arg2) -- Line 258, Named "Fits"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var50
    if type(arg2) ~= "number" then
        var50 = false
    else
        var50 = true
    end
    assert(var50, "number expected")
    var50 = arg1.len - arg1.i
    if arg2 > var50 then
    else
    end
    return true
end
local function _(arg1, arg2) -- Line 263, Named "readPad"
    arg1.i += arg2
    if arg1.len < arg1.i then
        arg1.len = arg1.i
    end
end
local function writePad_upvr(arg1, arg2) -- Line 270, Named "writePad"
    for _ = 1, math.floor(arg2 / 32) do
        arg1:writeUnit(32, 0)
    end
    arg1:writeUnit(arg2 % 32, 0)
end
tbl_upvr.__index.WritePad = function(arg1, arg2) -- Line 281, Named "WritePad"
    local var52
    if type(arg2) ~= "number" then
        var52 = false
    else
        var52 = true
    end
    assert(var52, "number expected")
    if arg2 <= 0 then
    else
        var52 = arg1
        writePad_upvr(var52, arg2)
    end
end
tbl_upvr.__index.ReadPad = function(arg1, arg2) -- Line 293, Named "ReadPad"
    local var53
    if type(arg2) ~= "number" then
        var53 = false
    else
        var53 = true
    end
    assert(var53, "number expected")
    if arg2 <= 0 then
    else
        var53 = arg1.i
        arg1.i = var53 + arg2
        var53 = arg1.len
        if var53 < arg1.i then
            arg1.len = arg1.i
        end
    end
end
tbl_upvr.__index.WriteAlign = function(arg1, arg2) -- Line 306, Named "WriteAlign"
    local var54
    if type(arg2) ~= "number" then
        var54 = false
    else
        var54 = true
    end
    assert(var54, "number expected")
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var54 = arg1.i
        return var54 % arg2 == 0
    end
    if arg2 <= 1 or decompInlinedCondition() then
    else
        var54 = math.ceil(arg1.i / arg2) * arg2 - arg1.i
        var54 = arg1
        writePad_upvr(var54, math.floor(var54))
    end
end
tbl_upvr.__index.ReadAlign = function(arg1, arg2) -- Line 319, Named "ReadAlign"
    local var55
    if type(arg2) ~= "number" then
        var55 = false
    else
        var55 = true
    end
    assert(var55, "number expected")
    local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var55 = arg1.i
        return var55 % arg2 == 0
    end
    if arg2 <= 1 or decompInlinedCondition_2() then
    else
        var55 = math.ceil(arg1.i / arg2) * arg2 - arg1.i
        var55 = arg1.i + math.floor(var55)
        arg1.i = var55
        var55 = arg1.i
        if arg1.len < var55 then
            var55 = arg1.i
            arg1.len = var55
        end
    end
end
tbl_upvr.__index.Reset = function(arg1) -- Line 331, Named "Reset"
    arg1.i = 0
    arg1.len = 0
    table.clear(arg1.buf)
end
local function fastWriteBytes_upvr(arg1, arg2) -- Line 340, Named "fastWriteBytes"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    if #arg2 <= 4 then
        arg1:writeUnit(#arg2 * 8, string.unpack("<I"..(#arg2), arg2))
    else
        local floored = math.floor(3 - (arg1.i / 8 - 1) % 4)
        if 0 < floored then
            arg1:writeUnit(floored * 8, string.unpack("<I"..floored, arg2))
        end
        local floored_4 = math.floor((#arg2 - floored) / 4)
        for i_8 = 0, floored_4 - 1 do
            arg1.buf[bit32.rshift(arg1.i, 5) + 1 + i_8] = string.unpack("<I4", arg2, floored + i_8 * 4 + 1)
            local _
        end
        arg1.i += floored_4 * 32
        if arg1.len < arg1.i then
            arg1.len = arg1.i
        end
        local var63 = (#arg2 - floored) % 4
        if 0 < var63 then
            arg1:writeUnit(var63 * 8, string.unpack("<I"..var63, arg2, #arg2 - var63 + 1))
        end
    end
end
tbl_upvr.__index.WriteBytes = function(arg1, arg2) -- Line 373, Named "WriteBytes"
    local var66
    if type(arg2) ~= "string" then
        var66 = false
    else
        var66 = true
    end
    assert(var66, "string expected")
    if arg2 == "" then
    else
        var66 = arg1.i
        if var66 % 8 == 0 then
            var66 = arg1
            fastWriteBytes_upvr(var66, arg2)
            return
        end
        var66 = 1
        for i_9 = 1, #arg2, var66 do
            arg1:writeUnit(8, string.byte(arg2, i_9))
        end
    end
end
local function fastReadBytes_upvr(arg1, arg2) -- Line 390, Named "fastReadBytes"
    local var69
    if arg2 <= 4 then
        var69 = arg2
        return string.pack("<I"..var69, arg1:readUnit(arg2 * 8))
    end
    var69 = arg1.i / 8 - 1
    local floored_3 = math.floor(3 - var69 % 4)
    local var71 = (arg2 - floored_3) % 4
    var69 = (arg2 - floored_3) / 4 + var71
    local table_create_result1 = table.create(var69, nil)
    var69 = 1
    if 0 < floored_3 then
        table_create_result1[var69] = string.pack("<I"..floored_3, arg1:readUnit(floored_3 * 8))
        var69 += 1
    end
    local floored_2 = math.floor((arg2 - floored_3) / 4)
    for i_6 = 0, floored_2 - 1 do
        local var74 = arg1.buf[bit32.rshift(arg1.i, 5) + 1 + i_6]
        if var74 then
            table_create_result1[var69] = string.pack("<I4", var74)
        else
            table_create_result1[var69] = "\x00\x00\x00\x00"
        end
        var69 += 1
    end
    arg1.i += floored_2 * 32
    if arg1.len < var69 then
        arg1.len = var69
    end
    if 0 < var71 then
        table_create_result1[var69] = string.pack("<I"..var71, arg1:readUnit(var71 * 8))
    end
    return table.concat(table_create_result1)
end
tbl_upvr.__index.ReadBytes = function(arg1, arg2) -- Line 434, Named "ReadBytes"
    local var77
    if type(arg2) ~= "number" then
        var77 = false
    else
        var77 = true
    end
    assert(var77, "number expected")
    if arg2 == 0 then
        return ""
    end
    var77 = arg1.i
    if var77 % 8 == 0 then
        var77 = arg1
        return fastReadBytes_upvr(var77, arg2)
    end
    var77 = arg2
    var77 = arg2
    for i_7 = 1, var77 do
        table.create(var77, "")[i_7] = string.char(arg1:readUnit(8))
        local var79
    end
    var77 = table.concat(var79)
    return var77
end
tbl_upvr.__index.WriteUint = function(arg1, arg2, arg3) -- Line 453, Named "WriteUint"
    local var80
    if type(arg2) ~= "number" then
        var80 = false
    else
        var80 = true
    end
    assert(var80, "number expected")
    if type(arg3) ~= "number" then
        var80 = false
    else
        var80 = true
    end
    assert(var80, "number expected")
    var80 = false
    if 0 <= arg2 then
        if arg2 > 53 then
            var80 = false
        else
            var80 = true
        end
    end
    assert(var80, "size must be in range [0,53]")
    if arg2 == 0 then
    else
        if arg2 <= 32 then
            arg1:writeUnit(arg2, arg3)
            return
        end
        var80 = 2
        local var81 = arg3 % var80 ^ arg2
        arg1:writeUnit(32, var81)
        arg1:writeUnit(arg2 - 32, math.floor(var81 / 4294967296))
    end
end
tbl_upvr.__index.ReadUint = function(arg1, arg2) -- Line 472, Named "ReadUint"
    local var82
    if type(arg2) ~= "number" then
        var82 = false
    else
        var82 = true
    end
    assert(var82, "number expected")
    var82 = false
    if 0 <= arg2 then
        if arg2 > 53 then
            var82 = false
        else
            var82 = true
        end
    end
    assert(var82, "size must be in range [0,53]")
    if arg2 == 0 then
        return 0
    end
    if arg2 <= 32 then
        return arg1:readUnit(arg2)
    end
    var82 = arg1:readUnit(32)
    return var82 + arg1:readUnit(arg2 - 32) * 4294967296
end
tbl_upvr.__index.WriteBool = function(arg1, arg2) -- Line 486, Named "WriteBool"
    if arg2 then
        arg1:writeUnit(1, 1)
    else
        arg1:writeUnit(1, 0)
    end
end
tbl_upvr.__index.ReadBool = function(arg1) -- Line 498, Named "ReadBool"
    local var83
    if arg1:readUnit(1) ~= 1 then
        var83 = false
    else
        var83 = true
    end
    return var83
end
tbl_upvr.__index.WriteByte = function(arg1, arg2) -- Line 505, Named "WriteByte"
    local var84
    if type(arg2) ~= "number" then
        var84 = false
    else
        var84 = true
    end
    assert(var84, "number expected")
    arg1:writeUnit(8, arg2)
end
tbl_upvr.__index.ReadByte = function(arg1) -- Line 513, Named "ReadByte"
    return arg1:readUnit(8)
end
tbl_upvr.__index.WriteInt = function(arg1, arg2, arg3) -- Line 521, Named "WriteInt"
    local var85
    if type(arg2) ~= "number" then
        var85 = false
    else
        var85 = true
    end
    assert(var85, "number expected")
    if type(arg3) ~= "number" then
        var85 = false
    else
        var85 = true
    end
    assert(var85, "number expected")
    var85 = false
    if 0 <= arg2 then
        if arg2 > 53 then
            var85 = false
        else
            var85 = true
        end
    end
    assert(var85, "size must be in range [0,53]")
    if arg2 == 0 then
    else
        var85 = 2 ^ arg2
        local var86 = arg3 % var85
        if arg2 <= 32 then
            arg1:writeUnit(arg2, var86)
            return
        end
        arg1:writeUnit(32, var86)
        arg1:writeUnit(arg2 - 32, math.floor(var86 / 4294967296))
    end
end
tbl_upvr.__index.ReadInt = function(arg1, arg2) -- Line 541, Named "ReadInt"
    local var87
    if type(arg2) ~= "number" then
        var87 = false
    else
        var87 = true
    end
    assert(var87, "number expected")
    var87 = false
    if 0 <= arg2 then
        if arg2 > 53 then
            var87 = false
        else
            var87 = true
        end
    end
    assert(var87, "size must be in range [0,53]")
    if arg2 == 0 then
        return 0
    end
    local var88
    var87 = 32
    if arg2 <= var87 then
        var87 = arg1:readUnit(arg2)
        var88 = var87
    else
        var87 = arg1:readUnit(32)
        var88 = var87 + arg1:readUnit(arg2 - 32) * 4294967296
    end
    local var89 = 2 ^ arg2
    local var90 = var88 % var89
    if var89 / 2 <= var90 then
        var87 = var90 - var89
        return var87
    end
    var87 = var90
    return var87
end
tbl_upvr.__index.WriteFloat = function(arg1, arg2, arg3) -- Line 563, Named "WriteFloat"
    local var91
    if type(arg2) ~= "number" then
        var91 = false
    else
        var91 = true
    end
    assert(var91, "number expected")
    if type(arg3) ~= "number" then
        var91 = false
    else
        var91 = true
    end
    assert(var91, "number expected")
    var91 = true
    if arg2 ~= 32 then
        if arg2 ~= 64 then
            var91 = false
        else
            var91 = true
        end
    end
    assert(var91, "size must be 32 or 64")
    if arg2 == 32 then
        arg1:WriteBytes(string.pack("<f", arg3))
    else
        arg1:WriteBytes(string.pack("<d", arg3))
    end
end
tbl_upvr.__index.ReadFloat = function(arg1, arg2) -- Line 581, Named "ReadFloat"
    local var92
    if type(arg2) ~= "number" then
        var92 = false
    else
        var92 = true
    end
    assert(var92, "number expected")
    var92 = true
    if arg2 ~= 32 then
        if arg2 ~= 64 then
            var92 = false
        else
            var92 = true
        end
    end
    assert(var92, "size must be 32 or 64")
    local any_ReadBytes_result1 = arg1:ReadBytes(arg2 / 8)
    if arg2 == 32 then
        var92 = string.unpack("<f", any_ReadBytes_result1)
        return var92
    end
    var92 = string.unpack("<d", any_ReadBytes_result1)
    return var92
end
tbl_upvr.__index.WriteUfixed = function(arg1, arg2, arg3, arg4) -- Line 598, Named "WriteUfixed"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var94
    if type(arg2) ~= "number" then
        var94 = false
    else
        var94 = true
    end
    assert(var94, "number expected")
    if type(arg3) ~= "number" then
        var94 = false
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    var94 = true
    assert(var94, "number expected")
    if 0 > arg2 then
        var94 = false
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
tbl_upvr.__index.ReadUfixed = function(arg1, arg2, arg3) -- Line 613, Named "ReadUfixed"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var95
    if type(arg2) ~= "number" then
        var95 = false
    else
        var95 = true
    end
    assert(var95, "number expected")
    if type(arg3) ~= "number" then
        var95 = false
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    var95 = true
    assert(var95, "number expected")
    if 0 > arg2 then
        var95 = false
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
tbl_upvr.__index.WriteFixed = function(arg1, arg2, arg3, arg4) -- Line 627, Named "WriteFixed"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var96
    if type(arg2) ~= "number" then
        var96 = false
    else
        var96 = true
    end
    assert(var96, "number expected")
    if type(arg3) ~= "number" then
        var96 = false
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    var96 = true
    assert(var96, "number expected")
    if 0 > arg2 then
        var96 = false
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
tbl_upvr.__index.ReadFixed = function(arg1, arg2, arg3) -- Line 642, Named "ReadFixed"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var97
    if type(arg2) ~= "number" then
        var97 = false
    else
        var97 = true
    end
    assert(var97, "number expected")
    if type(arg3) ~= "number" then
        var97 = false
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    var97 = true
    assert(var97, "number expected")
    if 0 > arg2 then
        var97 = false
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module.isBuffer(arg1) -- Line 654
    local var98
    if getmetatable(arg1) ~= tbl_upvr then
        var98 = false
    else
        var98 = true
    end
    return var98
end
return module