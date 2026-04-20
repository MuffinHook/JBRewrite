if game:GetService("RunService"):IsServer() then
    return require(script.GameAnalytics)
end
return require(script.GameAnalyticsClient)