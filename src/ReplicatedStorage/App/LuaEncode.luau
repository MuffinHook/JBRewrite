local v1 = table
local v2 = ipairs
local v3 = string
local v4 = next
local v5 = pcall
local v6 = game
local v7 = workspace
local v8 = math
local v9 = tostring
local v10 = tonumber
local v11 = getmetatable
local format = v3.format
local char = v3.char
local gsub = v3.gsub
local match = v3.match
local rep = v3.rep
local sub = v3.sub
local gmatch = v3.gmatch
local concat = v1.concat
local insert = v1.insert
local huge = v8.huge
local v12 = typeof or type
local v13 = setmetatable({}, {
	__mode = "k"
})
for v14, v15 in v4, {
	"and",
	"break",
	"do",
	"else",
	"elseif",
	"end",
	"false",
	"for",
	"function",
	"if",
	"in",
	"local",
	"nil",
	"not",
	"or",
	"repeat",
	"return",
	"then",
	"true",
	"until",
	"while",
	"continue"
} do
	v13[v15] = true
end
local v17 = v1.find or function(p1, p2) --[[ Line: 68 | Upvalues: v2 (copy) ]]
	for v1, v22 in v2(p1) do
		if v22 == p2 then
			return v1
		end
	end
end
local v19 = v1.clone or function(p1) --[[ Line: 80 | Upvalues: v4 (copy) ]]
	local t = {}
	for v1, v2 in v4, p1 do
		t[v1] = v2
	end
	return t
end
local function CheckType(p1, p2, ...) --[[ Line: 92 | Upvalues: v12 (copy), v17 (ref), format (copy), concat (copy) ]]
	local t = { ... }
	local v1 = v12(p1)
	if not v17(t, v1) then
		error(format("LuaEncode: Incorrect type for `%s`: `%s` expected, got `%s`", p2, concat(t, ", "), v1), 0)
	end
	return p1
end
local t = {
	["\""] = "\\\"",
	["\\"] = "\\\\",
	["\7"] = "\\a",
	["\8"] = "\\b",
	["\t"] = "\\t",
	["\n"] = "\\n",
	["\11"] = "\\v",
	["\f"] = "\\f",
	["\r"] = "\\r"
}
for i = 0, 255 do
	local v20 = char(i)
	if not t[v20] and (i < 32 or i > 126) then
		t[v20] = "\\" .. i
	end
end
local function SerializeString(p1) --[[ Line: 139 | Upvalues: gsub (copy), t (copy) ]]
	return "\"" .. gsub(p1, "[%z\\\"\1-\31\127-\255]", t) .. "\""
end
local function CommentBlock(p1) --[[ Line: 147 | Upvalues: gmatch (copy) ]]
	local v1 = ""
	for v2 in gmatch(p1, "%](=*)%]") do
		if #v1 <= #v2 then
			v1 = v2 .. "="
		end
	end
	return "--[" .. v1 .. "[" .. p1 .. "]" .. v1 .. "]"
end
local function IsService(p1) --[[ Line: 163 | Upvalues: v5 (copy), v6 (copy) ]]
	local v1, v2 = v5(v6.FindService, v6, p1.ClassName)
	return v1 and v2 and true or false
end
local function v21(p1, p2) --[[ Line: 175 | Upvalues: v6 (copy), v5 (copy), SerializeString (ref), v13 (ref), match (copy), v7 (copy), v21 (ref) ]]
	local v1 = p2 or ""
	local v2 = p1.Name
	local ClassName = p1.ClassName
	local v3 = p1.Parent
	local v4
	if v3 == v6 then
		local v52, v62 = v5(v6.FindService, v6, p1.ClassName)
		v4 = if v52 and v62 and true or false then ":GetService(" .. SerializeString(ClassName) .. ")" .. v1 elseif v13[v2] or not match(v2, "^[A-Za-z_][A-Za-z0-9_]*$") then "[" .. SerializeString(v2) .. "]" .. v1 else "." .. v2 .. v1
	else
		v4 = if v13[v2] or not match(v2, "^[A-Za-z_][A-Za-z0-9_]*$") then "[" .. SerializeString(v2) .. "]" .. v1 else "." .. v2 .. v1
	end
	if v3 then
		if v3 == v6 then
			return "game" .. v4
		elseif v3 == v7 then
			return "workspace" .. v4
		else
			return v21(v3, v4)
		end
	end
end
local function v22(p1, p2) --[[ Line: 236 | Upvalues: CheckType (copy), rep (copy), sub (copy), v4 (copy), v12 (copy), insert (copy), concat (copy), huge (copy), format (copy), v13 (ref), match (copy), SerializeString (ref), v19 (ref), v22 (copy), v9 (copy), v10 (copy), v21 (ref), gmatch (copy), v11 (copy), v5 (copy) ]]
	CheckType(p1, "inputTable", "table")
	CheckType(p2, "options", "table", "nil")
	if p2 then
		CheckType(p2.Prettify, "options.Prettify", "boolean", "nil")
		CheckType(p2.PrettyPrinting, "options.PrettyPrinting", "boolean", "nil")
		CheckType(p2.IndentCount, "options.IndentCount", "number", "nil")
		CheckType(p2.OutputWarnings, "options.OutputWarnings", "boolean", "nil")
		CheckType(p2.StackLimit, "options.StackLimit", "number", "nil")
		CheckType(p2.FunctionsReturnRaw, "options.FunctionsReturnRaw", "boolean", "nil")
		CheckType(p2.UseInstancePaths, "options.UseInstancePaths", "boolean", "nil")
		CheckType(p2._StackLevel, "options._StackLevel", "number", "nil")
		CheckType(p2._VisitedTables, "options._StackLevel", "table", "nil")
	end
	local v2 = p2 or {}
	if v2.Prettify == nil then
		local isPrettyPrinting = v2.PrettyPrinting == nil
	end
	local v3 = if v2.Prettify == nil then v2.PrettyPrinting and v2.PrettyPrinting else v2.Prettify or v2.PrettyPrinting and v2.PrettyPrinting
	local IndentCount = v2.IndentCount
	if not IndentCount then
		IndentCount = if v3 then 4 else 0
	end
	local v42 = if v2.OutputWarnings == nil then true else v2.OutputWarnings
	local v52 = v2.StackLimit or 500
	local isFunctionsReturnRaw = v2.FunctionsReturnRaw == nil
	local FunctionsReturnRaw = v2.FunctionsReturnRaw
	local v6 = if v2.UseInstancePaths == nil then true else v2.UseInstancePaths
	local v7 = v2._StackLevel or 1
	local v8 = v2._VisitedTables or {
		[p1] = true
	}
	if v52 <= v7 then
		return "{--[[LuaEncode: Stack level limit of `" .. v52 .. "` reached]]}"
	else
		local v92 = if v3 then "\n" else ""
		local v102 = if v3 then ", " else ","
		local v112 = if v3 then " " else ""
		local v122 = rep(" ", IndentCount)
		local v132 = v3 and rep(v122, v7) or v122
		local v14 = #v132 > 0 and sub(v132, 1, -IndentCount - 1) or ""
		local v16 = 1
		local t = {}
		local function TypeCase(p1, p2) --[[ Line: 301 | Upvalues: t (copy) ]]
			return t[p1](p2, false)
		end
		local function Args(...) --[[ Line: 308 | Upvalues: v4 (ref), v12 (ref), t (copy), insert (ref), concat (ref), v102 (copy) ]]
			local t2 = {}
			for v1, v2 in v4, { ... } do
				insert(t2, (t[v12(v2)](v2, false)))
			end
			return concat(t2, v102)
		end
		local function Params(p1, p2) --[[ Line: 319 | Upvalues: concat (ref), t (copy), v102 (copy) ]]
			return "(function(v, p) for pn, pv in next, p do v[pn] = pv end return v end)(" .. concat({ p1, (t.table(p2, false)) }, v102) .. ")"
		end
		function t.number(p1, p2) --[[ Line: 325 | Upvalues: v16 (ref), huge (ref), format (ref) ]]
			if p2 and p1 == v16 then
				v16 = v16 + 1
				return nil, true
			elseif p1 == huge then
				return "math.huge"
			elseif p1 == -huge then
				return "-math.huge"
			else
				return format("%.14g", p1)
			end
		end
		function t.string(p1, p2) --[[ Line: 346 | Upvalues: v13 (ref), match (ref), SerializeString (ref) ]]
			if p2 and (not v13[p1] and match(p1, "^[A-Za-z_][A-Za-z0-9_]*$")) then
				return p1, true
			else
				return SerializeString(p1)
			end
		end
		function t.table(p12, p2) --[[ Line: 355 | Upvalues: v8 (copy), format (ref), p1 (copy), v19 (ref), v2 (ref), v3 (copy), IndentCount (copy), v7 (copy), v22 (ref) ]]
			if v8[p12] then
				return format("{--[[LuaEncode: Duplicate reference%s]]}", if p12 == p1 then " (of parent)" else "")
			else
				v8[p12] = true
				local v4 = v19(v2)
				v4.Prettify = v3
				v4.IndentCount = if p2 then if v3 then 1 else IndentCount or 1 else IndentCount
				v4._StackLevel = if p2 then 1 else v7 + 1
				v4._VisitedTables = v8
				return v22(p12, v4)
			end
		end
		function t.boolean(p1) --[[ Line: 387 | Upvalues: v9 (ref) ]]
			return v9(p1)
		end
		t["nil"] = function(p1) --[[ Line: 391 ]]
			return "nil"
		end
		t["function"] = function(p1) --[[ Line: 395 | Upvalues: FunctionsReturnRaw (copy) ]]
			if FunctionsReturnRaw then
				return p1()
			else
				return "function() --[[LuaEncode: `options.FunctionsReturnRaw` false; can\'t serialize functions]] return end"
			end
		end
		function t.Axes(p1) --[[ Line: 409 | Upvalues: v4 (ref), insert (ref), concat (ref), v102 (copy) ]]
			local t = {}
			for v1, v2 in v4, {
				["Enum.Axis.X"] = p1.X,
				["Enum.Axis.Y"] = p1.Y,
				["Enum.Axis.Z"] = p1.Z
			} do
				if v2 then
					insert(t, v1)
				end
			end
			return "Axes.new(" .. concat(t, v102) .. ")"
		end
		function t.BrickColor(p1) --[[ Line: 426 | Upvalues: v3 (copy), t (copy) ]]
			local v2 = v3
			if v2 then
				v2 = t.string(p1.Name, false)
			end
			return "BrickColor.new(" .. v2 or p1.Number .. ")"
		end
		function t.CFrame(p1) --[[ Line: 432 | Upvalues: Args (copy) ]]
			return "CFrame.new(" .. Args(p1:components()) .. ")"
		end
		function t.CatalogSearchParams(p1) --[[ Line: 436 | Upvalues: concat (ref), t (copy), v102 (copy) ]]
			return "(function(v, p) for pn, pv in next, p do v[pn] = pv end return v end)(" .. concat({ "CatalogSearchParams.new()", (t.table({
					SearchKeyword = p1.SearchKeyword,
					MinPrice = p1.MinPrice,
					MaxPrice = p1.MaxPrice,
					SortType = p1.SortType,
					CategoryFilter = p1.CategoryFilter,
					BundleTypes = p1.BundleTypes,
					AssetTypes = p1.AssetTypes
				}, false)) }, v102) .. ")"
		end
		function t.Color3(p1) --[[ Line: 448 | Upvalues: Args (copy) ]]
			return "Color3.new(" .. Args(p1.R, p1.G, p1.B)
		end
		function t.ColorSequence(p1) --[[ Line: 453 | Upvalues: t (copy) ]]
			return "ColorSequence.new(" .. t.table(p1.Keypoints, false) .. ")"
		end
		function t.ColorSequenceKeypoint(p1) --[[ Line: 457 | Upvalues: Args (copy) ]]
			return "ColorSequenceKeypoint.new(" .. Args(p1.Time, p1.Value) .. ")"
		end
		function t.DateTime(p1) --[[ Line: 462 ]]
			return "DateTime.fromUnixTimestamp(" .. p1.UnixTimestamp .. ")"
		end
		function t.DockWidgetPluginGuiInfo(p1) --[[ Line: 469 | Upvalues: v9 (ref), Args (copy), match (ref), v10 (ref) ]]
			local v1 = v9(p1)
			return "DockWidgetPluginGuiInfo.new(" .. Args(Enum.InitialDockState[match(v1, "InitialDockState:(%w+)")], match(v1, "InitialEnabled:(%w+)") == "1", match(v1, "InitialEnabledShouldOverrideRestore:(%w+)") == "1", v10(match(v1, "FloatingXSize:(%w+)")), v10(match(v1, "FloatingYSize:(%w+)")), v10(match(v1, "MinWidth:(%w+)")), (v10(match(v1, "MinHeight:(%w+)")))) .. ")"
		end
		function t.Enum(p1) --[[ Line: 491 | Upvalues: v9 (ref) ]]
			return "Enum." .. v9(p1)
		end
		function t.EnumItem(p1) --[[ Line: 496 | Upvalues: v9 (ref) ]]
			return v9(p1)
		end
		function t.Enums(p1) --[[ Line: 501 ]]
			return "Enum"
		end
		function t.Faces(p1) --[[ Line: 505 | Upvalues: v4 (ref), insert (ref), concat (ref), v102 (copy) ]]
			local t = {}
			for v1, v2 in v4, {
				["Enum.NormalId.Top"] = p1.Top,
				["Enum.NormalId.Bottom"] = p1.Bottom,
				["Enum.NormalId.Left"] = p1.Left,
				["Enum.NormalId.Right"] = p1.Right,
				["Enum.NormalId.Back"] = p1.Back,
				["Enum.NormalId.Front"] = p1.Front
			} do
				if v2 then
					insert(t, v1)
				end
			end
			return "Faces.new(" .. concat(t, v102) .. ")"
		end
		function t.FloatCurveKey(p1) --[[ Line: 525 | Upvalues: Args (copy) ]]
			return "FloatCurveKey.new(" .. Args(p1.Time, p1.Value, p1.Interpolation) .. ")"
		end
		function t.Font(p1) --[[ Line: 529 | Upvalues: Args (copy) ]]
			return "Font.new(" .. Args(p1.Family, p1.Weight, p1.Style) .. ")"
		end
		function t.Instance(p1) --[[ Line: 535 | Upvalues: v6 (copy), v21 (ref), v112 (copy), t (copy), gmatch (ref) ]]
			local v1, v2, v3, v4, v5
			if v6 then
				local v62 = v21(p1)
				if v62 then
					return v62
				else
					v1 = v112
					v2 = p1.ClassName
					v3 = "Instance.new(" .. t.string(v2, false) .. ")"
					v4 = ""
					v5 = "nil"
					for v7 in gmatch(v3, "%](=*)%]") do
						if #v4 <= #v7 then
							v4 = v7 .. "="
						end
					end
					return v5 .. v112 .. "--[" .. v4 .. "[" .. v3 .. "]" .. v4 .. "]"
				end
			else
				v1 = v112
				v2 = p1.ClassName
				v3 = "Instance.new(" .. t.string(v2, false) .. ")"
				v4 = ""
				v5 = "nil"
				for v7 in gmatch(v3, "%](=*)%]") do
					if #v4 <= #v7 then
						v4 = v7 .. "="
					end
				end
				return v5 .. v112 .. "--[" .. v4 .. "[" .. v3 .. "]" .. v4 .. "]"
			end
		end
		function t.NumberRange(p1) --[[ Line: 550 | Upvalues: Args (copy) ]]
			return "NumberRange.new(" .. Args(p1.Min, p1.Max) .. ")"
		end
		function t.NumberSequence(p1) --[[ Line: 554 | Upvalues: t (copy) ]]
			return "NumberSequence.new(" .. t.table(p1.Keypoints, false) .. ")"
		end
		function t.NumberSequenceKeypoint(p1) --[[ Line: 558 | Upvalues: Args (copy) ]]
			return "NumberSequenceKeypoint.new(" .. Args(p1.Time, p1.Value, p1.Envelope) .. ")"
		end
		function t.OverlapParams(p1) --[[ Line: 562 | Upvalues: concat (ref), t (copy), v102 (copy) ]]
			return "(function(v, p) for pn, pv in next, p do v[pn] = pv end return v end)(" .. concat({ "OverlapParams.new()", (t.table({
					FilterDescendantsInstances = p1.FilterDescendantsInstances,
					FilterType = p1.FilterType,
					MaxParts = p1.MaxParts,
					CollisionGroup = p1.CollisionGroup,
					RespectCanCollide = p1.RespectCanCollide
				}, false)) }, v102) .. ")"
		end
		function t.PathWaypoint(p1) --[[ Line: 572 | Upvalues: Args (copy) ]]
			return "PathWaypoint.new(" .. Args(p1.Position, p1.Action, p1.Label) .. ")"
		end
		function t.PhysicalProperties(p1) --[[ Line: 576 | Upvalues: Args (copy) ]]
			return "PhysicalProperties.new(" .. Args(p1.Density, p1.Friction, p1.Elasticity, p1.FrictionWeight, p1.ElasticityWeight) .. ")"
		end
		function t.Random() --[[ Line: 582 ]]
			return "Random.new()"
		end
		function t.Ray(p1) --[[ Line: 586 | Upvalues: Args (copy) ]]
			return "Ray.new(" .. Args(p1.Origin, p1.Direction) .. ")"
		end
		function t.RaycastParams(p1) --[[ Line: 590 | Upvalues: concat (ref), t (copy), v102 (copy) ]]
			return "(function(v, p) for pn, pv in next, p do v[pn] = pv end return v end)(" .. concat({ "RaycastParams.new()", (t.table({
					FilterDescendantsInstances = p1.FilterDescendantsInstances,
					FilterType = p1.FilterType,
					IgnoreWater = p1.IgnoreWater,
					CollisionGroup = p1.CollisionGroup,
					RespectCanCollide = p1.RespectCanCollide
				}, false)) }, v102) .. ")"
		end
		function t.Rect(p1) --[[ Line: 600 | Upvalues: Args (copy) ]]
			return "Rect.new(" .. Args(p1.Min, p1.Max) .. ")"
		end
		function t.Region3(p1) --[[ Line: 607 | Upvalues: Args (copy) ]]
			local v1 = p1.CFrame
			local Size = p1.Size
			return "Region3.new(" .. Args(v1 * CFrame.new(-Size / 2), v1 * CFrame.new(Size / 2)) .. ")"
		end
		function t.Region3int16(p1) --[[ Line: 619 | Upvalues: Args (copy) ]]
			return "Region3int16.new(" .. Args(p1.Min, p1.Max) .. ")"
		end
		function t.TweenInfo(p1) --[[ Line: 623 | Upvalues: Args (copy) ]]
			return "TweenInfo.new(" .. Args(p1.Time, p1.EasingStyle, p1.EasingDirection, p1.RepeatCount, p1.Reverses, p1.DelayTime) .. ")"
		end
		function t.RotationCurveKey(p1) --[[ Line: 637 | Upvalues: Args (copy) ]]
			return "RotationCurveKey.new(" .. Args(p1.Time, p1.Value, p1.Interpolation) .. ")"
		end
		function t.UDim(p1) --[[ Line: 641 | Upvalues: Args (copy) ]]
			return "UDim.new(" .. Args(p1.Scale, p1.Offset) .. ")"
		end
		function t.UDim2(p1) --[[ Line: 645 | Upvalues: Args (copy) ]]
			return "UDim2.new(" .. Args(p1.X.Scale, p1.X.Offset, p1.Y.Scale, p1.Y.Offset) .. ")"
		end
		function t.Vector2(p1) --[[ Line: 658 | Upvalues: Args (copy) ]]
			return "Vector2.new(" .. Args(p1.X, p1.Y) .. ")"
		end
		function t.Vector2int16(p1) --[[ Line: 662 | Upvalues: Args (copy) ]]
			return "Vector2int16.new(" .. Args(p1.X, p1.Y) .. ")"
		end
		function t.Vector3(p1) --[[ Line: 666 | Upvalues: Args (copy) ]]
			return "Vector3.new(" .. Args(p1.X, p1.Y, p1.Z) .. ")"
		end
		function t.Vector3int16(p1) --[[ Line: 670 | Upvalues: Args (copy) ]]
			return "Vector3int16.new(" .. Args(p1.X, p1.Y, p1.Z) .. ")"
		end
		function t.userdata(p1) --[[ Line: 675 | Upvalues: v11 (ref) ]]
			if v11(p1) then
				return "newproxy(true)"
			else
				return "newproxy()"
			end
		end
		local v17 = ""
		for v25, v26 in v4, p1 do
			local v18, v192, v20, v212, v222, v23, v24
			local v27 = v12(v25)
			local v28 = v12(v26)
			if t[v27] and t[v28] then
				v18 = v3 and v92 .. v132 or ""
				local v29 = false
				local v30, v31, v32 = v5(t[v27], v25, true)
				local v33, v34 = v5(t[v28], v26, false)
				if v30 and (v33 and v34) then
					if v31 then
						v192 = if v32 and v31 then v31 else format("[%s]", v31)
						v20 = if v3 then " = " else "="
						v212 = v192 .. v20 or ""
					else
						v212 = ""
					end
					v29 = true
					v18 = v18 .. v212 .. v34
				elseif v42 then
					v222 = if v30 then if v33 then "key/value" else "value" else "key"
					if v30 then
						v23 = v28
						if v33 then
							v24 = "(Failed to get error message)"
						else
							v24 = SerializeString(v34)
							if not v24 then
								v24 = "(Failed to get error message)"
							end
						end
					else
						v24 = SerializeString(v31)
						if v24 then
							v23 = v28
						elseif v33 then
							v24 = "(Failed to get error message)"
						else
							v24 = SerializeString(v34)
							if not v24 then
								v24 = "(Failed to get error message)"
							end
						end
					end
					local v38 = format("LuaEncode: Failed to encode %s of DataType `%s`: %s", v222, v23, v24)
					v39 = ""
					v40 = v18
					for v41 in gmatch(v38, "%](=*)%]") do
						if #v39 <= #v41 then
							v39 = v41 .. "="
						end
					end
					v18 = v40 .. "--[" .. v39 .. "[" .. v38 .. "]" .. v39 .. "]"
				end
				if v4(p1, v25) then
					if v29 then
						v18 = v18 .. ","
					end
				else
					v18 = v18 .. v92 .. v14
				end
				v17 = v17 .. v18
			end
		end
		return "{" .. v17 .. "}"
	end
end
return v22