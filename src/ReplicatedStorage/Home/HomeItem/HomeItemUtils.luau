-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMLEnBvaW50VG9PYmplY3RTcGFjZQF4AXkBeg5pc1BvaW50SW5QcmlzbQRTaXplB1ZlY3RvcjMDbmV3BmlwYWlycxFHZXRQbGFjZW1lbnRQcmlzbQ5pc1dpdGhpbkJvdW5kcwADBwMAAAAAL1IGAAC8BAHmAAAAAJ8EAwJbBQIBQwMEBakEAABNBQOZAgAAAIwGAAB9BiMABQAAAKkEAABNBQOZAgAAAE0GApkCAAAAfQUcAAYAAACpBAAATQUDmAMAAACMBgAAfQYWAAUAAACpBAAATQUDmAMAAABNBgKYAwAAAH0FDwAGAAAAqQQAAE0FA5sEAAAAjAYAAH0GCQAFAAAATQUDmwQAAABNBgKbBAAAANQFAgAGAAAAqQQAAakEAQCCBAIABQMBAgAAAAAAAOA/AwIDAwMEAAMFARgAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAHAMAAAAHAAABCA4UAVtNAwAvAAAAAIwG/P+MBAQAjAUBAKgEUwCMCfz/jAcEAIwIAQCoB04APgoGAT4LCQGMEP//NDYKBRALAABSDwoAUhELAKQOBQAAEDCAnw4EAgkNDgNbDA0CCQ0BDKkOAACkDwcAAABgQFIQAgCfDwIEUQ81ALwUEyMIAAAAnxQCA1sXFQlSGw0AvBkU5goAAACfGQMCWxoXAkMYGRqpFgAATRkYmQsAAACMGgAAfRojABkAAACpFgAATRkYmQsAAABNGheZCwAAAH0ZHAAaAAAAqRYAAE0ZGJgMAAAAjBoAAH0aFgAZAAAAqRYAAE0ZGJgMAAAATRoXmAwAAAB9GQ8AGgAAAKkWAABNGRibDQAAAIwaAAB9GgkAGQAAAE0ZGJsNAAAATRoXmw0AAADUGQIAGgAAAKkWAAGpFgEADhYCAKkOAQBlAAIAbg/K/wIAAIArDgIAqQ8AAIIPAgCLB7L/iwSt/6kEAQCCBAIADgMGAgAAAAAAABBAAgAAAAAAAOA/AwcDCAQAEDCAAwkEAABgQAMKAmq8dJMYBPA/AwEDAgMDAwQACQsBGAcABQAAAAEAAAADAQIAAAAAAAAAAAABAgEAAAAAAQAAAecAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGQH8ABUCAN//JgAEAAAAAAMAAAECAAijAAAA/wABAAAAAADAAQAAwAIBADACAPYCAAAAggACAAMGAAYBAwsCAAEBAAEYAAAAAgYAADABAAAAAAKchQB9157aLILbJZMbRMop7J0XCa5Banw=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:59
-- Luau version 6, Types version 3
-- Time taken: 0.006092 seconds

local module = {}
local function _(arg1, arg2, arg3) -- Line 3, Named "isPointInPrism"
    local var10 = arg2:pointToObjectSpace(arg1) + arg3 * 0.5
    local var11 = false
    if 0 <= var10.x then
        var11 = false
        if var10.x <= arg3.x then
            var11 = false
            if 0 <= var10.y then
                var11 = false
                if var10.y <= arg3.y then
                    var11 = false
                    if 0 <= var10.z then
                        if var10.z > arg3.z then
                            var11 = false
                        else
                            var11 = true
                        end
                    end
                end
            end
        end
    end
    return var11
end
function module.isWithinBounds(arg1, arg2, arg3) -- Line 9
    -- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
    -- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
    -- KONSTANTERROR: [88] 67. Error Block 18 start (CF ANALYSIS FAILED)
    -- KONSTANTERROR: [88] 67. Error Block 18 end (CF ANALYSIS FAILED)
    -- KONSTANTERROR: [6] 6. Error Block 2 start (CF ANALYSIS FAILED)
    -- KONSTANTERROR: [6] 6. Error Block 2 end (CF ANALYSIS FAILED)
end
return module