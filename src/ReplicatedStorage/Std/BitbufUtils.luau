-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMINVN0cmluZyB0b28gbG9uZyBmb3IgbGVuZ3RoIHRvIGJlIHdyaXR0ZW4gaW4gdWludCBzaXplBmFzc2VydAlXcml0ZVVpbnQKV3JpdGVCeXRlcwt3cml0ZVN0cmluZwhSZWFkVWludAlSZWFkQnl0ZXMKcmVhZFN0cmluZwADBwMAAAAAF4wGAgCyBQYBHAYCANQGAgAFAAAAqQQAAakEAQCBAQQEAAAAAG8FAACkAwIAAAAQQJ8DAwFSBQEAHAYCALwDAM4DAAAAnwMEAVIFAgC8AwAwBAAAAJ8DAwGCAAEABQMBAwIEAAAQQAMDAwQABAUBGAAAAAAAAAAAAAAAAAABAAAAAAEAAAABBQAAAAAGAgAAAAcAAAEPAgAJCVIEAQC8AgBKAAAAAJ8CAwJSBQIAvAMAlgEAAACfAwMAggMAAAIDBgMHAAkIARgAAAAAAQAAAAAKAAAAAAIAAAECBwAAAQ8AAQkKowAAAP8AAgAAAAAAwAEAADABADcBAAAAwAECADABALEDAAAAggACAAQGAAMFBgEDCAIAAQEAARgAAQACAAAFAAAEAQAAAAACDFTTyVAVq7I+kLld0wiUo7Q+ZbEhsmKubqxNw5kT+otx/PBza3BefQ==

return {
    writeString = function(v0, v1, v2) --[[ Line: 4 ]] --[[ Name: writeString ]]
        assert(2 ^ v1 >= #v2, "String too long for length to be written in uint size");
        v0:WriteUint(v1, #v2);
        v0:WriteBytes(v2);
    end, 
    readString = function(v3, v4) --[[ Line: 9 ]] --[[ Name: readString ]]
        return v3:ReadBytes((v3:ReadUint(v4)));
    end
};