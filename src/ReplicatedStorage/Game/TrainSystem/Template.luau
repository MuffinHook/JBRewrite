local Default_upvr = require(script.Parent.Default)
return {
    MakeCar = function(arg1) -- Line 4, Named "MakeCar"
        return Default_upvr.MakeCar(arg1)
    end;
    MoveCar = function(arg1, arg2, arg3, arg4) -- Line 8, Named "MoveCar"
        return Default_upvr.MoveCar(arg1, arg2, arg3, arg4)
    end;
    DestroyCar = function(arg1) -- Line 13, Named "DestroyCar"
        return Default_upvr.DestroyCar(arg1)
    end;
}