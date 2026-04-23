local t = {
	studsToKm = function(p1) --[[ Name: studsToKm | Line: 6 ]]
		return p1 / 3 / 1000
	end,
	kmToStuds = function(p1) --[[ Name: kmToStuds | Line: 9 ]]
		return p1 * 3 * 1000
	end
}
function t.studsToMi(p1) --[[ Line: 12 | Upvalues: t (copy) ]]
	return t.studsToKm(p1) * 0.621371
end
function t.miToStuds(p1) --[[ Line: 15 | Upvalues: t (copy) ]]
	return t.kmToStuds(p1 / 0.621371)
end
function t.sToH(p1) --[[ Line: 18 ]]
	return p1 * 60 * 60
end
return t