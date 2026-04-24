-- Reviewed by Claude
return function(p1)
	if p1 then
 local v1, v2 = next(p1)
 if v2 then
 if next(p1, v1) then
 error("Expected at most child, had more than one child.", 2)
 end
 return v2
 else
 return nil
 end
	else
 return nil
	end
end