-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMgCkRvQ2xlYW5pbmcHdW5tb3VudANuZXcDYWRkBG5hbWUFdGl0bGUEdHlwZQxkZWZhdWx0VmFsdWUFb3JkZXINcGxheWVyTWFya2Vycw5QbGF5ZXIgTWFya2VycwhDaGVja2JveAhHaXZlVGFzawVtb3VudA1jcmVhdGVFbGVtZW50B3JlcXVpcmUMR2FtZVNldHRpbmdzBnNjcmlwdAZQYXJlbnQEc2l6ZQhwb3NpdGlvbgthbmNob3JQb2ludAVVRGltMgdWZWN0b3IyBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQNTdGQETWFpZAVSb2FjdBNHYW1lU2V0dGluZ3NTZXJ2aWNlD2dhbWVTZXR0aW5nVHlwZQADAgADAAAACvsAAAC8AABRAAAAAJ8AAgH7AAEATQAAEgEAAAD7AQIAnwACAYIAAQACAwEDAgAZAAEYAAAAAAEAAAAAARoAAAAACwEEAAAATvsBAABNAQHvAAAAAJ8BAQL7BAEATQQEvwEAAADiBQcAbwYIADAGBVoCAAAAbwYJADAGBZoDAAAA+wYCAE0GBvAKAAAAMAYFcQQAAACpBgEAMAYFlgUAAACMBioAMAYFRAYAAACfBAIAvAIB/QsAAACfAgAB+wIDAE0CAuQMAAAA+wMDAE0DA8oNAAAApAQPAAAA4ECkBhIAAAAQQU0GBiQTAAAATQUGrhAAAACfBAIC4gUXAKQGGQAAAICBbwcaAIwIAABvCRoAjAoAAJ8GBQIwBgUPFAAAAKQGGQAAAICBbwcbAIwIAABvCRsAjAoAAJ8GBQIwBgXbFQAAAKQGHQAAAMCBbwcbAG8IGwCfBgMCMAYFCBYAAACfAwMCUgQAAJ8CAwLZAwAAEgABABICAwASAAIAggMCAB4DAwMEAwUDBgMHAwgDCQUFAgMEBQYDCgMLAwwDDQMOAw8DEAQAAOBAAxEDEgQAABBBAxMDFAMVAxYFAxQVFgMXBAAAgIECmpmZmZmZ6T8CAAAAAAAA4D8DGAQAAMCBAQAIAAEYAAAAAAEAAAABAAABAAABAAAAAAEAAAEAAPsAAAAHAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAQAAAAAAAAAAAQAAAAAAAP0F+ggAAAAACQAAAAAGAAABAgAnowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAoQYAAABNAgJ2BwAAAJ8BAgKkAgUAAABAQE0DACEIAAAAnwICAqQDBQAAAEBATQQArgkAAABNBASzCgAAAJ8DAgKkBAUAAABAQE0FAK4JAAAATQUFEwsAAACfBAICwAUMABIAAQASAAMAEgAEABIAAgCCBQIADQMZBAAAAEADGgMbAxAEAABAQAMcAx0DHgMRAx8DIAYBAQEBAAEYAAAAAAAAAAEAAAAAAAABAAAAAAIAAAAAAAABAAAAAAAAAgAAAAAAAQAAAAACE0sVAG3Ax1/AD3fVK+jB6WNTAnQhj38B

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:07
-- Luau version 6, Types version 3
-- Time taken: 0.001942 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local GameSettingsService_upvr = require(ReplicatedStorage.GameSettings.GameSettingsService)
local gameSettingType_upvr = require(ReplicatedStorage.GameSettings.gameSettingType)
local Roact_upvr = require(ReplicatedStorage.Roact)
return function(arg1) -- Line 8
    --[[ Upvalues[4]:
        [1]: Maid_upvr (readonly)
        [2]: GameSettingsService_upvr (readonly)
        [3]: gameSettingType_upvr (readonly)
        [4]: Roact_upvr (readonly)
    ]]
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
        --[[ Upvalues[3]:
            [1]: any_new_result1_upvr (readonly)
            [2]: Roact_upvr (copied, readonly)
            [3]: any_mount_result1_upvr (readonly)
        ]]
        any_new_result1_upvr:DoCleaning()
        Roact_upvr.unmount(any_mount_result1_upvr)
    end
end