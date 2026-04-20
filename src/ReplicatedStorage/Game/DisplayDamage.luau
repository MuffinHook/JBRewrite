local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module_upvr = {}
local waitForChild_upvr = require(ReplicatedStorage_upvr.Std.waitForChild)
function module_upvr.init() -- Line 8
    waitForChild_upvr(ReplicatedStorage_upvr, "DisplayDamageDraw"):andThen(function(arg1) -- Line 9
        arg1.OnClientEvent:Connect(module_upvr.draw)
    end)
end
local tbl_upvr = {}
local GunSystemConsts_upvr = require(ReplicatedStorage_upvr.Game.ItemSystem.GunSystemConsts)
local Promise_upvr = require(ReplicatedStorage_upvr.Std.Promise)
function module_upvr.draw(arg1, arg2, arg3, arg4) -- Line 13
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var8 = arg4
    if not var8 then
        var8 = {}
    end
    local var9 = var8
    local isVehicleDamage = var9.isVehicleDamage
    local didPopVehicleTires = var9.didPopVehicleTires
    if isVehicleDamage then
        if var9.isHeadshot == nil then
            if var9.isWallbang ~= nil then
            else
            end
        end
        assert(true, "Vehicle damage cannot be headshot or wallbang")
    else
        if didPopVehicleTires ~= nil then
        else
        end
        assert(true, "Non-vehicle damage cannot pop vehicle tires")
    end
    local var12_upvw = tbl_upvr[arg1]
    if not var12_upvw then
        local clone = ReplicatedStorage_upvr.Resource.ItemSystem.Damage.Arrows:Clone()
        clone.Archivable = false
        clone.Parent = arg2
        local clone_2 = ReplicatedStorage_upvr.Resource.ItemSystem.Damage.DamageBillboard:Clone()
        clone_2.Archivable = false
        clone_2.Parent = arg2
        var12_upvw = {
            promise = nil;
            arrowsGui = clone;
            billboardGui = clone_2;
            totalDamageDealt = 0;
            firstDamageTime = os.clock();
            realDamage = 0;
        }
        tbl_upvr[arg1] = var12_upvw
    end
    local function _() -- Line 48, Named "displayDPS"
        local var16 = var12_upvw
        var16.realDamage += arg3
        local var17 = os.clock() - var12_upvw.firstDamageTime
        print("real damage, time, dps: ", var12_upvw.realDamage, var17, var12_upvw.realDamage / var17)
    end
    var12_upvw.totalDamageDealt += math.floor(arg3 + 0.5)
    var12_upvw.arrowsGui:Emit(5)
    var12_upvw.billboardGui.TextLabel.Text = tostring(var12_upvw.totalDamageDealt)
    var12_upvw.billboardGui.TextLabel.TextLabel.Text = var12_upvw.billboardGui.TextLabel.Text
    if isVehicleDamage then
        if didPopVehicleTires then
            var12_upvw.billboardGui.TextLabel.TextColor3 = GunSystemConsts_upvr.VEHICLE_TIRE_POP_DAMAGE_DISPLAY_COLOR
        elseif true then
            var12_upvw.billboardGui.TextLabel.TextColor3 = GunSystemConsts_upvr.VEHICLE_DAMAGE_DISPLAY_COLOR
        end
        var12_upvw.billboardGui.TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
        var12_upvw.billboardGui.TextLabel.TextLabel.TextColor3 = Color3.new(0, 0, 0)
        var12_upvw.billboardGui.TextLabel.TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    else
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        if var9.isHeadshot then
            var12_upvw.billboardGui.TextLabel.TextColor3 = GunSystemConsts_upvr.HEADSHOT_DAMAGE_DISPLAY_COLOR
        else
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            if var9.isWallbang then
                var12_upvw.billboardGui.TextLabel.TextColor3 = GunSystemConsts_upvr.WALLBANG_DAMAGE_DISPLAY_COLOR
            else
                var12_upvw.billboardGui.TextLabel.TextColor3 = GunSystemConsts_upvr.DEFAULT_DAMAGE_DISPLAY_COLOR
            end
        end
    end
    if var12_upvw.promise then
        var12_upvw.promise:cancel()
        var12_upvw.promise = nil
    end
    var12_upvw.promise = Promise_upvr.delay(1):andThen(function() -- Line 82
        var12_upvw.arrowsGui:Destroy()
        var12_upvw.billboardGui:Destroy()
        tbl_upvr[arg1] = nil
    end)
end
return module_upvr