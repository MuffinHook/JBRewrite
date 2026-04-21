local Players_upvr = game:GetService("Players")
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local InventoryItemUtils_upvr = require(ReplicatedStorage.Inventory.InventoryItemUtils)
local var6_upvw
local tbl_7_upvr = {}
local tbl_6_upvr = {}
local tbl_3_upvr = {}
local module_upvr = {
    OnLocalItemEquipped = Signal.new();
    OnLocalItemUnequipped = Signal.new();
    onItemEquipped = Signal.new();
}
local InventoryItemSystem_upvr = require(ReplicatedStorage.Inventory.InventoryItemSystem)
local CharacterUtil_upvr = require(ReplicatedStorage.Game.CharacterUtil)
local Falling_upvr = require(ReplicatedStorage.Game.Falling)
local JetPack_upvr = require(ReplicatedStorage.Game.JetPack.JetPack)
local PlayerUtils_upvr = require(ReplicatedStorage.Game.PlayerUtils)
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local CharacterBinder_upvr = require(ReplicatedStorage.App.CharacterBinder)
local InventoryItemOwnerBinder_upvr = require(ReplicatedStorage.Inventory.InventoryItemOwnerBinder)
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
local DefaultActions_upvr = require(ReplicatedStorage.Game.DefaultActions)
local ActionButtonService_upvr = require(ReplicatedStorage.ActionButton.ActionButtonService)
local CharacterUtils_upvr = require(ReplicatedStorage.Std.CharacterUtils)
local CollectionService_upvr = game:GetService("CollectionService")
local RegionUtils_upvr = require(ReplicatedStorage.Std.Region.RegionUtils)
local InventoryItemBinder_upvr = require(ReplicatedStorage.Inventory.InventoryItemBinder)
function module_upvr.Init(arg1) -- Line 35
    var6_upvw = arg1.Event
    local em = arg1.em
    function em.acox1hpp(arg1_2, arg2, arg3) -- Line 39
        local any_GetEquipped_result1_2 = module_upvr.GetEquipped(arg1_2)
        if any_GetEquipped_result1_2 ~= nil then
            local tbl = {}
            tbl.UserInputType = arg2
            tbl.KeyCode = arg3
            any_GetEquipped_result1_2:InputBegan(tbl, false)
        end
    end
    function em.o9yta4in(arg1_3, arg2, arg3) -- Line 48
        local any_GetEquipped_result1 = module_upvr.GetEquipped(arg1_3)
        if any_GetEquipped_result1 ~= nil then
            local tbl_11 = {}
            tbl_11.UserInputType = arg2
            tbl_11.KeyCode = arg3
            any_GetEquipped_result1:InputEnded(tbl_11, false)
        end
    end
    InventoryItemSystem_upvr.addEquipCondition(function() -- Line 61
        return not tbl_6_upvr[LocalPlayer_upvr]
    end)
    InventoryItemSystem_upvr.addEquipCondition(function() -- Line 64
        if CharacterUtil_upvr.IsCrawling then
            return false
        end
        if Falling_upvr.IsRagdolling() then
            return false
        end
        if JetPack_upvr.IsFlying() then
            return false
        end
        local any_getHumanoid_result1 = PlayerUtils_upvr.getHumanoid(LocalPlayer_upvr)
        if not any_getHumanoid_result1 then
            return false
        end
        if any_getHumanoid_result1.Health <= 0.001 then
            return false
        end
        return true
    end)
    local function updateCharacter() -- Line 85
        local any_GetLocalVehiclePacket_result1_4 = VehicleUtils_upvr.GetLocalVehiclePacket()
        if any_GetLocalVehiclePacket_result1_4 then
            local var41 = false
            local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                local Seat_2 = any_GetLocalVehiclePacket_result1_4.Seat
                return Seat_2:FindFirstChild("Lean")
            end
            if 0.1 < tick() - VehicleUtils_upvr.LastVehicleExit and (decompInlinedCondition() or Seat_2:FindFirstChild("Items")) then
                var41 = true
            end
            if not var41 then
                return false
            end
        end
        return true
    end
    InventoryItemSystem_upvr.addEquipCondition(updateCharacter)
    local function handleEquipped_upvr(arg1_4) -- Line 107, Named "handleEquipped"
        if tbl_6_upvr[arg1_4:GetOwner()] then
            module_upvr._unequip(arg1_4:GetOwner())
            warn("An item was already equipped, choosing newer server state.")
        end
        local any__equip_result1_upvr = module_upvr._equip(arg1_4:GetOwner(), arg1_4.obj)
        if any__equip_result1_upvr.SetLeaning then
            local any_GetLocalVehiclePacket_result1 = VehicleUtils_upvr.GetLocalVehiclePacket()
            if any_GetLocalVehiclePacket_result1 then
                local Seat = any_GetLocalVehiclePacket_result1.Seat
                local var50
                if Seat:FindFirstChild("Lean") then
                    if 0 >= any_GetLocalVehiclePacket_result1.Model:FindFirstChild("Engine").CFrame:PointToObjectSpace(Seat.Position).X then
                        var50 = false
                    else
                        var50 = true
                    end
                    any__equip_result1_upvr:SetLeaning(true, var50)
                end
            end
        end
        if any__equip_result1_upvr.Model then
            local Character_upvr = arg1_4:GetOwner().Character
            local Parent_upvr_2 = any__equip_result1_upvr.Model.Parent
            if not any__equip_result1_upvr.Model then
            elseif Character_upvr.Parent then
                any__equip_result1_upvr.Model.Parent = Parent_upvr_2
            else
                any__equip_result1_upvr.Model.Parent = nil
            end
            arg1_4._maid.listenParent = Character_upvr.AncestryChanged:Connect(function() -- Line 139, Named "updateParent"
                if not any__equip_result1_upvr.Model then
                else
                    if Character_upvr.Parent then
                        any__equip_result1_upvr.Model.Parent = Parent_upvr_2
                        return
                    end
                    any__equip_result1_upvr.Model.Parent = nil
                end
            end)
        end
        Character_upvr = InventoryItemUtils_upvr
        Character_upvr = Character_upvr.getLocked
        Parent_upvr_2 = arg1_4.obj
        Character_upvr = Character_upvr(Parent_upvr_2)
        if not Character_upvr then
            Character_upvr = Audio_upvr
            Character_upvr = Character_upvr.ObjectLocal
            Parent_upvr_2 = any__equip_result1_upvr.RootPart
            Character_upvr(Parent_upvr_2, 690572276, {
                Volume = 0.8;
            })
        end
    end
    function updateCharacter(arg1_5) -- Line 159
        local obj_upvr = arg1_5.obj
        arg1_5.maid:GiveTask(InventoryItemSystem_upvr.onInventoryItemEquipped:Connect(function(arg1_6) -- Line 163
            if arg1_6:GetOwner().Character == obj_upvr then
                handleEquipped_upvr(arg1_6)
            end
        end))
        for _, v in InventoryItemSystem_upvr.getEquipped() do
            if v:GetOwner().Character == obj_upvr then
                handleEquipped_upvr(v)
            end
        end
    end
    local var54 = updateCharacter
    for _, v_2 in CharacterBinder_upvr:GetAll() do
        var54(v_2)
    end
    CharacterBinder_upvr:GetClassAddedSignal():Connect(var54)
    InventoryItemSystem_upvr.onInventoryItemEquipped:Connect(function(arg1_7) -- Line 182
        local any_GetOwner_result1_upvr = arg1_7:GetOwner()
        if typeof(any_GetOwner_result1_upvr) == "table" and getmetatable(any_GetOwner_result1_upvr) == InventoryItemOwnerBinder_upvr:GetConstructor() then
            if any_GetOwner_result1_upvr.Character then
                handleEquipped_upvr(arg1_7)
            end
            arg1_7._maid:GiveTask(any_GetOwner_result1_upvr._onCharacterChanged:Connect(function() -- Line 188
                if any_GetOwner_result1_upvr.Character then
                    handleEquipped_upvr(arg1_7)
                end
            end))
        end
    end)
    local function handleUnequippedRaw_upvr(arg1_8, arg2) -- Line 196, Named "handleUnequippedRaw"
        tbl_3_upvr[arg1_8] = arg2
        task.delay(1, function() -- Line 204
            if tbl_3_upvr[arg1_8] == arg2 then
                tbl_3_upvr[arg1_8] = nil
            end
        end)
        if arg2.IsLeaning then
            arg2:SetLeaning(false)
        end
        module_upvr._unequip(arg1_8)
    end
    local function clearUnknownOwners_upvr() -- Line 217, Named "clearUnknownOwners"
        for i_3, v_3 in tbl_6_upvr do
            local var73 = false
            local Character = i_3.Character
            if not Character or not Character.PrimaryPart or not Character.PrimaryPart:IsDescendantOf(workspace) then
                var73 = true
            end
            if var73 then
                handleUnequippedRaw_upvr(i_3, v_3)
            end
        end
    end
    Interval_upvr.every(1):Connect(clearUnknownOwners_upvr)
    InventoryItemSystem_upvr.onInventoryItemUnequipped:Connect(function(arg1_9) -- Line 232, Named "handleUnequipped"
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local any_GetOwner_result1 = arg1_9:GetOwner()
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [22.3]
        handleUnequippedRaw_upvr(any_GetOwner_result1, nil)
        do
            return
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        clearUnknownOwners_upvr()
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end)
    local priority_upvr = DefaultActions_upvr.crawlButton.priority
    local priority_upvr_2 = DefaultActions_upvr.sprintButton.priority
    module_upvr.OnLocalItemEquipped:Connect(function(arg1_10) -- Line 248
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local Maid = arg1_10.Maid
        local ShootBegin_2 = arg1_10.ShootBegin
        local var121
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        var121 = 1050
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [32.6]
        nil.priority = var121
        if ShootBegin_2.saturateTo ~= nil then
            var121 = ShootBegin_2.saturateTo
        else
            var121 = 0
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        nil.saturateTo = var121
        var121 = true
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        nil.noSink = var121
        var121 = ShootBegin_2.keyCodes
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        nil.keyCodes = var121
        var121 = "rbxassetid://4939736393"
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        nil.image = var121
        function var121() -- Line 261, Named "onPressed"
            arg1_10:InputBegan({
                UserInputType = Enum.UserInputType.MouseButton1;
            })
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        nil.onPressed = var121
        function var121() -- Line 264, Named "onReleased"
            if not arg1_10.InputEnded then
            else
                arg1_10:InputEnded({
                    UserInputType = Enum.UserInputType.MouseButton1;
                })
            end
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        nil.onReleased = var121
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [62.5]
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        Maid:GiveTask(nil(nil))
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if arg1_10.Reload then
            local tbl_14 = {
                priority = 750;
                image = "rbxassetid://4939737424";
            }
            local tbl_10 = {}
            var121 = Enum.KeyCode.R
            tbl_10[1] = var121
            tbl_14.keyCodes = tbl_10
            local function onPressed() -- Line 277
                arg1_10:InputBegan({
                    UserInputType = Enum.UserInputType.Keyboard;
                    KeyCode = Enum.KeyCode.R;
                })
            end
            tbl_14.onPressed = onPressed
            Maid:GiveTask(ActionButtonService_upvr.add(tbl_14))
        end
        local ScopeBegin_2 = arg1_10.ScopeBegin
        if ScopeBegin_2 then
            if typeof(arg1_10.ScopeBegin) ~= "function" then
                ScopeBegin_2 = false
            else
                ScopeBegin_2 = true
            end
        end
        if ScopeBegin_2 then
            local tbl_4 = {}
            var121 = 975
            tbl_4.priority = var121
            var121 = "rbxassetid://4939736720"
            tbl_4.image = var121
            var121 = true
            tbl_4.touchIsToggle = var121
            var121 = {}
            var121[1] = Enum.KeyCode.Q
            var121[2] = Enum.KeyCode.ButtonL2
            tbl_4.keyCodes = var121
            var121 = true
            tbl_4.noSink = var121
            function var121() -- Line 290, Named "onPressed"
                arg1_10:InputBegan({
                    UserInputType = Enum.UserInputType.MouseButton2;
                })
            end
            tbl_4.onPressed = var121
            function var121() -- Line 293, Named "onReleased"
                if not arg1_10.InputEnded then
                else
                    arg1_10:InputEnded({
                        UserInputType = Enum.UserInputType.MouseButton2;
                    })
                end
            end
            tbl_4.onReleased = var121
            Maid:GiveTask(ActionButtonService_upvr.add(tbl_4))
        end
        if arg1_10.ApplySkin then
            if typeof(arg1_10.ApplySkin) == "function" then
                local var113_upvw = false
                local function checkFlagToggleSkins_upvr() -- Line 303, Named "checkFlagToggleSkins"
                    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                    if not CharacterUtils_upvr.getRootPart(Players_upvr.LocalPlayer.Character) then return end
                    local any_GetTagged_result1_2, any_GetTagged_result2, any_GetTagged_result3_2 = CollectionService_upvr:GetTagged("GunSkinUIRegion")
                    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [28.7]
                    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                end
                var121 = Interval_upvr
                var121 = var121.every(0.1)
                var121 = var121:Connect(function() -- Line 321
                    checkFlagToggleSkins_upvr()
                end)
                Maid:GiveTask(var121)
                checkFlagToggleSkins_upvr()
            end
        end
        if not ScopeBegin_2 then
            ActionButtonService_upvr.setButtonPriority(DefaultActions_upvr.crawlButton, 900)
            ActionButtonService_upvr.setButtonPriority(DefaultActions_upvr.sprintButton, 950)
            Maid:GiveTask(function() -- Line 331
                ActionButtonService_upvr.setButtonPriority(DefaultActions_upvr.crawlButton, priority_upvr)
                ActionButtonService_upvr.setButtonPriority(DefaultActions_upvr.sprintButton, priority_upvr_2)
            end)
        end
        local any_GetLocalVehiclePacket_result1_2 = VehicleUtils_upvr.GetLocalVehiclePacket()
        if any_GetLocalVehiclePacket_result1_2 == nil then
        else
        end
        if not true or any_GetLocalVehiclePacket_result1_2.Passenger then
            var121 = false
            ActionButtonService_upvr.setButtonEnabled(DefaultActions_upvr.radioButton, var121)
            function var121() -- Line 342
                ActionButtonService_upvr.setButtonEnabled(DefaultActions_upvr.radioButton, true)
            end
            Maid:GiveTask(var121)
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end)
    InventoryItemBinder_upvr:GetClassAddedSignal():Connect(function(arg1_11) -- Line 348
        arg1_11._maid:GiveTask(arg1_11.onAttemptDrop:Connect(function() -- Line 349
            if arg1_11:GetOwner() ~= Players_upvr.LocalPlayer then
            else
                var6_upvw:FireServer('i'.."uohs0zrbr":sub(3, 6):reverse().."".."".."ru0vkte2":sub(5, 6):reverse():reverse():reverse():reverse():reverse()..""..'3')
            end
        end))
    end)
end
function module_upvr.Register(arg1) -- Line 357
    local __ClassName = arg1.__ClassName
    assert(__ClassName)
    if tbl_7_upvr[arg1.__ClassName] ~= nil then
        __ClassName = false
    else
        __ClassName = true
    end
    assert(__ClassName)
    tbl_7_upvr[arg1.__ClassName] = arg1
end
local ItemDataUtils_upvr = require(ReplicatedStorage.App.ItemDataUtils)
function module_upvr.GetConfig(arg1) -- Line 362
    return ItemDataUtils_upvr.getConfig(arg1)
end
function module_upvr.GetEquipped(arg1) -- Line 365
    return tbl_6_upvr[arg1]
end
function module_upvr.GetLocalEquipped() -- Line 369
    return module_upvr.GetEquipped(LocalPlayer_upvr)
end
local UserInputService_upvr = game:GetService("UserInputService")
function module_upvr._equip(arg1, arg2) -- Line 372
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    assert(arg1, "missing player")
    assert(arg2, "missing inventoryItemValue")
    local var143 = arg2
    local any_getName_result1 = InventoryItemUtils_upvr.getName(var143)
    local BroadcastInputEnded
    if InventoryItemUtils_upvr.getAttr(arg2, "CustomItem") ~= true then
        var143 = false
    else
        var143 = true
    end
    if var143 then
        BroadcastInputEnded = "Custom"
    else
        BroadcastInputEnded = any_getName_result1
    end
    local var146 = tbl_7_upvr[BroadcastInputEnded]
    if not var146 then
        BroadcastInputEnded = string.format("No module for item: %s", any_getName_result1)
        error(BroadcastInputEnded)
    end
    BroadcastInputEnded = arg1
    local any_new_result1_upvr = var146.new(BroadcastInputEnded, arg2, tbl_3_upvr[arg1])
    BroadcastInputEnded = any_new_result1_upvr.Local
    if BroadcastInputEnded then
        BroadcastInputEnded = any_new_result1_upvr.Maid
        BroadcastInputEnded = BroadcastInputEnded:GiveTask
        BroadcastInputEnded(UserInputService_upvr.InputBegan:Connect(function(arg1_12, arg2_2) -- Line 385
            any_new_result1_upvr:InputBegan(arg1_12, arg2_2)
        end))
        BroadcastInputEnded = any_new_result1_upvr.Maid
        BroadcastInputEnded = BroadcastInputEnded:GiveTask
        BroadcastInputEnded(UserInputService_upvr.InputEnded:Connect(function(...) -- Line 388
            any_new_result1_upvr:InputEnded(...)
        end))
        BroadcastInputEnded = any_new_result1_upvr.ShootBegin
        if BroadcastInputEnded == nil then
            BroadcastInputEnded = any_new_result1_upvr.Maid
            BroadcastInputEnded = BroadcastInputEnded:GiveTask
            BroadcastInputEnded(UserInputService_upvr.TouchStarted:connect(function(arg1_13, arg2_3) -- Line 399
                if arg2_3 then
                    return false
                end
                any_new_result1_upvr:InputBegan({
                    UserInputType = Enum.UserInputType.MouseButton1;
                    Position = arg1_13.Position;
                })
            end))
            BroadcastInputEnded = any_new_result1_upvr.Maid
            BroadcastInputEnded = BroadcastInputEnded:GiveTask
            BroadcastInputEnded(UserInputService_upvr.TouchEnded:connect(function(arg1_14, arg2_4) -- Line 405
                if arg2_4 then
                    return false
                end
                any_new_result1_upvr:InputEnded({
                    UserInputType = Enum.UserInputType.MouseButton1;
                    Position = arg1_14.Position;
                })
            end))
        end
        function BroadcastInputEnded(arg1_15, arg2_5) -- Line 414, Named "BroadcastInputBegan"
            if arg2_5 == nil then
            else
            end
            assert(true)
            var6_upvw:FireServer("acox1hpp", arg2_5.UserInputType, arg2_5.KeyCode)
        end
        any_new_result1_upvr.BroadcastInputBegan = BroadcastInputEnded
        function BroadcastInputEnded(arg1_16, arg2_6) -- Line 418
            if arg2_6 == nil then
            else
            end
            assert(true)
            var6_upvw:FireServer('o'.."cju4aty9td0":sub(4, 8):reverse().."".."".."uim":sub(2, 2):reverse():reverse():reverse():reverse():reverse()..""..'n', arg2_6.UserInputType, arg2_6.KeyCode)
        end
        any_new_result1_upvr.BroadcastInputEnded = BroadcastInputEnded
    end
    BroadcastInputEnded = tbl_6_upvr
    BroadcastInputEnded[arg1] = any_new_result1_upvr
    BroadcastInputEnded = any_new_result1_upvr.Local
    if BroadcastInputEnded then
        BroadcastInputEnded = ipairs(UserInputService_upvr:GetKeysPressed())
        local ipairs_result1_2, ipairs_result2, ipairs_result3 = ipairs(UserInputService_upvr:GetKeysPressed())
        for _, v_4 in ipairs_result1_2, ipairs_result2, ipairs_result3 do
            any_new_result1_upvr:InputBegan(v_4)
            local var157
        end
        ipairs_result1_2 = ipairs(UserInputService_upvr:GetMouseButtonsPressed())
        local ipairs_result1, ipairs_result2_2, ipairs_result3_2 = ipairs(UserInputService_upvr:GetMouseButtonsPressed())
        for _, v_5 in ipairs_result1, ipairs_result2_2, ipairs_result3_2 do
            if v_5.UserInputType ~= Enum.UserInputType.MouseButton1 then
                var157:InputBegan(v_5)
            end
        end
    end
    ipairs_result1 = var157.Local
    if ipairs_result1 then
        ipairs_result1 = module_upvr
        ipairs_result1 = ipairs_result1.OnLocalItemEquipped:Fire
        ipairs_result1(var157)
    end
    ipairs_result1 = module_upvr
    ipairs_result1 = ipairs_result1.onItemEquipped:Fire
    ipairs_result1(var157)
    return var157
end
function module_upvr._unequip(arg1) -- Line 445
    assert(arg1, "missing player")
    local var161 = tbl_6_upvr[arg1]
    if not var161 then
        return false
    end
    var161:Destroy()
    tbl_6_upvr[arg1] = nil
    if var161.Local then
        module_upvr.OnLocalItemUnequipped:Fire()
    end
    return true
end
return module_upvr