-- Reviewed by Claude
local t = {
	studsToKm = function(p1)
		return p1 / 3 / 1000
	end,
	kmToStuds = function(p1)
		return p1 * 3 * 1000
	end
}
function t.studsToMi(p1)
	return t.studsToKm(p1) * 0.621371
end
function t.miToStuds(p1)
	return t.kmToStuds(p1 / 0.621371)
end
function t.sToH(p1)
	return p1 * 60 * 60
end
return t
