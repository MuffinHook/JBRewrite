-- Reviewed by Claude
return function(p1)
	return function(p12, p2)
 if p12 == nil then
 p12 = {}
 end
 local tbl = {}
 for k, v in pairs(p1) do
 tbl[k] = v(p12[k], p2)
 end
 return tbl
	end
end