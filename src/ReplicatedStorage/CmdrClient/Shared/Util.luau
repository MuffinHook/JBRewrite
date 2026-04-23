local TextService = game:GetService("TextService")
local t = {
	MakeDictionary = function(p1) --[[ Name: MakeDictionary | Line: 17 ]]
		local t = {}
		for i = 1, #p1 do
			t[p1[i]] = true
		end
		return t
	end,
	DictionaryKeys = function(p1) --[[ Name: DictionaryKeys | Line: 30 ]]
		local t = {}
		for k in pairs(p1) do
			table.insert(t, k)
		end
		return t
	end
}
local function transformInstanceSet(p1) --[[ Line: 41 ]]
	local t = {}
	for i = 1, #p1 do
		t[i] = p1[i].Name
	end
	return t, p1
end
function t.MakeFuzzyFinder(p1) --[[ Line: 59 ]]
	local v1 = nil
	local t = {}
	if typeof(p1) == "Enum" then
		p1 = p1:GetEnumItems()
	end
	if typeof(p1) == "Instance" then
		local v3 = p1:GetChildren()
		local t2 = {}
		for i = 1, #v3 do
			t2[i] = v3[i].Name
		end
		t = v3
		v1 = t2
	elseif typeof(p1) == "table" then
		local v5, v6
		if typeof(p1[1]) == "Instance" then
			v5 = p1
			v6 = {}
			for j = 1, #p1 do
				v6[j] = v5[j].Name
			end
			t = v5
			v1 = v6
		else
			if typeof(p1[1]) == "EnumItem" or typeof(p1[1]) == "table" and typeof(p1[1].Name) == "string" then
				v5 = p1
				v6 = {}
				for j = 1, #p1 do
					v6[j] = v5[j].Name
				end
				t = v5
				v1 = v6
			else
				local v9
				v9 = p1[1]
				if type(v9) == "string" then
					v1 = p1
				elseif p1[1] == nil then
					v1 = {}
				else
					error("[Cmdr] MakeFuzzyFinder only accepts tables of instances or strings.")
				end
			end
		end
	else
		error("[Cmdr] MakeFuzzyFinder only accepts a table, Enum, or Instance.")
	end
	return function(p1, p2, p3) --[[ Line: 88 | Upvalues: v1 (ref), t (ref) ]]
		local t2 = {}
		for k, v in pairs(v1) do
			local v12 = t and t[k] or v
			if v:lower() == p1:lower() then
				if p2 then
					return v12
				end
				table.insert(t2, 1, v12)
			elseif p3 then
				if v:lower():sub(1, #p1) == p1:lower() then
					t2[#t2 + 1] = v12
				end
			elseif v:lower():find(p1:lower(), 1, true) then
				t2[#t2 + 1] = v12
			end
		end
		if p2 then
			return t2[1]
		else
			return t2
		end
	end
end
function t.GetNames(p1) --[[ Line: 124 ]]
	local t = {}
	for i = 1, #p1 do
		local v1 = p1[i].Name
		if not v1 then
			v1 = tostring(p1[i])
		end
		t[i] = v1
	end
	return t
end
function t.SplitStringSimple(p1, p2) --[[ Line: 137 ]]
	if p2 == nil then
		p2 = "%s"
	end
	local t = {}
	local count = 1
	for v1 in string.gmatch(p1, "([^" .. p2 .. "]+)") do
		t[count] = v1
		count = count + 1
	end
	return t
end
local function charCode(p1) --[[ Line: 150 ]]
	return utf8.char((tonumber(p1, 16)))
end
function t.ParseEscapeSequences(p1) --[[ Line: 157 | Upvalues: charCode (copy) ]]
	return p1:gsub("\\(.)", {
		t = "\t",
		n = "\n"
	}):gsub("\\u(%x%x%x%x)", charCode):gsub("\\x(%x%x)", charCode)
end
function t.EncodeEscapedOperator(p1, p2) --[[ Line: 169 ]]
	return p1:gsub("(" .. ("%" .. p2:sub(1, 1)) .. "+)(" .. p2:gsub(".", "%%%1") .. ")", function(p1, p2) --[[ Line: 174 ]]
		return (p1:sub(1, #p1 - 1) .. p2):gsub(".", function(p1) --[[ Line: 175 ]]
			return "\\u" .. string.format("%04x", string.byte(p1), 16)
		end)
	end)
end
local t2 = { "&&", "||", ";" }
function t.EncodeEscapedOperators(p1) --[[ Line: 185 | Upvalues: t2 (copy), t (copy) ]]
	for i, v in ipairs(t2) do
		p1 = t.EncodeEscapedOperator(p1, v)
	end
	return p1
end
local function encodeControlChars(p1) --[[ Line: 193 ]]
	return p1:gsub("\\\\", "___!CMDR_ESCAPE!___"):gsub("\\\"", "___!CMDR_QUOTE!___"):gsub("\\\'", "___!CMDR_SQUOTE!___"):gsub("\\\n", "___!CMDR_NL!___")
end
local function decodeControlChars(p1) --[[ Line: 202 ]]
	return p1:gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n")
end
function t.SplitString(p1, p2) --[[ Line: 209 | Upvalues: t (copy) ]]
	local v1 = nil
	local v2 = nil
	local t2 = {}
	local v3 = p2 or (1 / 0)
	for v5 in p1:gsub("\\\\", "___!CMDR_ESCAPE!___"):gsub("\\\"", "___!CMDR_QUOTE!___"):gsub("\\\'", "___!CMDR_SQUOTE!___"):gsub("\\\n", "___!CMDR_NL!___"):gmatch("[^ ]+") do
		local v4
		local v6 = t.ParseEscapeSequences(v5)
		local v7 = v6:match("^([\'\"])")
		local v8 = v6:match("([\'\"])$")
		local v9 = v6:match("(\\*)[\'\"]$")
		if v7 and not (v1 or v8) then
			v2 = v6
			v1 = v7
			v5 = v6
		elseif v2 and (v8 == v1 and #v9 % 2 == 0) then
			v2 = nil
			v1 = nil
			v5 = v2 .. " " .. v6
		elseif v2 then
			v2, v5 = v2 .. " " .. v6, v6
		else
			v5 = v6
		end
		if not v2 then
			v4 = if v3 < #t2 then 0 else 1
			t2[#t2 + v4] = v5:gsub("^([\'\"])", ""):gsub("([\'\"])$", ""):gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n")
		end
	end
	if v2 then
		t2[#t2 + if v3 < #t2 then 0 else 1] = v2:gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n")
	end
	return t2
end
function t.MashExcessArguments(p1, p2) --[[ Line: 242 ]]
	local t = {}
	for i = 1, #p1 do
		if p2 < i then
			t[p2] = ("%s %s"):format(t[p2] or "", p1[i])
		else
			t[i] = p1[i]
		end
	end
	return t
end
function t.TrimString(p1) --[[ Line: 257 ]]
	local _, v1 = string.find(p1, "^%s*")
	if v1 == #p1 then
		return ""
	else
		return string.match(p1, ".*%S", v1 + 1)
	end
end
function t.GetTextSize(p1, p2, p3) --[[ Line: 266 | Upvalues: TextService (copy) ]]
	return TextService:GetTextSize(p1, p2.TextSize, p2.Font, p3 or Vector2.new(p2.AbsoluteSize.X, 0))
end
function t.MakeEnumType(p1, p2) --[[ Line: 274 | Upvalues: t (copy) ]]
	local v1 = t.MakeFuzzyFinder(p2)
	return {
		Validate = function(p12) --[[ Name: Validate | Line: 277 | Upvalues: v1 (copy), p1 (copy) ]]
			return v1(p12, true) ~= nil, ("Value %q is not a valid %s."):format(p12, p1)
		end,
		Autocomplete = function(p1) --[[ Name: Autocomplete | Line: 280 | Upvalues: v1 (copy), t (ref) ]]
			local v12 = v1(p1)
			return if type(v12[1]) == "string" then v12 else t.GetNames(v12) or v12
		end,
		Parse = function(p1) --[[ Name: Parse | Line: 284 | Upvalues: v1 (copy) ]]
			return v1(p1, true)
		end
	}
end
function t.ParsePrefixedUnionType(p1, p2) --[[ Line: 293 | Upvalues: t (copy) ]]
	local v1 = t.SplitStringSimple(p1)
	local t2 = {}
	for i = 1, #v1, 2 do
		t2[#t2 + 1] = {
			prefix = v1[i - 1] or "",
			type = v1[i]
		}
	end
	table.sort(t2, function(p1, p2) --[[ Line: 305 ]]
		return #p1.prefix > #p2.prefix
	end)
	for j = 1, #t2 do
		local v2 = t2[j]
		if p2:sub(1, #v2.prefix) == v2.prefix then
			return v2.type, p2:sub(#v2.prefix + 1), v2.prefix
		end
	end
end
function t.MakeListableType(p1, p2) --[[ Line: 325 ]]
	local t = {
		Listable = true,
		Transform = p1.Transform,
		Validate = p1.Validate,
		ValidateOnce = p1.ValidateOnce,
		Autocomplete = p1.Autocomplete,
		Default = p1.Default,
		ArgumentOperatorAliases = p1.ArgumentOperatorAliases,
		Parse = function(...) --[[ Name: Parse | Line: 334 | Upvalues: p1 (copy) ]]
			return { p1.Parse(...) }
		end
	}
	if p2 then
		for k, v in pairs(p2) do
			t[k] = v
		end
	end
	return t
end
local function encodeCommandEscape(p1) --[[ Line: 348 ]]
	return p1:gsub("\\%$", "___!CMDR_DOLLAR!___")
end
local function decodeCommandEscape(p1) --[[ Line: 352 ]]
	return p1:gsub("___!CMDR_DOLLAR!___", "$")
end
function t.RunCommandString(p1, p2) --[[ Line: 361 | Upvalues: t (copy) ]]
	local v2 = t.EncodeEscapedOperators((t.ParseEscapeSequences(p2))):split("&&")
	local v3 = ""
	for i, v in ipairs(v2) do
		local v4 = v3:gsub("%$", "\\x24"):gsub("%%", "%%%%")
		local v9 = tostring(p1:EvaluateAndRun((t.RunEmbeddedCommands(p1, (v:gsub("||", v3:find("%s") and ("%q"):format(v4) or v4))))))
		if i == #v2 then
			return v9
		end
		v3 = v9
	end
end
function t.RunEmbeddedCommands(p1, p2) --[[ Line: 386 | Upvalues: t (copy) ]]
	local v1 = p2:gsub("\\%$", "___!CMDR_DOLLAR!___")
	local t2, v2 = {}, v1
	for v4 in v1:gmatch("$(%b{})") do
		local v3
		local v5 = v4:sub(2, #v4 - 1)
		if v5:match("^{.+}$") then
			v5, v3 = v5:sub(2, #v5 - 1), false
		else
			v3 = true
		end
		t2[v4] = t.RunCommandString(p1, v5)
		if v3 and (t2[v4]:find("%s") or t2[v4] == "") then
			t2[v4] = string.format("%q", t2[v4])
		end
	end
	return v2:gsub("$(%b{})", t2):gsub("___!CMDR_DOLLAR!___", "$")
end
function t.SubstituteArgs(p1, p2) --[[ Line: 417 ]]
	local v1 = p1:gsub("\\%$", "___!CMDR_DOLLAR!___")
	local v2
	if type(p2) == "table" then
		v2 = v1
		for i = 1, #p2 do
			local v3 = tostring(i)
			p2[v3] = p2[i]
			if p2[v3]:find("%s") then
				p2[v3] = string.format("%q", p2[v3])
			end
		end
	else
		v2 = v1
	end
	return v2:gsub("($%d+)%b{}", "%1"):gsub("$(%w+)", p2):gsub("___!CMDR_DOLLAR!___", "$")
end
function t.MakeAliasCommand(p1, p2) --[[ Line: 437 | Upvalues: t (copy) ]]
	local v1, v2 = unpack(p1:split("|"))
	local v3 = t.EncodeEscapedOperators(p2)
	local t2 = {}
	local t3 = {}
	for v10 in v3:gmatch("$(%d+)") do
		local v4, v5, v6, v7, v8, v9
		if t2[v10] == nil then
			t2[v10] = true
			local v11 = v3:match((("$%*(%%b{})"):format(v10)))
			if v11 then
				local v13, v14, v15 = unpack(v11:sub(2, #v11 - 1):split("|"))
				v4 = v13
				v5 = v14
				v6 = v15
			else
				v4 = nil
				v5 = nil
				v6 = nil
			end
			v7 = v4 and (v4:match("%?$") and true or false)
			v8 = if v4 then v4:match("^%w+") else "string"
			v9 = v5 or ("Argument %*"):format(v10)
			table.insert(t3, {
				Type = v8,
				Name = v9,
				Description = v6 or "",
				Optional = v7
			})
		end
	end
	return {
		Name = v1,
		Aliases = {},
		Description = ("<Alias> %*"):format(v2 or v3),
		Group = "UserAlias",
		Args = t3,
		ClientRun = function(p1) --[[ Name: ClientRun | Line: 476 | Upvalues: t (ref), v3 (ref) ]]
			return t.RunCommandString(p1.Dispatcher, t.SubstituteArgs(v3, p1.RawArguments))
		end
	}
end
function t.MakeSequenceType(p1) --[[ Line: 490 | Upvalues: t (copy) ]]
	local v2 = p1 or {}
	assert(if v2.Parse == nil then v2.Constructor ~= nil else true, "[Cmdr] MakeSequenceType: Must provide one of: Constructor, Parse")
	v2.TransformEach = v2.TransformEach or function(...) --[[ Line: 498 ]]
		return ...
	end
	v2.ValidateEach = v2.ValidateEach or function() --[[ Line: 502 ]]
		return true
	end
	local t2 = {
		Prefixes = v2.Prefixes,
		Transform = function(p1) --[[ Name: Transform | Line: 509 | Upvalues: t (ref), v2 (ref) ]]
			return t.Map(t.SplitPrioritizedDelimeter(p1, { ",", "%s" }), function(p1) --[[ Line: 510 | Upvalues: v2 (ref) ]]
				return v2.TransformEach(p1)
			end)
		end,
		Validate = function(p1) --[[ Name: Validate | Line: 515 | Upvalues: v2 (ref) ]]
			if v2.Length and #p1 > v2.Length then
				return false, ("Maximum of %d values allowed in sequence"):format(v2.Length)
			else
				for i = 1, v2.Length or #p1 do
					local v3, v4 = v2.ValidateEach(p1[i], i)
					if not v3 then
						return false, v4
					end
				end
				return true
			end
		end
	}
	t2.Parse = v2.Parse or function(p1) --[[ Line: 531 | Upvalues: v2 (ref) ]]
		return v2.Constructor(unpack(p1))
	end
	return t2
end
function t.SplitPrioritizedDelimeter(p1, p2) --[[ Line: 540 | Upvalues: t (copy) ]]
	for i, v in ipairs(p2) do
		if p1:find(v) or i == #p2 then
			return t.SplitStringSimple(p1, v)
		end
	end
end
function t.Map(p1, p2) --[[ Line: 552 ]]
	local t = {}
	for i, v in ipairs(p1) do
		t[i] = p2(v, i)
	end
	return t
end
function t.Each(p1, ...) --[[ Line: 563 ]]
	local t = {}
	for i, v in ipairs({ ... }) do
		t[i] = p1(v)
	end
	return unpack(t)
end
function t.EmulateTabstops(p1, p2) --[[ Line: 572 ]]
	local v1 = #p1
	local v2 = table.create(v1)
	local sum = 0
	for i = 1, v1 do
		local v3 = string.sub(p1, i, i)
		if v3 == "\t" then
			local v4 = p2 - sum % p2
			table.insert(v2, string.rep(" ", v4))
			sum = sum + v4
		else
			table.insert(v2, v3)
			if v3 == "\n" then
				sum = 0
			elseif v3 ~= "\r" then
				sum = sum + 1
			end
		end
	end
	return table.concat(v2)
end
function t.Mutex() --[[ Line: 594 ]]
	local t = {}
	local v1 = false
	return function() --[[ Line: 598 | Upvalues: v1 (ref), t (copy) ]]
		if v1 then
			table.insert(t, coroutine.running())
			coroutine.yield()
		else
			v1 = true
		end
		return function() --[[ Line: 606 | Upvalues: t (ref), v1 (ref) ]]
			if #t > 0 then
				coroutine.resume(table.remove(t, 1))
			else
				v1 = false
			end
		end
	end
end
return t