-- Reviewed by Claude
-- variables reassigned
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DuffelBagBinder = require(ReplicatedStorage.Game.DuffelBag.DuffelBagBinder)
local DuffelBagConsts = require(ReplicatedStorage.Game.DuffelBag.DuffelBagConsts)
local RobberyMoneyUI = require(ReplicatedStorage.Game.RobberyMoneyUI.RobberyMoneyUI)
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
local Time = require(ReplicatedStorage.Module.Time)
local Audio = require(ReplicatedStorage.Std.Audio)
local Maid_2 = require(ReplicatedStorage.Std.Maid)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local bankEventSignal = nil
local eventManager = nil
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
local RobberyBankClass = {}
RobberyBankClass.__index = RobberyBankClass
function RobberyBankClass.new(p1, p2)
	assert(p1 ~= nil)
	assert(p2 ~= nil)
	local instance = {}
	setmetatable(instance, RobberyBankClass)
	local layoutChild = p2.Layout:GetChildren()[1]
	assert(layoutChild ~= nil)
	instance.ModelLayout = layoutChild
	instance.Maid = Maid_2.new()
	instance.BornAtSync = p1
	if instance.ModelLayout:FindFirstChild("Lasers") then
		instance:SetupLasers(layoutChild)
	end
	return instance
end
function RobberyBankClass.SetupLasers(p1, p2)
	local Lasers = p2:WaitForChild("Lasers")
	assert(Lasers)
	local laserTable = {}
	for i, v in ipairs(Lasers:GetChildren()) do
		if v.Name == "Laser" or (v.Name == "LaserWall" or v.Name == "LaserTrack") then
			local laserPeriod = 2
			if v.Name == "LaserWall" then
				laserPeriod = 5
			elseif v.Name == "LaserTrack" then
				laserPeriod = 7
			end
			local Part = v:WaitForChild("Part", 3)
			table.insert(laserTable, {
				Part = Part,
				Origin = Part.CFrame,
				Target = v.End.CFrame,
				Period = laserPeriod
			})
		end
	end
	p1.Maid:GiveTask(RunService.Heartbeat:Connect(function()
		local elapsedTime = Time.GetNowSync() - p1.BornAtSync
		for i, v in ipairs(laserTable) do
			v.Part.CFrame = v.Origin:lerp(v.Target, math.cos(elapsedTime * (6.283185307179586 / v.Period)) * -0.5 + 0.5)
		end
	end))
	p1.Maid:GiveTask(function()
		for i, v in ipairs(laserTable) do
			v.Part.CFrame = v.Origin
		end
	end)
end
function RobberyBankClass.Destroy(p1)
	p1.Maid:Destroy()
	p1.Maid = nil
end
return {
	Init = function(p1)
		local em = p1.em
		bankEventSignal = p1.Event
		eventManager = em
		local Sound = Instance.new("Sound")
		Sound.SoundId = "rbxassetid://1848209466"
		Sound.Looped = true
		Sound.Volume = 0
		Sound.SoundGroup = game:GetService("SoundService").RobberyMusic
		Sound.Parent = LocalPlayer.PlayerGui
		local soundFadeConnection = nil
		local bankInstance = nil
		local moneyRenderConnection = nil
		function em.qqzqeh08(p1, p2, p3, p4)
			if not moneyRenderConnection then
				local duffelBinder = nil
				local maxValue = p4:FindFirstChild(DuffelBagConsts.MAXIMUM_VALUE_NAME)
				local multValue = p4:FindFirstChild(DuffelBagConsts.MULT_VALUE_NAME)
				local multEnabledValue = p4:FindFirstChild(DuffelBagConsts.MULT_ENABLED_VALUE_NAME)
				moneyRenderConnection = RunService.RenderStepped:Connect(function()
					if not duffelBinder then
						duffelBinder = DuffelBagBinder:Get(p4)
					end
					if duffelBinder and p4.Parent then
						local currentMoney = math.floor(p2 + (workspace:GetServerTimeNow() - p1) * p3)
						local maxMoney = multEnabledValue.Value and math.ceil(maxValue.Value * multValue.Value) or maxValue.Value
						RobberyMoneyUI.SetMoney(math.clamp(currentMoney, 0, maxMoney), maxMoney, true)
					end
				end)
			end
		end
		function em.jpukwdz9(p1)
			if moneyRenderConnection then
				moneyRenderConnection:Disconnect()
				moneyRenderConnection = nil
			end
			local multEnabledValue = p1 and p1:FindFirstChild(DuffelBagConsts.MULT_ENABLED_VALUE_NAME)
			if multEnabledValue then
				multEnabledValue.Value = not multEnabledValue.Value
				multEnabledValue.Value = not multEnabledValue.Value
			end
		end
		function em.d0ltid0f(p1, p2)
			assert(bankInstance == nil)
			assert(p2 ~= nil)
			bankInstance = RobberyBankClass.new(p1, p2)
			Audio.ObjectLocal(LocalPlayer, 1837831244)
			delay(1, function()
				Audio.ObjectLocal(LocalPlayer, 1843025542)
			end)
			if soundFadeConnection ~= nil then
				soundFadeConnection:Disconnect()
				soundFadeConnection = nil
			end
			if Sound.Playing == false then
				Sound:Play()
			end
			soundFadeConnection = Audio.FadeTo(Sound, 1, 5)
		end
		function em.zwfzfdnm()
			if bankInstance ~= nil then
				bankInstance:Destroy()
				bankInstance = nil
			end
			if soundFadeConnection ~= nil then
				soundFadeConnection:Disconnect()
				soundFadeConnection = nil
			end
			soundFadeConnection = Audio.FadeTo(Sound, 0, 5, function()
				Sound:Stop()
			end)
			if moneyRenderConnection then
				moneyRenderConnection:Disconnect()
				moneyRenderConnection = nil
			end
		end
		Binder.new("BankDoorEscapeRoute", function(p1)
			local maid = Maid.new()
			local t = {
				Part = p1,
				Name = "Place Dynamite",
				Timed = true,
				Duration = 5,
				Dist = 8,
				Callback = function(p12, p2)
					if p2 then
						bankEventSignal:FireServer("b" .. ("uxo0p3bs0ymu4"):sub(5, 9):reverse() .. "pj", p1)
					end
					return true
				end
			}
			local function update()
				t.Enabled = p1:GetAttribute("Open") == nil
			end
			t.Enabled = p1:GetAttribute("Open") == nil
			maid:GiveTask(CircleAction.Add(t, p1))
			maid:GiveTask(p1:GetAttributeChangedSignal("Open"):Connect(update))
			return maid
		end):Start()
		Binder.new("BankTopFloorButton", function(p1)
			local maid = Maid.new()
			local t = {
				Part = p1,
				Name = "Open Shutters",
				Timed = false,
				Dist = 8,
				Callback = function(p12, p2)
					if p2 then
						Audio.ObjectLocal(p1, 9553471217, {
							Volume = 0.5
						})
						p1:FindFirstChild("OpenTopFloorRemote"):FireServer()
					end
					return true
				end
			}
			local function update()
				t.Enabled = p1:GetAttribute("ButtonDisabled") ~= true
			end
			t.Enabled = p1:GetAttribute("ButtonDisabled") ~= true
			maid:GiveTask(CircleAction.Add(t, p1))
			maid:GiveTask(p1:GetAttributeChangedSignal("ButtonDisabled"):Connect(update))
			return maid
		end):Start()
	end
}
