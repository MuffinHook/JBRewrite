local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TrainSystem = require(ReplicatedStorage.Game.TrainSystem)
local Joint = require(ReplicatedStorage.Std.Joint)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local v1 = nil
local v2 = nil
local v3 = nil
local function comma(p1) --[[ Line: 12 ]]
	local v1, v2, v3 = string.match(p1, "^([^%d]*%d)(%d*)(.-)$")
	return v1 .. v2:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v3
end
local function FormatMoney(p1) --[[ Line: 16 ]]
	local v3, v4, v5 = string.match(math.abs(p1), "^([^%d]*%d)(%d*)(.-)$")
	return ("%s$%s"):format(if p1 >= 0 then "" else "-", v3 .. v4:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v5)
end
local function PlaySound(p1, p2) --[[ Line: 20 ]]
	local Sound = Instance.new("Sound")
	Sound.SoundId = ("rbxassetid://%d"):format(p2)
	Sound.Volume = 0.75
	Sound.RollOffMode = Enum.RollOffMode.InverseTapered
	Sound.Parent = p1
	Sound:Play()
	delay(1, function() --[[ Line: 27 | Upvalues: Sound (copy) ]]
		game.Debris:AddItem(Sound, Sound.TimeLength)
	end)
end
local function OpenRoofDoorRaw(p1, p2) --[[ Line: 31 | Upvalues: PlaySound (copy), CircleAction (copy) ]]
	local v2 = assert(p1.Model.Model:FindFirstChild("Glass" .. tostring(p2)), "missing glassPart")
	if not p1.GlassIndexOpen[p2] then
		p1.GlassIndexOpen[p2] = true
		v2.CanCollide = false
		v2.Transparency = 1
		PlaySound(v2, 848150421)
		CircleAction.Remove(v2)
		return true
	end
end
local function OpenSideDoorRaw(p1, p2) --[[ Line: 43 | Upvalues: CircleAction (copy) ]]
	local v2 = assert(p1.Model.Skeleton:FindFirstChild("Door" .. tostring(p2)), "missing doorModel")
	if not p1.DoorIndexOpen[p2] then
		p1.DoorIndexOpen[p2] = true
		p1.DoorOpenFuncs[p2]()
		CircleAction.Remove(v2)
		return true
	end
end
local v4 = CFrame.new()
local function SetupPassengerCar(p1) --[[ Line: 54 | Upvalues: v1 (ref), CircleAction (copy), ReplicatedStorage (copy), Joint (copy), v4 (copy), OpenRoofDoorRaw (copy) ]]
	local t = {}
	local function GrabAction(p12, p2) --[[ Line: 56 | Upvalues: v1 (ref), p1 (copy) ]]
		if p2 then
			p12.IsMine = true
			v1:FireServer("no98ghkm", p1.SystemId, p1.Id, p12.SpawnName, p12.ItemName)
		end
		return true
	end
	p1.Items = {}
	local Model = p1.Model
	if p1.Name == "PassengerArmor" then
		for v12, v2 in Model.Model.Cash:GetChildren() do
			local t2 = {
				Part = v2,
				Name = "Grab Cash",
				Timed = true,
				Duration = 0.65,
				Dist = 6,
				Callback = GrabAction,
				SpawnName = v2.Name,
				ItemName = "RackOfCash"
			}
			CircleAction.Add(t2, v2)
			table.insert(t, t2)
			p1.Items[v2.Name] = v2
		end
	else
		local v3 = next
		local v42, v5 = Model.Model.Spawns:GetChildren()
		for v6, v7 in v3, v42, v5 do
			local v8 = p1.ChosenItems[v7.Name]
			if v8 then
				local v9 = ReplicatedStorage.Resource.TrainGrabItems[v8]:Clone()
				v9.CanCollide = false
				Joint.CustomWeld(v9, p1.Base, (v7.CFrame * CFrame.new(0, v9.Size.Y * 0.5, 0) * CFrame.Angles(0, (math.random() - 0.5) * 2 * 0.1, 0)):toObjectSpace(p1.Base.CFrame), v4)
				v9.Anchored = false
				v9.Parent = Model
				p1.Items[v7.Name] = v9
				local t2 = {
					Part = v9,
					Name = ("Grab %s"):format(v8:lower()),
					Timed = true,
					Duration = 0.65,
					Dist = 6,
					Callback = GrabAction,
					SpawnName = v7.Name,
					ItemName = v8
				}
				CircleAction.Add(t2, v9)
				table.insert(t, t2)
			end
			v7:Destroy()
		end
	end
	if p1.Name ~= "PassengerArmor" then
		local function Action(p12, p2) --[[ Line: 118 | Upvalues: OpenRoofDoorRaw (ref), p1 (copy), v1 (ref) ]]
			if p2 and OpenRoofDoorRaw(p1, p12.GlassIndex) then
				v1:FireServer("i" .. ("dls1l"):sub(2, 4):reverse():reverse():reverse():reverse():reverse() .. "qzvb", p1.SystemId, p1.Id, p12.GlassIndex)
			elseif p2 then
				return false
			end
			return true
		end
		for i = 1, 2 do
			local v11 = Model.Model:FindFirstChild("Glass" .. tostring(i))
			local t2 = {
				Part = v11,
				Name = "Break Glass",
				ValidRoot = p1.Model,
				Timed = true,
				NoRay = true,
				Duration = 1.5,
				Dist = 10,
				Callback = Action,
				GlassIndex = i
			}
			CircleAction.Add(t2, v11)
			table.insert(t, t2)
		end
	end
	local function SideDoorAction(p12, p2) --[[ Line: 147 | Upvalues: p1 (copy), CircleAction (ref), v1 (ref) ]]
		if p2 then
			local v12 = p1
			local DoorIndex = p12.DoorIndex
			local v3 = assert(v12.Model.Skeleton:FindFirstChild("Door" .. tostring(DoorIndex)), "missing doorModel")
			local v4
			if v12.DoorIndexOpen[DoorIndex] then
				v4 = nil
			else
				v12.DoorIndexOpen[DoorIndex] = true
				v12.DoorOpenFuncs[DoorIndex]()
				CircleAction.Remove(v3)
				v4 = true
			end
			if v4 then
				v1:FireServer("r" .. ("z8jlxqn5i"):sub(4, 5):reverse() .. "" .. "" .. ("mjscq"):sub(3, 3):reverse() .. "" .. "" .. ("w5419skn"):sub(5, 7):reverse():reverse():reverse() .. "y", p1.SystemId, p1.Id, p12.DoorIndex)
			else
				return false
			end
		end
		return true
	end
	for j = 1, 2 do
		local v12 = Model.Skeleton:FindFirstChild("Door" .. tostring(j))
		if v12 then
			local t2 = {
				Part = v12.PrimaryPart,
				Name = "Open Door",
				ValidRoot = p1.Model,
				Timed = false,
				NoRay = true,
				Dist = 10,
				Callback = SideDoorAction,
				DoorIndex = j
			}
			CircleAction.Add(t2, v12)
			table.insert(t, t2)
		end
	end
	p1.CircleActionSpecs = t
	p1.GlassIndexOpen = {}
	p1.DoorIndexOpen = {}
end
local function OnCarCreated(p1) --[[ Line: 180 | Upvalues: SetupPassengerCar (copy) ]]
	if p1.Name:sub(1, 9) == "Passenger" then
		SetupPassengerCar(p1)
	end
end
local function OnCarDestroyed(p1) --[[ Line: 186 ]]
	if p1.Name:sub(1, 9) == "Passenger" then
		if p1.CircleActionSpecs then
			for v1, v2 in next, p1.CircleActionSpecs do
				if not v2.Kill then
					v2.Kill = true
				end
			end
		else
			warn("Car.CircleActionSpecs is nil")
			print(p1)
		end
	end
end
return {
	Init = function(p1) --[[ Name: Init | Line: 201 | Upvalues: v1 (ref), v2 (ref), v3 (ref), TrainSystem (copy), OnCarCreated (copy), OnCarDestroyed (copy), PlaySound (copy), LocalPlayer (copy), OpenRoofDoorRaw (copy) ]]
		local em = p1.em
		v1 = p1.Event
		v2 = em
		v3 = p1.ScreenGui
		TrainSystem.Signals.OnCarCreated:Connect(OnCarCreated)
		TrainSystem.Signals.OnCarDestroyed:Connect(OnCarDestroyed)
		function em.no98ghkm(p1, p2, p3) --[[ Line: 210 | Upvalues: TrainSystem (ref), PlaySound (ref), LocalPlayer (ref) ]]
			local v1 = TrainSystem.GetSystemById(p1)
			if v1 then
				local v2 = TrainSystem.GetCarById(v1, p2)
				if v2 and v2.Items[p3] then
					v2.Items[p3]:Destroy()
					if v2.CircleActionSpecs then
						for v3, v4 in v2.CircleActionSpecs do
							if v4.SpawnName == p3 then
								v4.Kill = true
								if v4.IsMine then
									PlaySound(LocalPlayer, 1988477690)
								end
								break
							end
						end
					end
					return true
				else
					return nil
				end
			else
				return nil
			end
		end
		function em.i1slqzvb(p1, p2, p3) --[[ Line: 237 | Upvalues: TrainSystem (ref), OpenRoofDoorRaw (ref) ]]
			local v1 = TrainSystem.GetSystemById(p1)
			if v1 then
				local v2 = TrainSystem.GetCarById(v1, p2)
				if v2 then
					OpenRoofDoorRaw(v2, p3)
					return true
				else
					return nil
				end
			else
				return nil
			end
		end
	end
}