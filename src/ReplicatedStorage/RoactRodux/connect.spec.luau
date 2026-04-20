return function() -- Line 1
    local connect_upvr = require(script.Parent.connect)
    local StoreProvider_upvr = require(script.Parent.StoreProvider)
    local Roact_upvr = require(script.Parent.Parent.Roact)
    local Rodux_upvr = require(script.Parent.Parent.Rodux)
    local function noop_upvr() -- Line 9, Named "noop"
        return nil
    end
    local function NoopComponent_upvr() -- Line 13, Named "NoopComponent"
        return nil
    end
    local any_combineReducers_result1_upvr = Rodux_upvr.combineReducers({
        count = function(arg1, arg2) -- Line 17, Named "countReducer"
            local var6 = arg1 or 0
            if arg2.type == "increment" then
                return var6 + 1
            end
            return var6
        end;
    })
    describe("Argument validation", function() -- Line 31
        it("should accept no arguments", function() -- Line 32
            connect_upvr()
        end)
        it("should accept one function", function() -- Line 36
            connect_upvr(noop_upvr)
        end)
        it("should accept two functions", function() -- Line 40
            connect_upvr(noop_upvr, noop_upvr)
        end)
        it("should accept only the second function", function() -- Line 44
            connect_upvr(nil, function() -- Line 45
            end)
        end)
        it("should accept one table of action creators", function() -- Line 48
            connect_upvr(nil, {
                foo = function() -- Line 50, Named "foo"
                end;
            })
        end)
        it("should throw if not passed a component", function() -- Line 54
            local function var18_upvr(arg1) -- Line 55
                return {}
            end
            expect(function() -- Line 59
                connect_upvr(var18_upvr)(nil)
            end).to.throw()
        end)
    end)
    it("should throw if not mounted under a StoreProvider", function() -- Line 65
        local var22_upvr = connect_upvr()(NoopComponent_upvr)
        expect(function() -- Line 68
            Roact_upvr.mount(Roact_upvr.createElement(var22_upvr))
        end).to.throw()
    end)
    it("should accept a higher-order function mapStateToProps", function() -- Line 73
        local function mapStateToProps() -- Line 74
            return function(arg1) -- Line 75
                return {
                    count = arg1.count;
                }
            end
        end
        Roact_upvr.unmount(Roact_upvr.mount(Roact_upvr.createElement(StoreProvider_upvr, {
            store = Rodux_upvr.Store.new(any_combineReducers_result1_upvr);
        }, {
            someComponent = Roact_upvr.createElement(connect_upvr(mapStateToProps)(NoopComponent_upvr));
        })))
    end)
    it("should not accept a higher-order mapStateToProps that returns a non-table value", function() -- Line 96
        local function mapStateToProps() -- Line 97
            return function(arg1) -- Line 98
                return "nope"
            end
        end
        local any_createElement_result1_upvr = Roact_upvr.createElement(StoreProvider_upvr, {
            store = Rodux_upvr.Store.new(any_combineReducers_result1_upvr);
        }, {
            someComponent = Roact_upvr.createElement(connect_upvr(mapStateToProps)(NoopComponent_upvr));
        })
        expect(function() -- Line 112
            Roact_upvr.mount(any_createElement_result1_upvr)
        end).to.throw()
    end)
    it("should not accept a mapStateToProps that returns a non-table value", function() -- Line 117
        local function mapStateToProps() -- Line 118
            return "nah"
        end
        local any_createElement_result1_upvr_2 = Roact_upvr.createElement(StoreProvider_upvr, {
            store = Rodux_upvr.Store.new(any_combineReducers_result1_upvr);
        }, {
            someComponent = Roact_upvr.createElement(connect_upvr(mapStateToProps)(NoopComponent_upvr));
        })
        expect(function() -- Line 131
            Roact_upvr.mount(any_createElement_result1_upvr_2)
        end).to.throw()
    end)
    it("should abort renders when mapStateToProps returns the same data", function() -- Line 136
        local function mapStateToProps(arg1) -- Line 137
            return {
                count = arg1.count;
            }
        end
        local var41_upvw = 0
        local function SomeComponent(arg1) -- Line 144
            var41_upvw += 1
        end
        local any_new_result1_3 = Rodux_upvr.Store.new(any_combineReducers_result1_upvr)
        expect(var41_upvw).to.equal(1)
        any_new_result1_3:dispatch({
            type = "an unknown action";
        })
        any_new_result1_3:flush()
        expect(var41_upvw).to.equal(1)
        any_new_result1_3:dispatch({
            type = "increment";
        })
        any_new_result1_3:flush()
        expect(var41_upvw).to.equal(2)
        Roact_upvr.unmount(Roact_upvr.mount(Roact_upvr.createElement(StoreProvider_upvr, {
            store = any_new_result1_3;
        }, {
            someComponent = Roact_upvr.createElement(connect_upvr(mapStateToProps)(SomeComponent));
        })))
    end)
    it("should only call mapDispatchToProps once and never re-render if no mapStateToProps was passed", function() -- Line 174
        local var48_upvw = 0
        local var52_upvw = 0
        local function SomeComponent(arg1) -- Line 187
            var52_upvw += 1
        end
        local any_new_result1_2 = Rodux_upvr.Store.new(any_combineReducers_result1_upvr)
        expect(var48_upvw).to.equal(1)
        expect(var52_upvw).to.equal(1)
        any_new_result1_2:dispatch({
            type = "an unknown action";
        })
        any_new_result1_2:flush()
        expect(var48_upvw).to.equal(1)
        expect(var52_upvw).to.equal(1)
        any_new_result1_2:dispatch({
            type = "increment";
        })
        any_new_result1_2:flush()
        expect(var48_upvw).to.equal(1)
        expect(var52_upvw).to.equal(1)
        Roact_upvr.unmount(Roact_upvr.mount(Roact_upvr.createElement(StoreProvider_upvr, {
            store = any_new_result1_2;
        }, {
            someComponent = Roact_upvr.createElement(connect_upvr(nil, function(arg1) -- Line 176
                var48_upvw += 1
                local module_2 = {}
                local function increment() -- Line 180
                    return arg1({
                        type = "increment";
                    })
                end
                module_2.increment = increment
                return module_2
            end)(SomeComponent));
        })))
    end)
    it("should dispatch the action using a table of action creators", function() -- Line 220
        local function SomeComponent(arg1) -- Line 229
            arg1.increment()
        end
        local any_new_result1_4 = Rodux_upvr.Store.new(any_combineReducers_result1_upvr)
        any_new_result1_4.changed:connect(function(arg1) -- Line 244
            expect(arg1.count).to.equal(1)
        end)
        Roact_upvr.unmount(Roact_upvr.mount(Roact_upvr.createElement(StoreProvider_upvr, {
            store = any_new_result1_4;
        }, {
            someComponent = Roact_upvr.createElement(connect_upvr(nil, {
                increment = function() -- Line 222, Named "increment"
                    return {
                        type = "increment";
                    }
                end;
            })(SomeComponent));
        })))
    end)
    it("should return result values from the dispatch passed to mapDispatchToProps", function() -- Line 251
        local var66_upvw
        expect(var66_upvw).to.be.a("function")
        expect(var66_upvw(function() -- Line 256, Named "fiveThunk"
            return 5
        end)).to.equal(5)
        Roact_upvr.unmount(Roact_upvr.mount(Roact_upvr.createElement(StoreProvider_upvr, {
            store = Rodux_upvr.Store.new(function() -- Line 252, Named "reducer"
                return 0
            end, nil, {Rodux_upvr.thunkMiddleware});
        }, {
            someComponent = Roact_upvr.createElement(connect_upvr(nil, function(arg1) -- Line 265, Named "mapDispatchToProps"
                local module = {}
                module.dispatch = arg1
                return module
            end)(function(arg1) -- Line 261, Named "SomeComponent"
                var66_upvw = arg1.dispatch
            end));
        })))
    end)
    it("should allow fields to be assigned on connected components", function() -- Line 289
        local function mapStateToProps(arg1) -- Line 290
            return {
                count = arg1.count;
            }
        end
        local var73_upvr = connect_upvr(mapStateToProps)(NoopComponent_upvr)
        expect(function() -- Line 298
            var73_upvr.SomeEnum = {
                Value = 1;
            }
        end).never.to.throw()
        expect(var73_upvr.SomeEnum).to.be.ok()
        expect(var73_upvr.SomeEnum.Value).to.equal(1)
    end)
    it("should never pass the store and innerProps to `mapStateToProps`", function() -- Line 309
        local tbl_upvr = {}
        local var78_upvw
        local any_new_result1 = Rodux_upvr.Store.new(any_combineReducers_result1_upvr)
        any_new_result1:dispatch({
            type = "increment";
        })
        any_new_result1:flush()
        expect(var78_upvw.store).to.equal(nil)
        expect(var78_upvw.innerProps).to.equal(nil)
        expect(var78_upvw.somePropName).to.equal(tbl_upvr)
        Roact_upvr.unmount(Roact_upvr.mount(Roact_upvr.createElement(StoreProvider_upvr, {
            store = any_new_result1;
        }, {
            parent = Roact_upvr.createElement(connect_upvr(function(arg1, arg2) -- Line 312, Named "mapStateToProps"
                var78_upvw = arg2
                expect(arg2.store).to.equal(nil)
                expect(arg2.innerProps).to.equal(nil)
                expect(arg2.somePropName).to.equal(tbl_upvr)
                return {
                    count = arg1.count;
                }
            end)(NoopComponent_upvr), {
                somePropName = tbl_upvr;
            });
        })))
    end)
end