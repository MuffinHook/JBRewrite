-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMnA25ldwhtYW5pZmVzdARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQ5NYW5pZmVzdEJpbmRlcgNTdGQKQmFzZU9iamVjdAdfX2luZGV4CUNoYXJhY3RlchBIdW1hbm9pZFJvb3RQYXJ0BEhlYWQKVXBwZXJUb3JzbwpMb3dlclRvcnNvBE5lY2sFV2Fpc3QEUm9vdA1SaWdodFVwcGVyQXJtDVJpZ2h0U2hvdWxkZXINUmlnaHRMb3dlckFybQpSaWdodEVsYm93CVJpZ2h0SGFuZApSaWdodFdyaXN0DExlZnRVcHBlckFybQxMZWZ0U2hvdWxkZXIMTGVmdExvd2VyQXJtCUxlZnRFbGJvdwhMZWZ0SGFuZAlMZWZ0V3Jpc3QJSGVhZC9OZWNrEFVwcGVyVG9yc28vV2Fpc3QPTG93ZXJUb3Jzby9Sb290G1JpZ2h0VXBwZXJBcm0vUmlnaHRTaG91bGRlchhSaWdodExvd2VyQXJtL1JpZ2h0RWxib3cUUmlnaHRIYW5kL1JpZ2h0V3Jpc3QZTGVmdFVwcGVyQXJtL0xlZnRTaG91bGRlchZMZWZ0TG93ZXJBcm0vTGVmdEVsYm93EkxlZnRIYW5kL0xlZnRXcmlzdAACBAIBAAAACPsCAABNAgLvAAAAAFIDAACfAgICMAECSAEAAACCAgIAAgMBAwIACAEBGAAAAAAAAQABCQAAAAAIAAABAgBbowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAiQYAAACfAQICpAIFAAAAQEBNAwChBwAAAE0DA0sIAAAAnwICAv8DAgAAAAAAMAMDbgkAAADABAoAEgACADAEA+8LAAAATQQB7wsAAABvBQwA4gYgAG8HDQAwBwZmDQAAAG8HDgAwBwYTDgAAAG8HDwAwBwZVDwAAAG8HEAAwBwYyEAAAAG8HIQAwBwbkEQAAAG8HIgAwBwZAEgAAAG8HIwAwBwZ0EwAAAG8HFAAwBwbSFAAAAG8HJAAwBwbLFQAAAG8HFgAwBwbZFgAAAG8HJQAwBwb2FwAAAG8HGAAwBwYlGAAAAG8HJgAwBwZtGQAAAG8HGgAwBwa4GgAAAG8HJwAwBwZSGwAAAG8HHAAwBwbhHAAAAG8HKAAwBwatHQAAAG8HHgAwBwZaHgAAAG8HKQAwBwb8HwAAAFIHAwCfBAQAggQAACoDAwQAAABAAwQDBQMGBAAAQEADBwMIAwkDCgYAAwEDCwMMAw0DDgMPAxADEQMSAxMDFAMVAxYDFwMYAxkDGgMbAxwDHQMeBRMNDg8QERITFBUWFxgZGhscHR4fAx8DIAMhAyIDIwMkAyUDJgMnAQABAAEYAAAAAAAAAAEAAAAAAQAAAAAAAAIAAQACAAAACQAAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAEAAAHsAAEAAAAAAZlWLuGzYcio8sZ/WInXZ57pTjmVq5JE4A==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:13
-- Luau version 6, Types version 3
-- Time taken: 0.001652 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
module.__index = module
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
function module.new(arg1, arg2) -- Line 8
    --[[ Upvalues[1]:
        [1]: BaseObject_upvr (readonly)
    ]]
    local any_new_result1 = BaseObject_upvr.new(arg1)
    any_new_result1.manifest = arg2
    return any_new_result1
end
return require(ReplicatedStorage.ManifestBinder).new("Character", {
    HumanoidRootPart = "HumanoidRootPart";
    Head = "Head";
    UpperTorso = "UpperTorso";
    LowerTorso = "LowerTorso";
    Neck = "Head/Neck";
    Waist = "UpperTorso/Waist";
    Root = "LowerTorso/Root";
    RightUpperArm = "RightUpperArm";
    RightShoulder = "RightUpperArm/RightShoulder";
    RightLowerArm = "RightLowerArm";
    RightElbow = "RightLowerArm/RightElbow";
    RightHand = "RightHand";
    RightWrist = "RightHand/RightWrist";
    LeftUpperArm = "LeftUpperArm";
    LeftShoulder = "LeftUpperArm/LeftShoulder";
    LeftLowerArm = "LeftLowerArm";
    LeftElbow = "LeftLowerArm/LeftElbow";
    LeftHand = "LeftHand";
    LeftWrist = "LeftHand/LeftWrist";
}, module)