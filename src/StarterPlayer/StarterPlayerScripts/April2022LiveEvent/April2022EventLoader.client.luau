local ReplicatedStorage = game:GetService("ReplicatedStorage")
local function check(p1) --[[ Line: 5 ]]
	if p1 and p1.Name == "April2022LiveEventClient" then
		local April2022LiveEventRuntime = p1:WaitForChild("April2022LiveEventRuntime")
		task.wait(0.1)
		require(April2022LiveEventRuntime).init()
		print("Loaded April 2022 live event client code")
	end
end
check(ReplicatedStorage:FindFirstChild("April2022LiveEventClient"))
ReplicatedStorage.ChildAdded:Connect(check)