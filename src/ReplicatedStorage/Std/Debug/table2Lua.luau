-- Reviewed by Claude
local insert = table.insert
return function(p1)
	if p1 == nil then
		return "nil"
	end
	if typeof(p1) == "table" then
		local t = {}
		local function v1(p1, p2, p3)
			local v12 = ("\t"):rep(p2)
			if p3 then
				if typeof(p3) == "string" and (not p3:find("\"") and (not p3:find("\'") and p3:sub(1, 1):match("[%w_]"))) then
					insert(t, ("%s%s = {"):format(v12, p3))
				else
					insert(t, ("%s[%q] = {"):format(v12, p3))
				end
			else
				insert(t, ("%s{"):format(v12))
			end
			local t2 = {}
			for v2, v3 in p1 do
				table.insert(t2, {
					k = v2,
					v = v3
				})
			end
			table.sort(t2, function(p1, p2)
				return p1.k < p2.k
			end)
			for v5, v6 in t2 do
				local v4
				local k = v6.k
				local v = v6.v
				if type(v) == "table" then
					v1(v, p2 + 1, k)
				else
					v4 = if typeof(v) == "Vector3" then ("Vector3.new(%s)"):format((tostring(v))) elseif typeof(v) == "string" then ("%q"):format(v) elseif typeof(v) == "Instance" then ("[%s]"):format(v:GetFullName()) else tostring(v)
					if typeof(k) == "string" and (not k:find("\"") and (not k:find("\'") and k:sub(1, 1):match("[%w_]"))) then
						insert(t, ("\t%s%s = %s,"):format(v12, k, v4))
					else
						insert(t, ("\t%s[%q] = %s"):format(v12, k, v4))
					end
				end
			end
			insert(t, ("%s},"):format(v12))
		end
		v1(p1, 0)
		table.remove(t)
		insert(t, "}")
		return table.concat(t, "\n")
	end
	warn("table2Lua: t must be a table, currently of type: " .. typeof(p1))
end
