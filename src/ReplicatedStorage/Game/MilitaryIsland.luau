local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Time = require(ReplicatedStorage.Module.Time)
local RunService = game:GetService("RunService")
local CurrentCamera = workspace.CurrentCamera
local t = {
	Maid = Maid.new()
}
function t.Init() --[[ Line: 12 | Upvalues: CollectionService (copy), t (copy) ]]
	for i, v in ipairs(CollectionService:GetTagged("MilitaryLasers")) do
		t.StartSpin(v)
	end
	CollectionService:GetInstanceAddedSignal("MilitaryLasers"):Connect(t.StartSpin)
	CollectionService:GetInstanceRemovedSignal("MilitaryLasers"):Connect(t.StopSpin)
end
function t.StartSpin(p1) --[[ Line: 19 | Upvalues: t (copy), RunService (copy), CurrentCamera (copy), Time (copy) ]]
	assert(p1)
	local v1 = CFrame.new(p1.PrimaryPart.Position)
	local Position = v1.Position
	t.Maid.ConnectionSpin = RunService.Heartbeat:Connect(function() --[[ Line: 25 | Upvalues: CurrentCamera (ref), Position (copy), Time (ref), p1 (copy), v1 (copy) ]]
		local Magnitude = (CurrentCamera.CFrame.Position - Position).Magnitude
		if not (Magnitude * Magnitude > 250000) then
			debug.profilebegin("MilitaryIsland Laser Spin")
			local v12 = Time.GetNowSync()
			p1:SetPrimaryPartCFrame(v1 * CFrame.Angles(0, (v12 + math.sin(2 * v12) * 0.1) * 1 % 6.283185307179586, 0))
			debug.profileend()
		end
	end)
end
function t.StopSpin() --[[ Line: 38 | Upvalues: t (copy) ]]
	t.Maid.ConnectionSpin = nil
end
return t