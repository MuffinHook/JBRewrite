local ReplicatedStorage = game:GetService("ReplicatedStorage")
local function check(arg1) -- Line 5
    if not arg1 then
    elseif arg1.Name == "April2022LiveEventClient" then
        task.wait(0.1)
        require(arg1:WaitForChild("April2022LiveEventRuntime")).init()
        print("Loaded April 2022 live event client code")
    end
end
check(ReplicatedStorage:FindFirstChild("April2022LiveEventClient"))
ReplicatedStorage.ChildAdded:Connect(check)