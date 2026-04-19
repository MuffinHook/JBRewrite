-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMPCHdhcm5PbmNld1JvYWN0LnJlaWZ5IGhhcyBiZWVuIHJlbmFtZWQgdG8gUm9hY3QubW91bnQgYW5kIHdpbGwgYmUgcmVtb3ZlZCBpbiBhIGZ1dHVyZSByZWxlYXNlLgpDaGVjayB0aGUgY2FsbCB0byBSb2FjdC5yZWlmeSBhdDoKEG1vdW50VmlydHVhbFRyZWUFcmVpZnl/Um9hY3QudGVhcmRvd24gaGFzIGJlZW4gcmVuYW1lZCB0byBSb2FjdC51bm1vdW50IGFuZCB3aWxsIGJlIHJlbW92ZWQgaW4gYSBmdXR1cmUgcmVsZWFzZS4KQ2hlY2sgdGhlIGNhbGwgdG8gUm9hY3QudGVhcmRvd24gYXQ6ChJ1bm1vdW50VmlydHVhbFRyZWUIdGVhcmRvd26AAVJvYWN0LnJlY29uY2lsZSBoYXMgYmVlbiByZW5hbWVkIHRvIFJvYWN0LnVwZGF0ZSBhbmQgd2lsbCBiZSByZW1vdmVkIGluIGEgZnV0dXJlIHJlbGVhc2UuCkNoZWNrIHRoZSBjYWxsIHRvIFJvYWN0LnJlY29uY2lsZSBhdDoKEXVwZGF0ZVZpcnR1YWxUcmVlCXJlY29uY2lsZRZjcmVhdGVSZWNvbmNpbGVyQ29tcGF0B3JlcXVpcmUGc2NyaXB0BlBhcmVudAdMb2dnaW5nAAUCAAIBAAUAAgAPDwyjAAAA+wEAAE0AAYgAAAAAbwEBAJ8AAgH7AQEATQABHQIAAADdAQAAnwAAAIIAAAADAwEDAgMDABoEARgAAQAAAAACAAAAAAAaAAAAAAIAAgEABQACAA8PDKMAAAD7AQAATQABiAAAAABvAQEAnwACAfsBAQBNAAHyAgAAAN0BAACfAAAAggAAAAMDAQMFAwYAIAcBGAABAAAAAAIAAAAAACAAAAAAAgACAQAFAAIADw8MowAAAPsBAABNAAGIAAAAAG8BAQCfAAIB+wEBAE0AATsCAAAA3QEAAJ8AAACCAAAAAwMBAwgDCQAmCgEYAAEAAAAAAgAAAAAAJgAAAAADAQEAAAgAAQEPDwEAEhL/AQMAAAAAANkCAAASAgAAEgAAADACAa0AAAAA2QIBABICAAASAAAAMAIBogEAAADZAgIAEgIAABIAAAAwAgEvAgAAAIIBAgADAwQDBwMKAwABAhcLARgAAAIAAAAABgAAAAAGAAAAAAYYAAAAAAQAAAECCwAAAg8AAQwPAQoDDaMAAACkAAEAAAAAQKQDAwAAACBATQIDJAQAAABNAQJ8BQAAAJ8AAgLAAQYAEgAAAIIBAgAHAwwEAAAAQAMNBAAAIEADDgMPBgMBAwEAARgABQAAAAAAAAAAEQAYAQAAAAAEaRIskPokYXJb1kYE1ekbz/QCaQLTxlMn1MzB1PBnN/eBkmuHfZWYTg==

local v0 = require(script.Parent.Logging);
return function(v1) --[[ Line: 23 ]] --[[ Name: createReconcilerCompat ]]
    -- upvalues: v0 (copy)
    return {
        reify = function(...) --[[ Line: 26 ]] --[[ Name: reify ]]
            -- upvalues: v0 (ref), v1 (copy)
            v0.warnOnce("Roact.reify has been renamed to Roact.mount and will be removed in a future release.\nCheck the call to Roact.reify at:\n");
            return v1.mountVirtualTree(...);
        end, 
        teardown = function(...) --[[ Line: 32 ]] --[[ Name: teardown ]]
            -- upvalues: v0 (ref), v1 (copy)
            v0.warnOnce("Roact.teardown has been renamed to Roact.unmount and will be removed in a future release.\nCheck the call to Roact.teardown at:\n");
            return v1.unmountVirtualTree(...);
        end, 
        reconcile = function(...) --[[ Line: 38 ]] --[[ Name: reconcile ]]
            -- upvalues: v0 (ref), v1 (copy)
            v0.warnOnce("Roact.reconcile has been renamed to Roact.update and will be removed in a future release.\nCheck the call to Roact.reconcile at:\n");
            return v1.updateVirtualTree(...);
        end
    };
end;