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
local function PlaySound(parent, soundId)
	local Sound = Instance.new("Sound")
	Sound.SoundId = ("rbxassetid://%d"):format(soundId)
	Sound.Volume = 0.75
	Sound.Parent = parent
	Sound:Play()
	delay(1, function()
		game.Debris:AddItem(Sound, Sound.TimeLength)
	end)
end
local RobberyBankClass = {}
RobberyBankClass.__index = RobberyBankClass
function RobberyBankClass.new(birthSync, bankModel)
	assert(birthSync ~= nil)
	assert(bankModel ~= nil)
	local instance = {}
	setmetatable(instance, RobberyBankClass)
	local layoutChild = bankModel.Layout:GetChildren()[1]
	assert(layoutChild ~= nil)
	instance.ModelLayout = layoutChild
	instance.Maid = Maid_2.new()
	instance.BornAtSync = birthSync
	if instance.ModelLayout:FindFirstChild("Lasers") then
		instance:SetupLasers(layoutChild)
	end
	return instance
end
function RobberyBankClass.SetupLasers(instance, layout)
	local Lasers = layout:WaitForChild("Lasers")
	assert(Lasers)
	local laserTable = {}
	for i, laser in ipairs(Lasers:GetChildren()) do
		if laser.Name == "Laser" or (laser.Name == "LaserWall" or laser.Name == "LaserTrack") then
			local laserPeriod = 2
			if laser.Name == "LaserWall" then
				laserPeriod = 5
			elseif laser.Name == "LaserTrack" then
				laserPeriod = 7
			end
			local Part = laser:WaitForChild("Part", 3)
			table.insert(laserTable, {
				Part = Part,
				Origin = Part.CFrame,
				Target = laser.End.CFrame,
				Period = laserPeriod
			})
		end
	end
	instance.Maid:GiveTask(RunService.Heartbeat:Connect(function()
		local elapsedTime = Time.GetNowSync() - instance.BornAtSync
		for i, laser in ipairs(laserTable) do
			laser.Part.CFrame = laser.Origin:lerp(laser.Target, math.cos(elapsedTime * (math.tau / laser.Period)) * -0.5 + 0.5)
		end
	end))
	instance.Maid:GiveTask(function()
		for i, laser in ipairs(laserTable) do
			laser.Part.CFrame = laser.Origin
		end
	end)
end
function RobberyBankClass.Destroy(instance)
	instance.Maid:Destroy()
	instance.Maid = nil
end
return {
	Init = function(config)
		local em = config.em
		bankEventSignal = config.Event
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
		function em.StartMoneyRender(startTime, initialMoney, moneyPerSecond, duffelBag)
			if not moneyRenderConnection then
				local duffelBinder = nil
				local maxValue = duffelBag:FindFirstChild(DuffelBagConsts.MAXIMUM_VALUE_NAME)
				local multValue = duffelBag:FindFirstChild(DuffelBagConsts.MULT_VALUE_NAME)
				local multEnabledValue = duffelBag:FindFirstChild(DuffelBagConsts.MULT_ENABLED_VALUE_NAME)
				moneyRenderConnection = RunService.RenderStepped:Connect(function()
					if not duffelBinder then
						duffelBinder = DuffelBagBinder:Get(duffelBag)
					end
					if duffelBinder and duffelBag.Parent then
						local currentMoney = math.floor(initialMoney + (workspace:GetServerTimeNow() - startTime) * moneyPerSecond)
						local maxMoney = multEnabledValue.Value and math.ceil(maxValue.Value * multValue.Value) or maxValue.Value
						RobberyMoneyUI.SetMoney(math.clamp(currentMoney, 0, maxMoney), maxMoney, true)
					end
				end)
			end
		end
		function em.StopMoneyRender(duffelBag)
			if moneyRenderConnection then
				moneyRenderConnection:Disconnect()
				moneyRenderConnection = nil
			end
			local multEnabledValue = duffelBag and duffelBag:FindFirstChild(DuffelBagConsts.MULT_ENABLED_VALUE_NAME)
			if multEnabledValue then
				multEnabledValue.Value = not multEnabledValue.Value
				multEnabledValue.Value = not multEnabledValue.Value
			end
		end
		function em.StartBank(birthSync, bankModel)
			assert(bankInstance == nil)
			assert(bankModel ~= nil)
			bankInstance = RobberyBankClass.new(birthSync, bankModel)
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
		function em.StopBank()
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
		Binder.new("BankDoorEscapeRoute", function(doorPart)
			local maid = Maid.new()
			local actionConfig = {
				Part = doorPart,
				Name = "Place Dynamite",
				Timed = true,
				Duration = 5,
				Dist = 8,
				Callback = function(activatedByUser, isActive)
					if isActive then
						bankEventSignal:FireServer("b0sb3ppj", doorPart)
					end
					return true
				end
			}
			local function update()
				actionConfig.Enabled = doorPart:GetAttribute("Open") == nil
			end
			actionConfig.Enabled = doorPart:GetAttribute("Open") == nil
			maid:GiveTask(CircleAction.Add(actionConfig, doorPart))
			maid:GiveTask(doorPart:GetAttributeChangedSignal("Open"):Connect(update))
			return maid
		end):Start()
		Binder.new("BankTopFloorButton", function(topFloorButton)
			local maid = Maid.new()
			local actionConfig = {
				Part = topFloorButton,
				Name = "Open Shutters",
				Timed = false,
				Dist = 8,
				Callback = function(activatedByUser, isActive)
					if isActive then
						Audio.ObjectLocal(topFloorButton, 9553471217, {
							Volume = 0.5
						})
						topFloorButton:FindFirstChild("OpenTopFloorRemote"):FireServer()
					end
					return true
				end
			}
			local function update()
				actionConfig.Enabled = topFloorButton:GetAttribute("ButtonDisabled") ~= true
			end
			actionConfig.Enabled = topFloorButton:GetAttribute("ButtonDisabled") ~= true
			maid:GiveTask(CircleAction.Add(actionConfig, topFloorButton))
			maid:GiveTask(topFloorButton:GetAttributeChangedSignal("ButtonDisabled"):Connect(update))
			return maid
		end):Start()
	end
}
