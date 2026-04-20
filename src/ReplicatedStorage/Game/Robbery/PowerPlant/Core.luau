local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr_2 = {}
module_upvr_2.__index = module_upvr_2
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local RunService_upvr = game:GetService("RunService")
function module_upvr_2.new(arg1) -- Line 11
    local module_upvr = {}
    setmetatable(module_upvr, module_upvr_2)
    module_upvr.Model = arg1
    local Spinner = module_upvr.Model:FindFirstChild("Spinner")
    module_upvr.Spinner = Spinner
    RxInstanceUtils_upvr.yieldForProperty(Spinner, "PrimaryPart")
    assert(module_upvr.Spinner.PrimaryPart, "spinner is missing PrimaryPart")
    module_upvr.Spinner.PrimaryPart.CFrame = CFrame.new(module_upvr.Spinner.PrimaryPart.Position)
    module_upvr.Maid = Maid_upvr.new()
    module_upvr.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(function(arg1_2) -- Line 25
        module_upvr:Heartbeat(arg1_2)
    end))
    return module_upvr
end
local CurrentCamera_upvr = workspace.CurrentCamera
function module_upvr_2.Heartbeat(arg1, arg2) -- Line 31
    local Magnitude = (CurrentCamera_upvr.CFrame.Position - arg1.Spinner.PrimaryPart.Position).Magnitude
    if 250000 < Magnitude * Magnitude then
    else
        debug.profilebegin("PowerPlant Core")
        arg1.Spinner:SetPrimaryPartCFrame(arg1.Spinner.PrimaryPart.CFrame * CFrame.Angles(0, arg2, 0))
        local var11 = math.cos(tick() * 2) * 20
        arg1.Model.Part.Color = Color3.fromRGB(var11 + 129, var11 + 125, var11 + 152)
        arg1.Model.PowerWire.Color = Color3.fromRGB(var11 + 129, var11 + 125, var11 + 152)
        debug.profileend()
    end
end
function module_upvr_2.Destroy(arg1) -- Line 44
    arg1.Maid:Destroy()
    arg1.Maid = nil
end
return module_upvr_2