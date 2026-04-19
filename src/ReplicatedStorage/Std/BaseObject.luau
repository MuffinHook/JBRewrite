-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMNDHNldG1ldGF0YWJsZQNuZXcEbWFpZANvYmoKRG9DbGVhbmluZwdEZXN0cm95B3JlcXVpcmUGc2NyaXB0BlBhcmVudARNYWlkCkJhc2VPYmplY3QJQ2xhc3NOYW1lB19faW5kZXgAAwQBAgAADAMCAQUBBw8PDwEAERH/AgIAAAAAAPsDAACePQIDAwAAAKQBAQAAAABAnwEDAvsDAQBNAgPvAgAAAJ8CAQIwAgEWAwAAADAAARMEAAAAggECAAUDAQQAAABAAwIDAwMEAAgCARgAAAAAAAAAAAIAAAAAAAEAAgkAAAAABAEAAAAADU0BABYAAAAAvAEBUQEAAACfAQIBgT0ABQIAAABSAgAAbwMCAKQBBAAAADBAnwEDAYIAAQAFAwMDBQADAQQAADBAABEGARgAAAAAAAEAAAAAAAABEgAAAAAEAAABAgsAAAIPAAEZDwEKEBqjAAAApAABAAAAAECkAwMAAAAgQE0CAyQEAAAATQECdgUAAACfAAIC/wEDAAAAAABvAgYAMAIB2wcAAAAwAQFuCAAAAMACCQASAAEAEgAAADACAe8KAAAAwAILADACAVAMAAAAggECAA0DBwQAAABAAwgEAAAgQAMJAwoDCwMMAw0GAAMCBgEDBgIAAQEAARgAAQAAAAAAAAAAAgABAAABAAIAAAAACQAABQEAAAAAAqc4sUf1G+gIlfzb04TNCeTaGXjmWQ3+/z/Tga4pgSNo0LenBVqrSlc=

local v0 = require(script.Parent.Maid);
local v1 = {
    ClassName = "BaseObject"
};
v1.__index = v1;
v1.new = function(v2) --[[ Line: 8 ]] --[[ Name: new ]]
    -- upvalues: v1 (copy), v0 (copy)
    local v3 = setmetatable({}, v1);
    v3.maid = v0.new();
    v3.obj = v2;
    return v3;
end;
v1.Destroy = function(v4) --[[ Line: 17 ]] --[[ Name: Destroy ]]
    v4.maid:DoCleaning();
    setmetatable(v4, nil);
end;
return v1;