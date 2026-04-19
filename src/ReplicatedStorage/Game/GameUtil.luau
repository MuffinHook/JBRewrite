-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMWFGdldENlbnRlcldpbmRvd0dyb3VwBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlCFNldHRpbmdzCFJlc291cmNlA1N0ZAZTaWduYWwLV2luZG93R3JvdXAGTW9kdWxlBldpbmRvdwNuZXcNT25UZWFtQ2hhbmdlZAhFbnVtVGVhbQhQcmlzb25lcgRUZWFtCFNjaGVkdWxlBmJvdW50eQ9vbkJvdW50eUNoYW5nZWQOcmVtb3ZlRGVhdGhHdWkTcmVtb3ZlRGVhdGhMaWdodGluZwACAQABAAAAAvsAAACCAAIAAAAPAQEYAAAQAAAAAAcAAAECAESjAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAwBiBwAAAE0CA8oGAAAAnwECAqQCBQAAAEBATQMAoQgAAABNAwMfCQAAAJ8CAgKkAwUAAABAQE0FAEALAAAATQUFZQwAAABNBAUPCgAAAJ8DAgL/BAQAAAAAAE0FAu8NAAAAnwUBAjAFBC0OAAAATQUBTA8AAABNBQWeEAAAADAFBGwRAAAAxgUAADAFBKASAAAAjAUAADAFBFETAAAATQUC7w0AAACfBQECMAUEABQAAADGBQAAMAUEDRUAAADGBQAAMAUE4hYAAABNBQPvDQAAAJ8FAQLABhcAEgAFADAGBOAYAAAAggQCABkDAgQAAABAAwMDBAMFBAAAQEADBgMHAwgDCQMKAwsDDAMNAw4DDwMQAxEDEgMTAxQDFQMWBgADAQEAAQABGAAAAAAAAAABAAAAAAAAAQAAAAAAAAEAAAAAAAAAAAEAAQAAAAABAAAAAAABAAABAAABAAAAAAEAAAEAAAIAAAEAAAADAQAAAAABmh+VXuGeKCcq3wUx2EYEa+oHgiqo2/9f

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:34:18
-- Luau version 6, Types version 3
-- Time taken: 0.000923 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Std.Signal)
local module = {
    OnTeamChanged = Signal.new();
    Team = require(ReplicatedStorage.Resource.Settings).EnumTeam.Prisoner;
    Schedule = nil;
    bounty = 0;
    onBountyChanged = Signal.new();
    removeDeathGui = nil;
    removeDeathLighting = nil;
}
local any_new_result1_upvr = require(ReplicatedStorage.Module.Window.WindowGroup).new()
function module.getCenterWindowGroup() -- Line 15
    --[[ Upvalues[1]:
        [1]: any_new_result1_upvr (readonly)
    ]]
    return any_new_result1_upvr
end
return module