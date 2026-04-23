local LocalPlayer = game:GetService("Players").LocalPlayer
local LocalizationService = game:GetService("LocalizationService")
local v1 = nil
if LocalPlayer then
	task.spawn(function() --[[ Line: 10 | Upvalues: v1 (ref), LocalizationService (copy), LocalPlayer (copy) ]]
		local v12, v2 = pcall(function() --[[ Line: 11 | Upvalues: v1 (ref), LocalizationService (ref), LocalPlayer (ref) ]]
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
local function _formatByKey(p1, ...) --[[ Line: 25 | Upvalues: v1 (ref), v2 (copy), v3 (copy) ]]
	local t = { ... }
	local v12 = nil
	local v22 = pcall(function() --[[ Line: 28 | Upvalues: v12 (ref), v1 (ref), p1 (copy), t (copy) ]]
		v12 = v1:FormatByKey(p1, unpack(t))
	end)
	if not v22 then
		v22 = pcall(function() --[[ Line: 32 | Upvalues: v12 (ref), v2 (ref), p1 (copy), t (copy) ]]
			v12 = v2:FormatByKey(p1, unpack(t))
		end)
	end
	if not v22 then
		v22 = pcall(function() --[[ Line: 37 | Upvalues: v12 (ref), v3 (ref), p1 (copy), t (copy) ]]
			v12 = v3:FormatByKey(p1, unpack(t))
		end)
	end
	if not v22 then
		v12 = p1
	end
	return v22, v12
end
function t.FormatByKey(p1, ...) --[[ Line: 46 | Upvalues: _formatByKey (copy) ]]
	local v1, v2 = _formatByKey(...)
	if not v1 then
		warn("No valid translation for: " .. v2)
	end
	return v2
end
function t.AttemptFormatByKey(p1, ...) --[[ Line: 54 | Upvalues: _formatByKey (copy) ]]
	local v1, v2 = _formatByKey(...)
	return v1, v2
end
return t