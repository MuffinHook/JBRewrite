-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKA25ldwVEb251dAVfbWFpZAhHaXZlVGFzaw9fdmVuZGluZ01hY2hpbmUFc2V0dXAHcmVxdWlyZQ9fVmVuZGluZ01hY2hpbmUGc2NyaXB0BlBhcmVudAACBQEBAAAAD/sBAABNAQHvAAAAAFICAABvAwEAnwEDAk0CAMECAAAAUgQBALwCAv0DAAAAnwIDATABAIMEAAAAggABAAUDAQMCAwMDBAMFAAQGARgAAAAAAAABAAAAAAABAAEFAAAAAAMAAAECABGjAAAApAABAAAAAECkAgQAAAAwQE0CAiQFAAAATQEC+wIAAACfAAIC/wEBAAAAAADAAgYAEgAAADACAfkHAAAAggECAAgDBwQAAABAAwgDCQQAADBAAwoGAAMGAQABAAEYAAAAAAAAAAAAAAIAAQAAAAUBAAAAAAFRRyj/fiNxibBy/NlQ88mRIV8/i2ODQv4=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:00
-- Luau version 6, Types version 3
-- Time taken: 0.000791 seconds

local module = {}
local _VendingMachine_upvr = require(script.Parent._VendingMachine)
function module.setup(arg1) -- Line 4
    --[[ Upvalues[1]:
        [1]: _VendingMachine_upvr (readonly)
    ]]
    local any_new_result1 = _VendingMachine_upvr.new(arg1, "Donut")
    arg1._maid:GiveTask(any_new_result1)
    arg1._vendingMachine = any_new_result1
end
return module