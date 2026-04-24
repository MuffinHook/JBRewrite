-- Reviewed by Claude
local LocalizationService = game:GetService("LocalizationService")
game:GetService("ReplicatedStorage"):WaitForChild("HawkeyeRemoteFunction").OnClientInvoke = function()
	return {
		system_locale = LocalizationService.SystemLocaleId,
		account_locale = LocalizationService.RobloxLocaleId
	}
end
