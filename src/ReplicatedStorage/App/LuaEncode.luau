local table_2 = table
local string_2 = string
local next_upvr = next
local pcall_upvr = pcall
local game_upvr = game
local format_upvr = string_2.format
local match_upvr = string_2.match
local gmatch_upvr = string_2.gmatch
local concat_upvr = table_2.concat
local typeof_upvr = typeof
if not typeof_upvr then
    typeof_upvr = type
end
local tbl = {"and", "break", "do", "else", "elseif", "end", "false", "for", "function", "if", "in", "local", "nil", "not", "or", "repeat", "return", "then", "true", "until", "while", "continue"}
for _, v in next_upvr, tbl do
    setmetatable({}, {
        __mode = 'k';
    })[v] = true
    local var20_upvw
end
tbl = table_2.find
local var22_upvw = tbl
if not var22_upvw then
    local ipairs_upvr = ipairs
    function var22_upvw(arg1, arg2) -- Line 68
        for i_2, v_2 in ipairs_upvr(arg1) do
            if v_2 == arg2 then
                return i_2
            end
        end
    end
end
var22_upvw = table_2.clone
local var30_upvw = var22_upvw
if not var30_upvw then
    function var30_upvw(arg1) -- Line 80
        local module_2 = {}
        for i_3, v_3 in next_upvr, arg1 do
            module_2[i_3] = v_3
        end
        return module_2
    end
end
local function CheckType_upvr(arg1, arg2, ...) -- Line 92, Named "CheckType"
    local args_list = {...}
    local typeof_upvr_result1 = typeof_upvr(arg1)
    if not var22_upvw(args_list, typeof_upvr_result1) then
        error(format_upvr("LuaEncode: Incorrect type for `%s`: `%s` expected, got `%s`", arg2, concat_upvr(args_list, ", "), typeof_upvr_result1), 0)
    end
    return arg1
end
local module_3_upvr = {
    ['"'] = "\\\"";
    ['\\'] = "\\\\";
    ['\a'] = "\\a";
    ['\b'] = "\\b";
    ['\t'] = "\\t";
    ['\n'] = "\\n";
    ['\v'] = "\\v";
    ['\f'] = "\\f";
    ['\r'] = "\\r";
}
for i_4 = 0, 255 do
    local any_char_result1 = string_2.char(i_4)
    if not module_3_upvr[any_char_result1] and (i_4 < 32 or 126 < i_4) then
        module_3_upvr[any_char_result1] = '\\'..i_4
    end
end
local gsub_upvr = string_2.gsub
local function SerializeString_upvw(arg1) -- Line 139, Named "SerializeString"
    return '"'..gsub_upvr(arg1, "[%z\\\"\x01-\x1F\x7F-\xFF]", module_3_upvr)..'"'
end
function module_3_upvr(arg1) -- Line 147, Named "CommentBlock"
    local var46
    for i_5 in gmatch_upvr(arg1, "%](=*)%]") do
        if #var46 <= #i_5 then
            var46 = i_5..'='
        end
    end
    return "--["..var46..'['..arg1..']'..var46..']'
end
local function _(arg1) -- Line 163, Named "IsService"
    local pcall_upvr_result1_2, pcall_upvr_result2 = pcall_upvr(game_upvr.FindService, game_upvr, arg1.ClassName)
    if pcall_upvr_result1_2 and pcall_upvr_result2 then
        return true
    end
    return false
end
local workspace_upvr = workspace
local function EvaluateInstancePath_upvw(arg1, arg2) -- Line 175, Named "EvaluateInstancePath"
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local pcall_upvr_result1, pcall_upvr_result2_3 = pcall_upvr(game_upvr.FindService, game_upvr, arg1.ClassName)
    local var58
    if pcall_upvr_result1 and pcall_upvr_result2_3 then
        var58 = true
    else
        var58 = false
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local rep_upvr = string_2.rep
local sub_upvr = string_2.sub
local insert_upvr = table_2.insert
local huge_upvr = math.huge
local tostring_upvr = tostring
local tonumber_upvr = tonumber
local getmetatable_upvr = getmetatable
local function LuaEncode_upvr(arg1, arg2) -- Line 236, Named "LuaEncode"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    CheckType_upvr(arg1, "inputTable", "table")
    CheckType_upvr(arg2, "options", "table", "nil")
    local var66
    if arg2 then
        var66 = CheckType_upvr
        var66(arg2.Prettify, "options.Prettify", "boolean", "nil")
        var66 = CheckType_upvr
        var66(arg2.PrettyPrinting, "options.PrettyPrinting", "boolean", "nil")
        var66 = CheckType_upvr
        var66(arg2.IndentCount, "options.IndentCount", "number", "nil")
        var66 = CheckType_upvr
        var66(arg2.OutputWarnings, "options.OutputWarnings", "boolean", "nil")
        var66 = CheckType_upvr
        var66(arg2.StackLimit, "options.StackLimit", "number", "nil")
        var66 = CheckType_upvr
        var66(arg2.FunctionsReturnRaw, "options.FunctionsReturnRaw", "boolean", "nil")
        var66 = CheckType_upvr
        var66(arg2.UseInstancePaths, "options.UseInstancePaths", "boolean", "nil")
        var66 = CheckType_upvr
        var66(arg2._StackLevel, "options._StackLevel", "number", "nil")
        var66 = CheckType_upvr
        var66(arg2._VisitedTables, "options._StackLevel", "table", "nil")
    end
    var66 = arg2
    if not var66 then
        var66 = {}
    end
    local var67_upvw = var66
    if var67_upvw.Prettify ~= nil or var67_upvw.PrettyPrinting ~= nil then
    end
    if var67_upvw.Prettify == nil or not var67_upvw.Prettify or var67_upvw.PrettyPrinting then
    end
    local IndentCount_upvr = var67_upvw.IndentCount
    if not IndentCount_upvr then
        if var67_upvw.PrettyPrinting then
            IndentCount_upvr = 4
        else
            IndentCount_upvr = 0
        end
    end
    if var67_upvw.OutputWarnings == nil then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    local var69 = var67_upvw.StackLimit or 500
    if var67_upvw.FunctionsReturnRaw ~= nil then
    end
    if var67_upvw.UseInstancePaths == nil then
    else
    end
    local var70_upvr = var67_upvw._StackLevel or 1
    if not var67_upvw._VisitedTables then
        ({})[arg1] = true
    end
    if var69 <= var70_upvr then
        return "{--[[LuaEncode: Stack level limit of `"..var69.."` reached]]}"
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    if var67_upvw.PrettyPrinting then
    else
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    if var67_upvw.PrettyPrinting then
        local _ = ", "
    else
    end
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    if var67_upvw.PrettyPrinting then
    else
    end
    local rep_upvr_result1 = rep_upvr(' ', IndentCount_upvr)
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    if not var67_upvw.PrettyPrinting or not rep_upvr(rep_upvr_result1, var70_upvr) then
    end
    local var73 = rep_upvr_result1
    if 0 >= #var73 or not sub_upvr(var73, 1, -IndentCount_upvr - 1) then
    end
    local tbl_3_upvr = {}
    local function _(arg1_2, arg2_2) -- Line 301, Named "TypeCase"
        return tbl_3_upvr[arg1_2](arg2_2, false)
    end
    local const_string_upvr_2 = ','
    local function Args_upvr(...) -- Line 308, Named "Args"
        local module_4 = {}
        for _, v_4 in next_upvr, {...} do
            insert_upvr(module_4, tbl_3_upvr[typeof_upvr(v_4)](v_4, false))
        end
        return concat_upvr(module_4, const_string_upvr_2)
    end
    local function _(arg1_3, arg2_3) -- Line 319, Named "Params"
        local module = {}
        module[1] = arg1_3
        module[2] = tbl_3_upvr.table(arg2_3, false)
        return "(function(v, p) for pn, pv in next, p do v[pn] = pv end return v end)("..concat_upvr(module, const_string_upvr_2)..')'
    end
    local var84_upvw = 1
    function tbl_3_upvr.number(arg1_4, arg2_4) -- Line 325
        if arg2_4 and arg1_4 == var84_upvw then
            var84_upvw += 1
            return nil, true
        end
        if arg1_4 == huge_upvr then
            return "math.huge"
        end
        if arg1_4 == -huge_upvr then
            return "-math.huge"
        end
        return format_upvr("%.14g", arg1_4)
    end
    function tbl_3_upvr.string(arg1_5, arg2_5) -- Line 346
        if arg2_5 and not var20_upvw[arg1_5] and match_upvr(arg1_5, "^[A-Za-z_][A-Za-z0-9_]*$") then
            return arg1_5, true
        end
        return SerializeString_upvw(arg1_5)
    end
    local tbl_2_upvr = {}
    local PrettyPrinting_upvr = var67_upvw.PrettyPrinting
    function tbl_3_upvr.table(arg1_6, arg2_6) -- Line 355
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local var89
        if tbl_2_upvr[arg1_6] then
            if arg1_6 == arg1 then
                var89 = " (of parent)"
            else
                var89 = ""
            end
            return format_upvr("{--[[LuaEncode: Duplicate reference%s]]}", var89)
        end
        tbl_2_upvr[arg1_6] = true
        local var30_result1 = var30_upvw(var67_upvw)
        if not arg2_6 then
        end
        var30_result1.Prettify = PrettyPrinting_upvr
        if arg2_6 then
            if PrettyPrinting_upvr or not IndentCount_upvr then
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
        else
        end
        var30_result1.IndentCount = IndentCount_upvr
        if arg2_6 then
        else
        end
        var30_result1._StackLevel = var70_upvr + 1
        var30_result1._VisitedTables = tbl_2_upvr
        return LuaEncode_upvr(arg1_6, var30_result1)
    end
    function tbl_3_upvr.boolean(arg1_7) -- Line 387
        return tostring_upvr(arg1_7)
    end
    tbl_3_upvr["nil"] = function(arg1_8) -- Line 391
        return "nil"
    end
    local FunctionsReturnRaw_upvr = var67_upvw.FunctionsReturnRaw
    tbl_3_upvr["function"] = function(arg1_9) -- Line 395
        if FunctionsReturnRaw_upvr then
            return arg1_9()
        end
        return "function() --[[LuaEncode: `options.FunctionsReturnRaw` false; can't serialize functions]] return end"
    end
    function tbl_3_upvr.Axes(arg1_10) -- Line 409
        for i_7, v_5 in next_upvr, {
            ["Enum.Axis.X"] = arg1_10.X;
            ["Enum.Axis.Y"] = arg1_10.Y;
            ["Enum.Axis.Z"] = arg1_10.Z;
        } do
            if v_5 then
                insert_upvr({}, i_7)
            end
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        return "Axes.new("..concat_upvr({}, const_string_upvr_2)..')'
    end
    function tbl_3_upvr.BrickColor(arg1_11) -- Line 426
        local var100 = PrettyPrinting_upvr
        if var100 then
            var100 = tbl_3_upvr.string(arg1_11.Name, false)
        end
        local var101 = "BrickColor.new("..var100
        if not var101 then
            var101 = arg1_11.Number..')'
        end
        return var101
    end
    function tbl_3_upvr.CFrame(arg1_12) -- Line 432
        return "CFrame.new("..Args_upvr(arg1_12:components())..')'
    end
    function tbl_3_upvr.CatalogSearchParams(arg1_13) -- Line 436
        return "(function(v, p) for pn, pv in next, p do v[pn] = pv end return v end)("..concat_upvr({"CatalogSearchParams.new()", tbl_3_upvr.table({
            SearchKeyword = arg1_13.SearchKeyword;
            MinPrice = arg1_13.MinPrice;
            MaxPrice = arg1_13.MaxPrice;
            SortType = arg1_13.SortType;
            CategoryFilter = arg1_13.CategoryFilter;
            BundleTypes = arg1_13.BundleTypes;
            AssetTypes = arg1_13.AssetTypes;
        }, false)}, const_string_upvr_2)..')'
    end
    function tbl_3_upvr.Color3(arg1_14) -- Line 448
        return "Color3.new("..Args_upvr(arg1_14.R, arg1_14.G, arg1_14.B)
    end
    function tbl_3_upvr.ColorSequence(arg1_15) -- Line 453
        return "ColorSequence.new("..tbl_3_upvr.table(arg1_15.Keypoints, false)..')'
    end
    function tbl_3_upvr.ColorSequenceKeypoint(arg1_16) -- Line 457
        return "ColorSequenceKeypoint.new("..Args_upvr(arg1_16.Time, arg1_16.Value)..')'
    end
    function tbl_3_upvr.DateTime(arg1_17) -- Line 462
        return "DateTime.fromUnixTimestamp("..arg1_17.UnixTimestamp..')'
    end
    function tbl_3_upvr.DockWidgetPluginGuiInfo(arg1_18) -- Line 469
        local tostring_upvr_result1 = tostring_upvr(arg1_18)
        local InitialDockState = Enum.InitialDockState
        local var113
        if var113 ~= '1' then
            InitialDockState = false
        else
            InitialDockState = true
        end
        if match_upvr(tostring_upvr_result1, "InitialEnabledShouldOverrideRestore:(%w+)") ~= '1' then
            var113 = false
        else
            var113 = true
        end
        return "DockWidgetPluginGuiInfo.new("..Args_upvr(InitialDockState[match_upvr(tostring_upvr_result1, "InitialDockState:(%w+)")], InitialDockState, var113, tonumber_upvr(match_upvr(tostring_upvr_result1, "FloatingXSize:(%w+)")), tonumber_upvr(match_upvr(tostring_upvr_result1, "FloatingYSize:(%w+)")), tonumber_upvr(match_upvr(tostring_upvr_result1, "MinWidth:(%w+)")), tonumber_upvr(match_upvr(tostring_upvr_result1, "MinHeight:(%w+)")))..')'
    end
    function tbl_3_upvr.Enum(arg1_19) -- Line 491
        return "Enum."..tostring_upvr(arg1_19)
    end
    function tbl_3_upvr.EnumItem(arg1_20) -- Line 496
        return tostring_upvr(arg1_20)
    end
    function tbl_3_upvr.Enums(arg1_21) -- Line 501
        return "Enum"
    end
    function tbl_3_upvr.Faces(arg1_22) -- Line 505
        for i_8, v_6 in next_upvr, {
            ["Enum.NormalId.Top"] = arg1_22.Top;
            ["Enum.NormalId.Bottom"] = arg1_22.Bottom;
            ["Enum.NormalId.Left"] = arg1_22.Left;
            ["Enum.NormalId.Right"] = arg1_22.Right;
            ["Enum.NormalId.Back"] = arg1_22.Back;
            ["Enum.NormalId.Front"] = arg1_22.Front;
        } do
            if v_6 then
                insert_upvr({}, i_8)
            end
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        return "Faces.new("..concat_upvr({}, const_string_upvr_2)..')'
    end
    function tbl_3_upvr.FloatCurveKey(arg1_23) -- Line 525
        return "FloatCurveKey.new("..Args_upvr(arg1_23.Time, arg1_23.Value, arg1_23.Interpolation)..')'
    end
    function tbl_3_upvr.Font(arg1_24) -- Line 529
        return "Font.new("..Args_upvr(arg1_24.Family, arg1_24.Weight, arg1_24.Style)..')'
    end
    local UseInstancePaths_upvr = var67_upvw.UseInstancePaths
    local const_string_upvr = ""
    function tbl_3_upvr.Instance(arg1_25) -- Line 535
        local var136
        if UseInstancePaths_upvr then
            local EvaluateInstancePath_result1_2 = EvaluateInstancePath_upvw(arg1_25)
            if EvaluateInstancePath_result1_2 then
                return EvaluateInstancePath_result1_2
            end
        end
        var136 = "Instance.new("
        local var138 = var136..tbl_3_upvr.string(arg1_25.ClassName, false)..')'
        var136 = ""
        for i_9 in gmatch_upvr(var138, "%](=*)%]") do
            if #var136 <= #i_9 then
                var136 = i_9..'='
            end
        end
        return "nil"..const_string_upvr.."--["..var136..'['..var138..']'..var136..']'
    end
    function tbl_3_upvr.NumberRange(arg1_26) -- Line 550
        return "NumberRange.new("..Args_upvr(arg1_26.Min, arg1_26.Max)..')'
    end
    function tbl_3_upvr.NumberSequence(arg1_27) -- Line 554
        return "NumberSequence.new("..tbl_3_upvr.table(arg1_27.Keypoints, false)..')'
    end
    function tbl_3_upvr.NumberSequenceKeypoint(arg1_28) -- Line 558
        return "NumberSequenceKeypoint.new("..Args_upvr(arg1_28.Time, arg1_28.Value, arg1_28.Envelope)..')'
    end
    function tbl_3_upvr.OverlapParams(arg1_29) -- Line 562
        return "(function(v, p) for pn, pv in next, p do v[pn] = pv end return v end)("..concat_upvr({"OverlapParams.new()", tbl_3_upvr.table({
            FilterDescendantsInstances = arg1_29.FilterDescendantsInstances;
            FilterType = arg1_29.FilterType;
            MaxParts = arg1_29.MaxParts;
            CollisionGroup = arg1_29.CollisionGroup;
            RespectCanCollide = arg1_29.RespectCanCollide;
        }, false)}, const_string_upvr_2)..')'
    end
    function tbl_3_upvr.PathWaypoint(arg1_30) -- Line 572
        return "PathWaypoint.new("..Args_upvr(arg1_30.Position, arg1_30.Action, arg1_30.Label)..')'
    end
    function tbl_3_upvr.PhysicalProperties(arg1_31) -- Line 576
        return "PhysicalProperties.new("..Args_upvr(arg1_31.Density, arg1_31.Friction, arg1_31.Elasticity, arg1_31.FrictionWeight, arg1_31.ElasticityWeight)..')'
    end
    function tbl_3_upvr.Random() -- Line 582
        return "Random.new()"
    end
    function tbl_3_upvr.Ray(arg1_32) -- Line 586
        return "Ray.new("..Args_upvr(arg1_32.Origin, arg1_32.Direction)..')'
    end
    function tbl_3_upvr.RaycastParams(arg1_33) -- Line 590
        return "(function(v, p) for pn, pv in next, p do v[pn] = pv end return v end)("..concat_upvr({"RaycastParams.new()", tbl_3_upvr.table({
            FilterDescendantsInstances = arg1_33.FilterDescendantsInstances;
            FilterType = arg1_33.FilterType;
            IgnoreWater = arg1_33.IgnoreWater;
            CollisionGroup = arg1_33.CollisionGroup;
            RespectCanCollide = arg1_33.RespectCanCollide;
        }, false)}, const_string_upvr_2)..')'
    end
    function tbl_3_upvr.Rect(arg1_34) -- Line 600
        return "Rect.new("..Args_upvr(arg1_34.Min, arg1_34.Max)..')'
    end
    function tbl_3_upvr.Region3(arg1_35) -- Line 607
        local CFrame_2 = arg1_35.CFrame
        local Size = arg1_35.Size
        return "Region3.new("..Args_upvr(CFrame_2 * CFrame.new(-Size / 2), CFrame_2 * CFrame.new(Size / 2))..')'
    end
    function tbl_3_upvr.Region3int16(arg1_36) -- Line 619
        return "Region3int16.new("..Args_upvr(arg1_36.Min, arg1_36.Max)..')'
    end
    function tbl_3_upvr.TweenInfo(arg1_37) -- Line 623
        return "TweenInfo.new("..Args_upvr(arg1_37.Time, arg1_37.EasingStyle, arg1_37.EasingDirection, arg1_37.RepeatCount, arg1_37.Reverses, arg1_37.DelayTime)..')'
    end
    function tbl_3_upvr.RotationCurveKey(arg1_38) -- Line 637
        return "RotationCurveKey.new("..Args_upvr(arg1_38.Time, arg1_38.Value, arg1_38.Interpolation)..')'
    end
    function tbl_3_upvr.UDim(arg1_39) -- Line 641
        return "UDim.new("..Args_upvr(arg1_39.Scale, arg1_39.Offset)..')'
    end
    function tbl_3_upvr.UDim2(arg1_40) -- Line 645
        return "UDim2.new("..Args_upvr(arg1_40.X.Scale, arg1_40.X.Offset, arg1_40.Y.Scale, arg1_40.Y.Offset)..')'
    end
    function tbl_3_upvr.Vector2(arg1_41) -- Line 658
        return "Vector2.new("..Args_upvr(arg1_41.X, arg1_41.Y)..')'
    end
    function tbl_3_upvr.Vector2int16(arg1_42) -- Line 662
        return "Vector2int16.new("..Args_upvr(arg1_42.X, arg1_42.Y)..')'
    end
    function tbl_3_upvr.Vector3(arg1_43) -- Line 666
        return "Vector3.new("..Args_upvr(arg1_43.X, arg1_43.Y, arg1_43.Z)..')'
    end
    function tbl_3_upvr.Vector3int16(arg1_44) -- Line 670
        return "Vector3int16.new("..Args_upvr(arg1_44.X, arg1_44.Y, arg1_44.Z)..')'
    end
    function tbl_3_upvr.userdata(arg1_45) -- Line 675
        if getmetatable_upvr(arg1_45) then
            return "newproxy(true)"
        end
        return "newproxy()"
    end
    Args_upvr = next_upvr
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [526.25]
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
return LuaEncode_upvr