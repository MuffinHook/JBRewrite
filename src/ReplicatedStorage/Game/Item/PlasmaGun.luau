local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage.Std.Audio)
local GeomUtils_upvr = require(ReplicatedStorage.Std.GeomUtils)
local Gun_upvr = require(script.Parent.Gun)
local random_state_upvr = Random.new()
local function _() -- Line 15, Named "RandomBilateral"
    return random_state_upvr:NextNumber() * 2 - 1
end
local function _() -- Line 18, Named "RandomVector"
    return GeomUtils_upvr.randomPointOnSphere()
end
local module_upvr = {
    __ClassName = "PlasmaGun";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Gun_upvr)
function module_upvr.new(arg1, arg2, arg3) -- Line 26
    local any_new_result1 = Gun_upvr.new(arg1, arg2, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1.ListZap = {}
    return any_new_result1
end
function module_upvr.UpdateZap(arg1, arg2) -- Line 33
    local Origin = arg2.Origin
    local Target = arg2.Target
    local Width = arg2.Width
    local ceiled = math.ceil((Target - Origin).Magnitude / arg2.PerDistance)
    local var14 = 0.3333333333333333 + 0.6666666666666666 * (tick() - arg2.BornAt) / math.min(1 / arg1.Config.FireFreq, 0.1)
    local LastPositionIndex = arg2.LastPositionIndex
    local var17
    for i = LastPositionIndex, var17 do
        if arg2.NextPosition == nil then
            local var18 = i / ceiled
            local var19 = Origin * (1 - var18) + Target * var18
            if i < ceiled then
                var19 += GeomUtils_upvr.randomPointInSphere() * arg2.OffsetRadius
            end
            arg2.NextPosition = var19
            local LastPosition = arg2.LastPosition
            local Magnitude = (var19 - LastPosition).Magnitude
            local Part = Instance.new("Part")
            Part.Anchored = true
            Part.CanCollide = false
            Part.Material = Enum.Material.Neon
            Part.Transparency = 0.1
            Part.Color = Color3.fromRGB(173, 110, 125)
            Part.TopSurface = 0
            Part.BottomSurface = 0
            Part.Size = Vector3.new(Width, Width, Magnitude)
            Part.CFrame = CFrame.new(LastPosition, var19) * CFrame.new(0, 0, -Magnitude * 0.5)
            Part.Parent = workspace.Items
            local SurfaceLight = Instance.new("SurfaceLight")
            SurfaceLight.Angle = 81
            SurfaceLight.Brightness = 2.5
            SurfaceLight.Color = Color3.fromRGB(173, 110, 125)
            SurfaceLight.Face = Enum.NormalId.Bottom
            SurfaceLight.Range = 16
            SurfaceLight.Shadows = false
            SurfaceLight.Parent = Part
            arg2.Part = Part
            table.insert(arg2.Parts, Part)
        end
        if i == LastPositionIndex then
            local clamped = math.clamp(var14 * ceiled - i + 1, 0, 1)
            local LastPosition_2 = arg2.LastPosition
            local var26 = arg2.NextPosition * clamped + LastPosition_2 * (1 - clamped)
            local Part_2 = arg2.Part
            local Magnitude_2 = (var26 - LastPosition_2).Magnitude
            Part_2.Size = Vector3.new(Width, Width, Magnitude_2)
            Part_2.CFrame = CFrame.new(LastPosition_2, var26) * CFrame.new(0, 0, -Magnitude_2 * 0.5)
        else
            arg2.LastPosition = arg2.NextPosition
            arg2.NextPosition = nil
        end
    end
    arg2.LastPositionIndex = math.ceil(var14 * ceiled)
    if 1 > var14 then
        var17 = false
    else
        var17 = true
    end
    return var17
end
function module_upvr.DestroyZap(arg1, arg2) -- Line 106
    for _, v in ipairs(arg2.Parts) do
        v:Destroy()
    end
    arg2.Parts = nil
end
function module_upvr.DestroyZaps(arg1) -- Line 112
    for i_3 = #arg1.ListZap, 1, -1 do
        table.remove(arg1.ListZap, i_3)
        arg1:DestroyZap(arg1.ListZap[i_3])
    end
end
function module_upvr.UpdateZaps(arg1) -- Line 119
    for i_4 = #arg1.ListZap, 1, -1 do
        local var36 = arg1.ListZap[i_4]
        if arg1:UpdateZap(var36) then
            table.remove(arg1.ListZap, i_4)
            arg1:DestroyZap(var36)
        end
    end
end
function module_upvr.Heartbeat(arg1) -- Line 129
    arg1:UpdateZaps()
end
function module_upvr.Zap(arg1, arg2, arg3, arg4, arg5, arg6) -- Line 132
    local tbl = {}
    tbl.Width = arg4
    tbl.OffsetRadius = arg5
    tbl.PerDistance = arg6
    tbl.Origin = arg2
    tbl.Target = arg3
    tbl.LastPosition = tbl.Origin
    tbl.NextPosition = nil
    tbl.LastPositionIndex = 1
    tbl.Parts = {}
    tbl.BornAt = tick()
    table.insert(arg1.ListZap, tbl)
end
local CharacterUtils_upvr = require(ReplicatedStorage.Std.CharacterUtils)
local GunUtils_upvr = require(ReplicatedStorage.Game.GunShop.GunUtils)
local Raycast_upvr = require(ReplicatedStorage.Std.Raycast)
local GunSystemConsts_upvr = require(ReplicatedStorage.Game.ItemSystem.GunSystemConsts)
function module_upvr.ShootOther(arg1) -- Line 147
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local Tip = arg1.Tip
    arg1.SpringItemOffset:Accelerate(Vector3.new(0, 0, 30) + GeomUtils_upvr.randomPointOnSphere() * 3)
    arg1.SpringItemRotation:Accelerate(Vector3.new(-1, 2, 0).Unit * 12 + GeomUtils_upvr.randomPointOnSphere() * 2)
    local RaycastParams_new_result1 = RaycastParams.new()
    RaycastParams_new_result1.FilterDescendantsInstances = arg1.IgnoreList
    RaycastParams_new_result1.FilterType = Enum.RaycastFilterType.Exclude
    for _ = 1, arg1.Config.BulletsPerShot or 1 do
        local TipDirection = arg1.TipDirection
        if not TipDirection then
            TipDirection = Tip.CFrame.LookVector
        end
        if not arg1.TipDirection then
            warn("No cached tipDirection")
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        local any_getBulletDirection_result1 = GunUtils_upvr.getBulletDirection(Tip.CFrame, TipDirection, arg1.Config.BulletSpread or 0)
        local any_collidable_result1 = Raycast_upvr.collidable(Tip.Position, any_getBulletDirection_result1, arg1.Config.Range, RaycastParams_new_result1, function(arg1_2) -- Line 157, Named "collidableFunc"
            if arg1_2:GetAttribute("InvisibleToBullets") == true then
                return false
            end
            if CharacterUtils_upvr.getAncestorPartHumanoid(arg1_2) then
                return true
            end
            return arg1_2.CanCollide
        end)
        if any_collidable_result1 then
            local Instance = any_collidable_result1.Instance
            local _ = any_collidable_result1.Position
        else
        end
        if not arg1.Local then
        end
        if arg1.SimulateLocal and Instance and CharacterUtils_upvr.getAncestorPartHumanoid(Instance) then
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            arg1.inventoryItemValue:FindFirstChild(GunSystemConsts_upvr.DAMAGE_REMOTE_NAME):FireServer(Tip.Position + any_getBulletDirection_result1 * arg1.Config.Range, CharacterUtils_upvr.getAncestorPartHumanoid(Instance))
            if arg1.CrossHair then
                arg1.CrossHair:Flare()
            end
            if 0.1 < os.clock() - (arg1.soundDebounce or 0) then
                Audio_upvr.ObjectLocal(arg1.Tip, arg1.Config.Sound.bullet_impact_bass, {
                    TimePosition = 0;
                    Volume = 1;
                    Pitch = 1;
                })
                arg1.soundDebounce = os.clock()
            end
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        arg1:Zap(Tip.Position, Tip.Position + any_getBulletDirection_result1 * arg1.Config.Range, 0.2, 0.5, 6)
    end
    arg1:Zap(Tip.Position, Tip.CFrame * Vector3.new(0, 0, -4) + GeomUtils_upvr.randomPointOnSphere() * 3, 0.06, 0.2, 1)
    arg1:Zap(Tip.Position, Tip.CFrame * Vector3.new(0, 0, -4) + GeomUtils_upvr.randomPointOnSphere() * 3, 0.06, 0.2, 1)
    arg1:Zap(Tip.Position, Tip.CFrame * Vector3.new(0, 0, -4) + GeomUtils_upvr.randomPointOnSphere() * 3, 0.06, 0.2, 1)
end
function module_upvr.ShootSound(arg1, arg2) -- Line 216
    if not arg2 then
        Audio_upvr.ObjectLocal(arg1.Tip, 4752401149)
    end
end
function module_upvr.ReloadDropAmmoVisual(arg1) -- Line 221
end
function module_upvr.ReloadRefillAmmoVisual(arg1) -- Line 222
end
function module_upvr.ReloadDropAmmoSound(arg1) -- Line 223
    Audio_upvr.ObjectLocal(arg1.Tip, 16652902841, {
        Volume = 1;
    })
end
function module_upvr.ReloadRefillAmmoSound(arg1) -- Line 226
end
function module_upvr.Unequip(arg1) -- Line 227
    Gun_upvr.Unequip(arg1)
    arg1:DestroyZaps()
end
return module_upvr