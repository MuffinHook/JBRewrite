local configTable = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local isEnabled = false
local adRewardSystemFolder = nil
local adRewardEventsFolder = nil
local logEventRemote = nil
task.spawn(function()
	adRewardSystemFolder = ReplicatedStorage:FindFirstChild("AdRewardSystem")
	if adRewardSystemFolder then
		adRewardEventsFolder = adRewardSystemFolder:FindFirstChild("AdRewardEvents")
		if adRewardEventsFolder then
			logEventRemote = adRewardEventsFolder:WaitForChild("LogEvent")
			isEnabled = true
			print("Roblox Ad Services Team: Custom Telemetry Connected")
		else
			warn("Custom telemetry failed: No Service")
		end
	else
		warn("Custom telemetry failed: No Service")
	end
end)
function configTable.send(eventName, eventValue, eventFields)
	if isEnabled then
		local configTable = {
			eventName = eventName,
			value = eventValue or 0
		}
		configTable.fields = eventFields or {}
		logEventRemote:FireServer(configTable)
	end
end
return configTable
