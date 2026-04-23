return function(p1, p2) --[[ Name: internalAssert | Line: 1 ]]
	if not p1 then
		error(p2 .. " (This is probably a bug in Roact!)", 3)
	end
end