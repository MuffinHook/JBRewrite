-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMFBU1vZGVsDlNlY29uZEludGVyaW9yDkZpbmRGaXJzdENoaWxkBE1ha2UFU2xvb3AAAgYBAAAAABFNAQA7AAAAACsBAQCCAAEAbwQBAKkFAQC8AgEDAgAAAJ8CBAIrAgYATQMArQMAAADwAwIABAAAAKkCAAGpAgEAggICAAUDAQMCAwMDBAMFAAEAARgAAAEBAgAAAAAAAAAAAAAAAAIAAAAAAQAAAQIAA6MAAADAAAAAggACAAEGAAEAAQABGAAAAAEAAAAAAQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:45
-- Luau version 6, Types version 3
-- Time taken: 0.001062 seconds

return function(arg1) -- Line 1
    local Model = arg1.Model
    if not Model then return end
    local SecondInterior = Model:FindFirstChild("SecondInterior", true)
    if not SecondInterior then
        if arg1.Make ~= "Sloop" then
            SecondInterior = false
        else
            SecondInterior = true
        end
    end
    return SecondInterior
end