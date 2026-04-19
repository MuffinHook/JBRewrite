-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMdGHF1ZXJ5Q3VycmVudFN0YW5kaW5nSG9tZRRfY3VycmVudFN0YW5kaW5nSG9tZQlvbkVudGVyZWQERmlyZQhvbkV4aXRlZAVTdGFydAVldmVyeQdDb25uZWN0BGluaXQLZ2V0Um9vdFBhcnQIUG9zaXRpb24GaXBhaXJzBkdldEFsbBZJc1BvaW50SW5TdGFuZGluZ1ByaXNtBGdhbWUHUGxheWVycwpHZXRTZXJ2aWNlC0xvY2FsUGxheWVyEVJlcGxpY2F0ZWRTdG9yYWdlB3JlcXVpcmUDU3RkCEludGVydmFsC1BsYXllclV0aWxzBEdhbWUGU2lnbmFsCkhvbWVCaW5kZXIGc2NyaXB0BlBhcmVudANuZXcABAUAAQAAACD7AAAATQAAXAAAAACfAAEC+wEAAE0BAesBAAAA8QEXAAAAAAD7AQAATQEB6wEAAAD7AgAAMAAC6wEAAAAOAAgA+wIAAE0CAgICAAAAUgQAALwCAt0DAAAAnwIDAYIAAQD7AgAATQICTwQAAABSBAEAvAIC3QMAAACfAgMBggABAAUDAQMCAwMDBAMFABIAARgAAAAAAQAAAAABAAABAAABAQAAAAAAAAACAAAAAAAAAxMAAAAAAwADAAAAD/sAAAC8AAAcAAAAAJ8AAgH7AAEATQAAxAEAAABvAQIAnwACAsACAwASAgIAvAAAxwQAAACfAAMBggABAAUDBgMHAgAAAAAAANA/BgADCAEADgkBGAAAAAADAAAAAAAAAAAADA8AAAAACgADAAAAGvsAAABNAAAbAAAAAPsBAQCfAAICKwABAIIAAQBNAQA7AQAAAKQCAwAAACBA+wMCALwDA9AEAAAAnwMCAJ8CAARRAgYAUgkBALwHBuUFAAAAnwcDAg4HAQCCBgIAbgL5/wIAAICCAAEABgMKAwsDDAQAACBAAw0DDgAgAQEYAAAAAAABAQIAAQAAAAAAAAABAAAAAAH+AAUhAAAAAAkAAAECAEmjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCTQEAMQQAAACkAgEAAAAAQG8EBQC8AgIWAwAAAJ8CAwKkAwcAAABgQE0EAqEIAAAATQQErAkAAACfAwICpAQHAAAAYEBNBgK9CwAAAE0FBqYKAAAAnwQCAqQFBwAAAGBATQYCoQgAAABNBgYfDAAAAJ8FAgKkBgcAAABgQKQIDwAAAOBATQgIJBAAAABNBwg1DQAAAJ8GAgL/BwQAAAAAAMYIAAAwCAfrEQAAAE0IBe8SAAAAnwgBAjAIBwITAAAATQgF7xIAAACfCAECMAgHTxQAAADACBUAEgAGABIAAwASAAcAMAgHExYAAADACBcAEgAEABIAAQASAAYAMAgHXBgAAACCBwIAGQMPBAAAAEADEAMRAxIDEwMUBAAAYEADFQMWAxcDGAMZAxoDGwQAAOBAAxwDAgMdAwMDBQYBAwkGAgMBAgECAQABGAAAAAAAAAABAAEAAAAAAAEAAAAAAAABAAAAAAAAAQAAAAAAAAIAAAAAAAAAAAIAAQAAAQAAAAABAAAAAAEAAAAAABIAAAAAAAwBAAAAAAPgRsxQb/lWwkbfxG1l4kCBkF7bJNKCplE=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:49
-- Luau version 6, Types version 3
-- Time taken: 0.002577 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local HomeBinder_upvr = require(script.Parent.HomeBinder)
local module_upvr = {
    _currentStandingHome = nil;
    onEntered = Signal.new();
    onExited = Signal.new();
}
local Interval_upvr = require(ReplicatedStorage.Std.Interval)
function module_upvr.init() -- Line 14
    --[[ Upvalues[3]:
        [1]: HomeBinder_upvr (readonly)
        [2]: Interval_upvr (readonly)
        [3]: module_upvr (readonly)
    ]]
    HomeBinder_upvr:Start()
    Interval_upvr.every(0.25):Connect(function() -- Line 18
        --[[ Upvalues[1]:
            [1]: module_upvr (copied, readonly)
        ]]
        local any_queryCurrentStandingHome_result1 = module_upvr.queryCurrentStandingHome()
        if module_upvr._currentStandingHome ~= any_queryCurrentStandingHome_result1 then
            module_upvr._currentStandingHome = any_queryCurrentStandingHome_result1
            if any_queryCurrentStandingHome_result1 then
                module_upvr.onEntered:Fire(any_queryCurrentStandingHome_result1)
                return
            end
            module_upvr.onExited:Fire(module_upvr._currentStandingHome)
        end
    end)
end
local PlayerUtils_upvr = require(ReplicatedStorage.Game.PlayerUtils)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
function module_upvr.queryCurrentStandingHome() -- Line 32
    --[[ Upvalues[3]:
        [1]: PlayerUtils_upvr (readonly)
        [2]: LocalPlayer_upvr (readonly)
        [3]: HomeBinder_upvr (readonly)
    ]]
    local any_getRootPart_result1 = PlayerUtils_upvr.getRootPart(LocalPlayer_upvr)
    if not any_getRootPart_result1 then
    else
        for _, v in ipairs(HomeBinder_upvr:GetAll()) do
            if v:IsPointInStandingPrism(any_getRootPart_result1.Position) then
                return v
            end
        end
    end
end
return module_upvr