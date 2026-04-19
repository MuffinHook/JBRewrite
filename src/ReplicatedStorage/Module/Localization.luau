-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMTG0dldFRyYW5zbGF0b3JGb3JQbGF5ZXJBc3luYwVwY2FsbAR3YXJuBnVucGFjawtGb3JtYXRCeUtleQxfZm9ybWF0QnlLZXkaTm8gdmFsaWQgdHJhbnNsYXRpb24gZm9yOiASQXR0ZW1wdEZvcm1hdEJ5S2V5BGdhbWUHUGxheWVycwpHZXRTZXJ2aWNlC0xvY2FsUGxheWVyE0xvY2FsaXphdGlvblNlcnZpY2UEdGFzawVzcGF3bhVHYW1lTG9jYWxpemF0aW9uVGFibGUOUm9ibG94TG9jYWxlSWQNR2V0VHJhbnNsYXRvcgVlbi11cwAJAwADAAAAB/sAAQD7AgIAvAAARwAAAACfAAMC3gAAAIIAAQABAwEACwABGAAAAAAAAAEMAAAAAAQAAwAAABCkAAEAAAAAQNkBAAASAgAAEgIBABICAgCfAAIDDgABAIIAAQCkAgMAAAAgQFIDAQCfAgIBxgIAAN4CAACCAAEABAMCBAAAAEADAwQAACBAAQAKAAEYAAAAAAAAAAMAAwAAAAEAAgsAAAAABQAEAAAADPsAAQD7AgIA+wQDALs1BAKkAwEAAAAAQJ8DAgC8AACbAgAAAJ8AAALeAAAAggABAAMDBAQAAABAAwUAHAABGAAAAAAAAAAAAAAAAR0AAAAABQAEAAAADPsAAQD7AgIA+wQDALs1BAKkAwEAAAAAQJ8DAgC8AACbAgAAAJ8AAALeAAAAggABAAMDBAQAAABAAwUAIAABGAAAAAAAAAAAAAAAASEAAAAABQAEAAAADPsAAQD7AgIA+wQDALs1BAKkAwEAAAAAQJ8DAgC8AACbAgAAAJ8AAALeAAAAggABAAMDBAQAAABAAwUAJQABGAAAAAAAAAAAAAAAASYAAAAABgEDAQAAKaMBAAD/AQAAAAAAAN0CAADFAQIAAQAAAMYCAACkAwEAAAAAQNkEAAASAQL/EgIAABIAAAASAAEAnwMCAisDCQCkBAEAAAAAQNkFAQASAQL/EgIBABIAAAASAAEAnwQCAlIDBAArAwkApAQBAAAAAEDZBQIAEgEC/xICAgASAAAAEgABAJ8EAgJSAwQAKwMBAFICAABSBAMAUgUCAMECAACCBAMAAgMCBAAAAEADAgMEGQYBGAABAAAAAAEBAAAAAAAAAAMBAAAAAAAAAAAEAQAAAAAAAAAABAECAAAAGQAAAAAHAQEBAAAMowEAAPsBAADdAgAAnwEAAysBBgCkAwEAAAAAQG8FAgBSBgIAcwQFBp8DAgGCAgIAAwMDBAAAAEADBwAuBQEYAAEAAAEBAAAAAAACLgAAAAADAQEBAAAFowEAAPsBAADdAgAAnwEAA4IBAwAAADYIARgAAQAAATYAAAAACQAAAQIANaMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwJNAQAxBAAAAKQCAQAAAABAbwQFALwCAhYDAAAAnwIDAsYDAAAOAQcApAQIAAAcYIDZBQAAEgED/xIAAgASAAEAnwQCAU0EAvQJAAAATQYCiwoAAAC8BAQZCwAAAJ8EAwJNBQL0CQAAAG8HDAC8BQUZCwAAAJ8FAwL/BgIAAAAAANkHAQASAQP/EgAEABIABQDACA0AEgAHADAIBpsOAAAAwAgPABIABwAwCAadEAAAAMEDAACCBgIAEQMJBAAAAEADCgMLAwwDDQMOAw8EABxggAMQAxEDEgMTBgYDBQYHAwgEAQUGBwEAARgABAAAAAAAAQABAAAAAAABAQEAAAAAAAAMAAAAAAAAAQAAAAAAAQABAAAAFQAAAAgAAAAEAAEAAAAACGHE2DvALsweHz3dh4LuOwsR3M9PUwCyOg==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:31
-- Luau version 6, Types version 3
-- Time taken: 0.004018 seconds

local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local LocalizationService_upvr = game:GetService("LocalizationService")
local var3_upvw
if LocalPlayer_upvr then
    task.spawn(function() -- Line 10
        --[[ Upvalues[3]:
            [1]: var3_upvw (read and write)
            [2]: LocalizationService_upvr (readonly)
            [3]: LocalPlayer_upvr (readonly)
        ]]
        local pcall_result1, pcall_result2 = pcall(function() -- Line 11
            --[[ Upvalues[3]:
                [1]: var3_upvw (copied, read and write)
                [2]: LocalizationService_upvr (copied, readonly)
                [3]: LocalPlayer_upvr (copied, readonly)
            ]]
            var3_upvw = LocalizationService_upvr:GetTranslatorForPlayerAsync(LocalPlayer_upvr)
        end)
        if pcall_result1 then
        else
            warn(pcall_result2)
            var3_upvw = nil
        end
    end)
end
local module = {}
local any_GetTranslator_result1_upvr_2 = LocalizationService_upvr.GameLocalizationTable:GetTranslator(LocalizationService_upvr.RobloxLocaleId)
local any_GetTranslator_result1_upvr = LocalizationService_upvr.GameLocalizationTable:GetTranslator("en-us")
local function _formatByKey_upvr(arg1, ...) -- Line 25, Named "_formatByKey"
    --[[ Upvalues[3]:
        [1]: var3_upvw (read and write)
        [2]: any_GetTranslator_result1_upvr_2 (readonly)
        [3]: any_GetTranslator_result1_upvr (readonly)
    ]]
    -- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
    local args_list_upvr = {...}
    local var13_upvw
    local var14_upvw
    if not pcall(function() -- Line 28
        --[[ Upvalues[4]:
            [1]: var13_upvw (read and write)
            [2]: var3_upvw (copied, read and write)
            [3]: arg1 (readonly)
            [4]: args_list_upvr (readonly)
        ]]
        var13_upvw = var3_upvw:FormatByKey(arg1, unpack(args_list_upvr))
    end) then
    end
    if not pcall(function() -- Line 32
        --[[ Upvalues[4]:
            [1]: var14_upvw (read and write)
            [2]: any_GetTranslator_result1_upvr_2 (copied, readonly)
            [3]: arg1 (readonly)
            [4]: args_list_upvr (readonly)
        ]]
        var14_upvw = any_GetTranslator_result1_upvr_2:FormatByKey(arg1, unpack(args_list_upvr))
    end) then
        local pcall_result1_2 = pcall(function() -- Line 37
            --[[ Upvalues[4]:
                [1]: var14_upvw (read and write)
                [2]: any_GetTranslator_result1_upvr (copied, readonly)
                [3]: arg1 (readonly)
                [4]: args_list_upvr (readonly)
            ]]
            var14_upvw = any_GetTranslator_result1_upvr:FormatByKey(arg1, unpack(args_list_upvr))
        end)
    end
    if not pcall_result1_2 then
        var14_upvw = arg1
    end
    return pcall_result1_2, var14_upvw
end
function module.FormatByKey(arg1, ...) -- Line 46
    --[[ Upvalues[1]:
        [1]: _formatByKey_upvr (readonly)
    ]]
    local _formatByKey_upvr_result1_2, _formatByKey_upvr_result2 = _formatByKey_upvr(...)
    if not _formatByKey_upvr_result1_2 then
        warn("No valid translation for: ".._formatByKey_upvr_result2)
    end
    return _formatByKey_upvr_result2
end
function module.AttemptFormatByKey(arg1, ...) -- Line 54
    --[[ Upvalues[1]:
        [1]: _formatByKey_upvr (readonly)
    ]]
    local _formatByKey_upvr_result1, _formatByKey_upvr_result2_2 = _formatByKey_upvr(...)
    return _formatByKey_upvr_result1, _formatByKey_upvr_result2_2
end
return module