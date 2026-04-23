local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local Time = require(ReplicatedStorage.Module.Time)
local Joint = require(ReplicatedStorage.Std.Joint)
local Timeline = require(ReplicatedStorage.Module.Timeline)
local Audio = require(ReplicatedStorage.Std.Audio)
local RayCast = require(ReplicatedStorage.Module.RayCast)
local PlayerUtils = require(ReplicatedStorage.Game.PlayerUtils)
game:GetService("SoundService")
local MinimapService = require(ReplicatedStorage.App.MinimapService)
local DuffelBagUtils = require(ReplicatedStorage.Game.DuffelBag.DuffelBagUtils)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local RobberyCargoPlaneShared = require(ReplicatedStorage.Game.Robbery.RobberyCargoPlaneShared)
local RobberyConsts = require(ReplicatedStorage.Robbery.RobberyConsts)
local v1 = nil
local v2 = nil
local v3 = nil
local t = {
	alarm_siren_loop_01 = 4487202760,
	background_air_compressor_pump_loop_01 = 9058646197,
	prop_loop = 9058616635,
	hydraulic_strut_air_gas_shock_door_01 = 4487204926,
	collect_item_02 = 4487203151,
	truck_low_engine_rattle_loop = 9058628651,
	metal_sheet_impacts_01 = 4487205142,
	metal_sheet_impacts_02 = 4487205303,
	metal_sheet_impacts_03 = 4487205462,
	lever_sound = 1988476846
}
local t2 = { t.metal_sheet_impacts_01, t.metal_sheet_impacts_02, t.metal_sheet_impacts_03 }
local function Ease_InOutQuad(p1) --[[ Line: 44 ]]
	return p1 < 0.5 and 2 * p1 * p1 or -1 - 2 * (p1 - 2) * p1
end
local function Ease_InOutSine(p1) --[[ Line: 47 ]]
	return (math.sin(math.pi * p1 - 1.5707963267948966) + 1) * 0.5
end
local function v4(p1) --[[ Line: 51 | Upvalues: v4 (copy) ]]
	for i, v in ipairs(p1:GetChildren()) do
		if v:IsA("BasePart") then
			v.Transparency = 1
			v.CanCollide = false
		end
		v4(v)
	end
end
local function v5(p1) --[[ Line: 60 | Upvalues: v5 (copy) ]]
	for i, v in ipairs(p1:GetChildren()) do
		if v:IsA("BasePart") then
			v.Transparency = 0
			v.CanCollide = true
		end
		v5(v)
	end
end
local function GetHumanoid() --[[ Line: 70 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character
	if Character == nil then
		return nil
	else
		return Character:FindFirstChild("Humanoid")
	end
end
local function GetHRP() --[[ Line: 78 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character
	local v1 = if Character == nil then nil else Character:FindFirstChild("Humanoid")
	if v1 == nil then
		return nil
	else
		return v1.RootPart
	end
end
local t3 = {}
t3.__index = t3
function t3.new(p1, p2) --[[ Line: 89 | Upvalues: t3 (copy), Joint (copy), Signal (copy), CircleAction (copy) ]]
	assert(p1)
	assert(p1.PrimaryPart)
	assert(p2)
	local v2 = setmetatable({}, t3)
	v2.Model = p1
	v2._leverMotor = Joint.Motor(p1.PrimaryPart, p2)
	v2.Length = p1.PrimaryPart.Size.Z
	v2.OnSuccess = Signal.new()
	v2.OnFail = Signal.new()
	local function Action(p1, p2) --[[ Line: 100 | Upvalues: v2 (copy) ]]
		if p2 then
			v2.OnSuccess:Fire()
		end
		return true
	end
	local t = {
		Part = p1.PrimaryPart,
		Name = "Open Door",
		NoRay = true,
		Timed = true,
		Duration = 1,
		Dist = 8,
		Callback = Action
	}
	CircleAction.Add(t, p1.PrimaryPart)
	v2.Spec = t
	v2:Reset()
	return v2
end
function t3.SetAngle(p1, p2) --[[ Line: 121 ]]
	p1._leverMotor.C1 = p1._leverMotor.C0:Inverse() * CFrame.new(0, 0, p1.Length * 0.5) * CFrame.Angles(p2, 0, 0) * CFrame.new(0, 0, -p1.Length * 0.5) * p1._leverMotor.C0
end
function t3.Reset(p1) --[[ Line: 128 ]]
	p1:SetAngle(0.7853981633974483)
end
function t3.Pull(p1) --[[ Line: 131 ]]
	p1:SetAngle(-0.7853981633974483)
end
function t3.Destroy(p1) --[[ Line: 134 ]]
	p1.OnSuccess:Destroy()
	p1.OnSuccess = nil
	p1.OnFail:Destroy()
	p1.OnFail = nil
	p1.Spec.Kill = true
	p1.Spec = nil
end
local UnsafePositionReplication = ReplicatedStorage:FindFirstChild("UnsafePositionReplication")
local ChangePositionReplication = ReplicatedStorage:FindFirstChild("ChangePositionReplication")
local v6 = os.clock()
local v7 = CFrame.new()
local t4 = {}
local t5 = {}
local v8 = nil
local t6 = {}
t6.__index = t6
function t6.new(p1) --[[ Line: 157 | Upvalues: t6 (copy), Signal (copy), ReplicatedStorage (copy), CollectionService (copy), Joint (copy), Audio (copy), t (copy), t3 (copy), Time (copy), v1 (ref), v2 (ref), RobberyCargoPlaneShared (copy), Timeline (copy), RunService (copy), LocalPlayer (copy), DuffelBagUtils (copy), RobberyConsts (copy), MinimapService (copy) ]]
	assert(p1)
	local v22 = setmetatable({}, t6)
	v22.BornAt = p1
	v22.IsPlayerInsidePlane = false
	v22.IsPlayerOnPlane = false
	v22.OnPlayerEnter = Signal.new()
	v22.OnPlayerLeave = Signal.new()
	local v3 = ReplicatedStorage.Resource.RobberyCargoPlane.Plane:Clone()
	CollectionService:AddTag(v3.CargoPlane, "RobberyMarker")
	Joint.WeldAllTo(v3, v3.PrimaryPart, true)
	Joint.WeldAllTo(v3.ControlPanel, v3.PrimaryPart)
	Joint.WeldAllTo(v3.Crates, v3.PrimaryPart)
	Joint.WeldAllTo(v3.Model, v3.PrimaryPart)
	v22._topDoorMotor = Joint.Motor(v3.TopDoor.Part, v3.PrimaryPart)
	v3.TopDoor.Part.Anchored = false
	Joint.WeldAllTo(v3.BottomDoor.Door, v3.BottomDoor.Door.PrimaryPart)
	v22._bottomDoorMotor = Joint.Motor(v3.BottomDoor.Door.PrimaryPart, v3.PrimaryPart)
	Joint.WeldAllTo(v3.Lever, v3.Lever.PrimaryPart)
	v3.PrimaryPart.Anchored = true
	v3.Parent = workspace
	v22.Model = v3
	v22:SetupProps()
	v22.SoundEngineFlying = Audio.ObjectLocal(v3.Root, t.prop_loop, {
		Volume = 0,
		Looped = true,
		EmitterSize = 128,
		RollOffMaxDistance = 1536
	})
	v22.SoundEngineIdle = Audio.ObjectLocal(v3.Root, t.truck_low_engine_rattle_loop, {
		Volume = 0,
		Looped = true,
		EmitterSize = 64,
		RollOffMaxDistance = 1536
	})
	v22.SoundEngineBackground = Audio.ObjectLocal(v3.Root, t.background_air_compressor_pump_loop_01, {
		Volume = 0,
		Looped = true,
		EmitterSize = 64
	})
	v22.SoundWind = Audio.ObjectLocal(v3.WindNode, 9058653424, {
		Volume = 0,
		Looped = true,
		EmitterSize = 64,
		RollOffMaxDistance = 1536
	})
	v22.Lever = t3.new(v3.Lever, v3.PrimaryPart)
	v22.Lever.OnSuccess:Connect(function() --[[ Line: 208 | Upvalues: Time (ref), v22 (copy), Audio (ref), v3 (copy), v1 (ref) ]]
		if v22.CargoOpenedAt ~= nil and Time.GetNowSync() - v22.CargoOpenedAt < v22.SeqsCargoDuration then
			return false
		end
		Audio.ObjectLocal(v22.Model.PrimaryPart, 700180643, {
			TimePosition = 1,
			MaxPlaybackTime = 0.6
		})
		v3.ControlPanel.Light.Color = Color3.new(0/255, 255/255, 0/255)
		delay(0.1, function() --[[ Line: 216 | Upvalues: v3 (ref) ]]
			v3.ControlPanel.Light.Color = Color3.fromRGB(196, 40, 28)
		end)
		v1:FireServer("w" .. ("o3jonpri"):sub(5, 6):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("oog1nt"):sub(3, 4):reverse() .. "" .. "" .. ("ohk"):sub(2, 2):reverse():reverse():reverse() .. "xm")
	end)
	v22.Lever.OnFail:Connect(function() --[[ Line: 221 | Upvalues: v2 (ref), Audio (ref), v22 (copy), v3 (copy) ]]
		v2.mq92d5a8({
			Title = "CargoPlane",
			Text = "Keycard required. Search the crates..."
		})
		Audio.ObjectLocal(v22.Model.PrimaryPart, 700180643, {
			TimePosition = 0,
			MaxPlaybackTime = 0.6
		})
		v3.ControlPanel.Light.Color = Color3.new(0/255, 0/255, 0/255)
		delay(0.1, function() --[[ Line: 227 | Upvalues: v3 (ref) ]]
			v3.ControlPanel.Light.Color = Color3.fromRGB(196, 40, 28)
		end)
	end)
	v22.RealRoll = 0
	v22.RealDirection = v3.PrimaryPart.CFrame.LookVector
	v22.CargoOpenAmount = 0
	v22.ShouldDestroy = false
	local v4 = RobberyCargoPlaneShared.GetFlightData()
	local PathEnter = v4.PathEnter
	PathEnter.ApproxTotalLength = PathEnter:ApproximateLength(1000)
	v22.PathEnter = PathEnter
	local PathLeave = v4.PathLeave
	PathLeave.ApproxTotalLength = PathLeave:ApproximateLength(1000)
	v22.PathLeave = PathLeave
	local t2 = {
		SeqEnter = function(p1) --[[ Name: SeqEnter | Line: 250 | Upvalues: v22 (copy) ]]
			v22:SeqEnter(p1)
		end,
		SeqCargoOpen = function(p1) --[[ Name: SeqCargoOpen | Line: 253 | Upvalues: v22 (copy) ]]
			v22:SeqCargoOpen(p1)
		end,
		SeqLoadCrates = function(p1) --[[ Name: SeqLoadCrates | Line: 256 | Upvalues: v22 (copy) ]]
			v22:SeqLoadCrates(p1)
		end,
		SeqCargoClose = function(p1) --[[ Name: SeqCargoClose | Line: 259 | Upvalues: v22 (copy) ]]
			v22:SeqCargoClose(p1)
		end,
		SeqLeave = function(p1) --[[ Name: SeqLeave | Line: 262 | Upvalues: v22 (copy) ]]
			v22:SeqLeave(p1)
		end,
		SeqHatchOpen = function(p1) --[[ Name: SeqHatchOpen | Line: 265 | Upvalues: v22 (copy) ]]
			v22:SeqHatchOpen(p1)
		end,
		SeqHatchClose = function(p1) --[[ Name: SeqHatchClose | Line: 268 | Upvalues: v22 (copy) ]]
			v22:SeqHatchClose(p1)
		end,
		SeqNone = function() --[[ Name: SeqNone | Line: 271 ]] end
	}
	local t4 = {}
	for i = 1, #v4.SeqsLayout do
		local v5 = v4.SeqsLayout[i]
		local v6 = v5[1]
		local v7 = t2[v6]
		if v7 == nil then
			error("No seq function found for: " .. v6)
		end
		table.insert(t4, { v7, (assert(v5[2])) })
	end
	v22.mTimeline = Timeline.new(t4)
	local list = {
		{ t2.SeqCargoOpen, 2 },
		{ t2.SeqNone, 4 },
		{ t2.SeqCargoClose, 3 }
	}
	v22.SeqsCargo = list
	v22.Tl_Cargo = nil
	v22.CargoOpenedAt = nil
	local sum = 0
	for i, v in ipairs(list) do
		sum = sum + v[2]
	end
	v22.SeqsCargoDuration = sum
	v22.HeartbeatConn = RunService.Heartbeat:Connect(function(p1) --[[ Line: 301 | Upvalues: v22 (copy) ]]
		v22:Update(p1)
	end)
	v22.SoundMusic = nil
	v22.OnPlayerEnter:Connect(function() --[[ Line: 306 | Upvalues: v22 (copy), Audio (ref), LocalPlayer (ref) ]]
		if v22.SoundMusic then
			v22.SoundMusic:Destroy()
		end
		v22.SoundMusic = Audio.ObjectLocal(LocalPlayer.PlayerGui, 1837315896, {
			Looped = true,
			Volume = 1,
			GroupName = "RobberyMusic"
		})
		if LocalPlayer.Character then
			for v1, v2 in LocalPlayer.Character:QueryDescendants("BasePart") do
				v2.CollisionGroup = "PlayersInTrain"
			end
		end
	end)
	v22.OnPlayerLeave:Connect(function(p1) --[[ Line: 321 | Upvalues: v22 (copy), Audio (ref), DuffelBagUtils (ref), LocalPlayer (ref), RobberyConsts (ref), MinimapService (ref) ]]
		local SoundMusic = v22.SoundMusic
		if SoundMusic then
			v22.SoundMusic = nil
			Audio.promiseFadeTo(SoundMusic, 0, 1):finally(function() --[[ Line: 326 | Upvalues: SoundMusic (copy) ]]
				SoundMusic:Destroy()
			end):catch(warn)
		end
		local v1 = DuffelBagUtils.getBag(LocalPlayer)
		if not v22._setWaypoint and (v1 and v1:GetRobbery() == RobberyConsts.ENUM_ROBBERY.CARGO_PLANE) then
			v22._setWaypoint = true
			v1._maid:GiveTask(MinimapService.addWaypoint({
				position = Vector3.new(-346.243, 22.666, 2057.052),
				name = "CargoPlaneCollect",
				priority = 1000,
				minDist = 0
			}))
		end
		if (not p1 or p1 and v22.IsPlayerInsidePlane) and LocalPlayer.Character then
			for v2, v3 in LocalPlayer.Character:QueryDescendants("BasePart") do
				v3.CollisionGroup = "Players"
			end
		end
	end)
	v22:SetupCrates()
	v22.Tl_Hatch = nil
	v22.HatchOpenedAt = nil
	v22.SeqsHatch = {
		{ t2.SeqHatchOpen, 0.5 },
		{ t2.SeqNone, 2 },
		{ t2.SeqHatchClose, 0.5 }
	}
	v22:SetupHatch()
	return v22
end
function t6.SetupHatch(p1) --[[ Line: 363 | Upvalues: PlayerUtils (copy), Audio (copy), v1 (ref), CircleAction (copy) ]]
	p1.TopDoorModel = p1.Model.TopDoor
	p1._hatchOffset = p1.TopDoorModel.Part.CFrame:ToObjectSpace(p1.TopDoorModel.Open.CFrame)
	p1.TopDoorModel.Open:Destroy()
	local function Action(p12, p2) --[[ Line: 369 | Upvalues: PlayerUtils (ref), Audio (ref), p1 (copy), v1 (ref) ]]
		if PlayerUtils.hasKey() == true then
			if p2 then
				Audio.ObjectLocal(p1.Model.PrimaryPart, 700180643, {
					TimePosition = 1,
					MaxPlaybackTime = 0.6
				})
				v1:FireServer("u" .. "" .. ("bo2p"):sub(3, 3):reverse():reverse():reverse():reverse():reverse() .. "46rrbe")
			end
			return true
		else
			Audio.ObjectLocal(p1.Model.PrimaryPart, 700180643, {
				TimePosition = 0,
				MaxPlaybackTime = 0.6
			})
			return false
		end
	end
	local t = {
		Part = p1.TopDoorModel.Part,
		Name = "Open Door",
		NoRay = true,
		Timed = true,
		Duration = 5,
		Dist = 8,
		Callback = Action
	}
	CircleAction.Add(t, p1.TopDoorModel.Part)
	p1.SpecHatch = t
end
function t6.SeqHatchOpen(p1, p2) --[[ Line: 395 | Upvalues: Audio (copy) ]]
	local Part = p1.TopDoorModel.Part
	if p2 == 0 then
		Audio.ObjectLocal(Part, 1791024087)
		Part.CanCollide = false
	end
	p1._topDoorMotor.C1 = p1._topDoorMotor.C0:Inverse() * CFrame.new():Lerp(p1._hatchOffset, p2) * p1._topDoorMotor.C0
end
function t6.SeqHatchClose(p1, p2) --[[ Line: 405 | Upvalues: Audio (copy) ]]
	local Part = p1.TopDoorModel.Part
	if p2 == 0 then
		Audio.ObjectLocal(Part, 1791025004)
	elseif p2 == 1 then
		Part.CanCollide = true
	end
	p1._topDoorMotor.C1 = p1._topDoorMotor.C0:Inverse() * CFrame.new():Lerp(p1._hatchOffset, 1 - p2) * p1._topDoorMotor.C0
end
function t6.SetupCrates(p1) --[[ Line: 416 | Upvalues: v4 (copy) ]]
	local Crates = p1.Model.Crates
	local v1 = next
	local v2, v3 = Crates:GetChildren()
	local t = {}
	for v42, v5 in v1, v2, v3 do
		local t2 = {
			Name = v5.Name,
			Model = v5
		}
		t2.Model.PrimaryPart = v5["1"]
		table.insert(t, t2)
	end
	p1.Crates = t
	v4(Crates)
end
function t6.EnableCrates(p1) --[[ Line: 433 | Upvalues: v1 (ref), CircleAction (copy) ]]
	p1.CratesEnabled = true
	local function Action(p1, p2) --[[ Line: 435 | Upvalues: v1 (ref) ]]
		if p2 then
			v1:FireServer("x4dtvc4o", p1.Part.Parent.Name)
		end
		return true
	end
	for i, v in ipairs(p1.Crates) do
		local PrimaryPart = v.Model.PrimaryPart
		local t = {
			Part = PrimaryPart,
			Name = "Inspect Crate",
			NoRay = true,
			Timed = true,
			Duration = 10,
			Dist = 8,
			Callback = Action
		}
		CircleAction.Add(t, PrimaryPart)
		v.Spec = t
	end
end
function t6.SetupProps(p1) --[[ Line: 456 | Upvalues: Joint (copy) ]]
	local Model = p1.Model
	local PrimaryPart = Model.PrimaryPart
	local v1 = next
	local v2, v3 = Model.Props:GetChildren()
	local t = {}
	for v4, v5 in v1, v2, v3 do
		local t2 = {}
		local Prop = v5.Prop
		t2.PartProp = Prop
		t2.PartDisc = v5.Disc
		t2.Rotation = math.random()
		Joint.WeldAllTo(v5, Prop)
		t2._motor = Joint.Motor(Prop, PrimaryPart)
		table.insert(t, t2)
	end
	p1.Props = t
end
function t6.StepProps(p1, p2) --[[ Line: 477 ]]
	for i, v in ipairs(p1.Props) do
		local Rotation = v.Rotation
		v._motor.C1 = v._motor.C0:Inverse() * CFrame.Angles(0, 0, Rotation) * v._motor.C0
		v.PartDisc.Transparency = (1 - math.clamp(p2, 0, 1)) * 0.30000000000000004 + 0.7
		v.Rotation = Rotation + p2
	end
end
function t6.Update(p1, p2) --[[ Line: 486 | Upvalues: Time (copy), LocalPlayer (copy), Players (copy), RayCast (copy), ChangePositionReplication (copy), CurrentCamera (copy), UnsafePositionReplication (copy), v6 (ref), v7 (ref), t5 (copy), t4 (copy), Timeline (copy), Audio (copy) ]]
	debug.profilebegin("CargoPlane Update")
	local v1 = Time.GetNowSync()
	local v2 = v1 - p1.BornAt
	local v3 = false
	local v4 = false
	debug.profilebegin("PlayerInPlane")
	local Character = LocalPlayer.Character
	local v5 = if Character == nil then nil else Character:FindFirstChild("Humanoid")
	if v5 then
		local RootPart = v5.RootPart
		if RootPart then
			local t = { workspace.Items }
			local Rain = workspace:FindFirstChild("Rain")
			if Rain ~= nil then
				table.insert(t, Rain)
			end
			for i, v in ipairs(Players:GetPlayers()) do
				local Character_2 = v.Character
				if Character_2 then
					table.insert(t, Character_2)
				end
			end
			local v62 = RootPart.CFrame
			local v72 = RayCast.RayIgnoreNonCollideWithIgnoreList(v62.p, -v62.UpVector, 24, t, true)
			if v72 and v72:IsDescendantOf(p1.Model) then
				v4 = true
			end
			if v4 then
				local v8 = RayCast.RayIgnoreNonCollideWithIgnoreList(v62.p, v62.UpVector, 24, t, true)
				if v8 and v8:IsDescendantOf(p1.Model) then
					v3 = true
				end
			end
		end
	end
	debug.profileend()
	if v3 == true and p1.IsPlayerInsidePlane == false then
		p1.IsPlayerInsidePlane = v3
		p1.OnPlayerEnter:Fire()
	elseif v3 == false and p1.IsPlayerInsidePlane == true then
		p1.IsPlayerInsidePlane = v3
		p1.OnPlayerLeave:Fire()
	end
	if v4 == true and p1.IsPlayerOnPlane == false then
		p1.IsPlayerOnPlane = v4
	elseif v4 == false and p1.IsPlayerOnPlane == true then
		p1.IsPlayerOnPlane = v4
		ChangePositionReplication:FireServer(nil, false)
	end
	local Root = p1.Model.Root
	local v9 = Root.CFrame
	debug.profilebegin("Timeline Update")
	if p1.mTimeline and p1.mTimeline:Update(v2) then
		p1.mTimeline = nil
	end
	debug.profileend()
	local v10 = Root.CFrame
	local Magnitude = (v10.p - v9.p).Magnitude
	debug.profilebegin("Step Props")
	p1:StepProps(Magnitude * 0.2)
	debug.profileend()
	if v4 then
		local Unit = (p1.Model.WindNode.Position - v10.p).Unit
		local sum = v10 * v9:Inverse()
		if Magnitude > 0.01 and p1.CargoOpenAmount > 0.0001 then
			sum = sum + Unit * 0.3 * p2 * 60
		end
		local Character_2 = LocalPlayer.Character
		local v11 = if Character_2 == nil then nil else Character_2:FindFirstChild("Humanoid")
		local v12 = if v11 == nil then nil else v11.RootPart
		v12.CFrame = sum * v12.CFrame
		local v13 = CurrentCamera.CFrame:ToObjectSpace(CurrentCamera.Focus)
		CurrentCamera.CFrame = CurrentCamera.CFrame * v13 * (sum - sum.p) * v13:Inverse()
		if UnsafePositionReplication and os.clock() - v6 > 0.2 then
			local v14 = v10:ToObjectSpace(v12.CFrame)
			if not (v7 and v14:FuzzyEq(v7)) then
				v6 = os.clock()
				UnsafePositionReplication:FireServer("Plane", nil, v14)
				v7 = v14
			end
		end
		for v15, v16 in t5 do
			local v17 = v16:GetAttribute("PlaneOffset")
			if v12.Parent ~= v16 and (v16.PrimaryPart and v17) then
				local v18 = t4[v16]
				if not v18 then
					local t = {
						LastOffset = v10:ToObjectSpace(v16.PrimaryPart.CFrame)
					}
					t4[v16] = t
					v18 = t
				end
				local v19 = v18.LastOffset:Lerp(v17, 1 - math.exp(-5 * p2))
				v18.LastOffset = v19
				v16.PrimaryPart.CFrame = v10 * v19
			end
		end
	end
	if p1.CargoOpenedAt ~= nil then
		local v20 = v1 - p1.CargoOpenedAt
		if p1.Tl_Cargo == nil and v20 < p1.SeqsCargoDuration - 0.01 then
			p1.Tl_Cargo = Timeline.new(p1.SeqsCargo)
			Audio.FadeTo(p1.SoundWind, 1, 0.5)
		end
		if p1.Tl_Cargo ~= nil and p1.Tl_Cargo:Update(v20) == true then
			p1.Tl_Cargo = nil
			Audio.FadeTo(p1.SoundWind, 0, 0.5)
		end
	end
	if p1.Tl_Hatch ~= nil and p1.Tl_Hatch:Update(v1 - p1.HatchOpenedAt) == true then
		p1.Tl_Hatch = nil
	end
	debug.profileend()
	if p1.ShouldDestroy then
		task.defer(p1.Destroy, p1)
	end
end
function t6.StepRoll(p1, p2, p3) --[[ Line: 635 ]]
	if p2 ~= p2 then
		p2 = 0
	end
	local RealRoll = p1.RealRoll
	local v1 = RealRoll + (p2 - RealRoll) * p3
	p1.RealRoll = v1
	return v1
end
function t6.StepDirection(p1, p2) --[[ Line: 644 ]]
	local RealDirection = p1.RealDirection
	if p2.Magnitude <= 0.001 then
		return RealDirection
	else
		local v1 = RealDirection + (p2 - RealDirection) * 0.1
		p1.RealDirection = v1
		return v1
	end
end
function t6.SeqEnter(p1, p2) --[[ Line: 653 | Upvalues: Audio (copy) ]]
	if p2 == 0 then
		Audio.FadeTo(p1.SoundEngineFlying, 0.75, 0.1)
	elseif p2 == 1 then
		Audio.FadeTo(p1.SoundEngineFlying, 0, 1)
		Audio.FadeTo(p1.SoundEngineIdle, 0.6, 1)
	end
	local v1 = (math.sin(math.pi * p2 - 1.5707963267948966) + 1) * 0.5
	local Model = p1.Model
	local PathEnter = p1.PathEnter
	local v2, v3 = PathEnter:GetWorldPositionAt(PathEnter.ApproxTotalLength * v1)
	local v4 = p1:StepDirection(v3)
	local v9 = p1:StepRoll(if v1 > 0.8 then 0 else math.acos((Model.PrimaryPart.CFrame.LookVector:Dot(v3.Unit))) * 5, if v1 > 0.8 then 0.03 else 0.01)
	Model.PrimaryPart.CFrame = CFrame.new(v2, v2 + v4) * CFrame.Angles(0, 0, v9)
end
function t6.SeqLeave(p1, p2) --[[ Line: 670 | Upvalues: Audio (copy) ]]
	if p2 == 0 then
		Audio.FadeTo(p1.SoundEngineIdle, 0, 1)
		Audio.FadeTo(p1.SoundEngineFlying, 0.75, 1)
		Audio.FadeTo(p1.SoundEngineBackground, 0.6, 1)
	end
	if p2 > 0.2 and not p1.CratesEnabled then
		p1:EnableCrates()
	end
	local v1 = (math.sin(math.pi * p2 - 1.5707963267948966) + 1) * 0.5
	local Model = p1.Model
	local PathLeave = p1.PathLeave
	local v2, v3 = PathLeave:GetWorldPositionAt(PathLeave.ApproxTotalLength * v1)
	if v3.Magnitude > 0 then
		p1.Direction = v3
	end
	local v4 = p1:StepDirection(v3)
	local v9 = p1:StepRoll(if v1 < 0.2 then 0 else math.acos((Model.PrimaryPart.CFrame.LookVector:Dot(v3.Unit))) * 5, if v1 < 0.2 then 0.03 else 0.01)
	Model.PrimaryPart.CFrame = CFrame.new(v2, v2 + v4) * CFrame.Angles(0, 0, v9)
	if v1 == 1 then
		p1.ShouldDestroy = true
	end
end
function t6.SeqLoadCrates(p1, p2) --[[ Line: 695 | Upvalues: v5 (copy) ]]
	for i = 1, math.floor(p2 * (#p1.Crates - 1)) + 1 do
		local v2 = p1.Crates[i]
		if not v2.HasLoaded then
			v2.HasLoaded = true
			v5(v2.Model)
		end
	end
	if p2 == 1 then
		v5(p1.Model.Crates)
	end
end
function t6.SeqCargoOpen(p1, p2) --[[ Line: 709 | Upvalues: Audio (copy), t (copy), v8 (ref) ]]
	local Door = p1.Model.BottomDoor.Door
	if p2 == 0 then
		Audio.ObjectLocal(Door.PrimaryPart, t.hydraulic_strut_air_gas_shock_door_01)
		Audio.ObjectLocal(v8.Lever.Model.PrimaryPart, t.lever_sound)
		p1.Lever:Pull()
	end
	p1._bottomDoorMotor.C1 = p1._bottomDoorMotor.C0:Inverse() * CFrame.Angles(0, 0, -(p2 < 0.5 and 2 * p2 * p2 or -1 - 2 * (p2 - 2) * p2) * math.pi * 0.15) * p1._bottomDoorMotor.C0
	p1.CargoOpenAmount = p2
end
function t6.SeqCargoClose(p1, p2) --[[ Line: 724 | Upvalues: Audio (copy), t (copy), v8 (ref) ]]
	local Door = p1.Model.BottomDoor.Door
	if p2 == 0 then
		Audio.ObjectLocal(Door.PrimaryPart, t.hydraulic_strut_air_gas_shock_door_01)
		Audio.ObjectLocal(v8.Lever.Model.PrimaryPart, t.lever_sound)
		p1.Lever:Reset()
	elseif p2 == 1 then
		p1.CargoOpenedAt = nil
	end
	local v1 = 1 - p2
	p1._bottomDoorMotor.C1 = p1._bottomDoorMotor.C0:Inverse() * CFrame.Angles(0, 0, -(v1 < 0.5 and 2 * v1 * v1 or -1 - 2 * (v1 - 2) * v1) * math.pi * 0.15) * p1._bottomDoorMotor.C0
	p1.CargoOpenAmount = 1 - p2
end
function t6.Destroy(p1) --[[ Line: 740 | Upvalues: v8 (ref) ]]
	p1.HeartbeatConn:Disconnect()
	p1.HeartbeatConn = nil
	if p1.Crates ~= nil then
		for i = 1, #p1.Crates do
			local v1 = p1.Crates[i]
			if v1.Spec then
				v1.Spec.Kill = true
			end
		end
		p1.Crates = nil
	end
	p1.OnPlayerEnter:Destroy()
	p1.OnPlayerEnter = nil
	p1.OnPlayerLeave:Fire(true)
	p1.OnPlayerLeave:Destroy()
	p1.OnPlayerLeave = nil
	p1.SoundEngineFlying:Destroy()
	p1.SoundEngineFlying = nil
	p1.SoundEngineIdle:Destroy()
	p1.SoundEngineIdle = nil
	p1.SoundEngineBackground:Destroy()
	p1.SoundEngineBackground = nil
	p1.SoundWind:Destroy()
	p1.SoundWind = nil
	p1.Lever:Destroy()
	p1.Lever = nil
	p1.SpecHatch.Kill = true
	p1.SpecHatch = nil
	p1.Model:Destroy()
	p1.Model = nil
	v8 = nil
	setmetatable(p1, nil)
end
return {
	Init = function(p1) --[[ Name: Init | Line: 783 | Upvalues: v1 (ref), v2 (ref), v3 (ref), v8 (ref), t6 (copy), v4 (copy), Audio (copy), t2 (copy), Time (copy), Timeline (copy), CollectionService (copy), t5 (copy), t4 (copy) ]]
		local em = p1.em
		v1 = p1.Event
		v2 = em
		v3 = p1.Team
		local ScreenGui = p1.ScreenGui
		local v22 = Random.new()
		function em.p2y3cg32(p1) --[[ Line: 789 | Upvalues: v8 (ref), t6 (ref), v4 (ref), Audio (ref), t2 (ref), v22 (copy) ]]
			if p1 then
				if v8 == nil then
					v8 = t6.new(p1.BornAt)
				end
				v8.BornAt = p1.BornAt
				if p1.CargoOpenedAt ~= nil and v8.CargoOpenedAt ~= p1.CargoOpenedAt then
					v8.CargoOpenedAt = p1.CargoOpenedAt
				end
				if p1.CrateNamesTaken ~= nil then
					local t = {}
					for i, v in ipairs(p1.CrateNamesTaken) do
						t[v] = true
					end
					for i = #v8.Crates, 1, -1 do
						local v1 = v8.Crates[i]
						if t[v1.Name] then
							if v1.Spec then
								v1.Spec.Kill = true
							end
							v4(v1.Model)
							Audio.ObjectLocal(v1.Model:GetChildren()[1], t2[v22:NextInteger(1, #t2)], {
								Volume = 1
							})
							table.remove(v8.Crates, i)
						end
					end
				end
			elseif v8 then
				v8:Destroy()
				v8 = nil
			end
		end
		function em.u246rrbe() --[[ Line: 828 | Upvalues: v8 (ref), Time (ref), Timeline (ref) ]]
			if v8 == nil then
				error("No running plane to open hatch of.")
			end
			v8.HatchOpenedAt = Time.GetNowSync()
			v8.Tl_Hatch = Timeline.new(v8.SeqsHatch)
		end
		for v32, v42 in CollectionService:GetTagged("ReplicateCharacterPlane") do
			table.insert(t5, v42)
		end
		local t = {}
		CollectionService:GetInstanceAddedSignal("ReplicateCharacterPlane"):Connect(function(p1) --[[ Line: 841 | Upvalues: t5 (ref), t (copy) ]]
			table.insert(t5, p1)
			if t[p1] then
				task.cancel(t[p1])
				t[p1] = nil
			end
		end)
		CollectionService:GetInstanceRemovedSignal("ReplicateCharacterPlane"):Connect(function(p1) --[[ Line: 850 | Upvalues: t5 (ref), t (copy), t4 (ref) ]]
			table.remove(t5, table.find(t5, p1))
			if t[p1] then
				task.cancel(t[p1])
			end
			t[p1] = task.delay(2, function() --[[ Line: 860 | Upvalues: t4 (ref), p1 (copy), t (ref) ]]
				t4[p1] = nil
				t[p1] = nil
			end)
		end)
	end
}