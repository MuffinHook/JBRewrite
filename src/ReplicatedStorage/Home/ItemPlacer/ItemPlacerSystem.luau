local Players_upvr = game:GetService("Players")
local UserInputService_upvr = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Signal = require(ReplicatedStorage.Std.Signal)
local HomeItemBinder_upvr = require(ReplicatedStorage.Home.HomeItem.HomeItemBinder)
local ItemPlacerUtils_upvr = require(script.Parent.ItemPlacerUtils)
local HomeSystem_upvr = require(script.Parent.Parent.HomeSystem)
local HomeItemSystem_upvr = require(ReplicatedStorage.Home.HomeItem.HomeItemSystem)
local homeStore_upvr = require(ReplicatedStorage.Home.homeStore)
local Roact_upvr = require(ReplicatedStorage.Roact)
local function getClosestVecDual_upvr(arg1, arg2) -- Line 25, Named "getClosestVecDual"
    local var16
    for _, v in arg1 do
        local any_Dot_result1 = v:Dot(arg2)
        local var18 = any_Dot_result1
        if (-math.huge) < math.abs(var18) then
            if 0 < any_Dot_result1 then
                var18 = 1
            else
                var18 = -1
            end
        end
    end
    return nil
end
local function rotBtwnUnit_upvr(arg1, arg2) -- Line 39, Named "rotBtwnUnit"
    local any_Cross_result1 = arg1:Cross(arg2)
    local any_Dot_result1_2 = arg1:Dot(arg2)
    if any_Dot_result1_2 < -0.999 then
        return CFrame.Angles(math.pi, 0, 0)
    end
    return CFrame.new(0, 0, 0, any_Cross_result1.x, any_Cross_result1.y, any_Cross_result1.z, any_Dot_result1_2 + 1)
end
local function _(arg1, arg2) -- Line 48, Named "roundN"
    return math.floor(arg1 / arg2 + 0.5) * arg2
end
local module_upvr = {
    _maid = nil;
    _lastDragStart = 0;
    _lastDragEnd = 0;
    _currentHomeItem = nil;
    onDragStarted = Signal.new();
    onDragEnded = Signal.new();
}
function module_upvr.init() -- Line 60
    local any_new_result1_upvr_4 = Maid_upvr.new()
    module_upvr._maid = any_new_result1_upvr_4
    local tbl_upvr_2 = {}
    HomeItemSystem_upvr.onCustomizeStarted:Connect(function() -- Line 66
        local function inputBegan(arg1, arg2) -- Line 67
            local var30 = false
            if arg1.UserInputType == Enum.UserInputType.Gamepad1 then
                if arg1.KeyCode ~= Enum.KeyCode.ButtonA then
                    var30 = false
                else
                    var30 = true
                end
            end
            if arg2 and not var30 then
            elseif arg1.UserInputType == Enum.UserInputType.MouseButton1 or arg1.UserInputType == Enum.UserInputType.Touch or var30 then
                if module_upvr.isDragging() then return end
                if module_upvr.getTimeSinceLastDragEnd() < 0.1 then return end
                if not HomeSystem_upvr.queryCurrentStandingHome() then return end
                local any_raycastMouse_result1 = ItemPlacerUtils_upvr.raycastMouse(tbl_upvr_2, true)
                if any_raycastMouse_result1 then
                    for _, v_4 in ipairs(HomeItemBinder_upvr:GetAll()) do
                        if any_raycastMouse_result1.Instance:IsDescendantOf(v_4:GetObj()) then
                            module_upvr.startDrag(v_4)
                            return
                        end
                    end
                end
            end
        end
        any_new_result1_upvr_4._listenForCustomizeTouch = UserInputService_upvr.TouchTap:Connect(inputBegan)
        any_new_result1_upvr_4._listenForCustomizeClick = UserInputService_upvr.InputBegan:Connect(inputBegan)
    end)
    HomeItemSystem_upvr.onCustomizeEnded:Connect(function() -- Line 115
        any_new_result1_upvr_4._listenForCustomizeClick = nil
        any_new_result1_upvr_4._listenForCustomizeTouch = nil
        if module_upvr.isDragging() then
            module_upvr.stopDrag()
        end
    end)
    HomeSystem_upvr.onExited:Connect(function() -- Line 123
        any_new_result1_upvr_4._listenForCustomizeClick = nil
        any_new_result1_upvr_4._listenForCustomizeTouch = nil
        if module_upvr.isDragging() then
            module_upvr.stopDrag()
        end
    end)
    HomeItemSystem_upvr.onAttemptPlaceItem:Connect(function(arg1) -- Line 131
        module_upvr.createAndDrag(arg1.name)
    end)
    HomeItemSystem_upvr.onAttemptDeleteItem:Connect(function() -- Line 136
        module_upvr.attemptDeleteCurrentHomeItem()
    end)
end
function module_upvr.getTargetPosition(arg1) -- Line 142
    local any_raycastMouse_result1_2 = ItemPlacerUtils_upvr.raycastMouse(arg1)
    if any_raycastMouse_result1_2 then
        local Instance = any_raycastMouse_result1_2.Instance
        local any_PointToObjectSpace_result1 = Instance.CFrame:PointToObjectSpace(any_raycastMouse_result1_2.Position)
        return Instance.CFrame:PointToWorldSpace(Vector3.new(math.floor(any_PointToObjectSpace_result1.x / 0.1 + 0.5) * 0.1, any_PointToObjectSpace_result1.y, math.floor(any_PointToObjectSpace_result1.z / 0.1 + 0.5) * 0.1)), any_raycastMouse_result1_2.Normal, Instance.CFrame
    end
end
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local Spring_upvr = require(ReplicatedStorage.Std.Spring)
local createElement_upvr = Roact_upvr.createElement
local PlacerApp_upvr = require(ReplicatedStorage.Home.UI.PlacerApp)
local RunService_upvr = game:GetService("RunService")
local InputUtils_upvr = require(ReplicatedStorage.Std.InputUtils)
function module_upvr.startDrag(arg1) -- Line 157
    module_upvr._lastDragStart = os.clock()
    local PrimaryPart = arg1:GetObj().PrimaryPart
    local any_UntranslateCf_result1_upvr = arg1:UntranslateCf(PrimaryPart.CFrame)
    local any_new_result1_upvr = Maid_upvr.new()
    module_upvr._maid.placeMaid = any_new_result1_upvr
    module_upvr._currentHomeItem = arg1
    any_new_result1_upvr:GiveTask(function() -- Line 167
        module_upvr._currentHomeItem = nil
    end)
    arg1:SetBeingDragged(true)
    any_new_result1_upvr:GiveTask(function() -- Line 171
        arg1:SetBeingDragged(false)
    end)
    homeStore_upvr:dispatch({
        type = "setVisible";
        value = false;
    })
    any_new_result1_upvr:GiveTask(function() -- Line 180
        homeStore_upvr:dispatch({
            type = "setVisible";
            value = true;
        })
    end)
    local var60_upvw = false
    any_new_result1_upvr:GiveTask(function() -- Line 188
        if not var60_upvw then
            if arg1._obj then
                arg1._obj:SetPrimaryPartCFrame(arg1:TranslateCf(any_UntranslateCf_result1_upvr))
            end
            if not arg1:IsPlaced() then
                arg1:AttemptDelete()
            end
        end
    end)
    arg1:CacheSurfaces()
    any_new_result1_upvr:GiveTask(function() -- Line 201
        arg1:ClearCacheSurfaces()
    end)
    for _, v_2 in ipairs(arg1:GetObj():GetDescendants()) do
        if v_2:IsA("BasePart") and v_2.CanCollide then
            table.insert({}, v_2)
            v_2.CanCollide = false
        end
    end
    local tbl_upvr = {}
    any_new_result1_upvr:GiveTask(function() -- Line 221
        for _, v_3 in ipairs(tbl_upvr) do
            v_3.CanCollide = true
        end
    end)
    local Humanoid_upvr = LocalPlayer_upvr.Character:FindFirstChild("Humanoid")
    any_new_result1_upvr:GiveTask(Humanoid_upvr.Changed:connect(function() -- Line 232
        Humanoid_upvr.Jump = false
    end))
    if Humanoid_upvr.SeatPart then
        Humanoid_upvr:ChangeState(Enum.HumanoidStateType.Jumping)
    end
    Humanoid_upvr:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    any_new_result1_upvr:GiveTask(function() -- Line 239
        Humanoid_upvr:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
    end)
    local Part_upvr = Instance.new("Part")
    Part_upvr.Color = Color3.new(1, 0, 0)
    Part_upvr.Anchored = true
    Part_upvr.CanCollide = false
    Part_upvr.TopSurface = 0
    Part_upvr.BottomSurface = 0
    Part_upvr.Size = PrimaryPart.Size + Vector3.new(0.10000, 0.10000, 0.10000)
    Part_upvr.CFrame = PrimaryPart.CFrame
    Part_upvr.Transparency = 1
    Part_upvr.Parent = arg1:GetObj()
    any_new_result1_upvr:GiveTask(Part_upvr)
    local tbl_upvr_3 = {arg1:GetObj(), LocalPlayer_upvr.Character}
    local var78 = any_UntranslateCf_result1_upvr
    var78 -= var78.p
    local var79_upvw = var78
    local _, any_getTargetPosition_result2_2, any_getTargetPosition_result3 = module_upvr.getTargetPosition(tbl_upvr_3)
    local UpVector_upvw = var79_upvw.UpVector
    if any_getTargetPosition_result2_2:Dot(UpVector_upvw) < 0.99 then
        var79_upvw = rotBtwnUnit_upvr(UpVector_upvw, any_getTargetPosition_result2_2) * var79_upvw
        UpVector_upvw = any_getTargetPosition_result2_2
    end
    local any__alignMat_result1 = module_upvr._alignMat(any_getTargetPosition_result2_2, any_getTargetPosition_result3, var79_upvw)
    local _, any_ToOrientation_result2_upvw, _ = any__alignMat_result1:Inverse() * any_UntranslateCf_result1_upvr:ToOrientation()
    local p = any_UntranslateCf_result1_upvr.p
    local any_new_result1_upvr_7 = Spring_upvr.new(any_ToOrientation_result2_upvw, 0, 0.8, 30)
    local var90_upvw = 0
    local function doRotate_upvr(arg1_2, arg2, arg3) -- Line 277, Named "doRotate"
        local os_clock_result1 = os.clock()
        local var92 = os_clock_result1 - arg3
        local var93
        if 0.1 < var92 then
            var93 = math.min(12, var92 / 0.1 + 1)
        else
            var93 = 1
        end
        if os_clock_result1 - var90_upvw < 0.1 then
        else
            var90_upvw = os_clock_result1
            if arg1_2 then
                any_ToOrientation_result2_upvw += 0.08726646259971647 * var93
            elseif arg2 then
                any_ToOrientation_result2_upvw -= 0.08726646259971647 * var93
            end
            any_ToOrientation_result2_upvw = math.floor(any_ToOrientation_result2_upvw / 0.08726646259971647 + 0.5) * 0.08726646259971647
            any_new_result1_upvr_7:SetTarget(any_ToOrientation_result2_upvw)
        end
    end
    local function attemptPlaceCurrentHomeItem_upvr() -- Line 295, Named "attemptPlaceCurrentHomeItem"
        module_upvr._maid.listenForFeedback = arg1._placeRemote.OnClientEvent:Connect(function(arg1_3) -- Line 296
            module_upvr._maid.listenForFeedback = nil
            if not arg1_3 and arg1._obj then
                arg1._obj:SetPrimaryPartCFrame(arg1:TranslateCf(any_UntranslateCf_result1_upvr))
            end
        end)
        local any_getTargetPosition_result1, any_getTargetPosition_result2_3, any_getTargetPosition_result3_3 = module_upvr.getTargetPosition(tbl_upvr_3)
        arg1:SetServerCFrame(arg1:TranslateCf(module_upvr._alignMat(any_getTargetPosition_result2_3, any_getTargetPosition_result3_3, var79_upvw) * CFrame.Angles(0, any_ToOrientation_result2_upvw, 0) + any_getTargetPosition_result1))
        var60_upvw = true
        module_upvr.stopDrag()
    end
    local any_mount_result1_upvr = Roact_upvr.mount(createElement_upvr("ScreenGui", {
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        ResetOnSpawn = false;
        IgnoreGuiInset = true;
        DisplayOrder = 1;
    }, {
        PlacerContainer = createElement_upvr("Frame", {
            BackgroundTransparency = 1;
            Size = UDim2.fromScale(0.5, 0.08);
            Position = UDim2.fromScale(0.5, 0.85);
            AnchorPoint = Vector2.new(0.5, 1);
        }, {
            UIAspectRatioConstraint = createElement_upvr("UIAspectRatioConstraint", {
                AspectRatio = 7;
            });
            PlacerApp = createElement_upvr(PlacerApp_upvr, {
                aspectRatio = 7;
                verticalPaddingRatio = 18.285714285714285;
                onClickDelete = function() -- Line 333, Named "onClickDelete"
                    module_upvr.attemptDeleteCurrentHomeItem()
                end;
                onClickPlace = function() -- Line 336, Named "onClickPlace"
                    attemptPlaceCurrentHomeItem_upvr()
                end;
                onDownRight = function() -- Line 339, Named "onDownRight"
                    local os_clock_result1_2_upvr = os.clock()
                    any_new_result1_upvr.rotateHeartbeat = RunService_upvr.Heartbeat:Connect(function() -- Line 341
                        local os_clock_result1_4 = os.clock()
                        local var107 = os_clock_result1_4 - os_clock_result1_2_upvr
                        local var108
                        if 0.1 < var107 then
                            var108 = math.min(12, var107 / 0.1 + 1)
                        else
                            var108 = 1
                        end
                        if os_clock_result1_4 - var90_upvw < 0.1 then
                        else
                            var90_upvw = os_clock_result1_4
                            any_ToOrientation_result2_upvw -= 0.08726646259971647 * var108
                            any_ToOrientation_result2_upvw = math.floor(any_ToOrientation_result2_upvw / 0.08726646259971647 + 0.5) * 0.08726646259971647
                            any_new_result1_upvr_7:SetTarget(any_ToOrientation_result2_upvw)
                        end
                    end)
                end;
                onUpRight = function() -- Line 345, Named "onUpRight"
                    any_new_result1_upvr.rotateHeartbeat = nil
                end;
                onDownLeft = function() -- Line 348, Named "onDownLeft"
                    local os_clock_result1_upvr = os.clock()
                    any_new_result1_upvr.rotateHeartbeat = RunService_upvr.Heartbeat:Connect(function() -- Line 350
                        local os_clock_result1_5 = os.clock()
                        local var112 = os_clock_result1_5 - os_clock_result1_upvr
                        local var113
                        if 0.1 < var112 then
                            var113 = math.min(12, var112 / 0.1 + 1)
                        else
                            var113 = 1
                        end
                        if os_clock_result1_5 - var90_upvw < 0.1 then
                        else
                            var90_upvw = os_clock_result1_5
                            any_ToOrientation_result2_upvw += 0.08726646259971647 * var113
                            any_ToOrientation_result2_upvw = math.floor(any_ToOrientation_result2_upvw / 0.08726646259971647 + 0.5) * 0.08726646259971647
                            any_new_result1_upvr_7:SetTarget(any_ToOrientation_result2_upvw)
                        end
                    end)
                end;
                onUpLeft = function() -- Line 354, Named "onUpLeft"
                    any_new_result1_upvr.rotateHeartbeat = nil
                end;
                showPlace = InputUtils_upvr.isTouch();
            });
        });
    }), Players_upvr.LocalPlayer.PlayerGui, "ItemPlacerGui")
    any_new_result1_upvr:GiveTask(function() -- Line 364
        Roact_upvr.unmount(any_mount_result1_upvr)
    end)
    any_new_result1_upvr:GiveTask(UserInputService_upvr.InputEnded:Connect(function(arg1_4, arg2) -- Line 369
        if arg2 then
        elseif arg1_4.UserInputType == Enum.UserInputType.MouseButton1 then
            any_new_result1_upvr.rotateHeartbeat = nil
        end
    end))
    any_new_result1_upvr:GiveTask(UserInputService_upvr.InputBegan:Connect(function(arg1_5, arg2) -- Line 377
        if arg2 then
        elseif arg1_5.UserInputType == Enum.UserInputType.Keyboard or arg1_5.UserInputType == Enum.UserInputType.Gamepad1 then
            local var118_upvr = true
            if arg1_5.KeyCode ~= Enum.KeyCode.Q then
                if arg1_5.KeyCode ~= Enum.KeyCode.ButtonL2 then
                    var118_upvr = false
                else
                    var118_upvr = true
                end
            end
            local var119_upvr = true
            if arg1_5.KeyCode ~= Enum.KeyCode.E then
                if arg1_5.KeyCode ~= Enum.KeyCode.ButtonR2 then
                    var119_upvr = false
                else
                    var119_upvr = true
                end
            end
            if var119_upvr or var118_upvr then
                any_new_result1_upvr.waitForEnd = arg1_5:GetPropertyChangedSignal("UserInputState"):Connect(function() -- Line 393
                    if arg1_5.UserInputState == Enum.UserInputState.End then
                        any_new_result1_upvr.waitForEnd = nil
                        any_new_result1_upvr.rotateHeartbeat = nil
                    end
                end)
                local os_clock_result1_3_upvr = os.clock()
                any_new_result1_upvr.rotateHeartbeat = RunService_upvr.Heartbeat:Connect(function() -- Line 399
                    doRotate_upvr(var118_upvr, var119_upvr, os_clock_result1_3_upvr)
                end)
            end
        end
    end))
    local any_new_result1_upvr_3 = Spring_upvr.new(p, Vector3.new(), 0.8, 50)
    local any_new_result1_upvr_5 = Spring_upvr.new(p, Vector3.new(), 0.7, 30)
    local any_new_result1_upvr_6 = Spring_upvr.new(any__alignMat_result1.RightVector, Vector3.new(), 0.8, 50)
    local any_new_result1_upvr_2 = Spring_upvr.new(any__alignMat_result1.UpVector, Vector3.new(), 0.8, 50)
    any_new_result1_upvr:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 406
        local any_getTargetPosition_result1_2, any_getTargetPosition_result2, any_getTargetPosition_result3_2 = module_upvr.getTargetPosition(tbl_upvr_3)
        if any_getTargetPosition_result1_2 then
            local any_SetTarget_result1, _ = any_new_result1_upvr_3:SetTarget(any_getTargetPosition_result1_2)
            local _, any_SetTarget_result2 = any_new_result1_upvr_5:SetTarget(any_getTargetPosition_result1_2)
            if any_getTargetPosition_result2:Dot(UpVector_upvw) < 0.99 then
                var79_upvw = rotBtwnUnit_upvr(UpVector_upvw, any_getTargetPosition_result2) * var79_upvw
                UpVector_upvw = any_getTargetPosition_result2
            end
            local any__alignMat_result1_2 = module_upvr._alignMat(any_getTargetPosition_result2, any_getTargetPosition_result3_2, var79_upvw)
            local var136 = any_ToOrientation_result2_upvw
            local any_TranslateCf_result1 = arg1:TranslateCf(any__alignMat_result1_2 * CFrame.Angles(0, var136, 0) + any_getTargetPosition_result1_2)
            if arg1:IsWithinBoundsCached(any_TranslateCf_result1) and arg1:IsValidUpDot(any_TranslateCf_result1.UpVector:Dot(Vector3.new(0, 1, 0))) then
                var136 = 1
            else
                var136 = 0.5
            end
            Part_upvr.Transparency = var136
            arg1:SetCFrame(arg1:TranslateCf(CFrame.fromMatrix(Vector3.new(0, 0, 0), any_new_result1_upvr_6:SetTarget(any__alignMat_result1_2.RightVector).Unit, any_new_result1_upvr_2:SetTarget(any__alignMat_result1_2.UpVector).Unit) * CFrame.Angles(-any_SetTarget_result2.z * 0.0015, 0, any_SetTarget_result2.x * 0.0015) * CFrame.Angles(0, any_new_result1_upvr_7:Update(), 0) + any_SetTarget_result1))
        end
    end))
    any_new_result1_upvr:GiveTask(UserInputService_upvr.InputBegan:Connect(function(arg1_6, arg2) -- Line 445, Named "inputBegan"
        local var138 = false
        if arg1_6.UserInputType == Enum.UserInputType.Gamepad1 then
            if arg1_6.KeyCode ~= Enum.KeyCode.ButtonA then
                var138 = false
            else
                var138 = true
            end
        end
        if arg2 and not var138 then
        elseif arg1_6.UserInputType == Enum.UserInputType.MouseButton1 or var138 then
            attemptPlaceCurrentHomeItem_upvr()
        end
    end))
    module_upvr.onDragStarted:Fire()
end
function module_upvr._alignMat(arg1, arg2, arg3) -- Line 465
    local module = {arg2.LookVector, arg2.RightVector, arg2.UpVector}
    local getClosestVecDual_result1 = getClosestVecDual_upvr(module, arg1)
    if table.find(module, getClosestVecDual_result1) then
        table.remove(module, table.find(module, getClosestVecDual_result1))
    end
    if table.find(module, -getClosestVecDual_result1) then
        table.remove(module, table.find(module, -getClosestVecDual_result1))
    end
    return arg3 * rotBtwnUnit_upvr(Vector3.new(1, 0, 0), arg3:VectorToObjectSpace(getClosestVecDual_upvr(module, arg3:VectorToWorldSpace(Vector3.new(1, 0, 0)))))
end
function module_upvr.stopDrag() -- Line 489
    module_upvr._maid.placeMaid = nil
    module_upvr._lastDragEnd = os.clock()
    module_upvr.onDragEnded:Fire()
end
function module_upvr.isDragging() -- Line 494
    local _maid = module_upvr._maid
    if _maid then
        if module_upvr._maid.placeMaid == nil then
            _maid = false
        else
            _maid = true
        end
    end
    return _maid
end
function module_upvr.attemptDeleteCurrentHomeItem() -- Line 497
    assert(module_upvr.isDragging())
    local _currentHomeItem = module_upvr._currentHomeItem
    local var143
    if _currentHomeItem == nil then
        var143 = false
    else
        var143 = true
    end
    assert(var143)
    module_upvr.stopDrag()
    _currentHomeItem:AttemptDelete()
end
function module_upvr.getTimeSinceLastDragStart() -- Line 504
    return os.clock() - module_upvr._lastDragStart
end
function module_upvr.getTimeSinceLastDragEnd() -- Line 507
    return os.clock() - module_upvr._lastDragEnd
end
local HomeConsts_upvr = require(ReplicatedStorage.Home.HomeConsts)
local StreamingHelperUtils_upvr = require(ReplicatedStorage.App.StreamingHelperUtils)
local BinderUtils_upvr = require(ReplicatedStorage.Std.Binder.BinderUtils)
local Notification_upvr = require(ReplicatedStorage.Game.Notification)
function module_upvr.createAndDrag(arg1) -- Line 510
    local tbl = {
        type = "setVisible";
    }
    local var149 = false
    tbl.value = var149
    homeStore_upvr:dispatch(tbl)
    local function _() -- Line 515, Named "reopenUI"
        homeStore_upvr:dispatch({
            type = "setVisible";
            value = true;
        })
    end
    local any_queryCurrentStandingHome_result1 = HomeSystem_upvr.queryCurrentStandingHome()
    if any_queryCurrentStandingHome_result1 == nil then
        var149 = false
    else
        var149 = true
    end
    assert(var149)
    HomeItemSystem_upvr._maid._listenNewItem = any_queryCurrentStandingHome_result1._homeItemNewRemote.OnClientEvent:Connect(function(arg1_7) -- Line 523
        HomeItemSystem_upvr._maid._listenNewItem = nil
        if arg1_7.id == HomeConsts_upvr.ENUM_HOME_ITEM_NEW_RESULT.SUCCESS then
            StreamingHelperUtils_upvr.yieldForObjValuePopulated(arg1_7.modelPtr)
            BinderUtils_upvr.promiseBoundClass(HomeItemBinder_upvr, arg1_7.modelPtr.Value):andThen(function(arg1_8) -- Line 529
                module_upvr.startDrag(arg1_8)
                module_upvr._maid.placeMaid:GiveTask(function() -- Line 532
                    homeStore_upvr:dispatch({
                        type = "setVisible";
                        value = true;
                    })
                end)
            end):catch(warn)
        else
            if arg1_7.id == HomeConsts_upvr.ENUM_HOME_ITEM_NEW_RESULT.TOO_MANY then
                Notification_upvr.new({
                    Text = "Too many items placed... try deleting some.";
                })
                homeStore_upvr:dispatch({
                    type = "setVisible";
                    value = true;
                })
                return
            end
            if arg1_7.id == HomeConsts_upvr.ENUM_HOME_ITEM_NEW_RESULT.ALL_OWNED_PLACED then
                Notification_upvr.new({
                    Text = "You placed all of these that you own...";
                })
                homeStore_upvr:dispatch({
                    type = "setVisible";
                    value = true;
                })
                return
            end
            if arg1_7.id == HomeConsts_upvr.ENUM_HOME_ITEM_NEW_RESULT.MAX_PLACED then
                Notification_upvr.new({
                    Text = "You reached the placement limit for this item...";
                })
                homeStore_upvr:dispatch({
                    type = "setVisible";
                    value = true;
                })
                return
            end
            error("Unhandled result id: %d":format(arg1_7.id))
        end
    end)
    any_queryCurrentStandingHome_result1:AttemptCreateHomeItem(arg1)
end
return module_upvr