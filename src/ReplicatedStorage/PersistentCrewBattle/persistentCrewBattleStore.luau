-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMOBGdhbWURUmVwbGljYXRlZFN0b3JhZ2UKR2V0U2VydmljZQdyZXF1aXJlBVJvZHV4BVN0b3JlA25ldw9jb21iaW5lUmVkdWNlcnMPbGVhZGVyYm9hcmRJbmZvGGNyZXdzSW5TZXJ2ZXJEaXNwbGF5SW5mbxRQZXJzaXN0ZW50Q3Jld0JhdHRsZQdSZWR1Y2VyFmxlYWRlcmJvYXJkSW5mb1JlZHVjZXIfY3Jld3NJblNlcnZlckRpc3BsYXlJbmZvUmVkdWNlcgABBwAAAQIALKMAAACkAAEAAAAAQG8CAgC8AAAWAwAAAJ8AAwKkAQUAAABAQE0CAKcGAAAAnwECAk0CAV4HAAAATQIC7wgAAABNAwHjCQAAAOIEDACkBQUAAABAQE0GAFgNAAAATQYGKA4AAABNBgYdDwAAAJ8FAgIwBQTLCgAAAKQFBQAAAEBATQYAWA0AAABNBgYoDgAAAE0GBpMQAAAAnwUCAjAFBF8LAAAAnwMCAJ8CAACCAgAAEQMBBAAAAEADAgMDAwQEAABAQAMFAwYDBwMIAwkDCgUCCgsDCwMMAw0DDgABAAEYAAAAAAAAAAEAAAAAAQAAAAAAAAEAAAAAAAAAAAAAAQAAAAAAAAAAAAD+AAABAAAAAABnuxUXdYzL0qBCNn4X5KboF6MCY1V/fxY=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:44:47
-- Luau version 6, Types version 3
-- Time taken: 0.000779 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rodux = require(ReplicatedStorage.Rodux)
return Rodux.Store.new(Rodux.combineReducers({
    leaderboardInfo = require(ReplicatedStorage.PersistentCrewBattle.Reducer.leaderboardInfoReducer);
    crewsInServerDisplayInfo = require(ReplicatedStorage.PersistentCrewBattle.Reducer.crewsInServerDisplayInfoReducer);
}))