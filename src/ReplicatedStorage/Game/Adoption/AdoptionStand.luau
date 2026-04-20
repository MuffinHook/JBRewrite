local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {}
module_upvr.__index = module_upvr
module_upvr.__ClassName = "AdoptionStand"
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local AdoptionStandConsts_upvr = require(script.Parent.AdoptionStandConsts)
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
local PlayerUtils_upvr = require(ReplicatedStorage.Game.PlayerUtils)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local AdoptionStandUI_upvr = require(script.Parent.AdoptionStandUI)
local AdoptionSystem_upvr = require(script.Parent.AdoptionSystem)
local DogConsts_upvr = require(ReplicatedStorage.Game.Dog.DogConsts)
local CircleAction_upvr = require(ReplicatedStorage.Module.UI).CircleAction
function module_upvr.new(arg1) -- Line 18
    local module_upvr_2 = {}
    setmetatable(module_upvr_2, module_upvr)
    module_upvr_2._maid = Maid_upvr.new()
    module_upvr_2._breedIdValue = arg1:WaitForChild(AdoptionStandConsts_upvr.BREED_ID_VALUE_NAME)
    module_upvr_2._adoptRemote = arg1:WaitForChild(AdoptionStandConsts_upvr.ADOPT_REMOTE_NAME)
    local tbl_upvr = {}
    tbl_upvr.Part = arg1
    tbl_upvr.Timed = false
    tbl_upvr.Dist = 8
    function tbl_upvr.Callback(arg1_2, arg2) -- Line 26, Named "action"
        if arg2 then
            local any_GetBreedId_result1 = module_upvr_2:GetBreedId()
            module_upvr_2._maid.walkAwayLoop = Interval_upvr.every(1):Connect(function() -- Line 29
                local any_getRootPart_result1 = PlayerUtils_upvr.getRootPart(LocalPlayer_upvr)
                if any_getRootPart_result1 and 16 < (any_getRootPart_result1.Position - arg1.Position).Magnitude and AdoptionStandUI_upvr.isOpen() then
                    AdoptionStandUI_upvr.close()
                end
            end)
            module_upvr_2._maid.onClickAdopt = AdoptionStandUI_upvr.getOnClickAdoptSignal():Connect(function() -- Line 40
                module_upvr_2._adoptRemote:FireServer(AdoptionStandUI_upvr.getName())
                AdoptionStandUI_upvr.close()
            end)
            module_upvr_2._maid.onClosed = AdoptionStandUI_upvr.getOnClosedSignal():Connect(function() -- Line 45
                module_upvr_2._maid.walkAwayLoop = nil
                module_upvr_2._maid.onClosed = nil
                module_upvr_2._maid.onClickAdopt = nil
            end)
            local any_doesOwn_result1 = AdoptionSystem_upvr.doesOwn(any_GetBreedId_result1)
            local var19
            if not any_doesOwn_result1 then
                var19 = DogConsts_upvr.PRICE[any_GetBreedId_result1]
            end
            AdoptionStandUI_upvr.setName(AdoptionSystem_upvr.getDogName(any_GetBreedId_result1) or "")
            AdoptionStandUI_upvr.setTitle(DogConsts_upvr.TITLE[any_GetBreedId_result1]:upper())
            AdoptionStandUI_upvr.setImageId(DogConsts_upvr.IMAGE_ID[any_GetBreedId_result1])
            AdoptionStandUI_upvr.setDescriptionTeam(DogConsts_upvr.OPT_TEAM[any_GetBreedId_result1])
            AdoptionStandUI_upvr.setPrice(var19)
            AdoptionStandUI_upvr.setFirstAdopt(not any_doesOwn_result1)
            AdoptionStandUI_upvr.open()
            return true
        end
    end
    function tbl_upvr.PreUpdateFun(arg1_3) -- Line 65, Named "preUpdateFun"
        arg1_3.Enabled = not AdoptionStandUI_upvr.isOpen()
    end
    tbl_upvr.PreUpdatePeriod = 0.5
    CircleAction_upvr.Add(tbl_upvr, arg1)
    module_upvr_2._maid:GiveTask(function() -- Line 77
        CircleAction_upvr.Remove(arg1)
    end)
    module_upvr_2._maid:GiveTask(module_upvr_2._breedIdValue.Changed:Connect(function() -- Line 81, Named "updateSpec"
        tbl_upvr.Name = "Adopt %s":format(DogConsts_upvr.TITLE[module_upvr_2:GetBreedId()])
    end))
    tbl_upvr.Name = "Adopt %s":format(DogConsts_upvr.TITLE[module_upvr_2:GetBreedId()])
    return module_upvr_2
end
function module_upvr.GetBreedId(arg1) -- Line 90
    return arg1._breedIdValue.Value
end
function module_upvr.Destroy(arg1) -- Line 93
    local _maid = arg1._maid
    local var23
    if _maid == nil then
        var23 = false
    else
        var23 = true
    end
    assert(var23)
    arg1._maid = nil
    _maid:Destroy()
end
return module_upvr