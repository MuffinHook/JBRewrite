local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise_upvr = require(ReplicatedStorage.Std.Promise)
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local Players_upvr = game:GetService("Players")
local CurrentCamera_upvr = workspace.CurrentCamera
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local TableUtils_upvr = require(ReplicatedStorage.Std.TableUtils)
local ManifestBinder_upvr = require(ReplicatedStorage.ManifestBinder)
local MansionRobberyUtils_upvr = require(ReplicatedStorage.MansionRobbery.MansionRobberyUtils)
local MansionRobberyConsts_upvr = require(ReplicatedStorage.MansionRobbery.MansionRobberyConsts)
local Roact_upvr = require(ReplicatedStorage.Roact)
local mansionRobberyStore_upvr = require(ReplicatedStorage.MansionRobbery.mansionRobberyStore)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
local RobberyUtils_upvr = require(ReplicatedStorage.Robbery.RobberyUtils)
local RobberyConsts_upvr = require(ReplicatedStorage.Robbery.RobberyConsts)
local createElement_upvr = Roact_upvr.createElement
local RoactRodux_upvr = require(ReplicatedStorage.RoactRodux)
local MansionRobberyApp_upvr = require(ReplicatedStorage.MansionRobbery.UI.MansionRobberyApp)
local RxInstanceUtils_upvr = require(ReplicatedStorage.Std.RxInstanceUtils)
local PlayersEnteredIntroCutscene_upvr = require(ReplicatedStorage.MansionRobbery.Res.PlayersEnteredIntroCutscene)
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
function module_upvr.new(arg1, arg2) -- Line 37
    local any_new_result1_upvr = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1_upvr, module_upvr)
    local function handleProgressionState_upvr() -- Line 41, Named "handleProgressionState"
        local any_new_result1_6 = Maid_upvr.new()
        any_new_result1_upvr.maid.progressionMaid = any_new_result1_6
        if not MansionRobberyUtils_upvr.getIsPlayerInRobbery(any_new_result1_upvr.obj, Players_upvr.LocalPlayer) then
        else
            local any_getProgressionState_result1 = MansionRobberyUtils_upvr.getProgressionState(any_new_result1_upvr.obj)
            if any_getProgressionState_result1 == MansionRobberyConsts_upvr.PROGRESSION_STATE.WaitForEnter then
                any_new_result1_upvr:_launchWaitForEnter(any_new_result1_6)
                return
            end
            if any_getProgressionState_result1 == MansionRobberyConsts_upvr.PROGRESSION_STATE.PlayersEnteredIntroCutscene then
                any_new_result1_upvr:_launchIntroCutscene(any_new_result1_6)
                any_new_result1_upvr:_launchMusic2(any_new_result1_6)
                return
            end
            if any_getProgressionState_result1 == MansionRobberyConsts_upvr.PROGRESSION_STATE.RunAwayEndCutscene then
                any_new_result1_upvr:_launchRunAwayEndCutscene(any_new_result1_6)
                any_new_result1_upvr.maid.currRobberyMaid.music2 = nil
            end
        end
    end
    handleProgressionState_upvr()
    any_new_result1_upvr.maid:GiveTask(MansionRobberyUtils_upvr.getProgressionStateChangedSignal(any_new_result1_upvr.obj):Connect(handleProgressionState_upvr))
    local function handleStatus_upvr() -- Line 64, Named "handleStatus"
        local any_new_result1 = Maid_upvr.new()
        any_new_result1_upvr.maid.currRobberyMaid = any_new_result1
        if not MansionRobberyUtils_upvr.getIsPlayerInRobbery(any_new_result1_upvr.obj, Players_upvr.LocalPlayer) then
        elseif RobberyUtils_upvr.getStatus(any_new_result1_upvr.obj) == RobberyConsts_upvr.ENUM_STATUS.STARTED then
            any_new_result1_upvr:_hookBossCameras(any_new_result1)
            any_new_result1_upvr:_launchStarted(any_new_result1)
        end
    end
    handleStatus_upvr()
    any_new_result1_upvr.maid:GiveTask(RobberyUtils_upvr.getStatusChangedSignal(any_new_result1_upvr.obj):Connect(handleStatus_upvr))
    local any_createBinding_result1, any_createBinding_result2 = Roact_upvr.createBinding(0)
    any_new_result1_upvr.pctClosed = any_createBinding_result1
    any_new_result1_upvr.updatePctClosed = any_createBinding_result2
    any_new_result1_upvr.maid.localPlayerRobberyMaid = Maid_upvr.new()
    local function handleLocalPlayerInRobbery_upvr() -- Line 83, Named "handleLocalPlayerInRobbery"
        handleProgressionState_upvr()
        handleStatus_upvr()
        any_new_result1_upvr.maid.localPlayerRobberyMaid:DoCleaning()
        if MansionRobberyUtils_upvr.getIsPlayerInRobbery(any_new_result1_upvr.obj, Players_upvr.LocalPlayer) then
            local any_mount_result1_upvr = Roact_upvr.mount(createElement_upvr("ScreenGui", {
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
                ResetOnSpawn = false;
                IgnoreGuiInset = true;
                ScreenInsets = Enum.ScreenInsets.None;
                DisplayOrder = 3;
            }, {Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
                store = mansionRobberyStore_upvr;
            }, {createElement_upvr(MansionRobberyApp_upvr, {
                charPerSecond = MansionRobberyConsts_upvr.CHAR_PER_SECOND;
                pctClosed = any_new_result1_upvr.pctClosed;
            })})}), Players_upvr.LocalPlayer.PlayerGui, "MansionRobberyUI")
            any_new_result1_upvr.maid.localPlayerRobberyMaid:GiveTask(function() -- Line 111
                Roact_upvr.unmount(any_mount_result1_upvr)
            end)
        end
    end
    any_new_result1_upvr.maid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(any_new_result1_upvr.obj, MansionRobberyConsts_upvr.IN_ROBBERY_FOLDER_NAME, function(arg1_2, arg2_2) -- Line 121
        arg2_2:GiveTask(RxInstanceUtils_upvr.observeChildren(arg1_2, function(arg1_3, arg2_3) -- Line 123
            if arg1_3.Name == tostring(Players_upvr.LocalPlayer.UserId) then
                handleLocalPlayerInRobbery_upvr()
                arg2_3:GiveTask(arg1_3.Changed:Connect(handleLocalPlayerInRobbery_upvr))
            end
        end))
    end))
    any_new_result1_upvr.mapCurveData = {
        introCutscene1 = {
            curve = PlayersEnteredIntroCutscene_upvr;
            relativeCF = CFrame.new(154.824, 524.029, -172.294);
        };
    }
    local function _() -- Line 143, Named "shouldExitConfirmationBeOpen"
        local any_isPlayerInElevator_result1 = MansionRobberyUtils_upvr.isPlayerInElevator(any_new_result1_upvr.obj, Players_upvr.LocalPlayer)
        if any_isPlayerInElevator_result1 then
            any_isPlayerInElevator_result1 = not MansionRobberyUtils_upvr.getIsElevatorMoving(any_new_result1_upvr.obj)
            if any_isPlayerInElevator_result1 then
                if RobberyUtils_upvr.getStatus(any_new_result1_upvr.obj) ~= RobberyConsts_upvr.ENUM_STATUS.OPENED then
                    any_isPlayerInElevator_result1 = false
                else
                    any_isPlayerInElevator_result1 = true
                end
            end
        end
        return any_isPlayerInElevator_result1
    end
    local attemptExitElevatorRemote_upvr = arg2.attemptExitElevatorRemote
    any_new_result1_upvr.maid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(any_new_result1_upvr.obj, MansionRobberyConsts_upvr.EXIT_ELEVATOR_PART_NAME, function(arg1_4, arg2_4) -- Line 169
        local tbl = {}
        tbl.Part = arg1_4
        tbl.Name = "Exit Elevator"
        tbl.Dist = 25
        function tbl.Callback() -- Line 174
            attemptExitElevatorRemote_upvr:FireServer()
        end
        arg2_4:GiveTask(CircleAction_upvr.Add(tbl, tbl))
    end))
    any_new_result1_upvr.maid:GiveTask(RxInstanceUtils_upvr.observeAttribute(Players_upvr.LocalPlayer, "MansionInvites", function(arg1_5) -- Line 183
        if any_new_result1_upvr.obj:FindFirstChild("InviteCount") then
            any_new_result1_upvr.obj.InviteCount.SurfaceGui.TextLabel.Text = tostring(arg1_5)
        end
    end))
    return any_new_result1_upvr
end
function module_upvr._launchStarted(arg1, arg2) -- Line 191
    arg2:GiveTask(Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 11794013749, {
        Looped = true;
        Volume = 1;
    }))
    local any_ObjectLocal_result1_upvr_2 = Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 11793724573, {
        Looped = true;
        Volume = 0.5;
        Group = game:GetService("SoundService").RobberyMusic;
    })
    function arg2.music1() -- Line 201
        Audio_upvr.promiseFadeTo(any_ObjectLocal_result1_upvr_2, 0, 3):andThen(function() -- Line 202
            any_ObjectLocal_result1_upvr_2:Destroy()
        end)
    end
end
function module_upvr._launchMusic2(arg1) -- Line 207
    local currRobberyMaid = arg1.maid.currRobberyMaid
    currRobberyMaid.music1 = nil
    local any_ObjectLocal_result1_upvr = Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 11793723268, {
        Looped = true;
        Volume = 0.5;
        Group = game:GetService("SoundService").RobberyMusic;
    })
    function currRobberyMaid.music2() -- Line 216
        Audio_upvr.promiseFadeTo(any_ObjectLocal_result1_upvr, 0, 3):andThen(function() -- Line 217
            any_ObjectLocal_result1_upvr:Destroy()
        end)
    end
end
local tbl_2_upvr = {
    doorModel = "Door";
    conePart = "Cone";
    floorCircle = "FloorCircle";
}
local DoorBinder_upvr = require(ReplicatedStorage.Door2.DoorBinder)
local DoorUtils_upvr = require(ReplicatedStorage.Door2.DoorUtils)
local GeomUtils_upvr = require(ReplicatedStorage.Std.GeomUtils)
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
local CharacterUtils_upvr = require(ReplicatedStorage.Std.CharacterUtils)
function module_upvr._hookBossCameras(arg1) -- Line 227
    local any_new_result1_3 = ManifestBinder_upvr.new("BossRoomCamera", tbl_2_upvr, function(arg1_6, arg2) -- Line 229
        local any_new_result1_2_upvr = Maid_upvr.new()
        arg2.conePart.Transparency = 0.95
        any_new_result1_2_upvr:GiveTask(function() -- Line 232
            arg2.conePart.Transparency = 1
        end)
        arg2.floorCircle.Transparency = 0.95
        any_new_result1_2_upvr:GiveTask(function() -- Line 236
            arg2.floorCircle.Transparency = 1
        end)
        local BoolValue_upvr = Instance.new("BoolValue")
        BoolValue_upvr.Name = "IsInFloorCircle"
        BoolValue_upvr.Parent = nil
        any_new_result1_2_upvr:GiveTask(BoolValue_upvr)
        local doorModel_upvr = arg2.doorModel
        any_new_result1_2_upvr:GivePromise(DoorBinder_upvr:Promise(doorModel_upvr):andThen(function(arg1_7) -- Line 247
            local function updateCone() -- Line 248
                local any_getInnerModel_result1 = DoorUtils_upvr.getInnerModel(doorModel_upvr)
                local LookVector = any_getInnerModel_result1.PrimaryPart.CFrame.LookVector
                local Position = any_getInnerModel_result1.PrimaryPart.Position
                local any_intersectRayPlane_result1 = GeomUtils_upvr.intersectRayPlane(Position, LookVector, Position + Vector3.new(0, -40, 0), Vector3.new(0, 1, 0))
                if any_intersectRayPlane_result1 then
                    local var73 = Position + LookVector * 3
                    local var74 = any_intersectRayPlane_result1 + LookVector * 6
                    local Magnitude = (var74 - var73).Magnitude
                    arg2.conePart.Size = Vector3.new(15, Magnitude, 15)
                    arg2.conePart.CFrame = CFrame.lookAt(var73, var74, Vector3.new(1, 1, 1).Unit) * CFrame.new(0, 0, -Magnitude / 2) * CFrame.Angles((math.pi/2), 0, 0)
                    arg2.floorCircle.CFrame = CFrame.new(any_intersectRayPlane_result1)
                end
            end
            updateCone()
            any_new_result1_2_upvr:GiveTask(arg1_7:SetUpdateCallback(updateCone))
        end))
        any_new_result1_2_upvr:GiveTask(Interval_upvr.every(0.25):Connect(function() -- Line 269
            local any_getRootPart_result1 = CharacterUtils_upvr.getRootPart(Players_upvr.LocalPlayer.Character)
            local var78 = false
            if any_getRootPart_result1 then
                if (any_getRootPart_result1.Position - arg2.floorCircle.Position).Magnitude <= arg2.floorCircle.Size.X * 0.5 then
                    var78 = true
                    BoolValue_upvr.Parent = any_getRootPart_result1.Parent
                end
            end
            if not var78 then
                BoolValue_upvr.Parent = nil
            end
        end))
        return any_new_result1_2_upvr
    end)
    any_new_result1_3:Start()
    arg1.maid.currRobberyMaid:GiveTask(any_new_result1_3)
end
function module_upvr.IsPlayerInRobbery(arg1, arg2) -- Line 289
    return MansionRobberyUtils_upvr.getIsPlayerInRobbery(arg1.obj, arg2)
end
local RunService_upvr = game:GetService("RunService")
function module_upvr._promisePlayCurve(arg1, arg2, arg3, arg4) -- Line 292
    local curve_upvr = arg2.curve
    if not curve_upvr.PointData then
        curve_upvr:Generate()
    end
    local any_new_result1_5_upvr = Maid_upvr.new()
    local var84_upvw
    local var85_upvw
    local var86_upvw
    return Promise_upvr.new(function(arg1_8, arg2_5, arg3_2) -- Line 302
        if arg3_2(function() -- Line 305
            any_new_result1_5_upvr:DoCleaning()
        end) then
        else
            local os_clock_result1_upvr = os.clock()
            local var90_upvw = false
            any_new_result1_5_upvr:GiveTask(RunService_upvr.PreRender:Connect(function(arg1_9) -- Line 310
                local var91 = (os.clock() - os_clock_result1_upvr) / (arg4 - 0.1)
                if 1 <= var91 then
                    if not var90_upvw then
                        var90_upvw = true
                        any_new_result1_5_upvr:GiveTask(task.delay(0.1, function() -- Line 318
                            task.defer(any_new_result1_5_upvr.DoCleaning, any_new_result1_5_upvr)
                            arg1_8()
                        end))
                    end
                    var91 = 1
                end
                local any_GetProgressRaw_result1, any_GetProgressRaw_result2, any_GetProgressRaw_result3 = curve_upvr:GetProgressRaw(curve_upvr:GetCurveValueAt(var91), arg3, arg1_9)
                if not var84_upvw then
                    var84_upvw = any_GetProgressRaw_result1
                end
                if not var85_upvw then
                    var85_upvw = any_GetProgressRaw_result2
                end
                if not var86_upvw then
                    var86_upvw = any_GetProgressRaw_result3
                end
                var84_upvw += (any_GetProgressRaw_result1 - var84_upvw) * 0.1
                var85_upvw += (any_GetProgressRaw_result2 - var85_upvw) * 0.1
                var86_upvw += (any_GetProgressRaw_result3 - var86_upvw) * 0.1
                CurrentCamera_upvr.CFrame = arg2.relativeCF:Inverse() * arg1.obj:FindFirstChild("CameraRelative").CFrame * CFrame.lookAt(Vector3.new(0, 0, 0), var85_upvw, var86_upvw) + var84_upvw
            end))
        end
    end)
end
function module_upvr._launchWaitForEnter(arg1, arg2) -- Line 349
    arg2:GiveTask(task.delay(3, function() -- Line 350
        local any_filter_result1 = TableUtils_upvr.filter(Players_upvr:GetPlayers(), function(arg1_10) -- Line 352
            return MansionRobberyUtils_upvr.getIsPlayerInRobbery(arg1.obj, arg1_10)
        end)
        local var99
        if 1 < #any_filter_result1 then
            var99 = "team"
        else
            var99 = ""
        end
        local formatted = "%s: \"Okay %s.. let's find his office.\"":format(any_filter_result1[math.random(1, #any_filter_result1)].DisplayName, var99)
        var99 = {}
        var99.type = "setDialogueText"
        var99.text = formatted
        mansionRobberyStore_upvr:dispatch(var99)
        var99 = Promise_upvr
        var99 = var99.delay(5 + utf8.len(formatted) / MansionRobberyConsts_upvr.CHAR_PER_SECOND)
        var99 = var99:finally(function() -- Line 365
            mansionRobberyStore_upvr:dispatch({
                type = "setDialogueText";
                text = "";
            })
        end)
        arg2:GivePromise(var99)
    end))
end
local Dialogue_upvr = require(ReplicatedStorage.Module.Dialogue)
local cutsceneDialogue1Data_upvr = require(ReplicatedStorage.MansionRobbery.cutsceneDialogue1Data)
function module_upvr._launchIntroCutscene(arg1, arg2) -- Line 375
    CurrentCamera_upvr.CameraType = Enum.CameraType.Scriptable
    arg2:GiveTask(function() -- Line 377
        CurrentCamera_upvr.CameraType = Enum.CameraType.Custom
    end)
    arg1.updatePctClosed(0.4)
    arg2:GiveTask(function() -- Line 383
        arg1.updatePctClosed(0)
    end)
    arg2:GiveTask(function() -- Line 386
        mansionRobberyStore_upvr:dispatch({
            type = "setDialogueText";
            text = "";
        })
    end)
    local any_new_result1_4_upvr = Dialogue_upvr.new()
    any_new_result1_4_upvr:LoadData(cutsceneDialogue1Data_upvr)
    any_new_result1_4_upvr:Connect("IntroCurve", function(arg1_11) -- Line 398
        arg2:GivePromise(arg1:_promisePlayCurve(arg1.mapCurveData.introCutscene1, 4, arg1_11.Duration))
    end)
    arg2:GiveTask(any_new_result1_4_upvr)
    local var112_upvw
    arg2:GiveTask(any_new_result1_4_upvr.OnMessage:Connect(function(arg1_12) -- Line 404
        if arg1_12.IsPlayer then
            local any_filter_result1_3 = TableUtils_upvr.filter(Players_upvr:GetPlayers(), function(arg1_13) -- Line 407
                return MansionRobberyUtils_upvr.getIsPlayerInRobbery(arg1.obj, arg1_13)
            end)
            mansionRobberyStore_upvr:dispatch({
                type = "setDialogueText";
                text = "%s: %s":format(any_filter_result1_3[math.random(1, #any_filter_result1_3)].DisplayName, arg1_12.Text);
            })
        else
            mansionRobberyStore_upvr:dispatch({
                type = "setDialogueText";
                text = arg1_12.Text;
            })
        end
        if arg1_12.GRAB_CAMERA then
            var112_upvw = CurrentCamera_upvr.CFrame
        end
        if arg1_12.IsPlayer then
            CurrentCamera_upvr.CFrame = arg1.obj:FindFirstChild("CameraRelative").CFrame * CFrame.new(2.75805664, 5.60137939, 62.3071289, 0.960502386, 0.0158457458, -0.277820319, 0, 0.998377442, 0.056943398, 0.278271854, -0.0546942689, 0.958943903)
        elseif arg1_12.IsBoss and var112_upvw then
            CurrentCamera_upvr.CFrame = var112_upvw
        end
    end))
    any_new_result1_4_upvr:SetBornAt(arg1.obj:GetAttribute(MansionRobberyConsts_upvr.LAST_PROGRESSION_BORN_AT_ATTR_NAME))
    arg2:GiveTask(arg1.obj:GetAttributeChangedSignal(MansionRobberyConsts_upvr.LAST_PROGRESSION_BORN_AT_ATTR_NAME):Connect(function() -- Line 448, Named "updateBornAt"
        any_new_result1_4_upvr:SetBornAt(arg1.obj:GetAttribute(MansionRobberyConsts_upvr.LAST_PROGRESSION_BORN_AT_ATTR_NAME))
    end))
    any_new_result1_4_upvr:VerifyAllConnected()
    any_new_result1_4_upvr:Run()
end
function module_upvr._launchRunAwayEndCutscene(arg1, arg2) -- Line 461
    local tbl_4 = {"CEO: This is not the end for me!", "CEO: I'll be back with a vengeance!", "CEO: I may be beaten, but I am not defeated!", "CEO: You won't take me today!", "CEO: Where I'm going, you'll never touch me!"}
    local tbl_3 = {"We did it...?", "That was intense, but we did it!", "I'm so glad that's over, but we can't rest. We will discover his whereabouts.", "Good riddance."}
    CurrentCamera_upvr.CameraType = Enum.CameraType.Scriptable
    arg2:GiveTask(function() -- Line 476
        CurrentCamera_upvr.CameraType = Enum.CameraType.Custom
    end)
    arg1.updatePctClosed(0.4)
    arg2:GiveTask(function() -- Line 482
        arg1.updatePctClosed(0)
    end)
    arg2:GiveTask(function() -- Line 485
        mansionRobberyStore_upvr:dispatch({
            type = "setDialogueText";
            text = "";
        })
    end)
    CurrentCamera_upvr.CFrame = arg1.obj:FindFirstChild("CameraRelative").CFrame * CFrame.new(29.6342773, 11.0867615, 111.834961, -0.751779616, -0.105196744, 0.650969386, 7.45058149e-09, 0.987192988, 0.159530535, -0.65941453, 0.11993181, -0.742151499)
    local any_filter_result1_2 = TableUtils_upvr.filter(Players_upvr:GetPlayers(), function(arg1_14) -- Line 508
        return MansionRobberyUtils_upvr.getIsPlayerInRobbery(arg1.obj, arg1_14)
    end)
    local var125 = any_filter_result1_2[math.random(1, #any_filter_result1_2)]
    local formatted_2 = "%s: %s":format(var125.DisplayName, tbl_3[math.random(1, #tbl_3)])
    mansionRobberyStore_upvr:dispatch({
        type = "setDialogueText";
        text = formatted_2;
    })
    local var129_upvr = tbl_4[math.random(1, #tbl_4)]
    local formatted_3_upvr = "%s: %s":format(var125.DisplayName, "Let's follow him!")
    arg2:GivePromise(Promise_upvr.delay(2 + utf8.len(formatted_2) / MansionRobberyConsts_upvr.CHAR_PER_SECOND):andThen(function() -- Line 523
        mansionRobberyStore_upvr:dispatch({
            type = "setDialogueText";
            text = var129_upvr;
        })
        return Promise_upvr.delay(2 + utf8.len(var129_upvr) / MansionRobberyConsts_upvr.CHAR_PER_SECOND)
    end):andThen(function() -- Line 530
        mansionRobberyStore_upvr:dispatch({
            type = "setDialogueText";
            text = formatted_3_upvr;
        })
        return Promise_upvr.delay(2 + utf8.len(formatted_3_upvr) / MansionRobberyConsts_upvr.CHAR_PER_SECOND)
    end):andThen(function() -- Line 537
        task.defer(arg2.DoCleaning, arg2)
    end))
end
return ManifestBinder_upvr.new(MansionRobberyConsts_upvr.TAG_NAME, {
    attemptExitElevatorRemote = MansionRobberyConsts_upvr.ATTEMPT_EXIT_ELEVATOR_REMOTE_NAME;
}, module_upvr)