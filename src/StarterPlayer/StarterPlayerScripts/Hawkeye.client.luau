local LocalizationService_upvr = game:GetService("LocalizationService")
game:GetService("ReplicatedStorage"):WaitForChild("HawkeyeRemoteFunction").OnClientInvoke = function() -- Line 5, Named "OnClientInvoke"
    return {
        system_locale = LocalizationService_upvr.SystemLocaleId;
        account_locale = LocalizationService_upvr.RobloxLocaleId;
    }
end