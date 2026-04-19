-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMJPkFCQ0RFRkdISUpLTE1OT1BRUlNUVVZXWFlaYWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXowMTIzNDU2Nzg5CTAxMjM0NTY4OQRtYXRoBnJhbmRvbQNzdWIFdGFibGUGaW5zZXJ0BmNvbmNhdAd2YXJTYWZlAAINAQAAAAAh/wEAAAAAAACMBAEAUgIAAIwDAQCoAhYAbwUAAA0EBAABAAAAUgYFAG8HAgBzBQYHpAYFAAAQMICMBwEAHAgFAJ8GAwJSCAEAUgsGAFIMBgC8CQXwBgAAAJ8JBABMNAACpAcJAAAgcICfBwABiwLq/6QCCwAAKHCAUgMBAJ8CAgCCAgAADAMBAgAAAAAAAPA/AwIDAwMEBAAQMIADBQMGAwcEACBwgAMIBAAocIAAAgkBGAAAAQAAAAEBAAEAAAIAAAAAAQAAAAAAAAAAAPoIAAAAAAUAAAAAAgAAAQIAB6MAAAD/AAEAAAAAAMABAAAwAQDUAQAAAIIAAgACBgADCQEAAQABGAAAAAEAAA4BAAAAAAFixzmB2jR9ObSXGANEoGPyEt8u9VADU4A=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:36
-- Luau version 6, Types version 3
-- Time taken: 0.001116 seconds

return {
    varSafe = function(arg1) -- Line 2, Named "varSafe"
        local module = {}
        for i = 1, arg1 do
            local var5 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
            if i ~= 1 then
                var5 = var5.."012345689"
            end
            local randint = math.random(1, #var5)
            table.insert(module, var5:sub(randint, randint))
        end
        return table.concat(module)
    end;
}