-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMSBXBhaXJzBGNvcHkLX2V4dGVuc2lvbnMMc2V0bWV0YXRhYmxlA25ldwZleHRlbmQVc3RhcnRFeHBlY3RhdGlvbkNoYWluBnN0cmluZwZmb3JtYXQjQ2Fubm90IHJlYXNzaWduICVxIGluIGV4cGVjdC5leHRlbmQGYXNzZXJ0LkNhbm5vdCBvdmVyd3JpdGUgbWF0Y2hlciAlcTsgaXQgYWxyZWFkeSBleGlzdHMHcmVxdWlyZQZzY3JpcHQGUGFyZW50C0V4cGVjdGF0aW9uGmNoZWNrTWF0Y2hlck5hbWVDb2xsaXNpb25zB19faW5kZXgABQcBAAAAAAv/AQAAAAAAAKQCAQAAAABAUgMAAJ8CAgQXAgEAagYBBW4C/v8CAAAAggECAAIDAQQAAABAAAQCARgAAAIAAAAAAf8ABAUAAAAACgEBAAAAHOIBAQAOAA4ATQMACgAAAAD/BAAAAAAAAKQFAwAAACBAUgYDAJ8FAgQXBQEAagkECG4F/v8CAAAAUgIEACsCAgD/AgAAAAAAADACAQoAAAAA+wQAAJ49AQQEAAAAUgMBAKQCBQAAAEBAnwIDAoICAgAGAwMFAQADAQQAACBAAwQEAABAQAARBQEYDQEAAPIAAgAAAAAB/wAEAAgAAAADAAAAAAAAAAUAAAAABAEBAQAADKMBAAD7AQAATQEB7wAAAADdAgAAnwEAAk0DAAoBAAAAvAEBnAIAAACfAQMAggEAAAMDBQMDAwYAGQcBGAABAAAAAAAAAAAAABkAAAAADAIBAAAAJ6QCAQAAAABAUgMBAJ8CAgQXAh8ATQoACgIAAACHCQoFRwkCAAAAAACpCAABqQgBAKQJBQAAEDCAbwoGAFILBQCfCQMATAEAAqQHCAAAAHBAnwcAAfsIAABSCQUAnwgCAqQJBQAAEDCAbwoJAFILBQCfCQMATAEAAqQHCAAAAHBAnwcAAU0HAAoCAAAAagYHBW4C4P8CAAAAggABAAoDAQQAAABAAwMDCAMJBAAQMIADCgMLBAAAcEADDAAdBgEYAAAAAAABAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAgAA/AAGHgAAAAAFAAABAgAeowAAAKQAAQAAAABApAEDAAAAIEBNAQEkBAAAAE0BAf8FAAAAnwACAk0BAOEGAAAAwAIHAP8DAwAAAAAAMAMDbggAAADABAkAEgADADAEA+8KAAAAwAQLABIAAAAwBAOmDAAAAMAEDQASAAEAMAQDnA4AAACCAwIADwMNBAAAAEADDgQAACBAAw8DEAMRBgADEgYBAwUGAgMHBgMDBgQAAQIDAQABGAAAAAAAAAAAAAABAAIKAAEAAgAAAAgAAAAEAAAACQEAAAAABBDl/xbRFkO9gr1GMRAELyFg/ehiIiGVFw==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:32:00
-- Luau version 6, Types version 3
-- Time taken: 0.003293 seconds

local Expectation_upvr = require(script.Parent.Expectation)
local function _(arg1) -- Line 4, Named "copy"
    local module = {}
    for i, v in pairs(arg1) do
        module[i] = v
    end
    return module
end
local module_3_upvr = {}
module_3_upvr.__index = module_3_upvr
function module_3_upvr.new(arg1) -- Line 17
    --[[ Upvalues[1]:
        [1]: module_3_upvr (readonly)
    ]]
    -- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
    local module_2 = {}
    -- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
    -- KONSTANTERROR: [2] 3. Error Block 12 start (CF ANALYSIS FAILED)
    for i_2, v_2 in pairs(arg1._extensions) do
        ({})[i_2] = v_2
        local var20
    end
    local var21 = var20
    if not var21 then
        -- KONSTANTERROR: [16] 13. Error Block 5 start (CF ANALYSIS FAILED)
        var21 = {}
        -- KONSTANTERROR: [16] 13. Error Block 5 end (CF ANALYSIS FAILED)
    end
    module_2._extensions = var21
    do
        return setmetatable(module_2, module_3_upvr)
    end
    -- KONSTANTERROR: [2] 3. Error Block 12 end (CF ANALYSIS FAILED)
end
function module_3_upvr.startExpectationChain(arg1, ...) -- Line 25
    --[[ Upvalues[1]:
        [1]: Expectation_upvr (readonly)
    ]]
    return Expectation_upvr.new(...):extend(arg1._extensions)
end
local checkMatcherNameCollisions_upvr = Expectation_upvr.checkMatcherNameCollisions
function module_3_upvr.extend(arg1, arg2) -- Line 29
    --[[ Upvalues[1]:
        [1]: checkMatcherNameCollisions_upvr (readonly)
    ]]
    for i_3, v_3 in pairs(arg2) do
        local var30
        if arg1._extensions[i_3] ~= nil then
            var30 = false
        else
            var30 = true
        end
        assert(var30, string.format("Cannot reassign %q in expect.extend", i_3))
        var30 = checkMatcherNameCollisions_upvr(i_3)
        assert(var30, string.format("Cannot overwrite matcher %q; it already exists", i_3))
        arg1._extensions[i_3] = v_3
    end
end
return module_3_upvr