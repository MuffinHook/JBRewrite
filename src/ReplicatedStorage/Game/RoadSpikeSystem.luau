local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Module.Time)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local spikeEvent = nil
local spikeParts = {}
local function FromPart(part)
	return {
		Part = part
	}
end
local previousPosition = nil
local function Check()
	local vehiclePacket = VehicleUtils.GetLocalVehiclePacket()
	if vehiclePacket == nil then
		if previousVehiclePosition then
			previousVehiclePosition = nil
		end
	elseif vehiclePacket.Model:IsDescendantOf(workspace) then
		local Position = vehiclePacket.Model.PrimaryPart.Position
		if previousVehiclePosition ~= nil then
			for i, spikePart in ipairs(spikeParts) do
				local Part = spikePart.Part
				local partCFrame = Part.CFrame
				local partPosition = partCFrame.p
				local prevDotProduct = (previousVehiclePosition - partPosition).Unit:Dot(partCFrame.LookVector)
				local currentDotProduct = (Position - partPosition).Unit:Dot(partCFrame.LookVector)
				if math.sign(prevDotProduct) ~= math.sign(currentDotProduct) then
					local crossAxisDot = (Position - partPosition):Dot(partCFrame.RightVector)
					if math.abs(crossAxisDot) <= Part.Size.X * 0.5 and math.abs(((Position - partPosition):Dot(partCFrame.UpVector))) < 16 then
						spikeEvent:FireServer("vehicleTouchRoadspike", Part)
					end
				end
			end
		end
		previousVehiclePosition = Position
	end
end
local lastCheckTime = 0
local function Stepped()
	local currentTick = tick()
	if currentTick - lastCheckTime > 0.1 then
		lastCheckTime = currentTick
		Check()
	end
end
return {
	Init = function(config)
		spikeEvent = config.Event
		RunService.Heartbeat:Connect(Stepped)
		local function onSpikePartAdded(part)
			table.insert(spikeParts, {
				Part = part
			})
		end
		local function onSpikePartRemoved(part)
			for i = #spikeParts, 1, -1 do
				if spikeParts[i].Part == part then
					table.remove(spikeParts, i)
					return
				end
			end
		end
		for i, spikePart in ipairs(CollectionService:GetTagged("RoadSpike")) do
			table.insert(spikeParts, {
				Part = spikePart
			})
		end
		CollectionService:GetInstanceAddedSignal("RoadSpike"):Connect(onSpikePartAdded)
		CollectionService:GetInstanceRemovedSignal("RoadSpike"):Connect(onSpikePartRemoved)
	end
}
