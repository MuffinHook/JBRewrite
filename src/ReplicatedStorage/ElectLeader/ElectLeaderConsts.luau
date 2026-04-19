-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMOBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlA0FwcAlSdW5Db25zdHMIUnVuVXRpbHMDU3RkClRhYmxlVXRpbHMacmVxdWlyZVZhbGlkSW5kZXhBbmRGcmVlemUbTUFYX1JBTkRfREVDSU1BTF9UT19ET19UQVNLD01BWF9KSVRURVJfVElNRQZnZXRFbnYJUFJPRF9OQU1FAAEJAAABAgAwowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQIAwQYAAABNAgJvBwAAAJ8BAgKkAgUAAABAQE0DAMEGAAAATQMDQggAAACfAgICpAMFAAAAQEBNBAChCQAAAE0EBBgKAAAAnwMCAk0EAwALAAAA4gUOAE0HAo4PAAAAnwcBAk0IAcEQAAAAmgcDAAgAAABvBhEAZQABAIwGAQAwBgV4DAAAAIwGWAIwBgXIDQAAAJ8EAgCCBAAAEgMBBAAAAEADAgMDAwQEAABAQAMFAwYDBwMIAwkDCgMLAwwFAgwNAw0DDgKamZmZmZm5PwABAAEYAAAAAAAAAAEAAAAAAAABAAAAAAAAAQAAAAAAAAEAAAEAAAAAAAAAAAAAAAEAAP4AAQAAAAAAqSXpCXoPBiHjQuOFJAdazdk9/n2b4YMI

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:32
-- Luau version 6, Types version 3
-- Time taken: 0.000965 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local var3
if require(ReplicatedStorage.App.RunUtils).getEnv() == require(ReplicatedStorage.App.RunConsts).PROD_NAME then
    var3 = 0.1
else
    var3 = 1
end
module.MAX_RAND_DECIMAL_TO_DO_TASK = var3
var3 = 600
module.MAX_JITTER_TIME = var3
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze(module)