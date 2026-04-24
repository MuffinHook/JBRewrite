-- Reviewed by Claude
local LocalPlayer = game:GetService("Players").LocalPlayer
local LocalizationService = game:GetService("LocalizationService")
local v1 = nil
if LocalPlayer then
	task.spawn(function()
		local v12, v2 = pcall(function()
			v1 = LocalizationService:GetTranslatorForPlayerAsync(LocalPlayer)
		end)
		if not v12 then
			warn(v2)
			v1 = nil
		end
	end)
end
local v2 = LocalizationService.GameLocalizationTable:GetTranslator(LocalizationService.RobloxLocaleId)
local v3 = LocalizationService.GameLocalizationTable:GetTranslator("en-us")
local t = {}
local function _formatByKey(p1, ...)
	local t = { ... }
	local v12 = nil
	local v22 = pcall(function()
		v12 = v1:FormatByKey(p1, unpack(t))
	end)
	if not v22 then
		v22 = pcall(function()
			v12 = v2:FormatByKey(p1, unpack(t))
		end)
	end
	if not v22 then
		v22 = pcall(function()
			v12 = v3:FormatByKey(p1, unpack(t))
		end)
	end
	if not v22 then
		v12 = p1
	end
	return v22, v12
end
function t.FormatByKey(p1, ...)
	local v1, v2 = _formatByKey(...)
	if not v1 then
		warn("No valid translation for: " .. v2)
	end
	return v2
end
function t.AttemptFormatByKey(p1, ...)
	local v1, v2 = _formatByKey(...)
	return v1, v2
end
return t
