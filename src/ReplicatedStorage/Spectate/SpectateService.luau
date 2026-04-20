local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local SpectateConsts_upvr = require(script.Parent.SpectateConsts)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local CurrentCamera_upvr = workspace.CurrentCamera
local SOME_upvr = ReplicatedStorage:WaitForChild(SpectateConsts_upvr.SPECTATE_OTHER_REMOTE_NAME)
local module_2_upvr = {
    _tree = nil;
    guiMaid = Maid_upvr.new();
    active = false;
    spectateMaid = nil;
    onCharacterSpectated = require(ReplicatedStorage.Std.Signal).new();
}
function module_2_upvr.trackCharacter(arg1) -- Line 21
    if arg1 then
        CurrentCamera_upvr.CameraSubject = arg1:FindFirstChild("Humanoid")
    else
        CurrentCamera_upvr.CameraSubject = nil
    end
    module_2_upvr.onCharacterSpectated:Fire(arg1)
    SOME_upvr:FireServer(Players_upvr:GetPlayerFromCharacter(arg1))
end
local CollectionService_upvr = game:GetService("CollectionService")
local function getAllCharacters_upvr() -- Line 31, Named "getAllCharacters"
    local module = {}
    for _, v in CollectionService_upvr:GetTagged(SpectateConsts_upvr.SPECTATE_TAG_NAME) do
        table.insert(module, v)
    end
    local Character = Players_upvr.LocalPlayer.Character
    if table.find(module, Character) == nil then
        table.insert(module, Character)
    end
    table.sort(module, function(arg1, arg2) -- Line 41
        local var20
        if arg1.Name >= arg2.Name then
            var20 = false
        else
            var20 = true
        end
        return var20
    end)
    return module
end
function module_2_upvr.findNewTarget() -- Line 46
    local getAllCharacters_upvr_result1_3 = getAllCharacters_upvr()
    local var22
    if 0 >= #getAllCharacters_upvr_result1_3 then
        var22 = false
    else
        var22 = true
    end
    assert(var22, "No characters to spectate")
    var22 = math.random(1, #getAllCharacters_upvr_result1_3)
    var22 = module_2_upvr
    var22 = var22.trackCharacter
    var22(getAllCharacters_upvr_result1_3[var22])
end
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function module_2_upvr.spectate(arg1) -- Line 52
    module_2_upvr.active = true
    local var24_upvw
    if var24_upvw then
        var24_upvw:DoCleaning()
    else
        var24_upvw = Maid_upvr.new()
        module_2_upvr.spectateMaid = var24_upvw
    end
    if arg1 then
        module_2_upvr.trackCharacter(arg1)
    else
        module_2_upvr.findNewTarget()
    end
    local CameraSubject_2 = CurrentCamera_upvr.CameraSubject
    if CameraSubject_2 ~= nil and CameraSubject_2:IsA("Humanoid") then
        var24_upvw.humanoidDied = CameraSubject_2.Died:Connect(function() -- Line 77
            module_2_upvr.findNewTarget()
        end)
    end
    var24_upvw:GiveTask(CurrentCamera_upvr:GetAttributeChangedSignal("CameraSubject"):Connect(function() -- Line 73, Named "handleHumanoid"
        local CameraSubject_3 = CurrentCamera_upvr.CameraSubject
        if CameraSubject_3 ~= nil and CameraSubject_3:IsA("Humanoid") then
            var24_upvw.humanoidDied = CameraSubject_3.Died:Connect(function() -- Line 77
                module_2_upvr.findNewTarget()
            end)
        end
    end))
    var24_upvw:GiveTask(Interval_upvr.every(1):Connect(function() -- Line 67, Named "checkIfNeedNewTarget"
        if CurrentCamera_upvr.CameraSubject and CurrentCamera_upvr.CameraSubject:IsDescendantOf(workspace) then
        else
            module_2_upvr.findNewTarget()
        end
    end))
    var24_upvw:GiveTask(function() -- Line 86
        module_2_upvr.active = false
    end)
end
function module_2_upvr.unspectate() -- Line 90
    if module_2_upvr.spectateMaid then
        module_2_upvr.spectateMaid:DoCleaning()
    end
    local Character_2 = Players_upvr.LocalPlayer.Character
    if not Character_2 then
    else
        local Humanoid = Character_2:FindFirstChild("Humanoid")
        if not Humanoid then return end
        CurrentCamera_upvr.CameraSubject = Humanoid
        SOME_upvr:FireServer()
    end
end
local createElement_upvr = Roact_upvr.createElement
local SpectateSelector_upvr = require(ReplicatedStorage.Spectate.UI.SpectateSelector)
local function getComponent_upvr(arg1) -- Line 105, Named "getComponent"
    return createElement_upvr("ScreenGui", {
        ResetOnSpawn = false;
        IgnoreGuiInset = true;
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    }, {
        SpectateSelector = createElement_upvr(SpectateSelector_upvr, arg1);
    })
end
function module_2_upvr.showGui() -- Line 114
    module_2_upvr.guiMaid:DoCleaning()
    local function _(arg1) -- Line 116, Named "getNextCharacter"
        local getAllCharacters_upvr_result1_2 = getAllCharacters_upvr()
        return getAllCharacters_upvr_result1_2[(table.find(getAllCharacters_upvr_result1_2, CurrentCamera_upvr.CameraSubject.Parent) + arg1 - 1) % #getAllCharacters_upvr_result1_2 + 1]
    end
    local tbl_upvr = {
        size = UDim2.fromScale(1, 0.075);
        position = UDim2.fromScale(0.5, 0.75);
        onClickNext = function() -- Line 126, Named "onClickNext"
            local getAllCharacters_upvr_result1 = getAllCharacters_upvr()
            module_2_upvr.spectate(getAllCharacters_upvr_result1[(table.find(getAllCharacters_upvr_result1, CurrentCamera_upvr.CameraSubject.Parent) + 1 - 1) % #getAllCharacters_upvr_result1 + 1])
        end;
        onClickPrev = function() -- Line 129, Named "onClickPrev"
            local getAllCharacters_upvr_result1_4 = getAllCharacters_upvr()
            module_2_upvr.spectate(getAllCharacters_upvr_result1_4[(table.find(getAllCharacters_upvr_result1_4, CurrentCamera_upvr.CameraSubject.Parent) + -1 - 1) % #getAllCharacters_upvr_result1_4 + 1])
        end;
        title = "N/A";
    }
    local any_mount_result1_upvr = Roact_upvr.mount(getComponent_upvr(tbl_upvr), Players_upvr.LocalPlayer:FindFirstChild("PlayerGui"), "Spectate")
    module_2_upvr.guiMaid:GiveTask(function() -- Line 135
        Roact_upvr.unmount(any_mount_result1_upvr)
    end)
    local function updateCameraSubject() -- Line 138
        local CameraSubject = CurrentCamera_upvr.CameraSubject
        if CameraSubject ~= nil and CameraSubject:IsA("Humanoid") then
            local any_GetPlayerFromCharacter_result1 = Players_upvr:GetPlayerFromCharacter(CameraSubject.Parent)
            if any_GetPlayerFromCharacter_result1 then
                tbl_upvr.title = any_GetPlayerFromCharacter_result1.DisplayName
            else
                tbl_upvr.title = CameraSubject.Parent.Name
            end
            Roact_upvr.update(any_mount_result1_upvr, getComponent_upvr(tbl_upvr))
        end
    end
    module_2_upvr.guiMaid:GiveTask(CurrentCamera_upvr:GetPropertyChangedSignal("CameraSubject"):Connect(updateCameraSubject))
    updateCameraSubject()
    module_2_upvr.guiMaid:GiveTask(module_2_upvr.unspectate)
    return module_2_upvr.hideGui
end
function module_2_upvr.hideGui() -- Line 157
    module_2_upvr.guiMaid:DoCleaning()
end
return module_2_upvr