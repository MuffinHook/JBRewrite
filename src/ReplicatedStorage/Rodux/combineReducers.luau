-- Reviewed by Claude
return function(p1)
	return function(p12, p2)
 if p12 == nil then
 p12 = {}
 end
 local t = {}
 for k, v in pairs(p1) do
 t[k] = v(p12[k], p2)
 end
 return t
	end
end