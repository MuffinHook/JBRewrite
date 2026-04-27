local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Time = require(ReplicatedStorage.Module.Time)
local RunService = game:GetService("RunService")
local CurrentCamera = workspace.CurrentCamera
local MilitaryIslandModule = {
	Maid = Maid.new()
}
function MilitaryIslandModule.Init()
	for index, laserModel in ipairs(CollectionService:GetTagged("MilitaryLasers")) do
		MilitaryIslandModule.StartSpin(laserModel)
	end
	CollectionService:GetInstanceAddedSignal("MilitaryLasers"):Connect(MilitaryIslandModule.StartSpin)
	CollectionService:GetInstanceRemovedSignal("MilitaryLasers"):Connect(MilitaryIslandModule.StopSpin)
end
function MilitaryIslandModule.StartSpin(laserModel)
	assert(laserModel)
	local baseCFrame = CFrame.new(laserModel.PrimaryPart.Position)
	local Position = baseCFrame.Position
	MilitaryIslandModule.Maid.ConnectionSpin = RunService.Heartbeat:Connect(function()
		local Magnitude = (CurrentCamera.CFrame.Position - Position).Magnitude
		if not (Magnitude * Magnitude > 250000) then
			debug.profilebegin("MilitaryIsland Laser Spin")
			local currentTime = Time.GetNowSync()
			laserModel:SetPrimaryPartCFrame(baseCFrame * CFrame.Angles(0, (currentTime + math.sin(2 * currentTime) * 0.1) * 1 % 6.283185307179586, 0))
			debug.profileend()
		end
	end)
end
function MilitaryIslandModule.StopSpin()
	MilitaryIslandModule.Maid.ConnectionSpin = nil
end
return MilitaryIslandModule
