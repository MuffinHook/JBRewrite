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
function t.init() --[[ Line: 19 | Upvalues: t (copy) ]]
	t.setupCollect()
	t.setupComputers()
	t.setupRobberyDoor()
	t.setupMusic()
	t.setupAlarm()
end
function t.setupCollect() --[[ Line: 26 | Upvalues: Binder (copy), CasinoRobberyConsts (copy), Maid (copy), RxInstanceUtils (copy), CircleAction (copy) ]]
	Binder.new(CasinoRobberyConsts.LOOT_TAG_NAME, function(p1) --[[ Line: 27 | Upvalues: Maid (ref), CasinoRobberyConsts (ref), RxInstanceUtils (ref), CircleAction (ref) ]]
		local v1 = Maid.new()
		local function action(p12, p2) --[[ Line: 29 | Upvalues: p1 (copy), CasinoRobberyConsts (ref) ]]
			if p2 then
				p1:FindFirstChild(CasinoRobberyConsts.LOOT_COLLECT_REMOTE_NAME):FireServer()
				return true
			end
		end
		local v2 = nil
		if p1:IsA("Model") then
			RxInstanceUtils.yieldForProperty(p1, "PrimaryPart")
			v2 = p1.PrimaryPart
		elseif p1:IsA("BasePart") then
			v2 = p1
		else
			error("Invalid ClassName for Casino Collect obj")
		end
		CircleAction.Add({
			Part = v2,
			Name = "Collect",
			NoRay = true,
			Timed = true,
			Duration = 0.5,
			Dist = 8,
			Callback = action
		}, v2)
		v1:GiveTask(function() --[[ Line: 60 | Upvalues: CircleAction (ref), v2 (ref) ]]
			CircleAction.Remove(v2)
		end)
		return v1
	end):Start()
end
function t.setupComputers() --[[ Line: 67 | Upvalues: Binder (copy), CasinoRobberyConsts (copy), RxInstanceUtils (copy), Maid (copy), CircleAction (copy) ]]
	Binder.new(CasinoRobberyConsts.COMPUTER_TAG_NAME, function(p1) --[[ Line: 68 | Upvalues: RxInstanceUtils (ref), Maid (ref), CasinoRobberyConsts (ref), CircleAction (ref) ]]
		RxInstanceUtils.yieldForProperty(p1, "PrimaryPart")
		local v1 = Maid.new()
		local function action(p12, p2) --[[ Line: 71 | Upvalues: p1 (copy), CasinoRobberyConsts (ref) ]]
			if p2 then
				p1:FindFirstChild(CasinoRobberyConsts.COMPUTER_HACK_REMOTE_NAME):FireServer()
				return true
			end
		end
		local PrimaryPart = p1.PrimaryPart
		local t = {
			Part = PrimaryPart,
			Name = "Hack",
			NoRay = true,
			Timed = true,
			Duration = 0.5,
			Dist = 8,
			Callback = action
		}
		local function update() --[[ Line: 88 | Upvalues: t (copy), p1 (copy) ]]
			t.Enabled = p1:GetAttribute("ComputerActive") == true
			local v3, v4
			if p1:GetAttribute("ShowDisableSecurityPrompt") == true then
				v3 = "Disable Vault Security"
				v4 = true
			else
				v3 = "Hack"
				v4 = false
			end
			t.Name = v3
			t.Timed = v4
		end
		t.Enabled = p1:GetAttribute("ComputerActive") == true
		local v3, v4
		if p1:GetAttribute("ShowDisableSecurityPrompt") == true then
			v3 = "Disable Vault Security"
			v4 = true
		else
			v3 = "Hack"
			v4 = false
		end
		t.Name = v3
		t.Timed = v4
		v1:GiveTask(p1:GetAttributeChangedSignal("ComputerActive"):Connect(update))
		v1:GiveTask(p1:GetAttributeChangedSignal("ShowDisableSecurityPrompt"):Connect(update))
		CircleAction.Add(t, PrimaryPart)
		v1:GiveTask(function() --[[ Line: 104 | Upvalues: CircleAction (ref), PrimaryPart (copy) ]]
			CircleAction.Remove(PrimaryPart)
		end)
		return v1
	end):Start()
end
function t.setupRobberyDoor() --[[ Line: 111 | Upvalues: Binder (copy), CasinoRobberyConsts (copy), Maid (copy), Notification (copy), store (copy), CircleAction (copy) ]]
	Binder.new(CasinoRobberyConsts.KEYPAD_TAG_NAME, function(p1) --[[ Line: 114 | Upvalues: Maid (ref), CasinoRobberyConsts (ref), Notification (ref), store (ref), CircleAction (ref) ]]
		local v1 = Maid.new()
		local function action(p12, p2) --[[ Line: 116 | Upvalues: CasinoRobberyConsts (ref), Notification (ref), store (ref), p1 (copy) ]]
			if workspace:FindFirstChild(CasinoRobberyConsts.WORKSPACE_MODEL_NAME):GetAttribute(CasinoRobberyConsts.OPEN_ATTR_NAME) ~= true then
				Notification.new({
					Text = "Wait for the Crown Jewel to open..."
				})
				return false
			end
			if p2 then
				store:dispatch({
					type = "setCasinoKeypadVisible",
					visible = true
				})
				store:dispatch({
					type = "setCasinoKeypadCallback",
					callback = function(p12) --[[ Name: callback | Line: 130 | Upvalues: p1 (ref), CasinoRobberyConsts (ref) ]]
						p1:FindFirstChild(CasinoRobberyConsts.KEYPAD_SUBMIT_REMOTE_NAME):FireServer(p12)
					end
				})
				return true
			end
		end
		CircleAction.Add({
			Part = p1,
			ValidRoot = p1.Parent,
			Name = "Open Keypad",
			Dist = 8,
			Callback = action
		}, p1)
		v1:GiveTask(function() --[[ Line: 147 | Upvalues: CircleAction (ref), p1 (copy) ]]
			CircleAction.Remove(p1)
		end)
		return v1
	end):Start()
end
function t.setupMusic() --[[ Line: 154 | Upvalues: Players (copy), CasinoRobberyConsts (copy), Audio (copy) ]]
	local v1 = nil
	local v2 = nil
	Players.LocalPlayer:GetAttributeChangedSignal(CasinoRobberyConsts.ROBBERY_MUSIC_PLAYING_ATTR_NAME):Connect(function() --[[ Line: 160 | Upvalues: Players (ref), CasinoRobberyConsts (ref), v2 (ref), v1 (ref), Audio (ref) ]]
		local v12 = Players.LocalPlayer:GetAttribute(CasinoRobberyConsts.ROBBERY_MUSIC_PLAYING_ATTR_NAME)
		if v2 then
			v2:cancel()
			v2 = nil
		end
		if v1 then
			local v22 = v1
			v1 = nil
			Audio.promiseFadeTo(v22, 0, 3):finally(function() --[[ Line: 169 | Upvalues: v22 (copy) ]]
				v22:Destroy()
			end)
		end
		if v12 then
			v1 = Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 1837987527, {
				Looped = true,
				Volume = 0
			})
			v1.Name = "CasinoMusic"
			v1.SoundGroup = game:GetService("SoundService").RobberyMusic
			v2 = Audio.promiseFadeTo(v1, 0.5, 3):finally(function() --[[ Line: 177 | Upvalues: v2 (ref) ]]
				v2 = nil
			end)
		end
	end)
end
function t.setupAlarm() --[[ Line: 183 | Upvalues: Binder (copy), Maid (copy), Players (copy), ReplicatedStorage (copy), CasinoRobberyConsts (copy) ]]
	Binder.new("CasinoTriggerAlarm", function(p1) --[[ Line: 184 | Upvalues: Maid (ref), Players (ref), ReplicatedStorage (ref), CasinoRobberyConsts (ref) ]]
		local v1 = Maid.new()
		local v2 = 0
		v1:GiveTask(p1.Touched:Connect(function(p1) --[[ Line: 189 | Upvalues: Players (ref), v2 (ref), ReplicatedStorage (ref), CasinoRobberyConsts (ref) ]]
			if p1:IsDescendantOf(Players.LocalPlayer.Character) then
				local v1 = os.clock()
				if not (v1 - v2 < 0.3) then
					v2 = v1
					ReplicatedStorage:FindFirstChild(CasinoRobberyConsts.TRIGGER_ALARM_REMOTE_NAME):FireServer()
				end
			end
		end))
		return v1
	end):Start()
end
return t