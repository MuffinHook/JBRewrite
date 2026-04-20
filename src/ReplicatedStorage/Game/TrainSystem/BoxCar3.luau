local BoxCar_upvr = require(script.Parent.BoxCar)
return {
    MakeCar = function(arg1) -- Line 2, Named "MakeCar"
        return BoxCar_upvr.MakeCar(arg1)
    end;
    MoveCar = function(arg1, arg2, arg3, arg4) -- Line 5, Named "MoveCar"
        return BoxCar_upvr.MoveCar(arg1, arg2, arg3, arg4)
    end;
    DestroyCar = function(arg1) -- Line 8, Named "DestroyCar"
        return BoxCar_upvr.DestroyCar(arg1)
    end;
}