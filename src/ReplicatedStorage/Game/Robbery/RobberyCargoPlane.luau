local CollectionService_upvr = game:GetService("CollectionService")
local Players_upvr = game:GetService("Players")
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Signal_upvr = require(ReplicatedStorage_upvr.Std.Signal)
local Time_upvr = require(ReplicatedStorage_upvr.Module.Time)
local Joint_upvr = require(ReplicatedStorage_upvr.Std.Joint)
local Timeline_upvr = require(ReplicatedStorage_upvr.Module.Timeline)
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local CircleAction_upvr = require(ReplicatedStorage_upvr.Module.UI).CircleAction
local var11_upvw
local var12_upvw
local tbl_6_upvr = {
    alarm_siren_loop_01 = 4487202760;
    background_air_compressor_pump_loop_01 = 9058646197;
    prop_loop = 9058616635;
    hydraulic_strut_air_gas_shock_door_01 = 4487204926;
    collect_item_02 = 4487203151;
    truck_low_engine_rattle_loop = 9058628651;
    metal_sheet_impacts_01 = 4487205142;
    metal_sheet_impacts_02 = 4487205303;
    metal_sheet_impacts_03 = 4487205462;
    lever_sound = 1988476846;
}
local tbl_8_upvr = {tbl_6_upvr.metal_sheet_impacts_01, tbl_6_upvr.metal_sheet_impacts_02, tbl_6_upvr.metal_sheet_impacts_03}
local function _(arg1) -- Line 44, Named "Ease_InOutQuad"
    local var15
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var15 = 2 * arg1 * arg1
        return var15
    end
    if arg1 >= 0.5 or not decompInlinedCondition() then
        var15 = -1 - 2 * (arg1 - 2) * arg1
    end
    return var15
end
local function _(arg1) -- Line 47, Named "Ease_InOutSine"
    return (math.sin(math.pi * arg1 - (math.pi/2)) + 1) * 0.5
end
local function HideModel_upvr(arg1) -- Line 51, Named "HideModel"
    for _, v in ipairs(arg1:GetChildren()) do
        if v:IsA("BasePart") then
            v.Transparency = 1
            v.CanCollide = false
        end
        HideModel_upvr(v)
    end
end
local function ShowModel_upvr(arg1) -- Line 60, Named "ShowModel"
    for _, v_2 in ipairs(arg1:GetChildren()) do
        if v_2:IsA("BasePart") then
            v_2.Transparency = 0
            v_2.CanCollide = true
        end
        ShowModel_upvr(v_2)
    end
end
local function _() -- Line 70, Named "GetHumanoid"
    local Character_2 = LocalPlayer_upvr.Character
    if Character_2 == nil then
        return nil
    end
    return Character_2:FindFirstChild("Humanoid")
end
local function _() -- Line 78, Named "GetHRP"
    local Character_4 = LocalPlayer_upvr.Character
    local var28
    if Character_4 == nil then
        var28 = nil
    else
        var28 = Character_4:FindFirstChild("Humanoid")
    end
    if var28 == nil then
        return nil
    end
    return var28.RootPart
end
local tbl_18_upvr = {}
tbl_18_upvr.__index = tbl_18_upvr
local function new(arg1, arg2) -- Line 89
    assert(arg1)
    assert(arg1.PrimaryPart)
    assert(arg2)
    local setmetatable_result1_upvr_2 = setmetatable({}, tbl_18_upvr)
    setmetatable_result1_upvr_2.Model = arg1
    setmetatable_result1_upvr_2._leverMotor = Joint_upvr.Motor(arg1.PrimaryPart, arg2)
    setmetatable_result1_upvr_2.Length = arg1.PrimaryPart.Size.Z
    setmetatable_result1_upvr_2.OnSuccess = Signal_upvr.new()
    setmetatable_result1_upvr_2.OnFail = Signal_upvr.new()
    local function Action(arg1_2, arg2_2) -- Line 100
        if arg2_2 then
            setmetatable_result1_upvr_2.OnSuccess:Fire()
        end
        return true
    end
    local tbl_5 = {
        Part = arg1.PrimaryPart;
        Name = "Open Door";
        NoRay = true;
        Timed = true;
        Duration = 1;
        Dist = 8;
        Callback = Action;
    }
    CircleAction_upvr.Add(tbl_5, arg1.PrimaryPart)
    setmetatable_result1_upvr_2.Spec = tbl_5
    setmetatable_result1_upvr_2:Reset()
    return setmetatable_result1_upvr_2
end
tbl_18_upvr.new = new
function tbl_18_upvr.SetAngle(arg1, arg2) -- Line 121
    arg1._leverMotor.C1 = arg1._leverMotor.C0:Inverse() * CFrame.new(0, 0, arg1.Length * 0.5) * CFrame.Angles(arg2, 0, 0) * CFrame.new(0, 0, -arg1.Length * 0.5) * arg1._leverMotor.C0
end
function tbl_18_upvr.Reset(arg1) -- Line 128
    arg1:SetAngle(0.7853981633974483)
end
function tbl_18_upvr.Pull(arg1) -- Line 131
    arg1:SetAngle(-0.7853981633974483)
end
local function Destroy(arg1) -- Line 134
    arg1.OnSuccess:Destroy()
    arg1.OnSuccess = nil
    arg1.OnFail:Destroy()
    arg1.OnFail = nil
    arg1.Spec.Kill = true
    arg1.Spec = nil
end
tbl_18_upvr.Destroy = Destroy
local tbl_10_upvr = {}
local tbl_2_upvr = {}
local var34_upvw
local tbl_4_upvr = {}
tbl_4_upvr.__index = tbl_4_upvr
local RobberyCargoPlaneShared_upvr = require(ReplicatedStorage_upvr.Game.Robbery.RobberyCargoPlaneShared)
local RunService_upvr = game:GetService("RunService")
local DuffelBagUtils_upvr = require(ReplicatedStorage_upvr.Game.DuffelBag.DuffelBagUtils)
local RobberyConsts_upvr = require(ReplicatedStorage_upvr.Robbery.RobberyConsts)
local MinimapService_upvr = require(ReplicatedStorage_upvr.App.MinimapService)
function tbl_4_upvr.new(arg1) -- Line 157
    assert(arg1)
    local setmetatable_result1_upvr = setmetatable({}, tbl_4_upvr)
    setmetatable_result1_upvr.BornAt = arg1
    setmetatable_result1_upvr.IsPlayerInsidePlane = false
    setmetatable_result1_upvr.IsPlayerOnPlane = false
    setmetatable_result1_upvr.OnPlayerEnter = Signal_upvr.new()
    setmetatable_result1_upvr.OnPlayerLeave = Signal_upvr.new()
    local clone_upvr = ReplicatedStorage_upvr.Resource.RobberyCargoPlane.Plane:Clone()
    CollectionService_upvr:AddTag(clone_upvr.CargoPlane, "RobberyMarker")
    Joint_upvr.WeldAllTo(clone_upvr, clone_upvr.PrimaryPart, true)
    Joint_upvr.WeldAllTo(clone_upvr.ControlPanel, clone_upvr.PrimaryPart)
    Joint_upvr.WeldAllTo(clone_upvr.Crates, clone_upvr.PrimaryPart)
    Joint_upvr.WeldAllTo(clone_upvr.Model, clone_upvr.PrimaryPart)
    setmetatable_result1_upvr._topDoorMotor = Joint_upvr.Motor(clone_upvr.TopDoor.Part, clone_upvr.PrimaryPart)
    clone_upvr.TopDoor.Part.Anchored = false
    Joint_upvr.WeldAllTo(clone_upvr.BottomDoor.Door, clone_upvr.BottomDoor.Door.PrimaryPart)
    setmetatable_result1_upvr._bottomDoorMotor = Joint_upvr.Motor(clone_upvr.BottomDoor.Door.PrimaryPart, clone_upvr.PrimaryPart)
    Joint_upvr.WeldAllTo(clone_upvr.Lever, clone_upvr.Lever.PrimaryPart)
    clone_upvr.PrimaryPart.Anchored = true
    clone_upvr.Parent = workspace
    setmetatable_result1_upvr.Model = clone_upvr
    setmetatable_result1_upvr:SetupProps()
    setmetatable_result1_upvr.SoundEngineFlying = Audio_upvr.ObjectLocal(clone_upvr.Root, tbl_6_upvr.prop_loop, {
        Volume = 0;
        Looped = true;
        EmitterSize = 128;
        RollOffMaxDistance = 1536;
    })
    setmetatable_result1_upvr.SoundEngineIdle = Audio_upvr.ObjectLocal(clone_upvr.Root, tbl_6_upvr.truck_low_engine_rattle_loop, {
        Volume = 0;
        Looped = true;
        EmitterSize = 64;
        RollOffMaxDistance = 1536;
    })
    setmetatable_result1_upvr.SoundEngineBackground = Audio_upvr.ObjectLocal(clone_upvr.Root, tbl_6_upvr.background_air_compressor_pump_loop_01, {
        Volume = 0;
        Looped = true;
        EmitterSize = 64;
    })
    setmetatable_result1_upvr.SoundWind = Audio_upvr.ObjectLocal(clone_upvr.WindNode, 9058653424, {
        Volume = 0;
        Looped = true;
        EmitterSize = 64;
        RollOffMaxDistance = 1536;
    })
    setmetatable_result1_upvr.Lever = tbl_18_upvr.new(clone_upvr.Lever, clone_upvr.PrimaryPart)
    setmetatable_result1_upvr.Lever.OnSuccess:Connect(function() -- Line 208
        if setmetatable_result1_upvr.CargoOpenedAt ~= nil and Time_upvr.GetNowSync() - setmetatable_result1_upvr.CargoOpenedAt < setmetatable_result1_upvr.SeqsCargoDuration then
            return false
        end
        Audio_upvr.ObjectLocal(setmetatable_result1_upvr.Model.PrimaryPart, 700180643, {
            TimePosition = 1;
            MaxPlaybackTime = 0.6;
        })
        clone_upvr.ControlPanel.Light.Color = Color3.new(0, 1, 0)
        delay(0.1, function() -- Line 216
            clone_upvr.ControlPanel.Light.Color = Color3.fromRGB(196, 40, 28)
        end)
        var11_upvw:FireServer('l'.."".."uzcmhzxj":sub(3, 6):reverse():reverse():reverse():reverse():reverse().."".."".."y9idbp":sub(2, 2):reverse().."".."0l")
    end)
    setmetatable_result1_upvr.Lever.OnFail:Connect(function() -- Line 221
        var12_upvw.ropj1fju({
            Title = "CargoPlane";
            Text = "Keycard required. Search the crates...";
        })
        Audio_upvr.ObjectLocal(setmetatable_result1_upvr.Model.PrimaryPart, 700180643, {
            TimePosition = 0;
            MaxPlaybackTime = 0.6;
        })
        clone_upvr.ControlPanel.Light.Color = Color3.new(0, 0, 0)
        delay(0.1, function() -- Line 227
            clone_upvr.ControlPanel.Light.Color = Color3.fromRGB(196, 40, 28)
        end)
    end)
    setmetatable_result1_upvr.RealRoll = 0
    setmetatable_result1_upvr.RealDirection = clone_upvr.PrimaryPart.CFrame.LookVector
    setmetatable_result1_upvr.CargoOpenAmount = 0
    setmetatable_result1_upvr.ShouldDestroy = false
    local any_GetFlightData_result1 = RobberyCargoPlaneShared_upvr.GetFlightData()
    local PathEnter = any_GetFlightData_result1.PathEnter
    PathEnter.ApproxTotalLength = PathEnter:ApproximateLength(1000)
    setmetatable_result1_upvr.PathEnter = PathEnter
    local PathLeave_2 = any_GetFlightData_result1.PathLeave
    PathLeave_2.ApproxTotalLength = PathLeave_2:ApproximateLength(1000)
    setmetatable_result1_upvr.PathLeave = PathLeave_2
    local tbl_3 = {}
    local function SeqEnter(arg1_3) -- Line 250
        setmetatable_result1_upvr:SeqEnter(arg1_3)
    end
    tbl_3.SeqEnter = SeqEnter
    local function SeqCargoOpen(arg1_4) -- Line 253
        setmetatable_result1_upvr:SeqCargoOpen(arg1_4)
    end
    tbl_3.SeqCargoOpen = SeqCargoOpen
    local function SeqLoadCrates(arg1_5) -- Line 256
        setmetatable_result1_upvr:SeqLoadCrates(arg1_5)
    end
    tbl_3.SeqLoadCrates = SeqLoadCrates
    local function SeqCargoClose(arg1_6) -- Line 259
        setmetatable_result1_upvr:SeqCargoClose(arg1_6)
    end
    tbl_3.SeqCargoClose = SeqCargoClose
    local function SeqLeave(arg1_7) -- Line 262
        setmetatable_result1_upvr:SeqLeave(arg1_7)
    end
    tbl_3.SeqLeave = SeqLeave
    local function SeqHatchOpen(arg1_8) -- Line 265
        setmetatable_result1_upvr:SeqHatchOpen(arg1_8)
    end
    tbl_3.SeqHatchOpen = SeqHatchOpen
    local function SeqHatchClose(arg1_9) -- Line 268
        setmetatable_result1_upvr:SeqHatchClose(arg1_9)
    end
    tbl_3.SeqHatchClose = SeqHatchClose
    function tbl_3.SeqNone() -- Line 271
    end
    local tbl_15 = {}
    local var65
    for i_3 = var65, #any_GetFlightData_result1.SeqsLayout do
        local var66 = any_GetFlightData_result1.SeqsLayout[i_3]
        local _1 = var66[1]
        local var68 = tbl_3[_1]
        if var68 == nil then
            error("No seq function found for: ".._1)
        end
        table.insert(tbl_15, {var68, assert(var66[2])})
    end
    setmetatable_result1_upvr.mTimeline = Timeline_upvr.new(tbl_15)
    local tbl_13 = {}
    ;({})[1] = tbl_3.SeqCargoOpen
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    ;({})[2] = 2
    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
    tbl_13[1] = {}
    tbl_13[2] = {tbl_3.SeqNone, 4}
    tbl_13[3] = {tbl_3.SeqCargoClose, 3}
    setmetatable_result1_upvr.SeqsCargo = tbl_13
    setmetatable_result1_upvr.Tl_Cargo = nil
    setmetatable_result1_upvr.CargoOpenedAt = nil
    for _, v_3 in ipairs(tbl_13) do
    end
    setmetatable_result1_upvr.SeqsCargoDuration = 0 + v_3[2]
    setmetatable_result1_upvr.HeartbeatConn = RunService_upvr.Heartbeat:Connect(function(arg1_10) -- Line 301
        setmetatable_result1_upvr:Update(arg1_10)
    end)
    setmetatable_result1_upvr.SoundMusic = nil
    setmetatable_result1_upvr.OnPlayerEnter:Connect(function() -- Line 306
        if setmetatable_result1_upvr.SoundMusic then
            setmetatable_result1_upvr.SoundMusic:Destroy()
        end
        setmetatable_result1_upvr.SoundMusic = Audio_upvr.ObjectLocal(LocalPlayer_upvr.PlayerGui, 1837315896, {
            Looped = true;
            Volume = 1;
            GroupName = "RobberyMusic";
        })
        if LocalPlayer_upvr.Character then
            for _, v_4 in LocalPlayer_upvr.Character:QueryDescendants("BasePart") do
                v_4.CollisionGroup = "PlayersInTrain"
            end
        end
    end)
    setmetatable_result1_upvr.OnPlayerLeave:Connect(function(arg1_11) -- Line 321
        local SoundMusic_upvr = setmetatable_result1_upvr.SoundMusic
        if SoundMusic_upvr then
            setmetatable_result1_upvr.SoundMusic = nil
            Audio_upvr.promiseFadeTo(SoundMusic_upvr, 0, 1):finally(function() -- Line 326
                SoundMusic_upvr:Destroy()
            end):catch(warn)
        end
        local any_getBag_result1 = DuffelBagUtils_upvr.getBag(LocalPlayer_upvr)
        if not setmetatable_result1_upvr._setWaypoint and any_getBag_result1 and any_getBag_result1:GetRobbery() == RobberyConsts_upvr.ENUM_ROBBERY.CARGO_PLANE then
            setmetatable_result1_upvr._setWaypoint = true
            any_getBag_result1._maid:GiveTask(MinimapService_upvr.addWaypoint({
                position = Vector3.new(-346.24, 22.6660, 2057.05);
                name = "CargoPlaneCollect";
                priority = 1000;
                minDist = 0;
            }))
        end
        if not arg1_11 or arg1_11 and setmetatable_result1_upvr.IsPlayerInsidePlane or LocalPlayer_upvr.Character then
            for _, v_5 in LocalPlayer_upvr.Character:QueryDescendants("BasePart") do
                v_5.CollisionGroup = "Players"
            end
        end
    end)
    setmetatable_result1_upvr:SetupCrates()
    setmetatable_result1_upvr.Tl_Hatch = nil
    setmetatable_result1_upvr.HatchOpenedAt = nil
    setmetatable_result1_upvr.SeqsHatch = {{tbl_3.SeqHatchOpen, 0.5}, {tbl_3.SeqNone, 2}, {tbl_3.SeqHatchClose, 0.5}}
    setmetatable_result1_upvr:SetupHatch()
    return setmetatable_result1_upvr
end
local PlayerUtils_upvr = require(ReplicatedStorage_upvr.Game.PlayerUtils)
function tbl_4_upvr.SetupHatch(arg1) -- Line 363
    arg1.TopDoorModel = arg1.Model.TopDoor
    arg1._hatchOffset = arg1.TopDoorModel.Part.CFrame:ToObjectSpace(arg1.TopDoorModel.Open.CFrame)
    arg1.TopDoorModel.Open:Destroy()
    local function Action(arg1_12, arg2) -- Line 369
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if PlayerUtils_upvr.hasKey() == true then
            if arg2 then
                Audio_upvr.ObjectLocal(arg1.Model.PrimaryPart, 700180643, {
                    TimePosition = 1;
                    MaxPlaybackTime = 0.6;
                })
                var11_upvw:FireServer('o'.."".."gjvpe":sub(2, 2):reverse().."".."grzonj")
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
        else
            Audio_upvr.ObjectLocal(arg1.Model.PrimaryPart, 700180643, {
                TimePosition = 0;
                MaxPlaybackTime = 0.6;
            })
            return false
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        do
            return true
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
    local tbl_21 = {
        Part = arg1.TopDoorModel.Part;
        Name = "Open Door";
        NoRay = true;
        Timed = true;
        Duration = 5;
        Dist = 8;
        Callback = Action;
    }
    CircleAction_upvr.Add(tbl_21, arg1.TopDoorModel.Part)
    arg1.SpecHatch = tbl_21
end
function tbl_4_upvr.SeqHatchOpen(arg1, arg2) -- Line 395
    local Part = arg1.TopDoorModel.Part
    if arg2 == 0 then
        Audio_upvr.ObjectLocal(Part, 1791024087)
        Part.CanCollide = false
    end
    arg1._topDoorMotor.C1 = arg1._topDoorMotor.C0:Inverse() * CFrame.new():Lerp(arg1._hatchOffset, arg2) * arg1._topDoorMotor.C0
end
function tbl_4_upvr.SeqHatchClose(arg1, arg2) -- Line 405
    if arg2 == 0 then
        Audio_upvr.ObjectLocal(arg1.TopDoorModel.Part, 1791025004)
    elseif arg2 == 1 then
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        arg1.TopDoorModel.Part.CanCollide = true
    end
    arg1._topDoorMotor.C1 = arg1._topDoorMotor.C0:Inverse() * CFrame.new():Lerp(arg1._hatchOffset, 1 - arg2) * arg1._topDoorMotor.C0
end
function tbl_4_upvr.SetupCrates(arg1) -- Line 416
    local Crates = arg1.Model.Crates
    local tbl = {}
    for _, v_6 in next, Crates:GetChildren() do
        local tbl_22 = {
            Name = v_6.Name;
            Model = v_6;
        }
        tbl_22.Model.PrimaryPart = v_6['1']
        table.insert(tbl, tbl_22)
    end
    arg1.Crates = tbl
    HideModel_upvr(Crates)
end
function tbl_4_upvr.EnableCrates(arg1) -- Line 433
    arg1.CratesEnabled = true
    local function Action(arg1_13, arg2) -- Line 435
        if arg2 then
            var11_upvw:FireServer('q'.."".."kpcayb2wwgi":sub(4, 7):reverse().."".."goe", arg1_13.Part.Parent.Name)
        end
        return true
    end
    for _, v_7 in ipairs(arg1.Crates) do
        local PrimaryPart_2 = v_7.Model.PrimaryPart
        local tbl_12 = {
            Part = PrimaryPart_2;
            Name = "Inspect Crate";
            NoRay = true;
            Timed = true;
            Duration = 10;
            Dist = 8;
            Callback = Action;
        }
        CircleAction_upvr.Add(tbl_12, PrimaryPart_2)
        v_7.Spec = tbl_12
    end
end
function tbl_4_upvr.SetupProps(arg1) -- Line 456
    local Model = arg1.Model
    local PrimaryPart = Model.PrimaryPart
    local tbl_19 = {}
    for _, v_8 in next, Model.Props:GetChildren() do
        local tbl_9 = {}
        local Prop = v_8.Prop
        tbl_9.PartProp = Prop
        tbl_9.PartDisc = v_8.Disc
        tbl_9.Rotation = math.random()
        Joint_upvr.WeldAllTo(v_8, Prop)
        tbl_9._motor = Joint_upvr.Motor(Prop, PrimaryPart)
        table.insert(tbl_19, tbl_9)
    end
    arg1.Props = tbl_19
end
function tbl_4_upvr.StepProps(arg1, arg2) -- Line 477
    for _, v_9 in ipairs(arg1.Props) do
        local Rotation = v_9.Rotation
        v_9._motor.C1 = v_9._motor.C0:Inverse() * CFrame.Angles(0, 0, Rotation) * v_9._motor.C0
        v_9.PartDisc.Transparency = (1 - math.clamp(arg2, 0, 1)) * 0.30000000000000004 + 0.7
        v_9.Rotation = Rotation + arg2
    end
end
local RayCast_upvr = require(ReplicatedStorage_upvr.Module.RayCast)
local ChangePositionReplication_upvr = ReplicatedStorage_upvr:FindFirstChild("ChangePositionReplication")
local CurrentCamera_upvr = workspace.CurrentCamera
local UnsafePositionReplication_upvr = ReplicatedStorage_upvr:FindFirstChild("UnsafePositionReplication")
local os_clock_result1_upvw = os.clock()
local zero_cframe_upvw = CFrame.new()
function tbl_4_upvr.Update(arg1, arg2) -- Line 486
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    debug.profilebegin("CargoPlane Update")
    local any_GetNowSync_result1_2 = Time_upvr.GetNowSync()
    local profilebegin = debug.profilebegin
    profilebegin("PlayerInPlane")
    local Character_10 = LocalPlayer_upvr.Character
    local var247
    if Character_10 == nil then
        profilebegin = nil
    else
        profilebegin = Character_10:FindFirstChild("Humanoid")
    end
    if profilebegin and profilebegin.RootPart then
        local tbl_17 = {workspace.Items}
        local Rain = workspace:FindFirstChild("Rain")
        local var250
        if Rain ~= nil then
            table.insert(tbl_17, Rain)
        end
        for _, v_10 in ipairs(Players_upvr:GetPlayers()) do
            local Character_6 = v_10.Character
            if Character_6 then
                table.insert(tbl_17, Character_6)
            end
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        local CFrame_3 = profilebegin.RootPart.CFrame
        local any_RayIgnoreNonCollideWithIgnoreList_result1_2 = RayCast_upvr.RayIgnoreNonCollideWithIgnoreList(CFrame_3.p, -CFrame_3.UpVector, 24, tbl_17, true)
        if any_RayIgnoreNonCollideWithIgnoreList_result1_2 and any_RayIgnoreNonCollideWithIgnoreList_result1_2:IsDescendantOf(arg1.Model) then
            var250 = true
        end
        if var250 then
            local any_RayIgnoreNonCollideWithIgnoreList_result1_4 = RayCast_upvr.RayIgnoreNonCollideWithIgnoreList(CFrame_3.p, CFrame_3.UpVector, 24, tbl_17, true)
            if any_RayIgnoreNonCollideWithIgnoreList_result1_4 and any_RayIgnoreNonCollideWithIgnoreList_result1_4:IsDescendantOf(arg1.Model) then
                var247 = true
            end
        end
    end
    debug.profileend()
    if var247 == true and arg1.IsPlayerInsidePlane == false then
        arg1.IsPlayerInsidePlane = var247
        arg1.OnPlayerEnter:Fire()
    elseif var247 == false and arg1.IsPlayerInsidePlane == true then
        arg1.IsPlayerInsidePlane = var247
        arg1.OnPlayerLeave:Fire()
    end
    if var250 == true and arg1.IsPlayerOnPlane == false then
        arg1.IsPlayerOnPlane = var250
    elseif var250 == false and arg1.IsPlayerOnPlane == true then
        arg1.IsPlayerOnPlane = var250
        ChangePositionReplication_upvr:FireServer(nil, false)
    end
    local Root_2 = arg1.Model.Root
    local CFrame_6 = Root_2.CFrame
    debug.profilebegin("Timeline Update")
    if arg1.mTimeline and arg1.mTimeline:Update(any_GetNowSync_result1_2 - arg1.BornAt) then
        arg1.mTimeline = nil
    end
    debug.profileend()
    local CFrame_4 = Root_2.CFrame
    local Magnitude = (CFrame_4.p - CFrame_6.p).Magnitude
    debug.profilebegin("Step Props")
    arg1:StepProps(Magnitude * 0.2)
    debug.profileend()
    local var262
    if var250 then
        local var263 = CFrame_4 * CFrame_6:Inverse()
        if 0.01 < Magnitude then
            var262 = 0.0001
            if var262 < arg1.CargoOpenAmount then
                var262 = (arg1.Model.WindNode.Position - CFrame_4.p).Unit * 0.3 * arg2
                var263 += var262 * 60
            end
        end
        local Character_3 = LocalPlayer_upvr.Character
        if Character_3 == nil then
            var262 = nil
        else
            var262 = Character_3:FindFirstChild("Humanoid")
        end
        if var262 == nil then
            local _
        else
        end
        var262 = var263 * var262.RootPart.CFrame
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        var262.RootPart.CFrame = var262
        var262 = CurrentCamera_upvr
        var262 = var262.CFrame:ToObjectSpace(CurrentCamera_upvr.Focus)
        CurrentCamera_upvr.CFrame = CurrentCamera_upvr.CFrame * var262 * (var263 - var263.p) * var262:Inverse()
        local function decompInlinedCondition_4() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            local any_ToObjectSpace_result1_2 = CFrame_4:ToObjectSpace(var262.RootPart.CFrame)
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            return zero_cframe_upvw
        end
        if UnsafePositionReplication_upvr and 0.2 < os.clock() - os_clock_result1_upvw and (not decompInlinedCondition_4() or not any_ToObjectSpace_result1_2:FuzzyEq(zero_cframe_upvw)) then
            os_clock_result1_upvw = os.clock()
            UnsafePositionReplication_upvr:FireServer("Plane", nil, any_ToObjectSpace_result1_2)
            zero_cframe_upvw = any_ToObjectSpace_result1_2
        end
        for _, v_11 in tbl_2_upvr do
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            if var262.RootPart.Parent ~= v_11 and v_11.PrimaryPart and v_11:GetAttribute("PlaneOffset") then
                local var267 = tbl_10_upvr[v_11]
                if not var267 then
                    var267 = {
                        LastOffset = CFrame_4:ToObjectSpace(v_11.PrimaryPart.CFrame);
                    }
                    tbl_10_upvr[v_11] = var267
                end
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                local any_Lerp_result1 = var267.LastOffset:Lerp(v_11:GetAttribute("PlaneOffset"), 1 - math.exp(-5 * arg2))
                var267.LastOffset = any_Lerp_result1
                v_11.PrimaryPart.CFrame = CFrame_4 * any_Lerp_result1
            end
        end
    end
    if arg1.CargoOpenedAt ~= nil then
        local var270 = any_GetNowSync_result1_2 - arg1.CargoOpenedAt
        if arg1.Tl_Cargo == nil then
            if var270 < arg1.SeqsCargoDuration - 0.01 then
                arg1.Tl_Cargo = Timeline_upvr.new(arg1.SeqsCargo)
                var262 = 1
                Audio_upvr.FadeTo(arg1.SoundWind, var262, 0.5)
            end
        end
        if arg1.Tl_Cargo ~= nil then
            var262 = var270
            if arg1.Tl_Cargo:Update(var262) == true then
                arg1.Tl_Cargo = nil
                var262 = arg1.SoundWind
                Audio_upvr.FadeTo(var262, 0, 0.5)
            end
        end
    end
    if arg1.Tl_Hatch ~= nil then
        var262 = any_GetNowSync_result1_2 - arg1.HatchOpenedAt
        if arg1.Tl_Hatch:Update(var262) == true then
            arg1.Tl_Hatch = nil
        end
    end
    debug.profileend()
    if arg1.ShouldDestroy then
        task.defer(arg1.Destroy, arg1)
    end
end
function tbl_4_upvr.StepRoll(arg1, arg2, arg3) -- Line 635
    if arg2 ~= arg2 then
    end
    local RealRoll = arg1.RealRoll
    local var272 = RealRoll + (0 - RealRoll) * arg3
    arg1.RealRoll = var272
    return var272
end
function tbl_4_upvr.StepDirection(arg1, arg2) -- Line 644
    local RealDirection = arg1.RealDirection
    if arg2.Magnitude <= 0.001 then
        return RealDirection
    end
    local var274 = RealDirection + (arg2 - RealDirection) * 0.1
    arg1.RealDirection = var274
    return var274
end
function tbl_4_upvr.SeqEnter(arg1, arg2) -- Line 653
    if arg2 == 0 then
        Audio_upvr.FadeTo(arg1.SoundEngineFlying, 0.75, 0.1)
    elseif arg2 == 1 then
        Audio_upvr.FadeTo(arg1.SoundEngineFlying, 0, 1)
        Audio_upvr.FadeTo(arg1.SoundEngineIdle, 0.6, 1)
    end
    local var275 = (math.sin(math.pi * arg2 - (math.pi/2)) + 1) * 0.5
    local Model_3 = arg1.Model
    local PathEnter_2 = arg1.PathEnter
    local any_GetWorldPositionAt_result1, any_GetWorldPositionAt_result2 = PathEnter_2:GetWorldPositionAt(PathEnter_2.ApproxTotalLength * var275)
    if 0.8 < var275 then
    else
    end
    if 0.8 < var275 then
    else
    end
    Model_3.PrimaryPart.CFrame = CFrame.new(any_GetWorldPositionAt_result1, any_GetWorldPositionAt_result1 + arg1:StepDirection(any_GetWorldPositionAt_result2)) * CFrame.Angles(0, 0, arg1:StepRoll(math.acos(Model_3.PrimaryPart.CFrame.LookVector:Dot(any_GetWorldPositionAt_result2.Unit)) * 5, 0.01))
end
function tbl_4_upvr.SeqLeave(arg1, arg2) -- Line 670
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    if arg2 == 0 then
        Audio_upvr.FadeTo(arg1.SoundEngineIdle, 0, 1)
        Audio_upvr.FadeTo(arg1.SoundEngineFlying, 0.75, 1)
        Audio_upvr.FadeTo(arg1.SoundEngineBackground, 0.6, 1)
    end
    local var280
    if 0.2 < arg2 and not arg1.CratesEnabled then
        arg1:EnableCrates()
    end
    local var281 = (math.sin(math.pi * arg2 - (math.pi/2)) + 1) * 0.5
    local Model_2 = arg1.Model
    local PathLeave = arg1.PathLeave
    local any_GetWorldPositionAt_result1_2, any_GetWorldPositionAt_result2_2 = PathLeave:GetWorldPositionAt(PathLeave.ApproxTotalLength * var281)
    if 0 < any_GetWorldPositionAt_result2_2.Magnitude then
        arg1.Direction = any_GetWorldPositionAt_result2_2
    end
    if var281 < 0.2 then
        var280 = 0
    else
        var280 = math.acos(Model_2.PrimaryPart.CFrame.LookVector:Dot(any_GetWorldPositionAt_result2_2.Unit)) * 5
    end
    if var281 < 0.2 then
    else
    end
    var280 = CFrame.new(any_GetWorldPositionAt_result1_2, any_GetWorldPositionAt_result1_2 + arg1:StepDirection(any_GetWorldPositionAt_result2_2)) * CFrame.Angles(0, 0, arg1:StepRoll(var280, 0.01))
    Model_2.PrimaryPart.CFrame = var280
    if var281 == 1 then
        arg1.ShouldDestroy = true
    end
end
function tbl_4_upvr.SeqLoadCrates(arg1, arg2) -- Line 695
    for i_13 = 1, math.floor(arg2 * (#arg1.Crates - 1)) + 1 do
        local var287 = arg1.Crates[i_13]
        if not var287.HasLoaded then
            var287.HasLoaded = true
            ShowModel_upvr(var287.Model)
        end
    end
    if arg2 == 1 then
        i_13 = arg1.Model
        ShowModel_upvr(i_13.Crates)
    end
end
function tbl_4_upvr.SeqCargoOpen(arg1, arg2) -- Line 709
    local var288
    if arg2 == 0 then
        var288 = Audio_upvr
        var288 = var288.ObjectLocal
        var288(arg1.Model.BottomDoor.Door.PrimaryPart, tbl_6_upvr.hydraulic_strut_air_gas_shock_door_01)
        var288 = Audio_upvr
        var288 = var288.ObjectLocal
        var288(var34_upvw.Lever.Model.PrimaryPart, tbl_6_upvr.lever_sound)
        var288 = arg1.Lever:Pull
        var288()
    end
    local function decompInlinedCondition_5() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var288 = 2 * arg2 * arg2
        return var288
    end
    if arg2 >= 0.5 or not decompInlinedCondition_5() then
        var288 = -1 - 2 * (arg2 - 2) * arg2
    end
    arg1._bottomDoorMotor.C1 = arg1._bottomDoorMotor.C0:Inverse() * CFrame.Angles(0, 0, -var288 * math.pi * 0.15) * arg1._bottomDoorMotor.C0
    arg1.CargoOpenAmount = arg2
end
function tbl_4_upvr.SeqCargoClose(arg1, arg2) -- Line 724
    local var289
    if arg2 == 0 then
        var289 = Audio_upvr
        var289 = var289.ObjectLocal
        var289(arg1.Model.BottomDoor.Door.PrimaryPart, tbl_6_upvr.hydraulic_strut_air_gas_shock_door_01)
        var289 = Audio_upvr
        var289 = var289.ObjectLocal
        var289(var34_upvw.Lever.Model.PrimaryPart, tbl_6_upvr.lever_sound)
        var289 = arg1.Lever:Reset
        var289()
    elseif arg2 == 1 then
        var289 = nil
        arg1.CargoOpenedAt = var289
    end
    local var290 = 1 - arg2
    local function decompInlinedCondition_6() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var289 = 2 * var290 * var290
        return var289
    end
    if var290 >= 0.5 or not decompInlinedCondition_6() then
        var289 = -1 - 2 * (var290 - 2) * var290
    end
    arg1._bottomDoorMotor.C1 = arg1._bottomDoorMotor.C0:Inverse() * CFrame.Angles(0, 0, -var289 * math.pi * 0.15) * arg1._bottomDoorMotor.C0
    arg1.CargoOpenAmount = 1 - arg2
end
function tbl_4_upvr.Destroy(arg1) -- Line 740
    arg1.HeartbeatConn:Disconnect()
    arg1.HeartbeatConn = nil
    if arg1.Crates ~= nil then
        for i_14 = 1, #arg1.Crates do
            local var292 = arg1.Crates[i_14]
            if var292.Spec then
                var292.Spec.Kill = true
            end
        end
        arg1.Crates = nil
    end
    arg1.OnPlayerEnter:Destroy()
    arg1.OnPlayerEnter = nil
    arg1.OnPlayerLeave:Fire(true)
    arg1.OnPlayerLeave:Destroy()
    arg1.OnPlayerLeave = nil
    arg1.SoundEngineFlying:Destroy()
    arg1.SoundEngineFlying = nil
    arg1.SoundEngineIdle:Destroy()
    arg1.SoundEngineIdle = nil
    arg1.SoundEngineBackground:Destroy()
    arg1.SoundEngineBackground = nil
    arg1.SoundWind:Destroy()
    arg1.SoundWind = nil
    arg1.Lever:Destroy()
    arg1.Lever = nil
    arg1.SpecHatch.Kill = true
    arg1.SpecHatch = nil
    arg1.Model:Destroy()
    arg1.Model = nil
    var34_upvw = nil
    setmetatable(arg1, nil)
end
local var293_upvw
return {
    Init = function(arg1) -- Line 783, Named "Init"
        var11_upvw = arg1.Event
        var12_upvw = arg1.em
        var293_upvw = arg1.Team
        local random_state_upvr = Random.new()
        function var12_upvw.hlg3oa41(arg1_14) -- Line 789
            if not arg1_14 then
                if var34_upvw then
                    var34_upvw:Destroy()
                    var34_upvw = nil
                end
            else
                if var34_upvw == nil then
                    var34_upvw = tbl_4_upvr.new(arg1_14.BornAt)
                end
                var34_upvw.BornAt = arg1_14.BornAt
                if arg1_14.CargoOpenedAt ~= nil and var34_upvw.CargoOpenedAt ~= arg1_14.CargoOpenedAt then
                    var34_upvw.CargoOpenedAt = arg1_14.CargoOpenedAt
                end
                if arg1_14.CrateNamesTaken ~= nil then
                    for _, v_13 in ipairs(arg1_14.CrateNamesTaken) do
                        ({})[v_13] = true
                        local var307
                    end
                    for i_17 = #var34_upvw.Crates, 1, -1 do
                        local var308 = var34_upvw.Crates[i_17]
                        if var307[var308.Name] then
                            if var308.Spec then
                                var308.Spec.Kill = true
                            end
                            HideModel_upvr(var308.Model)
                            Audio_upvr.ObjectLocal(var308.Model:GetChildren()[1], tbl_8_upvr[random_state_upvr:NextInteger(1, #tbl_8_upvr)], {
                                Volume = 1;
                            })
                            table.remove(var34_upvw.Crates, i_17)
                        end
                    end
                end
            end
        end
        function var12_upvw.ojgrzonj() -- Line 828
            if var34_upvw == nil then
                error("No running plane to open hatch of.")
                return false
            end
            var34_upvw.HatchOpenedAt = Time_upvr.GetNowSync()
            var34_upvw.Tl_Hatch = Timeline_upvr.new(var34_upvw.SeqsHatch)
        end
        for _, v_12 in CollectionService_upvr:GetTagged("ReplicateCharacterPlane") do
            table.insert(tbl_2_upvr, v_12)
        end
        local tbl_11_upvr = {}
        CollectionService_upvr:GetInstanceAddedSignal("ReplicateCharacterPlane"):Connect(function(arg1_15) -- Line 841
            table.insert(tbl_2_upvr, arg1_15)
            if tbl_11_upvr[arg1_15] then
                task.cancel(tbl_11_upvr[arg1_15])
                tbl_11_upvr[arg1_15] = nil
            end
        end)
        CollectionService_upvr:GetInstanceRemovedSignal("ReplicateCharacterPlane"):Connect(function(arg1_16) -- Line 850
            table.remove(tbl_2_upvr, table.find(tbl_2_upvr, arg1_16))
            if tbl_11_upvr[arg1_16] then
                task.cancel(tbl_11_upvr[arg1_16])
            end
            tbl_11_upvr[arg1_16] = task.delay(2, function() -- Line 860
                tbl_10_upvr[arg1_16] = nil
                tbl_11_upvr[arg1_16] = nil
            end)
        end)
    end;
}