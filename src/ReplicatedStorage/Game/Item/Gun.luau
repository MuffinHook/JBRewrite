local CurrentCamera_upvr = workspace.CurrentCamera
local Debris_upvr = game:GetService("Debris")
local RunService_upvr = game:GetService("RunService")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Joint_upvr = require(ReplicatedStorage_upvr.Std.Joint)
local R15IKv2_upvr = require(ReplicatedStorage_upvr.Module.R15IKv2)
local Spring_upvr = require(ReplicatedStorage_upvr.Std.Spring)
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local ItemCamera_upvr = require(ReplicatedStorage_upvr.Game.ItemSystem.ItemCamera)
local UI_upvr = require(ReplicatedStorage_upvr.Game.ItemSkin.UI.UI)
local VehicleUtils_upvr = require(ReplicatedStorage_upvr.Vehicle.VehicleUtils)
local InventoryItemUtils_upvr = require(ReplicatedStorage_upvr.Inventory.InventoryItemUtils)
local GunUtils_upvr = require(ReplicatedStorage_upvr.Game.GunShop.GunUtils)
local GunSystemConsts_upvr = require(ReplicatedStorage_upvr.Game.ItemSystem.GunSystemConsts)
local ConstraintUtils_upvr = require(ReplicatedStorage_upvr.Std.ConstraintUtils)
local Item_upvr = require(script.Parent.Item)
local zero_cframe_upvr = CFrame.new()
local function FromAxisAngle_upvr(arg1) -- Line 50, Named "FromAxisAngle"
    local x = arg1.x
    local y = arg1.y
    local z = arg1.z
    local var21 = (x * x + y * y + z * z) ^ 0.5
    if 0.00001 < var21 then
        local var22 = math.sin(var21 * 0.5) / var21
        return CFrame.new(0, 0, 0, var22 * x, var22 * y, var22 * z, math.cos(var21 * 0.5))
    end
    return zero_cframe_upvr
end
local function _() -- Line 60, Named "RandomVector"
    return Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit
end
local tbl_upvr = {
    bullet_impact_bass = 2837091387;
    bullet_impact_metal_light_01 = 2121004076;
    bullet_impact_rock_03 = 2121004325;
    bullet_impact_wood_light_04 = 2121004681;
}
local tbl_upvr_2 = {
    [Enum.Material.Wood] = tbl_upvr.bullet_impact_wood_light_04;
    [Enum.Material.Metal] = tbl_upvr.bullet_impact_metal_light_01;
    [Enum.Material.DiamondPlate] = tbl_upvr.bullet_impact_metal_light_01;
    [Enum.Material.Slate] = tbl_upvr.bullet_impact_rock_03;
}
local var25_upvw
local var26_upvw
local var27_upvw = 1
local module_upvr = {
    __ClassName = "Gun";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Item_upvr)
local var29_upvw = false
local waitForChild_upvr = require(ReplicatedStorage_upvr.Std.waitForChild)
local Players_upvr = game:GetService("Players")
local ItemSystem_upvr = require(ReplicatedStorage_upvr.Game.ItemSystem.ItemSystem)
local gameSettingType_upvr = require(ReplicatedStorage_upvr.GameSettings.gameSettingType)
local GameSettingsService_upvr = require(ReplicatedStorage_upvr.GameSettings.GameSettingsService)
function module_upvr.Init(arg1) -- Line 89
    assert(not var29_upvw, "gun already Init")
    var29_upvw = true
    var25_upvw = arg1.Event
    waitForChild_upvr(ReplicatedStorage_upvr, "ItemSystemGunMouseMovement"):andThen(function(arg1_2) -- Line 96
        var26_upvw = arg1_2
        var26_upvw.OnClientEvent:Connect(function(arg1_3) -- Line 98
            for i, v in arg1_3 do
                local any_GetPlayerByUserId_result1 = Players_upvr:GetPlayerByUserId(tonumber(i))
                if any_GetPlayerByUserId_result1 then
                    local any_GetEquipped_result1_2 = ItemSystem_upvr.GetEquipped(any_GetPlayerByUserId_result1)
                    if any_GetEquipped_result1_2 ~= nil and any_GetEquipped_result1_2.Local == false and any_GetEquipped_result1_2.SetThirdMousePosition then
                        any_GetEquipped_result1_2:SetThirdMousePosition(v)
                    end
                end
            end
        end)
    end)
    arg1.em.jwgzcdu3 = function(arg1_4, arg2, arg3) -- Line 113, Named "jwgzcdu3"
        local any_GetEquipped_result1 = ItemSystem_upvr.GetEquipped(arg1_4)
        if any_GetEquipped_result1 ~= nil and any_GetEquipped_result1.SetLeaning then
            any_GetEquipped_result1:SetLeaning(arg2, arg3)
        end
    end
    local tbl = {
        name = "scopeSens";
        title = "Scope Sensitivity";
        type = gameSettingType_upvr.Slider;
        defaultValue = 100;
        order = 210;
        min = 10;
        max = 100;
        step = 1;
        textMap = function(arg1_5) -- Line 131, Named "textMap"
            return "%d%%":format(arg1_5)
        end;
    }
    GameSettingsService_upvr.add(tbl)
    var27_upvw = tbl:getValue() / 100
    tbl.onChanged:Connect(function(arg1_6) -- Line 136, Named "handleSetting"
        var27_upvw = arg1_6 / 100
    end)
end
function module_upvr.new(arg1, arg2, arg3) -- Line 142
    local any_new_result1_2 = Item_upvr.new(arg1, arg3)
    setmetatable(any_new_result1_2, module_upvr)
    any_new_result1_2.inventoryItemValue = arg2
    local any_getName_result1 = InventoryItemUtils_upvr.getName(arg2)
    local SOME_2 = ReplicatedStorage_upvr.Game.ItemConfig:FindFirstChild(any_getName_result1)
    if SOME_2 == nil then
        error("No config file exists for item: %s":format(any_getName_result1))
    end
    any_new_result1_2.Config = require(SOME_2)
    any_new_result1_2.LastReplicateMousePosition = tick()
    any_new_result1_2.SimulateLocal = false
    any_new_result1_2.MinimalFx = false
    return any_new_result1_2
end
local CollectionService_upvr = game:GetService("CollectionService")
local DestructibleConsts_upvr = require(ReplicatedStorage_upvr.Game.Destructible.DestructibleConsts)
function module_upvr.Setup(arg1, arg2) -- Line 164
    arg1:SetupModel()
    arg1.IgnoreList = {arg1.Character, arg1.Model, workspace.Items}
    if arg1.Local then
        local any_GetLocalVehicleModel_result1 = VehicleUtils_upvr.GetLocalVehicleModel()
        if any_GetLocalVehicleModel_result1 then
            table.insert(arg1.IgnoreList, any_GetLocalVehicleModel_result1)
        end
        for _, v_2 in CollectionService_upvr:GetTagged(DestructibleConsts_upvr.SPAWN_TAG_NAME) do
            if v_2:FindFirstChild(DestructibleConsts_upvr.INSTANCE_VALUE_NAME) and v_2[DestructibleConsts_upvr.INSTANCE_VALUE_NAME].Value then
                table.insert(arg1.IgnoreList, v_2[DestructibleConsts_upvr.INSTANCE_VALUE_NAME].Value)
            end
        end
    end
    arg1:SetupArmWelds()
    arg1:SetupTip()
    arg1:AttachModelToPlayer()
    arg1:SetupBulletEmitter()
    arg1:SetupSprings(arg2)
    arg1.IK = R15IKv2_upvr.BuildPacketArms(arg1.Character)
    if arg1.Local then
        arg1:SetupCrossHair()
    end
    arg1:SetupAmmoGui()
    if arg1.Local then
        local any_new_result1 = Spring_upvr.new(Vector3.new(), Vector3.new(), 0.6, 75)
        arg1.SpringCamera = any_new_result1
        ItemCamera_upvr.SetRecoilSpring(any_new_result1)
    end
    if not arg1.Local then
        arg1.SpringThirdMousePosition = Spring_upvr.new(Vector3.new(), Vector3.new(), 0.9, 20)
    end
    arg1.JointNeckC0 = arg1.JointNeck.C0
    arg1.JointWaistC0 = arg1.JointWaist.C0
    arg1.IsShooting = false
    arg1.IsReloading = false
    arg1.IsEquipping = false
    arg1.IsScoping = false
    arg1.IsLeaning = false
    arg1.IsLeaningRight = false
    arg1.MousePosition = Vector3.new()
    arg1._lastUpdateViewDist = 0
    arg1:SetupShoot()
    arg1:Equip()
    arg1.Maid:GiveTask(function() -- Line 223
        ConstraintUtils_upvr.setJointC0(arg1.JointNeck, arg1.JointNeckC0)
        ConstraintUtils_upvr.setJointC0(arg1.JointWaist, arg1.JointWaistC0)
    end)
    arg1.Maid:GiveTask(function() -- Line 228
        arg1.Motor:Destroy()
        arg1.Motor = nil
        arg1.Model:Destroy()
        arg1.Model = nil
    end)
end
local RxInstanceUtils_upvr = require(ReplicatedStorage_upvr.Std.RxInstanceUtils)
function module_upvr.SetupShoot(arg1) -- Line 235
    arg1.Maid:GiveTask(RxInstanceUtils_upvr.observeOneChildNamed(arg1.inventoryItemValue, GunSystemConsts_upvr.SHOOT_REMOTE_NAME, function(arg1_7, arg2) -- Line 240
        arg2:GiveTask(arg1_7.OnClientEvent:Connect(function() -- Line 241
            arg1:Shoot()
        end))
    end))
end
local CrossHair_upvr = require(ReplicatedStorage_upvr.Game.CrossHair)
function module_upvr.SetupCrossHair(arg1) -- Line 248
    arg1.CrossHair = CrossHair_upvr.Make()
    arg1.CrossHair.Gui.Parent = arg1.Player.PlayerGui
    arg1.Maid:GiveTask(function() -- Line 252
        arg1.CrossHair:Destroy()
        arg1.CrossHair = nil
    end)
end
local AmmoGui_upvr = require(ReplicatedStorage_upvr.Game.AmmoGui)
local GunShopUtils_upvr = require(ReplicatedStorage_upvr.Game.GunShop.GunShopUtils)
local ItemDataUtils_upvr = require(ReplicatedStorage_upvr.App.ItemDataUtils)
function module_upvr.SetupAmmoGui(arg1) -- Line 257
    if arg1.Local then
        local any_getName_result1_2_upvr = InventoryItemUtils_upvr.getName(arg1.inventoryItemValue)
        arg1.AmmoGui = AmmoGui_upvr.new(GunShopUtils_upvr.getTranslatedTitleFromName(any_getName_result1_2_upvr))
        local any_getAttr_result1_2 = InventoryItemUtils_upvr.getAttr(arg1.inventoryItemValue, "AmmoCurrent")
        if any_getAttr_result1_2 then
            InventoryItemUtils_upvr.setAttr(arg1.inventoryItemValue, "AmmoCurrentLocal", any_getAttr_result1_2)
        end
        local var73_upvw = 0
        arg1.Maid:GiveTask(arg1.inventoryItemValue:GetAttributeChangedSignal("AmmoCurrent"):Connect(function() -- Line 272
            local any_getAttr_result1 = InventoryItemUtils_upvr.getAttr(arg1.inventoryItemValue, "AmmoCurrent")
            if var73_upvw < any_getAttr_result1 then
                InventoryItemUtils_upvr.setAttr(arg1.inventoryItemValue, "AmmoCurrentLocal", any_getAttr_result1)
            end
            var73_upvw = any_getAttr_result1
        end))
        local function updateAmmo() -- Line 280
            local any_getConfig_result1_2 = ItemDataUtils_upvr.getConfig(any_getName_result1_2_upvr)
            local var76
            if any_getConfig_result1_2 and any_getConfig_result1_2.MagSize then
                var76 = any_getConfig_result1_2.MagSize
            end
            arg1.AmmoGui:Update(InventoryItemUtils_upvr.getAttr(arg1.inventoryItemValue, "AmmoCurrentLocal") or 0, var76)
        end
        arg1.Maid:GiveTask(arg1.inventoryItemValue:GetAttributeChangedSignal("AmmoCurrentLocal"):Connect(updateAmmo))
        arg1.Maid:GiveTask(arg1.inventoryItemValue:GetAttributeChangedSignal("AmmoLeft"):Connect(updateAmmo))
        local any_getConfig_result1 = ItemDataUtils_upvr.getConfig(any_getName_result1_2_upvr)
        local var78
        if any_getConfig_result1 and any_getConfig_result1.MagSize then
            var78 = any_getConfig_result1.MagSize
        end
        arg1.AmmoGui:Update(InventoryItemUtils_upvr.getAttr(arg1.inventoryItemValue, "AmmoCurrentLocal") or 0, var78)
        local Model_upvr = arg1.Model
        if Model_upvr then
            Model_upvr = arg1.Model:FindFirstChild("BoundingBox", true)
        end
        var78 = arg1.Maid
        var78 = var78:GiveTask
        var78(RunService_upvr.Heartbeat:Connect(function(arg1_8) -- Line 295
            if Model_upvr then
                arg1.AmmoGui:UpdatePosition(Model_upvr, arg1_8)
            end
        end))
        var78 = arg1.Maid
        var78 = var78:GiveTask
        var78(function() -- Line 301
            arg1.AmmoGui:Destroy()
            arg1.AmmoGui = nil
        end)
    end
end
function module_upvr.SetupModel(arg1, arg2) -- Line 307
    if arg2 == nil then
        local any_getName_result1_3 = InventoryItemUtils_upvr.getName(arg1.inventoryItemValue)
    end
    local SOME_3 = ReplicatedStorage_upvr.Resource.ItemSystem.Models:FindFirstChild(any_getName_result1_3)
    if SOME_3 == nil then
        error("Could not find model for item `%s`":format(any_getName_result1_3))
    end
    local clone_2 = SOME_3:Clone()
    for _, v_3 in clone_2:GetDescendants() do
        if v_3:IsA("BasePart") then
            v_3.CanCollide = false
            v_3.CanQuery = false
            v_3.CanTouch = false
        end
    end
    arg1.Model = clone_2
    local BoundingBox = clone_2.Skeleton.BoundingBox
    arg1.BoundingBox = BoundingBox
    Joint_upvr.WeldAllTo(clone_2.Model, BoundingBox)
    if arg1.ApplySkin then
        arg1.Maid:GiveTask(arg1.inventoryItemValue:GetAttributeChangedSignal("SkinName"):Connect(function() -- Line 331, Named "updateSkin"
            arg1:ApplySkinLocal(arg1.inventoryItemValue:GetAttribute("SkinName"))
        end))
        arg1:ApplySkinLocal(arg1.inventoryItemValue:GetAttribute("SkinName"))
    end
end
function module_upvr.SetupTip(arg1) -- Line 338
    local Tip_4 = arg1.Model.Skeleton.Tip
    arg1.Tip = Tip_4
    arg1.TipOffset = arg1.BoundingBox.CFrame:PointToObjectSpace(Tip_4.Position)
    Joint_upvr.Weld(arg1.Model.Skeleton.Tip, arg1.BoundingBox)
    arg1.Model.Skeleton.Tip.Anchored = false
end
function module_upvr.SetupArmWelds(arg1) -- Line 347
    Joint_upvr.Weld(arg1.Model.Skeleton.LeftArm, arg1.BoundingBox)
    Joint_upvr.Weld(arg1.Model.Skeleton.RightArm, arg1.BoundingBox)
    arg1.Model.Skeleton.LeftArm.Anchored = false
    arg1.Model.Skeleton.RightArm.Anchored = false
end
local ItemSkinIds_upvr = require(ReplicatedStorage_upvr.Game.ItemSkin.ItemSkinIds)
function module_upvr.ApplySkinLocal(arg1, arg2) -- Line 353
    local var99
    if arg2 ~= nil and arg2 ~= "None" then
        local var100 = ItemSkinIds_upvr[arg2]
        if var100 == nil then
            error("No skin by name of %s exists.":format(arg2))
        end
        local var101 = var100[arg1.__ClassName]
        if var101 == nil then
            error("Skin %s has no image id for item: %s":format(arg2, arg1.__ClassName))
        end
        var99 = "rbxassetid://%d":format(var101)
    end
    for _, v_4 in arg1.Model:GetDescendants() do
        if v_4:IsA("MeshPart") and v_4:GetAttribute("ApplyGunTexture") == true then
            v_4.TextureID = var99
        end
    end
end
function module_upvr.ApplySkin(arg1, arg2) -- Line 375
    if arg1.Local then
        var25_upvw:FireServer('p'.."k01ss2":sub(4, 4):reverse():reverse():reverse().."".."".."ugmaqslr5v":sub(4, 6):reverse():reverse():reverse():reverse():reverse().."".."".."lphe":sub(3, 3):reverse():reverse():reverse():reverse():reverse().."".."x8", arg1.inventoryItemValue, arg2)
    end
end
function module_upvr.AttachModelToPlayer(arg1) -- Line 380
    local UpperTorso = arg1.UpperTorso
    arg1.BoundingBox.CFrame = UpperTorso.CFrame
    arg1.Model.Parent = workspace.Items
    arg1.Motor = Joint_upvr.BlankMotor6D(arg1.BoundingBox, UpperTorso)
end
local Time_upvr = require(ReplicatedStorage_upvr.Module.Time)
function module_upvr.BulletEmitterOnLocalHitPlayer(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15) -- Line 393
    local any_GetNowSync_result1 = Time_upvr.GetNowSync()
    arg1.inventoryItemValue:FindFirstChild(GunSystemConsts_upvr.DAMAGE_REMOTE_NAME):FireServer(arg2, arg3, arg4, arg5, arg6 - 0.6609848067581097 * any_GetNowSync_result1, arg7, arg8, arg9 + 0.3968011188544949 * any_GetNowSync_result1, arg10, arg11, arg12, arg13, arg14 + 0.6369049829533174 * any_GetNowSync_result1, arg15)
    if arg1.CrossHair then
        arg1.CrossHair:Flare()
    end
    if not arg1.MinimalFx then
        Audio_upvr.ObjectLocal(arg1.Tip, tbl_upvr.bullet_impact_bass, {
            TimePosition = 0;
            Volume = 1;
            Pitch = 1;
        })
    end
end
local ForcefieldConsts_upvr = require(ReplicatedStorage_upvr.Forcefield.ForcefieldConsts)
function module_upvr.BulletEmitterShieldDamage(arg1, arg2) -- Line 435
    if not arg1.Local then
    else
        ReplicatedStorage_upvr.Forcefield:FindFirstChild(ForcefieldConsts_upvr.DAMAGE_REMOTE_NAME):FireServer(arg2.Id, arg1.__ClassName)
    end
end
local BulletEmitter_upvr = require(ReplicatedStorage_upvr.Game.ItemSystem.BulletEmitter)
local HomeItemBinder_upvr = require(ReplicatedStorage_upvr.Home.HomeItem.HomeItemBinder)
local CameraBinder_upvr = require(ReplicatedStorage_upvr.CCTV.CameraBinder)
local ExplodableBarrelBinder_upvr = require(ReplicatedStorage_upvr.ExplodableBarrel.ExplodableBarrelBinder)
function module_upvr.SetupBulletEmitter(arg1) -- Line 443
    arg1.LastImpactSound = 0
    arg1.LastImpact = 0
    arg1.BulletEmitter = BulletEmitter_upvr.new(arg1.Local)
    arg1.BulletEmitter.IgnoreList = assert(arg1.IgnoreList)
    arg1.BulletEmitter.LifeSpan = 1
    arg1.BulletEmitter.GravityVector = (arg1.Config.GravityMultiplier or 1) * Vector3.new(0, -workspace.Gravity / 10, 0)
    local BulletEmitterOnLocalHitPlayer_2_upvr = arg1.BulletEmitterOnLocalHitPlayer
    arg1.BulletEmitter.OnLocalHitPlayer:Connect(function(...) -- Line 453
        BulletEmitterOnLocalHitPlayer_2_upvr(arg1, ...)
    end)
    local BulletEmitterShieldDamage_2_upvr = arg1.BulletEmitterShieldDamage
    arg1.BulletEmitter.OnShieldDamage:Connect(function(...) -- Line 458
        BulletEmitterShieldDamage_2_upvr(arg1, ...)
    end)
    arg1.BulletEmitter.OnHitSurface:Connect(function(arg1_9, arg2, arg3, arg4) -- Line 462
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local tick_result1 = tick()
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local Part_2 = Instance.new("Part")
        Part_2.Color = arg1_9.Color
        Part_2.Massless = true
        Part_2.Size = Vector3.new(0.5, 0.5, 0.10000)
        Part_2.Anchored = false
        Part_2.CanCollide = false
        Part_2.Transparency = 1
        Part_2.CFrame = CFrame.new(Vector3.new(), arg3) * CFrame.Angles(0, 0, math.random() * math.pi * 2) + arg2
        local Decal = Instance.new("Decal")
        Decal.Texture = "rbxassetid://2078626"
        Decal.Color3 = arg1_9.Color
        Decal.Face = Enum.NormalId.Front
        Decal.Parent = Part_2
        Joint_upvr.Weld(Part_2, arg1_9)
        Part_2.Parent = workspace.Items
        Debris_upvr:AddItem(Part_2, 2)
        if arg1.Local then
            if 0.03 < tick_result1 - arg1.LastImpactSound then
                local var128 = tbl_upvr_2[arg4]
                if var128 ~= nil then
                    arg1.LastImpactSound = tick_result1
                    Audio_upvr.ObjectLocal(Part_2, var128, {
                        Volume = 0.4;
                    })
                end
            end
        end
        local clone_3 = ReplicatedStorage_upvr.Resource.ItemSystem.Projectiles.Debris:Clone()
        clone_3.EmissionDirection = Enum.NormalId.Front
        clone_3.Size = NumberSequence.new(0.1)
        clone_3.SpreadAngle = Vector2.new(15, 15)
        clone_3.Parent = Part_2
        clone_3:Emit(3)
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end)
    local any_Connect_result1_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 554
        debug.profilebegin("Gun Bullet Emitter Update")
        arg1.BulletEmitter:Update()
        debug.profileend()
    end)
    arg1.Maid:GiveTask(function() -- Line 560
        if 0 < #arg1.BulletEmitter.Bullets then
            arg1.BulletEmitter.OnQueueEmptied:Connect(function() -- Line 563
                any_Connect_result1_upvw:Disconnect()
                any_Connect_result1_upvw = nil
                arg1.BulletEmitter:Destroy()
            end)
        else
            any_Connect_result1_upvw:Disconnect()
            any_Connect_result1_upvw = nil
            arg1.BulletEmitter:Destroy()
        end
    end)
end
function module_upvr.SetupSprings(arg1, arg2) -- Line 575
    if arg1.Local and arg2 and arg2.SpringItemOffset then
        arg1.SpringItemOffset = arg2.SpringItemOffset
        arg1.SpringItemOffset.Damp = 0.7
        arg1.SpringItemOffset.Freq = 50
        arg1.SpringItemOffset:SetTarget(arg1.Config.Motion.Hip.Springs.ItemOffset)
    else
        arg1.SpringItemOffset = Spring_upvr.new(arg1.Config.Motion.Hip.Springs.ItemOffset, Vector3.new(), 0.7, 50)
    end
    if arg1.Local and arg2 and arg2.SpringItemRotation then
        arg1.SpringItemRotation = arg2.SpringItemRotation
        arg1.SpringItemRotation.Damp = 0.9
        arg1.SpringItemRotation.Freq = 25
        arg1.SpringItemRotation:SetTarget(arg1.Config.Motion.Hip.Springs.ItemRotation)
    else
        arg1.SpringItemRotation = Spring_upvr.new(arg1.Config.Motion.Hip.Springs.ItemRotation, Vector3.new(), 0.9, 25)
    end
    if arg1.Local and arg2 and arg2.SpringNeckRotation then
        arg1.SpringNeckRotation = arg2.SpringNeckRotation
        arg1.SpringNeckRotation.Damp = 0.9
        arg1.SpringNeckRotation.Freq = 25
        arg1.SpringNeckRotation:SetTarget(arg1.Config.Motion.Hip.Springs.NeckRotation)
    else
        arg1.SpringNeckRotation = Spring_upvr.new(arg1.Config.Motion.Hip.Springs.NeckRotation, Vector3.new(), 0.9, 25)
    end
end
function module_upvr.UpdateItemSprings(arg1) -- Line 605
    local any_Update_result1, any_Update_result2 = arg1.SpringItemRotation:Update()
    arg1.ItemOffsetPosition = arg1.SpringItemOffset:Update()
    arg1.ItemRotationCFrame = FromAxisAngle_upvr(any_Update_result1)
    arg1.ItemRotationVelocityCFrame = FromAxisAngle_upvr(any_Update_result2 * 0.01)
end
function module_upvr.UpdateItemJoints(arg1) -- Line 616
end
function module_upvr.ApplyItemJointsC1(arg1) -- Line 617
    if arg1.Motor then
        arg1.Motor.C1 = arg1.ItemRotationCFrame * CFrame.new(arg1.ItemOffsetPosition) * arg1.JointWaist.C1
    end
end
function module_upvr.ApplyItemJointsTransform(arg1) -- Line 622
    if arg1.Motor then
        arg1.Motor.Transform = arg1.ItemRotationCFrame * CFrame.new(arg1.ItemOffsetPosition) * arg1.JointWaist.C1:Inverse()
    end
end
function module_upvr.UpdateBodySprings(arg1) -- Line 627
    arg1.NeckRotationPosition = arg1.SpringNeckRotation:Update()
end
function module_upvr.UpdateMousePosition(arg1) -- Line 631
    local var137
    if arg1.Local then
        var137 = arg1:ProjectMouseLocationToWorld(arg1:GetMouseLocation())
    else
        var137 = arg1.SpringThirdMousePosition:Update()
    end
    arg1.MousePosition = var137
    if arg1.Local and var26_upvw and 0.25 < tick() - arg1.LastReplicateMousePosition then
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        arg1.LastReplicateMousePosition = tick()
        var26_upvw:FireServer(var137)
    end
end
local GeomUtils_upvr = require(ReplicatedStorage_upvr.Std.GeomUtils)
function module_upvr.ComputeBodyJoints(arg1) -- Line 651
    local JointRoot = arg1.JointRoot
    local JointWaist = arg1.JointWaist
    arg1.JointWaist.Transform = CFrame.new()
    arg1.JointNeck.Transform = CFrame.new()
    local any_PointToObjectSpace_result1 = arg1.RootPart.CFrame * JointRoot.C0 * JointRoot.Transform * JointRoot.C1:Inverse() * arg1.JointWaistC0 * JointWaist.Transform:PointToObjectSpace(arg1.MousePosition)
    local var142 = arg1.ItemRotationCFrame:Inverse() * JointWaist.C1:Inverse() * arg1.ItemRotationCFrame * CFrame.new(arg1.ItemOffsetPosition + arg1.TipOffset) * JointWaist.C1
    local any_offsetLookAtTarget_result1, any_offsetLookAtTarget_result2 = GeomUtils_upvr.offsetLookAtTarget(var142.x, var142.y, var142.z, any_PointToObjectSpace_result1.x, any_PointToObjectSpace_result1.y, any_PointToObjectSpace_result1.z)
    if any_offsetLookAtTarget_result2 < -1.382300767579509 then
        any_offsetLookAtTarget_result2 = -1.382300767579509
    end
    arg1.JointWaistTransform = CFrame.Angles(0, any_offsetLookAtTarget_result1, 0) * CFrame.Angles(any_offsetLookAtTarget_result2, 0, 0) * arg1.ItemRotationCFrame:inverse()
    arg1.JointNeckTransform = arg1.ItemRotationCFrame * FromAxisAngle_upvr(arg1.NeckRotationPosition) * arg1.ItemRotationVelocityCFrame
end
function module_upvr.ApplyBodyJointsC1(arg1) -- Line 684
    if arg1.JointWaistTransform then
        ConstraintUtils_upvr.setJointC0(arg1.JointWaist, arg1.JointWaistC0 * arg1.JointWaistTransform)
        ConstraintUtils_upvr.setJointC0(arg1.JointNeck, arg1.JointNeckC0 * arg1.JointNeckTransform)
    end
end
function module_upvr.ApplyBodyJointsTransform(arg1) -- Line 690
    if arg1.JointWaistTransform then
        arg1.JointWaist.Transform = arg1.JointWaistTransform
        arg1.JointNeck.Transform = arg1.JointNeckTransform
    end
end
function module_upvr.ClearBodyTransform(arg1) -- Line 696
    arg1.JointWaist.Transform = CFrame.new()
    arg1.JointNeck.Transform = CFrame.new()
end
function module_upvr.UpdateArmIK(arg1) -- Line 703
    local IK_2 = arg1.IK
    local Model = arg1.Model
    IK_2.RightArm = Model.Skeleton.RightArm.Position
    IK_2.LeftArm = Model.Skeleton.LeftArm.Position
    IK_2.RightAngle = arg1.Config.Motion.RightElbowAngle
    IK_2.LeftAngle = arg1.Config.Motion.LeftElbowAngle
end
function module_upvr.ComputeArmJoints(arg1) -- Line 712
    if not arg1.Model:IsDescendantOf(workspace) then
    else
        if not arg1.Character.PrimaryPart then return end
        arg1:UpdateArmIK()
        R15IKv2_upvr.ComputeArms(arg1.IK)
    end
end
function module_upvr.ApplyArmJoints(arg1) -- Line 727
    local IK = arg1.IK
    R15IKv2_upvr.ApplyArms(IK)
    if arg1.Config.Motion.RightWristRotation then
        IK.RightWrist.Transform = arg1.Config.Motion.RightWristRotation
    end
    if arg1.Config.Motion.LeftWristRotation then
        IK.LeftWrist.Transform = arg1.Config.Motion.LeftWristRotation
    end
end
function module_upvr.ReloadDropAmmoVisual(arg1) -- Line 738
    local Ammo_2 = arg1.Model.Model:FindFirstChild("Ammo")
    if not Ammo_2 then
    else
        local clone_4 = Ammo_2:Clone()
        clone_4:ClearAllChildren()
        clone_4.CFrame = Ammo_2.CFrame
        clone_4.CanCollide = true
        clone_4.CollisionGroup = "NoCollide"
        clone_4.Velocity = Vector3.new(0, -20, 0)
        clone_4.Parent = workspace
        Debris_upvr:AddItem(clone_4, 6)
        Ammo_2.Transparency = 1
    end
end
function module_upvr.ReloadRefillAmmoVisual(arg1) -- Line 754
    local Ammo = arg1.Model.Model:FindFirstChild("Ammo")
    if not Ammo then
    else
        Ammo.Transparency = 0
    end
end
function module_upvr.ReloadDropAmmoSound(arg1) -- Line 762
    error("TODO: Implement")
end
function module_upvr.ReloadRefillAmmoSound(arg1) -- Line 765
    error("TODO: Implement")
end
function module_upvr._reloadBroadcast(arg1) -- Line 769
    local SOME = arg1.inventoryItemValue:FindFirstChild(GunSystemConsts_upvr.RELOAD_REMOTE_NAME)
    if SOME then
        SOME:FireServer()
    end
end
function module_upvr.ReloadLocal(arg1, arg2) -- Line 775
    arg1:StartReloadProgressCircle()
    return true
end
function module_upvr.ReloadAnyone(arg1) -- Line 779
    arg1:ReloadDropAmmoVisual()
    arg1:ReloadDropAmmoSound()
    task.delay(arg1.Config.ReloadTime - (arg1.Config.LocalReloadOffset or 0), function() -- Line 785
        if arg1.Destroyed then
            return false
        end
        arg1:ReloadRefillAmmoVisual()
        if arg1.Destroyed then
            return false
        end
        arg1:ReloadRefillAmmoSound()
        if arg1.Destroyed then
            return false
        end
        return true
    end)
end
function module_upvr._checkReloadCondition(arg1) -- Line 802
    if arg1.IsReloading then
        return false
    end
    if arg1.Local and arg1.inventoryItemValue:GetAttribute("IsReloading") then
        return false
    end
    if arg1:GetAmmoLeft() <= 0 then
        return false
    end
    return true
end
function module_upvr.Reload(arg1) -- Line 816
    if not arg1:_checkReloadCondition() then
        return false
    end
    arg1.IsReloading = true
    task.delay(arg1.Config.ReloadTime, function() -- Line 824
        if arg1.Destroyed then
            return false
        end
        arg1.IsReloading = false
        return true
    end)
    if arg1.Local or arg1.SimulateLocal then
        arg1:_reloadBroadcast()
    end
    if arg1.Local then
        arg1:ReloadLocal()
    end
    arg1:ReloadAnyone()
    return true
end
function module_upvr.GetAmmoLeft(arg1) -- Line 840
    return InventoryItemUtils_upvr.getAttr(arg1.inventoryItemValue, "AmmoLeft") or math.huge
end
local RayCast_upvr = require(ReplicatedStorage_upvr.Module.RayCast)
function module_upvr.ShootCheckConditions(arg1) -- Line 844
    local Tip_2 = arg1.Tip
    if arg1.IsReloading then
        return false
    end
    if arg1.IsEquipping then
        return false
    end
    if arg1.BlockFire then
        return false
    end
    if arg1.inventoryItemValue:GetAttribute("IsReloading") then
        return false
    end
    if arg1.Local then
        if InventoryItemUtils_upvr.getAttr(arg1.inventoryItemValue, "AmmoCurrentLocal") <= 0 then
            arg1:ShootSound(true)
            if arg1.IsReloading == false then
                arg1:InputBegan({
                    UserInputType = Enum.UserInputType.Keyboard;
                    KeyCode = Enum.KeyCode.R;
                })
            end
            return false
        end
        if Tip_2 then
            local Position_2 = arg1.RootPart.Position
            local var164 = Tip_2.Position - Position_2
            local _, any_RayIgnoreNonCollideWithIgnoreList_result2 = RayCast_upvr.RayIgnoreNonCollideWithIgnoreList(Position_2, var164.Unit, var164.Magnitude, arg1.IgnoreList, nil, nil, arg1._customCollideFunc)
            if 0.1 < (any_RayIgnoreNonCollideWithIgnoreList_result2 - Tip_2.Position).Magnitude then
                return false
            end
        end
    end
    if not arg1:CheckNextShotPossible() then
        return false
    end
    return true
end
function module_upvr.CheckNextShotPossible(arg1) -- Line 894
    local any_getNextShotPossible_result1 = GunUtils_upvr.getNextShotPossible(arg1.Player)
    if any_getNextShotPossible_result1 and workspace:GetServerTimeNow() < any_getNextShotPossible_result1 then
        return false
    end
    return true
end
function module_upvr.SetNextShotPossible(arg1) -- Line 904
    local FireFreq = arg1.Config.FireFreq
    local Player_2 = arg1.Player
    local workspace_GetServerTimeNow_result1 = workspace:GetServerTimeNow()
    GunUtils_upvr.setLastShotTime(Player_2, workspace_GetServerTimeNow_result1)
    if FireFreq then
        GunUtils_upvr.setNextShotPossible(Player_2, workspace_GetServerTimeNow_result1 + 1 / FireFreq)
    else
        warn("No FireFreq")
        return false
    end
    return true
end
local HapticEffect_upvr = require(ReplicatedStorage_upvr.App.HapticEffect)
function module_upvr.ShootLocal(arg1) -- Line 917
    local var172
    if arg1.Local then
        local basic = HapticEffect_upvr.basic
        var172 = 0.25
        basic(0.2, var172)
        if arg1.IsScoping then
            basic = 0.3
        else
            basic = 1
        end
        var172 = arg1.SpringCamera:Accelerate
        var172(Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * 0.15 * arg1.Config.CamShakeMagnitude * basic)
        if arg1.IsScoping then
            var172 = 0.3
        else
            var172 = 1
        end
        arg1.CrossHair.Spring:Accelerate(600 * var172)
        return true
    end
    return false
end
function module_upvr.ShootOther(arg1) -- Line 933
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    arg1.SpringItemOffset:Accelerate(Vector3.new(0, 0, 50) + Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * 3)
    arg1.SpringItemRotation:Accelerate(Vector3.new(-1, 2, 0).Unit * 12 + Vector3.new(math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1).Unit * 2)
    local CFrame_upvr = arg1.Tip.CFrame
    local TipDirection_upvr = arg1.TipDirection
    if not TipDirection_upvr then return end
    local function _() -- Line 947, Named "getLocalBulletDirection"
        return GunUtils_upvr.getBulletDirection(CFrame_upvr, TipDirection_upvr, (arg1.BulletSpread or 0) + (arg1.Config.BulletSpread or 0))
    end
    if arg1.Config.BulletsPerShot then
        for i_5 = 1, arg1.Config.BulletsPerShot do
            arg1.BulletEmitter:Emit(CFrame_upvr.Position, GunUtils_upvr.getBulletDirection(CFrame_upvr, TipDirection_upvr, (arg1.BulletSpread or 0) + (arg1.Config.BulletSpread or 0)), arg1.Config.BulletSpeed)
        end
    else
        i_5 = arg1.BulletSpread or 0
        i_5 = GunUtils_upvr
        i_5 = i_5.getBulletDirection(CFrame_upvr, TipDirection_upvr, i_5 + (arg1.Config.BulletSpread or 0))
        arg1.BulletEmitter:Emit(CFrame_upvr.Position, i_5, arg1.Config.BulletSpeed)
    end
    return true
end
function module_upvr.ShootFx(arg1) -- Line 962
    local Tip_5 = arg1.Tip
    if not Tip_5 then
    else
        if not ({
            Flintlock = 1;
            NerfRevolver = 20;
            Revolver = 20;
            Shotgun = 20;
            Sniper = 3;
        })[arg1.__ClassName] then
        end
        local ParticleEmitter = Tip_5:FindFirstChild("ParticleEmitter")
        if ParticleEmitter then
            ParticleEmitter:Emit(1)
        end
        local ParticleEmitterFlash = Tip_5:FindFirstChild("ParticleEmitterFlash")
        if ParticleEmitterFlash then
            ParticleEmitterFlash:Emit(1)
        end
        local PointLight_upvr = Tip_5:FindFirstChild("PointLight", true)
        if PointLight_upvr then
            PointLight_upvr.Enabled = true
            task.delay(0.1, function() -- Line 990
                PointLight_upvr.Enabled = false
            end)
        end
    end
end
function module_upvr.Shoot(arg1) -- Line 995
    arg1:ShootLocal()
    arg1:ShootOther()
    arg1:ShootSound(false)
    arg1:ShootFx()
    return true
end
function module_upvr.ShootSound(arg1, arg2) -- Line 1002
    error("TODO: Implement")
end
function module_upvr._attemptShoot(arg1) -- Line 1005
    if not arg1:ShootCheckConditions() then
        return false
    end
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        arg1:PreFireFunc()
        return arg1.Destroyed
    end
    if arg1.PreFireFunc and (decompInlinedCondition() or not arg1:ShootCheckConditions()) then
        return false
    end
    arg1:DecrementAmmo()
    arg1:SetNextShotPossible()
    if arg1.Local or arg1.SimulateLocal then
        arg1:_shootBroadcast()
    end
    arg1:Shoot()
    return true
end
function module_upvr._startReloading(arg1) -- Line 1026
    if arg1.IsReloading == false then
        arg1:InputBegan({
            UserInputType = Enum.UserInputType.Keyboard;
            KeyCode = Enum.KeyCode.R;
        })
    end
end
function module_upvr.DecrementAmmo(arg1) -- Line 1031
    if arg1.Local or arg1.SimulateLocal then
        local var187 = InventoryItemUtils_upvr.getAttr(arg1.inventoryItemValue, "AmmoCurrent") - 1
        InventoryItemUtils_upvr.setAttr(arg1.inventoryItemValue, "AmmoCurrentLocal", var187)
        if var187 <= 0 then
            arg1:_startReloading()
        end
        return true
    end
    return false
end
function module_upvr._shootBroadcast(arg1) -- Line 1044
    local SOME_4 = arg1.inventoryItemValue:FindFirstChild(GunSystemConsts_upvr.SHOOT_REMOTE_NAME)
    if SOME_4 then
        SOME_4:FireServer()
    end
end
function module_upvr.UpdateCrossHair(arg1) -- Line 1050
    if arg1.CrossHair then
        arg1.CrossHair:Update(arg1:GetMouseLocation())
    end
end
local MovementRollService_upvr = require(ReplicatedStorage_upvr.MovementRoll.MovementRollService)
function module_upvr.RenderStepped(arg1) -- Line 1055
    if arg1.Local then
        arg1:UpdateCrossHair()
    end
    debug.profilebegin("UpdateMousePosition")
    arg1:UpdateMousePosition()
    debug.profileend()
    debug.profilebegin("UpdateItemSprings")
    arg1:UpdateItemSprings()
    debug.profileend()
    debug.profilebegin("UpdateBodySprings")
    arg1:UpdateBodySprings()
    debug.profileend()
    debug.profilebegin("ComputeBodyJoints")
    arg1:ComputeBodyJoints()
    debug.profileend()
    if arg1.Local then
        if not MovementRollService_upvr.isPlayerRolling(arg1.Player) then
            debug.profilebegin("ApplyBodyJoints")
            arg1:ApplyBodyJointsC1()
            debug.profileend()
        end
        debug.profilebegin("ApplyItemJoints")
        arg1:ApplyItemJointsC1()
        debug.profileend()
    end
    arg1:UpdateItemJoints()
    debug.profilebegin("ComputeArmJoints")
    arg1:ComputeArmJoints()
    debug.profileend()
    local Tip_3 = arg1.Tip
    if Tip_3 ~= nil then
        arg1.TipDirection = Tip_3.CFrame.LookVector
    end
    if arg1.Local or arg1.SimulateLocal then
        if arg1.IsShooting == true then
            arg1:_attemptShoot()
        end
    end
end
function module_upvr.Stepped(arg1) -- Line 1106
    arg1:ClearBodyTransform()
    if not arg1.Local then
        debug.profilebegin("ApplyBodyJoints")
        arg1:ApplyBodyJointsTransform()
        debug.profileend()
        debug.profilebegin("ApplyItemJoints")
        arg1:ApplyItemJointsTransform()
        debug.profileend()
    end
    arg1:ApplyArmJoints()
end
local InputUtils_upvr = require(ReplicatedStorage_upvr.Std.InputUtils)
function module_upvr.ShootBegin(arg1, arg2) -- Line 1121
    if arg1.Config.FireAuto or InputUtils_upvr.isTouch() and arg1.Config.FireAutoMobile then
        arg1.IsShooting = true
    else
        arg1:_attemptShoot()
    end
end
function module_upvr.ShootEnd(arg1, arg2) -- Line 1128
    if arg1.IsShooting == true then
        arg1.IsShooting = false
    end
end
local AimAssist_upvr = require(ReplicatedStorage_upvr.Game.ItemSystem.AimAssist)
local Interval_upvr = require(ReplicatedStorage_upvr.Std.Interval)
function module_upvr.LocalScopeChanged(arg1) -- Line 1134
    if AimAssist_upvr.canAimAssist() then
        local maid_upvr = arg1.maid
        local function finishedCallback_upvr() -- Line 1137, Named "finishedCallback"
            maid_upvr.aimAssistMaid = nil
        end
        if arg1.IsScoping then
            maid_upvr.aimAssistMaid = AimAssist_upvr.aimAssist(arg1, finishedCallback_upvr)
            maid_upvr.aimAssistScan = Interval_upvr.every(0.25):Connect(function() -- Line 1142
                if maid_upvr.aimAssistMaid ~= nil then
                else
                    maid_upvr.aimAssistMaid = AimAssist_upvr.aimAssist(arg1, finishedCallback_upvr)
                end
            end)
            return
        end
        maid_upvr.aimAssistMaid = nil
        maid_upvr.aimAssistScan = nil
    end
end
function module_upvr.ScopeBegin(arg1) -- Line 1155
    if arg1.IsLeaning then
        return false
    end
    if VehicleUtils_upvr.GetLocalVehiclePacket() then
        return false
    end
    if arg1.IsScoping then
        return false
    end
    arg1.SpringItemOffset:SetTarget(arg1.Config.Motion.Scope.Springs.ItemOffset)
    arg1.SpringItemRotation:SetTarget(arg1.Config.Motion.Scope.Springs.ItemRotation)
    arg1.SpringNeckRotation:SetTarget(arg1.Config.Motion.Scope.Springs.NeckRotation)
    if arg1.Local then
        ItemCamera_upvr.Zoom(arg1.Config.Motion.Scope.FOV or 50)
        arg1.CrossHair:ADS(true)
        if 0.001 < math.abs(var27_upvw - 1) then
            ItemCamera_upvr.setSensitivity(var27_upvw)
        end
    end
    arg1.IsScoping = true
    if arg1.Local then
        arg1:LocalScopeChanged()
    end
    return true
end
function module_upvr.ScopeEnd(arg1) -- Line 1183
    if arg1.IsLeaning then
        return false
    end
    if not arg1.IsScoping then
        return false
    end
    arg1.SpringItemOffset:SetTarget(arg1.Config.Motion.Hip.Springs.ItemOffset)
    arg1.SpringItemRotation:SetTarget(arg1.Config.Motion.Hip.Springs.ItemRotation)
    arg1.SpringNeckRotation:SetTarget(arg1.Config.Motion.Hip.Springs.NeckRotation)
    if arg1.Local then
        ItemCamera_upvr.Zoom(70)
        arg1.CrossHair:ADS(false)
        ItemCamera_upvr.setSensitivity(1)
    end
    arg1.IsScoping = false
    if arg1.Local then
        arg1:LocalScopeChanged()
    end
    return true
end
function module_upvr.SetLeaning(arg1, arg2, arg3) -- Line 1204
    arg1.IsLeaning = arg2
    arg1.IsLeaningRight = arg3
    if arg1.IsLeaning then
        if arg1.IsLeaningRight == true then
            arg1.SpringItemOffset:SetTarget(Vector3.new(0.89999, 1, -1.8999))
            arg1.SpringItemRotation:SetTarget(Vector3.new(0.20000, 0, 0.60000))
            arg1.SpringNeckRotation:SetTarget(Vector3.new(0, 0, -0.5))
        else
            arg1.SpringItemOffset:SetTarget(Vector3.new(-0.6000, 1, -1.8999))
            arg1.SpringItemRotation:SetTarget(Vector3.new(0.20000, 0, -0.6000))
            arg1.SpringNeckRotation:SetTarget(Vector3.new(0, 0, 0.5))
        end
    else
        arg1.SpringItemOffset:SetTarget(arg1.Config.Motion.Hip.Springs.ItemOffset)
        arg1.SpringItemRotation:SetTarget(arg1.Config.Motion.Hip.Springs.ItemRotation)
        arg1.SpringNeckRotation:SetTarget(arg1.Config.Motion.Hip.Springs.NeckRotation)
    end
    if arg1.Local then
        var25_upvw:FireServer('j'.."siqmzgwx93i":sub(5, 7):reverse():reverse():reverse().."".."".."emjdcdo6":sub(4, 5):reverse().."".."u3", arg2, arg3)
    end
end
function module_upvr.InputBegan(arg1, arg2, arg3) -- Line 1226
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    do
        return false
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.InputEnded(arg1, arg2, arg3) -- Line 1274
    if arg3 then
        return false
    end
    local var198 = true
    if arg2.UserInputType ~= Enum.UserInputType.MouseButton1 then
        var198 = false
        if arg2.UserInputType == Enum.UserInputType.Gamepad1 then
            if arg2.KeyCode ~= Enum.KeyCode.ButtonR2 then
                var198 = false
            else
                var198 = true
            end
        end
    end
    if arg2.UserInputType ~= Enum.UserInputType.MouseButton2 then
    else
    end
    if var198 then
        arg1:ShootEnd(arg2)
    elseif true and arg1.ScopeEnd then
        arg1:ScopeEnd()
        if arg1.Local then
            arg1:BroadcastInputEnded(arg2)
        end
    end
end
function module_upvr.SetThirdMousePosition(arg1, arg2) -- Line 1292
    arg1.SpringThirdMousePosition:SetTarget(arg2)
end
function module_upvr._getUncachedViewDist(arg1) -- Line 1295
    return (arg1.RootPart.Position - CurrentCamera_upvr.CFrame.Position).Magnitude
end
function module_upvr._getViewDist(arg1) -- Line 1298
    local os_clock_result1_4 = os.clock()
    if 0.1 < os_clock_result1_4 - arg1._lastUpdateViewDist then
        arg1._lastUpdateViewDist = os_clock_result1_4
        local any__getUncachedViewDist_result1 = arg1:_getUncachedViewDist()
        arg1._viewDist = any__getUncachedViewDist_result1
        return any__getUncachedViewDist_result1
    end
    return arg1._viewDist
end
function module_upvr._getUpdateRate(arg1, arg2) -- Line 1309
    if not arg1.Model:IsDescendantOf(workspace) then
        return 1
    end
    local var201 = arg2 or 512
    local any__getViewDist_result1 = arg1:_getViewDist()
    if any__getViewDist_result1 < var201 then
        return 0
    end
    return (any__getViewDist_result1 - var201) / (1024 - var201)
end
function module_upvr.Equip(arg1) -- Line 1322
    arg1:RenderStepped()
    arg1:Stepped()
    local var203
    if not var203 then
        var203 = GunSystemConsts_upvr
        var203 = var203.GUN_EQUIP_TIME
    end
    if GunUtils_upvr.getShouldAddEquipTime(arg1) and 0 < var203 then
        if InventoryItemUtils_upvr.getAttr(arg1.inventoryItemValue, "AmmoCurrent") <= 0 then
            arg1.maid:GiveTask(task.defer(function() -- Line 1334
                arg1:_startReloading()
            end))
        else
            arg1.IsEquipping = true
            arg1:StartReloadProgressCircle(var203)
            arg1.maid:GiveTask(task.delay(var203, function() -- Line 1340
                arg1.IsEquipping = false
            end))
        end
    end
    arg1.maid:GiveTask(function() -- Line 1346
        local Player = arg1.Player
        if Player and Player.SetAttribute then
            GunUtils_upvr.setNextShotPossible(Player, nil)
        end
    end)
    if arg1.Local then
        local var209_upvw = 0
        arg1.Maid:GiveTask(RunService_upvr.RenderStepped:Connect(function() -- Line 1357
            if not arg1.Destroyed then
                local os_clock_result1 = os.clock()
                if arg1:_getUpdateRate() < os_clock_result1 - var209_upvw then
                    var209_upvw = os_clock_result1
                    debug.profilebegin("Gun RenderStepped")
                    arg1:RenderStepped()
                    debug.profileend()
                end
            end
        end))
    else
        arg1.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 1370
            if not arg1.Destroyed then
                local os_clock_result1_3 = os.clock()
                if arg1:_getUpdateRate() < os_clock_result1_3 - var209_upvw then
                    var209_upvw = os_clock_result1_3
                    debug.profilebegin("Gun RenderStepped")
                    arg1:RenderStepped()
                    debug.profileend()
                end
            end
        end))
    end
    local var215_upvw = 0
    arg1.Maid:GiveTask(RunService_upvr.Stepped:Connect(function() -- Line 1385
        if not arg1.Destroyed then
            local os_clock_result1_2 = os.clock()
            local any__getUpdateRate_result1 = arg1:_getUpdateRate()
            if arg1.Local or arg1.SimulateLocal then
                any__getUpdateRate_result1 = 0
            end
            if any__getUpdateRate_result1 < os_clock_result1_2 - var215_upvw then
                var215_upvw = os_clock_result1_2
                debug.profilebegin("Gun Stepped")
                arg1:Stepped()
                debug.profileend()
            end
        end
    end))
    if arg1.Heartbeat then
        arg1.Maid:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 1403
            if not arg1.Destroyed then
                debug.profilebegin("Gun Heartbeat")
                arg1:Heartbeat()
                debug.profileend()
            end
        end))
    end
end
function module_upvr.Unequip(arg1) -- Line 1412
    if arg1.IsLeaning then
        arg1:SetLeaning(false)
    end
    if arg1.IsScoping then
        arg1:ScopeEnd()
        CurrentCamera_upvr.FieldOfView = 70
    end
    if arg1.Local and UI_upvr.IsOpen == true then
        UI_upvr.Close()
    end
end
function module_upvr.Destroy(arg1) -- Line 1428
    arg1:Unequip()
    Item_upvr.Destroy(arg1)
end
return module_upvr