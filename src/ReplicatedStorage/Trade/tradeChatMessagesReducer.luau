-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMVC2Rpc3BsYXlOYW1lD05vIGRpc3BsYXkgbmFtZQZhc3NlcnQEdGV4dAdObyB0ZXh0Am1lBnR5cGVvZgdib29sZWFuEk5vIG1lIHZhbHVlIHBhc3NlZAV0YWJsZQVjbG9uZQVjb2xvcgZpbnNlcnQTYWRkVHJhZGVDaGF0TWVzc2FnZRZjbGVhclRyYWRlQ2hhdE1lc3NhZ2VzBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBVJvZHV4DWNyZWF0ZVJlZHVjZXIAAwcCAAAAADxNAwF3AAAAAIEBAwQBAAAAbwQBAKQCAwAAACBAnwIDAU0DAdUEAAAAgQEDBAUAAABvBAUApAIDAAAAIECfAgMBTQUB0QYAAAC7LAUCpAQIAAAAcECfBAIC8AQCAAkAAACpAwABqQMBAIEBAwQKAAAAbwQKAKQCAwAAACBAnwIDAaQCDQAAMLCAUgMAAJ8CAgLiBQ8ATQYBdwAAAAAwBgV3AAAAAE0GAdEGAAAAMAYF0QYAAABNBgHVBAAAADAGBdUEAAAATQYBRA4AAAAwBgVEDgAAAJ40AgQFAAAAUgQCAKQDEQAAQLCAnwMDAYICAgASAwEDAgMDBAAAIEADBAMFAwYDBwQAAHBAAwgDCQMKAwsEADCwgAMMBQQABgQOAw0EAECwgAAFDgEYAAAAAAAAAAABAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAACAAAABAAAAAAAAAAAAAAAAAAAAAAAAAD+AAAFBgAAAAADAgAAAAAD/wIAAAAAAACCAgIAAAATDwEYAAAAFAAAAAAGAAABAgAZowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIApwYAAACfAQICTQIB1gcAAAD/AwAAAAAAAOIECgDABQsAMAUEnggAAADABQwAMAUEIQkAAACfAgMAggIAAA0DEAQAAABAAxEDEgMTBAAAQEADFAMVAw4DDwUCCAkGAAYBAgABAQABGAAAAAAAAAABAAAAAAIAAAAAAQAADgAA8QABAAAAAAJnewY94UCMcg0EGI7cy7QiF2MRSVW/bDw=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:20
-- Luau version 6, Types version 3
-- Time taken: 0.001458 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    addTradeChatMessage = function(arg1, arg2) -- Line 5, Named "addTradeChatMessage"
        assert(arg2.displayName, "No display name")
        local text = arg2.text
        assert(text, "No text")
        if typeof(arg2.me) ~= "boolean" then
            text = false
        else
            text = true
        end
        assert(text, "No me value passed")
        local clone = table.clone(arg1)
        table.insert(clone, {
            displayName = arg2.displayName;
            me = arg2.me;
            text = arg2.text;
            color = arg2.color;
        })
        return clone
    end;
    clearTradeChatMessages = function(arg1, arg2) -- Line 19, Named "clearTradeChatMessages"
        return {}
    end;
})