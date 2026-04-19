-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMJBXBjYWxsCkpTT05EZWNvZGUIVmFsaWRhdGUFUGFyc2UEanNvbgxSZWdpc3RlclR5cGUEZ2FtZQtIdHRwU2VydmljZQpHZXRTZXJ2aWNlAAQFAQEAAAAJpAEBAAAAAED7AgAATQICywIAAAD7AwAAUgQAAJ8BBACCAQAAAwMBBAAAAEADAgAFAwEYAAAAAAAAAAAABgAAAAAEAQEAAAAG+wEAAFIDAAC8AQHLAAAAAJ8BAwCCAQAAAQMCAAkEARgAAAAAAAAKAAAAAAYBAQAAAA5vAwAA4gQDAMAFBAASAgAAMAUEdgEAAADABQUAEgIAADAFBJsCAAAAvAEA3QYAAACfAQQBggABAAcDBQMDAwQFAgECBgAGAQMGAgABAwABGAAAAQAAAAQAAAD7AAAJBAAAAAADAAABAgAKowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAsABBAASAAAAggECAAUDBwQAAABAAwgDCQYCAQIBAAEYAAAAAAAAAAIAAAEAAAAAA9VHjd77lGu4+WERF/Gs7wGlX5qq54Pn3w==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:33:45
-- Luau version 6, Types version 3
-- Time taken: 0.000930 seconds

local HttpService_upvr = game:GetService("HttpService")
return function(arg1) -- Line 3
    --[[ Upvalues[1]:
        [1]: HttpService_upvr (readonly)
    ]]
    arg1:RegisterType("json", {
        Validate = function(arg1_2) -- Line 5, Named "Validate"
            --[[ Upvalues[1]:
                [1]: HttpService_upvr (copied, readonly)
            ]]
            return pcall(HttpService_upvr.JSONDecode, HttpService_upvr, arg1_2)
        end;
        Parse = function(arg1_3) -- Line 9, Named "Parse"
            --[[ Upvalues[1]:
                [1]: HttpService_upvr (copied, readonly)
            ]]
            return HttpService_upvr:JSONDecode(arg1_3)
        end;
    })
end