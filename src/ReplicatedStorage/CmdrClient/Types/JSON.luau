local HttpService_upvr = game:GetService("HttpService")
return function(arg1) -- Line 3
    arg1:RegisterType("json", {
        Validate = function(arg1_2) -- Line 5, Named "Validate"
            return pcall(HttpService_upvr.JSONDecode, HttpService_upvr, arg1_2)
        end;
        Parse = function(arg1_3) -- Line 9, Named "Parse"
            return HttpService_upvr:JSONDecode(arg1_3)
        end;
    })
end