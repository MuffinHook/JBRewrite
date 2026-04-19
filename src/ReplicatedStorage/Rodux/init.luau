-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMJB3JlcXVpcmUGc2NyaXB0BVN0b3JlDWNyZWF0ZVJlZHVjZXIPY29tYmluZVJlZHVjZXJzEW1ha2VBY3Rpb25DcmVhdG9yEGxvZ2dlck1pZGRsZXdhcmUPdGh1bmtNaWRkbGV3YXJlCm1pZGRsZXdhcmUAAQgAAAECGwAABg8AAToPAQgzDwIPLA8DFiUPBB0eDwUkFzujAAAApAABAAAAAECkAgMAAAAgQE0BAl4EAAAAnwACAqQBAQAAAABApAMDAAAAIEBNAgPWBQAAAJ8BAgKkAgEAAAAAQKQEAwAAACBATQME4wYAAACfAgICpAMBAAAAAECkBQMAAAAgQE0EBVsHAAAAnwMCAqQEAQAAAABApAYDAAAAIEBNBQb6CAAAAJ8EAgKkBQEAAAAAQKQHAwAAACBATQYHZAkAAACfBQIC4gYKADAABl4EAAAAMAEG1gUAAAAwAgbjBgAAADADBlsHAAAATQcEbgsAAAAwBwb6CAAAADAFBmQJAAAAggYCAAwDAQQAAABAAwIEAAAgQAMDAwQDBQMGAwcDCAUGBAUGBwgJAwkAAQABGAAAAAAAAAAAAQAAAAAAAAEAAAAAAAABAAAAAAAAAQAAAAAAAAEAAAAAAAACAQABAAEAAQABAAAAAQAAAQAAAAAA3BZhb2qiNe3u0gv7R0L3FurgzLvoudz8Ww5nTYVW3C89AY3Cy6DmDA==

local v0 = require(script.Store);
local v1 = require(script.createReducer);
local v2 = require(script.combineReducers);
local v3 = require(script.makeActionCreator);
local v4 = require(script.loggerMiddleware);
local v5 = require(script.thunkMiddleware);
return {
    Store = v0, 
    createReducer = v1, 
    combineReducers = v2, 
    makeActionCreator = v3, 
    loggerMiddleware = v4.middleware, 
    thunkMiddleware = v5
};