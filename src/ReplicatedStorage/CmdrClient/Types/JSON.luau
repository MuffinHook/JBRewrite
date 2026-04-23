local HttpService = game:GetService("HttpService")
return function(p1) --[[ Line: 3 | Upvalues: HttpService (copy) ]]
	p1:RegisterType("json", {
		Validate = function(p1) --[[ Name: Validate | Line: 5 | Upvalues: HttpService (ref) ]]
			return pcall(HttpService.JSONDecode, HttpService, p1)
		end,
		Parse = function(p1) --[[ Name: Parse | Line: 9 | Upvalues: HttpService (ref) ]]
			return HttpService:JSONDecode(p1)
		end
	})
end