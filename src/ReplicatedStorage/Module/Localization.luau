local LocalPlayer = game:GetService("Players").LocalPlayer
local LocalizationService = game:GetService("LocalizationService")
local playerTranslator = nil
if LocalPlayer then
	task.spawn(function()
		local successPlayerTranslator, errorMessagePlayerTranslator = pcall(function()
			playerTranslator = LocalizationService:GetTranslatorForPlayerAsync(LocalPlayer)
		end)
		if not successPlayerTranslator then
			warn(errorMessagePlayerTranslator)
			playerTranslator = nil
		end
	end)
end
local gameTranslator = LocalizationService.GameLocalizationTable:GetTranslator(LocalizationService.RobloxLocaleId)
local englishTranslator = LocalizationService.GameLocalizationTable:GetTranslator("en-us")
local localizationModule = {}
local function _formatByKey(translationKey, ...)
	local formattedArguments = { ... }
	local formattedResult = nil
	local successFromPlayer = pcall(function()
		formattedResult = playerTranslator:FormatByKey(translationKey, unpack(formattedArguments))
	end)
	if not successFromPlayer then
		successFromPlayer = pcall(function()
			formattedResult = gameTranslator:FormatByKey(translationKey, unpack(formattedArguments))
		end)
	end
	if not successFromPlayer then
		successFromPlayer = pcall(function()
			formattedResult = englishTranslator:FormatByKey(translationKey, unpack(formattedArguments))
		end)
	end
	if not successFromPlayer then
		formattedResult = translationKey
	end
	return successFromPlayer, formattedResult
end
function localizationModule.FormatByKey(translationKey, ...)
	local successFormat, formattedText = _formatByKey(...)
	if not successFormat then
		warn("No valid translation for: " .. formattedText)
	end
	return formattedText
end
function localizationModule.AttemptFormatByKey(translationKey, ...)
	local successFormat, formattedText = _formatByKey(...)
	return successFormat, formattedText
end
return localizationModule
