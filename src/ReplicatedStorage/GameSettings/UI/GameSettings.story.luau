local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local GameSettingsService_upvr = require(ReplicatedStorage.GameSettings.GameSettingsService)
local gameSettingType_upvr = require(ReplicatedStorage.GameSettings.gameSettingType)
local Roact_upvr = require(ReplicatedStorage.Roact)
return function(arg1) -- Line 8
    local any_new_result1_upvr = Maid_upvr.new()
    any_new_result1_upvr:GiveTask(GameSettingsService_upvr.add({
        name = "playerMarkers";
        title = "Player Markers";
        type = gameSettingType_upvr.Checkbox;
        defaultValue = true;
        order = 42;
    }))
    local any_mount_result1_upvr = Roact_upvr.mount(Roact_upvr.createElement(require(script.Parent.GameSettings), {
        size = UDim2.new(0.8, 0, 0.8, 0);
        position = UDim2.new(0.5, 0, 0.5, 0);
        anchorPoint = Vector2.new(0.5, 0.5);
    }), arg1)
    return function() -- Line 25
        any_new_result1_upvr:DoCleaning()
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end