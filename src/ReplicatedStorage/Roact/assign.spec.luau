-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

return function() --[[ Line: 1 ]]
    local v0 = require(script.Parent.None);
    local v1 = require(script.Parent.assign);
    it("should accept zero additional tables", function() --[[ Line: 6 ]]
        -- upvalues: v1 (copy)
        local v2 = {};
        local v3 = v1(v2);
        expect(v2).to.equal(v3);
    end);
    it("should merge multiple tables onto the given target table", function() --[[ Line: 13 ]]
        -- upvalues: v1 (copy)
        local v4 = {
            a = 5, 
            b = 6
        };
        local v5 = {
            b = 7, 
            c = 8
        };
        local v6 = {
            b = 8
        };
        v1(v4, v5, v6);
        expect(v4.a).to.equal(5);
        expect(v4.b).to.equal(v6.b);
        expect(v4.c).to.equal(v5.c);
    end);
    it("should remove keys if specified as None", function() --[[ Line: 35 ]]
        -- upvalues: v0 (copy), v1 (copy)
        local v7 = {
            foo = 2, 
            bar = 3
        };
        local v8 = {
            foo = v0
        };
        v1(v7, v8);
        expect(v7.foo).to.equal(nil);
        expect(v7.bar).to.equal(3);
    end);
    it("should re-add keys if specified after None", function() --[[ Line: 51 ]]
        -- upvalues: v0 (copy), v1 (copy)
        local v9 = {
            foo = 2
        };
        local v10 = {
            foo = v0
        };
        local v11 = {
            foo = 3
        };
        v1(v9, v10, v11);
        expect(v9.foo).to.equal(v11.foo);
    end);
end;