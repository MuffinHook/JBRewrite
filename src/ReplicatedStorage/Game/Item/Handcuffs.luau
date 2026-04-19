-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMSA25ldwxzZXRtZXRhdGFibGUQU3ByaW5nSXRlbU9mZnNldAlTZXRUYXJnZXQKSW5wdXRCZWdhbgpJbnB1dEVuZGVkBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQZzY3JpcHQGUGFyZW50B3JlcXVpcmUFQmFzaWMER2FtZQpJdGVtQ29uZmlnCUhhbmRjdWZmcwtfX0NsYXNzTmFtZQdfX2luZGV4AAQIAwMAAAAW+wMAAE0DA+8AAAAAUgQAAFIFAQD7BgEAUgcCAJ8DBQL7BgIAnj0DBAYAAABSBQMApAQCAAAAEECfBAMBTQQDHQMAAABvBgQAvAQElwUAAACfBAMBggMCAAYDAQMCBAAAEEADAwcAAAAAmpmZPgAAgL8AAAAAAwQACwEBGAAAAAAAAAAAAQAAAAAAAAIAAAAAAAIMAAAAAAQBAQEAAAijAQAA+wEAAE0BAYIAAAAAUgIAAN0DAACfAQABggABAAEDBQATBQEYAAEAAAAAAAETAAAAAAEBAAAAAAGCAAEAAAAWBgEYABYAAAAACAAAAQIANaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0BASQGAAAApAIIAAAAcEBNAwHLCQAAAJ8CAgKkAwgAAABwQE0EAL0KAAAATQQELAsAAABNBATYDAAAAJ8DAgL/BAQAAAAAAG8FDAAwBQTlDQAAADAEBG4OAAAAnj0EBQIAAABSBgQAUgcCAKQFEAAAAPBAnwUDAcAFEQASAAIAEgADABIABAAwBQTvEgAAAMAFEwASAAIAMAUEghQAAADABRUAMAUErxYAAACCBAIAFwMHBAAAAEADCAMJAwoEAABAQAMLAwwEAABwQAMNAw4DDwMQAxEDEgMCBAAA8EAGAAMBBgEDBQYCAwYDAAECAQABGAAAAAAAAAABAAAAAQAAAAACAAAAAAAAAAACAAEAAAEAAQAAAAAAAAEAAAAAAAgAAAADAAACAQAAAAADJgdt+Eb3GDhkYsOzcZ1CTlYfeowUwwf5

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:37:18
-- Luau version 6, Types version 3
-- Time taken: 0.001296 seconds

local Basic_upvr = require(script.Parent.Basic)
local module_upvr = {
    __ClassName = "Handcuffs";
}
module_upvr.__index = module_upvr
setmetatable(module_upvr, Basic_upvr)
local Handcuffs_upvr = require(game:GetService("ReplicatedStorage").Game.ItemConfig.Handcuffs)
function module_upvr.new(arg1, arg2, arg3) -- Line 11
    --[[ Upvalues[3]:
        [1]: Basic_upvr (readonly)
        [2]: Handcuffs_upvr (readonly)
        [3]: module_upvr (readonly)
    ]]
    local any_new_result1 = Basic_upvr.new(arg1, arg2, Handcuffs_upvr, arg3)
    setmetatable(any_new_result1, module_upvr)
    any_new_result1.SpringItemOffset:SetTarget(Vector3.new(0, 0.30000, -1))
    return any_new_result1
end
function module_upvr.InputBegan(arg1, ...) -- Line 19
    --[[ Upvalues[1]:
        [1]: Basic_upvr (readonly)
    ]]
    Basic_upvr.InputBegan(arg1, ...)
end
function module_upvr.InputEnded(arg1) -- Line 22
end
return module_upvr