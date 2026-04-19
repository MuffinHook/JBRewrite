-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMFCXN0dWRzVG9LbQlrbVRvU3R1ZHMJc3R1ZHNUb01pCW1pVG9TdHVkcwRzVG9IAAYDAQAAAAADPgIAAT4BAgCCAQIAAgIAAAAAAECPQAIAAAAAAAAIQAAGAQEYAAAABwAAAAADAQAAAAADWwIAAVsBAgCCAQIAAgIAAAAAAECPQAIAAAAAAAAIQAAJAgEYAAAACgAAAAAEAQEAAAAH+wIAAE0CAikBAAAAUgMAAJ8CAgJbAQIAggECAAICodl1b0Xi4z8DAQAMAwEYAAAAAAAAAA0AAAAAAwEBAAAABvsBAABNAQECAAAAAD4CAAGfAQIAggEAAAIDAgKh2XVvReLjPwAPBAEYAAAAAAAAEAAAAAADAQAAAAADWwIAAFsBAgCCAQIAAQIAAAAAAABOQAASBQEYAAAAEwAAAAACAAABAgAVowAAAP8ABAAAAAAAwAEAADABACkBAAAAwAECADABAAIDAAAAwAEEABIAAAAwAQDxBQAAAMABBgASAAAAMAEAkQcAAADAAQgAMAEAUQkAAACCAAIACgYAAwEGAQMCBgIDAwYDAwQGBAMFBQABAgMEAQABGAACAAMAAAMAAAMAAAADAAAAAwAAAwEAAAAABde9v6KY1NT/r4CbQuqjC/SnpajW5XnVow==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:46:06
-- Luau version 6, Types version 3
-- Time taken: 0.001450 seconds

local module_upvr = {
    studsToKm = function(arg1) -- Line 6, Named "studsToKm"
        return arg1 / 3 / 1000
    end;
    kmToStuds = function(arg1) -- Line 9, Named "kmToStuds"
        return arg1 * 3 * 1000
    end;
}
function module_upvr.studsToMi(arg1) -- Line 12
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    return module_upvr.studsToKm(arg1) * 0.621371
end
function module_upvr.miToStuds(arg1) -- Line 15
    --[[ Upvalues[1]:
        [1]: module_upvr (readonly)
    ]]
    return module_upvr.kmToStuds(arg1 / 0.621371)
end
function module_upvr.sToH(arg1) -- Line 18
    return arg1 * 60 * 60
end
return module_upvr