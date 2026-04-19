-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMUD01ha2VGdXp6eUZpbmRlcglUcmFuc2Zvcm0IVmFsaWRhdGUIR2V0TmFtZXMMQXV0b2NvbXBsZXRlBVBhcnNlCXVzZXJJbnB1dAxSZWdpc3RlclR5cGUKdXNlcklucHV0cxBNYWtlTGlzdGFibGVUeXBlB3JlcXVpcmUGc2NyaXB0BlBhcmVudAZTaGFyZWQEVXRpbARFbnVtDVVzZXJJbnB1dFR5cGUMR2V0RW51bUl0ZW1zBXBhaXJzB0tleUNvZGUABgQBAgAAAAn7AQAATQEBPQAAAAD7AgEAnwECAlICAQBSAwAAnwICAIICAAABAwEACgIBGAAAAAAAAgAAAAsAAAAABAEAAAAABxwCAACMAwAAtwMCAAIAAACpAQABqQEBAIIBAgAAABADARgAAAAAAAAAEQAAAAADAQEAAAAG+wEAAE0BAccAAAAAUgIAAJ8BAgCCAQAAAQMEABQFARgAAAAAAAAVAAAAAAIBAAAAAAITAQAAggECAAAAGAYBGAAAGQAAAAAGAQIAAAAPbwMAAPsEAAC8AQDdAQAAAJ8BBAFvAwIA+wQBAE0EBCQDAAAA+wUAAJ8EAgC8AQDdAQAAAJ8BAAGCAAEABAMHAwgDCQMKAB0AARgAAAAAAAEAAAAAAAAAAAEeAAAAAAkAAAEAADWjAAAApAABAAAAAECkAQMAAAAgQE0BASQEAAAATQEBJAQAAABNAQESBQAAAE0BAZ4GAAAAnwACAqQBCQAAIHCAvAEBFgoAAACfAQICpAIMAAAAsECkAw4AADRwgLwDAxYKAAAAnwMCAJ8CAAQXAgMAHAgBAJUHCA9qBgEHbgL8/wIAAADiAhQAwAMVABIAAAASAAEAMAMCIRAAAADAAxYAMAMCdhEAAADAAxcAEgAAADADAqsSAAAAwAMYADADApsTAAAAwAMZABIAAgASAAAAggMCABoDCwQAAABAAwwEAAAgQAMNAw4DDwMQAxEEACBwgAMSAxMEAACwQAMUBAA0cIACAAAAAAAA8D8DAgMDAwUDBgUEEBESEwYABgEGAgYDBgQFAAECAwQBAAEYAAAAAAAAAAAAAAAAAAACAAAAAAIAAAAAAAAAAAEAAP8ABAEAAAAABgAABAAAAAQAAAUAAAABAAAAAAXLGbdzOwMlVVGLZPyQYhExuwGgB/nd3XI=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:33:52
-- Luau version 6, Types version 3
-- Time taken: 0.002453 seconds

local Util_upvr = require(script.Parent.Parent.Shared.Util)
local Enum_UserInputType_GetEnumItems_result1_upvr = Enum.UserInputType:GetEnumItems()
for _, v in pairs(Enum.KeyCode:GetEnumItems()) do
    Enum_UserInputType_GetEnumItems_result1_upvr[#Enum_UserInputType_GetEnumItems_result1_upvr + 1] = v
end
local tbl_upvr = {
    Transform = function(arg1) -- Line 10, Named "Transform"
        --[[ Upvalues[2]:
            [1]: Util_upvr (readonly)
            [2]: Enum_UserInputType_GetEnumItems_result1_upvr (readonly)
        ]]
        return Util_upvr.MakeFuzzyFinder(Enum_UserInputType_GetEnumItems_result1_upvr)(arg1)
    end;
    Validate = function(arg1) -- Line 16, Named "Validate"
        local var11
        if 0 >= #arg1 then
            var11 = false
        else
            var11 = true
        end
        return var11
    end;
    Autocomplete = function(arg1) -- Line 20, Named "Autocomplete"
        --[[ Upvalues[1]:
            [1]: Util_upvr (readonly)
        ]]
        return Util_upvr.GetNames(arg1)
    end;
    Parse = function(arg1) -- Line 24, Named "Parse"
        return arg1[1]
    end;
}
return function(arg1) -- Line 29
    --[[ Upvalues[2]:
        [1]: tbl_upvr (readonly)
        [2]: Util_upvr (readonly)
    ]]
    arg1:RegisterType("userInput", tbl_upvr)
    arg1:RegisterType("userInputs", Util_upvr.MakeListableType(tbl_upvr))
end