-- Reviewed by Claude
local function v1(p1, p2)
	local v12 = p2 or 0
	local tbl = {}
	if typeof(p1) == "table" then
 table.insert(tbl, "{\n")
 for k, v in pairs(p1) do
 table.insert(tbl, (" "):rep(v12 + 1))
 table.insert(tbl, (tostring(k)))
 table.insert(tbl, " = ")
 table.insert(tbl, v1(v, v12 + 1))
 table.insert(tbl, "\n")
 end
 table.insert(tbl, (" "):rep(v12))
 table.insert(tbl, "}")
	elseif typeof(p1) == "string" then
 table.insert(tbl, string.format("%q", p1))
 table.insert(tbl, " (string)")
	else
 table.insert(tbl, (tostring(p1)))
 table.insert(tbl, " (")
 table.insert(tbl, (typeof(p1)))
 table.insert(tbl, ")")
	end
	return table.concat(tbl, "")
end
return v1