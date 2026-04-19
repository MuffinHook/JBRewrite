-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMEBU1vZGVsDVZlaGljbGVIb3JuSWQMR2V0QXR0cmlidXRlEVZlaGljbGVIb3JuQ3VzdG9tAAIFAQAAAAARqQEAAE0CADsAAAAAbwQBALwCAhICAAAAnwIDAkcCCAAAAAAATQIAOwAAAABvBAMAvAICEgIAAACfAgMCVgECAIIBAgAEAwEDAgMDAwQAAQABGAAAAAAAAAAAAAAAAAAAAAAAAgAAAAABAAABAgADowAAAMAAAACCAAIAAQYAAQABAAEYAAAAAQAAAAAB

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:44
-- Luau version 6, Types version 3
-- Time taken: 0.000695 seconds

return function(arg1) -- Line 1
    local var2 = false
    if arg1.Model:GetAttribute("VehicleHornId") ~= nil then
        var2 = not arg1.Model:GetAttribute("VehicleHornCustom")
    end
    return var2
end