local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GunUtils_upvr = require(ReplicatedStorage.Game.GunShop.GunUtils)
local InventoryItemUtils_upvr = require(ReplicatedStorage.Inventory.InventoryItemUtils)
local Basic_upvr = require(script.Parent.Basic)
local var6_upvw
local module_upvr = {
    __ClassName = "Taser";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Basic_upvr)
local ItemSystem_upvr = require(ReplicatedStorage.Game.ItemSystem.ItemSystem)
function module_upvr.Init(arg1) -- Line 29
    var6_upvw = arg1.Event
    arg1.em.q2xjkpyg = function(arg1_2, arg2) -- Line 32, Named "q2xjkpyg"
        local any_GetEquipped_result1 = ItemSystem_upvr.GetEquipped(arg1_2)
        if any_GetEquipped_result1 ~= nil and any_GetEquipped_result1.Draw then
            any_GetEquipped_result1:Draw(arg2)
        end
    end
end
local Taser_upvr = require(ReplicatedStorage.Game.ItemConfig.Taser)
local GunSystemConsts_upvr = require(ReplicatedStorage.Game.ItemSystem.GunSystemConsts)
function module_upvr.new(arg1, arg2, arg3) -- Line 41
    local any_new_result1_upvr = Basic_upvr.new(arg1, arg2, Taser_upvr, arg3)
    setmetatable(any_new_result1_upvr, module_upvr)
    any_new_result1_upvr.Tip = any_new_result1_upvr.Model.Skeleton.Tip
    any_new_result1_upvr.IgnoreList = {any_new_result1_upvr.Character, any_new_result1_upvr.Model}
    if not InventoryItemUtils_upvr.getAttr(any_new_result1_upvr.inventoryItemValue, "NextUse") then
        InventoryItemUtils_upvr.setAttr(any_new_result1_upvr.inventoryItemValue, "NextUse", os.clock())
        InventoryItemUtils_upvr.setAttr(any_new_result1_upvr.inventoryItemValue, "LastUsedAt", 0)
    end
    if any_new_result1_upvr.Local then
        any_new_result1_upvr:SetupCrossHair()
    end
    any_new_result1_upvr._customCollidableFunc = any_new_result1_upvr:_buildCustomCollidableFunc()
    if any_new_result1_upvr.Local then
        local var14 = InventoryItemUtils_upvr.getAttr(any_new_result1_upvr.inventoryItemValue, "NextUse") or 0
        local var15 = InventoryItemUtils_upvr.getAttr(any_new_result1_upvr.inventoryItemValue, "LastUsedAt") or 0
        local os_clock_result1_3 = os.clock()
        if os_clock_result1_3 < var14 then
            any_new_result1_upvr:StartReloadProgressCircle(var14 - var15, (os.clock()) - (os_clock_result1_3 - var15))
            return any_new_result1_upvr
        end
        if GunUtils_upvr.getShouldAddEquipTime(any_new_result1_upvr) then
            any_new_result1_upvr.IsEquipping = true
            any_new_result1_upvr:StartReloadProgressCircle(GunSystemConsts_upvr.GUN_EQUIP_TIME)
            any_new_result1_upvr.maid:GiveTask(task.delay(GunSystemConsts_upvr.GUN_EQUIP_TIME, function() -- Line 71
                any_new_result1_upvr.IsEquipping = false
            end))
        end
    end
    return any_new_result1_upvr
end
function module_upvr._buildCustomCollidableFunc(arg1) -- Line 80
    return function(arg1_3) -- Line 81
        if arg1_3.CanCollide then
            return true
        end
        if arg1._lastListCharacter then
            for _, v in ipairs(arg1._lastListCharacter) do
                if arg1_3:IsDescendantOf(v) then
                    return true
                end
            end
        end
    end
end
function module_upvr.UpdateCrossHair(arg1) -- Line 94
    arg1.CrossHair:Update(arg1:GetMouseLocation())
end
local CrossHair_upvr = require(ReplicatedStorage.Game.CrossHair)
function module_upvr.SetupCrossHair(arg1) -- Line 97
    arg1.CrossHair = CrossHair_upvr.Make()
    arg1.CrossHair.Gui.Parent = arg1.Player.PlayerGui
    arg1.Maid:GiveTask(function() -- Line 101
        arg1.CrossHair:Destroy()
        arg1.CrossHair = nil
    end)
end
function module_upvr.Heartbeat(arg1) -- Line 107
    Basic_upvr.Heartbeat(arg1)
    if arg1.Local then
        arg1:UpdateCrossHair()
    end
end
function module_upvr.GetLeftArmPosition(arg1) -- Line 113
    return nil
end
local LightningUtils_upvr = require(ReplicatedStorage.Game.LightningUtils)
function module_upvr.Draw(arg1, arg2) -- Line 116
    if arg1._lastDraw and os.clock() - arg1._lastDraw < 1 then
    else
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        arg1._lastDraw = os.clock()
        local tbl_2 = {
            Origin = arg1.Tip.Position;
        }
        tbl_2.Target = arg2
        tbl_2.NumSegments = 10
        tbl_2.OffsetRadius = 2
        tbl_2.PartWidth = 0.1
        tbl_2.Transparency = 0
        tbl_2.Color = Color3.fromRGB(175, 130, 90)
        game:GetService("Debris"):AddItem(LightningUtils_upvr.strikePosition(tbl_2), 0.1)
        if arg1.Local then
            var6_upvw:FireServer('q'.."m2a":sub(2, 2):reverse().."".."".."enxnpkjxa85a":sub(5, 8):reverse():reverse():reverse().."".."yg", arg2)
        end
    end
end
local TagUtils_upvr = require(ReplicatedStorage.Tag.TagUtils)
local Notification_upvr = require(ReplicatedStorage.Game.Notification)
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local Raycast_upvr = require(ReplicatedStorage.Std.Raycast)
local GeomUtils_upvr = require(ReplicatedStorage.Std.GeomUtils)
local PlayerUtils_upvr = require(ReplicatedStorage.Game.PlayerUtils)
function module_upvr.Tase(arg1, arg2) -- Line 155
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    if arg1.IsEquipping then
        return false
    end
    local os_clock_result1 = os.clock()
    if os_clock_result1 - InventoryItemUtils_upvr.getAttr(arg1.inventoryItemValue, "NextUse") < 0 then
        return false
    end
    local Character = Players_upvr.LocalPlayer.Character
    if not Character then
        return false
    end
    if TagUtils_upvr.isPointInTag(Character.PrimaryPart.Position, "NoTaser") then
        if arg1.Local then
            Notification_upvr.new({
                Text = "Tasers not allowed here.";
            })
        end
        return false
    end
    Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.taser_buzz)
    arg1:UpdateMousePosition()
    local var86
    if arg1.Local then
        arg1.CrossHair.Spring:Accelerate(600)
        local tbl_3 = {}
        for _, v_2 in Players_upvr:GetPlayers() do
            if v_2 ~= LocalPlayer_upvr and v_2.Character then
                table.insert(tbl_3, v_2.Character)
            end
        end
        arg1._lastListCharacter = tbl_3
        local Position_2 = arg1.Tip.Position
        local var92 = arg1.MousePosition - arg1.Tip.Position
        RaycastParams.new().FilterDescendantsInstances = arg1.IgnoreList
        local any_collidable_result1_2 = Raycast_upvr.collidable(Position_2, var92.Unit, arg1.Config.Range)
        if any_collidable_result1_2 then
        else
        end
        if not any_collidable_result1_2.Instance then
            for _, v_3 in tbl_3 do
                local PrimaryPart_2 = v_3.PrimaryPart
                if PrimaryPart_2 then
                    local any_calcRayIntersectSphere_result1_2 = GeomUtils_upvr.calcRayIntersectSphere(Position_2, Position_2 + var92, PrimaryPart_2.Position, 3)
                    if any_calcRayIntersectSphere_result1_2 then
                        local var96 = any_calcRayIntersectSphere_result1_2
                    end
                end
            end
        end
        arg1:Draw(var96)
        local ReloadTime = arg1.Config.ReloadTime
        local var98 = os_clock_result1 + ReloadTime
        if v_3.PrimaryPart then
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            local any_getPlayerFromDescendant_result1 = PlayerUtils_upvr.getPlayerFromDescendant(v_3.PrimaryPart)
            if any_getPlayerFromDescendant_result1 then
                v_3 = 'm'.."syi":sub(2, 2):reverse().."".."".."z3r4w1bpc":sub(5, 8):reverse():reverse():reverse():reverse():reverse().."".."9g"
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                var6_upvw:FireServer(v_3, any_getPlayerFromDescendant_result1.Character:FindFirstChild("Humanoid"), v_3.PrimaryPart, var96)
                var98 = os_clock_result1 + arg1.Config.ReloadTimeHit
                arg1.CrossHair:Flare()
                ReloadTime = arg1.Config.ReloadTimeHit
            end
        end
        if arg1.Local then
            arg1:StartReloadProgressCircle(ReloadTime)
        end
        InventoryItemUtils_upvr.setAttr(arg1.inventoryItemValue, "LastUsedAt", os_clock_result1)
        InventoryItemUtils_upvr.setAttr(arg1.inventoryItemValue, "NextUse", var98)
        arg1:BroadcastInputBegan(arg2)
    end
    GunUtils_upvr.setLastShotTime(arg1.Player, workspace:GetServerTimeNow())
    return true
end
function module_upvr.InputBegan(arg1, arg2, arg3) -- Line 244
    local var101 = true
    if arg2.UserInputType ~= Enum.UserInputType.MouseButton1 then
        var101 = false
        if arg2.UserInputType == Enum.UserInputType.Gamepad1 then
            if arg2.KeyCode ~= Enum.KeyCode.ButtonR2 then
                var101 = false
            else
                var101 = true
            end
        end
    end
    if var101 then
        arg1:Tase(arg2)
    end
    Basic_upvr.InputBegan(arg1, arg2, arg3)
end
function module_upvr.InputEnded(arg1) -- Line 254
end
return module_upvr