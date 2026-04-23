local function v1(p1, p2) --[[ Line: 3 | Upvalues: v1 (copy) ]]
	local v12 = p2 or 0
	local t = {}
	if typeof(p1) == "table" then
		table.insert(t, "{\n")
		for k, v in pairs(p1) do
			table.insert(t, ("    "):rep(v12 + 1))
			table.insert(t, (tostring(k)))
			table.insert(t, " = ")
			table.insert(t, v1(v, v12 + 1))
			table.insert(t, "\n")
		end
		table.insert(t, ("    "):rep(v12))
		table.insert(t, "}")
	elseif typeof(p1) == "string" then
		table.insert(t, string.format("%q", p1))
		table.insert(t, " (string)")
	else
		table.insert(t, (tostring(p1)))
		table.insert(t, " (")
		table.insert(t, (typeof(p1)))
		table.insert(t, ")")
	end
	return table.concat(t, "")
end
return v1