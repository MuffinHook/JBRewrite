-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = nil
local initialized = false
local function Check()
	local April2020LiveEvent = ReplicatedStorage.Resource:FindFirstChild("April2020LiveEvent")
	if April2020LiveEvent ~= nil then
		initialized = true
		local April2020LiveEvent_2 = April2020LiveEvent:WaitForChild("April2020LiveEvent")
		wait(0.1)
		require(April2020LiveEvent_2).Init(v1)
		v1 = nil
		print("Loaded april 2020 live event")
	end
end
local function Launch()
	while initialized == false do
		local success, errorMessage = pcall(Check)
		if not success then
			warn(errorMessage)
		end
		wait(1)
	end
end
return {
	Init = function(initData)
		v1 = initData
		spawn(Launch)
	end
}
