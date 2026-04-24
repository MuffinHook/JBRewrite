-- Reviewed by Claude
local LocalPlayer = game:GetService("Players").LocalPlayer
local LocalizationService = game:GetService("LocalizationService")
local v1 = nil
if LocalPlayer then
	task.spawn(function()
		local var12, table2 = pcall(function()
			v1 = LocalizationService:GetTranslatorForPlayerAsync(LocalPlayer)
		end)
		if not var12 then
			warn(table2)
			v1 = nil
		end
	end)
end
local table2 = LocalizationService.GameLocalizationTable:GetTranslator(LocalizationService.RobloxLocaleId)
local table3 = LocalizationService.GameLocalizationTable:GetTranslator("en-us")
local t = {}
local function _formatByKey(p1, ...)
	local t = { ... }
	local var12 = nil
	local func22 = pcall(function()
		var12 = v1:FormatByKey(p1, unpack(t))
	end)
	if not func22 then
		func22 = pcall(function()
			var12 = table2:FormatByKey(p1, unpack(t))
		end)
	end
	if not func22 then
		func22 = pcall(function()
			var12 = table3:FormatByKey(p1, unpack(t))
		end)
	end
	if not func22 then
		var12 = p1
	end
	return func22, var12
end
function t.FormatByKey(p1, ...)
	local v1, table2 = _formatByKey(...)
	if not v1 then
		warn("No valid translation for: " .. table2)
	end
	return table2
end
function t.AttemptFormatByKey(p1, ...)
	local v1, table2 = _formatByKey(...)
	return v1, table2
end
return t
