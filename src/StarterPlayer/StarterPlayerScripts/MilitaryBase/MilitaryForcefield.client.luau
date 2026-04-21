local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local any_new_result1_upvr_2 = require(ReplicatedStorage.Std.RateLimiter).new(1, 3)
local Falling_upvr = require(ReplicatedStorage.Game.Falling)
local Paraglide_upvr = require(ReplicatedStorage.Game.Paraglide)
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
local CharacterUtil_upvr = require(ReplicatedStorage.Game.CharacterUtil)
local C4System_upvr = require(ReplicatedStorage.Game.C4.C4System)
local function flingPlayer_upvr(arg1, arg2) -- Line 41, Named "flingPlayer"
    local PrimaryPart = LocalPlayer_upvr.Character.PrimaryPart
    if not PrimaryPart then
    else
        if PrimaryPart.CollisionGroup == "PlayersInTrain" then return end
        if not any_new_result1_upvr_2:UseBudget(1) then return end
        Audio_upvr.ObjectLocal(PrimaryPart, 17183453324, {
            Volume = 0.5;
        })
        if Falling_upvr.IsSkydiving() then
            Falling_upvr.StopSkydiving()
        end
        if Paraglide_upvr.IsFlying() then
            Paraglide_upvr.ParachuteStop()
        end
        if VehicleUtils_upvr.GetLocalVehiclePacket() ~= nil then
            CharacterUtil_upvr.OnJump()
            task.wait(0.3)
        end
        C4System_upvr.onExplode(arg1, 100000, 98, 98, false)
        arg2(true)
        task.delay(0.2, function() -- Line 65
            arg2(false)
        end)
    end
end
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local BulletEmitter_upvr = require(ReplicatedStorage.Game.ItemSystem.BulletEmitter)
local InventoryItemSystem_upvr = require(ReplicatedStorage.Inventory.InventoryItemSystem)
local PlayerUtils_upvr = require(ReplicatedStorage.Game.PlayerUtils)
local Settings_upvr = require(ReplicatedStorage.Resource.Settings)
local GameUtil_upvr = require(ReplicatedStorage.Game.GameUtil)
local InventoryItemBinder_upvr = require(ReplicatedStorage.Inventory.InventoryItemBinder)
local CharacterUtils_upvr = require(ReplicatedStorage.Std.CharacterUtils)
local TweenService_upvr = game:GetService("TweenService")
local RunService_upvr = game:GetService("RunService")
local Fade_upvr = require(ReplicatedStorage.Std.Fade)
require(ReplicatedStorage.Std.Binder).new("MilitaryForcefield", function(arg1) -- Line 70
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local any_new_result1_upvr = Maid_upvr.new()
    local var42_upvr = arg1.Position - Vector3.new(0, 1, 0) * arg1.Position.Y
    local var43_upvr = arg1.Size.X / 2
    local tbl_4_upvr = {
        Position = var42_upvr;
        Radius = var43_upvr;
    }
    tbl_4_upvr.Part = arg1
    BulletEmitter_upvr._militaryForcefield = tbl_4_upvr
    any_new_result1_upvr:GiveTask(function() -- Line 89
        if BulletEmitter_upvr._militaryForcefield == tbl_4_upvr then
            BulletEmitter_upvr._militaryForcefield = nil
        end
    end)
    local tbl_2_upvr = {}
    local function toggleFlash_upvr(arg1_2) -- Line 96, Named "toggleFlash"
        local var51
        for _, v in tbl_2_upvr do
            if arg1_2 then
                var51 = 0
            else
                var51 = 1
            end
            v.Transparency = var51
        end
    end
    local _
    for _, v_2 in Enum.NormalId:GetEnumItems() do
        local Decal = Instance.new("Decal")
        Decal.Face = v_2
        Decal.Texture = "rbxassetid://50282315"
        Decal.Color3 = Color3.fromRGB(475, 280, 510)
        Decal.Transparency = 1
        Decal.Parent = arg1
        table.insert(tbl_2_upvr, Decal)
        any_new_result1_upvr:GiveTask(Decal)
    end
    any_new_result1_upvr:GiveTask(Audio_upvr.ObjectLocal(arg1, 17183453324, {
        DoNotPlay = true;
    }))
    local function _() -- Line 114, Named "isServerDisabled"
        local var58
        if arg1:GetAttribute("Disabled") ~= true then
            var58 = false
        else
            var58 = true
        end
        return var58
    end
    local var115_upvw
    if InventoryItemSystem_upvr.playerHasItem(LocalPlayer_upvr, "Key") ~= true then
    else
    end
    local var60_upvw = true
    local var61_upvw = false
    local var62_upvw = true
    if not var62_upvw then
        if PlayerUtils_upvr.getTeamId(LocalPlayer_upvr) ~= Settings_upvr.EnumTeam.Police then
        else
        end
    end
    var61_upvw = true
    local var67_upvw = var61_upvw
    arg1.CanCollide = not var67_upvw and var60_upvw
    if not var67_upvw and not var60_upvw then
        if arg1:GetAttribute("Disabled") ~= true then
        else
        end
        if not true and var115_upvw then
            var115_upvw()
        end
    end
    any_new_result1_upvr:GiveTask(GameUtil_upvr.OnTeamChanged:Connect(function() -- Line 123, Named "updatePermsToEnter"
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local var65 = var62_upvw
        if not var65 then
            if PlayerUtils_upvr.getTeamId(LocalPlayer_upvr) ~= Settings_upvr.EnumTeam.Police then
                var65 = false
            else
                var65 = true
            end
        end
        var61_upvw = var65
        if not var61_upvw then
        end
        arg1.CanCollide = var60_upvw
        if not var61_upvw then
            local var66 = var60_upvw
            if not var66 then
                if arg1:GetAttribute("Disabled") ~= true then
                    var66 = false
                else
                    var66 = true
                end
                if not var66 then
                    var66 = var115_upvw
                    if var66 then
                        var66 = var115_upvw
                        var66()
                    end
                end
            end
        end
    end))
    any_new_result1_upvr:GiveTask(InventoryItemBinder_upvr:GetClassAddedSignal():Connect(function(arg1_3) -- Line 133
        if arg1_3:GetOwner() == LocalPlayer_upvr then
            local var72
            if arg1_3:GetName() == "Key" then
                var62_upvw = true
                local var73 = var62_upvw
                if not var73 then
                    var72 = PlayerUtils_upvr
                    var72 = var72.getTeamId(LocalPlayer_upvr)
                    if var72 ~= Settings_upvr.EnumTeam.Police then
                        var73 = false
                    else
                        var73 = true
                    end
                end
                var67_upvw = var73
                var72 = not var67_upvw
                if var72 then
                    var72 = var60_upvw
                end
                arg1.CanCollide = var72
                if not var67_upvw then
                    local var74 = var60_upvw
                    if not var74 then
                        var72 = arg1:GetAttribute("Disabled")
                        if var72 ~= true then
                            var74 = false
                        else
                            var74 = true
                        end
                        if not var74 then
                            var74 = var115_upvw
                            if var74 then
                                var74 = var115_upvw
                                var74()
                            end
                        end
                    end
                end
            end
        end
    end))
    any_new_result1_upvr:GiveTask(InventoryItemBinder_upvr:GetClassRemovingSignal():Connect(function(arg1_4) -- Line 139
        if arg1_4:GetOwner() == LocalPlayer_upvr then
            local var76
            if arg1_4:GetName() == "Key" then
                var62_upvw = false
                local var77 = var62_upvw
                if not var77 then
                    var76 = PlayerUtils_upvr
                    var76 = var76.getTeamId(LocalPlayer_upvr)
                    if var76 ~= Settings_upvr.EnumTeam.Police then
                        var77 = false
                    else
                        var77 = true
                    end
                end
                var67_upvw = var77
                var76 = not var67_upvw
                if var76 then
                    var76 = var60_upvw
                end
                arg1.CanCollide = var76
                if not var67_upvw then
                    local var78 = var60_upvw
                    if not var78 then
                        var76 = arg1:GetAttribute("Disabled")
                        if var76 ~= true then
                            var78 = false
                        else
                            var78 = true
                        end
                        if not var78 then
                            var78 = var115_upvw
                            if var78 then
                                var78 = var115_upvw
                                var78()
                            end
                        end
                    end
                end
            end
        end
    end))
    local function _() -- Line 147, Named "getSoundAttachment"
        if not arg1:FindFirstChild("SoundAttachment") then
            local Attachment_3 = Instance.new("Attachment")
            Attachment_3.Name = "SoundAttachment"
            Attachment_3.Parent = arg1
            Attachment_3.Position = Vector3.new(-0, -1, -0) * var43_upvr / 2
        end
        return Attachment_3
    end
    local var80_upvw
    local var81_upvw = false
    if not arg1:FindFirstChild("SoundAttachment") then
        local Attachment_2 = Instance.new("Attachment")
        Attachment_2.Name = "SoundAttachment"
        Attachment_2.Parent = arg1
        Attachment_2.Position = Vector3.new(-0, -1, -0) * var43_upvr / 2
    end
    local any_ObjectLocal_result1_upvr = Audio_upvr.ObjectLocal(Attachment_2, 104027245185669, {
        Volume = 2;
        RollOffMaxDistance = var43_upvr + 200;
        RollOffMinDistance = var43_upvr;
        Looped = true;
    })
    any_new_result1_upvr:GiveTask(function() -- Line 166
        if var80_upvw then
            var80_upvw:cancel()
        end
        any_ObjectLocal_result1_upvr:Destroy()
    end)
    local function _(arg1_5, arg2) -- Line 173, Named "safeActiveFadeTo"
        if var80_upvw then
            var80_upvw:cancel()
        end
        var80_upvw = Audio_upvr.promiseFadeTo(any_ObjectLocal_result1_upvr, arg1_5, arg2)
    end
    local var86_upvw = false
    any_new_result1_upvr:GiveTask(CharacterUtils_upvr.observeLocalCharacterAdded(function(arg1_6, arg2) -- Line 181
        if var80_upvw then
            var80_upvw:cancel()
        end
        any_ObjectLocal_result1_upvr.Volume = 0.2
        var86_upvw = true
    end))
    local TweenInfo_new_result1_upvr_2 = TweenInfo.new(0.8, Enum.EasingStyle.Bounce, Enum.EasingDirection.In)
    local function disableForcefield_upvr() -- Line 192, Named "disableForcefield"
        local var106
        if not var60_upvw then
        else
            var60_upvw = false
            local var107 = var62_upvw
            if not var107 then
                var106 = PlayerUtils_upvr
                var106 = var106.getTeamId(LocalPlayer_upvr)
                if var106 ~= Settings_upvr.EnumTeam.Police then
                    var107 = false
                else
                    var107 = true
                end
            end
            var67_upvw = var107
            var106 = not var67_upvw
            if var106 then
                var106 = var60_upvw
            end
            arg1.CanCollide = var106
            if not var67_upvw then
                local var108 = var60_upvw
                if not var108 then
                    var106 = arg1:GetAttribute("Disabled")
                    if var106 ~= true then
                        var108 = false
                    else
                        var108 = true
                    end
                    if not var108 then
                        var108 = var115_upvw
                        if var108 then
                            var108 = var115_upvw
                            var108()
                        end
                    end
                end
            end
            if not arg1:FindFirstChild("SoundAttachment") then
                local Attachment_4 = Instance.new("Attachment")
                Attachment_4.Name = "SoundAttachment"
                Attachment_4.Parent = arg1
                Attachment_4.Position = Vector3.new(-0, -1, -0) * var43_upvr / 2
            end
            any_new_result1_upvr:GiveTask(Audio_upvr.ObjectLocal(Attachment_4, 2992428082, {
                Volume = 0.6;
                RollOffMaxDistance = var43_upvr + 200;
                RollOffMinDistance = var43_upvr;
            }))
            TweenService_upvr:Create(arg1, TweenInfo_new_result1_upvr_2, {
                Transparency = 1;
            }):Play()
            local any_QueryDescendants_result1_4, any_QueryDescendants_result2_5, any_QueryDescendants_result3_3 = arg1.Parent:QueryDescendants("Beam")
            for _, v_4 in any_QueryDescendants_result1_4, any_QueryDescendants_result2_5, any_QueryDescendants_result3_3 do
                v_4.Enabled = false
            end
            if var80_upvw then
                var80_upvw:cancel()
            end
            any_QueryDescendants_result2_5 = any_ObjectLocal_result1_upvr
            var80_upvw = Audio_upvr.promiseFadeTo(any_QueryDescendants_result2_5, 0, 1)
        end
    end
    function var115_upvw() -- Line 211
        local var121
        if var60_upvw then
        else
            var60_upvw = true
            local var122 = var62_upvw
            if not var122 then
                var121 = PlayerUtils_upvr
                var121 = var121.getTeamId(LocalPlayer_upvr)
                if var121 ~= Settings_upvr.EnumTeam.Police then
                    var122 = false
                else
                    var122 = true
                end
            end
            var67_upvw = var122
            var121 = not var67_upvw
            if var121 then
                var121 = var60_upvw
            end
            arg1.CanCollide = var121
            if not var67_upvw then
                local var123 = var60_upvw
                if not var123 then
                    var121 = arg1:GetAttribute("Disabled")
                    if var121 ~= true then
                        var123 = false
                    else
                        var123 = true
                    end
                    if not var123 then
                        var123 = var116_upvw
                        if var123 then
                            var123 = var116_upvw
                            var123()
                        end
                    end
                end
            end
            if not arg1:FindFirstChild("SoundAttachment") then
                local Attachment = Instance.new("Attachment")
                Attachment.Name = "SoundAttachment"
                Attachment.Parent = arg1
                Attachment.Position = Vector3.new(-0, -1, -0) * var43_upvr / 2
            end
            any_new_result1_upvr:GiveTask(Audio_upvr.ObjectLocal(Attachment, 4058366615, {
                Volume = 0.45;
                RollOffMaxDistance = var43_upvr + 200;
                RollOffMinDistance = var43_upvr - 50;
            }))
            TweenService_upvr:Create(arg1, TweenInfo_new_result1_upvr_3, {
                Transparency = -5;
            }):Play()
            var121 = 0.5
            task.delay(var121, function() -- Line 225
                for _, v_5 in arg1.Parent:QueryDescendants("Beam") do
                    v_5.Enabled = true
                end
            end)
            var121 = Size_upvr * 0.7
            arg1.Size = var121
            var121 = Size_upvr
            var121 = var121.Y
            var121 = arg1
            var121.Position -= Vector3.new(0, (var121 - arg1.Size.Y) / 2, 0)
            var121 = TweenService_upvr
            var121 = var121:Create(arg1, TweenInfo_new_result1_upvr, {
                Size = Size_upvr;
                Position = Position_upvr;
            })
            var121:Play()
            if var81_upvw then
                if var80_upvw then
                    var80_upvw:cancel()
                end
                var80_upvw = Audio_upvr.promiseFadeTo(any_ObjectLocal_result1_upvr, 0.2, 1)
                return
            end
            if var80_upvw then
                var80_upvw:cancel()
            end
            var80_upvw = Audio_upvr.promiseFadeTo(any_ObjectLocal_result1_upvr, 1.7, 1)
        end
    end
    local TweenInfo_new_result1_upvr_3 = TweenInfo.new(0.6, Enum.EasingStyle.Bounce, Enum.EasingDirection.In)
    local Size_upvr = arg1.Size
    local TweenInfo_new_result1_upvr = TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    local Position_upvr = arg1.Position
    local var116_upvw = var115_upvw
    local function updateServerState() -- Line 249
        local var135
        if arg1:GetAttribute("Disabled") ~= true then
            var135 = false
        else
            var135 = true
        end
        if var135 then
            var135 = var60_upvw
            if var135 then
                var135 = disableForcefield_upvr
                var135()
                return
            end
        end
        if arg1:GetAttribute("Disabled") ~= true then
            var135 = false
        else
            var135 = true
        end
        if not var135 then
            var135 = var60_upvw
            if not var135 then
                var135 = var116_upvw
                var135()
            end
        end
    end
    any_new_result1_upvr:GiveTask(arg1:GetAttributeChangedSignal("Disabled"):Connect(updateServerState))
    task.spawn(updateServerState)
    arg1.Transparency = -5
    arg1.LocalTransparencyModifier = 1
    for _, v_3 in arg1.Parent:QueryDescendants("Beam") do
        v_3.LocalTransparencyModifier = 1
        v_3.Enabled = true
    end
    local var140_upvw = 0
    local var141_upvw = false
    local var142_upvr = var43_upvr - 50
    local var143_upvr = var43_upvr + 50
    local var144_upvw = 0
    any_new_result1_upvr:GiveTask(RunService_upvr.Heartbeat:Connect(function() -- Line 268
        local os_clock_result1_2 = os.clock()
        local var179
        if os_clock_result1_2 < var140_upvw then
        else
            local Character_2 = LocalPlayer_upvr.Character
            local var181 = Character_2
            if var181 then
                var181 = Character_2.PrimaryPart
            end
            if not var181 then return end
            local Position_2 = var181.Position
            local Magnitude = (var42_upvr - Position_2).Magnitude
            local var184
            var179 = 400 + var43_upvr
            if var179 < Magnitude then
                var184 = 1
            else
                var184 = 0.05
            end
            var179 = os_clock_result1_2 + var184
            var140_upvw = var179
            if Magnitude >= 1800 + var43_upvr then
            else
            end
            if true and not var141_upvw then
                var141_upvw = true
                any_new_result1_upvr._distFade = Maid_upvr.new()
                for _, v_6 in arg1.Parent:QueryDescendants("Beam, BasePart#Forcefield") do
                    any_new_result1_upvr._distFade:GiveTask(Fade_upvr.linear(v_6, "LocalTransparencyModifier", 0, 3))
                end
            else
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                if not true and var141_upvw then
                    var141_upvw = false
                    any_new_result1_upvr._distFade = Maid_upvr.new()
                    local any_QueryDescendants_result1_2, any_QueryDescendants_result2_2, any_QueryDescendants_result3_2 = arg1.Parent:QueryDescendants("Beam, BasePart#Forcefield")
                    for i_7, v_7 in any_QueryDescendants_result1_2, any_QueryDescendants_result2_2, any_QueryDescendants_result3_2 do
                        any_new_result1_upvr._distFade:GiveTask(Fade_upvr.linear(v_7, "LocalTransparencyModifier", 1, 3))
                    end
                end
            end
            if var184 ~= 0.05 then return end
            any_QueryDescendants_result1_2 = false
            local var191 = any_QueryDescendants_result1_2
            if var142_upvr < Magnitude and Magnitude < var143_upvr and var42_upvr.Y <= Position_2.Y then
                var191 = var67_upvw
            end
            if var191 then
                var144_upvw = os.clock()
                local var192
            end
            if var191 and var60_upvw then
                disableForcefield_upvr()
            elseif not var191 then
                local var193 = var60_upvw
                if not var193 then
                    var192 = arg1
                    v_7 = "Disabled"
                    var192 = var192:GetAttribute(v_7)
                    if var192 ~= true then
                        var193 = false
                    else
                        var193 = true
                    end
                    if not var193 then
                        var192 = os.clock()
                        i_7 = var144_upvw
                        var193 = var192 - i_7
                        var192 = 3
                        if var192 < var193 then
                            var193 = var116_upvw
                            var193()
                        end
                    end
                end
            end
            var193 = false
            local var194 = var193
            i_7 = var43_upvr
            var192 = i_7 - 4
            if var192 < Magnitude then
                var194 = false
                i_7 = var43_upvr
                var192 = i_7 + 6
                if Magnitude < var192 then
                    var192 = Position_2.Y
                    i_7 = var42_upvr
                    i_7 = i_7.Y
                    if i_7 > var192 then
                        var194 = false
                    else
                        var194 = true
                    end
                end
            end
            if var194 then
                var192 = var67_upvw
                if not var192 then
                    var192 = var60_upvw
                    if var192 then
                        var192 = flingPlayer_upvr
                        i_7 = var42_upvr
                        v_7 = toggleFlash_upvr
                        var192(i_7, v_7)
                    end
                end
            end
            i_7 = var43_upvr
            if Magnitude >= i_7 then
                var192 = false
            else
                var192 = true
            end
            i_7 = tbl_4_upvr
            i_7.Ignore = var192
            i_7 = var81_upvw
            local function decompInlinedCondition_3() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                i_7 = var86_upvw
                return i_7
            end
            local function decompInlinedCondition_4() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                i_7 = var60_upvw
                var81_upvw = var192
                var86_upvw = i_7
                i_7 = false
                return i_7
            end
            if var192 ~= i_7 or decompInlinedCondition_3() or decompInlinedCondition_4() then
                if var192 then
                    i_7 = var80_upvw
                    if i_7 then
                        var80_upvw:cancel()
                    end
                    i_7 = Audio_upvr
                    i_7 = i_7.promiseFadeTo
                    v_7 = any_ObjectLocal_result1_upvr
                    i_7 = i_7(v_7, 0.2, 1)
                    var80_upvw = i_7
                    return
                end
                i_7 = var80_upvw
                if i_7 then
                    var80_upvw:cancel()
                end
                i_7 = Audio_upvr
                i_7 = i_7.promiseFadeTo
                v_7 = any_ObjectLocal_result1_upvr
                i_7 = i_7(v_7, 1.7, 1)
                var80_upvw = i_7
            end
        end
    end))
    return any_new_result1_upvr
end):Start()
