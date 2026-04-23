local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Time = require(ReplicatedStorage.Module.Time)
local Signal = require(ReplicatedStorage.Std.Signal)
require(ReplicatedStorage.Module.RayCast)
local JetPack = require(ReplicatedStorage.Game.JetPack.JetPack)
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local v1 = nil
local v2 = nil
local v3 = nil
local t = {
	OnCarCreated = Signal.new(),
	OnCarDestroyed = Signal.new(),
	OnCarEntered = Signal.new(),
	OnCarExited = Signal.new()
}
local TrainSystemUtils = require(script.TrainSystemUtils)
local CalculateDistanceAhead = TrainSystemUtils.CalculateDistanceAhead
local MoveTrain = TrainSystemUtils.MoveTrain
local v4 = RaycastParams.new()
v4.FilterType = Enum.RaycastFilterType.Include
v4.IgnoreWater = true
local function PopulateCar(p1, p2, p3) --[[ Line: 33 | Upvalues: v2 (ref), t (copy) ]]
	local Base = p3.Base
	local v1 = require(p2)
	p1.Model = p3
	p1.Base = Base
	p1.Length = Base.Size.Z
	p1.InvertBogey = false
	v1.MakeCar(p1, v2)
	t.OnCarCreated:Fire(p1)
	assert(p1.BogeyMotorFront)
	assert(p1.BogeyMotorBack)
	assert(p1.BogeyOffsetFront)
	assert(p1.BogeyOffsetBack)
	p1.MoveCar = v1.MoveCar
	p1.DestroyCar = v1.DestroyCar
	p1.Loaded = true
	return p1
end
local function RenderTrain(p1, p2) --[[ Line: 55 ]]
	local v1 = 0
	for i = #p1.Cars, 1, -1 do
		local v2 = p1.Cars[i]
		if v2.Loaded then
			v2:MoveCar(p1, p2, v1)
			v1 = v1 + v2.Length + p1.BufferLength
		end
	end
end
local t2 = {}
local function GetSystemById(p1) --[[ Line: 66 | Upvalues: t2 (copy) ]]
	for i = 1, #t2 do
		if t2[i].Id == p1 then
			return t2[i]
		end
	end
	return false
end
local function GetCarById(p1, p2) --[[ Line: 74 ]]
	for i = 1, #p1.Cars do
		if p1.Cars[i].Id == p2 then
			return p1.Cars[i]
		end
	end
	return false
end
return {
	Init = function(p1) --[[ Name: Init | Line: 83 | Upvalues: v2 (ref), v3 (ref), v1 (ref), v4 (copy), ReplicatedStorage (copy), PopulateCar (copy), t2 (copy), Time (copy), CalculateDistanceAhead (copy), t (copy), CollectionService (copy), LocalPlayer (copy), JetPack (copy), MoveTrain (copy), RenderTrain (copy), VehicleUtils (copy), CurrentCamera (copy), RunService (copy) ]]
		local em = p1.em
		v2 = p1.Event
		v3 = em
		local Trains = Instance.new("Folder")
		Trains.Name = "Trains"
		Trains.Parent = workspace
		v1 = { Trains }
		v4.FilterDescendantsInstances = { Trains }
		local UnsafePositionReplication = ReplicatedStorage:FindFirstChild("UnsafePositionReplication")
		local ChangePositionReplication = ReplicatedStorage:FindFirstChild("ChangePositionReplication")
		local function PopulateTrain(p1) --[[ Line: 97 | Upvalues: ReplicatedStorage (ref), Trains (copy), PopulateCar (ref) ]]
			for v1, v2 in next, p1.Cars do
				v2.SystemId = p1.Id
				local v3 = v2.Name
				local v4 = ReplicatedStorage.Resource.TrainCars[v3]:Clone()
				local v5 = script:FindFirstChild(v3) or script.Default
				v4:PivotTo(CFrame.new(0, -200, 0))
				v4.Parent = Trains
				PopulateCar(v2, v5, v4)
				task.wait()
			end
		end
		function em.b9qhzm8t(p1) --[[ Line: 109 | Upvalues: t2 (ref), PopulateTrain (copy) ]]
			local Id = p1.Id
			local v1 = false
			for i = 1, #t2 do
				if t2[i].Id == Id then
					v1 = t2[i]
					break
				end
			end
			if v1 then
				assert("This train already exists on client.")
			else
				table.insert(t2, p1)
				PopulateTrain(p1)
			end
			return true
		end
		local v22 = 0
		local function ReplicateTrain(p1) --[[ Line: 120 | Upvalues: t2 (ref), v22 (ref), v2 (ref), Time (ref), CalculateDistanceAhead (ref) ]]
			local SystemId = p1.SystemId
			local v1 = false
			for i = 1, #t2 do
				if t2[i].Id == SystemId then
					v1 = t2[i]
					break
				end
			end
			if v1 then
				local v23 = Time.GetNowSync() - p1.NowSync
				assert(p1.SegmentId)
				assert(v1.SegmentsById)
				local SegmentId_2 = p1.SegmentId
				local v3 = p1.Offset + v23 * p1.Speed
				local v4 = CalculateDistanceAhead(v1, v1.SegmentId, v1.Offset, SegmentId_2, p1.Offset)
				v1.ServerSpeed = p1.Speed
				if v4 then
					v1.ServerDistanceAhead = v4
				else
					print("Train force replication")
					v1.ServerDistanceAhead = nil
					v1.SegmentId = SegmentId_2
					v1.Offset = v3
				end
				return true
			else
				local v5 = tick()
				if v5 - v22 > 0.5 then
					v22 = v5
					v2:FireServer("k" .. ("pti4n"):sub(2, 2):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("erpspq94"):sub(4, 5):reverse() .. "" .. "" .. ("d1gw"):sub(3, 3):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("zg1jgvo"):sub(4, 4):reverse():reverse():reverse() .. "el", p1.SystemId)
				end
				return false
			end
		end
		function em.pvopv1ja(p1) --[[ Line: 165 | Upvalues: ReplicateTrain (copy) ]]
			for v1, v2 in next, p1 do
				ReplicateTrain(v2)
			end
		end
		function em.mwxdlqx0(p1) --[[ Line: 170 | Upvalues: t2 (ref), t (ref) ]]
			for i = 1, #t2 do
				local v1 = t2[i]
				if v1.Id == p1 then
					table.remove(t2, i)
					for v2, v3 in next, v1.Cars do
						local v4 = os.clock()
						repeat
							task.wait()
						until v3.DestroyCar ~= nil or v4 + 5 < os.clock()
						if v3.DestroyCar then
							t.OnCarDestroyed:Fire(v3)
							v3:DestroyCar()
						else
							warn("Car has no DestroyCar function")
							print(v3)
						end
					end
					return true
				end
			end
			return false
		end
		function em.ptiew0pw(p1, p2, p3) --[[ Line: 195 | Upvalues: t2 (ref) ]]
			local v1 = false
			for i = 1, #t2 do
				if t2[i].Id == p1 then
					v1 = t2[i]
					break
				end
			end
			if not v1 then
				return false
			end
			local v2 = v1.SegmentsById[p2]
			assert(v2)
			v2.BranchIndex = p3
		end
		function em.r0klh6da(p1) --[[ Line: 204 | Upvalues: t2 (ref) ]]
			local v1 = false
			for i = 1, #t2 do
				if t2[i].Id == p1 then
					v1 = t2[i]
					break
				end
			end
			if not v1 then
				return false
			end
			for v2, v3 in v1.Cars do
				if v3.SoundHorn then
					v3.SoundHorn:Play()
					v3.LastHorn = tick()
				elseif v3.SoundWhistle then
					v3.SoundWhistle:Play()
					v3.LastHorn = tick()
				end
			end
		end
		local t3 = {}
		for v32, v42 in CollectionService:GetTagged("ReplicateCharacterTrain") do
			table.insert(t3, v42)
		end
		local t4 = {}
		local t5 = {}
		CollectionService:GetInstanceAddedSignal("ReplicateCharacterTrain"):Connect(function(p1) --[[ Line: 226 | Upvalues: t3 (copy), t5 (copy) ]]
			table.insert(t3, p1)
			if t5[p1] then
				task.cancel(t5[p1])
				t5[p1] = nil
			end
		end)
		CollectionService:GetInstanceRemovedSignal("ReplicateCharacterTrain"):Connect(function(p1) --[[ Line: 235 | Upvalues: t3 (copy), t5 (copy), t4 (copy) ]]
			table.remove(t3, table.find(t3, p1))
			if t5[p1] then
				task.cancel(t5[p1])
			end
			t5[p1] = task.delay(2, function() --[[ Line: 245 | Upvalues: t4 (ref), p1 (copy), t5 (ref) ]]
				t4[p1] = nil
				t5[p1] = nil
			end)
		end)
		local v5 = nil
		local v6 = nil
		local v7 = os.clock()
		local v8 = CFrame.new()
		local function Stepped(p1) --[[ Line: 256 | Upvalues: t2 (ref), v5 (ref), t (ref), v6 (ref), LocalPlayer (ref), JetPack (ref), v4 (ref), MoveTrain (ref), RenderTrain (ref), VehicleUtils (ref), CurrentCamera (ref), UnsafePositionReplication (copy), v7 (ref), v8 (ref), t3 (copy), t4 (copy) ]]
			if #t2 <= 0 then
				if v5 then
					t.OnCarExited:Fire(v5)
				end
				v5 = nil
				v6 = nil
			else
				debug.profilebegin("Train Update")
				local v1 = nil
				local v2 = nil
				local v3 = nil
				local v42 = nil
				local Character = LocalPlayer.Character
				if Character then
					local Humanoid = Character:FindFirstChild("Humanoid")
					if Humanoid then
						v42 = Humanoid.RootPart
						if v42 and not JetPack.IsFlying() then
							local v52 = workspace:Raycast(v42.Position, Vector3.new(0, -20, 0), v4)
							v1 = if v52 and v52.Instance then v52.Instance else v52
						end
					end
				end
				if not v1 then
					if v5 then
						t.OnCarExited:Fire(v5)
					end
					v5 = nil
					v6 = nil
				end
				for v72, v82 in next, t2 do
					local v62
					for i = #v82.Cars, 1, -1 do
						local v9 = v82.Cars[i]
						if v9.Loaded and (v1 and v1:IsDescendantOf(v9.Model)) then
							v2 = v9.Base
							v3 = v2.CFrame
							if v5 then
								if v5 ~= v9 then
									t.OnCarExited:Fire(v5, true)
									t.OnCarEntered:Fire(v9)
								end
							else
								t.OnCarEntered:Fire(v9)
							end
							v5 = v9
							v6 = v82
						end
					end
					v62 = if v82.ServerDistanceAhead then v82.ServerSpeed + v82.ServerDistanceAhead else v82.ServerSpeed or v82.Speed
					v82.Speed = v82.Speed + (v62 - v82.Speed) * 0.1
					MoveTrain(v82, p1)
					RenderTrain(v82, p1)
				end
				debug.profileend()
				if v2 then
					local v10 = v2.CFrame
					local v11 = v10 * v3:Inverse()
					local v12 = VehicleUtils.GetLocalVehiclePacket()
					if not (v12 and v12.Passenger) then
						v42.CFrame = v11 * v42.CFrame
					end
					local v13 = CurrentCamera.CFrame:ToObjectSpace(CurrentCamera.Focus)
					CurrentCamera.CFrame = CurrentCamera.CFrame * v13 * (v11 - v11.p) * v13:Inverse()
					assert(v5)
					if UnsafePositionReplication and os.clock() - v7 > 0.2 then
						local v15 = v10:ToObjectSpace(v42.CFrame)
						if not (v8 and v15:FuzzyEq(v8)) then
							v7 = os.clock()
							UnsafePositionReplication:FireServer("Train", v5.Id, v15)
							v8 = v15
						end
					end
					for v16, v17 in t3 do
						local v18 = v17:GetAttribute("TrainCar")
						local v19 = v17:GetAttribute("TrainOffset")
						if Character ~= v17 and (v17.PrimaryPart and (v18 and v19)) then
							local v20 = v6
							local v21 = false
							local v22 = v18
							for j = 1, #v20.Cars do
								if v20.Cars[j].Id == v22 then
									v21 = v20.Cars[j]
									break
								end
							end
							if v21 and v21.Base then
								local v23 = t4[v17]
								if not v23 then
									local t5 = {
										LastCarId = v22,
										LastOffset = v21.Base.CFrame:ToObjectSpace(v17.PrimaryPart.CFrame)
									}
									t4[v17] = t5
									v23 = t5
								end
								local LastOffset = v23.LastOffset
								if v23.LastCarId ~= v22 then
									local v24 = v6
									local LastCarId = v23.LastCarId
									local v25 = false
									for k = 1, #v24.Cars do
										if v24.Cars[k].Id == LastCarId then
											v25 = v24.Cars[k]
											break
										end
									end
									LastOffset = if v25 and v25.Base then v21.Base.CFrame:ToObjectSpace(v25.Base.CFrame * LastOffset) else v21.Base.CFrame:ToObjectSpace(v17.PrimaryPart.CFrame)
									v23.LastCarId = v22
								end
								local v29 = LastOffset:Lerp(v19, 1 - math.exp(-5 * p1))
								v23.LastOffset = v29
								v17.PrimaryPart.CFrame = v21.Base.CFrame * v29
							end
						end
					end
				end
			end
		end
		RunService.Heartbeat:Connect(Stepped)
		t.OnCarEntered:Connect(function(p1) --[[ Line: 397 | Upvalues: LocalPlayer (ref), ChangePositionReplication (copy) ]]
			if LocalPlayer.Character then
				local v1 = nil
				local v2 = p1.Base and p1.Base.CFrame
				for v3, v4 in LocalPlayer.Character:GetDescendants() do
					if v4:IsA("BasePart") then
						if v1 == nil and v4.Name == "HumanoidRootPart" then
							v1 = v4.CFrame
						end
						v4.CollisionGroup = "PlayersInTrain"
					end
				end
				if v1 and (v2 and ChangePositionReplication) then
					ChangePositionReplication:FireServer("Train", true, p1.Id, v2:ToObjectSpace(v1))
				end
			end
		end)
		t.OnCarExited:Connect(function(p1, p2) --[[ Line: 415 | Upvalues: LocalPlayer (ref), ChangePositionReplication (copy) ]]
			if LocalPlayer.Character then
				for v1, v2 in LocalPlayer.Character:GetDescendants() do
					if v2:IsA("BasePart") then
						v2.CollisionGroup = "Players"
					end
				end
			end
			if not p2 and ChangePositionReplication then
				ChangePositionReplication:FireServer(nil, false)
			end
		end)
	end,
	Signals = t,
	GetSystemById = GetSystemById,
	GetCarById = GetCarById,
	MoveTrain = MoveTrain
}