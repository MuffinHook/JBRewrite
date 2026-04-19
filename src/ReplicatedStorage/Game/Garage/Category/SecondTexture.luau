-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMZBE1ha2UFTW9kZWwKU2Vjb25kQm9keQ5GaW5kRmlyc3RDaGlsZAtUcmFpbGJsYXplcgJSOAlNb2x0ZW5NMTIEUmF5OQpCZWFtSHlicmlkB0NvbmNlcHQHQ2Vsc2lvcgpKYWNrUmFiYml0CFNlbnRpbmVsCUJhbmFuYUNhcglFc2NhcGVCb3QGU2hvZ3VuCFBvc2VpZG9uBVN0dW50CERpcnRiaWtlBVNsb29wB0NydWlzZXIFV2VkZ2UKQmxhY2tiZWFyZAhPcmlvbk00MgdQb2xhaXJlAAIHAQEAAAARTQEArQAAAAD7AwAAhwIDAQ4CAgCpAgAAggICAE0CADsBAAAAKwIBAIIAAQBvBQIAqQYBALwDAgMDAAAAnwMEAIIDAAAEAwEDAgMDAwQAGwABGAAAAQAAAQACAAEBAgAAAAAAHAAAAAACAAABAgBFowAAAP8ABgAAAAAAqQEBADABANAAAAAAqQEBADABAMoBAAAAqQEBADABALwCAAAAqQEBADABADIDAAAAqQEBADABAJkEAAAAqQEBADABAGgFAAAAqQEBADABAM4GAAAAqQEBADABADQHAAAAqQEBADABAFsIAAAAqQEBADABAFgJAAAAqQEBADABAJ8KAAAAqQEBADABAMALAAAAqQEBADABAFkMAAAAqQEBADABAJYNAAAAqQEBADABAFwOAAAAqQEBADABAF4PAAAAqQEBADABAJgQAAAAqQEBADABADIRAAAAqQEBADABAIESAAAAqQEBADABAJITAAAAqQEBADABAF4UAAAAwAEVABIAAACCAQIAFgMFAwYDBwMIAwkDCgMLAwwDDQMOAw8DEAMRAxIDEwMUAxUDFgMXAxgDGQYAAQABAAEYAAIAAQAAAQAAAQAAAQAAAQAAAQAAAQAAAQAAAQAAAQAAAQAAAQAAAQAAAQAAAQAAAQAAAQAAAQAAAQAAAQAAAQAAAwAAAQAAAAABlbhKALXvd0MAZs2HWxYoEuWgXXSnfCAB

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:36:48
-- Luau version 6, Types version 3
-- Time taken: 0.001376 seconds

local tbl_upvr = {
    Trailblazer = true;
    R8 = true;
    MoltenM12 = true;
    Ray9 = true;
    BeamHybrid = true;
    Concept = true;
    Celsior = true;
    JackRabbit = true;
    Sentinel = true;
    BananaCar = true;
    EscapeBot = true;
    Shogun = true;
    Poseidon = true;
    Stunt = true;
    Dirtbike = true;
    Sloop = true;
    Cruiser = true;
    Wedge = true;
    Blackbeard = true;
    OrionM42 = true;
    Polaire = true;
}
return function(arg1) -- Line 27
    --[[ Upvalues[1]:
        [1]: tbl_upvr (readonly)
    ]]
    if tbl_upvr[arg1.Make] then
        return false
    end
    local Model = arg1.Model
    if not Model then return end
    return Model:FindFirstChild("SecondBody", true)
end