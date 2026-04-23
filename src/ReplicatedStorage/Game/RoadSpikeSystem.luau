local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Module.Time)
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local v1 = nil
local t = {}
local function FromPart(p1) --[[ Line: 10 ]]
	return {
		Part = p1
	}
end
local v2 = nil
local function Check() --[[ Line: 17 | Upvalues: VehicleUtils (copy), v2 (ref), t (copy), v1 (ref) ]]
	local v12 = VehicleUtils.GetLocalVehiclePacket()
	if v12 == nil then
		if v2 then
			v2 = nil
		end
	elseif v12.Model:IsDescendantOf(workspace) then
		local Position = v12.Model.PrimaryPart.Position
		if v2 ~= nil then
			for i, v in ipairs(t) do
				local Part = v.Part
				local v22 = Part.CFrame
				local p = v22.p
				local v3 = (v2 - p).Unit:Dot(v22.LookVector)
				local v4 = (Position - p).Unit:Dot(v22.LookVector)
				if math.sign(v3) ~= math.sign(v4) then
					local v5 = (Position - p):Dot(v22.RightVector)
					if math.abs(v5) <= Part.Size.X * 0.5 and math.abs(((Position - p):Dot(v22.UpVector))) < 16 then
						v1:FireServer("a" .. ("cvqx0sn8"):sub(5, 5):reverse():reverse():reverse() .. "" .. "" .. ("nwqycdqc"):sub(4, 5):reverse() .. "m8fr", Part)
					end
				end
			end
		end
		v2 = Position
	end
end
local v3 = 0
local function Stepped() --[[ Line: 51 | Upvalues: v3 (ref), Check (copy) ]]
	local v1 = tick()
	if v1 - v3 > 0.1 then
		v3 = v1
		Check()
	end
end
return {
	Init = function(p1) --[[ Name: Init | Line: 58 | Upvalues: v1 (ref), RunService (copy), Stepped (copy), t (copy), CollectionService (copy) ]]
		v1 = p1.Event
		RunService.Heartbeat:Connect(Stepped)
		local function AddedFun(p1) --[[ Line: 62 | Upvalues: t (ref) ]]
			table.insert(t, {
				Part = p1
			})
		end
		local function RemovedFun(p1) --[[ Line: 66 | Upvalues: t (ref) ]]
			for i = #t, 1, -1 do
				if t[i].Part == p1 then
					table.remove(t, i)
					return
				end
			end
		end
		for i, v in ipairs(CollectionService:GetTagged("RoadSpike")) do
			table.insert(t, {
				Part = v
			})
		end
		CollectionService:GetInstanceAddedSignal("RoadSpike"):Connect(AddedFun)
		CollectionService:GetInstanceRemovedSignal("RoadSpike"):Connect(RemovedFun)
	end
}