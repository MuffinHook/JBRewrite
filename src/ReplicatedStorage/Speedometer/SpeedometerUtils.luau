local module_upvr = {
    studsToKm = function(arg1) -- Line 6, Named "studsToKm"
        return arg1 / 3 / 1000
    end;
    kmToStuds = function(arg1) -- Line 9, Named "kmToStuds"
        return arg1 * 3 * 1000
    end;
}
function module_upvr.studsToMi(arg1) -- Line 12
    return module_upvr.studsToKm(arg1) * 0.621371
end
function module_upvr.miToStuds(arg1) -- Line 15
    return module_upvr.kmToStuds(arg1 / 0.621371)
end
function module_upvr.sToH(arg1) -- Line 18
    return arg1 * 60 * 60
end
return module_upvr