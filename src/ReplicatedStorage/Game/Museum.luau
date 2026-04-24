-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UI = require(ReplicatedStorage.Module.UI)
local Maid = require(ReplicatedStorage.Std.Maid)
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local function PlaySound(p1, p2)
	local Sound = Instance.new("Sound")
	Sound.SoundId = ("rbxassetid://%d"):format(p2)
	Sound.Volume = 0.75
	Sound.Parent = p1
	Sound:Play()
	delay(1, function()
		game.Debris:AddItem(Sound, Sound.TimeLength)
	end)
end
return function(p1)
	local v1 = p1.Event
	local em = p1.em
	local ScreenGui = p1.ScreenGui
	local Sound = Instance.new("Sound")
	Sound.SoundId = "rbxassetid://1841825097"
	Sound.Looped = true
	Sound.SoundGroup = game:GetService("SoundService").RobberyMusic
	Sound.Parent = LocalPlayer.PlayerGui
	local v2 = 0
	local function FadeInSound()
		local v1 = v2 + 1
		v2 = v1
		Sound:Play()
		for i = 0, 1, 0.015 do
			if v1 ~= v1 then
				break
			end
			Sound.Volume = i
			wait()
		end
	end
	local function FadeOutSound()
		local v1 = v2 + 1
		v2 = v1
		for i = 1, 0, -0.015 do
			if v1 ~= v1 then
				return
			end
			Sound.Volume = i
			wait()
		end
		Sound:Stop()
	end
	local v3 = false
	local function EnterRobbery()
		if v3 then
			return error("Already in robbery")
		end
		v3 = true
		PlaySound(LocalPlayer, 1837831244)
		delay(1, function()
			PlaySound(LocalPlayer, 1843025542)
		end)
		spawn(FadeInSound)
	end
	local function ExitRobbery()
		if not v3 then
			return error("Player not in robbery")
		end
		v3 = false
		spawn(FadeOutSound)
	end
	function em.dhqg05sg()
		EnterRobbery()
	end
	function em.exsgze3l()
		if v3 then
			v3 = false
			spawn(FadeOutSound)
		else
			error("Player not in robbery")
		end
	end
	local function Ease_InOutQuad(p1)
		return p1 < 0.5 and 2 * p1 * p1 or -1 - 2 * (p1 - 2) * p1
	end
	local t = {}
	local v4 = Maid.new()
	local v5 = nil
	function em.aad1ukee(p1)
		if not v5 then
			return false
		end
		v5:Disconnect()
		v5 = nil
		v4:DoCleaning()
		for v1, v2 in next, p1 do
			v2.Part.Transparency = 1
			v2.Part.Color = Color3.fromRGB(153, 153, 153)
		end
	end
	function em.impi1r3j(p1)
		if v5 then
			em.aad1ukee()
		end
		for v12, v2 in next, p1 do
			v2.Part.Transparency = 0
		end
		local v3 = tick()
		for i, v in ipairs(p1) do
			v4:GiveTask(v.Part.Touched:Connect(function(p1)
				if p1:IsDescendantOf(LocalPlayer.Character) then
					local v12 = tick()
					if not (v12 - v3 < 0.2) and v12 - v.LastDamage >= 0.5 then
						v3 = v12
						v.LastDamage = v12
						v1:FireServer("y" .. ("pa5upbdeq"):sub(2, 5):reverse():reverse():reverse():reverse():reverse() .. "pwp")
					end
				end
			end))
		end
		local function getPeriod(p1)
			return 0.5 * p1.Duration * p1._speed
		end
		v5 = RunService.Heartbeat:Connect(function()
			for v3, v4 in next, p1 do
				local v1, v2
				if not v4._speed then
					v4._speed = 0
					v4._offset = 0
				end
				local Part = v4.Part
				v1 = if t.SecurityTripped then Color3.fromRGB(253, 106, 97) else Color3.fromRGB(153, 153, 153)
				Part.Color = v1
				v2 = if t.SecurityTripped then 2 else 1
				local v7 = workspace:GetServerTimeNow()
				local v8 = 0.5 * v4.Duration * v4._speed
				if v2 ~= v4._speed then
					v4._speed = v2
					local v9 = 0.5 * v4.Duration * v4._speed
					v4._offset = v4._offset + (v9 - v8) * v7
					v8 = v9
				end
				local v10 = GeomUtils.waveTriangle(v8 * v7 - v4._offset) / 2 + 0.5
				Part.CFrame = v4.StartCF:lerp(v4.EndCF, v10 < 0.5 and 2 * v10 * v10 or -1 - 2 * (v10 - 2) * v10)
			end
		end)
	end
	function em.ckvvbfd2(p1)
		t = p1
	end
	local CircleAction = UI.CircleAction
	local function Action(p1, p2)
		if p2 then
			PlaySound(LocalPlayer, 1843025542)
			v1:FireServer("r" .. "" .. ("p9cm02a8gq"):sub(5, 6):reverse() .. "" .. "" .. ("q5fhmdj"):sub(3, 3):reverse():reverse():reverse() .. "" .. "" .. ("vum2"):sub(2, 2):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("pw8wcyud"):sub(5, 6):reverse() .. "w", p1.Part)
			return true
		end
	end
	local function PreUpdateFun(p1)
		p1.Enabled = p1.Part.Parent.Arm.Transparency < 0.5
	end
	local function AddedFun(p1)
		CircleAction.Add({
			Part = p1,
			ValidRoot = p1.Parent,
			Name = "Place Dynamite",
			Timed = true,
			Duration = 1,
			Dist = 10,
			Callback = Action,
			PreUpdateFun = PreUpdateFun,
			PreUpdatePeriod = 0.1
		}, p1)
	end
	local function RemovedFun(p1)
		CircleAction.Remove(p1)
	end
	local v6 = next
	local v7, v8 = CollectionService:GetTagged("Museum_DynamiteNode")
	for v9, v10 in v6, v7, v8 do
		CircleAction.Add({
			Part = v10,
			ValidRoot = v10.Parent,
			Name = "Place Dynamite",
			Timed = true,
			Duration = 1,
			Dist = 10,
			Callback = Action,
			PreUpdateFun = PreUpdateFun,
			PreUpdatePeriod = 0.1
		}, v10)
	end
	CollectionService:GetInstanceAddedSignal("Museum_DynamiteNode"):Connect(AddedFun)
	CollectionService:GetInstanceRemovedSignal("Museum_DynamiteNode"):Connect(RemovedFun)
	local function Action_2(p1, p2)
		if p2 then
			PlaySound(LocalPlayer, 1988477690)
			PlaySound(LocalPlayer, 8473658289)
			v1:FireServer("r" .. ("ntohwid"):sub(5, 5):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("pmc3uf"):sub(2, 2):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("ly1zsxv"):sub(3, 3):reverse():reverse():reverse() .. "" .. "" .. ("vo0hayob"):sub(4, 5):reverse():reverse():reverse():reverse():reverse() .. "pj", p1.Part)
			return true
		end
	end
	local function PreUpdateFun_2(p1)
		p1.Enabled = (p1.HidePart or p1.Part).Transparency < 0.999
	end
	local function AddedFun_2(p1)
		local v1 = nil
		local v2 = nil
		local v3 = 2
		local v4 = p1.Name
		if v4 == "DonutNode" then
			v1 = p1.Parent.Model.Bread
			v4 = "Giant Donut"
		elseif v4 == "SpinnerRim" then
			v4 = "Spinner Rim"
		elseif v4 == "DinoBone" then
			v4 = "Bone"
			v3 = 1
		elseif v4 == "MummyNode" then
			v1 = p1.Parent.Glass
			v2 = p1.Parent
			v4 = "Mummy"
			v3 = 3
		elseif v4 == "Picture" then
			v2 = p1.Parent
		end
		CircleAction.Add({
			Part = p1,
			Name = "Grab " .. v4,
			Timed = true,
			Duration = v3,
			Dist = 10,
			Callback = Action_2,
			PreUpdateFun = PreUpdateFun_2,
			PreUpdatePeriod = 0.5,
			HidePart = v1,
			ValidRoot = v2
		}, p1)
	end
	local function RemovedFun_2(p1)
		local _ = p1.Name
		CircleAction.Remove(p1)
	end
	local v11 = next
	local v12, v13 = CollectionService:GetTagged("Museum_Item")
	for v14, v15 in v11, v12, v13 do
		AddedFun_2(v15)
	end
	CollectionService:GetInstanceAddedSignal("Museum_Item"):Connect(AddedFun_2)
	CollectionService:GetInstanceRemovedSignal("Museum_Item"):Connect(RemovedFun_2)
	local function Action_3(p1, p2)
		if p2 then
			PlaySound(LocalPlayer, 1837831244)
			v1:FireServer("z" .. ("wabix"):sub(2, 4):reverse():reverse():reverse():reverse():reverse() .. "" .. "" .. ("uzby1rmb"):sub(5, 7):reverse() .. "v", p1.Part)
			return true
		end
	end
	local function PreUpdateFun_3(p1)
		p1.Enabled = p1.Part.Reflectance < 0.15
	end
	local function AddedFun_3(p1)
		CircleAction.Add({
			Part = p1,
			Name = "Pull Lever",
			Timed = true,
			Duration = 1,
			Dist = 10,
			Callback = Action_3,
			PreUpdateFun = PreUpdateFun_3,
			PreUpdatePeriod = 0.5
		}, p1)
	end
	local function RemovedFun_3(p1)
		CircleAction.Remove(p1)
	end
	local v16 = next
	local v17, v18 = CollectionService:GetTagged("Museum_Lever")
	for v19, v20 in v16, v17, v18 do
		CircleAction.Add({
			Part = v20,
			Name = "Pull Lever",
			Timed = true,
			Duration = 1,
			Dist = 10,
			Callback = Action_3,
			PreUpdateFun = PreUpdateFun_3,
			PreUpdatePeriod = 0.5
		}, v20)
	end
	CollectionService:GetInstanceAddedSignal("Museum_Lever"):Connect(AddedFun_3)
	CollectionService:GetInstanceRemovedSignal("Museum_Lever"):Connect(RemovedFun_3)
end
