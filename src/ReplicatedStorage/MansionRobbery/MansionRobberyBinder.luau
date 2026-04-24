-- Reviewed by Claude
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Std.Promise)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local CharacterUtils = require(ReplicatedStorage.Std.CharacterUtils)
local Players = game:GetService("Players")
local CurrentCamera = workspace.CurrentCamera
local Audio = require(ReplicatedStorage.Std.Audio)
require(ReplicatedStorage.Module.Confirmation)
local Dialogue = require(ReplicatedStorage.Module.Dialogue)
local Maid = require(ReplicatedStorage.Std.Maid)
local DoorBinder = require(ReplicatedStorage.Door2.DoorBinder)
local DoorUtils = require(ReplicatedStorage.Door2.DoorUtils)
local Interval = require(ReplicatedStorage.Std.Interval)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local GeomUtils = require(ReplicatedStorage.Std.GeomUtils)
local CircleAction = require(ReplicatedStorage.Module.UI).CircleAction
require(ReplicatedStorage.Std.Binder)
local ManifestBinder = require(ReplicatedStorage.ManifestBinder)
local MansionRobberyUtils = require(ReplicatedStorage.MansionRobbery.MansionRobberyUtils)
local RobberyConsts = require(ReplicatedStorage.Robbery.RobberyConsts)
local RobberyUtils = require(ReplicatedStorage.Robbery.RobberyUtils)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local MansionRobberyConsts = require(ReplicatedStorage.MansionRobbery.MansionRobberyConsts)
local PlayersEnteredIntroCutscene = require(ReplicatedStorage.MansionRobbery.Res.PlayersEnteredIntroCutscene)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local MansionRobberyApp = require(ReplicatedStorage.MansionRobbery.UI.MansionRobberyApp)
local mansionRobberyStore = require(ReplicatedStorage.MansionRobbery.mansionRobberyStore)
local t = {}
t.__index = t
setmetatable(t, BaseObject)
function t.new(self, p2)
	local instance = BaseObject.new(self)
	setmetatable(instance, t)
	local function handleProgressionState()
		local instance12 = Maid.new()
		instance.maid.progressionMaid = instance12
		if MansionRobberyUtils.getIsPlayerInRobbery(instance.obj, Players.LocalPlayer) then
			local instance2 = MansionRobberyUtils.getProgressionState(instance.obj)
			if instance2 == MansionRobberyConsts.PROGRESSION_STATE.WaitForEnter then
				instance:_launchWaitForEnter(instance12)
			elseif instance2 == MansionRobberyConsts.PROGRESSION_STATE.PlayersEnteredIntroCutscene then
				instance:_launchIntroCutscene(instance12)
				instance:_launchMusic2(instance12)
			elseif instance2 == MansionRobberyConsts.PROGRESSION_STATE.RunAwayEndCutscene then
				instance:_launchRunAwayEndCutscene(instance12)
				instance.maid.currRobberyMaid.music2 = nil
			end
		end
	end
	handleProgressionState()
	instance.maid:GiveTask(MansionRobberyUtils.getProgressionStateChangedSignal(instance.obj):Connect(handleProgressionState))
	local function handleStatus()
		local instance12 = RobberyUtils.getStatus(instance.obj)
		local instance2 = Maid.new()
		instance.maid.currRobberyMaid = instance2
		if MansionRobberyUtils.getIsPlayerInRobbery(instance.obj, Players.LocalPlayer) and instance12 == RobberyConsts.ENUM_STATUS.STARTED then
			instance:_hookBossCameras(instance2)
			instance:_launchStarted(instance2)
		end
	end
	handleStatus()
	instance.maid:GiveTask(RobberyUtils.getStatusChangedSignal(instance.obj):Connect(handleStatus))
	local var3, var4 = Roact.createBinding(0)
	instance.pctClosed = var3
	instance.updatePctClosed = var4
	instance.maid.localPlayerRobberyMaid = Maid.new()
	local function handleLocalPlayerInRobbery()
		handleProgressionState()
		handleStatus()
		instance.maid.localPlayerRobberyMaid:DoCleaning()
		if MansionRobberyUtils.getIsPlayerInRobbery(instance.obj, Players.LocalPlayer) then
			local instance12 = Roact.mount(createElement("ScreenGui", {
				ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
				ResetOnSpawn = false,
				IgnoreGuiInset = true,
				ScreenInsets = Enum.ScreenInsets.None,
				DisplayOrder = 3
			}, { Roact.createElement(RoactRodux.StoreProvider, {
					store = mansionRobberyStore
				}, { createElement(MansionRobberyApp, {
						charPerSecond = MansionRobberyConsts.CHAR_PER_SECOND,
						pctClosed = instance.pctClosed
					}) }) }), Players.LocalPlayer.PlayerGui, "MansionRobberyUI")
			instance.maid.localPlayerRobberyMaid:GiveTask(function()
				Roact.unmount(instance12)
			end)
		end
	end
	instance.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(instance.obj, MansionRobberyConsts.IN_ROBBERY_FOLDER_NAME, function(self, p2)
		p2:GiveTask(RxInstanceUtils.observeChildren(self, function(self, p2)
			if self.Name == tostring(Players.LocalPlayer.UserId) then
				handleLocalPlayerInRobbery()
				p2:GiveTask(self.Changed:Connect(handleLocalPlayerInRobbery))
			end
		end))
	end))
	instance.mapCurveData = {
		introCutscene1 = {
			curve = PlayersEnteredIntroCutscene,
			relativeCF = CFrame.new(154.824, 524.029, -172.294)
		}
	}
	local attemptExitElevatorRemote = p2.attemptExitElevatorRemote
	local function shouldExitConfirmationBeOpen()
		return MansionRobberyUtils.isPlayerInElevator(instance.obj, Players.LocalPlayer) and not MansionRobberyUtils.getIsElevatorMoving(instance.obj) and RobberyUtils.getStatus(instance.obj) == RobberyConsts.ENUM_STATUS.OPENED
	end
	instance.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(instance.obj, MansionRobberyConsts.EXIT_ELEVATOR_PART_NAME, function(self, p2)
		local t = {
			Part = self,
			Name = "Exit Elevator",
			Dist = 25,
			Callback = function()
				attemptExitElevatorRemote:FireServer()
			end
		}
		p2:GiveTask(CircleAction.Add(t, t))
	end))
	instance.maid:GiveTask(RxInstanceUtils.observeAttribute(Players.LocalPlayer, "MansionInvites", function(self)
		if instance.obj:FindFirstChild("InviteCount") then
			instance.obj.InviteCount.SurfaceGui.TextLabel.Text = tostring(self)
		end
	end))
	return instance
end
function t._launchStarted(self, p2)
	p2:GiveTask(Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 11794013749, {
		Looped = true,
		Volume = 1
	}))
	local instance = Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 11793724573, {
		Looped = true,
		Volume = 0.5,
		Group = game:GetService("SoundService").RobberyMusic
	})
	function p2.music1()
		Audio.promiseFadeTo(instance, 0, 3):andThen(function()
			instance:Destroy()
		end)
	end
end
function t._launchMusic2(self)
	local currRobberyMaid = self.maid.currRobberyMaid
	currRobberyMaid.music1 = nil
	local instance = Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 11793723268, {
		Looped = true,
		Volume = 0.5,
		Group = game:GetService("SoundService").RobberyMusic
	})
	function currRobberyMaid.music2()
		Audio.promiseFadeTo(instance, 0, 3):andThen(function()
			instance:Destroy()
		end)
	end
end
local t2 = {
	doorModel = "Door",
	conePart = "Cone",
	floorCircle = "FloorCircle"
}
function t._hookBossCameras(self)
	local instance = ManifestBinder.new("BossRoomCamera", t2, function(self, p2)
		local instance = Maid.new()
		p2.conePart.Transparency = 0.95
		instance:GiveTask(function()
			p2.conePart.Transparency = 1
		end)
		p2.floorCircle.Transparency = 0.95
		instance:GiveTask(function()
			p2.floorCircle.Transparency = 1
		end)
		local IsInFloorCircle = Instance.new("BoolValue")
		IsInFloorCircle.Name = "IsInFloorCircle"
		IsInFloorCircle.Parent = nil
		instance:GiveTask(IsInFloorCircle)
		local doorModel = p2.doorModel
		instance:GivePromise(DoorBinder:Promise(doorModel):andThen(function(self)
			local function updateCone()
				local instance = DoorUtils.getInnerModel(doorModel)
				local LookVector = instance.PrimaryPart.CFrame.LookVector
				local Position = instance.PrimaryPart.Position
				local instance2 = GeomUtils.intersectRayPlane(Position, LookVector, Position + Vector3.new(0, -40, 0), Vector3.new(0, 1, 0))
				if instance2 then
					local var3 = Position + LookVector * 3
					local var4 = instance2 + LookVector * 6
					local Magnitude = (var4 - var3).Magnitude
					p2.conePart.Size = Vector3.new(15, Magnitude, 15)
					p2.conePart.CFrame = CFrame.lookAt(var3, var4, (Vector3.new(1, 1, 1)).Unit) * CFrame.new(0, 0, -Magnitude / 2) * CFrame.Angles(1.5707963267948966, 0, 0)
					p2.floorCircle.CFrame = CFrame.new(instance2)
				end
			end
			updateCone()
			instance:GiveTask(self:SetUpdateCallback(updateCone))
		end))
		instance:GiveTask(Interval.every(0.25):Connect(function()
			local instance = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
			local instance2
			if instance and (instance.Position - p2.floorCircle.Position).Magnitude <= p2.floorCircle.Size.X * 0.5 then
				IsInFloorCircle.Parent = instance.Parent
				instance2 = true
			else
				instance2 = false
			end
			if not instance2 then
				IsInFloorCircle.Parent = nil
			end
		end))
		return instance
	end)
	instance:Start()
	self.maid.currRobberyMaid:GiveTask(instance)
end
function t.IsPlayerInRobbery(self, p2)
	return MansionRobberyUtils.getIsPlayerInRobbery(self.obj, p2)
end
function t._promisePlayCurve(self, p2, p3, p4)
	local curve = p2.curve
	if not curve.PointData then
		curve:Generate()
	end
	local instance = nil
	local instance2 = nil
	local var3 = nil
	local var4 = Maid.new()
	return Promise.new(function(p12, p22, p32)
		local instance12 = false
		local var22 = os.clock()
		if not p32(function()
			var4:DoCleaning()
		end) then
			var4:GiveTask(RunService.PreRender:Connect(function(p13)
				local var13 = (os.clock() - var22) / (p4 - 0.1)
				if var13 >= 1 then
					if not instance12 then
						instance12 = true
						var4:GiveTask(task.delay(0.1, function()
							task.defer(var4.DoCleaning, var4)
							p12()
						end))
					end
					var13 = 1
				end
				local v23, v32, v42 = curve:GetProgressRaw(curve:GetCurveValueAt(var13), p3, p13)
				if not instance then
					instance = v23
				end
				if not instance2 then
					instance2 = v32
				end
				if not var3 then
					var3 = v42
				end
				instance = instance + (v23 - instance) * 0.1
				instance2 = instance2 + (v32 - instance2) * 0.1
				var3 = var3 + (v42 - var3) * 0.1
				CurrentCamera.CFrame = p2.relativeCF:Inverse() * self.obj:FindFirstChild("CameraRelative").CFrame * CFrame.lookAt(Vector3.new(0, 0, 0), instance2, var3) + instance
			end))
		end
	end)
end
function t._launchWaitForEnter(self, p2)
	p2:GiveTask(task.delay(3, function()
		local instance2 = TableUtils.filter(Players:GetPlayers(), function(p12)
			return MansionRobberyUtils.getIsPlayerInRobbery(self.obj, p12)
		end)
		local DisplayName = instance2[math.random(1, #instance2)].DisplayName
		local var5 = ("%s: \"Okay %s.. let\'s find his office.\""):format(DisplayName, if #instance2 > 1 then "team" else "")
		mansionRobberyStore:dispatch({
			type = "setDialogueText",
			text = var5
		})
		p2:GivePromise(Promise.delay(5 + utf8.len(var5) / MansionRobberyConsts.CHAR_PER_SECOND):finally(function()
			mansionRobberyStore:dispatch({
				type = "setDialogueText",
				text = ""
			})
		end))
	end))
end
local cutsceneDialogue1Data = require(ReplicatedStorage.MansionRobbery.cutsceneDialogue1Data)
function t._launchIntroCutscene(self, p2)
	CurrentCamera.CameraType = Enum.CameraType.Scriptable
	p2:GiveTask(function()
		CurrentCamera.CameraType = Enum.CameraType.Custom
	end)
	self.updatePctClosed(0.4)
	p2:GiveTask(function()
		self.updatePctClosed(0)
	end)
	p2:GiveTask(function()
		mansionRobberyStore:dispatch({
			type = "setDialogueText",
			text = ""
		})
	end)
	local instance = Dialogue.new()
	instance:LoadData(cutsceneDialogue1Data)
	instance:Connect("IntroCurve", function(p12)
		p2:GivePromise(self:_promisePlayCurve(self.mapCurveData.introCutscene1, 4, p12.Duration))
	end)
	local instance2 = nil
	p2:GiveTask(instance)
	p2:GiveTask(instance.OnMessage:Connect(function(p12)
		if p12.IsPlayer then
			local var22 = TableUtils.filter(Players:GetPlayers(), function(p12)
				return MansionRobberyUtils.getIsPlayerInRobbery(self.obj, p12)
			end)
			mansionRobberyStore:dispatch({
				type = "setDialogueText",
				text = ("%s: %s"):format(var22[math.random(1, #var22)].DisplayName, p12.Text)
			})
		else
			mansionRobberyStore:dispatch({
				type = "setDialogueText",
				text = p12.Text
			})
		end
		if p12.GRAB_CAMERA then
			instance2 = CurrentCamera.CFrame
		end
		if p12.IsPlayer then
			CurrentCamera.CFrame = self.obj:FindFirstChild("CameraRelative").CFrame * CFrame.new(2.75805664, 5.60137939, 62.3071289, 0.960502386, 0.0158457458, -0.277820319, 0, 0.998377442, 0.056943398, 0.278271854, -0.0546942689, 0.958943903)
		elseif p12.IsBoss and instance2 then
			CurrentCamera.CFrame = instance2
		end
	end))
	local function updateBornAt()
		instance:SetBornAt(self.obj:GetAttribute(MansionRobberyConsts.LAST_PROGRESSION_BORN_AT_ATTR_NAME))
	end
	instance:SetBornAt(self.obj:GetAttribute(MansionRobberyConsts.LAST_PROGRESSION_BORN_AT_ATTR_NAME))
	p2:GiveTask(self.obj:GetAttributeChangedSignal(MansionRobberyConsts.LAST_PROGRESSION_BORN_AT_ATTR_NAME):Connect(updateBornAt))
	instance:VerifyAllConnected()
	instance:Run()
end
function t._launchRunAwayEndCutscene(self, p2)
	local t = { "CEO: This is not the end for me!", "CEO: I\'ll be back with a vengeance!", "CEO: I may be beaten, but I am not defeated!", "CEO: You won\'t take me today!", "CEO: Where I\'m going, you\'ll never touch me!" }
	local t2 = { "We did it...?", "That was intense, but we did it!", "I\'m so glad that\'s over, but we can\'t rest. We will discover his whereabouts.", "Good riddance." }
	CurrentCamera.CameraType = Enum.CameraType.Scriptable
	p2:GiveTask(function()
		CurrentCamera.CameraType = Enum.CameraType.Custom
	end)
	self.updatePctClosed(0.4)
	p2:GiveTask(function()
		self.updatePctClosed(0)
	end)
	p2:GiveTask(function()
		mansionRobberyStore:dispatch({
			type = "setDialogueText",
			text = ""
		})
	end)
	CurrentCamera.CFrame = self.obj:FindFirstChild("CameraRelative").CFrame * CFrame.new(29.6342773, 11.0867615, 111.834961, -0.751779616, -0.105196744, 0.650969386, 7.45058149e-9, 0.987192988, 0.159530535, -0.65941453, 0.11993181, -0.742151499)
	local instance2 = TableUtils.filter(Players:GetPlayers(), function(p12)
		return MansionRobberyUtils.getIsPlayerInRobbery(self.obj, p12)
	end)
	local var3 = instance2[math.random(1, #instance2)]
	local var4 = ("%s: %s"):format(var3.DisplayName, t2[math.random(1, #t2)])
	local var5 = t[math.random(1, #t)]
	local var6 = ("%s: %s"):format(var3.DisplayName, "Let\'s follow him!")
	mansionRobberyStore:dispatch({
		type = "setDialogueText",
		text = var4
	})
	p2:GivePromise(Promise.delay(2 + utf8.len(var4) / MansionRobberyConsts.CHAR_PER_SECOND):andThen(function()
		mansionRobberyStore:dispatch({
			type = "setDialogueText",
			text = var5
		})
		return Promise.delay(2 + utf8.len(var5) / MansionRobberyConsts.CHAR_PER_SECOND)
	end):andThen(function()
		mansionRobberyStore:dispatch({
			type = "setDialogueText",
			text = var6
		})
		return Promise.delay(2 + utf8.len(var6) / MansionRobberyConsts.CHAR_PER_SECOND)
	end):andThen(function()
		task.defer(p2.DoCleaning, p2)
	end))
end
return ManifestBinder.new(MansionRobberyConsts.TAG_NAME, {
	attemptExitElevatorRemote = MansionRobberyConsts.ATTEMPT_EXIT_ELEVATOR_REMOTE_NAME
}, t)
