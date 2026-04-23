local LocalPlayer = game:GetService("Players").LocalPlayer
local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local Promise = require(ReplicatedStorage.Std.Promise)
local Audio = require(ReplicatedStorage.Std.Audio)
local Binder = require(ReplicatedStorage.Std.Binder)
local CartSystem = require(ReplicatedStorage.Game.Cart.CartSystem)
local DoorUtils = require(ReplicatedStorage.Door2.DoorUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
local TombRobberyConsts = require(script.Parent.TombRobberyConsts)
local v1 = nil
local t = {}
function t.init(p1) --[[ Line: 21 | Upvalues: v1 (ref), Audio (copy), LocalPlayer (copy), SoundService (copy), Promise (copy), waitForChild (copy), TombRobberyConsts (copy), ReplicatedStorage (copy), t (copy) ]]
	v1 = p1.Event
	local v12 = nil
	local v2 = nil
	local v3 = nil
	local v4 = nil
	local function playMusic() --[[ Line: 30 | Upvalues: v4 (ref), v12 (ref), Audio (ref), LocalPlayer (ref), SoundService (ref), v2 (ref), Promise (ref), v3 (ref) ]]
		if v4 then
			v4:cancel()
			v4 = nil
		end
		if not v12 then
			v12 = Audio.ObjectLocal(LocalPlayer.PlayerGui, 9062816634, {
				Looped = true,
				Volume = 0
			})
			v12.SoundGroup = SoundService.RobberyMusic
		end
		if not v2 then
			v2 = Audio.ObjectLocal(LocalPlayer.PlayerGui, 9062816122, {
				Looped = true,
				Volume = 0
			})
			v2.SoundGroup = SoundService.RobberyMusic
		end
		local t = {}
		t[1] = Audio.promiseFadeTo(v12, if v3 then 1 else 0, 3)
		t[2] = Audio.promiseFadeTo(v2, if v3 then 0 else 1, 3)
		v4 = Promise.all(t):andThen(function() --[[ Line: 46 | Upvalues: v4 (ref) ]]
			v4 = nil
		end)
	end
	local function stopMusic() --[[ Line: 50 | Upvalues: v4 (ref), Promise (ref), Audio (ref), v12 (ref), v2 (ref) ]]
		if v4 then
			v4:cancel()
			v4 = nil
		end
		v4 = Promise.all({ Audio.promiseFadeTo(v12, 0, 1):andThen(function() --[[ Line: 56 | Upvalues: v12 (ref) ]]
				v12:Destroy()
				v12 = nil
			end), Audio.promiseFadeTo(v2, 0, 1):andThen(function() --[[ Line: 60 | Upvalues: v2 (ref) ]]
				v2:Destroy()
				v2 = nil
			end) }):andThen(function() --[[ Line: 64 | Upvalues: v4 (ref) ]]
			v4 = nil
		end)
	end
	local function changeTrack() --[[ Line: 68 | Upvalues: v12 (ref), v2 (ref), v4 (ref), Promise (ref), Audio (ref), v3 (ref) ]]
		if v12 and v2 then
			if v4 then
				v4:await()
			end
			if v12 and v2 then
				local t = {}
				t[1] = Audio.promiseFadeTo(v12, if v3 then 1 else 0, 2)
				t[2] = Audio.promiseFadeTo(v2, if v3 then 0 else 1, 2)
				v4 = Promise.all(t):andThen(function() --[[ Line: 82 | Upvalues: v4 (ref) ]]
					v4 = nil
				end)
			end
		end
	end
	waitForChild(LocalPlayer.PlayerGui, TombRobberyConsts.MUSIC_ENABLED_VALUE_NAME):andThen(function(p1) --[[ Line: 87 | Upvalues: playMusic (copy), stopMusic (copy) ]]
		p1.Changed:Connect(function(p1) --[[ Line: 88 | Upvalues: playMusic (ref), stopMusic (ref) ]]
			if p1 then
				playMusic()
			else
				stopMusic()
			end
		end)
		if p1.Value then
			playMusic()
		end
	end)
	waitForChild(LocalPlayer.PlayerGui, TombRobberyConsts.MUSIC_TRACK_VALUE_NAME):andThen(function(p1) --[[ Line: 100 | Upvalues: v3 (ref), changeTrack (copy) ]]
		p1.Changed:Connect(function(p1) --[[ Line: 101 | Upvalues: v3 (ref), changeTrack (ref) ]]
			v3 = p1
			changeTrack()
		end)
		v3 = p1.Value
		changeTrack()
	end)
	local function hookCharacter(p1) --[[ Line: 109 | Upvalues: ReplicatedStorage (ref), t (ref) ]]
		local Humanoid = p1:WaitForChild("Humanoid")
		local v1 = Humanoid:LoadAnimation(ReplicatedStorage.Resource.CartDuckAnimation)
		t._duckTrack = v1
		local v2 = nil
		v2 = Humanoid.Died:Connect(function() --[[ Line: 115 | Upvalues: v2 (ref), v1 (copy), t (ref) ]]
			v2:Disconnect()
			v1:Destroy()
			t._duckTrack = nil
		end)
	end
	if LocalPlayer.Character then
		hookCharacter(LocalPlayer.Character)
	end
	LocalPlayer.CharacterAdded:Connect(hookCharacter)
	t.setupSpikes()
	t.setupGems()
	t.setupWood()
	t.setupBranches()
end
function t.setupSpikes() --[[ Line: 143 | Upvalues: Binder (copy), TombRobberyConsts (copy), RxInstanceUtils (copy), DoorUtils (copy), Maid (copy), LocalPlayer (copy), v1 (ref) ]]
	local v12 = 0
	Binder.new(TombRobberyConsts.SPIKE_TAG_NAME, function(p1) --[[ Line: 145 | Upvalues: RxInstanceUtils (ref), DoorUtils (ref), Maid (ref), LocalPlayer (ref), v12 (ref), v1 (ref) ]]
		RxInstanceUtils.yieldForProperty(p1, "PrimaryPart")
		local v13 = DoorUtils.getInnerModel(p1)
		RxInstanceUtils.yieldForProperty(v13, "PrimaryPart")
		local v2 = Maid.new()
		local v3 = 0
		v13.PrimaryPart.Touched:Connect(function(p1) --[[ Line: 153 | Upvalues: LocalPlayer (ref), v3 (ref), v12 (ref), v1 (ref) ]]
			if p1.Parent == LocalPlayer.Character and not ((p1.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude > 32) then
				local v13 = os.clock()
				if v13 - v3 > 1 and v13 - v12 > 0.5 then
					v3 = v13
					v12 = v13
					v1:FireServer("x" .. ("asu1v6ekfq"):sub(2, 7):reverse():reverse():reverse() .. "6", 36, "Spikes")
				end
			end
		end)
		DoorUtils.getDoorOpenChangedSignal(p1):Connect(function() --[[ Line: 168 | Upvalues: DoorUtils (ref), p1 (copy), v3 (ref) ]]
			if DoorUtils.getOpen(p1) then
				v3 = 0
			end
		end)
		return v2
	end):Start()
end
function t.setupGems() --[[ Line: 178 | Upvalues: Binder (copy), TombRobberyConsts (copy), RxInstanceUtils (copy), Maid (copy), CircleAction (copy) ]]
	Binder.new(TombRobberyConsts.GEM_TAG_NAME, function(p1) --[[ Line: 179 | Upvalues: RxInstanceUtils (ref), Maid (ref), TombRobberyConsts (ref), CircleAction (ref) ]]
		RxInstanceUtils.yieldForProperty(p1, "PrimaryPart")
		local v1 = Maid.new()
		local function action(p12, p2) --[[ Line: 183 | Upvalues: p1 (copy), TombRobberyConsts (ref) ]]
			if p2 then
				local v1 = p1:FindFirstChild(TombRobberyConsts.GEM_COLLECT_REMOTE_NAME)
				assert(v1)
				v1:FireServer()
				return true
			end
		end
		local function preUpdateFun(p1) --[[ Line: 191 ]]
			p1.Enabled = p1.Part.Transparency < 0.999
		end
		local PrimaryPart = p1.PrimaryPart
		CircleAction.Add({
			Part = PrimaryPart,
			Name = "Collect",
			NoRay = true,
			Timed = false,
			Dist = 8,
			Callback = action,
			PreUpdateFun = preUpdateFun,
			PreUpdatePeriod = 0.5
		}, PrimaryPart)
		v1:GiveTask(function() --[[ Line: 206 | Upvalues: CircleAction (ref), PrimaryPart (copy) ]]
			CircleAction.Remove(PrimaryPart)
		end)
		return v1
	end):Start()
end
function t.duck() --[[ Line: 215 | Upvalues: t (copy), Promise (copy) ]]
	local _duckTrack = t._duckTrack
	if _duckTrack then
		if t._duckPromise then
			t._duckPromise:cancel()
			t._duckPromise = nil
		end
		_duckTrack:Play()
		t._duckPromise = Promise.delay(2):andThen(function() --[[ Line: 225 | Upvalues: _duckTrack (copy), t (ref) ]]
			_duckTrack:Stop()
			t._duckPromise = nil
		end)
	end
end
local function preUpdateFun(p1) --[[ Line: 230 | Upvalues: LocalPlayer (copy), CartSystem (copy) ]]
	local t = {}
	if LocalPlayer.Character then
		table.insert(t, LocalPlayer.Character)
		local v1 = CartSystem.getCartForCharacter(LocalPlayer.Character)
		if v1 then
			table.insert(t, v1._obj)
		end
	end
	p1.IgnoreOverride = t
end
function t.setupWood() --[[ Line: 241 | Upvalues: Binder (copy), TombRobberyConsts (copy), Maid (copy), t (copy), Promise (copy), preUpdateFun (copy), CircleAction (copy), LocalPlayer (copy), v1 (ref), Audio (copy) ]]
	Binder.new(TombRobberyConsts.WOOD_TAG_NAME, function(p1) --[[ Line: 242 | Upvalues: Maid (ref), t (ref), Promise (ref), preUpdateFun (ref), CircleAction (ref), LocalPlayer (ref), v1 (ref), Audio (ref) ]]
		local v12 = Maid.new()
		CircleAction.Add({
			Part = p1,
			Name = "Duck",
			NoRay = true,
			Timed = false,
			Dist = 36,
			Callback = function(p1, p2) --[[ Name: action | Line: 244 | Upvalues: t (ref), Promise (ref) ]]
				if p2 then
					t.duck()
					p1.Enabled = false
					Promise.delay(2):andThen(function() --[[ Line: 248 | Upvalues: p1 (copy) ]]
						p1.Enabled = true
					end)
					return true
				end
			end,
			PreUpdateFun = preUpdateFun,
			PreUpdatePeriod = 0.2
		}, p1)
		v12:GiveTask(function() --[[ Line: 265 | Upvalues: CircleAction (ref), p1 (copy) ]]
			CircleAction.Remove(p1)
		end)
		local v2 = 0
		v12:GiveTask(p1.Touched:Connect(function(p12) --[[ Line: 270 | Upvalues: LocalPlayer (ref), v2 (ref), t (ref), v1 (ref), Audio (ref), p1 (copy) ]]
			if p12:IsDescendantOf(LocalPlayer.Character) then
				if (p12.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude > 32 then
					return
				end
				local v12 = os.clock()
				if v12 - v2 < 10 then
					return
				end
				v2 = v12
				if t._duckTrack and not t._duckTrack.IsPlaying then
					v1:FireServer("x" .. "" .. ("t4qley"):sub(5, 5):reverse() .. "" .. "" .. ("m8ad6fm8"):sub(5, 5):reverse():reverse():reverse() .. "" .. "" .. ("b01vsnz4"):sub(3, 4):reverse() .. "us6", 30, "Duck")
					Audio.ObjectLocal(p1, 6875020869, {
						Volume = 0.6,
						RollOffMaxDistance = 64
					})
				else
					Audio.ObjectLocal(p1, 3772601178, {
						Volume = 0.2,
						RollOffMaxDistance = 64
					})
				end
			end
		end))
		return v12
	end):Start()
end
function t.setupBranches() --[[ Line: 295 | Upvalues: Binder (copy), TombRobberyConsts (copy), Maid (copy), preUpdateFun (copy), CircleAction (copy) ]]
	Binder.new(TombRobberyConsts.BRANCH_SWITCH_TAG_NAME, function(p1) --[[ Line: 296 | Upvalues: Maid (ref), TombRobberyConsts (ref), preUpdateFun (ref), CircleAction (ref) ]]
		local v1 = Maid.new()
		local function action(p12, p2) --[[ Line: 298 | Upvalues: p1 (copy), TombRobberyConsts (ref) ]]
			if p2 then
				p1:WaitForChild(TombRobberyConsts.BRANCH_SWITCH_REMOTE_NAME):FireServer()
				return true
			end
		end
		CircleAction.Add({
			Part = p1.PrimaryPart,
			ValidRoot = p1.Parent,
			Name = "Switch",
			Dist = 80,
			Callback = action,
			PreUpdateFun = preUpdateFun,
			PreUpdatePeriod = 0.2
		}, p1)
		v1:GiveTask(function() --[[ Line: 315 | Upvalues: CircleAction (ref), p1 (copy) ]]
			CircleAction.Remove(p1)
		end)
		return v1
	end):Start()
end
return t