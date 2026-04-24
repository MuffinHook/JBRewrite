-- Reviewed by Claude
-- variables reassigned
local configTable = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local isEnabled = false
local v2 = nil
local v3 = nil
local v4 = nil
task.spawn(function()
	v2 = ReplicatedStorage:FindFirstChild("AdRewardSystem")
	if v2 then
		v3 = v2:FindFirstChild("AdRewardEvents")
		if v3 then
			v4 = v3:WaitForChild("LogEvent")
			isEnabled = true
			print("Roblox Ad Services Team: Custom Telemetry Connected")
		else
			warn("Custom telemetry failed: No Service")
		end
	else
		warn("Custom telemetry failed: No Service")
	end
end)
function configTable.send(p1, p2, p3)
	if isEnabled then
		local configTable = {
			eventName = p1,
			value = p2 or 0
		}
		configTable.fields = p3 or {}
		v4:FireServer(configTable)
	end
end
return configTable
