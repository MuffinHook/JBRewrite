-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = nil
local v2 = false
local function Check()
	local April2020LiveEvent = ReplicatedStorage.Resource:FindFirstChild("April2020LiveEvent")
	if April2020LiveEvent ~= nil then
		v2 = true
		local April2020LiveEvent_2 = April2020LiveEvent:WaitForChild("April2020LiveEvent")
		wait(0.1)
		require(April2020LiveEvent_2).Init(v1)
		v1 = nil
		print("Loaded april 2020 live event")
	end
end
local function Launch()
	while v2 == false do
		local v1, v22 = pcall(Check)
		if not v1 then
			warn(v22)
		end
		wait(1)
	end
end
return {
	Init = function(p1)
		v1 = p1
		spawn(Launch)
	end
}
