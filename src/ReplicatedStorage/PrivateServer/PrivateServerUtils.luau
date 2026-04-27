local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PrivateServerConsts = require(ReplicatedStorage.PrivateServer.PrivateServerConsts)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local PrivateServerUtils = {
	promiseGetPrivateServerType = function()
		return RxInstanceUtils.waitForAttribute(ReplicatedStorage, PrivateServerConsts.SERVER_TYPE_ATTR_NAME):timeout(10)
	end
}
function PrivateServerUtils.promiseGetIsBattleServer()
	return PrivateServerUtils.promiseGetPrivateServerType():andThen(function(serverType)
		return serverType == PrivateServerConsts.BATTLE_SERVER_SERVER_TYPE
	end)
end
function PrivateServerUtils.getPrivateServerType()
	local success, serverType = PrivateServerUtils.promiseGetPrivateServerType():await()
	if not success then
		error(serverType)
	end
	return serverType
end
function PrivateServerUtils.getIsBattleServer()
	local success, isBattleServer = PrivateServerUtils.promiseGetIsBattleServer():await()
	if not success then
		error(isBattleServer)
	end
	return isBattleServer
end
return PrivateServerUtils
