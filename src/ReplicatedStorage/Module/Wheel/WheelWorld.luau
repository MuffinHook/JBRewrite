-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMXBG5leHQLR2V0Q2hpbGRyZW4IQmFzZVBhcnQDSXNBB0dldE1hc3MMc2V0bWV0YXRhYmxlBU1vZGVsBldoZWVscwNuZXcIU2V0TW9kZWwGYXNzZXJ0BXRhYmxlBmluc2VydAlDYWxjdWxhdGUIQWRkV2hlZWwGaXBhaXJzDF9hcHBseUZvcmNlcxBHZXRFZmZXaGVlbENvdW50DUVmZmVjdGl2ZU1hc3MLSWdub3JlTW9kZWwETWFzcwdEZXN0cm95B19faW5kZXgACAoBAQAAABeMAQAApAIBAAAAAEC8AwBoAgAAAJ8DAgMXAg0AbwkDALwHBv4EAAAAnwcDAg4HBAC8BwbHBQAAAJ8HAgJDAQEH+wcAAFIIBgCfBwICQwEBB24C8v8CAAAAggECAAYDAQQAAABAAwIDAwMEAwUABwUBGAABAAAAAAABAAAAAAEAAAACAAAA/AAGCAAAAAADAAEAAAAQ/wECAAAAAAD7AgAAnj0BAwIAAACkAAEAAAAAQJ8AAwLGAQAAMAEAOwIAAAD/AQAAAAAAADABAEQDAAAAggACAAQDBgQAAABAAwcDCAAUCQEYAAAAAAAAAAABAAABAAAAARUAAAAAAgIAAAAAAzABADsAAAAAggABAAEDBwAaCgEYAAABGwAAAAAFAgAAAAARuwEBA1IDAQCkAgEAAAAAQJ8CAgFNAwBEAgAAAJ40AwQBAAAAUgQBAKQCBQAAEDCAnwIDAbwCAC0GAAAAnwICAYIAAQAHAwsEAAAAQAMIAwwDDQQAEDCAAw4AHQ8BGAAAAAAAAQAAAAAAAAABAAABHgAAAAAIAQAAAAAOjAEAAKQCAQAAAABATQMARAIAAACfAgIEUQIEAE0HBmoDAAAADgcBAJUBAQRuAvv/AgAAgIIBAgAFAxAEAAAAQAMIAxECAAAAAAAA8D8AIhIBGAABAAAAAAABAAAB/gAFIwAAAAAJAQEAAAAljAEAAE0CADsAAAAARwIGAAAAAAD7AgAATQMAOwAAAACfAgICUgECALwCAHkBAAAAnwICAtgEAgIJAwEEjAYBAE0HAEQDAAAAHAQHAIwFAQCoBA0ATQgARAMAAACHBwgGMAMH5AQAAABNCABEAwAAAIcHCAZNCAA7AAAAADAIBxoFAAAAiwTz/zABAAkGAAAAggABAAcDBwMSAgAAAAAAAPA/AwgDEwMUAxUAKw4BGAABAAAAAQAAAAADAAABAAEAAAAAAAEAAAAAAgAAAAAAAP0FAAEsAAAAAAYBAAAAABKMAwEATQQARAAAAAAcAQQAjAIBAKgBBwBNBQBEAAAAAIcEBQO8BARQAQAAAJ8EAgGLAfn//wEAAAAAAAAwAQBEAAAAAIIAAQACAwgDFgA6FgEYAAAAAAAAAQAAAAAA/wMAAAABOwAAAAADAAABAgAcowAAAMAAAAASAAAA/wEEAAAAAAAwAQFuAQAAAMACAgASAAEAMAIB7wMAAADAAgQAMAIBNgUAAADAAgYAMAIBwgcAAADAAggAMAIBeQkAAADAAgoAEgAAADACAS0LAAAAwAIMADACAVANAAAAggECAA4GAAMXBgEDCQYCAwoGAwMPBgQDEgYFAw4GBgMWBwABAgMEBQYBAAEYAAYACwABAAEAAAAGAAADAAAFAAAJAAAADwAABwEAAAAAB/Wfr6FllSH19zdbDByfa6eFh7jVx1vFoA==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:53
-- Luau version 6, Types version 3
-- Time taken: 0.003515 seconds

local function GetMass_upvr(arg1) -- Line 7, Named "GetMass"
    --[[ Upvalues[1]:
        [1]: GetMass_upvr (readonly)
    ]]
    local var7
    for _, v in next, arg1:GetChildren() do
        if v:IsA("BasePart") then
            var7 += v:GetMass()
        end
        var7 += GetMass_upvr(v)
    end
    return var7
end
local module_upvr = {}
module_upvr.__index = module_upvr
function module_upvr.new() -- Line 20
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    local setmetatable_result1 = setmetatable({}, module_upvr)
    setmetatable_result1.Model = nil
    setmetatable_result1.Wheels = {}
    return setmetatable_result1
end
function module_upvr.SetModel(arg1, arg2) -- Line 26
    arg1.Model = arg2
end
function module_upvr.AddWheel(arg1, arg2) -- Line 29
    assert(arg2)
    table.insert(arg1.Wheels, arg2)
    arg1:Calculate()
end
function module_upvr.GetEffWheelCount(arg1) -- Line 34
    local var17
    for _, v_2 in ipairs(arg1.Wheels) do
        if v_2._applyForces then
            var17 += 1
        end
    end
    return var17
end
function module_upvr.Calculate(arg1) -- Line 43
    --[[ Upvalues[1]:
        [1]: GetMass_upvr (readonly)
    ]]
    -- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
    local var22 = 0
    if arg1.Model ~= nil then
        var22 = GetMass_upvr(arg1.Model)
    end
    for i_3 = 1, #arg1.Wheels do
        arg1.Wheels[i_3].EffectiveMass = (var22) * (1 / arg1:GetEffWheelCount())
        arg1.Wheels[i_3].IgnoreModel = arg1.Model
        local _
    end
    arg1.Mass = var22
end
function module_upvr.Destroy(arg1) -- Line 58
    for i_4 = 1, #arg1.Wheels do
        arg1.Wheels[i_4]:Destroy()
    end
    arg1.Wheels = {}
end
return module_upvr