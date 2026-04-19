-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMVA25ldwxzZXRtZXRhdGFibGUIbWFuaWZlc3QRbmV0d29ya093bmVySWRPYmoFVmFsdWURR2V0UGxheWVyQnlVc2VySWQIR2V0T3duZXIHQ2hhbmdlZBVHZXRPd25lckNoYW5nZWRTaWduYWwEZ2FtZQdQbGF5ZXJzCkdldFNlcnZpY2URUmVwbGljYXRlZFN0b3JhZ2UHcmVxdWlyZQNTdGQKQmFzZU9iamVjdA5NYW5pZmVzdEJpbmRlcgxOZXR3b3JrT3duZWQSTmV0d29ya093bmVkQ29uc3RzB19faW5kZXgZTkVUV09SS19PV05FUl9JRF9PQkpfTkFNRQAEBgICAAAAD/sCAABNAgLvAAAAAFIDAACfAgIC+wUBAJ49AgQFAAAAUgQCAKQDAgAAABBAnwMDATABAkgDAAAAggICAAQDAQMCBAAAEEADAwAMAQEYAAAAAAABAAAAAAAAAgACDQAAAAAFAQEAAAAMTQEASAAAAABNAQFBAQAAAE0BAewCAAAA+wIAAFIEAQC8AgJhAwAAAJ8CAwKCAgIABAMDAwQDBQMGABQHARgAAAAAAAABAAAAAAEVAAAAAAIBAAAAAAdNAQBIAAAAAE0BAUEBAAAATQEBhQIAAACCAQIAAwMDAwQDCAAZCQEYAAAAAAAAABoAAAAACgAAAQIAQqMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQEAAAAAQG8DBAC8AQEWAwAAAJ8BAwKkAgYAAABQQE0DAaEHAAAATQMDSwgAAACfAgICpAMGAAAAUEBNBAGJCQAAAJ8DAgKkBAYAAABQQE0FAdUKAAAATQUF/AsAAACfBAIC/wUDAAAAAAAwBQVuDAAAAJ49BQUCAAAAUgcFAFIIAgCkBg4AAADQQJ8GAwHABg8AEgACABIABQAwBgXvEAAAAMAGEQASAAAAMAYFwxIAAADABhMAMAYF8BQAAABNBgPvEAAAAG8HCgDiCBYATQkE2BcAAAAwCQhBFQAAAFIJBQCfBgQAggYAABgDCgQAAABAAwsDDAMNAw4EAABQQAMPAxADEQMSAxMDFAMCBAAA0EAGAAMBBgEDBwYCAwkDBAUBFQMVAwABAgEAARgAAAAAAAAAAQAAAAAAAQAAAAAAAAEAAAAAAgAAAAAAAAIAAQABAAAAAAAAAgAAAAAIAAAABQAABAAAAAEAAAAB/gABAAAAAAOFw3PHfAgYL+uImYUX/Zc39dtks7cHGcY=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:44:19
-- Luau version 6, Types version 3
-- Time taken: 0.001959 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BaseObject_upvr = require(ReplicatedStorage.Std.BaseObject)
local module_upvr = {}
module_upvr.__index = module_upvr
setmetatable(module_upvr, BaseObject_upvr)
function module_upvr.new(arg1, arg2) -- Line 12
    --[[ Upvalues[2]:
        [1]: BaseObject_upvr (readonly)
        [2]: module_upvr (readonly)
    ]]
    local any_new_result1 = BaseObject_upvr.new(arg1)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1.manifest = arg2
    return any_new_result1
end
local Players_upvr = game:GetService("Players")
function module_upvr.GetOwner(arg1) -- Line 20
    --[[ Upvalues[1]:
        [1]: Players_upvr (readonly)
    ]]
    return Players_upvr:GetPlayerByUserId(arg1.manifest.networkOwnerIdObj.Value)
end
function module_upvr.GetOwnerChangedSignal(arg1) -- Line 25
    return arg1.manifest.networkOwnerIdObj.Changed
end
return require(ReplicatedStorage.ManifestBinder).new("NetworkOwned", {
    networkOwnerIdObj = require(ReplicatedStorage.NetworkOwned.NetworkOwnedConsts).NETWORK_OWNER_ID_OBJ_NAME;
}, module_upvr)