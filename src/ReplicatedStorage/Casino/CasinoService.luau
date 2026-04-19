-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMKB3JlcXVpcmUGc2NyaXB0BlBhcmVudBVWYXVsdERvb3JQdXp6bGVCaW5kZXIFU3RhcnQTQ3V0dGFibGVHbGFzc0JpbmRlchRDYXNpbm9Sb2JiZXJ5U2VydmljZQRpbml0EE5pZ2h0Y2x1YlNlcnZpY2UNU3Bpbm5lckJpbmRlcgACAgAAAAAAPaQAAQAAAABApAEDAAAAIEBNAQEkBAAAAE0BAdEFAAAAnwACArwAABwGAAAAnwACAaQAAQAAAABApAEDAAAAIEBNAQEkBAAAAE0BAasHAAAAnwACArwAABwGAAAAnwACAaQAAQAAAABApAEDAAAAIEBNAQEkBAAAAE0BAWkIAAAAnwACAk0AABMJAAAAnwABAaQAAQAAAABApAEDAAAAIEBNAQEkBAAAAE0BAcIKAAAAnwACAk0AABMJAAAAnwABAaQAAQAAAABApAEDAAAAIEBNAQEkBAAAAE0BAZ0LAAAAnwACArwAABwGAAAAnwACAYIAAQAMAwEEAAAAQAMCBAAAIEADAwMEAwUDBgMHAwgDCQMKAAIIARgAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAABAwAAAAACAAABAgAHowAAAP8AAQAAAAAAwAEAADABABMBAAAAggACAAIGAAMIAQABAAEYAAAAAQAABwEAAAAAAZFKtzz2GK3EhL6nEggWK/jhUqBIo47dPQ==

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:41:00
-- Luau version 6, Types version 3
-- Time taken: 0.000837 seconds

return {
    init = function() -- Line 2, Named "init"
        require(script.Parent.VaultDoorPuzzleBinder):Start()
        require(script.Parent.CuttableGlassBinder):Start()
        require(script.Parent.CasinoRobberyService).init()
        require(script.Parent.NightclubService).init()
        require(script.Parent.SpinnerBinder):Start()
    end;
}