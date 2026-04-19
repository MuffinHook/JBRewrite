-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMGBnR5cGVvZgZzdHJpbmcSc3RyIG11c3QgYmUgc3RyaW5nBmFzc2VydARieXRlFXBvbHlub21pYWxSb2xsaW5nSGFzaAACCAEAAAAPAAADAgUUCg8EEA4CAQ8RILssAANSBAAApAMBAAAAAECfAwIC8AMCAAIAAACpAgABqQIBAIEBAgQDAAAAbwMDAKQBBQAAAEBAnwEDAYwBAACMBAEAHAIAAIwDAQCoAgsAnikABQQAAABSBgAAUgcEAKQFBwAAGCCAnwUDAlsHAQlDBgcFIQEGCIsC9f+CAQIACgMBBAAAAEADAgMDAwQEAABAQAMFBAAYIIACAACABGXNzUECAAAAAAAAP0AABQYBGAAAAAAAAAAAAAAAAAAAAAMBAAAAAQAAAAAAAAEAAP4EBgAAAAACAAABAgcAAAEPAAEGB6MAAAD/AAEAAAAAAMABAAAwAQDQAQAAAIIAAgACBgADBgEAAQABGAABAAMAAAwBAAAAAAGDKgCiBWsKd7HuajZqIRFA6IYI58wqA0pQLooVDTLcwAGdrZ8jiogV

return {
    polynomialRollingHash = function(v0) --[[ Line: 5 ]] --[[ Name: polynomialRollingHash ]]
        assert(typeof(v0) == "string", "str must be string");
        local v1 = 0;
        for v2 = 1, #v0 do
            local v3 = string.byte(v0, v2);
            v1 = (v1 * 31 + v3) % 1000000009;
        end;
        return v1;
    end
};