--!strict
local Rodux = require(script.Parent.Parent.Rodux)

type Action = { type: string }
type ThunkAction<ReturnType, State> = (State) -> ReturnType
type ActionCreator<Type, Payload> = ((Payload) -> Action) & { name: Type }

export type DispatchProp = <Payload>(action: Payload & Action) -> ()

export type ThunkfulDispatchProp<State = any> =
	DispatchProp
	& <ReturnType>(thunkAction: ThunkAction<ReturnType, State>) -> ReturnType

export type MapStateToProps<StoreState, Props, PartialProps> = (StoreState, Props) -> PartialProps?

export type MapStateToPropsOrThunk<StoreState, Props, PartialProps> =
	MapStateToProps<StoreState, Props, PartialProps>
	| () -> MapStateToProps<StoreState, Props, PartialProps>

export type ActionCreatorMap = {
	[string]: ActionCreator<any, any, ...any>,
}

export type MapDispatchToProps<StoreState, PartialProps> = (ThunkfulDispatchProp<StoreState>) -> PartialProps?

export type MapDispatchToPropsOrActionCreator<StoreState, PartialProps> =
	MapDispatchToProps<StoreState, PartialProps>
	| ActionCreatorMap

return nil
