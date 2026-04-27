return function(typeRegistry)
	typeRegistry:RegisterType("conditionFunction", typeRegistry.Cmdr.Util.MakeEnumType("ConditionFunction", { "startsWith" }))
end
