-- Reviewed by Claude
local tableLib = table
local ipairsFunc = ipairs
local stringLib = string
local nextFunc = next
local pcallFunc = pcall
local gameService = game
local workspaceRef = workspace
local mathLib = math
local tostringFunc = tostring
local tonumberFunc = tonumber
local getmetatableFunc = getmetatable
local format = stringLib.format
local char = stringLib.char
local gsub = stringLib.gsub
local match = stringLib.match
local rep = stringLib.rep
local sub = stringLib.sub
local gmatch = stringLib.gmatch
local concat = tableLib.concat
local insert = tableLib.insert
local huge = mathLib.huge
local typeofFunc = typeof or type
local metatableTable = setmetatable({}, {
	__mode = "k"
})
for v14, v15 in nextFunc, {
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
	metatableTable[v15] = true
end
local v17 = tableLib.find or function(p1, p2)
	for tableLib, v22 in ipairsFunc(p1) do
		if v22 == p2 then
			return tableLib
		end
	end
end
local v19 = tableLib.clone or function(p1)
	local localTable = {}
	for tableLib, ipairsFunc in nextFunc, p1 do
		localTable[tableLib] = ipairsFunc
	end
	return localTable
end
local function CheckType(p1, p2, ...)
	local localTable = { ... }
	local tableLib = typeofFunc(p1)
	if not v17(localTable, tableLib) then
		error(format("LuaEncode: Incorrect type for `%s`: `%s` expected, got `%s`", p2, concat(localTable, ", "), tableLib), 0)
	end
	return p1
end
local localTable = {
	["\""] = "\\\"",
	["\\"] = "\\\\",
	["\7"] = "\\a",
	["\8"] = "\\b",
	["\localTable"] = "\\localTable",
	["\n"] = "\\n",
	["\11"] = "\\v",
	["\f"] = "\\f",
	["\r"] = "\\r"
}
for i = 0, 255 do
	local v20 = char(i)
	if not localTable[v20] and (i < 32 or i > 126) then
		localTable[v20] = "\\" .. i
	end
end
local function SerializeString(p1)
	return "\"" .. gsub(p1, "[%z\\\"\1-\31\127-\255]", localTable) .. "\""
end
local function CommentBlock(p1)
	local tableLib = ""
	for ipairsFunc in gmatch(p1, "%](=*)%]") do
		if #tableLib <= #ipairsFunc then
			tableLib = ipairsFunc .. "="
		end
	end
	return "--[" .. tableLib .. "[" .. p1 .. "]" .. tableLib .. "]"
end
local function IsService(p1)
	local tableLib, ipairsFunc = pcallFunc(gameService.FindService, gameService, p1.ClassName)
	return tableLib and ipairsFunc and true or false
end
local function v21(p1, p2)
	local tableLib = p2 or ""
	local ipairsFunc = p1.Name
	local ClassName = p1.ClassName
	local stringLib = p1.Parent
	local nextFunc
	if stringLib == gameService then
		local v52, v62 = pcallFunc(gameService.FindService, gameService, p1.ClassName)
		nextFunc = if v52 and v62 and true or false then ":GetService(" .. SerializeString(ClassName) .. ")" .. tableLib elseif metatableTable[ipairsFunc] or not match(ipairsFunc, "^[A-Za-z_][A-Za-z0-9_]*$") then "[" .. SerializeString(ipairsFunc) .. "]" .. tableLib else "." .. ipairsFunc .. tableLib
	else
		nextFunc = if metatableTable[ipairsFunc] or not match(ipairsFunc, "^[A-Za-z_][A-Za-z0-9_]*$") then "[" .. SerializeString(ipairsFunc) .. "]" .. tableLib else "." .. ipairsFunc .. tableLib
	end
	if stringLib then
		if stringLib == gameService then
			return "game" .. nextFunc
		elseif stringLib == workspaceRef then
			return "workspace" .. nextFunc
		else
			return v21(stringLib, nextFunc)
		end
	end
end
local function v22(p1, p2)
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
	local ipairsFunc = p2 or {}
	if ipairsFunc.Prettify == nil then
		local isPrettyPrinting = ipairsFunc.PrettyPrinting == nil
	end
	local stringLib = if ipairsFunc.Prettify == nil then ipairsFunc.PrettyPrinting and ipairsFunc.PrettyPrinting else ipairsFunc.Prettify or ipairsFunc.PrettyPrinting and ipairsFunc.PrettyPrinting
	local IndentCount = ipairsFunc.IndentCount
	if not IndentCount then
		IndentCount = if stringLib then 4 else 0
	end
	local v42 = if ipairsFunc.OutputWarnings == nil then true else ipairsFunc.OutputWarnings
	local v52 = ipairsFunc.StackLimit or 500
	local isFunctionsReturnRaw = ipairsFunc.FunctionsReturnRaw == nil
	local FunctionsReturnRaw = ipairsFunc.FunctionsReturnRaw
	local gameService = if ipairsFunc.UseInstancePaths == nil then true else ipairsFunc.UseInstancePaths
	local workspaceRef = ipairsFunc._StackLevel or 1
	local mathLib = ipairsFunc._VisitedTables or {
		[p1] = true
	}
	if v52 <= workspaceRef then
		return "{--[[LuaEncode: Stack level limit of `" .. v52 .. "` reached]]}"
	else
		local v92 = if stringLib then "\n" else ""
		local v102 = if stringLib then ", " else ","
		local v112 = if stringLib then " " else ""
		local v122 = rep(" ", IndentCount)
		local v132 = stringLib and rep(v122, workspaceRef) or v122
		local v14 = #v132 > 0 and sub(v132, 1, -IndentCount - 1) or ""
		local v16 = 1
		local localTable = {}
		local function TypeCase(p1, p2)
			return localTable[p1](p2, false)
		end
		local function Args(...)
			local t2 = {}
			for tableLib, ipairsFunc in nextFunc, { ... } do
				insert(t2, (localTable[typeofFunc(ipairsFunc)](ipairsFunc, false)))
			end
			return concat(t2, v102)
		end
		local function Params(p1, p2)
			return "(function(v, p) for pn, pv in next, p do v[pn] = pv end return v end)(" .. concat({ p1, (localTable.table(p2, false)) }, v102) .. ")"
		end
		function localTable.number(p1, p2)
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
		function localTable.string(p1, p2)
			if p2 and (not metatableTable[p1] and match(p1, "^[A-Za-z_][A-Za-z0-9_]*$")) then
				return p1, true
			else
				return SerializeString(p1)
			end
		end
		function localTable.table(p12, p2)
			if mathLib[p12] then
				return format("{--[[LuaEncode: Duplicate reference%s]]}", if p12 == p1 then " (of parent)" else "")
			else
				mathLib[p12] = true
				local nextFunc = v19(ipairsFunc)
				nextFunc.Prettify = stringLib
				nextFunc.IndentCount = if p2 then if stringLib then 1 else IndentCount or 1 else IndentCount
				nextFunc._StackLevel = if p2 then 1 else workspaceRef + 1
				nextFunc._VisitedTables = mathLib
				return v22(p12, nextFunc)
			end
		end
		function localTable.boolean(p1)
			return tostringFunc(p1)
		end
		localTable["nil"] = function(p1)
			return "nil"
		end
		localTable["function"] = function(p1)
			if FunctionsReturnRaw then
				return p1()
			else
				return "function() --[[LuaEncode: `options.FunctionsReturnRaw` false; can\'localTable serialize functions]] return end"
			end
		end
		function localTable.Axes(p1)
			local localTable = {}
			for tableLib, ipairsFunc in nextFunc, {
				["Enum.Axis.X"] = p1.X,
				["Enum.Axis.Y"] = p1.Y,
				["Enum.Axis.Z"] = p1.Z
			} do
				if ipairsFunc then
					insert(localTable, tableLib)
				end
			end
			return "Axes.new(" .. concat(localTable, v102) .. ")"
		end
		function localTable.BrickColor(p1)
			local ipairsFunc = stringLib
			if ipairsFunc then
				ipairsFunc = localTable.string(p1.Name, false)
			end
			return "BrickColor.new(" .. ipairsFunc or p1.Number .. ")"
		end
		function localTable.CFrame(p1)
			return "CFrame.new(" .. Args(p1:components()) .. ")"
		end
		function localTable.CatalogSearchParams(p1)
			return "(function(v, p) for pn, pv in next, p do v[pn] = pv end return v end)(" .. concat({ "CatalogSearchParams.new()", (localTable.table({
					SearchKeyword = p1.SearchKeyword,
					MinPrice = p1.MinPrice,
					MaxPrice = p1.MaxPrice,
					SortType = p1.SortType,
					CategoryFilter = p1.CategoryFilter,
					BundleTypes = p1.BundleTypes,
					AssetTypes = p1.AssetTypes
				}, false)) }, v102) .. ")"
		end
		function localTable.Color3(p1)
			return "Color3.new(" .. Args(p1.R, p1.G, p1.B)
		end
		function localTable.ColorSequence(p1)
			return "ColorSequence.new(" .. localTable.table(p1.Keypoints, false) .. ")"
		end
		function localTable.ColorSequenceKeypoint(p1)
			return "ColorSequenceKeypoint.new(" .. Args(p1.Time, p1.Value) .. ")"
		end
		function localTable.DateTime(p1)
			return "DateTime.fromUnixTimestamp(" .. p1.UnixTimestamp .. ")"
		end
		function localTable.DockWidgetPluginGuiInfo(p1)
			local tableLib = tostringFunc(p1)
			return "DockWidgetPluginGuiInfo.new(" .. Args(Enum.InitialDockState[match(tableLib, "InitialDockState:(%w+)")], match(tableLib, "InitialEnabled:(%w+)") == "1", match(tableLib, "InitialEnabledShouldOverrideRestore:(%w+)") == "1", tonumberFunc(match(tableLib, "FloatingXSize:(%w+)")), tonumberFunc(match(tableLib, "FloatingYSize:(%w+)")), tonumberFunc(match(tableLib, "MinWidth:(%w+)")), (tonumberFunc(match(tableLib, "MinHeight:(%w+)")))) .. ")"
		end
		function localTable.Enum(p1)
			return "Enum." .. tostringFunc(p1)
		end
		function localTable.EnumItem(p1)
			return tostringFunc(p1)
		end
		function localTable.Enums(p1)
			return "Enum"
		end
		function localTable.Faces(p1)
			local localTable = {}
			for tableLib, ipairsFunc in nextFunc, {
				["Enum.NormalId.Top"] = p1.Top,
				["Enum.NormalId.Bottom"] = p1.Bottom,
				["Enum.NormalId.Left"] = p1.Left,
				["Enum.NormalId.Right"] = p1.Right,
				["Enum.NormalId.Back"] = p1.Back,
				["Enum.NormalId.Front"] = p1.Front
			} do
				if ipairsFunc then
					insert(localTable, tableLib)
				end
			end
			return "Faces.new(" .. concat(localTable, v102) .. ")"
		end
		function localTable.FloatCurveKey(p1)
			return "FloatCurveKey.new(" .. Args(p1.Time, p1.Value, p1.Interpolation) .. ")"
		end
		function localTable.Font(p1)
			return "Font.new(" .. Args(p1.Family, p1.Weight, p1.Style) .. ")"
		end
		function localTable.Instance(p1)
			local tableLib, ipairsFunc, stringLib, nextFunc, pcallFunc
			if gameService then
				local v62 = v21(p1)
				if v62 then
					return v62
				else
					tableLib = v112
					ipairsFunc = p1.ClassName
					stringLib = "Instance.new(" .. localTable.string(ipairsFunc, false) .. ")"
					nextFunc = ""
					pcallFunc = "nil"
					for workspaceRef in gmatch(stringLib, "%](=*)%]") do
						if #nextFunc <= #workspaceRef then
							nextFunc = workspaceRef .. "="
						end
					end
					return pcallFunc .. v112 .. "--[" .. nextFunc .. "[" .. stringLib .. "]" .. nextFunc .. "]"
				end
			else
				tableLib = v112
				ipairsFunc = p1.ClassName
				stringLib = "Instance.new(" .. localTable.string(ipairsFunc, false) .. ")"
				nextFunc = ""
				pcallFunc = "nil"
				for workspaceRef in gmatch(stringLib, "%](=*)%]") do
					if #nextFunc <= #workspaceRef then
						nextFunc = workspaceRef .. "="
					end
				end
				return pcallFunc .. v112 .. "--[" .. nextFunc .. "[" .. stringLib .. "]" .. nextFunc .. "]"
			end
		end
		function localTable.NumberRange(p1)
			return "NumberRange.new(" .. Args(p1.Min, p1.Max) .. ")"
		end
		function localTable.NumberSequence(p1)
			return "NumberSequence.new(" .. localTable.table(p1.Keypoints, false) .. ")"
		end
		function localTable.NumberSequenceKeypoint(p1)
			return "NumberSequenceKeypoint.new(" .. Args(p1.Time, p1.Value, p1.Envelope) .. ")"
		end
		function localTable.OverlapParams(p1)
			return "(function(v, p) for pn, pv in next, p do v[pn] = pv end return v end)(" .. concat({ "OverlapParams.new()", (localTable.table({
					FilterDescendantsInstances = p1.FilterDescendantsInstances,
					FilterType = p1.FilterType,
					MaxParts = p1.MaxParts,
					CollisionGroup = p1.CollisionGroup,
					RespectCanCollide = p1.RespectCanCollide
				}, false)) }, v102) .. ")"
		end
		function localTable.PathWaypoint(p1)
			return "PathWaypoint.new(" .. Args(p1.Position, p1.Action, p1.Label) .. ")"
		end
		function localTable.PhysicalProperties(p1)
			return "PhysicalProperties.new(" .. Args(p1.Density, p1.Friction, p1.Elasticity, p1.FrictionWeight, p1.ElasticityWeight) .. ")"
		end
		function localTable.Random()
			return "Random.new()"
		end
		function localTable.Ray(p1)
			return "Ray.new(" .. Args(p1.Origin, p1.Direction) .. ")"
		end
		function localTable.RaycastParams(p1)
			return "(function(v, p) for pn, pv in next, p do v[pn] = pv end return v end)(" .. concat({ "RaycastParams.new()", (localTable.table({
					FilterDescendantsInstances = p1.FilterDescendantsInstances,
					FilterType = p1.FilterType,
					IgnoreWater = p1.IgnoreWater,
					CollisionGroup = p1.CollisionGroup,
					RespectCanCollide = p1.RespectCanCollide
				}, false)) }, v102) .. ")"
		end
		function localTable.Rect(p1)
			return "Rect.new(" .. Args(p1.Min, p1.Max) .. ")"
		end
		function localTable.Region3(p1)
			local tableLib = p1.CFrame
			local Size = p1.Size
			return "Region3.new(" .. Args(tableLib * CFrame.new(-Size / 2), tableLib * CFrame.new(Size / 2)) .. ")"
		end
		function localTable.Region3int16(p1)
			return "Region3int16.new(" .. Args(p1.Min, p1.Max) .. ")"
		end
		function localTable.TweenInfo(p1)
			return "TweenInfo.new(" .. Args(p1.Time, p1.EasingStyle, p1.EasingDirection, p1.RepeatCount, p1.Reverses, p1.DelayTime) .. ")"
		end
		function localTable.RotationCurveKey(p1)
			return "RotationCurveKey.new(" .. Args(p1.Time, p1.Value, p1.Interpolation) .. ")"
		end
		function localTable.UDim(p1)
			return "UDim.new(" .. Args(p1.Scale, p1.Offset) .. ")"
		end
		function localTable.UDim2(p1)
			return "UDim2.new(" .. Args(p1.X.Scale, p1.X.Offset, p1.Y.Scale, p1.Y.Offset) .. ")"
		end
		function localTable.Vector2(p1)
			return "Vector2.new(" .. Args(p1.X, p1.Y) .. ")"
		end
		function localTable.Vector2int16(p1)
			return "Vector2int16.new(" .. Args(p1.X, p1.Y) .. ")"
		end
		function localTable.Vector3(p1)
			return "Vector3.new(" .. Args(p1.X, p1.Y, p1.Z) .. ")"
		end
		function localTable.Vector3int16(p1)
			return "Vector3int16.new(" .. Args(p1.X, p1.Y, p1.Z) .. ")"
		end
		function localTable.userdata(p1)
			if getmetatableFunc(p1) then
				return "newproxy(true)"
			else
				return "newproxy()"
			end
		end
		local v17 = ""
		for v25, v26 in nextFunc, p1 do
			local v18, v192, v20, v212, v222, v23, v24
			local v27 = typeofFunc(v25)
			local v28 = typeofFunc(v26)
			if localTable[v27] and localTable[v28] then
				v18 = stringLib and v92 .. v132 or ""
				local v29 = false
				local v30, v31, v32 = pcallFunc(localTable[v27], v25, true)
				local v33, v34 = pcallFunc(localTable[v28], v26, false)
				if v30 and (v33 and v34) then
					if v31 then
						v192 = if v32 and v31 then v31 else format("[%s]", v31)
						v20 = if stringLib then " = " else "="
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
				if nextFunc(p1, v25) then
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