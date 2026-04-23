local LocalPlayer = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local TrainSystem = require(ReplicatedStorage.Game.TrainSystem)
local v1 = nil
local v2 = nil
local function Ease_InOutQuad(p1) --[[ Line: 11 ]]
	return p1 < 0.5 and 2 * p1 * p1 or -1 - 2 * (p1 - 2) * p1
end
local function OpenRoofDoorRaw(p1) --[[ Line: 14 | Upvalues: RunService (copy) ]]
	if not p1.RoofDoorOpen then
		p1.RoofDoorOpen = true
		local v1 = tick()
		local v2 = nil
		local function Heartbeat() --[[ Line: 22 | Upvalues: v1 (copy), v2 (ref), p1 (copy) ]]
			local v12 = (tick() - v1) * 0.5
			if v12 >= 1 then
				v2:Disconnect()
				v12 = 1
			end
			local v22, v3
			if v12 < 0.5 then
				v22 = 2 * v12 * v12
				if not v22 then
					v3 = v12
					v22 = -1 - 2 * (v12 - 2) * v12
				end
			else
				v3 = v12
				v22 = -1 - 2 * (v12 - 2) * v12
			end
			p1.RoofDoorMotor.C1 = CFrame.new():lerp(p1.RoofDoorOpenC1, v22)
		end
		v2 = RunService.Heartbeat:Connect(Heartbeat)
		p1.RoofDoorSpec.Kill = true
		return true
	end
end
local function OpenSideDoorRaw(p1) --[[ Line: 40 | Upvalues: RunService (copy) ]]
	if not p1.DoorOpen then
		p1.DoorOpen = true
		local v1 = tick()
		local v2 = nil
		local function Heartbeat() --[[ Line: 48 | Upvalues: v1 (copy), v2 (ref), p1 (copy) ]]
			local v12 = (tick() - v1) * 0.5
			if v12 >= 1 then
				v2:Disconnect()
				v12 = 1
			end
			local v22, v3
			if v12 < 0.5 then
				v22 = 2 * v12 * v12
				if not v22 then
					v3 = v12
					v22 = -1 - 2 * (v12 - 2) * v12
				end
			else
				v3 = v12
				v22 = -1 - 2 * (v12 - 2) * v12
			end
			p1.DoorMotor.C1 = CFrame.new():Lerp(p1.DoorOpenC1, v22)
		end
		v2 = RunService.Heartbeat:Connect(Heartbeat)
		p1.SideDoorSpec.Kill = true
		return true
	end
end
local function OpenVaultDoorRaw(p1) --[[ Line: 64 | Upvalues: RunService (copy) ]]
	if p1.VaultOpenC1 then
		if not p1.VaultOpened and p1.RoofDoorOpen then
			p1.VaultOpened = true
			local Root = p1.Model.Skeleton.Vault.Root
			local Sound = Instance.new("Sound")
			Sound.SoundId = "rbxassetid://55224766"
			Sound.Parent = Root
			Sound.Volume = 0.6
			Sound.RollOffMode = Enum.RollOffMode.InverseTapered
			Sound:Play()
			game.Debris:AddItem(Sound, 5)
			local Explosion = Instance.new("Explosion")
			Explosion.Position = Root.Position
			Explosion.DestroyJointRadiusPercent = 0
			Explosion.BlastPressure = 5000
			Explosion.Parent = Root
			game.Debris:AddItem(Explosion, 5)
			wait(0.1)
			local v1 = tick()
			local v2 = nil
			local function Heartbeat() --[[ Line: 96 | Upvalues: v1 (copy), v2 (ref), p1 (copy) ]]
				local v12 = (tick() - v1) * 0.5
				if v12 >= 1 then
					v2:Disconnect()
					v12 = 1
				end
				local v22, v3
				if v12 < 0.5 then
					v22 = 2 * v12 * v12
					if not v22 then
						v3 = v12
						v22 = -1 - 2 * (v12 - 2) * v12
					end
				else
					v3 = v12
					v22 = -1 - 2 * (v12 - 2) * v12
				end
				p1.VaultMotor.C1 = CFrame.new():Lerp(p1.VaultOpenC1, v22)
			end
			v2 = RunService.Heartbeat:Connect(Heartbeat)
			p1.VaultDoorSpec.Kill = true
			return true
		end
	end
end
local function SetupBoxCar(p1) --[[ Line: 112 | Upvalues: RunService (copy), v1 (ref), CircleAction (copy), OpenVaultDoorRaw (copy) ]]
	local t = {}
	local Model = p1.Model
	local function Action(p12, p2) --[[ Line: 116 | Upvalues: p1 (copy), RunService (ref), v1 (ref) ]]
		if p2 then
			local v12 = p1
			local v2
			if v12.RoofDoorOpen then
				v2 = nil
			else
				v12.RoofDoorOpen = true
				local v3 = tick()
				local v4 = nil
				local function Heartbeat() --[[ Line: 22 | Upvalues: v3 (copy), v4 (ref), v12 (copy) ]]
					local v1 = (tick() - v3) * 0.5
					if v1 >= 1 then
						v4:Disconnect()
						v1 = 1
					end
					local v2, v32
					if v1 < 0.5 then
						v2 = 2 * v1 * v1
						if not v2 then
							v32 = v1
							v2 = -1 - 2 * (v1 - 2) * v1
						end
					else
						v32 = v1
						v2 = -1 - 2 * (v1 - 2) * v1
					end
					v12.RoofDoorMotor.C1 = CFrame.new():lerp(v12.RoofDoorOpenC1, v2)
				end
				v4 = RunService.Heartbeat:Connect(Heartbeat)
				v12.RoofDoorSpec.Kill = true
				v2 = true
			end
			if v2 then
				v1:FireServer("b" .. ("cqriz95"):sub(2, 4):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("nv5a"):sub(2, 3):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("k2hpd8"):sub(2, 2):reverse() .. "d", p1.SystemId, p1.Id)
			else
				return false
			end
		end
		return true
	end
	local RoofDoorClosed = Model.Skeleton.RoofDoorClosed
	local t2 = {
		Part = RoofDoorClosed,
		Name = "Open Door",
		ValidRoot = p1.Model,
		Timed = true,
		NoRay = true,
		Duration = 2,
		Dist = 10,
		Callback = Action
	}
	CircleAction.Add(t2, RoofDoorClosed)
	p1.RoofDoorSpec = t2
	table.insert(t, t2)
	local function Action_2(p12, p2) --[[ Line: 142 | Upvalues: p1 (copy), RunService (ref), v1 (ref) ]]
		if p2 then
			local v12 = p1
			local v2
			if v12.DoorOpen then
				v2 = nil
			else
				v12.DoorOpen = true
				local v3 = tick()
				local v4 = nil
				local function Heartbeat() --[[ Line: 48 | Upvalues: v3 (copy), v4 (ref), v12 (copy) ]]
					local v1 = (tick() - v3) * 0.5
					if v1 >= 1 then
						v4:Disconnect()
						v1 = 1
					end
					local v2, v32
					if v1 < 0.5 then
						v2 = 2 * v1 * v1
						if not v2 then
							v32 = v1
							v2 = -1 - 2 * (v1 - 2) * v1
						end
					else
						v32 = v1
						v2 = -1 - 2 * (v1 - 2) * v1
					end
					v12.DoorMotor.C1 = CFrame.new():Lerp(v12.DoorOpenC1, v2)
				end
				v4 = RunService.Heartbeat:Connect(Heartbeat)
				v12.SideDoorSpec.Kill = true
				v2 = true
			end
			if v2 then
				v1:FireServer("w" .. ("qovodl"):sub(3, 3):reverse() .. "" .. "" .. ("uh5prsl96"):sub(5, 6):reverse() .. "" .. "" .. ("q34cz4"):sub(3, 4):reverse() .. "" .. "" .. ("y6kk0qls"):sub(5, 5):reverse():reverse():reverse() .. "j", p1.SystemId, p1.Id)
			else
				return false
			end
		end
		return true
	end
	local LeftDoorClosed = Model.Skeleton.LeftDoorClosed
	local t3 = {
		Part = LeftDoorClosed,
		Name = "Open Door",
		ValidRoot = p1.Model,
		Timed = true,
		NoRay = true,
		Duration = 2,
		Dist = 10,
		Callback = Action_2
	}
	CircleAction.Add(t3, LeftDoorClosed)
	p1.SideDoorSpec = t3
	table.insert(t, t3)
	local function Action_3(p12, p2) --[[ Line: 168 | Upvalues: OpenVaultDoorRaw (ref), p1 (copy), v1 (ref) ]]
		if p2 and OpenVaultDoorRaw(p1) then
			v1:FireServer("udhdjqcd", p1.SystemId, p1.Id)
		elseif p2 then
			return false
		end
		return true
	end
	local Root = Model.Skeleton.Vault.Root
	local t4 = {
		Part = Root,
		Name = "Breach Vault",
		Timed = true,
		NoRay = true,
		Duration = 3,
		Dist = 20,
		Callback = Action_3
	}
	CircleAction.Add(t4, Root)
	p1.VaultDoorSpec = t4
	table.insert(t, t4)
	p1.CircleActionSpecs = t
end
local function OnCarCreated(p1) --[[ Line: 194 | Upvalues: SetupBoxCar (copy) ]]
	if p1.Name:find("BoxCar") then
		SetupBoxCar(p1)
	end
end
local function OnCarDestroyed(p1) --[[ Line: 199 ]]
	if p1.Name:find("BoxCar") then
		for v1, v2 in next, p1.CircleActionSpecs do
			if not v2.Kill then
				v2.Kill = true
			end
		end
	end
end
local v3 = nil
local function OnCarEntered(p1) --[[ Line: 209 | Upvalues: v3 (ref), RunService (copy), LocalPlayer (copy), v1 (ref) ]]
	if p1.Name:find("BoxCar") then
		local v12 = 0
		v3 = RunService.Heartbeat:Connect(function() --[[ Line: 213 | Upvalues: v12 (ref), p1 (copy), LocalPlayer (ref), v1 (ref) ]]
			local v13 = tick()
			if v13 - v12 > 1 then
				v12 = v13
				if p1.VaultOpened and (p1.Model.Model.Rob.Gold.Position - LocalPlayer.Character.Humanoid.RootPart.Position).Magnitude < 6 then
					v1:FireServer("q" .. "" .. ("ji96bgzpu2n"):sub(3, 7):reverse() .. "" .. "" .. ("hxpxhgz1"):sub(5, 5):reverse():reverse():reverse():reverse():reverse() .. "v", p1.SystemId, p1.Id)
				end
			end
		end)
	end
end
local function OnCarExited(p1) --[[ Line: 230 | Upvalues: v3 (ref), v1 (ref) ]]
	if p1.Name:find("BoxCar") then
		if v3 then
			v3:Disconnect()
			v3 = nil
		end
		v1:FireServer("q" .. ("uzm"):sub(2, 2):reverse():reverse():reverse() .. "" .. "" .. ("b0cvi"):sub(3, 4):reverse() .. "gwi5", p1.SystemId, p1.Id)
	end
end
return {
	Init = function(p1) --[[ Name: Init | Line: 240 | Upvalues: v1 (ref), v2 (ref), TrainSystem (copy), OnCarCreated (copy), OnCarDestroyed (copy), OnCarEntered (copy), OnCarExited (copy), RunService (copy), OpenVaultDoorRaw (copy) ]]
		local em = p1.em
		v1 = p1.Event
		v2 = em
		TrainSystem.Signals.OnCarCreated:Connect(OnCarCreated)
		TrainSystem.Signals.OnCarDestroyed:Connect(OnCarDestroyed)
		TrainSystem.Signals.OnCarEntered:Connect(OnCarEntered)
		TrainSystem.Signals.OnCarExited:Connect(OnCarExited)
		function em.birq5v2d(p1, p2) --[[ Line: 248 | Upvalues: TrainSystem (ref), RunService (ref) ]]
			local v1 = TrainSystem.GetSystemById(p1)
			local v2 = TrainSystem.GetCarById(v1, p2)
			if v1 and v2 then
				if not v2.RoofDoorOpen then
					v2.RoofDoorOpen = true
					local v3 = tick()
					local v4 = nil
					local function Heartbeat() --[[ Line: 22 | Upvalues: v3 (copy), v4 (ref), v2 (copy) ]]
						local v1 = (tick() - v3) * 0.5
						if v1 >= 1 then
							v4:Disconnect()
							v1 = 1
						end
						local v22, v32
						if v1 < 0.5 then
							v22 = 2 * v1 * v1
							if not v22 then
								v32 = v1
								v22 = -1 - 2 * (v1 - 2) * v1
							end
						else
							v32 = v1
							v22 = -1 - 2 * (v1 - 2) * v1
						end
						v2.RoofDoorMotor.C1 = CFrame.new():lerp(v2.RoofDoorOpenC1, v22)
					end
					v4 = RunService.Heartbeat:Connect(Heartbeat)
					v2.RoofDoorSpec.Kill = true
				end
				return true
			else
				return nil
			end
		end
		function em.wvsrc40j(p1, p2) --[[ Line: 257 | Upvalues: TrainSystem (ref), RunService (ref) ]]
			local v1 = TrainSystem.GetSystemById(p1)
			local v2 = TrainSystem.GetCarById(v1, p2)
			if v1 and v2 then
				if not v2.DoorOpen then
					v2.DoorOpen = true
					local v3 = tick()
					local v4 = nil
					local function Heartbeat() --[[ Line: 48 | Upvalues: v3 (copy), v4 (ref), v2 (copy) ]]
						local v1 = (tick() - v3) * 0.5
						if v1 >= 1 then
							v4:Disconnect()
							v1 = 1
						end
						local v22, v32
						if v1 < 0.5 then
							v22 = 2 * v1 * v1
							if not v22 then
								v32 = v1
								v22 = -1 - 2 * (v1 - 2) * v1
							end
						else
							v32 = v1
							v22 = -1 - 2 * (v1 - 2) * v1
						end
						v2.DoorMotor.C1 = CFrame.new():Lerp(v2.DoorOpenC1, v22)
					end
					v4 = RunService.Heartbeat:Connect(Heartbeat)
					v2.SideDoorSpec.Kill = true
				end
				return true
			else
				return nil
			end
		end
		function em.udhdjqcd(p1, p2) --[[ Line: 266 | Upvalues: TrainSystem (ref), OpenVaultDoorRaw (ref) ]]
			local v1 = TrainSystem.GetSystemById(p1)
			local v2 = TrainSystem.GetCarById(v1, p2)
			if v1 and v2 and OpenVaultDoorRaw(v2) then
				OpenVaultDoorRaw(v2)
				return true
			else
				return nil
			end
		end
	end
}