local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local RunUtils_upvr = require(ReplicatedStorage_upvr.App.RunUtils)
local TeamShared_upvr = require(ReplicatedStorage_upvr.App.TeamShared)
local EzUtils_upvr = require(ReplicatedStorage_upvr.EzUi.EzUtils)
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local tbl_upvr = {
    City2_Start = {
        p = Vector3.new(-93.269, 62.1699, 431.170);
        LookVector = Vector3.new(0.17000, -0.2599, 0.94999);
    };
    PoliceBase1 = {
        p = Vector3.new(-1173.1, 43.3499, -1573.4);
        LookVector = Vector3.new(0.01999, -0.0199, -1);
    };
    City2_Stop = {
        p = Vector3.new(39.0299, 62.1699, 1179.23);
        LookVector = Vector3.new(0.17000, -0.2599, 0.94999);
    };
    Prisoner_Cells = {
        p = Vector3.new(-1391.6, 4.09999, -1963.1);
        LookVector = Vector3.new(-0.7799, -0.3000, -0.5500);
    };
    Prisoner_Yard = {
        p = Vector3.new(-1145.5, 18.8500, -1858.0);
        LookVector = Vector3.new(-0.7099, -0, 0.70999);
    };
    Prisoner_Foodcourt = {
        p = Vector3.new(-1424.4, 45.4900, -1763.4);
        LookVector = Vector3.new(-0.0099, -0.4900, -0.8700);
    };
    City1_Start = {
        p = Vector3.new(-1088.8, 117.120, -2020.9);
        LookVector = Vector3.new(-0.5, -0.0199, 0.86000);
    };
    City1_Stop = {
        p = Vector3.new(-1301.4, 68.3300, -1581.1);
        LookVector = Vector3.new(-0.4600, -0.0199, 0.88999);
    };
    City3_Start = {
        p = Vector3.new(655.739, 71.5699, -1052.7);
        LookVector = Vector3.new(-0.5699, 0.02999, -0.8199);
    };
    City3_Stop = {
        p = Vector3.new(230.679, 57.8600, -1542.0);
        LookVector = Vector3.new(-0.5500, 0.02999, -0.8299);
    };
}
local tbl_3 = {
    p = Vector3.new(739.130, 38.9099, 1125.96);
    LookVector = Vector3.new(-0.8100, 0.09000, -0.5699);
}
tbl_upvr.PoliceBase2 = tbl_3
tbl_3 = {}
local var22_upvr = tbl_3
for i, _ in tbl_upvr do
    var22_upvr[i] = {
        p = Vector3.new(0, 0, 0);
        LookVector = Vector3.new(0, 0, -1);
    }
end
local function _(arg1) -- Line 63, Named "SelectIfGamepad"
    EzUtils_upvr.selectIfGamepad(arg1)
end
local function _(arg1) -- Line 67, Named "Ease_InOutQuad"
    local var24
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var24 = 2 * arg1 * arg1
        return var24
    end
    if arg1 >= 0.5 or not decompInlinedCondition() then
        var24 = -1 - 2 * (arg1 - 2) * arg1
    end
    return var24
end
local var25_upvw
local var26_upvw
local var27_upvw
local module_upvr = {
    ColorCorrection = nil;
    Maid = require(ReplicatedStorage_upvr.Std.Maid).new();
}
local Lighting_upvr = game:GetService("Lighting")
local any_isStudio_result1_upvr = RunUtils_upvr.isStudio()
local Settings_upvr = require(ReplicatedStorage_upvr.Resource.Settings)
function module_upvr.Init(arg1) -- Line 79
    var25_upvw = arg1.Event
    var26_upvw = arg1.em
    var27_upvw = arg1.OnJump
    module_upvr.ColorCorrection = Lighting_upvr:FindFirstChild("ColorCorrection")
    function var26_upvw.pce3mz4c() -- Line 88
        module_upvr.Hide()
    end
    function var26_upvw.iqhsv859(arg1_2) -- Line 93
        if not TeamShared_upvr.isTeamSwitchingEnabled() then
        else
            module_upvr.Show(arg1_2)
        end
    end
    if any_isStudio_result1_upvr and not Settings_upvr.Test.ChooseTeamInitially then
    else
        var26_upvw.iqhsv859(true)
    end
end
local ScreenFade_upvr = require(ReplicatedStorage_upvr.App.ScreenFade)
local CinematicCamera_upvr = require(ReplicatedStorage_upvr.Module.CinematicCamera)
local CurrentCamera_upvr = workspace.CurrentCamera
local RunService_upvr = game:GetService("RunService")
local Notification_upvr = require(ReplicatedStorage_upvr.Game.Notification)
local Localization_upvr = require(ReplicatedStorage_upvr.Module.Localization)
local Teams_upvr = game:GetService("Teams")
local VoiceChatService_upvr = game:GetService("VoiceChatService")
local Players_upvr = game:GetService("Players")
local TeamSelectConsts_upvr = require(ReplicatedStorage_upvr.TeamSelect.TeamSelectConsts)
local GamepassSystem_upvr = require(ReplicatedStorage_upvr.Gamepass.GamepassSystem)
local GamepassUtils_upvr = require(ReplicatedStorage_upvr.Gamepass.GamepassUtils)
local WorldTeleportConsts_upvr = require(ReplicatedStorage_upvr.WorldTeleport.WorldTeleportConsts)
local RunConsts_upvr = require(ReplicatedStorage_upvr.App.RunConsts)
local createElement_upvr = Roact_upvr.createElement
local TeamSelect_upvr = require(ReplicatedStorage_upvr.TeamSelect.UI.TeamSelect)
local CharacterUtils_upvr = require(ReplicatedStorage_upvr.Std.CharacterUtils)
local InventoryItemSystem_upvr = require(ReplicatedStorage_upvr.Inventory.InventoryItemSystem)
local WorldMarkerSystem_upvr = require(ReplicatedStorage_upvr.Game.WorldMarker.WorldMarkerSystem)
function module_upvr.Show(arg1) -- Line 106
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local Maid_upvr = module_upvr.Maid
    local ColorCorrection_upvr = module_upvr.ColorCorrection
    assert(ColorCorrection_upvr)
    local var61_upvw
    local any_new_result1_upvr = ScreenFade_upvr.new()
    local var63_upvw = 0
    local any_MakeCinematicCamera_result1_upvr = CinematicCamera_upvr.MakeCinematicCamera()
    local var65_upvw = 0
    local function UpdateCamera_upvr() -- Line 120, Named "UpdateCamera"
        var63_upvw += 1
        local var66 = ColorCorrection_upvr
        var66.TintColor = Color3.new(1, 1, 1)
        if RunUtils_upvr.isStudio() then
            var66 = var22_upvr
        else
            var66 = tbl_upvr
        end
        var65_upvw = var65_upvw % 3 + 1
        local var67 = var66["City"..var65_upvw.."_Start"]
        local var68 = var66["City"..var65_upvw.."_Stop"]
        local var69 = CFrame.new(Vector3.new(), var67.LookVector) + var67.p
        any_MakeCinematicCamera_result1_upvr.StartPosition = var69.p
        any_MakeCinematicCamera_result1_upvr.TargetPosition = (CFrame.new(Vector3.new(), var68.LookVector) + var68.p).p
        any_MakeCinematicCamera_result1_upvr.LookVector = var69.LookVector
        any_MakeCinematicCamera_result1_upvr.TargetLookVector = nil
    end
    local var70_upvw
    if arg1 == nil then
        var70_upvw = false
    else
        var70_upvw = true
    end
    local tick_result1_2_upvw = tick()
    Maid_upvr:GiveTask(RunService_upvr.RenderStepped:Connect(function(arg1_3) -- Line 142, Named "RenderStepped"
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        CurrentCamera_upvr.CameraType = Enum.CameraType.Scriptable
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end))
    UpdateCamera_upvr()
    local var78_upvw = false
    local function play_upvr() -- Line 172, Named "play"
        if var78_upvw then
        else
            if TeamShared_upvr.isTeamFull(var61_upvw) then
                var61_upvw = nil
                Notification_upvr.new({
                    Text = Localization_upvr:FormatByKey("Teams.TeamFull");
                })
                return
            end
            var78_upvw = true
            any_new_result1_upvr:FadeToLinear(0, 0.3)
            var25_upvw:FireServer('d'.."".."vwurcqv":sub(3, 3):reverse():reverse():reverse():reverse():reverse().."".."".."eug9g9uf":sub(4, 4):reverse():reverse():reverse().."".."".."zgcflrr":sub(3, 3):reverse().."".."".."u4um9g2":sub(5, 5):reverse():reverse():reverse().."".."n2f", var61_upvw)
            Maid_upvr:GiveTask(task.delay(2, function() -- Line 184
                any_new_result1_upvr:Set(1)
                var78_upvw = false
            end))
        end
    end
    local any_createRef_result1_upvr = Roact_upvr.createRef()
    local function getComponent_upvr() -- Line 192, Named "getComponent"
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local var90
        if EzUtils_upvr.isSmallScreen() then
        else
        end
        var90 = Teams_upvr:GetChildren()
        local children_upvr, NONE, NONE_3 = Teams_upvr:GetChildren()
        for _, v_2 in children_upvr, NONE, NONE_3 do
            if v_2.Name == "Police" then
            else
            end
        end
        if RunUtils_upvr.getPlaceType() ~= "Default" then
            children_upvr = false
        else
            children_upvr = true
        end
        if RunUtils_upvr.getPlaceType() ~= "VoiceChat" then
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        if RunUtils_upvr.getPlaceType() ~= "Pro" then
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        local var94_upvr = true
        local tbl = {}
        local tbl_4 = {}
        local function onClicked() -- Line 207
            local var97
            if children_upvr then
                var97 = "VoiceChat"
            else
                var97 = "Default"
            end
            local pcall_result1_2, pcall_result2 = pcall(function() -- Line 209
                return VoiceChatService_upvr:IsVoiceEnabledForUserIdAsync(Players_upvr.LocalPlayer.UserId)
            end)
            if children_upvr and not (pcall_result1_2 and pcall_result2) then
                Notification_upvr.new({
                    Text = "Enable voice chat to join voice chat servers!";
                })
            else
                ReplicatedStorage_upvr.TeamSelect:FindFirstChild(TeamSelectConsts_upvr.TELEPORT_PLACE_TYPE_REMOTE_NAME):FireServer(var97)
            end
        end
        tbl_4.onClicked = onClicked
        if children_upvr then
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        tbl_4.text = "MAIN SERVERS"
        local tbl_5 = {}
        local function onClicked() -- Line 225
            local var103
            if var94_upvr then
                var103 = "VoiceChat"
            else
                var103 = "Pro"
            end
            local pcall_result1, pcall_result2_2 = pcall(function() -- Line 227
                return VoiceChatService_upvr:IsVoiceEnabledForUserIdAsync(Players_upvr.LocalPlayer.UserId)
            end)
            if var94_upvr and not (pcall_result1 and pcall_result2_2) then
                Notification_upvr.new({
                    Text = "Enable voice chat to join voice chat servers!";
                })
            else
                if not var94_upvr and Players_upvr.LocalPlayer.AccountAge < 60 then
                    Notification_upvr.new({
                        Text = "Your account needs to be 60 days old to enter High Roller servers.";
                    })
                    return
                end
                if not var94_upvr and not Players_upvr.LocalPlayer:GetAttribute("ProServerAccess") then
                    Notification_upvr.new({
                        Text = "You need $5 million to enter High Roller servers!";
                    })
                    return
                end
                ReplicatedStorage_upvr.TeamSelect:FindFirstChild(TeamSelectConsts_upvr.TELEPORT_PLACE_TYPE_REMOTE_NAME):FireServer(var103)
            end
        end
        tbl_5.onClicked = onClicked
        if var94_upvr then
        else
        end
        tbl_5.text = "HIGH ROLLER SERVERS"
        local tbl_2 = {}
        local function onClicked() -- Line 252
            if not GamepassSystem_upvr.DoesPlayerOwn(GamepassUtils_upvr.EnumGamepass.TradingVIP) then
                GamepassUtils_upvr.PromptGamepass(GamepassUtils_upvr.EnumGamepass.TradingVIP)
            else
                ReplicatedStorage_upvr:FindFirstChild(WorldTeleportConsts_upvr.TELEPORT_TO_WORLD_FROM_TEAM_SWITCH_NAME):FireServer(RunConsts_upvr.TRADE_WORLD_NAME)
            end
        end
        tbl_2.onClicked = onClicked
        tbl_2.text = "TRADE WORLD"
        tbl[1] = tbl_4
        tbl[2] = tbl_5
        tbl[3] = tbl_2
        if workspace:GetServerTimeNow() < TeamSelectConsts_upvr.OG_JB_END_TIME then
            table.insert(tbl, 1, {
                onClicked = function() -- Line 267, Named "onClicked"
                    ReplicatedStorage_upvr.TeamSelect:FindFirstChild(TeamSelectConsts_upvr.TELEPORT_PLACE_TYPE_REMOTE_NAME):FireServer("Hang")
                end;
                text = "OG JAILBREAK";
                textColor = Color3.fromHex("e88839");
            })
        end
        local var112 = false
        local AllowCriminalSpawn = Players_upvr.LocalPlayer:GetAttribute("AllowCriminalSpawn")
        if AllowCriminalSpawn ~= nil then
            var112 = AllowCriminalSpawn
        end
        return createElement_upvr("ScreenGui", {
            IgnoreGuiInset = true;
            Enabled = var70_upvw;
        }, {
            TeamSelect = createElement_upvr(TeamSelect_upvr, {
                size = UDim2.fromScale(1, 1);
                numPolice = 0 + #v_2:GetPlayers();
                numCriminals = 0 + #v_2:GetPlayers();
                criminalButtonRef = any_createRef_result1_upvr;
                allowCriminal = var112;
                onTeamSelected = function(arg1_4) -- Line 293, Named "onTeamSelected"
                    var61_upvw = arg1_4
                    play_upvr()
                end;
                serverButtons = tbl;
            });
        })
    end
    local any_mount_result1_upvr = Roact_upvr.mount(getComponent_upvr(), Players_upvr.LocalPlayer.PlayerGui, "TeamSelectGui")
    if any_createRef_result1_upvr:getValue() then
        EzUtils_upvr.selectIfGamepad(any_createRef_result1_upvr:getValue())
    end
    Maid_upvr:GiveTask(function() -- Line 307
        Roact_upvr.unmount(any_mount_result1_upvr)
    end)
    local function update() -- Line 311
        Roact_upvr.update(any_mount_result1_upvr, getComponent_upvr())
    end
    for var129, var127 in Teams_upvr:GetChildren() do
        Maid_upvr:GiveTask(var127.PlayerAdded:Connect(update))
        Maid_upvr:GiveTask(var127.PlayerRemoved:Connect(update))
        local _
    end
    Maid_upvr:GiveTask(function() -- Line 320
        CurrentCamera_upvr.CameraType = Enum.CameraType.Custom
        local any_getHumanoid_result1 = CharacterUtils_upvr.getHumanoid(Players_upvr.LocalPlayer.Character)
        if any_getHumanoid_result1 then
            CurrentCamera_upvr.CameraSubject = any_getHumanoid_result1
        end
        any_new_result1_upvr:FadeToLinear(1, 0.3)
        task.delay(0.3, function() -- Line 327
            any_new_result1_upvr:Destroy()
        end)
    end)
    InventoryItemSystem_upvr.unequipAll()
    var27_upvw()
    var26_upvw.t6yqxhtu(true)
    Maid_upvr:GiveTask(function() -- Line 336
        ColorCorrection_upvr.TintColor = Color3.new(1, 1, 1)
    end)
    if not arg1 then
        var129 = 0.3
        any_new_result1_upvr:FadeToLinear(0, var129)
        var129 = 0.4
        function var127() -- Line 342
            var70_upvw = true
            Roact_upvr.update(any_mount_result1_upvr, getComponent_upvr())
            any_new_result1_upvr:FadeToLinear(1, 0.3)
        end
        Maid_upvr:GiveTask(task.delay(var129, var127))
    end
    local gui_upvr = WorldMarkerSystem_upvr.gui
    if gui_upvr then
        gui_upvr.Enabled = false
        function var129() -- Line 352
            gui_upvr.Enabled = true
        end
        Maid_upvr:GiveTask(var129)
    end
end
function module_upvr.Hide() -- Line 360
    module_upvr.Maid:DoCleaning()
end
return module_upvr