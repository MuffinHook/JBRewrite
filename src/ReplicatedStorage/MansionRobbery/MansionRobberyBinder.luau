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
function t.new(p1, p2)
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	local function handleProgressionState()
		local v12 = Maid.new()
		v1.maid.progressionMaid = v12
		if MansionRobberyUtils.getIsPlayerInRobbery(v1.obj, Players.LocalPlayer) then
			local v2 = MansionRobberyUtils.getProgressionState(v1.obj)
			if v2 == MansionRobberyConsts.PROGRESSION_STATE.WaitForEnter then
				v1:_launchWaitForEnter(v12)
			elseif v2 == MansionRobberyConsts.PROGRESSION_STATE.PlayersEnteredIntroCutscene then
				v1:_launchIntroCutscene(v12)
				v1:_launchMusic2(v12)
			elseif v2 == MansionRobberyConsts.PROGRESSION_STATE.RunAwayEndCutscene then
				v1:_launchRunAwayEndCutscene(v12)
				v1.maid.currRobberyMaid.music2 = nil
			end
		end
	end
	handleProgressionState()
	v1.maid:GiveTask(MansionRobberyUtils.getProgressionStateChangedSignal(v1.obj):Connect(handleProgressionState))
	local function handleStatus()
		local v12 = RobberyUtils.getStatus(v1.obj)
		local v2 = Maid.new()
		v1.maid.currRobberyMaid = v2
		if MansionRobberyUtils.getIsPlayerInRobbery(v1.obj, Players.LocalPlayer) and v12 == RobberyConsts.ENUM_STATUS.STARTED then
			v1:_hookBossCameras(v2)
			v1:_launchStarted(v2)
		end
	end
	handleStatus()
	v1.maid:GiveTask(RobberyUtils.getStatusChangedSignal(v1.obj):Connect(handleStatus))
	local v3, v4 = Roact.createBinding(0)
	v1.pctClosed = v3
	v1.updatePctClosed = v4
	v1.maid.localPlayerRobberyMaid = Maid.new()
	local function handleLocalPlayerInRobbery()
		handleProgressionState()
		handleStatus()
		v1.maid.localPlayerRobberyMaid:DoCleaning()
		if MansionRobberyUtils.getIsPlayerInRobbery(v1.obj, Players.LocalPlayer) then
			local v12 = Roact.mount(createElement("ScreenGui", {
				ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
				ResetOnSpawn = false,
				IgnoreGuiInset = true,
				ScreenInsets = Enum.ScreenInsets.None,
				DisplayOrder = 3
			}, { Roact.createElement(RoactRodux.StoreProvider, {
					store = mansionRobberyStore
				}, { createElement(MansionRobberyApp, {
						charPerSecond = MansionRobberyConsts.CHAR_PER_SECOND,
						pctClosed = v1.pctClosed
					}) }) }), Players.LocalPlayer.PlayerGui, "MansionRobberyUI")
			v1.maid.localPlayerRobberyMaid:GiveTask(function()
				Roact.unmount(v12)
			end)
		end
	end
	v1.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(v1.obj, MansionRobberyConsts.IN_ROBBERY_FOLDER_NAME, function(p1, p2)
		p2:GiveTask(RxInstanceUtils.observeChildren(p1, function(p1, p2)
			if p1.Name == tostring(Players.LocalPlayer.UserId) then
				handleLocalPlayerInRobbery()
				p2:GiveTask(p1.Changed:Connect(handleLocalPlayerInRobbery))
			end
		end))
	end))
	v1.mapCurveData = {
		introCutscene1 = {
			curve = PlayersEnteredIntroCutscene,
			relativeCF = CFrame.new(154.824, 524.029, -172.294)
		}
	}
	local attemptExitElevatorRemote = p2.attemptExitElevatorRemote
	local function shouldExitConfirmationBeOpen()
		return MansionRobberyUtils.isPlayerInElevator(v1.obj, Players.LocalPlayer) and not MansionRobberyUtils.getIsElevatorMoving(v1.obj) and RobberyUtils.getStatus(v1.obj) == RobberyConsts.ENUM_STATUS.OPENED
	end
	v1.maid:GiveTask(RxInstanceUtils.observeOneChildNamed(v1.obj, MansionRobberyConsts.EXIT_ELEVATOR_PART_NAME, function(p1, p2)
		local t = {
			Part = p1,
			Name = "Exit Elevator",
			Dist = 25,
			Callback = function()
				attemptExitElevatorRemote:FireServer()
			end
		}
		p2:GiveTask(CircleAction.Add(t, t))
	end))
	v1.maid:GiveTask(RxInstanceUtils.observeAttribute(Players.LocalPlayer, "MansionInvites", function(p1)
		if v1.obj:FindFirstChild("InviteCount") then
			v1.obj.InviteCount.SurfaceGui.TextLabel.Text = tostring(p1)
		end
	end))
	return v1
end
function t._launchStarted(p1, p2)
	p2:GiveTask(Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 11794013749, {
		Looped = true,
		Volume = 1
	}))
	local v1 = Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 11793724573, {
		Looped = true,
		Volume = 0.5,
		Group = game:GetService("SoundService").RobberyMusic
	})
	function p2.music1()
		Audio.promiseFadeTo(v1, 0, 3):andThen(function()
			v1:Destroy()
		end)
	end
end
function t._launchMusic2(p1)
	local currRobberyMaid = p1.maid.currRobberyMaid
	currRobberyMaid.music1 = nil
	local v1 = Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 11793723268, {
		Looped = true,
		Volume = 0.5,
		Group = game:GetService("SoundService").RobberyMusic
	})
	function currRobberyMaid.music2()
		Audio.promiseFadeTo(v1, 0, 3):andThen(function()
			v1:Destroy()
		end)
	end
end
local t2 = {
	doorModel = "Door",
	conePart = "Cone",
	floorCircle = "FloorCircle"
}
function t._hookBossCameras(p1)
	local v1 = ManifestBinder.new("BossRoomCamera", t2, function(p1, p2)
		local v1 = Maid.new()
		p2.conePart.Transparency = 0.95
		v1:GiveTask(function()
			p2.conePart.Transparency = 1
		end)
		p2.floorCircle.Transparency = 0.95
		v1:GiveTask(function()
			p2.floorCircle.Transparency = 1
		end)
		local IsInFloorCircle = Instance.new("BoolValue")
		IsInFloorCircle.Name = "IsInFloorCircle"
		IsInFloorCircle.Parent = nil
		v1:GiveTask(IsInFloorCircle)
		local doorModel = p2.doorModel
		v1:GivePromise(DoorBinder:Promise(doorModel):andThen(function(p1)
			local function updateCone()
				local v1 = DoorUtils.getInnerModel(doorModel)
				local LookVector = v1.PrimaryPart.CFrame.LookVector
				local Position = v1.PrimaryPart.Position
				local v2 = GeomUtils.intersectRayPlane(Position, LookVector, Position + Vector3.new(0, -40, 0), Vector3.new(0, 1, 0))
				if v2 then
					local v3 = Position + LookVector * 3
					local v4 = v2 + LookVector * 6
					local Magnitude = (v4 - v3).Magnitude
					p2.conePart.Size = Vector3.new(15, Magnitude, 15)
					p2.conePart.CFrame = CFrame.lookAt(v3, v4, (Vector3.new(1, 1, 1)).Unit) * CFrame.new(0, 0, -Magnitude / 2) * CFrame.Angles(1.5707963267948966, 0, 0)
					p2.floorCircle.CFrame = CFrame.new(v2)
				end
			end
			updateCone()
			v1:GiveTask(p1:SetUpdateCallback(updateCone))
		end))
		v1:GiveTask(Interval.every(0.25):Connect(function()
			local v1 = CharacterUtils.getRootPart(Players.LocalPlayer.Character)
			local v2
			if v1 and (v1.Position - p2.floorCircle.Position).Magnitude <= p2.floorCircle.Size.X * 0.5 then
				IsInFloorCircle.Parent = v1.Parent
				v2 = true
			else
				v2 = false
			end
			if not v2 then
				IsInFloorCircle.Parent = nil
			end
		end))
		return v1
	end)
	v1:Start()
	p1.maid.currRobberyMaid:GiveTask(v1)
end
function t.IsPlayerInRobbery(p1, p2)
	return MansionRobberyUtils.getIsPlayerInRobbery(p1.obj, p2)
end
function t._promisePlayCurve(p1, p2, p3, p4)
	local curve = p2.curve
	if not curve.PointData then
		curve:Generate()
	end
	local v1 = nil
	local v2 = nil
	local v3 = nil
	local v4 = Maid.new()
	return Promise.new(function(p12, p22, p32)
		local v12 = false
		local v22 = os.clock()
		if not p32(function()
			v4:DoCleaning()
		end) then
			v4:GiveTask(RunService.PreRender:Connect(function(p13)
				local v13 = (os.clock() - v22) / (p4 - 0.1)
				if v13 >= 1 then
					if not v12 then
						v12 = true
						v4:GiveTask(task.delay(0.1, function()
							task.defer(v4.DoCleaning, v4)
							p12()
						end))
					end
					v13 = 1
				end
				local v23, v32, v42 = curve:GetProgressRaw(curve:GetCurveValueAt(v13), p3, p13)
				if not v1 then
					v1 = v23
				end
				if not v2 then
					v2 = v32
				end
				if not v3 then
					v3 = v42
				end
				v1 = v1 + (v23 - v1) * 0.1
				v2 = v2 + (v32 - v2) * 0.1
				v3 = v3 + (v42 - v3) * 0.1
				CurrentCamera.CFrame = p2.relativeCF:Inverse() * p1.obj:FindFirstChild("CameraRelative").CFrame * CFrame.lookAt(Vector3.new(0, 0, 0), v2, v3) + v1
			end))
		end
	end)
end
function t._launchWaitForEnter(p1, p2)
	p2:GiveTask(task.delay(3, function()
		local v2 = TableUtils.filter(Players:GetPlayers(), function(p12)
			return MansionRobberyUtils.getIsPlayerInRobbery(p1.obj, p12)
		end)
		local DisplayName = v2[math.random(1, #v2)].DisplayName
		local v5 = ("%s: \"Okay %s.. let\'s find his office.\""):format(DisplayName, if #v2 > 1 then "team" else "")
		mansionRobberyStore:dispatch({
			type = "setDialogueText",
			text = v5
		})
		p2:GivePromise(Promise.delay(5 + utf8.len(v5) / MansionRobberyConsts.CHAR_PER_SECOND):finally(function()
			mansionRobberyStore:dispatch({
				type = "setDialogueText",
				text = ""
			})
		end))
	end))
end
local cutsceneDialogue1Data = require(ReplicatedStorage.MansionRobbery.cutsceneDialogue1Data)
function t._launchIntroCutscene(p1, p2)
	CurrentCamera.CameraType = Enum.CameraType.Scriptable
	p2:GiveTask(function()
		CurrentCamera.CameraType = Enum.CameraType.Custom
	end)
	p1.updatePctClosed(0.4)
	p2:GiveTask(function()
		p1.updatePctClosed(0)
	end)
	p2:GiveTask(function()
		mansionRobberyStore:dispatch({
			type = "setDialogueText",
			text = ""
		})
	end)
	local v1 = Dialogue.new()
	v1:LoadData(cutsceneDialogue1Data)
	v1:Connect("IntroCurve", function(p12)
		p2:GivePromise(p1:_promisePlayCurve(p1.mapCurveData.introCutscene1, 4, p12.Duration))
	end)
	local v2 = nil
	p2:GiveTask(v1)
	p2:GiveTask(v1.OnMessage:Connect(function(p12)
		if p12.IsPlayer then
			local v22 = TableUtils.filter(Players:GetPlayers(), function(p12)
				return MansionRobberyUtils.getIsPlayerInRobbery(p1.obj, p12)
			end)
			mansionRobberyStore:dispatch({
				type = "setDialogueText",
				text = ("%s: %s"):format(v22[math.random(1, #v22)].DisplayName, p12.Text)
			})
		else
			mansionRobberyStore:dispatch({
				type = "setDialogueText",
				text = p12.Text
			})
		end
		if p12.GRAB_CAMERA then
			v2 = CurrentCamera.CFrame
		end
		if p12.IsPlayer then
			CurrentCamera.CFrame = p1.obj:FindFirstChild("CameraRelative").CFrame * CFrame.new(2.75805664, 5.60137939, 62.3071289, 0.960502386, 0.0158457458, -0.277820319, 0, 0.998377442, 0.056943398, 0.278271854, -0.0546942689, 0.958943903)
		elseif p12.IsBoss and v2 then
			CurrentCamera.CFrame = v2
		end
	end))
	local function updateBornAt()
		v1:SetBornAt(p1.obj:GetAttribute(MansionRobberyConsts.LAST_PROGRESSION_BORN_AT_ATTR_NAME))
	end
	v1:SetBornAt(p1.obj:GetAttribute(MansionRobberyConsts.LAST_PROGRESSION_BORN_AT_ATTR_NAME))
	p2:GiveTask(p1.obj:GetAttributeChangedSignal(MansionRobberyConsts.LAST_PROGRESSION_BORN_AT_ATTR_NAME):Connect(updateBornAt))
	v1:VerifyAllConnected()
	v1:Run()
end
function t._launchRunAwayEndCutscene(p1, p2)
	local t = { "CEO: This is not the end for me!", "CEO: I\'ll be back with a vengeance!", "CEO: I may be beaten, but I am not defeated!", "CEO: You won\'t take me today!", "CEO: Where I\'m going, you\'ll never touch me!" }
	local t2 = { "We did it...?", "That was intense, but we did it!", "I\'m so glad that\'s over, but we can\'t rest. We will discover his whereabouts.", "Good riddance." }
	CurrentCamera.CameraType = Enum.CameraType.Scriptable
	p2:GiveTask(function()
		CurrentCamera.CameraType = Enum.CameraType.Custom
	end)
	p1.updatePctClosed(0.4)
	p2:GiveTask(function()
		p1.updatePctClosed(0)
	end)
	p2:GiveTask(function()
		mansionRobberyStore:dispatch({
			type = "setDialogueText",
			text = ""
		})
	end)
	CurrentCamera.CFrame = p1.obj:FindFirstChild("CameraRelative").CFrame * CFrame.new(29.6342773, 11.0867615, 111.834961, -0.751779616, -0.105196744, 0.650969386, 7.45058149e-9, 0.987192988, 0.159530535, -0.65941453, 0.11993181, -0.742151499)
	local v2 = TableUtils.filter(Players:GetPlayers(), function(p12)
		return MansionRobberyUtils.getIsPlayerInRobbery(p1.obj, p12)
	end)
	local v3 = v2[math.random(1, #v2)]
	local v4 = ("%s: %s"):format(v3.DisplayName, t2[math.random(1, #t2)])
	local v5 = t[math.random(1, #t)]
	local v6 = ("%s: %s"):format(v3.DisplayName, "Let\'s follow him!")
	mansionRobberyStore:dispatch({
		type = "setDialogueText",
		text = v4
	})
	p2:GivePromise(Promise.delay(2 + utf8.len(v4) / MansionRobberyConsts.CHAR_PER_SECOND):andThen(function()
		mansionRobberyStore:dispatch({
			type = "setDialogueText",
			text = v5
		})
		return Promise.delay(2 + utf8.len(v5) / MansionRobberyConsts.CHAR_PER_SECOND)
	end):andThen(function()
		mansionRobberyStore:dispatch({
			type = "setDialogueText",
			text = v6
		})
		return Promise.delay(2 + utf8.len(v6) / MansionRobberyConsts.CHAR_PER_SECOND)
	end):andThen(function()
		task.defer(p2.DoCleaning, p2)
	end))
end
return ManifestBinder.new(MansionRobberyConsts.TAG_NAME, {
	attemptExitElevatorRemote = MansionRobberyConsts.ATTEMPT_EXIT_ELEVATOR_REMOTE_NAME
}, t)
