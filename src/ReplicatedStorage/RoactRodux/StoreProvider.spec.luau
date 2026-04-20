return function() -- Line 1
    local StoreProvider_upvr = require(script.Parent.StoreProvider)
    local Roact_upvr = require(script.Parent.Parent.Roact)
    local Rodux_upvr = require(script.Parent.Parent.Rodux)
    it("should be instantiable as a component", function() -- Line 7
        local any_new_result1_2 = Rodux_upvr.Store.new(function() -- Line 8
            return 0
        end)
        local any_createElement_result1_2 = Roact_upvr.createElement(StoreProvider_upvr, {
            store = any_new_result1_2;
        })
        expect(any_createElement_result1_2).to.be.ok()
        Roact_upvr.unmount(Roact_upvr.mount(any_createElement_result1_2, nil, "StoreProvider-test"))
        any_new_result1_2:destruct()
    end)
    it("should expect a 'store' prop", function() -- Line 23
        local any_createElement_result1_3_upvr = Roact_upvr.createElement(StoreProvider_upvr)
        expect(function() -- Line 26
            Roact_upvr.mount(any_createElement_result1_3_upvr)
        end).to.throw()
    end)
    it("should accept a single child", function() -- Line 31
        local any_new_result1 = Rodux_upvr.Store.new(function() -- Line 32
            return 0
        end)
        local Folder = Instance.new("Folder")
        local any_createElement_result1 = Roact_upvr.createElement(StoreProvider_upvr, {
            store = any_new_result1;
        }, {
            test1 = Roact_upvr.createElement("Frame");
        })
        expect(any_createElement_result1).to.be.ok()
        local StoreProvider_test = Folder:FindFirstChild("StoreProvider-test", true)
        expect(StoreProvider_test).to.be.ok()
        expect(StoreProvider_test:IsA("Frame")).to.equal(true)
        Roact_upvr.unmount(Roact_upvr.mount(any_createElement_result1, Folder, "StoreProvider-test"))
        any_new_result1:destruct()
    end)
end