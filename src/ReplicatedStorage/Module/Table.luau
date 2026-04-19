-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMJBHR5cGUFdGFibGUEbmV4dAxnZXRtZXRhdGFibGUMc2V0bWV0YXRhYmxlDVRhYmxlRGVlcENvcHkLVGFibGVDb25jYXQIRGVlcENvcHkGQ29uY2F0AAMLAQEAAAAnuygAA1ICAACkAQEAAAAAQJ8BAgLGAgAA8AEeAAIAAID/AgAAAAAAAKQDBAAAADBAUgQAAMYFAABkAwcA+wgAAFIJBgCfCAIC+wkAAFIKBwCfCQICagkCCG4D+P8CAAAAUgQCAPsFAAC7PAADUgcAAKQGBgAAAFBAnwYCAp8FAgBMPQACpAMIAAAAcECfAwABggICAFICAACCAgIACQMBBAAAAEADAgMDBAAAMEADBAQAAFBAAwUEAABwQAABBgEYAAAAAAABAQABAAEAAAAAAQAAAAAAAP8AAwAAAAAAAAAAAAAAAAICAgAAAAAHAgAAAAAKjAQBABwCAQCMAwEAqAIFABwGAACVBQYAhwYBBGoGAAWLAvv/ggACAAECAAAAAAAA8D8ADwcBGAAAAAABAAAA/wMQAAAAAAMAAAECAAqjAAAAwAAAABIAAADAAQEA4gIEADAAAoUCAAAAMAECOgMAAACCAgIABQYABgEDCAMJBQICAwIAAQEAARgAAAAOBwEAAQAAAQAAAAACrOgAYECQXeeVKHCc6wBhi9zwFxSeLGph

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:46
-- Luau version 6, Types version 3
-- Time taken: 0.001618 seconds

local function TableDeepCopy_upvr(arg1) -- Line 1, Named "TableDeepCopy"
    --[[ Upvalues[1]:
        [1]: TableDeepCopy_upvr (readonly)
    ]]
    if type(arg1) == "table" then
        for i, v in next, arg1 do
            ({})[TableDeepCopy_upvr(i)] = TableDeepCopy_upvr(v)
            local var6
        end
        setmetatable(var6, TableDeepCopy_upvr(getmetatable(arg1)))
        return var6
    end
    return arg1
end
return {
    DeepCopy = TableDeepCopy_upvr;
    Concat = function(arg1, arg2) -- Line 15, Named "TableConcat"
        for i_2 = 1, #arg2 do
            arg1[#arg1 + 1] = arg2[i_2]
        end
        return arg1
    end;
}