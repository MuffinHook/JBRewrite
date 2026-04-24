-- Reviewed by Claude
local GlobalConfig = require(script.GlobalConfig)
local createReconciler = require(script.createReconciler)
local createReconcilerCompat = require(script.createReconcilerCompat)
local RobloxRenderer = require(script.RobloxRenderer)
local strict = require(script.strict)
local Binding = require(script.Binding)
local v1 = createReconciler(RobloxRenderer)
local v2 = createReconcilerCompat(v1)
return strict({
	Component = require(script.Component),
	createElement = require(script.createElement),
	createFragment = require(script.createFragment),
	oneChild = require(script.oneChild),
	PureComponent = require(script.PureComponent),
	None = require(script.None),
	Portal = require(script.Portal),
	createRef = require(script.createRef),
	forwardRef = require(script.forwardRef),
	createBinding = Binding.create,
	joinBindings = Binding.join,
	createContext = require(script.createContext),
	Change = require(script.PropMarkers.Change),
	Children = require(script.PropMarkers.Children),
	Event = require(script.PropMarkers.Event),
	Ref = require(script.PropMarkers.Ref),
	mount = v1.mountVirtualTree,
	unmount = v1.unmountVirtualTree,
	update = v1.updateVirtualTree,
	reify = v2.reify,
	teardown = v2.teardown,
	reconcile = v2.reconcile,
	setGlobalConfig = GlobalConfig.set,
	UNSTABLE = {}
})