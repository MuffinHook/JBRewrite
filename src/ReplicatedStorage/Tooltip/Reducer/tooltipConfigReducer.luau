-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPBXRhYmxlBWNsb25lBXZhbHVlBHRleHQOc2V0VG9vbHRpcFRleHQHdmlzaWJsZRFzZXRUb29sdGlwVmlzaWJsZQRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHcmVxdWlyZQVSb2R1eAdUb29sdGlwDVRvb2x0aXBDb25zdHMNY3JlYXRlUmVkdWNlcgADBAIAAAAADlICAAArAgIA/wIAAAAAAABSAAIApAICAAAEAIBSAwAAnwICAk0DAcwDAAAAMAMC1QQAAACCAgIABQMBAwIEAAQAgAMDAwQABgUBGAAAAAAAAQAAAAEAAAABCAAAAAAEAgAAAAAOUgIAACsCAgD/AgAAAAAAAFIAAgCkAgIAAAQAgFIDAACfAgICTQMBzAMAAAAwAwKgBAAAAIICAgAFAwEDAgQABACAAwMDBgANBwEYAAAAAAABAAAAAQAAAAEOAAAAAAcAAAECAB+jAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgCnBgAAAJ8BAgKkAgUAAABAQE0DAHUHAAAATQMDKwgAAACfAgICTQMB1gkAAADGBAAA4gUMAMAGDQAwBgViCgAAAMAGDgAwBgUmCwAAAJ8DAwCCAwAADwMIBAAAAEADCQMKAwsEAABAQAMMAw0DDgMPAwUDBwUCCgsGAAYBAgABAQABGAAAAAAAAAABAAAAAAEAAAAAAAACAAAAAQAABwAA+AABAAAAAAL8caN5nnTDHRzv6YN7xwBajGm0Dc61yXg=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:47:03
-- Luau version 6, Types version 3
-- Time taken: 0.001302 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer(nil, {
    setTooltipText = function(arg1, arg2) -- Line 6, Named "setTooltipText"
        local var3 = arg1
        if not var3 then
            var3 = {}
        end
        local clone = table.clone(var3)
        clone.text = arg2.value
        return clone
    end;
    setTooltipVisible = function(arg1, arg2) -- Line 13, Named "setTooltipVisible"
        local var5 = arg1
        if not var5 then
            var5 = {}
        end
        local clone_2 = table.clone(var5)
        clone_2.visible = arg2.value
        return clone_2
    end;
})