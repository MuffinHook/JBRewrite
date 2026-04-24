-- Reviewed by Claude
-- variables reassigned
return function(tableA, tableB)
	if tableA == nil then
 return tableB == nil
	end
	if tableB == nil then
 return tableA == nil
	end
	for k, v in pairs(tableA) do
 if v ~= tableB[k] then
 return false
 end
	end
	for k, v in pairs(tableB) do
 if v ~= tableA[k] then
 return false
 end
	end
	return true
end
