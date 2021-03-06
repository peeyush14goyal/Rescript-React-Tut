let s = React.string

type action =
  | Increment
  | Decrement
  | Reset(int)

let reducer = (state, action) =>
  switch action {
    | Increment => state + 1
    | Decrement => state - 1
    | Reset(initialValue) => initialValue
  }

@react.component
let make = (~initialValue) => {
  let (count, dispatch) = React.useReducer(reducer, initialValue)

  let bgColor = if count == 0 {
    "bg-blue-200"
  } else if count > 0 {
    "bg-green-200"
  } else {
    "bg-red-200"
  }

  <div className="max-w-3xl mx-auto mt-24">
    <p className={`py-4 mb-8 text-center text-4xl ${bgColor}`}>
      {s("The count is " ++ count->Belt.Int.toString)}
    </p>
    <div className="flex justify-center">
      <Button text="Increment"
        className="border py-2 px-4 bg-gray-200 hover:bg-blue-200 mr-2"
        handleClick={_mouseEvt => dispatch(Increment)}
        />
        <Button text="Decrement"
        className="border py-2 px-4 bg-gray-200 hover:bg-blue-200 mr-2"
        handleClick={_mouseEvt => dispatch(Decrement)}
        />
        <Button text="Reset"
        className="border py-2 px-4 bg-gray-200 hover:bg-blue-200 mr-2"
        handleClick={_mouseEvt => dispatch(Reset(initialValue))}
        />
    </div>
  </div>
}
