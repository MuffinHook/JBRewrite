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
for keyword, keywordValue in nextFunc, {
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
	metatableTable[keywordValue] = true
end
local tableFind = tableLib.find or function(searchTable, searchValue)
	for index, element in ipairsFunc(searchTable) do
		if element == searchValue then
			return index
		end
	end
end
local tableClone = tableLib.clone or function(sourceTable)
	local clonedTable = {}
	for key, value in nextFunc, sourceTable do
		clonedTable[key] = value
	end
	return clonedTable
end
local function CheckType(inputValue, paramName, ...)
	local expectedTypes = { ... }
	local actualType = typeofFunc(inputValue)
	if not tableFind(expectedTypes, actualType) then
		error(format("LuaEncode: Incorrect type for `%s`: `%s` expected, got `%s`", paramName, concat(expectedTypes, ", "), actualType), 0)
	end
	return inputValue
end
local escapeMap = {
	["\""] = "\\\"",
	["\\"] = "\\\\",
	["\7"] = "\\a",
	["\8"] = "\\b",
	["\\localTable"] = "\\\\localTable",
	["\n"] = "\\n",
	["\11"] = "\\v",
	["\f"] = "\\f",
	["\r"] = "\\r"
}
for i = 0, 255 do
	local charCode = char(i)
	if not escapeMap[charCode] and (i < 32 or i > 126) then
		escapeMap[charCode] = "\\" .. i
	end
end
local function SerializeString(inputString)
	return "\"" .. gsub(inputString, "[%z\\\"\1-\31\127-\255]", escapeMap) .. "\""
end
local function CommentBlock(content)
	local equalCount = ""
	for equalsFound in gmatch(content, "%](=*)%]") do
		if #equalCount <= #equalsFound then
			equalCount = equalsFound .. "="
		end
	end
	return "--[" .. equalCount .. "[" .. content .. "]" .. equalCount .. "]"
end
local function IsService(className)
	local isValid, service = pcallFunc(gameService.FindService, gameService, className.ClassName)
	return isValid and service and true or false
end
local function getInstancePath(instance, suffix)
	local pathSuffix = suffix or ""
	local instanceName = instance.Name
	local className = instance.ClassName
	local parentRef = instance.Parent
	local pathPart
	if parentRef == gameService then
		local isService, serviceRef = pcallFunc(gameService.FindService, gameService, instance.ClassName)
		pathPart = if isService and serviceRef and true or false then ":GetService(" .. SerializeString(className) .. ")" .. pathSuffix elseif metatableTable[instanceName] or not match(instanceName, "^[A-Za-z_][A-Za-z0-9_]*$") then "[" .. SerializeString(instanceName) .. "]" .. pathSuffix else "." .. instanceName .. pathSuffix
	else
		pathPart = if metatableTable[instanceName] or not match(instanceName, "^[A-Za-z_][A-Za-z0-9_]*$") then "[" .. SerializeString(instanceName) .. "]" .. pathSuffix else "." .. instanceName .. pathSuffix
	end
	if parentRef then
		if parentRef == gameService then
			return "game" .. pathPart
		elseif parentRef == workspaceRef then
			return "workspace" .. pathPart
		else
			return getInstancePath(parentRef, pathPart)
		end
	end
end
local function encode(inputTable, options)
	CheckType(inputTable, "inputTable", "table")
	CheckType(options, "options", "table", "nil")
	if options then
		CheckType(options.Prettify, "options.Prettify", "boolean", "nil")
		CheckType(options.PrettyPrinting, "options.PrettyPrinting", "boolean", "nil")
		CheckType(options.IndentCount, "options.IndentCount", "number", "nil")
		CheckType(options.OutputWarnings, "options.OutputWarnings", "boolean", "nil")
		CheckType(options.StackLimit, "options.StackLimit", "number", "nil")
		CheckType(options.FunctionsReturnRaw, "options.FunctionsReturnRaw", "boolean", "nil")
		CheckType(options.UseInstancePaths, "options.UseInstancePaths", "boolean", "nil")
		CheckType(options._StackLevel, "options._StackLevel", "number", "nil")
		CheckType(options._VisitedTables, "options._StackLevel", "table", "nil")
	end
	local mergedOptions = options or {}
	if mergedOptions.Prettify == nil then
		local isPrettyPrinting = mergedOptions.PrettyPrinting == nil
	end
	local shouldPrettify = if mergedOptions.Prettify == nil then mergedOptions.PrettyPrinting and mergedOptions.PrettyPrinting else mergedOptions.Prettify or mergedOptions.PrettyPrinting and mergedOptions.PrettyPrinting
	local IndentCount = mergedOptions.IndentCount
	if not IndentCount then
		IndentCount = if shouldPrettify then 4 else 0
	end
	local shouldOutputWarnings = if mergedOptions.OutputWarnings == nil then true else mergedOptions.OutputWarnings
	local stackLimit = mergedOptions.StackLimit or 500
	local isFunctionsReturnRaw = mergedOptions.FunctionsReturnRaw == nil
	local FunctionsReturnRaw = mergedOptions.FunctionsReturnRaw
	local shouldUseInstancePaths = if mergedOptions.UseInstancePaths == nil then true else mergedOptions.UseInstancePaths
	local currentStackLevel = mergedOptions._StackLevel or 1
	local visitedTables = mergedOptions._VisitedTables or {
		[inputTable] = true
	}
	if stackLimit <= currentStackLevel then
		return "{--[[LuaEncode: Stack level limit of `" .. stackLimit .. "` reached]]}"
	else
		local newline = if shouldPrettify then "\n" else ""
		local separator = if shouldPrettify then ", " else ","
		local space = if shouldPrettify then " " else ""
		local indentStr = rep(" ", IndentCount)
		local currentIndent = shouldPrettify and rep(indentStr, currentStackLevel) or indentStr
		local previousIndent = #currentIndent > 0 and sub(currentIndent, 1, -IndentCount - 1) or ""
		local sequenceIndex = 1
		local localTable = {}
		local function TypeCase(typeKey, value)
			return localTable[typeKey](value, false)
		end
		local function Args(...)
			local argsList = {}
			for index, argValue in nextFunc, { ... } do
				insert(argsList, (localTable[typeofFunc(argValue)](argValue, false)))
			end
			return concat(argsList, separator)
		end
		local function Params(initValue, paramsTable)
			return "(function(v, p) for pn, pv in next, p do v[pn] = pv end return v end)(" .. concat({ initValue, (localTable.table(paramsTable, false)) }, separator) .. ")"
		end
		function localTable.number(numValue, isSequence)
			if isSequence and numValue == sequenceIndex then
				sequenceIndex = sequenceIndex + 1
				return nil, true
			elseif numValue == huge then
				return "math.huge"
			elseif numValue == -huge then
				return "-math.huge"
			else
				return format("%.14g", numValue)
			end
		end
		function localTable.string(strValue, isKey)
			if isKey and (not metatableTable[strValue] and match(strValue, "^[A-Za-z_][A-Za-z0-9_]*$")) then
				return strValue, true
			else
				return SerializeString(strValue)
			end
		end
		function localTable.table(tableInput, isSequence)
			if visitedTables[tableInput] then
				return format("{--[[LuaEncode: Duplicate reference%s]]}", if tableInput == inputTable then " (of parent)" else "")
			else
				visitedTables[tableInput] = true
				local nextOptions = tableClone(mergedOptions)
				nextOptions.Prettify = shouldPrettify
				nextOptions.IndentCount = if isSequence then if shouldPrettify then 1 else IndentCount or 1 else IndentCount
				nextOptions._StackLevel = if isSequence then 1 else currentStackLevel + 1
				nextOptions._VisitedTables = visitedTables
				return encode(tableInput, nextOptions)
			end
		end
		function localTable.boolean(boolValue)
			return tostringFunc(boolValue)
		end
		localTable["nil"] = function(nilValue)
			return "nil"
		end
		localTable["function"] = function(funcValue)
			if FunctionsReturnRaw then
				return funcValue()
			else
				return "function() --[[LuaEncode: `options.FunctionsReturnRaw` false; can\'localTable serialize functions]] return end"
			end
		end
		function localTable.Axes(axesValue)
			local axesList = {}
			for axisName, isActive in nextFunc, {
				["Enum.Axis.X"] = axesValue.X,
				["Enum.Axis.Y"] = axesValue.Y,
				["Enum.Axis.Z"] = axesValue.Z
			} do
				if isActive then
					insert(axesList, axisName)
				end
			end
			return "Axes.new(" .. concat(axesList, separator) .. ")"
		end
		function localTable.BrickColor(colorValue)
			local colorStr = shouldPrettify
			if colorStr then
				colorStr = localTable.string(colorValue.Name, false)
			end
			return "BrickColor.new(" .. colorStr or colorValue.Number .. ")"
		end
		function localTable.CFrame(frameValue)
			return "CFrame.new(" .. Args(frameValue:components()) .. ")"
		end
		function localTable.CatalogSearchParams(paramsValue)
			return "(function(v, p) for pn, pv in next, p do v[pn] = pv end return v end)(" .. concat({ "CatalogSearchParams.new()", (localTable.table({
					SearchKeyword = paramsValue.SearchKeyword,
					MinPrice = paramsValue.MinPrice,
					MaxPrice = paramsValue.MaxPrice,
					SortType = paramsValue.SortType,
					CategoryFilter = paramsValue.CategoryFilter,
					BundleTypes = paramsValue.BundleTypes,
					AssetTypes = paramsValue.AssetTypes
				}, false)) }, separator) .. ")"
		end
		function localTable.Color3(colorValue)
			return "Color3.new(" .. Args(colorValue.R, colorValue.G, colorValue.B)
		end
		function localTable.ColorSequence(seqValue)
			return "ColorSequence.new(" .. localTable.table(seqValue.Keypoints, false) .. ")"
		end
		function localTable.ColorSequenceKeypoint(keypointValue)
			return "ColorSequenceKeypoint.new(" .. Args(keypointValue.Time, keypointValue.Value) .. ")"
		end
		function localTable.DateTime(dtValue)
			return "DateTime.fromUnixTimestamp(" .. dtValue.UnixTimestamp .. ")"
		end
		function localTable.DockWidgetPluginGuiInfo(guiInfoValue)
			local guiStr = tostringFunc(guiInfoValue)
			return "DockWidgetPluginGuiInfo.new(" .. Args(Enum.InitialDockState[match(guiStr, "InitialDockState:(%w+)")], match(guiStr, "InitialEnabled:(%w+)") == "1", match(guiStr, "InitialEnabledShouldOverrideRestore:(%w+)") == "1", tonumberFunc(match(guiStr, "FloatingXSize:(%w+)")), tonumberFunc(match(guiStr, "FloatingYSize:(%w+)")), tonumberFunc(match(guiStr, "MinWidth:(%w+)")), (tonumberFunc(match(guiStr, "MinHeight:(%w+)")))) .. ")"
		end
		function localTable.Enum(enumValue)
			return "Enum." .. tostringFunc(enumValue)
		end
		function localTable.EnumItem(itemValue)
			return tostringFunc(itemValue)
		end
		function localTable.Enums(enumsValue)
			return "Enum"
		end
		function localTable.Faces(facesValue)
			local facesList = {}
			for faceName, isActive in nextFunc, {
				["Enum.NormalId.Top"] = facesValue.Top,
				["Enum.NormalId.Bottom"] = facesValue.Bottom,
				["Enum.NormalId.Left"] = facesValue.Left,
				["Enum.NormalId.Right"] = facesValue.Right,
				["Enum.NormalId.Back"] = facesValue.Back,
				["Enum.NormalId.Front"] = facesValue.Front
			} do
				if isActive then
					insert(facesList, faceName)
				end
			end
			return "Faces.new(" .. concat(facesList, separator) .. ")"
		end
		function localTable.FloatCurveKey(keyValue)
			return "FloatCurveKey.new(" .. Args(keyValue.Time, keyValue.Value, keyValue.Interpolation) .. ")"
		end
		function localTable.Font(fontValue)
			return "Font.new(" .. Args(fontValue.Family, fontValue.Weight, fontValue.Style) .. ")"
		end
		function localTable.Instance(instanceValue)
			local space2, classNameStr, constructorCall, equalCount, commentStr
			if shouldUseInstancePaths then
				local instancePathStr = getInstancePath(instanceValue)
				if instancePathStr then
					return instancePathStr
				else
					space2 = space
					classNameStr = instanceValue.ClassName
					constructorCall = "Instance.new(" .. localTable.string(classNameStr, false) .. ")"
					equalCount = ""
					commentStr = "nil"
					for equalsFound in gmatch(constructorCall, "%](=*)%]") do
						if #equalCount <= #equalsFound then
							equalCount = equalsFound .. "="
						end
					end
					return commentStr .. space .. "--[" .. equalCount .. "[" .. constructorCall .. "]" .. equalCount .. "]"
				end
			else
				space2 = space
				classNameStr = instanceValue.ClassName
				constructorCall = "Instance.new(" .. localTable.string(classNameStr, false) .. ")"
				equalCount = ""
				commentStr = "nil"
				for equalsFound in gmatch(constructorCall, "%](=*)%]") do
					if #equalCount <= #equalsFound then
						equalCount = equalsFound .. "="
					end
				end
				return commentStr .. space .. "--[" .. equalCount .. "[" .. constructorCall .. "]" .. equalCount .. "]"
			end
		end
		function localTable.NumberRange(rangeValue)
			return "NumberRange.new(" .. Args(rangeValue.Min, rangeValue.Max) .. ")"
		end
		function localTable.NumberSequence(seqValue)
			return "NumberSequence.new(" .. localTable.table(seqValue.Keypoints, false) .. ")"
		end
		function localTable.NumberSequenceKeypoint(keypointValue)
			return "NumberSequenceKeypoint.new(" .. Args(keypointValue.Time, keypointValue.Value, keypointValue.Envelope) .. ")"
		end
		function localTable.OverlapParams(paramsValue)
			return "(function(v, p) for pn, pv in next, p do v[pn] = pv end return v end)(" .. concat({ "OverlapParams.new()", (localTable.table({
					FilterDescendantsInstances = paramsValue.FilterDescendantsInstances,
					FilterType = paramsValue.FilterType,
					MaxParts = paramsValue.MaxParts,
					CollisionGroup = paramsValue.CollisionGroup,
					RespectCanCollide = paramsValue.RespectCanCollide
				}, false)) }, separator) .. ")"
		end
		function localTable.PathWaypoint(waypointValue)
			return "PathWaypoint.new(" .. Args(waypointValue.Position, waypointValue.Action, waypointValue.Label) .. ")"
		end
		function localTable.PhysicalProperties(propsValue)
			return "PhysicalProperties.new(" .. Args(propsValue.Density, propsValue.Friction, propsValue.Elasticity, propsValue.FrictionWeight, propsValue.ElasticityWeight) .. ")"
		end
		function localTable.Random()
			return "Random.new()"
		end
		function localTable.Ray(rayValue)
			return "Ray.new(" .. Args(rayValue.Origin, rayValue.Direction) .. ")"
		end
		function localTable.RaycastParams(paramsValue)
			return "(function(v, p) for pn, pv in next, p do v[pn] = pv end return v end)(" .. concat({ "RaycastParams.new()", (localTable.table({
					FilterDescendantsInstances = paramsValue.FilterDescendantsInstances,
					FilterType = paramsValue.FilterType,
					IgnoreWater = paramsValue.IgnoreWater,
					CollisionGroup = paramsValue.CollisionGroup,
					RespectCanCollide = paramsValue.RespectCanCollide
				}, false)) }, separator) .. ")"
		end
		function localTable.Rect(rectValue)
			return "Rect.new(" .. Args(rectValue.Min, rectValue.Max) .. ")"
		end
		function localTable.Region3(regionValue)
			local regionCFrame = regionValue.CFrame
			local Size = regionValue.Size
			return "Region3.new(" .. Args(regionCFrame * CFrame.new(-Size / 2), regionCFrame * CFrame.new(Size / 2)) .. ")"
		end
		function localTable.Region3int16(regionValue)
			return "Region3int16.new(" .. Args(regionValue.Min, regionValue.Max) .. ")"
		end
		function localTable.TweenInfo(tweenValue)
			return "TweenInfo.new(" .. Args(tweenValue.Time, tweenValue.EasingStyle, tweenValue.EasingDirection, tweenValue.RepeatCount, tweenValue.Reverses, tweenValue.DelayTime) .. ")"
		end
		function localTable.RotationCurveKey(keyValue)
			return "RotationCurveKey.new(" .. Args(keyValue.Time, keyValue.Value, keyValue.Interpolation) .. ")"
		end
		function localTable.UDim(dimValue)
			return "UDim.new(" .. Args(dimValue.Scale, dimValue.Offset) .. ")"
		end
		function localTable.UDim2(dim2Value)
			return "UDim2.new(" .. Args(dim2Value.X.Scale, dim2Value.X.Offset, dim2Value.Y.Scale, dim2Value.Y.Offset) .. ")"
		end
		function localTable.Vector2(vecValue)
			return "Vector2.new(" .. Args(vecValue.X, vecValue.Y) .. ")"
		end
		function localTable.Vector2int16(vecValue)
			return "Vector2int16.new(" .. Args(vecValue.X, vecValue.Y) .. ")"
		end
		function localTable.Vector3(vecValue)
			return "Vector3.new(" .. Args(vecValue.X, vecValue.Y, vecValue.Z) .. ")"
		end
		function localTable.Vector3int16(vecValue)
			return "Vector3int16.new(" .. Args(vecValue.X, vecValue.Y, vecValue.Z) .. ")"
		end
		function localTable.userdata(userdataValue)
			if getmetatableFunc(userdataValue) then
				return "newproxy(true)"
			else
				return "newproxy()"
			end
		end
		local outputStr = ""
		for tableKey, tableValue in nextFunc, inputTable do
			local lineOutput, keyStr, keyFormatted, assignOp, assignmentPart, errorType, errorMsg, errorDetails, errorStr, commentContent, equalsForError, formattedError
			local keyType = typeofFunc(tableKey)
			local valueType = typeofFunc(tableValue)
			if localTable[keyType] and localTable[valueType] then
				lineOutput = shouldPrettify and newline .. currentIndent or ""
				local isValidPair = false
				local keySuccess, keyResult, keyIsKey = pcallFunc(localTable[keyType], tableKey, true)
				local valueSuccess, valueResult = pcallFunc(localTable[valueType], tableValue, false)
				if keySuccess and (valueSuccess and valueResult) then
					if keyIsKey then
						keyStr = if keyResult and keyIsKey then keyResult else format("[%s]", keyResult)
						assignOp = if shouldPrettify then " = " else "="
						assignmentPart = keyStr .. assignOp or ""
					else
						assignmentPart = ""
					end
					isValidPair = true
					lineOutput = lineOutput .. assignmentPart .. valueResult
				elseif shouldOutputWarnings then
					errorType = if keySuccess then if valueSuccess then "key/value" else "value" else "key"
					if keySuccess then
						errorDetails = valueType
						if valueSuccess then
							errorMsg = "(Failed to get error message)"
						else
							errorMsg = SerializeString(valueResult)
							if not errorMsg then
								errorMsg = "(Failed to get error message)"
							end
						end
					else
						errorMsg = SerializeString(keyResult)
						if errorMsg then
							errorDetails = valueType
						elseif valueSuccess then
							errorMsg = "(Failed to get error message)"
						else
							errorMsg = SerializeString(valueResult)
							if not errorMsg then
								errorMsg = "(Failed to get error message)"
							end
						end
					end
					local errorMessage = format("LuaEncode: Failed to encode %s of DataType `%s`: %s", errorType, errorDetails, errorMsg)
					commentContent = ""
					formattedError = lineOutput
					for equalsMarker in gmatch(errorMessage, "%](=*)%]") do
						if #commentContent <= #equalsMarker then
							commentContent = equalsMarker .. "="
						end
					end
					lineOutput = formattedError .. "--[" .. commentContent .. "[" .. errorMessage .. "]" .. commentContent .. "]"
				end
				if nextFunc(inputTable, tableKey) then
					if isValidPair then
						lineOutput = lineOutput .. ","
					end
				else
					lineOutput = lineOutput .. newline .. previousIndent
				end
				outputStr = outputStr .. lineOutput
			end
		end
		return "{" .. outputStr .. "}"
	end
end
return encode
