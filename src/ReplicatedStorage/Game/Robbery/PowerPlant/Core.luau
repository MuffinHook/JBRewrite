local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local RunService = game:GetService("RunService")
local CurrentCamera = workspace.CurrentCamera
local t = {}
t.__index = t
function t.new(p1) --[[ Line: 11 | Upvalues: t (copy), RxInstanceUtils (copy), Maid (copy), RunService (copy) ]]
	local t2 = {}
	setmetatable(t2, t)
	t2.Model = p1
	local Spinner = t2.Model:FindFirstChild("Spinner")
	t2.Spinner = Spinner
	RxInstanceUtils.yieldForProperty(Spinner, "PrimaryPart")
	assert(t2.Spinner.PrimaryPart, "spinner is missing PrimaryPart")
	t2.Spinner.PrimaryPart.CFrame = CFrame.new(t2.Spinner.PrimaryPart.Position)
	t2.Maid = Maid.new()
	t2.Maid:GiveTask(RunService.Heartbeat:Connect(function(p1) --[[ Line: 25 | Upvalues: t2 (copy) ]]
		t2:Heartbeat(p1)
	end))
	return t2
end
function t.Heartbeat(p1, p2) --[[ Line: 31 | Upvalues: CurrentCamera (copy) ]]
	local Magnitude = (CurrentCamera.CFrame.Position - p1.Spinner.PrimaryPart.Position).Magnitude
	if not (Magnitude * Magnitude > 250000) then
		debug.profilebegin("PowerPlant Core")
		p1.Spinner:SetPrimaryPartCFrame(p1.Spinner.PrimaryPart.CFrame * CFrame.Angles(0, p2, 0))
		local v2 = math.cos(tick() * 2) * 20
		p1.Model.Part.Color = Color3.fromRGB(v2 + 129, v2 + 125, v2 + 152)
		p1.Model.PowerWire.Color = Color3.fromRGB(v2 + 129, v2 + 125, v2 + 152)
		debug.profileend()
	end
end
function t.Destroy(p1) --[[ Line: 44 ]]
	p1.Maid:Destroy()
	p1.Maid = nil
end
return t