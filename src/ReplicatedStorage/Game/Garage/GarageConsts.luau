-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlA1N0ZApUYWJsZVV0aWxzA0FwcAhSdW5VdGlscxpyZXF1aXJlVmFsaWRJbmRleEFuZEZyZWV6ZRpTUEFXTl9ERUJPVU5DRV9OT05fUFJFTUlVTRZTUEFXTl9ERUJPVU5DRV9QUkVNSVVNF1NQQVdOX0RFQk9VTkNFX1BIWVNJQ0FMDk5VTV9TQVZFX1NMT1RTE05VTV9GUkVFX1NBVkVfU0xPVFMLaXNNYWluV29ybGQAAQcAAAECADWjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgChBgAAAE0CAhgHAAAAnwECAqQCBQAAAEBATQMAwQgAAABNAwNCCQAAAJ8CAgJNAwEACgAAAOIEEABNBgJQEQAAAJ8GAQIOBgIAjAVaAGUAAQCMBR4AMAUEbgsAAABNBgJQEQAAAJ8GAQIOBgIAjAU8AGUAAQCMBQoAMAUErgwAAACMBQUAMAUEdA0AAACMBRQAMAUEtQ4AAACMBQoAMAUELw8AAACfAwIAggMAABIDAQQAAABAAwIDAwMEBAAAQEADBQMGAwcDCAMJAwoDCwMMAw0DDgUFCwwNDg8DDwABAAEYAAAAAAAAAAEAAAAAAAABAAAAAAAAAQAAAQAAAAAAAAAAAQAAAAAAAAAAAQAAAgAAAQAA+gABAAAAAABm9SFR4+KbjuHk0slbFYxiFu02JVQxS1A=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:15
-- Luau version 6, Types version 3
-- Time taken: 0.001130 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunUtils = require(ReplicatedStorage.App.RunUtils)
local module = {}
local var4
if RunUtils.isMainWorld() then
    var4 = 90
else
    var4 = 30
end
module.SPAWN_DEBOUNCE_NON_PREMIUM = var4
if RunUtils.isMainWorld() then
    var4 = 60
else
    var4 = 10
end
module.SPAWN_DEBOUNCE_PREMIUM = var4
var4 = 5
module.SPAWN_DEBOUNCE_PHYSICAL = var4
var4 = 20
module.NUM_SAVE_SLOTS = var4
var4 = 10
module.NUM_FREE_SAVE_SLOTS = var4
return require(ReplicatedStorage.Std.TableUtils).requireValidIndexAndFreeze(module)