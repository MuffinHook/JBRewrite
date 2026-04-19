-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMRDGdhbWVwYXNzRW51bQZ0eXBlb2YGbnVtYmVyHUluY29ycmVjdCBnYW1lcGFzc0VudW0gcGFzc2VkBmFzc2VydA1nYW1lcGFzc093bmVkB2Jvb2xlYW4kSW5jb3JyZWN0IGdhbWVwYXNzT3duZWQgdmFsdWUgcGFzc2VkBXRhYmxlBWNsb25lEHNldEdhbWVwYXNzT3duZWQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUFUm9kdXgNY3JlYXRlUmVkdWNlcgACBgIAAAAAKk0FAXIAAAAAuywFAqQEAgAAABBAnwQCAvAEAgADAAAAqQMAAakDAQCBAQMEBAAAAG8EBACkAgYAAABQQJ8CAwFNBQEMBwAAALssBQKkBAIAAAAQQJ8EAgLwBAIACAAAAKkDAAGpAwEAgQEDBAkAAABvBAkApAIGAAAAUECfAgMBpAIMAAAsoIBSAwAAnwICAk0DAXIAAAAATQQBDAcAAABqBAIDggICAA0DAQMCBAAAEEADAwMEAwUEAABQQAMGAwcDCAMJAwoEACyggAAFCwEYAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAABAAAAAQAAAAABBgAAAAAGAAABAgAWowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIApwYAAACfAQICTQIB1gcAAAD/AwAAAAAAAOIECQDABQoAMAUE/ggAAACfAgMAggIAAAsDDAQAAABAAw0DDgMPBAAAQEADEAMRAwsFAQgGAAEAAQABGAAAAAAAAAABAAAAAAIAAAAAAQAA/wABAAAAAAGpwOoWwm+PUhp6rNJ72wAS2dj9YpsEgBc=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:20
-- Luau version 6, Types version 3
-- Time taken: 0.001302 seconds

return require(game:GetService("ReplicatedStorage").Rodux).createReducer({}, {
    setGamepassOwned = function(arg1, arg2) -- Line 5, Named "setGamepassOwned"
        local var2
        if typeof(arg2.gamepassEnum) ~= "number" then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "Incorrect gamepassEnum passed")
        if typeof(arg2.gamepassOwned) ~= "boolean" then
            var2 = false
        else
            var2 = true
        end
        assert(var2, "Incorrect gamepassOwned value passed")
        var2 = arg1
        local clone = table.clone(var2)
        var2 = arg2.gamepassEnum
        clone[var2] = arg2.gamepassOwned
        return clone
    end;
})