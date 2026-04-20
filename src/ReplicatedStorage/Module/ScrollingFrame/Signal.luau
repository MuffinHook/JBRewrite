return {
    new = function() -- Line 30, Named "new"
        local module = {}
        local BindableEvent_upvw = Instance.new("BindableEvent")
        local var4_upvw
        local var5_upvw
        function module.fire(arg1, ...) -- Line 38
            var4_upvw = {...}
            var5_upvw = select('#', ...)
            BindableEvent_upvw:Fire()
        end
        function module.connect(arg1, arg2) -- Line 44
            if not arg2 then
                error("connect(nil)", 2)
            end
            return BindableEvent_upvw.Event:connect(function() -- Line 48
                arg2(unpack(var4_upvw, 1, var5_upvw))
            end)
        end
        function module.wait(arg1) -- Line 53
            BindableEvent_upvw.Event:wait()
            assert(var4_upvw, "Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.")
            return unpack(var4_upvw, 1, var5_upvw)
        end
        function module.Destroy(arg1) -- Line 59
            BindableEvent_upvw:Destroy()
            var4_upvw = nil
            var5_upvw = nil
            BindableEvent_upvw = nil
        end
        return module
    end;
}