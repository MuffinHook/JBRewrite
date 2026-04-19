-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- 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

return function() --[[ Line: 1 ]]
    local v0 = require(script.Parent.Parent.createElement);
    local v1 = require(script.Parent.Parent.createReconciler);
    local v2 = require(script.Parent.Parent.GlobalConfig);
    local v3 = require(script.Parent.Parent.NoopRenderer);
    local v4 = require(script.Parent.Parent.Component);
    local v5 = v1(v3);
    it("should return stack traces in initial renders", function() --[[ Line: 11 ]]
        -- upvalues: v4 (copy), v2 (copy), v0 (copy), v5 (copy)
        local v6 = v4:extend("TestComponent");
        local v7 = nil;
        v6.init = function(v8) --[[ Line: 15 ]] --[[ Name: init ]]
            -- upvalues: v7 (ref)
            v7 = v8:getElementTraceback();
        end;
        v6.render = function(_) --[[ Line: 19 ]] --[[ Name: render ]]
            return nil;
        end;
        local v10 = {
            elementTracing = true
        };
        v2.scoped(v10, function() --[[ Line: 27 ]]
            -- upvalues: v0 (ref), v6 (copy), v5 (ref)
            local v11 = v0(v6);
            v5.mountVirtualNode(v11, nil, "Some key");
        end);
        expect(v7).to.be.a("string");
    end);
    itSKIP("it should return an updated stack trace after an update", function() --[[ Line: 38 ]]

    end);
    it("should return nil when elementTracing is off", function() --[[ Line: 40 ]]
        -- upvalues: v4 (copy), v2 (copy), v0 (copy), v5 (copy)
        local v12 = nil;
        local v13 = {
            elementTracing = false
        };
        local v14 = v4:extend("TestComponent");
        v14.init = function(v15) --[[ Line: 49 ]] --[[ Name: init ]]
            -- upvalues: v12 (ref)
            v12 = v15:getElementTraceback();
        end;
        v14.render = function(_) --[[ Line: 53 ]] --[[ Name: render ]]
            return nil;
        end;
        v2.scoped(v13, function() --[[ Line: 57 ]]
            -- upvalues: v0 (ref), v14 (copy), v5 (ref)
            local v17 = v0(v14);
            v5.mountVirtualNode(v17, nil, "Some key");
        end);
        expect(v12).to.equal(nil);
    end);
end;