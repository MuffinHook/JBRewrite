local module = {}
local Bitbuf_upvr = require(script.Parent.Bitbuf)
local Base85_upvr = require(script.Parent.Base85)
local function isAxisAligned_upvr(arg1) -- Line 14, Named "isAxisAligned"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var9
    for i = 4, 12 do
        local absolute = math.abs(({arg1:GetComponents()})[i])
        if absolute == 1 then
        elseif absolute == 0 then
            var9 += 1
        end
    end
    local var11 = false
    if var9 == 6 then
        if 0 + 1 ~= 3 then
            var11 = false
        else
            var11 = true
        end
    end
    return var11
end
local function toNormalId_upvr(arg1) -- Line 32, Named "toNormalId"
    for _, v in ipairs(Enum.NormalId:GetEnumItems()) do
        if Vector3.FromNormalId(v):Dot(arg1) == 1 then
            return v.Value
        end
    end
    return -1
end
local function _(arg1) -- Line 45, Named "isLegalOrientId"
    local var17 = arg1 / 6
    if math.floor(var17) % 3 == arg1 % 3 then
        var17 = false
    else
        var17 = true
    end
    return var17
end
local function _(arg1) -- Line 52, Named "getOrientId"
    if not isAxisAligned_upvr(arg1) then
        return -1
    end
    local var18 = 6 * toNormalId_upvr(arg1.RightVector)
    local var19 = var18 + toNormalId_upvr(arg1.UpVector)
    if math.floor(var19 / 6) % 3 == var19 % 3 then
        var18 = false
    else
        var18 = true
    end
    if not var18 then
        return -1
    end
    return var19
end
local function encodeMatrix_upvr(arg1) -- Line 69, Named "encodeMatrix"
    local selected, NONE_3, NONE, NONE_2, NONE_7, NONE_8, NONE_5, NONE_6, NONE_4 = select(4, arg1:GetComponents())
    local var29 = selected + NONE_7 + NONE_4
    local var30
    local var31
    local var32
    local var33
    if 0 < var29 then
        local var34 = 2 * math.sqrt(1 + var29)
        var33 = var34 / 4
        var30 = (NONE_6 - NONE_8) / var34
        var31 = (NONE - NONE_5) / var34
        var32 = (NONE_2 - NONE_3) / var34
    elseif NONE_7 < selected and NONE_4 < selected then
        local var35 = var34 * math.sqrt(1 + selected - NONE_7 - NONE_4)
        var33 = (NONE_6 - NONE_8) / var35
        var30 = var35 / 4
        var31 = (NONE_2 + NONE_3) / var35
        var32 = (NONE + NONE_5) / var35
    elseif NONE_4 < NONE_7 then
        local var36 = var35 * math.sqrt(1 - selected + NONE_7 - NONE_4)
        var33 = (NONE - NONE_5) / var36
        var30 = (NONE_2 + NONE_3) / var36
        var31 = var36 / 4
        var32 = (NONE_6 + NONE_8) / var36
    else
        local var37 = var36 * math.sqrt(1 - selected - NONE_7 + NONE_4)
        var33 = (NONE_2 - NONE_3) / var37
        var30 = (NONE + NONE_5) / var37
        var31 = (NONE_6 + NONE_8) / var37
        var32 = var37 / 4
    end
    return {var30, var31, var32, var33}
end
function module.encode(arg1) -- Line 109
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local any_new_result1 = Bitbuf_upvr.new()
    local Position = arg1.Position
    any_new_result1:WriteFloat(32, Position.X)
    any_new_result1:WriteFloat(32, Position.Y)
    any_new_result1:WriteFloat(32, Position.Z)
    if not isAxisAligned_upvr(arg1) then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var41 = 6 * toNormalId_upvr(arg1.RightVector) + toNormalId_upvr(arg1.UpVector)
    if math.floor(var41 / 6) % 3 == var41 % 3 then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module.decode(arg1) -- Line 133
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local any_decode_result1, any_decode_result2 = Base85_upvr.decode(arg1)
    if any_decode_result1 then
        assert(any_decode_result1)
    end
    local any_fromString_result1 = Bitbuf_upvr.fromString(any_decode_result2)
    local any_ReadFloat_result1 = any_fromString_result1:ReadFloat(32)
    local any_ReadFloat_result1_3 = any_fromString_result1:ReadFloat(32)
    local any_ReadFloat_result1_2 = any_fromString_result1:ReadFloat(32)
    local any_ReadByte_result1 = any_fromString_result1:ReadByte()
    local var53 = 0
    if var53 < any_ReadByte_result1 then
        local var54 = any_ReadByte_result1 - 1
        local var55 = var54
        if math.floor(var55 / 6) % 3 == var55 % 3 then
            var53 = false
        else
            var53 = true
        end
        if var53 then
            var53 = Vector3.new(any_ReadFloat_result1, any_ReadFloat_result1_3, any_ReadFloat_result1_2)
            return CFrame.fromMatrix(var53, Vector3.FromNormalId(var54 / 6), Vector3.FromNormalId(var54 % 6))
        end
        var53 = CFrame.new(any_ReadFloat_result1, any_ReadFloat_result1_3, any_ReadFloat_result1_2)
        return var53
    end
    local any_ReadByte_result1_2 = any_fromString_result1:ReadByte()
    local table_create_result1 = table.create(any_ReadByte_result1_2)
    for i_3 = 1, any_ReadByte_result1_2 do
        table_create_result1[i_3] = any_fromString_result1:ReadFloat(32)
        local _
    end
    return CFrame.new(any_ReadFloat_result1, any_ReadFloat_result1_3, any_ReadFloat_result1_2, unpack(table_create_result1))
end
return module