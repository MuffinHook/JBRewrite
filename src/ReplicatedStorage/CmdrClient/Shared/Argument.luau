-- Reviewed by Claude
local Util = require(script.Parent.Util)
local function unescapeOperators(p1)
	for i, v in ipairs({ "%.", "%?", "%*", "%*%*" }) do
		p1 = p1:gsub("\\" .. v, v:gsub("%%", ""))
	end
	return p1
end
local t = {}
t.__index = t
function t.new(p1, p2, p3)
	local t2 = {
		Command = p1,
		Type = nil,
		Name = p2.Name,
		Object = p2
	}
	t2.Required = if p2.Default == nil then p2.Optional ~= true else false
	t2.Executor = p1.Executor
	t2.RawValue = p3
	t2.RawSegments = {}
	t2.TransformedValues = {}
	t2.Prefix = ""
	t2.TextSegmentInProgress = ""
	t2.RawSegmentsAreAutocomplete = false
	if type(p2.Type) == "table" then
		t2.Type = p2.Type
	else
		local v2, v3, v4 = Util.ParsePrefixedUnionType(p1.Cmdr.Registry:GetTypeName(p2.Type), p3)
		t2.Type = p1.Dispatcher.Registry:GetType(v2)
		t2.RawValue = v3
		t2.Prefix = v4
		if t2.Type == nil then
			error(("[Cmdr] %* has an unregistered type %%q"):format(t2.Name or "none"):format(v2 or "<none>"))
		end
	end
	setmetatable(t2, t)
	t2:Transform()
	return t2
end
function t.GetDefaultAutocomplete(p1)
	if p1.Type.Autocomplete then
		local v1, v2 = p1.Type.Autocomplete(p1:TransformSegment(""))
		return v1, v2 or {}
	else
		return {}
	end
end
function t.Transform(p1)
	if #p1.TransformedValues == 0 then
		local RawValue = p1.RawValue
		if p1.Type.ArgumentOperatorAliases then
			RawValue = p1.Type.ArgumentOperatorAliases[RawValue] or RawValue
		end
		if RawValue == "." and p1.Type.Default then
			RawValue = p1.Type.Default(p1.Executor) or ""
			p1.RawSegmentsAreAutocomplete = true
		end
		if RawValue == "?" and p1.Type.Autocomplete then
			local v1, v2 = p1:GetDefaultAutocomplete()
			if not v2.IsPartial and #v1 > 0 then
				RawValue = v1[math.random(1, #v1)]
				p1.RawSegmentsAreAutocomplete = true
			end
		end
		if p1.Type.Listable and #p1.RawValue > 0 then
			local v3 = RawValue:match("^%?(%d+)$")
			if v3 then
				local v4 = tonumber(v3)
				if v4 and v4 > 0 then
					local t = {}
					local v5, v6 = p1:GetDefaultAutocomplete()
					if not v6.IsPartial and #v5 > 0 then
						for i = 1, math.min(v4, #v5) do
							local remove = table.remove
							table.insert(t, remove(v5, math.random(1, #v5)))
						end
						local v7 = table.concat(t, ",")
						p1.RawSegmentsAreAutocomplete = true
						RawValue = v7
					end
				end
			elseif RawValue == "*" or RawValue == "**" then
				local v8, v9 = p1:GetDefaultAutocomplete()
				if not v9.IsPartial and #v8 > 0 then
					if RawValue == "**" and p1.Type.Default then
						local v10 = p1.Type.Default(p1.Executor) or ""
						for i, v in ipairs(v8) do
							if v == v10 then
								table.remove(v8, i)
							end
						end
					end
					local v11 = table.concat(v8, ",")
					p1.RawSegmentsAreAutocomplete = true
					RawValue = v11
				end
			end
			local v12 = unescapeOperators(RawValue)
			local v13 = Util.SplitStringSimple(v12, ",")
			if #v13 == 0 then
				v13 = { "" }
			end
			if v12:sub(#v12, #v12) == "," then
				v13[#v13 + 1] = ""
			end
			for i, v in ipairs(v13) do
				p1.RawSegments[i] = v
				p1.TransformedValues[i] = { p1:TransformSegment(v) }
			end
			p1.TextSegmentInProgress = v13[#v13]
		else
			local v14 = unescapeOperators(RawValue)
			p1.RawSegments[1] = unescapeOperators(v14)
			p1.TransformedValues[1] = { p1:TransformSegment(v14) }
			p1.TextSegmentInProgress = p1.RawValue
		end
	end
end
function t.TransformSegment(p1, p2)
	if p1.Type.Transform then
		return p1.Type.Transform(p2, p1.Executor)
	else
		return p2
	end
end
function t.GetTransformedValue(p1, p2)
	return unpack(p1.TransformedValues[p2])
end
function t.Validate(p1, p2)
	if p1.RawValue ~= nil and (#p1.RawValue ~= 0 or p1.Required ~= false) then
		if p1.Required and (p1.RawSegments[1] == nil or #p1.RawSegments[1] == 0) then
			return false, "This argument is required."
		elseif p1.Type.Validate or p1.Type.ValidateOnce then
			for i = 1, #p1.TransformedValues do
				if p1.Type.Validate then
					local v1, v2 = p1.Type.Validate(p1:GetTransformedValue(i))
					if not v1 then
						return v1, v2 or "Invalid value"
					end
				end
				if p2 and p1.Type.ValidateOnce then
					local v3, v4 = p1.Type.ValidateOnce(p1:GetTransformedValue(i))
					if not v3 then
						return v3, v4
					end
				end
			end
		end
	end
	return true
end
function t.GetAutocomplete(p1)
	if p1.Type.Autocomplete then
		return p1.Type.Autocomplete(p1:GetTransformedValue(#p1.TransformedValues))
	else
		return {}
	end
end
function t.ParseValue(p1, p2)
	if p1.Type.Parse then
		return p1.Type.Parse(p1:GetTransformedValue(p2))
	else
		return p1:GetTransformedValue(p2)
	end
end
function t.GetValue(p1)
	if #p1.RawValue == 0 and (not p1.Required and p1.Object.Default ~= nil) then
		return p1.Object.Default
	elseif p1.Type.Listable then
		local tbl = {}
		for i = 1, #p1.TransformedValues do
			local v1 = p1:ParseValue(i)
			if type(v1) ~= "table" then
				error((("[Cmdr] Listable types must return a table from Parse %*"):format(p1.Type.Name)))
			end
			for k, v in pairs(v1) do
				tbl[v] = true
			end
		end
		local t = {}
		for k in pairs(tbl) do
			t[#t + 1] = k
		end
		return t
	else
		return p1:ParseValue(1)
	end
end
return t
