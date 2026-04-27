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
local MansionRobberyBinder = {}
MansionRobberyBinder.__index = MansionRobberyBinder
setmetatable(MansionRobberyBinder, BaseObject)
function MansionRobberyBinder.new(self, config)
	local instance = BaseObject.new(self)
	setmetatable(instance, MansionRobberyBinder)
	local function handleProgressionState()
		local progressionMaid = Maid.new()
		instance.maid.progressionMaid = progressionMaid
		if MansionRobberyUtils.getIsPlayerInRobbery(instance.obj, Players.LocalPlayer) then
			local progressionState = MansionRobberyUtils.getProgressionState(instance.obj)
			if progressionState == MansionRobberyConsts.PROGRESSION_STATE.WaitForEnter then
				instance:_launchWaitForEnter(progressionMaid)
			elseif progressionState == MansionRobberyConsts.PROGRESSION_STATE.PlayersEnteredIntroCutscene then
				instance:_launchIntroCutscene(progressionMaid)
				instance:_launchMusic2(progressionMaid)
			elseif progressionState == MansionRobberyConsts.PROGRESSION_STATE.RunAwayEndCutscene then
				instance:_launchRunAwayEndCutscene(progressionMaid)
				instance.maid.currRobberyMaid.music2 = nil
			end
		end
	end
	handleProgressionState()
	instance.maid:GiveTask(MansionRobberyUtils.getProgressionStateChangedSignal(instance.obj):Connect(handleProgressionState))
	local function handleStatus()
		local statusValue = RobberyUtils.getStatus(instance.obj)
		local currRobberyMaid = Maid.new()
		instance.maid.currRobberyMaid = currRobberyMaid
		if MansionRobberyUtils.getIsPlayerInRobbery(instance.obj, Players.LocalPlayer) and statusValue == RobberyConsts.ENUM_STATUS.STARTED then
			instance:_hookBossCameras(currRobberyMaid)
			instance:_launchStarted(currRobberyMaid)
		end
	end
	handleStatus()
	instance.maid:GiveTask(RobberyUtils.getStatusChangedSignal(instance.obj):Connect(handleStatus))
	local pctClosedBinding, setPctClosed = Roact.createBinding(0)
	instance.pctClosed = pctClosedBinding
	instance.updatePctClosed = setPctClosed
	instance.maid.localPlayerRobberyMaid = Maid.new()
	local function handleLocalPlayerInRobbery()
		handleProgressionState()
		handleStatus()
		instance.maid.localPlayerRobberyMaid:DoCleaning()
		if MansionRobberyUtils.getIsPlayerInRobbery(instance.obj, Players.LocalPlayer) then
			local guiInstance = Roact.mount(createElement("ScreenGui", {
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
				Roact.unmount(guiInstance)
			end)
		end
	end
	instance.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(instance.obj, MansionRobberyConsts.IN_ROBBERY_FOLDER_NAME, function(self, maid)
		maid:GiveTask(RxInstanceUtils.observeChildren(self, function(self, maid)
			if self.Name == tostring(Players.LocalPlayer.UserId) then
				handleLocalPlayerInRobbery()
				maid:GiveTask(self.Changed:Connect(handleLocalPlayerInRobbery))
			end
		end))
	end))
	instance.mapCurveData = {
		introCutscene1 = {
			curve = PlayersEnteredIntroCutscene,
			relativeCF = CFrame.new(154.824, 524.029, -172.294)
		}
	}
	local attemptExitElevatorRemote = config.attemptExitElevatorRemote
	local function shouldExitConfirmationBeOpen()
		return MansionRobberyUtils.isPlayerInElevator(instance.obj, Players.LocalPlayer) and not MansionRobberyUtils.getIsElevatorMoving(instance.obj) and RobberyUtils.getStatus(instance.obj) == RobberyConsts.ENUM_STATUS.OPENED
	end
	instance.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(instance.obj, MansionRobberyConsts.EXIT_ELEVATOR_PART_NAME, function(self, maid)
		local exitElevatorAction = {
			Part = self,
			Name = "Exit Elevator",
			Dist = 25,
			Callback = function()
				attemptExitElevatorRemote:FireServer()
			end
		}
		maid:GiveTask(CircleAction.Add(exitElevatorAction, exitElevatorAction))
	end))
	instance.maid:GiveTask(RxInstanceUtils.observeAttribute(Players.LocalPlayer, "MansionInvites", function(self)
		if instance.obj:FindFirstChild("InviteCount") then
			instance.obj.InviteCount.SurfaceGui.TextLabel.Text = tostring(self)
		end
	end))
	return instance
end
function MansionRobberyBinder._launchStarted(self, maid)
	maid:GiveTask(Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 11794013749, {
		Looped = true,
		Volume = 1
	}))
	local musicInstance = Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 11793724573, {
		Looped = true,
		Volume = 0.5,
		Group = game:GetService("SoundService").RobberyMusic
	})
	function maid.music1()
		Audio.promiseFadeTo(musicInstance, 0, 3):andThen(function()
			musicInstance:Destroy()
		end)
	end
end
function MansionRobberyBinder._launchMusic2(self)
	local currRobberyMaid = self.maid.currRobberyMaid
	currRobberyMaid.music1 = nil
	local musicInstance = Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 11793723268, {
		Looped = true,
		Volume = 0.5,
		Group = game:GetService("SoundService").RobberyMusic
	})
	function currRobberyMaid.music2()
		Audio.promiseFadeTo(musicInstance, 0, 3):andThen(function()
			musicInstance:Destroy()
		end)
	end
end
local bossRoomParts = {
	doorModel = "Door",
	conePart = "Cone",
	floorCircle = "FloorCircle"
}
function MansionRobberyBinder._hookBossCameras(self)
	local manifestBinder = ManifestBinder.new("BossRoomCamera", bossRoomParts, function(self, manifestParts)
		local maid = Maid.new()
		manifestParts.conePart.Transparency = 0.95
		maid:GiveTask(function()
			manifestParts.conePart.Transparency = 1
		end)
		manifestParts.floorCircle.Transparency = 0.95
		maid:GiveTask(function()
			manifestParts.floorCircle.Transparency = 1
		end)
		local IsInFloorCircle = Instance.new("BoolValue")
		IsInFloorCircle.Name = "IsInFloorCircle"
		IsInFloorCircle.Parent = nil
		maid:GiveTask(IsInFloorCircle)
		local doorModel = manifestParts.doorModel
		maid:GivePromise(DoorBinder:Promise(doorModel):andThen(function(self)
			local function updateCone()
				local doorInstance = DoorUtils.getInnerModel(doorModel)
				local LookVector = doorInstance.PrimaryPart.CFrame.LookVector
				local Position = doorInstance.PrimaryPart.Position
				local intersectionPoint = GeomUtils.intersectRayPlane(Position, LookVector, Position + Vector3.new(0, -40, 0), Vector3.new(0, 1, 0))
				if intersectionPoint then
					local coneStart = Position + LookVector * 3
					local coneEnd = intersectionPoint + LookVector * 6
					local Magnitude = (coneEnd - coneStart).Magnitude
					manifestParts.conePart.Size = Vector3.new(15, Magnitude, 15)
					manifestParts.conePart.CFrame = CFrame.lookAt(coneStart, coneEnd, (Vector3.new(1, 1, 1)).Unit) * CFrame.new(0, 0, -Magnitude / 2) * CFrame.Angles(1.5707963267948966, 0, 0)
					manifestParts.floorCircle.CFrame = CFrame.new(intersectionPoint)
				end
			end
			updateCone()
			maid:GiveTask(self:SetUpdateCallback(updateCone))
		end))
		maid:GiveTask(Interval.every(0.25):Connect(function()
			local rootPart = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
			local isPlayerInCircle
			if rootPart and (rootPart.Position - manifestParts.floorCircle.Position).Magnitude <= manifestParts.floorCircle.Size.X * 0.5 then
				IsInFloorCircle.Parent = rootPart.Parent
				isPlayerInCircle = true
			else
				isPlayerInCircle = false
			end
			if not isPlayerInCircle then
				IsInFloorCircle.Parent = nil
			end
		end))
		return maid
	end)
	manifestBinder:Start()
	self.maid.currRobberyMaid:GiveTask(manifestBinder)
end
function MansionRobberyBinder.IsPlayerInRobbery(self, player)
	return MansionRobberyUtils.getIsPlayerInRobbery(self.obj, player)
end
function MansionRobberyBinder._promisePlayCurve(self, curveData, targetTime, duration)
	local curve = curveData.curve
	if not curve.PointData then
		curve:Generate()
	end
	local startPosition = nil
	local startUpVector = nil
	local startForwardVector = nil
	local maid = Maid.new()
	return Promise.new(function(resolve, reject, onCancel)
		local isCompleted = false
		local startTime = os.clock()
		if not onCancel(function()
			maid:DoCleaning()
		end) then
			maid:GiveTask(RunService.PreRender:Connect(function(deltaTime)
				local progress = (os.clock() - startTime) / (duration - 0.1)
				if progress >= 1 then
					if not isCompleted then
						isCompleted = true
						maid:GiveTask(task.delay(0.1, function()
							task.defer(maid.DoCleaning, maid)
							resolve()
						end))
					end
					progress = 1
				end
				local cameraPosition, cameraUpVector, cameraForwardVector = curve:GetProgressRaw(curve:GetCurveValueAt(progress), targetTime, deltaTime)
				if not startPosition then
					startPosition = cameraPosition
				end
				if not startUpVector then
					startUpVector = cameraUpVector
				end
				if not startForwardVector then
					startForwardVector = cameraForwardVector
				end
				startPosition = startPosition + (cameraPosition - startPosition) * 0.1
				startUpVector = startUpVector + (cameraUpVector - startUpVector) * 0.1
				startForwardVector = startForwardVector + (cameraForwardVector - startForwardVector) * 0.1
				CurrentCamera.CFrame = curveData.relativeCF:Inverse() * self.obj:FindFirstChild("CameraRelative").CFrame * CFrame.lookAt(Vector3.new(0, 0, 0), startUpVector, startForwardVector) + startPosition
			end))
		end
	end)
end
function MansionRobberyBinder._launchWaitForEnter(self, maid)
	maid:GiveTask(task.delay(3, function()
		local playersInRobbery = TableUtils.filter(Players:GetPlayers(), function(player)
			return MansionRobberyUtils.getIsPlayerInRobbery(self.obj, player)
		end)
		local selectedPlayerName = playersInRobbery[math.random(1, #playersInRobbery)].DisplayName
		local dialogueText = ("%s: \"Okay %s.. let\'s find his office.\""):format(selectedPlayerName, if #playersInRobbery > 1 then "team" else "")
		mansionRobberyStore:dispatch({
			type = "setDialogueText",
			text = dialogueText
		})
		maid:GivePromise(Promise.delay(5 + utf8.len(dialogueText) / MansionRobberyConsts.CHAR_PER_SECOND):finally(function()
			mansionRobberyStore:dispatch({
				type = "setDialogueText",
				text = ""
			})
		end))
	end))
end
local cutsceneDialogue1Data = require(ReplicatedStorage.MansionRobbery.cutsceneDialogue1Data)
function MansionRobberyBinder._launchIntroCutscene(self, maid)
	CurrentCamera.CameraType = Enum.CameraType.Scriptable
	maid:GiveTask(function()
		CurrentCamera.CameraType = Enum.CameraType.Custom
	end)
	self.updatePctClosed(0.4)
	maid:GiveTask(function()
		self.updatePctClosed(0)
	end)
	maid:GiveTask(function()
		mansionRobberyStore:dispatch({
			type = "setDialogueText",
			text = ""
		})
	end)
	local dialogue = Dialogue.new()
	dialogue:LoadData(cutsceneDialogue1Data)
	dialogue:Connect("IntroCurve", function(curveEvent)
		maid:GivePromise(self:_promisePlayCurve(self.mapCurveData.introCutscene1, 4, curveEvent.Duration))
	end)
	local previousCameraFrame = nil
	maid:GiveTask(dialogue)
	maid:GiveTask(dialogue.OnMessage:Connect(function(message)
		if message.IsPlayer then
			local playersInRobbery = TableUtils.filter(Players:GetPlayers(), function(player)
				return MansionRobberyUtils.getIsPlayerInRobbery(self.obj, player)
			end)
			mansionRobberyStore:dispatch({
				type = "setDialogueText",
				text = ("%s: %s"):format(playersInRobbery[math.random(1, #playersInRobbery)].DisplayName, message.Text)
			})
		else
			mansionRobberyStore:dispatch({
				type = "setDialogueText",
				text = message.Text
			})
		end
		if message.GRAB_CAMERA then
			previousCameraFrame = CurrentCamera.CFrame
		end
		if message.IsPlayer then
			CurrentCamera.CFrame = self.obj:FindFirstChild("CameraRelative").CFrame * CFrame.new(2.75805664, 5.60137939, 62.3071289, 0.960502386, 0.0158457458, -0.277820319, 0, 0.998377442, 0.056943398, 0.278271854, -0.0546942689, 0.958943903)
		elseif message.IsBoss and previousCameraFrame then
			CurrentCamera.CFrame = previousCameraFrame
		end
	end))
	local function updateBornAt()
		dialogue:SetBornAt(self.obj:GetAttribute(MansionRobberyConsts.LAST_PROGRESSION_BORN_AT_ATTR_NAME))
	end
	dialogue:SetBornAt(self.obj:GetAttribute(MansionRobberyConsts.LAST_PROGRESSION_BORN_AT_ATTR_NAME))
	maid:GiveTask(self.obj:GetAttributeChangedSignal(MansionRobberyConsts.LAST_PROGRESSION_BORN_AT_ATTR_NAME):Connect(updateBornAt))
	dialogue:VerifyAllConnected()
	dialogue:Run()
end
function MansionRobberyBinder._launchRunAwayEndCutscene(self, maid)
	local ceoDynamiteLines = { "CEO: This is not the end for me!", "CEO: I\'ll be back with a vengeance!", "CEO: I may be beaten, but I am not defeated!", "CEO: You won\'t take me today!", "CEO: Where I\'m going, you\'ll never touch me!" }
	local playerVictoryLines = { "We did it...?", "That was intense, but we did it!", "I\'m so glad that\'s over, but we can\'t rest. We will discover his whereabouts.", "Good riddance." }
	CurrentCamera.CameraType = Enum.CameraType.Scriptable
	maid:GiveTask(function()
		CurrentCamera.CameraType = Enum.CameraType.Custom
	end)
	self.updatePctClosed(0.4)
	maid:GiveTask(function()
		self.updatePctClosed(0)
	end)
	maid:GiveTask(function()
		mansionRobberyStore:dispatch({
			type = "setDialogueText",
			text = ""
		})
	end)
	CurrentCamera.CFrame = self.obj:FindFirstChild("CameraRelative").CFrame * CFrame.new(29.6342773, 11.0867615, 111.834961, -0.751779616, -0.105196744, 0.650969386, 7.45058149e-9, 0.987192988, 0.159530535, -0.65941453, 0.11993181, -0.742151499)
	local playersInRobbery = TableUtils.filter(Players:GetPlayers(), function(player)
		return MansionRobberyUtils.getIsPlayerInRobbery(self.obj, player)
	end)
	local selectedPlayer = playersInRobbery[math.random(1, #playersInRobbery)]
	local playerDialogueLine = ("%s: %s"):format(selectedPlayer.DisplayName, playerVictoryLines[math.random(1, #playerVictoryLines)])
	local ceoDialogueLine = ceoDynamiteLines[math.random(1, #ceoDynamiteLines)]
	local followLine = ("%s: %s"):format(selectedPlayer.DisplayName, "Let\'s follow him!")
	mansionRobberyStore:dispatch({
		type = "setDialogueText",
		text = playerDialogueLine
	})
	maid:GivePromise(Promise.delay(2 + utf8.len(playerDialogueLine) / MansionRobberyConsts.CHAR_PER_SECOND):andThen(function()
		mansionRobberyStore:dispatch({
			type = "setDialogueText",
			text = ceoDialogueLine
		})
		return Promise.delay(2 + utf8.len(ceoDialogueLine) / MansionRobberyConsts.CHAR_PER_SECOND)
	end):andThen(function()
		mansionRobberyStore:dispatch({
			type = "setDialogueText",
			text = followLine
		})
		return Promise.delay(2 + utf8.len(followLine) / MansionRobberyConsts.CHAR_PER_SECOND)
	end):andThen(function()
		task.defer(maid.DoCleaning, maid)
	end))
end
return ManifestBinder.new(MansionRobberyConsts.TAG_NAME, {
	attemptExitElevatorRemote = MansionRobberyConsts.ATTEMPT_EXIT_ELEVATOR_REMOTE_NAME
}, MansionRobberyBinder)
