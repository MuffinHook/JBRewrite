-- Reviewed by Claude
-- variables reassigned
return function(self)
	if self then
 local result1, result2 = next(self)
 if result2 then
 if next(self, result1) then
 error("Expected at most child, had more than one child.", 2)
 end
 return result2
 else
 return nil
 end
	else
 return nil
	end
end
