local LocalizationService = game:GetService("LocalizationService")
game:GetService("ReplicatedStorage"):WaitForChild("HawkeyeRemoteFunction").OnClientInvoke = function() --[[ Name: OnClientInvoke | Line: 5 | Upvalues: LocalizationService (copy) ]]
	return {
		system_locale = LocalizationService.SystemLocaleId,
		account_locale = LocalizationService.RobloxLocaleId
	}
end