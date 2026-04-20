local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local module_upvr = {
    ClassName = "CrewsSurfaceGuiDisplay";
}
module_upvr.__index = module_upvr
local PersistentCrewBattleConsts_upvr = require(script.Parent.PersistentCrewBattleConsts)
local BaseObject_upvr = require(ReplicatedStorage_upvr.Std.BaseObject)
local RxInstanceUtils_upvr = require(ReplicatedStorage_upvr.Std.RxInstanceUtils)
local PersistentCrewConsts_upvr = require(ReplicatedStorage_upvr.PersistentCrew.PersistentCrewConsts)
local persistentCrewStore_upvr = require(ReplicatedStorage_upvr.PersistentCrew.persistentCrewStore)
local Interval_upvr = require(ReplicatedStorage_upvr.Std.Interval)
local Players_upvr = game:GetService("Players")
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
local CrewLeaderboard_upvr = require(ReplicatedStorage_upvr.PersistentCrewBattle.UI.CrewLeaderboard)
local createElement_upvr = Roact_upvr.createElement
local persistentCrewBattleStore_upvr = require(script.Parent.persistentCrewBattleStore)
function module_upvr.new(arg1, arg2) -- Line 19
    if not PersistentCrewBattleConsts_upvr.LEADERBOARD_DISPLAY_TYPE_ENUM:GetValueFromEnum(arg2) then
        error("Invalid displayType: "..tostring(arg2))
    end
    local any_new_result1 = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1, module_upvr)
    RxInstanceUtils_upvr.yieldForProperty(arg1, "PrimaryPart")
    local any_createBinding_result1_upvr, any_createBinding_result2_upvr = Roact_upvr.createBinding(true)
    any_new_result1.maid:GiveTask(Interval_upvr.every(1):Connect(function() -- Line 37
        local Character = Players_upvr.LocalPlayer.Character
        local any_getValue_result1_upvr = any_createBinding_result1_upvr:getValue()
        local function _(arg1_3) -- Line 40, Named "setCurrEnabled"
            if arg1_3 ~= any_getValue_result1_upvr then
                any_createBinding_result2_upvr(arg1_3)
            end
        end
        if not Character then
            if any_getValue_result1_upvr ~= false then
                any_createBinding_result2_upvr(false)
            end
        else
            local PrimaryPart = Character.PrimaryPart
            if not PrimaryPart then
                if any_getValue_result1_upvr ~= false then
                    any_createBinding_result2_upvr(false)
                end
                return
            end
            if PersistentCrewBattleConsts_upvr.UNRENDER_LEADERBOARD_DISPLAY_DISTANCE <= (PrimaryPart.Position - arg1.PrimaryPart.Position).Magnitude then
                if any_getValue_result1_upvr ~= false then
                    any_createBinding_result2_upvr(false)
                end
                return
            end
            if any_getValue_result1_upvr ~= true then
                any_createBinding_result2_upvr(true)
            end
        end
    end))
    local var26
    if any_new_result1.obj.PrimaryPart.Size.Y < 30 then
        var26 = 80
    else
        var26 = 20
    end
    local tbl_2 = {}
    local tbl = {}
    tbl.displayType = arg2
    tbl.aspectRatio = any_new_result1.obj.PrimaryPart.Size.X / any_new_result1.obj.PrimaryPart.Size.Y
    function tbl.attemptViewClanId(arg1_2) -- Line 27
        ReplicatedStorage_upvr:FindFirstChild(PersistentCrewConsts_upvr.VIEW_CLAN_REMOTE_NAME):FireServer(arg1_2)
        persistentCrewStore_upvr:dispatch({
            type = "setGroupVisible";
            value = true;
        })
    end
    tbl_2.Display = createElement_upvr(RoactRodux_upvr.connect(function(arg1_4, arg2_2) -- Line 65
        local var24
        if arg2 == PersistentCrewBattleConsts_upvr.LEADERBOARD_DISPLAY_TYPE_ENUM.CrewsInServer then
            var24 = arg1_4.crewsInServerDisplayInfo
        elseif arg2 == PersistentCrewBattleConsts_upvr.LEADERBOARD_DISPLAY_TYPE_ENUM.Leaderboard then
            var24 = arg1_4.leaderboardInfo
        else
            error("Invalid displayType: "..tostring(arg2))
        end
        return {
            leaderboardInfo = var24;
        }
    end)(CrewLeaderboard_upvr), tbl)
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
        store = persistentCrewBattleStore_upvr;
    }, {createElement_upvr("SurfaceGui", {
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        ResetOnSpawn = false;
        Adornee = any_new_result1.obj.PrimaryPart;
        Face = Enum.NormalId.Front;
        SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
        PixelsPerStud = var26;
        Enabled = any_createBinding_result1_upvr;
    }, tbl_2)}), Players_upvr.LocalPlayer.PlayerGui, "CrewsInServerGui")
    any_new_result1.maid:GiveTask(function() -- Line 104
        Roact_upvr.unmount(any_mount_result1_upvr)
    end)
    return any_new_result1
end
return module_upvr