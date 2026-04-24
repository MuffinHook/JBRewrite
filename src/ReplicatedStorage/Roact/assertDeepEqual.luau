-- Reviewed by Claude
local function v1(p1, p2)
	if typeof(p1) == typeof(p2) then
 if typeof(p1) == "table" then
 local tbl = {}
 for k, v in pairs(p1) do
 tbl[k] = true
 local v12, v2 = v1(v, p2[k])
 if not v12 and v2 then
 return false, v2:gsub("{1}", ("{1}[%s]"):format((tostring(k)))):gsub("{2}", ("{2}[%s]"):format((tostring(k))))
 end
 end
 for k, v in pairs(p2) do
 if not tbl[k] then
 local v3, v4 = v1(v, p1[k])
 if not v3 and v4 then
 return false, v4:gsub("{1}", ("{1}[%s]"):format((tostring(k)))):gsub("{2}", ("{2}[%s]"):format((tostring(k))))
 end
 end
 end
 return true, nil
 elseif p1 == p2 then
 return true, nil
 else
 return false, "{1} ~= {2}"
 end
	else
 return false, ("{1} is of type %s, but {2} is of type %s"):format(typeof(p1), (typeof(p2)))
	end
end
return function(p1, p2)
	local v12, v2 = v1(p1, p2)
	if not v12 and v2 then
 error(("Values were not deep-equal.\n%s"):format((v2:gsub("{1}", "first"):gsub("{2}", "second"))), 2)
	end
end