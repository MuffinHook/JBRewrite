local SpeedometerUtils = {
	studsToKm = function(studs)
		return studs / 3 / 1000
	end,
	kmToStuds = function(km)
		return km * 3 * 1000
	end
}
function SpeedometerUtils.studsToMi(studs)
	return SpeedometerUtils.studsToKm(studs) * 0.621371
end
function SpeedometerUtils.miToStuds(miles)
	return SpeedometerUtils.kmToStuds(miles / 0.621371)
end
function SpeedometerUtils.sToH(seconds)
	return seconds * 60 * 60
end
return SpeedometerUtils
