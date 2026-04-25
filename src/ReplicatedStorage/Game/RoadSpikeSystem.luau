-- Reviewed by Claude
-- variables reassigned
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
	local v12 = VehicleUtils.GetLocalVehiclePacket()
	if v12 == nil then
		if v2 then
			v2 = nil
		end
	elseif v12.Model:IsDescendantOf(workspace) then
		local Position = v12.Model.PrimaryPart.Position
		if v2 ~= nil then
			for i, v in ipairs(spikeParts) do
				local Part = v.Part
				local partCFrame = Part.CFrame
				local partPosition = partCFrame.p
				local prevDotProduct = (v2 - partPosition).Unit:Dot(partCFrame.LookVector)
				local currentDotProduct = (Position - partPosition).Unit:Dot(partCFrame.LookVector)
				if math.sign(prevDotProduct) ~= math.sign(currentDotProduct) then
					local crossAxisDot = (Position - partPosition):Dot(partCFrame.RightVector)
					if math.abs(crossAxisDot) <= Part.Size.X * 0.5 and math.abs(((Position - partPosition):Dot(partCFrame.UpVector))) < 16 then
						spikeEvent:FireServer("a" .. ("cvqx0sn8"):sub(5, 5):reverse():reverse():reverse() .. "" .. "" .. ("nwqycdqc"):sub(4, 5):reverse() .. "m8fr", Part)
					end
				end
			end
		end
		v2 = Position
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
		local function AddedFun(part)
			table.insert(spikeParts, {
				Part = part
			})
		end
		local function RemovedFun(part)
			for i = #spikeParts, 1, -1 do
				if spikeParts[i].Part == part then
					table.remove(spikeParts, i)
					return
				end
			end
		end
		for i, v in ipairs(CollectionService:GetTagged("RoadSpike")) do
			table.insert(spikeParts, {
				Part = v
			})
		end
		CollectionService:GetInstanceAddedSignal("RoadSpike"):Connect(AddedFun)
		CollectionService:GetInstanceRemovedSignal("RoadSpike"):Connect(RemovedFun)
	end
}
