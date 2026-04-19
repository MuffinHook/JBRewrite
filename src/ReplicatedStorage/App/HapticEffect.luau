-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMaCWlzR2FtZXBhZAZhc3NlcnQISW5zdGFuY2UDbmV3DEhhcHRpY0VmZmVjdAZSYWRpdXMGTG9vcGVkBEVudW0QSGFwdGljRWZmZWN0VHlwZQZDdXN0b20EVHlwZQ1GbG9hdEN1cnZlS2V5D1NldFdhdmVmb3JtS2V5cwl3b3Jrc3BhY2UGUGFyZW50BFBsYXkEdGFzawVkZWxheQdEZXN0cm95BWJhc2ljBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlA1N0ZApJbnB1dFV0aWxzAAIJAgEAAAcEAAAFAgICO/sCAABNAgJcAAAAAJ8CAQIrAgEAggABALsBAANSAwAApAICAAAAEECfAgIBuwEBA1IDAQCkAgIAAAAQQJ8CAgGkAgUAABAwgG8DBgCfAgICjAMDADADAnEHAAAAqQMBADADArUIAAAApAMMAAsokMAwAwIRDQAAAP8FAAABAAAApAYPAAAQ4ICMBwAAUggAAJ8GAwDFBQYAAQAAALwDAvAQAAAAnwMDAaQDEgAAABBBMAMCJBMAAAC8AwLuFAAAAJ8DAgENAQgAFQAAAKQDGAAAXGCBUgQBAE0FAlAZAAAAUgYCAJ8DBAGCAgIAGgMBAwIEAAAQQAMDAwQEABAwgAMFAwYDBwMIAwkDCgQLKJDAAwsDDAQAEOCAAw0DDgQAABBBAw8DEAIAAAAAAADwfwMRAxIEAFxggQMTAAcUARgAAAAAAAECAAAAAAEAAAAAAQAAAAEAAAEAAAEAAAABAAAAAAAAAAAAAAABAAAAAQAAAQABAAAAAAAAAggAAAAABAAAAQIAFaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKEGAAAATQIC5QcAAACfAQIC/wIBAAAAAADAAwgAEgABADADAisJAAAAggICAAoDFQQAAABAAxYDFwMYBAAAQEADGQMaBgADFAEAAQABGAAAAAAAAAABAAAAAAAAAQAEAAAAEwEAAAAAAdmr6q+EFMR6oFWHlvnFaHmps/3b62+Arg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:16
-- Luau version 6, Types version 3
-- Time taken: 0.001184 seconds

local module = {}
local InputUtils_upvr = require(game:GetService("ReplicatedStorage").Std.InputUtils)
function module.basic(arg1, arg2) -- Line 7
    --[[ Upvalues[1]:
        [1]: InputUtils_upvr (readonly)
    ]]
    if not InputUtils_upvr.isGamepad() then return end
    assert(arg1)
    assert(arg2)
    local HapticEffect = Instance.new("HapticEffect")
    HapticEffect.Radius = 3
    HapticEffect.Looped = true
    HapticEffect.Type = Enum.HapticEffectType.Custom
    HapticEffect:SetWaveformKeys({FloatCurveKey.new(0, arg1)})
    HapticEffect.Parent = workspace
    HapticEffect:Play()
    if arg2 ~= math.huge then
        task.delay(arg2, HapticEffect.Destroy, HapticEffect)
    end
    return HapticEffect
end
return module