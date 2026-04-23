local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PrivateServerConsts = require(ReplicatedStorage.PrivateServer.PrivateServerConsts)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local t = {
	promiseGetPrivateServerType = function() --[[ Name: promiseGetPrivateServerType | Line: 6 | Upvalues: RxInstanceUtils (copy), ReplicatedStorage (copy), PrivateServerConsts (copy) ]]
		return RxInstanceUtils.waitForAttribute(ReplicatedStorage, PrivateServerConsts.SERVER_TYPE_ATTR_NAME):timeout(10)
	end
}
function t.promiseGetIsBattleServer() --[[ Line: 9 | Upvalues: t (copy), PrivateServerConsts (copy) ]]
	return t.promiseGetPrivateServerType():andThen(function(p1) --[[ Line: 10 | Upvalues: PrivateServerConsts (ref) ]]
		return p1 == PrivateServerConsts.BATTLE_SERVER_SERVER_TYPE
	end)
end
function t.getPrivateServerType() --[[ Line: 14 | Upvalues: t (copy) ]]
	local v1, v2 = t.promiseGetPrivateServerType():await()
	if not v1 then
		error(v2)
	end
	return v2
end
function t.getIsBattleServer() --[[ Line: 21 | Upvalues: t (copy) ]]
	local v1, v2 = t.promiseGetIsBattleServer():await()
	if not v1 then
		error(v2)
	end
	return v2
end
return t