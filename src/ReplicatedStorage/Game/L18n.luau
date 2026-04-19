-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMVCVNjcmVlbkd1aQl3b3Jrc3BhY2UETDE4bg5GaW5kRmlyc3RDaGlsZAZpcGFpcnMLR2V0Q2hpbGRyZW4KU3VyZmFjZUd1aQlUZXh0TGFiZWwId29ybGQuJXMETmFtZQZmb3JtYXQLRm9ybWF0QnlLZXkEVGV4dARnYW1lEVJlcGxpY2F0ZWRTdG9yYWdlCkdldFNlcnZpY2UHUGxheWVycwtMb2NhbFBsYXllcgdyZXF1aXJlDExvY2FsaXphdGlvbgZNb2R1bGUAAg8BAQAABwAAAQMMIAIrTQEAegAAAACkAgIAAAAQQG8EAwC8AgIDBAAAAJ8CAwIOAiEApAMGAAAAUEC8BAJoBwAAAJ8EAgCfAwAEUQMYAG8KCAC8CAcDBAAAAJ8IAwJHCBMAAAAAAG8LCQC8CQgDBAAAAJ8JAwJHCQ0AAAAAAPsKAABvDAoATQ4HugsAAAC8DAyNDAAAAJ8MAwC8CgqbDQAAAJ8KAAIwCgn1DgAAAG4D5/8CAACAggABAA8DAQMCBAAAEEADAwMEAwUEAABQQAMGAwcDCAMJAwoDCwMMAw0ABgABGAAAAgAAAAAAAQEAAAAAAAABAAAAAQABAAAAAQABAAAAAAAAAAAAAAD7ABcHAAAAAAYAAAECABmjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEBAAAAAEBvAwQAvAEBFgMAAACfAQMCTQIBMQUAAACkAwcAAABgQE0FAEAJAAAATQQFfAgAAACfAwICwAQKABIAAwCCBAIACwMOBAAAAEADDwMQAxEDEgMTBAAAYEADFAMVBgABAAEAARgAAAAAAAAAAQAAAAAAAQABAAAAAAAAAgAAAQAAAAABFaj4Hbk0igqWUwzBfupFrGWw72knbJIc

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:34:20
-- Luau version 6, Types version 3
-- Time taken: 0.002394 seconds

local Localization_upvr = require(game:GetService("ReplicatedStorage").Module.Localization)
return function(arg1) -- Line 6
    --[[ Upvalues[1]:
        [1]: Localization_upvr (readonly)
    ]]
    local L18n = workspace:FindFirstChild("L18n")
    if L18n then
        for _, v in ipairs(L18n:GetChildren()) do
            local SurfaceGui_2 = v:FindFirstChild("SurfaceGui")
            if SurfaceGui_2 ~= nil then
                local TextLabel_2 = SurfaceGui_2:FindFirstChild("TextLabel")
                if TextLabel_2 ~= nil then
                    TextLabel_2.Text = Localization_upvr:FormatByKey("world.%s":format(v.Name))
                end
            end
        end
    end
end