-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMUB3JlcXVpcmUQSG90YmFySXRlbVN5c3RlbQZzY3JpcHQGUGFyZW50BGluaXQDZ3VpBmlwYWlycwlDb250YWluZXILR2V0Q2hpbGRyZW4LcHJlc2V0RnJhbWUJQ2xhc3NOYW1lA0lzQQtJbWFnZUNvbG9yMwVJbmRleApUZXh0Q29sb3IzCHNldENvbG9yB0VuYWJsZWQEc2hvdwRoaWRlDUhvdGJhckl0ZW1SZXMABQMAAAAAAA2kAAEAAAAAQKQCBAAAADBATQICJAUAAABNAQInAgAAAJ8AAgJNAAATBgAAAJ8AAQGCAAEABwMBBAAAAEADAgMDBAAAMEADBAMFAAQFARgAAAAAAAAAAAAAAAABBQAAAAAKAQEAAAAe+wEAAE0BAX8AAAAApAICAAAAEEBNAwFvAwAAALwDA2gEAAAAnwMCAJ8CAARRAg8A+wkAAE0JCfEFAAAATQkJ2wYAAAC8Bwb+BwAAAJ8HAwIOBwYAMAAGAAgAAABNBwbiCQAAADAAB3MKAAAAbgLw/wIAAICCAAEACwMGAwcEAAAQQAMIAwkDCgMLAwwDDQMOAw8ABxABGAAAAAEAAAAAAAAAAAEAAAAAAAAAAAEAAQAAAP0ABggAAAAAAgABAAAACPsAAABNAAB/AAAAAA4AAwCpAQEAMAEA8AEAAACCAAEAAgMGAxEAEBIBGAAAAAEBAAACEQAAAAACAAEAAAAI+wAAAE0AAH8AAAAADgADAKkBAAAwAQDwAQAAAIIAAQACAwYDEQAWEwEYAAAAAQEAAAIXAAAAAAMAAAECAByjAAAApAABAAAAAECkAgQAAAAwQE0CAiQFAAAATQECeAIAAACfAAIC/wEDAAAAAADAAgYAMAIBEwcAAADAAggAEgAAADACAd8JAAAAwAIKABIAAAAwAgG4CwAAAMACDAASAAAAMAIB7w0AAACCAQIADgMBBAAAAEADFAMDBAAAMEADBAYAAwUGAQMQBgIDEgYDAxMEAAECAwEAARgAAAAAAAAAAAAAAgABAAADAAAACQAAAAYAAAAGAQAAAAAEn+cV8HYjFPCgwOeia1zQAO//AoStI3/x

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:43:33
-- Luau version 6, Types version 3
-- Time taken: 0.002120 seconds

local HotbarItemRes_upvr = require(script.Parent.HotbarItemRes)
return {
    init = function() -- Line 4, Named "init"
        require(script.Parent.HotbarItemSystem).init()
    end;
    setColor = function(arg1) -- Line 7, Named "setColor"
        --[[ Upvalues[1]:
            [1]: HotbarItemRes_upvr (readonly)
        ]]
        for _, v in ipairs(HotbarItemRes_upvr.gui.Container:GetChildren()) do
            if v:IsA(HotbarItemRes_upvr.presetFrame.ClassName) then
                v.ImageColor3 = arg1
                v.Index.TextColor3 = arg1
            end
        end
    end;
    show = function() -- Line 16, Named "show"
        --[[ Upvalues[1]:
            [1]: HotbarItemRes_upvr (readonly)
        ]]
        local gui = HotbarItemRes_upvr.gui
        if gui then
            gui.Enabled = true
        end
    end;
    hide = function() -- Line 22, Named "hide"
        --[[ Upvalues[1]:
            [1]: HotbarItemRes_upvr (readonly)
        ]]
        local gui_2 = HotbarItemRes_upvr.gui
        if gui_2 then
            gui_2.Enabled = false
        end
    end;
}