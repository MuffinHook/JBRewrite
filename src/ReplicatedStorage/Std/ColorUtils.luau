local ColorUtils = {
	clamp01 = function(hue, saturation, value)
		return math.clamp(hue, 0, 1), math.clamp(saturation, 0, 1), math.clamp(value, 0, 1)
	end
}
function ColorUtils.saturateBy(color, saturationMultiplier)
	local hue, saturation, value = color:ToHSV()
	local clampedHue, clampedSaturation, clampedValue = ColorUtils.clamp01(hue, saturation * (1 + saturationMultiplier), value)
	return Color3.fromHSV(clampedHue, clampedSaturation, clampedValue)
end
function ColorUtils.saturateTo(color, saturationTarget)
	local hue, _, value = color:ToHSV()
	local clampedHue, clampedSaturation, clampedValue = ColorUtils.clamp01(hue, saturationTarget, value)
	return Color3.fromHSV(clampedHue, clampedSaturation, clampedValue)
end
function ColorUtils.brightenBy(color, brightnessMultiplier)
	local hue, saturation, value = color:ToHSV()
	local clampedHue, clampedSaturation, clampedValue = ColorUtils.clamp01(hue, saturation, value * (1 + brightnessMultiplier))
	return Color3.fromHSV(clampedHue, clampedSaturation, clampedValue)
end
function ColorUtils.brightenTo(color, brightnessTarget)
	local hue, saturation, _ = color:ToHSV()
	local clampedHue, clampedSaturation, clampedValue = ColorUtils.clamp01(hue, saturation, brightnessTarget)
	return Color3.fromHSV(clampedHue, clampedSaturation, clampedValue)
end
function ColorUtils.hueBy(color, hueShift)
	local hue, saturation, value = color:ToHSV()
	local clampedHue, clampedSaturation, clampedValue = ColorUtils.clamp01((hue + hueShift) % 1, saturation, value)
	return Color3.fromHSV(clampedHue, clampedSaturation, clampedValue)
end
function ColorUtils.hueTo(color, hueTarget)
	local _, saturation, value = color:ToHSV()
	local clampedHue, clampedSaturation, clampedValue = ColorUtils.clamp01(hueTarget, saturation, value)
	return Color3.fromHSV(clampedHue, clampedSaturation, clampedValue)
end
function ColorUtils.adjustBy(color, hueShift, saturationMultiplier, brightnessMultiplier)
	local hue, saturation, value = color:ToHSV()
	local clampedHue, clampedSaturation, clampedValue = ColorUtils.clamp01((hue + hueShift) % 1, saturation * (1 + saturationMultiplier), value * (1 + brightnessMultiplier))
	return Color3.fromHSV(clampedHue, clampedSaturation, clampedValue)
end
return ColorUtils
