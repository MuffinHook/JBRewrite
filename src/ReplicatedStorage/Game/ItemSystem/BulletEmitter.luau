local Players_upvr = game:GetService("Players")
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local tbl = {
    bullet_flyby_01 = 2121003369;
    bullet_flyby_04 = 2121003636;
    bullet_impact_body_thump_01 = 2121003873;
    bullet_impact_bass = 2837091387;
}
local function IntersectRaySphereF_upvr(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11) -- Line 33, Named "IntersectRaySphereF"
    local var5 = arg7 * arg7 * arg4 * arg4 + arg7 * arg7 * arg5 * arg5 + arg7 * arg7 * arg6 * arg6
    local var6 = 2 * (arg7 * arg4 * (arg1 - arg8) + arg7 * arg5 * (arg2 - arg9) + arg7 * arg6 * (arg3 - arg10))
    local var7 = var6 * var6 - 4 * var5 * (arg8 * arg8 + arg9 * arg9 + arg10 * arg10 + arg1 * arg1 + arg2 * arg2 + arg3 * arg3 - 2 * (arg8 * arg1 + arg9 * arg2 + arg10 * arg3) - arg11 * arg11)
    if math.abs(var5) < 0.001 or var7 < 0 then
        return nil, nil
    end
    local var8 = var7 ^ 0.5
    local var9 = (-var6 - var8) / (2 * var5)
    local var10 = (-var6 + var8) / (2 * var5)
    if var5 * (1 - var9) * (var10 - var9) < 0 or var5 * var10 * (var10 - var9) < 0 then
        return nil, nil
    end
    return var9, var10
end
local function _(arg1, arg2, arg3, arg4, arg5) -- Line 52, Named "IntersectRaySphere"
    return IntersectRaySphereF_upvr(arg1.x, arg1.y, arg1.z, arg2.x, arg2.y, arg2.z, arg3, arg4.x, arg4.y, arg4.z, arg5)
end
local Part_2_upvr = Instance.new("Part")
Part_2_upvr.Anchored = true
Part_2_upvr.CFrame = CFrame.new(0, 0, 0)
Part_2_upvr.CanCollide = false
Part_2_upvr.Transparency = 1
Part_2_upvr.Parent = workspace
local Folder_upvr = Instance.new("Folder")
Folder_upvr.Parent = workspace
local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local Signal_upvr = require(ReplicatedStorage.Std.Signal)
function module_upvr.new(arg1) -- Line 79
    if arg1 == nil then
    else
    end
    assert(true)
    local module = {}
    setmetatable(module, module_upvr)
    module.Maid = Maid_upvr.new()
    local any_new_result1_3 = Signal_upvr.new()
    module.Maid:GiveTask(any_new_result1_3)
    local any_new_result1 = Signal_upvr.new()
    module.Maid:GiveTask(any_new_result1)
    local any_new_result1_2 = Signal_upvr.new()
    module.Maid:GiveTask(any_new_result1_2)
    local any_new_result1_4 = Signal_upvr.new()
    module.Maid:GiveTask(any_new_result1_4)
    module.BulletWhizEnabled = true
    module.Local = arg1
    module.IgnoreList = {}
    module.IgnoreLocalPlayer = true
    module.OnLocalHitPlayer = any_new_result1_3
    module.OnHitSurface = any_new_result1
    module.OnQueueEmptied = any_new_result1_2
    module.OnShieldDamage = any_new_result1_4
    module.Bullets = {}
    module.LastUpdate = nil
    module.LastPlayedWhizSound = nil
    module.GravityVector = nil
    module.LifeSpan = nil
    module.Color = Color3.fromRGB(255, 235, 141)
    module._mapLastHitSurface = {}
    module._customCollidableFunc = module:_buildCustomCollidableFunc()
    return module
end
function module_upvr.Emit(arg1, arg2, arg3, arg4) -- Line 121
    local LineHandleAdornment = Instance.new("LineHandleAdornment")
    LineHandleAdornment.Adornee = Part_2_upvr
    LineHandleAdornment.AdornCullingMode = Enum.AdornCullingMode.Automatic
    LineHandleAdornment.Transparency = 0
    LineHandleAdornment.Color3 = arg1.Color
    LineHandleAdornment.Thickness = 2
    LineHandleAdornment.SizeRelativeOffset = Vector3.new(0, 0, 0)
    LineHandleAdornment.Length = 0
    LineHandleAdornment.CFrame = CFrame.new()
    LineHandleAdornment.Parent = Folder_upvr
    local tbl_5 = {}
    tbl_5[1] = arg2
    tbl_5[2] = arg3
    tbl_5[3] = arg4
    tbl_5[4] = LineHandleAdornment
    tbl_5[5] = arg1.LifeSpan
    tbl_5[6] = arg2
    local tbl_7 = {}
    for _, v in ipairs(arg1.IgnoreList) do
        tbl_7[#tbl_7 + 1] = v
    end
    tbl_5[7] = tbl_7
    arg1.Bullets[#arg1.Bullets + 1] = tbl_5
end
local tbl_2_upvr = {tbl.bullet_flyby_01, tbl.bullet_flyby_04}
local tbl_9_upvr = {}
local function _() -- Line 151, Named "getWhizPart"
    local popped = table.remove(tbl_9_upvr)
    if popped then
        return popped
    end
    local Part = Instance.new("Part")
    Part.Transparency = 1
    Part.Anchored = true
    Part.CanCollide = false
    Part.Size = Vector3.new(1, 1, 1)
    return Part
end
local function returnWhizPart_upvr(arg1) -- Line 163, Named "returnWhizPart"
    arg1.Parent = nil
    if #tbl_9_upvr < 8 then
        tbl_9_upvr[#tbl_9_upvr + 1] = arg1
    else
        arg1:Destroy()
    end
end
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
function module_upvr.PlayWhiz(arg1, arg2, arg3) -- Line 171
    local popped_2 = table.remove(tbl_9_upvr)
    local var37
    if popped_2 then
        var37 = popped_2
    else
        local Part_3 = Instance.new("Part")
        Part_3.Transparency = 1
        Part_3.Anchored = true
        Part_3.CanCollide = false
        Part_3.Size = Vector3.new(1, 1, 1)
        var37 = Part_3
    end
    var37.Position = arg2
    var37.Parent = workspace
    Audio_upvr.ObjectLocal(var37, tbl_2_upvr[math.random(1, #tbl_2_upvr)], {
        TimePosition = 0.3;
        Volume = 0.6 * (1 - arg3 / 10);
        Pitch = 1 + math.random() * 0.1 - 0.05;
    })
    task.delay(3, returnWhizPart_upvr, var37)
end
local PlayerUtils_upvr = require(ReplicatedStorage.Game.PlayerUtils)
function module_upvr.CheckWhiz(arg1, arg2) -- Line 185
    local any_getRootPart_result1_2 = PlayerUtils_upvr.getRootPart(LocalPlayer_upvr)
    if any_getRootPart_result1_2 ~= nil then
        local _1 = arg2[1]
        local Magnitude = (_1 - any_getRootPart_result1_2.Position).Magnitude
        if Magnitude < 10 and 100 < arg2[3] and 0.1 < tick() - (arg1.LastPlayedWhizSound or 0) then
            arg1:PlayWhiz(_1, Magnitude)
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            arg1.LastPlayedWhizSound = tick()
        end
    end
end
function module_upvr._buildCustomCollidableFunc(arg1) -- Line 198
    return function(arg1_2) -- Line 199
        if arg1_2:GetAttribute("InvisibleToBullets") == true then
            return false
        end
        if arg1_2.CanCollide then
            return true
        end
        if arg1._listRootPart then
            for _, v_2 in ipairs(arg1._listRootPart) do
                if arg1_2:IsDescendantOf(v_2.Parent) then
                    return true
                end
            end
        end
    end
end
local tbl_3_upvr = {
    HairAttachment = true;
    HatAttachment = true;
    FaceFrontAttachment = true;
    FaceCenterAttachment = true;
}
local CollectionService_upvr = game:GetService("CollectionService")
local GuardNPCBinder_upvr = require(ReplicatedStorage.GuardNPC.GuardNPCBinder)
local ForcefieldService_upvr = require(ReplicatedStorage.Forcefield.ForcefieldService)
local ItemSystem_upvr = require(ReplicatedStorage.Game.ItemSystem.ItemSystem)
local InventoryItemUtils_upvr = require(ReplicatedStorage.Inventory.InventoryItemUtils)
local Math_upvr = require(ReplicatedStorage.Module.Math)
local CombatUtils_upvr = require(ReplicatedStorage.Combat.CombatUtils)
local RayCast_upvr = require(ReplicatedStorage.Module.RayCast)
function module_upvr.Update(arg1) -- Line 223
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    debug.profilebegin("BulletEmitter Update")
    arg1.LastUpdate = tick()
    local Local_2 = arg1.Local
    if not Local_2 then
        Local_2 = arg1.SimulateLocal
        local var83
    end
    if Local_2 then
        local tbl_4 = {}
        local tbl_6 = {}
        var83 = nil
        if LocalPlayer_upvr.Character then
            var83 = LocalPlayer_upvr.Character.PrimaryPart
        end
        for _, v_3 in CollectionService_upvr:GetTagged("Humanoid") do
            if v_3:IsDescendantOf(workspace) then
                local RootPart = v_3.RootPart
                if RootPart and not tbl_6[RootPart] then
                    tbl_6[RootPart] = true
                    if arg1.IgnoreLocalPlayer and RootPart == var83 then
                    end
                    local var90
                    if arg1.IgnoreGuards and GuardNPCBinder_upvr:Get(RootPart.Parent) then
                        var90 = false
                    end
                    if var90 then
                        tbl_4[#tbl_4 + 1] = RootPart
                    end
                end
            end
        end
        arg1._listRootPart = tbl_4
    end
    var83 = arg1.ShieldBlockPct
    var83 = #arg1.Bullets
    local ListShields = ForcefieldService_upvr.ListShields
    if module_upvr._militaryForcefield and module_upvr._militaryForcefield.Part.Transparency < 1 and not module_upvr._militaryForcefield.Ignore then
        table.clone(ListShields)[#ListShields + 1] = module_upvr._militaryForcefield
    end
    local _ = var83
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [707.21]
    -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [707.3212]
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function module_upvr.Destroy(arg1) -- Line 546
    for i_4 = #arg1.Bullets, 1, -1 do
        local var94 = arg1.Bullets[i_4]
        var94[4]:Destroy()
        var94[4] = nil
    end
    arg1.Bullets = nil
    arg1.Maid:Destroy()
    arg1.Maid = nil
end
return module_upvr