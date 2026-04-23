local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
return function(p1) --[[ Line: 5 | Upvalues: Roact (copy), createElement (copy) ]]
	local v1 = Roact.Component:extend("App")
	local LikePrompt = require(script.Parent.LikePrompt)
	function v1.init(p1) --[[ Line: 8 ]]
		p1:setState({
			visible = true
		})
	end
	function v1.render(p1) --[[ Line: 13 | Upvalues: createElement (ref), LikePrompt (copy) ]]
		return createElement(LikePrompt, {
			visible = p1.state.visible,
			countdownTil = workspace:GetServerTimeNow() + 20,
			onClickDone = function() --[[ Name: onClickDone | Line: 17 | Upvalues: p1 (copy) ]]
				print("clicked done..")
				p1:setState({
					visible = false
				})
			end,
			onExpired = function() --[[ Name: onExpired | Line: 23 | Upvalues: p1 (copy) ]]
				print("expired..")
				p1:setState({
					visible = false
				})
			end
		})
	end
	function v1.willUnmount(p1) --[[ Line: 31 ]] end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 34 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end
end