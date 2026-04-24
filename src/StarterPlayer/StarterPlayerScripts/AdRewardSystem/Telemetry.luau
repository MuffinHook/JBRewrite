-- Reviewed by Claude
local t = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = false
local v2 = nil
local v3 = nil
local v4 = nil
task.spawn(function()
	v2 = ReplicatedStorage:FindFirstChild("AdRewardSystem")
	if v2 then
		v3 = v2:FindFirstChild("AdRewardEvents")
		if v3 then
			v4 = v3:WaitForChild("LogEvent")
			v1 = true
			print("Roblox Ad Services Team: Custom Telemetry Connected")
		else
			warn("Custom telemetry failed: No Service")
		end
	else
		warn("Custom telemetry failed: No Service")
	end
end)
function t.send(p1, p2, p3)
	if v1 then
		local t = {
			eventName = p1,
			value = p2 or 0
		}
		t.fields = p3 or {}
		v4:FireServer(t)
	end
end
return t
