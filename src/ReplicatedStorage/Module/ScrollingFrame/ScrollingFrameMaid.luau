-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMQBVRhc2tzCEdpdmVUYXNrBXBhaXJzBHR5cGUIZnVuY3Rpb24GdHlwZW9mE1JCWFNjcmlwdENvbm5lY3Rpb24KZGlzY29ubmVjdAdEZXN0cm95CkRvQ2xlYW5pbmcHX19pbmRleApfX25ld2luZGV4CUluc3RhbmNlcwxzZXRtZXRhdGFibGUITWFrZU1haWQDbmV3AAYFAgAAAAAITQQARAEAAAAcAwQAlQIDAE0DAEQBAAAAagEDAoICAgACAgAAAAAAAPA/AwEAFwIBGAAAAAABAAABGAAAAAAJAQAAAAAkTQEARAAAAACkAgIAAAAQQFIDAQCfAgIEFwIaALsoBgNSCAYApAcEAAAAMECfBwIC8AcEAAUAAIBSBwYAnwcBAWUADgC7LAYDUggGAKQHBwAAAGBAnwcCAvAHBQAIAACAvAcG+gkAAACfBwIBZQADALwHBlAKAAAAnwcCAcYHAABqBwEFbgLl/wIAAACCAAEACwMBAwMEAAAQQAMEBAAAMEADBQMGBAAAYEADBwMIAwkAHAoBGAAAAQAAAAABAAAAAAAAAQAAAQAAAAAAAAEAAAACAAACAPgACh0AAAAABAIBAAAACvsDAACHAgMBDgIDAPsDAACHAgMBggICAE0DAEQAAAAAhwIDAYICAgABAwEALQsBGAAAAAEAAAIAAAAuAAAAAAYDAAAAACRNAwBEAAAAAEcCGwAAAACAhwUDAbsoBQKkBAIAAAAQQJ8EAgLwBBgAAwAAAIcEAwEOBBUAhwUDAbssBQKkBAUAAABAQJ8EAgLwBAYABgAAgIcEAwG8BAT6BwAAAJ8EAgFlAAkAhwQDAbwEBFAIAAAAnwQCAWUABACHBAMBDgQCAMYEAABqBAABagIDAYIAAQAJAwEDBAQAABBAAwUDBgQAAEBAAwcDCAMJADQMARgAAAEAAgAAAAAAAAAAAQAAAAAAAAEAAAAAAgAAAAADAAIAAgE1AAAAAAMAAQAAABDiAQIA/wIAAAAAAAAwAgFEAAAAAP8CAAAAAAAAMAIB5wEAAAD7AgAAnj0BAwIAAACkAAQAAAAwQJ8AAwKCAAIABQMBAw0FAgABAw4EAAAwQABHDwEYAAAAAAAAAAAAAAAAAAAAAEgAAAAABQAAAQIAHqMAAAD/AAIAAAAAAMYBAADiAgIAwAMDADADAv0AAAAAwAMEADADAlEBAAAATQMCUQEAAAAwAwJQBQAAAOIDCADABAkAEgACADAEA24GAAAAwAQKADAEA84HAAAAwAELABIAAwAwAQBxDAAAADABAO8NAAAAggACAA4DAgMKBQIAAQYABgEDCQMLAwwFAgYHBgIGAwYEAw8DEAUAAQIDBAEAARgAEQACAgEAAAUAAA4AAAACAQAAAAcAABMABQABAAIBAAAAAAU50xw9dfFkgwOFRNstWHO6ScsLSQsXdjw=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:40
-- Luau version 6, Types version 3
-- Time taken: 0.002992 seconds

local module = {}
local module_upvr = {
    GiveTask = function(arg1, arg2) -- Line 23, Named "GiveTask"
        local var3 = #arg1.Tasks + 1
        arg1.Tasks[var3] = arg2
        return var3
    end;
    DoCleaning = function(arg1) -- Line 28, Named "DoCleaning"
        local Tasks = arg1.Tasks
        for i, v in pairs(Tasks) do
            if type(v) == "function" then
                v()
            elseif typeof(v) == "RBXScriptConnection" then
                v:disconnect()
            else
                v:Destroy()
            end
            Tasks[i] = nil
        end
    end;
    Destroy = module_upvr.DoCleaning;
}
local module_upvr_2 = {
    __index = function(arg1, arg2) -- Line 45, Named "__index"
        --[[ Upvalues[1]:
            [1]: module_upvr (readonly)
        ]]
        if module_upvr[arg2] then
            return module_upvr[arg2]
        end
        return arg1.Tasks[arg2]
    end;
    __newindex = function(arg1, arg2, arg3) -- Line 52, Named "__newindex"
        -- KONSTANTERROR: [0] 1. Error Block 17 start (CF ANALYSIS FAILED)
        local Tasks_2 = arg1.Tasks
        if arg3 == nil then
            if type(Tasks_2[arg2]) ~= "function" and Tasks_2[arg2] then
                if typeof(Tasks_2[arg2]) == "RBXScriptConnection" then
                    Tasks_2[arg2]:disconnect()
                else
                    Tasks_2[arg2]:Destroy()
                end
                -- KONSTANTWARNING: GOTO [34] #27
            end
        elseif Tasks_2[arg2] then
            arg1[arg2] = nil
        end
        -- KONSTANTERROR: [0] 1. Error Block 17 end (CF ANALYSIS FAILED)
        -- KONSTANTERROR: [34] 27. Error Block 11 start (CF ANALYSIS FAILED)
        Tasks_2[arg2] = arg3
        -- KONSTANTERROR: [34] 27. Error Block 11 end (CF ANALYSIS FAILED)
    end;
}
local function MakeMaid() -- Line 71
    --[[ Upvalues[1]:
        [1]: module_upvr_2 (readonly)
    ]]
    return setmetatable({
        Tasks = {};
        Instances = {};
    }, module_upvr_2)
end
module.MakeMaid = MakeMaid
module.new = MakeMaid
return module