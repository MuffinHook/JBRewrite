-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMLDlN5c3RlbUxvY2FsZUlkDXN5c3RlbV9sb2NhbGUOUm9ibG94TG9jYWxlSWQOYWNjb3VudF9sb2NhbGUOT25DbGllbnRJbnZva2UEZ2FtZRNMb2NhbGl6YXRpb25TZXJ2aWNlCkdldFNlcnZpY2URUmVwbGljYXRlZFN0b3JhZ2UVSGF3a2V5ZVJlbW90ZUZ1bmN0aW9uDFdhaXRGb3JDaGlsZAACAgABAAAADf8AAgAAAAAA+wEAAE0BAXQAAAAAMAEAUwEAAAD7AQAATQEBiwIAAAAwAQDlAwAAAIIAAgAEAwEDAgMDAwQABQUBGAAAAQAAAAABAAAAAAEGAAAAAAUAAAECABajAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEBAAAAAEBvAwQAvAEBFgMAAACfAQMCbwQFALwCAdMGAAAAnwIDAsADBwASAAAAMAMCIggAAACCAAEACQMGBAAAAEADBwMIAwkDCgMLBgADBQEAAQABGAAAAAAAAAABAAAAAAACAAAAAQAAAAYBAAAAAAE7U0TpurXdKTTv9oGjx+V6S0tTnQmXLug=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:28:54
-- Luau version 6, Types version 3
-- Time taken: 0.000874 seconds

local LocalizationService_upvr = game:GetService("LocalizationService")
game:GetService("ReplicatedStorage"):WaitForChild("HawkeyeRemoteFunction").OnClientInvoke = function() -- Line 5, Named "OnClientInvoke"
    --[[ Upvalues[1]:
        [1]: LocalizationService_upvr (readonly)
    ]]
    return {
        system_locale = LocalizationService_upvr.SystemLocaleId;
        account_locale = LocalizationService_upvr.RobloxLocaleId;
    }
end