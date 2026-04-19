-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMHA25ldwdyZXF1aXJlBnNjcmlwdAZQYXJlbnQFV2hlZWwHX19pbmRleAxzZXRtZXRhdGFibGUAAgQBAQAAAAf7AQAATQEB7wAAAABSAgAAqQMBAJ8BAwKCAQIAAQMBAAYBARgAAAAAAAABBwAAAAAFAAABAgAaowAAAKQAAQAAAABApAEDAAAAIEBNAQEkBAAAAE0BAb8FAAAAnwACAv8BAgAAAAAAMAEBbgYAAACePQEFAAAAAFIDAQBSBAAApAIIAAAAcECfAgMBwAIJABIAAAAwAgHvCgAAAIIBAgALAwIEAAAAQAMDBAAAIEADBAMFAwYDBwQAAHBABgADAQEAAQABGAAAAAAAAAAAAAACAAEAAQAAAAAAAAEAAAAEAQAAAAABCkZ210zHr/6jyhweNAZ+QnpeYaM4ghzW

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:39:52
-- Luau version 6, Types version 3
-- Time taken: 0.000620 seconds

local Wheel_upvr = require(script.Parent.Wheel)
local module = {}
module.__index = module
setmetatable(module, Wheel_upvr)
function module.new(arg1) -- Line 6
    --[[ Upvalues[1]:
        [1]: Wheel_upvr (readonly)
    ]]
    return Wheel_upvr.new(arg1, true)
end
return module