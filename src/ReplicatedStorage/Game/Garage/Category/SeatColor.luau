-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMDBU1vZGVsDkZpbmRGaXJzdENoaWxkBVNlYXRzAAIGAQAAAAAPTQEAOwAAAAArAQEAggABAG8EAAC8AgEDAQAAAJ8CAwIrAgEAggABAG8FAgC8AwIDAQAAAJ8DAwCCAwAAAwMBAwIDAwABAAEYAAABAQIAAAABAQIAAAAAAgAAAAABAAABAgADowAAAMAAAACCAAIAAQYAAQABAAEYAAAAAQAAAAAB

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:47
-- Luau version 6, Types version 3
-- Time taken: 0.000617 seconds

return function(arg1) -- Line 1
    local Model_2 = arg1.Model
    if not Model_2 then return end
    local Model = Model_2:FindFirstChild("Model")
    if not Model then return end
    return Model:FindFirstChild("Seats")
end