-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMIBEdhbWUKSXRlbUNvbmZpZw5GaW5kRmlyc3RDaGlsZAdyZXF1aXJlCWdldENvbmZpZwRnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UAAgQBAQAAABL7AQAATQEBvQAAAABNAQEsAQAAAFIDAAC8AQEDAgAAAJ8BAwJHAQMAAAAAgMYCAACCAgIApAIEAAAAMEBSAwEAnwICAoICAgAFAwEDAgMDAwQEAAAwQAAFBQEYAAAAAAAAAAAAAQABAAIAAAABBgAAAAADAAABAgAOowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAv8BAQAAAAAAwAIEABIAAAAwAgFRBQAAAIIBAgAGAwYEAAAAQAMHAwgGAAMFAQABAAEYAAAAAAAAAAIAAgAAAAgBAAAAAAFmpp1o18kBFWMVGyW+cdWMFr6KHFRi92k=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:40:18
-- Luau version 6, Types version 3
-- Time taken: 0.001012 seconds

local module = {}
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function module.getConfig(arg1) -- Line 5
    --[[ Upvalues[1]:
        [1]: ReplicatedStorage_upvr (readonly)
    ]]
    local SOME = ReplicatedStorage_upvr.Game.ItemConfig:FindFirstChild(arg1)
    if SOME == nil then
        return nil
    end
    return require(SOME)
end
return module