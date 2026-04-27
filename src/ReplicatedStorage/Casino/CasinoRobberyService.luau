local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local Binder = require(ReplicatedStorage.Std.Binder)
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local UI = require(ReplicatedStorage.Module.UI)
local Notification = require(ReplicatedStorage.Game.Notification)
local CircleAction = UI.CircleAction
local store = require(ReplicatedStorage.App.store)
local CasinoRobberyConsts = require(script.Parent.CasinoRobberyConsts)
local t = {}
function t.init()
	t.setupCollect()
	t.setupComputers()
	t.setupRobberyDoor()
	t.setupMusic()
	t.setupAlarm()
end
function t.setupCollect()
	Binder.new(CasinoRobberyConsts.LOOT_TAG_NAME, function(lootObj)
		local maid = Maid.new()
		local function action(_, isActive)
			if isActive then
				lootObj:FindFirstChild(CasinoRobberyConsts.LOOT_COLLECT_REMOTE_NAME):FireServer()
				return true
			end
		end
		local targetPart = nil
		if lootObj:IsA("Model") then
			RxInstanceUtils.yieldForProperty(lootObj, "PrimaryPart")
			targetPart = lootObj.PrimaryPart
		elseif lootObj:IsA("BasePart") then
			targetPart = lootObj
		else
			error("Invalid ClassName for Casino Collect obj")
		end
		CircleAction.Add({
			Part = targetPart,
			Name = "Collect",
			NoRay = true,
			Timed = true,
			Duration = 0.5,
			Dist = 8,
			Callback = action
		}, targetPart)
		maid:GiveTask(function()
			CircleAction.Remove(targetPart)
		end)
		return maid
	end):Start()
end
function t.setupComputers()
	Binder.new(CasinoRobberyConsts.COMPUTER_TAG_NAME, function(computerObj)
		RxInstanceUtils.yieldForProperty(computerObj, "PrimaryPart")
		local maid = Maid.new()
		local function action(_, isActive)
			if isActive then
				computerObj:FindFirstChild(CasinoRobberyConsts.COMPUTER_HACK_REMOTE_NAME):FireServer()
				return true
			end
		end
		local PrimaryPart = computerObj.PrimaryPart
		local actionConfig = {
			Part = PrimaryPart,
			Name = "Hack",
			NoRay = true,
			Timed = true,
			Duration = 0.5,
			Dist = 8,
			Callback = action
		}
		local function update()
			actionConfig.Enabled = computerObj:GetAttribute("ComputerActive") == true
			local actionName, isTimed
			if computerObj:GetAttribute("ShowDisableSecurityPrompt") == true then
				actionName = "Disable Vault Security"
				isTimed = true
			else
				actionName = "Hack"
				isTimed = false
			end
			actionConfig.Name = actionName
			actionConfig.Timed = isTimed
		end
		actionConfig.Enabled = computerObj:GetAttribute("ComputerActive") == true
		local actionName, isTimed
		if computerObj:GetAttribute("ShowDisableSecurityPrompt") == true then
			actionName = "Disable Vault Security"
			isTimed = true
		else
			actionName = "Hack"
			isTimed = false
		end
		actionConfig.Name = actionName
		actionConfig.Timed = isTimed
		maid:GiveTask(computerObj:GetAttributeChangedSignal("ComputerActive"):Connect(update))
		maid:GiveTask(computerObj:GetAttributeChangedSignal("ShowDisableSecurityPrompt"):Connect(update))
		CircleAction.Add(actionConfig, PrimaryPart)
		maid:GiveTask(function()
			CircleAction.Remove(PrimaryPart)
		end)
		return maid
	end):Start()
end
function t.setupRobberyDoor()
	Binder.new(CasinoRobberyConsts.KEYPAD_TAG_NAME, function(keypadPrompt)
		local maid = Maid.new()
		local function action(_, isActive)
			if workspace:FindFirstChild(CasinoRobberyConsts.WORKSPACE_MODEL_NAME):GetAttribute(CasinoRobberyConsts.OPEN_ATTR_NAME) ~= true then
				Notification.new({
					Text = "Wait for the Crown Jewel to open..."
				})
				return false
			end
			if isActive then
				store:dispatch({
					type = "setCasinoKeypadVisible",
					visible = true
				})
				store:dispatch({
					type = "setCasinoKeypadCallback",
					callback = function(keyCode)
						keypadPrompt:FindFirstChild(CasinoRobberyConsts.KEYPAD_SUBMIT_REMOTE_NAME):FireServer(keyCode)
					end
				})
				return true
			end
		end
		CircleAction.Add({
			Part = keypadPrompt,
			ValidRoot = keypadPrompt.Parent,
			Name = "Open Keypad",
			Dist = 8,
			Callback = action
		}, keypadPrompt)
		maid:GiveTask(function()
			CircleAction.Remove(keypadPrompt)
		end)
		return maid
	end):Start()
end
function t.setupMusic()
	local casinoMusic = nil
	local fadePromise = nil
	Players.LocalPlayer:GetAttributeChangedSignal(CasinoRobberyConsts.ROBBERY_MUSIC_PLAYING_ATTR_NAME):Connect(function()
		local shouldPlayMusic = Players.LocalPlayer:GetAttribute(CasinoRobberyConsts.ROBBERY_MUSIC_PLAYING_ATTR_NAME)
		if fadePromise then
			fadePromise:cancel()
			fadePromise = nil
		end
		if casinoMusic then
			local oldMusic = casinoMusic
			casinoMusic = nil
			Audio.promiseFadeTo(oldMusic, 0, 3):finally(function()
				oldMusic:Destroy()
			end)
		end
		if shouldPlayMusic then
			casinoMusic = Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 1837987527, {
				Looped = true,
				Volume = 0
			})
			casinoMusic.Name = "CasinoMusic"
			casinoMusic.SoundGroup = game:GetService("SoundService").RobberyMusic
			fadePromise = Audio.promiseFadeTo(casinoMusic, 0.5, 3):finally(function()
				fadePromise = nil
			end)
		end
	end)
end
function t.setupAlarm()
	Binder.new("CasinoTriggerAlarm", function(alarmTrigger)
		local maid = Maid.new()
		local lastTriggerTime = 0
		maid:GiveTask(alarmTrigger.Touched:Connect(function(touchingPart)
			if touchingPart:IsDescendantOf(Players.LocalPlayer.Character) then
				local currentTime = os.clock()
				if not (currentTime - lastTriggerTime < 0.3) then
					lastTriggerTime = currentTime
					ReplicatedStorage:FindFirstChild(CasinoRobberyConsts.TRIGGER_ALARM_REMOTE_NAME):FireServer()
				end
			end
		end))
		return maid
	end):Start()
end
return t